package com.smpro.interceptor.shop;

import com.smpro.service.*;
import com.smpro.vo.BoardVo;
import com.smpro.vo.ItemVo;
import com.smpro.vo.MallVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@Slf4j
@Component
public class MallCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private MallService mallService;
	
	@Autowired
	private MenuService menuService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private CartService cartService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.debug("interceptor--handler #1:" + handler);
		log.info("interceptor--catched #1");
		log.debug("mallSeq:"+request.getAttribute("mallSeq"));
		response.addHeader("Progma", "No-cache");
		response.addHeader("Cache-Control", "no-cache");
		response.addHeader("Cache-Control", "no-store"); // 일부 파이어폭스 버그 관련
		response.addHeader("X-UA-Compatible", "IE=Edge");
//		response.setHeader("Pragma", "no-cache");
//		response.setHeader("Expires", "-1"); // 일부 파이어폭스 버그 관련
		log.info("### requestURI : " + request.getRequestURI());
		log.info("### mallId:"+ request.getParameter("mallSeq"));


		HttpSession session = request.getSession(true);

		//mall정보
		request.setAttribute("mallList",mallService.getListSimple());

		//공지사항
		BoardVo boardVo = new BoardVo();
		boardVo.setCategoryCode(new Integer(1));
		boardVo.setGroupCode("notice");
		boardVo.setRowCount(4);
		boardVo.setTotalRowCount( boardService.getListCount(boardVo) );
		request.setAttribute("noticeList",boardService.getList(boardVo));

		MallVo banner = mallService.getVo(2);
		request.setAttribute("banner", banner);
		//장바구니 카운트
		ItemVo itemVo = new ItemVo();

		itemVo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		request.setAttribute("cartCount", cartService.getListTotalCount(itemVo));
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

			int mallSeq = 1;
			if(session.getAttribute("mallSeq")!=null) {
				mallSeq = (Integer)session.getAttribute("mallSeq");
			}
			System.out.println("#### mallSeq:"+mallSeq);
			session.setAttribute("mallSeq", mallSeq);

			MallVo vo = mallService.getVo(mallSeq);
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
