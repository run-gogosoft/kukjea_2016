package com.smpro.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.FestivalService;
import com.smpro.service.FilenameService;
import com.smpro.service.SystemService;
import com.smpro.util.CommonServletUtil;
import com.smpro.util.Const;
import com.smpro.util.EditorUtil;
import com.smpro.util.FileUploadUtil;
import com.smpro.util.FileUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.FestivalVo;
import com.smpro.vo.FilenameVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class FestivalController {
	private static final Logger LOGGER = LoggerFactory.getLogger(FestivalController.class);
	
	@Resource(name = "festivalService")
	private FestivalService festivalService;

	@Resource(name = "filenameService")
	private FilenameService filenameService;
	
	@Resource(name = "systemService")
	private SystemService systemService;
	
	/** 행사 리스트 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "getList")
	@RequestMapping("/festival/list")
	public String getList(FestivalVo vo, Model model) {
		vo.setTotalRowCount(festivalService.getListCount(vo));
		model.addAttribute("list", festivalService.getList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		return "/festival/list.jsp";
	}
	
	/** 행사 등록 폼 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "getRegForm")
	@RequestMapping("/festival/form")
	public String getRegForm(Model model) {
		model.addAttribute("title", "행사 등록");
		return "/festival/form.jsp";
	}
	
	/** 행사 등록 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "regVo")
	@RequestMapping("/festival/reg")
	public String regVo(HttpServletRequest request, Model model) {
		String errMsg = "등록 처리에 실패하였습니다.";
		
		//멀티파트 request 처리
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		//vo 맵핑
		FestivalVo vo = getFestivalVo(mpRequest);
		
		//첨부파일 업로드		
		List<FilenameVo> fileList = null;
		try {
			fileList = uploadFile(mpRequest, "festival");
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("message", "파일 업로드에 실패하였습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
		
		//seq 생성
		festivalService.createSeq(vo);
		
		//에디터상에서 업로드한 임시 이미지 파일을 정식 등록 처리
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "festival"));
		
		try {
			if(festivalService.regVo(vo) == 1) {
				// 파일 내역을 DB에 저장한다
				if(fileList != null) {
					for(FilenameVo fvo : fileList) {
						fvo.setParentSeq(vo.getSeq());
						filenameService.replaceFilename(fvo);
					}
				}
				
				model.addAttribute("message", "정상적으로 등록 처리 되었습니다.");
				model.addAttribute("returnUrl", "/admin/festival/list");
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";			
		}		
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 행사 상세 정보 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "getDetail")
	@RequestMapping("/festival/detail/{festivalSeq}")
	public String getDetail(@PathVariable Integer festivalSeq, Integer seq, String detailType, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession(false);
		String loginType = String.valueOf(session.getAttribute("loginType"));
		Integer loginSeq = Integer.valueOf(String.valueOf(session.getAttribute("loginSeq")));
		
		//행사 정보
		FestivalVo vo = festivalService.getVo(festivalSeq);
		//행사 정보 글 내용이 아이프레임에 보여질때 오류가 발생할 수 있는 문자 제거
		String content = vo.getContent().replace("\n", "");
		content = content.replace("\r", "");
		content = content.replace("\"", "'");
		vo.setContent(content);
		model.addAttribute("vo", vo);
		
		//행사 첨부파일 리스트 조회
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "festival");
		map.put("parentSeq", festivalSeq);
		model.addAttribute("fileList", filenameService.getList(map));
		
		FestivalVo paramVo = new FestivalVo();
		paramVo.setFestivalSeq(festivalSeq);
		
		//행사 참여 정보 조회 (관리자일 경우)
		String detailTypeDefault = "";
		FestivalVo sellerVo = null;
		if("A".equals(loginType)) {
			if(seq == null) {
				//상세정보 조회를 위한 파라미터값이 존재하지 않으면 리스트를 우선적으로 보여준다.
				model.addAttribute("sellerList", festivalService.getSellerList(paramVo));
				detailTypeDefault = "sellerList";
			} else {
				//상세정보 조회를 위한 파라미터값이 존재하면 해당 정보를 우선적으로 보여준다.
				paramVo.setSeq(seq);
				sellerVo = festivalService.getSellerVo(paramVo);
				detailTypeDefault = "sellerDetail";
			}
		//행사 참여 정보 조회 (입점업체일 경우)	
		} else if("S".equals(loginType)) {		
			//입점업체는 자신의 정보만 조회하면 된다.
			paramVo.setSellerSeq(loginSeq);
			sellerVo = festivalService.getSellerVo(paramVo);
			detailTypeDefault = "sellerDetail";
		}
		
		if(sellerVo != null) {
			model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
			
			//행사 참여 업체 정보
			model.addAttribute("sellerVo", sellerVo);
			//행사 참여 업체 첨부파일 리스트
			map = new HashMap<>();
			map.put("parentCode", "festival_seller");
			map.put("parentSeq", sellerVo.getSeq());
			model.addAttribute("sellerFileList", filenameService.getList(map));
		}
		
		if(detailType == null) {
			model.addAttribute("detailType", detailTypeDefault);
		} else {
			model.addAttribute("detailType", detailType);
		}
		
		return "/festival/detail.jsp";
	}
	
	/** 행사 수정 폼 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "getModForm")
	@RequestMapping("/festival/form/{seq}")
	public String getModForm(@PathVariable Integer seq, Model model) {
		model.addAttribute("title", "행사 정보 수정");
		
		//첨부파일 리스트 조회
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "festival");
		map.put("parentSeq", seq);
		model.addAttribute("fileList", filenameService.getList(map));
		
		//정보 조회
		model.addAttribute("vo", festivalService.getVo(seq));
		return "/festival/form.jsp";
	}
	
	
	/** 행사 수정 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "modVo")
	@RequestMapping("/festival/mod/{seq}")
	public String modVo(@PathVariable Integer seq, HttpServletRequest request, Model model) {
		String errMsg = "수정 처리에 실패하였습니다.";
		
		//멀티파트 request 처리
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		//vo 맵핑
		FestivalVo vo = getFestivalVo(mpRequest);
		vo.setSeq(seq);
		
		//첨부파일 업로드		
		List<FilenameVo> fileList = null;
		try {
			fileList = uploadFile(mpRequest, "festival");
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("message", "파일 업로드에 실패하였습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
				
		//에디터상에서 업로드한 임시 이미지 파일을 정식 등록 처리
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "festival"));
		
		try {
			if(festivalService.modVo(vo) == 1) {
				// 파일 내역을 DB에 저장한다
				if(fileList != null) {
					for(FilenameVo fvo : fileList) {
						fvo.setParentSeq(vo.getSeq());
						filenameService.replaceFilename(fvo);
					}
				}
				
				model.addAttribute("message", "정상적으로 수정 처리 되었습니다.");
				model.addAttribute("returnUrl", "/admin/festival/detail/"+vo.getSeq());
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";			
		}		
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 행사 삭제 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "delVo")
	@RequestMapping("/festival/del/{seq}")
	public String delVo(@PathVariable Integer seq, HttpServletRequest request, Model model) {
		String errMsg = "삭제 처리에 실패하였습니다.";
			
		//에디터를 통해 업로드한 이미지 삭제
		EditorUtil.deleteImage(seq, "festival");
		
		//행사 첨부파일 삭제
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "festival");
		map.put("parentSeq", seq);
		List<FilenameVo> fileList = filenameService.getList(map);
		for(FilenameVo vo : fileList) {
			String deletePath = request.getServletContext().getRealPath("/") + vo.getRealFilename();
			LOGGER.info("file>>delete>> " + deletePath);
			new File(deletePath).delete();
			filenameService.deleteVo(vo.getSeq());
		}
		
		//참여업체 첨부파일 삭제
		FestivalVo paramVo = new FestivalVo();
		paramVo.setFestivalSeq(seq);
		List<FestivalVo> sellerList = festivalService.getSellerList(paramVo);
		for(FestivalVo festivalVo : sellerList) {
			map = new HashMap<>();
			map.put("parentCode", "festival_seller");
			map.put("parentSeq", festivalVo.getSeq());
			fileList = filenameService.getList(map);
			for(FilenameVo vo : fileList) {
				String deletePath = request.getServletContext().getRealPath("/") + vo.getRealFilename();
				LOGGER.info("file>>delete>> " + deletePath);
				new File(deletePath).delete();
				filenameService.deleteVo(vo.getSeq());
			}
		}
		
		try {
			if(festivalService.delVo(seq) == 1) {
				model.addAttribute("message", "정상적으로 삭제 처리 되었습니다.");
				model.addAttribute("returnUrl", "/admin/festival/list");
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";			
		}		
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 행사 참여 정보 등록 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "regSellerVo")
	@RequestMapping("/festival/seller/reg")
	public String regSellerVo(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		String loginType = String.valueOf(session.getAttribute("loginType"));
		Integer loginSeq = Integer.valueOf(String.valueOf(session.getAttribute("loginSeq")));
		
		String errMsg = "등록 처리에 실패하였습니다.";
		
		//멀티파트 request 처리
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		//vo 맵핑
		FestivalVo vo = getFestivalVo(mpRequest);
		if("S".equals(loginType)) {
			vo.setSellerSeq(loginSeq);
		}
		
		//첨부파일 업로드		
		List<FilenameVo> fileList = null;
		try {
			fileList = uploadFile(mpRequest, "festival_seller");
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("message", "파일 업로드에 실패하였습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
				
		try {
			if(festivalService.regSellerVo(vo) == 1) {
				// 파일 내역을 DB에 저장한다
				if(fileList != null) {
					for(FilenameVo fvo : fileList) {
						fvo.setParentSeq(vo.getSeq());
						filenameService.replaceFilename(fvo);
					}
				}
				
				model.addAttribute("message", "정상적으로 등록 처리 되었습니다.");
				model.addAttribute("returnUrl", "/admin/festival/detail/"+vo.getFestivalSeq());
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";			
		}		
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 행사 참여 정보 수정 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "modSellerVo")
	@RequestMapping("/festival/seller/mod/{seq}")
	public String modSellerVo(@PathVariable Integer seq, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		String loginType = String.valueOf(session.getAttribute("loginType"));
		Integer loginSeq = Integer.valueOf(String.valueOf(session.getAttribute("loginSeq")));
		
		String errMsg = "수정 처리에 실패하였습니다.";
		
		//멀티파트 request 처리
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		//vo 맵핑
		FestivalVo vo = getFestivalVo(mpRequest);
		vo.setSeq(seq);
		if("S".equals(loginType)) {
			vo.setSellerSeq(loginSeq);
		}
		
		//첨부파일 업로드		
		List<FilenameVo> fileList = null;
		try {
			fileList = uploadFile(mpRequest, "festival_seller");
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("message", "파일 업로드에 실패하였습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}
				
		try {
			if(festivalService.modSellerVo(vo) == 1) {
				// 파일 내역을 DB에 저장한다
				if(fileList != null) {
					for(FilenameVo fvo : fileList) {
						fvo.setParentSeq(vo.getSeq());
						filenameService.replaceFilename(fvo);
					}
				}
				
				model.addAttribute("message", "정상적으로 수정 처리 되었습니다.");
				model.addAttribute("returnUrl", "/admin/festival/detail/"+vo.getFestivalSeq()+"?seq="+vo.getSeq());
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";			
		}		
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 참여업체 정보 삭제 */
	@CheckGrade(controllerName = "festivalController", controllerMethod = "delSellerVo")
	@RequestMapping("/festival/seller/del/{festivalSeq}")
	public String delSellerVo(@PathVariable Integer festivalSeq, Integer seq, HttpServletRequest request, Model model) {
		String errMsg = "삭제 처리에 실패하였습니다.";
		
		Map<String,Object> map = new HashMap<>();
		map.put("parentCode", "festival_seller");
		map.put("parentSeq", seq);
		List<FilenameVo> fileList = filenameService.getList(map);
		for(FilenameVo vo : fileList) {
			String deletePath = request.getServletContext().getRealPath("/") + vo.getRealFilename();
			LOGGER.info("file>>delete>> " + deletePath);
			new File(deletePath).delete();
			filenameService.deleteVo(vo.getSeq());
		}
		
		try {
			if(festivalService.delSellerVo(seq) == 1) {
				model.addAttribute("message", "정상적으로 삭제 처리 되었습니다.");
				model.addAttribute("returnUrl", "/admin/festival/detail/"+festivalSeq);
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";			
		}		
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 첨부파일 삭제 */
	@RequestMapping("/festival/file/delete/{seq}")
	public String fileDelete(@PathVariable Integer seq, HttpServletRequest request, Model model) {
		String errMsg = "파일 삭제에 실패하였습니다.";
		FilenameVo fvo = filenameService.getVo(seq);
		String deletePath = request.getServletContext().getRealPath("/") + fvo.getRealFilename();

		// 파일을 삭제
		try {
			LOGGER.info("file>>delete>> " + deletePath);
			new File(deletePath).delete();
			if(filenameService.deleteVo(fvo.getSeq())) {
				model.addAttribute("callback", "FILE^파일이 삭제되었습니다.^"+fvo.getSeq());
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + " [" + e.getMessage() + "]";
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 첨부파일 다운로드 */
	@RequestMapping("/festival/file/download/{seq}")
	public void download(@PathVariable Integer seq, HttpServletResponse response) throws Exception {
		FilenameVo fvo = filenameService.getVo(seq);
		
		fvo.setFilename(java.net.URLEncoder.encode(fvo.getFilename(),"UTF-8"));
		
		response.setHeader("Content-Type", "application/octet-stream;");	
		response.setHeader("Content-Disposition", "attachment; filename="+fvo.getFilename());
				
		try {
			FileUtil.write(new FileInputStream(new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "") + fvo.getRealFilename())), response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/** request parameter vo 맵핑 */
	private FestivalVo getFestivalVo(MultipartHttpServletRequest mpRequest) {
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(mpRequest);
		FestivalVo vo = new FestivalVo();
		
		if(map.get("festivalSeq") != null) {
			vo.setFestivalSeq(Integer.valueOf(String.valueOf(map.get("festivalSeq"))));
		}
		
		if(map.get("sellerSeq") != null) {
			vo.setSellerSeq(Integer.valueOf(String.valueOf(map.get("sellerSeq"))));
		}
		
		if(map.get("title") != null) {
			vo.setTitle((String)map.get("title"));
		}
		
		if(map.get("startDate") != null) {
			vo.setStartDate((String)map.get("startDate"));
		}
				
		if(map.get("endDate") != null) {
			vo.setEndDate((String)map.get("endDate"));
		}
		
		if(map.get("content") != null) {
			vo.setContent(StringUtil.clearXSS((String)map.get("content")));
		}

		return vo;
	}
	
	/** 첨부파일 업로드 
	 * @throws IOException */
	private List<FilenameVo> uploadFile(MultipartHttpServletRequest mpRequest, String code) throws IOException {
		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while(iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);

			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				if(formName.indexOf("file") == 0) {
					FilenameVo fvo =  new FilenameVo();
					fvo.setParentCode(code);
					fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
					fvo.setFilename(file.getOriginalFilename());
					fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
					fileList.add(fvo);
				}
			}
		}
		
		return fileList;
	}
}
