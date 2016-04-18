package com.smpro.util.exception;

public class ImageDownloadException extends Exception {
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return "이미지를 불러오는 도중에 실패하였습니다. 이미지 경로가 올바르지 않거나, 이미지가 아니거나, 접속할 수 없었습니다";
	}
}
