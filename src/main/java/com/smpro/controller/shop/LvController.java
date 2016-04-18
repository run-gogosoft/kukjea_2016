package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import java.util.List;

@Controller
public class LvController {
	//private static final Logger LOGGER = LoggerFactory.getLogger(LvController.class);
	
	@Resource(name="categoryService")
	private CategoryService categoryService;

	@Resource(name="displayService")
	private DisplayService displayService;

	@Resource(name="systemService")
	private SystemService systemService;

	@Resource(name="itemService")
	private ItemService itemService;

	@Resource(name="mallService")
	private MallService mallService;

	@Resource(name="memberService")
	private MemberService memberService;
	
	@RequestMapping("/lv1/{seq}")
	public String lv1(@PathVariable Integer seq, String anchor, ItemVo vo, HttpSession session, Model model) {
		model.addAttribute("title", "Home");
		model.addAttribute("anchor", anchor);
		
		String loginType = (String)session.getAttribute("loginType");
		String memberTypeCode = (String)session.getAttribute("loginMemberTypeCode");
		
		//회원이면 회원의 멤버구분을, 비회원이면 무조건 회원으로 강제한다.
		if(memberTypeCode == null) {
			memberTypeCode = "C";
		}
		
		DisplayVo dvo = new DisplayVo();
		dvo.setLocation("sub");
		dvo.setCateSeq(seq);
		//공용이라면 공통 템플릿, 아니라면 개별 템플릿을 가져온다.
		dvo.setMemberTypeCode(memberTypeCode);

		dvo.setTitle("titleBanner");
		model.addAttribute("titleBanner", displayService.getVo(dvo) ==null ? null : displayService.getVo(dvo).getContent());

		dvo.setTitle("Banner");
		model.addAttribute("banner", displayService.getVo(dvo) ==null ? null : displayService.getVo(dvo).getContent());

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();
		cvo.setDepth(1);
		cvo.setShowFlag("Y");

		model.addAttribute("cateLv1List", categoryService.getListSimple(cvo));

		if(seq != null) {
			// 2단
			cvo.setDepth(2);
			cvo.setShowFlag("Y");
			cvo.setParentSeq(seq);
			model.addAttribute("cateLv2List", categoryService.getListSimple(cvo));
		}
		// 카테고리 정보
		model.addAttribute("vo", categoryService.getVo(seq));

		/** 상단 배너영역 상품 리스트 */
		DisplayLvItemVo paramVo = new DisplayLvItemVo();
		paramVo.setCateSeq(seq);
		paramVo.setMemberTypeCode(memberTypeCode);
		paramVo.setStatusFlag("Y");
		
		//상품리스트1		
		paramVo.setStyleCode(new Integer(1));
		DisplayLvItemVo dvo1 = displayService.getLvTitle(paramVo);
		model.addAttribute("gallery1_title", dvo1==null ? null : dvo1.getListTitle());
		model.addAttribute("gallery1", dvo1==null ? null : displayService.getLvItemList(paramVo));

		//상품리스트2
		paramVo.setStyleCode(new Integer(2));
		DisplayLvItemVo dvo2 = displayService.getLvTitle(paramVo);
		model.addAttribute("gallery2_title", dvo2==null ? null : dvo2.getListTitle());
		model.addAttribute("gallery2", dvo2==null ? null : displayService.getLvItemList(paramVo));

		//상품리스트2
		paramVo.setStyleCode(new Integer(3));
		DisplayLvItemVo dvo3 = displayService.getLvTitle(paramVo);
		model.addAttribute("gallery3_title", dvo3==null ? null : dvo3.getListTitle());
		model.addAttribute("gallery3", dvo3==null ? null : displayService.getLvItemList(paramVo));

		/* 하단 카테고리 상품 리스트 */
		vo.setLoginType(loginType);
		vo.setMemberTypeCode(memberTypeCode);
		vo.setCateLv1Seq(seq);
		vo.setStatusCode("Y");
		vo.setRowCount(15);
		vo.setPageCount(5);
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		model.addAttribute("list", itemService.getListSimple(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		return "/category/lv1.jsp";
	}
	
	@RequestMapping("/lv2/{seq}")
	public String lv2(@PathVariable Integer seq, ItemVo vo, Model model) {
		model.addAttribute("title", "Home");
		
		vo.setName(vo.getName().replace(",",""));

		Integer tempLv2 = vo.getCateLv2Seq();

		CategoryVo lv2 = null;
		if(vo.getCateLv2Seq() != null) {
			lv2 = categoryService.getVo(vo.getCateLv2Seq());
		} else {
			lv2 = categoryService.getVo(seq);
		}
		CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());

		model.addAttribute("lv1", lv1);
		model.addAttribute("lv2", lv2);
		vo.setCateLv1Seq(lv1.getSeq());
		vo.setCateLv2Seq(tempLv2 == null ? seq : tempLv2);

		/** 상품명으로 검색시 대소문자 구분을 없애기 위해 소문자로만 검색을 한다. */
		if(!"".equals(vo.getName())){
			vo.setName(vo.getName().toLowerCase());
		}
		vo.setStatusCode("Y"); // 판매가 가능한 리스트만 보여야 한다
		
		if(vo.getRowCount()==20) {
			vo.setRowCount(30);
		}
		
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		List<ItemVo> list = itemService.getListSimple(vo);
		for(int i=0;i<list.size();i++){
			ItemVo tmpVo = list.get(i);
			tmpVo.setName(StringUtil.cutString(tmpVo.getName(),140));
		}

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

		model.addAttribute("list", list);
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		vo.setSeq(seq);
		vo.setName("");
		model.addAttribute("vo", vo);

		return "/category/lv2.jsp";
	}

	@RequestMapping("/lv3/{seq}")
	public String lv3(@PathVariable Integer seq, ItemVo vo, Model model) {
		model.addAttribute("title", "Home");
		

		vo.setName(vo.getName().replace(",",""));

		Integer tempLv3 = vo.getCateLv3Seq();
		CategoryVo lv3 = new CategoryVo();

		if(!"".equals(vo.getCateLv3Seq())) {
			lv3 = categoryService.getVo(vo.getCateLv3Seq());
		} else {
			lv3 = categoryService.getVo(seq);
		}
		CategoryVo lv2 = categoryService.getVo(lv3.getParentSeq());
		CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());

		model.addAttribute("lv1", lv1);
		model.addAttribute("lv2", lv2);
		model.addAttribute("lv3", lv3);
		vo.setCateLv1Seq(lv1.getSeq());
		vo.setCateLv2Seq(lv2.getSeq());
		vo.setCateLv3Seq(tempLv3 == null ? seq : tempLv3);

		/** 상품명으로 검색시 대소문자 구분을 없애기 위해 소문자로만 검색을 한다. */
		if(!"".equals(vo.getName())){
			vo.setName(vo.getName().toLowerCase());
		}
		vo.setStatusCode("Y"); // 판매가 가능한 리스트만 보여야 한다
		
		if(vo.getRowCount()==20) {
			vo.setRowCount(30);
		}
		
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));

		List<ItemVo> list = itemService.getListSimple(vo);
		for(int i=0;i<list.size();i++){
			ItemVo tmpVo = list.get(i);
			tmpVo.setName(StringUtil.cutString(tmpVo.getName(),140));
		}

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
		model.addAttribute("list", list);
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		vo.setName("");
		model.addAttribute("vo", vo);

		return "/category/lv3.jsp";
	}

	@RequestMapping("/lv4/{seq}")
	public String lv4(@PathVariable Integer seq, ItemVo vo, Model model) {
		model.addAttribute("title", "Home");
		

		vo.setName(vo.getName().replace(",",""));

		Integer tempLv4 = vo.getCateLv4Seq();
		CategoryVo lv4 = null;

		if(vo.getCateLv4Seq() != null) {
			lv4 = categoryService.getVo(vo.getCateLv4Seq());
		} else {
			lv4 = categoryService.getVo(seq);
		}

		CategoryVo lv3 = categoryService.getVo(lv4.getParentSeq());
		CategoryVo lv2 = categoryService.getVo(lv3.getParentSeq());
		CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());

		model.addAttribute("lv1", lv1);
		model.addAttribute("lv2", lv2);
		model.addAttribute("lv3", lv3);
		model.addAttribute("lv4", lv4);
		vo.setCateLv1Seq(lv1.getSeq());
		vo.setCateLv2Seq(lv2.getSeq());
		vo.setCateLv3Seq(lv3.getSeq());
		vo.setCateLv4Seq(tempLv4 == null ? seq : tempLv4);

		/** 상품명으로 검색시 대소문자 구분을 없애기 위해 소문자로만 검색을 한다. */
		if(!"".equals(vo.getName())){
			vo.setName(vo.getName().toLowerCase());
		}
		vo.setStatusCode("Y"); // 판매가 가능한 리스트만 보여야 한다
		
		if(vo.getRowCount()==20) {
			vo.setRowCount(30);
		}
		
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		List<ItemVo> list = itemService.getListSimple(vo);
		for(int i=0;i<list.size();i++){
			ItemVo tmpVo = list.get(i);
			tmpVo.setName(StringUtil.cutString(tmpVo.getName(),140));
		}

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
		model.addAttribute("list", list);
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		vo.setName("");
		model.addAttribute("vo", vo);

		return "/category/lv4.jsp";
	}
	
	@RequestMapping("/jachigu/{jachiguCode}")
	public String jachigu(@PathVariable String jachiguCode, ItemVo vo, HttpSession session, Model model) {
		model.addAttribute("title", "Home");
		model.addAttribute("loginJachiGuCode", session.getAttribute("loginJachiGuCode"));
		vo.setName(vo.getName().replace(",",""));
		

		/** 상품명으로 검색시 대소문자 구분을 없애기 위해 소문자로만 검색을 한다. */
		if(!"".equals(vo.getName())){
			vo.setName(vo.getName().toLowerCase());
		}
		vo.setStatusCode("Y"); // 판매가 가능한 리스트만 보여야 한다
		
		if(vo.getRowCount()==20) {
			vo.setRowCount(30);
		}
		
		vo.setJachiguCode(jachiguCode);
		//자치구 코드가 00이라면 전체라는 의미로 사용하고 값을 초기화시킨다.
		if("00".equals(jachiguCode)) {
			vo.setJachiguCode("");
		}
		 
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		List<ItemVo> list = itemService.getListSimple(vo);
		for(int i=0;i<list.size();i++){
			ItemVo tmpVo = list.get(i);
			tmpVo.setName(StringUtil.cutString(tmpVo.getName(),140));
		}

		model.addAttribute("list", list);
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		vo.setName("");
		model.addAttribute("vo", vo);
		
		//자치구 코드
		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		return "/category/jachigu_list.jsp";
	}
}
