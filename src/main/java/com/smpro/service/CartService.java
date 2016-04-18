package com.smpro.service;

import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CartService {
	public List<ItemVo> getList(ItemVo vo);

	public Integer getListTotalCount(ItemVo vo);

	public ItemVo getVo(ItemVo vo);

	public boolean insertVo(ItemVo vo);

	public boolean updateVo(ItemVo vo);

	public boolean deleteVo(ItemVo vo);

	public void deleteVo(List<ItemVo> list);
	
	/** 장바구니 자동 삭제 */
	public int deleteBatch();
	
}
