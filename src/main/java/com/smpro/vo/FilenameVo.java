package com.smpro.vo;

public class FilenameVo {
	private Integer seq;
	private String parentCode = "";
	private Integer parentSeq;
	private Integer num;
	private String filename = "";
	private String realFilename = "";
	private String regDate = "";
	
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public Integer getParentSeq() {
		return parentSeq;
	}
	public void setParentSeq(Integer parentSeq) {
		this.parentSeq = parentSeq;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getRealFilename() {
		return realFilename;
	}
	public void setRealFilename(String realFilename) {
		this.realFilename = realFilename;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
