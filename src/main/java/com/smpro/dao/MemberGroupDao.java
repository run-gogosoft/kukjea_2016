package com.smpro.dao;

import com.smpro.vo.MemberGroupVo;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberGroupDao {
	/** 등록 */
	public int regVo(MemberGroupVo vo);

	/** 수정 */
	public int modVo(MemberGroupVo vo);
	
	/** 상세 조회 */
	public MemberGroupVo getVo(Integer seq);
	
	/** 주소 수정 */
	public int modAddr(MemberGroupVo vo); 
	
	public int getBizNoCnt(String bizNo);
}
