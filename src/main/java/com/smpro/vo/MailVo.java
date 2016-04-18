package com.smpro.vo;

public class MailVo {
	/** 제목 */
	private String subject = "";
	/** 내용 */
	private String text = "";
	/** 발신자 메일 주소 (보내는 사람) */
	private String fromUser = "";
	/** 수신자 메일 주소 (받는 사람) */
	private String toUser = "";
	/** 함께 보내는 수신자 메일 주소들 */
	private String[] toCc;

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getText() {
		return text;
	}

	/** CLEARXSS를 적용하지 않았다. */
	public void setText(String text) {
		this.text = text;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String[] getToCc() {
		if (toCc == null) {
			return new String[] {};
		}
		return toCc;
	}

	public void setToCc(String[] toCc) {
		this.toCc = toCc;
	}
}