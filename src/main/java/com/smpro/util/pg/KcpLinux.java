package com.smpro.util.pg;

import com.kcp.C_PP_CLI_T;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.MallVo;
import com.smpro.vo.OrderPayVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;

public class KcpLinux {
	private static final Logger LOGGER = LoggerFactory.getLogger(KcpLinux.class);
	
	// KCP 사이트코드 / 사이트키 (기본 테스트값으로 설정)
	private String siteCd = "T0000";
	private String siteKey = "3grptw1.zW0GSo4PQdaGvsF__";

	// 공통
	private static final String g_conf_log_level = "3";
	private static final String g_conf_gw_port = "8090"; // 포트번호(변경불가)
	private static final int g_conf_tx_mode = 0; // 변경불가
	private static final String g_conf_home_dir = "/web/out/gsretail/conf/kcp"; // BIN
																				// 절대경로
																				// 입력
																				// (bin전까지)
	// private static final String g_conf_key_dir = g_conf_home_dir +
	// "/bin/pub.key"; // 공개키 파일 절대경로(리눅스일 경우 사용안함)
	private static final String g_conf_gw_url; // lguplus 결제 게이트웨이 URL

	static {
		if ("test".equals(Const.LOCATION)) {
			g_conf_gw_url = "testpaygw.kcp.co.kr";
		} else {
			g_conf_gw_url = "paygw.kcp.co.kr";
		}
	}

	private String tno; // 거래번호
	private String custIp; // 결제 요청 IP주소
	private String ordrIdxx; // 주문번호
	private String usePayMethod; // 결제수단코드
	private int commFreemny; // 면세 대상 금액

	C_PP_CLI_T c_PayPlus = null;

	public KcpLinux() {
		// 결제 모듈 인스턴스 생성
		c_PayPlus = new C_PP_CLI_T();
	}

	// 결제
	public OrderPayVo doPay(HttpServletRequest request, int calcPayPrice) throws Exception {
		MallVo mallVo = (MallVo) request.getAttribute("mallVo");
		
		if ("service".equals(Const.LOCATION)) {
			siteCd = mallVo.getPgId(); 		// 사이트 코드
			siteKey = mallVo.getPgKey(); 	// 사이트 키
		}

		custIp = request.getRemoteAddr();
		ordrIdxx = request.getParameter("ordr_idxx");
		usePayMethod = request.getParameter("use_pay_method");

		if (!"".equals(request.getParameter("comm_free_mny"))) {
			commFreemny = Integer.parseInt(request.getParameter("comm_free_mny"));
		}

		c_PayPlus.mf_init(g_conf_home_dir, g_conf_gw_url, g_conf_gw_port,
				g_conf_tx_mode);
		c_PayPlus.mf_init_set();

		if ("pay".equals(request.getParameter("req_tx"))) {
			c_PayPlus.mf_set_enc_data(request.getParameter("enc_data"), request.getParameter("enc_info"));

			// 결제금액 유효성 검증
			if (request.getParameter("good_mny").trim().length() > 0) {
				int ordr_data_set_no;
				ordr_data_set_no = c_PayPlus.mf_add_set("ordr_data");
				c_PayPlus.mf_set_us(ordr_data_set_no, "ordr_mony", String.valueOf(calcPayPrice));
			}
		}

		if (request.getParameter("tran_cd").length() > 0) {
			c_PayPlus.mf_do_tx(siteCd, siteKey, request.getParameter("tran_cd"), custIp, ordrIdxx, g_conf_log_level, "0");
		} else {
			c_PayPlus.m_res_cd = "9562";
			c_PayPlus.m_res_msg = "연동 오류|Payplus Plugin이 설치되지 않았거나 tran_cd값이 설정되지 않았습니다.";
		}
		tno = c_PayPlus.mf_get_res("tno") == null ? "" : c_PayPlus.mf_get_res(
				"tno").trim();
		LOGGER.info("### KCP 결제 ");
		LOGGER.info("### tno : " + tno);
		LOGGER.info("### res_cd : " + c_PayPlus.m_res_cd);
		LOGGER.info("### res_msg : " + c_PayPlus.m_res_msg);

		return createOrderPayVo(c_PayPlus);
	}

	// 자동 취소
	public OrderPayVo doCancel() {
		int mod_data_set_no;

		c_PayPlus.mf_init_set();

		mod_data_set_no = c_PayPlus.mf_add_set("mod_data");
		c_PayPlus.mf_set_us(mod_data_set_no, "tno", tno); // KCP 원거래 거래번호
		c_PayPlus.mf_set_us(mod_data_set_no, "mod_type", "STSC"); // 원거래 변경 요청
																	// 종류
		c_PayPlus.mf_set_us(mod_data_set_no, "mod_ip", custIp); // 변경 요청자 IP
		c_PayPlus.mf_set_us(mod_data_set_no, "mod_desc", "주문 DB처리 실패로 인한 자동 취소"); // 변경 사유

		c_PayPlus.mf_do_tx(siteCd, siteKey, "00200000", "", ordrIdxx, g_conf_log_level, "0");
		LOGGER.info("### KCP 결제 자동취소");
		LOGGER.info("### tno : " + tno);
		LOGGER.info("### custIp : " + custIp);
		LOGGER.info("### res_cd : " + c_PayPlus.m_res_cd);
		LOGGER.info("### res_msg : " + c_PayPlus.m_res_msg);
		return createOrderPayVo(c_PayPlus);
	}

