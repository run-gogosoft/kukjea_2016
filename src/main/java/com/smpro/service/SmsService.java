package com.smpro.service;

import com.smpro.vo.SmsVo;

import java.util.List;

public interface SmsService {

	public List<SmsVo> getList();

	public List<SmsVo> getLogList(SmsVo vo);

	public int getLogListCount(SmsVo vo);

	public SmsVo getVo(Integer seq);

	public boolean insertVo(SmsVo vo);

	public boolean insertSmsSendVo(SmsVo vo);

	public boolean updateVo(SmsVo vo);

	public boolean deleteData(Integer seq);

	public String getContent(SmsVo svo);
}
