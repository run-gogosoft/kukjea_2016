package com.smpro.dao;

import com.smpro.vo.MemberGroupVo;
import com.smpro.vo.OrderVo;
import com.smpro.vo.SellerVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class OrderStatsDaoImpl implements OrderStatsDao {
	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<HashMap<String,Integer[]>> getListByCategory(OrderVo vo) {
		return sqlSession.selectList("order_stats.getListByCategory", vo);
	}
	
	@Override
	public HashMap<String, Integer[]> getSumByCategory(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getSumByCategory", vo);
	}

	@Override
	public List<OrderVo> getListByCategoryDetail(OrderVo vo) {
		return sqlSession.selectList("order_stats.getListByCategoryDetail", vo);
	}

	@Override
	public OrderVo getListByCategoryDetailSum(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getListByCategoryDetailSum", vo);
	}

	@Override
	public OrderVo getListByCategoryDetailCancelSum(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getListByCategoryDetailCancelSum", vo);
	}

	@Override
	public List<HashMap<String, Integer>> getListByAuthCategory(OrderVo vo) {
		return sqlSession.selectList("order_stats.getListByAuthCategory", vo);
	}

	@Override
	public HashMap<String, Integer> getSumByAuthCategory(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getSumByAuthCategory", vo);
	}

	@Override
	public List<HashMap<String, Integer>> getListByMember(OrderVo vo) {
		return sqlSession.selectList("order_stats.getListByMember", vo);
	}

	@Override	
	public HashMap<String, Integer> getSumByMember(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getSumByMember", vo);
	}

	@Override
	public List<HashMap<String, Integer>> getListByMemberPublic(OrderVo vo) {
		return sqlSession.selectList("order_stats.getListByMemberPublic", vo);
	}
	
	@Override
	public List<OrderVo> getListByMemberPublicDetail(MemberGroupVo vo) {
		return sqlSession.selectList("order_stats.getListByMemberPublicDetail", vo);
	}

	@Override
	public List<OrderVo> getListByItem(OrderVo vo) {
		return sqlSession.selectList("order_stats.getListByItem", vo);
	}
	
	@Override
	public OrderVo getListByItemSum(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getListByItemSum", vo);
	}
	
	@Override
	public OrderVo getListByItemCancelSum(OrderVo vo) {
		return sqlSession.selectOne("order_stats.getListByItemCancelSum", vo);
	}

	@Override
	public List<OrderVo> getListByItemForSellerJachigu(SellerVo vo) {
		return sqlSession.selectList("order_stats.getListByItemForSellerJachigu", vo);
	}

	@Override
	public OrderVo getListByItemForSellerJachiguSum(SellerVo vo) {
		return sqlSession.selectOne("order_stats.getListByItemForSellerJachiguSum", vo);
	}

	@Override
	public List<OrderVo> getListByItemForMemberJachigu(SellerVo vo) {
		return sqlSession.selectList("order_stats.getListByItemForMemberJachigu", vo);
	}

	@Override
	public OrderVo getListByItemForMemberJachiguSum(SellerVo vo) {
		return sqlSession.selectOne("order_stats.getListByItemForMemberJachiguSum", vo);
	}
}
