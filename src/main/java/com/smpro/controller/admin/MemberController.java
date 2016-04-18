package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.List;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberGroupService memberGroupService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private MallService mallService;

	@Autowired
	private PointService pointService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private MemberDeliveryService memberDeliveryService;

	@CheckGrade(controllerName = "memberController", controllerMethod = "getStats")
	@RequestMapping("/member/stats")
	public String getStats(Model model) {
		model.addAttribute("title", "회원 현황");
		model.addAttribute("vo", memberService.getStats());
		return "/member/stats.jsp";
	}

	/** 한달간 전체 회원 현황 */
	@RequestMapping("/member/chartstats/month/json")
	public String getChartMonthStats(Model model) {
		model.addAttribute("list", memberService.getMonthMemberStats());
		return "/ajax/get-member-stats-list.jsp";
	}

	/** 일주일간 신규가입 회원 현황 */
	@RequestMapping("/member/chartstats/week/json")
	public String getChartWeekStats(Model model) {
		model.addAttribute("list", memberService.getWeekMemberStats());
		return "/ajax/get-member-stats-list.jsp";
	}

	@CheckGrade(controllerName = "memberController", controllerMethod = "getList")
	@RequestMapping("/member/list")
	public String getList(MemberVo pvo, Model model) throws Exception {
		model.addAttribute("title", "회원 리스트" + ("Y".equals(pvo.getLongTermNotLoginFlag()) ? "(1년이상 미접속자)":""));
		
		/* 공통코드 리스트 가져오기 */
		CommonVo cvo = new CommonVo();
		// 상태
		cvo.setGroupCode(new Integer(1));
		model.addAttribute("statusList", systemService.getCommonList(cvo));
		// 등급
		cvo.setGroupCode(new Integer(8));
		model.addAttribute("gradeList", systemService.getCommonList(cvo));
		// 회원구분
		cvo.setGroupCode(new Integer(30));
		model.addAttribute("memberTypeList", systemService.getCommonList(cvo));
		
		MallVo mvo = new MallVo();
		model.addAttribute("mallList", mallService.getList(mvo));
		
		//최초 접속시 개인회원으로 초기화
		if("".equals(pvo.getMemberTypeCode())) {
			pvo.setMemberTypeCode("C");			
		}
		
		pvo.setTotalRowCount(memberService.getListCount(pvo));
		model.addAttribute("list", memberService.getList(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		return "/member/list.jsp";
	}
	
	@CheckGrade(controllerName = "memberController", controllerMethod = "getListNotAccess")
	@RequestMapping("/member/list/not_access")
	public String getListNotAccess(MemberVo pvo, Model model) throws Exception {
		pvo.setLongTermNotLoginFlag("Y");
		return getList(pvo, model);
	}

	@CheckGrade(controllerName = "memberController", controllerMethod = "getView")
	@RequestMapping("/member/view/{seq}")
	public String getView(@PathVariable Integer seq, Model model) throws Exception {
		MemberVo vo = memberService.getData(seq);
		model.addAttribute("vo", vo);
		if(vo != null) {
			model.addAttribute("gvo", memberGroupService.getVo(vo.getGroupSeq()));
		}
		
		return "/member/view.jsp";
	}

	@CheckGrade(controllerName = "memberController", controllerMethod = "getData")
	@RequestMapping("/member/mod/{seq}")
	public String getData(@PathVariable Integer seq, Model model) throws Exception {
		MemberVo vo = memberService.getData(seq);
		MemberGroupVo gvo = null;
		if(vo != null) {
			gvo = memberGroupService.getVo(vo.getGroupSeq());
		}
		
		CommonVo cvo = new CommonVo();
		//자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		//회원 정보
		model.addAttribute("vo", vo);
		//기관 or 기업/시설/단체 정보
		model.addAttribute("gvo", gvo);
		return "/member/mod.jsp";
	}

	@RequestMapping("/member/mod")
	public String modData(MemberVo vo, Model model) throws Exception {
		if (memberService.modData(vo)) {
			model.addAttribute("message", "수정 성공.");
			model.addAttribute("returnUrl", "/admin/member/mod/" + vo.getSeq());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "수정 실패.");
		return Const.ALERT_PAGE;

	}
	
	@RequestMapping("/member/group/mod")
	public String modMemberGroup(Integer memberSeq, MemberGroupVo vo, Model model) {
		String errMsg = "";
		try {
			if (memberGroupService.modVo(vo)) {
				model.addAttribute("message", "수정 성공.");
				model.addAttribute("returnUrl", "/admin/member/mod/" + memberSeq);
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			if(e.getMessage() == null) {
				errMsg = "처리 도중 오류가 발생하였습니다.";
			} else {
				errMsg = e.getMessage();
			}
		}
		

		model.addAttribute("message", "수정 실패. ["+errMsg+"]");
		return Const.ALERT_PAGE;

	}

	/** 회원 리스트 엑셀 다운로드 
	 * @throws InvalidKeyException */
	@CheckGrade(controllerName = "memberController", controllerMethod = "writeExcelMemberList")
	@RequestMapping("/member/list/download/excel")
	public void writeExcelMemberList(MemberVo vo, HttpSession session, HttpServletResponse response) throws Exception {
		vo.setRowCount(3000);
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = member_list_" + loginId + "_"	+ StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		// 워크북
		Workbook wb = memberService.writeExcelMemberist(vo, "xls");
		// 파일스트림
		OutputStream fileOut = response.getOutputStream();
		wb.write(fileOut);
		wb.close();

		if (fileOut != null) {
			fileOut.flush();
			fileOut.close();
		}
	}

	@CheckGrade(controllerName = "memberController", controllerMethod = "formExcel")
	@RequestMapping("/member/excel/form")
	public String form(Model model) {
		model.addAttribute("title", "엑셀 회원 등록");

		model.addAttribute("mallList", mallService.getListSimple());

		return "/member/excel_form.jsp";
	}

	@RequestMapping("/member/excel/upload/proc")
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public String uploadData(Integer mallSeq, HttpServletRequest request, Model model) throws IOException {
		List<String> errorList = new ArrayList<>();
		//MallVo mvo = mallService.getVo(mallSeq);
		List<MemberVo> regList = new ArrayList<>();

		/* 업로드된 엑셀 파일 객체 가져오기 */
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		MultipartFile xlsFile = mpRequest.getFile("xlsFile");

		/* 쇼핑몰 시퀀스 */
		if (mallSeq == null) {
			model.addAttribute("callback", "MSG:쇼핑몰을 선택해 주세요.");
			return Const.REDIRECT_PAGE;
		}

		/* 업로드 처리 */
		List<String[]> list = new XlsService().readXlsFile(xlsFile.getInputStream());

		if (list == null) {
			model.addAttribute("callback", "MSG:잘못된 회원등록 양식 입니다.");
			return Const.REDIRECT_PAGE;
		}

		for (int i = 0; i < list.size(); i++) {
			String[] row = list.get(i);
			// 값 유효성 검증
			String errMsg = memberService.chkXlsData(row, mallSeq);
			if (errMsg != "") {
				String msg = "";
				if (i != 0) {
					msg += "|";
				}
				msg += "(" + (i + 2) + "번째 행) " + errMsg;
				errorList.add(msg);
			} else {
				MemberVo vo = new MemberVo();
				vo.setId(row[0]);
				vo.setName(row[1]);
				vo.setPassword(row[2]);
				if (row.length > 3) {
					vo.setCell(row[3]);
					if (row.length > 4) {
						vo.setEmail(row[4]);
					}
				}
				vo.setMallSeq(mallSeq);
				vo.setTypeCode("C");
				vo.setStatusCode("Y");
				regList.add(vo);
			}
		}

		if (errorList.size() > 0) {
			//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			model.addAttribute("callback", "LIST:" + errorList);
			return Const.REDIRECT_PAGE;
		}

		for (int i = 0; i < regList.size(); i++) {
			if (memberService.getIdCnt(regList.get(i)) > 0) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				model.addAttribute("callback", "MSG:(" + (i + 2) + "번째 행) " + "중복된 아이디가 있습니다.");
				return Const.REDIRECT_PAGE;
			}
			try {
				memberService.regData(regList.get(i));
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				model.addAttribute("callback", "MSG:(" + (i + 2) + "번째 행) " + "등록중 서버오류가 발생 하였습니다.");
				return Const.REDIRECT_PAGE;
			}
		}

		model.addAttribute("callback", "MEMBER");
		return Const.REDIRECT_PAGE;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	@RequestMapping("/point/excel/upload/proc")
	public String uploadPointData(Integer mallSeq, HttpServletRequest request, HttpSession session, Model model) throws IOException {
		List<String> errorList = new ArrayList<>();
		List<PointVo> regList = new ArrayList<>();
		MemberVo mvo = new MemberVo();

		/* 업로드된 엑셀 파일 객체 가져오기 */
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		MultipartFile xlsFile = mpRequest.getFile("xlsFile");

		/* 쇼핑몰 시퀀스 */
		if (mallSeq == null) {
			model.addAttribute("callback", "MSG:쇼핑몰을 선택해 주세요.");
			return Const.REDIRECT_PAGE;
		}

		/* 업로드 처리 */
		List<String[]> list = new XlsService().readXlsFile(xlsFile.getInputStream());

		if (list == null) {
			model.addAttribute("callback", "MSG:잘못된 포인트 양식 입니다.");
			return Const.REDIRECT_PAGE;
		}

		for (int i = 0; i < list.size(); i++) {
			String[] row = list.get(i);
			// 값 유효성 검증
			String errMsg = pointService.chkXlsData(row);
			if (errMsg != "") {
				String msg = "";
				if (i != 0) {
					msg += "|";
				}
				msg += "(" + (i + 2) + "번째 행) " + errMsg;
				errorList.add(msg);
			} else {
				mvo.setId(row[0]);
				mvo.setMallSeq(mallSeq);
				Integer seq = memberService.getMemberSeq(mvo);

				if (seq != null) {
					PointVo vo = new PointVo();
					Integer memberSeq = Integer.valueOf(("" + session.getAttribute("loginSeq")));
					vo.setAdminSeq(memberSeq);
					vo.setStatusCode("S");
					vo.setMemberSeq(seq);
					vo.setEndDate(row[1]);
					vo.setPoint(Integer.parseInt(row[2]));
					if (row[3].equals("Y")) {
						vo.setUseablePoint(Integer.parseInt(row[2]));
					}
					vo.setValidFlag(row[3]);
					vo.setReserveCode(row[4]);
					vo.setTypeCode("1");
					vo.setReserveComment(row[5]);
					regList.add(vo);
				} else {
					errorList.add("(" + (i + 2) + "번째 행) "+ "존재 하지않는 회원 아이디 입니다.");
				}
			}
		}

		if (errorList.size() > 0) {
			model.addAttribute("callback", "LIST:" + errorList);
			return Const.REDIRECT_PAGE;
		}
		
		for (int i = 0; i < regList.size(); i++) {
			PointVo tempVo = regList.get(i);
			try {
				pointService.regPoint(tempVo);
			} catch(Exception e) {
				model.addAttribute("callback", "(" + (i + 2) + "번째 행) " + "등록중 서버오류가 발생 하였습니다.");
				return Const.REDIRECT_PAGE;
			}
		}

		model.addAttribute("callback", "POINT");
		return Const.REDIRECT_PAGE;
	}
	
	/*
	 * 회원 정보 상세 CS 리스트
	 */
	@CheckGrade(controllerName = "memberController", controllerMethod = "getCsList")
	@RequestMapping("/member/cs/list/{listType}")
	public String getCsList(@PathVariable String listType, Integer memberSeq, int pageNum, HttpSession session, Model model) throws Exception {
		String loginType = (String) session.getAttribute("loginType");
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		
		if("order".equals(listType)) {
			OrderVo pvo = new OrderVo();
			pvo.setLoginType(loginType);
			pvo.setLoginSeq(loginSeq);
			pvo.setMemberSeq(memberSeq);
			pvo.setPageNum(pageNum);
			pvo.setTotalRowCount(orderService.getListCount(pvo));
			
			model.addAttribute("list", orderService.getList(pvo));
			model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		} else if("point".equals(listType)) {
			PointVo pvo = new PointVo();
			pvo.setLoginType(loginType);
			pvo.setLoginSeq(loginSeq);
			pvo.setMemberSeq(memberSeq);
			pvo.setPageNum(pageNum);
			pvo.setTotalRowCount(pointService.getShopPointCount(pvo));
			
			model.addAttribute("list", pointService.getShopPointList(pvo));
			model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		} else if("one".equals(listType)) {
			BoardVo pvo = new BoardVo();
			pvo.setLoginType(loginType);
			pvo.setLoginSeq(loginSeq);
			pvo.setUserSeq(memberSeq);
			pvo.setLoginType((String)session.getAttribute("loginType"));
			pvo.setGroupCode(listType);
			pvo.setPageNum(pageNum);
			pvo.setTotalRowCount(boardService.getListCount(pvo));
			
			model.addAttribute("list", boardService.getList(pvo));
			model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		} else if("review".equals(listType)) {
			ReviewVo pvo = new ReviewVo();
			pvo.setLoginType(loginType);
			pvo.setLoginSeq(loginSeq);
			pvo.setMemberSeq(memberSeq);
			pvo.setLoginType((String)session.getAttribute("loginType"));
			pvo.setPageNum(pageNum);
			pvo.setTotalRowCount(reviewService.getListCount(pvo));
			
			model.addAttribute("list", reviewService.getList(pvo));
			model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		} else if("delivery".equals(listType)) {
			MemberDeliveryVo pvo = new MemberDeliveryVo();
			pvo.setMemberSeq(memberSeq);
			
			List<MemberDeliveryVo> list = memberDeliveryService.getList(pvo); 
			model.addAttribute("list", list);
			model.addAttribute("total", new Integer(list.size()));
		} else if("cs".equals(listType)) {
			OrderVo pvo = new OrderVo();
			pvo.setLoginType(loginType);
			pvo.setLoginSeq(loginSeq);
			pvo.setMemberSeq(memberSeq);
			pvo.setPageNum(pageNum);
			pvo.setTotalRowCount(orderService.getCsLogListCount(pvo));
			
			List<OrderVo> list = orderService.getCsLogList(pvo); 
			model.addAttribute("list", list);
			model.addAttribute("total", new Integer(list.size()));
			model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		}
		
		
		return "/ajax/get-"+listType+"-list.jsp";
	}
}
