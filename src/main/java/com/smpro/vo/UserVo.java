package com.smpro.vo;

import java.util.List;

public class UserVo extends PagingVo {
	/** 시퀀스(고유번호) */
	protected Integer seq;
	/** 몰 시퀀스 */
	protected Integer mallSeq;
	/** 아이디 */
	protected String id = "";
	/** 패스워드 */
	protected String password = "";
	/** 새 비밀번호 (비밀번호 변경시) */
	protected String newPassword = "";
	
	/** 이름/입점업체명(법인명)/쇼핑몰명 */
	protected String name = "";
	/** 닉네임/가칭 */
	protected String nickname = "";
	/** 유형 (A:관리자,S:입점업체,D:총판,C:회원,P:택배사) */
	protected String typeCode = "";
	/** 상태(H:승인대기, Y:정상, N:중지, X:폐점/탈퇴) */
	protected String statusCode = "";
	protected String statusText = "";
	/** 등급 (9:일반, 0:연구소) */
	protected Integer gradeCode;
	protected String gradeText = "";
	/** 로그인 토큰(세션 유지) */
	protected String loginToken = "";
	/** 마지막 접속 아이피 */
	protected String lastIp = "";
	/** 마지막 접속일 */
	protected String lastDate = "";
	/** 임시비밀번호 */
	protected String tempPassword = "";
	/** 임시 비밀번호 발급일 */
	protected String tempPasswordDate = "";
	/** 비밀번호 변경일 */
	protected String modPasswordDate = "";
	/** 변경일 */
	protected String modDate = "";
	/** 등록일 */
	protected String regDate = "";
	
	/** 패스워드 변경 안내 여부 */
	protected String notiPasswordFlag = "";

	/** 가입 회원 수 */
	protected int userCount;

	/** 로그 액션 (로그인/조회/수정, 외부로그인/조회/수정) */
	protected String logAction = "";
	/** 로그 내용 */
	protected String logContent = "";
	/** 로그용 로그인 시퀀스 */
	protected Integer logLoginSeq;
	/** 관리자 등급에 따른 권한 체크를 위한 필드 추가 */
	/** 컨트롤러 이름 */
	protected String controllerName = "";
	/** 메소드 이름 */
	protected String controllerMethod = "";
	/** 구분자 이름 */
	protected String controllerDivision = "";
	/** 컨트롤러 설명 */
	protected String controllerDescription = "";
	/** 연구소 */
	protected String admin0Flag = "";
	/** 최고 관리자 */
	protected String admin1Flag = "";
	/** 운영 관리자 */
	protected String admin2Flag = "";
	/** 디자이너 */
	protected String admin3Flag = "";
	/** 정산 관리자 */
	protected String admin4Flag = "";
	/** CS관리자 */
	protected String admin5Flag = "";
	/** 임시 */
	protected String admin6Flag = "";
	/** 임시 */
	protected String admin7Flag = "";
	/** 임시 */
	protected String admin8Flag = "";
	/** 일반 관리자 */
	protected String admin9Flag = "";
	/** 총판 */
	protected String distributorFlag = "";
	/** 입점업체 */
	protected String sellerFlag = "";
	/** 이메일 */
	private String email = "";
	private String email1 = "";
	private String email2 = "";
	/** 접속지 아이피 주소 */
	private String ipAddr = "";
	
	/** 회원 유형 코드 */
	private String memberTypeCode = "";

	/** mall access **/
	private List<MallAccessVo> mallAccessVos=null;

	public void setMallAccessVos(List<MallAccessVo> lists){
		this.mallAccessVos = lists;
	}

	public List<MallAccessVo> getMallAccessVos(){
		return this.mallAccessVos;
	}
	
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	
	public Integer getMallSeq() {
		return mallSeq;
	}
	public void setMallSeq(Integer mallSeq) {
		this.mallSeq = mallSeq;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusText() {
		return statusText;
	}

	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}

	public Integer getGradeCode() {
		return gradeCode;
	}

	public void setGradeCode(Integer gradeCode) {
		this.gradeCode = gradeCode;
	}

	public String getGradeText() {
		return gradeText;
	}

	public void setGradeText(String gradeText) {
		this.gradeText = gradeText;
	}

	public String getLoginToken() {
		return loginToken;
	}

	public void setLoginToken(String loginToken) {
		this.loginToken = loginToken;
	}

	public String getLastIp() {
		return lastIp;
	}

	public void setLastIp(String lastIp) {
		this.lastIp = lastIp;
	}

