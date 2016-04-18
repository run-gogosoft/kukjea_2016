package com.smpro.vo;


/** 메뉴 */
public class MenuVo {
	private Integer seq;
	private Integer sort;
	private String name;
	/** 연결 링크 주소 */
	private String linkUrl;

	// 서브
	private Integer mainSeq;
	private Integer mainSort;
	private Integer subSort;
	private String mainName;
	private String subName;
	private String mainLinkUrl;
	private String subLinkUrl;

	/** 메인/서브 구분 코드 */
	private String typeCode;

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

	public Integer getMainSeq() {
		return mainSeq;
	}

	public void setMainSeq(Integer mainSeq) {
		this.mainSeq = mainSeq;
	}

	public Integer getMainSort() {
		return mainSort;
	}

	public void setMainSort(Integer mainSort) {
		this.mainSort = mainSort;
	}

	public Integer getSubSort() {
		return subSort;
	}

	public void setSubSort(Integer subSort) {
		this.subSort = subSort;
	}

	public String getMainName() {
		return mainName;
	}

	public void setMainName(String mainName) {
		this.mainName = mainName;
	}

	public String getSubName() {
		return subName;
	}

	public void setSubName(String subName) {
		this.subName = subName;
	}

	public String getMainLinkUrl() {
		return mainLinkUrl;
	}

	public void setMainLinkUrl(String mainLinkUrl) {
		this.mainLinkUrl = mainLinkUrl;
	}

	public String getSubLinkUrl() {
		return subLinkUrl;
	}

	public void setSubLinkUrl(String subLinkUrl) {
		this.subLinkUrl = subLinkUrl;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	
	
}
