package com.smpro.dao;

import com.smpro.vo.SmsVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SmsDao {
	public List<SmsVo> getList();

	public List<SmsVo> getLogList(SmsVo vo);

	public int getLogListCount(SmsVo vo);

	public SmsVo getVo(Integer seq);

	public int insertVo(SmsVo vo);

	public int insertSmsSendVo(SmsVo vo);

	public int updateVo(SmsVo vo);

	public int deleteData(Integer seq);

	public String getContent(SmsVo svo);
}
