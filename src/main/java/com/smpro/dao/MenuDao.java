package com.smpro.dao;

import com.smpro.vo.MenuVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuDao {
	public List<MenuVo> getMainList();
	public List<MenuVo> getSubList(Integer mainSeq);

	public MenuVo getMainVo(Integer seq);
	public MenuVo getSubVo(Integer seq);

	public int insertMainVo(MenuVo vo);
	public int updateMainVo(MenuVo vo);
	public int deleteMainVo(Integer seq);
	public int modifyMainOrdering(MenuVo vo);

	public int insertSubVo(MenuVo vo);
	public int updateSubVo(MenuVo vo);
	public int deleteSubVo(Integer seq);
	public int modifySubOrdering(MenuVo vo);
	public List<MenuVo> getAllSubList();
	public String getSubSeq(String name);
}
