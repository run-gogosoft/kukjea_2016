package com.smpro.dao;

import com.smpro.vo.FilenameVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class FilenameDaoImpl implements FilenameDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public FilenameVo getVo(Map<String, Object> map) {
		return sqlSession.selectOne("filename.getVo", map);
	}
	
	@Override
	public FilenameVo getVoBySeq(Integer seq) {
		return sqlSession.selectOne("filename.getVoBySeq", seq);
	}

	@Override
	public List<FilenameVo> getList(Map<String, Object> map) {
		return sqlSession.selectList("filename.getList", map);
	}

	@Override
	public int replaceFilename(FilenameVo vo) {
		return sqlSession.insert("filename.replaceFilename", vo);
	}

	@Override
	public int deleteVo(FilenameVo vo) {
		return sqlSession.delete("filename.deleteVo", vo);
	}
	
	@Override
	public int deleteVoBySeq(Integer seq) {
		return sqlSession.delete("filename.deleteVoBySeq", seq);
	}
}
