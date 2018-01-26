package com.smpro.vo;

public class SellerVo extends UserVo {
	/** 정산 등급 */
	// private int adjustGradeCode;
	/** 대표자명 */
	private String ceoName = "";
	/** 사업자 번호 */
	private String bizNo = "";
	private String bizNo1 = "";
	private String bizNo2 = "";
	private String bizNo3 = "";
	/** 업태 */
	private String bizType = "";
	/** 업종 */
	private String bizKind = "";
	/** 매출액 */
	private String totalSales = "";
	/** 종업원수 */
	private String amountOfWorker = "";
	/** 대표 전화 */
	private String tel = "";
	private String tel1 = "";
	private String tel2 = "";
	private String tel3 = "";
	/** 팩스 번호 */
	private String fax = "";
	private String fax1 = "";
	private String fax2 = "";
	private String fax3 = "";
	/** 우편 번호 */
	private String postcode = "";
	private String postcode1 = "";
	private String postcode2 = "";
	/** 주소 */
	private String addr1 = "";
	/** 주소 상세 */
	private String addr2 = "";
	/** 담당자명 */
	private String salesName = "";
	/** 담당자 전화번호 */
	private String salesTel = "";
	private String salesTel1 = "";
	private String salesTel2 = "";
	private String salesTel3 = "";
	/** 담당자 휴대폰 번호 */
	private String salesCell = "";
	private String salesCell1 = "";
	private String salesCell2 = "";
	private String salesCell3 = "";
	/** 담당자 이메일 */
	private String salesEmail = "";
	/** 입급 계좌 은행 */
	private String accountBank = "";
	/** 입급 계좌 번호 */
	private String accountNo = "";
	/** 입급 계좌 예금주 */
	private String accountOwner = "";
	/** 총판 시퀀스 */
	private Integer masterSeq;
	/** 총판 명 */
	private String masterName = "";
	/** 승인 일자 */
	private String approvalDate = "";
	/** 중지 일자 */
	private String stopDate = "";
	/** 폐점 일자 */
	private String closeDate = "";
	/** 추가 */
	/** 기본택배사 */
	private Integer defaultDeliCompany;
	/** 반품담당자 */
	private String returnName = "";
	/** 반품담당자 연락처 */
	private String returnCell = "";
	private String returnCell1 = "";
	private String returnCell2 = "";
	private String returnCell3 = "";
	/** 반품주소지 우편번호 */
	private String returnPostCode = "";
	private String returnPostCode1 = "";
	private String returnPostCode2 = "";
	/** 반품주소 */
	private String returnAddr1 = "";
	/** 반품 상세주소 */
	private String returnAddr2 = "";
	/** 공급사 소개 */
	private String intro = "";
	/** 주요취급상품 */
	private String mainItem = "";
	/** 사회적경제활동 */
	private String socialActivity = "";
	/** 총 상품갯수 */
	private int totalItemCount;
	/** 판매중인 상품갯수 */
	private int sellItemCount;
	/** 면세기업 여부 (Y:과세, N:면세) */
	private String taxTypeFlag = "";

	/** 정산 담당자명 */
	private String adjustName = "";
	/** 정산 담당자 이메일 */
	private String adjustEmail= "";
	/** 정산 담당자 연락처 */
	private String adjustTel = "";
	private String adjustTel1 = "";
	private String adjustTel2 = "";
	private String adjustTel3 = "";
	/** 자치구 */
	private String jachiguCode = "";
	private String jachiguName = "";
	/** 첨부파일 존재 여부 */
	private String isFile = "";
	/** 인증구분 */
	private String authCategory = "";
	private String[] authCategoryArr;
	
	private String comment = "";

	private int commission = 0;

	/** 총판매액 **/
	private long totalSellPrice = 0;

	/** 총판원가액 **/
	private long totalSellOrgPrice = 0;

	/** 총배송비액 **/
	private long deliCost = 0;

	/** 총실배송비액 **/
	private long totalDeliCost = 0;

	/** 판매건수 **/
	private int totlaSellCount = 0;

	public int getTotalSellCount(){return this.totlaSellCount;}

	public void setTotalSellCount(int count){this.totlaSellCount = count;}

	public long getTotalSellPrice(){return this.totalSellPrice;}

	public void setTotalSellPrice(long price){this.totalSellPrice = price;}


	public long getTotalSellOrgPrice(){return this.totalSellOrgPrice;}

