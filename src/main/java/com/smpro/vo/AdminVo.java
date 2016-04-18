package com.smpro.vo;

public class AdminVo extends UserVo {
	/** 전화번호 */
	private String tel = "";
	/** 핸드폰번호 */
	private String cell = "";

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCell() {
		return cell;
	}

	public void setCell(String cell) {
		this.cell = cell;
	}
}
