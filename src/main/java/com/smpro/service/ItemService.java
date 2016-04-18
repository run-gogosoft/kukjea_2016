package com.smpro.service;

import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.vo.FilterVo;
import com.smpro.vo.ItemInfoNoticeVo;
import com.smpro.vo.ItemLogVo;
import com.smpro.vo.ItemVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.OrderVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public interface ItemService {

	public List<ItemVo> getList(ItemVo vo);

	public List<ItemVo> getListForBest(ItemVo vo);

	public int getListTotalCount(ItemVo vo);

	public List<ItemVo> getListSimple(ItemVo vo);

	public int getListSimpleTotalCount(ItemVo vo);

	public OrderVo getVoForOrderReg(ItemVo vo);

	public ItemVo getVo(Integer seq);

	public int createSeq(ItemVo vo);
	
	public boolean insertVo(ItemVo vo);

	public boolean insertDetailVo(ItemVo vo);

	public boolean updateImgPath(ItemVo vo);

	public boolean updateVo(ItemVo vo);

	public boolean updateDetailVo(ItemVo vo);

	public boolean deleteVo(Integer seq);

	public boolean updateStatusCode(ItemVo vo);

	public boolean updateCategory(ItemVo vo);

	public boolean insertLogVo(ItemLogVo vo);

	public List<ItemLogVo> getLogList(ItemLogVo vo);

	public Integer getLogListTotalCount(ItemLogVo vo);

	/**
	 * 순차적으로 이미지 파일을 업로드한 후에, 맵을 반환하는 메서드
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 */
	public Map<String, String> uploadImagesByMap(HttpServletRequest request) throws IOException, ImageIsNotAvailableException;

	public String imageProc(String realPath, String idx, String filename, Integer seq);

	public String imageDetailProc(String realPath, String idx, String filename,	Integer seq);

	/**
	 * 순차적으로 파일을 업로드한 후에, 맵을 반환하는 메서드
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 */
	public Map<String, String> uploadFilesByMap(HttpServletRequest request) throws IOException;

	/**
	 * 해당 seq의 파일을 일괄 삭제한다
	 * 
	 * @param realPath
	 * @param seq
	 */
	public void deleteFiles(String realPath, Integer seq);

	/** 상품 존재유무 검사 */
	public int getItemCnt(Integer itemSeq);

	/** 판매중인 상품 갯수 */
	public Integer getItemRegCntForWeek(MemberVo memberVo);

	/** 해당 상품의 입점업체가 맞는지 체크 */
	public boolean diffSellerSeq(Integer seq, Integer loginSeq);

	/** 해당 상품의 총판이 맞는지 체크 */
	public boolean diffMasterSeq(Integer seq, Integer loginSeq);

	public List<ItemVo> getTypeInfoList();

	public List<ItemInfoNoticeVo> getPropList(Integer typeCd);

	public HashMap<String, String> getInfo(Integer seq);

	public boolean insertInfo(ItemInfoNoticeVo vo);

	public boolean updateInfo(ItemInfoNoticeVo vo) throws Exception;

	public int deleteInfo(Integer seq);

	public boolean updateTypeCd(ItemInfoNoticeVo vo);

	/** 상품 엑셀 다운로드 */
	public Workbook writeExcelItemList(ItemVo vo, String type, HttpSession session);

	public List<FilterVo> getFilterList();

	public boolean deleteFilter(Integer seq);

	public boolean insertFilter(String word);

	public List<ItemVo> getSoldOutList();

	public boolean batchUpdateVo(ItemVo vo);

	public boolean batchUpdateDetailVo(ItemVo vo);

	public boolean insertProp(ItemInfoNoticeVo pvo);
	
	public boolean imgDelete(int idx, String imgPath, Model model);
	
	public boolean detailImgDelete(int idx, String imgPath, Model model);
	
	public boolean deleteImgPath(ItemVo vo);
	
	public boolean deleteDetailImgPath(ItemVo vo);
	
	/** 상품로그 6개월 경과분 삭제 */
	public int deleteLogBatch();
	
	/** 판매중인 상품 조회 */
	public List<ItemVo> getListForSelling(ItemVo vo);
	
	/** 재고 품절 처리 배치 */
	public boolean modItemStatusCode(ItemVo vo) throws Exception;
}
