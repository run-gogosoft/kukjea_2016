package com.smpro.service;

import com.smpro.dao.*;
import com.smpro.util.Const;
import com.smpro.util.ExcelUtil;
import com.smpro.util.FileDownloadUtil;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.*;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private OrderPayDao orderPayDao;

	@Autowired
	private SystemDao systemDao;

	@Autowired
	private PointDao pointDao;

	@Autowired
	private EstimateDao estimateDao;

	@Autowired
	private OrderTaxRequestDao orderTaxRequestDao;

	public List<OrderVo> getList(OrderVo pvo) throws Exception {
		List<OrderVo> getList = orderDao.getList(pvo);
		for (OrderVo vo : getList) {
			//개인정보 복호화
			decryptData(vo);
			
			// LGUPLUS 영수증 출력용 MD5 인증값 생성
			vo.setAuthData(StringUtil.encryptMd5(vo.getMid() + vo.getTid() + vo.getPgKey()));
		}
		if (pvo.getSearch().equals("receiver_num")) {
			pvo.setFindword(CrypteUtil.decrypt(pvo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		return getList;
	}

	public List<OrderVo> getRepeatOrderList(OrderVo pvo) throws Exception{
		List<OrderVo> getList = orderDao.getRepeatOrderList(pvo);
		for (OrderVo vo : getList) {
			//개인정보 복호화
			decryptData(vo);

			// LGUPLUS 영수증 출력용 MD5 인증값 생성
			vo.setAuthData(StringUtil.encryptMd5(vo.getMid() + vo.getTid() + vo.getPgKey()));
		}
		if (pvo.getSearch().equals("receiver_num")) {
			pvo.setFindword(CrypteUtil.decrypt(pvo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		return getList;
	}

	public int getListCount(OrderVo vo) {
		return orderDao.getListCount(vo);
	}

	public List<OrderVo> getCsOrderList(OrderVo pvo) {
		return orderDao.getCsOrderList(pvo);
	}

	public Integer getCsOrderListCount(OrderVo vo) {
		return orderDao.getCsOrderListCount(vo);
	}

	public List<OrderVo> getCsLogList(OrderVo vo) {
		return orderDao.getCsLogList(vo);
	}

	public int getCsLogListCount(OrderVo vo) {
		return orderDao.getCsLogListCount(vo);
	}

	public List<OrderVo> getListForDetail(OrderVo vo) {
		return orderDao.getListForDetail(vo);
	}

	public List<OrderCsVo> getCsList(Integer seq) {
		return orderDao.getCsList(seq);
	}

	public List<OrderCsVo> getLogList(Integer seq) {
		return orderDao.getLogList(seq);
	}

	public OrderVo getData(OrderVo ovo) throws Exception {
		OrderVo vo = orderDao.getData(ovo);
		if( vo != null) {
			//개인정보 복호화
			decryptData(vo);
		}
		return vo;
	}
	
	/**
	 * 세금계산서 요청서
	 */
	public OrderVo getTaxRequestData(Integer orderSeq) throws Exception {
		OrderVo vo = orderTaxRequestDao.getData(orderSeq);
		if( vo != null) {
			//개인정보 복호화
			if(vo.getRequestCell() != null && !"".equals(vo.getRequestCell())) {
				vo.setRequestCell(CrypteUtil.decrypt(vo.getRequestCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
			if(vo.getRequestEmail() != null && !"".equals(vo.getRequestEmail())) {
				vo.setRequestEmail(CrypteUtil.decrypt(vo.getRequestEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
		}
		return vo;
	}

	public boolean regData(OrderVo vo) throws Exception {
		vo.setReceiverTel(CrypteUtil.encrypt(vo.getReceiverTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		vo.setReceiverCell(CrypteUtil.encrypt(vo.getReceiverCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		vo.setReceiverAddr2(CrypteUtil.encrypt(vo.getReceiverAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		return orderDao.regData(vo) > 0;
	}

	public boolean regData(OrderCsVo vo) {
		return orderDao.regCsData(vo) > 0;
	}

	public boolean regLogData(OrderLogVo vo) {
		return orderDao.regLogData(vo) > 0;
	}

	public boolean modData(OrderVo vo) {
		return orderDao.modData(vo) > 0;
	}

	public boolean regDetailData(OrderVo vo) {
		return orderDao.regDetailData(vo) > 0;
	}

	/** 주문 상태 변경 */
	public boolean updateStatus(OrderVo vo) {
		int procCnt = 0;

		OrderLogVo logVo = this.createLogVo(vo);
		procCnt = orderDao.updateStatus(vo);
		if (procCnt > 0) {
			// 주문 변경 로그 등록
			if (logVo != null) {
				orderDao.regLogData(logVo);
			}
		}
		return procCnt > 0;
	}
	
	/** 주문 상태 변경(입금확인) */
	public boolean updateStatusForConfirm(OrderVo vo) {
		List<OrderLogVo> list = this.createLogVoList(vo);
		int procCnt = orderDao.updateStatusForConfirm(vo.getOrderSeq());
		if (procCnt > 0) {
			// 주문 변경 로그 등록
			if (list != null && list.size() > 0) {
				for(OrderLogVo logVo : list) {
					orderDao.regLogData(logVo);
				}
			}
		}
		return procCnt > 0;
	}
	
	/** 주문 상태 변경(취소완료) */
	public boolean updateStatusForCancelByOrderSeq(OrderVo vo) {
		List<OrderLogVo> list = this.createLogVoList(vo);
		int procCnt = orderDao.updateCancelAll(vo);
		if (procCnt > 0) {
			// 주문 변경 로그 등록
			if (list != null && list.size() > 0) {
				for(OrderLogVo logVo : list) {
					orderDao.regLogData(logVo);
				}
			}
		}
		return procCnt > 0;
	}

	/** 주문 상태 일괄 변경 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateStatus(Integer[] seq, String statusCode, Integer loginSeq) {
		int procCntTotal = 0;
		if (seq != null) {
			for (int i = 0; i < seq.length; i++) {
				OrderVo vo = new OrderVo();
				vo.setSeq(seq[i]);
				vo.setStatusCode(statusCode);
				vo.setLoginSeq(loginSeq);

				/* 1. 주문 변경 로그 VO 생성 */
				OrderLogVo logVo = this.createLogVo(vo);
				/* 2. 주문 상태 변경 */
				int procCnt;
				procCnt = orderDao.updateStatus(vo);
				/* 3. 주문 변경 로그 등록 */
				if (procCnt > 0) {
					if (logVo != null) {
						orderDao.regLogData(logVo);
					}
				}
				procCntTotal = procCntTotal + procCnt;
			}
		}
		return procCntTotal;
	}

	/** 주문 상태 일괄 변경(배송중 처리) */
	public int updateStatusForDelivery(Integer[] seq, String statusCode, Integer loginSeq, Integer[] deliSeq, String[] deliNo,Integer[] boxCnt, Integer[] totalDeliCost) {
		return updateStatusForDelivery(seq, statusCode, loginSeq, deliSeq, deliNo, boxCnt, totalDeliCost, null);
	}

	/** 주문 상태 일괄 변경 - 송장 일괄 업로드 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateStatusForDelivery(Integer[] seq, String statusCode, Integer loginSeq, Integer[] deliSeq, String[] deliNo, Integer[] boxCnt, Integer[] totalDeliCost,Integer sellerSeq) {
		int procCntTotal = 0;
		if (seq != null) {
			for (int i = 0; i < seq.length; i++) {
				OrderVo vo = new OrderVo();
				vo.setSeq(seq[i]);
				vo.setStatusCode(statusCode);
				vo.setLoginSeq(loginSeq);
				vo.setSellerSeq(sellerSeq);

				if (deliSeq != null && deliSeq[i].intValue() > 0) {
					vo.setDeliSeq(deliSeq[i]);
					vo.setDeliNo(deliNo[i]);
					vo.setBoxCnt(boxCnt[i]);
					vo.setTotalDeliCost(totalDeliCost[i]);
					System.out.println("### updateStatusForDelivery, seq:"+deliSeq[i]+", deliNo:"+deliNo[i]+", boxCnt:"+boxCnt[i]+", totalDeliCost:"+totalDeliCost[i]);
				}

				/* 1. 주문 변경 로그 VO 생성 */
				OrderLogVo logVo = this.createLogVo(vo);
				/* 2. 주문 상태 변경 */
				int procCnt = 0;
				procCnt = orderDao.updateStatusForDelivery(vo);
				/* 3. 주문 변경 로그 등록 */
				if (procCnt > 0) {
					if (logVo != null) {
						orderDao.regLogData(logVo);
					}
				}
				procCntTotal = procCntTotal + procCnt;
			}
		}
		return procCntTotal;
	}

	/** 주문 정보 변경 이력 VO 생성(건별) */
	private OrderLogVo createLogVo(OrderVo vo) {
		/* 체크항목 데이터 추가시 Select 쿼리 수정 */
		OrderVo dbVo = orderDao.getCheckData(vo.getSeq());
		
		return createLogVoMsg(vo, dbVo);
	}
	
	/** 주문 정보 변경 이력 VO 생성(주문번호별) */
	private List<OrderLogVo> createLogVoList(OrderVo vo) {
		List<OrderLogVo> logVoArr = new ArrayList<>();
		/* 체크항목 데이터 추가시 Select 쿼리 수정 */
		List<OrderVo> list = orderDao.getCheckList(vo.getOrderSeq());

		if(list != null) {
			for(OrderVo dbVo : list) {
				logVoArr.add(createLogVoMsg(vo, dbVo));
			}
		}
		
		return logVoArr;
	}
	
	/** 주문 번호 변경 이력 내용 생성 */
	private OrderLogVo createLogVoMsg(OrderVo vo, OrderVo dbVo) {
		String contents = "";
		StringBuffer sb = new StringBuffer();
		OrderLogVo logVo = null;
		/* 체크 항목 갯수별로 IF블럭 추가 */
		/* 메세지 생성방식(항목1:변경값1,항목2:변경값2,......) */
		if (!"".equals(vo.getStatusCode())	&& !dbVo.getStatusCode().equals(vo.getStatusCode())) {
			CommonVo cvo = new CommonVo();
			cvo.setGroupCode(new Integer(6));
			cvo.setValue(vo.getStatusCode());
			sb.append("주문상태:" + systemDao.getCommonName(cvo));
		}

		contents = sb.toString();
		if (!"".equals(contents)) {
			/* 로그 VO 생성 */
			logVo = new OrderLogVo();
			logVo.setOrderDetailSeq(dbVo.getSeq());
			logVo.setContents(contents);
			logVo.setLoginSeq(vo.getLoginSeq());
		}
		
		return logVo;
	}
	

	/** 송장정보 일괄 업로드 대상 주문 엑셀파일 포맷으로 생성 */
	public HSSFWorkbook createDeliveryXlsFile(Integer sellerSeq) throws Exception {
		HSSFWorkbook wb = null;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[20];
		int idx = 0;
		strTitle[idx++] = "No.";
		strTitle[idx++] = "상품주문번호";
		strTitle[idx++] = "주문번호";
		strTitle[idx++] = "택배사 코드";
		strTitle[idx++] = "송장번호";
		strTitle[idx++] = "상품코드";
		strTitle[idx++] = "상품명";
		strTitle[idx++] = "상품 옵션";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "공급가";
		strTitle[idx++] = "구매 수량";
		strTitle[idx++] = "배송비";
		strTitle[idx++] = "배송 구분";
		strTitle[idx++] = "배송 요청 사항";
		strTitle[idx++] = "주문자";
		strTitle[idx++] = "수취인";
		strTitle[idx++] = "배송지 주소";
		strTitle[idx++] = "수취인 연락처1";
		strTitle[idx++] = "수취인 연락처2";
		strTitle[idx++] = "주문 확인일";

		/* 데이터 생성 */
		List<OrderVo> list = orderDao.getDeliveryTargetList(sellerSeq);
		List<String[]> strList = new ArrayList<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrderVo vo = list.get(i);
				idx = 0;

				//개인정보 복호화
				decryptData(vo);

				String[] strData = new String[20];
				strData[idx++] = String.valueOf(i + 1);
				strData[idx++] = String.valueOf(vo.getSeq());
				strData[idx++] = String.valueOf(vo.getOrderSeq());
				strData[idx++] = "";
				strData[idx++] = "";
				strData[idx++] = String.valueOf(vo.getItemSeq());
				strData[idx++] = vo.getItemName();
				strData[idx++] = vo.getOptionValue();
				strData[idx++] = StringUtil.formatAmount(vo.getSellPrice());
				strData[idx++] = StringUtil.formatAmount(vo.getSupplyPrice());
				strData[idx++] = StringUtil.formatAmount(vo.getOrderCnt());
				strData[idx++] = StringUtil.formatAmount(vo.getDeliCost());
				strData[idx++] = vo.getDeliPrepaidFlag();
				strData[idx++] = vo.getRequest();
				strData[idx++] = vo.getMemberName();
				strData[idx++] = vo.getReceiverName();
				strData[idx++] = vo.getReceiverPostcode() + vo.getReceiverAddr1() + vo.getReceiverAddr2();
				strData[idx++] = vo.getReceiverTel();
				strData[idx++] = vo.getReceiverCell();
				strData[idx++] = vo.getC20Date();

				strList.add(strData);
			}
		}

		/* 엑셀 파일 생성 */
		wb = XlsService.createFile(strTitle, strList);

		return wb;
	}

	/** 엑셀 데이터 유효성 체크 */
	public String chkDeliveryXlsData(String[] row) {
		String errPosMsg = " (행번호:" + row[0] + ")";

		/* 상품 주문 번호 */
		String seq = row[1];
		/* 택배사 코드 */
		String deliSeq = row[3];
		/* 송장 번호 */
		String deliNo = row[4];

		/* 필수값 체크 */
		if (StringUtil.isBlank(seq)) {
			return "상품주문번호 미입력" + errPosMsg;
		}
		if (StringUtil.isBlank(deliSeq)) {
			return "택배사 코드 미입력" + errPosMsg;
		}
		if (!StringUtil.isNum(deliSeq)) {
			return "택배사 코드가 숫자 형식 아님" + errPosMsg;
		}
		if (systemDao.getDeliCompanyVo(Integer.valueOf(deliSeq)) == null) {
			return "택배사 코드가 존재하지 않습니다" + errPosMsg;
		}

		if (StringUtil.isBlank(deliNo)) {
			return "송장 번호 미입력" + errPosMsg;
		}

		/* 숫자 체크 */
		if (!StringUtil.isNum(seq)) {
			return "상품주문번호 숫자 형식 아님" + errPosMsg;
		}
		if (!StringUtil.isNum(deliSeq)) {
			return "택배사 코드 숫자 형식 아님" + errPosMsg;
		}
		if (!StringUtil.isNum(deliNo)) {
			return "송장 번호 숫자 숫자 형식 아님" + errPosMsg;
		}

		/* 길이 체크 */
		if (deliNo.length() > 20) {
			return "송장 번호 최대 길이(20자리) 초과" + errPosMsg;
		}

		return null;
	}

	/** 판매 일보 */
	public List<OrderVo> getSellDaily(OrderVo vo) {
		return orderDao.getSellDaily(vo);
	}

	/** 주문상태별 건수 */
	public HashMap<String, String> getCntByStatus(OrderVo pvo) {
		List<HashMap<String, String>> list = orderDao.getCntByStatus(pvo);
		HashMap<String, String> result = null;
		if (list != null) {
			result = new HashMap<>();
			int cnt30 = 0;
			for (int i = 0; i < list.size(); i++) {
				HashMap<String, String> row = list.get(i);
				String statusCode = row.get("STATUS_CODE");
				
				int cnt = 0;
				if(row.get("CNT") != null) {
					cnt = Integer.parseInt(String.valueOf(row.get("CNT")));
				}
				
				if ("30".equals(statusCode) || "40".equals(statusCode) || "41".equals(statusCode) || "42".equals(statusCode)) {
					// 배송중은 별도 합산
					cnt30 = cnt30 + cnt;
				} else {
					result.put("STATUS_" + statusCode, String.valueOf(cnt));
				}
			}

			if (cnt30 > 0) {
				result.put("STATUS_30", String.valueOf(cnt30));
			}
		}
		return result;
	}

	/** 구매확정된 총 구매 금액 */
	public String getTotalOrderFinishPrice(Integer loginSeq) {
		return orderDao.getTotalOrderFinishPrice(loginSeq);
	}

	/** 구매금액 랭킹 순위 */
	public List<OrderVo> getRankingOrderFinishPrice(OrderVo vo) {
		return orderDao.getRankingOrderFinishPrice(vo);
	}

	/** 금일 매출현황 */
	public List<OrderVo> getDayOrderStatus(MemberVo memberVo) {
		return orderDao.getDayOrderStatus(memberVo);
	}

	/** 금월 매출현황 */
	public List<OrderVo> getMonthOrderStatus(MemberVo memberVo) {
		return orderDao.getMonthOrderStatus(memberVo);
	}

	/** 금년 매출현황 */
	public List<OrderVo> getYearOrderStatus(MemberVo memberVo) {
		return orderDao.getYearOrderStatus(memberVo);
	}

	/** 일주일간 쇼핑몰 현황 */
	public OrderVo getOrderSumForWeek(MemberVo memberVo) {
		return orderDao.getOrderSumForWeek(memberVo);
	}

	/** 일주일 매출 추이 */
	public List<OrderVo> getOrderSumChartForWeek(HttpSession session) {
		List<OrderVo> getList = new ArrayList<>();
		OrderVo vo = new OrderVo();
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		for (int i = 6; i >= 0; i--) {
			vo.setWeekPeriodCount(i);
			OrderVo tmpVo = new OrderVo();
			if (orderDao.getOrderSumChartForWeek(vo) == null) {
				tmpVo.setPayDate(StringUtil.getDate(-i, "yyyyMMdd"));
				getList.add(tmpVo);
			} else {
				getList.add(orderDao.getOrderSumChartForWeek(vo));
			}
		}
		return getList;
	}

	/** 금일 매출 추이 */
	public List<OrderVo> getOrderSumChartForToDay(HttpSession session) {
		List<OrderVo> getList = new ArrayList<>();
		OrderVo vo = new OrderVo();
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		for (int i = 0; i < 24; i++) {
			OrderVo tmpVo = new OrderVo();
			/** 0~9시 일때 앞에 0을 붙인다. */
			if (String.valueOf(i).length() == 1) {
				vo.setTodayPeriodCount(StringUtil.getDate(0, "yyyyMMdd") + "0"
						+ i);
				if (orderDao.getOrderSumChartForToDay(vo) == null) {
					tmpVo.setPayDate(StringUtil.getDate(0, "yyyyMMdd") + "0"
							+ i);
					getList.add(tmpVo);
				} else {
					getList.add(orderDao.getOrderSumChartForToDay(vo));
				}
				/** 10~23시 일때 앞에 0을 붙이지 않는다. */
			} else {
				vo.setTodayPeriodCount(StringUtil.getDate(0, "yyyyMMdd") + i);
				if (orderDao.getOrderSumChartForToDay(vo) == null) {
					tmpVo.setPayDate(StringUtil.getDate(0, "yyyyMMdd") + i);
					getList.add(tmpVo);
				} else {
					getList.add(orderDao.getOrderSumChartForToDay(vo));
				}
			}
		}
		return getList;
	}

	public List<OrderVo> getOrderDeliveryFinish() {
		return orderDao.getOrderDeliveryFinish();
	}

	public List<OrderVo> getOrderConfirm() {
		return orderDao.getOrderConfirm();
	}

	public MemberDeliveryVo getLatelyOrderVo(Integer memberSeq)	throws Exception {
		MemberDeliveryVo vo = orderDao.getLatelyOrderVo(memberSeq);
		vo.setTel(CrypteUtil.decrypt(vo.getTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		vo.setCell(CrypteUtil.decrypt(vo.getCell(), Const.ARIA_KEY,	Const.ARIA_KEY.length * 8, null));
		vo.setAddr2(CrypteUtil.decrypt(vo.getAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		return vo;
	}

	/** 주문 전체 취소 체크 */
	public boolean checkCancelAll(OrderVo vo) {
		return orderDao.checkCancelAll(vo).intValue() > 0 ? true : false;
	}

	/** 취소할 주문의 PG 정보 가져오기 */
	public OrderPayVo getPayVoForCancel(Integer orderSeq) {
		return orderPayDao.getPayVoForCancel(orderSeq);
	}

	/** PG취소금액 합계(과세) */
	public int getSumCancelPayAmountTax(Integer orderSeq) {
		return orderPayDao.getSumCancelPayAmountTax(orderSeq);
	}

	/** 주문 취소 처리 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean updateCancelAll(OrderVo vo, OrderPayVo payCancelVo, PointVo pointVoCancel) throws Exception {
		// 주문 상태 변경 로그 생성
		List<OrderVo> list = getListForDetail(vo);
		OrderLogVo[] arrLogVo = null;
		if (list != null) {
			vo.setStatusCode("99");
			arrLogVo = new OrderLogVo[list.size()];
			for (int i = 0; i < list.size(); i++) {
				vo.setSeq(list.get(i).getSeq());
				arrLogVo[i] = createLogVo(vo);
			}
		}

		// 주문 전체 취소 상태 업데이트
		int result = orderDao.updateCancelAll(vo);
		// PG 결제 취소 내역 등록;
		if (result > 0 && payCancelVo != null) {
			orderPayDao.regOrderPayCancel(payCancelVo);
		}

		// 포인트 취소 내역 업데이트
		if (result > 0 && pointVoCancel != null) {
			regPointHistoryForCancel(pointVoCancel);
		}

		// 부분취소시 선결제 묶음배송비 정상 주문 건으로 이동
		if ("PART".equals(vo.getCancelType())) {
			// 묶음배송비 이동할 상품주문번호 가져오기
			Integer minSeqBySeller = orderDao.findMinSeqBySeller(vo);
			if (minSeqBySeller != null) {
				orderDao.copyPackageDeliCost(minSeqBySeller);
				orderDao.initPackageDeliCost(vo.getSeq());
			}
		}

		// 주문 상태 변경로그 등록
		if (arrLogVo != null && arrLogVo.length > 0) {
			for (OrderLogVo logVo : arrLogVo) {
				orderDao.regLogData(logVo);
			}
		}

		return true;
	}

	/** 주문 상세 정보 가져오기 */
	public OrderVo getVoDetail(Integer seq) {
		return orderDao.getVoDetail(seq);
	}

	/** 부분 취소 금액 계산 */
	public OrderVo calcPartCancelAmt(Integer seq) {
		return orderDao.calcPartCancelAmt(seq);
	}

	/** 결제정보 리스트(주문번호별) */
	public List<OrderPayVo> getPayInfoListForDetail(Integer orderSeq) {
		return orderPayDao.getPayInfoListForDetail(orderSeq);
	}

	/** PG 결제 취소 내역 */
	public List<OrderPayVo> getListPayCancel(Integer orderSeq) {
		return orderPayDao.getListPayCancel(orderSeq);
	}

	/** 주문 엑셀 다운로드 */
	public Workbook writeExcelOrderList(OrderVo vo, String type) throws Exception {
		/* 주문리스트 */
		Workbook wb;
		int arraySize = "S".equals(vo.getLoginType()) || "M".equals(vo.getLoginType()) ? 23 : 25;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arraySize];
		int idx = 0;
		strTitle[idx++] = "주문일자";
		strTitle[idx++] = "주문상태";
		strTitle[idx++] = "상품명";
		strTitle[idx++] = "옵션";
		strTitle[idx++] = "모델명";
		strTitle[idx++] = "결제수단";
		strTitle[idx++] = "수량";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "판매가합계";
		strTitle[idx++] = "배송비";
		strTitle[idx++] = "배송구분";

		if ("A".equals(vo.getLoginType())) {
			strTitle[idx++] = "포인트";
			strTitle[idx++] = "총주문금액";
		}

		strTitle[idx++] = "묶음배송여부";
		strTitle[idx++] = "배송업체";
		strTitle[idx++] = "송장번호";
		strTitle[idx++] = "과세여부";
		strTitle[idx++] = "입점업체명";
		strTitle[idx++] = "주문자명";
		strTitle[idx++] = "수령자";
		strTitle[idx++] = "수취인전화번호";
		strTitle[idx++] = "수취인휴대폰번호";
		strTitle[idx++] = "수령자이메일";
		strTitle[idx++] = "배송지주소";
		strTitle[idx++] = "배송지메세지";

		List<OrderVo> list = orderDao.getListExcelDownload(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrderVo ovo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(arraySize);
				cell.add(ovo.getRegDate().indexOf(" ") > 0 ? ovo.getRegDate().substring(0, ovo.getRegDate().indexOf(" ")) : "");
				cell.add(ovo.getStatusText());
				cell.add(StringUtil.restoreClearXSS(ovo.getItemName()));
				cell.add(ovo.getOptionValue());
				cell.add(StringUtil.restoreClearXSS(ovo.getModelName()));
				cell.add(ovo.getPayMethodName());
				cell.add(StringUtil.formatAmount(ovo.getOrderCnt()));
				cell.add(StringUtil.formatAmount(ovo.getSellPrice()));
				cell.add(StringUtil.formatAmount((ovo.getSellPrice()) * ovo.getOrderCnt()));
				cell.add(StringUtil.formatAmount(ovo.getDeliCost()));
				
				if(ovo.getDeliCost() == 0) {
					cell.add("무료");
				} else {
					cell.add("선결제");
				}

				// 현재 로그인한 타입이 어드민일때만 보여준다
				if ("A".equals(vo.getLoginType())) {
					cell.add(StringUtil.formatAmount(ovo.getPoint()));
					cell.add(StringUtil.formatAmount(ovo.getTotalPrice()));
				}

				cell.add(ovo.getDeliPackageFlag());
				cell.add(ovo.getDeliCompanyName());
				cell.add(ovo.getDeliNo());
				cell.add(ovo.getTaxCode());
				cell.add(StringUtil.restoreClearXSS(ovo.getSellerName()));
				cell.add(ovo.getMemberName());
				cell.add(ovo.getReceiverName());
				
				//개인정보 복호화
				decryptData(ovo);

				cell.add(ovo.getReceiverTel());
				cell.add(ovo.getReceiverCell());
				cell.add(ovo.getReceiverEmail());
				cell.add(ovo.getReceiverAddr1() + " " + ovo.getReceiverAddr2());
				cell.add(ovo.getRequest());

				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, type, 0);

		return wb;
	}

	/** 후청구 결제 주문 다운로드 */
	public Workbook writeExcelOrderListNP(OrderVo vo, String type, HttpSession session) throws Exception {
		/* 주문리스트 */
		vo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		vo.setLoginType((String)session.getAttribute("loginType"));
		Workbook wb;
		int arraySize = "S".equals(vo.getLoginType()) || "M".equals(vo.getLoginType()) ? 47 : 52;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arraySize];
		int idx = 0;
		strTitle[idx++] = "주문번호";
		strTitle[idx++] = "결제수단";
		strTitle[idx++] = "기관명";
		strTitle[idx++] = "주문자명";
		strTitle[idx++] = "주문자 이메일";
		strTitle[idx++] = "수령자";
		strTitle[idx++] = "수취인 연락처";
		strTitle[idx++] = "배송지";
		strTitle[idx++] = "상품명";
		strTitle[idx++] = "부가세";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "수량";
		strTitle[idx++] = "배송비";
		strTitle[idx++] = "주문상태";
		strTitle[idx++] = "합계 금액";
		strTitle[idx++] = "결제(예정) 금액";
		strTitle[idx++] = "처리 상태";
		strTitle[idx++] = "입금완료 일자";
		strTitle[idx++] = "주문 일자";
			
		List<OrderVo> list = orderDao.getListNP(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrderVo ovo = list.get(i);
				//개인정보 복호화
				decryptData(ovo);
				
				ArrayList<Object> cell = new ArrayList<>(arraySize);
								
				cell.add(ovo.getOrderSeq());
				cell.add(ovo.getPayMethodName());
				cell.add(ovo.getGroupName());
				cell.add(ovo.getMemberName());
				cell.add(ovo.getMemberEmail());
				cell.add(ovo.getReceiverName());
				cell.add(StringUtil.isBlank(ovo.getReceiverTel()) ? ovo.getReceiverCell() : ovo.getReceiverTel());
				cell.add(ovo.getReceiverPostcode()+" "+ovo.getReceiverAddr1()+" "+ovo.getReceiverAddr2());
				
				
				if(!"".equals(ovo.getOptionValue())) {
					ovo.setItemName(ovo.getItemName() +"(" + ovo.getOptionValue() + ")");
				}
				cell.add(ovo.getItemName());
				
				cell.add(ovo.getTaxName());
				cell.add(StringUtil.formatAmount(ovo.getSellPrice()));
				cell.add(StringUtil.formatAmount(ovo.getOrderCnt()));
				cell.add(StringUtil.formatAmount(ovo.getDeliCost()));
				cell.add(ovo.getStatusText());
				cell.add(StringUtil.formatAmount(ovo.getTotalPrice()));
				cell.add(StringUtil.formatAmount(ovo.getPayPrice()));
				
				if("Y".equals(ovo.getNpPayFlag())) {
					cell.add("입금완료");
				} else {
					if(ovo.getPayPrice() > 0) {
						cell.add("입금대기");
					} else if(ovo.getPayPrice() == 0) {
						cell.add("입금대기중 취소");
					}
				}
								
				cell.add(ovo.getNpPayDate());
				cell.add(ovo.getRegDate());
				
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcelOrderListNp(strTitle, row, type, 0, list);
		return wb;
	}

	public String updateDeliveryProc(OrderVo vo) {
		String resultMsg;

		Integer[] seqs = { vo.getSeq() };

		boolean result = false;
		try {
			DeliCompanyVo dvo = systemDao.getDeliCompanyVo(vo.getDeliSeq());
			String[] arrMsg = dvo.getCompleteMsg().trim().split("\\|");
			
			if (arrMsg.length > 1) {
				for (int i = 0; i < arrMsg.length; i++) {
					result = FileDownloadUtil.chkDelivComplete(vo.getDeliSeq(), vo.getDeliNo(),	vo.getDeliTrackUrl(), arrMsg[i]);
					// 만약 result가 true가 나왔다면 for문을 탈출한다.
					if (result) {
						break;
					}
				}
			} else {
				result = FileDownloadUtil.chkDelivComplete(vo.getDeliSeq(), vo.getDeliNo(), vo.getDeliTrackUrl(), dvo.getCompleteMsg());
			}
			
		} catch (Exception e) {
			resultMsg = e.getMessage();
			e.printStackTrace();
		}

		// 일단 통신이 성공했다면
		if (result) {
			if (updateStatus(seqs, "50", vo.getLoginSeq()) > 0) { // 주문완료
				resultMsg = "배송완료";
			} else {
				resultMsg = "DB오류";
			}
		} else {
			resultMsg = "배송중";
		}
		return resultMsg;
	}

	public List<OrderVo> createDetails(Integer orderSeq, List<ItemVo> list, String payMethod) {
		//결제수단별 수수료율 가져오기
		Map<String,Float> data = orderPayDao.getFeeRate(payMethod);
		
		List<OrderVo> details = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			OrderVo vo = new OrderVo();
			vo.setOrderSeq(orderSeq);
			vo.setItemSeq(list.get(i).getItemSeq());
			vo.setOptionValueSeq(list.get(i).getOptionValueSeq());
			vo.setItemName(list.get(i).getName());
			vo.setOptionValue(list.get(i).getOptionName() + " "	+ list.get(i).getValueName());
			
			/** 주문 상태 설정 */
			vo.setStatusCode("00"); //입금대기
			if(payMethod.startsWith("CARD") || payMethod.startsWith("NP") || payMethod.startsWith("OFFLINE") || "POINT".equals(payMethod)) {
				//신용카드, 후청구/방문결제, 포인트 전액 결제일 경우 결제 완료로 처리
				vo.setStatusCode("10");
			}
			
			vo.setSellPrice(list.get(i).getSellPrice());
			vo.setOptionPrice(list.get(i).getOptionPrice());
			vo.setOrderCnt(list.get(i).getCount());
			
			/** 공급가 계산 */	
			int sellPrice = vo.getSellPrice();
			vo.setSupplyPrice(sellPrice);
			if(data != null) {
				//서울시 수수료
				Float feeRate = data.get("fee_rate1"); 
				if("99".equals(list.get(i).getJachiguCode())) {
					//지방 수수료
					feeRate = data.get("fee_rate2");
				}
				//공급가를 해당 수수료율에 맞게 책정한다. 
				vo.setSupplyPrice((int)(sellPrice - (sellPrice*feeRate.floatValue()/100)));
			}
			
			/** 견적 주문일 경우  */
			if(list.get(i).getEstimateCount() > 0) {
				vo.setEstimateCount(list.get(i).getEstimateCount());
				vo.setItemName(vo.getItemName() + "( x " + list.get(i).getEstimateCount() + "개 )");
				vo.setEstimateSeq(list.get(i).getSeq());
			}
						
			vo.setDeliCost(list.get(i).getDeliCost());
			vo.setDeliPrepaidFlag(list.get(i).getDeliPrepaidFlag());
			vo.setPackageDeliCost(list.get(i).getPackageDeliCost());
			vo.setTaxCode(list.get(i).getTaxCode());
			vo.setSellerSeq(list.get(i).getSellerSeq());
			vo.setSellerMasterSeq(list.get(i).getMasterSeq());
			vo.setSellerName(list.get(i).getSellerName());
			vo.setSellerMasterName(list.get(i).getMasterName());

			// OrderVo 배열 변수에 저장
			details.add(i, vo);
		}

		return details;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean regOrder(OrderVo ovo, List<OrderVo> details, OrderPayVo payVo) throws Exception {
		boolean estimateFlag = false;
		// 주문 메인 등록
		orderDao.regData(ovo);
		// 주문 DETAIL을 등록
		for (int i = 0; i < details.size(); i++) {
			if(details.get(i).getEstimateCount() > 0) {
				estimateFlag = true;
			}
			orderDao.regDetailData(details.get(i));
		}
		// PG 결제 정보 등록
		if (payVo != null) {
			orderPayDao.regOrderPay(payVo);
		}
		// 포인트 거래내역 등록
		if (ovo.getPoint() > 0) {
			regPointHistory(ovo);
		}
		
		// 견적 주문완료 업데이트
		if(estimateFlag) {
			EstimateVo vo = new EstimateVo();
			vo.setSeq(details.get(0).getEstimateSeq());
			vo.setOrderDetailSeq(details.get(0).getSeq());
			vo.setLoginSeq(ovo.getMemberSeq());
			estimateDao.updateStatus(vo);
		}
		
		// 세금계산서 요청서 등록
		if("Y".equals(ovo.getTaxRequest())) {
			ovo.setRequestEmail(CrypteUtil.encrypt(ovo.getRequestEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			ovo.setRequestCell(CrypteUtil.encrypt(ovo.getRequestCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			orderTaxRequestDao.mergeData(ovo);
		}

		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean modOrder(OrderPayVo vo) {
		OrderVo ovo = new OrderVo();
		ovo.setOrderSeq(vo.getOrderSeq());
		ovo.setNpPayFlag("Y");
		orderDao.updateNpPayFlag(ovo);
		orderPayDao.regOrderPay(vo);
		return true;
	}
	
	/** 포인트 사용 내역 등록 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	private void regPointHistory(OrderVo vo) throws Exception {
		List<PointVo> list = pointDao.getPointList(vo.getMemberSeq());
		int usePoint = vo.getPoint();
		for (int i = 0; i < list.size(); i++) {
			if (usePoint > 0) {
				PointVo pvo = list.get(i);
				if (usePoint >= pvo.getUseablePoint()) {
					pvo.setPoint(pvo.getUseablePoint());
					pvo.setStatusCode("E"); // 소진되었음 (전부 다 썼다)

					usePoint -= pvo.getUseablePoint();

					pvo.setUseablePoint(0);
					pvo.setValidFlag("N");
				} else {
					pvo.setPoint(usePoint);
					pvo.setStatusCode("U"); // 사용했음
					pvo.setNote("포인트t사용(주문번호 :" + vo.getOrderSeq() + ")");
					pvo.setUseablePoint(pvo.getUseablePoint() - usePoint);
					usePoint = 0;
				}

				// 포인트 로그 등록
				if (pointDao.insertLogData(pvo) <= 0) {
					throw new Exception();
				}
				// 포인트 잔액 업데이트
				if (pointDao.updateData(pvo) <= 0) {
					throw new Exception();
				}
			}
		}

		// 포인트 내역 등록
		PointVo pvo = new PointVo();
		pvo.setPoint(vo.getPoint());
		pvo.setMemberSeq(vo.getMemberSeq());
		pvo.setStatusCode("U");
		pvo.setOrderSeq(vo.getOrderSeq());
		if (pointDao.insertHistoryData(pvo) <= 0) {
			throw new Exception();
		}
	}

	/** 포인트 취소적립 내역 등록 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	private boolean regPointHistoryForCancel(PointVo vo) throws Exception {
		// 포인트 신규 생성
		if (pointDao.insertData(vo) <= 0) {
			throw new Exception();
		}
		// 포인트 로그 등록
		vo.setPointSeq(vo.getSeq());
		if (pointDao.insertLogData(vo) <= 0) {
			throw new Exception();
		}
		// 포인트 내역 등록
		if (pointDao.insertHistoryData(vo) <= 0) {
			throw new Exception();
		}

		return true;
	}

	public Long getSumPrice(OrderVo pvo) {
		return orderDao.getSumPrice(pvo);
	}

	public boolean updateAddr(OrderVo vo) throws UnsupportedEncodingException, InvalidKeyException {
		vo.setReceiverAddr2(CrypteUtil.encrypt(vo.getReceiverAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		return orderDao.updateAddr(vo) > 0;
	}
	
	@Override
	public boolean updateMember(OrderVo vo) throws UnsupportedEncodingException, InvalidKeyException {
		vo.setMemberEmail(CrypteUtil.encrypt(vo.getMemberEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		return orderDao.updateMember(vo) > 0;
	}

	public List<?> getSeqList(Integer orderSeq) {
		return orderDao.getSeqList(orderSeq);
	}

	public boolean getItemOrderCnt(Integer seq) {
		return orderDao.getItemOrderCnt(seq).intValue() > 0;
	}

	public List<OrderVo> getDeliList(OrderVo pvo) {
		return orderDao.getDeliList(pvo);
	}

	public OrderVo getOrderInfo(OrderVo ovo) throws Exception {
		OrderVo vo = orderDao.getOrderInfo(ovo);
		if(vo != null) {
			//개인정보 복호화
			decryptData(vo);
		}
		return vo;
	}
	
	@Override
	public int createOrderSeq(OrderVo ovo) {
		return orderDao.createOrderSeq(ovo);
	}
	
	@Override
	public int getListForReviewDetailCount(OrderVo vo) {
		return orderDao.getListForReviewDetailCount(vo);
	}

	@Override
	public List<OrderVo> getListForReviewDetail(OrderVo vo) {
		return orderDao.getListForReviewDetail(vo);
	}

	@Override
	public int updateNpPayFlag(OrderVo vo) {
		return orderDao.updateNpPayFlag(vo);
	}

	@Override
	public List<OrderVo> getWeekOrderStatus(MemberVo vo) {
		return orderDao.getWeekOrderStatus(vo);
	}

	@Override
	public List<OrderVo> getListForEncrypt() {
		return orderDao.getListForEncrypt();
	}
	
	@Override
	public List<Integer> getListExpire() {
		return orderDao.getListExpire();
	}

	@Override
	public boolean updatePayInfo(OrderPayVo vo) {
		int result = orderPayDao.modVo(vo);
		if(result == 0) {
			return false;
		}
		
		OrderVo ovo = new OrderVo();
		ovo.setOrderSeq(vo.getOrderSeq());
		
		if(vo.getResultCode().endsWith("0000")) {
			ovo.setStatusCode("10"); //결제완료
			if(updateStatusForConfirm(ovo)) {
				return true;
			}
			
		} else {
			ovo.setStatusCode("99"); //취소완료
			ovo.setCancelType("ALL");//전체취소
			ovo.setReason("결제 처리 실패로 인한 주문 자동 취소"); //사유
			if(updateStatusForCancelByOrderSeq(ovo)) {
				return true;
			}
		}
		
		return false;
	}

	@Override
	public List<OrderVo> getListNP(OrderVo vo) throws Exception {
		List<OrderVo> list = orderDao.getListNP(vo);
		for (OrderVo dbVo : list) {
			//개인정보 복호화
			decryptData(dbVo);
		}
		return list;
	}

	@Override
	public int getListNPCount(OrderVo vo) {
		return orderDao.getListNPCount(vo);
	}

	@Override
	public int checkOrder(Integer orderSeq) {
		return orderDao.checkOrder(orderSeq);
	}

	@Override
	public OrderVo getVoNP(Integer orderSeq) throws Exception {
		OrderVo vo = orderDao.getVoNP(orderSeq);
		if(vo != null) {
			//개인정보 복호화
			decryptData(vo);
		}
		
		return vo;
	}

	@Override
	public String getOrderItemName(Integer orderSeq) {
		return orderDao.getOrderItemName(orderSeq);
	}

	@Override
	public int updateForEncrypt(OrderVo vo) throws Exception {
		//주문 개인정보 암호화
		if(!"".equals(vo.getReceiverTel())) {
			vo.setReceiverTel(CrypteUtil.encrypt(vo.getReceiverTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));		
		}
		if(!"".equals(vo.getReceiverCell())) {
			vo.setReceiverCell(CrypteUtil.encrypt(vo.getReceiverCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getReceiverAddr2())) {
			vo.setReceiverAddr2(CrypteUtil.encrypt(vo.getReceiverAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getMemberCell())) {
			vo.setMemberCell(CrypteUtil.encrypt(vo.getMemberCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getMemberEmail())) {
			vo.setMemberEmail(CrypteUtil.encrypt(vo.getMemberEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		
		return orderDao.updateForEncrypt(vo);
	}
	
	/** 주문 개인정보 복호화 */
	private void decryptData(OrderVo vo) throws Exception {
		if(!"".equals(vo.getReceiverTel())) {
			vo.setReceiverTel(CrypteUtil.decrypt(vo.getReceiverTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getReceiverCell())) {
			vo.setReceiverCell(CrypteUtil.decrypt(vo.getReceiverCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getReceiverAddr2())) {
			vo.setReceiverAddr2(CrypteUtil.decrypt(vo.getReceiverAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getReceiverEmail())) {
			vo.setReceiverEmail(CrypteUtil.decrypt(vo.getReceiverEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getMemberTel())) {
			vo.setMemberTel(CrypteUtil.decrypt(vo.getMemberTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getMemberCell())) {
			vo.setMemberCell(CrypteUtil.decrypt(vo.getMemberCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getMemberEmail())) {
			vo.setMemberEmail(CrypteUtil.decrypt(vo.getMemberEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getAddr2())) {
			vo.setAddr2(CrypteUtil.decrypt(vo.getAddr2(), Const.ARIA_KEY,	Const.ARIA_KEY.length * 8, null));
		}
	}

	/** 세금계산서 요청 완료처리 */
	@Override
	public int completeTaxRequest(Integer orderSeq) {
		return orderTaxRequestDao.completeTaxRequest(orderSeq);
	}

	@Override
	public boolean deleteCsData(Integer seq) {
		return orderDao.deleteCsData(seq) > 0;
	}
}