	public void setTotalSellOrgPrice(long price){this.totalSellOrgPrice = price;}
	public long getDeliCost(){return this.deliCost;}

	public void setDeliCost(long price){this.deliCost = price;}
	public long getTotalDeliCost(){return this.totalDeliCost;}

	public void setTotalDeliCost(long price){this.totalDeliCost = price;}




	public int getCommission() {
		return commission;
	}

	public void setCommission(int commission) {
		this.commission = commission;
	}


	public String getSocialActivity() {
		return socialActivity;
	}

	public void setSocialActivity(String socialActivity) {
		this.socialActivity = socialActivity;
	}

	public String[] getAuthCategoryArr() {
		return authCategoryArr;
	}

	public void setAuthCategoryArr(String[] authCategoryArr) {
		this.authCategoryArr = authCategoryArr;
	}

	public String getTaxTypeFlag() {
		return taxTypeFlag;
	}

	public void setTaxTypeFlag(String taxTypeFlag) {
		this.taxTypeFlag = taxTypeFlag;
	}

	public String getCeoName() {
		return ceoName;
	}

	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}

	public String getBizNo() {
		return bizNo;
	}

	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}

	public String getBizNo1() {
		return bizNo1;
	}

	public void setBizNo1(String bizNo1) {
		this.bizNo1 = bizNo1;
	}

	public String getBizNo2() {
		return bizNo2;
	}

	public void setBizNo2(String bizNo2) {
		this.bizNo2 = bizNo2;
	}

	public String getBizNo3() {
		return bizNo3;
	}

	public void setBizNo3(String bizNo3) {
		this.bizNo3 = bizNo3;
	}

	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}

	public String getBizKind() {
		return bizKind;
	}

	public void setBizKind(String bizKind) {
		this.bizKind = bizKind;
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

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getFax1() {
		return fax1;
	}

	public void setFax1(String fax1) {
		this.fax1 = fax1;
	}

	public String getFax2() {
		return fax2;
	}

	public void setFax2(String fax2) {
		this.fax2 = fax2;
	}

	public String getFax3() {
		return fax3;
	}

	public void setFax3(String fax3) {
		this.fax3 = fax3;
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
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getSalesName() {
		return salesName;
	}

	public void setSalesName(String salesName) {
		this.salesName = salesName;
	}

	public String getSalesTel() {
		return salesTel;
	}

	public void setSalesTel(String salesTel) {
		this.salesTel = salesTel;
	}

	public String getSalesTel1() {
		return salesTel1;
	}

	public void setSalesTel1(String salesTel1) {
		this.salesTel1 = salesTel1;
	}

	public String getSalesTel2() {
		return salesTel2;
	}

	public void setSalesTel2(String salesTel2) {
		this.salesTel2 = salesTel2;
	}

	public String getSalesTel3() {
		return salesTel3;
	}

	public void setSalesTel3(String salesTel3) {
		this.salesTel3 = salesTel3;
	}

	public String getSalesCell() {
		return salesCell;
	}

	public void setSalesCell(String salesCell) {
		this.salesCell = salesCell;
	}

	public String getSalesCell1() {
		return salesCell1;
	}

	public void setSalesCell1(String salesCell1) {
		this.salesCell1 = salesCell1;
	}

	public String getSalesCell2() {
		return salesCell2;
	}

	public void setSalesCell2(String salesCell2) {
		this.salesCell2 = salesCell2;
	}

	public String getSalesCell3() {
		return salesCell3;
	}

	public void setSalesCell3(String salesCell3) {
		this.salesCell3 = salesCell3;
	}

	public String getSalesEmail() {
		return salesEmail;
	}

	public void setSalesEmail(String salesEmail) {
		this.salesEmail = salesEmail;
	}

	public String getAccountBank() {
		return accountBank;
	}

	public void setAccountBank(String accountBank) {
		this.accountBank = accountBank;
	}

	public String getAccountNo() {
		if(accountNo != null) {
			accountNo = accountNo.trim();
		}
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getAccountOwner() {
		return accountOwner;
	}

	public void setAccountOwner(String accountOwner) {
		this.accountOwner = accountOwner;
	}

	public Integer getMasterSeq() {
		return masterSeq;
	}

	public void setMasterSeq(Integer masterSeq) {
		this.masterSeq = masterSeq;
	}

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}

	public String getStopDate() {
		return stopDate;
	}

	public void setStopDate(String stopDate) {
		this.stopDate = stopDate;
	}

	public String getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}

	public Integer getDefaultDeliCompany() {
		return defaultDeliCompany;
	}

	public void setDefaultDeliCompany(Integer defaultDeliCompany) {
		this.defaultDeliCompany = defaultDeliCompany;
	}

	public String getReturnName() {
		return returnName;
	}

	public void setReturnName(String returnName) {
		this.returnName = returnName;
	}

	public String getReturnCell() {
		return returnCell;
	}

	public void setReturnCell(String returnCell) {
		this.returnCell = returnCell;
	}

	public String getReturnCell1() {
		return returnCell1;
	}

	public void setReturnCell1(String returnCell1) {
		this.returnCell1 = returnCell1;
	}

	public String getReturnCell2() {
		return returnCell2;
	}

	public void setReturnCell2(String returnCell2) {
		this.returnCell2 = returnCell2;
	}

	public String getReturnCell3() {
		return returnCell3;
	}

	public void setReturnCell3(String returnCell3) {
		this.returnCell3 = returnCell3;
	}

	public String getReturnPostCode() {
		return returnPostCode;
	}

	public void setReturnPostCode(String returnPostCode) {
		this.returnPostCode = returnPostCode;
	}

	public String getReturnPostCode1() {
		return returnPostCode1;
	}

	public void setReturnPostCode1(String returnPostCode1) {
		this.returnPostCode1 = returnPostCode1;
	}

	public String getReturnPostCode2() {
		return returnPostCode2;
	}

	public void setReturnPostCode2(String returnPostCode2) {
		this.returnPostCode2 = returnPostCode2;
	}

	public String getReturnAddr1() {
		return returnAddr1;
	}

	public void setReturnAddr1(String returnAddr1) {
		this.returnAddr1 = returnAddr1;
	}

	public String getReturnAddr2() {
		return returnAddr2;
	}

	public void setReturnAddr2(String returnAddr2) {
		this.returnAddr2 = returnAddr2;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getMainItem() {
		return mainItem;
	}

	public void setMainItem(String mainItem) {
		this.mainItem = mainItem;
	}

	public int getTotalItemCount() {
		return totalItemCount;
	}

	public void setTotalItemCount(int totalItemCount) {
		this.totalItemCount = totalItemCount;
	}

	public int getSellItemCount() {
		return sellItemCount;
	}

	public void setSellItemCount(int sellItemCount) {
		this.sellItemCount = sellItemCount;
	}

	public String getAdjustName() {
		return adjustName;
	}

	public void setAdjustName(String adjustName) {
		this.adjustName = adjustName;
	}

	public String getAdjustEmail() {
		return adjustEmail;
	}

	public void setAdjustEmail(String adjustEmail) {
		this.adjustEmail = adjustEmail;
	}

	public String getAdjustTel() {
		return adjustTel;
	}

	public void setAdjustTel(String adjustTel) {
		this.adjustTel = adjustTel;
	}

	public String getAdjustTel1() {
		return adjustTel1;
	}

	public void setAdjustTel1(String adjustTel1) {
		this.adjustTel1 = adjustTel1;
	}

	public String getAdjustTel2() {
		return adjustTel2;
	}

	public void setAdjustTel2(String adjustTel2) {
		this.adjustTel2 = adjustTel2;
	}

	public String getAdjustTel3() {
		return adjustTel3;
	}

	public void setAdjustTel3(String adjustTel3) {
		this.adjustTel3 = adjustTel3;
	}

	public String getJachiguCode() {
		return jachiguCode;
	}

	public void setJachiguCode(String jachiguCode) {
		this.jachiguCode = jachiguCode;
	}

	public String getJachiguName() {
		return jachiguName;
	}

	public void setJachiguName(String jachiguName) {
		this.jachiguName = jachiguName;
	}

	public String getIsFile() {
		return isFile;
	}

	public void setIsFile(String isFile) {
		this.isFile = isFile;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getAuthCategory() {
		return authCategory;
	}

	public void setAuthCategory(String authCategory) {
		this.authCategory = authCategory;
	}

	public String getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(String totalSales) {
		this.totalSales = totalSales;
	}

	public String getAmountOfWorker() {
		return amountOfWorker;
	}

	public void setAmountOfWorker(String amountOfWorker) {
		this.amountOfWorker = amountOfWorker;
	}
}
