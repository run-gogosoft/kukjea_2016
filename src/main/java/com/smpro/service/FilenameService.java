package com.smpro.service;

import java.util.List;
import java.util.Map;

import com.smpro.vo.FilenameVo;

public interface FilenameService {
	public FilenameVo getVo(Map<String, Object> map);
	public FilenameVo getVo(Integer seq);
	public List<FilenameVo> getList(Map<String, Object> map);
	public boolean replaceFilename(FilenameVo vo);
	public boolean deleteVo(FilenameVo vo);
	public boolean deleteVo(Integer seq);
}
