package com.smpro.service;

import com.smpro.vo.CategoryVo;
import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface CategoryService {
	public List<CategoryVo> getList(CategoryVo vo);

	public List<CategoryVo> getListSimple(CategoryVo vo);

	public List<CategoryVo> getListForSearch(ItemVo vo);

	public CategoryVo getVo(Integer seq);

	public CategoryVo getVoByName(Map name);

	public boolean insertVo(CategoryVo vo);

	public boolean updateVo(CategoryVo vo);

	public boolean updateOrderNo(CategoryVo vo);

	public boolean deleteVo(Integer seq) throws Exception;

	public String getFirstDepthSeq(CategoryVo vo);

	/**
	 * 카테고리의 json 파일을 생성한다
	 * 
	 * @param targetPath
	 *            생성할 js 파일의 목적지
	 * @throws Exception
	 */
	public void createJs(String targetPath) throws Exception;

	public Integer getLv1Value(Integer seq);

	public Integer getLv2Value(Integer seq);
}
