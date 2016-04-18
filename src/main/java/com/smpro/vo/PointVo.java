package com.smpro.vo;

public class PointVo extends PagingVo {
	/** 시퀀스 */
	private Integer seq;
	/** sm_point 테이블 시퀀스 */
	private Integer pointSeq;
	/** 몰 시퀀스 */
	private Integer mallSeq;
	/** 발생일 */
	private String regDate = "";
	/** 유효일 */
	private String endDate = "";
	/** 적립포인트 */
	private int point;
	/** 현재 사용 포인트 */
	private int curPoint;
	/** 사용가능 포인트 */
	private int useablePoint;
	/** 사용구분(사용,사용불가, sm_point) */
	private String validFlag = "";
	/** 상태코드(S:적립, U:사용, D:소멸, E:소진, C:취소적립) */
	private String statusCode = "";
	private String statusName = "";
	/** 적립방식코드 */
	private String reserveCode = "";
	/** 적립방식코드(이름) */
	private String reserveText = "";
	/** 적립방식 비고(추가설명) */
	private String reserveComment = "";
	/** 주문번호 */
	private Integer orderSeq;
	/** 상품 주문 번호 */
	private Integer orderDetailSeq;
	/** 상품 주문 번호(checkbox 배열 전송시 ,로 나열된 값) */
	private String orderDetailSeqs = "";
	/** 회원시퀀스 */
	private Integer memberSeq;
	/** 회원 아이디 */
	private String id = "";
	/** 회원 이름 */
	private String name = "";
	/** 회원 닉네임 */
	private String nickname = "";
	/** 관리자 시퀀스 */
	private Integer adminSeq;
	/** 관리자 이름 */
	private String adminName = "";
	/** 관리자 등급 */
	private String gradeText = "";
	/** 등록 구분(일반, 부분취소) */
	private String typeCode = "";
	/** 쇼핑몰 이름 */
	private String mallName = "";
	/** 비고(추가설명) */
	private String note = "";

	@Override
	public String getSearch() {
		return search;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getPointSeq() {
		return pointSeq;
	}

	public void setPointSeq(Integer pointSeq) {
		this.pointSeq = pointSeq;
	}
	
	public Integer getMallSeq() {
		return mallSeq;
	}

	public void setMallSeq(Integer mallSeq) {
		this.mallSeq = mallSeq;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getCurPoint() {
		return curPoint;
	}

	public void setCurPoint(int curPoint) {
		this.curPoint = curPoint;
	}

	public int getUseablePoint() {
		return useablePoint;
	}

	public void setUseablePoint(int useablePoint) {
		this.useablePoint = useablePoint;
	}

	public String getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(String validFlag) {
		this.validFlag = validFlag;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getReserveCode() {
		return reserveCode;
	}

	public void setReserveCode(String reserveCode) {
		this.reserveCode = reserveCode;
	}

	public String getReserveText() {
		return reserveText;
	}

	public void setReserveText(String reserveText) {
		this.reserveText = reserveText;
	}

	public String getReserveComment() {
		return reserveComment;
	}

	public void setReserveComment(String reserveComment) {
		this.reserveComment = reserveComment;
	}

	public Integer getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(Integer orderSeq) {
		this.orderSeq = orderSeq;
	}

	public Integer getOrderDetailSeq() {
		return orderDetailSeq;
	}

	public void setOrderDetailSeq(Integer orderDetailSeq) {
		this.orderDetailSeq = orderDetailSeq;
	}

	public String getOrderDetailSeqs() {
		return orderDetailSeqs;
	}

	public void setOrderDetailSeqs(String orderDetailSeqs) {
		this.orderDetailSeqs = orderDetailSeqs;
	}

	public Integer getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(Integer memberSeq) {
		this.memberSeq = memberSeq;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Integer getAdminSeq() {
		return adminSeq;
	}

	public void setAdminSeq(Integer adminSeq) {
		this.adminSeq = adminSeq;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getGradeText() {
		return gradeText;
	}

	public void setGradeText(String gradeText) {
		this.gradeText = gradeText;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getMallName() {
		return mallName;
	}

	public void setMallName(String mallName) {
		this.mallName = mallName;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}