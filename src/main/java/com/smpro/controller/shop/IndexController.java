package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

@Controller
public class IndexController {
	//private static final Logger LOGGER = LoggerFactory.getLogger(IndexController.class);
	
	@Resource(name="categoryService")
	private CategoryService categoryService;

	@Resource(name="displayService")
	private DisplayService displayService;

	@Resource(name="systemService")
	private SystemService systemService;

	@Resource(name="itemService")
	private ItemService itemService;

	@Resource(name="itemOptionService")
	private ItemOptionService itemOptionService;

	@Resource(name="reviewService")
	private ReviewService reviewService;

	@Resource(name="boardService")
	private BoardService boardService;

	@Resource(name="orderService")
	private OrderService orderService;

	@Resource(name="pointService")
	private PointService pointService;

	@Resource(name="mallService")
	private MallService mallService;

	@Resource(name="memberService")
	private MemberService memberService;
	
	@Resource(name = "commonBoardService")
	private CommonBoardService commonBoardService;

	@RequestMapping("/main")
	public String index(HttpSession session, Model model) {
		String memberTypeCode = (String)session.getAttribute("loginMemberTypeCode");
		//회원이면 회원의 멤버구분을, 비회원이면 무조건 회원으로 강제한다.
		if(memberTypeCode == null) {
			memberTypeCode = "C";
		}
		model.addAttribute("title", "Home");

		NoticePopupVo nvo = new NoticePopupVo();
		nvo.setStatusCode("Y");
		nvo.setTypeCode("C");
		model.addAttribute("noticePopup", systemService.getNoticePopupList(nvo));

		DisplayVo vo = new DisplayVo();
		vo.setMemberTypeCode(memberTypeCode); //회원구분에 따라 템플릿을 가져온다.
		vo.setLocation("main");
		
		//배너
		vo.setTitle("mainHeroBanner");
		DisplayVo bvo = displayService.getVo(vo);
		model.addAttribute("mainHeroBanner", bvo==null ? null:bvo.getContent());

		vo.setTitle("mainBannerA");
		DisplayVo bvo2 = displayService.getVo(vo);
		model.addAttribute("mainBannerA", bvo2==null ? null:bvo2.getContent());

		vo.setTitle("mainBannerB");
		DisplayVo bvo3 = displayService.getVo(vo);
		model.addAttribute("mainBannerB", bvo3==null ? null:bvo3.getContent());

		vo.setTitle("mainBannerC");
		DisplayVo bvo4 = displayService.getVo(vo);
		model.addAttribute("mainBannerC", bvo4==null ? null:bvo4.getContent());

		vo.setTitle("mainBannerF");
		DisplayVo bvo5 = displayService.getVo(vo);
		model.addAttribute("mainBannerF", bvo5==null ? null:bvo5.getContent());
		
		//상품리스트1
		DisplayLvItemVo dvo = new DisplayLvItemVo();
		dvo.setMemberTypeCode(memberTypeCode);
		dvo.setStatusFlag("Y");
		
		dvo.setStyleCode(new Integer(1));
		DisplayLvItemVo tlvo = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle1", tlvo == null ? null:tlvo.getListTitle());
		model.addAttribute("gallery1", tlvo == null ? null:displayService.getLvItemList(dvo));

		//상품리스트2
		dvo.setStyleCode(new Integer(2));
		DisplayLvItemVo tlvo2 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle2", tlvo2 == null ? null : tlvo2.getListTitle());
		model.addAttribute("gallery2", tlvo2 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트3
		dvo.setStyleCode(new Integer(3));
		DisplayLvItemVo tlvo3 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle3",  tlvo3 == null ? null :  tlvo3.getListTitle());
		model.addAttribute("gallery3",  tlvo3 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트9
		dvo.setStyleCode(new Integer(9));
		DisplayLvItemVo tlvo9 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle9",  tlvo9 == null ? null :  tlvo9.getListTitle());
		model.addAttribute("gallery9",  tlvo9 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트10
		dvo.setStyleCode(new Integer(10));
		DisplayLvItemVo tlvo10 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle10",  tlvo10 == null ? null :  tlvo10.getListTitle());
		model.addAttribute("gallery10",  tlvo10 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트4
		dvo.setStyleCode(new Integer(4));
		DisplayLvItemVo tlvo4 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle4",  tlvo4 == null ? null :  tlvo4.getListTitle());
		model.addAttribute("gallery4",  tlvo4 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트5
		dvo.setStyleCode(new Integer(5));
		DisplayLvItemVo tlvo5 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle5",  tlvo5 == null ? null :  tlvo5.getListTitle());
		model.addAttribute("gallery5",  tlvo5 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트6
		dvo.setStyleCode(new Integer(6));
		DisplayLvItemVo tlvo6 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle6",  tlvo6 == null ? null :  tlvo6.getListTitle());
		model.addAttribute("gallery6",  tlvo6 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트7
		dvo.setStyleCode(new Integer(7));
		DisplayLvItemVo tlvo7 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle7",  tlvo7 == null ? null :  tlvo7.getListTitle());
		model.addAttribute("gallery7",  tlvo7 == null ? null : displayService.getLvItemList(dvo));
		
		//상품리스트8
		dvo.setStyleCode(new Integer(8));
		DisplayLvItemVo tlvo8 = displayService.getLvTitle(dvo);
		model.addAttribute("galleryTitle8",  tlvo8 == null ? null :  tlvo8.getListTitle());
		model.addAttribute("gallery8",  tlvo8 == null ? null : displayService.getLvItemList(dvo));
		
		//공지사항
		BoardVo boardVo = new BoardVo();
		boardVo.setCategoryCode(new Integer(1));
		boardVo.setGroupCode("notice");
		boardVo.setRowCount(4);
		boardVo.setTotalRowCount( boardService.getListCount(boardVo) );
		model.addAttribute("noticeList",boardService.getList(boardVo));
		
		//사회적 기업 소식
		CommonBoardVo cvo = new CommonBoardVo();
		cvo.setCommonBoardSeq(new Integer(3));
		cvo.setRowCount(4);
		model.addAttribute("socialList",commonBoardService.getDetailList(cvo));
		
		MemberVo mvo;
		try {
			mvo = memberService.getData((Integer)session.getAttribute("loginSeq"));
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("memberVo", mvo);

		return "/index.jsp";
	}
	
	@RequestMapping("/detail/{seq}")
	public String detail(HttpServletRequest request, @PathVariable Integer seq,Model model) {
		HttpSession session = request.getSession();
		model.addAttribute("loginSeq", session.getAttribute("loginSeq"));
		model.addAttribute("nickName", session.getAttribute("nickname"));
		
		ItemVo vo = itemService.getVo(seq);

		if(vo==null){
			model.addAttribute("target", "self");
			model.addAttribute("message","허용되지 않은 접근입니다.");
			model.addAttribute("returnUrl", "/shop/main");
			return Const.REDIRECT_PAGE;
		} 
		
		if(!"Y".equals(vo.getStatusCode()) && !"S".equals(vo.getStatusCode()) ) {
			if("N".equals(vo.getStatusCode())) {
				model.addAttribute("message", "해당 상품은 판매 중지되었습니다.");
			} else {
				model.addAttribute("message", "해당 상품은 현재 판매중이 아닙니다.");
			}
			model.addAttribute("returnUrl", "/shop/main");
			return Const.REDIRECT_PAGE;
		}
			 
		model.addAttribute("vo", vo);

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();
		cvo.setDepth(1);
		cvo.setShowFlag("Y");
		model.addAttribute("cateLv1List", categoryService.getListSimple(cvo));

		// 2단
		cvo.setDepth(2);
		cvo.setShowFlag("Y");
		cvo.setParentSeq(vo.getCateLv1Seq());
		model.addAttribute("cateLv2List", categoryService.getListSimple(cvo));
		// 3단
		cvo.setDepth(3);
		cvo.setShowFlag("Y");
		cvo.setParentSeq(vo.getCateLv2Seq());
		model.addAttribute("cateLv3List", categoryService.getListSimple(cvo));
		// 4단
		cvo.setDepth(4);
		cvo.setShowFlag("Y");
		cvo.setParentSeq(vo.getCateLv3Seq());
		model.addAttribute("cateLv4List", categoryService.getListSimple(cvo));

		// 옵션 리스트를 불러온다
		List<ItemOptionVo> list = itemOptionService.getList(vo.getSeq());
		List<ItemOptionVo> resolvedList = new ArrayList<>();
		if(list == null) {
			model.addAttribute("message", "판매중이 아닙니다.");
			model.addAttribute("returnUrl", "/shop/main");
		} else {
			for(int i=0; i<list.size(); i++) {
				// 상품 보기를 허용한 리스트만 넣는다
				if("Y".equals(list.get(i).getShowFlag())) {
					resolvedList.add(list.get(i));
				}
			}
		}

		String lv1ShowFlag = "";
		String lv2ShowFlag = "";
		String lv3ShowFlag = "";
		if(vo.getCateLv1Seq() != null){
			CategoryVo tempVo = categoryService.getVo(vo.getCateLv1Seq());
			if(tempVo != null) {
				lv1ShowFlag = tempVo.getShowFlag();
			}
		}
		if(vo.getCateLv2Seq() != null){
			CategoryVo tempVo = categoryService.getVo(vo.getCateLv2Seq());
			if(tempVo != null) {
				lv2ShowFlag = tempVo.getShowFlag();
			}
		}
		if(vo.getCateLv3Seq() != null){
			CategoryVo tempVo = categoryService.getVo(vo.getCateLv3Seq());
			if(tempVo != null) {
				lv3ShowFlag = tempVo.getShowFlag();
			}
		}
		model.addAttribute("lv1ShowFlag", lv1ShowFlag);
		model.addAttribute("lv2ShowFlag", lv2ShowFlag);
		model.addAttribute("lv3ShowFlag", lv3ShowFlag);

		model.addAttribute("itemSeq", seq);
		model.addAttribute("title", vo.getName());
		model.addAttribute("optionList", resolvedList);
		model.addAttribute("propList", itemService.getPropList(vo.getTypeCd())); //해당 상품에 저장된 상품고시정보 제목
		model.addAttribute("propInfo", itemService.getInfo(seq)); //해당 상품에 저장된 상품고시정보 등록된 내용
		model.addAttribute("statusCode", vo.getStatusCode()); //상품상태
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35))); //인증구분 공통코드
		return "/detail.jsp";
	}

	@RequestMapping("/detail/review/exist/ajax")
	public String getReviewExist(OrderVo vo, HttpSession session, Model model) {
		

		//배송완료된 주문이 있는지 확인하기 위한 셋팅
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		vo.setStatusCode("50");

		int existCnt = orderService.getListCount(vo);
		if(existCnt > 0) {
			model.addAttribute("result", "Y");
		} else {
			model.addAttribute("result", "N");
			model.addAttribute("message", "해당상품 구매이력이 없거나, 이미 등록하셨습니다.");
		}
		return "/ajax/get-message-result.jsp";
	}

	@RequestMapping("/detail/review/getList")
	public String getAjaxReviewList(ReviewVo vo, Model model) {
		vo.setRowCount(5);
		model.addAttribute("list", reviewService.getList(vo));
		return "/ajax/get-review-list.jsp";
	}

	@RequestMapping("/detail/review/reviewcount")
	public String getAjaxReviewCount(ReviewVo vo, Model model) {
		int reviewCount = 0;
		List<ReviewVo> getList = reviewService.getList(vo);

		for(int i=0;i< getList.size(); i++){
			ReviewVo tmpVo = getList.get(i);
			reviewCount = tmpVo.getReviewCount();
			if(i>=1){
				break;
			}
		}
		model.addAttribute("message", new Integer(reviewCount));
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/detail/qna/count")
	public String getAjaxQnaCount(HttpServletRequest request, BoardVo vo, Model model) {
		vo.setGroupCode("qna");
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		vo.setMallSeq(mallVo.getSeq());
		model.addAttribute("message",new Integer(boardService.getListCount(vo)));
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/detail/review/paging")
	public String getAjaxReviewPaging(ReviewVo vo, Model model) {
		vo.setTotalRowCount( reviewService.getListCount(vo) );
		vo.setRowCount(5);
		model.addAttribute("message", vo.drawPagingNavigation("goPage"));
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/detail/itemqna/getList")
	public String getAjaxItemQnaList(HttpServletRequest request, BoardVo vo, Model model) {
		vo.setRowCount(5);
		vo.setGroupCode("qna");
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		vo.setMallSeq(mallVo.getSeq());
		List<BoardVo> list = boardService.getList(vo);
		for(int i=0; i<list.size(); i++){
			list.get(i).setName(list.get(i).getName().replace(list.get(i).getName().charAt(1)+"", "*"));
		}
		model.addAttribute("list", list);
		return "/ajax/get-itemqna-list.jsp";
	}

	@RequestMapping("/detail/itemqna/paging")
	public String getAjaxItemQnaPaging(HttpServletRequest request, BoardVo vo, Model model) {
		vo.setRowCount(5);
		vo.setGroupCode("qna");
		vo.setTotalRowCount( boardService.getListCount(vo) );
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		vo.setMallSeq(mallVo.getSeq());
		model.addAttribute("message", vo.drawPagingNavigation("goPageQna"));
		return Const.AJAX_PAGE;
	}
	
	@RequestMapping("/detail/seller/item/list/ajax")
	public String getSellerItemListAjax(ItemVo vo, Model model) {
		vo.setTotalRowCount( itemService.getListSimpleTotalCount(vo) );
		
		model.addAttribute("list", itemService.getListSimple(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPageSellerItem"));
		model.addAttribute("vo", vo);
		return "/ajax/get-seller-item-list.jsp";
	}
	
	@RequestMapping("/best")
	public String best(Model model) {
		model.addAttribute("title", "베스트상품");

		DisplayLvItemVo dvo = new DisplayLvItemVo();
		dvo.setMemberTypeCode("B");
		dvo.setStatusFlag("Y");
		dvo.setStyleCode(new Integer(1));
		DisplayLvItemVo tlvo = displayService.getLvTitle(dvo);
		model.addAttribute("title", tlvo == null ? null:tlvo.getListTitle());
		model.addAttribute("list", tlvo == null ? null:displayService.getLvItemList(dvo));
		return "/best/best.jsp";
	}

	@RequestMapping("/ranking")
	public String ranking(Model model) {
		

		OrderVo vo = new OrderVo();
		vo.setSearchDate1(StringUtil.getDate(-30,"yyyyMMdd"));
		vo.setSearchDate2(StringUtil.getDate(0,"yyyyMMdd"));
		model.addAttribute("list", orderService.getRankingOrderFinishPrice(vo));
		return "/ajax/get-ranking-list.jsp";
	}
	
	@RequestMapping("/video/item/list/ajax")
	public String getVideoItemList(HttpSession session, Model model) {
		String memberTypeCode = (String)session.getAttribute("loginMemberTypeCode");
		//회원이면 회원의 멤버구분을, 비회원이면 무조건 회원으로 강제한다.
		if(memberTypeCode == null) {
			memberTypeCode = "C";
		}
		
		DisplayLvItemVo dvo = new DisplayLvItemVo();
		dvo.setMemberTypeCode(memberTypeCode);
		dvo.setStatusFlag("Y");
		dvo.setStyleCode(new Integer(8));
		DisplayLvItemVo tlvo8 = displayService.getLvTitle(dvo);
		model.addAttribute("title",  tlvo8 == null ? null :  tlvo8.getListTitle());
		model.addAttribute("list",  tlvo8 == null ? null : displayService.getLvItemList(dvo));
		return "/ajax/get-template-list.jsp";
	}
}
