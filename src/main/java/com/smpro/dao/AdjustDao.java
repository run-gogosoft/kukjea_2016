package com.smpro.dao;

import com.smpro.vo.AdjustVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdjustDao {
	/** 정산 대상 상품주문 리스트(주문번호별) */
	public List<AdjustVo> getListForAdjust();

	/** 취소 정산 대상 상품주문 리스트 */
	public List<AdjustVo> getListForAdjustCancel();

	/** 정산 데이터 등록 */
	public int regVo(AdjustVo vo);

	/** 주문 정산 상태 업데이트 */
	public int updateAdjustFlag(Integer seq);

	/** 입점업체별 정산 리스트 */
	public List<AdjustVo> getList(AdjustVo pvo);

	/** 상품주문별 정산 리스트 */
	public List<AdjustVo> getOrderList(AdjustVo pvo);

	/** 정산 상태 업데이트 */
	public int updateStatus(AdjustVo vo);
	
	/** 정산 내역 삭제 */
	public int delVo(Integer seq);

}
