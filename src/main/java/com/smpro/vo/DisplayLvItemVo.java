package com.smpro.vo;

public class DisplayLvItemVo {
	/** 시퀀스 */
	private Integer seq;
	/** 대분류 카테고리 시퀀스 */
	private Integer cateSeq;
	/** 쇼핑몰 시퀀스 */
	private Integer mallSeq;
	/** 대분류(sm_display_item -> seq)스타일 시퀀스 */
	private Integer displaySeq;
	/** 상품 시퀀스 */
	private Integer itemSeq;
	/** 스타일 제목 */
	private String listTitle = "";
	/** 스타일 제목 */
	private String title = "";
	/** 상품이름 */
	private String itemName = "";
	/** 상품 판매 가격 */
	private int sellPrice;
	private int marketPrice;
	/** 상품 상태 코드(가승인,판매중,판매중지) */
	private String statusFlag = "";
	/** 대분류 스타일 코드 */
	private Integer styleCode;
	/** 카테고리 이름 */
	private String cateName = "";
	/** 상품 이미지 */
	private String img1 = "";
	private String img2 = "";
	/** 정렬 순서 */
	private int orderNo;
	/** 상품 표시 제한 */
	private int limitCnt;
	/** 검색조건 유지를 위한 필드 */
	private Integer lv1; // 대분류
	private Integer lv2; // 중분류
	private Integer lv3; // 소분류
	private String name = ""; // 상품명
	private String searchItemSeq = ""; // 검색조건 유지를 위한 상품시퀀스
	/** 회원구분 */
	private String memberTypeCode = "";
	/** 원산지 */
	private String originCountry = "";
	/** 브랜드 */
	private String brand = "";
	/** 상품구분 */
	private String typeCode = "";

	/** 상품이미지내 이벤트 배너 전시 코드값(01:세일,02:특가,03:한정수량,04:행사) */
	private String imgBannerCode = "";

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getCateSeq() {
		return cateSeq;
	}

	public void setCateSeq(Integer cateSeq) {
		this.cateSeq = cateSeq;
	}

	public Integer getMallSeq() {
		return mallSeq;
	}

	public void setMallSeq(Integer mallSeq) {
		this.mallSeq = mallSeq;
	}

	public Integer getDisplaySeq() {
		return displaySeq;
	}

	public void setDisplaySeq(Integer displaySeq) {
		this.displaySeq = displaySeq;
	}

	public Integer getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}

	public String getListTitle() {
		return listTitle;
	}

	public void setListTitle(String listTitle) {
		this.listTitle = listTitle;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}

	public int getMarketPrice() {
		return marketPrice;
	}

	public void setMarketPrice(int marketPrice) {
		this.marketPrice = marketPrice;
	}

	public String getStatusFlag() {
		return statusFlag;
	}

	public void setStatusFlag(String statusFlag) {
		this.statusFlag = statusFlag;
	}

	public Integer getStyleCode() {
		return styleCode;
	}

	public void setStyleCode(Integer styleCode) {
		this.styleCode = styleCode;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}
	
	public String getImg2() {
		return img2;
	}

	public void setImg2(String img2) {
		this.img2 = img2;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getLimitCnt() {
		return limitCnt;
	}

	public void setLimitCnt(int limitCnt) {
		this.limitCnt = limitCnt;
	}

	public Integer getLv1() {
		return lv1;
	}

	public void setLv1(Integer lv1) {
		this.lv1 = lv1;
	}

	public Integer getLv2() {
		return lv2;
	}

	public void setLv2(Integer lv2) {
		this.lv2 = lv2;
	}

	public Integer getLv3() {
		return lv3;
	}

	public void setLv3(Integer lv3) {
		this.lv3 = lv3;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSearchItemSeq() {
		return searchItemSeq;
	}

	public void setSearchItemSeq(String searchItemSeq) {
		this.searchItemSeq = searchItemSeq;
	}

	public String getMemberTypeCode() {
		return memberTypeCode;
	}

	public void setMemberTypeCode(String memberTypeCode) {
		this.memberTypeCode = memberTypeCode;
	}

	public String getOriginCountry() {
		return originCountry;
	}

	public void setOriginCountry(String originCountry) {
		this.originCountry = originCountry;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getImgBannerCode() {
		return imgBannerCode;
	}

	public void setImgBannerCode(String imgBannerCode) {
		this.imgBannerCode = imgBannerCode;
	}

}