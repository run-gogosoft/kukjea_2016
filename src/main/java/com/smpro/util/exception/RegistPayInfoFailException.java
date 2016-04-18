package com.smpro.util.exception;

public class RegistPayInfoFailException extends Exception {
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return super.getMessage() + "\nERROR: 결제 정보가 정상적으로 입력되지 않았습니다";
	}
}
