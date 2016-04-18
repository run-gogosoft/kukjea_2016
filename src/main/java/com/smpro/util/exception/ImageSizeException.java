package com.smpro.util.exception;

public class ImageSizeException extends Exception {
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return "이미지의 사이즈가 올바르지 않습니다";
	}
}
