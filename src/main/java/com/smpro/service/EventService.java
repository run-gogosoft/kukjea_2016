package com.smpro.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;
import com.smpro.vo.BoardVo;
import com.smpro.vo.EventVo;
import org.springframework.stereotype.Service;

@Service
public interface EventService {
	public List<EventVo> getList(EventVo vo);

	public Integer getListCount(EventVo vo);

	public int createSeq(EventVo vo);
	
	public boolean insertData(EventVo vo);

	public boolean updateData(EventVo vo);

	public boolean deleteData(Integer seq);

	public EventVo getVo(EventVo vo);

	public List<EventVo> getItemList(EventVo vo);

	public String getTitle(EventVo vo);

	public boolean insertItemListTitleData(EventVo vo);

	public boolean updateItemListTitleData(EventVo vo);

	public String getMaxOrderNo(EventVo vo);

	public String getTitleOrderNo(EventVo vo);

	/** 이벤트 상품등록 여부 검사 */
	public Integer getEventItemCnt(EventVo vo);

	public boolean insertItemData(EventVo vo);

	public boolean deleteItemData(Integer seq);

	public boolean deleteItemTitleData(Integer seq);

	public List<EventVo> getTitleList(EventVo vo);

	public boolean updateItemListOrderData(EventVo vo);

	public List<EventVo> getLv1List(EventVo vo);

	/** 이벤트의 자동발행 쿠폰번호 유효성 검사 */
	public boolean chkEventCouponSeq(EventVo vo);
	
	public boolean insertComment(BoardVo vo);
	
	public int getCommentListCount(BoardVo vo);
	
	public List<BoardVo> getCommentList(BoardVo vo);
	
	public boolean deleteCommentVo(Integer seq);
	
	public Map<String, String> uploadImagesByMap(HttpServletRequest request) throws IOException, ImageIsNotAvailableException, ImageSizeException;
	
	public String imageProc(String realPath, String filename, Integer seq);
	
	public void deleteFiles(String realPath, Integer seq);
}
