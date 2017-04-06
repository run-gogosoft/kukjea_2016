package com.smpro.dao;

import com.smpro.vo.MemberStatsVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MemberVo> getList(MemberVo vo) {
		return sqlSession.selectList("member.getList", vo);
	}

	@Override
	public List<MemberVo> getRequestList(MemberVo vo) {
		return sqlSession.selectList("member.getRequestList", vo);
	}

	@Override
	public int getListCount(MemberVo vo) {
		return ((Integer) sqlSession.selectOne("member.getListCount", vo)).intValue();
	}

	@Override
	public int getRequestListCount(MemberVo vo) {
		return ((Integer) sqlSession.selectOne("member.getRequestListCount", vo)).intValue();
	}

	@Override
	public MemberVo getData(Integer seq) {
		return sqlSession.selectOne("member.getData", seq);
	}

	@Override
	public MemberVo getData(String id) {
		return sqlSession.selectOne("member.getDataByLoginId", id);
	}

	@Override
	public MemberVo getSearchMemberVo(MemberVo vo) {
		return sqlSession.selectOne("member.getSearchMemberVo", vo);
	}

	@Override
	public List<MemberVo> getSearchMemberList(MemberVo vo) {
		return sqlSession.selectList("member.getSearchMemberList", vo);
	}

	@Override
	public int regData(MemberVo vo) {
		return sqlSession.insert("member.regData", vo);
	}

	@Override
	public int modDataUser(MemberVo vo) {
		return sqlSession.update("member.modDataUser", vo);
	}

	@Override
	public int modDataMember(MemberVo vo) {
		return sqlSession.update("member.modDataMember", vo);
	}

	@Override
	public MemberStatsVo getStats() {
		return sqlSession.selectOne("member.getStats");
	}

	@Override
	public List<UserVo> getCompanyAndMemberRegCntForWeek() {
		return sqlSession.selectList("member.getCompanyAndMemberRegCntForWeek");
	}

	@Override
	public MemberStatsVo getMonthMemberStats(Integer periodCount) {
		return sqlSession.selectOne("member.getMonthMemberStats", periodCount);
	}

	@Override
	public MemberStatsVo getWeekMemberStats(Integer periodCount) {
		return sqlSession.selectOne("member.getWeekMemberStats", periodCount);
	}

	@Override
	public Integer getMemberSeq(MemberVo mvo) {
		return sqlSession.selectOne("member.getMemberSeq", mvo);
	}

	@Override
	public int updateMemberPassword(MemberVo vo) {
		return sqlSession.update("member.updateMemberPassword", vo);
	}

	@Override
	public int leaveMember(Integer seq) {
		return sqlSession.update("member.leaveMember", seq);
	}

	@Override
	public int initPassword(MemberVo vo) {
		return sqlSession.update("member.initPassword", vo);
	}
	
	@Override
	public int updateReceiverAgree(MemberVo vo) {
		return sqlSession.update("member.updateReceiverAgree", vo);
	}
	
	

	@Override
	public List<MemberVo> getListForPasswordNotice() {
		return sqlSession.selectList("member.getListForPasswordNotice");
	}

	@Override
	public int checkCnt(String certKey) {
		return ((Integer)sqlSession.selectOne("member.checkCnt", certKey)).intValue();
	}

	@Override
	public List<MemberVo> getListForEncrypt() {
		return sqlSession.selectList("member.getListForEncrypt");
	}

	@Override
	public int updateForEncrypt(MemberVo vo) {
		return sqlSession.update("member.updateForEncrypt", vo);
	}
	
	
}
