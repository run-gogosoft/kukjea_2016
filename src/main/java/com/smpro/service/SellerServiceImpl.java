package com.smpro.service;

import com.smpro.dao.SellerDao;
import com.smpro.dao.UserDao;
import com.smpro.util.Const;
import com.smpro.util.EditorUtil;
import com.smpro.util.ExcelUtil;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.SellerVo;
import com.smpro.vo.UserVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Service
public class SellerServiceImpl implements SellerService {
	@Autowired
	private SellerDao sellerDao;

	@Autowired
	private UserDao userDao;

	@Override
	public List<SellerVo> getList(SellerVo srchVo) {
		List<SellerVo> list = sellerDao.getList(srchVo);
		for(SellerVo vo : list) {
			if(vo.getIntro() != null) {
				vo.setIntro(StringUtil.restoreClearXSS(vo.getIntro()).replaceAll("\\<[^>]*>","").replaceAll("&nbsp;"," ") );

			}
		}
		return list;
	}

	@Override
	public int getListCount(SellerVo srchVo) {
		return sellerDao.getListCount(srchVo);
	}

	@Override
	public List<UserVo> getSimpleList(SellerVo srchVo) {
		return sellerDao.getSimpleList(srchVo);
	}

	/** 입점업체/총판 상세 정보 가져오기 */
	@Override
	public SellerVo getData(Integer seq) throws Exception {
		SellerVo vo = sellerDao.getData(seq);
		if (!StringUtil.isBlank(vo.getAccountNo())) {
			vo.setAccountNo(CrypteUtil.decrypt(vo.getAccountNo(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}

		/* 전화번호 자르기 */
		if (vo.getTel() != null) {
			String[] tmp = vo.getTel().split("-");
			if (tmp.length == 3) {
				vo.setTel1(tmp[0]);
				vo.setTel2(tmp[1]);
				vo.setTel3(tmp[2]);
			}
		}
		if (vo.getFax() != null) {
			String[] tmp = vo.getFax().split("-");
			if (tmp.length == 3) {
				vo.setFax1(tmp[0]);
				vo.setFax2(tmp[1]);
				vo.setFax3(tmp[2]);
			}
		}
		if (vo.getSalesTel() != null) {
			String[] tmp = vo.getSalesTel().split("-");			if (tmp.length == 3) {
				vo.setSalesTel1(tmp[0]);
				vo.setSalesTel2(tmp[1]);
				vo.setSalesTel3(tmp[2]);
			}
		}
		if (vo.getSalesCell() != null) {
			String[] tmp = vo.getSalesCell().split("-");
			if (tmp.length == 3) {
				vo.setSalesCell1(tmp[0]);
				vo.setSalesCell2(tmp[1]);
				vo.setSalesCell3(tmp[2]);
			}
		}
		if (vo.getReturnCell() != null) {
			String[] tmp = vo.getReturnCell().split("-");
			if (tmp.length == 3) {
				vo.setReturnCell1(tmp[0]);
				vo.setReturnCell2(tmp[1]);
				vo.setReturnCell3(tmp[2]);
			}
		}
		/* 사업자 번호 자르기 */
		String bizNo = vo.getBizNo();
		if (bizNo != null && bizNo.length() == 10) {
			vo.setBizNo1(bizNo.substring(0, 3));
			vo.setBizNo2(bizNo.substring(3, 5));
			vo.setBizNo3(bizNo.substring(5));
		}
		/* 우편 번호 자르기 */
		String postcode = vo.getPostcode();
		if (!"".equals(postcode) && postcode.length() == 6) {
			vo.setPostcode1(postcode.substring(0, 3));
			vo.setPostcode2(postcode.substring(3));
		}
		/* 반품 우편 번호 자르기 */
		String returnPostCode = vo.getReturnPostCode();
		if (!"".equals(returnPostCode) && returnPostCode.length() == 6) {
			vo.setReturnPostCode1(returnPostCode.substring(0, 3));
			vo.setReturnPostCode2(returnPostCode.substring(3));
		}
		
		/* 에디터 html 원복 */
		vo.setIntro(StringUtil.restoreClearXSS(vo.getIntro()));
		vo.setIntro(vo.getIntro().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		
		vo.setMainItem(StringUtil.restoreClearXSS(vo.getMainItem()));
		vo.setMainItem(vo.getMainItem().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		
		vo.setSocialActivity(StringUtil.restoreClearXSS(vo.getSocialActivity()));
		vo.setSocialActivity(vo.getSocialActivity().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		
		return vo;
	}
	
	public SellerVo getVoSimple(Integer seq) {
		return sellerDao.getVoSimple(seq);
	}

	/** 입점업체/총판 등록 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean regData(SellerVo vo) throws Exception {
		int result = 0;

		/* 문자열 패턴 생성 */
		this.combineData(vo);
		if (!StringUtil.isBlank(vo.getAccountNo())) {
			/* 계좌번호 암호화 */
			vo.setAccountNo(CrypteUtil.encrypt(vo.getAccountNo(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		result += userDao.insertData(vo);
		
		//에디터 이미지 업로드 기능 처리
		vo.setIntro(EditorUtil.procImage(vo.getIntro(), vo.getSeq(), "seller_intro"));
		vo.setMainItem(EditorUtil.procImage(vo.getMainItem(), vo.getSeq(), "seller_main_item"));
		vo.setSocialActivity(EditorUtil.procImage(vo.getSocialActivity(), vo.getSeq(), "seller_social_activity"));
		
		result += sellerDao.regSellerData(vo);

		if (result != 2) {
			/* insert 결과가 2가 아닐경우 롤백 */
			throw new Exception("등록 처리 DB개수가 일치하지 않습니다.");
		}

		return result > 0;
	}

	/** 입점업체/총판 수정 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean modData(SellerVo vo) throws Exception {
		int result = 0;
		/* 문자열 패턴 생성 */
		this.combineData(vo);
		if (!StringUtil.isBlank(vo.getAccountNo())) {
			/* 계좌번호 암호화 */
			vo.setAccountNo(CrypteUtil.encrypt(vo.getAccountNo(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		
		//에디터 이미지 업로드 기능 처리
		vo.setIntro(EditorUtil.procImage(vo.getIntro(), vo.getSeq(), "seller_intro"));
		vo.setMainItem(EditorUtil.procImage(vo.getMainItem(), vo.getSeq(), "seller_main_item"));
		vo.setSocialActivity(EditorUtil.procImage(vo.getSocialActivity(), vo.getSeq(), "seller_social_activity"));
		
		/* DB 업데이트 트랜잭션 처리 */
		result = sellerDao.modUserData(vo);
		if (result > 0) {
			// LOGGER.info("### procCnt1 : " +
			// result);
			result = result + sellerDao.modSellerData(vo);
			// LOGGER.info("### procCnt2 : " +
			// result);
			if (result != 2) {
				/* update 결과가 2가 아닐경우 롤백 */
				throw new Exception("업데이트 처리 DB개수가 일치하지 않습니다.");
			}
		}

		return result > 0;
	}

	/** 승인/폐점 처리 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean updateStatus(SellerVo vo) throws Exception {
		/* DB 업데이트 트랜잭션 처리 */
		int result = sellerDao.updateUserStatus(vo);
		if (result > 0) {
			// LOGGER.info("### procCnt1 : " +
			// result);
			result = result + sellerDao.updateSellerStatus(vo);
			// LOGGER.info("### procCnt2 : " +
			// result);
			if (result != 2) {
				/* update 결과가 2가 아닐경우 롤백 */
				throw new Exception("업데이트 처리 DB개수가 일치하지 않습니다.");
			}
		}
		return result > 0;
	}

	/** 사업자 번호 체크 */
	@Override
	public int getBizNoCnt(String bizNo) {
		return sellerDao.getBizNoCnt(bizNo);
	}

	private void combineData(SellerVo vo) {
		/* 사업자번호 붙이기 */
		if (!"".equals(vo.getBizNo1()) && !"".equals(vo.getBizNo2()) && !"".equals(vo.getBizNo3())) {
			StringBuffer bizNo = new StringBuffer();
			bizNo.append(vo.getBizNo1());
			bizNo.append(vo.getBizNo2());
			bizNo.append(vo.getBizNo3());
			vo.setBizNo(bizNo.toString());
		}
		/* 우편번호 붙이기 */
		if (!"".equals(vo.getPostcode1()) && !"".equals(vo.getPostcode2())) {
			StringBuffer postcode = new StringBuffer();
			postcode.append(vo.getPostcode1());
			postcode.append(vo.getPostcode2());
			vo.setPostcode(postcode.toString());
		}
		/* 반품 우편번호 붙이기 */
		if (!"".equals(vo.getReturnPostCode1()) && !"".equals(vo.getReturnPostCode2())) {
			StringBuffer returnPostCode = new StringBuffer();
			returnPostCode.append(vo.getReturnPostCode1());
			returnPostCode.append(vo.getReturnPostCode2());
			vo.setReturnPostCode(returnPostCode.toString());
		}
	}

	/** 요청을 위한 임시 매핑(지워야함) */
	@Override
	public UserVo getSellerSeq(String id) {
		return sellerDao.getSellerSeq(id);
	}

	/** 입점업체 엑셀 다운로드 */
	@Override
	public Workbook writeExcelSellerList(SellerVo vo, String type) {
		Workbook wb;

		/* 타이틀 항목 생성 */
		int ArrSize = 12;
		String[] strTitle = new String[ArrSize];
		int idx = 0;
		strTitle[idx++] = "No.";
		strTitle[idx++] = "아이디";
		strTitle[idx++] = "상호명";
		strTitle[idx++] = "상점명";
		strTitle[idx++] = "등록 상품수\n(판매중/전체)";
		strTitle[idx++] = "상태";
		strTitle[idx++] = "대표자명";
		strTitle[idx++] = "대표전화";
		strTitle[idx++] = "담당자명";
		strTitle[idx++] = "담당자 전화번호";
		strTitle[idx++] = "승인일자";
		strTitle[idx++] = "등록일자";

		/* 주문리스트 */
		vo.setTypeCode("S"); // 입점업체만 가져온다
		List<SellerVo> list = sellerDao.getList(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				SellerVo svo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(ArrSize);
				cell.add(svo.getSeq());
				cell.add(svo.getId());
				cell.add(svo.getName());
				cell.add(svo.getNickname());
				cell.add(svo.getSellItemCount() + "/" + svo.getTotalItemCount());
				cell.add(svo.getStatusText());
				cell.add(svo.getCeoName());
				cell.add(svo.getTel());
				cell.add(svo.getSalesName());
				cell.add(svo.getSalesTel());
				cell.add(svo.getApprovalDate());
				cell.add(svo.getRegDate());
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, type, 0);

		return wb;
	}

	@Override
	public UserVo getShopSellerSeq(SellerVo vo) {
		return sellerDao.getShopSellerSeq(vo);
	}

	@Override
	public int getSellerRegCntForWeek() {
		return sellerDao.getSellerRegCntForWeek();
	}

	@Override
	public int updateComment(SellerVo vo) {
		return sellerDao.updateComment(vo);
	}
	
	public Integer getSeqByOldSeq(Integer oldSeq) {
		return sellerDao.getSeqByOldSeq(oldSeq);
	}

	@Override
	public boolean deleteSeller(Integer seq) {
		return sellerDao.deleteSeller(seq) > 0;
	}

	@Override
	public String getTotlaSellFinishCount(Integer sellerSeq){ return sellerDao.getTotlaSellFinishCount(sellerSeq);}

	@Override
	public String getTotalSellFinishPrice(Integer sellerSeq){return sellerDao.getTotalSellFinishPrice(sellerSeq);}

}
