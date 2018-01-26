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

	/** 세일 % **/
	private int salePercent;

	/** 판매가격 **/
	private int sellPrice;
	/** 할인 기간 */
	private String salePeriod="";

	/** 할인 금액 */
	private int salePrice;

	/** 이벤트 추가 */
	private String eventAdded;

	/** 무료 배송 여부 */
	private String freeDeli = "N";

	// ------- 추가 필드 ---------
	private List<ItemOptionVo> valueList;
	/** 수량 */
	private int count;

	/** seller seq **/
	private int sellerSeq;

	/** 변경내역 */
	private String modContent="";
	private String column="";

	/** 제품원가 **/
	private int originalPrice=0;

	public int getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(int originalPrice) {
		this.originalPrice = originalPrice;
	}


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

	public int getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}

	public int getSellerSeq() {
		return sellerSeq;
	}

	public void setSellerSeq(int sellerSeq) {
		this.sellerSeq = sellerSeq;
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

	public String getSalePeriod() {
		return salePeriod;
	}

	public void setSalePeriod(String salePeriod) {
		this.salePeriod = salePeriod;
	}

	public int getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}

	public int getSalePercent() {
		return salePercent;
	}

	public void setSalePercent(int salePercent) {
		this.salePercent = salePercent;
	}


	public String getEventAdded() {
		return eventAdded;
	}

	public void setEventAdded(String eventAdded) {
		this.eventAdded = eventAdded;
	}
	public String getFreeDeli() {
		return freeDeli;
	}

	public void setFreeDeli(String freeDeli) {
		this.freeDeli = freeDeli;
	}

	@Override
	public String toString() {
		return "ItemOptionVo [seq=" + seq + ", itemSeq=" + itemSeq
				+ ", optionName=" + optionName + ", showFlag=" + showFlag
				+ ", modDate=" + modDate + ", regDate=" + regDate
				+ ", optionSeq=" + optionSeq + ", valueName=" + valueName
				+ ", stockCount=" + stockCount + ", stockFlag=" + stockFlag + ", optionPrice=" + optionPrice
				+ ", salePrice=" + salePrice +", salePeriod=" + salePeriod + ", eventAdded="+ eventAdded
				+ ", sellPrice=" + sellPrice +", salePercent="+ salePercent
				+ ", valueList=" + valueList + ", count=" + count +",freeDeli=" + freeDeli
				+ ", modContent=" + modContent + ", column=" + column + "]";
	}
}
