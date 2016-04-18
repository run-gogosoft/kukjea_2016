package com.smpro.service;

import com.smpro.dao.PointDao;
import com.smpro.util.ExcelUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.PointVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Service
public class PointServiceImpl implements PointService {
	@Autowired
	private PointDao pointDao;

	public List<PointVo> getList(PointVo vo) {
		return pointDao.getList(vo);
	}

	public int getListCount(PointVo vo) {
		return pointDao.getListCount(vo);
	}

	public PointVo getVo(PointVo vo) {
		return pointDao.getVo(vo);
	}

	public List<PointVo> getDetailList(PointVo vo) {
		return pointDao.getDetailList(vo);
	}

	public Integer getDetailListCount(PointVo vo) {
		return pointDao.getDetailListCount(vo);
	}

	public List<PointVo> getShopPointList(PointVo vo) {
		return pointDao.getShopPointList(vo);
	}

	public int getShopPointCount(PointVo vo) {
		return pointDao.getShopPointCount(vo);
	}

	public boolean updateData(PointVo vo) {
		return pointDao.updateData(vo) > 0;
	}

	public boolean insertData(PointVo vo) {
		return pointDao.insertData(vo) > 0;
	}

	public boolean insertHistoryData(PointVo vo) {
		return pointDao.insertHistoryData(vo) > 0;
	}

	public boolean insertLogData(PointVo vo) {
		return pointDao.insertLogData(vo) > 0;
	}

	public List<PointVo> getBatchPointForEndDate() {
		return pointDao.getBatchPointForEndDate();
	}

	public List<PointVo> getShopPointListForAllCancel(PointVo vo) {
		return pointDao.getShopPointListForAllCancel(vo);
	}

	public Integer getUseablePoint(Integer memberSeq) {
		return pointDao.getUseablePoint(memberSeq);
	}

	// 포인트 취소 대상 건 가져오기
	public PointVo getHistoryForCancel(Integer orderSeq) {
		return pointDao.getHistoryForCancel(orderSeq);
	}

	// 포인트 기 취소내역 체크(중복처리 방지용)
	public int checkCancel(PointVo vo) {
		return pointDao.checkCancel(vo);
	}

	// 포인트 사용 내역 리스트(주문번호별)
	public List<PointVo> getHistoryList(Integer orderSeq) {
		return pointDao.getHistoryList(orderSeq);
	}

