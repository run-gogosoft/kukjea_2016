package com.smpro.service;

import java.util.List;

import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Service;

@Service
public interface WishService {
	/** 리스트 */
	public List<ItemVo> getList(ItemVo vo);

	/** 일괄 등록 */
	public int regData(Integer[] wishSeq, Integer memberSeq, Integer optionValueSeq, String deliPrepaidFlag);

	/** 등록 */
	public boolean regData(ItemVo vo);

	/** 일괄 삭제 */
	public int delData(int[] wishSeq, Integer memberSeq);

	/** 삭제 */
	public boolean delData(ItemVo vo);

	/** 일괄 체크 */
	public int getCnt(Integer[] wishSeq, Integer memberSeq, Integer optionValueSeq);

	public Integer getWishListCount(Integer memberSeq);
	
	public ItemVo getData(Integer wishSeq);
}