	// 결제 취소
	public OrderPayVo doCancel(OrderPayVo vo, String custIp, String taxCode) {
		if ("service".equals(Const.LOCATION)) {
			siteCd = vo.getPgId();
			siteKey = vo.getPgKey();
		}

		C_PP_CLI_T c_PayPlus = new C_PP_CLI_T();
		c_PayPlus.mf_init(g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_tx_mode);
		c_PayPlus.mf_init_set();

		int mod_data_set_no = c_PayPlus.mf_add_set("mod_data");

		c_PayPlus.mf_set_us(mod_data_set_no, "tno", vo.getTid()); // KCP 원거래 거래번호
		if (vo.getPartCancelAmt() > 0) {
			// 부분취소
			c_PayPlus.mf_set_us(mod_data_set_no, "mod_type", "STPC"); // 원거래 변경 요청 종류
			c_PayPlus.mf_set_us(mod_data_set_no, "mod_mny",	String.valueOf(vo.getPartCancelAmt())); // 취소요청금액
			c_PayPlus.mf_set_us(mod_data_set_no, "rem_mny",	String.valueOf(vo.getAmount())); // 취소가능잔액

			// 면세금액 포함이면 복합과세 처리 로직을 추가로 수행한다.
			if (vo.getTaxFreeAmount() > 0) {
				c_PayPlus.mf_set_us(mod_data_set_no, "tax_flag", "TG03"); // 복합과세 구분
				if ("1".equals(taxCode)) {
					int mod_tax_mny = (int) (Math.ceil((vo.getPartCancelAmt()) / 1.1));
					int mod_vat_mny = vo.getPartCancelAmt() - mod_tax_mny;
					// 과세 부분취소
					c_PayPlus.mf_set_us(mod_data_set_no, "mod_tax_mny",	String.valueOf(mod_tax_mny)); // 공급가 부분 취소 요청 금액
					c_PayPlus.mf_set_us(mod_data_set_no, "mod_vat_mny",	String.valueOf(mod_vat_mny)); // 부과세 부분 취소 요청 금액
					c_PayPlus.mf_set_us(mod_data_set_no, "mod_free_mny", "0"); // 비과세 부분 취소 요청 금액
				} else {
					// 면세 부분취소
					c_PayPlus.mf_set_us(mod_data_set_no, "mod_tax_mny", "0"); // 공급가 부분 취소 요청 금액
					c_PayPlus.mf_set_us(mod_data_set_no, "mod_vat_mny", "0"); // 부과세 부분 취소 요청 금액
					c_PayPlus.mf_set_us(mod_data_set_no, "mod_free_mny", String.valueOf(vo.getPartCancelAmt())); // 비과세 부분 취소 요청 금액
				}
			}
		} else {
			// 전체취소
			c_PayPlus.mf_set_us(mod_data_set_no, "mod_type", "STSC"); // 원거래 변경 요청 종류
		}

		c_PayPlus.mf_set_us(mod_data_set_no, "mod_ip", custIp); // 변경 요청자 IP
		c_PayPlus.mf_set_us(mod_data_set_no, "mod_desc", "주문 취소"); // 변경 사유

		c_PayPlus.mf_do_tx(siteCd, siteKey, "00200000", "", String.valueOf(vo.getOrderSeq()), g_conf_log_level, "0");

		return createOrderPayVo(vo, c_PayPlus);
	}

	// 결제 및 자동취소 처리 결과 맵핑
	private OrderPayVo createOrderPayVo(C_PP_CLI_T c_PayPlus) {
		OrderPayVo vo = new OrderPayVo();
		vo.setOrderSeq(Integer.valueOf(ordrIdxx));
		vo.setTid(tno);
		vo.setOid(ordrIdxx);
		vo.setMid(siteCd);
		vo.setPgKey(siteKey);
		vo.setResultCode(c_PayPlus.m_res_cd);
		vo.setResultMsg(c_PayPlus.m_res_msg);
		if (!StringUtil.isBlank(c_PayPlus.mf_get_res("amount"))) {
			vo.setAmount(Integer.parseInt(c_PayPlus.mf_get_res("amount")));
		}
		vo.setTaxFreeAmount(commFreemny);
		vo.setMethodCode(usePayMethod);
		vo.setOrgCode(c_PayPlus.mf_get_res("card_cd"));
		vo.setOrgName(c_PayPlus.mf_get_res("card_name"));
		vo.setEscrowFlag("N");
		vo.setApprovalNo(c_PayPlus.mf_get_res("app_no"));
		vo.setCardMonth(c_PayPlus.mf_get_res("quota"));
		vo.setInterestFlag("Y".equals(c_PayPlus.mf_get_res("noinf")) ? "N"
				: "Y");
		vo.setCashReceiptTypeCode("");
		vo.setCashReceiptNo("");
		vo.setAccountNo("");
		vo.setTransDate(c_PayPlus.mf_get_res("app_time"));
		vo.setPgCode("kcp");

		// 처리결과 여부 저장
		if ("0000".equals(c_PayPlus.m_res_cd)) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}

	// 결제 취소 처리 결과 맵핑
	private OrderPayVo createOrderPayVo(OrderPayVo payVo, C_PP_CLI_T c_PayPlus) {
		OrderPayVo vo = new OrderPayVo();
		vo.setOrderPaySeq(payVo.getSeq());
		if (payVo.getPartCancelAmt() > 0) {
			// 부분취소금액, 상품주문번호 저장
			vo.setTypeCode("PART");
			vo.setAmount(payVo.getPartCancelAmt());
			vo.setOrderDetailSeq(payVo.getOrderDetailSeq());
		} else {
			// 전체취소금액 저장
			vo.setTypeCode("ALL");
			vo.setAmount(payVo.getAmount());
			vo.setOrderDetailSeq(null);
		}

		vo.setResultCode(c_PayPlus.m_res_cd);
		vo.setResultMsg(c_PayPlus.m_res_msg);

		// 처리결과 여부 저장
		if ("0000".equals(c_PayPlus.m_res_cd)) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}
}