	/** 엑셀 데이터 유효성 체크 */
	public String chkXlsData(String[] row) {
		String errPosMsg = "";

		/* 회원 시퀀스 */
		String id = row[0];
		/* 만료일 */
		String endDate = row[1];
		/* 지급포인트 */
		String point = row[2];
		/* 사용 구분 */
		String validFlag = row[3];
		/* 적립 방식 */
		String saveCode = row[4];
		/* 비고 */
		String comment = row[5];

		if (row.length > 6) {
			errPosMsg += " 잘못된 포인트 등록 양식 입니다.";
			return errPosMsg;
		}
		/* 필수값 체크 */
		if (StringUtil.isBlank(id)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 회원 아이디는 반드시 입력되어야 합니다";
		}
		if (StringUtil.isBlank(endDate)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 만료일은 반드시 입력되어야 합니다";
		} else if (!endDate.matches("^([0-9]{4})+-([0-9]{2})+-([0-9]{2})*$")) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 만료일을 날짜 형식으로 입력해주세요( yyyy-mm-dd )";
		}
		if (StringUtil.isBlank(point)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 지급포인트는 반드시 입력되어야 합니다";
		} else if (!point.matches("^[0-9]*$")) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 지급포인트는 숫자만 입력 가능합니다";
		}
		if (StringUtil.isBlank(validFlag)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 사용구분은 반드시 입력되어야 합니다";
		} else if (!validFlag.matches("^[YN]$")) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 사용구분은 Y,N으로 입력되어야 합니다";
		}
		if (StringUtil.isBlank(saveCode)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 적립방식은 반드시 입력되어야 합니다";
		} else if (!saveCode.matches("^[123]$")) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 적립방식은 1,2,3으로 입력되어야 합니다";
		}
		if (StringUtil.isBlank(comment)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 비고는 반드시 입력되어야 합니다";
		}
		if (StringUtil.getByteLength(comment) > 200) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 비고가 200Bytes를 초과하였습니다";
		}

		return errPosMsg;
	}

	public Integer getExcelDownListCount(PointVo vo) {
		return pointDao.getExcelDownListCount(vo);
	}

	public List<PointVo> getExcelDownList(PointVo vo) {
		return pointDao.getExcelDownList(vo);
	}

	/** 포인트 엑셀 다운로드 */
	public Workbook writeExcelPointList(PointVo vo, String type) {
		/* 포인트리스트 */
		Workbook wb;
		int arraySize = 7;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arraySize];
		int idx = 0;
		strTitle[idx++] = "아이디";
		strTitle[idx++] = "이름";
		strTitle[idx++] = "쇼핑몰";
		strTitle[idx++] = "지급포인트";
		strTitle[idx++] = "지급일";
		strTitle[idx++] = "비고";
		strTitle[idx++] = "사용가능여부";

		List<PointVo> list = pointDao.getExcelDownList(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				PointVo ovo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(arraySize);
				cell.add(ovo.getId());
				cell.add(ovo.getName());
				cell.add(ovo.getMallName());
				cell.add(StringUtil.formatAmount(ovo.getPoint()));
				cell.add(StringUtil.isBlank(ovo.getRegDate()) ? "" : ovo.getRegDate().substring(0, 10));
				cell.add(ovo.getReserveComment());
				if ("Y".equals(ovo.getValidFlag())) {
					ovo.setValidFlag("가능");
				} else {
					ovo.setValidFlag("불가능");
				}
				cell.add(ovo.getValidFlag());
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.pointExcel(strTitle, row, type, 0);

		return wb;
	}

	/** 포인트 엑셀 다운로드 */
	public Workbook writePointList(PointVo vo, String type) {
		/* 포인트리스트 */
		Workbook wb;
		int arraySize = 5;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arraySize];
		int idx = 0;
		strTitle[idx++] = "아이디";
		strTitle[idx++] = "이름";
		strTitle[idx++] = "쇼핑몰";
		strTitle[idx++] = "총적립포인트";
		strTitle[idx++] = "잔여포인트";

		List<PointVo> list = pointDao.getList(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				PointVo ovo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(arraySize);
				cell.add(ovo.getId());
				cell.add(ovo.getName());
				cell.add(ovo.getMallName());
				cell.add(StringUtil.formatAmount(ovo.getPoint()));
				cell.add(StringUtil.formatAmount(ovo.getUseablePoint()));
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.pointExcel(strTitle, row, type, 0);

		return wb;
	}

	/** 포인트 상세 리스트 엑셀 다운로드 */
	public Workbook writeDetailPointList(PointVo vo, String type) {
		/* 포인트리스트 */
		Workbook wb;

		int memSize = 4;
		/* 타이틀 항목 생성 */
		String[] memTitle = new String[memSize];
		int idxF = 0;
		memTitle[idxF++] = "회원 아이디";
		memTitle[idxF++] = "회원 이름";
		memTitle[idxF++] = "회원 쇼핑몰";
		memTitle[idxF++] = "잔여포인트";

		PointVo pvo = new PointVo();
		pvo.setMemberSeq(vo.getMemberSeq());
		pvo = pointDao.getVo(pvo);

		/* 타이틀 항목 생성 */
		String[] memVo = new String[memSize];
		int idxS = 0;
		memVo[idxS++] = pvo.getId();
		memVo[idxS++] = pvo.getName();
		memVo[idxS++] = pvo.getMallName();
		memVo[idxS++] = StringUtil.formatAmount(pvo.getUseablePoint());

		int arraySize = 6;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arraySize];
		int idx = 0;
		strTitle[idx++] = "발생일";
		strTitle[idx++] = "포인트";
		strTitle[idx++] = "상태";
		strTitle[idx++] = "주문번호";
		strTitle[idx++] = "상품주문번호";
		strTitle[idx++] = "비고";

		List<PointVo> list = pointDao.getShopPointList(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				PointVo ovo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(arraySize);
				cell.add(ovo.getRegDate().substring(0, 10));
				cell.add(StringUtil.formatAmount(ovo.getPoint()));
				if ("S".equals(ovo.getStatusCode())) {
					cell.add("적립");
				} else if ("U".equals(ovo.getStatusCode())) {
					cell.add("사용");
				} else if ("D".equals(ovo.getStatusCode())) {
					cell.add("소멸");
				} else if ("C".equals(ovo.getStatusCode())) {
					cell.add("취소적립");
				}
				cell.add(ovo.getOrderSeq());
				cell.add(ovo.getOrderDetailSeq());
				cell.add(ovo.getNote());
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil
				.pointDetailExcel(strTitle, memTitle, memVo, row, type, 0);

		return wb;
	}

	/** 포인트 상세 리스트 엑셀 다운로드(모든회원) */
	public Workbook writePointAllList(PointVo vo, String type) {
		/* 포인트리스트 */
		Workbook wb;

		int arraySize = 8;
		/* 타이틀 항목 생성 */
		String[] strTitle = new String[arraySize];
		int idx = 0;
		strTitle[idx++] = "발생일";
		strTitle[idx++] = "포인트";
		strTitle[idx++] = "회원명";
		strTitle[idx++] = "쇼핑몰";
		strTitle[idx++] = "상태";
		strTitle[idx++] = "주문번호";
		strTitle[idx++] = "상품주문번호";
		strTitle[idx++] = "비고";

		List<PointVo> list = pointDao.getShopPointList(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				PointVo ovo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(arraySize);
				cell.add(ovo.getRegDate().substring(0, 10));
				cell.add(StringUtil.formatAmount(ovo.getPoint()));
				cell.add(ovo.getName());
				cell.add(ovo.getMallName());
				if ("S".equals(ovo.getStatusCode())) {
					cell.add("적립");
				} else if ("U".equals(ovo.getStatusCode())) {
					cell.add("사용");
				} else if ("D".equals(ovo.getStatusCode())) {
					cell.add("소멸");
				} else if ("C".equals(ovo.getStatusCode())) {
					cell.add("취소적립");
				}
				cell.add(ovo.getOrderSeq());
				cell.add(ovo.getOrderDetailSeq());
				cell.add(ovo.getNote());
				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.pointExcel(strTitle, row, type, 0);

		return wb;
	}
	
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public boolean regPoint(PointVo vo) {
		insertData(vo);
		vo.setPointSeq(vo.getSeq());
		vo.setNote(vo.getReserveComment());
		insertHistoryData(vo);
		insertLogData(vo);
		return true;
	}
}
