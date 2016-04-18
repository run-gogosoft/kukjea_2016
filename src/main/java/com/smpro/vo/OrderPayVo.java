package com.smpro.vo;

public class OrderPayVo {
	/* 결제 관련 */
	// 시퀀스(PK)
	private Integer seq;
	// 주문번호
	private Integer orderSeq;
	// PG거래번호
	private String tid = "";
	// 주문번호(PG수신)
	private String oid = "";
	// 상점아이디
	private String mid = "";
	// 처리결과 코드
	private String resultCode = "";
	// 처리결과 메세지
	private String resultMsg = "";
	// 결제 금액
	private int amount;
	// 현재 결제 금액
	private int curAmount;
	// 결제수단 코드
	private String methodCode = "";
	// 결제기관 코드
	private String orgCode = "";
	// 결제기관 명
	private String orgName = "";
	// 에스크로 적용 여부
	private String escrowFlag = "";
	// 승인 번호
	private String approvalNo = "";
	// 카드 할부 개월 수
	private String cardMonth = "";
	// 무이자 할부 여부
	private String interestFlag = "";
	// 현금영수증 유형(0:소득공제, 1:지출증빙)
	private String cashReceiptTypeCode = "";
	// 현금영수증 번호
	private String cashReceiptNo = "";
	// 계좌번호
	private String accountNo = "";
	// 거래일자(가상계좌일 경우 입금일자)
	private String transDate = "";
	// PG사 구분 코드
	private String pgCode = "";
	// 등록일자
	private String regDate = "";
	// PG 상점 아이디
	private String pgId = "";
	// PG 상점 키
	private String pgKey = "";
	// 면세 대상 금액
	private int taxFreeAmount;

	/** 결제 취소 관련 */
	// 결제 시퀀스(FK)
	private Integer orderPaySeq;
	// 취소 유형(ALL:전체취소, PART:부분취소)
	private String typeCode = "";
	// 부분취소시 해당 상품주문번호
	private Integer orderDetailSeq;
	// 기 전체취소 여부 체크
	private Integer checkCancelAll;
	// 처리 결과 정상 여부
	private String resultFlag = "";
	// 부분 취소 금액
	private int partCancelAmt;

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

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getCurAmount() {
		return curAmount;
	}

	public void setCurAmount(int curAmount) {
		this.curAmount = curAmount;
	}

	public String getMethodCode() {
		return methodCode;
	}

	public void setMethodCode(String methodCode) {
		this.methodCode = methodCode;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getEscrowFlag() {
		return escrowFlag;
	}

	public void setEscrowFlag(String escrowFlag) {
		this.escrowFlag = escrowFlag;
	}

	public String getApprovalNo() {
		return approvalNo;
	}

	public void setApprovalNo(String approvalNo) {
		this.approvalNo = approvalNo;
	}

	public String getCardMonth() {
		return cardMonth;
	}

	public void setCardMonth(String cardMonth) {
		this.cardMonth = cardMonth;
	}

	public String getInterestFlag() {
		return interestFlag;
	}

	public void setInterestFlag(String interestFlag) {
		this.interestFlag = interestFlag;
	}

	public String getCashReceiptTypeCode() {
		return cashReceiptTypeCode;
	}

	public void setCashReceiptTypeCode(String cashReceiptTypeCode) {
		this.cashReceiptTypeCode = cashReceiptTypeCode;
	}

	public String getCashReceiptNo() {
		return cashReceiptNo;
	}

	public void setCashReceiptNo(String cashReceiptNo) {
		this.cashReceiptNo = cashReceiptNo;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getTransDate() {
		return transDate;
	}

	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}

	public String getPgCode() {
		return pgCode;
	}

	public void setPgCode(String pgCode) {
		this.pgCode = pgCode;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public Integer getOrderPaySeq() {
		return orderPaySeq;
	}

	public void setOrderPaySeq(Integer orderPaySeq) {
		this.orderPaySeq = orderPaySeq;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public Integer getOrderDetailSeq() {
		return orderDetailSeq;
	}

	public void setOrderDetailSeq(Integer orderDetailSeq) {
		this.orderDetailSeq = orderDetailSeq;
	}

	public Integer getCheckCancelAll() {
		return checkCancelAll;
	}

	public void setCheckCancelAll(Integer checkCancelAll) {
		this.checkCancelAll = checkCancelAll;
	}

	public String getResultFlag() {
		return resultFlag;
	}

	public void setResultFlag(String resultFlag) {
		this.resultFlag = resultFlag;
	}

	public int getPartCancelAmt() {
		return partCancelAmt;
	}

	public void setPartCancelAmt(int partCancelAmt) {
		this.partCancelAmt = partCancelAmt;
	}

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public String getPgKey() {
		return pgKey;
	}

	public void setPgKey(String pgKey) {
		this.pgKey = pgKey;
	}
}
