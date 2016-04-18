package com.smpro.util.exception;

public class ImageIsNotAvailableException extends Exception {
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return "이 파일은 이미지가 아니거나 사용할 수 없습니다";
	}
}
