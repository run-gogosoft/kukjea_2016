package com.smpro.service;

import com.smpro.dao.DisplayDao;
import com.smpro.util.StringUtil;
import com.smpro.vo.DisplayLvItemVo;
import com.smpro.vo.DisplayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DisplayServiceImpl implements DisplayService {
	@Autowired
	private DisplayDao displayDao;

	public DisplayVo getVo(DisplayVo vo) {
		DisplayVo dvo = displayDao.getVo(vo);
		if (dvo != null) {
			dvo.setContent(StringUtil.restoreClearXSS(dvo.getContent()));
			// 스크립트 replace
			dvo.setContent(dvo.getContent().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		}
		return dvo;
	}

	public boolean updateData(DisplayVo vo) {
		vo.setContent(StringUtil.restoreClearXSS(vo.getContent()));
		return displayDao.updateData(vo) > 0;
	}

	public boolean insertHtmlData(DisplayVo vo) {
		vo.setContent(StringUtil.restoreClearXSS(vo.getContent()));
		return displayDao.insertHtmlData(vo) > 0;
	}

	public List<DisplayLvItemVo> getLvItemList(DisplayLvItemVo vo) {
		return displayDao.getLvItemList(vo);
	}

	public DisplayLvItemVo getLvTitle(DisplayLvItemVo vo) {
		return displayDao.getLvTitle(vo);
	}

	public boolean insertData(DisplayLvItemVo vo) {
		return displayDao.insertData(vo) > 0;
	}

	public String getOrderNoData(DisplayLvItemVo vo) {
		return displayDao.getOrderNoData(vo);
	}

	public String getItemConfirm(DisplayLvItemVo vo) {
		return displayDao.getItemConfirm(vo);
	}

	public String getItemListConfirm(DisplayLvItemVo vo) {
		return displayDao.getItemListConfirm(vo);
	}

	public boolean deleteData(Integer seq) {
		return displayDao.deleteData(seq) > 0;
	}

	public boolean updateItemListTitleData(DisplayLvItemVo vo) {
		return displayDao.updateItemListTitleData(vo) > 0;
	}

	public boolean updateItemListOrderData(DisplayLvItemVo vo) {
		return displayDao.updateItemListOrderData(vo) > 0;
	}

	public boolean insertDisplayData(DisplayVo vo) {
		return displayDao.insertDisplayData(vo) > 0;
	}

	public boolean insertDisplayItemData(DisplayLvItemVo vo) {
		return displayDao.insertDisplayItemData(vo) > 0;
	}

}
