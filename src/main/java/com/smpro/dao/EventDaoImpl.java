package com.smpro.dao;

import com.smpro.vo.BoardVo;
import com.smpro.vo.EventVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EventDaoImpl implements EventDao {
	@Autowired
	private SqlSession sqlSession;

	public int createSeq(EventVo vo) {
		return sqlSession.update("event.createSeq", vo);
	}

	@Override
	public int insertData(EventVo vo) {
		return sqlSession.insert("event.insertData", vo);
	}

	@Override
	public List<EventVo> getList(EventVo vo) {
		return sqlSession.selectList("event.getList", vo);
	}

	@Override
	public Integer getListCount(EventVo vo) {
		return sqlSession.selectOne("event.getListCount", vo);
	}

	@Override
	public EventVo getVo(EventVo vo) {
		return sqlSession.selectOne("event.getVo", vo);
	}

	@Override
	public int updateData(EventVo vo) {
		return sqlSession.update("event.updateData", vo);
	}

	@Override
	public int deleteData(Integer seq) {
		return sqlSession.delete("event.deleteData", seq);
	}

	@Override
	public List<EventVo> getItemList(EventVo vo) {
		return sqlSession.selectList("event.getItemList", vo);
	}

	@Override
	public String getTitle(EventVo vo) {
		return sqlSession.selectOne("event.getTitle", vo);
	}

	@Override
	public int insertItemListTitleData(EventVo vo) {
		return sqlSession.insert("event.insertItemListTitleData", vo);
	}

	@Override
	public int updateItemListTitleData(EventVo vo) {
		return sqlSession.update("event.updateItemListTitleData", vo);
	}

	@Override
	public String getMaxOrderNo(EventVo vo) {
		return sqlSession.selectOne("event.getMaxOrderNo", vo);
	}

	@Override
	public String getTitleOrderNo(EventVo vo) {
		return sqlSession.selectOne("event.getTitleOrderNo", vo);
	}

	/** 이벤트 상품등록 여부 검사 */
	@Override
	public Integer getEventItemCnt(EventVo vo) {
		return sqlSession.selectOne("event.getEventItemCnt", vo);
	}

	@Override
	public int insertItemData(EventVo vo) {
		return sqlSession.insert("event.insertItemData", vo);
	}

	@Override
	public int deleteItemData(Integer seq) {
		return sqlSession.delete("event.deleteItemData", seq);
	}

	@Override
	public int deleteItemTitleData(Integer seq) {
		return sqlSession.delete("event.deleteItemTitleData", seq);
	}

	@Override
	public List<EventVo> getTitleList(EventVo vo) {
		return sqlSession.selectList("event.getTitleList", vo);
	}

	@Override
	public int updateItemListOrderData(EventVo vo) {
		return sqlSession.update("event.updateItemListOrderData", vo);
	}

	@Override
	public List<EventVo> getLv1List(EventVo vo) {
		return sqlSession.selectList("event.getLv1List", vo);
	}

	@Override
	public int insertComment(BoardVo vo) {
		return sqlSession.insert("event.insertComment", vo);
	}

	@Override
	public int getCommentListCount(BoardVo vo) {
		return ((Integer)sqlSession.selectOne("event.getCommentListCount", vo)).intValue();
	}

	@Override
	public List<BoardVo> getCommentList(BoardVo vo) {
		return sqlSession.selectList("event.getCommentList", vo);
	}

	@Override
	public int deleteCommentVo(Integer seq) {
		return sqlSession.delete("event.deleteCommentVo", seq);
	}
}
