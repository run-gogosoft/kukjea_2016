package com.smpro.service;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class XlsService {
	private static final Logger LOGGER = LoggerFactory.getLogger(XlsService.class);
	
	/**
	 * 엑셀 파일 포맷 데이터 생성
	 * 
	 * @param strTitle
	 *            항목 타이틀
	 * @param strList
	 *            데이터 리스트
	 * @return
	 */
	public static HSSFWorkbook createFile(String[] strTitle, List<String[]> strList) {

		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("List");
		HSSFRow row = null;
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFFont font = null;

		// row
		row = sheet.createRow(0);
		row.setHeightInPoints(20);

		// style
		style = wb.createCellStyle();
		style.setWrapText(true);

		// Align
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

		// Layout Line
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(HSSFColor.BLACK.index);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(HSSFColor.BLACK.index);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(HSSFColor.BLACK.index);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(HSSFColor.BLACK.index);

		// Fill
		style.setFillForegroundColor(HSSFColor.YELLOW.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);

		// font
		font = wb.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setColor(HSSFColor.BLACK.index);
		style.setFont(font);

		for (int j = 0; j < strTitle.length; j++) {
			// Set Cell
			cell = row.createCell(j);
			cell.setCellValue(new HSSFRichTextString(strTitle[j]));
			cell.setCellStyle(style);
		}

		// 내용
		if (strList != null && strList.size() > 0) {
			for (int i = 0; i < strList.size(); i++) {
				String[] strData = strList.get(i);
				// row
				row = sheet.createRow(i + 1);
				row.setHeightInPoints(20);

				// style
				style = wb.createCellStyle();
				style.setWrapText(true);

				// Align
				style.setAlignment(CellStyle.ALIGN_LEFT);
				style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

				// Layout Line
				style.setBorderBottom(CellStyle.BORDER_THIN);
				style.setBottomBorderColor(HSSFColor.BLACK.index);
				style.setBorderLeft(CellStyle.BORDER_THIN);
				style.setLeftBorderColor(HSSFColor.BLACK.index);
				style.setBorderRight(CellStyle.BORDER_THIN);
				style.setRightBorderColor(HSSFColor.BLACK.index);
				style.setBorderTop(CellStyle.BORDER_THIN);
				style.setTopBorderColor(HSSFColor.BLACK.index);

				// Fill
				style.setFillForegroundColor(HSSFColor.WHITE.index);
				style.setFillPattern(CellStyle.SOLID_FOREGROUND);

				// font
				font = wb.createFont();
				font.setFontHeightInPoints((short) 9);
				font.setColor(HSSFColor.BLACK.index);
				style.setFont(font);

				for (int j = 0; j < strData.length; j++) {
					// Set Cell
					cell = row.createCell(j);
					cell.setCellValue(new HSSFRichTextString(strData[j]));
					cell.setCellStyle(style);
				}
			}
		}
		return wb;
	}

	/*
	 * 엑셀 파일의 데이터 읽어오기
	 */
	public List<String[]> readXlsFile(InputStream xlsFile) {
		List<String[]> list = new ArrayList<>();
		HSSFWorkbook wb = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFCell cell = null;

		try {
			POIFSFileSystem fs = new POIFSFileSystem(xlsFile);
			wb = new HSSFWorkbook(fs);
			sheet = wb.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			LOGGER.info("전체 레코드 갯수 = " + (rows - 1));
			// 시작열을 제목열 0열을 제외하구 1열부터 읽기
			for (int i = 1; i < rows; i++) {
				row = sheet.getRow(i);
				int cellCnt = row.getPhysicalNumberOfCells();
				String[] strRow = new String[cellCnt];
				for (int j = 0; j < cellCnt; j++) {
					cell = row.getCell(j);
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_NUMERIC:
						if (DateUtil.isCellDateFormatted(cell)) {
							SimpleDateFormat sdf = new SimpleDateFormat(
									"yyyy-MM-dd");
							strRow[j] = sdf.format(cell.getDateCellValue());
						} else {
							strRow[j] = (long) cell.getNumericCellValue() + "";
						}
						break;
					case Cell.CELL_TYPE_STRING:
						strRow[j] = cell.getRichStringCellValue().getString();
						break;
					case Cell.CELL_TYPE_BLANK:
						strRow[j] = "";
						break;
					case Cell.CELL_TYPE_ERROR:
						strRow[j] = "";
						break;
					default:
						strRow[j] = "";
						break;
					}
				}
				list.add(strRow);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (wb != null)
					wb.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return list;
	}
}
