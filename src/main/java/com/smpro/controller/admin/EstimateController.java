package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.EstimateService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.FileUtil;
import com.smpro.vo.CommonVo;
import com.smpro.vo.EstimateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

@Controller
public class EstimateController {
	@Autowired
	private EstimateService estimateService;

	@Autowired
	private SystemService systemService;
	
	@CheckGrade(controllerName = "estimateController", controllerMethod = "getList")
	@RequestMapping("/estimate/list")
	public String getList(HttpServletRequest request, EstimateVo pvo, Model model) {
		HttpSession session = request.getSession(false);
		pvo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		pvo.setLoginType((String)session.getAttribute("loginType"));
		
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

	@CheckGrade(controllerName = "estimateController", controllerMethod = "modData")
	@RequestMapping("/estimate/mod")
	public String modData(EstimateVo vo, String returnUrl, Model model) {
		String errMsg = "정보 및 상태 수정에 실패했습니다.";
		
		if("".equals(vo.getStatusCode())) {
			vo.setStatusCode("2");
		}
		
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
	
	@CheckGrade(controllerName = "estimateController", controllerMethod = "delData")
	@RequestMapping("/estimate/del/{seq}")
	public String delData(@PathVariable Integer seq, String returnUrl, Model model) {
		String errMsg = "삭제에 실패했습니다.";
		
		try {
			if (estimateService.delVo(seq) == 1) {
				model.addAttribute("message", "삭제 처리되었습니다.");
				model.addAttribute("returnUrl", returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
				return Const.REDIRECT_PAGE;
			}
			errMsg = errMsg + " (데이터가 존재하지 않거나 삭제를 할 수 없는 상태입니다.)";
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " ["+e.getMessage()+"]";
		}
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	@CheckGrade(controllerName = "estimateController", controllerMethod = "getListCompare")
	@RequestMapping("/estimate/compare/list")
	public String getListCompare(HttpServletRequest request, EstimateVo pvo, Model model) {
		HttpSession session = request.getSession(false);
		pvo.setLoginType((String)session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		
		pvo.setTotalRowCount(estimateService.getListCountCompare(pvo));
		model.addAttribute("list", estimateService.getListCompare(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		return "/estimate/list_compare.jsp";
	}
	
	@CheckGrade(controllerName = "estimateController", controllerMethod = "regDataCompare")
	@RequestMapping("/estimate/compare/reg")
	public String regDataCompare(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
		MultipartFile mFile = mpRequest.getFile("file");
		
		EstimateVo vo = new EstimateVo();
		//시퀀스 생성
		estimateService.createEstimateCompareSeq(vo);
		
		//저장 경로 상위 디렉토리 체크
		FileUtil.mkdir(new File(Const.UPLOAD_REAL_PATH + "/estimate/"));
		FileUtil.mkdir(new File(Const.UPLOAD_REAL_PATH + "/estimate/compare"));
		//파일 저장 경로 체크
		int perSeq = calcPerSeq(vo.getSeq());
		File filePath = new File(Const.UPLOAD_REAL_PATH + "/estimate/compare/" + perSeq);
		FileUtil.mkdir(filePath);
		
		//파일 생성
		String fileName = mFile.getOriginalFilename();
		//본래 파일명을 먼저 저장한다.
		vo.setFileName(fileName); 
		//원래 파일명에서 확장자만 추출하고 파일명은 시퀀스 번호로 재설정 한다. 
		fileName = vo.getSeq() + fileName.substring(fileName.lastIndexOf('.')).toLowerCase();
		File file = new File(filePath, fileName);

		boolean writeFlag = false;
		try {
			writeFlag = FileUtil.write(mFile.getInputStream(), new FileOutputStream(file));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//파일이 정상적으로 업로드 되었으면 DB등록을 진행한다.
		if(writeFlag) {
			vo.setOrderSeq(Integer.valueOf(mpRequest.getParameter("orderSeq")));
			vo.setOrderDetailSeq(Integer.valueOf(mpRequest.getParameter("orderDetailSeq")));
			
			vo.setSellerSeq((Integer)session.getAttribute("loginSeq"));
			if("A".equals(session.getAttribute("loginType"))) {
				vo.setSellerSeq(Integer.valueOf(mpRequest.getParameter("sellerSeq")));
			}
			
			vo.setFile("/estimate/compare/" + perSeq + "/" + fileName);
			if(estimateService.regVoCompare(vo) == 1) {
				model.addAttribute("message", "파일이 정상적으로 업로드되었습니다.");
				model.addAttribute("returnUrl", "/admin/order/view/"+vo.getOrderSeq()+"?seq="+vo.getOrderDetailSeq());
				return Const.REDIRECT_PAGE;
			}
			
			model.addAttribute("message", "업로드 실패(DB업데이트 중 오류가 발생하였습니다.)");
			return Const.ALERT_PAGE;
		}
		
		file.delete();
		model.addAttribute("message", "업로드 실패(파일 업로드가 실패하였습니다.)");
		return Const.ALERT_PAGE;
	}
	
	@CheckGrade(controllerName = "estimateController", controllerMethod = "download")
	@RequestMapping("/estimate/compare/download/{seq}")
	public void download(@PathVariable Integer seq, HttpServletResponse response) throws Exception {
		EstimateVo vo = estimateService.getVoCompare(seq);
		
		//다운로드 파일명 생성
		String fileName = vo.getFileName();
		if("".equals(fileName)) {
			String fileExt = vo.getFile().substring(vo.getFile().lastIndexOf("."));
			fileName = "비교견적서_"+vo.getSellerName().replace(" ","")+"_"+vo.getSeq()+fileExt;
		}
		fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		
		response.setHeader("Content-Type", "application/octet-stream;");	
		response.setHeader("Content-Disposition", "attachment; filename="+fileName);
	
		try {
			FileUtil.write(new FileInputStream(new File(Const.UPLOAD_REAL_PATH + vo.getFile())), response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@CheckGrade(controllerName = "estimateController", controllerMethod = "delDataCompare")
	@RequestMapping("/estimate/compare/del/{seq}")
	public String delDataCompare(@PathVariable Integer seq, Integer orderDetailSeq, Model model) {
		EstimateVo vo = estimateService.getVoCompare(seq);
		String errMsg = "삭제 처리 중 오류가 발생하였습니다.";
	
		try {
			//파일 삭제
			File file = new File(Const.UPLOAD_REAL_PATH + vo.getFile());
			file.delete();
			
			//DB 삭제
			if(estimateService.delVoCompare(seq) == 1) {
				model.addAttribute("message", "삭제 처리되었습니다.");
				model.addAttribute("returnUrl", "/admin/order/view/"+vo.getOrderSeq()+"?seq="+orderDetailSeq);
				return Const.REDIRECT_PAGE;
			}
			
			model.addAttribute("message", "파일은 삭제되었으나 DB 삭제에 실패했습니다.");
			return Const.ALERT_PAGE;
			
		} catch (Exception e) {
			errMsg = errMsg + "["+e.getMessage()+"]";
			e.printStackTrace();
		}
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	private static int calcPerSeq(Integer seq) {
		return ((seq.intValue() / 1000) * 1000 + 1000);
	}
}
