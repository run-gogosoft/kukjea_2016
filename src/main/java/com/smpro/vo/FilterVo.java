package com.smpro.vo;

public class FilterVo {
	// 시퀀스
	private Integer seq;
	// 금지어
	private String filterWord = "";
	// 등록일
	private String regDate = "";

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getFilterWord() {
		return filterWord;
	}

	public void setFilterWord(String filterWord) {
		this.filterWord = filterWord;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

}
