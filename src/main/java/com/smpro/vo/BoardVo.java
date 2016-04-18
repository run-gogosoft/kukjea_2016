package com.smpro.vo;

public class BoardVo extends PagingVo {
	/** 작성자 아이디 */
	private String id = "";
	/** 작성자 이름 */
	private String name = "";
	/** 작성자 닉네임 */
	private String nickName = "";
	/** 답변자 이름 */
	private String answerName = "";
	/** 게시글 시퀀스 */
	private Integer seq;
	/** 작성자 시퀀스 */
	private Integer userSeq;
	/** 게시글(1:1문의, 상품QnA 답변자 시퀀스) */
	private Integer answerSeq;
	/** 시퀀스(주문번호) */
	private Integer orderSeq;
	/** 통합 시퀀스(상품번호, 주문번호, 이벤트 시퀀스) */
	private Integer integrationSeq;
	/** 게시글 제목 */
	private String title = "";
	/** 게시글 내용 */
	private String content = "";
	/** 게시글 답변(1:1문의, 상품QnA) */
	private String answer = "";
	/** 게시글 답변 여부 */
	private Integer answerFlag;
	/** 게시판 분류 코드 */
	private String groupCode = "";
	/** 게시판 카테고리 코드 */
	private Integer categoryCode;
	/** 게시글 조회수 */
	private int viewCount;
	/** 게시글 답변 날짜 */
	private String answerDate = "";
	/** 게시글 수정 날짜 */
	private String modDate = "";
	/** 게시글 등록 날짜 */
	private String regDate = "";
	/** 상품이름 */
	private String itemName = "";
	/** 상품이미지 */
	private String img1 = "";
	/** 상품이미지 */
	private String img2 = "";
	/** 상품이미지 */
	private String img3 = "";
	/** 상품이미지 */
	private String img4 = "";
	/** 추가 */
	/** 웹진 게시글 시퀀스 */
	private Integer boardSeq;
	/** 메인현황 게시판 게시물 수 */
	private int boardCount;
	/** 몰 시퀀스 */
	private Integer mallSeq;
	/** 몰 이름 */
	private String mallName = "";
	/** 파일 존재여부 */
	private String isFile = "";
	
	@Override
	public String getSearch() {
		return search;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getAnswerName() {
		return answerName;
	}

	public void setAnswerName(String answerName) {
		this.answerName = answerName;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	
	public Integer getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(Integer userSeq) {
		this.userSeq = userSeq;
	}

	public Integer getAnswerSeq() {
		return answerSeq;
	}

	public void setAnswerSeq(Integer answerSeq) {
		this.answerSeq = answerSeq;
	}

	public Integer getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(Integer orderSeq) {
		this.orderSeq = orderSeq;
	}

	public Integer getIntegrationSeq() {
		return integrationSeq;
	}

	public void setIntegrationSeq(Integer integrationSeq) {
		this.integrationSeq = integrationSeq;
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

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Integer getAnswerFlag() {
		return answerFlag;
	}

	public void setAnswerFlag(Integer answerFlag) {
		this.answerFlag = answerFlag;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public Integer getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(Integer categoryCode) {
		this.categoryCode = categoryCode;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(String answerDate) {
		this.answerDate = answerDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
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

	public Integer getBoardSeq() {
		return boardSeq;
	}

	public void setBoardSeq(Integer boardSeq) {
		this.boardSeq = boardSeq;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
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

	public String getIsFile() {
		return isFile;
	}

	public void setIsFile(String isFile) {
		this.isFile = isFile;
	}
}
