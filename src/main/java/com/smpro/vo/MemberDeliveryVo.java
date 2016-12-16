package com.smpro.vo;

public class MemberDeliveryVo {
	/** 시퀀스 */
	private Integer seq;
	/** 회원 시퀀스 */
	private Integer memberSeq;
	/** 배송지 명 */
	private String title = "";
	/** 수취인 명 */
	private String name = "";
	/** 전화번호 */
	private String tel = "";
	private String tel1 = "";
	private String tel2 = "";
	private String tel3 = "";
	/** 휴대폰번호 */
	private String cell = "";
	private String cell1 = "";
	private String cell2 = "";
	private String cell3 = "";
	/** 우편번호 */
	private String postcode = "";
	private String postcode1 = "";
	private String postcode2 = "";
	private String deliveryPostCode1 = "";
	private String deliveryPostCode2 = "";

	/** 주소1 */
	private String addr1 = "";
	private String deliveryAddr1 = "";
	/** 주소2 */
	private String addr2 = "";
	/** 기본 배송지 */
	private String defaultFlag = "";
	/** 변경일 */
	private String modDate = "";
	/** 등록일 */
	private String regDate = "";
	/** 검색조건 */
	private String search = "";
	private String findword = "";
	//이메일 정보
	private String email = "";

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(Integer memberSeq) {
		this.memberSeq = memberSeq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getCell() {
		return cell;
	}

	public void setCell(String cell) {
		this.cell = cell;
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

	public String getDeliveryPostCode1() {
		return deliveryPostCode1;
	}

	public void setDeliveryPostCode1(String deliveryPostCode1) {
		this.deliveryPostCode1 = deliveryPostCode1;
	}

	public String getDeliveryPostCode2() {
		return deliveryPostCode2;
	}

	public void setDeliveryPostCode2(String deliveryPostCode2) {
		this.deliveryPostCode2 = deliveryPostCode2;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getDeliveryAddr1() {
		return deliveryAddr1;
	}

	public void setDeliveryAddr1(String deliveryAddr1) {
		this.deliveryAddr1 = deliveryAddr1;
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

	public String getDefaultFlag() {
		return defaultFlag;
	}

	public void setDefaultFlag(String defaultFlag) {
		this.defaultFlag = defaultFlag;
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

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getFindword() {
		return findword;
	}

	public void setFindword(String findword) {
		this.findword = findword;
	}

}
