package com.smpro.service;

import com.smpro.dao.MenuDao;
import com.smpro.vo.MenuVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	@Resource(name="menuDao")
	private MenuDao menuDao;

	public List<MenuVo> getMainList() {
		return menuDao.getMainList();
	}
	public List<MenuVo> getSubList(Integer mainSeq) {
		return menuDao.getSubList(mainSeq);
	}

	public MenuVo getMainVo(Integer seq) {
		return menuDao.getMainVo(seq);
	}
	public MenuVo getSubVo(Integer seq) {
		return menuDao.getSubVo(seq);
	}

	public boolean insertMainVo(MenuVo vo) {
		return menuDao.insertMainVo(vo) > 0;
	}
	public boolean updateMainVo(MenuVo vo) {
		return menuDao.updateMainVo(vo) > 0;
	}
	public boolean deleteMainVo(Integer seq) {
		return menuDao.deleteMainVo(seq) > 0;
	}

	public boolean insertSubVo(MenuVo vo) {
		return menuDao.insertSubVo(vo) > 0;
	}
	public boolean updateSubVo(MenuVo vo) {
		return menuDao.updateSubVo(vo) > 0;
	}
	public boolean deleteSubVo(Integer seq) {
		return menuDao.deleteSubVo(seq) > 0;
	}

	public boolean modifyMainOrdering(MenuVo vo) {
		return menuDao.modifyMainOrdering(vo) > 0;
	}

	public boolean modifySubOrdering(MenuVo vo) {
		return menuDao.modifySubOrdering(vo) > 0;
	}

	public List<MenuVo> getAllSubList() {
		return menuDao.getAllSubList();
	}
	@Override
	public String getSubSeq(String name) {
		return menuDao.getSubSeq(name);
	}
}
