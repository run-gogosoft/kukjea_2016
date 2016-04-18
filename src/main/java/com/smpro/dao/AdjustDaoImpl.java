package com.smpro.dao;

import com.smpro.vo.AdjustVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdjustDaoImpl implements AdjustDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<AdjustVo> getListForAdjust() {
		return sqlSession.selectList("adjust.getListForAdjust");
	}

	@Override
	public List<AdjustVo> getListForAdjustCancel() {
		return sqlSession.selectList("adjust.getListForAdjustCancel");
	}

	@Override
	public List<AdjustVo> getList(AdjustVo pvo) {
		return sqlSession.selectList("adjust.getList", pvo);
	}

	@Override
	public List<AdjustVo> getOrderList(AdjustVo pvo) {
		return sqlSession.selectList("adjust.getOrderList", pvo);
	}

	@Override
	public int updateStatus(AdjustVo vo) {
		return sqlSession.update("adjust.updateStatus", vo);
	}

	@Override
	public int regVo(AdjustVo vo) {
		return sqlSession.insert("adjust.regVo", vo);
	}

	@Override
	public int updateAdjustFlag(Integer seq) {
		return sqlSession.update("adjust.updateAdjustFlag", seq);
	}

	@Override
	public int delVo(Integer seq) {
		return sqlSession.delete("adjust.delVo", seq);
	}
}
