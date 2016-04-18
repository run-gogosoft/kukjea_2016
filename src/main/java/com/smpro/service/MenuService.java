package com.smpro.service;

import com.smpro.vo.MenuVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MenuService {
	public List<MenuVo> getMainList();
	public List<MenuVo> getSubList(Integer mainSeq);

	public MenuVo getMainVo(Integer seq);
	public MenuVo getSubVo(Integer seq);

	public boolean insertMainVo(MenuVo vo);
	public boolean updateMainVo(MenuVo vo);
	public boolean deleteMainVo(Integer seq);

	public boolean insertSubVo(MenuVo vo);
	public boolean updateSubVo(MenuVo vo);
	public boolean deleteSubVo(Integer seq);

	public boolean modifyMainOrdering(MenuVo vo);

	public boolean modifySubOrdering(MenuVo vo);
	public List<MenuVo> getAllSubList();
	
	public String getSubSeq(String name);
}
