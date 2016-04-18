package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.List;

@Controller
public class PointController {
	private static final Logger LOGGER = LoggerFactory.getLogger(PointController.class);
	
	@Resource(name = "mallService")
	private MallService mallService;

	@Resource(name = "pointService")
	private PointService pointService;

	@Resource(name = "systemService")
	private SystemService systemService;

	@Resource(name = "memberService")
	private MemberService memberService;

	@Resource(name = "orderService")
	private OrderService orderService;

	/*
	 * 컨트롤러가 트랜잭션 매니저를 알고 있는 건 별로 좋은 설계가 아니다. 정말 극히 일부분에만 적용하고 싶었기 때문에 이렇게
	 * 적용하였다. DAO나 SERVICE에서 @Transactional로 구현해주기 바람.
	 */
	@Autowired
	DataSourceTransactionManager transactionManager;

	public void setTransactionManager(DataSourceTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	/** 포인트 리스트 */
	@CheckGrade(controllerName = "pointController", controllerMethod = "pointList")
	@RequestMapping("/point/list")
	public String pointList(PointVo vo, Model model) {
		model.addAttribute("title", "포인트 리스트");

		// 전체 리스트 개수
		vo.setRowCount(100);
		vo.setTotalRowCount(pointService.getListCount(vo));

		model.addAttribute("mallList", mallService.getListSimple());

		model.addAttribute("vo", vo);
		model.addAttribute("list", pointService.getList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		return "/point/list.jsp";
	}

	/** 포인트 리스트 엑셀 다운 */
	@RequestMapping("/point/list/download")
	public void pointListDown(PointVo vo, HttpServletResponse response) throws Exception {

		vo.setRowCount(pointService.getListCount(vo));
		// 엑셀 파일명
		response.setHeader("Content-Disposition",
				"attachment; filename = point_list.xls");
		// 워크북

		Workbook wb = null;
		try {
			wb = pointService.writePointList(vo, "xls");
		} catch (Exception e) {
			LOGGER.info(
					"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
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

	/** 포인트 상세 리스트 */
	@CheckGrade(controllerName = "pointController", controllerMethod = "pointDetailList")
	@RequestMapping("/point/detail/list/{seq}")
	public String pointDetailList(@PathVariable Integer seq, Integer pg, PointVo vo, Model model) {
		model.addAttribute("title", "포인트 상세 리스트");

		vo.setMemberSeq(seq);
		// 전체 리스트 개수
		vo.setRowCount(20);
		vo.setTotalRowCount(pointService.getDetailListCount(vo).intValue());
		model.addAttribute("list", pointService.getDetailList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));

		PointVo ovo = new PointVo();
		if (pg != null) {
			ovo.setPageNum(pg.intValue());
		} else {
			ovo.setPageNum(0);
		}
		ovo.setRowCount(20);
		ovo.setMemberSeq(seq);
		ovo.setTotalRowCount(pointService.getShopPointCount(ovo));
		model.addAttribute("listPoint", pointService.getShopPointList(ovo));
		model.addAttribute("pointPaging",
				ovo.drawPagingNavigation("goPointPage"));

		model.addAttribute("vo", vo);

		PointVo pvo = new PointVo();
		pvo.setMemberSeq(seq);
		model.addAttribute("detailTitle", "회원 잔여 포인트");
		model.addAttribute("detailVo", pointService.getVo(pvo));
		model.addAttribute("memberSeq", seq);

		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(16));
		model.addAttribute("commonlist", systemService.getCommonList(cvo));
		return "/point/detail_list.jsp";
	}

	/** 포인트 상세 리스트 엑셀 다운 */
	@RequestMapping("/point/detail/list/download")
	public void pointDetailListDown(PointVo vo, HttpServletResponse response) throws Exception {

		vo.setRowCount(pointService.getShopPointCount(vo));
		// 엑셀 파일명
		response.setHeader("Content-Disposition",
				"attachment; filename = point_list.xls");
		// 워크북

		Workbook wb = null;
		try {
			wb = pointService.writeDetailPointList(vo, "xls");
		} catch (Exception e) {
			LOGGER.info(
					"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
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

	/** 포인트 지급 폼 */
	@CheckGrade(controllerName = "pointController", controllerMethod = "pointForm")
	@RequestMapping("/point/form")
	public String pointForm(String formFlag, Integer memberSeq, Model model) {
		model.addAttribute("title", "포인트 지급");
		if ("Y".equals(formFlag)) {
			MemberVo mvo;
			try {
				mvo = memberService.getData(memberSeq);
			} catch (Exception e) {
				model.addAttribute("message",
						"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
				return Const.ALERT_PAGE;
			}
			model.addAttribute("vo", mvo);
		}
		model.addAttribute("formFlag", formFlag);

		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(16));
		model.addAttribute("commonlist", systemService.getCommonList(cvo));
		return "/point/form.jsp";
	}

	@CheckGrade(controllerName = "pointController", controllerMethod = "pointWriteProc")
	@RequestMapping("/point/write/proc")
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public String pointWriteProc(PointVo vo, HttpSession session, Model model) {
		// 이벤트, CS요청등을 통한 일반지급
		vo.setStatusCode("S");
		if (vo.getMemberSeq() == null) {
			model.addAttribute("message", "회원은 반드시 입력 되어야 합니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank(vo.getEndDate())) {
			model.addAttribute("message", "만료일은 반드시 입력 되어야 합니다.");
			return Const.ALERT_PAGE;
		}
		if (vo.getPoint() <= 0) {
			model.addAttribute("message", "포인트는 반드시 입력 되어야 합니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank(vo.getValidFlag())) {
			model.addAttribute("message", "사용구분은 반드시 선택 되어야 합니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank(vo.getReserveCode())) {
			model.addAttribute("message", "적립방식은 반드시 선택 되어야 합니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.isBlank(vo.getTypeCode())) {
			model.addAttribute("message", "등록구분이 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if ("2".equals(vo.getTypeCode())) {
			// 취소, 부분취소로 인한 포인트 지급
			vo.setStatusCode("C");
			if (StringUtil.isBlank("" + vo.getOrderSeq())
					|| StringUtil.isBlank("" + vo.getOrderDetailSeq())) {
				model.addAttribute("message", "주문번호가 입력되지 않았습니다.");
				return Const.ALERT_PAGE;
			}
			OrderVo ovo = new OrderVo();
			ovo.setOrderSeq(vo.getOrderSeq());

			OrderVo confirmVo;
			try {
				confirmVo = orderService.getData(ovo);
			} catch (Exception e) {
				model.addAttribute("message",
						"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
				return Const.ALERT_PAGE;
			}
			if (confirmVo == null) {
				model.addAttribute("message", "장바구니 번호가 존재하지 않습니다.");
				return Const.ALERT_PAGE;
			}

			// 취소완료 상태가 아니라면 포인트를 지급받은 뒤에 취소요청철회로 인해 포인트지급이 악용될수 있기때문에 취소가 완료된
			// 주문만 가지고 온다.
			ovo.setStatusCode("99");
			List<OrderVo> detailList = orderService.getListForDetail(ovo);

			// 폼에서 넘어온 상품 주문번호
			String[] orderDetailSeq = vo.getOrderDetailSeqs().split(",");

			PointVo pvo = new PointVo();
			pvo.setOrderSeq(vo.getOrderSeq());
			List<PointVo> historyList = pointService
					.getShopPointListForAllCancel(pvo);
			int sucCnt = 0, failCnt = 0;

			if (detailList.size() > 0) {
				for (int i = 0; i < detailList.size(); i++) {
					for (int j = 0; j < orderDetailSeq.length; j++) {
						if (detailList.get(i).getSeq() == Integer
								.valueOf(orderDetailSeq[j])) {
							sucCnt++;
						}
					}
				}
				if (sucCnt != orderDetailSeq.length) {
					failCnt++;
				}
			} else {
				failCnt++;
			}
			if (failCnt > 0) {
				model.addAttribute("message", "존재하지 않는 주문번호를 입력하셨습니다.");
				return Const.ALERT_PAGE;
			}

			int duplicateCnt = 0;
			String duplicateDetailSeq = "";
			// 포인트를 지급하려는 상품 주문번호가 이미 취소된적이 있는지 확인한다.
			for (int i = 0; i < historyList.size(); i++) {
				if (historyList.get(i).getOrderDetailSeq() != null) {
					String[] tmpValue = historyList.get(i).getOrderDetailSeqs()
							.split(",");

					for (int k = 0; k < orderDetailSeq.length; k++) {
						for (int j = 0; j < tmpValue.length; j++) {
							if (Integer.parseInt(orderDetailSeq[k]) == Integer
									.parseInt(tmpValue[j])) {
								if (!StringUtil.isBlank(duplicateDetailSeq)) {
									duplicateDetailSeq += ",";
								}
								duplicateDetailSeq += orderDetailSeq[k];
								duplicateCnt++;
							}
						}
					}
				}
			}

			if (duplicateCnt > 0) {
				model.addAttribute("message", "상품 주문번호 " + duplicateDetailSeq
						+ "는 이미 포인트 환불이 되어 있는 주문입니다.");
				return Const.ALERT_PAGE;
			}
		}

		Integer memberSeq = Integer.valueOf(("" + session
				.getAttribute("loginSeq")));
		vo.setAdminSeq(memberSeq);
		vo.setUseablePoint(vo.getPoint());

		// Programmatic Transaction management
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			if (!pointService.insertData(vo)) {
				throw new Exception();
			}

			// generateKey로 받은 point seq
			vo.setPointSeq(vo.getSeq());

			if (!pointService.insertHistoryData(vo)) {
				throw new Exception();
			}

			if (!pointService.insertLogData(vo)) {
				throw new Exception();
			}

			transactionManager.commit(status);
		} catch (Exception e) {
			LOGGER.error(
					"POINT FAIL:: ===> " + e.getMessage());
			e.printStackTrace();
			transactionManager.rollback(status);
		}
		model.addAttribute("message", "포인트가 지급 되었습니다.");

		model.addAttribute("returnUrl",	"/admin/point/detail/list/" + vo.getMemberSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/point/member/json")
	public String getVoForJson(MemberVo vo, Model model) throws UnsupportedEncodingException, InvalidKeyException {
		/* 입력값 검증 */
		if (StringUtil.isBlank(vo.getFindword())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "검색할 키워드를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		if ("id".equals(vo.getSearch())) {
			if (StringUtil.getByteLength(vo.getFindword()) > 50) {
				model.addAttribute("result", "false");
				model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
				return "/ajax/get-message-result.jsp";
			} else if (StringUtil.getByteLength(vo.getFindword()) < 6) {
				model.addAttribute("result", "false");
				model.addAttribute("message", "아이디를 6자 이상 입력해주세요.");
				return "/ajax/get-message-result.jsp";
			}
		} else if ("nickname".equals(vo.getSearch())) {
			if (StringUtil.getByteLength(vo.getFindword()) > 30) {
				model.addAttribute("result", "false");
				model.addAttribute("message", "닉네임이 100Bytes를 초과하였습니다.");
				return "/ajax/get-message-result.jsp";
			}
		} else if ("name".equals(vo.getSearch())) {
			if (StringUtil.getByteLength(vo.getFindword()) > 15) {
				model.addAttribute("result", "false");
				model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
				return "/ajax/get-message-result.jsp";
			}
		}

		/* 아이디 체크 */
		List<MemberVo> getMemberList = memberService.getSearchMemberList(vo);
		if (getMemberList.size() > 0) {
			model.addAttribute("list", getMemberList);
			return "/ajax/get-member-list.jsp";
		} else if (getMemberList.size() == 0) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "회원정보가 존재하지 않습니다.");
			return "/ajax/get-message-result.jsp";
		}
		return "";
	}

	@RequestMapping("/point/detail/json")
	public String getDetailListForJson(OrderVo vo, Model model) {
		/* 입력값 검증 */
		if (StringUtil.isBlank("" + vo.getOrderSeq())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "검색할 장바구니를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 장바구니번호 체크 */
		OrderVo ovo;
		try {
			ovo = orderService.getData(vo);
		} catch (Exception e) {
			model.addAttribute("message",
					"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return "/ajax/get-message-result.jsp";
		}
		if (ovo != null) {
			vo.setStatusCode("99");
			model.addAttribute("list", orderService.getListForDetail(vo));
			return "/ajax/get-detail-list.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "주문이 존재하지 않습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/** 포인트 엑셀 다운 리스트 */
	@RequestMapping("/point/excel/list")
	public String pointExcelList(PointVo vo, Model model) {
		model.addAttribute("title", "포인트 엑셀 다운 리스트");

		// 특별하게 전체 일정을 잡지 않았다면 일주일간의 내역을 기본 세팅한다
		if (StringUtil.isBlank(vo.getSearchDate1())
				|| StringUtil.isBlank(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-7, "yyyy-MM-dd"));
		}

		// 전체 리스트 개수
		vo.setRowCount(20);
		vo.setTotalRowCount(pointService.getExcelDownListCount(vo).intValue());

		model.addAttribute("vo", vo);
		model.addAttribute("list", pointService.getExcelDownList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		return "/point/excel_list.jsp";
	}

	/** 포인트 엑셀 다운 */
	@CheckGrade(controllerName = "pointController", controllerMethod = "pointList")
	@RequestMapping("/point/list/download/excel")
	public void pointExcelDown(PointVo vo, HttpServletResponse response) throws Exception {

		vo.setRowCount(pointService.getExcelDownListCount(vo).intValue());
		// 엑셀 파일명
		response.setHeader("Content-Disposition",
				"attachment; filename = point_list.xls");
		// 워크북

		Workbook wb = null;
		try {
			wb = pointService.writeExcelPointList(vo, "xls");
		} catch (Exception e) {
			LOGGER.info(
					"회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
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

	/** 포인트 상세 리스트(모든회원) */
	@CheckGrade(controllerName = "pointController", controllerMethod = "pointDetailList")
	@RequestMapping("/point/all/list")
	public String pointAllList(PointVo vo, Model model) {
		model.addAttribute("title", "포인트 상세 리스트");

		model.addAttribute("mallList", mallService.getListSimple());

		vo.setRowCount(20);
		vo.setTotalRowCount(pointService.getShopPointCount(vo));
		model.addAttribute("listPoint", pointService.getShopPointList(vo));
		model.addAttribute("total", new Integer(vo.getTotalRowCount()));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));

		model.addAttribute("vo", vo);

		return "/point/all_list.jsp";
	}

	/** 포인트 상세 리스트 엑셀 다운(모든회원) */
	@CheckGrade(controllerName = "pointController", controllerMethod = "pointList")
	@RequestMapping("/point/all/list/download")
	public void pointListExcelDown(PointVo vo, HttpServletResponse response) throws Exception {

		vo.setRowCount(pointService.getShopPointCount(vo));
		// 엑셀 파일명
		response.setHeader("Content-Disposition",
				"attachment; filename = point_all_list.xls");
		// 워크북

		Workbook wb = null;
		try {
			wb = pointService.writePointAllList(vo, "xls");
		} catch (Exception e) {
			LOGGER.info("회원 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
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
}
