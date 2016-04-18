package com.smpro.dao;

import com.smpro.vo.ItemVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class WishDaoImpl implements WishDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ItemVo> getList(ItemVo vo) {
		return sqlSession.selectList("wish.getList", vo);
	}

	@Override
	public int regData(ItemVo vo) {
		return sqlSession.insert("wish.regData", vo);
	}

	@Override
	public int delData(ItemVo vo) {
		return sqlSession.delete("wish.delData", vo);
	}

	@Override
	public int getCnt(ItemVo vo) {
		return ((Integer)sqlSession.selectOne("wish.getCnt", vo)).intValue();
	}

	@Override
	public Integer getWishListCount(Integer memberSeq) {
		return sqlSession.selectOne("wish.getWishListCount", memberSeq);
	}
	
	@Override
	public ItemVo getData(Integer wishSeq) {
		return sqlSession.selectOne("wish.getData", wishSeq);
	}

}
