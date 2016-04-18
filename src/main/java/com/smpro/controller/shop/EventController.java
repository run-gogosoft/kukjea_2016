package com.smpro.controller.shop;

import com.smpro.service.EventService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.BoardVo;
import com.smpro.vo.EventVo;
import com.smpro.vo.MallVo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.List;

@Controller
public class EventController {
	@Resource(name="eventService")
	private EventService eventService;

	@Resource(name="systemService")
	private SystemService systemService;

	@RequestMapping("/event/plan")
	public String planList(EventVo vo , HttpServletRequest request, Model model){
		
		//쇼핑몰 정보 가져오기
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		/** 현재 진행중인 기획전 상품리스트를 가져옴 */
		vo.setTypeCode("1");
		vo.setStatusCode("Y");
		vo.setMallSeq(mallVo.getSeq());
		//현재날짜 저장
		vo.setCurDate(StringUtil.getDate(0, "yyyyMMdd"));

		List<EventVo> eventVo = eventService.getList(vo);
		for(int i=0;i<eventVo.size();i++){
			EventVo tmpVo = eventVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("list",eventVo);
		model.addAttribute("vo", vo);

		return "/event/plan.jsp";
	}

	@RequestMapping("/event/plan/plansub/{seq}")
	public String planSub(@PathVariable Integer seq, HttpServletRequest request, Model model){
		
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		/** sm_event 내용 */
		//List
		EventVo pvo = new EventVo();
		pvo.setTypeCode("1");
		pvo.setStatusCode("Y");
		pvo.setMallSeq(mallVo.getSeq());
		List<EventVo> getList = eventService.getList(pvo);
		for(int i=0;i<getList.size();i++){
			EventVo tmpVo = getList.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("list",getList);
		//Vo
		EventVo eventVo = new EventVo();
		eventVo.setTypeCode("1");
		eventVo.setStatusCode("Y");
		eventVo.setMallSeq(mallVo.getSeq());
		eventVo.setSeq(seq);
		model.addAttribute("vo", eventService.getVo(eventVo));

		/** sm_event_group 내용 */
		List<EventVo> eventGroupListVo = eventService.getTitleList(eventVo);
		model.addAttribute("groupList", eventGroupListVo);

		for(int i=0;i < eventGroupListVo.size();i++){
			EventVo tmpVo = eventGroupListVo.get(i);
			if(i < 1){
				eventVo.setSeq(tmpVo.getEventSeq());
				break;
			}
		}

		/** sm_event_item 내용 */
		eventVo.setStatusCode("Y");
		List<EventVo> eventItemListVo = eventService.getItemList(eventVo);
		model.addAttribute("itemList", eventItemListVo);
		return "/event/plan_sub.jsp";
	}


	@RequestMapping("/event")
	public String eventList(EventVo vo , HttpServletRequest request, Model model){
		
		//쇼핑몰 정보 가져오기
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		/** 현재 진행중인 이벤트 상품리스트를 가져옴 */
		vo.setTypeCode("2");
		vo.setStatusCode("Y");
		vo.setMallSeq(mallVo.getSeq());
		List<EventVo> eventVo = eventService.getList(vo);
		for(int i=0;i<eventVo.size();i++){
			EventVo tmpVo = eventVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("list",eventVo);
		model.addAttribute("vo", vo);

		return "/event/event.jsp";
	}
	
	@RequestMapping("/event/sub/{seq}")
	public String eventSub(@PathVariable Integer seq, HttpServletRequest request, Model model){
		
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		/** sm_event 내용 */
		EventVo pvo = new EventVo();
		pvo.setTypeCode("2");
		pvo.setStatusCode("Y");
		pvo.setMallSeq(mallVo.getSeq());
		List<EventVo> getList = eventService.getList(pvo);
		for(int i=0;i<getList.size();i++){
			EventVo tmpVo = getList.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("list",getList);
		//Vo
		EventVo eventVo = new EventVo();
		eventVo.setTypeCode("2");
		eventVo.setStatusCode("Y");
		eventVo.setMallSeq(mallVo.getSeq());
		eventVo.setSeq(seq);
		model.addAttribute("vo", eventService.getVo(eventVo));
		return "/event/event_sub.jsp";
	}

	@RequestMapping("/event/eventclose")
	public String eventClose(EventVo vo , HttpServletRequest request, Model model){
		
		//쇼핑몰 정보 가져오기
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		vo.setTypeCode("2");
		vo.setStatusCode("N");
		vo.setMallSeq(mallVo.getSeq());
		List<EventVo> eventVo = eventService.getList(vo);
		for(int i=0;i<eventVo.size();i++){
			EventVo tmpVo = eventVo.get(i);
			tmpVo.setTitle(StringUtil.cutString(tmpVo.getTitle(),150));
		}
		model.addAttribute("list",eventVo);
		model.addAttribute("vo", vo);

		return "/event/event_close.jsp";
	}
	
	@RequestMapping(value="/event/comment/proc", method= RequestMethod.POST)
	public String regDeliverySubmit(HttpSession session, BoardVo vo, Model model) {
		Integer loginSeq = (Integer)session.getAttribute("loginSeq");
		
		if(StringUtil.isBlank((vo.getContent()))) {
			model.addAttribute("message", "내용을 입력해 주세요.");
			return Const.AJAX_PAGE;
		}

		try {
			vo.setUserSeq(loginSeq);
			
			if (!eventService.insertComment(vo)) {
				model.addAttribute("message", "FAIL[1]");
				return Const.AJAX_PAGE;
			}
		} catch(Exception e) {
			model.addAttribute("message", "FAIL[2]");
			return Const.AJAX_PAGE;
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}
	
	@RequestMapping("/event/comment/list")
	public String getAjaxCommentList(BoardVo vo, Model model) {
		model.addAttribute("totalCount", new Integer(eventService.getCommentListCount(vo)));
		vo.setRowCount(10);
		model.addAttribute("list", eventService.getCommentList(vo));
		model.addAttribute("pageNum", new Integer(vo.getPageNum()));
		return "/ajax/get-comment-list.jsp";
	}
	
	@RequestMapping("/event/comment/paging")
	public String getAjaxCommentPaging(BoardVo vo, Model model) {
		vo.setTotalRowCount( eventService.getCommentListCount(vo) );
		vo.setRowCount(10);
		model.addAttribute("message", vo.drawPagingNavigation("goPage"));
		return Const.AJAX_PAGE;
	}
	
	@RequestMapping("/event/plan/comment/delete")
	public String commentDelete(BoardVo vo, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		
		if(!vo.getUserSeq().equals(loginSeq)) {
			model.addAttribute("message", "FAIL[1]");
			return Const.AJAX_PAGE;
		}
		
		if (!eventService.deleteCommentVo(vo.getSeq())) {
			model.addAttribute("message", "FAIL[2]");
			return Const.AJAX_PAGE;
		}
		
		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}
}
