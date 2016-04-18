package com.smpro.service;

import com.smpro.vo.MallVo;

import java.util.List;

public interface MallService {
	public List<MallVo> getList(MallVo reqVo);

	public List<MallVo> getListSimple();

	public MallVo getVo(Integer seq);

	public MallVo getLoginTmpl(String mallId);

	public MallVo getMainInfo(String mallId);

	public boolean regVo(MallVo vo) throws Exception;

	public boolean modVo(MallVo vo) throws Exception;

	public boolean deleteMall(Integer seq);

}
