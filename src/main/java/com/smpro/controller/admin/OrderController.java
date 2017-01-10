package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.util.pg.PgUtil;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

@Slf4j
@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private ItemOptionService itemOptionService;

	@Autowired
	private PointService pointService;

	@Autowired
	private MallService mallService;

	@Autowired
	private SmsService smsService;

	@Autowired
	private EstimateService estimateService;

	@Autowired
	private MemberGroupService memberGroupService;

	@Autowired
	private MailService mailService;
	
	/** 주문 리스트 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "getList")
	@RequestMapping("/order/list")
	public String getList(HttpSession session, OrderVo pvo, Model model) {
		session.setAttribute("cs", "");
		
		//기본 조회기간 일주일
		if ("".equals(pvo.getSearchDate1()) || "".equals(pvo.getSearchDate2())) {
			pvo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			pvo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
		}

		//기본 50개씩 조회
		if (pvo.getRowCount() == 20) {
			pvo.setRowCount(50);
		}
		
		// 카테고리를 가져온다
		CategoryVo cavo = new CategoryVo();
		cavo.setDepth(1);

		model.addAttribute("cateLv1List", categoryService.getList(cavo));
		if (pvo.getLv1Seq() != null) {
			// 2단
			cavo.setDepth(2);
			cavo.setParentSeq((pvo.getLv1Seq()));
			model.addAttribute("cateLv2List", categoryService.getList(cavo));
		}
		if (pvo.getLv1Seq() != null && pvo.getLv2Seq() != null) {
			// 3단
			cavo.setDepth(3);
			cavo.setParentSeq(pvo.getLv2Seq());
			model.addAttribute("cateLv3List", categoryService.getList(cavo));
		}
		if (pvo.getLv1Seq() != null && pvo.getLv2Seq() != null && pvo.getLv3Seq() != null) {
			// 4단
			cavo.setDepth(4);
			cavo.setParentSeq(pvo.getLv3Seq());
			model.addAttribute("cateLv4List", categoryService.getList(cavo));
		}

		// 주문 상태 코드 조회
		model.addAttribute("statusList", systemService.getCommonListByGroup(new Integer(6)));
		// 결제 수단 코드 조회
		model.addAttribute("payMethodList", systemService.getCommonListByGroup(new Integer(21)));
		
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));
		try {
			if (pvo.getSearch().equals("receiver_num")) {
				pvo.setFindword(CrypteUtil.encrypt(pvo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
		} catch (Exception e) {
			model.addAttribute("message", "회원 정보 암호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}

		pvo.setTotalRowCount(orderService.getListCount(pvo));

		List<OrderVo> list;
		try {
			list = orderService.getList(pvo);
		} catch (Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}
		
		//model.addAttribute("mallList", mallService.getListSimple());
		model.addAttribute("sumPrice", orderService.getSumPrice(pvo));
		model.addAttribute("list", list);
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		model.addAttribute("deliCompanyList", systemService.getDeliveryList(new DeliCompanyVo()));
		return "/order/list.jsp";
	}
	
	@CheckGrade(controllerName = "orderController", controllerMethod = "getListByPayMethod")
	@RequestMapping("/order/list/np")
	public String getListByPayMethod(HttpServletRequest request, OrderVo pvo, Model model) {
		HttpSession session = request.getSession(false);	
		
		//기본 50개씩 조회
		if (pvo.getRowCount() == 20) {
			pvo.setRowCount(50);
		}
		
		//기본 미완료 조회
		if(request.getParameter("npPayFlag") == null) {
			pvo.setNpPayFlag("N");
		}
				
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));
		
		pvo.setTotalRowCount(orderService.getListNPCount(pvo));

		List<OrderVo> list;
		try {
			list = orderService.getListNP(pvo);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("list", list);
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		return "/order/list_np.jsp";
	}
	
	/** 후청구 주문 리스트 엑셀 다운로드 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "downloadExcelOrderListNP")
	@RequestMapping("/order/list/np/excel")
	public void downloadExcelOrderListNP(OrderVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		// 엑셀 다운로드시 row수를 3000개로 무조건 고정한다.
		vo.setRowCount(3000);
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = order_list_np_" + loginId + "_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		// 워크북

		Workbook wb = null;
		try {
			wb = orderService.writeExcelOrderListNP(vo, "xls", session);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
		}

		// 파일전송
		OutputStream fileOut = response.getOutputStream();
		if (wb != null){
			wb.write(fileOut);
			wb.close();
		}

		fileOut.flush();
		fileOut.close();
	}

	/** 취소/교환/반품 리스트 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "getCsList")
	@RequestMapping("/order/{cs}/list")
	public String getCsList(@PathVariable String cs, HttpSession session, OrderVo pvo, Model model) {
		session.setAttribute("cs", cs);
		String title = "";
		if ("cancel".equals(cs)) {
			title = "취소 요청 리스트";
			if (StringUtil.isBlank(pvo.getStatusCode())) { // 맨처음 리스트를 들어왔을때 초기화
				pvo.setStatusCode("90");
			}
		} else if ("exchange".equals(cs)) {
			title = "교환 요청 리스트";
			if (StringUtil.isBlank(pvo.getStatusCode())) {
				pvo.setStatusCode("60");
			}
		} else if ("return".equals(cs)) {
			title = "반품 요청 리스트";
			if (StringUtil.isBlank(pvo.getStatusCode())) {
				pvo.setStatusCode("70");
			}
		}

		if (pvo.getRowCount() == 20) {
			pvo.setRowCount(50);
		}

		model.addAttribute("title", title);
		
		//주문 상태 코드 조회
		model.addAttribute("statusList", systemService.getCommonListByGroup(new Integer(6)));
		
		// 결제 수단 코드 조회
		model.addAttribute("payMethodList", systemService.getCommonListByGroup(new Integer(21)));

		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));

		pvo.setTotalRowCount(orderService.getCsOrderListCount(pvo).intValue());
		List<OrderVo> list = orderService.getCsOrderList(pvo);

		model.addAttribute("mallList", mallService.getListSimple());

		model.addAttribute("cs", cs);
		model.addAttribute("list", list);
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		return "/order/cs_list.jsp";
	}

	/** CS 처리내역 리스트 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "getCsLogList")
	@RequestMapping("/order/cs/log/list")
	public String getCsLogList(HttpSession session, OrderVo pvo, Model model) {
		model.addAttribute("title", "CS 처리 내역 리스트");

		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(6));
		model.addAttribute("statusList", systemService.getCommonList(cvo));

		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));

		pvo.setTotalRowCount(orderService.getCsLogListCount(pvo));
		List<OrderVo> list = orderService.getCsLogList(pvo);

		model.addAttribute("mallList", mallService.getListSimple());

		model.addAttribute("list", list);
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		return "/order/cs_log_list.jsp";
	}

	/** 주문 상세 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "getData")
	@RequestMapping("/order/view/{orderSeq}")
	public String getData(HttpServletRequest request, @PathVariable Integer orderSeq, @RequestParam(required=false) Integer seq, @RequestParam(required=false) Integer sellerSeq, Model model) {
		String viewType = request.getParameter("view_type");
		
		HttpSession session = request.getSession(false);
		model.addAttribute("title", "주문 상세 정보");
		OrderVo pvo = new OrderVo();
		pvo.setSeq(seq);
		pvo.setOrderSeq(orderSeq);
		pvo.setSellerSeq(sellerSeq);
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));

		/* 메인 */
		OrderVo ovo;
		try {
			ovo = orderService.getData(pvo);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("vo", ovo);

		/* 서브 */
		List<OrderVo> detailList = orderService.getListForDetail(pvo);
		for (int i = 0; i < detailList.size(); i++) {
			OrderVo tempVo = detailList.get(i);
			try {
				tempVo.setMemberTel(CrypteUtil.decrypt(tempVo.getMemberTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
				tempVo.setMemberCell(CrypteUtil.decrypt(tempVo.getMemberCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			} catch (Exception e) {
				model.addAttribute("message", "회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
				return Const.ALERT_PAGE;
			}
		}
		model.addAttribute("list", detailList);

		/* PG 결제 정보 */
		model.addAttribute("payInfoList",orderService.getPayInfoListForDetail(orderSeq));
		
		/* PG 결제 취소 내역 */
		model.addAttribute("payListCancel",	orderService.getListPayCancel(orderSeq));
		/* 포인트 사용 내역 */
		model.addAttribute("pointList", pointService.getHistoryList(orderSeq));
		
		/* CS 처리내역 */
		model.addAttribute("csList", orderService.getCsList(seq));
		
		/* 주문 변경 이력 내역 */
		model.addAttribute("logList", orderService.getLogList(seq));
		
		/* 세금계산서 요청 내역 */
		try {
			model.addAttribute("taxRequest", orderService.getTaxRequestData(orderSeq));
		} catch(Exception e) {
			// 안해도 별 상관없을 것이다
			e.printStackTrace();
		}
		
		/* 비교견적 첨부파일 리스트 */
		EstimateVo evo = new EstimateVo();
		evo.setLoginType(pvo.getLoginType());
		evo.setLoginSeq(pvo.getLoginSeq());
		evo.setOrderSeq(pvo.getOrderSeq());
		model.addAttribute("estimateCompareFileList", estimateService.getListCompareFile(evo));
		
		/* 기관,기업 회원 정보 */
		model.addAttribute("mgVo", memberGroupService.getVo(ovo.getMemberGroupSeq()) );
		
		/* 전체취소 취소 가능 여부 체크 */
		model.addAttribute("checkCancelAll", new Boolean(orderService.checkCancelAll(pvo)));
		
		model.addAttribute("pvo", pvo);
		
		return "/order/view"+(viewType == null ? "":"_"+viewType)+".jsp";
	}

	/** 주문 상태 일괄 변경 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "updateStatusBatch")
	@RequestMapping("/order/status/update/batch")
	public String updateStatusBatch (
			HttpServletRequest request,
			@RequestParam(value = "seq") Integer[] seq,
			@RequestParam(value = "updateStatusCode") String statusCode,
			@RequestParam(value = "deliSeq", required = false) Integer[] deliSeq,
			@RequestParam(value = "deliNo", required = false) String[] deliNo,
			@RequestParam(value = "returnUrl") String returnUrl, Model model
		) throws Exception {
		
		HttpSession session = request.getSession(false);
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");

		int procCnt = 0;

		if ("30".equals(statusCode)) {
			for (int i = 0; i < seq.length; i++) {
				OrderVo ovo = new OrderVo();
				ovo.setSeq(seq[i]);
				ovo.setDeliSeq(deliSeq[i]);
				ovo = orderService.getOrderInfo(ovo);

				MallVo mallVo = mallService.getMainInfo(ovo.getMallId());
				if (deliSeq[i].intValue() != 25) {
					SmsVo smvo = new SmsVo();
					smvo.setStatusCode("30");
					smvo.setStatusType("O");
					String content= smsService.getContent(smvo);
					content = content
							.replaceAll("orderSeq", "" + ovo.getOrderSeq())
							.replaceAll("deliNo", deliNo[i])
							.replaceAll("deliCompanyName", ovo.getDeliCompanyName());
					smvo.setTrSendStat("0");
					smvo.setTrMsgType("0");
					smvo.setTrMsg(content);
					smvo.setTrPhone(ovo.getReceiverCell().replace("-", ""));
					try {
						smsService.insertSmsSendVo(smvo);
					} catch (Exception e) {
						e.printStackTrace();
						log.info("SMS발송에 실패 하였습니다. [" + e.getMessage() + "]");
					}
				}

			}
			procCnt = orderService.updateStatusForDelivery(seq, statusCode,	loginSeq, deliSeq, deliNo);
		} else {
			procCnt = orderService.updateStatus(seq, statusCode, loginSeq);
		}
				
		model.addAttribute("message", procCnt + "건 일괄 상태 변경 성공.");
		model.addAttribute("returnUrl", StringUtil.restoreClearXSS(returnUrl));

		return Const.REDIRECT_PAGE;
	}

	/** 주문 상태 건별 변경 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "updateStatusOne")
	@RequestMapping("/order/status/update/one")
	public String updateStatusOne(HttpSession session, OrderVo vo, Model model) {
		String errMsg = "주문상태 변경 실패";

		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));

		try {
			boolean flag =  orderService.updateStatus(vo);
			// 변경 사유 내용이 있으면 CS처리 내용으로 등록
			if (flag && !"".equals(vo.getContents())) {
				OrderCsVo csVo = new OrderCsVo();
				csVo.setOrderDetailSeq(vo.getSeq());
				csVo.setContents(vo.getContents());
				csVo.setLoginSeq(vo.getLoginSeq());
				orderService.regData(csVo);
			}
			
			if(flag) {
				model.addAttribute("message", "주문상태 변경 성공.");
				model.addAttribute("returnUrl", "/admin/order/view/" + vo.getOrderSeq() + "?seq=" + vo.getSeq());
				return Const.REDIRECT_PAGE;
			}
			
			model.addAttribute("message", errMsg);
			return Const.ALERT_PAGE;
			
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = e.getMessage();
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
		
	}
	
	/** 주문 상태 입금대기로 변경 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "updateStatusOne")
	@RequestMapping("/order/status/update/00")
	public String updateStatus00(HttpSession session, OrderVo vo, Model model) {
		String errMsg = "";
		Integer seq = vo.getSeq();
		
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setStatusCode("00");
		
		List<OrderVo> detailList = orderService.getListForDetail(vo);
		for(OrderVo xvo : detailList) {
			try {
				vo.setSeq(xvo.getSeq());
				boolean flag =  orderService.updateStatus(vo);
				// 변경 사유 내용이 있으면 CS처리 내용으로 등록
				if (flag && !"".equals(vo.getContents())) {
					OrderCsVo csVo = new OrderCsVo();
					csVo.setOrderDetailSeq(vo.getSeq());
					csVo.setContents(vo.getContents());
					csVo.setLoginSeq(vo.getLoginSeq());
					orderService.regData(csVo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				errMsg = e.getMessage();
			}
		}
		
		if("".equals(errMsg)) {
			model.addAttribute("message", "주문상태 변경 성공.");
			model.addAttribute("returnUrl", "/admin/order/view/" + vo.getOrderSeq() + "?seq=" + seq);
			return Const.REDIRECT_PAGE;
		}
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}
	
	/** 입금확인(입금대기건 결제완료 처리) */
	@CheckGrade(controllerName = "orderController", controllerMethod = "updateStatusForConfirm")
	@RequestMapping("/order/status/update/confirm")
	public String updateStatusForConfirm(HttpServletRequest request, OrderVo vo, Model model) {
		HttpSession session = request.getSession(false);
		String errMsg = "결제완료 처리 실패";
		vo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		vo.setLoginType((String)session.getAttribute("loginType"));

		try {
			if (orderService.updateStatusForConfirm(vo)) {

				//입점업체 주문확인 메일 발송
				mailService.sendMailToSellerForOrder(orderService.getData(vo), request.getServletContext().getRealPath("/"));
				
				model.addAttribute("message", "결제완료 처리 성공.");
				model.addAttribute("returnUrl", "/admin/order/view/" + vo.getOrderSeq() + "?seq=" + vo.getSeq());
				return Const.REDIRECT_PAGE;
			}
			
			model.addAttribute("message", errMsg);
			return Const.ALERT_PAGE;
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = errMsg + "[" + e.getMessage() + "]";
		}
			
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}

	/** 후청구 입금완료 상태 일괄 변경 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "updatePayFlagList")
	@RequestMapping("/order/update/np")
	public String updatePayFlagList (OrderVo vo, String returnUrl, Model model) {
		if(orderService.updateNpPayFlag(vo) == 1) {
			model.addAttribute("message","입금완료 처리 성공");
			if("N".equals(vo.getNpPayFlag())) {
				model.addAttribute("message","입금대기 상태로 되돌리기 성공");
			}
			model.addAttribute("returnUrl", returnUrl == null ? "" : returnUrl.replace("&amp;", "&"));
			return Const.REDIRECT_PAGE;
		}
		
		model.addAttribute("message","입금완료 처리 실패");
		return Const.ALERT_PAGE;
	}
	
	/** 송장 엑셀 일괄 업로드 폼 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "getDeliveryUploadForm")
	@RequestMapping("/order/delivery/upload")
	public String getDeliveryUploadForm(Model model) {
		model.addAttribute("title", "송장 일괄 업로드");
		DeliCompanyVo vo = new DeliCompanyVo();
		model.addAttribute("list", systemService.getDeliveryList(vo));
		return "/order/delivery_upload.jsp";
	}

	/** 송장 엑셀 일괄 업로드 처리 */
	@RequestMapping("/order/delivery/upload/proc")
	public String updateDeliveryData(HttpServletRequest request, Model model) throws IOException {
		int procCnt = 0;

		HttpSession session = request.getSession(false);
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");

		/* 업로드된 엑셀 파일 객체 가져오기 */
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		MultipartFile xlsFile = mpRequest.getFile("xlsFile");

		/* 입점업체 시퀀스 */
		if (StringUtil.isBlank(mpRequest.getParameter("sellerSeq"))) {
			model.addAttribute("message", "입점업체를 선택해 주세요.");
			return Const.ALERT_PAGE;
		}
		Integer sellerSeq = Integer
				.valueOf(mpRequest.getParameter("sellerSeq"));

		/* 업로드 처리 */
		List<String[]> list;

		if (new XlsService().readXlsFile(xlsFile.getInputStream()) == null) {
			model.addAttribute("message", "잘못된 양식 입니다.");
			return Const.ALERT_PAGE;
		}

		list = new XlsService().readXlsFile(xlsFile.getInputStream());

		Integer[] seq = null;
		Integer[] deliSeq = null;
		String[] deliNo = null;

		if (list != null && list.size() > 0) {
			seq = new Integer[list.size()];
			deliSeq = new Integer[list.size()];
			deliNo = new String[list.size()];
			for (int i = 0; i < list.size(); i++) {
				String[] row = list.get(i);
				// 값 유효성 검증
				String errMsg = orderService.chkDeliveryXlsData(row);
				if (errMsg != null) {
					// 에러건 발생시 중단
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}
				seq[i] = Integer.valueOf(row[1]);
				deliSeq[i] = Integer.valueOf(row[3]);
				deliNo[i] = row[4];
			}

			/* DB 업데이트 처리 */
			procCnt = orderService.updateStatusForDelivery(seq, "30", loginSeq,
					deliSeq, deliNo, sellerSeq);
		}
		

		if (procCnt > 0) {
			model.addAttribute("message", procCnt + "건 처리되었습니다.");
			model.addAttribute("returnUrl", "/admin/order/list?statusCode=30");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "처리할 대상 주문이 없거나 이미 처리된 건들입니다.");
		return Const.ALERT_PAGE;

	}

	/** 송장입력 대상 주문건 엑셀 다운로드 */
	@RequestMapping("/order/delivery/xls")
	public void downloadDeliveryXlsFile(@RequestParam Integer sellerSeq, HttpServletResponse response) throws IOException {
		response.setHeader("Content-Disposition", "attachment; filename = order_delivery_proc_list_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		// response.setCharacterEncoding("UTF-8");

		HSSFWorkbook wb = null;
		try {
			wb = orderService.createDeliveryXlsFile(sellerSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		OutputStream fileOut = response.getOutputStream();
		if (wb != null) {
			wb.write(fileOut);
		}
		fileOut.flush();
		
		if (wb != null) {
			wb.close();
		}
		fileOut.close();
		
	}

	/** CS 등록 */
	@RequestMapping("/order/cs/reg/{orderSeq}")
	public String regCsData(HttpSession session, @PathVariable int orderSeq, OrderCsVo vo, Model model) {
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		vo.setLoginSeq(loginSeq);

		if (orderService.regData(vo)) {
			model.addAttribute("message", "등록 성공.");
			model.addAttribute("returnUrl", "/admin/order/view/" + orderSeq
					+ "?seq=" + vo.getOrderDetailSeq());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "등록 실패.");
		return Const.ALERT_PAGE;
	}
	
	/** CS 삭제  */
	@RequestMapping("/order/cs/delete/")
	public String deleteCsData(HttpSession session, Integer seq, Model model) {
		Integer gradeCode = (Integer) session.getAttribute("gradeCode");
		if(gradeCode == null || gradeCode.intValue() > 1) {
			model.addAttribute("message", "접근할 수 있는 권한이 없습니다");
			return Const.ALERT_PAGE;
		}
		
		if(!orderService.deleteCsData(seq)) {
			model.addAttribute("message", "데이터를 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "<script>top.location.reload()</script>");
		return Const.AJAX_PAGE;
	}

	@CheckGrade(controllerName = "orderController", controllerMethod = "orderDeliveryProcList")
	@RequestMapping("/order/delivery/proc/list")
	public String orderDeliveryProcList(HttpSession session, OrderVo pvo, Model model) {
		model.addAttribute("title", "자동 배송완료 처리");

		pvo.setStatusCode("30");
		pvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		pvo.setLoginType((String) session.getAttribute("loginType"));

		List<OrderVo> list;
		try {
			list = orderService.getDeliList(pvo);
		} catch (Exception e) {
			model.addAttribute("message",
					"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("list", list);
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);

		return "/order/delivery_proc_list.jsp";
	}

	@CheckGrade(controllerName = "orderController", controllerMethod = "getDeliveryProcResult")
	@RequestMapping("/order/delivery/socket/proc")
	public String getDeliveryProcResult(OrderVo vo, HttpSession session, Model model) {
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		vo.setLoginSeq(loginSeq);
		model.addAttribute("message", orderService.updateDeliveryProc(vo));
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/order/ajax/itemlist")
	public String getAjaxItemList(ItemVo vo, Model model) {
		vo.setRowCount(10);
		vo.setStatusCode("Y");
		vo.setTotalRowCount(itemService.getListTotalCount(vo));

		List<ItemVo> list = itemService.getList(vo);
		for (ItemVo tmpVo : list) {
			if (tmpVo.getOptionSeq() != null) {
				tmpVo.setOptionList(itemOptionService.getValueList(tmpVo.getOptionSeq()));
			}
		}
		model.addAttribute("list", list);

		return "/ajax/get-order-reg-item-list.jsp";
	}

	@RequestMapping("/order/ajax/itemlist/paging")
	public String getAjaxItemListPaging(ItemVo vo, Model model) {
		vo.setRowCount(10);
		vo.setStatusCode("Y");
		vo.setTotalRowCount(itemService.getListTotalCount(vo));
		model.addAttribute("message", vo.drawPagingNavigation("goPage"));
		return Const.AJAX_PAGE;
	}

	public static ItemVo getSearchItemVo(Integer lv1, Integer lv2, Integer lv3,
			Integer itemSeq, String itemName) {
		ItemVo vo = new ItemVo();
		/** 상품 검색값이 null이 아닐경우 */
		if (itemSeq != null) {
			vo.setSeq(itemSeq);
		}
		if (itemName != null) {
			vo.setName(itemName);
		}
		if (lv1 != null) {
			vo.setCateLv1Seq(lv1);
		}
		if (lv2 != null) {
			vo.setCateLv2Seq(lv2);
		}
		if (lv3 != null) {
			vo.setCateLv3Seq(lv3);
		}
		return vo;
	}

	/**
	 * 주문 취소 처리(전체,부분)
	 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "cancelOrder")
	@RequestMapping(value = "/order/cancel", method = RequestMethod.POST)
	public String cancelOrder(HttpServletRequest request, OrderVo vo, Model model) {
		HttpSession session = request.getSession(false);

		boolean flag;
		String errMsg = "취소 처리에 실패했습니다.";

		String cancelType = vo.getCancelType();

		// 부분취소 주문 금액
		int partCancelAmt = 0;
		// 부분취소 대상 상품주문 데이터
		OrderVo detailVo = null;

		// 포인트 부분취소 금액
		int partCancelPoint = 0;

		// 로그인 정보 vo에 셋팅
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));

		/** 취소/부분취소 주문 체크 */
		if ("ALL".equals(cancelType)) {
			// 전체취소
			if (!orderService.checkCancelAll(vo)) {
				model.addAttribute("message", "전체 취소가 가능한 상태가 아니거나 이미 처리 된 건입니다.");
				return Const.ALERT_PAGE;
			}
		} else if ("PART".equals(cancelType)) {
			// 부분취소 금액을 계산한다.
			detailVo = orderService.calcPartCancelAmt(vo.getSeq());
			if (detailVo == null || detailVo.getSumPrice() == 0) {
				model.addAttribute("message", "부분 취소할 주문이 존재하지 않습니다.");
				return Const.ALERT_PAGE;
			}

			partCancelAmt = (int)detailVo.getSumPrice();
			
			vo.setSellerSeq(detailVo.getSellerSeq()); // 해당 부분취소 주문건의 입점업체 시퀀스 저장
		} else {
			model.addAttribute("message", "유효하지 않은 접근입니다.");
			return Const.ALERT_PAGE;
		}

		/*** PG 취소/부분취소 처리 ***/
		OrderPayVo payVo = orderService.getPayVoForCancel(vo.getOrderSeq());
		OrderPayVo payVoCancel = null;
		if (payVo != null && payVo.getCurAmount() > 0) {
			// PG 부분취소 금액
			int partCancelAmtPay;
			PgUtil pgUtil = new PgUtil(payVo.getPgCode());
			if (partCancelAmt > 0) {
				int curAmount = payVo.getCurAmount();
				partCancelAmtPay = partCancelAmt;

				// 결제금액에 면세금액이 포함(복합과세)되어 있고 과세금액 주문 취소일 경우
				if (payVo.getTaxFreeAmount() > 0 && (detailVo != null && "1".equals(detailVo.getTaxCode()))) {
					// 현재 PG결제금액을 과세결제금액만으로 설정한다.(결제 시점에서의 과세/면세 금액 비율과 동일하게 유지)
					// 잔여 과세 결제금액 = 총 과세결제금액 - (과세 결제금액 취소 합계)
					curAmount = (payVo.getAmount() - payVo.getTaxFreeAmount()) - orderService.getSumCancelPayAmountTax(vo.getOrderSeq());
				}
				if (partCancelAmt > curAmount) {
					// 부분취소 할 금액이 현재 PG결제금액 보다 클경우 현재 PG결제 금액으로 한다.
					partCancelAmtPay = curAmount;
					// 나머지 취소 금액은 포인트 사용 금액에서 환불 처리한다.
					partCancelPoint = partCancelAmt - partCancelAmtPay;
				}
			} else {
				/** 전체 취소 */
				partCancelAmtPay = 0;
			}
			try {
				// PG 취소 요청
				payVo.setOrderDetailSeq(vo.getSeq());
				payVo.setPartCancelAmt(partCancelAmtPay);
				payVoCancel = pgUtil.doCancel(request, payVo, detailVo == null ? "" : detailVo.getTaxCode());
			} catch (Exception e) {
				e.printStackTrace();
				errMsg = e.getMessage();
			}
			if (payVoCancel == null || !"Y".equals(payVoCancel.getResultFlag())) {
				if (payVoCancel == null) {
					model.addAttribute("message", "PG 결제 취소 처리에 실패하였습니다.["+ errMsg + "]");
				} else {
					model.addAttribute("message", "PG 결제 취소 처리에 실패하였습니다.["+ payVoCancel.getResultCode() + ":"	+ payVoCancel.getResultMsg() + "]");
				}
				return Const.ALERT_PAGE;
			}
		} else {
			// PG 결제가 아니거나 PG결제금액이 모두 취소되었을 경우 포인트로 부분환불 처리한다.
			if (partCancelAmt > 0) {
				partCancelPoint = partCancelAmt;
			}
		}

		/** 자체 포인트 취소 처리 */
		PointVo pointVoCancel = null;

		// 해당 주문번호의 포인트 사용내역 조회
		PointVo pointVo = pointService.getHistoryForCancel(vo.getOrderSeq());
		if (pointVo != null && pointVo.getCurPoint() > 0) {
			// 취소 적립할 포인트 금액
			int reservePoint = pointVo.getCurPoint();
			if (partCancelPoint > 0) {
				if(partCancelPoint > reservePoint) {
					partCancelPoint = reservePoint;
				}
				// 부분 취소시 실결제금액 환불액을 제외한 나머지 금액을 포인트 적립금액으로 정한다.
				reservePoint = partCancelPoint;
				// 부분취소 발생시 상품주문번호를 추가로 조회한다.
				pointVo.setOrderDetailSeq(vo.getSeq());
			}

			// 기 취소 여부 체크(중복취소 방지)
			if (pointService.checkCancel(pointVo) > 0) {
				model.addAttribute("message", "포인트 취소적립 처리가 이미 완료된 건입니다.");
				return Const.ALERT_PAGE;
			}
			
			pointVoCancel = new PointVo();
			pointVoCancel.setOrderSeq(pointVo.getOrderSeq());
			// 부분취소 처리 경우 상품주문번호를 추가로 저장한다.
			if (pointVo.getOrderDetailSeq() != null) {
				pointVoCancel.setOrderDetailSeq(pointVo.getOrderDetailSeq());
			}
			pointVoCancel.setEndDate(StringUtil.getDate(365, "yyyy-MM-dd"));
			pointVoCancel.setPoint(reservePoint);
			pointVoCancel.setUseablePoint(reservePoint);
			pointVoCancel.setValidFlag("Y");
			pointVoCancel.setReserveCode("2");
			pointVoCancel.setReserveComment("주문 취소, 포인트 재적립");
			pointVoCancel.setMemberSeq(pointVo.getMemberSeq());
			pointVoCancel.setAdminSeq((Integer) session.getAttribute("loginSeq"));
			pointVoCancel.setStatusCode("C");
		}

		
		try {
			// 취소 내역 DB 업데이트
			flag = orderService.updateCancelAll(vo, payVoCancel, pointVoCancel);
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = "취소 처리 중 오류가 발생하였습니다.[" + e.getMessage() + "]";
			flag = false;
		}

		if (flag) {
			model.addAttribute("message", "취소 완료 처리 되었습니다.");
			model.addAttribute("returnUrl", "/admin/order/view/" + vo.getOrderSeq() + "?seq=" + vo.getSeq());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}

	/** 주문 리스트 엑셀 다운로드 */
	@CheckGrade(controllerName = "orderController", controllerMethod = "writeExcelOrderList")
	@RequestMapping("/order/list/download/excel")
	public void writeExcelOrderList(OrderVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		
		// 엑셀 다운로드시 row수를 3000개로 무조건 고정한다.
		vo.setRowCount(3000);
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = order_list_" + loginId + "_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		// 워크북

		Workbook wb = null;
		try {
			wb = orderService.writeExcelOrderList(vo, "xls");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
		}

		// 파일스트림
		OutputStream fileOut = response.getOutputStream();
		if (wb != null){
			wb.write(fileOut);
			wb.close();
		}

		fileOut.flush();
		fileOut.close();
	}

	@RequestMapping("/order/list/download/excel/check")
	public String writeExcelCheck(OrderVo vo, HttpSession session, Model model) {
		/* 주문리스트 */
		if (StringUtil.isBlank(vo.getSearchDate1()) || StringUtil.isBlank(vo.getSearchDate2())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "주문일자를 입력해 주세요.");
			return "/ajax/get-message-result.jsp";
		}

		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		if (orderService.getListCount(vo) > 3000) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "엑셀 다운로드는 3000건 까지만 다운로드 됩니다.");
			return "/ajax/get-message-result.jsp";
		}
		model.addAttribute("result", "true");
		return "/ajax/get-message-result.jsp";
	}

	/** 배송지 변경하기(결제완료/주문확인/교환신청상태일때) */
	@RequestMapping("/order/delivery/change")
	public String deliChange(OrderVo vo, Model model, HttpSession session) throws UnsupportedEncodingException, InvalidKeyException {
		String addr2 = vo.getReceiverAddr2();

		if (!orderService.updateAddr(vo)) {
			model.addAttribute("message", "주소 변경 실패");
			return Const.ALERT_PAGE;
		}

		List<?> seqList = orderService.getSeqList(vo.getOrderSeq());

		for (int i = 0; i < seqList.size(); i++) {
			OrderLogVo lvo = new OrderLogVo();
			lvo.setOrderDetailSeq((Integer) seqList.get(i));
			lvo.setContents("배송지 주소변경 : 우편번호-" + vo.getReceiverPostcode() + ", 주소1-" + vo.getReceiverAddr1() + ", 주소2-" + addr2);
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			orderService.regLogData(lvo);
		}

		model.addAttribute("message", "주소 변경 성공");
		model.addAttribute("returnUrl", "/admin/order/view/" + vo.getOrderSeq()	+ "?seq=" + vo.getSeq());
		return Const.REDIRECT_PAGE;
	}
	
	/** 주문자 정보 변경하기(결제완료/주문확인/교환신청상태일때) */
	@RequestMapping("/order/member/change")
	public String memberChange(OrderVo vo, Model model, HttpSession session) throws UnsupportedEncodingException, InvalidKeyException {
		// 최고 관리자만 가능
		Integer gradeCode = (Integer) session.getAttribute("gradeCode");
		if(gradeCode == null || gradeCode.intValue() > 1) {
			model.addAttribute("message", "접근할 수 있는 권한이 없습니다");
			return Const.ALERT_PAGE;
		}
		
		String memberEmail = vo.getMemberEmail();
		
		if (!orderService.updateMember(vo)) {
			model.addAttribute("message", "주문자 정보 변경 실패");
			return Const.ALERT_PAGE;
		}

		List<?> seqList = orderService.getSeqList(vo.getOrderSeq());

		for (int i = 0; i < seqList.size(); i++) {
			OrderLogVo lvo = new OrderLogVo();
			lvo.setOrderDetailSeq((Integer) seqList.get(i));
			lvo.setContents("주문자 정보 변경 : 주문자명-" + vo.getMemberName() + ", 이메일-" + memberEmail);
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			orderService.regLogData(lvo);
		}

		model.addAttribute("message", "주문자 정보 변경 성공");
		model.addAttribute("returnUrl", "/admin/order/view/" + vo.getOrderSeq()	+ "?seq=" + vo.getSeq());
		return Const.REDIRECT_PAGE;
	}
	
	/** PG 입금통보 수신 */
	@RequestMapping("/{pgCode}/pay/update")
	public void updatePayInfo(@PathVariable String pgCode, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tid = request.getParameter("TID");
		String mid = request.getParameter("MID");
		String oid = request.getParameter("MOID");
		String amount = request.getParameter("Price");
		String resultCode = request.getParameter("ResultCode");
		String resultMsg = request.getParameter("ResultMsg");
		String approvalNo= request.getParameter("CardApplNum");
		String cardMonth = request.getParameter("CardQuota");
		String orgCode   = request.getParameter("CardCode");
		String date		 = request.getParameter("Date");
		String time		 = request.getParameter("Time");
		
		log.info("### " + pgCode + " 신용카드 ARS 결제 입금 통보 수신 ###");
		log.info("### PG IP Addr : " + request.getRemoteAddr());
		log.info("### tid : " + tid);
		log.info("### mid : " + mid);
		log.info("### oid : " + oid);
		log.info("### amount : " + amount);
		log.info("### resultCode : " + resultCode);
		log.info("### resultMsg : " + resultMsg);
		log.info("### approvalNo : " + approvalNo);
		log.info("### cardMonth : " + cardMonth);
		log.info("### orgCode : " + orgCode);
		log.info("### date : " + date);
		log.info("### time : " + time);
		
		if(tid == null || resultCode == null) {
			response.getWriter().print("tid or ResultCode not found");
			return;
		}
		
		OrderPayVo vo = new OrderPayVo();
		vo.setOrderSeq(Integer.valueOf(oid));
		vo.setTid(tid);
		vo.setMid(mid);
		vo.setOid(oid);
		vo.setAmount(Integer.parseInt(amount));
		vo.setApprovalNo(approvalNo);
		vo.setCardMonth(cardMonth);
		vo.setOrgCode(orgCode);
		vo.setResultCode(resultCode);
		vo.setResultMsg(resultMsg);
		
		if(date != null && time != null) {
			vo.setTransDate(date.trim()+time.trim());
		}
		
		if(orderService.updatePayInfo(vo)) {
			//입점 업체 주문 확인 메일 발송
			OrderVo ovo = new OrderVo();
			ovo.setOrderSeq(vo.getOrderSeq());
			mailService.sendMailToSellerForOrder(orderService.getData(ovo), request.getServletContext().getRealPath("/"));
			//DB 정상 처리 결과 값 송신
			response.getWriter().print("0000");
			return;
		}
		
		response.getWriter().print("Failed to update DB");
		return;
	}
	
	/** 세금계산서 요청 완료처리 */
	@ResponseBody
	@RequestMapping("/order/view/taxrequest/complete")
	public String deliChange(Integer orderSeq) {
		int count = orderService.completeTaxRequest(orderSeq);
		if(count > 0) {
			return "success";
		} 
		
		return "fail";
	
	}
}
