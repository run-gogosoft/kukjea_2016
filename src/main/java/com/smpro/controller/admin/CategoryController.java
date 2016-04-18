package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.CategoryService;
import com.smpro.service.MallService;
import com.smpro.util.Const;
import com.smpro.vo.CategoryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private MallService mallService;

	@CheckGrade(controllerName = "categoryController", controllerMethod = "getList")
	@RequestMapping("/category")
	public String getList(Model model) {
		// 몰 리스트
		model.addAttribute("mallList", mallService.getListSimple());
		return "/category/list.jsp";
	}

	@RequestMapping("/category/list/simple/ajax")
	public String getListSimpleForAjax(CategoryVo vo, Model model) {
		// todo : 사용자가 카테고리를 리스트를 읽을 권한이 있는지 검사해야 한다
		model.addAttribute("list", categoryService.getListSimple(vo));
		return "/ajax/get-category-list.jsp";
	}

	@RequestMapping("/category/list/ajax")
	public String getListForAjax(CategoryVo vo, Model model) {
		
		List<CategoryVo> list = categoryService.getList(vo);

		model.addAttribute("list", list);
		return "/ajax/get-category-list.jsp";
	}

	@RequestMapping("/category/vo/ajax")
	public String getVoForAjax(@RequestParam Integer seq, Model model) {
		// todo : 사용자가 카테고리를 vo를 읽을 권한이 있는지 검사해야 한다

		model.addAttribute("item", categoryService.getVo(seq));
		return "/ajax/get-category-vo.jsp";
	}

	@RequestMapping("/category/new")
	public String insert(CategoryVo vo, Model model) {
		// todo : 사용자가 카테고리를 삽입할 권한이 있는지 검사해야 한다

		if ("".equals(vo.getName().trim())) {
			model.addAttribute("message", "카테고리명이 입력되지 않았습니다");
			return Const.ALERT_PAGE;
		}

		if (vo.getDepth() < 1) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.ALERT_PAGE;
		}

		if (!categoryService.insertVo(vo)) {
			model.addAttribute("message", "등록에 실패했습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("callback", vo.getDepth() + ":" + vo.getParentSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/category/update")
	public String update(CategoryVo vo, Model model) {
		// todo : 사용자가 카테고리를 수정할 권한이 있는지 검사해야 한다

		if ("".equals(vo.getName().trim())) {
			model.addAttribute("message", "카테고리명이 입력되지 않았습니다");
			return Const.ALERT_PAGE;
		}

		if (vo.getDepth() < 1) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.ALERT_PAGE;
		}

		if (!categoryService.updateVo(vo)) {
			model.addAttribute("message", "등록에 실패했습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback", vo.getDepth() + ":" + vo.getParentSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/category/delete")
	public String delete(@RequestParam Integer seq, Model model)
			throws Exception {
		// todo : 사용자가 카테고리를 수정할 권한이 있는지 검사해야 한다

		// 이미 삭제되었는지 검사
		CategoryVo vo = categoryService.getVo(seq);
		if (vo == null) {
			model.addAttribute("message", "이미 삭제된 카테고리입니다");
			return Const.ALERT_PAGE;
		}

		if (!categoryService.deleteVo(seq)) {
			model.addAttribute("message", "삭제에 실패했습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback", vo.getDepth() + ":" + vo.getParentSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/category/update/order")
	public String updateOrder(CategoryVo vo, Model model) {
		// todo : 사용자가 카테고리를 수정할 권한이 있는지 검사해야 한다

		if (vo.getSeq() == null || vo.getOrderNo() < 0) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.AJAX_PAGE;
		}

		if (!categoryService.updateOrderNo(vo)) {
			model.addAttribute("message", "업데이트에 실패했습니다");
			return Const.AJAX_PAGE;
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/category/create/js")
	public String createJs(Model model) {
		// js 파일을 생성한다, 몰별로 파일을 만들기 위해 mallSeq를 넘긴다.
		try {
			categoryService.createJs(Const.UPLOAD_REAL_PATH + "/menuJson.js");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "오류가 발생해서 해당 내용을 적용할 수 없었습니다.");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("message", "변경 내역이 쇼핑몰에 적용되었습니다.");
		model.addAttribute("returnUrl", "/admin/category");
		return Const.REDIRECT_PAGE;
	}
}
