package com.smpro.service;

import com.smpro.dao.EventDao;
import com.smpro.util.Const;
import com.smpro.util.FileUploadUtil;
import com.smpro.util.FileUtil;
import com.smpro.util.StringUtil;
import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;
import com.smpro.vo.BoardVo;
import com.smpro.vo.EventVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class EventServiceImpl implements EventService {
	@Autowired
	private EventDao eventDao;

	public List<EventVo> getList(EventVo vo) {
		return eventDao.getList(vo);
	}

	public Integer getListCount(EventVo vo) {
		return eventDao.getListCount(vo);
	}
	
	public int createSeq(EventVo vo) {
		return eventDao.createSeq(vo);
	}

	public boolean insertData(EventVo vo) {
		return eventDao.insertData(vo) > 0;
	}

	public boolean updateData(EventVo vo) {
		return eventDao.updateData(vo) > 0;
	}

	public boolean deleteData(Integer seq) {
		return eventDao.deleteData(seq) > 0;
	}

	public EventVo getVo(EventVo vo) {
		EventVo evo = eventDao.getVo(vo);
		if (evo != null) {
			evo.setHtml(StringUtil.restoreClearXSS(evo.getHtml()));
			evo.setHtml(evo.getHtml().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
			
		}
		return evo;
	}

	public List<EventVo> getItemList(EventVo vo) {
		List<EventVo> eventItemListVo = eventDao.getItemList(vo);
		for (EventVo event:eventItemListVo) {
			System.out.println(">>>event.getFreeDeli:"+event.getFreeDeli());
			System.out.println(">>>event.getEventAdded:"+event.getEventAdded());
			event.setItemName(
					StringUtil.cutString(event.getItemName(),
							100));
		}
		return eventItemListVo;
	}

	public String getTitle(EventVo vo) {
		return eventDao.getTitle(vo);
	}

	public boolean insertItemListTitleData(EventVo vo) {
		return eventDao.insertItemListTitleData(vo) > 0;
	}

	public boolean updateItemListTitleData(EventVo vo) {
		return eventDao.updateItemListTitleData(vo) > 0;
	}

	public String getMaxOrderNo(EventVo vo) {
		return eventDao.getMaxOrderNo(vo);
	}

	public String getTitleOrderNo(EventVo vo) {
		return eventDao.getTitleOrderNo(vo);
	}

	/** 이벤트 상품등록 여부 검사 */
	public Integer getEventItemCnt(EventVo vo) {
		return eventDao.getEventItemCnt(vo);
	}

	public boolean insertItemData(EventVo vo) {
		return eventDao.insertItemData(vo) > 0;
	}

	public boolean deleteItemData(Integer seq) {
		return eventDao.deleteItemData(seq) > 0;
	}

	public boolean deleteItemTitleData(Integer seq) {
		return eventDao.deleteItemTitleData(seq) > 0;
	}

	public List<EventVo> getTitleList(EventVo vo) {
		return eventDao.getTitleList(vo);
	}

	public boolean updateItemListOrderData(EventVo vo) {
		return eventDao.updateItemListOrderData(vo) > 0;
	}

	public List<EventVo> getLv1List(EventVo vo) {
		return eventDao.getLv1List(vo);
	}

	/** 이벤트의 자동발행 쿠폰번호 유효성 검사 */
	public boolean chkEventCouponSeq(EventVo vo) {
		EventVo result = eventDao.getVo(vo);

		if (result != null && !StringUtil.isBlank("" + result.getCouponSeq())) {
			if (vo.getCouponSeq() == result.getCouponSeq()) {
				return true;
			}
		}

		return false;
	}

	public boolean insertComment(BoardVo vo) {
		return eventDao.insertComment(vo) > 0;
	}

	public int getCommentListCount(BoardVo vo) {
		return eventDao.getCommentListCount(vo);
	}

	public List<BoardVo> getCommentList(BoardVo vo) {
		return eventDao.getCommentList(vo);
	}

	public boolean deleteCommentVo(Integer seq) {
		return eventDao.deleteCommentVo(seq) > 0;
	}
	
	public String imageProc(String realPath, String filename, Integer seq) {
		String ext = "." + filename.split("\\.")[1];
		String perSeq = "" + ((seq.intValue() / 1000) * 1000 + 1000);

		// 디렉토리를 검증한다
		FileUtil.mkdir(new File(realPath + "/" + perSeq + "/"));
		// 파일이 존재한다면 미리 삭제해야 한다
		FileUtil.move(new File(realPath + "/temp/" + filename), new File(realPath + "/" + perSeq + "/" + seq + ext));

		return "/plan/" + perSeq + "/" + seq + ext;
	}
	
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
	public Map<String, String> uploadImagesByMap(HttpServletRequest request) throws IOException, ImageIsNotAvailableException, ImageSizeException {
		Map<String, String> fileMap = new LinkedHashMap<>();
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iter = mpRequest.getFileNames();
		while (iter.hasNext()) {
			MultipartFile file = mpRequest.getFile(iter.next());
			if (file.getSize() > 0) {
				// temp 디렉토리 생성
				File tempDir = new File(Const.UPLOAD_REAL_PATH);
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/plan/");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/plan/temp");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				
				fileMap.put(file.getName(), new FileUploadUtil().uploadEventImageFile(file, Const.UPLOAD_REAL_PATH + "/plan/temp"));
			}
		}
		return fileMap;
	}
	
	/**
	 * 해당 seq의 파일을 삭제한다
	 * 
	 * @param realPath
	 * @param seq
	 */
	public void deleteFiles(String realPath, Integer seq) {
		EventVo paramVo = new EventVo();
		paramVo.setSeq(seq);
		EventVo vo = getVo(paramVo);
		new File(realPath + vo.getThumbImg()).delete();
		log.info("vo.getThumbImg deleted --> " + vo.getThumbImg());
	}
}
