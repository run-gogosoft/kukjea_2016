package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.AdjustService;
import com.smpro.service.OrderService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.AdjustVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;

@Controller
public class AdjustController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private AdjustService adjustService;

	@Autowired
	private SystemService systemService;

	/** 정산 리스트 */
	@CheckGrade(controllerName = "adjustController", controllerMethod = "getList")
	@RequestMapping("/adjust/list")
	public String getList(HttpSession session, AdjustVo pvo, Model model) {
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		// 현재년 설정
		pvo.setLastYear(StringUtil.getDate(0, "yyyy"));
		// 기본 검색년월 설정
		if ("".equals(pvo.getYear()) || "".equals(pvo.getMonth())) {
			pvo.setYear(StringUtil.getDate(0, "yyyy"));
			pvo.setMonth(StringUtil.getMonth(0, "MM"));
		}
		pvo.setAdjustDate(pvo.getYear()+pvo.getMonth());

		model.addAttribute("title", "정산 리스트");
		model.addAttribute("list", adjustService.getList(pvo));
		model.addAttribute("pvo", pvo);
		return "/adjust/list.jsp";
	}

	/** 정산 리스트 엑셀 다운로드 */
	@CheckGrade(controllerName = "adjustController", controllerMethod = "writeExcelAdjustList")
	@RequestMapping("/adjust/list/excel/{type}")
	public void writeExcelAdjustList(@PathVariable String type, AdjustVo pvo, HttpSession session, HttpServletResponse response) throws IOException {
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = adjust_list_" + type + "_" + loginId + "_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		
		// 기본 검색년월 설정
		if("".equals(pvo.getAdjustDate())) {
			if ("".equals(pvo.getYear()) || "".equals(pvo.getMonth())) {
				pvo.setYear(StringUtil.getDate(0, "yyyy"));
				pvo.setMonth(StringUtil.getMonth(0, "MM"));
			}
			pvo.setAdjustDate(pvo.getYear()+pvo.getMonth());
		}
		
		
		// 워크북
		Workbook wb;
		if ("order".equals(type)) {
			wb = adjustService.getListExcelOrder(pvo, "xls");
		} else {
			wb = adjustService.getListExcel(pvo, "xls");
		}
		// 파일스트림
		OutputStream fileOut = response.getOutputStream();

		if (wb != null) {
			wb.write(fileOut);
			wb.close();
		}

		if (fileOut != null) {
			fileOut.flush();
			fileOut.close();
		}
	}

	/** 정산 주문 리스트 */
	@CheckGrade(controllerName = "adjustController", controllerMethod = "getOrderList")
	@RequestMapping("/adjust/order/list")
	public String getOrderList(HttpSession session, AdjustVo pvo, Model model) {
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		
		model.addAttribute("title", "정산 주문 리스트");
		model.addAttribute("list", adjustService.getOrderList(pvo));
		
		//수동 추가 내역 리스트
		pvo.setManualFlag("Y");
		model.addAttribute("manualList", adjustService.getOrderList(pvo));
		
		model.addAttribute("payMethodList", systemService.getCommonListByGroup(new Integer(21)));
		model.addAttribute("pvo", pvo);
		return "/adjust/order_list.jsp";
	}

	/** 정산 완료 일괄 처리 */
	@CheckGrade(controllerName = "adjustController", controllerMethod = "updateStatusBatch")
	@RequestMapping("/adjust/update/status/batch")
	public String updateStatusBatch(AdjustVo vo, Model model) {
		int procCnt = adjustService.updateStatus(vo);
		if (procCnt > 0) {
			model.addAttribute("message", procCnt + "건 정산 완료 처리");
			model.addAttribute("returnUrl",	"/admin/adjust/order/list?adjustDate=" + vo.getAdjustDate() + "&sellerSeq=" + vo.getSellerSeq() + "&completeFlag=" + vo.getCompleteFlag());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "정산 완료 처리 실패");
		return Const.ALERT_PAGE;

	}
	
	/** 정산 내역 추가(금액 조정) */
	@CheckGrade(controllerName = "adjustController", controllerMethod = "regVo")
	@RequestMapping("/adjust/reg")
	public String regVo(AdjustVo vo, Model model) {
		if(adjustService.regVo(vo) == 1) {
			model.addAttribute("message", "정산 내역 추가 성공");
			model.addAttribute("returnUrl",	"/admin/adjust/order/list?adjustDate=" + vo.getAdjustDate() + "&sellerSeq=" + vo.getSellerSeq() + "&completeFlag=" + vo.getCompleteFlag());
			return Const.REDIRECT_PAGE;
		}
		model.addAttribute("message", "정산 내역 추가 실패");
		return Const.ALERT_PAGE;
	}
	
	/** 정산 내역 삭제 */
	@CheckGrade(controllerName = "adjustController", controllerMethod = "delVo")
	@RequestMapping("/adjust/del/{seq}")
	public String delVo(@PathVariable Integer seq, String returnUrl, Model model) {
		if(adjustService.delVo(seq) == 1) {
			model.addAttribute("message", "정산 내역이 삭제되었습니다.");
			model.addAttribute("returnUrl",	returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
			return Const.REDIRECT_PAGE;
		}
		model.addAttribute("message", "정산 내역 삭제 실패");
		return Const.ALERT_PAGE;
	}
}
