package com.smpro.controller.shop;

import com.smpro.service.BoardService;
import com.smpro.service.FilenameService;
import com.smpro.util.Const;
import com.smpro.util.FileDownloadUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.BoardVo;
import com.smpro.vo.FilenameVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class CsCenterController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private FilenameService filenameService;

	@RequestMapping("/cscenter/guide")
	public static String guide(Model model) {
		model.addAttribute("title", "이용안내");
		model.addAttribute("on", "04");
		return "/cscenter/guide.jsp";
	}

	@RequestMapping("/cscenter/policy")
	public static String policy(Model model) {
		model.addAttribute("title", "이용약관");
		model.addAttribute("on", "05");
		return "/cscenter/policy.jsp";
	}

	@RequestMapping("/cscenter/privacy")
	public String privacy(Model model){
		model.addAttribute("title", "개인정보처리방침");
		model.addAttribute("on", "06");
		return "/cscenter/privacy.jsp";
	}

	@RequestMapping("/cscenter/reject/email/collection")
	public String rejectEmailCollection(Model model){
		model.addAttribute("title", "이메일 무단수집 거부");
		model.addAttribute("on", "07");
		return "/cscenter/reject_email_collection.jsp";
	}

	@RequestMapping("/cscenter/price")
	public String price(Model model){
		model.addAttribute("title", "가격제안");
		model.addAttribute("on", "10");
		return "/cscenter/price.jsp";
	}

	@RequestMapping("/cscenter/fax")
	public String fax(Model model){
		model.addAttribute("title", "FAX 주문");
		model.addAttribute("on", "11");
		return "/cscenter/fax.jsp";
	}

	@RequestMapping("/cscenter/search/id")
	public String searchId(Model model){
		model.addAttribute("title", "ID/PW 찾기");
		model.addAttribute("on", "13");
		return "/cscenter/search_id.jsp";
	}

	@RequestMapping("/cscenter/search/pw")
	public String searchPw(Model model){
		model.addAttribute("title", "ID/PW 찾기");
		model.addAttribute("on", "13");
		return "/cscenter/search_pw.jsp";
	}

	@RequestMapping("/cscenter/main")
	public String csCenterMain(Model model){
		List<BoardVo> list = null;

		/** 공지사항 */
		BoardVo noticeVo = new BoardVo();
		noticeVo.setCategoryCode(new Integer(1));
		noticeVo.setGroupCode("notice");
		noticeVo.setRowCount(6);
		noticeVo.setTotalRowCount( boardService.getListCount(noticeVo) );

		list = boardService.getList(noticeVo);
		for(int i=0;i<list.size();i++){
			BoardVo tmpVo = list.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),70));
		}
		model.addAttribute("noticeBoardGroup","notice");
		model.addAttribute("noticeList",list);
		model.addAttribute("noticeTotal", new Integer(noticeVo.getTotalRowCount()));
		model.addAttribute("noticePaging", noticeVo.drawPagingNavigation("goPage"));
		model.addAttribute("noticeVo", noticeVo);
		/** FAQ */
		BoardVo faqVo = new BoardVo();
		faqVo.setGroupCode("faq");
		faqVo.setRowCount(6);
		faqVo.setTotalRowCount( boardService.getListCount(faqVo) );

		list = boardService.getList(faqVo);
		for(int i=0;i<list.size();i++){
			BoardVo tmpVo = list.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),70));
		}
		model.addAttribute("faqBoardGroup","faq");
		model.addAttribute("faqList",list);
		model.addAttribute("faqTotal", new Integer(faqVo.getTotalRowCount()));
		model.addAttribute("faqPaging", faqVo.drawPagingNavigation("goPage"));
		model.addAttribute("faqVo", faqVo);

		return "/cscenter/main.jsp";
	}

	/** 고객센터 -> 게시판 리스트 */
	@RequestMapping("/cscenter/list/{boardName}")
	public String list(@PathVariable String boardName, BoardVo pvo , Model model){

		String goPage = "";

		/** 게시판에서 검색항목 드롭박스를 선택 안했을시 디폴트로 title를 검색 */
		if("".equals(pvo.getSearch())){
			pvo.setSearch("title");
		}
		/** FAQ */
		if("faq".equals(boardName)){
			pvo.setGroupCode(boardName);
			pvo.setRowCount(10);
			pvo.setPageCount(3);
			pvo.setTotalRowCount( boardService.getListCount(pvo) );

			List<BoardVo> boardVo = boardService.getList(pvo);
			for(int i=0;i<boardVo.size();i++){
				BoardVo tmpVo = boardVo.get(i);
				tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),125));
				tmpVo.setContent((String)tmpVo.getContent() == null ? "" : StringUtil.restoreClearXSS((String)tmpVo.getContent()));
			}

			model.addAttribute("categoryCode",pvo.getCategoryCode());
			model.addAttribute("boardGroup",boardName);
			model.addAttribute("list",boardVo);
			model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
			model.addAttribute("vo", pvo);
			model.addAttribute("title", "자주하는 질문");
			model.addAttribute("on", "02");
			goPage = "/cscenter/faq_list.jsp";
		}
		/** 공지사항 */
		if("notice".equals(boardName)){
			pvo.setCategoryCode(new Integer(1));
			pvo.setGroupCode(boardName);
			pvo.setRowCount(10);
			pvo.setPageCount(3);
			pvo.setTotalRowCount( boardService.getListCount(pvo) );

			List<BoardVo> boardVo = boardService.getList(pvo);
			for(int i=0;i<boardVo.size();i++){
				BoardVo tmpVo = boardVo.get(i);
				tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),125));
			}
			model.addAttribute("boardGroup",boardName);
			model.addAttribute("list",boardVo);
			model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
			model.addAttribute("vo", pvo);
			model.addAttribute("title", "공지사항");
			model.addAttribute("on", "01");
			goPage = "/cscenter/notice_list.jsp";
		}
		return goPage;
	}

	/** 고객센터 -> 뷰페이지 */
	@RequestMapping("/cscenter/view/{boardName}/{seq}")
	public String view(@PathVariable String boardName, @PathVariable Integer seq, BoardVo paramVo, Model model){

		String goPage = "";
		/** 공지사항 */
		if("notice".equals(boardName)){
			paramVo.setGroupCode(boardName);
			paramVo.setSeq(seq);
			boardService.updateViewCnt(paramVo);
			BoardVo vo = boardService.getVo(paramVo);
			if(!"N".equals(vo.getGroupCode())) {
				model.addAttribute("message", "잘못된 접근 입니다.");
				return Const.ALERT_PAGE;
			}

			//글내용이 아이프레임에 보여질때 오류가 발생할 수 있는 문자 제거
			String content = vo.getContent().replace("\n", "");
			content = content.replace("\r", "");
			content = content.replace("\"", "'");

			model.addAttribute("content", content);
			model.addAttribute("boardGroup",boardName);
			model.addAttribute("vo", vo);
			goPage = "/cscenter/notice_view.jsp";
		}

		String codeName = "";

		if("faq".equals(boardName)) {
			codeName = "faqBoard";
			model.addAttribute("title", "자주하는 질문");
			model.addAttribute("on", "02");
		} else if("notice".equals(boardName)) {
			codeName = "noticeBoard";
			model.addAttribute("title", "공지사항");
			model.addAttribute("on", "01");
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", codeName);
		map.put("parentSeq", seq);
		model.addAttribute("file", filenameService.getList(map));


		return goPage;
	}

	@RequestMapping("/cscenter/{boardName}/file/download/proc")
	public String download(@PathVariable String boardName, @RequestParam int seq, @RequestParam int num, HttpServletResponse response) throws Exception {
		String codeName = "";
		if("faq".equals(boardName)) {
			codeName = "faqBoard";
		} else if("notice".equals(boardName)) {
			codeName = "noticeBoard";
		}


		BoardVo bvo = new BoardVo();
		bvo.setSeq(new Integer(seq));
		bvo.setGroupCode(boardName);
		BoardVo vo = boardService.getVo(bvo);
		if(vo == null) {
			return null;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode",codeName);
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);

		response.setContentType("application/octet-stream; charset=UTF-8;");
		response.setHeader("Content-Disposition", "attachment; filename=\""+ new String(fvo.getFilename().getBytes("utf-8"), "ISO-8859-1") +"\";");

		// 바보같겠지만... upload하는 메서드를 수정하긴 너무 빡셌다. 리얼에서만 돌아가는 것을 확인
		log.info(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		File file = new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		FileDownloadUtil.download(response, file);
		return null;
	}

	@RequestMapping("/cscenter/write/proc/qna")
	public String writeProc(BoardVo vo, HttpSession session, Model model){
		vo.setId((String) session.getAttribute("loginId"));
		vo.setUserSeq((Integer)session.getAttribute("loginSeq"));
		vo.setGroupCode("Q");

		if(StringUtil.isBlank(vo.getTitle())){
			model.addAttribute("message", "제목을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getContent())){
			model.addAttribute("message", "문의 내용을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if (vo.getContent().length() > 4000) {
			model.addAttribute("message", "내용을 4000byte 이하로 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		//시퀀스 생성
		boardService.createSeq(vo);

		if(!boardService.insertData(vo)) {
			model.addAttribute("message", "등록 할 수 없었습니다.");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "등록 되었습니다.");
		model.addAttribute("returnUrl", "/shop/detail/" + vo.getIntegrationSeq());

		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/cscenter/terms")
	public static String termsPage() {
		return "/cscenter/terms.jsp";
	}
}
