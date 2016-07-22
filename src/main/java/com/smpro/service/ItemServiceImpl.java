package com.smpro.service;

import com.smpro.dao.ItemDao;
import com.smpro.util.*;
import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Slf4j
@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemDao itemDao;

	public List<ItemVo> getList(ItemVo vo) {
		List<ItemVo> list = itemDao.getList(vo);
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getOptionName() != null) {
					list.get(i).setOptionName(
							StringUtil.cutString(list.get(i).getOptionName(),
									12));
				}
				if (list.get(i).getOptionValues() != null) {
					list.get(i).setOptionValues(
							StringUtil.cutString(list.get(i).getOptionValues(),
									12));
				}
			}
		}
		return list;
	}

	public List<ItemVo> getListForBest(ItemVo vo) {
		return itemDao.getListForBest(vo);
	}

	public int getListTotalCount(ItemVo vo) {
		return itemDao.getListTotalCount(vo);
	}

	public List<ItemVo> getListSimple(ItemVo vo) {
		return itemDao.getListSimple(vo);
	}

	public int getListSimpleTotalCount(ItemVo vo) {
		return itemDao.getListSimpleTotalCount(vo);
	}

	public OrderVo getVoForOrderReg(ItemVo vo) {
		return itemDao.getVoForOrderReg(vo);
	}

	public ItemVo getVo(Integer seq) {
		ItemVo vo = itemDao.getVo(seq);
		if (vo != null) {
			// 전화번호 자르기
			if (vo.getAsTel() != null) {
				String[] tmp = vo.getAsTel().split("-");
				if (tmp.length == 3) {
					vo.setAsTel1(tmp[0]);
					vo.setAsTel2(tmp[1]);
					vo.setAsTel3(tmp[2]);
				}
			}
			vo.setContent(StringUtil.restoreClearXSS(vo.getContent()));
			vo.setContent(vo.getContent().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		}

		return vo;
	}

	
	public int createSeq(ItemVo vo) {
		return itemDao.createSeq(vo);
	}

	public boolean insertVo(ItemVo vo) {
		return itemDao.insertVo(vo) > 0;
	}

	public boolean insertDetailVo(ItemVo vo) {
		return itemDao.insertDetailVo(vo) > 0;
	}

	public boolean updateImgPath(ItemVo vo) {
		return itemDao.updateImgPath(vo) > 0;
	}

	public boolean updateVo(ItemVo vo) {
		return itemDao.updateVo(vo) > 0;
	}

	public boolean updateDetailVo(ItemVo vo) {
		vo.setAsTel(vo.getAsTel1() + "-" + vo.getAsTel2() + "-" + vo.getAsTel3());
		vo.setContent(StringUtil.restoreClearXSS(vo.getContent()));
		return itemDao.updateDetailVo(vo) > 0;
	}

	public boolean deleteVo(Integer seq) {
		return itemDao.deleteVo(seq) > 0;
	}

	public boolean updateStatusCode(ItemVo vo) {
		return itemDao.updateStatusCode(vo) > 0;
	}

	public boolean updateCategory(ItemVo vo) {
		return itemDao.updateCategory(vo) > 0;
	}

	public boolean insertLogVo(ItemLogVo vo) {
		return itemDao.insertLogVo(vo) > 0;
	}

	public List<ItemLogVo> getLogList(ItemLogVo vo) {
		return itemDao.getLogList(vo);
	}

	public Integer getLogListTotalCount(ItemLogVo vo) {
		return itemDao.getLogListTotalCount(vo);
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
	public Map<String, String> uploadImagesByMap(HttpServletRequest request) throws IOException, ImageIsNotAvailableException {
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
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/item/");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/item/temp");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}

				fileMap.put(file.getName(), new FileUploadUtil().uploadImageFile(file, Const.UPLOAD_REAL_PATH + "/item/temp"));
			}
		}
		return fileMap;
	}

	public String imageProc(String realPath, String idx, String filename, Integer seq) {
		String ext = "." + filename.split("\\.")[1];
		String perSeq = "" + ((seq.intValue() / 1000) * 1000 + 1000);

		// 디렉토리를 검증한다
		FileUtil.mkdir(new File(realPath + "/origin/"));
		FileUtil.mkdir(new File(realPath + "/origin/" + perSeq + "/"));
		FileUtil.mkdir(new File(realPath + "/origin/" + perSeq + "/" + idx + "/"));
		FileUtil.mkdir(new File(realPath + "/s60/"));
		FileUtil.mkdir(new File(realPath + "/s60/" + perSeq + "/"));
		FileUtil.mkdir(new File(realPath + "/s60/" + perSeq + "/" + idx + "/"));
		FileUtil.mkdir(new File(realPath + "/s110/"));
		FileUtil.mkdir(new File(realPath + "/s110/" + perSeq + "/"));
		FileUtil.mkdir(new File(realPath + "/s110/" + perSeq + "/" + idx + "/"));
		FileUtil.mkdir(new File(realPath + "/s170/"));
		FileUtil.mkdir(new File(realPath + "/s170/" + perSeq + "/"));
		FileUtil.mkdir(new File(realPath + "/s170/" + perSeq + "/" + idx + "/"));

		// 파일이 존재한다면 미리 삭제해야 한다
		FileUtil.move(new File(realPath + "/temp/" + filename), new File(realPath + "/origin/" + perSeq + "/" + idx + "/" + seq + ext));
		FileUtil.move(new File(realPath + "/temp/" + filename.replace(".", "_60.")), new File(realPath + "/s60/" + perSeq + "/" + idx + "/" + seq	+ ext));
		FileUtil.move(new File(realPath + "/temp/" + filename.replace(".", "_110.")), new File(realPath + "/s110/" + perSeq + "/" + idx + "/" + seq	+ ext));
		FileUtil.move(new File(realPath + "/temp/" + filename.replace(".", "_170.")), new File(realPath + "/s170/" + perSeq + "/" + idx + "/" + seq	+ ext));

		return "/item/origin/" + perSeq + "/" + idx + "/" + seq + ext;
	}

	public String imageDetailProc(String realPath, String idx, String filename, Integer seq) {
		String ext = "." + filename.split("\\.")[1];
		int perSeq = ((seq.intValue() / 1000) * 1000 + 1000);

		// 디렉토리를 검증한다
		FileUtil.mkdir(new File(realPath + "/detail/"));
		FileUtil.mkdir(new File(realPath + "/detail/" + perSeq + "/"));
		FileUtil.mkdir(new File(realPath + "/detail/" + perSeq + "/" + idx + "/"));

		// 파일이 존재한다면 미리 삭제해야 한다
		FileUtil.move(new File(realPath + "/temp/" + filename), new File(realPath + "/detail/" + perSeq + "/" + idx + "/" + seq + ext));
		return "/item/detail/" + perSeq + "/" + idx + "/" + seq + ext;
	}
		
	/**
	 * 순차적으로 파일을 업로드한 후에, 맵을 반환하는 메서드
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 */
	public Map<String, String> uploadFilesByMap(HttpServletRequest request)	throws IOException {
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
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/item/");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/item/temp");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				fileMap.put(file.getName(), new FileUploadUtil().uploadFile(file, Const.UPLOAD_REAL_PATH + "/item/temp"));
			}
		}
		return fileMap;
	}

	/**
	 * 상품 이미지 파일 삭제
	 * 
	 * @param realPath
	 * @param seq
	 */
	public void deleteFiles(String realPath, Integer seq) {
		ItemVo vo = getVo(seq);
		if(!"/old/no_image1.jpg".equals(vo.getImg1())) {
			new File(realPath + vo.getImg1()).delete();
			new File(realPath + vo.getImg1().replaceAll("origin", "s60")).delete();
			new File(realPath + vo.getImg1().replaceAll("origin", "s110")).delete();
			new File(realPath + vo.getImg1().replaceAll("origin", "s170")).delete();
			log.info("vo.getImg1 deleted --> " + vo.getImg1());
		}
		
		if(!"/old/no_image1.jpg".equals(vo.getImg2())) {
			new File(realPath + vo.getImg2()).delete();
			new File(realPath + vo.getImg2().replaceAll("origin", "s60")).delete();
			new File(realPath + vo.getImg2().replaceAll("origin", "s110")).delete();
			new File(realPath + vo.getImg2().replaceAll("origin", "s170")).delete();
			log.info("vo.getImg2 deleted --> " + vo.getImg2());
		}
		
		new File(realPath + vo.getImg3()).delete();
		new File(realPath + vo.getImg3().replaceAll("origin", "s60")).delete();
		new File(realPath + vo.getImg3().replaceAll("origin", "s110")).delete();
		new File(realPath + vo.getImg3().replaceAll("origin", "s170")).delete();
		log.info("vo.getImg3 deleted --> " + vo.getImg3());

		new File(realPath + vo.getImg4()).delete();
		new File(realPath + vo.getImg4().replaceAll("origin", "s60")).delete();
		new File(realPath + vo.getImg4().replaceAll("origin", "s110")).delete();
		new File(realPath + vo.getImg4().replaceAll("origin", "s170")).delete();
		log.info("vo.getImg4 deleted --> " + vo.getImg4());

		new File(realPath + vo.getDetailImg1()).delete();
		log.info("vo.getDetailImg1 deleted --> " + vo.getDetailImg1());
		new File(realPath + vo.getDetailImg2()).delete();
		log.info("vo.getDetailImg2 deleted --> " + vo.getDetailImg2());
		new File(realPath + vo.getDetailImg3()).delete();
		log.info("vo.getDetailImg3 deleted --> " + vo.getDetailImg3());
		
		//에디터를 통해 업로드한 이미지 삭제
		EditorUtil.deleteImage(seq, "item");
		
	}

	/** 상품 존재유무 검사 */
	public int getItemCnt(Integer itemSeq) {
		return itemDao.getItemCnt(itemSeq);
	}

	/** 판매중인 상품 갯수 */
	public Integer getItemRegCntForWeek(MemberVo memberVo) {
		return itemDao.getItemRegCntForWeek(memberVo);
	}

	/** 해당 상품의 입점업체가 맞는지 체크 */
	public boolean diffSellerSeq(Integer seq, Integer loginSeq) {
		
		// 널 체크
		if (StringUtil.isBlank("" + seq) || StringUtil.isBlank("" + loginSeq)) {
			return false;
		}
		// 상품존재여부 체크
		if (itemDao.getItemCnt(seq) < 1) {
			return false;
		}
		// 비교
		if (loginSeq.equals(itemDao.getItemSellerSeq(seq))) {
			return true;
		}

		return false;
	}

	/** 해당 상품의 총판이 맞는지 체크 */
	public boolean diffMasterSeq(Integer seq, Integer loginSeq) {
		// 널 체크
		if (StringUtil.isBlank("" + seq) || StringUtil.isBlank("" + loginSeq)) {
			return false;
		}
		// 상품존재여부 체크
		if (itemDao.getItemCnt(seq) < 1) {
			return false;
		}
		// 비교
		if (loginSeq == itemDao.getItemMasterSeq(seq)) {
			return true;
		}

		return false;
	}

	public List<ItemVo> getTypeInfoList() {
		return itemDao.getTypeInfoList();
	}

	public List<ItemInfoNoticeVo> getPropList(Integer typeCd) {
		return itemDao.getPropList(typeCd);
	}

	public HashMap<String, String> getInfo(Integer seq) {
		return itemDao.getInfo(seq);
	}

	public boolean insertInfo(ItemInfoNoticeVo vo) {
		// nullpoint exception을 막기 위한 예비조치
		List<String> tempPropValList = new ArrayList<>();
		for (int i = 0; i < 20; i++) {
			// size() 는 배열의 총길이를 나타내고 i는0부터 시작하므로 size에서 1을 빼준다(빼주지 않으면 index에러
			// 발생).
			if (i > (vo.getPropValList().size() - 1)) {
				tempPropValList.add(i, "");
			} else {
				tempPropValList.add(i, vo.getPropValList().get(i));
			}
		}
		vo.setPropValList(tempPropValList);

		return itemDao.insertInfo(vo) > 0;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean updateInfo(ItemInfoNoticeVo vo) throws Exception {
		List<String> tempPropValList = new ArrayList<>();
		int result = itemDao.updateTypeCd(vo);
		log.info("### service updateTypeCd result :::: [" + result + "]");
		if (result > 0) {
			for (int i = 0; i < 20; i++) {
				// size() 는 배열의 총길이를 나타내고 i는0부터 시작하므로 size에서 1을 빼준다(빼주지 않으면
				// index에러 발생).
				if (i > (vo.getPropValList().size() - 1)) {
					tempPropValList.add(i, "");
				} else {
					tempPropValList.add(i, vo.getPropValList().get(i));
				}
			}
			vo.setPropValList(tempPropValList);
			Map<String, String> validMap = getInfo(vo.getItemSeq());
			// 상품 추가정보 수정시 추가정보가 존재한다면 수정하고 없다면 등록시킨다.
			if (validMap == null) {
				if (insertInfo(vo)) {
					result += 1;
				}
			} else {
				result += itemDao.updateInfo(vo);
			}
			log.info(
					"### service updateInfo result :::: [" + result + "]");
		}
		// insert 결과가 2가 아닐경우 롤백
		if (result != 2) {
			throw new Exception(
					"fail result data :::: correct data=[2], now data=["
							+ result + "]");
		}
		return true;
	}

	public int deleteInfo(Integer seq) {
		return itemDao.deleteInfo(seq);
	}

	public boolean updateTypeCd(ItemInfoNoticeVo vo) {
		return itemDao.updateTypeCd(vo) > 0;
	}

	/** 상품 엑셀 다운로드 */
	public Workbook writeExcelItemList(ItemVo vo, String type,
			HttpSession session) {
		Workbook wb;
		String loginType = (String) session.getAttribute("loginType");

		int arrSize = 18;

		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arrSize];
		int idx = 0;
		strTitle[idx++] = "상품코드";
		strTitle[idx++] = "대분류";
		strTitle[idx++] = "중분류";
		strTitle[idx++] = "소분류";
		strTitle[idx++] = "세분류";
		strTitle[idx++] = "진료과목";
		strTitle[idx++] = "상품명";
		strTitle[idx++] = "규격 1";
		strTitle[idx++] = "규격 2";
		strTitle[idx++] = "규격 3";
		strTitle[idx++] = "보험코드";
		strTitle[idx++] = "제조사";
		strTitle[idx++] = "단위";
		strTitle[idx++] = "기준재고";
		strTitle[idx++] = "발주처";
		strTitle[idx++] = "자동발주량";
		strTitle[idx++] = "상품이미지1";
		strTitle[idx++] = "상품이미지2";

		/* 상품리스트 */
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		List<ItemVo> list = itemDao.getListExcel(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				ItemVo ivo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(arrSize);
				cell.add(ivo.getSeq());
				cell.add(ivo.getCateLv1Name());
				cell.add(ivo.getCateLv2Name());
				cell.add(ivo.getCateLv3Name());
				cell.add(ivo.getCateLv4Name());
				cell.add(ivo.getSubjectType());//진료과목
				cell.add(ivo.getName());//상품명
				cell.add(ivo.getType1());//규격 1
				cell.add(ivo.getType2());//규격 2
				cell.add(ivo.getType3());//규격 3
				cell.add(ivo.getInsuranceCode());//보험코드
				cell.add(ivo.getMaker());//제조사
				cell.add(ivo.getOriginCountry());//단위
				cell.add(ivo.getModelName());//기준재고
				cell.add(ivo.getBrand());//발주처
				cell.add(ivo.getMinCnt());//자동발주량

				cell.add(ivo.getImg1());//상품이미지1
				if (StringUtil.isBlank(ivo.getImg2())) {
					cell.add(ivo.getImg2());
				} else {
					cell.add(ivo.getImg2());
				}
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, type, 0);

		return wb;
	}

	public List<FilterVo> getFilterList() {
		return itemDao.getFilterList();
	}

	public boolean deleteFilter(Integer seq) {
		return itemDao.deleteFilter(seq) > 0;
	}

	public boolean insertFilter(String word) {
		return itemDao.insertFilter(word) > 0;
	}

	public List<ItemVo> getSoldOutList() {
		return itemDao.getSoldOutList();
	}

	public boolean batchUpdateVo(ItemVo vo) {
		return itemDao.batchUpdateVo(vo) > 0;
	}

	public boolean batchUpdateDetailVo(ItemVo vo) {
		return itemDao.batchUpdateDetailVo(vo) > 0;
	}

	public boolean insertProp(ItemInfoNoticeVo pvo) {
		return itemDao.insertInfo(pvo) > 0;
	}
	
	public boolean deleteImgPath(ItemVo vo) {
		return itemDao.deleteImgPath(vo) > 0;
	}

	public boolean deleteDetailImgPath(ItemVo vo) {
		return itemDao.deleteDetailImgPath(vo) > 0;
	}

	public boolean imgDelete(int idx, String imgPath, Model model) {
		boolean result = true;
		String[] itemImageSize = { "origin", "s60", "s110", "s170" };
		String groupNumber = imgPath.split("/")[3];
		String fileName = imgPath.split("/")[5];
		
		for (int j = 0; j < itemImageSize.length; j++) {
			File file = new File(Const.UPLOAD_REAL_PATH+"/item/"+itemImageSize[j]+"/"+groupNumber+"/"+idx+"/"+fileName);
			if(file.exists()) {
				if(!file.delete()) {
					model.addAttribute("message", "이미지 삭제가 실패하였습니다.");
					result = false;
				}
			} else {
				model.addAttribute("message", "이미지가 존재하지 않습니다.");
				result = false;
			}
		}
		return result;
	}
	
	public boolean detailImgDelete(int idx, String imgPath, Model model) {
		boolean result = true;
		String groupNumber = imgPath.split("/")[3];
		String fileName = imgPath.split("/")[5];

		File file = new File(Const.UPLOAD_REAL_PATH+"/item/detail/"+groupNumber+"/"+idx+"/"+fileName);
		if(file.exists()) {
			if(!file.delete()) {
				model.addAttribute("message", "상세 이미지 삭제가 실패하였습니다.");
				result = false;
			}
		} else {
			model.addAttribute("message", "상세 이미지가 존재하지 않습니다.");
			result = false;
		}
		return result;
	}
	
	public int deleteLogBatch() {
		return itemDao.deleteLogBatch();
	}

	public List<ItemVo> getListForSelling(ItemVo vo) {
		return itemDao.getListForSelling(vo);
	}
	
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public boolean modItemStatusCode(ItemVo vo) throws Exception {
		int result = 0;

		vo.setStatusCode("S");
		result = itemDao.updateStatusCode(vo);

		ItemLogVo ivo = new ItemLogVo();
		ivo.setItemSeq(vo.getSeq());
		ivo.setLoginSeq(new Integer(0));
		ivo.setAction("수정");
		ivo.setLoginType("A");
		ivo.setContent("재고 품절로 인한 상품상태 변경");
		result += itemDao.insertLogVo(ivo);


		//update 결과가 2가 아닐경우 롤백
		if(result != 2) {
			throw new Exception("###재고 품절로 인한 상품상태 변경 실패");
		}

		return true;
	}
}
