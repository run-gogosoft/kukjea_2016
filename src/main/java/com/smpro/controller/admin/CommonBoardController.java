package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.CommonBoardService;
import com.smpro.service.FilenameService;
import com.smpro.util.*;
import com.smpro.vo.CommonBoardVo;
import com.smpro.vo.FilenameVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class CommonBoardController {

	@Autowired
	private CommonBoardService commonBoardService;

	@Autowired
	private FilenameService filenameService;
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "list")
	@RequestMapping("/about/board/list")
	public String list(CommonBoardVo vo, Model model) {
		model.addAttribute("title", "게시판 관리 리스트");
		
		vo.setTotalRowCount(commonBoardService.getListCount(vo));
		model.addAttribute("list", commonBoardService.getList(vo));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		return "/commonboard/list.jsp";
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "form")
	@RequestMapping(value="/about/board/list/proc", method = RequestMethod.POST)
	public String proc(CommonBoardVo vo, Model model) {
		if("".equals(vo.getName().trim())) {
			model.addAttribute("message", "게시판 이름은 반드시 입력되어야 합니다"); 
		} else if(commonBoardService.insertCommonVo(vo)) {
			model.addAttribute("message", "등록되었습니다");
		} else {
			model.addAttribute("message", "등록할 수 없었습니다");
		}
		
		model.addAttribute("returnUrl", "/admin/about/board/list/");
		return Const.REDIRECT_PAGE;
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "form")
	@RequestMapping(value="/about/board/list/edit/proc", method = RequestMethod.POST)
	public String editProc(CommonBoardVo vo, Model model) {
		if("".equals(vo.getName().trim())) {
			model.addAttribute("message", "게시판 이름은 반드시 입력되어야 합니다"); 
		} else if(commonBoardService.updateCommonVo(vo)) {
			model.addAttribute("message", "수정되었습니다");
		} else {
			model.addAttribute("message", "수정할 수 없었습니다");
		}
		
		model.addAttribute("returnUrl", "/admin/about/board/list/");
		return Const.REDIRECT_PAGE;
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "form")
	@RequestMapping("/about/board/list/delete/proc")
	public String deleteProc(Integer seq, Model model) {
		if(commonBoardService.deleteCommonVo(seq)) {
			model.addAttribute("message", "삭제되었습니다");
		} else {
			model.addAttribute("message", "삭제할 수 없었습니다");
		}
		
		model.addAttribute("returnUrl", "/admin/about/board/list/");
		return Const.REDIRECT_PAGE;
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "detailList")
	@RequestMapping("/about/board/detail/list/{commonBoardSeq}")
	public String detailList(@PathVariable Integer commonBoardSeq, CommonBoardVo vo, Model model) {
		model.addAttribute("title", commonBoardService.getVo(commonBoardSeq).getName());
		
		vo.setCommonBoardSeq(commonBoardSeq);
		if("1".equals(commonBoardSeq) || commonBoardSeq.intValue() == 1) {
			vo.setFileCodeName("itemRequest");
		} else if("2".equals(commonBoardSeq) || commonBoardSeq.intValue() == 2) {
			vo.setFileCodeName("sellerRequest");
		} else if("3".equals(commonBoardSeq) || commonBoardSeq.intValue() == 3) {
			vo.setFileCodeName("socialNews");
		}
		vo.setTotalRowCount(commonBoardService.getDetailListCount(vo));
		model.addAttribute("list", commonBoardService.getDetailList(vo));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		CommonBoardVo cvo = commonBoardService.getVo(commonBoardSeq);
		model.addAttribute("cvo", cvo);
		return "/commonboard/detail_list.jsp";
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "view")
	@RequestMapping("/about/board/detail/view/{seq}")
	public String view(@PathVariable Integer seq, Integer commonBoardSeq, Model model) {
		String codeName = "";
		if("1".equals(commonBoardSeq) || commonBoardSeq.intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(commonBoardSeq) || commonBoardSeq.intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(commonBoardSeq) || commonBoardSeq.intValue() == 3) {
			codeName =  "socialNews";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		model.addAttribute("file", filenameService.getList(map));
		
		//글 내용이 아이프레임에 보여질때 오류가 발생할 수 있는 문자 제거
		CommonBoardVo vo = commonBoardService.getDetailVo(seq);
		
		String content = vo.getContent().replace("\n", "");
		content = content.replace("\r", "");
		content = content.replace("\"", "'");
		vo.setContent(content);
		
		String answer = vo.getAnswer().replace("\n", "");
		answer = answer.replace("\r", "");
		answer = answer.replace("\"", "'");
		vo.setAnswer(answer);
		
		model.addAttribute("vo", vo);
		CommonBoardVo cvo = commonBoardService.getVo(commonBoardSeq);
		model.addAttribute("cvo", cvo);
		
		// 댓글
		vo.setBoardSeq(vo.getSeq());
		vo.setRowCount(9999);
		model.addAttribute("clist", commonBoardService.getCommentList(vo));
		model.addAttribute("ctotal", new Integer(commonBoardService.getCommentListTotalCount(vo)));
		return "/commonboard/view.jsp";
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "form")
	@RequestMapping("/about/board/detail/form/{commonBoardSeq}")
	public String form(@PathVariable Integer commonBoardSeq, Model model) {
		CommonBoardVo cvo = commonBoardService.getVo(commonBoardSeq);
		model.addAttribute("title", cvo.getName());
		model.addAttribute("cvo", cvo);
		model.addAttribute("commonBoardSeq", commonBoardSeq);
		
		if("B".equals(cvo.getTypeCode())) {
			return "/commonboard/form_bodo.jsp"; // 보도자료게시판
		} else if("Y".equals(cvo.getTypeCode())) {
			return "/commonboard/form_youtube.jsp"; // 유투브게시판
		} else if("G".equals(cvo.getTypeCode())) {
			return "/commonboard/form_gallery.jsp"; // 갤러리게시판
		} else {
			return "/commonboard/form.jsp";
		}
	}
	
	@CheckGrade(controllerName = "commonBoardController", controllerMethod = "edit")
	@RequestMapping("/about/board/detail/edit/{seq}")
	public String edit(@PathVariable Integer seq, Integer commonBoardSeq, Model model) {
		CommonBoardVo cvo = commonBoardService.getVo(commonBoardSeq);
		model.addAttribute("cvo", cvo);
		model.addAttribute("vo", commonBoardService.getDetailVo(seq));
		
		String codeName = "";
		if("1".equals(commonBoardSeq) || commonBoardSeq.intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(commonBoardSeq) || commonBoardSeq.intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(commonBoardSeq) || commonBoardSeq.intValue() == 3) {
			codeName =  "socialNews";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		model.addAttribute("file", filenameService.getList(map));
		
		if("B".equals(cvo.getTypeCode())) {
			return "/commonboard/form_bodo.jsp"; // 보도자료게시판
		} else if("Y".equals(cvo.getTypeCode())) {
			return "/commonboard/form_youtube.jsp"; // 유투브게시판
		} else if("G".equals(cvo.getTypeCode())) {
			return "/commonboard/form_gallery.jsp"; // 갤러리게시판
		} else {
			return "/commonboard/form.jsp";
		}
	}
	
	@RequestMapping("/about/board/detail/reg/proc")
	public String regProc(HttpServletRequest request, Integer commonBoardSeq, String code, HttpSession session, Model model) {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		CommonBoardVo vo = getCommonBoardVo(map);
		vo.setCommonBoardSeq(commonBoardSeq);
		vo.setUserSeq((Integer) session.getAttribute("loginSeq"));
		if(!validCheck(vo, session, model)){
			return Const.ALERT_PAGE;
		}
		
		String codeName = "";
		if("1".equals(commonBoardSeq) || commonBoardSeq.intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(commonBoardSeq) || commonBoardSeq.intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(commonBoardSeq) || commonBoardSeq.intValue() == 3) {
			codeName =  "socialNews";
		}
		
		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while (iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);
			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				try {
					if(formName.indexOf("file") == 0) {
						FilenameVo fvo =  new FilenameVo();
						fvo.setParentCode(codeName);
						fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
						fvo.setFilename(file.getOriginalFilename());
						fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
						fileList.add(fvo);
					}
				} catch(Exception e) {
					log.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}
		
		//시퀀스 생성
		commonBoardService.createSeq(vo);
		
		//에디터로 업로드한 이미지 등록
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "common_board"));
		
		try {
			if (!commonBoardService.insertVo(vo)) {
				model.addAttribute("message", "게시물을 등록할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "게시물 등록중 오류가 발생하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			fvo.setParentSeq(vo.getSeq());
			filenameService.replaceFilename(fvo);
		}
		
		model.addAttribute("message", "게시물 등록이 완료되었습니다.");
		model.addAttribute("returnUrl", "/admin/about/board/detail/list/"+vo.getCommonBoardSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/about/board/detail/edit/proc")
	public String editProc(HttpServletRequest request, Integer seq, Integer commonBoardSeq, String code, HttpSession session, Model model) {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		CommonBoardVo vo = getCommonBoardVo(map);
		vo.setSeq(seq);
		vo.setCommonBoardSeq(commonBoardSeq);
		
		if(!validCheck(vo, session, model)){
			return Const.ALERT_PAGE;
		}
		
		String codeName = "";
		if("1".equals(commonBoardSeq) || commonBoardSeq.intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(commonBoardSeq) || commonBoardSeq.intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(commonBoardSeq) || commonBoardSeq.intValue() == 3) {
			codeName =  "socialNews";
		}
		
		//에디터로 업로드한 이미지 등록
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "common_board"));
		
		try {
			if (!commonBoardService.updateVo(vo)) {
				model.addAttribute("message", "게시물을 수정할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "게시물 수정중 오류가 발생하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while (iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);

			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				try {
					if(formName.indexOf("file") == 0) {
						FilenameVo fvo =  new FilenameVo();
						fvo.setParentCode(codeName);
						fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
						fvo.setFilename(file.getOriginalFilename());
						fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
						fvo.setParentSeq(vo.getSeq());
						fileList.add(fvo);
					}
				} catch(Exception e) {
					log.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}
		
		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			filenameService.replaceFilename(fvo);
		}
		
		model.addAttribute("message", "게시물 수정이 완료되었습니다.");
		model.addAttribute("returnUrl", "/admin/about/board/detail/view/"+vo.getSeq()+"?commonBoardSeq="+commonBoardSeq);
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping("/about/board/detail/delete/proc")
	public String deleteProc(HttpServletRequest request, CommonBoardVo vo, HttpSession session, Model model) {
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		
		if("C".equals(vo.getLoginType())) {
			//등록되어있는 게시물의 작성자seq와 현재로그인한 사람의 seq가 다르다면 삭제가되어선 안된다.
			if(vo.getUserSeq() != vo.getLoginSeq()) {
				model.addAttribute("message", "게시물을 삭제는 본인만 가능합니다.");
				return Const.ALERT_PAGE;
			}
		}
		
		String codeName = "";
		if("1".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 3) {
			codeName =  "socialNews";
		}
		
		CommonBoardVo dvo = commonBoardService.getDetailVo(vo.getSeq());
		
		// 파일이 등록되어 있었다면 삭제한다
		if("Y".equals(dvo.getIsFile())) {
			Map<String, Object> map = new HashMap<>();
			map.put("parentCode", codeName);
			map.put("parentSeq", vo.getSeq());
				List<FilenameVo> list = filenameService.getList(map);
			for(FilenameVo fvo : list) {
				try {
					new File(request.getServletContext().getRealPath("/") + fvo.getRealFilename()).delete();
					filenameService.deleteVo(fvo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		//에디터로 업로드한 이미지 삭제
		EditorUtil.deleteImage(vo.getSeq(), "common_board");
		
		try {
			if (!commonBoardService.deleteContentVo(vo)) {
				model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "게시물 삭제중 오류가 발생하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "게시물 삭제가 완료되었습니다.");
		model.addAttribute("returnUrl", "/admin/about/board/detail/list/"+vo.getCommonBoardSeq());
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping("/about/board/file/delete/proc")
	public String fileDelete(Integer seq, Integer num, HttpServletRequest request, Model model) {
		CommonBoardVo vo = commonBoardService.getDetailVo(seq);
		if(vo == null) {
			model.addAttribute("message", "비정상적인 접근입니다!!");
			return Const.ALERT_PAGE;
		}
		
		String codeName = "";
		if("1".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 3) {
			codeName =  "socialNews";
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		map.put("num", num);

		FilenameVo fvo = filenameService.getVo(map);
		String deletePath = request.getServletContext().getRealPath("/") + fvo.getRealFilename();

		// 파일을 삭제
		try {
			log.info("file>>delete>> " + deletePath);
			filenameService.deleteVo(fvo);
			new File(deletePath).delete();
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		model.addAttribute("callback", num);
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping("/about/board/file/download/proc")
	public String download(Integer seq, Integer num, HttpServletResponse response) throws Exception {
		CommonBoardVo vo = commonBoardService.getDetailVo(seq);
		if(vo == null) {
			return null;
		}
		
		String codeName = "";
		if("1".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 1) {
			codeName = "itemRequest";
		} else if("2".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 2) {
			codeName = "sellerRequest";
		} else if("3".equals(vo.getCommonBoardSeq()) || vo.getCommonBoardSeq().intValue() == 3) {
			codeName =  "socialNews";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		map.put("num", num);

		FilenameVo fvo = filenameService.getVo(map);

		response.setContentType("application/octet-stream; charset=UTF-8;");
		response.setHeader("Content-Disposition", "attachment; filename=\""+ new String(fvo.getFilename().getBytes("utf-8"), "ISO-8859-1") +"\";");

		// 바보같겠지만... upload하는 메서드를 수정하긴 너무 빡셌다. 리얼에서만 돌아가는 것을 확인
		log.info(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		File file = new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		FileDownloadUtil.download(response, file);
		return null;
	}
	
	private boolean validCheck(CommonBoardVo vo, HttpSession session, Model model) {
		boolean flag = true;
		Integer loginSeq = (Integer)session.getAttribute("loginSeq"); 
		
		if("".equals(vo.getAnswer())) {
			if("".equals(vo.getNoticeFlag())) {
				model.addAttribute("message", "공지여부를 선택해주세요.");
				flag = false;
			} else if("".equals(vo.getTitle())) {
				model.addAttribute("message", "제목을 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getContent())) {
				model.addAttribute("message", "내용을 입력해주세요.");
				flag = false;
			}
			vo.setUserSeq(loginSeq);
		} else {
			vo.setAnswerSeq(loginSeq);
		}
	
		if(!"".equals(vo.getAnswer())) {
			vo.setAnswerSeq(loginSeq);
		}
		
		return flag;
	}
	
	private CommonBoardVo getCommonBoardVo(HashMap<String, Object> map) {
		CommonBoardVo vo = new CommonBoardVo();
		vo.setUserName((String)map.get("userName") == null ? "" : (String)map.get("userName"));
		vo.setSecretFlag((String)map.get("secretFlag") == null ? "" : (String)map.get("secretFlag"));
		vo.setNoticeFlag((String)map.get("noticeFlag") == null ? "" : (String)map.get("noticeFlag"));
		vo.setUserPassword((String)map.get("userPassword") == null ? "" : (String)map.get("userPassword"));
		vo.setTitle((String)map.get("title") == null ? "" : (String)map.get("title"));
		vo.setContent((String)map.get("content") == null ? "" : StringUtil.clearXSS((String)map.get("content")));
		vo.setAnswer((String)map.get("answer") == null ? "" : StringUtil.clearXSS((String)map.get("answer")));
		return vo;
	}
	
	@RequestMapping(value = "/about/board/detail/comment/insert", method = RequestMethod.POST)
	public String insertComment(CommonBoardVo vo, HttpSession session, Model model) {
		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		if(loginSeq == null || loginSeq.intValue() == 0) {
			model.addAttribute("message", "로그인해야 댓글을 달 수 있습니다");
			return Const.ALERT_PAGE;
		}
		
		vo.setUserSeq(loginSeq);
		if(!commonBoardService.insertComment(vo)) {
			model.addAttribute("message", "댓글을 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "<script>alert('정상적으로 등록 되었습니다');top.location.reload();</script>");
		return Const.AJAX_PAGE;
	}
	
	
	@RequestMapping("/about/board/detail/comment/delete")
	public String deleteComment(Integer seq, Model model) {
		// 관리자 페이지라서 별도의 유저 체크를 하지 않는다

		if(!commonBoardService.deleteComment(seq)) {
			model.addAttribute("message", "삭제에 실패했습니다");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "<script>top.location.reload();</script>");
		return Const.AJAX_PAGE;
	}
}
