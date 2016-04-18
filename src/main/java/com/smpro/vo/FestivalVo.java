package com.smpro.vo;

public class FestivalVo extends SellerVo {
	//private Integer seq;
	private Integer festivalSeq;
	private Integer sellerSeq;
	private String sellerId = "";
	private String sellerName = "";
	private String title = "";
	private String content = "";
	private String startDate = "";
	private String endDate = "";
	//private String modDate = "";
	//private String regDate = "";

	
	public Integer getFestivalSeq() {
		return festivalSeq;
	}


	public void setFestivalSeq(Integer festivalSeq) {
		this.festivalSeq = festivalSeq;
	}


	public Integer getSellerSeq() {
		return sellerSeq;
	}


	public void setSellerSeq(Integer sellerSeq) {
		this.sellerSeq = sellerSeq;
	}


	public String getSellerId() {
		return sellerId;
	}


	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}


	public String getSellerName() {
		return sellerName;
	}


	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getStartDate() {
		return startDate;
	}


	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}


	public String getEndDate() {
		return endDate;
	}


	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}


	@Override
	public String getSearch() {
		return null;
	}
	
}
