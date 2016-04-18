package com.smpro.controller.admin;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smpro.vo.MenuVo;
import com.smpro.service.MenuService;
import com.smpro.util.Const;
import com.smpro.util.MenuUtil;

@Controller
public class AboutController {
	@Resource(name = "menuService")
	private MenuService menuService;

	@RequestMapping(value = "/about/menu/list")
	public String getList(Model model) {
		model.addAttribute("list", menuService.getMainList());
		return "/about/menu/list.jsp";
	}


	@RequestMapping(value = "/about/menu/insert", method = RequestMethod.POST)
	public String insert(MenuVo vo, Model model) {
		if("".equals(vo.getName())) {
			model.addAttribute("message", "메뉴명을 입력해 주세요.");
			return Const.ALERT_PAGE;
		}
			
		
		if(!menuService.insertMainVo(vo)) {
			model.addAttribute("message", "메뉴를 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		// html을 재생성한다
		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "메뉴가 등록되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/list");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/about/menu/update", method = RequestMethod.POST)
	public String update(MenuVo vo, Model model) {
		if("".equals(vo.getName())) {
			model.addAttribute("message", "메뉴명을 입력해 주세요.");
			return Const.ALERT_PAGE;
		}
		
		if(!menuService.updateMainVo(vo)) {
			model.addAttribute("message", "메뉴를 수정할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "메뉴가 수정되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/list");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/about/menu/delete")
	public String delete(Integer seq, Model model) {
		if(!menuService.deleteMainVo(seq)) {
			model.addAttribute("message", "메뉴를 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "메뉴가 삭제되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/list");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/about/menu/order")
	public String updateOrder(String seqs, Model model) {
		String[] seqArr = seqs.split(",");
		int length = seqArr.length;
		for(int i=0; i<length; i++) {
			MenuVo vo = new MenuVo();
			vo.setSeq(Integer.valueOf(seqArr[i]));
			vo.setSort(new Integer(length-i));

			menuService.modifyMainOrdering(vo);
		}

		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "순서가 저장 되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/list");
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping("/about/menu/sub/list")
	public String getListSub(Integer mainSeq, Model model) {
		model.addAttribute("list", menuService.getSubList(mainSeq));
		model.addAttribute("vo", menuService.getMainVo(mainSeq));
		return "/about/menu/sub_list.jsp";
	}

	@RequestMapping(value = "/about/menu/sub/insert", method = RequestMethod.POST)
	public String insertSub(MenuVo vo, Model model) {
		if(!menuService.insertSubVo(vo)) {
			model.addAttribute("message", "서브메뉴를 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		// html을 재생성한다
		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "서브메뉴가 등록되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/sub/list?mainSeq=" + vo.getMainSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/about/menu/sub/update", method = RequestMethod.POST)
	public String updateSub(MenuVo vo, Model model) {
		if(!menuService.updateSubVo(vo)) {
			model.addAttribute("message", "서브메뉴를 수정할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "서브메뉴가 수정되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/sub/list?mainSeq=" + vo.getMainSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/about/menu/sub/delete")
	public String deleteSub(Integer seq, Model model) {
		MenuVo vo = menuService.getSubVo(seq);

		if(!menuService.deleteSubVo(seq)) {
			model.addAttribute("message", "서브메뉴를 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "서브메뉴가 삭제되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/sub/list?mainSeq=" + vo.getMainSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/about/menu/sub/order")
	public String updateOrderSub(int mainSeq, String seqs, Model model) {
		String[] seqArr = seqs.split(",");
		int length = seqArr.length;
		for(int i=0; i<length; i++) {
			MenuVo vo = new MenuVo();
			vo.setSeq(Integer.valueOf(seqArr[i]));
			vo.setSort(new Integer(length-i));

			menuService.modifySubOrdering(vo);
		}

		MenuUtil.setMenuAutomatically();

		model.addAttribute("message", "순서가 저장 되었습니다");
		model.addAttribute("returnUrl", "/admin/about/menu/sub/list?mainSeq=" + mainSeq);
		return Const.REDIRECT_PAGE;
	}
}
