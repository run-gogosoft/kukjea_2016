package com.smpro.dao;

import com.smpro.vo.FilenameVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface FilenameDao {
	public FilenameVo getVo(Map<String, Object> map);
	public FilenameVo getVoBySeq(Integer seq);
	public List<FilenameVo> getList(Map<String, Object> map);
	public int replaceFilename(FilenameVo vo);
	public int deleteVo(FilenameVo vo);
	public int deleteVoBySeq(Integer seq);
}
