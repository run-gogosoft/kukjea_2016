package com.smpro.dao;

import com.smpro.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class OrderDaoImpl implements OrderDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<OrderVo> getList(OrderVo pvo) {
		return sqlSession.selectList("order.getList", pvo);
	}

	@Override
	public List<OrderVo> getRepeatOrderList(OrderVo pvo) {
		return sqlSession.selectList("order.getRepeatOrderList", pvo);
	}


	@Override
	public int getListCount(OrderVo pvo) {
		return ((Integer)sqlSession.selectOne("order.getListCount", pvo)).intValue();
	}

	@Override
	public List<OrderVo> getCsOrderList(OrderVo pvo) {
		return sqlSession.selectList("order.getCsOrderList", pvo);
	}

	@Override
	public Integer getCsOrderListCount(OrderVo pvo) {
		return sqlSession.selectOne("order.getCsOrderListCount", pvo);
	}

	@Override
	public List<OrderVo> getCsLogList(OrderVo vo) {
		return sqlSession.selectList("order.getCsLogList", vo);
	}

	@Override
	public int getCsLogListCount(OrderVo vo) {
		return ((Integer)sqlSession.selectOne("order.getCsLogListCount", vo)).intValue();
	}

	@Override
	public List<OrderVo> getListForDetail(OrderVo pvo) {
		return sqlSession.selectList("order.getListForDetail", pvo);
	}

	@Override
	public List<OrderVo> getDeliveryTargetList(Integer sellerSeq) {
		return sqlSession.selectList("order.getDeliveryTargetList", sellerSeq);
	}

	@Override
	public List<OrderCsVo> getCsList(Integer seq) {
		return sqlSession.selectList("order.getCsList", seq);
	}

	@Override
	public List<OrderCsVo> getLogList(Integer seq) {
		return sqlSession.selectList("order.getLogList", seq);
	}

	@Override
	public OrderVo getData(OrderVo vo) {
		return sqlSession.selectOne("order.getData", vo);
	}

	@Override
	public OrderVo getCheckData(Integer seq) {
		return sqlSession.selectOne("order.getCheckData", seq);
	}

	@Override
	public int regData(OrderVo vo) {
		return sqlSession.insert("order.regData", vo);
	}

	@Override
	public int regCsData(OrderCsVo vo) {
		return sqlSession.insert("order.regCsData", vo);
	}
	
	@Override
	public int deleteCsData(Integer seq) {
		return sqlSession.delete("order.deleteCsData", seq);
	}

	@Override
	public int regLogData(OrderLogVo vo) {
		return sqlSession.insert("order.regLogData", vo);
	}

	@Override
	public int modData(OrderVo vo) {
		return sqlSession.update("order.modData", vo);
	}

	@Override
	public int updateStatus(OrderVo vo) {
		return sqlSession.update("order.updateStatus", vo);
	}

	@Override
	public int updateStatusForDelivery(OrderVo vo) {
		return sqlSession.update("order.updateStatusForDelivery", vo);
	}

	@Override
	public int regDetailData(OrderVo vo) {
		return sqlSession.insert("order.regDetailData", vo);
	}

	@Override
	public List<OrderVo> getSellDaily(OrderVo vo) {
		return sqlSession.selectList("order.getSellDaily", vo);
	}

	@Override
	public List<HashMap<String, String>> getCntByStatus(OrderVo pvo) {
		return sqlSession.selectList("order.getCntByStatus", pvo);
	}
	
	@Override
	public String getTotalOrderFinishPrice(Integer loginSeq) {
		return sqlSession.selectOne("order.getTotalOrderFinishPrice", loginSeq);
	}

	@Override
	public Integer getOrderCntAfterStatus10(OrderVo vo) {
		return sqlSession.selectOne("order.getOrderCntAfterStatus10", vo);
	}

	@Override
	public List<OrderVo> getRankingOrderFinishPrice(OrderVo vo) {
		return sqlSession.selectList("order.getRankingOrderFinishPrice", vo);
	}

	@Override
	public List<OrderVo> getDayOrderStatus(MemberVo memberVo) {
		return sqlSession.selectList("order.getDayOrderStatus", memberVo);
	}

	@Override
	public List<OrderVo> getMonthOrderStatus(MemberVo memberVo) {
		return sqlSession.selectList("order.getMonthOrderStatus", memberVo);
	}

	@Override
	public List<OrderVo> getYearOrderStatus(MemberVo memberVo) {
		return sqlSession.selectList("order.getYearOrderStatus", memberVo);
	}

	@Override
	public OrderVo getOrderSumForWeek(MemberVo memberVo) {
		return sqlSession.selectOne("order.getOrderSumForWeek", memberVo);
	}

	@Override
	public OrderVo getOrderSumChartForWeek(OrderVo vo) {
		return sqlSession.selectOne("order.getOrderSumChartForWeek", vo);
	}

	@Override
	public OrderVo getOrderSumChartForToDay(OrderVo vo) {
		return sqlSession.selectOne("order.getOrderSumChartForToDay", vo);
	}

	@Override
	public List<OrderVo> getOrderDeliveryFinish() {
		return sqlSession.selectList("order.getOrderDeliveryFinish");
	}

	@Override
	public List<OrderVo> getOrderConfirm() {
		return sqlSession.selectList("order.getOrderConfirm");
	}

	@Override
	public MemberDeliveryVo getLatelyOrderVo(Integer memberSeq) {
		return sqlSession.selectOne("order.getLatelyOrderVo", memberSeq);
	}

	@Override
	public Integer checkCancelAll(OrderVo vo) {
		return sqlSession.selectOne("order.checkCancelAll", vo);
	}

	@Override
	public int updateCancelAll(OrderVo vo) {
		return sqlSession.update("order.updateCancelAll", vo);
	}

	@Override
	public OrderVo getVoDetail(Integer seq) {
		return sqlSession.selectOne("order.getVoDetail", seq);
	}

	@Override
	public OrderVo calcPartCancelAmt(Integer seq) {
		return sqlSession.selectOne("order.calcPartCancelAmt", seq);
	}

	@Override
	public List<OrderVo> getListExcelDownload(OrderVo vo) {
		return sqlSession.selectList("order.getListExcelDownload", vo);
	}

	@Override
	public Long getSumPrice(OrderVo pvo) {
		return sqlSession.selectOne("order.getSumPrice", pvo);
	}

	@Override
	public Integer findMinSeqBySeller(OrderVo vo) {
		return sqlSession.selectOne("order.findMinSeqBySeller", vo);
	}

	@Override
	public int copyPackageDeliCost(Integer minSeqBySeller) {
		return sqlSession.update("order.copyPackageDeliCost", minSeqBySeller);
	}

	@Override
	public int initPackageDeliCost(Integer seq) {
		return sqlSession.update("order.initPackageDeliCost", seq);
	}

	@Override
	public int updateAddr(OrderVo vo) {
		return sqlSession.update("order.updateAddr", vo);
	}
	
	@Override
	public int updateMember(OrderVo vo) {
		return sqlSession.update("order.updateMember", vo);
	}

	@Override
	public List<?> getSeqList(Integer orderSeq) {
		return sqlSession.selectList("order.getSeqList", orderSeq);
	}

	@Override
	public Integer getItemOrderCnt(Integer seq) {
		return sqlSession.selectOne("order.getItemOrderCnt", seq);
	}

	@Override
	public List<OrderVo> getDeliList(OrderVo pvo) {
		return sqlSession.selectList("order.getDeliList", pvo);
	}

	@Override
	public OrderVo getOrderInfo(OrderVo ovo) {
		return sqlSession.selectOne("order.getOrderInfo", ovo);
	}
	
	@Override
	public int createOrderSeq(OrderVo ovo) {
		return sqlSession.update("order.createOrderSeq", ovo);
	}
	
	@Override
	public int getListForReviewDetailCount(OrderVo vo) {
		return ((Integer)sqlSession.selectOne("order.getListForReviewDetailCount", vo)).intValue();
	}

	@Override
	public List<OrderVo> getListForReviewDetail(OrderVo vo) {
		return sqlSession.selectList("order.getListForReviewDetail", vo);
	}

	@Override
	public List<OrderVo> getCheckList(Integer orderSeq) {
		return sqlSession.selectList("order.getCheckList", orderSeq);
	}

	@Override
	public int updateStatusForConfirm(Integer orderSeq) {
		return sqlSession.update("order.updateStatusForConfirm", orderSeq);
	}

	@Override
	public int updateNpPayFlag(OrderVo vo) {
		return sqlSession.update("updateNpPayFlag", vo);
	}

	@Override
	public List<OrderVo> getWeekOrderStatus(MemberVo vo) {
		return sqlSession.selectList("order.getWeekOrderStatus", vo);
	}

	@Override
	public List<Integer> getListExpire() {
		return sqlSession.selectList("order.getListExpire");
	}
	
	@Override
	public List<OrderVo> getListNP(OrderVo vo) {
		return sqlSession.selectList("order.getListNP", vo);
	}

	@Override
	public int getListNPCount(OrderVo vo) {
		return Integer.parseInt(String.valueOf(sqlSession.selectOne("order.getListNPCount", vo)));
	}

	@Override
	public int checkOrder(Integer orderSeq) {
		return Integer.parseInt(String.valueOf(sqlSession.selectOne("order.checkOrder", orderSeq)));
	}

	@Override
	public OrderVo getVoNP(Integer orderSeq) {
		return sqlSession.selectOne("order.getVoNP", orderSeq);
	}

	@Override
	public String getOrderItemName(Integer orderSeq) {
		return sqlSession.selectOne("order.getOrderItemName", orderSeq);
	}

	@Override
	public List<OrderVo> getListForEncrypt() {
		return sqlSession.selectList("order.getListForEncrypt");
	}

	@Override
	public int updateForEncrypt(OrderVo vo) {
		return sqlSession.update("order.updateForEncrypt", vo);
	}
	
	@Override
	public List<String> getListSellerEmail(Integer orderSeq) {
		return sqlSession.selectList("order.getListSellerEmail", orderSeq);
	}
}
