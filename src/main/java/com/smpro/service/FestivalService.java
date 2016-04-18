package com.smpro.service;

import com.smpro.vo.FestivalVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface FestivalService {
	/** 행사 리스트 */
	public List<FestivalVo> getList(FestivalVo vo);
	
	/** 행사 리스트 건수 */
	public int getListCount(FestivalVo vo);
	
	/** 행사 상세 */
	public FestivalVo getVo(Integer seq);

	/** 행사 seq 생성 */
	public int createSeq(FestivalVo vo);
	
	/** 행사 등록 */
	public int regVo(FestivalVo vo);
	
	/** 행사 수정 */
	public int modVo(FestivalVo vo);
	
	/** 행사 삭제 */
	public int delVo(Integer seq);
	
	/** 행사 참여 리스트 */
	public List<FestivalVo> getSellerList(FestivalVo vo);
	
	/** 행사 참여 상세 */
	public FestivalVo getSellerVo(FestivalVo vo);

	/** 행사 참여 등록 */
	public int regSellerVo(FestivalVo vo);

	/** 행사 참여 수정 */
	public int modSellerVo(FestivalVo vo);
	
	/** 행사 참여 삭제 */
	public int delSellerVo(Integer seq);
}
