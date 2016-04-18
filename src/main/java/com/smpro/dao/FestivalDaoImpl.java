package com.smpro.dao;

import com.smpro.vo.FestivalVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FestivalDaoImpl implements FestivalDao {
	@Autowired
	private SqlSession sqlSession;

	public List<FestivalVo> getList(FestivalVo vo) {
		return sqlSession.selectList("festival.getList", vo);
	}

	public int getListCount(FestivalVo vo) {
		return Integer.parseInt(String.valueOf(sqlSession.selectOne("festival.getListCount", vo)));
	}

	public FestivalVo getVo(Integer seq) {
		return sqlSession.selectOne("festival.getVo", seq);
	}

	public int createSeq(FestivalVo vo) {
		return sqlSession.update("festival.createSeq", vo);
	}

	public int regVo(FestivalVo vo) {
		return sqlSession.insert("festival.regVo", vo);
	}

	public int modVo(FestivalVo vo) {
		return sqlSession.update("festival.modVo", vo);
	}

	public int delVo(Integer seq) {
		return sqlSession.delete("festival.delVo", seq);
	}

	public List<FestivalVo> getSellerList(FestivalVo vo) {
		return sqlSession.selectList("festival.getSellerList", vo);
	}

	public FestivalVo getSellerVo(FestivalVo vo) {
		return sqlSession.selectOne("festival.getSellerVo", vo);
	}

	public int regSellerVo(FestivalVo vo) {
		return sqlSession.insert("festival.regSellerVo", vo);
	}

	public int modSellerVo(FestivalVo vo) {
		return sqlSession.update("festival.modSellerVo", vo);
	}

	public int delSellerVo(Integer seq) {
		return sqlSession.delete("festival.delSellerVo", seq);
	}
	
}
