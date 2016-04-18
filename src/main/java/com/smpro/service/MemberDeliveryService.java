package com.smpro.service;

import com.smpro.vo.MemberDeliveryVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MemberDeliveryService {
	/** 등록 */
	public boolean regData(MemberDeliveryVo vo) throws Exception;

	/** 수정 */
	public boolean modData(MemberDeliveryVo vo) throws Exception;

	/** 삭제 */
	public boolean delData(MemberDeliveryVo vo);

	/** 상세 */
	public MemberDeliveryVo getData(Integer seq) throws Exception;

	/** 리스트 */
	public List<MemberDeliveryVo> getList(MemberDeliveryVo dvo)
			throws Exception;

}
