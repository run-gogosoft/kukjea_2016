package com.smpro.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.DisplayService;
import com.smpro.service.ItemService;
import com.smpro.service.MallService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.CommonVo;
import com.smpro.vo.DisplayLvItemVo;
import com.smpro.vo.DisplayVo;
import com.smpro.vo.ItemVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
	private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);
	
	@Resource(name = "displayService")
	private DisplayService displayService;

	@Resource(name = "systemService")
	private SystemService systemService;

	@Resource(name = "mallService")
	private MallService mallService;

	@Resource(name = "itemService")
	private ItemService itemService;
	
	@CheckGrade(controllerName = "mainController", controllerMethod = "tmpl")
	@RequestMapping("/system/tmpl/list")
	public String tmpl(Model model) {
		model.addAttribute("title", "템플릿 관리");
		
		//회원구분 코드
		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(30));
		model.addAttribute("list", systemService.getCommonList(cvo));
		return "/tmpl/list.jsp";
	}
	
	@CheckGrade(controllerName = "mainController", controllerMethod = "login")
	@RequestMapping("/system/login")
	public String login(ItemVo itemVo, Integer sucSeq, String memberTypeCode, String sucStyleCode, String suclocation, String suctype, Model model) {
		model.addAttribute("title", "로그인 페이지 관리");
		if (suclocation != null && suctype != null) {
			model.addAttribute("suclocation", suclocation);
			model.addAttribute("suctype", suctype);
		}

		if (sucSeq != null && sucStyleCode != null) {
			model.addAttribute("sucSeq", sucSeq);
			model.addAttribute("sucStyleCode", sucStyleCode);
		}

		//회원구분 코드
		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(30));
		model.addAttribute("memberTypeList", systemService.getCommonList(cvo));
		model.addAttribute("memberTypeCode", memberTypeCode);

		/** 검색 관련 */
		model.addAttribute("itemTitle", "판매중인 아이템 목록");
		model.addAttribute("vo", itemVo);
		return "/tmpl/login.jsp";

	}
	
	@CheckGrade(controllerName = "mainController", controllerMethod = "main")
	@RequestMapping("/system/main")
	public String main(ItemVo itemVo, Integer sucSeq, String memberTypeCode, String sucStyleCode, String suclocation, String suctype, Model model) {
		model.addAttribute("title", "메인 페이지 관리");
		if (suclocation != null && suctype != null) {
			model.addAttribute("suclocation", suclocation);
			model.addAttribute("suctype", suctype);
		}

		if (sucSeq != null && sucStyleCode != null) {
			model.addAttribute("sucSeq", sucSeq);
			model.addAttribute("sucStyleCode", sucStyleCode);
		}

		//회원구분 코드
		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(30));
		model.addAttribute("memberTypeList", systemService.getCommonList(cvo));
		model.addAttribute("memberTypeCode", memberTypeCode);

		/** 검색 관련 */
		model.addAttribute("itemTitle", "판매중인 아이템 목록");
		model.addAttribute("vo", itemVo);
		return "/tmpl/mainpage_form.jsp";

	}

	@RequestMapping("/system/tmpl/main/ajax")
	public String getTmplForAjax(DisplayVo vo, Model model) {
		model.addAttribute("vo", displayService.getVo(vo));
		return "/ajax/get-categorydisplay-vo.jsp";
	}

	@RequestMapping("/system/main/reg/proc")
	public String regProc(DisplayVo vo, Model model) {

		if (!displayService.insertHtmlData(vo)) {
			model.addAttribute("message", "내용을 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "등록되었습니다.");
		model.addAttribute("callback", vo.getLocation() + ":" + vo.getTitle()
				+ ":" + vo.getMemberTypeCode());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/system/main/edit/proc")
	public String editProc(DisplayVo vo, Model model) {
		// if(StringUtil.isBlank(vo.getContent().trim())) {
		// model.addAttribute("message", "내용은 반드시 입력되어야 합니다.");
		// return Const.ALERT_PAGE;
		// }

		if (!displayService.updateData(vo)) {
			model.addAttribute("message", "내용을 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "수정되었습니다.");
		model.addAttribute("callback", vo.getLocation() + ":" + vo.getTitle()
				+ ":" + vo.getMemberTypeCode());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/system/tmpl/main/item/list")
	public String getItemListForAjax(ItemVo vo, HttpSession session, Model model) {
		/** 상품목록을 불러옴 */
		vo.setStatusCode("Y");
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		model.addAttribute("list", itemService.getListSimple(vo));
		return "/ajax/get-lv1DisplayItem-list.jsp";
	}

	@RequestMapping("/system/tmpl/main/item/list/paging")
	public String getItemListPagingForAjax(ItemVo vo, HttpSession session, Model model) {
		vo.setStatusCode("Y");
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		model.addAttribute("message", vo.drawPagingNavigation("goPage"));
		return Const.AJAX_PAGE;
	}

	/** 초기 스타일 등록 */
	@RequestMapping("/system/main/style/reg/proc")
	public String regStyle(DisplayLvItemVo vo, Model model) {
		if (StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "제목은 반드시 입력되어야 합니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getTitle().length() > 30) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		if (!displayService.insertDisplayItemData(vo)) {
			model.addAttribute("message", "게시물을 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback",
				vo.getMemberTypeCode() + ":" + vo.getStyleCode());
		return Const.REDIRECT_PAGE;
	}

	/** 스타일 제목 수정 */
	@RequestMapping("/system/main/title/edit/proc")
	public String editTitleProc(DisplayLvItemVo vo, Model model) {
		if (StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "제목은 반드시 입력되어야 합니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getTitle().length() > 30) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		if (!displayService.updateItemListTitleData(vo)) {
			model.addAttribute("message", "게시물을 수정할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute(
				"callback",
				vo.getMemberTypeCode() + ":" + vo.getStyleCode() + ":" + vo.getLv1()
						+ ":" + vo.getLv2() + ":" + vo.getLv3() + ":"
						+ vo.getSearchItemSeq() + ":" + vo.getName());
		model.addAttribute("message", "제목이 수정되었습니다.");
		return Const.REDIRECT_PAGE;
	}

	/** 상품추가 */
	@RequestMapping("/system/main/item/reg/proc")
	public String regItemProc(@RequestParam Integer[] procSeq, DisplayLvItemVo vo, Model model) {
		for (int i = 0; i < procSeq.length; i++) {
			vo.setItemSeq(procSeq[i]);

			if (StringUtil.isBlank(displayService.getItemConfirm(vo))) {
				continue;
			}
			if (!StringUtil.isBlank(displayService.getItemListConfirm(vo))) {
				continue;
			}

			String getOrderNo = displayService.getOrderNoData(vo);
			if (!StringUtil.isBlank(getOrderNo)) {
				vo.setOrderNo(Integer.parseInt(getOrderNo) + 1);
			}else{
				vo.setOrderNo(1);
			}

			if (!displayService.insertData(vo)) {
				model.addAttribute("message", "게시물을 등록할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("callback",
				vo.getMemberTypeCode() + ":" + vo.getStyleCode());
		model.addAttribute("message", "상품이 추가 되었습니다.");
		return Const.REDIRECT_PAGE;
	}

	/** 상품군 정렬방식 수정 */
	@RequestMapping("/system/main/orderno/edit/proc")
	public String editOrderNoProc(Integer[] displaySeq, Integer[] itemSeq,
			String[] orderNo, String memberTypeCode, int styleCode, String lv1,
			String lv2, String lv3, String searchItemSeq, String name,
			Model model) {
		Integer[] getDisplaySeq = displaySeq;
		Integer[] getItemSeq = itemSeq;
		String[] getOrderNo = orderNo;

		DisplayLvItemVo vo = new DisplayLvItemVo();
		if (getItemSeq.length == 0) {
			model.addAttribute("message", "상품이 추가되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		for (int i = 0; i < getOrderNo.length; i++) {
			// if (getOrderNo[i].length() > 1 ) {
			// model.addAttribute("message", "정렬값의 입력길이가 초과되었습니다.");
			// return Const.ALERT_PAGE;
			// }
			if(getOrderNo[i].equals("0")){
				model.addAttribute("message", "정렬순서에 0은 입력할수 없습니다.");
				return Const.ALERT_PAGE;
			}

			if (StringUtil.isBlank(getOrderNo[i])) {
				model.addAttribute("message", "정렬값이 입력되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
		}

		for (int i = 0; i < getDisplaySeq.length; i++) {
			vo.setDisplaySeq(getDisplaySeq[i]);
			vo.setItemSeq(getItemSeq[i]);
			vo.setOrderNo(Integer.parseInt(getOrderNo[i]));
			if (!displayService.updateItemListOrderData(vo)) {
				model.addAttribute("message", "게시물을 수정할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		}
		model.addAttribute("callback", memberTypeCode + ":" + styleCode + ":" + lv1
				+ ":" + lv2 + ":" + lv3 + ":" + searchItemSeq + ":" + name);
		model.addAttribute("message", "정렬순서를 수정 하였습니다.");
		return Const.REDIRECT_PAGE;
	}

	/** 상품 삭제 */
	@RequestMapping("/system/main/item/delete/proc")
	public String delProc(DisplayLvItemVo vo, Model model) {
		// 원래는 seq에 따라 삭제할 수 있는 유저를 판별해야 하지만 어차피 최고 관리자 밖에 쓸 수 없기 때문에 굳이 판별하지 않고
		// 바로 seq를 매칭한다
		LOGGER.info(
				"vo.getStyleCode() --> " + vo.getStyleCode());
		LOGGER.info(
				"vo.getCateSeq() --> " + vo.getCateSeq());

		if (!displayService.deleteData(vo.getSeq())) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute(
				"callback",
				vo.getMemberTypeCode() + ":" + vo.getStyleCode() + ":" + vo.getLv1()
						+ ":" + vo.getLv2() + ":" + vo.getLv3() + ":"
						+ vo.getSearchItemSeq() + ":" + vo.getName());
		return Const.REDIRECT_PAGE;
	}
}
