package com.smpro.controller.admin;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.CategoryService;
import com.smpro.service.OrderStatsService;
import com.smpro.service.SystemService;
import com.smpro.util.ExcelUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.CategoryVo;
import com.smpro.vo.CommonVo;
import com.smpro.vo.MemberGroupVo;
import com.smpro.vo.OrderVo;
import com.smpro.vo.SellerVo;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class OrderStatsController {
	//private static final Logger LOGGER = LoggerFactory.getLogger(OrderStatsController.class);
	
	@Resource(name = "orderStatsService")
	private OrderStatsService orderStatsService;
	
	@Resource(name = "systemService")
	private SystemService systemService;
	
	@Resource(name = "categoryService")
	private CategoryService categoryService;

	/** 상품 카테고리별 매출 통계 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByCategory")
	@RequestMapping("/stats/list/category")
	public String getListByCategory(OrderVo vo, Model model) {
		
		//기본 조회기간 한달
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-30, "yyyy-MM-dd"));
		}
		
		//기본 일별 조회
		if("".equals(vo.getSearchDateType())) {
			vo.setSearchDateType("day");
		}
		
		//상품 대분류 카테고리 조회
		CategoryVo cvo = new CategoryVo();
		cvo.setDepth(1);
		//cvo.setShowFlag("Y");
		vo.setCategoryList(categoryService.getListSimple(cvo));

		model.addAttribute("list", orderStatsService.getListByCategory(vo));
		model.addAttribute("lv1CategoryList", vo.getCategoryList());
		model.addAttribute("data", orderStatsService.getSumByCategory(vo));
		model.addAttribute("vo", vo);
		return "/stats/list_category.jsp";
	}
	
	/** 상품 카테고리별 매출 통계 상세 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByCategoryDetail")
	@RequestMapping("/stats/list/category/detail")
	public String getListByCategoryDetail(OrderVo vo, Model model) {
		
		model.addAttribute("list", orderStatsService.getListByCategoryDetail(vo));
		model.addAttribute("orderSum", orderStatsService.getListByCategoryDetailSum(vo));
		model.addAttribute("orderCancelSum", orderStatsService.getListByCategoryDetailCancelSum(vo));		
		model.addAttribute("vo", vo);
		return "/stats/list_category_detail.jsp";
	}
	
	/** 회원 구분별 매출 통계(공공기관) 상세 엑셀 다운로드 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByCategoryExcel")
	@RequestMapping("/stats/list/category/excel")
	public void getListByCategoryExcel(OrderVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = stats_list_category_" + loginId + "_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		
		// 워크북
		Workbook wb;

		/* 타이틀 항목 생성 */
		String[] strTitle = new String[13];
		int idx = 0;
		strTitle[idx++] = "결제 일자\r\n취소 일자";
		strTitle[idx++] = "기관 구분";
		strTitle[idx++] = "기관명";
		strTitle[idx++] = "부서명/직책";
		strTitle[idx++] = "주문자";
		strTitle[idx++] = "상품주문번호";
		strTitle[idx++] = "카테고리";
		strTitle[idx++] = "상품명\r\n옵션";
		strTitle[idx++] = "과/면세";
		strTitle[idx++] = "수량";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "공급가";
		strTitle[idx++] = "배송비";

		/* 주문리스트 */
		List<OrderVo> list = orderStatsService.getListByCategoryDetail(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrderVo ovo = list.get(i);
				ArrayList<Object> cell = new ArrayList<>();

				cell.add(ovo.getC10Date() + "\r\n" + ovo.getC99Date());
				cell.add("Y".equals(ovo.getInvestFlag()) ? "투자출연기관" : "공공기관");
				cell.add(ovo.getGroupName());
				cell.add(ovo.getDeptName() + "/" + ovo.getPosName());
				cell.add(ovo.getMemberName());
				cell.add(ovo.getSeq());
				cell.add(ovo.getCateLv1Name() + "\r\n" + ovo.getCateLv2Name() + "\r\n" + ovo.getCateLv3Name() + "\r\n" + ovo.getCateLv4Name());
				cell.add(ovo.getItemName() + "\r\n" + ovo.getOptionValue());
				cell.add(ovo.getTaxName());
				cell.add(StringUtil.formatAmount(ovo.getOrderCnt()));
				cell.add(StringUtil.formatAmount(ovo.getSellPrice()));
				cell.add(StringUtil.formatAmount(ovo.getSupplyPrice()));
				cell.add(StringUtil.formatAmount(ovo.getDeliCost()));			

				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, "xls", 0);

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
	
	/** 인증 구분별 매출 통계 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByAuthCategory")
	@RequestMapping("/stats/list/auth_category")
	public String getListByAuthCategory(OrderVo vo, Model model) {
		
		//기본 조회기간 한달
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-30, "yyyy-MM-dd"));
		}
		
		//기본 일별 조회
		if("".equals(vo.getSearchDateType())) {
			vo.setSearchDateType("day");
		}

		//인증구분 공통코드 리스트 조회
		vo.setAuthCategoryList(systemService.getCommonListOrderByValue(new Integer(35)));
		
		model.addAttribute("list", orderStatsService.getListByAuthCategory(vo));
		model.addAttribute("data", orderStatsService.getSumByAuthCategory(vo));
		model.addAttribute("vo", vo);
		return "/stats/list_auth_category.jsp";
	}
	
	/** 회원 구분별 매출 통계 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByMember")
	@RequestMapping("/stats/list/member")
	public String getListByMember(OrderVo vo, Model model) {
		
		//기본 조회기간 한달
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-30, "yyyy-MM-dd"));
		}
		
		//기본 일별 조회
		if("".equals(vo.getSearchDateType())) {
			vo.setSearchDateType("day");
		}

		model.addAttribute("list", orderStatsService.getListByMember(vo));
		model.addAttribute("data", orderStatsService.getSumByMember(vo));
		model.addAttribute("vo", vo);
		return "/stats/list_member.jsp";
	}
	
	/** 회원 구분별 매출 통계(공공기관) */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByMemberPublic")
	@RequestMapping("/stats/list/member/public")
	public String getListByMemberPublic(OrderVo vo, Model model) {
		
		//기본 조회기간 한달
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-30, "yyyy-MM-dd"));
		}

		model.addAttribute("list", orderStatsService.getListByMemberPublic(vo));
		model.addAttribute("vo", vo);
		return "/stats/list_member_public.jsp";
	}
	
	/** 회원 구분별 매출 통계(공공기관) 상세 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByMemberPublic")
	@RequestMapping("/stats/list/member/public/detail")
	public String getListByMemberPublicDetail(MemberGroupVo vo, Model model) {
		
		model.addAttribute("authCategoryList", systemService.getCommonListByGroup(new Integer(35)));
		model.addAttribute("list", orderStatsService.getListByMemberPublicDetail(vo));
		model.addAttribute("vo", vo);
		return "/stats/list_member_public_detail.jsp";
	}
	
	/** 회원 구분별 매출 통계(공공기관) 상세 엑셀 다운로드 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByMemberPublicExcel")
	@RequestMapping("/stats/list/member/public/excel")
	public void getListByMemberPublicExcel(MemberGroupVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = stats_list_member_public_" + loginId + "_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		
		// 워크북
		/** 입점업체별 정산 주문 리스트 엑셀 생성 */
		Workbook wb;

		/* 타이틀 항목 생성 */
		String[] strTitle = new String[16];
		int idx = 0;
		strTitle[idx++] = "결제 일자";
		strTitle[idx++] = "취소 일자";
		strTitle[idx++] = "기관 구분";
		strTitle[idx++] = "기관명";
		strTitle[idx++] = "부서명/직책";
		strTitle[idx++] = "주문자";
		strTitle[idx++] = "입점업체명";
		strTitle[idx++] = "사업자번호";
		strTitle[idx++] = "인증구분";
		strTitle[idx++] = "상품주문번호";
		strTitle[idx++] = "상품명\r\n옵션";
		strTitle[idx++] = "과/면세";
		strTitle[idx++] = "수량";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "공급가";
		strTitle[idx++] = "배송비";

		/* 주문리스트 */
		List<OrderVo> list = orderStatsService.getListByMemberPublicDetail(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			//인증구분 공통 코드 가져오기
			List<CommonVo> authCategoryList = systemService.getCommonListByGroup(new Integer(35));
			
			for (int i = 0; i < list.size(); i++) {
				OrderVo ovo = list.get(i);
				ArrayList<Object> cell = new ArrayList<>();

				cell.add(ovo.getC10Date().substring(0, ovo.getC10Date().indexOf(" ")));
				cell.add(ovo.getC99Date().indexOf(" ") > 0 ? ovo.getC99Date().substring(0, ovo.getC99Date().indexOf(" ")) : "");
				cell.add("Y".equals(ovo.getInvestFlag()) ? "투자출연기관" : "공공기관");
				cell.add(ovo.getGroupName());
				cell.add(ovo.getDeptName() + "/" + ovo.getPosName());
				cell.add(ovo.getMemberName());
				cell.add(ovo.getSellerName());
				cell.add(ovo.getBizNo().substring(0,3) + "-" + ovo.getBizNo().substring(3,5) + "-" + ovo.getBizNo().substring(5));
				
				String authCategory = "";
				if(authCategoryList != null) {
					int size = authCategoryList.size();
					for(int j=0; j < size; j++) {
						CommonVo cvo = authCategoryList.get(j);
						if(ovo.getAuthCategory().contains(cvo.getValue())) {
							authCategory += cvo.getName() + "\r\n";
						}
					}
				}
				cell.add(authCategory);
				
				cell.add(ovo.getSeq());
				cell.add(ovo.getItemName() + "\r\n" + ovo.getOptionValue());
				cell.add(ovo.getTaxName());
				cell.add(StringUtil.formatAmount(ovo.getOrderCnt()));
				cell.add(StringUtil.formatAmount(ovo.getSellPrice()));
				cell.add(StringUtil.formatAmount(ovo.getSupplyPrice()));
				cell.add(StringUtil.formatAmount(ovo.getDeliCost()));			

				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, "xls", 0);

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
	
	/** 상품별 누적 판매수 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByItem")
	@RequestMapping("/stats/list/item")
	public String getListByItem(OrderVo vo, Model model) {
		
		//기본 조회기간 한달
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-30, "yyyy-MM-dd"));
		}

		model.addAttribute("list", orderStatsService.getListByItem(vo));
		model.addAttribute("itemSum", orderStatsService.getListByItemSum(vo));
		model.addAttribute("itemCancelSum", orderStatsService.getListByItemCancelSum(vo));
		model.addAttribute("vo", vo);
		return "/stats/list_item.jsp";
	}
	
	/** 자치구별 상품 누적 판매수 */
	@CheckGrade(controllerName = "orderStatsController", controllerMethod = "getListByItemForJachigu")
	@RequestMapping("/stats/list/item/jachigu/{userType}")
	public String getListByItemForJachigu(@PathVariable String userType, SellerVo vo, Model model) {
		
		//기본 조회기간 한달
		if ("".equals(vo.getSearchDate1()) || "".equals(vo.getSearchDate2())) {
			vo.setSearchDate2(StringUtil.getDate(0, "yyyy-MM-dd"));
			vo.setSearchDate1(StringUtil.getDate(-30, "yyyy-MM-dd"));
		}
		
		//자치구별 상품 판매수 리스트 저장 변수		
		List<List<OrderVo>> lists = new ArrayList<>();
		
		//자치구별 상품 판매수 매출 합계 저장 변수
		List<OrderVo> sLists = new ArrayList<>();
		
		//자치구 코드 조회
		List<CommonVo> cList = systemService.getCommonListByGroup(new Integer((29)));
		//자치구 갯수별로 루프를 돌면서 리스트를 저장한다.
		for(CommonVo cvo : cList) {
			vo.setJachiguCode(cvo.getValue());
			if("seller".equals(userType)) {
				lists.add(orderStatsService.getListByItemForSellerJachigu(vo));
				sLists.add(orderStatsService.getListByItemForSellerJachiguSum(vo));
			} else {
				lists.add(orderStatsService.getListByItemForMemberJachigu(vo));
				sLists.add(orderStatsService.getListByItemForMemberJachiguSum(vo));
			}
		}
		
		model.addAttribute("cList", cList);
		model.addAttribute("lists", lists);
		model.addAttribute("sLists", sLists);
		
		model.addAttribute("vo", vo);
		model.addAttribute("userType", userType);
		return "/stats/list_item_jachigu.jsp";
	}
	
}
