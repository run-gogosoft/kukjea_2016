package com.smpro.dao;

import com.smpro.vo.MemberStatsVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.UserVo;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Member;
import java.util.List;

@Repository
public interface MemberDao {
	public MemberStatsVo getStats();

	public List<MemberVo> getList(MemberVo vo);

	public List<MemberVo> getRequestList(MemberVo vo);

	public int getListCount(MemberVo vo);

	public int getRequestListCount(MemberVo vo);

	public MemberVo getData(Integer seq);

	public MemberVo getData(String id);

	/** 회원 상세 정보 검색 */
	public MemberVo getSearchMemberVo(MemberVo vo);

	/** 회원 상세 정보 검색(리스트) */
	public List<MemberVo> getSearchMemberList(MemberVo vo);

	public int regData(MemberVo vo);

	public int modDataUser(MemberVo vo);

	public int modDataMember(MemberVo vo);

	public List<UserVo> getCompanyAndMemberRegCntForWeek();

	/** 한달간 전체 회원 수 */
	public MemberStatsVo getMonthMemberStats(Integer periodCount);

	/** 일주일간 신규가입 회원 수 */
	public MemberStatsVo getWeekMemberStats(Integer periodCount);

	public Integer getMemberSeq(MemberVo mvo);

	public int updateMemberPassword(MemberVo vo);

	public int leaveMember(Integer seq);
	
	/** 패스워드 초기화 */
	public int initPassword(MemberVo vo);
	
	/** 이메일, SMS 수신동의 */
	public int updateReceiverAgree(MemberVo vo);
	
	/** 비밀번호 변경 안내 메일 발송 대상자 리스트 */
	public List<MemberVo> getListForPasswordNotice();
	
	/** 본인인증(아이핀/휴대폰) 키값으로 회원 존재 여부 체크 */
	public int checkCnt(String certKey);
	
	public List<MemberVo> getListForEncrypt();
	
	public int updateForEncrypt(MemberVo vo);
}
