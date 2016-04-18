package com.smpro.service;

import com.smpro.dao.LoginDao;
import com.smpro.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
	@Autowired
	private LoginDao loginDao;

	/** 로그인 */
	public UserVo getData(UserVo vo) {
		return loginDao.getData(vo);
	}

	/** 세션 유지 자동 로그인 */
	public UserVo getDataForToken(UserVo vo) {
		return loginDao.getDataForToken(vo);
	}

	/** 로그인 기록 */
	public int updateData(UserVo vo) {
		return loginDao.updateData(vo);
	}

	/**
	 * 임시 비밀번호를 통한 로그인
	 * 
	 * @param uid
	 * @return
	 */
	public UserVo getDataByTempPassword(String uid) {
		return loginDao.getDataByTempPassword(uid);
	}

	/** 관리자 접속 로그 */
	public int insertAdminAccessLog(UserVo vo) {
		return loginDao.insertAdminAccessLog(vo);
	}

	public int checkCntInOrder(UserVo pvo) {
		return loginDao.checkCntInOrder(pvo);
	}

}
