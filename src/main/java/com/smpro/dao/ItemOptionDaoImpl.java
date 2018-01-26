package com.smpro.dao;

import com.smpro.vo.ItemOptionVo;
import com.smpro.vo.ItemVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ItemOptionDaoImpl implements ItemOptionDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ItemOptionVo> getList(Integer itemSeq) {
		return sqlSession.selectList("option.getList", itemSeq);
	}

	@Override
	public List<ItemOptionVo> getOptionList(Integer itemSeq) {
		return sqlSession.selectList("option.getOptionList", itemSeq);
	}

	@Override
	public List<ItemOptionVo> getValueListForSeller(Map map) {
		return sqlSession.selectList("option.getValueListForSeller", map);
	}

	@Override
	public List<ItemOptionVo> getValueList(Integer optionSeq) {
		return sqlSession.selectList("option.getValueList", optionSeq);
	}

	@Override
	public ItemOptionVo getVo(Integer seq) {
		return sqlSession.selectOne("option.getVo", seq);
	}

	@Override
	public int insertVo(ItemOptionVo vo) {
		return sqlSession.insert("option.insertVo", vo);
	}

	@Override
	public int updateVo(ItemOptionVo vo) {
		return sqlSession.update("option.updateVo", vo);
	}

	@Override
	public int deleteVo(Integer seq) {
		return sqlSession.delete("option.deleteVo", seq);
	}

	@Override
	public ItemOptionVo getValueVo(Integer seq) {
		return sqlSession.selectOne("option.getValueVo", seq);
	}

	@Override
	public int insertValueVo(ItemOptionVo vo) {

		System.out.println(">>>vo.:"+vo.toString());
		return sqlSession.insert("option.insertValueVo", vo);
	}

	@Override
	public int updateValueVo(ItemOptionVo vo) {
		return sqlSession.update("option.updateValueVo", vo);
	}

	@Override
	public int popStock(ItemOptionVo vo) {
		return sqlSession.update("option.popStock", vo);
	}

	@Override
	public int deleteValueVo(Integer seq) {
		return sqlSession.delete("option.deleteValueVo", seq);
	}

	@Override
	public int deleteValueVoApi(Integer seq) {
		return sqlSession.delete("option.deleteValueVoApi", seq);
	}

	@Override
	public ItemOptionVo getStockFlag(ItemVo vo) {
		return sqlSession.selectOne("option.getStockFlag", vo);
	}

	@Override
	public Integer getSeq(Integer seq) {

		Integer optionSeq =  sqlSession.selectOne("option.getSeq", seq);
		if(optionSeq == null) return -1;
		return optionSeq;
	}
}
