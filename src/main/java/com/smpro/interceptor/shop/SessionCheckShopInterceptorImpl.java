package com.smpro.interceptor.shop;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.Enumeration;

@Slf4j
@Component
public class SessionCheckShopInterceptorImpl extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.debug("interceptor--handler #3:" + handler);
		log.info("interceptor--catched #3");
	
		HttpSession session = request.getSession(false);

		//쇼핑몰 회원 로그인이 아니면 세션을 강제 종료한다.
		//if(session != null && (!"C".equals(session.getAttribute("loginType")) || !mallId.equals(session.getAttribute("mallId")))) {
		if( (session != null && session.getAttribute("loginType") != null) && ( !"C".equals(session.getAttribute("loginType")) && !"NC".equals(session.getAttribute("loginType")) ) ) {
			session.invalidate();
			session = null;
			Enumeration<String> param = request.getParameterNames();
			String strParam = "";
			while (param.hasMoreElements()) {
				String name = param.nextElement();
				String value = request.getParameter(name);
				strParam += name + "=" + value + "&";
			}
			response.sendRedirect(request.getRequestURI() + "?" + URLEncoder.encode(strParam, "utf-8"));
			return false;
		}

		return true;
	}

	/*public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//To change body of implemented methods use File | Settings | File Templates.
	}

	public void afterHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//To change body of implemented methods use File | Settings | File Templates.
	}*/
}
