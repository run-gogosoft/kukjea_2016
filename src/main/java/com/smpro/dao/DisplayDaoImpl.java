package com.smpro.dao;

import com.smpro.vo.DisplayLvItemVo;
import com.smpro.vo.DisplayVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DisplayDaoImpl implements DisplayDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public DisplayVo getVo(DisplayVo vo) {
		return sqlSession.selectOne("display.getVo", vo);
	}

	@Override
	public int updateData(DisplayVo vo) {
		return sqlSession.update("display.updateData", vo);
	}

	@Override
	public int insertHtmlData(DisplayVo vo) {
		return sqlSession.insert("display.insertHtmlData", vo);
	}

	@Override
	public List<DisplayLvItemVo> getLvItemList(DisplayLvItemVo vo) {
		return sqlSession.selectList("display.getLvItemList", vo);
	}

	@Override
	public DisplayLvItemVo getLvTitle(DisplayLvItemVo vo) {
		return sqlSession.selectOne("display.getLvTitle", vo);
	}

	@Override
	public int insertData(DisplayLvItemVo vo) {
		return sqlSession.insert("display.insertData", vo);
	}

	@Override
	public String getOrderNoData(DisplayLvItemVo vo) {
		return sqlSession.selectOne("display.getOrderNo", vo);
	}

	@Override
	public String getItemConfirm(DisplayLvItemVo vo) {
		return sqlSession.selectOne("display.getItemConfirm", vo);
	}

	@Override
	public String getItemListConfirm(DisplayLvItemVo vo) {
		return sqlSession.selectOne("display.getItemListConfirm", vo);
	}

	@Override
	public int deleteData(Integer seq) {
		return sqlSession.delete("display.deleteData", seq);
	}

	@Override
	public int updateItemListTitleData(DisplayLvItemVo vo) {
		return sqlSession.update("display.updateItemListTitleData", vo);
	}

	@Override
	public int updateItemListOrderData(DisplayLvItemVo vo) {
		return sqlSession.update("display.updateItemListOrderData", vo);
	}

	@Override
	public int insertDisplayData(DisplayVo vo) {
		return sqlSession.insert("display.insertDisplayData", vo);
	}

	@Override
	public int insertDisplayItemData(DisplayLvItemVo vo) {
		return sqlSession.insert("display.insertDisplayItemData", vo);
	}
}
