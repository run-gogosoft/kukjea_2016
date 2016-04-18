package com.smpro.controller.shop;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.smpro.service.CategoryService;
import com.smpro.service.ItemService;
import com.smpro.service.SystemService;
import com.smpro.vo.CategoryVo;
import com.smpro.vo.CommonVo;
import com.smpro.vo.ItemVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SearchController {
	@Resource(name="categoryService")
	private CategoryService categoryService;

	@Resource(name="itemService")
	private ItemService itemService;

	@Resource(name="systemService")
	private SystemService systemService;

	@RequestMapping("/search")
	public String search(ItemVo vo, HttpSession session, Model model) {
		
		model.addAttribute("title", "search");

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();

		cvo.setDepth(1);
		cvo.setShowFlag("Y");
		model.addAttribute("cateLv1List", categoryService.getListSimple(cvo));

		if(!"".equals(vo.getCateLv1Seq())) {
			// 2단
			cvo.setDepth(2);
			cvo.setShowFlag("Y");
			cvo.setParentSeq(vo.getCateLv1Seq());
			model.addAttribute("cateLv2List", categoryService.getListSimple(cvo));
		}
		if(!"".equals(vo.getCateLv1Seq()) && !"".equals(vo.getCateLv2Seq())) {
			// 3단
			cvo.setDepth(3);
			cvo.setShowFlag("Y");
			cvo.setParentSeq(vo.getCateLv2Seq());
			model.addAttribute("cateLv3List", categoryService.getListSimple(cvo));
		}
		if(!"".equals(vo.getCateLv1Seq()) && !"".equals(vo.getCateLv2Seq()) && !"".equals(vo.getCateLv3Seq())) {
			// 4단
			cvo.setDepth(4);
			cvo.setShowFlag("Y");
			cvo.setParentSeq(vo.getCateLv3Seq());
			model.addAttribute("cateLv4List", categoryService.getListSimple(cvo));
		}

		if(!"".equals(vo.getCateLv1Seq())) {
			CategoryVo lv1 = categoryService.getVo(vo.getCateLv1Seq());
			model.addAttribute("lv1", lv1);
		} else if(!"".equals(vo.getCateLv2Seq())) {
			CategoryVo lv2 = categoryService.getVo(vo.getCateLv2Seq());
			CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());
			model.addAttribute("lv1", lv1);
			model.addAttribute("lv2", lv2);
		} else if(!"".equals(vo.getCateLv3Seq())) {
			CategoryVo lv3 = categoryService.getVo(vo.getCateLv3Seq());
			CategoryVo lv2 = categoryService.getVo(lv3.getParentSeq());
			CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());
			model.addAttribute("lv1", lv1);
			model.addAttribute("lv2", lv2);
			model.addAttribute("lv3", lv3);
		} else if(!"".equals(vo.getCateLv4Seq())) {
			CategoryVo lv4 = categoryService.getVo(vo.getCateLv4Seq());
			CategoryVo lv3 = categoryService.getVo(lv4.getParentSeq());
			CategoryVo lv2 = categoryService.getVo(lv3.getParentSeq());
			CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());
			model.addAttribute("lv1", lv1);
			model.addAttribute("lv2", lv2);
			model.addAttribute("lv3", lv3);
			model.addAttribute("lv4", lv4);
		}
	
		// 카테고리 검색 결과
		if(vo.getRowCount()==20) {
			vo.setRowCount(30);
		}
		
		//자치구 코드가 00이라면 전체라는 의미로 사용하고 값을 초기화시킨다.
		if("00".equals(vo.getJachiguCode())) {
			vo.setJachiguCode("");
		}
				
		vo.setStatusCode("Y"); // 판매가 가능한 리스트만 보여야 한다
		vo.setShowFlag("Y");   //카테고리가 노출
		//함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.
		vo.setMemberTypeCode((String)session.getAttribute("loginMemberTypeCode"));
		model.addAttribute("categoryList", categoryService.getListForSearch(vo));

		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));

		model.addAttribute("list", itemService.getListSimple(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("itemSearchVo", vo);
		
		//자치구 코드
		CommonVo cjvo = new CommonVo();
		cjvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cjvo));
		return "/search/search.jsp";
	}
}
