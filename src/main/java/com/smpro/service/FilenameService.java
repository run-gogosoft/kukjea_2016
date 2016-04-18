package com.smpro.service;

import com.smpro.vo.FilenameVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface FilenameService {
	public FilenameVo getVo(Map<String, Object> map);
	public FilenameVo getVo(Integer seq);
	public List<FilenameVo> getList(Map<String, Object> map);
	public boolean replaceFilename(FilenameVo vo);
	public boolean deleteVo(FilenameVo vo);
	public boolean deleteVo(Integer seq);
}
