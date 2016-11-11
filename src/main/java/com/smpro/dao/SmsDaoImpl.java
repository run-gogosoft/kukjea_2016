package com.smpro.dao;

import com.smpro.vo.SmsVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SmsDaoImpl implements SmsDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<SmsVo> getList() {
		return sqlSession.selectList("sms.getList");
	}

	@Override
	public List<SmsVo> getLogList(SmsVo vo) {
		return sqlSession.selectList("sms.getLogList", vo);
	}

	@Override
	public int getLogListCount(SmsVo vo) {
		try {
			return ((Integer) sqlSession.selectOne("sms.getLogListCount", vo)).intValue();
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public SmsVo getVo(Integer seq) {
		return sqlSession.selectOne("sms.getVo", seq);
	}

	@Override
	public int insertVo(SmsVo vo) {
		return sqlSession.insert("sms.insertVo", vo);
	}

	@Override
	public int insertSmsSendVo(SmsVo vo) {
		System.out.println(">>>> insertSmsSendVo, Smsvo is "+ vo.getTrPhone()+", msg :"+vo.getTrMsg());
		return sqlSession.insert("sms.insertSmsSendVo", vo);
	}

	@Override
	public int updateVo(SmsVo vo) {
		return sqlSession.update("sms.updateVo", vo);
	}

	@Override
	public int deleteData(Integer seq) {
		return sqlSession.delete("sms.deleteData", seq);
	}

	@Override
	public String getContent(SmsVo svo) {
		return sqlSession.selectOne("sms.getContent", svo);
	}
}
