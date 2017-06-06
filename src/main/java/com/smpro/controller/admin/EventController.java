package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.EditorUtil;
import com.smpro.util.StringUtil;
import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class EventController {

	@Autowired
	private EventService eventService;
	@Autowired
	private DisplayService displayService;

	@CheckGrade(controllerName = "eventController", controllerMethod = "list")
	@RequestMapping("/event/list")
	public String list(Integer mallSeq, EventVo vo, Model model) {
		vo.setTotalRowCount(eventService.getListCount(vo).intValue());
		vo.setMallSeq(mallSeq);
		List<EventVo> eventVo = eventService.getList(vo);
		for (int i = 0; i < eventVo.size(); i++) {
			EventVo tmpVo = eventVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(), 150));
		}
//		System.out.println("event/list mallSeq :"+mallSeq+", vo.getmallSeq():"+vo.getMallSeq());
		model.addAttribute("lv1List", eventService.getLv1List(vo));
		model.addAttribute("title", "기획전 / 이벤트 리스트");
		model.addAttribute("list", eventVo);
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		model.addAttribute("mallSeq",mallSeq);
		return "/event/list.jsp";
	}

	@CheckGrade(controllerName = "eventController", controllerMethod = "form")
	@RequestMapping("/event/exhform")
	public String form(Integer mallSeq, Model model) {
		model.addAttribute("title", "기획전 / 이벤트 등록");
		// 몰 리스트
//		MallVo mvo = new MallVo();
		model.addAttribute("mallSeq", mallSeq);
		return "/event/form.jsp";
	}

	@RequestMapping("/event/write/proc")
	public String writeProc(EventVo vo, Model model) {
		if (StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "기획전/이벤트명을 입력해 주세요.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.getByteLength(vo.getTitle()) > 100) {
			model.addAttribute("message", "기획전/이벤트 명이 100 Bytes를 초과하였습니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank("" + vo.getStatusCode())) {
			model.addAttribute("message", "상태가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank("" + vo.getTypeCode())) {
			model.addAttribute("message", "등록구분이 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		if ("1".equals(vo.getTypeCode())) {
			if (StringUtil.isBlank("" + vo.getLv1Seq())) {
				model.addAttribute("message", "대분류 카테고리가 선택되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
			if (StringUtil.isBlank(vo.getShowFlag())) {
				model.addAttribute("message", "노출 여부가 선택되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
		}

		// 시작일 수정
		if (!StringUtil.isBlank(vo.getStartDate())) {
			vo.setStartDate(vo.getStartDate().replace("-", ""));
		}

		// 종료일 수정
		if (!StringUtil.isBlank(vo.getEndDate())) {
			vo.setEndDate(vo.getEndDate().replace("-", ""));
		}
		
		//시퀀스 생성
		eventService.createSeq(vo);
		
		//에디터로 업로드한 이미지 등록
		vo.setHtml(EditorUtil.procImage(vo.getHtml(), vo.getSeq(), "event"));
		
		//이미지 등록
		String realPath = Const.UPLOAD_REAL_PATH + "/plan";
		if (!"".equals(vo.getThumbImg())) {
			vo.setThumbImg(eventService.imageProc(realPath, vo.getThumbImg().replace("/upload/plan/temp/", ""), vo.getSeq()));
		}
		
		// 이벤트 등록
		if (!eventService.insertData(vo)) {
			model.addAttribute("message", "등록 할 수 없었습니다[1]");
			return Const.ALERT_PAGE;
		}		

		model.addAttribute("message", "게시물이 등록 되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/list?mallSeq="+vo.getMallSeq());
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "eventController", controllerMethod = "delProc")
	@RequestMapping("/event/del/proc")
	public String delProc(Integer seq, Model model) {
		EventVo event = new EventVo();
		event.setSeq(seq);
		EventVo ev = eventService.getVo(event);
		Integer mallSeq= ev.getMallSeq();
		System.out.println(">>>mallSEq:"+mallSeq);
		String realPath = Const.UPLOAD_REAL_PATH;
		eventService.deleteFiles(realPath, seq);
		if (!eventService.deleteData(seq)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		//에디터를 통해 업로드한 이미지 삭제
		EditorUtil.deleteImage(seq, "event");
		model.addAttribute("message", "게시물이 삭제 되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/list?mallSeq="+mallSeq);
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "eventController", controllerMethod = "edit")
	@RequestMapping("/event/edit")
	public String edit(String typeCode, EventVo paramVo, Model model) {
		model.addAttribute("title", "기획전 / 이벤트 수정");
		EventVo vo = eventService.getVo(paramVo);

		if (!typeCode.equals(vo.getTypeCode())) {
			model.addAttribute("message", "잘못된 접근입니다");
			return Const.AJAX_PAGE;
		}
		model.addAttribute("vo", vo);
		MallVo mvo = new MallVo();
		return "/event/form.jsp";
	}

	@RequestMapping("/event/edit/proc")
	public String editProc(EventVo vo, Model model) {
		if (StringUtil.isBlank(vo.getTitle())) {
			model.addAttribute("message", "기획전/이벤트명을 입력해 주세요.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.getByteLength(vo.getTitle()) > 100) {
			model.addAttribute("message", "기획전/이벤트 명이 100 Bytes를 초과하였습니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank("" + vo.getStatusCode())) {
			model.addAttribute("message", "상태가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank("" + vo.getTypeCode())) {
			model.addAttribute("message", "등록구분이 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		if ("1".equals(vo.getTypeCode())) {
			//if (StringUtil.isBlank("" + vo.getLv1Seq())) {
			//	model.addAttribute("message", "대분류 카테고리가 선택되지 않았습니다.");
			//	return Const.ALERT_PAGE;
			//}
			if (StringUtil.isBlank(vo.getShowFlag())) {
				model.addAttribute("message", "노출 여부가 선택되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
		}

		// 시작일 수정
		if (!StringUtil.isBlank(vo.getStartDate())) {
			vo.setStartDate(vo.getStartDate().replace("-", ""));
		}
		// 종료일 수정
		if (!StringUtil.isBlank(vo.getEndDate())) {
			vo.setEndDate(vo.getEndDate().replace("-", ""));
		}
		
		String realPath = Const.UPLOAD_REAL_PATH + "/plan";
		if (!"".equals(vo.getThumbImg())) {
			vo.setThumbImg(eventService.imageProc(realPath, vo.getThumbImg().replace("/upload/plan/temp/", ""), vo.getSeq()));
		}

		//에디터로 업로드한 이미지 등록
		vo.setHtml(EditorUtil.procImage(vo.getHtml(), vo.getSeq(), "event"));
				
		// 이벤트 수정
		EventVo event = new EventVo();
		event.setSeq(vo.getSeq());
		EventVo ev = eventService.getVo(event);
		Integer mallSeq= ev.getMallSeq();
		System.out.println(">>>mallSEq:"+mallSeq);


		if (eventService.updateData(vo)) {
			model.addAttribute("message", "게시물이 수정 되었습니다.");
			model.addAttribute("returnUrl",  "/admin/event/list?mallSeq="+mallSeq);
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "게시물을 수정할 수 없었습니다");
		return Const.ALERT_PAGE;
	}

	@CheckGrade(controllerName = "eventController", controllerMethod = "itemEdit")
	@RequestMapping("/event/item/edit")
	public String itemEdit(Integer seq, String lv1, String lv2, String lv3, String searchItemSeq, String searchItemName, EventVo paramVo, Model model) {
		model.addAttribute("title", "기획전 상품 등록/수정");
		model.addAttribute("planTitle", eventService.getVo(paramVo).getTitle());
		model.addAttribute("itemTitle", "판매중인 아이템 목록");

		// 몰 리스트
		MallVo mvo = new MallVo();
		model.addAttribute("titleListVo", eventService.getTitleList(paramVo));
		model.addAttribute("itemListVo", eventService.getItemList(paramVo));
		model.addAttribute("seq", seq);
		model.addAttribute("mallSeq", paramVo.getMallSeq());

		/** 상품 검색값이 null이 아닐경우 검색값 반환 */
		ItemVo searchItemVo = getSearchItemVo(lv1, lv2, lv3, searchItemSeq, searchItemName);
		model.addAttribute("vo", searchItemVo);
		return "/event/item_list.jsp";
	}

	@RequestMapping("/event/plan/list/ajax")
	public String planListForAjax(EventVo vo, Model model) {
		/** 기획전 리스트를 가져옴 */
		vo.setTypeCode("1");
		model.addAttribute("list", eventService.getList(vo));
		return "/ajax/get-plan-list.jsp";
	}

	@RequestMapping("/event/item/title/edit/proc")
	public String editItemListProc(String titleModLv1, String titleModLv2, String titleModLv3, String titleModItemSeq, String titleModItemName, String groupName, Integer seq, EventVo vo, Model model) {
		if (groupName.length() > 60) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		String tmpTitle = eventService.getTitle(vo);
		if (tmpTitle == null || tmpTitle == "") {
			model.addAttribute("message", "추가 되었습니다.");
			String titleOrderNo = eventService.getTitleOrderNo(vo);
			vo.setEventSeq(seq);
			if (titleOrderNo != null) {
				vo.setOrderNo(Integer.parseInt(titleOrderNo) + 1);
			}else{
				vo.setOrderNo(1);
			}

			if (!eventService.insertItemListTitleData(vo)) {
				model.addAttribute("message", "게시물을 수정할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("message", "등록 되었습니다.");
		} else {
			if(vo.getOrderNo()==0){
				model.addAttribute("message", "정렬순서에 0은 입력할수 없습니다.");
				return Const.ALERT_PAGE;
			}
			if (!eventService.updateItemListTitleData(vo)) {
				model.addAttribute("message", "게시물을 수정할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("message", "수정 되었습니다.");
		}

		model.addAttribute("returnUrl", "/admin/event/item/edit?seq=" + seq + "&lv1=" + titleModLv1	+ "&lv2=" + titleModLv2 + "&lv3=" + titleModLv3	+ "&searchItemSeq=" + titleModItemSeq + "&searchItemName=" + titleModItemName + "&mallSeq="	+ vo.getMallSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/event/itemtitle/del/proc")
	public String delItemListProc(String delLv1, String delLv2, String delLv3, String delItemSeq, String delItemName, Integer seq, Integer eventGroupSeq, Integer mallSeq, Model model) {
		if (!eventService.deleteItemTitleData(eventGroupSeq)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "삭제 되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/item/edit?seq=" + seq + "&lv1=" + delLv1 + "&lv2=" + delLv2 + "&lv3=" + delLv3 + "&searchItemSeq=" + delItemSeq + "&searchItemName=" + delItemName + "&mallSeq=" + mallSeq);
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/event/del/batch/proc")
	public String delBatchProc(Integer[] seq, Integer rSeq, Integer mallSeq, Model model) {
		for (int i = 0; i < seq.length; i++) {
			if (!eventService.deleteItemData(seq[i])) {
				model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
			
			//에디터를 통해 업로드한 이미지 삭제
			EditorUtil.deleteImage(seq[i], "event");
		}

		model.addAttribute("message", "게시물이 삭제 되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/item/edit?seq=" + rSeq + "&mallSeq=" + mallSeq);
		return Const.REDIRECT_PAGE;
	}

	/** 상품추가 */
	@RequestMapping("/event/item/write/proc")
	public String regItemProc(@RequestParam Integer[] procSeq, EventVo vo, String insertLv1, String insertLv2, String insertLv3, String insertItemSeq, String insertItemName, Model model) {
		for (int i = 0; i < procSeq.length; i++) {
			vo.setItemSeq(procSeq[i]);

			DisplayLvItemVo dvo = new DisplayLvItemVo();
			dvo.setItemSeq(procSeq[i]);
			if (StringUtil.isBlank(displayService.getItemConfirm(dvo))) {
				continue;
			}
			if (eventService.getEventItemCnt(vo).intValue() > 0) {
				continue;
			}

			// 정렬번호 설정
			String maxOrderNo = eventService.getMaxOrderNo(vo);
			if (maxOrderNo != null) {
				vo.setOrderNo(Integer.parseInt(maxOrderNo) + 1);
			}else{
				vo.setOrderNo(1);
			}

			// insert
			if (!eventService.insertItemData(vo)) {
				model.addAttribute("message", "게시물을 등록할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("message", "상품이 추가 되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/item/edit?seq=" + vo.getSeq() + "&lv1=" + insertLv1 + "&lv2=" + insertLv2 + "&lv3=" + insertLv3 + "&searchItemSeq=" + insertItemSeq + "&searchItemName=" + insertItemName + "&mallSeq=" + vo.getMallSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/event/item/del/proc")
	public String delItemProc(String delLv1, String delLv2, String delLv3, String delItemSeq, String delItemName, Integer seq, Integer eventItemSeq, Integer mallSeq, Model model) {
		if (!eventService.deleteItemData(eventItemSeq)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "삭제 되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/item/edit?seq=" + seq + "&lv1=" + delLv1 + "&lv2=" + delLv2 + "&lv3=" + delLv3 + "&searchItemSeq=" + delItemSeq + "&searchItemName=" + delItemName + "&mallSeq=" + mallSeq);
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/event/item/orderno/edit/proc")
	public String editItemListOrderNoProc(String orderModLv1,
			String orderModLv2, String orderModLv3, String orderModItemSeq,
			String orderModItemName, Integer seq, Integer[] groupSeq,
			Integer[] itemSeq, int[] orderNo, Integer mallSeq, Model model) {
		for (int i = 0; i < orderNo.length; i++) {
			if (orderNo[i] > 999) {
				model.addAttribute("message", "정렬값의 입력길이가 초과되었습니다.");
				return Const.ALERT_PAGE;
			}

			if (orderNo[i] == 0) {
				model.addAttribute("message", "정렬값이 입력되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
		}

		EventVo vo = new EventVo();

		for (int i = 0; i < groupSeq.length; i++) {
			vo.setGroupSeq(groupSeq[i]);
			vo.setItemSeq(itemSeq[i]);
			vo.setOrderNo(orderNo[i]);
			if (!eventService.updateItemListOrderData(vo)) {
				model.addAttribute("message", "게시물을 수정할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		}
		model.addAttribute("message", "정렬 순서가 저장되었습니다.");
		model.addAttribute("returnUrl", "/admin/event/item/edit?seq=" + seq + "&lv1=" + orderModLv1 + "&lv2=" + orderModLv2 + "&lv3=" + orderModLv3 + "&searchItemSeq=" + orderModItemSeq + "&searchItemName=" + orderModItemName + "&mallSeq=" + mallSeq);

		return Const.REDIRECT_PAGE;
	}

	public static ItemVo getSearchItemVo(String lv1, String lv2, String lv3, String itemSeq, String itemName) {
		ItemVo vo = new ItemVo();
		/** 상품 검색값이 null이 아닐경우 */
		if (!StringUtil.isBlank(itemSeq)) {
			vo.setSeq(Integer.valueOf(itemSeq));
		}
		if (!StringUtil.isBlank(itemName)) {
			vo.setName(itemName);
		}
		if (!StringUtil.isBlank(lv1)) {
			vo.setCateLv1Seq(Integer.valueOf(lv1));
		}
		if (!StringUtil.isBlank(lv2)) {
			vo.setCateLv2Seq(Integer.valueOf(lv2));
		}
		if (!StringUtil.isBlank(lv3)) {
			vo.setCateLv3Seq(Integer.valueOf(lv3));
		}
		return vo;
	}
	
	@RequestMapping("/event/comment")
	public String eventList(EventVo evo, Model model){
		/** 현재 진행중인 이벤트 상품리스트를 가져옴 */
		BoardVo vo = new BoardVo();
		vo.setIntegrationSeq(evo.getSeq());
		vo.setPageNum(evo.getPageNum());
		vo.setTotalRowCount(eventService.getCommentListCount(vo));
		List<BoardVo> getList = eventService.getCommentList(vo);
		for(int i=0;i<getList.size();i++){
			BoardVo tmpVo = getList.get(i);
			tmpVo.setContent(StringUtil.cutString(tmpVo.getContent(),220));
		}
		model.addAttribute("title", "기획전 댓글 게시판");
		model.addAttribute("list", getList);
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		model.addAttribute("planTitle", eventService.getVo(evo).getTitle());
		return "/event/comment_view.jsp";
	}
	
	@RequestMapping(value = "/event/thumnail/upload", method = RequestMethod.POST)
	public String upload(HttpServletRequest request,	Model model) {
		// todo : 업로드할 수 있는 권한이 있는지 검사

		Map<String, String> fileMap;
		try {
			fileMap = eventService.uploadImagesByMap(request);
		} catch (IOException ie) {
			log.error(ie.getMessage());
			model.addAttribute("message", "서버상의 문제가 발생했습니다. 관리자에게 문의하여 주십시오.");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (MaxUploadSizeExceededException me) {
			model.addAttribute("message", "한번에 너무 큰 용량의 이미지를 첨부하실 수 없습니다");
			me.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (ImageIsNotAvailableException ie) {
			model.addAttribute("message", "첨부한 파일은 이미지 파일이 아닙니다");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (ImageSizeException se) {
			model.addAttribute("message", "이미지의 사이즈가 올바르지 않습니다");
			se.printStackTrace();
			return Const.ALERT_PAGE;
		}
		
		String files = "";
		if (fileMap != null) {
			if (fileMap.get("file[0]") != null) {
				files += "/upload/plan/temp/" + fileMap.get("file[0]");

			}
		}
		// 업로드된 파일 리스트를 던진다
		model.addAttribute("callback", files);
		return Const.REDIRECT_PAGE;
	}
	
	/** 기획전 댓글 삭제 */
	@CheckGrade(controllerName = "eventController", controllerMethod = "delComment")
	@RequestMapping("/event/plan/comment/delete/{seq}")
	public String delComment(@PathVariable Integer seq, Integer eventSeq, Model model) {		
		if (!eventService.deleteCommentVo(seq)) {
			model.addAttribute("message", "삭제에 실패하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("returnUrl", "/admin/event/comment?seq="+eventSeq);
		model.addAttribute("message", "삭제에 성공하였습니다.");
		return Const.REDIRECT_PAGE;
	}
}
