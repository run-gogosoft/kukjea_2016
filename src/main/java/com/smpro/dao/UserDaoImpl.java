package com.smpro.dao;

import com.smpro.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insertData(UserVo vo) {
		return sqlSession.insert("user.insertData", vo);
	}

	@Override
	public int updateData(UserVo vo) {
		return sqlSession.update("user.updateData", vo);
	}

	@Override
	public boolean deleteMall(Integer seq) {
		return sqlSession.delete("user.deleteMall", seq) > 0;
	}

	public int getIdCnt(UserVo vo) {
		return ((Integer)sqlSession.selectOne("user.getIdCnt", vo)).intValue();
	}
	
	@Override
	public int getEmailCnt(UserVo vo) {
		return ((Integer)sqlSession.selectOne("user.getEmailCnt", vo)).intValue();
	}

	@Override
	public int getNickNameCnt(String nickname) {
		return ((Integer)sqlSession.selectOne("user.getNickNameCnt", nickname)).intValue();
	}
	
	@Override
	public int updateTempPassword(UserVo vo) {
		return sqlSession.update("user.updateTempPassword", vo);
	}
	
	@Override
	public int updateTempPasswordForSeller(UserVo vo) {
		return sqlSession.update("user.updateTempPasswordForSeller", vo);
	}
	
	@Override
	public int updateTempPasswordForAdmin(UserVo vo) {
		return sqlSession.update("user.updateTempPasswordForAdmin", vo);
	}

	@Override
	public String getFindId(UserVo vo) {
		return sqlSession.selectOne("user.getFindId", vo);
	}
	
	@Override
	public String getFindIdForSeller(UserVo vo) {
		return sqlSession.selectOne("user.getFindIdForSeller", vo);
	}

	@Override
	public String getFindIdForAdmin(UserVo vo) {
		return sqlSession.selectOne("user.getFindIdForAdmin", vo);
	}
	
	@Override
	public int updatePassword(UserVo vo) {
		return sqlSession.update("user.updatePassword", vo);
	}
	
	@Override
	public int updatePasswordDelay(Integer seq) {
		return sqlSession.update("user.updatePasswordDelay", seq);
	}

	@Override
	public List<UserVo> getListForEncrypt(String typeCode) {
		return sqlSession.selectList("user.getListForEncrypt", typeCode);
	}

	@Override
	public int updateForEncrypt(UserVo vo) {
		return sqlSession.update("user.updateForEncrypt", vo);
	}
}
