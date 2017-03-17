package com.smpro.dao;

import com.smpro.vo.BoardVo;
import com.smpro.vo.EventVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventDao {

	public List<EventVo> getList(EventVo vo);

	public Integer getListCount(EventVo vo);

	public EventVo getVo(EventVo vo);

	public int createSeq(EventVo vo);
	
	public int insertData(EventVo vo);

	public int updateData(EventVo vo);

	public int deleteData(Integer seq);

	public int deleteItemData(Integer seq);

	public int deleteItemTitleData(Integer seq);

	public List<EventVo> getItemList(EventVo vo);

	public List<EventVo> getTitleList(EventVo vo);

	public String getTitle(EventVo vo);

	public int insertItemListTitleData(EventVo vo);

	public int updateItemListTitleData(EventVo vo);

	public String getMaxOrderNo(EventVo vo);

	public String getTitleOrderNo(EventVo vo);

	public int insertItemData(EventVo vo);

	/** 이벤트 상품등록 여부 검사 */
	public Integer getEventItemCnt(EventVo vo);

	public int updateItemListOrderData(EventVo vo);

	public List<EventVo> getLv1List(EventVo vo);
	
	public int insertComment(BoardVo vo);
	
	public int getCommentListCount(BoardVo vo);
	
	public List<BoardVo> getCommentList(BoardVo vo);
	
	public int deleteCommentVo(Integer seq);
}
