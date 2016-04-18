package com.smpro.service;

import java.util.List;

import com.smpro.vo.EstimateVo;
import com.smpro.vo.ItemVo;
import org.springframework.stereotype.Service;

@Service
public interface EstimateService {
	/* 견적 신청 */
	public List<EstimateVo> getList(EstimateVo vo);
	public int getListCount(EstimateVo vo);
	public EstimateVo getVo(Integer seq);
	public int regVo(EstimateVo vo);
	public int modVo(EstimateVo vo);
	public int delVo(Integer seq);
	
	/* 비교 견적 신청 */
	public List<EstimateVo> getListCompare(EstimateVo vo);
	public List<EstimateVo> getListCompareFile(EstimateVo vo);
	public int getListCountCompare(EstimateVo vo);
	public EstimateVo getVoCompare(Integer seq);
	public int regVoCompare(EstimateVo vo);
	public int modVoCompare(EstimateVo vo);
	public int delVoCompare(Integer seq);
	
	public int createEstimateCompareSeq(EstimateVo vo);
	
	/*견적 주문 */
	public List<ItemVo> getListForOrder(EstimateVo vo);
}
