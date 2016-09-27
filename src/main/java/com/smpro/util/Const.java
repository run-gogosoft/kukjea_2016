package com.smpro.util;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Const {
	/** Manager Mail **/
	public final static String MALL_MAIL = "kukjea@empal.com";
	/** 경고창만 뜨는 페이지 */
	public final static String ALERT_PAGE = "/_proc/alert.jsp";
	/** 경고창이 뜬 후에 부모창을 리다이렉트 시키는 페이지 */
	public final static String REDIRECT_PAGE = "/_proc/parent_redirect.jsp";
	/** 경고창이 뜬 후에 뒤로 되돌아가는 페이지 */
	public final static String BACK_PAGE = "/_proc/back_page.jsp";
	/** ajax호출용 빈 페이지 */
	public final static String BLANK_PAGE = "/_proc/blank.jsp";
	/** ajax호출 후에 메시지를 전달하는 페이지 */
	public final static String AJAX_PAGE = "/_proc/ajax_message.jsp";

	/** 이미지 매직으로 변환하는 이미지 사이즈들 */
	public static final int[] ITEM_IMAGE_SIZE = { 60, 110, 170 };
	/** 이미지 매직 경로 */
	public static final String IMAGE_MAGICK_PATH;
	/** 장바구니와 주문 최고 수량 */
	public static final int MAX_ORDER_COUNT = 20;

	/** 주문확인 */
	public static final String ORDER_CONFIRM_REQUEST_CODE = "20";
	/** 배송중 */
	public static final String DELIVERY_REQUEST_CODE = "30";
	/** 반품수령 */
	public static final String RECEIVE_REQUEST_CODE = "71";

	public static final String ITEM_IMAGE_PATH = "http://kookje.gogosoft.kr/upload/item/item_img/";

	/** static resource path */
	public static final String UPLOAD_PATH;
	public static final String UPLOAD_REAL_PATH;
	public static final String WEBAPP_HOME_REAL_PATH;

	// 웹서비스 위치
	public static final String LOCATION;
	// 웹서비스 OS
	public static final String OS;
	public static final String TEMP_DIR;

	/* 도메인 */
	public static final String DOMAIN;
	static {
		// VM OPTION에 -DdetailedDebugMode=true로 설정하면 DEBUG모드로 진입한다
		if ("true".equalsIgnoreCase(System.getProperties().getProperty("detailedDebugMode"))) {
			IMAGE_MAGICK_PATH = "convert";
			UPLOAD_PATH = "/upload";
			UPLOAD_REAL_PATH =      "/Users/aubergine/Documents/gogo/kookje_2016/out/artifacts/kookje/exploded/kookje-1.0-SNAPSHOT.war/upload";
			WEBAPP_HOME_REAL_PATH = "/Users/aubergine/Documents/gogo/kookje_2016/out/artifacts/kookje/exploded/kookje-1.0-SNAPSHOT.war";
			TEMP_DIR = "/tmp";
			DOMAIN = "localhost";
			LOCATION = "test";
			OS = "linux";
		}
		else if ("win".equalsIgnoreCase(System.getProperties().getProperty("detailedDebugMode"))) {
			IMAGE_MAGICK_PATH = "convert";
			UPLOAD_PATH = "/upload";
			UPLOAD_REAL_PATH =      "C:\\Users\\USER\\IdeaProjects\\kookjea\\out\\artifacts\\kookje\\exploded\\kookje-1.0-SNAPSHOT.war\\upload";
			WEBAPP_HOME_REAL_PATH = "C:\\Users\\USER\\IdeaProjects\\kookjea\\out\\artifacts\\kookje\\exploded\\kookje-1.0-SNAPSHOT.war";
			TEMP_DIR = "c:\\tmp";
			DOMAIN = "localhost";
			LOCATION = "test";
			OS = "windows";
		}
		else {
			// PRODUCTION MODE
			IMAGE_MAGICK_PATH = "convert";
			UPLOAD_PATH = "/upload";
			UPLOAD_REAL_PATH = "/kookje/web/upload";
			WEBAPP_HOME_REAL_PATH = "/kookje/apps/instance1/webapps/ROOT";
			TEMP_DIR = "/tmp";
			DOMAIN = "kukjemall.com";
			LOCATION = "service";
			OS = "linux";
		}
	}

	/** Aria 암호화 키 (반드시 32byte가 되어야만 한다) */
	public final static byte[] ARIA_KEY = { (byte) -20, (byte) -105, (byte) -112, (byte) -20, (byte) -118, (byte) -92, (byte) -20, (byte) -105, (byte) -96, (byte) -19, (byte) -108, (byte) -124, (byte) -21, (byte) -95, (byte) -100, (byte) 32, (byte) -21, (byte) -77, (byte) -76, (byte) -20, (byte) -107, (byte) -120, (byte) 32, (byte) -20, (byte) -105, (byte) -112, (byte) -20, (byte) -118, (byte) -92, (byte) -21, (byte) -117, (byte) -91 };
}
