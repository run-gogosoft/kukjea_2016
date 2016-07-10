package com.smpro.service;

import com.smpro.dao.ItemDao;
import com.smpro.dao.ItemOptionDao;
import com.smpro.vo.ItemOptionVo;
import com.smpro.vo.ItemVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ItemOptionServiceImpl implements ItemOptionService {
	@Autowired
	private ItemOptionDao itemOptionDao;

	@Autowired
	private ItemDao itemDao;

	public List<ItemOptionVo> getList(Integer itemSeq) {
		return itemOptionDao.getList(itemSeq);
	}

	public List<ItemOptionVo> getOptionList(Integer itemSeq) {
		return itemOptionDao.getOptionList(itemSeq);
	}

	@Override
	public List<ItemOptionVo> getValueListForSeller(Map map) {
		return itemOptionDao.getValueListForSeller(map);
	}

	public List<ItemOptionVo> getValueList(Integer optionSeq) {
		return itemOptionDao.getValueList(optionSeq);
	}

	public ItemOptionVo getVo(Integer seq) {
		return itemOptionDao.getVo(seq);
	}

	public ItemOptionVo getValueVo(Integer seq) {
		return itemOptionDao.getValueVo(seq);
	}

	public boolean insertVo(ItemOptionVo vo) {
		return itemOptionDao.insertVo(vo) > 0;
	}

	public boolean updateVo(ItemOptionVo vo) {
		return itemOptionDao.updateVo(vo) > 0;
	}

	public boolean deleteVo(Integer seq) {
		return itemOptionDao.deleteVo(seq) > 0;
	}

	public boolean insertValueVo(ItemOptionVo vo) {
		return itemOptionDao.insertValueVo(vo) > 0;
	}

	public boolean updateValueVo(ItemOptionVo vo) {
		return itemOptionDao.updateValueVo(vo) > 0;
	}

	public boolean popStock(ItemOptionVo vo) {
		return itemOptionDao.popStock(vo) > 0;
	}

	public boolean deleteValueVo(Integer seq) {
		return itemOptionDao.deleteValueVo(seq) > 0;
	}

	// 재고 수량을 감소시킨다(재고관리 하는 상품에만 수량 차감)
	public void popStock(List<ItemVo> list) {
		for (int i = 0; i < list.size(); i++) {
			if("Y".equals(list.get(i).getStockFlag())) {
				ItemOptionVo optionVo = new ItemOptionVo();
				optionVo.setSeq(list.get(i).getOptionValueSeq());
				optionVo.setCount(list.get(i).getCount());
				itemOptionDao.popStock(optionVo);
			}
		}
	}

	// 재고 수량을 감소시킨다(옵션값으로 건별 매칭)
	public void popStock(Integer ItemSeq, String optionValueName, int orderCnt) {
		ItemVo ivo = new ItemVo();
		ivo.setItemSeq(ItemSeq);
		ivo.setOptionValues(optionValueName);
		ItemOptionVo vo = itemOptionDao.getStockFlag(ivo);
		if (vo != null) {
			vo.setCount(orderCnt);
			itemOptionDao.popStock(vo);
		}
	}

	public Integer getSeq(Integer seq) {
		return itemOptionDao.getSeq(seq);
	}
}
