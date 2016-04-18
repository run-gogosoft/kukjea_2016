package com.smpro.dao;

import com.smpro.vo.PointVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PointDaoImpl implements PointDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<PointVo> getList(PointVo vo) {
		return sqlSession.selectList("point.getList", vo);
	}

	@Override
	public int getListCount(PointVo vo) {
		return ((Integer)sqlSession.selectOne("point.getListCount", vo)).intValue();
	}

	@Override
	public PointVo getVo(PointVo vo) {
		return sqlSession.selectOne("point.getVo", vo);
	}

	@Override
	public List<PointVo> getDetailList(PointVo vo) {
		return sqlSession.selectList("point.getDetailList", vo);
	}

	@Override
	public Integer getDetailListCount(PointVo vo) {
		return sqlSession.selectOne("point.getDetailListCount", vo);
	}

	@Override
	public List<PointVo> getShopPointList(PointVo vo) {
		return sqlSession.selectList("point.getShopPointList", vo);
	}

	@Override
	public int getShopPointCount(PointVo vo) {
		return ((Integer)sqlSession.selectOne("point.getShopPointCount", vo)).intValue();
	}

	@Override
	public int updateData(PointVo vo) {
		return sqlSession.update("point.updateData", vo);
	}

	@Override
	public int insertData(PointVo vo) {
		return sqlSession.insert("point.insertData", vo);
	}

	@Override
	public int insertHistoryData(PointVo vo) {
		return sqlSession.insert("point.insertHistoryData", vo);
	}

	@Override
	public int insertLogData(PointVo vo) {
		return sqlSession.insert("point.insertLogData", vo);
	}

	@Override
	public List<PointVo> getPointList(Integer memberSeq) {
		return sqlSession.selectList("point.getPointList", memberSeq);
	}

	@Override
	public List<PointVo> getBatchPointForEndDate() {
		return sqlSession.selectList("point.getBatchPointForEndDate");
	}

	@Override
	public List<PointVo> getShopPointListForAllCancel(PointVo vo) {
		return sqlSession.selectList("point.getShopPointListForAllCancel", vo);
	}

	@Override
	public Integer getUseablePoint(Integer memberSeq) {
		return sqlSession.selectOne("point.getUseablePoint", memberSeq);
	}

	@Override
	public PointVo getHistoryForCancel(Integer orderSeq) {
		return sqlSession.selectOne("point.getHistoryForCancel", orderSeq);
	}

	@Override
	public int checkCancel(PointVo vo) {
		return ((Integer) sqlSession.selectOne("point.checkCancel", vo)).intValue();
	}

	@Override
	public List<PointVo> getHistoryList(Integer orderSeq) {
		return sqlSession.selectList("point.getHistoryList", orderSeq);
	}

	@Override
	public Integer getExcelDownListCount(PointVo vo) {
		return sqlSession.selectOne("point.getExcelDownListCount", vo);
	}

	@Override
	public List<PointVo> getExcelDownList(PointVo vo) {
		return sqlSession.selectList("point.getExcelDownList", vo);
	}
}
