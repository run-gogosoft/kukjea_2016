package com.smpro.vo;

public class OrderLogVo {
	private int rowNumber;

	/** 시퀀스 */
	private Integer seq;
	/** 주문 상세 시퀀스 */
	private Integer orderDetailSeq;
	/** 로그 내용 */
	private String contents = "";
	/** 등록자 시퀀스 */
	private Integer loginSeq;
	/** 등록자 명 */
	private String loginName = "";
	/** 등록일자 */
	private String regDate = "";

	public int getRowNumber() {
		return rowNumber;
	}

	public void setRowNumber(int rowNumber) {
		this.rowNumber = rowNumber;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getOrderDetailSeq() {
		return orderDetailSeq;
	}

	public void setOrderDetailSeq(Integer orderDetailSeq) {
		this.orderDetailSeq = orderDetailSeq;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Integer getLoginSeq() {
		return loginSeq;
	}

	public void setLoginSeq(Integer loginSeq) {
		this.loginSeq = loginSeq;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
