package com.smpro.dao;

import com.smpro.vo.MemberDeliveryVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberDeliveryDao {
	public List<MemberDeliveryVo> getList(MemberDeliveryVo vo);

	public MemberDeliveryVo getData(Integer seq);

	public int regData(MemberDeliveryVo vo);

	public int modData(MemberDeliveryVo vo);

	public int delData(MemberDeliveryVo vo);

	public void initDefaultFlag(Integer memberSeq);
}
