package com.smpro.dao;

import com.smpro.vo.OrderPayVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface OrderPayDao {
	/** pg 결제 정보 저장 */
	public int regOrderPay(OrderPayVo vo);

	/** PG 결제 내역 리스트(주문번호별) */
	public List<OrderPayVo> getPayInfoListForDetail(Integer orderSeq);

	/** PG 결제 취소 내역 리스트(주문번호별) */
	public List<OrderPayVo> getListPayCancel(Integer orderSeq);

	/** pg 결제 취소할 정보 가져오기 */
	public OrderPayVo getPayVoForCancel(Integer orderSeq);

	/** pg 결제 취소 내역 저장 */
	public int regOrderPayCancel(OrderPayVo vo);

	/** pg 주문번호별 취소된 과세금액 합계 */
	public int getSumCancelPayAmountTax(Integer orderSeq);
	
	/** 결제 수단별 수수료율 가져오기 */
	public Map<String,Float> getFeeRate(String payMethod);
	
	/** 입금 통보 수신시 결제정보 업데이트 */
	public int modVo(OrderPayVo vo);
}
