package com.smpro.dao;

import com.smpro.vo.UserVo;
import org.springframework.stereotype.Repository;

@Repository
public interface LoginDao {

	public UserVo getData(UserVo vo);

	public UserVo getDataForToken(UserVo vo);

	public int updateData(UserVo vo);

	public UserVo getDataByTempPassword(String uid);

	public int insertAdminAccessLog(UserVo vo);
	
	/** 비회원 로그인(기 주문 여부 확인) */
	public int checkCntInOrder(UserVo pvo);
}
