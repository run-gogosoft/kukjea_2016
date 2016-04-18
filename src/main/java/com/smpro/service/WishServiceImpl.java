package com.smpro.service;

import com.smpro.dao.WishDao;
import com.smpro.vo.ItemVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WishServiceImpl implements WishService {
	@Autowired
	private WishDao wishDao;

	/** 리스트 */
	@Override
	public List<ItemVo> getList(ItemVo vo) {
		return wishDao.getList(vo);
	}

	/** 일괄 등록 */
	public int regData(Integer[] wishSeq, Integer memberSeq, Integer optionValueSeq, String deliPrepaidFlag) {
		int result = 0;
		for (Integer seq : wishSeq) {
			ItemVo vo = new ItemVo();
			vo.setItemSeq(seq);
			vo.setMemberSeq(memberSeq);
			vo.setOptionValueSeq(optionValueSeq);
			vo.setDeliPrepaidFlag(deliPrepaidFlag);

			/* 중복된 상품이 있으면 제외하고 위시리스트에 등록 */
			if (getCnt(vo) == 0) {
				if (regData(vo)) {
					result++;
				}
			}
		}
		return result;
	}

	/** 등록 */
	public boolean regData(ItemVo vo) {
		return wishDao.regData(vo) > 0;
	}

	/** 일괄 삭제 */
	public int delData(int[] wishSeq, Integer memberSeq) {
		int result = 0;
		for (int seq : wishSeq) {
			ItemVo vo = new ItemVo();
			vo.setWishSeq(seq);
			vo.setMemberSeq(memberSeq);
			if (delData(vo)) {
				result++;
			}
		}
		return result;
	}

	/** 삭제 */
	public boolean delData(ItemVo vo) {
		return wishDao.delData(vo) > 0;
	}

	/** 일괄 체크 */
	public int getCnt(Integer[] wishSeq, Integer memberSeq, Integer optionValueSeq) {
		int result = 0;
		for (Integer seq : wishSeq) {
			ItemVo vo = new ItemVo();
			vo.setItemSeq(seq);
			vo.setMemberSeq(memberSeq);
			vo.setOptionValueSeq(optionValueSeq);
			result += getCnt(vo);
		}
		return result;
	}

	/** 중복 체크 */
	private int getCnt(ItemVo vo) {
		return wishDao.getCnt(vo);
	}

	public Integer getWishListCount(Integer memberSeq) {
		return wishDao.getWishListCount(memberSeq);
	}
	
	public ItemVo getData(Integer wishSeq) {
		return wishDao.getData(wishSeq);
	}
}
