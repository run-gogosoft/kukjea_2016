package com.smpro.controller.shop;

import com.smpro.service.EstimateService;
import com.smpro.util.StringUtil;
import com.smpro.vo.EstimateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MyPageEstimateController {
	@Autowired
	private EstimateService estimateService;

	@RequestMapping("/mypage/estimate/list")
	public String getList(HttpServletRequest request, EstimateVo vo, Model model) {
		HttpSession session = request.getSession(false);

		vo.setLoginType((String)session.getAttribute("loginType"));
		vo.setLoginSeq((Integer)session.getAttribute("loginSeq"));

		//기본 조회기간 일주일
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
		}

		vo.setRowCount(5);
		vo.setTotalRowCount(estimateService.getListCount(vo));

		model.addAttribute("list", estimateService.getList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", vo);
		return "/mypage/estimate/list.jsp";
	}

	@RequestMapping("/mypage/estimate/view/{seq}")
	public String getView(@PathVariable Integer seq, Model model) {
		model.addAttribute("vo", estimateService.getVo(seq));
		return "/mypage/estimate/view.jsp";
	}
}
