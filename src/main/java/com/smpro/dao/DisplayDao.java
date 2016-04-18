package com.smpro.dao;

import com.smpro.vo.DisplayLvItemVo;
import com.smpro.vo.DisplayVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DisplayDao {
	// 대분류 HTML
	public DisplayVo getVo(DisplayVo vo);

	public int updateData(DisplayVo vo);

	public int insertHtmlData(DisplayVo vo);

	// 대분류 ITEM
	public List<DisplayLvItemVo> getLvItemList(DisplayLvItemVo vo);

	// 대분류 타이틀
	public DisplayLvItemVo getLvTitle(DisplayLvItemVo vo);

	// 대분류 아이템 저장
	public int insertData(DisplayLvItemVo vo);

	// 대분류 order_no 최대값 가져오기
	public String getOrderNoData(DisplayLvItemVo vo);

	// 대분류 아이템 존재 여부 판단 및 중복검사
	public String getItemConfirm(DisplayLvItemVo vo);

	public String getItemListConfirm(DisplayLvItemVo vo);

	public int deleteData(Integer seq);

	public int updateItemListTitleData(DisplayLvItemVo vo);

	public int updateItemListOrderData(DisplayLvItemVo vo);

	// 카테고리가 추가되면 대분류 페이지 관련데이터 자동 추가
	public int insertDisplayData(DisplayVo vo);

	public int insertDisplayItemData(DisplayLvItemVo vo);
}