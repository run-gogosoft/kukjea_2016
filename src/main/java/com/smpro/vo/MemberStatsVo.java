package com.smpro.vo;

public class MemberStatsVo {
	/** 총회원수 */
	private int totalMember;
	/** 금일 신규 가입자수 */
	private int todayJoinCnt;
	/** 금주 신규 가입자수 */
	private int weekJoinCnt;
	/** 금월 신규 가입자수 */
	private int monthJoinCnt;
	/** 누적 탈퇴 회원수 */
	private int quitCnt;
	/** 총 가입자 수 */
	private int totalCnt;
	/** 등록일 */
	private String period = "";
	/** 가입 회원 수 */
	private int memberCount;

	public int getTotalMember() {
		return totalMember;
	}

	public void setTotalMember(int totalMember) {
		this.totalMember = totalMember;
	}

	public int getTodayJoinCnt() {
		return todayJoinCnt;
	}

	public void setTodayJoinCnt(int todayJoinCnt) {
		this.todayJoinCnt = todayJoinCnt;
	}

	public int getWeekJoinCnt() {
		return weekJoinCnt;
	}

	public void setWeekJoinCnt(int weekJoinCnt) {
		this.weekJoinCnt = weekJoinCnt;
	}

	public int getMonthJoinCnt() {
		return monthJoinCnt;
	}

	public void setMonthJoinCnt(int monthJoinCnt) {
		this.monthJoinCnt = monthJoinCnt;
	}

	public int getQuitCnt() {
		return quitCnt;
	}

	public void setQuitCnt(int quitCnt) {
		this.quitCnt = quitCnt;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public int getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}
}
