package com.smpro.service;

import com.smpro.vo.DisplayLvItemVo;
import com.smpro.vo.DisplayVo;

import java.util.List;

public interface DisplayService {
	public DisplayVo getVo(DisplayVo vo);

	public boolean updateData(DisplayVo vo);

	public boolean insertHtmlData(DisplayVo vo);

	public List<DisplayLvItemVo> getLvItemList(DisplayLvItemVo vo);

	public DisplayLvItemVo getLvTitle(DisplayLvItemVo vo);

	public boolean insertData(DisplayLvItemVo vo);

	public String getOrderNoData(DisplayLvItemVo vo);

	public String getItemConfirm(DisplayLvItemVo vo);

	public String getItemListConfirm(DisplayLvItemVo vo);

	public boolean deleteData(Integer seq);

	public boolean updateItemListTitleData(DisplayLvItemVo vo);

	public boolean updateItemListOrderData(DisplayLvItemVo vo);

	public boolean insertDisplayData(DisplayVo vo);

	public boolean insertDisplayItemData(DisplayLvItemVo vo);

}
