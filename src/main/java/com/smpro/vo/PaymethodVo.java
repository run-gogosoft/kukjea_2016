package com.smpro.vo;

public class PaymethodVo {
	private Integer seq;
	private String name = "";
	private String value = "";
	private Float feeRate1;
	private Float feeRate2;
	
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	public Float getFeeRate1() {
		return feeRate1;
	}
	public void setFeeRate1(Float feeRate1) {
		this.feeRate1 = feeRate1;
	}
	
	public Float getFeeRate2() {
		return feeRate2;
	}
	public void setFeeRate2(Float feeRate2) {
		this.feeRate2 = feeRate2;
	}
}
