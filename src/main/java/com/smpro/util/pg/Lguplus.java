package com.smpro.util.pg;

import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.MallVo;
import com.smpro.vo.OrderPayVo;

import lgdacom.XPayClient.XPayClient;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Lguplus {
	private static final Logger LOGGER = LoggerFactory.getLogger(Lguplus.class);
	
	private XPayClient xpay = null;
	private int LGD_TAXFREEAMOUNT; // 면세 대상 금액
	private String LGD_MERTKEY; // 상점키

	public Lguplus() {
		// 결제 모듈 인스턴스 생성
		xpay = new XPayClient();
	}

	// LGU+ PG 결제
	public OrderPayVo doPay(HttpServletRequest request, int calcPayPrice) throws Exception {
		HttpSession session = request.getSession(false);
		/*
		 * [최종결제요청 페이지(STEP2-2)]
		 * 
		 * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를
		 * 사용하세요)
		 */

		/*
		 * ※ 중요 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다. 해당 환경파일이 외부에 노출이 되는
		 * 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 예) [Window 계열]
		 * C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
		 */

		// LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.

		/*
		 * ************************************************
		 * 1.최종결제 요청 - BEGIN (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
		 * ************************************************
		 */
		
		String CST_PLATFORM = request.getParameter("CST_PLATFORM");
		String CST_MID = request.getParameter("CST_MID");
		String LGD_MID = ("test".equals(CST_PLATFORM.trim()) ? "t" : "") + CST_MID;
		String LGD_PAYKEY = request.getParameter("LGD_PAYKEY");
		LGD_MERTKEY = ((MallVo)request.getAttribute("mallVo")).getPgKey();

		if (StringUtil.isNum(request.getParameter("LGD_TAXFREEAMOUNT"))) {
			LGD_TAXFREEAMOUNT = Integer.parseInt( request.getParameter("LGD_TAXFREEAMOUNT"));
		}

		// 환경설정 파일 경로 테스트, 운영 분기
		String configPath = session.getServletContext().getRealPath("/WEB-INF/conf/lguplus");
		//if ("linux".equals(Const.OS)) {
		//	configPath = "/web/out/conf/lguplus";
		//}
		boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);
		if (!isInitOK) {
			// API 초기화 실패 화면처리
			StringBuffer errMsg = new StringBuffer();
			errMsg.append("결제요청을 초기화 하는데 실패하였습니다.\\n");
			errMsg.append("LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.\\n");
			errMsg.append("mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.]\\n\\n");
			errMsg.append("문의전화 LG유플러스 1544-7772");
			throw new Exception(errMsg.toString());
		}

		try {
			/*
			 * ************************************************
			 * 1.최종결제 요청(수정하지 마세요) - END
			 * ************************************************
			 */
			xpay.Init_TX(LGD_MID);
			xpay.Set("LGD_TXNAME", "PaymentByKey");
			xpay.Set("LGD_PAYKEY", LGD_PAYKEY);

			// 금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
			//String DB_AMOUNT = String.valueOf(calcPayPrice); // 반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
			//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
			//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception( "LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다.["+ e.getMessage() + "]");
		}

		/*
		 * 2. 최종결제 요청 결과처리
		 * 
		 * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
		 */
		if (xpay.TX()) {
			// 1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
			LOGGER.info("### 결제요청이 완료되었습니다.");
			LOGGER.info("### TX 결제요청 Response_code = " + xpay.m_szResCode);
			LOGGER.info("### TX 결제요청 Response_msg = " + xpay.m_szResMsg);
			LOGGER.info("### 거래번호 : System." + xpay.Response("LGD_TID", 0));
			LOGGER.info("### 상점아이디 : " + xpay.Response("LGD_MID", 0));
			LOGGER.info("### 상점주문번호 : " + xpay.Response("LGD_OID", 0));
			LOGGER.info("### 결제금액 : " + xpay.Response("LGD_AMOUNT", 0));
			LOGGER.info("### 결과코드 : " + xpay.Response("LGD_RESPCODE", 0));
			LOGGER.info("### 결과메세지 : " + xpay.Response("LGD_RESPMSG", 0));

			for (int i = 0; i < xpay.ResponseNameCount(); i++) {
				LOGGER.info(
						xpay.ResponseName(i) + " = ");
				for (int j = 0; j < xpay.ResponseCount(); j++) {
					LOGGER.info(
							xpay.Response(xpay.ResponseName(i), j));
				}
			}

			/*
			 * if( "0000".equals( xpay.m_szResCode ) ) { //최종결제요청 결과 성공 DB처리
			 * Logger
			 * .getLogger(this.getClass()).info("최종결제요청 결과 성공 DB처리하시기 바랍니다.<br>"
			 * );
			 * 
			 * //최종결제요청 결과 성공 DB처리 실패시 Rollback 처리 boolean isDBOK = true; //DB처리
			 * 실패시 false로 변경해 주세요. if( !isDBOK ) {
			 * xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:"
			 * +xpay.Response("LGD_TID",0)+",MID:" +
			 * xpay.Response("LGD_MID",0)+",OID:"
			 * +xpay.Response("LGD_OID",0)+"]");
			 * 
			 * //LOGGER.info(
			 * "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0)
			 * + "<br>"); //LOGGER.info(
			 * "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) +
			 * "<p>");
			 * 
			 * if( "0000".equals( xpay.m_szResCode ) ) {
			 * LOGGER.info("자동취소가 정상적으로 완료 되었습니다.");
			 * }else{
			 * LOGGER.info("자동취소가 정상적으로 처리되지 않았습니다."
			 * ); } } } else { //최종결제요청 결과 실패 DB처리 throw new
			 * Exception("승인 결과 처리에 실패하였습니다.[" + xpay.m_szResCode + ": " +
			 * xpay.m_szResMsg + "]"); }
			 */
		} else {
			// 2)API 요청실패 화면처리
			LOGGER.info("결제 요청에 실패하였습니다.[" + xpay.m_szResCode + ": "	+ xpay.m_szResMsg + "]");
			throw new Exception("결제 요청에 실패하였습니다.[" + xpay.m_szResCode + ": " + xpay.m_szResMsg + "]");
		}

		return createOrderPayVo(xpay);
	}

	// LGU+ 결제 자동 취소
	public OrderPayVo doCancel() {
		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" + xpay.Response("LGD_TID", 0) + ",MID:"+ xpay.Response("LGD_MID", 0) + ",OID:" + xpay.Response("LGD_OID", 0) + "]");
		LOGGER.info("### 결제 자동 취소요청");
		LOGGER.info("### TX Response_code = " + xpay.m_szResCode);
		LOGGER.info("### TX Response_msg = " + xpay.m_szResMsg);
		return createOrderPayVo(xpay);
	}

	// LGU+ 결제 취소
	public OrderPayVo doCancel(String configPath, OrderPayVo vo) throws Exception {
		String CST_PLATFORM = Const.LOCATION; // LG유플러스 결제서비스 선택(test:테스트, service:서비스)

		/*
		 * ※ 중요 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다. 해당 환경파일이 외부에 노출이 되는
		 * 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 예) [Window 계열]
		 * C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
		 */

		XPayClient xpay = new XPayClient();
		xpay.Init(configPath, CST_PLATFORM);
		xpay.Init_TX(vo.getMid());
		xpay.Set("LGD_TID", vo.getTid());
		if (vo.getPartCancelAmt() > 0) {
			xpay.Set("LGD_TXNAME", "PartialCancel"); // 부분취소
			xpay.Set("LGD_CANCELAMOUNT", String.valueOf(vo.getPartCancelAmt())); // 부분취소 금액
			xpay.Set("LGD_CANCELREASON", ""); // 부분취소 사유
		} else {
			xpay.Set("LGD_TXNAME", "Cancel"); // 전체취소
		}

		/**
		 * 1. 결제취소 요청 결과처리
		 * 
		 * 취소결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
		 * 
		 * [[[중요]]] 고객사에서 정상취소 처리해야할 응답코드 1. 신용카드 : 0000, AV11 2. 계좌이체 : 0000,
		 * RF00, RF10, RF09, RF15, RF19, RF23, RF25 (환불진행중 응답건-> 환불결과코드.xls 참고)
		 * 3. 나머지 결제수단의 경우 0000(성공) 만 취소성공 처리
		 */
		if (xpay.TX()) {
			// 1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
			LOGGER.info("### 결제 취소요청이 완료되었습니다");
			LOGGER.info("### TX Response_code = " + xpay.m_szResCode);
			LOGGER.info("### TX Response_msg = " + xpay.m_szResMsg);
		} else {
			// 2)API 요청 실패 화면처리
			LOGGER.info("### 결제 취소요청이 실패하였습니다.");
			LOGGER.info("### TX Response_code = " + xpay.m_szResCode);
			LOGGER.info("### TX Response_msg = " + xpay.m_szResMsg);
			throw new Exception("결제 요청에 실패하였습니다.[" + xpay.m_szResCode + ": " + xpay.m_szResMsg + "]");
		}

		return createOrderPayVo(vo, xpay);
	}

	// 결제 및 자동취소 결과 맵핑
	private OrderPayVo createOrderPayVo(XPayClient xpay) {
		OrderPayVo vo = new OrderPayVo();
		if (!StringUtil.isBlank(xpay.Response("LGD_OID", 0))) {
			vo.setOrderSeq(Integer.valueOf(xpay.Response("LGD_OID", 0)));
		}
		vo.setTid(xpay.Response("LGD_TID", 0));
		vo.setOid(xpay.Response("LGD_OID", 0));
		vo.setMid(xpay.Response("LGD_MID", 0));
		vo.setPgKey(LGD_MERTKEY);
		vo.setResultCode(xpay.Response("LGD_RESPCODE", 0));
		vo.setResultMsg(xpay.Response("LGD_RESPMSG", 0));
		if (!StringUtil.isBlank(xpay.Response("LGD_AMOUNT", 0))) {
			vo.setAmount(Integer.parseInt(xpay.Response("LGD_AMOUNT", 0)));
		}
		// 면세 대상 금액 저장
		vo.setTaxFreeAmount(LGD_TAXFREEAMOUNT);

		vo.setMethodCode(xpay.Response("LGD_PAYTYPE", 0));
		vo.setOrgCode(xpay.Response("LGD_FINANCECODE", 0));
		vo.setOrgName(xpay.Response("LGD_FINANCENAME", 0));
		vo.setEscrowFlag(xpay.Response("LGD_ESCROWYN", 0));
		vo.setApprovalNo(xpay.Response("LGD_FINANCEAUTHNUM", 0));
		vo.setCardMonth(xpay.Response("LGD_CARDINSTALLMONTH", 0));
		String interestFlag = "Y";
		if ("1".equals(xpay.Response("LGD_CARDNOINTYN", 0))) {
			// 무이자 설정
			interestFlag = "N";
		}
		vo.setInterestFlag(interestFlag);
		vo.setCashReceiptTypeCode(xpay.Response("LGD_CASHRECEIPTKIND", 0));
		vo.setCashReceiptNo(xpay.Response("LGD_CASHRECEIPTNUM", 0));
		vo.setAccountNo(xpay.Response("LGD_ACCOUNTNUM", 0));
		vo.setTransDate(xpay.Response("LGD_PAYDATE", 0));
		vo.setPgCode("lguplus");

		// 처리결과 여부 저장
		if ("0000".equals(xpay.m_szResCode)) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}

	// 결제 취소 처리 결과 맵핑
	private OrderPayVo createOrderPayVo(OrderPayVo payVo, XPayClient xpay) {
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
		vo.setResultCode(xpay.Response("LGD_RESPCODE", 0));
		vo.setResultMsg(xpay.Response("LGD_RESPMSG", 0));

		// 처리결과 여부 저장
		if ("0000".equals(xpay.m_szResCode)) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}

}
