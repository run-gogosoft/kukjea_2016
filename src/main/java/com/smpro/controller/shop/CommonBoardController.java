package com.smpro.controller.shop;

import com.smpro.service.CommonBoardService;
import com.smpro.service.FilenameService;
import com.smpro.service.MenuService;
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
	private MenuService menuService;

	@Autowired
	private FilenameService filenameService;

	@RequestMapping("/about/board/detail/list/{commonBoardSeq}")
	public String detailList(@PathVariable Integer commonBoardSeq, CommonBoardVo vo, Model model) {
		model.addAttribute("title", commonBoardService.getVo(commonBoardSeq).getName());

		model.addAttribute("menuList", menuService.getMainList());
		model.addAttribute("subList", menuService.getAllSubList());

		if("1".equals(commonBoardSeq) || commonBoardSeq.intValue() == 1) {
			vo.setFileCodeName("itemRequest");
		} else if("2".equals(commonBoardSeq) || commonBoardSeq.intValue() == 2) {
			vo.setFileCodeName("sellerRequest");
		} else if("3".equals(commonBoardSeq) || commonBoardSeq.intValue() == 3) {
			vo.setFileCodeName("socialNews");
		}
		vo.setCommonBoardSeq(commonBoardSeq);
		vo.setTotalRowCount(commonBoardService.getDetailListCount(vo));
		model.addAttribute("list", commonBoardService.getDetailList(vo));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);

		CommonBoardVo cvo = commonBoardService.getVo(commonBoardSeq);
		model.addAttribute("cvo", cvo);
		if("B".equals(cvo.getTypeCode())) {
			return "/commonboard/list_bodo.jsp"; // 보도자료게시판
		} else if("Y".equals(cvo.getTypeCode())) {
			return "/commonboard/list_youtube.jsp"; // 유투브게시판
		} else if("G".equals(cvo.getTypeCode())) {
			return "/commonboard/list_gallery.jsp"; // 갤러리게시판
		} else {
			return "/commonboard/list.jsp";
		}
	}

	@RequestMapping("/about/board/detail/form/{commonBoardSeq}")
	public String form(@PathVariable Integer commonBoardSeq, Model model) {

		model.addAttribute("menuList", menuService.getMainList());
		model.addAttribute("subList", menuService.getAllSubList());

		model.addAttribute("title", commonBoardService.getVo(commonBoardSeq).getName());
		model.addAttribute("commonBoardSeq", commonBoardSeq);
		return "/commonboard/form.jsp";
	}

	@RequestMapping("/about/board/detail/view/{seq}")
	public String view(@PathVariable Integer seq, Integer commonBoardSeq, Model model) {

		model.addAttribute("menuList", menuService.getMainList());
		model.addAttribute("subList", menuService.getAllSubList());

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

		commonBoardService.updateViewCnt(seq);

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

		// 댓글
		vo.setBoardSeq(vo.getSeq());
		vo.setRowCount(9999);
		model.addAttribute("clist", commonBoardService.getCommentList(vo));
		model.addAttribute("ctotal", new Integer(commonBoardService.getCommentListTotalCount(vo)));

		CommonBoardVo cvo = commonBoardService.getVo(commonBoardSeq);
		model.addAttribute("cvo", cvo);
		if("G".equals(cvo.getTypeCode())) {
			return "/commonboard/view_gallery.jsp"; // 갤러리게시판
		}
		model.addAttribute("title", cvo.getName());

		return "/commonboard/view.jsp";

	}

	@RequestMapping("/about/board/detail/edit/{seq}")
	public String edit(@PathVariable Integer seq, Model model) {

		model.addAttribute("menuList", menuService.getMainList());
		model.addAttribute("subList", menuService.getAllSubList());

		CommonBoardVo vo = commonBoardService.getDetailVo(seq);
		model.addAttribute("vo", vo);

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "itemRequest");
		map.put("parentSeq", seq);
		model.addAttribute("file", filenameService.getList(map));
		try {
			model.addAttribute("title", commonBoardService.getVo(vo.getCommonBoardSeq()).getName());
		} catch (Exception e) {
			model.addAttribute("title", "비정상적인 접근입니다");
		}
		return "/commonboard/form.jsp";
	}

	@RequestMapping("/about/board/detail/reg/proc")
	public String regProc(HttpServletRequest request, Integer commonBoardSeq, String code, HttpSession session, Model model) {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		CommonBoardVo vo = getCommonBoardVo(map);
		vo.setCommonBoardSeq(commonBoardSeq);

		if(!validCheck(vo, "reg", session, model)){
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
						fvo.setParentCode("itemRequest");
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
		model.addAttribute("returnUrl", "/shop/about/board/detail/list/"+vo.getCommonBoardSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/about/board/detail/edit/proc")
	public String editProc(HttpServletRequest request,  Integer seq, Integer commonBoardSeq, String code, HttpSession session, Model model) {
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		CommonBoardVo vo = getCommonBoardVo(map);
		vo.setSeq(seq);
		vo.setCommonBoardSeq(commonBoardSeq);

		if(!validCheck(vo, "edit", session, model)){
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
						fvo.setParentCode("itemRequest");
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

		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			filenameService.replaceFilename(fvo);
		}

		model.addAttribute("message", "게시물 수정이 완료되었습니다.");
		model.addAttribute("returnUrl", "/shop/about/board/detail/list/"+vo.getCommonBoardSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/about/board/file/delete/proc")
	public String fileDelete(Integer seq, Integer num, HttpServletRequest request, Model model) {
		CommonBoardVo vo = commonBoardService.getDetailVo(seq);
		if(vo == null) {
			model.addAttribute("message", "비정상적인 접근입니다!!");
			return Const.ALERT_PAGE;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "itemRequest");
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
	public String download(Integer seq, Integer num, Integer commonBoardSeq, HttpServletResponse response) throws Exception {
		CommonBoardVo vo = commonBoardService.getDetailVo(seq);
		if(vo == null) {
			return null;
		}

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

	@RequestMapping("/about/board/check/pass/ajax")
	public String checkPass(CommonBoardVo vo, Model model) {
		if("".equals(vo.getUserPassword())) {
			model.addAttribute("message", "ERROR[1]");
			return Const.AJAX_PAGE;
		}

		if(vo.getSeq() == null) {
			model.addAttribute("message", "ERROR[2]");
			return Const.AJAX_PAGE;
		}

		CommonBoardVo cvo = commonBoardService.getDetailVo(vo.getSeq());
		/* 입력받은 패스워드 암호화 */
		try {
			cvo.setUserPassword(StringUtil.encryptSha2(vo.getUserPassword()));
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다.");
			return Const.ALERT_PAGE;
		}

		if(commonBoardService.getPasswordCnt(cvo) > 0) {
			model.addAttribute("message", "true");
			return Const.AJAX_PAGE;
		}

		model.addAttribute("message", "false");
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/about/board/detail/delete/proc")
	public String deleteProc(CommonBoardVo vo, HttpServletRequest request, HttpSession session, Model model) {
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));

		if("C".equals(vo.getLoginType())) {
			//등록되어있는 게시물의 작성자seq와 현재로그인한 사람의 seq가 다르다면 삭제가되어선 안된다.
			if(vo.getUserSeq() != vo.getLoginSeq()) {
				model.addAttribute("message", "게시물을 삭제는 본인만 가능합니다.");
				return Const.ALERT_PAGE;
			}
		}

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

		// 파일이 등록되어 있었다면 삭제한다
		if("Y".equals(vo.getIsFile())) {
			Map<String, Object> map = new HashMap<>();
			map.put("parentCode", "itemRequest");
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

		model.addAttribute("message", "게시물 삭제가 완료되었습니다.");
		model.addAttribute("returnUrl", "/shop/about/board/detail/list/"+vo.getCommonBoardSeq());
		return Const.REDIRECT_PAGE;
	}

	private boolean validCheck(CommonBoardVo vo, String type, HttpSession session, Model model) {
		boolean flag = true;
		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		/* 유효성 검사 */

		//null이라면 비회원 아니라면 회원
		if(StringUtil.isBlank(""+loginSeq)) {
			if("reg".equals(type) && "".equals(vo.getUserName())) {
				model.addAttribute("message", "이름을 입력해주세요.");
				flag = false;
			} else if("Y".equals(vo.getSecretFlag()) && "".equals(vo.getUserPassword())) {
				//비회원이고 비밀글 설정을 하였다면 비밀번호를 입력하여야 한다.
				model.addAttribute("message", "비밀번호를 입력해주세요.");
				flag = false;
			}
		} else {
			vo.setUserSeq(loginSeq);
		}

		if("".equals(vo.getTitle())) {
			model.addAttribute("message", "제목을 입력해주세요.");
			flag = false;
		} else if("".equals(vo.getContent())) {
			model.addAttribute("message", "내용을 입력해주세요.");
			flag = false;
		}
		return flag;
	}

	private CommonBoardVo getCommonBoardVo(HashMap<String, Object> map) {
		CommonBoardVo vo = new CommonBoardVo();
		vo.setUserName((String)map.get("userName") == null ? "" : (String)map.get("userName"));
		vo.setSecretFlag((String)map.get("secretFlag") == null ? "" : (String)map.get("secretFlag"));
		vo.setUserPassword((String)map.get("userPassword") == null ? "" : (String)map.get("userPassword"));
		vo.setTitle((String)map.get("title") == null ? "" : (String)map.get("title"));
		vo.setContent((String)map.get("content") == null ? "" : (String)map.get("content"));
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

		model.addAttribute("message", "정상적으로 등록 되었습니다");
		model.addAttribute("returnUrl", "/shop/about/board/detail/view/"+vo.getBoardSeq()+"?commonBoardSeq="+vo.getCommonBoardSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/about/board/detail/comment/delete")
	public String deleteComment(Integer seq, HttpSession session, Model model) {
		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		if(loginSeq == null || loginSeq.intValue() == 0) {
			model.addAttribute("message", "로그인해야 이용할 수 있습니다");
			return Const.ALERT_PAGE;
		}

		CommonBoardVo original = commonBoardService.getComment(seq);
		if (!original.getUserSeq().equals(loginSeq)) {
			model.addAttribute("message", "본인이 등록한 댓글 외에는 삭제하실 수 없습니다");
			return Const.ALERT_PAGE;
		}


		if(!commonBoardService.deleteComment(seq)) {
			model.addAttribute("message", "삭제에 실패했습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("message", "<script>top.location.reload();</script>");
		return Const.AJAX_PAGE;
	}
}
