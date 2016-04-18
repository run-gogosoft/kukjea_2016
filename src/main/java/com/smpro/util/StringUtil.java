package com.smpro.util;

import com.smpro.vo.FilterVo;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

public class StringUtil {
	/**
	 * 널 또는 빈값인가?
	 * 
	 * @param temp
	 * @return
	 */
	public static boolean isBlank(String str) {
		if (str == null) {
			return true;
		}

		String tempStr = str.trim();
		if (tempStr.equals("") || tempStr.equals("&nbsp;") || tempStr.equals("null") || tempStr.equals("undefined")) {
			return true;
		}
		return false;
	}

	/**
	 * 특정날짜
	 * 
	 * @param day
	 * @param formatStr
	 * @return
	 */
	public static String getDate(int day, String formatStr) {
		DateFormat dateFormat = new SimpleDateFormat(formatStr);
		GregorianCalendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, day);
		return dateFormat.format(cal.getTime());
	}

	/**
	 * 특정월
	 * 
	 * @param month
	 * @param formatStr
	 * @return
	 */
	public static String getMonth(int month, String formatStr) {
		DateFormat dateFormat = new SimpleDateFormat(formatStr);
		GregorianCalendar cal = new GregorianCalendar();
		cal.add(Calendar.MONTH, month);
		return dateFormat.format(cal.getTime());
	}

	/**
	 * 숫자인가?
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNum(String str) {
		if (isBlank(str)) {
			return false;
		}
		return str.matches("^[\\d]+$");
	}

	public static String clearXSS(String str) {
		if (!StringUtil.isBlank(str)) {
			String val = str;
			val = val.trim();
			val = val.replaceAll("<", "&lt;");
			val = val.replaceAll(">", "&gt;");
			val = val.replaceAll("\"", "&quot;");
			val = val.replaceAll("\\\"", "&#34;");
			val = val.replaceAll("'", "&#39;");
			val = val.replaceAll("\\(", "&#40;");
			val = val.replaceAll("\\)", "&#41;");
			return val;
		} 
		
		return "";
	}
	
	public static String restoreClearXSS(String str) {
		if (!StringUtil.isBlank(str)) {
			String retStr = str.trim();
			retStr = retStr.replaceAll("&#35;", "#");
			retStr = retStr.replaceAll("&lt;", "<");
			retStr = retStr.replaceAll("&gt;", ">");
			retStr = retStr.replaceAll("&quot;", "\"");
			retStr = retStr.replaceAll("&#34;", "\\\"");
			retStr = retStr.replaceAll("&#39;", "'");
			retStr = retStr.replaceAll("&#40;", "\\(");
			retStr = retStr.replaceAll("&#41;", "\\)");
			retStr = retStr.replaceAll("&amp;", "&");
			
			return retStr;
		}
		return "";
	}

	/**
	 * newLine을 br로 변경하는 메서드
	 * 
	 * @author 강사무엘
	 * @since 2012-12-20
	 */
	public static String nl2br(String temp) {
		return temp.replaceAll("\\n", "<br/>");
	}

	/**
	 * email인지 아닌지 체크하는 메서드
	 * 
	 * @author 강사무엘
	 * @since 2013-01-14
	 */
	public static boolean isEmail(String email) {
		if (isBlank(email)) {
			return false;
		}
		return email
				.matches("^[\\w]+([\\w][-]?[.]?)*@[\\w]*([\\w][-]?[.]?)+[\\w]+$");
	}

	/**
	 * 전화번호에 '-' 붙임
	 * 
	 * @param phone1
	 *            , phone2, phone3
	 * @return
	 */
	public static String formatPhone(String phone1, String phone2, String phone3) {
		StringBuffer sb = new StringBuffer("");
		if (!isBlank(phone1) && !isBlank(phone2) && !isBlank(phone3)) {
			sb.append(phone1);
			sb.append('-');
			sb.append(phone2);
			sb.append('-');
			sb.append(phone3);
		}

		return sb.toString();
	}

	/**
	 * 년월일을 문자열을 붙여 8자리 날짜로 생성
	 * 
	 * @param yyyy
	 * @param mm
	 * @param dd
	 * @return
	 */
	public static String formatDate(String yyyy, String mm, String dd) {
		StringBuffer date = new StringBuffer("");
		if (!isBlank(yyyy) && !isBlank(mm) && !isBlank(dd)) {
			date.append(yyyy);
			date.append(mm);
			date.append(dd);
		}
		return date.toString();
	}

	/**
	 * 문자열을 자르는 메서드 utf-8에서 한글이 3bytes, ascii는 1bytes로 인식하여 자른다
	 * 
	 * @return
	 */
	public static String cutString(String text, int length) {
		if (isBlank(text)) {
			return "";
		}

		char[] arr = text.toCharArray();
		StringBuffer sb = new StringBuffer();
		int size = 0;
		for (char c : arr) {
			size += (c > 128) ? 3 : 1;
			sb.append(c);
			if (size >= length) {
				sb.append("...");
				break;
			}
		}
		return sb.toString();
	}

	/**
	 * 문자열의 Bytes을 리턴하는 메서드
	 * 
	 * @param str
	 * @return
	 */
	public static int getByteLength(String str) {
		if (isBlank(str)) {
			return 0;
		}

		int subject_len = str.length();
		int strLength = 0;
		char tempChar[] = new char[subject_len];

		for (int i = 0; i < subject_len; i++) {
			tempChar[i] = str.charAt(i);
			if (tempChar[i] < 128) {
				strLength++;
			} else {
				strLength += 3;
			}
		}

		return strLength;
	}

	/**
	 * 문자열을 split하여 int 배열로 바꿔주는 메서드
	 * 
	 * @param str
	 *            변환할 문자열 예: "2,5,67,33"
	 * @return ArrayList<Integer> 예: {2,5,67,33}
	 */
	public static List<Integer> convertIntArrayList(String str) {
		ArrayList<Integer> intList = new ArrayList<>();
		String[] strArr = str.split(",");
		for (int i = 0; i < strArr.length; i++) {
			if (isNum(strArr[i])) {
				intList.add(Integer.valueOf(strArr[i]));
			}
		}

		return intList;
	}

	/**
	 * SHA-2 암호화 처리
	 * 
	 * @param str
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public static String encryptSha2(String str)
			throws NoSuchAlgorithmException {
		StringBuffer sb = new StringBuffer();
		MessageDigest sh = MessageDigest.getInstance("SHA-256");
		sh.update(str.getBytes());
		byte byteData[] = sh.digest();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16)
					.substring(1));
		}
		return sb.toString();
	}

	public static int cutNumber(int arg, int nDigit) {
		return (int) (Math.floor(arg / Math.pow(10, nDigit)) * Math.pow(10,
				nDigit));
	}

	/**
	 * 숫자인가?(- 기호 포함)
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumWithMinusSign(String str) {
		if (isBlank(str)) {
			return false;
		}
		return str.matches("^-?\\d+$");
	}

	/** 숫자, 콤마(,) 제외한 나머지 문자 제거 */
	public static String extractNumberComma(String str) {
		if (isBlank(str)) {
			return "";
		}
		return str.replaceAll("[^\\d+,]", "");
	}

	/** 영대문자, 콤마(,) 제외한 나머지 문자 제거 */
	public static String extractUpperCaseComma(String str) {
		if (isBlank(str)) {
			return "";
		}
		return str.replaceAll("[^A-Z+,]", "");
	}

	/** 금지어 필터링 */
	public static String filterWord(List<FilterVo> list, String str) {
		if(StringUtil.isBlank(str)) {
			return "";
		}
		
		for (int i = 0; i < list.size(); i++) {
			if ("\\\"".equals(list.get(i).getFilterWord())) {
				list.get(i).setFilterWord("\"");
			}
			if ("\\\\".equals(list.get(i).getFilterWord())) {
				list.get(i).setFilterWord("\\");
			}
			if (!(StringUtil.restoreClearXSS(str.toLowerCase()).indexOf(list.get(i).getFilterWord().toLowerCase()) == -1)) {
				if ("\"".equals(list.get(i).getFilterWord())) {
					return "\\\"";
				} else if ("\\".equals(list.get(i).getFilterWord())) {
					return "\\\\";
				} else {
					return list.get(i).getFilterWord();
				}
			}
		}
		return "";
	}

	/**
	 * MD5 해쉬 암호화 처리
	 * 
	 * @param str
	 * @return
	 */
	public static String encryptMd5(String str) {
		StringBuffer strBuf = new StringBuffer();
		byte[] bNoti = str.toString().getBytes();
		byte[] digest = null;
		try {
			digest = MessageDigest.getInstance("MD5").digest(bNoti);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		if (digest != null) {
			for (int i = 0; i < digest.length; i++) {
				int c = digest[i] & 0xff;
				if (c <= 15) {
					strBuf.append("0");
				}
				strBuf.append(Integer.toHexString(c));
			}
		}

		return strBuf.toString();
	}
	
	/*
	 * 금액, 수량 천단위 콤마
	 */
	public static String formatAmount(int amount) {
		java.text.DecimalFormat decFormat = new java.text.DecimalFormat("###,###,###,###,###,###");
		return  decFormat.format(amount);
	}
}
