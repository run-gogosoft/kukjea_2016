package com.smpro.util.exception;

public class ExcelOutOfBoundsException extends Exception {
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return "ERROR: 이 문제는 옵션항목의 필드가 잘못 입력된 것으로 보입니다. 해당 옵션의 항목을 컴마(,)로 분할할 때 개수가 일치하여야 합니다";
	}
}
