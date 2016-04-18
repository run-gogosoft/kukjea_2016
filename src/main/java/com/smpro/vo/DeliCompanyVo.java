package com.smpro.vo;

public class DeliCompanyVo {
	/** 배송업체 시퀀스 */
	private Integer deliSeq;
	/** 배송업체 */
	private String deliCompanyName = "";
	/** 배송업체 전화번호 */
	private String deliCompanyTel = "";
	/** 배송업체 송장추적 URL */
	private String deliTrackUrl = "";
	/** 송장번호 */
	private String deliNo = "";
	/** 배송완료 메시지 */
	private String completeMsg = "";
	/** 배송업체 사용여부 */
	private String useFlag = "";

	/* 배송 */
	public Integer getDeliSeq() {
		return deliSeq;
	}

	public void setDeliSeq(Integer deliSeq) {
		this.deliSeq = deliSeq;
	}

	public String getDeliCompanyName() {
		return deliCompanyName;
	}

	public void setDeliCompanyName(String deliCompanyName) {
		this.deliCompanyName = deliCompanyName;
	}

	public String getDeliCompanyTel() {
		return deliCompanyTel;
	}

	public void setDeliCompanyTel(String deliCompanyTel) {
		this.deliCompanyTel = deliCompanyTel;
	}

	public String getDeliTrackUrl() {
		return deliTrackUrl;
	}

	public void setDeliTrackUrl(String deliTrackUrl) {
		this.deliTrackUrl = deliTrackUrl;
	}

	public String getDeliNo() {
		return deliNo;
	}

	public void setDeliNo(String deliNo) {
		this.deliNo = deliNo;
	}

	public String getCompleteMsg() {
		return completeMsg;
	}

	public void setCompleteMsg(String completeMsg) {
		this.completeMsg = completeMsg;
	}

	public String getUseFlag() {
		return useFlag;
	}

	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
}
