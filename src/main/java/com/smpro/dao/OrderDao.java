package com.smpro.dao;

import com.smpro.vo.*;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface OrderDao {

	/** 주문 리스트 */
	public List<OrderVo> getList(OrderVo vo);

	/** 반복 주문 리스트 **/
	public List<OrderVo> getRepeatOrderList(OrderVo vo);

	/** 주문 리스트 페이징용 카운트 */
	public int getListCount(OrderVo vo);

	/** 취소,교환,반품 리스트 */
	public List<OrderVo> getCsOrderList(OrderVo vo);

	/** 취소,교환,반품 리스트 페이징용 카운트 */
	public Integer getCsOrderListCount(OrderVo vo);

	/** CS 처리내역 리스트 페이징용 카운트 */
	public int getCsLogListCount(OrderVo vo);

	/** 주문 리스트(주문번호별 OR 회원별) */
	public List<OrderVo> getListForDetail(OrderVo pvo);

	/** 주문 송장일괄업로드 대상 리스트 */
	public List<OrderVo> getDeliveryTargetList(Integer sellerSeq);

	/** 주문 상세 CS 리스트 */
	public List<OrderCsVo> getCsList(Integer seq);

	/** CS 처리내역 리스트 */
	public List<OrderVo> getCsLogList(OrderVo vo);

	/** 주문 상세 변경 로그 리스트 */
	public List<OrderCsVo> getLogList(Integer seq);

	/** 주문 메인 데이타 */
	public OrderVo getData(OrderVo pvo);

	/** 주문 정보 변경이력 체크용(상품주문번호별) */
	public OrderVo getCheckData(Integer seq);
	
	/** 주문 정보 변경이력 체크용(주문번호별) */
	public List<OrderVo> getCheckList(Integer orderSeq);

	/** 주문 등록 */
	public int regData(OrderVo vo);

	/** 주문 상세 등록 */
	public int regDetailData(OrderVo vo);

	/** 주문 CS 등록 */
	public int regCsData(OrderCsVo vo);
	
	/** 주문 CS 삭제 */
	public int deleteCsData(Integer seq);

	/** 주문 변경이력 등록 */
	public int regLogData(OrderLogVo vo);

	/** 주문 수정 */
	public int modData(OrderVo vo);

	/** 주문 상태 업데이트 */
	public int updateStatus(OrderVo vo);
	
	/** 주문 상태 업데이트(입금확인) */
	public int updateStatusForConfirm(Integer orderSeq);

	/** 주문 상태 업데이트(상품발송) */
	public int updateStatusForDelivery(OrderVo vo);

	/** 판매 일보 */
	public List<OrderVo> getSellDaily(OrderVo vo);

	/** 주문 상태별 건수 */
	public List<HashMap<String, String>> getCntByStatus(OrderVo pvo);

	/** 구매확정된 총 구매 금액 */
	public String getTotalOrderFinishPrice(Integer loginSeq);

	/** 결제완료 이후 주문 건 체크 */
	public Integer getOrderCntAfterStatus10(OrderVo vo);

	/** 구매금액 랭킹 순위 */
	public List<OrderVo> getRankingOrderFinishPrice(OrderVo vo);

	/** 금일 매출현황 */
	public List<OrderVo> getDayOrderStatus(MemberVo memberVo);

	/** 금월 매출현황 */
	public List<OrderVo> getMonthOrderStatus(MemberVo memberVo);

	/** 금년 매출현황 */
	public List<OrderVo> getYearOrderStatus(MemberVo memberVo);

	/** 판매관리 */
	public OrderVo getOrderSumForWeek(MemberVo memberVo);

	/** 일주일 매출 추이 */
	public OrderVo getOrderSumChartForWeek(OrderVo vo);

	/** 금일 매출 추이 */
	public OrderVo getOrderSumChartForToDay(OrderVo vo);

	/** 배송완료 주문 */
	public List<OrderVo> getOrderDeliveryFinish();

	/** 구매확정 주문 */
	public List<OrderVo> getOrderConfirm();

	/** 가장 최신 주문번호 */
	public MemberDeliveryVo getLatelyOrderVo(Integer memberSeq);

	/** 주문 전체 취소 체크 */
	public Integer checkCancelAll(OrderVo vo);

	/** 주문 전체 취소 */
	public int updateCancelAll(OrderVo vo);

	/** 주문 상세 정보 가져 오기 */
	public OrderVo getVoDetail(Integer seq);

	/** 부분취소 금액 계산 */
	public OrderVo calcPartCancelAmt(Integer seq);

	/** 엑셀 다운로드 리스트 가져오기 */
	public List<OrderVo> getListExcelDownload(OrderVo vo);

	/** 검색조건에 맞는 주문총액 가져오기 */
	public Long getSumPrice(OrderVo pvo);

	/** 부분취소된 주문의 묶음 배송비 이동 관련 작업 */
	//묶음배송비 이동할 상품주문번호 가져오기
	public Integer findMinSeqBySeller(OrderVo vo);
	//해당 상품주문번호로 묶음배송비 복사
	public int copyPackageDeliCost(Integer minSeqBySeller);
	//부분취소된 상품주문번호 묶음 배송비 초기화
	public int initPackageDeliCost(Integer seq);

	public int updateAddr(OrderVo vo);
	
	public int updateMember(OrderVo vo);

	public List<?> getSeqList(Integer orderSeq);

	public Integer getItemOrderCnt(Integer seq);

	public List<OrderVo> getDeliList(OrderVo pvo);

	public OrderVo getOrderInfo(OrderVo ovo);
	
	/** 주문 번호 생성 */
	public int createOrderSeq(OrderVo ovo);
		
	/** 상품평 미등록 주문 */
	public int getListForReviewDetailCount(OrderVo vo);
	public List<OrderVo> getListForReviewDetail(OrderVo vo);
	/** 방문결제 처리상태 업데이트 */ 
	public int updateNpPayFlag(OrderVo vo);

	public List<OrderVo> getWeekOrderStatus(MemberVo vo);
	
	/** 무통장 입금 기한 만료된 주문 건 조회 */
	public List<Integer> getListExpire();
	
	/** 후청구 결제 주문 건 리스트 */
	public List<OrderVo> getListNP(OrderVo vo);
	public int getListNPCount(OrderVo vo);
	
	/** 후청구 PG 결제 가능한 주문인지 체크 */
	public int checkOrder(Integer orderSeq);
	
	/** 후청구 PG 결제 주문정보 가져오기 */
	public OrderVo getVoNP(Integer orderSeq);
	
	/** 후청구 PG결제시 주문 상품명 가져오기 */
	public String getOrderItemName(Integer orderSeq);
	
	/** 입점업체 주문확인 메일링 리스트 */
	public List<String> getListSellerEmail(Integer orderSeq);
	
	/** 함께누리몰 기주문 개인정보 암호화 대상 리스트 */
	public List<OrderVo> getListForEncrypt();
	
	/** 함께누리몰 기주문 개인정보 암호화 업데이트 */
	public int updateForEncrypt(OrderVo vo);
	
	
	
}
