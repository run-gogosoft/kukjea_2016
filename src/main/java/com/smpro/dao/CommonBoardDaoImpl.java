package com.smpro.dao;

import com.smpro.vo.CommonBoardVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommonBoardDaoImpl implements CommonBoardDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getListCount(CommonBoardVo vo) {
		return ((Integer)sqlSession.selectOne("commonBoard.getListCount", vo)).intValue();
	}

	@Override
	public List<CommonBoardVo> getList(CommonBoardVo vo) {
		return sqlSession.selectList("commonBoard.getList", vo);
	}
	
	@Override
	public int getDetailListCount(CommonBoardVo vo) {
		return ((Integer)sqlSession.selectOne("commonBoard.getDetailListCount", vo)).intValue();
	}
	
	@Override
	public List<CommonBoardVo> getDetailList(CommonBoardVo vo) {
		return sqlSession.selectList("commonBoard.getDetailList", vo);
	}

	@Override
	public CommonBoardVo getVo(Integer seq) {
		return sqlSession.selectOne("commonBoard.getVo", seq);
	}
	
	@Override
	public CommonBoardVo getDetailVo(Integer seq) {
		return sqlSession.selectOne("commonBoard.getDetailVo", seq);
	}

	@Override
	public int createSeq(CommonBoardVo vo) {
		return sqlSession.update("commonBoard.createSeq", vo);
	}

	@Override
	public int insertVo(CommonBoardVo vo) {
		return sqlSession.insert("commonBoard.insertVo", vo);
	}

	@Override
	public int updateVo(CommonBoardVo vo) {
		return sqlSession.update("commonBoard.updateVo", vo);
	}

	@Override
	public int updateViewCnt(Integer seq) {
		return sqlSession.update("commonBoard.updateViewCnt", seq);
	}

	@Override
	public int getPasswordCnt(CommonBoardVo vo) {
		return ((Integer)sqlSession.selectOne("commonBoard.getPasswordCnt", vo)).intValue();
	}

	@Override
	public int deleteContentVo(CommonBoardVo vo) {
		return sqlSession.delete("commonBoard.deleteContentVo", vo);
	}

	@Override
	public int insertCommonVo(CommonBoardVo vo) {
		return sqlSession.insert("commonBoard.insertCommonVo", vo);
	}
	
	@Override
	public int updateCommonVo(CommonBoardVo vo) {
		return sqlSession.update("commonBoard.updateCommonVo", vo);
	}

	@Override
	public int deleteCommonVo(Integer seq) {
		return sqlSession.delete("commonBoard.deleteCommonVo", seq);
	}

	@Override
	public List<CommonBoardVo> getCommentList(CommonBoardVo vo) {
		return sqlSession.selectList("commonBoard.getCommentList", vo);
	}

	@Override
	public int getCommentListTotalCount(CommonBoardVo vo) {
		return Integer.parseInt((String.valueOf(sqlSession.selectOne("commonBoard.getCommentListTotalCount", vo))));
	}

	@Override
	public CommonBoardVo getComment(Integer seq) {
		return sqlSession.selectOne("commonBoard.getComment", seq);
	}

	@Override
	public int insertComment(CommonBoardVo vo) {
		return sqlSession.insert("commonBoard.insertComment", vo);
	}

	@Override
	public int updateComment(CommonBoardVo vo) {
		return sqlSession.update("commonBoard.updateComment", vo);
	}

	@Override
	public int deleteComment(Integer seq) {
		return sqlSession.delete("commonBoard.deleteComment", seq);
	}
}
