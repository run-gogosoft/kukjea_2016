package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LvController {
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private DisplayService displayService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private MallService mallService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;

	@RequestMapping("/lv1/{seq}")
	public String lv1(
			@PathVariable Integer seq, HttpServletRequest request,
			ItemVo vo, HttpSession session, Model model) {
		String loginType = (String)session.getAttribute("loginType");
		String memberTypeCode = (String)session.getAttribute("loginMemberTypeCode");
		if(session.getAttribute("loginSeq") == null && session.getAttribute("loginEmail") == null) {

			model.addAttribute("message", "로그인 후 이용하시기 바랍니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		}

		//회원이면 회원의 멤버구분을, 비회원이면 무조건 회원으로 강제한다.
		if(memberTypeCode == null) {
			memberTypeCode = "C";
		}

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();
		cvo.setMallId((Integer)session.getAttribute("mallSeq"));
		cvo.setDepth(1);
		cvo.setShowFlag("Y");
		cvo.setMallId((Integer)session.getAttribute("mallSeq"));
		model.addAttribute("cateLv1List", categoryService.getListSimple(cvo));

		if(seq != null) {
			// 2단
			cvo.setDepth(2);
			cvo.setShowFlag("Y");
			cvo.setParentSeq(seq);
			model.addAttribute("cateLv2List", categoryService.getListSimple(cvo));
		}
		// 카테고리 정보
		CategoryVo mainVo = categoryService.getVo(seq);

		/* 하단 카테고리 상품 리스트 */
		vo.setLoginType(loginType);
		vo.setMemberTypeCode(memberTypeCode);
		vo.setCateLv1Seq(seq);
		vo.setStatusCode("Y");
		vo.setMallId((Integer)session.getAttribute("mallSeq"));
		if(request.getParameter("rowCount") == null || "".equals(request.getParameter("rowCount").trim())) {
			vo.setRowCount(vo.getRowCount());
		}
		if(request.getParameter("listStyle") == null || "".equals(request.getParameter("listStyle").trim())) {
			vo.setListStyle(vo.getListStyle());
		}
		vo.setSeq(null); // 이래야 검색이 제대로 된다
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));

		model.addAttribute("list", itemService.getListSimple(vo));
		vo.setSeq(seq);

		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		model.addAttribute("lv1", mainVo);
		if(mainVo != null) model.addAttribute("title", mainVo.getName());
		return "/category/lv1.jsp";
	}

	@RequestMapping("/lv2/{seq}")
	public String lv2(
			@PathVariable Integer seq, HttpServletRequest request,
			ItemVo vo, HttpSession session, Model model) {

		if(session.getAttribute("loginSeq") == null && session.getAttribute("loginEmail") == null) {
			model.addAttribute("message", "로그인 후 이용하시기 바랍니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		}

		String loginType = (String)session.getAttribute("loginType");
		String memberTypeCode = (String)session.getAttribute("loginMemberTypeCode");

		//회원이면 회원의 멤버구분을, 비회원이면 무조건 회원으로 강제한다.
		if(memberTypeCode == null) {
			memberTypeCode = "C";
		}

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();
		cvo.setDepth(1);
		cvo.setShowFlag("Y");
		cvo.setMallId((Integer)session.getAttribute("mallSeq"));
		model.addAttribute("cateLv1List", categoryService.getListSimple(cvo));

		// 카테고리 정보
		CategoryVo lv2 = categoryService.getVo(seq);
		CategoryVo lv1 = categoryService.getVo(lv2.getParentSeq());

		if(seq != null) {
			// 2단
			cvo.setDepth(2);
			cvo.setShowFlag("Y");
			cvo.setParentSeq( lv2.getParentSeq() );
			model.addAttribute("cateLv2List", categoryService.getListSimple(cvo));
		}

		/* 하단 카테고리 상품 리스트 */
		vo.setLoginType(loginType);
		vo.setMemberTypeCode(memberTypeCode);
		vo.setCateLv2Seq(seq);
		vo.setStatusCode("Y");
		if(request.getParameter("rowCount") == null || "".equals(request.getParameter("rowCount").trim())) {
			vo.setRowCount(vo.getRowCount());
		}
		if(request.getParameter("listStyle") == null || "".equals(request.getParameter("listStyle").trim())) {
			vo.setListStyle(vo.getListStyle());
		}

		vo.setSeq(null); // 이래야 검색이 제대로 된다
		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));

		model.addAttribute("list", itemService.getListSimple(vo));
		vo.setSeq(seq);

		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		model.addAttribute("lv1", lv1);
		model.addAttribute("lv2", lv2);
		model.addAttribute("title", lv2.getName());
		return "/category/lv1.jsp";
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

//		if(vo.getRowCount()==20) {
//			vo.setRowCount(30);
//		}

		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));

		List<ItemVo> list = itemService.getListSimple(vo);
		for(ItemVo tmpVo:list){
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

//		if(vo.getRowCount()==20) {
//			vo.setRowCount(30);
//		}

		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		List<ItemVo> list = itemService.getListSimple(vo);
		for(ItemVo tmpVo:list){
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

//		if(vo.getRowCount()==20) {
//			vo.setRowCount(30);
//		}

		vo.setJachiguCode(jachiguCode);
		//자치구 코드가 00이라면 전체라는 의미로 사용하고 값을 초기화시킨다.
		if("00".equals(jachiguCode)) {
			vo.setJachiguCode("");
		}

		vo.setTotalRowCount(itemService.getListSimpleTotalCount(vo));
		List<ItemVo> list = itemService.getListSimple(vo);
		for(ItemVo tmpVo:list){
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
