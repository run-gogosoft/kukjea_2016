package com.smpro.service;

import com.smpro.dao.MenuDao;
import com.smpro.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {
	@Autowired
	private MenuDao menuDao;

	@Override
	public List<MenuVo> getMainList() {
		return menuDao.getMainList();
	}
	@Override
	public List<MenuVo> getSubList(Integer mainSeq) {
		return menuDao.getSubList(mainSeq);
	}

	@Override
	public MenuVo getMainVo(Integer seq) {
		return menuDao.getMainVo(seq);
	}
	@Override
	public MenuVo getSubVo(Integer seq) {
		return menuDao.getSubVo(seq);
	}

	@Override
	public boolean insertMainVo(MenuVo vo) {
		return menuDao.insertMainVo(vo) > 0;
	}
	@Override
	public boolean updateMainVo(MenuVo vo) {
		return menuDao.updateMainVo(vo) > 0;
	}
	@Override
	public boolean deleteMainVo(Integer seq) {
		return menuDao.deleteMainVo(seq) > 0;
	}

	@Override
	public boolean insertSubVo(MenuVo vo) {
		return menuDao.insertSubVo(vo) > 0;
	}
	@Override
	public boolean updateSubVo(MenuVo vo) {
		return menuDao.updateSubVo(vo) > 0;
	}
	@Override
	public boolean deleteSubVo(Integer seq) {
		return menuDao.deleteSubVo(seq) > 0;
	}

	@Override
	public boolean modifyMainOrdering(MenuVo vo) {
		return menuDao.modifyMainOrdering(vo) > 0;
	}

	@Override
	public boolean modifySubOrdering(MenuVo vo) {
		return menuDao.modifySubOrdering(vo) > 0;
	}
	@Override
	public List<MenuVo> getAllSubList() {
		return menuDao.getAllSubList();
	}
	@Override
	public String getSubSeq(String name) {
		return menuDao.getSubSeq(name);
	}
}
