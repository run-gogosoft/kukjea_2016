package com.smpro.vo;

import com.smpro.util.Const;

public class AdjustVo extends PagingVo {
	// 시퀀스
	private Integer seq;
	// 주문 번호 시퀀스
	private Integer orderSeq;
	// 상품 주문 번호 시퀀스
	private Integer orderDetailSeq;
	// 몰 시퀀스
	private Integer mallSeq;
	// 취소 여부(Y:취소정산, N:정산)
	private String cancelFlag = "";
	// 완료 여부(Y:정산(송금)완료, N:정산(송금)미완료
	private String completeFlag = "";
	// 정상 등급
	private String adjustGradeCode = "";
	// 판매가
	private int sellPrice;
	// 판매원가
	private int orgPrice;
	// 공급가
	private int supplyPrice;
	// 주문 수량
	private int orderCnt;
	// 선결제 배송비
	private int deliCost= Const.DELI_COST;
	// 과세여부 (1=과세, 2=면세)
	private String taxCode = "";
	// 쇼핑몰명
	private String mallName = "";
	// 입점업체 시퀀스
	private Integer sellerSeq;
	// 입점업체 아이디
	private String sellerId = "";
	// 입점업체명
	private String sellerName = "";
	// 주문 년월
	private String orderYm = "";
	// 정산 확정 일자
	private String adjustDate = "";
	// 정산 완료 일자
	private String completeDate = "";

	// 상품명
	private String itemName = "";
	// 상품구분 코드(1:상품, 2:상품권, 3:취급상품)
	private String itemTypeCode = "";
	// 옵션
	private String optionValue = "";

	// 결제 총 금액
	private int payAmount;
	// 결제 수단
	private String payMethod = "";
	private String payMethodName = "";

	// 수취인
	private String receiverName = "";
	// 주문자
	private String memberName = "";
	
	// 조정 사유
	private String reason = "";
	// 수동 추가 건 여부
	private String manualFlag = "N";
	
	/** 날짜 조회용 */
	private String year = "";
	private String month = "";
	private String lastYear = "";

	@Override
	public String getSearch() {
		// TODO Auto-generated method stub
		return super.search;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
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

	public Integer getMallSeq() {
		return mallSeq;
	}

	public void setMallSeq(Integer mallSeq) {
		this.mallSeq = mallSeq;
	}

	public String getCancelFlag() {
		return cancelFlag;
	}

	public void setCancelFlag(String cancelFlag) {
		this.cancelFlag = cancelFlag;
	}

	public String getCompleteFlag() {
		return completeFlag;
	}

	public void setCompleteFlag(String completeFlag) {
		this.completeFlag = completeFlag;
	}

	public String getAdjustGradeCode() {
		return adjustGradeCode;
	}

	public void setAdjustGradeCode(String adjustGradeCode) {
		this.adjustGradeCode = adjustGradeCode;
	}

	public int getOrgPricePrice() {
		return orgPrice;
	}

	public void setOrgPrice(int orgPrice) {
		this.orgPrice = orgPrice;
	}

	public int getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}

	public int getSupplyPrice() {
		return supplyPrice;
	}

	public void setSupplyPrice(int supplyPrice) {
		this.supplyPrice = supplyPrice;
	}

	public int getOrderCnt() {
		return orderCnt;
	}

	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

	public int getDeliCost() {
		return deliCost;
	}

	public void setDeliCost(int deliCost) {
		this.deliCost = deliCost;
	}

	public String getTaxCode() {
		return taxCode;
	}

	public void setTaxCode(String taxCode) {
		this.taxCode = taxCode;
	}

	public String getMallName() {
		return mallName;
	}

	public void setMallName(String mallName) {
		this.mallName = mallName;
	}

	public Integer getSellerSeq() {
		return sellerSeq;
	}

	public void setSellerSeq(Integer sellerSeq) {
		this.sellerSeq = sellerSeq;
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getOrderYm() {
		return orderYm;
	}

	public void setOrderYm(String orderYm) {
		this.orderYm = orderYm;
	}

	public String getAdjustDate() {
		return adjustDate;
	}

	public void setAdjustDate(String adjustDate) {
		this.adjustDate = adjustDate;
	}

	public String getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemTypeCode() {
		return itemTypeCode;
	}

	public void setItemTypeCode(String itemTypeCode) {
		this.itemTypeCode = itemTypeCode;
	}

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public int getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(int payAmount) {
		this.payAmount = payAmount;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getPayMethodName() {
		return payMethodName;
	}

	public void setPayMethodName(String payMethodName) {
		this.payMethodName = payMethodName;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getManualFlag() {
		return manualFlag;
	}

	public void setManualFlag(String manualFlag) {
		this.manualFlag = manualFlag;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getLastYear() {
		return lastYear;
	}

	public void setLastYear(String lastYear) {
		this.lastYear = lastYear;
	}
}
