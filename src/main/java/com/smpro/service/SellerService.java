package com.smpro.service;

import com.smpro.vo.SellerVo;
import com.smpro.vo.UserVo;

import java.util.List;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

@Service
public interface SellerService {

	public List<SellerVo> getList(SellerVo srchVo);

	public int getListCount(SellerVo srchVo);

	public List<UserVo> getSimpleList(SellerVo srchVo);

	/** 입점업체/총판 상세 정보 가져오기 */
	public SellerVo getData(Integer seq) throws Exception;
	
	/** 입점업체/총판 상세 정보 가져오기(간략) */
	public SellerVo getVoSimple(Integer seq);

	/** 입점업체/총판 등록 */
	public boolean regData(SellerVo vo) throws Exception;

	/** 입점업체/총판 수정 */
	public boolean modData(SellerVo vo) throws Exception;

	/** 승인/폐점 처리 */
	public boolean updateStatus(SellerVo vo) throws Exception;

	/** 사업자 번호 체크 */
	public int getBizNoCnt(String bizNo);

	/** 요청을 위한 임시 매핑(지워야함) */
	public UserVo getSellerSeq(String id);

	/** 회원 엑셀 다운로드 */
	public Workbook writeExcelSellerList(SellerVo vo, String type);
	
	public UserVo getShopSellerSeq(SellerVo vo);
	
	public int getSellerRegCntForWeek();

	public int updateComment(SellerVo vo);
	
	/** 입점업체 시퀀스 쿼리(함께누리몰 데이터 이관용) */
	public Integer getSeqByOldSeq(Integer oldSeq);
	
	public boolean deleteSeller(Integer seq);


	/** 구매확정된 총 판매건수 */
	public String getTotlaSellFinishCount(Integer sellerSeq);

	/** 구매확정된 총 판매 금액 */
	public String getTotalSellFinishPrice(Integer sellerSeq);


}
