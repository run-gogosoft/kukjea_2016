package com.smpro.service;

import com.smpro.vo.*;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.List;

@Service
public interface MemberService {
	/** 회원 리스트 
	 * @throws Exception */
	public List<MemberVo> getList(MemberVo vo) throws Exception;

	/** 몰 이용 요청 회원 리스트
	 * @throws Exception */
	public List<MemberVo> getRequestList(MemberVo vo) throws Exception;

	/** 요청회원 리스트 건수 **/
	public int getRequestListCount(MemberVo vo);

	/** 회원 리스트 검색 건수 */
	public int getListCount(MemberVo vo);

	/** 회원 상세 정보 조회 */
	public MemberVo getData(Integer seq) throws Exception;

	/** 회원 상세 정보 조회(외부 연동용) */
	public MemberVo getData(String id);

	/** 회원 상세 정보 검색 */
	public MemberVo getSearchMemberVo(MemberVo vo);

	/** 회원 상세 정보 검색 */
	public List<MemberVo> getSearchMemberList(MemberVo vo) throws UnsupportedEncodingException, InvalidKeyException;

	/** 회원가입 */
	public boolean regData(MemberVo vo) throws Exception;

	/** 회원 정보 수정 */
	public boolean modData(MemberVo vo) throws Exception;

	/** 회원 현황 */
	public MemberStatsVo getStats();

	/** 임시비밀번호 업데이트 */
	public int updateTempPassword(UserVo vo) throws Exception;
	public int updateTempPasswordForSeller(UserVo vo) throws Exception;
	public int updateTempPasswordForAdmin(UserVo vo) throws Exception;
	
	/** 회원 아이디 기등록 체크 */
	public int getIdCnt(MemberVo vo);
	
	/** 회원 이메일 기등록 체크 */
	public int getEmailCnt(MemberVo vo) throws Exception;
	
	/** 회원 닉네임 기등록 체크 */
	public int getNickNameCnt(String nickname);

	public List<UserVo> getCompanyAndMemberRegCntForWeek();

	/** 한달간 전체 회원 수 */
	public List<MemberStatsVo> getMonthMemberStats();

	/** 일주일간 신규 회원 수 */
	public List<MemberStatsVo> getWeekMemberStats();

	/** 회원 엑셀 다운로드  */
	public Workbook writeExcelMemberist(MemberVo vo, String type) throws Exception;

	/** 엑셀 데이터 유효성 체크 */
	public String chkXlsData(String[] row, Integer mallSeq);

	public Integer getMemberSeq(MemberVo mvo);

	public int updateMemberPassword(MemberVo vo);

	public boolean leaveMember(Integer seq);
	
	/** 패스워드 초기화 */
	public boolean initPassword(MemberVo vo);
	
	/** 패스워드 갱신 */
	public int updatePassword(UserVo vo);
	
	/** 패스워드 갱신 유예 */
	public int updatePasswordDelay(Integer seq);
	
	/** 이메일/SMS 수신동의 */
	public boolean updateReceiverAgree(MemberVo vo);
	
	public String getFindId(UserVo vo) throws Exception;
	public String getFindIdForSeller(UserVo vo) throws Exception;
	public String getFindIdForAdmin(UserVo vo) throws Exception;
	
	/** 본인인증(아이핀/휴대폰) 키값으로 회원 존재 여부 체크 */
	public int checkCnt(String certKey);
	
	/** 함께누리몰 기회원 개인정보 암호화 대상 리스트 */
	public List<MemberVo> getListForEncrypt();
	
	/** 함께누리몰 기회원 개인정보 암호화 업데이트 */
	public int updateForEncrypt(MemberVo vo) throws Exception;
	
	/** 함께누리몰 기회원 패스워드 암호화 대상 리스트 */
	public List<UserVo> getUserListForEncrypt(String typeCode);
	
	/** 함께누리몰 기회원 패스워드 암호화 업데이트 */
	public int updateUserForEncrypt (UserVo vo) throws Exception;
}
