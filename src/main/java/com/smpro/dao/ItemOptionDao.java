package com.smpro.dao;

import com.smpro.vo.ItemOptionVo;
import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ItemOptionDao {
	public List<ItemOptionVo> getList(Integer itemSeq);

	public ItemOptionVo getVo(Integer seq);

	public ItemOptionVo getValueVo(Integer seq);

	public List<ItemOptionVo> getOptionList(Integer itemSeq);

	List<ItemOptionVo> getValueListForSeller(Map map);

	public List<ItemOptionVo> getValueList(Integer optionSeq);

	public int insertVo(ItemOptionVo vo);

	public int updateVo(ItemOptionVo vo);

	public int deleteVo(Integer seq);

	public int insertValueVo(ItemOptionVo vo);

	public int updateValueVo(ItemOptionVo vo);

	public int popStock(ItemOptionVo vo);

	public int deleteValueVo(Integer seq);

	public int deleteValueVoApi(Integer seq);

	// 상품 옵션 재고관리 여부 가져오기
	public ItemOptionVo getStockFlag(ItemVo vo);

	public Integer getSeq(Integer seq);
}
