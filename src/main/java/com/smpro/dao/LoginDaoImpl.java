package com.smpro.dao;

import com.smpro.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDaoImpl implements LoginDao {
	@Autowired
	private SqlSession sqlSession;
	/** 로그인 */
	@Override
	public UserVo getData(UserVo vo) {
		return sqlSession.selectOne("login.getData", vo);
	}

	/** 토큰 로그인 */
	@Override
	public UserVo getDataForToken(UserVo vo) {
		return sqlSession.selectOne("login.getDataForToken", vo);
	}

	/** 로그인 기록 */
	@Override
	public int updateData(UserVo vo) {
		return sqlSession.update("login.updateData", vo);
	}

	/**
	 * 임시 비밀번호를 통한 접근
	 * 
	 * @param uid
	 * @return */
	@Override
	public UserVo getDataByTempPassword(String uid) {
		return sqlSession.selectOne("login.getDataByTempPassword", uid);
	}

	@Override
	public int insertAdminAccessLog(UserVo vo) {
		return sqlSession.insert("login.insertAdminAccessLog", vo);
	}

	public int checkCntInOrder(UserVo pvo) {
		return ((Integer)sqlSession.selectOne("login.checkCntInOrder", pvo)).intValue();
	}

}
