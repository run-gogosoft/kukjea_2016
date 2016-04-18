package com.smpro.vo;

public class CommonVo {
	// 공통코드 테이블 필드
	/** 시퀀스 */
	private Integer seq;
	/** 그룹코드 */
	private Integer groupCode;
	/** 그룹명 */
	private String groupName = "";
	/** 값 */
	private String value = "";
	/** 명칭 */
	private String name = "";
	/** 비고/설명 */
	private String note = "";
	/** 등록일 */
	private String regDate = "";
	/** 수정일 */
	private String modDate = "";

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(Integer groupCode) {
		this.groupCode = groupCode;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
}
