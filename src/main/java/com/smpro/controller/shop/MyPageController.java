package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.*;
import com.smpro.util.pg.PgUtil;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class MyPageController extends MyPage {
	private static final int ROW_COUNT = 10;

	@Autowired
	private LoginService loginService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberGroupService memberGroupService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private PointService pointService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private EstimateService estimateService;

	@Autowired
	private FilenameService filenameService;

	@Autowired
	private EventService eventService;

	@RequestMapping("/mypage/main")
	public String mypageMain(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginSeq") == null && session.getAttribute("loginEmail") == null) {
			model.addAttribute("message", "로그인 후 이용하시기 바랍니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		}

		initMypage(session, model);
		OrderVo pvo = new OrderVo();
		pvo.setLoginType((String)session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer)session.getAttribute("loginSeq"));

		/** 비회원 조회용 */
		pvo.setLoginName((String)session.getAttribute("loginName"));
		pvo.setLoginEmail((String)session.getAttribute("loginEmail"));

		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		pvo.setRowCount(ROW_COUNT);
		pvo.setBoardType("order");

		pvo.setTotalRowCount(orderService.getListCount(pvo));

		List<OrderVo> list;
		try {
			list = orderService.getList(pvo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("orderList",  list);
		/* 주문 상태별 건수 */
		model.addAttribute("data", orderService.getCntByStatus(pvo));
		model.addAttribute("pvo", pvo);


		// 공지사항
		BoardVo bvo = new BoardVo();
		bvo.setCategoryCode(new Integer(1));
		bvo.setGroupCode("notice");
		bvo.setRowCount(ROW_COUNT);
		bvo.setPageCount(3);
		model.addAttribute("noticeList", boardService.getList(bvo));


		// 이벤트
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		/** 현재 진행중인 기획전 상품리스트를 가져옴 */
		EventVo evo = new EventVo();
		evo.setTypeCode("1");
		evo.setStatusCode("Y");
		evo.setMallSeq(mallVo.getSeq());
		//현재날짜 저장
		evo.setCurDate(StringUtil.getDate(0, "yyyyMMdd"));

		List<EventVo> eventVo = eventService.getList(evo);
		for(int i=0;i<eventVo.size();i++){
			EventVo tmpVo = eventVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("eventList",eventVo);
		model.addAttribute("evo", evo);

		model.addAttribute("title", "마이페이지");
		return "/mypage/main.jsp";
	}

	/**
	 * 회원수정 전 검증 페이지
	 */
	@RequestMapping("/mypage/confirm")
	public String mypageConfirm(HttpSession session, Model model, OrderVo pvo) {
		initMypage(session, model);


		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		model.addAttribute("data", orderService.getCntByStatus(pvo));

		model.addAttribute("title", "나의정보");
		model.addAttribute("on", "01");
		return "/mypage/member_confirm.jsp";
	}

	/** 회원수정,탈퇴 전 검증 **/
	@RequestMapping("/mypage/confirm/proc")
	public String confirmPassword(String member, HttpServletRequest request, HttpSession session, UserVo vo, Model model){


		vo.setId((String)session.getAttribute("loginId"));

		if(StringUtil.isBlank(vo.getPassword())) {
			model.addAttribute("message", "비밀번호를 입력해 주세요.");
			return Const.ALERT_PAGE;
		}

		/* 입력받은 패스워드 암호화 */
		try {
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다.");
			return Const.ALERT_PAGE;
		}

		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		vo.setMallSeq(mallVo.getSeq());
		vo.setLoginType("C");
		if(loginService.getData(vo)==null) {
			model.addAttribute("message", "비밀번호가 틀렸습니다.");
			return Const.ALERT_PAGE;
		}

		if(member.endsWith("mod")){
			session.setAttribute("checkPass", "pass");
			model.addAttribute("returnUrl", "/shop/mypage/mod");
			return Const.REDIRECT_PAGE;
		}

		session.setAttribute("checkPass", "pass");
		model.addAttribute("returnUrl", "/shop/mypage/leave");
		return Const.REDIRECT_PAGE;

	}

	@RequestMapping(value = "/mypage/mod")
	public String modForm(HttpSession session, MemberVo mvo, Model model, OrderVo pvo) {
		initMypage(session, model);

		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		mvo.setId((String)session.getAttribute("loginId"));
		mvo.setName((String)session.getAttribute("loginName"));

		model.addAttribute("data", orderService.getCntByStatus(pvo));

		MemberVo vo;
		try {
			vo = memberService.getData((Integer)session.getAttribute("loginSeq"));

			if(vo.getGroupSeq() != null) {
				model.addAttribute("gvo", memberGroupService.getVo(vo.getGroupSeq()));
			}
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("vo", vo);

//		CommonVo cvo = new CommonVo();
//		//자치구 코드
//		cvo.setGroupCode(new Integer(29));
//		model.addAttribute("jachiguList", systemService.getCommonList(cvo));

		model.addAttribute("title", "나의정보");
		model.addAttribute("on", "01");
		return "/mypage/member_mod.jsp";
	}

	/**
	 * 회원수정
	 */
	@RequestMapping(value = "/mypage/mod/proc", method = RequestMethod.POST)
	public String modData(HttpServletRequest request, HttpSession session, MemberVo vo, MemberGroupVo gvo, Model model) {

		boolean flag = false;
		boolean groupFlag = false;
		boolean resultFlag = false;
		String errMsg = "";
		/* 로그인 seq, type 세션으로부터 가져와서 vo 셋팅 */
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setSeq((Integer)session.getAttribute("loginSeq"));
		vo.setLogLoginSeq((Integer)session.getAttribute("loginSeq"));
		vo.setMemberTypeCode((String)session.getAttribute("loginMemberTypeCode"));

		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		if(!memberValidCheck(vo, gvo, model)){
			return Const.ALERT_PAGE;
		}

		try {
			vo.setMallSeq(mallVo.getSeq());
			flag = memberService.modData(vo);

			if("P".equals(vo.getMemberTypeCode()) || "O".equals(vo.getMemberTypeCode())) {
				gvo.setSeq(vo.getGroupSeq());
				groupFlag = memberGroupService.modVo(gvo);
			}

		} catch (NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			errMsg = "알 수 없는 오류가 발생했습니다.";
			flag = false;
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = "회원정보 수정에 실패하였습니다.";
			flag = false;
		}

		if ("C".equals(vo.getMemberTypeCode())) {
			if(flag) {
				resultFlag = true;
			}
		} else if("P".equals(vo.getMemberTypeCode()) || "O".equals(vo.getMemberTypeCode())) {
			//기업, 공공기관회원은 그룹까지 정상적으로 수정이 되어야 true이다.
			if (flag && groupFlag) {
				resultFlag = true;
			}
		}

		if(resultFlag) {
			model.addAttribute("message", "수정되었습니다.");
			model.addAttribute("returnUrl", "/shop/mypage/confirm");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}

	/**
	 * 회원수정
	 */
	@RequestMapping(value = "/mypage/mod/callback", method = RequestMethod.POST)
	public String modDataOnlyMember(HttpServletRequest request, HttpSession session, MemberVo vo, Model model) {

		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		boolean flag = false;
		String errMsg = "";

		MemberVo ovo;
		try {
			ovo = memberService.getData((Integer)session.getAttribute("loginSeq"));
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		ovo.setPassword(""); // 패스워드는 수정하지 않음 ^^
		ovo.setLoginType((String) session.getAttribute("loginType"));
		ovo.setSeq((Integer)session.getAttribute("loginSeq"));
		ovo.setLogLoginSeq((Integer)session.getAttribute("loginSeq"));

		// 수정할 것만 매핑한다
		ovo.setPostcode(vo.getPostcode());
		ovo.setAddr1(vo.getAddr1());
		ovo.setAddr2(vo.getAddr2());

		try {
			ovo.setMallSeq(mallVo.getSeq());
			flag = memberService.modData(ovo);
		} catch (NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			errMsg = "알 수 없는 오류가 발생했습니다.";
			flag = false;
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = "회원정보 수정에 실패하였습니다.";
			flag = false;
		}

		if (flag) {
			model.addAttribute("callback", "MEMBER_MOD_OK");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}

	/**
	 * 포인트 페이지
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/mypage/point")
	public String myPagePoint(PointVo pvo,  OrderVo ovo, HttpSession session, Model model) {
		ovo.setLoginType((String) session.getAttribute("loginType"));
		ovo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		initMypage(session, model);

		pvo.setMemberSeq(loginSeq);
		pvo.setRowCount(ROW_COUNT);
		pvo.setTotalRowCount(pointService.getShopPointCount(pvo));
		model.addAttribute("data", orderService.getCntByStatus(ovo));
		model.addAttribute("list", pointService.getShopPointList(pvo));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);

		model.addAttribute("title", "나의 포인트");
		model.addAttribute("on", "03");

		return "/mypage/point.jsp";
	}

	/**
	 * 주문 리스트
	 */
	@RequestMapping("/mypage/order/list")
	public String myPageOrderNow(OrderVo pvo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginSeq") == null && session.getAttribute("loginEmail") == null) {
			model.addAttribute("message", "로그인 후 이용하시기 바랍니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		}

		initMypage(session, model);

		pvo.setLoginType((String)session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer)session.getAttribute("loginSeq"));

		/** 비회원 조회용 */
		pvo.setLoginName((String)session.getAttribute("loginName"));
		pvo.setLoginEmail((String)session.getAttribute("loginEmail"));

		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		pvo.setRowCount(ROW_COUNT);
		pvo.setBoardType("order");

		pvo.setTotalRowCount(orderService.getListCount(pvo));

		List<OrderVo> list;
		try {
			list = orderService.getList(pvo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("list",  list);
		/* 주문 상태별 건수 */
		model.addAttribute("data", orderService.getCntByStatus(pvo));

		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);

		model.addAttribute("title", "구매리스트");
		model.addAttribute("on", "06");

		return "/mypage/order/list.jsp";
	}

	@RequestMapping("/mypage/NP_CARD/list")
	public String getListByPayMethod(HttpServletRequest request, OrderVo vo, Model model) {
		vo.setPayMethod("NP_CARD");
		HttpSession session = request.getSession();

		vo.setLoginType((String)session.getAttribute("loginType"));
		vo.setLoginSeq((Integer)session.getAttribute("loginSeq"));

		//기본 조회기간 일주일
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		vo.setRowCount(ROW_COUNT);
		vo.setTotalRowCount(orderService.getListNPCount(vo));

		try {
			model.addAttribute("list", orderService.getListNP(vo));
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", vo);
		return "/mypage/order/list_NP_CARD.jsp";
	}

	@RequestMapping("/mypage/item/info/ajax")
	public String getItemInfo(OrderVo vo, Model model) {

		model.addAttribute("vo", orderService.getVoDetail(vo.getSeq()));
		return "/ajax/get-item-info-vo.jsp";
	}

	@ResponseBody
	@RequestMapping(value="/mypage/point/ajax", produces = "application/json; charset=utf-8")
	public String getPoint(HttpSession session) {
		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		Integer useablePoint = pointService.getUseablePoint(loginSeq);

		Map map = new HashMap();
		map.put("point", useablePoint == null ? new Integer(0) : useablePoint);

		return JsonHelper.render(map);
	}

	/**
	 * 주문 상세 페이지
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/mypage/order/detail/{orderSeq}")
	public String myPageOrderDetail(HttpSession session, @PathVariable Integer orderSeq, Model model) {

		initMypage(session, model);

		OrderVo pvo = new OrderVo();
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setOrderSeq(orderSeq);

		/** 비회원 조회용 */
		pvo.setLoginName((String)session.getAttribute("loginName"));
		pvo.setLoginEmail((String)session.getAttribute("loginEmail"));

		OrderVo ovo;
		try {
			ovo = orderService.getData(pvo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			e.printStackTrace();
			return Const.ALERT_PAGE;
		}
		/* 주문 데이터 */
		model.addAttribute("vo", ovo);
		/* 주문 상품 리스트 */
		model.addAttribute("list", orderService.getListForDetail(pvo));
		/* 세금계산서 요청 내역 */
		try {
			model.addAttribute("taxRequest", orderService.getTaxRequestData(orderSeq));
		} catch(Exception e) {
			// 안해도 별 상관없을 것이다
		}

		/* 비교견적 첨부파일 리스트 */
		EstimateVo evo = new EstimateVo();
		evo.setLoginType(pvo.getLoginType());
		evo.setLoginSeq(pvo.getLoginSeq());
		evo.setOrderSeq(pvo.getOrderSeq());
		model.addAttribute("estimateCompareFileList", estimateService.getListCompareFile(evo));

		model.addAttribute("title", "구매 상세정보");
		model.addAttribute("on", "06");

		return "/mypage/order/detail.jsp";
	}

	/**
	 * 주문 상세 페이지(프린트용)
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/mypage/order/view/{orderSeq}")
	public String myPageOrderView(HttpSession session, @PathVariable Integer orderSeq, String pageType, Model model) throws Exception {
		String goUrl = "/mypage/order/view.jsp";
		model.addAttribute("title", "거래 명세표");
		if("receipt".equals(pageType)) {
			model.addAttribute("title", "영 수 증");
		} else if("estimate".equals(pageType)) {
			model.addAttribute("title", "견 적 서");
			goUrl = "/mypage/order/estimate_view.jsp";
		} else if("deliveryConfirm".equals(pageType)) {
			model.addAttribute("title", "납품확인서");
			goUrl = "/mypage/order/delivery_confirm_view.jsp";
		}

		OrderVo vo = new OrderVo();
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setOrderSeq(orderSeq);

		OrderVo ovo;
		try {
			ovo = orderService.getData(vo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			e.printStackTrace();
			return Const.ALERT_PAGE;
		}
		/* 주문 데이터 */
		model.addAttribute("vo", ovo);
		/* 주문 상품 리스트 */
		model.addAttribute("list", orderService.getListForDetail(vo));

		MemberVo mvo = memberService.getData((Integer) session.getAttribute("loginSeq"));
		model.addAttribute("memberVo", mvo);
		if(mvo != null) {
			model.addAttribute("memberGvo", memberGroupService.getVo(mvo.getGroupSeq()));
		}
		model.addAttribute("nowDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()).toString());
		return goUrl;
	}

	/**
	 ** 주문 취소,구매확정 처리 및 취소/교환/반품 요청
	 */
	@RequestMapping(value = "/mypage/order/status/update/proc", method = RequestMethod.POST)
	public String updateStatus(HttpSession session, OrderVo vo, Model model) {

		boolean flag = false;
		String errMsg = "처리에 실패 했습니다.";

		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		String loginType = (String) session.getAttribute("loginType");
		vo.setLoginSeq(loginSeq);
		vo.setLoginType(loginType);

        if(!vo.getStatusCode().equals("55") && StringUtil.isBlank(vo.getReason())){
            model.addAttribute("message", "신청 사유를 입력해주세요");
            return Const.ALERT_PAGE;
        }

		try {
			flag = orderService.updateStatus(vo);
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = "처리 중 오류가 발생하였습니다.["+e.getMessage()+"]";
		}

		if("55".equals(vo.getStatusCode())){
			model.addAttribute("message", "접수 되었습니다.");
			model.addAttribute("returnUrl", "/shop/mypage/order/list");
			return Const.REDIRECT_PAGE;
		}
		if (flag) {
			model.addAttribute("message", "접수 되었습니다.");
			model.addAttribute("returnUrl", "/shop/mypage/cancel/list");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;

	}

	/**
	 * 주문 취소 상세 페이지
	 */
	@RequestMapping("/mypage/cancel/detail/{orderSeq}")
	public String myPageCancelDetail(HttpSession session, @PathVariable Integer orderSeq, Model model) {
		myPageOrderDetail(session, orderSeq, model);
		return "/mypage/order/detail_cancel.jsp";
	}

	/**
	 * 구매확정(상품평) 등록
	 */
	@RequestMapping("/mypage/review/reg/proc")
	public String regItemReview(HttpSession session, ReviewVo vo, Model model) {
		vo.setMemberSeq((Integer) session.getAttribute("loginSeq"));
		OrderVo ovo = new OrderVo();
		ovo.setSeq(vo.getDetailSeq());
		ovo.setStatusCode(vo.getStatusCode());
		ovo.setLoginType((String) session.getAttribute("loginType"));
		ovo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		if(vo.getGoodGrade()==0){
			model.addAttribute("message", "평점을 선택해주세요.");
			return Const.ALERT_PAGE;
		}

		if(StringUtil.isBlank(vo.getReview())){
			model.addAttribute("message", "내용을 입력해주세요.");
			return Const.ALERT_PAGE;
		}
		try {
			boolean flag = orderService.updateStatus(ovo);

			if (flag && reviewService.insertData(vo)) {
				model.addAttribute("message", "등록되었습니다.");
			} else {
				model.addAttribute("message", "오류가 발생했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("returnUrl", "/shop/mypage/review");
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 상품평 페이지
	 *
	 * @param
	 * @param model
	 * @return
	 */
	@RequestMapping("/mypage/review")
	public String myPageReview(HttpSession session, ReviewVo pvo, OrderVo povo, Model model) {
		povo.setLoginType((String) session.getAttribute("loginType"));
		povo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		initMypage(session, model);
		OrderVo ovo = new OrderVo();
		ovo.setLoginType((String) session.getAttribute("loginType"));
		ovo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		ovo.setStatusCode("55");
		ovo.setTotalRowCount(orderService.getListForReviewDetailCount(ovo));
		model.addAttribute("detailList", orderService.getListForReviewDetail(ovo));
		model.addAttribute("detailPaging", ovo.drawPagingNavigation("goPage"));

		model.addAttribute("data", orderService.getCntByStatus(povo));
		pvo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setTotalRowCount(reviewService.getListCount(pvo));
		model.addAttribute("list", reviewService.getList(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		model.addAttribute("date1", pvo.getSearchDate1());
		model.addAttribute("date2", pvo.getSearchDate2());

		return "/mypage/review.jsp";
	}

	/**
	 * 1:1문의 리스트
	 */
	@RequestMapping("/mypage/direct/list")
	public String myPageDirectList(HttpSession session, BoardVo pvo, OrderVo povo, Model model) {

		povo.setLoginType((String) session.getAttribute("loginType"));
		povo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		initMypage(session, model);

		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		/** 1:1문의 */
		pvo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setGroupCode("one");
		pvo.setRowCount(ROW_COUNT);
		pvo.setTotalRowCount(boardService.getListCount(pvo));

		List<BoardVo> boardVo = boardService.getList(pvo);
		for (int i = 0; i < boardVo.size(); i++) {
			BoardVo tmpVo = boardVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 125));
		}

		model.addAttribute("data", orderService.getCntByStatus(povo));
		model.addAttribute("list", boardVo);
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);

		CommonVo cvo = new CommonVo();
		//1:1문의 구분 코드
		cvo.setGroupCode(new Integer(36));
		model.addAttribute("commonList", systemService.getCommonList(cvo));

		model.addAttribute("title", "내질문보기");
		model.addAttribute("on", "12");
		return "/mypage/direct_list.jsp";
	}

	@RequestMapping("/mypage/direct/form")
	public String directForm(HttpSession session, Model model) {
		initMypage(session, model);
		model.addAttribute("title", "1:1 문의하기");
		model.addAttribute("on", "12");

		CommonVo cvo = new CommonVo();
		//1:1문의 구분 코드
		cvo.setGroupCode(new Integer(36));
		model.addAttribute("commonList", systemService.getCommonList(cvo));
		return "/mypage/direct_form.jsp";
	}

	@RequestMapping("/mypage/{boardName}/edit/form/{seq}")
	public String directModForm(@PathVariable String boardName, @PathVariable Integer seq, Model model) {
		BoardVo vo = new BoardVo();
		String codeName = "";
		String goUrl = "";

		if("direct".equals(boardName)) {
			model.addAttribute("title", "1:1 문의하기");
			vo.setGroupCode("one");
			vo.setSeq(seq);
			codeName = "directBoard";
			goUrl = "/mypage/direct_form.jsp";
		} else if("qna".equals(boardName)) {
			model.addAttribute("title", "QnA 문의하기");
			vo.setGroupCode("qna");
			vo.setSeq(seq);
			goUrl = "/mypage/qna_form.jsp";
			codeName = "qnaBoard";
		}

		model.addAttribute("vo", boardService.getVo(vo));

		CommonVo cvo = new CommonVo();
		//1:1문의 구분 코드
		cvo.setGroupCode(new Integer(36));
		model.addAttribute("commonList", systemService.getCommonList(cvo));

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", vo.getSeq());
		model.addAttribute("file", filenameService.getList(map));
		return goUrl;
	}

	/**
	 * 1:1문의 등록하기
	 */
	@RequestMapping("/mypage/{boardName}/reg/proc")
	public String myPageDirectReg(@PathVariable String boardName, String code, HttpServletRequest request, HttpSession session, Model model) {
		String codeName = "";
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		BoardVo vo = getBoardVo(map, boardName);

		if("direct".equals(boardName)) {
			if(vo.getCategoryCode() == null) {
				model.addAttribute("message", "구분이 선택되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
			codeName = "directBoard";
		}

		if (vo.getTitle() != null && vo.getTitle().length() != 0 && (vo.getTitle().length() > 100)) {
			model.addAttribute("message", "제목 길이를 초과하였습니다.");
			return Const.ALERT_PAGE;
		} else if (vo.getTitle() == null || vo.getTitle().length() == 0 && "".equals(vo.getTitle())) {
			model.addAttribute("message", "제목이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		} else if (vo.getContent() == null || vo.getContent().length() == 0 && "".equals(vo.getContent())) {
			model.addAttribute("message", "내용이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		} else if (vo.getContent().length() > 4000) {
			model.addAttribute("message", "내용을 4000byte 이하로 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while (iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);

			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				try {
					if(formName.indexOf("file") == 0) {
						FilenameVo fvo =  new FilenameVo();
						fvo.setParentCode(codeName);
						fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
						fvo.setFilename(file.getOriginalFilename());
						fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
						fileList.add(fvo);
					}
				} catch(Exception e) {
					log.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}

		/** 1:1문의 */
		vo.setUserSeq((Integer) session.getAttribute("loginSeq"));
		if("direct".equals(boardName)) {
			vo.setGroupCode("O");
		}

		//시퀀스 생성
		boardService.createSeq(vo);

		if (!boardService.insertData(vo)) {
			model.addAttribute("message", "등록 할 수 없었습니다.");
			return Const.ALERT_PAGE;
		}

		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			fvo.setParentSeq(vo.getSeq());
			filenameService.replaceFilename(fvo);
		}

		model.addAttribute("message", "등록 되었습니다.");
		model.addAttribute("returnUrl", "/shop/mypage/direct/list");

		return Const.REDIRECT_PAGE;
	}

	/**
	 * 1:1문의 수정하기
	 */
	@RequestMapping("/mypage/{boardName}/mod/proc")
	public String myPageDirectMod(@PathVariable String boardName, Integer seq, String code, HttpServletRequest request, Model model) {
		String codeName = "";
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		BoardVo vo = getBoardVo(map, boardName);
		vo.setSeq(seq);

		if("direct".equals(boardName)) {
			if(vo.getCategoryCode() == null) {
				model.addAttribute("message", "구분이 선택되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
			codeName = "directBoard";
			vo.setGroupCode("one");
		} else if("qna".equals(boardName)) {
			vo.setGroupCode("qna");
		}

		if (vo.getTitle() != null && vo.getTitle().length() != 0 && (vo.getTitle().length() > 100)) {
			model.addAttribute("message", "제목 길이를 초과하였습니다.");
			return Const.ALERT_PAGE;
		} else if (vo.getTitle() == null || vo.getTitle().length() == 0 && "".equals(vo.getTitle())) {
			model.addAttribute("message", "제목이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		} else if (vo.getContent() == null || vo.getContent().length() == 0 && "".equals(vo.getContent())) {
			model.addAttribute("message", "내용이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		} else if (vo.getContent().length() > 4000) {
			model.addAttribute("message", "내용을 4000byte 이하로 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while (iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);

			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				try {
					if(formName.indexOf("file") == 0) {
						FilenameVo fvo =  new FilenameVo();
						fvo.setParentCode(codeName);
						fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
						fvo.setFilename(file.getOriginalFilename());
						fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
						fvo.setParentSeq(vo.getSeq());
						fileList.add(fvo);
					}
				} catch(Exception e) {
					log.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}

		/** 1:1문의 */
		if (!boardService.updateData(vo)) {
			model.addAttribute("message", "수정 할 수 없었습니다.");
			return Const.ALERT_PAGE;
		}

		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			filenameService.replaceFilename(fvo);
		}

		model.addAttribute("message", "수정 되었습니다.");
		model.addAttribute("returnUrl", "/shop/mypage/"+boardName+"/list");

		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/mypage/{boardName}/file/delete/proc")
	public String fileDelete(@PathVariable String boardName, @RequestParam int seq, @RequestParam int num, HttpServletRequest request, Model model) {
		String code = "";
		String groupCode = "";
		if("direct".equals(boardName)) {
			code = "directBoard";
			groupCode = "one";
		}

		BoardVo bvo = new BoardVo();
		bvo.setSeq(new Integer(seq));
		bvo.setGroupCode(groupCode);
		BoardVo vo = boardService.getVo(bvo);
		if(vo == null) {
			model.addAttribute("message", "비정상적인 접근입니다!!");
			return Const.ALERT_PAGE;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", code);
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);
		String deletePath = request.getServletContext().getRealPath("/") + fvo.getRealFilename();

		// 파일을 삭제
		try {
			log.info("file>>delete>> " + deletePath);
			filenameService.deleteVo(fvo);
			new File(deletePath).delete();
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		model.addAttribute("callback", new Integer(num));
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/mypage/{boardName}/file/download/proc")
	public String download(@PathVariable String boardName, @RequestParam int seq, @RequestParam int num, HttpServletResponse response) throws Exception {
		String code = "";
		String groupCode = "";
		if("direct".equals(boardName)) {
			code = "directBoard";
			groupCode = "one";
		}


		BoardVo bvo = new BoardVo();
		bvo.setSeq(new Integer(seq));
		bvo.setGroupCode(groupCode);
		BoardVo vo = boardService.getVo(bvo);
		if(vo == null) {
			return null;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode",code);
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);

		response.setContentType("application/octet-stream; charset=UTF-8;");
		response.setHeader("Content-Disposition", "attachment; filename=\""+ new String(fvo.getFilename().getBytes("utf-8"), "ISO-8859-1") +"\";");

		// 바보같겠지만... upload하는 메서드를 수정하긴 너무 빡셌다. 리얼에서만 돌아가는 것을 확인
		log.info(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		File file = new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		FileDownloadUtil.download(response, file);
		return null;
	}

	@RequestMapping("/mypage/{boardName}/del/proc")
	public String delProc(@PathVariable String boardName, Integer seq, Model model) {
		BoardVo vo = new BoardVo();
		vo.setSeq(seq);

		if (!boardService.deleteData(vo)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			model.addAttribute("returnUrl", "/shop/mypage/"+boardName+"/list");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "삭제 되었습니다");
		model.addAttribute("returnUrl", "/shop/mypage/"+boardName+"/list");

		return Const.REDIRECT_PAGE;
	}

	/**
	 * 취소/반품/교환 내역
	 */
	@RequestMapping("/mypage/cancel/list")
	public String orderCancelList(OrderVo pvo, HttpSession session, Model model) {
		initMypage(session, model);
		//OrderVo pvo = new OrderVo();
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		/** 비회원 조회용 */
		pvo.setLoginName((String)session.getAttribute("loginName"));
		pvo.setLoginEmail((String)session.getAttribute("loginEmail"));

		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		pvo.setRowCount(ROW_COUNT);
		pvo.setBoardType("cancel");
		pvo.setTotalRowCount(orderService.getListCount(pvo));

		List<OrderVo> list;
		try {
			list = orderService.getList(pvo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("list", list);
		/* 주문 상태별 건수 */
		model.addAttribute("data", orderService.getCntByStatus(pvo));

		pvo.setRowCount(ROW_COUNT);
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);

		return "/mypage/order/list_cancel.jsp";
	}

	/**
	 * 상품Q&A 리스트 *
	 */
	@RequestMapping("/mypage/qna/list")
	public String qnaList(HttpSession session, BoardVo vo, OrderVo povo, Model model) {
		initMypage(session, model);

		povo.setLoginType((String) session.getAttribute("loginType"));
		povo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		//기본 조회기간 일주일
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		model.addAttribute("loginSeq", session.getAttribute("loginSeq"));
		/** 게시판에서 검색항목 드롭박스를 선택 안했을시 디폴트로 title를 검색 */
		if ("".equals(vo.getSearch())) {
			vo.setSearch("title");
		}
		/** 상품문의 */
		vo.setUserSeq((Integer)session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setGroupCode("qna");
		vo.setRowCount(ROW_COUNT);
		vo.setTotalRowCount(boardService.getListCount(vo));

		List<BoardVo> boardVo = boardService.getList(vo);
		for (int i = 0; i < boardVo.size(); i++) {
			BoardVo tmpVo = boardVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 125));
		}

		model.addAttribute("data", orderService.getCntByStatus(povo));
		model.addAttribute("boardGroup", "qna");
		model.addAttribute("list", boardVo);
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("pvo", vo);

		return "/mypage/qna_list.jsp";
	}

	/** 취소/반품/교환안내 페이지 **/
	@RequestMapping("/mypage/cancel/info")
	public String cancelInfo(HttpSession session, Model model, OrderVo pvo){
		initMypage(session, model);

		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));


		model.addAttribute("data", orderService.getCntByStatus(pvo));

		return "/mypage/cancel_info.jsp";
	}

	/** 개인정보 이용동의 페이지 **/
	@RequestMapping("/mypage/agree")
	public String memberAgree(HttpSession session, Model model, OrderVo pvo){
		initMypage(session, model);

		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));


		model.addAttribute("data", orderService.getCntByStatus(pvo));

		return "/mypage/member_agree.jsp";
	}

	/**
	 * 회원탈퇴 전 검증 페이지
	 */
	@RequestMapping("/mypage/leave/confirm")
	public String leaveConfirm(HttpSession session, Model model, OrderVo pvo) {
		initMypage(session, model);

		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));


		model.addAttribute("data", orderService.getCntByStatus(pvo));

		model.addAttribute("title", "회원탈퇴");
		model.addAttribute("on", "14");

		return "/mypage/member_leave_confirm.jsp";
	}

	/** 회원탈퇴 페이지 **/
	@RequestMapping("/mypage/leave")
	public String memberLeave(HttpSession session, Model model, OrderVo pvo){
		if(StringUtil.isBlank((String) session.getAttribute("checkPass"))) {
			model.addAttribute("message", "정상적인 경로가 아닙니다.");
			model.addAttribute("returnUrl", "/shop/mypage/leave/confirm");
			return Const.REDIRECT_PAGE;
		}

		session.removeAttribute("checkPass");

		initMypage(session, model);

		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));


		model.addAttribute("data", orderService.getCntByStatus(pvo));

		return "/mypage/member_leave.jsp";
	}

	/**
	 * 주문 취소 처리(전체,부분)
	 */
	@RequestMapping(value = "/mypage/order/cancel", method = RequestMethod.POST)
	public String cancelOrder(HttpServletRequest request, OrderVo vo, Model model) {
		HttpSession session = request.getSession();


		boolean flag;
		String errMsg = "취소 처리에 실패했습니다.";

		String cancelType = vo.getCancelType();
		//int partCancelAmt = 0; //부분취소 주문 금액

		//로그인 정보 vo에 셋팅
		vo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		vo.setLoginType((String)session.getAttribute("loginType"));

		//사유 입력 체크
		if(StringUtil.isBlank(vo.getReason())){
			model.addAttribute("message", "취소 사유를 입력해주세요");
			return Const.ALERT_PAGE;
		}

		/** 취소/부분취소 주문 체크 */
		if("ALL".equals(cancelType)) {
			//전체취소
			if(!orderService.checkCancelAll(vo)) {
				model.addAttribute("message", "전체 취소가 가능한 상태가 아닙니다. 주문 상품별로 취소 요청하시기 바랍니다.");
				return Const.ALERT_PAGE;
			}
		} else if("PART".equals(cancelType)) {
			model.addAttribute("message", "부분 취소가 불가한 상태입니다. 고객 센터로 문의 바랍니다.)");
			return Const.ALERT_PAGE;
		} else {
			model.addAttribute("message", "유효하지 않은 접근입니다.");
			return Const.ALERT_PAGE;
		}

		OrderPayVo payVoCancel = null;
		/*** PG 취소 처리 ***/
		OrderPayVo payVo = orderService.getPayVoForCancel(vo.getOrderSeq());
		if(payVo != null && payVo.getCurAmount() > 0) {
			PgUtil pgUtil = new PgUtil(payVo.getPgCode());
			/** 전체 취소 */
			try {
				//PG 취소 요청
				//payVo.setOrderDetailSeq(vo.getSeq());
				payVo.setPartCancelAmt(0);
				payVoCancel = pgUtil.doCancel(request, payVo, "");
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (payVoCancel == null || !"Y".equals(payVoCancel.getResultFlag())) {
				if(payVoCancel == null) {
					model.addAttribute("message", "PG 결제 취소 처리에 실패하였습니다.[" + errMsg + "]");
				} else {
					model.addAttribute("message", "PG 결제 취소 처리에 실패하였습니다.[" + payVoCancel.getResultCode() + ":" + payVoCancel.getResultMsg() + "]");
				}
				return Const.ALERT_PAGE;
			}
		}

		/** 자체 포인트 취소 처리 */
		//해당 주문번호의 포인트 사용내역 조회
		PointVo pointVo = pointService.getHistoryForCancel(vo.getOrderSeq());
		PointVo pointVoCancel = null;
		if(pointVo != null && pointVo.getCurPoint() > 0) {
			//기 취소 여부 체크(중복취소 방지)
			if(pointService.checkCancel(pointVo) > 0){
				model.addAttribute("message", "포인트 취소적립 처리가 이미 완료된 건입니다.");
				return Const.ALERT_PAGE;
			}
			pointVoCancel = new PointVo();
			pointVoCancel.setOrderSeq(pointVo.getOrderSeq());
			pointVoCancel.setEndDate(StringUtil.getDate(365, "yyyy-MM-dd"));
			pointVoCancel.setPoint(pointVo.getCurPoint());
			pointVoCancel.setUseablePoint(pointVo.getCurPoint());
			pointVoCancel.setValidFlag("Y");
			pointVoCancel.setReserveCode("2");
			pointVoCancel.setReserveComment("주문 취소, 포인트 재적립");
			pointVoCancel.setMemberSeq(pointVo.getMemberSeq());
			pointVoCancel.setStatusCode("C");
		}

		/** 취소 내역 DB 업데이트 */
		try {
			flag = orderService.updateCancelAll(vo, payVoCancel, pointVoCancel);
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = "취소 처리 중 오류가 발생하였습니다.["+e.getMessage()+"]";
			flag = false;
		}

		if(flag) {
			model.addAttribute("message", "취소 완료 처리 되었습니다.");
			model.addAttribute("returnUrl", "/shop/mypage/cancel/list");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}

	/** 배송지 변경하기(결제완료상태일때) */
	@RequestMapping("/mypage/delivery/change")
	public String deliChange(OrderVo vo, Model model) throws UnsupportedEncodingException, InvalidKeyException {
		String name = vo.getReceiverName();
		String cell = vo.getReceiverCell();
		String tel = vo.getReceiverTel();
		String addr2 = vo.getReceiverAddr2();

		if(!orderService.updateAddr(vo)){
			model.addAttribute("result", "false");
			model.addAttribute("message", "배송지 변경에 실패하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		vo.setReceiverName(name);
		vo.setReceiverCell(cell);
		vo.setReceiverTel(tel);
		vo.setReceiverAddr2(addr2);
		model.addAttribute("vo", vo);
		return "/ajax/get-deli-addr.jsp";
	}

	/**
	 * 비교견적요청관리 (공공기관일 경우에만)
	 */
	@RequestMapping("/mypage/compare/list")
	public String myPageCompare(OrderVo pvo, HttpServletRequest request, Model model) {
		pvo.setEstimateCompareFlag("Y");
		myPageOrderNow(pvo, request, model);

		return "/mypage/order/list_compare.jsp";
	}

	/**
	 * 비교견적요청관리 상세 (공공기관일 경우에만)
	 */
	@RequestMapping("/mypage/compare/detail/{orderSeq}")
	public String myPageCompareDetail(HttpSession session, @PathVariable Integer orderSeq, Model model) {
		myPageOrderDetail(session, orderSeq, model);
		return "/mypage/order/detail_compare.jsp";
	}

	/**
	 * 세금계산서 (공공기관일 경우에만)
	 */
	@RequestMapping("/mypage/taxrequest/list")
	public String myPageTaxRequest(OrderVo pvo, HttpServletRequest request, Model model) {
		pvo.setTaxRequest("A");
		myPageOrderNow(pvo, request, model);

		return "/mypage/order/list_taxrequest.jsp";
	}

	/**
	 * 세금계산서 상세 (공공기관일 경우에만)
	 */
	@RequestMapping("/mypage/taxrequest/detail/{orderSeq}")
	public String myPageTaxRequestDetail(HttpSession session, @PathVariable Integer orderSeq, Model model) {
		myPageOrderDetail(session, orderSeq, model);
		return "/mypage/order/detail_taxrequest.jsp";
	}

	private boolean memberValidCheck(MemberVo vo, MemberGroupVo gvo, Model model) {
		boolean flag = true;
		/* 유효성 검사 */
		if("C".equals(vo.getMemberTypeCode())) {
			//일반회원
			if("".equals(vo.getEmail1()) || "".equals(vo.getEmail2())) {
				model.addAttribute("message", "이메일을 입력해주세요.");
				flag = false;
			} else if(!vo.getEmail1().matches("^[a-zA-Z0-9._-]*$") || !vo.getEmail2().matches("^[a-zA-Z0-9._-]*$")) {
				model.addAttribute("message", "이메일은 영문/숫자/._-만 가능 합니다.");
				flag = false;
			} else if("".equals(vo.getCell1()) || "".equals(vo.getCell2()) || "".equals(vo.getCell3())) {
				model.addAttribute("message", "휴대폰번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getPostcode())) {
				model.addAttribute("message", "우편번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getAddr1()) || "".equals(vo.getAddr2())) {
				model.addAttribute("message", "주소를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getEmailFlag())) {
				model.addAttribute("message", "뉴스레터 수신여부를 선택해주세요.");
				flag = false;
			} else if("".equals(vo.getSmsFlag())) {
				model.addAttribute("message", "SMS 수신여부를 선택해주세요.");
				flag = false;
			}
		} else {
			//공공기관, 기업
			if("".equals(gvo.getCeoName())) {
				model.addAttribute("message", "대표자를 입력해주세요.");
				flag = false;
//			} else if("P".equals(vo.getMemberTypeCode()) && "".equals(gvo.getJachiguCode())) { //공공기관일때만 검증
//				model.addAttribute("message", "자치구를 입력해주세요.");
//				flag = false;
			} else if("".equals(vo.getPostcode())) {
				model.addAttribute("message", "우편번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getAddr1()) || "".equals(vo.getAddr2())) {
				model.addAttribute("message", "주소를 입력해주세요.");
				flag = false;
//			} else if("".equals(vo.getName())) {
//				model.addAttribute("message", "담당자 이름을 입력해주세요.");
//				flag = false;
//			}  else if("".equals(vo.getEmail1()) || "".equals(vo.getEmail2())) {
//				model.addAttribute("message", "담당자 이메일을 입력해주세요.");
//				flag = false;
//			} else if(!vo.getEmail1().matches("^[a-zA-Z0-9._-]*$") || !vo.getEmail2().matches("^[a-zA-Z0-9._-]*$")) {
//				model.addAttribute("message", "담당자 이메일은 영문/숫자/._-만 가능 합니다.");
//				flag = false;
			} else if("".equals(vo.getCell1()) || "".equals(vo.getCell2()) || "".equals(vo.getCell3())) {
				model.addAttribute("message", "담당자 휴대폰번호를 입력해주세요.");
				flag = false;
//			} else if("".equals(vo.getTel1()) || "".equals(vo.getTel2()) || "".equals(vo.getTel3())) {
//				model.addAttribute("message", "담당자 전화번호를 입력해주세요.");
//				flag = false;
//			} else if("".equals(vo.getEmailFlag())) {
//				model.addAttribute("message", "뉴스레터 수신여부를 선택해주세요.");
//				flag = false;
//			} else if("".equals(vo.getSmsFlag())) {
//				model.addAttribute("message", "SMS 수신여부를 선택해주세요.");
//				flag = false;
//			} else if(!gvo.getTaxEmail1().matches("^[a-zA-Z0-9._-]*$") || !gvo.getTaxEmail2().matches("^[a-zA-Z0-9._-]*$")) {
//				model.addAttribute("message", "계산서 담당자 이메일은 영문/숫자/._-만 가능 합니다.");
//				flag = false;
			}
		}
		return flag;
	}

	private BoardVo getBoardVo(HashMap<String, Object> map, String boardName) {
		BoardVo vo = new BoardVo();
		if("direct".equals(boardName)) {
			vo.setCategoryCode(Integer.valueOf((String)map.get("categoryCode")));
		}
		vo.setTitle((String)map.get("title") == null ? "" : (String)map.get("title"));
		vo.setContent((String)map.get("content") == null ? "" : (String)map.get("content"));
		return vo;
	}
}