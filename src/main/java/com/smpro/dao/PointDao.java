package com.smpro.dao;

import com.smpro.vo.PointVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PointDao {
	public List<PointVo> getList(PointVo vo);

	public int getListCount(PointVo vo);

	public PointVo getVo(PointVo vo);

	public List<PointVo> getDetailList(PointVo vo);

	public Integer getDetailListCount(PointVo vo);

	public List<PointVo> getShopPointList(PointVo vo);

	public int getShopPointCount(PointVo vo);

	public int updateData(PointVo vo);

	public int insertData(PointVo vo);

	public int insertHistoryData(PointVo vo);

	public int insertLogData(PointVo vo);

	public List<PointVo> getPointList(Integer memberSeq);

	public List<PointVo> getBatchPointForEndDate();

	public List<PointVo> getShopPointListForAllCancel(PointVo vo);

	// 포인트 사용 가능 금액 가져오기
	public Integer getUseablePoint(Integer memberSeq);

	// 포인트 취소 대상 건 가져오기
	public PointVo getHistoryForCancel(Integer orderSeq);

	// 포인트 기 취소적립 건 체크
	public int checkCancel(PointVo vo);

	// 포인트 사용 내역 리스트(주문번호별)
	public List<PointVo> getHistoryList(Integer orderSeq);

	public Integer getExcelDownListCount(PointVo vo);

	public List<PointVo> getExcelDownList(PointVo vo);
}
