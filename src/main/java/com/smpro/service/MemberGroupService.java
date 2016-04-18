package com.smpro.service;

import com.smpro.vo.MemberGroupVo;
import org.springframework.stereotype.Service;

@Service
public interface MemberGroupService {
	/** 등록 */
	public int regVo(MemberGroupVo vo);

	/** 수정 */
	public boolean modVo(MemberGroupVo vo) throws Exception;
	
	/** 상세 조회 */
	public MemberGroupVo getVo(Integer seq);
	
	/** 사업자 번호 체크 */
	public int getBizNoCnt(String bizNo);
}
