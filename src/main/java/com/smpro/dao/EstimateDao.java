package com.smpro.dao;

import com.smpro.vo.EstimateVo;
import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EstimateDao {
	/* 견적 신청 */
	public List<EstimateVo> getList(EstimateVo vo);
	public int getListCount(EstimateVo vo);
	public EstimateVo getVo(Integer seq);
	public int regVo(EstimateVo vo);
	public int modVo(EstimateVo vo);
	public int delVo(Integer seq);
	public int updateStatus(EstimateVo vo);
	
	/* 비교 견적 */
	public List<EstimateVo> getListCompare(EstimateVo vo);
	public List<EstimateVo> getListCompareFile(EstimateVo vo);
	public int getListCountCompare(EstimateVo vo);
	public EstimateVo getVoCompare(Integer seq);
	public int regVoCompare(EstimateVo vo);
	public int modVoCompare(EstimateVo vo);
	public int delVoCompare(Integer seq);
	// 시퀀스 생성
	public int createEstimateCompareSeq(EstimateVo vo);
	
	/* 견적신청 상품 주문 */
	public List<ItemVo> getListForOrder(EstimateVo vo);
	
	/* 입점업체 영업담당자 휴대폰 정보 가져오기(SMS발송) */
	public String getSalesCell(Integer itemSeq);
}
