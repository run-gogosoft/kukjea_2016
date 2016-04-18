package com.smpro.vo;

public class OrderCsVo {
	private int rowNumber;

	/** 시퀀스 */
	private Integer seq;
	/** 주문 상세 시퀀스 */
	private Integer orderDetailSeq;
	/** CS 내용 */
	private String contents = "";
	/** 등록자 시퀀스 */
	private Integer loginSeq;
	/** 등록자 이름 */
	private String regName = "";
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

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
