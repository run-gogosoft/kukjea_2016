package com.smpro.controller.shop;

import com.smpro.service.MemberDeliveryService;
import com.smpro.service.OrderService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.MemberDeliveryVo;
import com.smpro.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MyPageDeliveryController extends MyPage {
	@Autowired
	private MemberDeliveryService memberDeliveryService;

	@Autowired
	private OrderService orderService;

	/** 배송지 리스트 */
	@RequestMapping("/mypage/delivery/list")
	public String getDeliveryList(HttpSession session, Model model, OrderVo pvo) {
		initMypage(session, model);

		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		MemberDeliveryVo vo = new MemberDeliveryVo();
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		List<MemberDeliveryVo> list;
		try {
			list = memberDeliveryService.getList(vo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("list", list);
		model.addAttribute("data", orderService.getCntByStatus(pvo));


		model.addAttribute("title", "배송지 관리");
		model.addAttribute("on", "02");
		return "/mypage/delivery_list.jsp";
	}

	/** 배송지 등록 폼 */
	@RequestMapping("/mypage/delivery/reg")
	public String getDeliveryRegForm(HttpSession session, Model model) {
		initMypage(session, model);
		model.addAttribute("title", "배송지 관리");
		model.addAttribute("on", "02");
		return "/mypage/delivery_form.jsp";
	}

	/** 배송지 등록 처리 */
	@RequestMapping(value="/mypage/delivery/reg/proc", method=RequestMethod.POST)
	public String regDeliveryData(HttpSession session, MemberDeliveryVo vo, Model model) {


		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		vo.setMemberSeq(loginSeq);

		/* 유효성 검사 */
		if(StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "이름을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "제목을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getCell1()) || StringUtil.isBlank(vo.getCell2()) || StringUtil.isBlank(vo.getCell3())) {
			model.addAttribute("message", "핸드폰 번호를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getTel1()) || StringUtil.isBlank(vo.getTel2()) || StringUtil.isBlank(vo.getTel3())) {
			model.addAttribute("message", "전화 번호를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getPostcode())) {
			model.addAttribute("message", "우편 번호를 입력해주세요..");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getAddr1()) || StringUtil.isBlank(vo.getAddr2())) {
			model.addAttribute("message", "주소를 입력해주세요");
			return Const.ALERT_PAGE;
		}

		try {
			if(memberDeliveryService.regData(vo)) {
				model.addAttribute("message", "등록되었습니다.");
				model.addAttribute("returnUrl", "/shop/mypage/delivery/list");
				return Const.REDIRECT_PAGE;
			}

			model.addAttribute("message", "오류가 발생했습니다.");
			return Const.ALERT_PAGE;
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 암호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
	}

	/** 배송지 수정 폼 */
	@RequestMapping("/mypage/delivery/mod/{seq}")
	public String getDeliveryModForm(HttpSession session, @PathVariable Integer seq, Model model) {
		initMypage(session, model);
		MemberDeliveryVo dvo;
		try {
			dvo = memberDeliveryService.getData(seq);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("vo", dvo);
		model.addAttribute("title", "배송지 관리");
		model.addAttribute("on", "02");
		return "/mypage/delivery_form.jsp";
	}

	/** 배송지 수정 처리 */
	@RequestMapping(value="/mypage/delivery/mod/{seq}/proc", method=RequestMethod.POST)
	public String regDeliveryData(@PathVariable Integer seq, HttpSession session, MemberDeliveryVo vo, Model model) {


		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		vo.setSeq(seq);
		vo.setMemberSeq(loginSeq);

		/* 유효성 검사 */
		if(StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "이름을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "제목을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getCell1()) || StringUtil.isBlank(vo.getCell2()) || StringUtil.isBlank(vo.getCell3())) {
			model.addAttribute("message", "핸드폰 번호를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getTel1()) || StringUtil.isBlank(vo.getTel2()) || StringUtil.isBlank(vo.getTel3())) {
			model.addAttribute("message", "전화 번호를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getPostcode())) {
			model.addAttribute("message", "우편 번호를 입력해주세요..");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getAddr1()) || StringUtil.isBlank(vo.getAddr2())) {
			model.addAttribute("message", "주소를 입력해주세요");
			return Const.ALERT_PAGE;
		}

		try {
			if(memberDeliveryService.modData(vo)) {
				model.addAttribute("message", "수정되었습니다.");
				model.addAttribute("returnUrl", "/shop/mypage/delivery/list");
				return Const.REDIRECT_PAGE;
			}

			model.addAttribute("message", "오류가 발생했습니다.");
			return Const.ALERT_PAGE;

		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 암호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
	}

	/** 배송지 삭제 처리 */
	@RequestMapping("/mypage/delivery/del/{seq}/proc")
	public String delDeliveryData(@PathVariable Integer seq, MemberDeliveryVo vo, HttpSession session, Model model) {


		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		vo.setSeq(seq);
		vo.setMemberSeq(loginSeq);

		if(memberDeliveryService.delData(vo)) {
			model.addAttribute("message", "삭제되었습니다.");
			model.addAttribute("returnUrl", "/shop/mypage/delivery/list");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "오류가 발생했습니다.");
		return Const.ALERT_PAGE;
	}

	/**
	 * 배송지 내역을 json 형태로 반환하는 메서드
	 * 반드시 내 로그인 시퀀스만 반환하여야 한다
	 *
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/mypage/delivery/list/json")
	public String getList(MemberDeliveryVo vo, HttpSession session, Model model) {
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));

		List<MemberDeliveryVo> list;
		try {
			list = memberDeliveryService.getList(vo);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		for(int i=0;i<list.size();i++){
			MemberDeliveryVo tmpVo = list.get(i);
			//전화번호 자르기
			if(!StringUtil.isBlank(tmpVo.getTel())) {
				String[] tmp = tmpVo.getTel().split("-");
				if(tmp.length == 3) {
					tmpVo.setTel1(tmp[0]);
					tmpVo.setTel2(tmp[1]);
					tmpVo.setTel3(tmp[2]);
				}
			}
			if(!StringUtil.isBlank(tmpVo.getCell())) {
				String[] tmp = tmpVo.getCell().split("-");
				if(tmp.length == 3) {
					tmpVo.setCell1(tmp[0]);
					tmpVo.setCell2(tmp[1]);
					tmpVo.setCell3(tmp[2]);
				}
			}
		}
		model.addAttribute("list", list);
		return "/ajax/get-delivery-list.jsp";
	}
}
