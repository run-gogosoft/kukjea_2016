package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.ItemService;
import com.smpro.service.MemberService;
import com.smpro.service.ReviewService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.MemberVo;
import com.smpro.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService reviewService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private ItemService itemService;

	@CheckGrade(controllerName = "reviewController", controllerMethod = "reviewList")
	@RequestMapping("/board/review/list")
	public String reviewList(HttpServletRequest request, ReviewVo vo, Model model) {
		HttpSession session = request.getSession(false);
		/* 로그인 세션 체크 */
		if (request.getSession().getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 후 이용하세요.");
			model.addAttribute("returnUrl",	"/admin/login?goUrl=/admin/board/review/list");
			return Const.REDIRECT_PAGE;
		}

		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setTotalRowCount(reviewService.getListCount(vo));
		model.addAttribute("title", "상품평 게시판");
		model.addAttribute("list", reviewService.getList(vo));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);

		return "/board/review_list.jsp";
	}

	@CheckGrade(controllerName = "reviewController", controllerMethod = "view")
	@RequestMapping("/board/review/view/{seq}")
	public String view(HttpServletRequest request, @PathVariable Integer seq, ReviewVo paramVo, Model model) {
		if (request.getSession().getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 후 이용하세요.");
			model.addAttribute("returnUrl",	"/admin/login?goUrl=/admin/board/review/view/" + seq);
			return Const.REDIRECT_PAGE;
		}

		String loginSeq = String.valueOf(request.getSession().getAttribute("loginSeq"));
		model.addAttribute("loginSeq", loginSeq);
		model.addAttribute("title", "상품평");
		paramVo.setSeq(seq);
		model.addAttribute("vo", reviewService.getVo(paramVo));

		return "/board/review_view.jsp";
	}

	@CheckGrade(controllerName = "reviewController", controllerMethod = "edit")
	@RequestMapping("/board/review/edit/{seq}")
	public String edit(HttpServletRequest request, @PathVariable Integer seq, ReviewVo paramVo, Model model) {
		/* 로그인 세션 체크 */
		if (request.getSession().getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 후 이용하세요.");
			model.addAttribute("returnUrl",	"/admin/login?goUrl=/admin/board/review/edit/" + seq);
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("title", "상품평 수정");
		paramVo.setSeq(seq);
		model.addAttribute("vo", reviewService.getVo(paramVo));
		return "/board/review_form.jsp";
	}

	@RequestMapping("/board/review/edit/proc/{seq}")
	public String editProc(@PathVariable Integer seq, ReviewVo vo, Model model) {
		if (vo.getReview().length() == 0 && "".equals(vo.getReview())) {
			model.addAttribute("message", "구매평이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (StringUtil.isBlank("" + vo.getGoodGrade())) {
			model.addAttribute("message", "상품평가가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (StringUtil.isBlank("" + vo.getDeliGrade())) {
			model.addAttribute("message", "배송평가가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		vo.setSeq(seq);
		if (!reviewService.updateData(vo)) {
			model.addAttribute("message", "게시물을 수정할 수 없었습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("message", "게시물이 수정 되었습니다.");
		model.addAttribute("returnUrl", "/admin/board/review/list");
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "reviewController", controllerMethod = "delProc")
	@RequestMapping("/board/review/del/proc/{seq}")
	public String delProc(@PathVariable Integer seq, Model model) {
		// 원래는 seq에 따라 삭제할 수 있는 유저를 판별해야 하지만 어차피 최고 관리자 밖에 쓸 수 없기 때문에 굳이 판별하지 않고
		// 바로 seq를 매칭한다

		if (!reviewService.deleteData(seq)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "구매평이 삭제 되었습니다.");
		model.addAttribute("returnUrl", "/admin/board/review/list");

		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/board/review/member/json")
	public String getVoForJson(MemberVo vo, Model model) {
		/* 입력값 검증 */
		if (StringUtil.isBlank(vo.getFindword())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "검색할 키워드를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getFindword()) > 50) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getFindword()) < 6) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 6자 이상 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		vo.setSearch("id");
		/* 아이디 체크 */
		MemberVo mvo = new MemberVo();
		mvo.setId(vo.getFindword());
		mvo.setTypeCode("C");
		if (systemService.getIdCnt(mvo) > 0) {
			model.addAttribute("vo", memberService.getSearchMemberVo(vo));
			return "/ajax/get-member-vo.jsp";
		} else if (systemService.getIdCnt(mvo) == 0) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디가 존재하지 않습니다.");
			return "/ajax/get-message-result.jsp";
		}
		return "";
	}

	/** 아이디 체크 */
	@RequestMapping("/board/review/item/check/ajax")
	public String checkItemSeq(Integer itemSeq, Model model) {
		// 입력값 검증
		if (itemSeq == null) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "상품번호를 입력해주세요");
			return "/ajax/get-message-result.jsp";
		}

		if (itemService.getItemCnt(itemSeq) < 1) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "상품번호가 존재하지 않습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "true");
		model.addAttribute("message", "등록하실수 있는 상품번호입니다.");
		return "/ajax/get-message-result.jsp";
	}
}
