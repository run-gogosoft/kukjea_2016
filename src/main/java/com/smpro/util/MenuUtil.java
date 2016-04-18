package com.smpro.util;

import com.smpro.vo.MenuVo;
import com.smpro.service.MenuService;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class MenuUtil {
	private static String mainHTML;
	private static String subHTML;

	/** HTML 조각을 만든다 */
	private static void htmlResolver(boolean forceFlag) {
		if(mainHTML == null || subHTML == null || "".equals(mainHTML) || "".equals(subHTML) || forceFlag) {
			mainHTML = "";
			subHTML = "";
			
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			MenuService menuService = (MenuService)context.getBean("menuService");
			
			List<MenuVo> list = menuService.getMainList();
			for (MenuVo vo : list) {
					// http로 시작하면(외부링크) 새창으로 띄운다
					mainHTML += "<li data-seq=\""+ vo.getSeq() +"\">"+ vo.getName() +"</a></li>";
			}
			for (MenuVo vo : list) {
				subHTML += "<ul data-seq=\""+ vo.getSeq() +"\">";
				List<MenuVo> subList = menuService.getSubList(vo.getSeq());
				for(MenuVo svo : subList) {
					if(svo.getLinkUrl().matches("^(http[s]?):.*")) {
						// http로 시작하면(외부링크) 새창으로 띄운다
						subHTML += "<li><a href=\"" + svo.getLinkUrl() + "\" target='_blank'>" + svo.getName() + "</a></li>";
					} else if("alert".equals(svo.getLinkUrl())) {
						// alert
						subHTML += "<li><a href=\"#\" onclick=\"alert('준비중입니다');return false;\">"+ svo.getName() +"</a></li>";
					} else {
						// 일반적인 링크의 경우
						subHTML += "<li><a href=\""+ svo.getLinkUrl() +"\">"+ svo.getName() +"</a></li>";
					}

				}
				subHTML += "</ul>";
			}

		}
	}

	/** 자동으로 메뉴를 생성하도록 만든다 */
	public static void setMenuAutomatically() {
		htmlResolver(true);
	}

	public static String getMainHTML() {
		htmlResolver(false);
		return mainHTML;
	}

	public static String getSubHTML() {
		htmlResolver(false);
		return subHTML;
	}
}
