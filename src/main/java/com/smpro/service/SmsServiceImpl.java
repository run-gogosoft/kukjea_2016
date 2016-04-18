package com.smpro.service;

import com.smpro.dao.SmsDao;
import com.smpro.vo.SmsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SmsServiceImpl implements SmsService {
	@Autowired
	private SmsDao smsDao;

	public List<SmsVo> getList() {
		return smsDao.getList();
	}

	public List<SmsVo> getLogList(SmsVo vo) {
		return smsDao.getLogList(vo);
	}

	public int getLogListCount(SmsVo vo) {
		return smsDao.getLogListCount(vo);
	}

	public SmsVo getVo(Integer seq) {
		return smsDao.getVo(seq);
	}

	public boolean insertVo(SmsVo vo) {
		return smsDao.insertVo(vo) > 0;
	}

	public boolean insertSmsSendVo(SmsVo vo) {
		return smsDao.insertSmsSendVo(vo) > 0;
	}

	public boolean updateVo(SmsVo vo) {
		return smsDao.updateVo(vo) > 0;
	}

	public boolean deleteData(Integer seq) {
		return smsDao.deleteData(seq) > 0;
	}

	public String getContent(SmsVo svo) {
		return smsDao.getContent(svo);
	}
}
