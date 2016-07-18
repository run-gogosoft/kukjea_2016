package com.smpro.dao;

import com.smpro.vo.CategoryVo;
import com.smpro.vo.ItemVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CategoryDaoImpl implements CategoryDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CategoryVo> getList(CategoryVo vo) {
		return sqlSession.selectList("category.getList", vo);
	}

	@Override
	public List<CategoryVo> getListSimple(CategoryVo vo) {
		return sqlSession.selectList("category.getListSimple", vo);
	}

	@Override
	public List<CategoryVo> getListForSearch(ItemVo vo) {
		return sqlSession.selectList("category.getListForSearch", vo);
	}

	@Override
	public CategoryVo getVo(Integer seq) {
		return sqlSession.selectOne("category.getVo", seq);
	}

	@Override
	public CategoryVo getVoByName(Map name) {
		return sqlSession.selectOne("category.getVoByName", name);
	}

	@Override
	public int insertVo(CategoryVo vo) {
		return sqlSession.insert("category.insertVo", vo);
	}

	@Override
	public int updateVo(CategoryVo vo) {
		return sqlSession.update("category.updateVo", vo);
	}

	@Override
	public int updateOrderNo(CategoryVo vo) {
		return sqlSession.update("category.updateOrderNo", vo);
	}

	@Override
	public int deleteVo(Integer seq) {
		return sqlSession.delete("category.deleteVo", seq);
	}

	@Override
	public String getFirstDepthSeq(CategoryVo vo) {
		return sqlSession.selectOne("category.getFirstDepthSeq", vo);
	}

	@Override
	public Integer getLv1Value(Integer seq) {
		return sqlSession.selectOne("category.getLv1Value", seq);
	}

	@Override
	public Integer getLv2Value(Integer seq) {
		return sqlSession.selectOne("category.getLv2Value", seq);
	}
}
