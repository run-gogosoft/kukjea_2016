package com.smpro.service;

import com.smpro.dao.FestivalDao;
import com.smpro.util.StringUtil;
import com.smpro.vo.FestivalVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FestivalServiceImpl implements FestivalService {
	@Autowired
	private FestivalDao festivalDao;

	public List<FestivalVo> getList(FestivalVo vo) {
		return festivalDao.getList(vo);
	}

	public int getListCount(FestivalVo vo) {
		return festivalDao.getListCount(vo);
	}

	public FestivalVo getVo(Integer seq) {
		FestivalVo vo = festivalDao.getVo(seq);
		if(vo != null) {
			vo.setContent(StringUtil.restoreClearXSS(vo.getContent()));
		}
		return vo;
	}

	
	public int createSeq(FestivalVo vo) {
		return festivalDao.createSeq(vo);
	}

	public int regVo(FestivalVo vo) {
		return festivalDao.regVo(vo);
	}

	public int modVo(FestivalVo vo) {
		return festivalDao.modVo(vo);
	}

	public int delVo(Integer seq) {
		return festivalDao.delVo(seq);
	}

	public List<FestivalVo> getSellerList(FestivalVo vo) {
		return festivalDao.getSellerList(vo);
	}

	public FestivalVo getSellerVo(FestivalVo vo) {
		return festivalDao.getSellerVo(vo);
	}

	public int regSellerVo(FestivalVo vo) {
		return festivalDao.regSellerVo(vo);
	}

	public int modSellerVo(FestivalVo vo) {
		return festivalDao.modSellerVo(vo);
	}

	public int delSellerVo(Integer seq) {
		return festivalDao.delSellerVo(seq);
	}


}
