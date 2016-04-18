package com.smpro.vo;

public class EstimateVo extends PagingVo {
	private Integer seq;
	private Integer orderDetailSeq;
	private Integer memberSeq;
	private Integer sellerSeq;
	private Integer itemSeq;
	private Integer optionValueSeq;
	private int amount;
	private int qty;
	private String typeCode = "";
	private String typeName = "";
	private String file = "";
	private String fileName = "";
	private String request = "";
	private String modDate = "";
	private String regDate = "";
	private String orderRegDate = "";
	
	private Integer orderSeq;
	private String memberName = "";
	private String sellerName = "";
	private String statusCode = "";
	private String statusText = "";
	private String itemName = "";
	private String cateLv1Name = "";
	private String optionValue = "";
	private int sellPrice;
	private int orderCnt;
	
	private String orderStatusCode = "";
	private String orderStatusText = "";
	
	private String img1 = "";
		
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
	
	public Integer getOrderDetailSeq() {
		return orderDetailSeq;
	}
	public void setOrderDetailSeq(Integer orderDetailSeq) {
		this.orderDetailSeq = orderDetailSeq;
	}
	
	public Integer getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(Integer memberSeq) {
		this.memberSeq = memberSeq;
	}
	
		
	public Integer getSellerSeq() {
		return sellerSeq;
	}

	public void setSellerSeq(Integer sellerSeq) {
		this.sellerSeq = sellerSeq;
	}

	public Integer getItemSeq() {
		return itemSeq;
	}
	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}
	
	public Integer getOptionValueSeq() {
		return optionValueSeq;
	}
	public void setOptionValueSeq(Integer optionValueSeq) {
		this.optionValueSeq = optionValueSeq;
	}
	
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	
	
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
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

	public Integer getOrderSeq() {
		return orderSeq;
	}
	public void setOrderSeq(Integer orderSeq) {
		this.orderSeq = orderSeq;
	}

	

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getStatusText() {
		return statusText;
	}

	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}

	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getCateLv1Name() {
		return cateLv1Name;
	}

	public void setCateLv1Name(String cateLv1Name) {
		this.cateLv1Name = cateLv1Name;
	}

	public String getOptionValue() {
		return optionValue;
	}
	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public int getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}

	
	public int getOrderCnt() {
		return orderCnt;
	}
	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getOrderStatusCode() {
		return orderStatusCode;
	}

	public void setOrderStatusCode(String orderStatusCode) {
		this.orderStatusCode = orderStatusCode;
	}

	public String getOrderStatusText() {
		return orderStatusText;
	}

	public void setOrderStatusText(String orderStatusText) {
		this.orderStatusText = orderStatusText;
	}

	public String getOrderRegDate() {
		return orderRegDate;
	}

	public void setOrderRegDate(String orderRegDate) {
		this.orderRegDate = orderRegDate;
	}

	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}	
}
