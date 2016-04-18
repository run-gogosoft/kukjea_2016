package com.smpro.dao;

import com.smpro.vo.MallVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MallDao {
	public List<MallVo> getList(MallVo reqVo);

	public List<MallVo> getListSimple();

	public int regVo(MallVo vo);

	public int modVo(MallVo vo);

	public MallVo getVo(Integer seq);

	public MallVo getLoginTmpl(String mallId);

	public MallVo getMainInfo(String mallId);

}
