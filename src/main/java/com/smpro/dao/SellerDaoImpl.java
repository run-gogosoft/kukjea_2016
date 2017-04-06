package com.smpro.dao;

import com.smpro.vo.SellerVo;
import com.smpro.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SellerDaoImpl implements SellerDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<SellerVo> getList(SellerVo srchVo) {
		return sqlSession.selectList("seller.getList", srchVo);
	}

	@Override
	public int getListCount(SellerVo srchVo) {
		return ((Integer) sqlSession.selectOne("seller.getListCount", srchVo)).intValue();
	}

	@Override
	public SellerVo getData(Integer seq) {
		return sqlSession.selectOne("seller.getData", seq);
	}
	
	@Override
	public SellerVo getVoSimple(Integer seq) {
		return sqlSession.selectOne("seller.getVoSimple", seq);
	}

	@Override
	public int modUserData(SellerVo vo) {
		return sqlSession.update("seller.modUserData", vo);
	}

	@Override
	public int modSellerData(SellerVo vo) {
		return sqlSession.update("seller.modSellerData", vo);
	}

	@Override
	public List<UserVo> getSimpleList(SellerVo srchVo) {
		return sqlSession.selectList("seller.getSimpleList", srchVo);
	}

	@Override
	public int regSellerData(SellerVo vo) {
		return sqlSession.insert("seller.regSellerData", vo);
	}

	@Override
	public int updateUserStatus(SellerVo vo) {
		return sqlSession.update("seller.updateUserStatus", vo);
	}

	@Override
	public int updateSellerStatus(SellerVo vo) {
		return sqlSession.update("seller.updateSellerStatus", vo);
	}

	@Override
	public int getBizNoCnt(String bizNo) {
		return ((Integer) sqlSession.selectOne("seller.getBizNoCnt", bizNo)).intValue();
	}

	/** 요청을 위한 임시 매핑(지워야함) */
	@Override
	public UserVo getSellerSeq(String id) {
		return sqlSession.selectOne("seller.getSellerSeq", id);
	}

	@Override
	public UserVo getShopSellerSeq(SellerVo vo) {
		return sqlSession.selectOne("seller.getShopSellerSeq", vo);
	}	

	@Override
	public int getSellerRegCntForWeek() {
		return Integer.parseInt(String.valueOf(sqlSession.selectOne("seller.getSellerRegCntForWeek")));
	}

	@Override
	public int updateComment(SellerVo vo) {
		return sqlSession.update("seller.updateComment", vo);
	}
	
	public Integer getSeqByOldSeq(Integer oldSeq) {
		return sqlSession.selectOne("seller.getSeqByOldSeq", oldSeq);
	}

	@Override
	public int deleteSeller(Integer seq) {
		return sqlSession.delete("seller.deleteSeller", seq);
	}

	@Override
	public String getTotlaSellFinishCount(Integer sellerSeq){
		return "0";
	}

	@Override
	public String getTotalSellFinishPrice(Integer sellerSeq){
		return sqlSession.selectOne("order.getTotalSellFinishPrice", sellerSeq);
	}
}
