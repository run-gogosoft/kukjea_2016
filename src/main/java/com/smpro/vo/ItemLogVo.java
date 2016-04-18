package com.smpro.vo;

public class ItemLogVo extends PagingVo {
	/** 해당 로그의 고유 시퀀스 */
	private Integer seq;
	/** 아이템의 고유 시퀀스 */
	private Integer itemSeq;
	/** 해당 action (insert/delete/update) */
	private String action = "";
	/** 내용 */
	private String content = "";
	/** 등록일 */
	private String regDate = "";
	/** 변경 내용 */
	private String modContent = "";

	// ----- 추가 필드 -----
	/** 로그인한 사람의 이름 */
	private String name = "";

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

	public Integer getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getModContent() {
		return modContent;
	}

	public void setModContent(String modContent) {
		this.modContent = modContent;
	}

}
