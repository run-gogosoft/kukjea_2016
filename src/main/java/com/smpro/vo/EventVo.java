package com.smpro.vo;

public class EventVo extends PagingVo {
	/** 시퀀스 */
	private Integer seq;
	/** 구분 코드(1:기획전 , 2:이벤트) */
	private String typeCode = "";
	/** 상태 코드(Y:진행, H:대기, N:종료) */
	private String statusCode = "";
	/** 기획전/이벤트 명 */
	private String title = "";
	/** 서브페이지 상단 배너영억 HTML */
	private String html = "";
	/** 리스트 페이지용 배너 URL */
	private String thumbImg = "";
	/** 종료 예정일 */
	private String endDate = "";
	/** 등록일 */
	private String regDate = "";
	/** 자동발행 쿠폰 시퀀스 */
	private Integer couponSeq;
	/** 자동발행 쿠폰 이름 */
	private String couponName = "";

	/** sm_event_group **/
	/** 시퀀스 */
	private Integer eventGroupSeq;
	/** 기획전 시퀀스(fk:sm_event) */
	private Integer eventSeq;
	/** 상품 그룹명 */
	private String groupName = "";
	/** 정렬 순서 */
	private int orderNo;

	/** sm_event_item **/
	/** 시퀀스 */
	private Integer groupSeq;
	/** 상품 시퀀스(FK:sm_item) */
	private Integer itemSeq;
	/** 기획전 그룹 시퀀스(FK:sm_event_group) */
	private Integer eventItemSeq;
	/** 정렬 순서 */
	private int itemOrderNo;

	/** sm_item **/
	/** 상품 이름 */
	private String itemName = "";
	/** 상품 가격 */
	private int sellPrice;
	/** 상품 상태(가승인,판매중,판매중지) */
	private String statusFlag = "";
	/** 카테고리 이름 */
	private String cateName = "";
	/** 대분류 시퀀스 */
	private Integer lv1Seq;
	/** 상품등급(점수) */
	private int reviewGrade;
	/** 상품 이미지 URL 1 */
	private String img1 = "";
	/** 상품 이미지 URL 2 */
	private String img2 = "";
	/** 상품 이미지 URL 3 */
	private String img3 = "";
	/** 상품 이미지 URL 4 */
	private String img4 = "";
	/** 몰시퀀스 */
	private Integer mallSeq;
	/** 몰이름 */
	private String mallName = "";
	/** 노출 여부(Y:노출, N:노출안함) */
	private String showFlag = "";
	/** 배너 영역 구분관리 */
	private String mainSection = "";
	/** 상품구분 */
	private String itemTypeCode = "";
	
	/** 현재날짜 */
	private String curDate = "";
	
	@Override
	public String getSearch() {
		// TODO Auto-generated method stub
		return null;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public Integer getCouponSeq() {
		return couponSeq;
	}

	public void setCouponSeq(Integer couponSeq) {
		this.couponSeq = couponSeq;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public Integer getEventGroupSeq() {
		return eventGroupSeq;
	}

	public void setEventGroupSeq(Integer eventGroupSeq) {
		this.eventGroupSeq = eventGroupSeq;
	}

	public Integer getEventSeq() {
		return eventSeq;
	}

	public void setEventSeq(Integer eventSeq) {
		this.eventSeq = eventSeq;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getGroupSeq() {
		return groupSeq;
	}

	public void setGroupSeq(Integer groupSeq) {
		this.groupSeq = groupSeq;
	}

	public Integer getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}

	public Integer getEventItemSeq() {
		return eventItemSeq;
	}

	public void setEventItemSeq(Integer eventItemSeq) {
		this.eventItemSeq = eventItemSeq;
	}

	public int getItemOrderNo() {
		return itemOrderNo;
	}

	public void setItemOrderNo(int itemOrderNo) {
		this.itemOrderNo = itemOrderNo;
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

	public String getStatusFlag() {
		return statusFlag;
	}

	public void setStatusFlag(String statusFlag) {
		this.statusFlag = statusFlag;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public Integer getLv1Seq() {
		return lv1Seq;
	}

	public void setLv1Seq(Integer lv1Seq) {
		this.lv1Seq = lv1Seq;
	}

	public int getReviewGrade() {
		return reviewGrade;
	}

	public void setReviewGrade(int reviewGrade) {
		this.reviewGrade = reviewGrade;
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

	public String getImg3() {
		return img3;
	}

	public void setImg3(String img3) {
		this.img3 = img3;
	}

	public String getImg4() {
		return img4;
	}

	public void setImg4(String img4) {
		this.img4 = img4;
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

	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
	}

	public String getMainSection() {
		return mainSection;
	}

	public void setMainSection(String mainSection) {
		this.mainSection = mainSection;
	}

	public String getItemTypeCode() {
		return itemTypeCode;
	}

	public void setItemTypeCode(String itemTypeCode) {
		this.itemTypeCode = itemTypeCode;
	}

	public String getCurDate() {
		return curDate;
	}

	public void setCurDate(String curDate) {
		this.curDate = curDate;
	}
}
