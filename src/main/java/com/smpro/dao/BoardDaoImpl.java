package com.smpro.dao;

import com.smpro.vo.BoardVo;
import com.smpro.vo.MemberVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BoardVo> getList(BoardVo vo) {
		return sqlSession.selectList("board.getList", vo);
	}

	@Override
	public List<BoardVo> getListAll(BoardVo vo) {
		return sqlSession.selectList("board.getListAll", vo);
	}

	@Override
	public int getListCount(BoardVo vo) {
		return ((Integer)sqlSession.selectOne("board.getListCount", vo)).intValue();
	}

	@Override
	public BoardVo getVo(BoardVo vo) {
		return sqlSession.selectOne("board.getVo", vo);
	}
	
	@Override
	public int createSeq(BoardVo vo) {
		return sqlSession.update("board.createSeq", vo);
	}

	@Override
	public int insertData(BoardVo vo) {
		return sqlSession.insert("board.insertData", vo);
	}

	@Override
	public int updateData(BoardVo vo) {
		return sqlSession.update("board.updateData", vo);
	}

	@Override
	public int deleteData(BoardVo vo) {
		return sqlSession.delete("board.deleteData", vo);
	}

	@Override
	public int updateViewCnt(BoardVo vo) {
		return sqlSession.update("board.updateViewCnt", vo);
	}

	@Override
	public Integer getDirectBoardRegCntForWeek(MemberVo vo) {
		return sqlSession.selectOne("board.getDirectBoardRegCntForWeek", vo);
	}

	@Override
	public Integer getItemQnaBoardRegCntForWeek(MemberVo vo) {
		return sqlSession.selectOne("board.getItemQnaBoardRegCntForWeek", vo);
	}

}
