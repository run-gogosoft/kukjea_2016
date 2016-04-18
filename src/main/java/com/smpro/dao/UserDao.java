package com.smpro.dao;

import com.smpro.vo.UserVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
	public int insertData(UserVo vo);

	public int updateData(UserVo vo);

	public boolean deleteMall(Integer seq);
	
	public int getIdCnt(UserVo vo);
	
	public int getEmailCnt(UserVo vo);
	
	public int getNickNameCnt(String nickname);
	
	public int updateTempPassword(UserVo vo);
	public int updateTempPasswordForSeller(UserVo vo);
	public int updateTempPasswordForAdmin(UserVo vo);
	
	public String getFindId(UserVo vo);
	public String getFindIdForSeller(UserVo vo);
	public String getFindIdForAdmin(UserVo vo);
	
	/** 패스워드 갱신 */
	public int updatePassword(UserVo vo);
	
	/** 패스워드 갱신 유예 */
	public int updatePasswordDelay(Integer seq);
	
	/** 함께누리몰 기회원 패스워드 암호화 대상 리스트 */
	public List<UserVo> getListForEncrypt(String typeCode);
	
	/** 함께누리몰 기회원 패스워드 암호화 업데이트 */
	public int updateForEncrypt(UserVo vo);
}
