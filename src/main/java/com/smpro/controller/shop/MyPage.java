package com.smpro.controller.shop;

import com.smpro.service.OrderService;
import com.smpro.service.PointService;
import com.smpro.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;

@Component
public abstract class MyPage {
	@Autowired
	private OrderService orderService;

	@Autowired
	private PointService pointService;
	/**
	 * 마이페이지 좌측 메뉴의 기본값을 설정한다
	 * @param session
	 * @param model
	 */
	protected void initMypage(HttpSession session, Model model) {
		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		String loginType = (String)session.getAttribute("loginType");

		/** 주문확정된 총 주문금액을 표시한다. */
		model.addAttribute("totalOrderFinishPrice", orderService.getTotalOrderFinishPrice(loginSeq));

		/** 구매확정된 총 주문갯수를 표시한다. */
		OrderVo ovo = new OrderVo();
		ovo.setLoginSeq(loginSeq);
		ovo.setLoginType(loginType);
		ovo.setStatusCode("55");
		model.addAttribute("totalOrderCnt", new Integer(orderService.getListCount(ovo)));

		/** 사용가능 포인트 표시. */
		Integer useablePoint = pointService.getUseablePoint(loginSeq);
		model.addAttribute("availablePoint", useablePoint == null ? new Integer(0) : useablePoint);
	}
}
