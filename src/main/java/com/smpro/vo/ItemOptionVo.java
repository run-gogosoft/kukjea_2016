package com.smpro.vo;

import java.util.List;

public class ItemOptionVo {
	private Integer seq;
	/** 상품 시퀀스 */
	private Integer itemSeq;
	/** 옵션명 */
	private String optionName = "";
	/** 노출여부 (Y:판매, N:비노출) */
	private String showFlag = "";
	/** 수정일 */
	private String modDate = "";
	/** 등록일 */
	private String regDate = "";

	/** 옵션 시퀀스 */
	private Integer optionSeq;
	/** 옵션 상품명 */
	private String valueName = "";
	/** 재고수량 */
	private int stockCount;
	/** 재고 관리 여부 */
	private String stockFlag = "Y";
	
	/** 추가 금액 */
	private int optionPrice;

	// ------- 추가 필드 ---------
	private List<ItemOptionVo> valueList;
	/** 수량 */
	private int count;

	/** 변경내역 */
	private String modContent="";
	private String column="";

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
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

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
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

	public Integer getOptionSeq() {
		return optionSeq;
	}

	public void setOptionSeq(Integer optionSeq) {
		this.optionSeq = optionSeq;
	}

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName;
	}

	public int getStockCount() {
		return stockCount;
	}

	public void setStockCount(int stockCount) {
		this.stockCount = stockCount;
	}

	public String getStockFlag() {
		return stockFlag;
	}

	public void setStockFlag(String stockFlag) {
		this.stockFlag = stockFlag;
	}

	public int getOptionPrice() {
		return optionPrice;
	}

	public void setOptionPrice(int optionPrice) {
		this.optionPrice = optionPrice;
	}

	public List<ItemOptionVo> getValueList() {
		return valueList;
	}

	public void setValueList(List<ItemOptionVo> valueList) {
		this.valueList = valueList;
	}

	public String getModContent() {
		return modContent;
	}

	public void setModContent(String modContent) {
		this.modContent = modContent;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	@Override
	public String toString() {
		return "ItemOptionVo [seq=" + seq + ", itemSeq=" + itemSeq
				+ ", optionName=" + optionName + ", showFlag=" + showFlag
				+ ", modDate=" + modDate + ", regDate=" + regDate
				+ ", optionSeq=" + optionSeq + ", valueName=" + valueName
				+ ", stockCount=" + stockCount + ", stockFlag=" + stockFlag + ", optionPrice=" + optionPrice
				+ ", valueList=" + valueList + ", count=" + count
				+ ", modContent=" + modContent + ", column=" + column + "]";
	}
}
