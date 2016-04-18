package com.smpro.interceptor.shop;

import com.smpro.service.MallService;
import com.smpro.service.MenuService;
import com.smpro.service.SystemService;
import com.smpro.vo.MallVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.net.URLEncoder;

public class MallCheckInterceptor extends HandlerInterceptorAdapter {
	private static final Logger LOGGER = LoggerFactory.getLogger(MallCheckInterceptor.class);
	
	@Autowired
	private MallService mallService;
	public void setMallService(MallService mallService) {
		this.mallService = mallService;
	}
	
	@Resource(name = "menuService")
	private MenuService menuService;

	@Autowired
	private SystemService systemService;
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		LOGGER.debug("interceptor--handler #1:" + handler);
		LOGGER.info("interceptor--catched #1");
		response.addHeader("Progma", "No-cache");
		response.addHeader("Cache-Control", "no-cache");
		response.addHeader("Cache-Control", "no-store"); // 일부 파이어폭스 버그 관련
		response.addHeader("X-UA-Compatible", "IE=Edge");
//		response.setHeader("Pragma", "no-cache");
//		response.setHeader("Expires", "-1"); // 일부 파이어폭스 버그 관련
		LOGGER.info("### requestURI : " + request.getRequestURI());
		
		String[] requestURI = request.getRequestURI().replace("http://","").split("/");
		String mallId = "";
		String errMsg = "";
		/* URL내 mall id를 추출하여 접속 가능 여부를 체크한다. */
		if((requestURI != null && requestURI.length >=3)) {
			mallId = requestURI[2];
			if(
				"back".equals(mallId) ||
				"addr".equals(mallId)
			) {
				//몰과 상관없이 공통적으로 쓰는 페이지는 skip
				return true;
			} 
			mallId = "hknuri";
			MallVo vo = mallService.getMainInfo(mallId);
			if(vo == null) {
				errMsg = "존재하지 않는 쇼핑몰 접근입니다.";
			} else {
				if("Y".equals(vo.getStatusCode())) {
					request.setAttribute("mallVo",vo);
					return true;
				} else if("H".equals(vo.getStatusCode())) {
					errMsg = "현재 오픈 대기중인 쇼핑몰 입니다.";
				} else if("N".equals(vo.getStatusCode())) {
					errMsg = "현재 사용 중지된 쇼핑몰 입니다.";
				} else if("X".equals(vo.getStatusCode())) {
					errMsg = "해당 쇼핑몰은 폐쇄되었습니다.";
				}
			}
		}

		response.sendRedirect("/shop/back?message="+ URLEncoder.encode(errMsg,"utf-8"));
		return false;
	}

	/*public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		//To change body of implemented methods use File | Settings | File Templates.
	}

	public void afterHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		//To change body of implemented methods use File | Settings | File Templates.
	}*/

}
