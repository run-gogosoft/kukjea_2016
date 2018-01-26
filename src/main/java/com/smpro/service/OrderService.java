package com.smpro.service;

import com.smpro.vo.*;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.*;

@Service
public interface OrderService {
	public List<OrderVo> getList(OrderVo pvo) throws Exception;

	public List<OrderVo> getRepeatOrderList(OrderVo pvo) throws Exception;

	public int getListCount(OrderVo vo);

	public List<OrderVo> getCsOrderList(OrderVo pvo);

	public Integer getCsOrderListCount(OrderVo vo);

	public List<OrderVo> getCsLogList(OrderVo vo);

	public int getCsLogListCount(OrderVo vo);

	public List<OrderVo> getListForDetail(OrderVo vo);

	public List<OrderCsVo> getCsList(Integer seq);

	public List<OrderCsVo> getLogList(Integer seq);

	public OrderVo getData(OrderVo ovo) throws Exception;

	public boolean regData(OrderVo vo) throws Exception;

	public boolean regData(OrderCsVo vo);

	public boolean regLogData(OrderLogVo vo);

	public boolean modData(OrderVo vo);

	public boolean regDetailData(OrderVo vo);

	/** 주문 상태 변경 */
	public boolean updateStatus(OrderVo vo);
	
	/** 주문 상태 변경(입금확인) */
	public boolean updateStatusForConfirm(OrderVo vo);

	/** 주문 상태 일괄 변경 */
	public int updateStatus(Integer[] seq, String statusCode, Integer loginSeq);

	/** 주문 상태 일괄 변경(배송중 처리) */
	public int updateStatusForDelivery(Integer[] seq, String statusCode, Integer loginSeq, Integer[] deliSeq, String[] deliNo, Integer[] boxCnt, Integer[] totalDeliCost);

	/** 주문 상태 일괄 변경 - 송장 일괄 업로드 */
	public int updateStatusForDelivery(Integer[] seq, String statusCode, Integer loginSeq, Integer[] deliSeq, String[] deliNo, Integer[] boxCnt, Integer[] totalDeliCost,Integer sellerSeq);

	/** 송장정보 일괄 업로드 대상 주문 엑셀파일 포맷으로 생성 */
	public HSSFWorkbook createDeliveryXlsFile(Integer sellerSeq) throws Exception;

	/** 엑셀 데이터 유효성 체크 */
	public String chkDeliveryXlsData(String[] row);

	/** 판매 일보 */
	public List<OrderVo> getSellDaily(OrderVo vo);

	/** 주문상태별 건수 */
	public HashMap<String, String> getCntByStatus(OrderVo pvo);

	/** 구매확정된 총 구매 금액 */
	public String getTotalOrderFinishPrice(Integer loginSeq);

	/** 구매금액 랭킹 순위 */
	public List<OrderVo> getRankingOrderFinishPrice(OrderVo vo);

	/** 금일 매출현황 */
	public List<OrderVo> getDayOrderStatus(MemberVo memberVo);

	/** 금월 매출현황 */
	public List<OrderVo> getMonthOrderStatus(MemberVo memberVo);

	/** 금년 매출현황 */
	public List<OrderVo> getYearOrderStatus(MemberVo memberVo);

	/** 일주일간 쇼핑몰 현황 */
	public OrderVo getOrderSumForWeek(MemberVo memberVo);

	/** 일주일 매출 추이 */
	public List<OrderVo> getOrderSumChartForWeek(HttpSession session);

	/** 금일 매출 추이 */
	public List<OrderVo> getOrderSumChartForToDay(HttpSession session);

	public List<OrderVo> getOrderDeliveryFinish();

	public List<OrderVo> getOrderConfirm();

	public MemberDeliveryVo getLatelyOrderVo(Integer memberSeq)	throws Exception;

	/** 주문 전체 취소 체크 */
	public boolean checkCancelAll(OrderVo vo);

