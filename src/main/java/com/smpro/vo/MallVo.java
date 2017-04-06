package com.smpro.vo;

public class MallVo extends UserVo {
	/** 쇼핑몰 URL */
	private String url = "";
	/** 사용 가능 결제 수단 */
	private String payMethod = "";
	/** PG CODE */
	private String pgCode = "";
	/** PG 상점아이디(kcp 사이트코드) */
	private String pgId = "";
	/** PG 상점키(kcp 사이트키) */
	private String pgKey = "";
	/** 오픈 일자 */
	private String openDate = "";
	/** 폐쇄 일자 */
	private String closeDate = "";

	private String logoImg = "";

	public String getLogoImg(){
		return this.logoImg;
	}

	public void setLogoImg(String url){
		this.logoImg = url;
	}

	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}

	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getPgCode() {
		return pgCode;
	}
	public void setPgCode(String pgCode) {
		this.pgCode = pgCode;
	}

	public String getPgId() {
		return pgId;
	}
	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public String getPgKey() {
		return pgKey;
	}
	public void setPgKey(String pgKey) {
		this.pgKey = pgKey;
	}

	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getCloseDate() {
		return closeDate;
	}
	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}

}
