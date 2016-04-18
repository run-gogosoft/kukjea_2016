package com.smpro.dao;

import com.smpro.vo.MemberGroupVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberGroupDaoImpl implements MemberGroupDao {
	@Autowired
	private SqlSession sqlSession;

	public int regVo(MemberGroupVo vo) {
		return sqlSession.insert("memberGroup.regVo", vo);
	}

	public int modVo(MemberGroupVo vo) {
		return sqlSession.update("memberGroup.modVo", vo);
	}

	public MemberGroupVo getVo(Integer seq) {
		return sqlSession.selectOne("memberGroup.getVo", seq);
	}

	public int modAddr(MemberGroupVo vo) {
		return sqlSession.update("memberGroup.modAddr", vo);
	}
	
	@Override
	public int getBizNoCnt(String bizNo) {
		return ((Integer) sqlSession.selectOne("memberGroup.getBizNoCnt", bizNo)).intValue();
	}
}
