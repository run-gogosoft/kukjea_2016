package com.smpro.service;

import com.smpro.vo.ItemOptionVo;
import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface ItemOptionService {
	public List<ItemOptionVo> getList(Integer itemSeq);

	public List<ItemOptionVo> getOptionList(Integer itemSeq);

	List<ItemOptionVo> getValueListForSeller(Map map);

	public List<ItemOptionVo> getValueList(Integer optionSeq);

	public ItemOptionVo getVo(Integer seq);

	public ItemOptionVo getValueVo(Integer seq);

	public boolean insertVo(ItemOptionVo vo);

	public boolean updateVo(ItemOptionVo vo);

	public boolean deleteVo(Integer seq);

	public boolean insertValueVo(ItemOptionVo vo);

	public boolean updateValueVo(ItemOptionVo vo);

	public boolean popStock(ItemOptionVo vo);

	public boolean deleteValueVo(Integer seq);

	// 재고 수량을 감소시킨다
	public void popStock(List<ItemVo> list);

	// 재고 수량을 감소시킨다(옵션값으로 건별 매칭)
	public void popStock(Integer ItemSeq, String optionValueName, int orderCnt);

	public Integer getSeq(Integer seq);
}
