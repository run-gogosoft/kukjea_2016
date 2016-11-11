package com.smpro.controller.shop;

import com.smpro.service.CartService;
import com.smpro.service.ItemOptionService;
import com.smpro.service.ItemService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.vo.ItemOptionVo;
import com.smpro.vo.ItemVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class CartController extends MyPage {
	@Autowired
	private CartService cartService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private ItemOptionService itemOptionService;

	public void setItemOptionService(ItemOptionService itemOptionService) {
		this.itemOptionService = itemOptionService;
	}

	@RequestMapping("/cart")
	public String cart(HttpServletRequest request, Model model){
		HttpSession session = request.getSession();

		initMypage(session, model);

		ItemVo vo = new ItemVo();
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}

		List<ItemVo> list = cartService.getList(vo);

		// 즉시구매로 들어온 내역은 지워버린다
		for(int i=0; i<list.size(); i++) {
			if("Y".equals(list.get(i).getDirectFlag())) {
				cartService.deleteVo(list.get(i));
			}
		}

		model.addAttribute("title", "장바구니");
		model.addAttribute("on", "05");

		return "/cart.jsp";
	}

	@RequestMapping("/cart/list/json")
	public String cartList( HttpServletRequest request, Model model){
		HttpSession session = request.getSession();

		ItemVo vo = new ItemVo();
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}

		List<ItemVo> list = cartService.getList(vo);

		model.addAttribute("list", list);

		return "/ajax/get-cart-list.jsp";
	}

	@RequestMapping("/cart/list/count/json")
	public String cartListCount(HttpSession session, Model model) {
		ItemVo vo = new ItemVo();
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}
		vo.setDirectFlag("N");

		model.addAttribute("message", cartService.getListTotalCount(vo));

		return Const.AJAX_PAGE;
	}

	@RequestMapping("/cart/update")
	public String update(ItemVo vo, HttpServletRequest request, Model model) {
		HttpSession session  = request.getSession();

		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}

		if(vo.getCount() == 0) {
			cartService.deleteVo(vo);
		} else {
			cartService.updateVo(vo);
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/cart/add")
	public String add(ItemVo vo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();

		if("C".equals(vo.getTypeCode())) {
			model.addAttribute("callback", "ERROR[5]");
			return Const.ALERT_PAGE;
		}

		if(vo.getCount() <= 0) {
			model.addAttribute("callback", "ERROR[1]");
			return Const.ALERT_PAGE;
		}

		// 존재하지 않는 옵션이거나 보여주지 않기로 한 옵션이라면 ERROR를 출력한다
		ItemOptionVo ivo = itemOptionService.getValueVo(vo.getOptionValueSeq());
		if(ivo == null || !"Y".equals(ivo.getShowFlag())) {
			model.addAttribute("callback", "ERROR[2]");
			return Const.ALERT_PAGE;
		}

		/** 비회원 구매 로직 분기 */
		Integer memberSeq = (Integer)session.getAttribute("loginSeq");
		if(memberSeq == null) {
			//비회원이면 별도 키값을 저장한다.
			if(session.getAttribute("notLoginKey") == null) {
				//키값이 세션에 없으면 새로 생성한다.
				session.setAttribute("notLoginKey", session.getId() + System.currentTimeMillis());
			}
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		} else {
			vo.setMemberSeq(memberSeq);
		}

		ItemVo cvo = new ItemVo();
		cvo.setMemberSeq(memberSeq);
		List<ItemVo> list = cartService.getList(cvo);
		// 장바구니에 동일한 optionValueSeq를 가진 상품이 있는가?
		int duplicatedIdx = -1;
		for(int i=0; i<list.size(); i++) {
			//이제 상품에 대한 배송방법결정을 고객이 할 수도 있으므로 중복 상품에 대한 로직을 수정한다.
			// 고객이 배송비 선결제/착불을 선택 할 수 있는 상품이고 장바구니에 담겨져 있는 상품과 같지만 먼저 담겨진 상품과 선결제/착불이 다를 경우 주문을 insert 진행.
			//TODO: 묶음배송에 관한 로직 추후에 들어 갈 것!!!
			if(ivo.getSeq().equals(list.get(i).getOptionValueSeq()) && vo.getDeliPrepaidFlag().equals(list.get(i).getDeliPrepaidFlag())) {
				duplicatedIdx = i;
			}
		}

		// 장바구니에 20개 이상은 담을 수가 없다 (하지만 이미 담았던 상품이라면 숫자를 증가시킬 것이다)
		if(list.size() > Const.MAX_ORDER_COUNT && duplicatedIdx != -1) {
			model.addAttribute("callback", "SIZE OVER");
			return Const.ALERT_PAGE;
		}

		// 즉시구매로 온 것이 아니기 때문에 플래그를 N으로 지정한다
		vo.setDirectFlag("N");
		if(duplicatedIdx < 0) {
			if(!cartService.insertVo(vo)) {
				model.addAttribute("callback", "ERROR[3]");
				return Const.ALERT_PAGE;
			}
		} else {
			// 숫자를 1 증가시킨다
			list.get(duplicatedIdx).setCount( list.get(duplicatedIdx).getCount()+1 );
			if (!cartService.updateVo(list.get(duplicatedIdx))) {
				model.addAttribute("getcallback", "ERROR[4]");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("callback", "OK");
		return Const.ALERT_PAGE;
	}

	@RequestMapping("/cart/remove")
	public String remove(@RequestParam Integer seq,  HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();

		ItemVo vo = new ItemVo();
		vo.setSeq(seq);

		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}

		if(!cartService.deleteVo(vo)){
			model.addAttribute("message", "ERROR (CODE:3)");
			return Const.AJAX_PAGE;
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	/**
	 * 주문 상세 페이지(프린트용)
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/cart/estimate/view")
	public String myPageOrderView(HttpSession session, String pageType, String cartSeqs, Model model) {
		if("estimate".equals(pageType)) {
			model.addAttribute("title", "견 적 서");
		}

		ItemVo vo = new ItemVo();
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		vo.setCartSeqs(cartSeqs);
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			vo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}

		/* 주문 상품 리스트 */
		model.addAttribute("list", cartService.getList(vo));
		model.addAttribute("nowDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()).toString());
		return "cart_estimate_view.jsp";
	}
}
