package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.JsonHelper;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {
	@Autowired
	private CartService cartService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private DisplayService displayService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private ItemOptionService itemOptionService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private PointService pointService;

	@Autowired
	private MallService mallService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CommonBoardService commonBoardService;

	@Autowired
	private EventService eventService;

	@RequestMapping("/main")
	public String index(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		String memberTypeCode = (String)session.getAttribute("loginMemberTypeCode");
		//회원이면 회원의 멤버구분을, 비회원이면 무조건 회원으로 강제한다.
		if(memberTypeCode == null) {
			memberTypeCode = "C";
		}
		model.addAttribute("title", "홈");

		NoticePopupVo nvo = new NoticePopupVo();
		nvo.setStatusCode("Y");
		nvo.setTypeCode("C");
		model.addAttribute("noticePopup", systemService.getNoticePopupList(nvo));

		DisplayVo vo = new DisplayVo();
		vo.setMemberTypeCode(memberTypeCode); //회원구분에 따라 템플릿을 가져온다.
		vo.setLocation("main");

		MemberVo mvo;
		try {
			mvo = memberService.getData((Integer)session.getAttribute("loginSeq"));
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("memberVo", mvo);


		// top banner
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		model.addAttribute("mallVo",mallVo);
		//배너
		EventVo eventVo = new EventVo();
		/** 현재 진행중인 기획전 상품리스트를 가져옴 */
		eventVo.setTypeCode("1");
		eventVo.setStatusCode("Y");
		eventVo.setMallSeq(mallVo.getSeq());
		//현재날짜 저장
		eventVo.setCurDate(StringUtil.getDate(0, "yyyyMMdd"));
		List<EventVo> eventList = eventService.getList(eventVo);
		for(int i=0;i<eventList.size();i++){
			EventVo tmpVo = eventList.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("eventList",eventList);


		// 오늘만 이가격
		eventVo.setSeq(1); // <-- 오늘만 이가격

		model.addAttribute("eventVo",eventService.getVo(eventVo) );
		eventVo.setStatusCode("Y");
		List<EventVo> eventVoList = eventService.getItemList(eventVo);
		for (EventVo tmpVo:eventVoList) {
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 150));
		}

		model.addAttribute("eventItemList",eventVoList);

		// 신규상품
		ItemVo newvo = new ItemVo();
		newvo.setRowCount(20);
		newvo.setStatusCode("Y");

		//nvo.setLoginType((String) session.getAttribute("loginType"));
		//nvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		model.addAttribute("newItemList", itemService.getList(newvo));

		OrderVo repeate = new OrderVo();
		repeate.setRowCount(10);
		repeate.setLoginType((String) session.getAttribute("loginType"));
		repeate.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		model.addAttribute("repeatList", orderService.getRepeatOrderList(repeate));
		model.addAttribute("mallList", mallService.getListSimple());
		return "/index.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/detail/{seq}", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public String detail(HttpServletRequest request, @PathVariable Integer seq,Model model) {
		Map map = new HashMap();
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

		map.put("vo", vo);

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();
		cvo.setDepth(1);
		cvo.setShowFlag("Y");
		map.put("cateLv1List", categoryService.getListSimple(cvo));

		// 2단
		cvo.setDepth(2);
		cvo.setShowFlag("Y");
		cvo.setParentSeq(vo.getCateLv1Seq());
		map.put("cateLv2List", categoryService.getListSimple(cvo));
		// 3단
		cvo.setDepth(3);
		cvo.setShowFlag("Y");
		cvo.setParentSeq(vo.getCateLv2Seq());
		map.put("cateLv3List", categoryService.getListSimple(cvo));
		// 4단
		cvo.setDepth(4);
		cvo.setShowFlag("Y");
		cvo.setParentSeq(vo.getCateLv3Seq());
		map.put("cateLv4List", categoryService.getListSimple(cvo));

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

		map.put("lv1ShowFlag", lv1ShowFlag);
		map.put("lv2ShowFlag", lv2ShowFlag);
		map.put("lv3ShowFlag", lv3ShowFlag);
		map.put("itemSeq", seq);
		map.put("title", vo.getName());
		map.put("optionList", resolvedList);
		map.put("propList", itemService.getPropList(vo.getTypeCd())); //해당 상품에 저장된 상품고시정보 제목
		map.put("propInfo", itemService.getInfo(seq)); //해당 상품에 저장된 상품고시정보 등록된 내용
		map.put("statusCode", vo.getStatusCode()); //상품상태
		map.put("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35))); //인증구분 공통코드
		return JsonHelper.render(map);
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

	/** 장바구니 등록 */
	@RequestMapping("/index/cart/proc")
	public String regCart(HttpServletRequest request,@RequestParam Integer[] seq, Model model) {

		// 1, login 확인 & get
		HttpSession session = request.getSession();
		model.addAttribute("loginSeq", session.getAttribute("loginSeq"));
		model.addAttribute("nickName", session.getAttribute("nickname"));
		MemberVo mvo;
		try {
			mvo = memberService.getData((Integer)session.getAttribute("loginSeq"));
		} catch(Exception e) {
			model.addAttribute("message","허용되지 않은 접근입니다.");
			model.addAttribute("returnUrl", "/shop/main");
			return Const.REDIRECT_PAGE;
		}


		//get ItemVo from selected seq in repeated list
		List<ItemVo> list = new ArrayList<>();
		for(int i=0; i<seq.length; i++) {
			// 2. 선택한 아이템에서 주문 정보 얻어오기
			System.out.println(">>>>seq[i]seq : "+seq[i]);
			ItemVo vo = new ItemVo();
			OrderVo ov = orderService.getVoDetail(seq[i]);
			// 3. 주문정보를 기준으로 아이템 정보 셋팅
			vo.setMemberSeq(mvo.getSeq());
			vo.setItemSeq(ov.getItemSeq());
			vo.setSeq(ov.getItemSeq());
			vo.setOptionValueSeq(ov.getOptionValueSeq());
			vo.setDirectFlag("N");
			vo.setCount(1);
			list.add(vo);
		}


		ItemVo logineVo = new ItemVo();
		logineVo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		//비회원일 경우 별도 인증키 값 저장
		if(session.getAttribute("notLoginKey") != null) {
			logineVo.setNotLoginKey((String)session.getAttribute("notLoginKey"));
		}

		List<ItemVo> cartList = cartService.getList(logineVo);

		// 4. 장바구니에 담기
		for(int i=0; i<list.size(); i++){
			//이미 장바구니에 있는지 확인 -> 수량 추가
			// 즉시구매로 들어온 내역은 지워버린다
			boolean found = false;
			for(int k=0; k<cartList.size(); k++) {
//				System.out.println(">>>>cartList.get(k).getItemSeq(): "+cartList.get(k).getItemSeq());
//				System.out.println(">>>>list.get(i).getItemSeq(): "+list.get(i).getItemSeq());
//				System.out.println(">>>>cartList.get(k).getOptionValueSeq(): "+cartList.get(k).getOptionValueSeq());
//				System.out.println(">>>>list.get(i).getOptionValueSeq(): "+list.get(i).getOptionValueSeq());

				if((cartList.get(k).getItemSeq().intValue() == list.get(i).getItemSeq().intValue()) &&
						(cartList.get(k).getOptionValueSeq().intValue() == list.get(i).getOptionValueSeq().intValue())){
					found = true;
					cartList.get(k).setCount(cartList.get(k).getCount()+1);
					cartService.updateVo(cartList.get(k));
					break;
				}

			}
			//장바구니에 없는 경우, 추가
			if(!found) {
				cartService.insertVo(list.get(i));
			}
			found = false;
		}

		model.addAttribute("message", "장바구니에 등록 되었습니다.");
		model.addAttribute("returnUrl", "/shop/cart");
		return Const.REDIRECT_PAGE;
	}

}