	/** 취소할 주문의 PG 정보 가져오기 */
	public OrderPayVo getPayVoForCancel(Integer orderSeq);

	/** PG취소금액 합계(과세) */
	public int getSumCancelPayAmountTax(Integer orderSeq);

	/** 주문 취소 처리 */
	public boolean updateCancelAll(OrderVo vo, OrderPayVo payCancelVo, PointVo pointVoCancel) throws Exception;

	/** 주문 상세 정보 가져오기 */
	public OrderVo getVoDetail(Integer seq);

	/** 부분 취소 금액 계산 */
	public OrderVo calcPartCancelAmt(Integer seq);

	/** 결제정보 리스트(주문번호별) */
	public List<OrderPayVo> getPayInfoListForDetail(Integer orderSeq);

	/** PG 결제 취소 내역 */
	public List<OrderPayVo> getListPayCancel(Integer orderSeq);

	/** 주문 엑셀 다운로드 */
	public Workbook writeExcelOrderList(OrderVo vo, String type) throws Exception;
	
	/** 후청구 주문 엑셀 다운로드 */
	public Workbook writeExcelOrderListNP(OrderVo vo, String type, HttpSession session) throws Exception;
	
	public String updateDeliveryProc(OrderVo vo);

	public List<OrderVo> createDetails(Integer orderSeq, List<ItemVo> list, String payMethod);

	public boolean regOrder(OrderVo ovo, List<OrderVo> details, OrderPayVo payVo) throws Exception;
	
	/** 후청구 결제 주문정보 수정 */
	public boolean modOrder(OrderPayVo vo);

	public Long getSumPrice(OrderVo pvo);

	public boolean updateAddr(OrderVo vo) throws UnsupportedEncodingException,	InvalidKeyException;
	
	public boolean updateMember(OrderVo vo) throws UnsupportedEncodingException,	InvalidKeyException;

	public List<?> getSeqList(Integer orderSeq);

	public boolean getItemOrderCnt(Integer seq);

	public List<OrderVo> getDeliList(OrderVo pvo);

	public OrderVo getOrderInfo(OrderVo ovo) throws Exception;
	
	public int createOrderSeq(OrderVo ovo);
	
	public int getListForReviewDetailCount(OrderVo vo);
	
	public List<OrderVo> getListForReviewDetail(OrderVo vo);
	
	/** 후청구 결제 처리상태 업데이트 */
	public int updateNpPayFlag(OrderVo vo);

	public List<OrderVo> getWeekOrderStatus(MemberVo vo);
	
	/** 무통장 입금 기한 만료된 주문 건 조회 */
	public List<Integer> getListExpire();
	
	/** PG 입금통보 수신 업데이트 */
	public boolean updatePayInfo(OrderPayVo vo);
	
	/** 후청구 결제 주문 건 리스트 */
	public List<OrderVo> getListNP(OrderVo vo) throws Exception;
	public int getListNPCount(OrderVo vo);
	
	/** 후청구 PG결제 가능 여부 체크 */
	public int checkOrder(Integer orderSeq);
	
	/** 후청구 PG결제 주문 정보 가져오기 */
	public OrderVo getVoNP(Integer orderSeq) throws Exception;
	
	/** 후청구 PG결제시 주문 상품명 가져오기 */
	public String getOrderItemName(Integer orderSeq);
	
	/** 함께누리몰 기주문 개인정보 암호화 대상 리스트 */
	public List<OrderVo> getListForEncrypt();
	
	/** 함께누리몰 기주문 개인정보 암호화 업데이트 */
	public int updateForEncrypt(OrderVo vo) throws Exception;
	
	/** 세금계산서 요청내역 */
	public OrderVo getTaxRequestData(Integer orderSeq) throws Exception;
	
	/** 세금계산서 요청 완료처리 */
	public int completeTaxRequest(Integer orderSeq);
	
	/** CS 삭제 */
	public boolean deleteCsData(Integer seq);
}
