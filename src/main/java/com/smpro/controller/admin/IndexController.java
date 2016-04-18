package com.smpro.controller.admin;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.BoardVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.NoticePopupVo;
import com.smpro.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.UUID;

@Slf4j
@Controller
public class IndexController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private SystemService systemService;

	/** 메인현황 페이지 */
	@RequestMapping("/index")
	public String index(HttpSession session, BoardVo vo, Model model) {
		model.addAttribute("title", "Home");
		
		String loginType = (String) session.getAttribute("loginType");

		MemberVo memberVo = new MemberVo();
		memberVo.setSeq((Integer) session.getAttribute("loginSeq"));
		memberVo.setLoginType(loginType);
		
		
		NoticePopupVo nvo = new NoticePopupVo();
		nvo.setStatusCode("Y");
		nvo.setTypeCode("S");
		model.addAttribute("noticePopup", systemService.getNoticePopupList(nvo));

		/** 일주일간 쇼핑몰 현황 */
		model.addAttribute("orderWeekVo", orderService.getOrderSumForWeek(memberVo));
		
		/** 일주일간 게시판 현황 */
		 model.addAttribute("directBoardWeekList",boardService.getDirectBoardRegCntForWeek(memberVo));
		 model.addAttribute("itemqnaBoardWeekList",boardService.getItemQnaBoardRegCntForWeek(memberVo));
		 model.addAttribute("reviewBoardWeekList",reviewService.getReviewBoardRegCntForWeek(memberVo));

		/** 일주일간 업체관리, 회원관리 현황 */
		 model.addAttribute("companyWeekList", memberService.getCompanyAndMemberRegCntForWeek());
		 
		 model.addAttribute("sellerWeekApproveCnt", new Integer(sellerService.getSellerRegCntForWeek()));

		/** 일주일간 상품관리 현황 */
		model.addAttribute("itemWeekCnt", itemService.getItemRegCntForWeek(memberVo));

		/** 금일 매출 현황 */
		model.addAttribute("dayOrderStatus", orderService.getDayOrderStatus(memberVo));
		
		/** 금주 매출 현황 */
		model.addAttribute("WeekOrderStatus", orderService.getWeekOrderStatus(memberVo));

		/** 금월 매출 현황 */
		model.addAttribute("monthOrderStatus", orderService.getMonthOrderStatus(memberVo));

		/** 금년 매출 현황 */
		model.addAttribute("yearOrderStatus", orderService.getYearOrderStatus(memberVo));

		List<BoardVo> getList = null;
		vo.setLoginType((String) session.getAttribute("loginType"));
		
		if(!"A".equals(vo.getLoginType())) {
			vo.setUserSeq((Integer) session.getAttribute("loginSeq"));
		}

		/** 공지사항 리스트 */
		vo.setGroupCode("notice");
		vo.setRowCount(7);
		getList = boardService.getList(vo);
		for (int i = 0; i < getList.size(); i++) {
			BoardVo tmpVo = getList.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 55));
		}
		model.addAttribute("noticeList", getList);

		/** 상품 Q&A 리스트 */
		vo.setGroupCode("qna");
		// 미답변 상태인 게시물만
		vo.setAnswerFlag(new Integer(2));
		vo.setRowCount(7);
		getList = boardService.getList(vo);
		for (int i = 0; i < getList.size(); i++) {
			BoardVo tmpVo = getList.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 55));
		}
		model.addAttribute("qnaList", getList);

		/** 1:1문의 리스트 */
		vo.setGroupCode("one");
		// 미답변 상태인 게시물만
		vo.setAnswerFlag(new Integer(2));
		vo.setRowCount(7);
		getList = boardService.getList(vo);
		for (int i = 0; i < getList.size(); i++) {
			BoardVo tmpVo = getList.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 55));
		}
		model.addAttribute("oneList", getList);

		return "/index.jsp";
	}

	@RequestMapping("/index/weekchart/json")
	public String getWeekChart(HttpSession session, Model model) {
		model.addAttribute("list", orderService.getOrderSumChartForWeek(session));
		return "/ajax/get-orderSumChart-list.jsp";
	}

	@RequestMapping("/index/todaychart/json")
	public String getTodayChart(HttpSession session, Model model) {
		model.addAttribute("list", orderService.getOrderSumChartForToDay(session));
		return "/ajax/get-orderSumChart-list.jsp";
	}

	/** 로그인 페이지 포워딩 */
	@RequestMapping({ "/login", "/" })
	public static String loginForm(Model model) {
		model.addAttribute("title", "관리 어드민 로그인");
		return "login.jsp";
	}

	/** 로그인 로직 처리 */
	@RequestMapping("/login/proc")
	public String loginProc(HttpServletRequest request, HttpServletResponse response, UserVo vo, Model model) {
		/* 로그인 검증 */
		if ("".equals(vo.getId()) || "".equals(vo.getPassword())) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.ALERT_PAGE;
		}

		/* 비정상적으로 접속하는 아이피 차단 */
		String[] blockIpAddrs = { "117.52.109.211", "117.52.109.212", "117.52.109.213" };
		String remoteAddr = request.getRemoteAddr();
		log.info("### 관리자 로그인 아이피 주소 : " + remoteAddr);
		for (String blockIpAddr : blockIpAddrs) {
			if (blockIpAddr.equals(remoteAddr)) {
				log.info("### 해당 아이피 주소는 차단되었습니다.");
				// model.addAttribute("message", "해당 아이피 주소는 차단되었습니다.");
				return "";
			}
		}

		/* 입력받은 패스워드 암호화 */
		try {
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		} catch (NoSuchAlgorithmException e) {
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다");
			return Const.ALERT_PAGE;
		}

		UserVo rvo = loginService.getData(vo);
		if (rvo == null) {
			model.addAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다");
			return Const.ALERT_PAGE;
		}

		/* 로그인 처리 */
		doLogin(request, response, rvo);

		/* loginType값으로 메인페이지 분기 */
		String loginType = rvo.getLoginType();
		String returnUrl = "/admin/index";

		if (!"A".equals(loginType) && !"S".equals(loginType) && !"D".equals(loginType) && !"M".equals(loginType)) {
			model.addAttribute("message", "허용되지 않은 권한입니다.");
			return Const.ALERT_PAGE;
		}

		if ("M".equals(loginType)) {
			returnUrl = "/admin/order/list"; // 몰
		}

		model.addAttribute("returnUrl", returnUrl);
		return Const.REDIRECT_PAGE;
	}

	/** 로그아웃 */
	@RequestMapping("/logout")
	public static String logout(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession(false);
		model.addAttribute("title", "로그아웃");
		/* 쿠키 삭제 */
		Cookie cookie = new Cookie("loginToken", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		/* 세션 파기 */
		if (session != null) {
			session.invalidate();
		}
		/* 페이지 이동 */
		model.addAttribute("message", "정상적으로 로그아웃 되셨습니다.");
		model.addAttribute("returnUrl", "/admin/login");
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 로그인 시키는 메서드 이 메서드는 사용자 검증을 하지 않는다 올바른 사용자인지 아닌지 판별한 후에 vo를 넘기도록 구현해야 한다
	 */
	public void doLogin(HttpServletRequest request, HttpServletResponse response, UserVo vo) {
		HttpSession session = request.getSession(true);
		session.setMaxInactiveInterval(60 * 60 * 2);
		session.setAttribute("loginSeq", vo.getLoginSeq());
		session.setAttribute("loginId", vo.getId());
		session.setAttribute("loginName", vo.getName());
		session.setAttribute("gradeCode", vo.getGradeCode());
		session.setAttribute("loginType", vo.getLoginType()); //사용자 유형 설정 (A:관리자,S:입점업체,D:총판,C:회원,M:쇼핑몰)

		/* 로그인 상태 정보를 변경한다 */
		vo.setLastIp(request.getRemoteAddr());
		// 톰캣 설정상의 문제로 ipv6로 루프백이 반환되는 경우가 있다.
		if(vo.getLastIp().startsWith("fe80:0:0:0:0:0:0:1")) {
			vo.setLastIp("127.0.0.1");
		}
		vo.setLoginToken(UUID.randomUUID().toString());
		loginService.updateData(vo); // DB 입력

		if ("A".equals(vo.getLoginType())) {
			vo.setIpAddr(vo.getLastIp());
			loginService.insertAdminAccessLog(vo);
		}

		/* 쿠키에 로그인 토큰과 로그인 타입을 담는다 */
		response.addCookie(createCookie("loginToken", vo.getLoginToken()));

		/* 로그인 정보 로그기록 */
		log.info("[login seq:id:name:grade:type:token] " + vo.getLoginSeq() + ":" + vo.getId() + ":" + vo.getName() + ":"	+ vo.getGradeCode() + ":" + vo.getLoginType() + ":"	+ vo.getLoginToken());
	}

	/** 쿠키 생성 */
	public static Cookie createCookie(String name, String value) {
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(60 * 60 * 24); // 하루동안만 유지시킨다.
		cookie.setPath("/");
		return cookie;
	}

	/**
	 * todo: 추후 구현
	 */
	@RequestMapping("/auth/fail")
	public static String authFail(Model model) {
		model.addAttribute("message", "권한이 허용되지 않은 접근입니다");
		model.addAttribute("returnUrl", "/admin/index");
		return Const.REDIRECT_PAGE;
	}
}
