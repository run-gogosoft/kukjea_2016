package com.smpro.controller.admin;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.FilenameService;
import com.smpro.service.MallService;
import com.smpro.service.MemberService;
import com.smpro.service.SystemService;
import com.smpro.vo.CommonVo;
import com.smpro.vo.FilenameVo;
import com.smpro.vo.MallVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.smpro.service.BoardService;
import com.smpro.util.CommonServletUtil;
import com.smpro.util.Const;
import com.smpro.util.EditorUtil;
import com.smpro.util.FileDownloadUtil;
import com.smpro.util.FileUploadUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.BoardVo;

@Controller
public class BoardController {
	private static final Logger LOGGER = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name = "boardService")
	private BoardService boardService;

	@Resource(name = "memberService")
	private MemberService memberService;

	@Resource(name = "mallService")
	private MallService mallService;
	
	@Resource(name = "filenameService")
	private FilenameService filenameService;
	
	@Resource(name="systemService")
	private SystemService systemService;

	@CheckGrade(controllerName = "boardController", controllerMethod = "list")
	@RequestMapping("/board/list/{boardName}")
	public String list(HttpServletRequest request,	@PathVariable String boardName, BoardVo vo, Model model) {
		HttpSession session = request.getSession(false);
		
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		model.addAttribute("loginSeq", loginSeq);

		// 게시판에서 검색항목 드롭박스를 선택 안했을시 디폴트로 title를 검색

		/** 입점업체, 총판으로 로그인 했을떄 필요한 로그인 시퀀스 */
		vo.setLoginSeq(loginSeq);
		if ("notice".equals(boardName)) {
			vo.setLoginType((String) session.getAttribute("loginType"));
			vo.setGroupCode(boardName);
			vo.setTotalRowCount(boardService.getListCount(vo));

			List<BoardVo> boardVo = boardService.getList(vo);
			for (int i = 0; i < boardVo.size(); i++) {

				BoardVo tmpVo = boardVo.get(i);
				tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 150));
			}

			model.addAttribute("title", "공지사항 게시판");
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("list", boardVo);
			model.addAttribute("total", new Integer(vo.getTotalRowCount()));
			model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
			model.addAttribute("vo", vo);
		}

		else if ("one".equals(boardName)) {
			vo.setGroupCode(boardName);
			vo.setTotalRowCount(boardService.getListCount(vo));

			List<BoardVo> boardVo = boardService.getList(vo);
			for (int i = 0; i < boardVo.size(); i++) {

				BoardVo tmpVo = boardVo.get(i);
				tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 150));
			}

			model.addAttribute("mallList", mallService.getListSimple());
			model.addAttribute("title", "1:1문의 게시판");
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("list", boardVo);
			model.addAttribute("total", new Integer(vo.getTotalRowCount()));
			model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
			model.addAttribute("vo", vo);
			CommonVo cvo = new CommonVo();
			//1:1문의 구분 코드
			cvo.setGroupCode(new Integer(36));
			model.addAttribute("commonList", systemService.getCommonList(cvo));
		}

		else if ("qna".equals(boardName)) {
			vo.setLoginType((String) session.getAttribute("loginType"));
			vo.setGroupCode(boardName);
			vo.setTotalRowCount(boardService.getListCount(vo));
			List<BoardVo> boardVo = boardService.getList(vo);
			for (int i = 0; i < boardVo.size(); i++) {
				BoardVo tmpVo = boardVo.get(i);
				tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 150));
			}

			model.addAttribute("mallList", mallService.getListSimple());
			model.addAttribute("title", "상품문의 게시판");
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("list", boardVo);
			model.addAttribute("total", new Integer(vo.getTotalRowCount()));
			model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
			model.addAttribute("vo", vo);
		}

		else if ("faq".equals(boardName)) {
			vo.setGroupCode(boardName);
			vo.setTotalRowCount(boardService.getListCount(vo));

			List<BoardVo> boardVo = boardService.getList(vo);
			for (int i = 0; i < boardVo.size(); i++) {

				BoardVo tmpVo = boardVo.get(i);
				tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 150));
			}

			model.addAttribute("title", "자주묻는질문 게시판");
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("list", boardVo);
			model.addAttribute("total", new Integer(vo.getTotalRowCount()));
			model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
			model.addAttribute("vo", vo);
		}
		return "/board/list.jsp";
	}

	@CheckGrade(controllerName = "boardController", controllerMethod = "form")
	@RequestMapping("/board/form/{boardName}")
	public String form(@PathVariable String boardName, Model model) {
		model.addAttribute("mallList", mallService.getListSimple());
		if ("notice".equals(boardName)) {
			model.addAttribute("title", " 공지사항 등록");
		} else if ("faq".equals(boardName)) {
			model.addAttribute("title", " 자주묻는 질문 등록");
		}
		model.addAttribute("boardGroup", boardName);
		return "/board/form.jsp";
	}

	@RequestMapping("/board/write/proc/{boardName}")
	public String writeProc(HttpServletRequest request, HttpSession session, @PathVariable String boardName, String code, Model model) {
		String codeName = "";
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		BoardVo vo = getBoardVo(map, boardName);
		
		if (vo.getTitle().length() != 0 && (vo.getTitle().length() > 100)) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getTitle().length() == 0 && "".equals(vo.getTitle())) {
			model.addAttribute("message", "제목이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getContent() == null || vo.getContent().length() == 0 && "".equals(vo.getContent())) {
			model.addAttribute("message", "내용이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getCategoryCode() == null) {
			model.addAttribute("message", "구분이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		
		if ("notice".equals(boardName)) {
			vo.setGroupCode("N");
			codeName = "noticeBoard";
		} else if ("faq".equals(boardName)) {
			vo.setGroupCode("F");
			codeName = "faqBoard";
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
					LOGGER.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}

		vo.setUserSeq((Integer)session.getAttribute("loginSeq"));
		//시퀀스 생성
		boardService.createSeq(vo);
		
		//에디터 이미지 업로드 기능 처리
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "board"));
		
		if (!boardService.insertData(vo)) {
			model.addAttribute("message", "게시물을 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			fvo.setParentSeq(vo.getSeq());
			filenameService.replaceFilename(fvo);
		}
		
		model.addAttribute("message", "게시물이 등록 되었습니다.");
		model.addAttribute("returnUrl", "/admin/board/list/" + boardName);
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "boardController", controllerMethod = "edit")
	@RequestMapping("/board/edit/{boardName}/{seq}")
	public String edit(HttpServletRequest request, @PathVariable String boardName, @PathVariable Integer seq, BoardVo paramVo, Model model) {
		String codeName = "";
		/* 로그인 세션 체크 */
		if (request.getSession().getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 후 이용하세요.");
			model.addAttribute("returnUrl", "/admin/login?goUrl=/admin/board/edit/" + boardName + "/" + seq);
			return Const.REDIRECT_PAGE;
		}

		MallVo mvo = new MallVo();

		model.addAttribute("mallList", mallService.getList(mvo));	

		if ("notice".equals(boardName)) {
			codeName = "noticeBoard";
			model.addAttribute("title", "공지사항");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"N".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("vo", vo);
		}

		else if ("one".equals(boardName)) {
			codeName = "directBoard";
			model.addAttribute("title", "1:1문의");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"O".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("vo", vo);
			CommonVo cvo = new CommonVo();
			//1:1문의 구분 코드
			cvo.setGroupCode(new Integer(36));
			model.addAttribute("commonList", systemService.getCommonList(cvo));
		}

		else if ("qna".equals(boardName)) {
			codeName = "qnaBoard";
			model.addAttribute("title", "상품 문의(Q&A)");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"Q".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("vo", vo);
		}

		else if ("faq".equals(boardName)) {
			codeName = "faqBoard";
			model.addAttribute("title", "자주 묻는 질문");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"F".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("vo", vo);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		model.addAttribute("file", filenameService.getList(map));
		return "/board/form.jsp";
	}

	@RequestMapping("/board/edit/proc/{boardName}/{seq}")
	public String editProc(String answer, @PathVariable String boardName, String code, @PathVariable Integer seq, HttpServletRequest request, HttpSession session, Model model) {
		String codeName = "";
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		BoardVo vo = getBoardVo(map, boardName);
		vo.setSeq(seq);
		vo.setGroupCode(boardName);

		if ("one".equals(boardName)) {
			codeName = "directBoard";
			vo.setAnswerSeq((Integer) session.getAttribute("loginSeq"));
			if (answer == null || answer.length() == 0 && answer == "") {
				model.addAttribute("message", "답변이 입력되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
		} else if("qna".equals(boardName)) {
			codeName = "qnaBoard";
			vo.setAnswerSeq((Integer) session.getAttribute("loginSeq"));
			if (answer == null || answer.length() == 0 && answer == "") {
				model.addAttribute("message", "답변이 입력되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
		} else if("faq".equals(boardName)) {
			codeName = "faqBoard";
		} else if("notice".equals(boardName)) {
			codeName = "noticeBoard";
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
					LOGGER.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}

		//에디터 이미지 업로드 기능 처리
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "board"));
				
		if (!boardService.updateData(vo)) {
			model.addAttribute("message", "게시물을 수정할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		// 파일 내역을 DB에 저장한다
		for(FilenameVo fvo : fileList) {
			filenameService.replaceFilename(fvo);
		}
					

		model.addAttribute("message", "게시물이 수정 되었습니다.");
		model.addAttribute("returnUrl", "/admin/board/list/" + boardName);

		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "boardController", controllerMethod = "delProc")
	@RequestMapping("/board/del/proc/{boardName}/{seq}")
	public String delProc(@PathVariable String boardName, @PathVariable Integer seq, HttpServletRequest request, Model model) {
		String code = "";
		BoardVo vo = new BoardVo();
		vo.setSeq(seq);
		vo.setGroupCode(boardName);
		
		if("one".equals(boardName)) {
			code = "directBoard";
		} else if("notice".equals(boardName)) {
			code = "noticeBoard";
		} else if("faq".equals(boardName)) {
			code = "faqBoard";
		} else if("qna".equals(boardName)) {
			code = "qnaBoard";
		} 
		
		BoardVo dvo = boardService.getVo(vo);
		// 파일이 등록되어 있었다면 삭제한다
		if(dvo != null) {
			if("Y".equals(dvo.getIsFile())) {
				Map<String, Object> map = new HashMap<>();
				map.put("parentCode", code);
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
		}
		
		//에디터를 통해 업로드한 이미지 삭제
		EditorUtil.deleteImage(seq, "board");
				
		if (!boardService.deleteData(vo)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			model.addAttribute("returnUrl", "/admin/board/list/" + boardName);
			return Const.REDIRECT_PAGE;
		}
		
		model.addAttribute("message", "삭제 되었습니다");
		model.addAttribute("returnUrl", "/admin/board/list/" + boardName);

		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "boardController", controllerMethod = "view")
	@RequestMapping("/board/view/{boardName}/{seq}")
	public String view(HttpServletRequest request, @PathVariable String boardName, @PathVariable Integer seq, BoardVo paramVo, Model model) {
		String codeName = "";
		if (request.getSession().getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 후 이용하세요.");
			model.addAttribute("returnUrl",	"/admin/login?goUrl=/admin/board/view/" + boardName + "/" + seq);
			return Const.REDIRECT_PAGE;
		}

		String loginSeq = String.valueOf(request.getSession().getAttribute("loginSeq"));
		model.addAttribute("loginSeq", loginSeq);
		if ("notice".equals(boardName)) {
			codeName = "noticeBoard";
			model.addAttribute("title", "공지사항");

			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			if ("S".equals(request.getSession().getAttribute("loginType"))) {
				boardService.updateViewCnt(paramVo);
			}
			BoardVo vo = boardService.getVo(paramVo);
			if (!"N".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			
			//글 내용이 아이프레임에 보여질때 오류가 발생할 수 있는 문자 제거
			String content = vo.getContent().replace("\n", "");
			content = content.replace("\r", "");
			content = content.replace("\"", "'");
			vo.setContent(content);
			
			model.addAttribute("vo", vo);
		}

		else if ("one".equals(boardName)) {
			codeName = "directBoard";
			model.addAttribute("title", "1:1문의(Q&A)");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"O".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("vo", vo);
			CommonVo cvo = new CommonVo();
			//1:1문의 구분 코드
			cvo.setGroupCode(new Integer(36));
			model.addAttribute("commonList", systemService.getCommonList(cvo));
		}

		else if ("qna".equals(boardName)) {
			codeName = "qnaBoard";
			model.addAttribute("title", "상품 문의");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"Q".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			model.addAttribute("vo", vo);
		}

		else if ("faq".equals(boardName)) {
			codeName = "faqBoard";
			model.addAttribute("title", "자주 묻는 질문");
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			BoardVo vo = boardService.getVo(paramVo);
			if (!"F".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근입니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("boardGroup", boardName);
			
			//글 내용이 아이프레임에 보여질때 오류가 발생할 수 있는 문자 제거
			String content = vo.getContent().replace("\n", "");
			content = content.replace("\r", "");
			content = content.replace("\"", "'");
			vo.setContent(content);
			
			model.addAttribute("vo", vo);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		model.addAttribute("file", filenameService.getList(map));
		return "/board/view.jsp";
	}
	
	@RequestMapping("/board/{boardName}/file/download/proc")
	public String download(@PathVariable String boardName, Integer seq, Integer num, HttpServletResponse response, Model model) throws Exception {
		String codeName = "";
		BoardVo paramVo = new BoardVo();
		paramVo.setSeq(seq);
		paramVo.setGroupCode(boardName);
		BoardVo vo = boardService.getVo(paramVo);
		if(vo == null) {
			model.addAttribute("message", "비정상적인 접근입니다!!");
			return null;
		}
		
		if("one".equals(boardName)) {		
			codeName = "directBoard";
		} else if("notice".equals(boardName)) {		
			codeName = "noticeBoard";
		} else if("qna".equals(boardName)) {		
			codeName = "qnaBoard";
		} else if("faq".equals(boardName)) {		
			codeName = "faqBoard";
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		map.put("num", num);

		FilenameVo fvo = filenameService.getVo(map);

		response.setContentType("application/octet-stream; charset=UTF-8;");
		response.setHeader("Content-Disposition", "attachment; filename=\""+ new String(fvo.getFilename().getBytes("utf-8"), "ISO-8859-1") +"\";");

		// 바보같겠지만... upload하는 메서드를 수정하긴 너무 빡셌다. 리얼에서만 돌아가는 것을 확인
		LOGGER.info(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		File file = new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		FileDownloadUtil.download(response, file);
		return null;
	}
	
	@RequestMapping("/board/{boardName}/file/delete/proc")
	public String fileDelete(@PathVariable String boardName, @RequestParam int seq, @RequestParam int num, HttpServletRequest request, Model model) {
		String codeName = "";
		BoardVo paramVo = new BoardVo();
		paramVo.setSeq(new Integer(seq));
		paramVo.setGroupCode(boardName);
		BoardVo vo = boardService.getVo(paramVo);
		if(vo == null) {
			return null;
		}
		
		if("one".equals(boardName)) {		
			codeName = "directBoard";
		} else if("notice".equals(boardName)) {		
			codeName = "noticeBoard";
		} else if("qna".equals(boardName)) {		
			codeName = "qnaBoard";
		} else if("faq".equals(boardName)) {		
			codeName = "faqBoard";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);
		String deletePath = request.getServletContext().getRealPath("/") + fvo.getRealFilename();

		// 파일을 삭제
		try {
			LOGGER.info("file>>delete>> " + deletePath);
			filenameService.deleteVo(fvo);
			new File(deletePath).delete();
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}

		model.addAttribute("callback", new Integer(num));
		return Const.REDIRECT_PAGE;
	}
	
	private BoardVo getBoardVo(HashMap<String, Object> map, String boardName) {
		BoardVo vo = new BoardVo();
		if("notice".equals(boardName) || "faq".equals(boardName)) {
			vo.setCategoryCode(Integer.valueOf((String)map.get("categoryCode")));			
		} else if("one".equals(boardName) || "qna".equals(boardName)) {
			vo.setAnswer((String)map.get("answer") == null ? "" : (String)map.get("answer"));
		}
		vo.setTitle((String)map.get("title") == null ? "" : (String)map.get("title"));
		vo.setContent((String)map.get("content") == null ? "" : StringUtil.clearXSS((String)map.get("content")));
		return vo;
	}
}
