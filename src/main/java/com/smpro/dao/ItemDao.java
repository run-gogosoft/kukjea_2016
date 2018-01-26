package com.smpro.dao;

import com.smpro.vo.*;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface ItemDao {
	public List<ItemVo> getList(ItemVo vo);

	public int getListTotalCount(ItemVo vo);

	public List<ItemVo> getListSimple(ItemVo vo);

	public int getListSimpleTotalCount(ItemVo vo);

	public OrderVo getVoForOrderReg(ItemVo vo);

	public ItemVo getVo(Integer seq);

	public int createSeq(ItemVo vo);
	
	public int insertVo(ItemVo vo);

	public int insertDetailVo(ItemVo vo);

	public int updateImgPath(ItemVo vo);

	public int updateVo(ItemVo vo);

	public int updateDetailVo(ItemVo vo);

	public int updateStatusCode(ItemVo vo);

	public int updateCategory(ItemVo vo);

	public int deleteVo(Integer seq);

	/* 베스트용 상품 리스트 */
	public List<ItemVo> getListForBest(ItemVo vo);

	/* 로그와 관련된 메서드들 */
	public int insertLogVo(ItemLogVo vo);

	public List<ItemLogVo> getLogList(ItemLogVo vo);

	public Integer getLogListTotalCount(ItemLogVo vo);

	/** 상품 존재유무 검사 */
	public int getItemCnt(Integer itemSeq);

	/** 판매중인 상품 갯수 */
	public Integer getItemRegCntForWeek(MemberVo memberVo);

	/** 상품 입점업체 시퀀스 */
	public Integer getItemSellerSeq(Integer seq);

	/** 상품 입점업체의 총판 시퀀스 */
	public Integer getItemMasterSeq(Integer seq);

	/** 상품 정보 고시 */
	public List<ItemVo> getTypeInfoList();

	public List<ItemInfoNoticeVo> getPropList(Integer typeCd);

	public HashMap<String, String> getInfo(Integer seq);

	public int insertInfo(ItemInfoNoticeVo vo);

	public int updateInfo(ItemInfoNoticeVo vo);

	public int deleteInfo(Integer seq);

	public int updateTypeCd(ItemInfoNoticeVo vo);

	public List<FilterVo> getFilterList();

	public int deleteFilter(Integer seq);

	public int insertFilter(String word);

	public List<ItemVo> getSoldOutList();

	public int batchUpdateVo(ItemVo vo);

	public int batchUpdateDetailVo(ItemVo vo);

	public List<ItemVo> getListExcel(ItemVo vo);
	
	public int deleteImgPath(ItemVo vo);
	
	public int deleteDetailImgPath(ItemVo vo);
	
	/* 상품로그 6개월 경과분 삭제 */
	public int deleteLogBatch();

	/* 판매중인 상품 조회 */
	public List<ItemVo> getListForSelling(ItemVo vo);
}
