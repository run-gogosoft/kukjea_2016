package com.smpro.service;

import com.smpro.dao.AdjustDao;
import com.smpro.dao.OrderDao;
import com.smpro.util.ExcelUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.AdjustVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Service
public class AdjustServiceImpl implements AdjustService {
	@Autowired
	private OrderDao orderDao;

	@Autowired
	private AdjustDao adjustDao;

	/** 정산 대상 리스트 가져오기 */
	@Override
	public List<AdjustVo> getListForAdjust() {
		return adjustDao.getListForAdjust();
	}

	/** 취소 정산 대상 리스트 가져오기 */
	@Override
	public List<AdjustVo> getListForAdjustCancel() {
		return adjustDao.getListForAdjustCancel();
	}

	/** 정산 배치 데이터 등록 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int regVo(List<AdjustVo> list) throws Exception {
		int cnt = 0;
		for (AdjustVo vo : list) {
			if ("Y".equals(vo.getCancelFlag())) {
				if (adjustDao.regVo(vo) == 1) {
					cnt++;
				} else {
					throw new Exception("### 취소 정산 DB 등록 처리중 오류 발생");
				}
			} else {
				if (adjustDao.regVo(vo) == 1) {
					if (adjustDao.updateAdjustFlag(vo.getOrderDetailSeq()) == 1) {
						cnt++;
					} else {
						throw new Exception("### 주문 정산여부 DB 업데이트 처리중 오류 발생");
					}
				} else {
					throw new Exception("### 정산 DB 등록 처리중 오류 발생");
				}
			}
		}
		return cnt;
	}
	
	/** 정산내역 수동 추가 */
	@Override
	public int regVo(AdjustVo vo) {
		return adjustDao.regVo(vo);
	}

	/** 정산 리스트 */
	@Override
	public List<AdjustVo> getList(AdjustVo pvo) {
		return adjustDao.getList(pvo);
	}

	/** 정산 주문 리스트 */
	@Override
	public List<AdjustVo> getOrderList(AdjustVo pvo) {
		return adjustDao.getOrderList(pvo);
	}

	/** 정산 상태 업데이트 */
	@Override
	public int updateStatus(AdjustVo vo) {
		return adjustDao.updateStatus(vo);
	}

	/** 정산 내역 삭제 */
	@Override
	public int delVo(Integer seq) {
		return adjustDao.delVo(seq);
	}
	
	/** 입점업체별 정산리스트 엑셀 생성 */
	@Override
	public Workbook getListExcel(AdjustVo pvo, String type) {
		Workbook wb;

		/* 타이틀 항목 생성 */
		String[] strTitle = new String[6];
		int idx = 0;
		strTitle[idx++] = "정산 확정 년월";
		strTitle[idx++] = "입점업체명";
		strTitle[idx++] = "완료 여부";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "공급가";
		strTitle[idx++] = "배송비";

		/* 주문리스트 */
		List<AdjustVo> list = adjustDao.getList(pvo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				AdjustVo vo = list.get(i);
				ArrayList<Object> cell = new ArrayList<>();

				cell.add(vo.getAdjustDate());
				cell.add(vo.getSellerName());
				cell.add("Y".equals(vo.getCompleteFlag()) ? "완료" : "미완료");
				cell.add(new Integer(vo.getSellPrice()));
				cell.add(new Integer(vo.getSupplyPrice()));
				cell.add(new Integer(vo.getDeliCost()));

				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, type, 0);

		return wb;
	}

	/** 입점업체별 정산 주문 리스트 엑셀 생성 */
	@Override
	public Workbook getListExcelOrder(AdjustVo pvo, String type) {
		Workbook wb;

		/* 타이틀 항목 생성 */
		String[] strTitle = new String[14];
		int idx = 0;
		strTitle[idx++] = "주문 년월";
		strTitle[idx++] = "정산 완료일";
		strTitle[idx++] = "입점업체명";
		strTitle[idx++] = "결제 수단";
		strTitle[idx++] = "상품주문번호";
		strTitle[idx++] = "상품명";
		strTitle[idx++] = "과세/면세";
		strTitle[idx++] = "정산구분";
		strTitle[idx++] = "수량";
		strTitle[idx++] = "판매가";
		strTitle[idx++] = "공급가";
		strTitle[idx++] = "배송비";
		strTitle[idx++] = "주문자";
		strTitle[idx++] = "수취인";

		/* 데이터 생성 */
		Vector<ArrayList<Object>> rows = new Vector<>();
		
		/* 주문리스트 */
		List<AdjustVo> list = adjustDao.getOrderList(pvo);

		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				AdjustVo vo = list.get(i);
				ArrayList<Object> cell = new ArrayList<>();

				cell.add(vo.getOrderYm());
				cell.add(vo.getCompleteDate());
				cell.add(vo.getSellerName());
				cell.add(vo.getPayMethodName());
				cell.add(vo.getOrderDetailSeq());
				cell.add(vo.getItemName());
				if ("1".equals(vo.getTaxCode())) {
					cell.add("과세");
				} else if ("2".equals(vo.getTaxCode())) {
					cell.add("면세");
				} else {
					cell.add("");
				}
				cell.add("Y".equals(vo.getCancelFlag()) ? "취소" : "정상");
				cell.add(StringUtil.formatAmount(vo.getOrderCnt()));
				if ("Y".equals(vo.getCancelFlag())) {
					cell.add(StringUtil.formatAmount(-vo.getSellPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(-vo.getSupplyPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(-vo.getDeliCost()));
				} else {
					cell.add(StringUtil.formatAmount(vo.getSellPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(vo.getSupplyPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(vo.getDeliCost()));
				}
				cell.add(vo.getMemberName());
				cell.add(vo.getReceiverName());
				

				rows.add(cell);
			}
		}
		
		/* 수동 추가 내역 리스트 */
		pvo.setManualFlag("Y");
		List<AdjustVo> manualList = adjustDao.getOrderList(pvo);

		if (manualList != null && manualList.size() > 0) {
			for (int i = 0; i < manualList.size(); i++) {
				AdjustVo vo = manualList.get(i);
				ArrayList<Object> cell = new ArrayList<>();

				cell.add("");
				cell.add("금액조정사유");
				cell.add(vo.getReason());
				cell.add("");
				cell.add("");
				cell.add("");
				cell.add("");
				cell.add("Y".equals(vo.getCancelFlag()) ? "취소" : "정상");
				cell.add(StringUtil.formatAmount(vo.getOrderCnt()));
				if ("Y".equals(vo.getCancelFlag())) {
					cell.add(StringUtil.formatAmount(-vo.getSellPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(-vo.getSupplyPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(-vo.getDeliCost()));
				} else {
					cell.add(StringUtil.formatAmount(vo.getSellPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(vo.getSupplyPrice() * vo.getOrderCnt()));
					cell.add(StringUtil.formatAmount(vo.getDeliCost()));
				}
				cell.add(vo.getMemberName());
				cell.add(vo.getReceiverName());
				
				rows.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, rows, type, 0);

		return wb;
	}

}