	public String getLastDate() {
		return lastDate;
	}

	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}

	public String getTempPassword() {
		return tempPassword;
	}

	public void setTempPassword(String tempPassword) {
		this.tempPassword = tempPassword;
	}

	public String getTempPasswordDate() {
		return tempPasswordDate;
	}

	public void setTempPasswordDate(String tempPasswordDate) {
		this.tempPasswordDate = tempPasswordDate;
	}

	public String getModPasswordDate() {
		return modPasswordDate;
	}

	public void setModPasswordDate(String modPasswordDate) {
		this.modPasswordDate = modPasswordDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	
	public String getNotiPasswordFlag() {
		return notiPasswordFlag;
	}
	public void setNotiPasswordFlag(String notiPasswordFlag) {
		this.notiPasswordFlag = notiPasswordFlag;
	}
	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public String getLogAction() {
		return logAction;
	}

	public void setLogAction(String logAction) {
		this.logAction = logAction;
	}

	public String getLogContent() {
		return logContent;
	}

	public void setLogContent(String logContent) {
		this.logContent = logContent;
	}

	public Integer getLogLoginSeq() {
		return logLoginSeq;
	}

	public void setLogLoginSeq(Integer logLoginSeq) {
		this.logLoginSeq = logLoginSeq;
	}

	public String getControllerName() {
		return controllerName;
	}

	public void setControllerName(String controllerName) {
		this.controllerName = controllerName;
	}

	public String getControllerMethod() {
		return controllerMethod;
	}

	public void setControllerMethod(String controllerMethod) {
		this.controllerMethod = controllerMethod;
	}

	public String getControllerDivision() {
		return controllerDivision;
	}

	public void setControllerDivision(String controllerDivision) {
		this.controllerDivision = controllerDivision;
	}

	public String getAdmin0Flag() {
		return admin0Flag;
	}

	public void setAdmin0Flag(String admin0Flag) {
		this.admin0Flag = admin0Flag;
	}

	public String getAdmin1Flag() {
		return admin1Flag;
	}

	public void setAdmin1Flag(String admin1Flag) {
		this.admin1Flag = admin1Flag;
	}

	public String getAdmin2Flag() {
		return admin2Flag;
	}

	public void setAdmin2Flag(String admin2Flag) {
		this.admin2Flag = admin2Flag;
	}

	public String getAdmin3Flag() {
		return admin3Flag;
	}

	public void setAdmin3Flag(String admin3Flag) {
		this.admin3Flag = admin3Flag;
	}

	public String getAdmin4Flag() {
		return admin4Flag;
	}

	public void setAdmin4Flag(String admin4Flag) {
		this.admin4Flag = admin4Flag;
	}

	public String getAdmin5Flag() {
		return admin5Flag;
	}

	public void setAdmin5Flag(String admin5Flag) {
		this.admin5Flag = admin5Flag;
	}

	public String getAdmin6Flag() {
		return admin6Flag;
	}

	public void setAdmin6Flag(String admin6Flag) {
		this.admin6Flag = admin6Flag;
	}

	public String getAdmin7Flag() {
		return admin7Flag;
	}

	public void setAdmin7Flag(String admin7Flag) {
		this.admin7Flag = admin7Flag;
	}

	public String getAdmin8Flag() {
		return admin8Flag;
	}

	public void setAdmin8Flag(String admin8Flag) {
		this.admin8Flag = admin8Flag;
	}

	public String getAdmin9Flag() {
		return admin9Flag;
	}

	public void setAdmin9Flag(String admin9Flag) {
		this.admin9Flag = admin9Flag;
	}

	public String getDistributorFlag() {
		return distributorFlag;
	}

	public void setDistributorFlag(String distributorFlag) {
		this.distributorFlag = distributorFlag;
	}

	public String getSellerFlag() {
		return sellerFlag;
	}

	public void setSellerFlag(String sellerFlag) {
		this.sellerFlag = sellerFlag;
	}

	public String getControllerDescription() {
		return controllerDescription;
	}

	public void setControllerDescription(String controllerDescription) {
		this.controllerDescription = controllerDescription;
	}


	public String getEmail() {
		if(email != null) {
			email = email.trim();
		}
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	
	
	public String getMemberTypeCode() {
		return memberTypeCode;
	}
	public void setMemberTypeCode(String memberTypeCode) {
		this.memberTypeCode = memberTypeCode;
	}
	
	@Override
	public String getSearch() {
		return super.search;
	}
}
