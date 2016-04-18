package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

@Slf4j
@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MallService mallService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private DisplayService displayService;

	@Autowired
	private MemberGroupService memberGroupService;

	@RequestMapping("/back")
	public static String goBack(String message, Model model) {
		model.addAttribute("message", message);
		return Const.BACK_PAGE;
	}

	@RequestMapping("/login")
	public String login(String returnUrl, Model model) {

		DisplayVo vo = new DisplayVo();
		vo.setMemberTypeCode("C"); //회원구분에 따라 템플릿을 가져온다.
		vo.setLocation("login");
		vo.setTitle("loginBanner");
		DisplayVo bvo = displayService.getVo(vo);
		model.addAttribute("loginBanner", bvo==null ? null:bvo.getContent());

		model.addAttribute("returnUrl", returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
		model.addAttribute("title", "로그인");
		return "/login.jsp";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, Model model) {
		/* 쿠키/세션 초기화 */
		initSession(request, response);

		model.addAttribute("returnUrl", "/shop/login");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/login/proc")
	public String login(HttpServletRequest request, HttpServletResponse response, String returnUrl, UserVo vo, Model model) {
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		/* 필수값 체크 */
		if("".equals(vo.getId())) {
			model.addAttribute("message", "아이디를 입력해 주세요.");
			return Const.ALERT_PAGE;
		} else if("".equals(vo.getPassword())) {
			model.addAttribute("message", "비밀번호를 입력해 주세요.");
			return Const.ALERT_PAGE;
		}

		/* 입력받은 패스워드 암호화 */
		try {
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다.");
			return Const.ALERT_PAGE;
		}

		vo.setMallSeq(mallVo.getSeq());

		/* 로그인 */
		vo.setLoginType("C");
		UserVo rvo = loginService.getData(vo);
		doLogin(request, response, model, rvo, vo);

		if(model.containsAttribute("message")) {
			return Const.ALERT_PAGE;
		}

		model.addAttribute("returnUrl", "/shop/main");
		if(!StringUtil.isBlank(returnUrl)){
			model.addAttribute("returnUrl", returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
		}

		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/notlogin/proc")
	public String notLogin(HttpServletRequest request, String returnUrl, UserVo vo, Model model) {
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		/* 필수값 체크 */
		if("".equals(vo.getName())) {
			model.addAttribute("message", "구매자명을 입력해 주세요.");
			return Const.ALERT_PAGE;
		} else if("".equals(vo.getEmail())) {
			model.addAttribute("message", "이메일을 입력해 주세요.");
			return Const.ALERT_PAGE;
		}

		/* 입력받은 이메일 암호화 */
		try {
			vo.setEmail(CrypteUtil.encrypt(vo.getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "암호화 처리 중 오류가 발생했습니다.");
			return Const.ALERT_PAGE;
		}

		vo.setMallSeq(mallVo.getSeq());

		if(loginService.checkCntInOrder(vo) <= 0) {
			model.addAttribute("message", "주문 내역이 존재하지 않습니다.");
			return Const.ALERT_PAGE;
		}
		//비회원 로그인 세션 생성
		HttpSession session = request.getSession(true);
		session.setMaxInactiveInterval(60*60);
		session.setAttribute("loginName", vo.getName());
		session.setAttribute("loginEmail",vo.getEmail());
		session.setAttribute("loginType", "NC");

		model.addAttribute("returnUrl", "/shop/mypage/order/list"); // 주문배송조회
		if(!StringUtil.isBlank(returnUrl)){
			model.addAttribute("returnUrl", returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
		}

		return Const.REDIRECT_PAGE;
	}

	private void doLogin(HttpServletRequest request, HttpServletResponse response, Model model, UserVo rvo, UserVo vo) {
		if(rvo == null) {
			model.addAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return;
		}

		if(!"C".equals(rvo.getLoginType())) {
			model.addAttribute("message", "쇼핑몰 이용 권한이 없습니다.");
			return;
		}
		/* 세션값 설정 */
		HttpSession session = request.getSession(true);
		session.setMaxInactiveInterval(60*60);
		session.setAttribute("loginSeq", rvo.getLoginSeq());
		session.setAttribute("loginId", rvo.getId());
		session.setAttribute("loginName", rvo.getName());
		session.setAttribute("nickname", rvo.getNickname());
		session.setAttribute("loginType", rvo.getLoginType());
		session.setAttribute("loginMemberTypeCode", rvo.getMemberTypeCode());
		session.setAttribute("notiPasswordFlag", rvo.getNotiPasswordFlag());

		MemberVo mvo = null;
		try {
			mvo = memberService.getData(rvo.getLoginSeq());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(mvo != null && !"C".equals(rvo.getMemberTypeCode())) {
			MemberGroupVo gvo = memberGroupService.getVo(mvo.getGroupSeq());
			if(gvo != null) {
				session.setAttribute("loginJachiGuCode", gvo.getJachiguCode());
			}
		}

		/* 로그인 상태 정보 업데이트 */
		vo.setLoginSeq(rvo.getLoginSeq());
		vo.setLastIp(request.getRemoteAddr());
		vo.setLoginToken(UUID.randomUUID().toString());
		loginService.updateData(vo);

		/* 쿠키에 로그인 토큰을 담는다 */
		response.addCookie(createCookie("loginToken", vo.getLoginToken()));

		/* 로그인 정보 로그기록 */
		log.info("[login seq:id:name:token] " + vo.getLoginSeq() + ":" + vo.getId() + ":" + vo.getName() + ":" + vo.getLoginToken());
	}

	/** 쿠키 세션 초기화 */
	private void initSession(HttpServletRequest request, HttpServletResponse response) {
		/* 세션 초기화 */
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
			session = null;
		}

		/* 쿠키 초기화 */
		Cookie cookie = new Cookie("loginToken", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	/** 쿠키 생성 */
	public static Cookie createCookie(String name, String value) {
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(60 * 60 * 24); //하루동안만 유지시킨다.
		cookie.setPath("/");
		return cookie;
	}

	@RequestMapping("/mobile/policy")
	public static String movePage() {
		return "/cscenter/site_policy.jsp";
	}
}


