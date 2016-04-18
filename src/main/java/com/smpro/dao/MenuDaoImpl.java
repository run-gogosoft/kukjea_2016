package com.smpro.dao;

import com.smpro.vo.MenuVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MenuDaoImpl implements MenuDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MenuVo> getMainList() {
		return sqlSession.selectList("menu.getMainList");
	}

	@Override
	public List<MenuVo> getSubList(Integer mainSeq) {
		return sqlSession.selectList("menu.getSubList", mainSeq);
	}

	@Override
	public MenuVo getMainVo(Integer seq) {
		return sqlSession.selectOne("menu.getMainVo", seq);
	}

	@Override
	public MenuVo getSubVo(Integer seq) {
		return sqlSession.selectOne("menu.getSubVo", seq);
	}

	@Override
	public int insertMainVo(MenuVo vo) {
		return sqlSession.insert("menu.insertMainVo", vo);
	}

	@Override
	public int updateMainVo(MenuVo vo) {
		return sqlSession.update("menu.updateMainVo", vo);
	}

	@Override
	public int deleteMainVo(Integer seq) {
		return sqlSession.delete("menu.deleteMainVo", seq);
	}

	@Override
	public int insertSubVo(MenuVo vo) {
		return sqlSession.insert("menu.insertSubVo", vo);
	}

	@Override
	public int updateSubVo(MenuVo vo) {
		return sqlSession.update("menu.updateSubVo", vo);
	}

	@Override
	public int deleteSubVo(Integer seq) {
		return sqlSession.delete("menu.deleteSubVo", seq);
	}


	@Override
	public int modifyMainOrdering(MenuVo vo) {
		return sqlSession.update("menu.modifyMainOrdering", vo);
	}

	@Override
	public int modifySubOrdering(MenuVo vo) {
		return sqlSession.update("menu.modifySubOrdering", vo);
	}

	@Override
	public List<MenuVo> getAllSubList() {
		return sqlSession.selectList("menu.getAllSubList");
	}

	@Override
	public String getSubSeq(String name) {
		return sqlSession.selectOne("menu.getSubSeq", name);
	}
}
