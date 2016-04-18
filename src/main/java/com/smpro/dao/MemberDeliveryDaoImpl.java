package com.smpro.dao;

import com.smpro.vo.MemberDeliveryVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDeliveryDaoImpl implements MemberDeliveryDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MemberDeliveryVo> getList(MemberDeliveryVo vo) {
		return sqlSession.selectList("delivery.getList", vo);
	}

	@Override
	public MemberDeliveryVo getData(Integer seq) {
		return sqlSession.selectOne("delivery.getData", seq);
	}

	@Override
	public int regData(MemberDeliveryVo vo) {
		return sqlSession.insert("delivery.regData", vo);
	}

	@Override
	public int modData(MemberDeliveryVo vo) {
		return sqlSession.update("delivery.modData", vo);
	}

	@Override
	public int delData(MemberDeliveryVo vo) {
		return sqlSession.delete("delivery.delData", vo);
	}

	@Override
	public void initDefaultFlag(Integer memberSeq) {
		sqlSession.update("delivery.initDefaultFlag", memberSeq);
	}

}
