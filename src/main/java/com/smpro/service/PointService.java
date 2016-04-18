package com.smpro.service;

import com.smpro.vo.PointVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface PointService {
	public List<PointVo> getList(PointVo vo);

	public int getListCount(PointVo vo);

	public PointVo getVo(PointVo vo);

	public List<PointVo> getDetailList(PointVo vo);

	public Integer getDetailListCount(PointVo vo);

	public List<PointVo> getShopPointList(PointVo vo);

	public int getShopPointCount(PointVo vo);

	public boolean updateData(PointVo vo);

	public boolean insertData(PointVo vo);

	public boolean insertHistoryData(PointVo vo);

	public boolean insertLogData(PointVo vo);

	public List<PointVo> getBatchPointForEndDate();

	public List<PointVo> getShopPointListForAllCancel(PointVo vo);

	public Integer getUseablePoint(Integer memberSeq);

	// 포인트 취소 대상 건 가져오기
	public PointVo getHistoryForCancel(Integer orderSeq);

	// 포인트 기 취소내역 체크(중복처리 방지용)
	public int checkCancel(PointVo vo);

	// 포인트 사용 내역 리스트(주문번호별)
	public List<PointVo> getHistoryList(Integer orderSeq);

	/** 엑셀 데이터 유효성 체크 */
	public String chkXlsData(String[] row);

	public Integer getExcelDownListCount(PointVo vo);

	public List<PointVo> getExcelDownList(PointVo vo);

	/** 포인트 엑셀 다운로드 */
	public Workbook writeExcelPointList(PointVo vo, String type);

	/** 포인트 엑셀 다운로드 */
	public Workbook writePointList(PointVo vo, String type);

	/** 포인트 상세 리스트 엑셀 다운로드 */
	public Workbook writeDetailPointList(PointVo vo, String type);

	/** 포인트 상세 리스트 엑셀 다운로드(모든회원) */
	public Workbook writePointAllList(PointVo vo, String type);
	
	public boolean regPoint(PointVo vo) throws Exception;
}
