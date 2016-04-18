package com.smpro.vo;

public class ReviewVo extends PagingVo {
	/** 주문 시퀀스 */
	private Integer orderSeq;
	/** 주문 상세 시퀀스 */
	private Integer detailSeq;
	/** 작성자 시퀀스 */
	private Integer memberSeq;
	/** 상품 시퀀스 */
	private Integer itemSeq;
	/** 구매평 */
	private String review = "";
	/** 내용을 일시적으로 자른 구매평 */
	private String tmpReview = "";
	/** 상품 평가 */
	private int goodGrade;
	/** 배송 평가 */
	private int deliGrade;
	/** 등록일 */
	private String regDate = "";
	/** 상품 이름 */
	private String itemName = "";
	/** 옵션 밸류 */
	private String valueName = "";
	/** 작성자 이름 */
	private String name = "";
	/** 작성자 아이디 */
	private String id = "";
	/** 상품/배송 총 평점 */
	private int reviewGrade;
	/** 상품평 갯수 */
	private int reviewCount;
	/** 닉네임 */
	private String nickName = "";
	/** 상품이미지 */
	private String img1 = "";
	/** 상품이미지 */
	private String img2 = "";
	/** 상품이미지 */
	private String img3 = "";
	/** 상품이미지 */
	private String img4 = "";
	/** 추가 */
	/** 주문 시퀀스 */
	private Integer seq;
	/** 주문 상태 코드 */
	private String statusCode = "";
	/** 메인현황 게시판 게시물 수 */
	private int boardCount;
	/** 몰이름 */
	private String mallName = "";

	@Override
	public String getSearch() {
		// TODO Auto-generated method stub
		return null;
	}

	public Integer getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(Integer orderSeq) {
		this.orderSeq = orderSeq;
	}

	public Integer getDetailSeq() {
		return detailSeq;
	}

	public void setDetailSeq(Integer detailSeq) {
		this.detailSeq = detailSeq;
	}

	
	public Integer getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(Integer memberSeq) {
		this.memberSeq = memberSeq;
	}

	public Integer getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getTmpReview() {
		return tmpReview;
	}

	public void setTmpReview(String tmpReview) {
		this.tmpReview = tmpReview;
	}

	public int getGoodGrade() {
		return goodGrade;
	}

	public void setGoodGrade(int goodGrade) {
		this.goodGrade = goodGrade;
	}

	public int getDeliGrade() {
		return deliGrade;
	}

	public void setDeliGrade(int deliGrade) {
		this.deliGrade = deliGrade;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getReviewGrade() {
		return reviewGrade;
	}

	public void setReviewGrade(int reviewGrade) {
		this.reviewGrade = reviewGrade;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
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

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public String getMallName() {
		return mallName;
	}

	public void setMallName(String mallName) {
		this.mallName = mallName;
	}
}
