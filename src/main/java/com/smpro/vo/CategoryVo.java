package com.smpro.vo;

import java.util.List;

public class CategoryVo {
	/** 고유 시퀀스 */
	private Integer seq;
	/** 해당 카테고리의 부모 시퀀스 */
	private Integer parentSeq;
	/** 카테고리 깊이 (1부터 시작) */
	private int depth;
	/** 카테고리명 */
	private String name = "";
	/** 순서 번호 (0부터 시작) */
	private int orderNo;
	/** 수정일 */
	private String modDate = "";
	/** 등록일 */
	private String regDate = "";
	/** 노출여부 (Y=보여줌, N=보여주지 않음) */
	private String showFlag = "";

	// ----- 추가 -----
	private List<CategoryVo> list;
	private Integer count;

	/** mall id **/
	private int mallId=1;

	public int getMallId() {
		System.out.println("$$$ CategoryVo this.mallId:"+this.mallId);
		return this.mallId;
	}

	public void setMallId(int mallId) {
		this.mallId = mallId;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(Integer parentSeq) {
		this.parentSeq = parentSeq;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
	}

	public List<CategoryVo> getList() {
		return list;
	}

	public void setList(List<CategoryVo> list) {
		this.list = list;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

}