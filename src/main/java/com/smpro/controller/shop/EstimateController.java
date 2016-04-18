package com.smpro.controller.shop;

import java.io.File;
import java.io.FileInputStream;

import com.smpro.service.EstimateService;
import com.smpro.service.SmsService;
import com.smpro.service.SystemService;
import com.smpro.vo.EstimateVo;
import com.smpro.vo.CommonVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smpro.util.Const;
import com.smpro.util.FileUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class EstimateController {
	@Resource(name = "estimateService")
	private EstimateService estimateService;
	
	@Resource(name = "systemService")
	private SystemService systemService;
	
	@Resource(name = "smsService")
	private SmsService smsService;
	
	@RequestMapping("/estimate/list")
	public String getList(EstimateVo pvo, Model model) {
		/* 공통코드 리스트 가져오기 */
		CommonVo cvo = new CommonVo();
		//상태
		cvo.setGroupCode(new Integer(32));
		model.addAttribute("statusList", systemService.getCommonList(cvo));
		//구분
		cvo.setGroupCode(new Integer(33));
		model.addAttribute("typeList", systemService.getCommonList(cvo));
		
		pvo.setTotalRowCount(estimateService.getListCount(pvo));
		model.addAttribute("title", "견적 요청 리스트");
		model.addAttribute("list", estimateService.getList(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		return "/estimate/list.jsp";
	}

	@RequestMapping("/estimate/view/{seq}")
	public String getView(@PathVariable Integer seq, Model model) {
		model.addAttribute("vo", estimateService.getVo(seq));
		return "/ajax/get-estimate-vo.jsp";
	}

	@RequestMapping("/estimate/reg")
	public String regData(HttpServletRequest request, EstimateVo vo, Model model) {
		HttpSession session = request.getSession();
		vo.setMemberSeq((Integer)session.getAttribute("loginSeq"));
		
		if (estimateService.regVo(vo) == 1) {
			model.addAttribute("callback", "ESTIMATE_OK");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("message", "등록 실패.");
		return Const.ALERT_PAGE;
	}
	
	@RequestMapping("/estimate/mod")
	public String modData(EstimateVo vo, String returnUrl, Model model) {
		String errMsg = "정보 수정에 실패했습니다.";
		
		vo.setStatusCode("1");
		
		try {
			if (estimateService.modVo(vo) == 1) {
				model.addAttribute("message", "수정 처리되었습니다.");
				model.addAttribute("returnUrl", returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
				return Const.REDIRECT_PAGE;
			}
			errMsg = errMsg + " (데이터가 존재하지 않거나 변경을 할 수 없는 상태입니다.)";
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " ["+e.getMessage()+"]";
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	@RequestMapping("/estimate/compare/download/{seq}")
	public void download(@PathVariable Integer seq, HttpServletResponse response) throws Exception {
		EstimateVo vo = estimateService.getVoCompare(seq);
		
		//다운로드 파일명 생성
		String fileExt = vo.getFile().substring(vo.getFile().lastIndexOf("."));
		String fileName = "비교견적서_"+vo.getSellerName().replace(" ","")+"_"+vo.getSeq()+fileExt;
		fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		
		response.setHeader("Content-Type", "application/octet-stream;");	
		response.setHeader("Content-Disposition", "attachment; filename="+fileName);
	
		try {
			FileUtil.write(new FileInputStream(new File(Const.UPLOAD_REAL_PATH + vo.getFile())), response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
