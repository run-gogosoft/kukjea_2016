package com.smpro.util;

import com.smpro.vo.OrderVo;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class ExcelUtil {
	public static Vector<ArrayList<Object>> read(InputStream xlsFile) throws IOException {
		HSSFWorkbook wb = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFCell cell = null;
		Vector<ArrayList<Object>> v = new Vector<>();
		ArrayList<Object> ar = null;

		POIFSFileSystem fs = new POIFSFileSystem(xlsFile);
		wb = new HSSFWorkbook(fs);
		sheet = wb.getSheetAt(0);
		int rows = sheet.getPhysicalNumberOfRows();
		for (int r = 0; r < rows; r++) {
			row = sheet.getRow(r);
			if(row == null) continue;
			ar = new ArrayList<>();
			int cells = row.getLastCellNum();

			for (int q = 0; q < cells; q++) {
				cell = row.getCell(q);
				if (cell != null) {
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_FORMULA:
						ar.add(cell.getCellFormula());
						break;
					case Cell.CELL_TYPE_NUMERIC:
						// 정수/실수 구분
						double numeric_d = cell.getNumericCellValue();
						int numeric_i = (int) numeric_d;
						if (numeric_d - numeric_i == 0.0) {
							ar.add(new Integer((int) cell.getNumericCellValue()));
						} else {
							ar.add(new Double(cell.getNumericCellValue()));
						}
						break;
					case Cell.CELL_TYPE_STRING:
						ar.add(cell.getRichStringCellValue().getString().trim());
						break;
					case Cell.CELL_TYPE_BLANK:
						ar.add("");
						break;
					case Cell.CELL_TYPE_BOOLEAN:
						ar.add(new Boolean(cell.getBooleanCellValue()));
						break;
					case Cell.CELL_TYPE_ERROR:
						ar.add("");
						break;
					default:
						break;
					}
				} else {
					ar.add("");
				}
			}
			v.add(ar);
		}

		wb.close();

		return v;
	}

	public static Workbook pointExcel(String[] strTitle, Vector<ArrayList<Object>> strList, String type, int startRowNo) {
		// 초기화
		Workbook wb = null;
		Row row = null;
		Font font = null;
		Sheet sheet = null;
		// 엑셀 유형 분기
		if ("xlsx".equals(type)) {
			wb = new XSSFWorkbook();
		} else {
			wb = new HSSFWorkbook();
		}
		// 시트 생성
		sheet = wb.createSheet("List");

		// 스타일 선언
		CellStyle style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 색 채우기
		style.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.WHITE.getIndex());
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(font);

		/* 제목 */
		// 행 생성
		row = sheet.createRow(startRowNo);
		// 셀 작성
		for (int j = 0; j < strTitle.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(strTitle[j]);
			cell.setCellStyle(style);
		}

		/* 내용 */
		// 스타일 선언
		style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.BLACK.getIndex());
		style.setFont(font);

		if (strList != null && strList.size() > 0) {
			for (int i = 0; i < strList.size(); i++) {
				ArrayList<Object> strData = strList.get(i);
				// 행 생성
				row = sheet.createRow(i + startRowNo + 1);
				// 셀 작성
				for (int j = 0; j < strData.size(); j++) {
					// Set Cell
					Cell cell = row.createCell(j);

					// Debug
					// LOGGER.info("cell[" + j + "] "
					// + strData.get(j));

					// 자료형에 따라 분기
					if (strData.get(j) == null) {
						cell.setCellValue("");
					}
					if (strData.get(j) instanceof String) {
						// String
						cell.setCellValue(String.valueOf(strData.get(j)));
					} else {
						// Integer or Double
						try {
							// 정수/실수 구분
							double numeric_d = Double.parseDouble(String
									.valueOf(strData.get(j)));
							int numeric_i = Integer.parseInt(String
									.valueOf(strData.get(j)));

							if (numeric_d - numeric_i == 0.0) {
								cell.setCellValue(numeric_i);
							} else {
								cell.setCellValue(numeric_d);
							}
						} catch (Exception e) {
							cell.setCellValue("");
						}
					}
					cell.setCellStyle(style);
				}
			}
		}

		// 셀 가로사이즈 자동 조절
		for (int i = 0; i < strTitle.length; i++) {
			sheet.autoSizeColumn(i);
		}

		return wb;
	}

	public static Workbook pointDetailExcel(String[] strTitle, String[] memTitle, String[] memVo, Vector<ArrayList<Object>> strList, String type, int startRowNo) {
		// 초기화
		Workbook wb = null;
		Row row = null;
		Font font = null;
		Sheet sheet = null;
		// 엑셀 유형 분기
		if ("xlsx".equals(type)) {
			wb = new XSSFWorkbook();
		} else {
			wb = new HSSFWorkbook();
		}
		// 시트 생성
		sheet = wb.createSheet("List");

		// 스타일 선언
		CellStyle style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 색 채우기
		style.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.WHITE.getIndex());
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(font);

		/* 제목 */
		// 행 생성
		row = sheet.createRow(startRowNo);
		// 셀 작성
		for (int j = 0; j < memTitle.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(memTitle[j]);
			cell.setCellStyle(style);
		}

		// 행 생성
		row = sheet.createRow(startRowNo + 3);
		// 셀 작성
		for (int j = 0; j < strTitle.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(strTitle[j]);
			cell.setCellStyle(style);
		}

		/* 내용 */
		// 스타일 선언
		style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.BLACK.getIndex());
		style.setFont(font);

		row = sheet.createRow(startRowNo + 1);
		// 셀 작성
		for (int j = 0; j < memVo.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(memVo[j]);
			cell.setCellStyle(style);
		}

		if (strList != null && strList.size() > 0) {
			for (int i = 0; i < strList.size(); i++) {
				ArrayList<Object> strData = strList.get(i);
				// 행 생성
				row = sheet.createRow(i + startRowNo + 4);
				// 셀 작성
				for (int j = 0; j < strData.size(); j++) {
					// Set Cell
					Cell cell = row.createCell(j);

					// Debug
					// LOGGER.info("cell[" + j + "] "
					// + strData.get(j));

					// 자료형에 따라 분기
					if (strData.get(j) == null) {
						cell.setCellValue("");
					}
					if (strData.get(j) instanceof String) {
						// String
						cell.setCellValue(String.valueOf(strData.get(j)));
					} else {
						// Integer or Double
						try {
							// 정수/실수 구분
							double numeric_d = Double.parseDouble(String.valueOf(strData.get(j)));
							int numeric_i = Integer.parseInt(String.valueOf(strData.get(j)));

							if (numeric_d - numeric_i == 0.0) {
								cell.setCellValue(numeric_i);
							} else {
								cell.setCellValue(numeric_d);
							}
						} catch (Exception e) {
							cell.setCellValue("");
						}
					}
					cell.setCellStyle(style);
				}
			}
		}

		// 셀 가로사이즈 자동 조절
		for (int i = 0; i < strTitle.length; i++) {
			sheet.autoSizeColumn(i);
		}

		return wb;
	}

	/**
	 * 엑셀 포맷 데이터 생성
	 * 
	 * @param strTitle
	 *            항목 타이틀
	 * @param strList
	 *            데이터 리스트
	 * @param type
	 *            엑셀 유형 (xls, xlsx)
	 * @return
	 */
	public static Workbook writeExcel(String[] strTitle, Vector<ArrayList<Object>> strList, String type, int startRowNo) {
		// 초기화
		Workbook wb = null;
		Row row = null;
		Font font = null;
		Sheet sheet = null;
		// 엑셀 유형 분기
		if ("xlsx".equals(type)) {
			wb = new XSSFWorkbook();
		} else {
			wb = new HSSFWorkbook();
		}
		// 시트 생성
		sheet = wb.createSheet("List");

		// 스타일 선언
		CellStyle style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 색 채우기
		style.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.WHITE.getIndex());
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(font);

		/* 제목 */
		// 행 생성
		row = sheet.createRow(startRowNo);
		// 셀 작성
		for (int j = 0; j < strTitle.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(strTitle[j]);
			cell.setCellStyle(style);
		}

		/* 내용 */
		// 스타일 선언
		style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.BLACK.getIndex());
		style.setFont(font);

		if (strList != null && strList.size() > 0) {
			for (int i = 0; i < strList.size(); i++) {
				ArrayList<Object> strData = strList.get(i);
				// 행 생성
				row = sheet.createRow(i + startRowNo + 1);
				// 셀 작성
				for (int j = 0; j < strData.size(); j++) {
					// Set Cell
					Cell cell = row.createCell(j);

					// Debug
					// LOGGER.info("cell[" + j + "] "
					// + strData.get(j));

					// 자료형에 따라 분기
					if (strData.get(j) == null) {
						cell.setCellValue("");
					}
					if (strData.get(j) instanceof String) {
						// String
						cell.setCellValue(String.valueOf(strData.get(j)));
					} else {
						// Integer or Double
						try {
							// 정수/실수 구분
							double numeric_d = Double.parseDouble(String.valueOf(strData.get(j)));
							int numeric_i = Integer.parseInt(String.valueOf(strData.get(j)));

							if (numeric_d - numeric_i == 0.0) {
								cell.setCellValue(numeric_i);
							} else {
								cell.setCellValue(numeric_d);
							}
						} catch (Exception e) {
							cell.setCellValue("");
						}
					}
					cell.setCellStyle(style);
				}
			}
		}

		// 셀 가로사이즈 자동 조절
		for (int i = 0; i < strTitle.length; i++) {
			sheet.autoSizeColumn(i);
		}

		return wb;
	}

	/**
	 * 주문 엑셀 포맷 데이터 생성
	 */
	public static Workbook writeExcelOrderList(String[] strTitle, Vector<ArrayList<Object>> strList, String type, int startRowNo, List<OrderVo> list, String loginType) {
		// 초기화
		Workbook wb = null;
		Row row = null;
		Font font = null;
		Sheet sheet = null;
		// 엑셀 유형 분기
		if ("xlsx".equals(type)) {
			wb = new XSSFWorkbook();
		} else {
			wb = new HSSFWorkbook();
		}
		// 시트 생성
		sheet = wb.createSheet("List");
		// 스타일 선언
		CellStyle style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 색 체우기
		style.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.WHITE.getIndex());
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(font);

		/* 제목 */
		// 행 생성
		row = sheet.createRow(startRowNo);
		// 셀 작성
		for (int j = 0; j < strTitle.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(strTitle[j]);
			cell.setCellStyle(style);
		}

		/* 내용 */
		// 스타일 선언
		style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.BLACK.getIndex());
		style.setFont(font);

		Integer notSumDuplicateOrderSeq = null;
		if (strList != null && strList.size() > 0) {
			for (int i = 0; i < strList.size(); i++) {
				ArrayList<Object> strData = strList.get(i);
				OrderVo ovo = list.get(i);

				// 행 생성
				row = sheet.createRow(i + startRowNo + 1);
				// 셀 작성
				for (int j = 0; j < strData.size(); j++) {
					// Set Cell
					Cell cell = row.createCell(j);

					// Debug
					// LOGGER.info("cell[" + j + "] "
					// + strData.get(j));

					// 자료형에 따라 분기
					if (strData.get(j) == null) {
						cell.setCellValue("");
					}
					if (strData.get(j) instanceof String) {
						// String
						cell.setCellValue(String.valueOf(strData.get(j)));
					} else {
						// Integer or Double
						try {
							// 정수/실수 구분
							double numeric_d = Double.parseDouble(String.valueOf(strData.get(j)));
							int numeric_i = Integer.parseInt(String.valueOf(strData.get(j)));
							// 엑셀파일 하단에 총주문금액 * row수만큼 더해진 값이 보이기 장바구니 주문일경우 첫번째
							// row만 값을 입력하고
							// 나머지 row는 0이들어가게 수정
							if (j == 19 || j == 20 || j == 21) {
								if (notSumDuplicateOrderSeq != null && notSumDuplicateOrderSeq.equals(ovo.getOrderSeq())) {
									cell.setCellValue(0);
								} else {
									if (numeric_d - numeric_i == 0.0) {
										cell.setCellValue(numeric_i);
									} else {
										cell.setCellValue(numeric_d);
									}
								}
							} else {
								if (numeric_d - numeric_i == 0.0) {
									cell.setCellValue(numeric_i);
								} else {
									cell.setCellValue(numeric_d);
								}
							}
						} catch (Exception e) {
							cell.setCellValue("");
						}
					}
					cell.setCellStyle(style);
				}
				// 엑셀파일 하단에 총주문금액 * row수만큼 더해진 값이 보이기 장바구니 주문일경우 첫번째 row만 값을
				// 입력하고
				// 나머지 row는 0이들어가게 수정
				if (ovo.getOrderCount() > 1) {
					notSumDuplicateOrderSeq = ovo.getOrderSeq();
				}
			}
		}

		// 셀병합
		Integer duplicateOrderSeq = null;
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrderVo ovo = list.get(i);
				
				
				if (duplicateOrderSeq != null && duplicateOrderSeq.equals(ovo.getOrderSeq())) {
					continue;
				}

				if (ovo.getOrderCount() > 1) {
					// 셀병합, i에+1을 해주는 이유는 첫번쨰 행은 제목이라서
					// i를 최초에 1로 초기화 하지않는 이유는 array index 에러 발생이 되기 때문
					// 현재 로그인한 타입이 어드민일때만 보여준다
					if ("A".equals(loginType)) {
						sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 19, 19));
						sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 20, 20));
						sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 21, 21));
					}

					duplicateOrderSeq = ovo.getOrderSeq();
				}
			}
		}

		// 셀 가로사이즈 자동 조절
		for (int i = 0; i < strTitle.length; i++) {
			sheet.autoSizeColumn(i);
		}

		return wb;
	}

	/**
	 * 후청구주문 엑셀 포맷 데이터 생성
	 */
	public static Workbook writeExcelOrderListNp(String[] strTitle, Vector<ArrayList<Object>> strList, String type, int startRowNo, List<OrderVo> list) {
		// 초기화
		Workbook wb = null;
		Row row = null;
		Font font = null;
		Sheet sheet = null;
		// 엑셀 유형 분기
		if ("xlsx".equals(type)) {
			wb = new XSSFWorkbook();
		} else {
			wb = new HSSFWorkbook();
		}
		// 시트 생성
		sheet = wb.createSheet("List");

		// 스타일 선언
		CellStyle style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 색 채우기
		style.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.WHITE.getIndex());
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(font);

		/* 제목 */
		// 행 생성
		row = sheet.createRow(startRowNo);
		// 셀 작성
		for (int j = 0; j < strTitle.length; j++) {
			// Set Cell
			Cell cell = row.createCell(j);
			cell.setCellValue(strTitle[j]);
			cell.setCellStyle(style);
		}

		/* 내용 */
		// 스타일 선언
		style = wb.createCellStyle();
		// 개행 가능
		style.setWrapText(true);
		// 정렬
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 외각선
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		// 폰트
		font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Malgun Gothic");
		font.setColor(IndexedColors.BLACK.getIndex());
		style.setFont(font);

		if (strList != null && strList.size() > 0) {
			for (int i = 0; i < strList.size(); i++) {
				ArrayList<Object> strData = strList.get(i);
				// 행 생성
				row = sheet.createRow(i + startRowNo + 1);
				// 셀 작성
				for (int j = 0; j < strData.size(); j++) {
					// Set Cell
					Cell cell = row.createCell(j);

					// Debug
					// LOGGER.info("cell[" + j + "] "
					// + strData.get(j));

					// 자료형에 따라 분기
					if (strData.get(j) == null) {
						cell.setCellValue("");
					}
					if (strData.get(j) instanceof String) {
						// String
						cell.setCellValue(String.valueOf(strData.get(j)));
					} else {
						// Integer or Double
						try {
							// 정수/실수 구분
							double numeric_d = Double.parseDouble(String.valueOf(strData.get(j)));
							int numeric_i = Integer.parseInt(String.valueOf(strData.get(j)));

							if (numeric_d - numeric_i == 0.0) {
								cell.setCellValue(numeric_i);
							} else {
								cell.setCellValue(numeric_d);
							}
						} catch (Exception e) {
							cell.setCellValue("");
						}
					}
					cell.setCellStyle(style);
				}
			}
		}

		// 셀병합
		Integer duplicateOrderSeq = null;
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrderVo ovo = list.get(i);
				
				if (duplicateOrderSeq != null && duplicateOrderSeq.equals(ovo.getOrderSeq())) {
					continue;
				}

				if (ovo.getOrderCount() > 1) {
					// 셀병합, i에+1을 해주는 이유는 첫번쨰 행은 제목이라서
					// i를 최초에 1로 초기화 하지않는 이유는 array index 에러 발생이 되기 때문

					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 0, 0));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 1, 1));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 2, 2));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 3, 3));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 4, 4));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 5, 5));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 6, 6));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 7, 7));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 12, 12));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 13, 13));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 14, 14));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 15, 15));
					sheet.addMergedRegion(new CellRangeAddress(i + 1, i	+ ovo.getOrderCount(), 16, 16));
										
					duplicateOrderSeq = ovo.getOrderSeq();
				}
			}
		}
				
		// 셀 가로사이즈 자동 조절
		for (int i = 0; i < strTitle.length; i++) {
			sheet.autoSizeColumn(i);
		}

		return wb;
	}
	
	/**
	 * 엑셀 데이터 읽어오기
	 * 
	 * @param xlsFile
	 *            엑셀파일
	 * @param type
	 *            엑셀 유형 (xls, xlsx)
	 * @param startLine
	 *            엑셀 읽어올 행 시작라인
	 * @return
	 */
	public static Vector<ArrayList<Object>> readExcel(InputStream xlsFile, String type, int startLine) throws IOException {
		// 초기화
		Workbook wb;
		Sheet sheet = null;
		Row row = null;
		Cell cell = null;
		Vector<ArrayList<Object>> v = new Vector<>();
		ArrayList<Object> ar = null;

		if ("xlsx".equals(type)) {
			wb = new XSSFWorkbook(xlsFile);
		} else {
			POIFSFileSystem fs = new POIFSFileSystem(xlsFile);
			wb = new HSSFWorkbook(fs);
		}

		// 첫번째 시트 읽어오기
		sheet = wb.getSheetAt(0);
		// 행 갯수
		int rows = sheet.getPhysicalNumberOfRows();

		// 제목행을 제외한 "startLine"행부터 읽어오기
		for (int r = startLine; r < rows; r++) {
			// 행 읽어오기
			row = sheet.getRow(r);
			// 셀 배열 초기화
			ar = new ArrayList<>();
			// 마지막 셀 번호
			int cells = row.getLastCellNum();

			for (int q = 0; q < cells; q++) {
				cell = row.getCell(q);
				if (cell != null) {
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_FORMULA:
						ar.add(cell.getCellFormula());
						break;
					case Cell.CELL_TYPE_NUMERIC:
						// 정수/실수 구분
						double numeric_d = cell.getNumericCellValue();
						int numeric_i = (int) numeric_d;
						if (numeric_d - numeric_i == 0.0) {
							ar.add(new Integer((int) cell.getNumericCellValue()));
						} else {
							ar.add(new Double(cell.getNumericCellValue()));
						}
						break;
					case Cell.CELL_TYPE_STRING:
						ar.add(cell.getRichStringCellValue().getString().trim());
						break;
					case Cell.CELL_TYPE_BLANK:
						ar.add("");
						break;
					case Cell.CELL_TYPE_BOOLEAN:
						ar.add(new Boolean(cell.getBooleanCellValue()));
						break;
					case Cell.CELL_TYPE_ERROR:
						ar.add("");
						break;
					default:
						break;
					}
				} else {
					ar.add("");
				}
			}
			v.add(ar);
		}

		wb.close();
		return v;
	}
}
