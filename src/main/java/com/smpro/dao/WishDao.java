package com.smpro.dao;

import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WishDao {
	public List<ItemVo> getList(ItemVo vo);

	public int regData(ItemVo vo);

	public int delData(ItemVo vo);

	public int getCnt(ItemVo vo);

	public Integer getWishListCount(Integer memberSeq);
	
	public ItemVo getData(Integer wishSeq);
}
