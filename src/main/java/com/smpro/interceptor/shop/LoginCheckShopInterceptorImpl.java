package com.smpro.interceptor.shop;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.net.URLEncoder;
import java.util.Enumeration;

public class LoginCheckShopInterceptorImpl extends HandlerInterceptorAdapter {
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginCheckShopInterceptorImpl.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		LOGGER.debug("interceptor--handler #2:" + handler);
		LOGGER.info("interceptor--catched #2");
	
		
		/*String mallId = "hknuri";
		String[] requestURI = request.getRequestURI().replace("http://","").split("/");
		if(requestURI != null && requestURI.length >= 3) {
			mallId = requestURI[2];
		}*/

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("loginSeq") == null) {
			Enumeration<String> param = request.getParameterNames();
			String strParam = "";
			while (param.hasMoreElements()) {
				String name = param.nextElement();
				String value = request.getParameter(name);
				strParam += name + "=" + value + "&";
			}

			response.sendRedirect("/shop/login?status=expired&returnUrl=" + URLEncoder.encode(request.getRequestURI() + "?" + strParam, "utf-8"));
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
