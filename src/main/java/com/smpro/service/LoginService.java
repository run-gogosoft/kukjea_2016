package com.smpro.service;

import com.smpro.vo.UserVo;
import org.springframework.stereotype.Service;

@Service
public interface LoginService {
	/** 로그인 */
	public UserVo getData(UserVo vo);

	/** 세션 유지 자동 로그인 */
	public UserVo getDataForToken(UserVo vo);

	/** 로그인 기록 */
	public int updateData(UserVo vo);

	/**
	 * 임시 비밀번호를 통한 로그인
	 * 
	 * @param uid
	 * @return
	 */
	public UserVo getDataByTempPassword(String uid);

	/** 관리자 접속 로그 */
	public int insertAdminAccessLog(UserVo vo);
	
	/** 비회원 로그인(기 주문 여부 확인) */
	public int checkCntInOrder(UserVo pvo);
}
