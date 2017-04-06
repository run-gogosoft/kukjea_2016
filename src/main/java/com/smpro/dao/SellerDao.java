package com.smpro.dao;

import com.smpro.vo.SellerVo;
import com.smpro.vo.UserVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SellerDao {
	public List<SellerVo> getList(SellerVo srchVo);

	public int getListCount(SellerVo srchVo);

	public SellerVo getData(Integer seq);
	
	public SellerVo getVoSimple(Integer seq);

	public int regSellerData(SellerVo vo);

	public int modUserData(SellerVo vo);

	public int modSellerData(SellerVo vo);

	public int updateUserStatus(SellerVo vo);

	public int updateSellerStatus(SellerVo vo);

	public int getBizNoCnt(String bizNo);

	public List<UserVo> getSimpleList(SellerVo srchVo);

	/** 요청을 위한 임시 매핑(지워야함) */
	public UserVo getSellerSeq(String id);
	
	public UserVo getShopSellerSeq(SellerVo vo);

	public int getSellerRegCntForWeek();

	public int updateComment(SellerVo vo);
	
	/** 입점업체 시퀀스 쿼리(함께누리몰 데이터 이관용) */
	public Integer getSeqByOldSeq(Integer oldSeq);

	public int deleteSeller(Integer seq);

	/** 구매확정된 총 판매건수 */
	public String getTotlaSellFinishCount(Integer sellerSeq);

	/** 구매확정된 총 판매 금액 */
	public String getTotalSellFinishPrice(Integer sellerSeq);
}
