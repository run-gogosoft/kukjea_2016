package com.smpro.dao;

import com.smpro.vo.OrderVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderTaxRequestDaoImpl implements OrderTaxRequestDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int mergeData(OrderVo vo) {
		return sqlSession.update("order_taxrequest.mergeData", vo);
	}

	@Override
	public OrderVo getData(Integer orderSeq) {
		return sqlSession.selectOne("order_taxrequest.getData", orderSeq);
	}

	@Override
	public int completeTaxRequest(Integer orderSeq) {
		return sqlSession.update("order_taxrequest.completeTaxRequest", orderSeq);
	}
}
