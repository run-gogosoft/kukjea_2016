package com.smpro.dao;

import com.smpro.vo.MemberVo;
import com.smpro.vo.ReviewVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReviewVo> getList(ReviewVo vo) {
		return sqlSession.selectList("review.getList", vo);
	}

	@Override
	public int getListCount(ReviewVo vo) {
		return ((Integer)sqlSession.selectOne("review.getListCount", vo)).intValue();
	}

	@Override
	public ReviewVo getVo(ReviewVo vo) {
		return sqlSession.selectOne("review.getVo", vo);
	}

	@Override
	public int insertData(ReviewVo vo) {
		return sqlSession.insert("review.insertData", vo);
	}

	@Override
	public int deleteData(Integer seq) {
		return sqlSession.delete("review.deleteData", seq);
	}

	@Override
	public int updateData(ReviewVo vo) {
		return sqlSession.update("review.updateData", vo);
	}

	@Override
	public Integer getReviewBoardRegCntForWeek(MemberVo vo) {
		return sqlSession.selectOne("review.getReviewBoardRegCntForWeek", vo);
	}
}
