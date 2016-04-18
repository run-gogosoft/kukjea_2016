package com.smpro.dao;

import com.smpro.vo.ItemVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDaoImpl implements CartDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ItemVo> getList(ItemVo vo) {
		return sqlSession.selectList("cart.getList", vo);
	}

	@Override
	public Integer getListTotalCount(ItemVo vo) {
		return sqlSession.selectOne("cart.getListTotalCount", vo);
	}

	@Override
	public ItemVo getVo(ItemVo vo) {
		return sqlSession.selectOne("cart.getVo", vo);
	}

	@Override
	public int insertVo(ItemVo vo) {
		return sqlSession.insert("cart.insertVo", vo);
	}

	@Override
	public int updateVo(ItemVo vo) {
		return sqlSession.update("cart.updateVo", vo);
	}

	@Override
	public int deleteVo(ItemVo vo) {
		return sqlSession.delete("cart.deleteVo", vo);
	}

	@Override
	public int deleteBatch() {
		return sqlSession.delete("cart.deleteBatch");
	}
	
}
