package com.smpro.service;

import com.smpro.dao.FilenameDao;
import com.smpro.vo.FilenameVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class FilenameServiceImpl implements FilenameService {
	@Autowired
	private FilenameDao filenameDao;

	@Override
	public FilenameVo getVo(Map<String, Object> map) {
		return filenameDao.getVo(map);
	}
	
	@Override
	public FilenameVo getVo(Integer seq) {
		return filenameDao.getVoBySeq(seq);
	}

	@Override
	public List<FilenameVo> getList(Map<String, Object> map) {
		return filenameDao.getList(map);
	}

	@Override
	public boolean replaceFilename(FilenameVo vo) {
		return filenameDao.replaceFilename(vo) > 0;
	}

	@Override
	public boolean deleteVo(FilenameVo vo) {
		return filenameDao.deleteVo(vo) > 0;
	}
	
	@Override
	public boolean deleteVo(Integer seq) {
		return filenameDao.deleteVoBySeq(seq) > 0;
	}
}
