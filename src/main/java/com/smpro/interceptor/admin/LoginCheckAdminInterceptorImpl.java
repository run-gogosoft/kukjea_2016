package com.smpro.interceptor.admin;

import com.smpro.service.LoginService;
import com.smpro.service.MallAccessService;
import com.smpro.service.MallService;
import com.smpro.util.StringUtil;
import com.smpro.vo.MallAccessVo;
import com.smpro.vo.MallVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.UserVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Component
public class LoginCheckAdminInterceptorImpl extends HandlerInterceptorAdapter {
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginCheckAdminInterceptorImpl.class);
	
	@Autowired
	private LoginService loginService;
	@Autowired
	private MallService mallService;

	@Autowired
	private MallAccessService mallAccessService;

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		/* 브라우저 캐시를 제거한다 */
		response.setHeader("Progma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store"); // 일부 파이어폭스 버그 관련

		/* navi 위치 처리 */
		String requestURI = request.getRequestURI();
		String requestURIAttribute = request.getParameter("mallSeq");

		String naviPos = "";
		String naviPosSub = "";

		LOGGER.info("### requestURI : " + requestURI);
		LOGGER.info("### requestURIAttribute : " + requestURIAttribute);
		LOGGER.debug("### handler : " + handler.toString());

		if (!StringUtil.isBlank(requestURI)	&& requestURI.split("/").length >= 3) {
			naviPos = requestURI.split("/")[2];
			naviPosSub = requestURI.substring(requestURI.indexOf(naviPos)-1);
		}
		// 다른이름의 페이지 navi 조정
//		if ("display".equals(naviPos) || "mall".equals(naviPos) || "category".equals(naviPos) || "sms".equals(naviPos) || "menu".equals(naviPos)) {
		if ("display".equals(naviPos) || "mall".equals(naviPos) || "sms".equals(naviPos) || "menu".equals(naviPos)) {
			naviPos = "system";
		} else if ("review".equals(naviPos)) {
			naviPos = "board";
		} else if ("event".equals(naviPos) || "category".equals(naviPos) || "best".equals(naviPos)) {
			naviPosSub = naviPos;
			naviPos = "item";
		} else if ("point".equals(naviPos)) {
			naviPos = "member";
		}

		LOGGER.debug("### navi : " + naviPos);
		LOGGER.debug("### naviSub : " + naviPosSub);
		LOGGER.info("### requestURIAttribute : " + requestURIAttribute);
		request.setAttribute("navi", naviPos);
		request.setAttribute("naviSub", naviPosSub);
		request.setAttribute("naviSubAttr",requestURIAttribute);

		/* 세션 체크 */
		HttpSession session = request.getSession(false);
		boolean validLogin = true;
		// 쇼핑몰 회원 로그인이면 세션을 강제 종료시킨다.
		if (session != null	&& (session.getAttribute("loginType") == null || "C".equals(session.getAttribute("loginType")) || "NC".equals(session.getAttribute("loginType")))) {
			session.invalidate();
			session = null;

			/* 쿠키 초기화 */
			Cookie cookie = new Cookie("loginToken", "");
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);

			validLogin = false;
		}

		LOGGER.info("### 1");
		if ((session == null || session.getAttribute("loginSeq") == null) && validLogin) {
			Cookie[] cookies = request.getCookies();
			UserVo vo = null;
			if (cookies != null) {
				/* 로그인 토큰이 있다면 토큰으로 로그인 정보를 취득한다 */
				UserVo paramVo = new UserVo();
				for (int i = 0; i < cookies.length; i++) {
					if ("loginToken".equals(cookies[i].getName())) {
						paramVo.setLoginToken("" + cookies[i].getValue());
						paramVo.setLastIp(request.getRemoteAddr());
					}
				}
				/* 로그인 토큰 확인 */
				vo = loginService.getDataForToken(paramVo);
			}
			LOGGER.info("### 2");
			/* 유효한 토큰일 경우 */
			if (vo != null) {
				session = request.getSession(true);
				session.setAttribute("loginSeq", vo.getLoginSeq());
				session.setAttribute("loginId", vo.getId());
				session.setAttribute("loginName", vo.getName());
				session.setAttribute("gradeCode", vo.getGradeCode());
				session.setAttribute("loginType", vo.getLoginType()); // 사용자 유형 설정 (관리자)

				/* 재 로그인 정보 로그기록 */
				LOGGER.info("[loginInterceptor seq:id:name:grade:token] " + vo.getLoginSeq() + ":" + vo.getId() + ":" + vo.getName() + ":" + vo.getGradeCode() + ":" + vo.getLoginType());
			}
			LOGGER.debug("### token login result : " + vo);
			LOGGER.debug("### token login result session : " + session);
		}
		LOGGER.info("### 3");
		if (session == null || session.getAttribute("loginSeq") == null) {
			response.sendRedirect("/admin/login?status=expired");
			return false;
		}


		List<MallVo> mallList = mallService.getListSimple();

		if(!session.getAttribute("loginType").equals("A")) {

			List<MallAccessVo> currentAccess = mallAccessService.getVo((Integer) session.getAttribute("loginSeq"));

			List<MallVo> tmpMallList = new ArrayList<MallVo>();

				for (MallVo mall : mallList) {
					if (findMall(mall.getSeq(), currentAccess)) {
						tmpMallList.add(mall);
					}
				}
			request.setAttribute("mallList", tmpMallList);
		}
		else {
			request.setAttribute("mallList", mallList);
		}
		return true;
	}

	private boolean findMall(int mallSeq, List<MallAccessVo>mallAccessVos){
		System.out.println("### findMall mallSeq:"+mallSeq);
		for(MallAccessVo mallacc:mallAccessVos){
			System.out.println("### findMall mallacc.getMallSeq():"+mallacc.getMallSeq());
			if(mallSeq == mallacc.getMallSeq() && mallacc.getAccessStatus().equals("A")) return true;
		}

		return false;
	}

}
