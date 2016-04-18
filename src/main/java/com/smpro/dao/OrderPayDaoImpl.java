package com.smpro.dao;

import com.smpro.vo.OrderPayVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class OrderPayDaoImpl implements OrderPayDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public OrderPayVo getPayVoForCancel(Integer orderSeq) {
		return sqlSession.selectOne("order_pay.getPayVoForCancel", orderSeq);
	}

	@Override
	public int regOrderPay(OrderPayVo vo) {
		return sqlSession.insert("order_pay.regOrderPay", vo);
	}

	@Override
	public int regOrderPayCancel(OrderPayVo vo) {
		return sqlSession.insert("order_pay.regOrderPayCancel", vo);
	}

	public List<OrderPayVo> getPayInfoListForDetail(Integer orderSeq) {
		return sqlSession.selectList("order_pay.getPayInfoListForDetail", orderSeq);
	}

	@Override
	public List<OrderPayVo> getListPayCancel(Integer orderSeq) {
		return sqlSession.selectList("order_pay.getListPayCancel", orderSeq);
	}

	@Override
	public int getSumCancelPayAmountTax(Integer orderSeq) {
		return ((Integer) sqlSession.selectOne("order_pay.getSumCancelPayAmountTax", orderSeq)).intValue();
	}

	@Override
	public Map<String, Float> getFeeRate(String payMethod) {
		return sqlSession.selectOne("order_pay.getFeeRate", payMethod);
	}

	@Override
	public int modVo(OrderPayVo vo) {
		return sqlSession.update("order_pay.modVo", vo);
	}
	
}
