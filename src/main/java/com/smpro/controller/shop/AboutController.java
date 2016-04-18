package com.smpro.controller.shop;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.FilenameService;
import com.smpro.service.MenuService;
import com.smpro.service.SellerService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.CommonVo;
import com.smpro.vo.SellerVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
public class AboutController {
	@Autowired
	private MenuService menuService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private FilenameService filenameService;

	@RequestMapping("/about/main")
	public String about(Integer seq, Model model) {
		model.addAttribute("title", "about 사회적경제 메인");

		model.addAttribute("menuList", menuService.getMainList());
		model.addAttribute("subList", menuService.getAllSubList());

		String importUrl = "";
		if(StringUtil.isBlank(""+seq)) {
			//최초접속시 하위 리스트 첫번째 정보를 강제한다.
			Integer mainSeq = menuService.getMainList().get(0).getSeq();
			Integer subSeq = menuService.getSubList(mainSeq).get(0).getSeq();
			importUrl = menuService.getSubVo(subSeq).getLinkUrl();
		} else {
			importUrl = menuService.getSubVo(seq).getLinkUrl();
		}

		model.addAttribute("importUrl", importUrl);
		return "/about/main.jsp";
	}

	/** 입점기업 정보 */
	@RequestMapping("/about/seller")
	public String sellerList(SellerVo pvo, Model model) {
		// 인증구분
		if(pvo.getAuthCategory() != null && !"".equals(pvo.getAuthCategory()) ) {
			pvo.setAuthCategoryArr( pvo.getAuthCategory().split(",") );
		}
		pvo.setTypeCode("S"); // 판매자 타입만
		pvo.setStatusCode("Y"); // 정상 입점기업만
		pvo.setTotalRowCount(sellerService.getListCount(pvo));
		model.addAttribute("list", sellerService.getList(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);

		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		model.addAttribute("menuList", menuService.getMainList());
		model.addAttribute("subList", menuService.getAllSubList());

		return "/about/seller.jsp";
	}

	/** 총판/입점업체 신규 등록 폼 */
	@CheckGrade(controllerName = "sellerController", controllerMethod = "getRegForm")
	@RequestMapping("/about/seller/{seq}")
	public String getRegForm(@PathVariable int seq,  Model model) {
		/* 콤보박스 리스트 가져오기 */
		CommonVo cvo = new CommonVo();
		// 회원 등급
		cvo.setGroupCode(new Integer(8));
		model.addAttribute("gradeList", systemService.getCommonList(cvo));
		//자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));

		/* 입점업체 상세 정보 */
		SellerVo vo;
		try {
			vo = sellerService.getData(new Integer(seq));
		} catch (Exception e) {
			model.addAttribute("message", "입점업체 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("deliCompanyList", systemService.getDeliCompany());
		model.addAttribute("vo", vo);


		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "seller");
		map.put("parentSeq", new Integer(seq));
		model.addAttribute("file", filenameService.getList(map));
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));

		return "/about/seller_view.jsp";
	}
}
