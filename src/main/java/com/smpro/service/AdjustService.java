package com.smpro.service;

import com.smpro.vo.AdjustVo;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface AdjustService {
	/** 정산 대상 리스트 가져오기 */
	public List<AdjustVo> getListForAdjust();

	/** 취소 정산 대상 리스트 가져오기 */
	public List<AdjustVo> getListForAdjustCancel();

	/** 정산 배치 데이터 등록 */
	public int regVo(List<AdjustVo> list) throws Exception;
	
	/** 정산 내역 수동 추가 */
	public int regVo(AdjustVo vo);

	/** 정산 리스트 */
	public List<AdjustVo> getList(AdjustVo pvo);

	/** 정산 주문 리스트 */
	public List<AdjustVo> getOrderList(AdjustVo pvo);

	/** 정산 상태 업데이트 */
	public int updateStatus(AdjustVo vo);
	
	/** 정산 내역 삭제 */
	public int delVo(Integer seq);

	/** 입점업체별 정산리스트 엑셀 생성 */
	public Workbook getListExcel(AdjustVo pvo, String type);

	/** 입점업체별 정산 주문 리스트 엑셀 생성 */
	public Workbook getListExcelOrder(AdjustVo pvo, String type);
}
