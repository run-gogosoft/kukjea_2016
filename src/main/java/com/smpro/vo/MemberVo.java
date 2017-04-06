package com.smpro.vo;
import java.util.List;

public class MemberVo extends UserVo {
	/** 성별 (M:남, F:여) */
	private String sexCode = "";
	/** 생년월일(yyyymmdd) */
	private String birthdate = "";
	private String birthyyyy = "";
	private String birthmm = "";
	private String birthdd = "";
	/** 전화번호 */
	private String tel = "";
	private String tel1 = "";
	private String tel2 = "";
	private String tel3 = "";
	/** 휴대폰 번호 */
	private String cell = "";
	private String cell1 = "";
	private String cell2 = "";
	private String cell3 = "";
	
	/** 이메일 수신동의 */
	private String email = "";
	private String emailFlag = "";
	private String emailFlagDate = "";
	/** SMS 수신동의 */
	private String smsFlag = "";
	private String smsFlagDate = "";
	/** 우편 번호 */
	private String postcode = "";
	private String postcode1 = "";
	private String postcode2 = "";
	/** 주소 */
	private String addr1 = "";
	/** 주소 상세 */
	private String addr2 = "";
	/** 탈퇴 이유 */
	private String closeCode = "";
	private String closeText = "";

	/** 보유 포인트 */
	private int point = 0;
	/** 몰 이름 */
	private String mallName = "";

	/** 회원 구분 */
	private String memberTypeName = "";
	
	/** 가입 경로 */
	private String joinPathCode = "";
	private String joinPathName = "";
	/** 관심 카테고리 */
	private String interestCategoryCode = "";
	private String interestCategoryName = "";
	/**본인확인 인증키(아이핀, 본인인증) **/
	private String certKey = "";
	
	/** 부서명 */
	private String deptName = "";
	/** 직책 */
	private String posName = "";
	/** 그룹 시퀀스 */
	private Integer groupSeq;
	/** 그룹명(기관,단체) */
	private String groupName = "";
	/** 투자출연기관 여부 */
	private String investFlag = "";
	
	/** 장기미접속 여부 */
	private String longTermNotLoginFlag ="";


	/** 총주문액 **/
	private int totalOrderPrice = 0;
	/** 등급 **/
	private String gradeName = "";

	public void setTotalOrderPrice(int price){ this.totalOrderPrice = price;}

	public int getTotalOrderPrice(){return this.totalOrderPrice;}

	public void setGradeName(String grade){ this.gradeName = grade;}

	public String getGradeName(){ return this.gradeName;}

	public String getSexCode() {
		return sexCode;
	}

	public void setSexCode(String sexCode) {
		this.sexCode = sexCode;
	}

	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getBirthyyyy() {
		return birthyyyy;
	}
	public void setBirthyyyy(String birthyyyy) {
		this.birthyyyy = birthyyyy;
	}

	public String getBirthmm() {
		return birthmm;
	}
	public void setBirthmm(String birthmm) {
		this.birthmm = birthmm;
	}

	public String getBirthdd() {
		return birthdd;
	}
	public void setBirthdd(String birthdd) {
		this.birthdd = birthdd;
	}

	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getCell() {
		return cell;
	}
	public void setCell(String cell) {
		this.cell = cell;
	}

	public String getCell1() {
		return cell1;
	}
	public void setCell1(String cell1) {
		this.cell1 = cell1;
	}

	public String getCell2() {
		return cell2;
	}
	public void setCell2(String cell2) {
		this.cell2 = cell2;
	}

	public String getCell3() {
		return cell3;
	}
	public void setCell3(String cell3) {
		this.cell3 = cell3;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmailFlag() {
		return emailFlag;
	}
	public void setEmailFlag(String emailFlag) {
		this.emailFlag = emailFlag;
	}

	public String getSmsFlag() {
		return smsFlag;
	}
	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}

	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getPostcode1() {
		return postcode1;
	}
	public void setPostcode1(String postcode1) {
		this.postcode1 = postcode1;
	}

	public String getPostcode2() {
		return postcode2;
	}
	public void setPostcode2(String postcode2) {
		this.postcode2 = postcode2;
	}

	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		if(addr2 != null) {
			addr2 = addr2.trim();
		}
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getCloseCode() {
		return closeCode;
	}
	public void setCloseCode(String closeCode) {
		this.closeCode = closeCode;
	}

	public String getCloseText() {
		return closeText;
	}
	public void setCloseText(String closeText) {
		this.closeText = closeText;
	}

	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}

	public String getMallName() {
		return mallName;
	}
	public void setMallName(String mallName) {
		this.mallName = mallName;
	}

	public String getEmailFlagDate() {
		return emailFlagDate;
	}
	public void setEmailFlagDate(String emailFlagDate) {
		this.emailFlagDate = emailFlagDate;
	}

	public String getSmsFlagDate() {
		return smsFlagDate;
	}
	public void setSmsFlagDate(String smsFlagDate) {
		this.smsFlagDate = smsFlagDate;
	}

	public String getJoinPathCode() {
		return joinPathCode;
	}
	public void setJoinPathCode(String joinPathCode) {
		this.joinPathCode = joinPathCode;
	}

	public String getInterestCategoryCode() {
		return interestCategoryCode;
	}
	public void setInterestCategoryCode(String interestCategoryCode) {
		this.interestCategoryCode = interestCategoryCode;
	}

	public Integer getGroupSeq() {
		return groupSeq;
	}
	public void setGroupSeq(Integer groupSeq) {
		this.groupSeq = groupSeq;
	}

	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPosName() {
		return posName;
	}
	public void setPosName(String posName) {
		this.posName = posName;
	}

	public String getMemberTypeName() {
		return memberTypeName;
	}

	public void setMemberTypeName(String memberTypeName) {
		this.memberTypeName = memberTypeName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getInvestFlag() {
		return investFlag;
	}

	public void setInvestFlag(String investFlag) {
		this.investFlag = investFlag;
	}

	public String getJoinPathName() {
		return joinPathName;
	}

	public void setJoinPathName(String joinPathName) {
		this.joinPathName = joinPathName;
	}

	public String getInterestCategoryName() {
		return interestCategoryName;
	}

	public void setInterestCategoryName(String interestCategoryName) {
		this.interestCategoryName = interestCategoryName;
	}

	public String getCertKey() {
		return certKey;
	}

	public void setCertKey(String certKey) {
		this.certKey = certKey;
	}

	public String getLongTermNotLoginFlag() {
		return longTermNotLoginFlag;
	}

	public void setLongTermNotLoginFlag(String longTermNotLoginFlag) {
		this.longTermNotLoginFlag = longTermNotLoginFlag;
	}
}
