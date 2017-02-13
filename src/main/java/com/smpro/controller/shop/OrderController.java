package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.util.pg.PgUtil;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.site.SitePreference;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class OrderController {
	@Autowired
	private GradeService gradeService;

	@Autowired
	private ItemOptionService itemOptionService;

	@Autowired
	private CartService cartService;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private EstimateService estimateService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MailService mailService;

	@Autowired
	private PointService pointService;

	@Autowired
	private MemberDeliveryService memberDeliveryService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private ItemService x;

	@Autowired
	private SmsService smsService;

	@Autowired
	private MemberGroupService memberGroupService;

	/** 결제 진행 페이지 */
	@RequestMapping("/order")
	public String orderForm(HttpServletRequest request, Model model){
		HttpSession session = request.getSession();
		Integer memberSeq = (Integer)session.getAttribute("loginSeq");

		String seq = request.getParameter("seq");

		//견적주문 여부 구분 값
		String estimateFlag = request.getParameter("estimate_flag");

		//주문할 상품 가져오기
		List<ItemVo> list = getListItem(seq, session, estimateFlag, model);

		if(list == null) {
			return Const.BACK_PAGE;
		}

		MemberVo mvo = null;
		if(memberSeq != null) {
			try {
				mvo = memberService.getData(memberSeq);
			} catch(Exception e) {
				model.addAttribute("message", "회원 정보 복호화에 실패했습니다.["+e.getMessage()+"]");
				if("Y".equals(estimateFlag)) {
					return Const.BACK_PAGE;
				}
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("memberVo", mvo);
		model.addAttribute("list", list);
		model.addAttribute("seq", seq);

		//보유 포인트
		Integer useablePoint = pointService.getUseablePoint(memberSeq);
		model.addAttribute("availablePoint", useablePoint == null ? new Integer(0) : useablePoint);

		//공통코드 조회(결제수단)
		model.addAttribute("payMethodList", systemService.getCommonListByGroup(new Integer(21)));

		//견적주문 여부 구분
		model.addAttribute("estimateFlag", estimateFlag);

		// 세금계산서 필드 (공공기관일 경우)
		if(mvo != null) {
			model.addAttribute("mgVo", memberGroupService.getVo(mvo.getGroupSeq()) );
		}

		model.addAttribute("title", "결제");
		return "/order/order.jsp";
	}

	@RequestMapping("/order/start")
	public String orderStart(OrderVo vo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();

		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		String seqs = request.getParameter("seqs");
		String estimateFlag = request.getParameter("estimate_flag");

		Integer memberSeq = (Integer)session.getAttribute("loginSeq");

		// 주문할 상품 가져오기
		List<ItemVo> list = getListItem(seqs, session, estimateFlag, model);
		if(list == null) {
			return Const.ALERT_PAGE;
		}

		// 총금액을 구한다
		int totalPrice = getTotalPrice(list, estimateFlag);

		// 실결제금액
		int payPrice = totalPrice;

		// 포인트 유효성 체크 및 실 결제 금액에서 차감
		if(!checkPoint(mallVo.getPayMethod(), vo.getPoint(), memberSeq, totalPrice, model )) {
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}
		payPrice -= vo.getPoint();

		//결제수단 체크
		if(payPrice > 0 && "".equals(vo.getPayMethod())) {
			model.addAttribute("message", "사용하실 결제 수단을 체크해 주세요.");
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		// 주문 시퀀스 생성(시퀀스로 가져오기)
		orderService.createOrderSeq(vo);

		vo.setReceiverPostcode(vo.getPostcode());

		// 수신자 주소 set
		vo.setReceiverAddr1(vo.getAddr1());
		vo.setReceiverAddr2(vo.getAddr2());

		// 수신자 email set
		vo.setReceiverEmail(vo.getMemberEmail());

		if(StringUtil.isBlank(vo.getReceiverEmail())){
			model.addAttribute("message", "이메일을  입력해주세요.");
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		// 휴대폰번호와 전화번호가 잘라져서 넘어오기 때문에 번호가 맞지 않으면 안되므로 검증을 한다.
		if(StringUtil.isBlank(vo.getReceiverTel1()) || StringUtil.isBlank(vo.getReceiverTel2()) || StringUtil.isBlank(vo.getReceiverTel3())){
			model.addAttribute("message", "Tel을 입력해주세요.");
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		if(StringUtil.isBlank(vo.getReceiverCell1()) || StringUtil.isBlank(vo.getReceiverCell2()) || StringUtil.isBlank(vo.getReceiverCell3())){
			model.addAttribute("message", "Cell을 입력해주세요.");
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		if(!StringUtil.isBlank(vo.getMemberCell1()) && !StringUtil.isBlank(vo.getMemberCell2()) && !StringUtil.isBlank(vo.getMemberCell3())) {
			vo.setMemberCell(StringUtil.formatPhone(vo.getMemberCell1(), vo.getMemberCell2(), vo.getMemberCell3()));
		}

		if(!StringUtil.isBlank(vo.getReceiverTel1()) && !StringUtil.isBlank(vo.getReceiverTel2()) && !StringUtil.isBlank(vo.getReceiverTel3())) {
			vo.setReceiverTel(StringUtil.formatPhone(vo.getReceiverTel1(), vo.getReceiverTel2(), vo.getReceiverTel3()));
		}
		if(!StringUtil.isBlank(vo.getReceiverCell1()) && !StringUtil.isBlank(vo.getReceiverCell2()) && !StringUtil.isBlank(vo.getReceiverCell3())) {
			vo.setReceiverCell(StringUtil.formatPhone(vo.getReceiverCell1(), vo.getReceiverCell2(), vo.getReceiverCell3()));
		}
		if(!StringUtil.isBlank(vo.getBusinessNum1()) && !StringUtil.isBlank(vo.getBusinessNum2()) && !StringUtil.isBlank(vo.getBusinessNum3())) {
			vo.setBusinessNum(StringUtil.formatPhone(vo.getBusinessNum1(), vo.getBusinessNum2(), vo.getBusinessNum3()));
		}
		if(!StringUtil.isBlank(vo.getRequestCell1()) && !StringUtil.isBlank(vo.getRequestCell2()) && !StringUtil.isBlank(vo.getRequestCell3())) {
			vo.setRequestCell(StringUtil.formatPhone(vo.getBusinessNum1(), vo.getRequestCell2(), vo.getRequestCell3()));
		}
	    //PG로 전송할 상품 정보 셋팅
		vo.setItemName(list.size() >= 2 ? list.get(0).getName()+" 외 "+(list.size()-1)+"건..":list.get(0).getName());

		//PG결제 금액 셋팅
		vo.setPayPrice(payPrice);

		Device device = (Device)request.getAttribute("currentDevice");

		//결제 디바이스 타입 등록(N:PC, M:모바일)
		vo.setDeviceType(device.isMobile() ? "M" : "N");

		//PG결제창에서 리다이렉트시 주문페이지에서 넘어온 파라메타 정보를 유지하기위하여 세션에 저장한다.
		session.setAttribute("orderMain", vo);
		session.setAttribute("seqs", seqs);

		//견적주문 여부 구분 값 세션 저장
		session.setAttribute("estimateFlag", estimateFlag);

		// 전액 포인트 및 무통장입금, 신용카드 ARS, 후청구 결제이면 바로 처리 결과 컨트롤러로 넘긴다.
		if(payPrice == 0 || "CASH".equals(vo.getPayMethod()) || "ARS".equals(vo.getPayMethod()) || "OFFLINE".equals(vo.getPayMethod()) || vo.getPayMethod().startsWith("NP")){
			model.addAttribute("target", "self");
			model.addAttribute("returnUrl",	"/shop/order/result");
			return Const.REDIRECT_PAGE;
		}

		log.debug("###device.isNormal() : " + device.isNormal());
		log.debug("###device.isMobile() : " + device.isMobile());
		log.debug("###device.isTablet() : " + device.isTablet());

		SitePreference sitePreference = (SitePreference)request.getAttribute("currentSitePreference");
		log.debug("###sitePreference.isNormal() : " + sitePreference.isNormal());
		log.debug("###sitePreference.isMobile() : " + sitePreference.isMobile());
		log.debug("###sitePreference.isTablet() : " + sitePreference.isTablet());

		//모바일 기기에서 PC버전 사이트 접속일 경우, 휴대폰 결제 모듈 실행을 위해 'mobile/' prefix를 강제로 셋팅한다.
		if(device.isMobile() && sitePreference.isNormal()) {
			return "/mobile/pg/"+mallVo.getPgCode()+"/pay.jsp";
		}

		return "/pg/"+mallVo.getPgCode()+"/pay.jsp";
	}

	@RequestMapping("/order/result")
	public String result(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		if(session == null) {
			model.addAttribute("message", "세션이 만료되었습니다.");
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		Integer memberSeq = (Integer)session.getAttribute("loginSeq");
		String seqs = (String)session.getAttribute("seqs");
		OrderVo ovo = (OrderVo)session.getAttribute("orderMain");

		//견적주문 여부 구분 값
		String estimateFlag = (String)session.getAttribute("estimateFlag");

		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		ovo.setMallSeq(mallVo.getSeq());

		// 주문할 상품 가져오기
		List<ItemVo> list = getListItem(seqs, session, estimateFlag, model);
		if(list == null) {
			return Const.ALERT_PAGE;
		}
		// 주문 총 금액을 구한다
		int totalPrice = getTotalPrice(list, estimateFlag);
		// 실 결제 금액
		int payPrice = totalPrice;

		// 포인트 유효성 체크 및 실결제금액에서 차감
		if(!checkPoint(mallVo.getPayMethod(), ovo.getPoint(), memberSeq, totalPrice, model )) {
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}
		payPrice -= ovo.getPoint();

		//결제수단 체크
		if(payPrice > 0 && "".equals(ovo.getPayMethod())) {
			model.addAttribute("message", "결제 수단 항목이 누락되었습니다. 재주문 하시기 바랍니다.");
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		//최종 결제 수단 결정
		ovo.setPayMethod(getPayMethod(ovo));

		//주문 상세 정보 데이터 생성
		List<OrderVo> details = orderService.createDetails(ovo.getOrderSeq(), list, ovo.getPayMethod());

		//면세 금액 계산
		request.setAttribute("taxFreeAmt", new Integer(calcTaxFreeAmt(list)));

		//PG승인이 필요한 결제수단은 해당 로직을 수행한다.
		PgUtil pgUtil = null;
		OrderPayVo payVo = null;
		if (payPrice > 0 && (ovo.getPayMethod().startsWith("CARD") || ovo.getPayMethod().startsWith("ARS"))) {
			// PG 결제 처리
			pgUtil = new PgUtil(mallVo.getPgCode());
			String errMsg = null;
			try {
				payVo = pgUtil.doPay(request, payPrice);
			} catch (Exception e) {
				e.printStackTrace();
				errMsg = e.getMessage();
			}
			if (payVo == null || !"Y".equals(payVo.getResultFlag())) {
				if(payVo == null) {
					model.addAttribute("message", "PG결제 승인 처리에 실패하였습니다.. [" + errMsg + "]");
				} else {
					model.addAttribute("message", "PG결제 승인 처리에 실패하였습니다.. [" + payVo.getResultCode() + ": " + payVo.getResultMsg() + "]");
				}
				model.addAttribute("callback", "fail");
				return Const.ALERT_PAGE;
			}
		}

		ovo.setTotalPrice(totalPrice);
		ovo.setPayPrice(payPrice);
		ovo.setMemberSeq(memberSeq);

		boolean flag=false;
		//SMS 발송을 위해 암호화가 되기전의 휴대폰 번호를 저장한다.
		String validMemberCell = ovo.getMemberCell();
		try {
			//회원 정보 암호화
			ovo.setMemberCell(CrypteUtil.encrypt(ovo.getMemberCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			ovo.setMemberEmail(CrypteUtil.encrypt(ovo.getMemberEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			ovo.setReceiverTel(CrypteUtil.encrypt(ovo.getReceiverTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			ovo.setReceiverCell(CrypteUtil.encrypt(ovo.getReceiverCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			ovo.setReceiverAddr2(CrypteUtil.encrypt(ovo.getReceiverAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			if(ovo.getReceiverEmail() != null && !"".equals(ovo.getReceiverEmail().trim())) {
				ovo.setReceiverEmail(CrypteUtil.encrypt(ovo.getReceiverEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
			//주문 정보 등록			}
			flag = orderService.regOrder(ovo, details, payVo);
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
		if(flag) {
			//재고 수량 감소
			itemOptionService.popStock(list);
			//장바구니 비움
			cartService.deleteVo(list);

			//SMS 발송
			//1. 사용자에게 주문완료 알림
			SmsVo svo = new SmsVo();
			svo.setStatusCode("10");
			svo.setStatusType("O");
			String content = smsService.getContent(svo);
			content = content.replaceAll("mallName", mallVo.getName()).replaceAll("memberName", ovo.getMemberName()).replaceAll("itemName", ovo.getItemName()).replaceAll("orderSeq", ""+ovo.getOrderSeq());
			svo.setTrSendStat("0");
			svo.setTrMsgType("0");
			svo.setTrPhone(validMemberCell.replace("-", ""));
			svo.setTrMsg(content);

			try {
				smsService.insertSmsSendVo(svo);
			} catch(Exception e) {
				e.printStackTrace();
				log.error("SMS발송에 실패 하였습니다. [" + e.getMessage() + "]");
			}

			//2.관리자에게 주문 접수 알림
			SmsVo ssvo = new SmsVo();
			ssvo.setStatusCode("00");
			ssvo.setStatusType("O");
			content = smsService.getContent(ssvo);
			content = content.replaceAll("mallName", mallVo.getName()).replaceAll("memberName", ovo.getMemberName()).replaceAll("itemName", ovo.getItemName()).replaceAll("orderSeq", ""+ovo.getOrderSeq());
			ssvo.setTrSendStat("0");
			ssvo.setTrMsgType("0");
			ssvo.setTrMsg(content);

			try {
				//2-1 관리자 핸드폰 번호 가져옮
				List<AdminVo> adminList = systemService.getAdminList();
				for(AdminVo admin:adminList){
					admin = systemService.getAdminData(admin);
					String cellNum=admin.getCell();
					if(cellNum!=null && cellNum.length()>0) {
						ssvo.setTrPhone(cellNum);
						smsService.insertSmsSendVo(ssvo);
					}
				}
				//2-2 공급자 핸드폰 번호 가져옮
				List<String> sellersCellNum = new ArrayList<>();
				for(OrderVo detail:details){
					String sellerCell = sellerService.getData(detail.getSellerSeq()).getSalesCell();
					if(sellerCell !=null && sellerCell.length()>0){
						if(sellersCellNum.contains(sellerCell)) continue;
						sellersCellNum.add(sellerCell);
					}
				}

				for(String sell:sellersCellNum){
						ssvo.setTrPhone(sell);
						smsService.insertSmsSendVo(ssvo);
				}

			} catch(Exception e) {
				e.printStackTrace();
				log.error("SMS발송에 실패 하였습니다. [" + e.getMessage() + "]");
			}

		} else {
			StringBuffer errMsg = new StringBuffer("주문 DB 처리에 실패하였습니다.");
			//PG 결제했을 경우 자동 취소
			if(payVo != null && pgUtil != null){
				payVo = pgUtil.doCancelDirect();
				if(!"Y".equals(payVo.getResultFlag())) {
					errMsg.append("\\nPG결제 취소 처리 실패["); errMsg.append(payVo.getResultCode()); errMsg.append(":"); errMsg.append(payVo.getResultMsg()); errMsg.append("]");
				}
			}

			model.addAttribute("message", errMsg.toString());
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		//주문 세션 정보 삭제
		session.removeAttribute("seqs");
		session.removeAttribute("orderMain");
		session.removeAttribute("estimateFlag");

		model.addAttribute("returnUrl", "/shop/order/finish?orderSeq=" + ovo.getOrderSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/order/start/{orderSeq}")
	public String orderStart(@PathVariable Integer orderSeq, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "회원 로그인 후 이용하시기 바랍니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		}

		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		//결제 가능한 주문인지 체크
		if(orderService.checkOrder(orderSeq) > 0) {
			model.addAttribute("message", "취소 처리 진행중인 주문 건이 존재합니다.\\n\\n해당 주문 건들의 취소 완료 처리 후 결제를 진행하시기 바랍니다.");
			return Const.ALERT_PAGE;
		}

		OrderVo vo;
		try {
			vo = orderService.getVoNP(orderSeq);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "주문 정보를 가져오는 도중 오류가 발생하였습니다.["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		if(vo == null) {
			model.addAttribute("message", "이미 결제가 완료되었거나 존재하지 않는 주문입니다.");
			return Const.ALERT_PAGE;
		}

		//결제 디바이스 타입
		Device device = (Device)request.getAttribute("currentDevice");

		//주문 상품명 저장
		vo.setItemName(orderService.getOrderItemName(orderSeq));

		//PG결제창에서 리다이렉트시 주문정보 유지
		session.setAttribute("orderMain", vo);

		log.debug("###device.isNormal() : " + device.isNormal());
		log.debug("###device.isMobile() : " + device.isMobile());
		log.debug("###device.isTablet() : " + device.isTablet());

		SitePreference sitePreference = (SitePreference)request.getAttribute("currentSitePreference");
		log.debug("###sitePreference.isNormal() : " + sitePreference.isNormal());
		log.debug("###sitePreference.isMobile() : " + sitePreference.isMobile());
		log.debug("###sitePreference.isTablet() : " + sitePreference.isTablet());

		//모바일 기기에서 PC버전 사이트 접속일 경우, 휴대폰 결제 모듈 실행을 위해 'mobile/' prefix를 강제로 셋팅한다.
		if(device.isMobile() && sitePreference.isNormal()) {
			return "/mobile/pg/"+mallVo.getPgCode()+"/pay.jsp";
		}

		return "/pg/"+mallVo.getPgCode()+"/pay.jsp";
	}

	@RequestMapping("/order/result/{orderSeq}")
	public String result(@PathVariable Integer orderSeq, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		if(session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "회원 로그인 후 이용하시기 바랍니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		}

		//결제 가능한 주문인지 체크
		if(orderService.checkOrder(orderSeq) > 0) {
			model.addAttribute("message", "취소 처리 진행중인 주문 건이 존재합니다.\\n\\n해당 주문 건들의 취소 완료 처리 후 결제를 진행하시기 바랍니다.");
			return Const.ALERT_PAGE;
		}

		OrderVo vo;
		try {
			vo = orderService.getVoNP(orderSeq);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "주문정보를 가져오는 도중 오류가 발생하였습니다.["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		if(vo == null) {
			model.addAttribute("message", "이미 결제가 완료되었거나 존재하지 않는 주문입니다.");
			return Const.ALERT_PAGE;
		}

		// 실 결제 금액
		int payPrice = vo.getPayPrice();

		//면세 금액 설정
		request.setAttribute("taxFreeAmt", Integer.valueOf(vo.getTaxFreeAmount()));

		StringBuffer errMsg = new StringBuffer();
		PgUtil pgUtil = new PgUtil(mallVo.getPgCode());
		OrderPayVo payVo = null;
		try {
			payVo = pgUtil.doPay(request, payPrice);
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = new StringBuffer(e.getMessage());
		}
		if (payVo == null || !"Y".equals(payVo.getResultFlag())) {
			if(payVo == null) {
				model.addAttribute("message", "PG결제 승인 처리에 실패하였습니다.. [" + errMsg.toString() + "]");
			} else {
				model.addAttribute("message", "PG결제 승인 처리에 실패하였습니다.. [" + payVo.getResultCode() + ": " + payVo.getResultMsg() + "]");
			}
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}


		boolean flag = false;
		try {
			//주문 정보 수정(입금완료 처리)
			flag = orderService.modOrder(payVo);
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
		if(!flag) {
			errMsg = new StringBuffer("주문 DB 처리에 실패하였습니다.");
			//PG 자동 취소
			payVo = pgUtil.doCancelDirect();
			if(!"Y".equals(payVo.getResultFlag())) {
				errMsg.append("\\nPG결제 취소 처리 실패["); errMsg.append(payVo.getResultCode()); errMsg.append(":"); errMsg.append(payVo.getResultMsg()); errMsg.append("]");
			}

			model.addAttribute("message", errMsg.toString());
			model.addAttribute("callback", "fail");
			return Const.ALERT_PAGE;
		}

		//이니시스 결제 프로세스 팝업창을 닫기 위해 자바스크립트 callback함수 호출
		model.addAttribute("callback","");
		model.addAttribute("message","결제가 정상적으로 처리되었습니다.[주문번호: "+vo.getOrderSeq()+"]");
		model.addAttribute("returnUrl", "/shop/mypage/NP_CARD/list");
		return Const.REDIRECT_PAGE;
	}

	/** 즉시구매로 눌렀을 경우 */
	@RequestMapping("/order/direct")
	public String directProc(HttpServletRequest request, ItemVo vo, Model model) {
		HttpSession session = request.getSession();

		/** 비회원 구매 로직 분기 */
		Integer memberSeq = (Integer)session.getAttribute("loginSeq");
		if(memberSeq == null) {
			//비회원이면 별도 키값을 저장한다.
			if(session.getAttribute("notLoginKey") == null) {
				//키값이 세션에 없으면 새로 생성한다.
				session.setAttribute("notLoginKey", session.getId() + System.currentTimeMillis());
			}
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		} else {
			vo.setMemberSeq(memberSeq);
		}

		if(vo.getCount() <= 0) {
			model.addAttribute("message", "오류가 발생했습니다. [CODE:1]");
			return Const.ALERT_PAGE;
		}

		// 존재하지 않는 옵션이거나 보여주지 않기로 한 옵션이라면 ERROR를 출력한다
		ItemOptionVo ivo = itemOptionService.getValueVo(vo.getOptionValueSeq());
		if(ivo == null || !"Y".equals(ivo.getShowFlag())) {
			model.addAttribute("message", "오류가 발생했습니다. [CODE:2]");
			return Const.ALERT_PAGE;
		}

		List<ItemVo> list = cartService.getList(vo);

		// 장바구니에 동일한 optionValueSeq를 가진 상품이 있는가?
		int duplicatedIdx = -1;
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getOptionValueSeq() == ivo.getSeq()) {
				log.info("duplicatedIdx ==> " + i);
				duplicatedIdx = i;
			}

			// 즉시구매 아이템이 있었다면 삭제한다
			if("Y".equals(list.get(i).getDirectFlag())) {
				cartService.deleteVo(list.get(i));
			}
		}

		// 즉시구매로 설정
		vo.setDirectFlag("Y");

		if(duplicatedIdx >= 0) {
			// 기존의 중복된 아이템은 삭제한다
			cartService.deleteVo(list.get(duplicatedIdx));
		}

		vo.setItemSeq(vo.getSeq());

		if(!cartService.insertVo(vo)) {
			model.addAttribute("message", "오류가 발생했습니다. [CODE:3]");
			return Const.ALERT_PAGE;
		}

		//견적주문 여부 구분 값
		String estimateFlag = request.getParameter("estimate_flag");
		List<ItemVo> cartList = getListItem(String.valueOf(vo.getSeq().intValue()), session, estimateFlag, model);
		if(cartList == null) {
			return Const.ALERT_PAGE;
		}

		// 즉시 구매에서는 굳이 수량을 체크하지 않아도 별 문제없다
		model.addAttribute("returnUrl", "/shop/order?seq=" + vo.getSeq());
		return Const.REDIRECT_PAGE;
	}

	/** 결제 완료 페이지 */
	@RequestMapping("/order/finish")
	public String orderFinish(Integer orderSeq, HttpServletRequest request, Model model){
		HttpSession session = request.getSession();
		Integer memberSeq = (Integer)session.getAttribute("loginSeq");
		String loginType = (String)session.getAttribute("loginType");

		OrderVo vo = new OrderVo();
		vo.setLoginSeq(memberSeq);
		vo.setLoginType(loginType);
		vo.setOrderSeq(orderSeq);

		OrderVo ovo;
		try {
			ovo = orderService.getData(vo);
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다.["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}


		if(ovo == null) {
			// 해당 사용자의 주문이 아니라면
			model.addAttribute("message", "오류가 발생했습니다.");
			model.addAttribute("returnUrl", "/shop/main");
			return Const.REDIRECT_PAGE;
		}

		List<OrderVo> list = orderService.getListForDetail(vo);

		model.addAttribute("vo", ovo);
		model.addAttribute("list", list);

		log.info("######### referer : " + request.getHeader("REFERER"));

		//메일 발송시 중복 처리 방지
		if(orderSeq != null && !orderSeq.equals(session.getAttribute("orderSeq"))) {
			// 고객 주문 이메일 발송
			mailService.sendMailToMemberForOrder(ovo, list, request.getServletContext().getRealPath("/"));

			//주문과 동시에 결제완료되는 결제수단에만 입점업체 주문확인 메일을 발송한다.
			if(ovo.getPayMethod().startsWith("CARD") || ovo.getPayMethod().startsWith("OFFLINE") || "POINT".equals(ovo.getPayMethod()) || ovo.getPayMethod().startsWith("NP") ) {
				mailService.sendMailToSellerForOrder(ovo, request.getServletContext().getRealPath("/"));
			}
		}



		/** 구매 금액에 적립률을 얻어온다 **/
		int totlaOrderPrice = 0;
		int grade_point = 0;
		if(orderService.getTotalOrderFinishPrice(memberSeq) !=null){
			totlaOrderPrice = new Integer(orderService.getTotalOrderFinishPrice(memberSeq));
		}
		GradeVo gradeVo = new GradeVo();
		List<GradeVo> grades = gradeService.getList(gradeVo);
		for(GradeVo gradeVo1:grades){
			if(gradeVo1.getPayCondition()<totlaOrderPrice) {
				grade_point = gradeVo1.getPointPercent();
				break;
			}
		}

		/** 신용카드 결제의 경우, 포인트 적립 **/
		if(!"CASH".equals(ovo.getPayMethod())) {
			//구매 후 포인트 적립 : 구입액 * 1%
			//포인트 유효기가 30일
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar cl = new GregorianCalendar();
			Date date = new Date();
			cl.setTime(date);
			cl.add(cl.DATE, 30);
			String endDate = sdf.format(cl.getTime());
			PointVo orderPoint = new PointVo();
			orderPoint.setStatusCode("S");
			orderPoint.setMemberSeq((Integer) session.getAttribute("loginSeq"));
			orderPoint.setEndDate(endDate);
			orderPoint.setPoint((int) (ovo.getPayPrice() * grade_point *0.01));
			orderPoint.setValidFlag("Y");
			orderPoint.setReserveCode("B");//회원가입 : N, 구매 : B  , 이벤트 : E
			orderPoint.setTypeCode("1");
			orderPoint.setOrderSeq(ovo.getOrderSeq());
			orderPoint.setNote("구매포인트지급(주문번호 :" + ovo.getOrderSeq() + ")");
			//orderPoint.setAdminSeq(memberSeq);
			orderPoint.setUseablePoint(orderPoint.getPoint());

			try {
				if (!pointService.insertData(orderPoint)) {
					throw new Exception();
				}

				orderPoint.setPointSeq(orderPoint.getSeq());

				if (!pointService.insertHistoryData(orderPoint)) {
					throw new Exception();
				}

				if (!pointService.insertLogData(orderPoint)) {
					throw new Exception();
				}
			} catch (Exception e) {
				log.error("POINT FAIL:: ===> " + e.getMessage());
				e.printStackTrace();
			}
		}
		//메일 중복 발송 방지를 위한 세션값 업데이트
		session.setAttribute("orderSeq", ovo.getOrderSeq());
		//회원읜 등급에 따른 적립율을 넘긴다

		model.addAttribute("grade_point",""+grade_point );
		return "/order/finish.jsp";
	}

	/** 주문할 상품 리스트 가져오기 */
	private List<ItemVo> getListItem(String seq, HttpSession session, String estimateFlag, Model model) {
		log.info("### session's loginSeq : " + session.getAttribute("loginSeq"));
		log.info("### session's notLoginKey : " + session.getAttribute("notLoginKey"));

		List<ItemVo> list = null;
		if("Y".equals(estimateFlag)) {
			EstimateVo vo = new EstimateVo();
			vo.setSeq(Integer.valueOf(seq));
			vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
			list = estimateService.getListForOrder(vo);
		} else {
			ItemVo vo = new ItemVo();
			vo.setCartSeqs(seq);
			vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
			//비회원일 경우 별도 인증키 값 저장
			if(session.getAttribute("notLoginKey") != null) {
				vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
			}
			list = cartService.getList(vo);
		}

		if (list == null || list.size() == 0) {
			// 주문 상품 존재여부 체크
			model.addAttribute("message", "죄송합니다.\\n주문하실 상품이 존재하지 않습니다");
			return null;
		}

		// 재고 수량 체크(재고관리 하는 상품만 체크한다.)
		for (int i = 0; i < list.size(); i++) {
			if("Y".equals(list.get(i).getStockFlag())) {
				if (list.get(i).getStockCount() == 0) {
					model.addAttribute("message", "죄송합니다.\\n해당 상품은 품절되었습니다.[상품번호:"	+ list.get(i).getName() + "]");
					return null;
				}
				if (list.get(i).getStockCount() < list.get(i).getCount()) {
					model.addAttribute("message", "죄송합니다.\\n해당 상품의 구매 수량이 현재 재고 수량을 초과합니다.[상품번호:"+ list.get(i).getName() + "]");
					return null;
				}
			}
		}

		return list;
	}

	/** 총금액을 구한다 */
	private int getTotalPrice(List<ItemVo> list, String estimateFlag) {
		int totalPrice = 0;
		for (int i = 0; i < list.size(); i++) {
			if("Y".equals(estimateFlag)) {
				totalPrice += list.get(i).getSellPrice();
			} else {
				totalPrice += list.get(i).getSellPrice() * list.get(i).getCount();
//				if (!("Y".equals(list.get(i).getFreeDeli()))) {
//					totalPrice += list.get(i).getDeliCost();
//				}
			}
		}

		if(totalPrice<50000) {
			for (int i = 0; i < list.size(); i++) {
				if (!"Y".equals(estimateFlag)) {
					if (!("Y".equals(list.get(i).getFreeDeli()))) {
						totalPrice += list.get(i).getDeliCost();
						break;
					}
				}
			}
		}
		return totalPrice;
	}

	/** 배송지 등록, 수정 처리 */
	@RequestMapping(value="/order/delivery/{submitFlag}/proc", method= RequestMethod.POST)
	public String regDeliverySubmit(@PathVariable String submitFlag, HttpSession session, MemberDeliveryVo vo, Model model) {


		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		vo.setMemberSeq(loginSeq);

		if(!"del".equals(submitFlag) && !dliveryValidCheck(vo, model)){
			return Const.AJAX_PAGE;
		}

		if("reg".equals(submitFlag)) { //등록
			try {
				if (!memberDeliveryService.regData(vo)) {
					model.addAttribute("message", "FAIL");
					return Const.AJAX_PAGE;
				}
			} catch(Exception e) {
				model.addAttribute("message", "회원 정보 암호화에 실패했습니다.["+e.getMessage()+"]");
				return Const.AJAX_PAGE;
			}
		} else if("mod".equals(submitFlag)) { //수정
			try {
				if (!memberDeliveryService.modData(vo)) {
					model.addAttribute("message", "FAIL");
					return Const.AJAX_PAGE;
				}
			} catch(Exception e) {
				model.addAttribute("message", "회원 정보 암호화에 실패했습니다.["+e.getMessage()+"]");
				return Const.AJAX_PAGE;
			}
		} else { //삭제
			if(!memberDeliveryService.delData(vo)) {
				model.addAttribute("message", "FAIL");
				return Const.AJAX_PAGE;
			}
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	/** PG 결제 인증값 수신 */
	@RequestMapping("/{pgCode}/return")
	public static String getResultMsg(HttpServletRequest request, @PathVariable String pgCode) throws Exception {
		request.setCharacterEncoding("euc-kr");
		return "/pg/"+pgCode+"/returnurl.jsp";
	}

	@RequestMapping("/order/lately/vo/json")
	public String getLatelyOrderVo(HttpSession session, Model model) {
		// 로그인 되었는지 체크
		if(session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "NOT LOGGED ON");
			return Const.AJAX_PAGE;
		}

		Integer memberSeq = Integer.valueOf( (""+session.getAttribute("loginSeq")) );
		MemberDeliveryVo vo;
		try {
			vo = orderService.getLatelyOrderVo(memberSeq);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다.["+e.getMessage()+"]");
			return Const.AJAX_PAGE;
		}

		if(vo != null) {
			//전화번호 자르기
			if (!StringUtil.isBlank(vo.getTel())) {
				String[] tmp = vo.getTel().split("-");
				if (tmp.length == 3) {
					vo.setTel1(tmp[0]);
					vo.setTel2(tmp[1]);
					vo.setTel3(tmp[2]);
				}
			}
			//전화번호 자르기
			if (!StringUtil.isBlank(vo.getCell())) {
				String[] tmp = vo.getCell().split("-");
				if (tmp.length == 3) {
					vo.setCell1(tmp[0]);
					vo.setCell2(tmp[1]);
					vo.setCell3(tmp[2]);
				}
			}
		}
		model.addAttribute("vo", vo);
		return "/ajax/get-delivery-vo.jsp";
	}

	/** 포인트 사용 가능 여부 체크 */
	private boolean checkPoint(String payMethod, int usePoint, Integer memberSeq, int totalPrice, Model model) {
		boolean flag = true;
		//사용포인트 체크
		if(usePoint < 0) {
			model.addAttribute("message", "사용포인트는 0보다 작을 수 없습니다.");
			flag = false;
		} else if(usePoint == 0) {
			if("POINT".equals(payMethod)) {
				//포인트 결제만 사용하는 쇼핑몰일 경우 사용 포인트가 존재하지 않으면 결제 진행을 중단시킨다.
				model.addAttribute("message","주문시 사용 포인트 금액을 입력해 주시기 바랍니다.");
				flag = false;
			}
		} else {
			Integer useablePoint = pointService.getUseablePoint(memberSeq);
			if(useablePoint == null) {
				model.addAttribute("message", "보유포인트가 존재하지 않거나, 사용가능 유효기간이 만료되었습니다)");
				flag = false;
			} else if(usePoint > useablePoint.intValue()) {
				model.addAttribute("message", "포인트 사용 금액이 보유 한도를 초과하였습니다.");
				flag = false;
			} else if(usePoint > totalPrice) {
				model.addAttribute("message", "포인트 사용 금액이 주문 금액을 초과하였습니다.");
				flag = false;
			} else {
				//포인트 결제만 사용하는 쇼핑몰일 경우 사용 포인트가 주문금액과 같은지(포인트전액결제) 체크한다.
				if("POINT".equals(payMethod)) {
					if(usePoint != totalPrice) {
						model.addAttribute("message", "포인트 사용 금액이 주문 금액과 일치하지 않습니다.");
						flag = false;
					}
				}
			}
		}
		return flag;
	}


	private boolean dliveryValidCheck(MemberDeliveryVo vo, Model model) {
		boolean flag = true;
		/* 유효성 검사 */
		if(StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "이름을 입력해주세요.");
			flag = false;
		} else if(StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "제목을 입력해주세요.");
			flag = false;
		} else if(StringUtil.isBlank(vo.getCell1()) || StringUtil.isBlank(vo.getCell2()) || StringUtil.isBlank(vo.getCell3())) {
			model.addAttribute("message", "핸드폰 번호를 입력해주세요.");
			flag = false;
		} else if(StringUtil.isBlank(vo.getTel1()) || StringUtil.isBlank(vo.getTel2()) || StringUtil.isBlank(vo.getTel3())) {
			model.addAttribute("message", "전화 번호를 입력해주세요.");
			flag = false;
		} else if(StringUtil.isBlank(vo.getPostcode())) {
			model.addAttribute("message", "우편 번호를 입력해주세요..");
			flag = false;
		} else if(StringUtil.isBlank(vo.getAddr1()) || StringUtil.isBlank(vo.getAddr2())) {
			model.addAttribute("message", "주소를 입력해주세요");
			flag = false;
		}
		return flag;
	}

	/** 면세 상품 금액 구하기 **/
	private int calcTaxFreeAmt(List<ItemVo> list) {
		int taxFreeAmt = 0;
		if(list != null) {
			for(int i=0; i<list.size(); i++) {
				ItemVo vo = list.get(i);
				if(!"1".equals(vo.getTaxCode())) {
					taxFreeAmt += vo.getSellPrice()* vo.getCount();
				}
			}
		}

		return taxFreeAmt;
	}

	/** 최종 결제수단 결정 **/
	private String getPayMethod(OrderVo vo) {
		String payMethod = vo.getPayMethod();

		// 방문결제, 후청구 결제시 결제완료여부 '미처리' 설정
		if("OFFLINE".equals(payMethod) || payMethod.startsWith("NP")) {
			vo.setNpPayFlag("N");
		}

		if(vo.getPayPrice() > 0) {
			if(vo.getPoint() > 0) {
				payMethod = payMethod + "+POINT";
			}
		} else {
			payMethod = "POINT";
		}

		return payMethod;
	}
}
