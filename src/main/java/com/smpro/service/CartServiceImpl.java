package com.smpro.service;

import com.smpro.dao.CartDao;
import com.smpro.vo.ItemVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDao cartDao;

	public List<ItemVo> getList(ItemVo vo) {
		return cartDao.getList(vo);
	}

	public Integer getListTotalCount(ItemVo vo) {
		return cartDao.getListTotalCount(vo);
	}

	public ItemVo getVo(ItemVo vo) {
		return cartDao.getVo(vo);
	}

	public boolean insertVo(ItemVo vo) {
		return cartDao.insertVo(vo) > 0;
	}

	public boolean updateVo(ItemVo vo) {
		return cartDao.updateVo(vo) > 0;
	}

	public boolean deleteVo(ItemVo vo) {
		return cartDao.deleteVo(vo) > 0;
	}

	public void deleteVo(List<ItemVo> list) {
		for (int i = 0; i < list.size(); i++) {
			cartDao.deleteVo(list.get(i));
		}
	}

	public int deleteBatch() {
		return cartDao.deleteBatch();
	}
}
