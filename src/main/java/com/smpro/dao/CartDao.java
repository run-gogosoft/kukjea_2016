package com.smpro.dao;

import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartDao {
	public List<ItemVo> getList(ItemVo vo);

	public Integer getListTotalCount(ItemVo vo);

	public ItemVo getVo(ItemVo vo);

	public int insertVo(ItemVo vo);

	public int updateVo(ItemVo vo);

	public int deleteVo(ItemVo vo);
	
	/** 장바구니 자동 삭제 */
	public int deleteBatch();
}
