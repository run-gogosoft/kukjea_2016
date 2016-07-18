package com.smpro.dao;

import com.smpro.vo.CategoryVo;
import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface CategoryDao {
	public List<CategoryVo> getList(CategoryVo vo);

	public List<CategoryVo> getListSimple(CategoryVo vo);

	public List<CategoryVo> getListForSearch(ItemVo vo);

	public CategoryVo getVo(Integer seq);

	public CategoryVo getVoByName(Map name);

	public int insertVo(CategoryVo vo);

	public int updateVo(CategoryVo vo);

	public int updateOrderNo(CategoryVo vo);

	public int deleteVo(Integer seq);

	public String getFirstDepthSeq(CategoryVo vo);

	public Integer getLv1Value(Integer seq);

	public Integer getLv2Value(Integer seq);
}
