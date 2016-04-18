package com.smpro.dao;

import com.smpro.vo.EstimateVo;
import com.smpro.vo.ItemVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EstimateDaoImpl implements EstimateDao {
	@Autowired
	private SqlSession sqlSession;

	public List<EstimateVo> getList(EstimateVo vo) {
		return sqlSession.selectList("estimate.getList", vo);
	}
	
	public int getListCount(EstimateVo vo) {
		return ((Integer)sqlSession.selectOne("estimate.getListCount", vo)).intValue();
	}
	
	public EstimateVo getVo(Integer seq) {
		return sqlSession.selectOne("estimate.getVo", seq);
	}
	
	public int regVo(EstimateVo vo) {
		return sqlSession.insert("estimate.regVo", vo);
	}
	
	public int modVo(EstimateVo vo) {
		return sqlSession.update("estimate.modVo", vo);
	}
	
	public int delVo(Integer seq) {
		return sqlSession.delete("estimate.delVo", seq);
	}
	
	public int updateStatus(EstimateVo vo) {
		return sqlSession.update("estimate.updateStatus", vo);
	}

	public List<EstimateVo> getListCompare(EstimateVo vo) {
		return sqlSession.selectList("estimate.getListCompare", vo);
	}
	
	public List<EstimateVo> getListCompareFile(EstimateVo vo) {
		return sqlSession.selectList("estimate.getListCompareFile", vo);
	}

	public int getListCountCompare(EstimateVo vo) {
		return ((Integer)sqlSession.selectOne("estimate.getListCountCompare", vo)).intValue();
	}
	
	public EstimateVo getVoCompare(Integer seq) {
		return sqlSession.selectOne("estimate.getVoCompare", seq);
	}
	
	public int regVoCompare(EstimateVo vo) {
		return sqlSession.insert("estimate.regVoCompare", vo);
	}
	
	public int modVoCompare(EstimateVo vo) {
		return sqlSession.update("estimate.modVoCompare", vo);
	}
	
	public int delVoCompare(Integer seq) {
		return sqlSession.delete("estimate.delVoCompare", seq);
	}

	public int createEstimateCompareSeq(EstimateVo vo) {
		return sqlSession.update("estimate.createEstimateCompareSeq", vo);
	}

	public List<ItemVo> getListForOrder(EstimateVo vo) {
		return sqlSession.selectList("estimate.getListForOrder", vo);
	}

	public String getSalesCell(Integer itemSeq) {
	
		return sqlSession.selectOne("estimate.getSalesCell", itemSeq);
	}
	
}
