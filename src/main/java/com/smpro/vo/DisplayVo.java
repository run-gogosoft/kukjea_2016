package com.smpro.vo;

public class DisplayVo {
	/** 시퀀스 */
	private Integer seq;
	/** 메인 / 서브 구분(main/sub) */
	private String location = "";
	/** 배너 종류 */
	private String title = "";
	/** HTML 내용 */
	private String content = "";
	/** 정렬순서 */
	private int orderNo;
	/** 변경일 */
	private String modDate = "";
	/** 대분류 카테고리 시퀀스 */
	private Integer cateSeq;
	/** 몰 시퀀스 */
	private Integer mallSeq;
	/** 회원구분 */
	private String memberTypeCode = "";

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
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

	public String getMemberTypeCode() {
		return memberTypeCode;
	}

	public void setMemberTypeCode(String memberTypeCode) {
		this.memberTypeCode = memberTypeCode;
	}
}
