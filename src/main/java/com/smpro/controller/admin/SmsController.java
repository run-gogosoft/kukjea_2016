package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.MallService;
import com.smpro.service.MemberService;
import com.smpro.service.SmsService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.SmsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.Calendar;

@Controller
public class SmsController {

	@Autowired
	private SystemService systemService;

	@Autowired
	private MallService mallService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private SmsService smsService;

	@CheckGrade(controllerName = "smsController", controllerMethod = "smsList")
	/** SMS 리스트 */
	@RequestMapping("/sms/list")
	public String smsList(Model model) {
		model.addAttribute("title", "SMS 관리 리스트");
		model.addAttribute("list", smsService.getList());
		return "/sms/list.jsp";
	}

	@CheckGrade(controllerName = "smsController", controllerMethod = "smsLogList")
	/** SMS 발송내역 리스트 */
	@RequestMapping("/sms/log/list")
	public String smsLogList(SmsVo vo, Model model) {
		model.addAttribute("title", "SMS 발송내역 리스트");

		// 특별하게 전체 일정을 잡지 않았다면 일주일간의 내역을 기본 세팅한다
		if ("".equals(vo.getLogDate())) {
			Calendar c = Calendar.getInstance();
			vo.setLogDate(new SimpleDateFormat("yyyyMM").format(c.getTime()));
		}
		vo.setTotalRowCount(smsService.getLogListCount(vo));
		model.addAttribute("list", smsService.getLogList(vo));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		return "/sms/log_list.jsp";
	}

	@CheckGrade(controllerName = "smsController", controllerMethod = "smsForm")
	/** SMS 등록 폼 */
	@RequestMapping("/sms/form")
	public String smsForm(Model model) {
		model.addAttribute("title", "SMS 내용 등록");
		model.addAttribute("mallList", mallService.getListSimple());
		return "/sms/form.jsp";
	}

	@CheckGrade(controllerName = "smsController", controllerMethod = "smsUpdateForm")
	/** SMS 수정 폼 */
	@RequestMapping("/sms/form/{seq}")
	public String smsUpdateForm(@PathVariable Integer seq, Model model) {
		model.addAttribute("title", "SMS 내용 수정");
		model.addAttribute("vo", smsService.getVo(seq));
		model.addAttribute("mallList", mallService.getListSimple());
		return "/sms/form.jsp";
	}

	@RequestMapping("/sms/common/ajax")
	public String getAjaxCommon(String mappingData, Model model) {
		if("O".equals(mappingData)) {
			model.addAttribute("list", systemService.getCommonListByGroup(new Integer(6)));
		} else if("S".equals(mappingData) || "C".equals(mappingData)) {
			model.addAttribute("list", systemService.getCommonListByGroup(new Integer(1)));
		} else if("E".equals(mappingData)) {
			model.addAttribute("list", systemService.getCommonListByGroup(new Integer(32)));
		}
		
		
		return "/ajax/get-common-list.jsp";
	}

	@RequestMapping("/sms/{procType}/proc")
	public String writeProc(@PathVariable String procType, SmsVo vo, Model model) {
		String procTypeStr = "write".equals(procType) ? "등록" : "수정";

		if (vo.getTitle().length() == 0 && "".equals(vo.getTitle())) {
			model.addAttribute("message", "제목이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getTitle().length() != 0 && (vo.getTitle().length() > 30)) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		if ("".equals(vo.getTypeCode())) {
			model.addAttribute("message", "발송대상이 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if ("".equals(vo.getStatusType())) {
			model.addAttribute("message", "상태타입이 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if ("".equals(vo.getStatusCode())) {
			model.addAttribute("message", "상태가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getContent() == null || vo.getContent().length() == 0
				&& "".equals(vo.getContent())) {
			model.addAttribute("message", "내용이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (StringUtil.getByteLength(vo.getContent()) > 129) {
			model.addAttribute("message", "내용은 129바이트 이하로 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		if ("write".equals(procType)) {
			if (!smsService.insertVo(vo)) {
				model.addAttribute("message", "게시물을 등록할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		} else {
			if (!smsService.updateVo(vo)) {
				model.addAttribute("message", "게시물을 수정할 수 없었습니다");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("message", "게시물이 " + procTypeStr + " 되었습니다.");
		model.addAttribute("returnUrl", "/admin/sms/list/");
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "smsController", controllerMethod = "smsDelete")
	@RequestMapping("/sms/delete/{seq}")
	public String smsDelete(@PathVariable Integer seq, Model model) {
		if (!smsService.deleteData(seq)) {
			model.addAttribute("message", "게시물을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "삭제 되었습니다");
		model.addAttribute("returnUrl", "/admin/sms/list");

		return Const.REDIRECT_PAGE;
	}

	/**
	 * SMS 보내기 폼
	 */
	@CheckGrade(controllerName = "smsController", controllerMethod = "smsSendForm")
	@RequestMapping("/sms/send")
	public String smsSendForm(Model model) {
		model.addAttribute("mallList", mallService.getListSimple());
		model.addAttribute("title", "SMS 보내기");
		return "/sms/sms.jsp";
	}
	
	/** SMS 일괄 발송 처리 */
	@CheckGrade(controllerName = "smsController", controllerMethod = "smsSend")
	@RequestMapping("/sms/send/proc")
	public String smsSend(SmsVo svo, Model model) {
		if ("".equals(svo.getTrPhone())) {
			model.addAttribute("message", "SMS 수신 휴대폰 번호 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (StringUtil.isBlank(svo.getTrMsg())) {
			model.addAttribute("message", "메세지가 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (StringUtil.getByteLength(svo.getTrMsg()) > 160) {
			model.addAttribute("message", "메세지는 160byte 이하로 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		String[] memberCells = svo.getTrPhone().split("\r\n");
		int total = memberCells.length;
		for (int i = 0; i < total; i++) {
			memberCells[i] = memberCells[i].trim().replace("-", "");
			
			if("".equals(memberCells[i])) {
				model.addAttribute("message", "비어있는 행이 감지되었습니다. 해당 행들 모두 제거하여 재시도 하시기 바랍니다.");
				return Const.ALERT_PAGE;
			}
			
			if(!StringUtil.isNum(memberCells[i])) {
				model.addAttribute("message", "휴대폰 번호는 숫자('-'포함)로만 이루어져야 합니다.("+(i+1)+"번째 줄)");
				return Const.ALERT_PAGE;
			}
		}
		
		svo.setTrSendStat("0");
		svo.setTrMsgType("0");
		for (int i = 0; i < total; i++) {		
			svo.setTrPhone(memberCells[i]);
			try {
				smsService.insertSmsSendVo(svo);
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "SMS발송에 실패 하였습니다. [" + e.getMessage() + "]\n\n"+(i+1)+"번째에서 중단되었습니다.");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("returnUrl", "/admin/sms/send");
		model.addAttribute("message", total + "건 SMS발송 완료!");
		return Const.REDIRECT_PAGE;
	}
}
