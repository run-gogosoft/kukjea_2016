package com.smpro.vo;

public class NoticePopupVo {
	/** 팝업 시퀀스 */
	private Integer seq;
	/** 타입코드 (C=일반, S=셀러) */
	private String typeCode = "";
	/** 팝업 제목 */
	private String title = "";
	/** 팝업 가로 크기 */
	private int width;
	/** 팝업 세로 크기 */
	private int height;
	/** 팝업 상단 여백 */
	private int topMargin;
	/** 팝업 왼쪽 여백 */
	private int leftMargin;
	/** 팝업 상태 코드 */
	private String statusCode = "";
	/** 팝업 HTML 코드 */
	private String contentHtml = "";
	/** 팝업 쇼핑몰 시퀀스 */
	private Integer mallSeq;

	private String mallName = "";

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	
	public int getTopMargin() {
		return topMargin;
	}

	public void setTopMargin(int topMargin) {
		this.topMargin = topMargin;
	}

	public int getLeftMargin() {
		return leftMargin;
	}

	public void setLeftMargin(int leftMargin) {
		this.leftMargin = leftMargin;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getContentHtml() {
		return contentHtml;
	}

	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
	}

	public Integer getMallSeq() {
		return mallSeq;
	}

	public void setMallSeq(Integer mallSeq) {
		this.mallSeq = mallSeq;
	}

	public String getMallName() {
		return mallName;
	}

	public void setMallName(String mallName) {
		this.mallName = mallName;
	}
}