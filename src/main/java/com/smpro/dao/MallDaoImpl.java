package com.smpro.dao;

import com.smpro.vo.MallVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MallDaoImpl implements MallDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MallVo> getList(MallVo reqVo) {
		return sqlSession.selectList("mall.getList", reqVo);
	}

	@Override
	public List<MallVo> getListSimple() {
		return sqlSession.selectList("mall.getListSimple");
	}

	@Override
	public MallVo getVo(Integer seq) {
		return sqlSession.selectOne("mall.getVo", seq);
	}

	@Override
	public MallVo getLoginTmpl(String mallId) {
		return sqlSession.selectOne("mall.getLoginTmpl", mallId);
	}

	@Override
	public int regVo(MallVo vo) {
		return sqlSession.insert("mall.regVo", vo);
	}

	@Override
	public int modVo(MallVo vo) {
		return sqlSession.update("mall.modVo", vo);
	}

	@Override
	public MallVo getMainInfo(String mallId) {
		return sqlSession.selectOne("mall.getMainInfo", mallId);
	}

}
