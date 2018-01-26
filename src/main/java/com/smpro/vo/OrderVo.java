package com.smpro.vo;

import com.smpro.util.Const;

import java.util.List;

public class OrderVo extends PagingVo {
	/** 시퀀스(주문번호) */
	private Integer orderSeq;
	
	/** 총 주문금액 */
	private int totalPrice;
	
	/** 실 결제금액 */
	private int payPrice;
	
	/** 회원 시퀀스 */
	private Integer memberSeq;
	
	/** 회원 그룹 시퀀스 */
	private Integer memberGroupSeq;
	
	/** 회원 구분 */
	private String memberTypeCode = "";
	private String memberTypeName = "";
	
	/** 회원 아이디(이메일) */
	private String memberId = "";
	
	/** 회원명 */
	private String memberName = "";
	
	/** 자치구 */
	private String jachiguCode = "";
	private String jachiguName = "";
	
	/** 요청 사항 */
	private String request = "";
	
	/** 수취인 명 */
	private String receiverName = "";
	
	/** buyer 이메일 */
	private String memberEmail = "";
	
	/** 주문자 휴대폰번호 */
	private String memberCell = "";
	private String memberCell1 = "";
	private String memberCell2 = "";
	private String memberCell3 = "";
	
	/** 수취인 전화번호 */
	private String receiverTel = "";
	private String receiverTel1 = "";
	private String receiverTel2 = "";
	private String receiverTel3 = "";
	
	/** 수취인 휴대폰번호 */
	private String receiverCell = "";
	private String receiverCell1 = "";
	private String receiverCell2 = "";
	private String receiverCell3 = "";
	
	/** 카테고리 이름 */
	private String cateLv1Name = "";
	private String cateLv2Name = "";
	private String cateLv3Name = "";
	private String cateLv4Name = "";
	
	/** 주문자 전화번호 */
	private String memberTel = "";

	private String postcode = "";
	private String postcode1 = "";
	private String postcode2 = "";
	private String addr1 = "";
	private String addr2 = "";

	/** 수취인 우편번호 */
	private String receiverPostcode = "";
	/** 수취인 주소 */
	private String receiverAddr1 = "";
	/** 수취인 주소 상세 */
	private String receiverAddr2 = "";
	/** 수취인 이메일 */
	private String receiverEmail = "";

	/** 시퀀스(상품 주문번호) */
	private Integer seq;
	
	/** 상품 시퀀스 */
	private Integer itemSeq;
	
	/** 옵션값 시퀀스 */
	private Integer optionValueSeq;
	
	/** 상품명 */
	private String itemName = "";
	
	/** 옵션 이름 */
	private String optionName = "";
	
	/** 옵션값(옵션 + 부가옵션 조합) */
	private String optionValue = "";
	
	/** 옵션 밸류 이름 */
	private String valueName = "";
	/**
	 * 주문상태(00:입금대기, 10:결제완료, 20:주문확인, 30:배송중, 50:배송완료, 55:구매확정, 60:교환요청 , 61: 교환진행중, 69: 교환완료 ,
	 * 70: 반품요청, 71:반품진행 , 79:반품완료, 90:취소요청, 99:취소완료)
	 */
	private String statusCode = "";
	private String statusText = "";
	
	/** 이전 주문상태 */
	private String beforeStatusCode = "";

	/** 판매 단가 */
	private int sellPrice;
	
	/** 옵션 추가금액 */
	private int optionPrice;
	
	/** 입점업체 공급가 */
	private int supplyPrice;
	
	/** 총판 공급가 */
	private int supplyMasterPrice;
	
	/** 쿠폰 결제(할인)액 - 구매수량과 관계없이 해당 상품주문의 총 할인 금액 */
	private int couponPrice;
	
	/** 주문 수량 */
	private int orderCnt;
	
	/** 판매가 합계 */
	private int sumSellPrice;
	
	/** 옵션 합계 */
	private int sumOptionPrice;

	/** 배송비 */
	private int deliCost = 0;//Const.DELI_COST;
	
	/** 배송 메세지 */
	private String deliMsg = "";

	/** 공급자 분리 배송료처리 여부 **/
	private String checkBD = "N";

	/** 묶음배송 가능 여부 */
	private String deliPackageFlag = "Y";
	
	/** 배송선결제 여부(착불/선결제선택가능:null,선결제필수:Y,선결제불가:N) */
	private String deliPrepaidFlag = "Y";
	
	/** 묶음 배송비 */
	private int packageDeliCost;
	
	/** 택배사 시퀀스 */
	private Integer deliSeq;
	
	/** 택배사 이름 */
	private String deliCompanyName = "";
	
	/** 택배사 송장조회 URL */
	private String deliTrackUrl = "";
	
	/** 송장 번호 */
	private String deliNo = "";
	
	/** 택배사명 */
	private String deliName = "";
	
	/** 배송완료 메시지 */
	private String completeMsg = "";

	/** 공급사 코드 */
	private String sellerCode = "";
	
	/** 과세여부 (1=과세, 2=면세) */
	private String taxCode = "";
	private String taxName = "";
	
	/** 면세 금액 */
	private int taxFreeAmount;
	
	/** 입점업체 시퀀스 */
	private Integer sellerSeq;
	
	/** 입점업체 아이디 */
	private String sellerId = "";
	
	/** 총판 시퀀스 */
	private Integer sellerMasterSeq;
	
	/** 입점업체명 */
	private String sellerName = "";
	
	/** 총판명 */
	private String sellerMasterName = "";

	/** 결제 완료일 */
	private String c10Date = "";
	
	/** 주문 확인일 */
	private String c20Date = "";
	
	/** 발송 완료일 */
	private String c30Date = "";
	
	/** 집하지 도착일 */
	private String c40Date = "";
	
	/** 배송 완료일 */
	private String c50Date = "";
	
	/** 구매 확정일 */
	private String c55Date = "";
	
	/** 교환 요청일 */
	private String c60Date = "";
	
	/** 교환 요청 접수일 */
	private String c61Date = "";
	
	/** 교환 완료일 */
	private String c69Date = "";
	
	/** 반품 요청일 */
	private String c70Date = "";
	
	/** 반품 요청 접수일 */
	private String c71Date = "";
	
	/** 반품 완료일 */
	private String c79Date = "";
	
	/** 취소 요청일 */
	private String c90Date = "";
	
	/** 취소 완료일 */
	private String c99Date = "";

	/** 변경일 */
	private String modDate = "";
	/** 등록일 */
	private String regDate = "";

	/** 사용 포인트 */
	private int point;

	/** 판매일보 관련 */
	/** 결제일 */
	private String payDate = "";
	
	/** 매출합계 */
	private long sumPrice;
	/** 매출합계 */
	private long orgSumPrice;
	/** 매출합계(투자 출연 기관) */
	private long investSumPrice;
	
	/** 총판 수수료 */
	private int masterCommission;
	/** 공급가 합계 */
	private int sumSupplyPrice;
	/** 영업이익 */
	private int profit;
	/** 판매일보 메뉴 - (일,월) - 2 */
	private String sellDailyName = "";
	/** 대분류 */
	private Integer lv1Seq;
	/** 중분류 */
	private Integer lv2Seq;
	/** 소분류 */
	private Integer lv3Seq;
	/** 세분류 */
	private Integer lv4Seq;
	/** 상품 대표이미지 */
	private String img1 = "";
	/** 랭킹 구매 금액 */
	private int totalOrderFinishPrice;
	/** 랭킹 닉네임 */
	private String nickName = "";

	/** 메인 현황 관련 추가 */
	/** 주문 건수 */
	private int orderCount;
	/** 일주일 매출 추이 */
	private int weekPeriodCount;
	/** 금일 매출 추이 */
	private String todayPeriodCount = "";

	/** 셀러 아이템 코드 (내부적으로만 쓰임) */
	private String sellerItemCode = "";

	/** 상품의 재고 수량 */
	private Integer stockCount;
	private Integer adminSeq;

	/** 취소/교환/반품 사유 */
	private String reason = "";

	/** 결제수단(주문페이지에서 넘어온 값) */
	private String payMethod = "";
	private String payMethodName = "";
	/** 몰이름 */
	private String mallName = "";
	/** 몰아이디 */
	private String mallId = "";
	/** 몰시퀀스 */
	private Integer mallSeq;
	
	/** 취소 유형(ALL:전체취소, PART:부분취소) */
	private String cancelType = "";
	/** 부분취소 여부 확인 */
	private int partCancelCnt;
	/** PG 거래번호 */
	private String tid = "";
	/** PG 상점아이디 */
	private String mid = "";
	/** PG 승인번호 */
	private String approvalNo = "";
	/** 인증데이타 */
	private String authData = "";
	/** PG 상점키 */
	private String pgKey = "";
	/** PG사 코드 */
	private String pgCode = "";

	/** cs 내용 */
	private String contents = "";

	/** 모델명 */
	private String modelName = "";
	/** 디바이스 타입(N:PC, M:모바일) */
	private String deviceType = "";
	/** 담당자명 */
	private String salesName = "";
	/** 담당자 전화번호 */
	private String salesTel = "";
	/** 담당자 휴대폰 번호 */
	private String salesCell = "";
	/** 담당자 이메일 */
	private String salesEmail = "";

	private String boardType = "";
		
	/** 비교 견적 */
	//비교견적 번호
	private Integer estimateCompareSeq;
	//신청 여부
	private String estimateCompareFlag = "";
	//처리 건수
	private int estimateCompareCnt;
	
	/** 견적 */
	//견적 번호
	private Integer estimateSeq;
	//견적 수량
	private int estimateCount;
		
	/** 무통장 입금 계좌 정보 */
	private String accountInfo = "";
	
	/** 후청구 결제 */
	//처리 여부
	private String npPayFlag = "";
	//처리 일자
	private String npPayDate = "";
	
	/** 투자 출연기관 여부 */
	private String investFlag = "";
	
	/** 사업자 번호 */
	private String bizNo = "";
	/** 인증 구분 */
	private String authCategory = "";
	
	/** 리스트 조회 용 */
	private String searchMember = "";
	private String searchOrder = "";
	private String searchSeller = "";
	private String searchDateType = "";
	
	private String deptName = "";
	private String posName = "";
	private String groupName = "";
	
	private List<CategoryVo> categoryList = null;
	private List<CommonVo> authCategoryList = null;
	
	/** 세금계산서 신청 */
	private String taxRequest = ""; // 세금계산서 요청 플래그 (Y=완료, N=요청중, A=전체)
	private String businessNum = ""; // 사업자 번호
	private String businessNum1 = "";
	private String businessNum2 = "";
	private String businessNum3 = "";
	private String businessCompany = ""; // 상호(법인명)
	private String businessName = ""; // 대표자
	private String businessAddr = ""; // 소재지
	private String businessCate = ""; // 업태
	private String businessItem = ""; // 종목
	private String requestEmail = ""; // 수신 이메일
	private String requestName = ""; // 수신자명
	private String requestCell = ""; // 수신자 전화번호
	private String requestCell1 = "";
	private String requestCell2 = "";
	private String requestCell3 = "";
	private String requestFlag = ""; // 상태 (Y=완료, N=요청중)
	private String requestDate = ""; // 수신요청 시각
	private String completeDate = ""; // 완료일
	
	// 입금완료일 (검색용)
	private String npPayDate1 = "";
	private String npPayDate2 = "";

	/** 이벤트 추가 */
	private String eventAdded;

	/** 무료 배송 여부 */
	private String freeDeli = "N";

	/** 규격 */
	private String type1 = "";
	private String type2 = "";
	private String type3 = "";

	/** 제조사 */
	private String maker = "";

	/** 보험코드 */

	private String insuranceCode = "";

	/** 단위 */
	private String originCountry = "";

	/** 상품원가 **/
	private int orgPrice;

	/** 주문상태에 따른 배경 색상 **/
	private String bgColor = "#ffffff";

	/** 배송 박스 카운트 **/
	private int boxCnt=0;
	/** 총배송료 **/
	private int totalDeliCost=0;



	public int getBoxCnt() {
		return boxCnt;
	}

	public void setBoxCnt(int boxCnt) {
		this.boxCnt = boxCnt;
	}

	public int getTotalDeliCost() {
		return totalDeliCost;
	}

	public void setTotalDeliCost(int totalDeliCost) {
		this.totalDeliCost = totalDeliCost;
	}



	public int getOrgPrice() {
		return orgPrice;
	}

	public void setOrgPrice(int orgPrice) {
		this.orgPrice = orgPrice;
	}


	public String getBgColor(){
		return this.bgColor;
	}

	public String getOriginCountry() {
		return originCountry;
	}

	public void setOriginCountry(String originCountry) {
		this.originCountry = originCountry;
	}


	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public void setInsuranceCode(String insurance){ this.insuranceCode = insurance;}

	public String getInsuranceCode(){return insuranceCode;}

	public void setType1(String type){ this.type1 = type;}

	public String getType1() { return type1;}

	public void setType2(String type){ this.type2 = type;}

	public String getType2() { return type2;}

	public void setType3(String type){ this.type3 = type;}

	public String getType3() { return type3;}

	public String getEventAdded() {
		return eventAdded;
	}

	public void setEventAdded(String eventAdded) {
		this.eventAdded = eventAdded;
	}
	public String getFreeDeli() {
		return freeDeli;
	}

	public void setFreeDeli(String freeDeli) {
		this.freeDeli = freeDeli;
	}

	public String getNpPayDate1() {
		return npPayDate1;
	}

	public void setNpPayDate1(String npPayDate1) {
		this.npPayDate1 = npPayDate1;
	}

	public String getNpPayDate2() {
		return npPayDate2;
	}

	public void setNpPayDate2(String npPayDate2) {
		this.npPayDate2 = npPayDate2;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getReceiverEmail() {
		return receiverEmail;
	}

	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getPayPrice() {
		return payPrice;
	}

	public void setPayPrice(int payPrice) {
		this.payPrice = payPrice;
	}

	public Integer getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(Integer memberSeq) {
		this.memberSeq = memberSeq;
	}
	
	

	public Integer getMemberGroupSeq() {
		return memberGroupSeq;
	}

	public void setMemberGroupSeq(Integer memberGroupSeq) {
		this.memberGroupSeq = memberGroupSeq;
	}

	
	public String getMemberTypeCode() {
		return memberTypeCode;
	}

	public void setMemberTypeCode(String memberTypeCode) {
		this.memberTypeCode = memberTypeCode;
	}

	public String getMemberTypeName() {
		return memberTypeName;
	}

	public void setMemberTypeName(String memberTypeName) {
		this.memberTypeName = memberTypeName;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
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

	public String getRequest() {
		return request;
	}

	public void setRequest(String request) {
		this.request = request;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getMemberEmail() {
		if(memberEmail != null) {
			memberEmail = memberEmail.trim();
		}
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
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

	public String getReceiverPostcode() {
		return receiverPostcode;
	}

	public void setReceiverPostcode(String receiverPostcode) {
		this.receiverPostcode = receiverPostcode;
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

	public String getReceiverAddr1() {
		return receiverAddr1;
	}

	public void setReceiverAddr1(String receiverAddr1) {
		this.receiverAddr1 = receiverAddr1;
	}

	public String getReceiverAddr2() {
		if(receiverAddr2 != null) {
			receiverAddr2 = receiverAddr2.trim();
		}
		return receiverAddr2;
	}

	public void setReceiverAddr2(String receiverAddr2) {
		this.receiverAddr2 = receiverAddr2;
	}

	
	public String getMemberCell1() {
		return memberCell1;
	}

	public void setMemberCell1(String memberCell1) {
		this.memberCell1 = memberCell1;
	}

	public String getMemberCell2() {
		return memberCell2;
	}

	public void setMemberCell2(String memberCell2) {
		this.memberCell2 = memberCell2;
	}

	public String getMemberCell3() {
		return memberCell3;
	}

	public void setMemberCell3(String memberCell3) {
		this.memberCell3 = memberCell3;
	}

	public String getReceiverTel() {
		return receiverTel;
	}

	public void setReceiverTel(String receiverTel) {
		this.receiverTel = receiverTel;
	}

	public String getReceiverTel1() {
		return receiverTel1;
	}

	public void setReceiverTel1(String receiverTel1) {
		this.receiverTel1 = receiverTel1;
	}

	public String getReceiverTel2() {
		return receiverTel2;
	}

	public void setReceiverTel2(String receiverTel2) {
		this.receiverTel2 = receiverTel2;
	}

	public String getReceiverTel3() {
		return receiverTel3;
	}

	public void setReceiverTel3(String receiverTel3) {
		this.receiverTel3 = receiverTel3;
	}

	public String getReceiverCell() {
		return receiverCell;
	}

	public void setReceiverCell(String receiverCell) {
		this.receiverCell = receiverCell;
	}

	public String getReceiverCell1() {
		return receiverCell1;
	}

	public void setReceiverCell1(String receiverCell1) {
		this.receiverCell1 = receiverCell1;
	}

	public String getReceiverCell2() {
		return receiverCell2;
	}

	public void setReceiverCell2(String receiverCell2) {
		this.receiverCell2 = receiverCell2;
	}

	public String getReceiverCell3() {
		return receiverCell3;
	}

	public void setReceiverCell3(String receiverCell3) {
		this.receiverCell3 = receiverCell3;
	}

	public String getCateLv1Name() {
		return cateLv1Name;
	}

	public void setCateLv1Name(String cateLv1Name) {
		this.cateLv1Name = cateLv1Name;
	}

	public String getCateLv2Name() {
		return cateLv2Name;
	}

	public void setCateLv2Name(String cateLv2Name) {
		this.cateLv2Name = cateLv2Name;
	}

	public String getCateLv3Name() {
		return cateLv3Name;
	}

	public void setCateLv3Name(String cateLv3Name) {
		this.cateLv3Name = cateLv3Name;
	}

	public String getCateLv4Name() {
		return cateLv4Name;
	}

	public void setCateLv4Name(String cateLv4Name) {
		this.cateLv4Name = cateLv4Name;
	}

	public String getMemberTel() {
		return memberTel;
	}

	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}

	public String getMemberCell() {
		return memberCell;
	}

	public void setMemberCell(String memberCell) {
		this.memberCell = memberCell;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(Integer orderSeq) {
		this.orderSeq = orderSeq;
	}

	public Integer getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}

	public Integer getOptionValueSeq() {
		return optionValueSeq;
	}

	public void setOptionValueSeq(Integer optionValueSeq) {
		this.optionValueSeq = optionValueSeq;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName;
	}

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
		/**
		 * 주문상태(00:입금대기, 10:결제완료, 20:주문확인, 30:배송중, 50:배송완료, 55:구매확정, 60:교환요청 , 61: 교환진행중, 69: 교환완료 ,
		 * 70: 반품요청, 71:반품진행 , 79:반품완료, 90:취소요청, 99:취소완료)
		 */

		switch (statusCode){
			case "00":
				this.bgColor="#ffcccc";
				break;
			case "10":
				this.bgColor="#ff9999";
				break;
			case "20":
				this.bgColor="#ffcc99";
				break;
			case "30":
			case "50":
				this.bgColor="#ffff99";
				break;
			case "55":
				this.bgColor="#e0e0e0";
				break;
			case "60":
			case "61":
			case "69":
				this.bgColor="#ccff99";
				break;
			case "70":
			case "71":
			case "79":
				this.bgColor="#99ffff";
				break;
			case "90":
			case "99":
				this.bgColor="#99ccff";
				break;


		}
	}

	public String getBeforeStatusCode() {
		return beforeStatusCode;
	}

	public void setBeforeStatusCode(String beforeStatusCode) {
		this.beforeStatusCode = beforeStatusCode;
	}

	public int getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}

	public int getOptionPrice() {
		return optionPrice;
	}

	public void setOptionPrice(int optionPrice) {
		this.optionPrice = optionPrice;
	}

	public int getSupplyPrice() {
		return supplyPrice;
	}

	public void setSupplyPrice(int supplyPrice) {
		this.supplyPrice = supplyPrice;
	}

	public int getSupplyMasterPrice() {
		return supplyMasterPrice;
	}

	public void setSupplyMasterPrice(int supplyMasterPrice) {
		this.supplyMasterPrice = supplyMasterPrice;
	}

	public int getCouponPrice() {
		return couponPrice;
	}

	public void setCouponPrice(int couponPrice) {
		this.couponPrice = couponPrice;
	}

	public int getOrderCnt() {
		return orderCnt;
	}

	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

	public int getSumSellPrice() {
		return sumSellPrice;
	}

	public void setSumSellPrice(int sumSellPrice) {
		this.sumSellPrice = sumSellPrice;
	}

	public int getSumOptionPrice() {
		return sumOptionPrice;
	}

	public void setSumOptionPrice(int sumOptionPrice) {
		this.sumOptionPrice = sumOptionPrice;
	}

	public int getDeliCost() {
		return deliCost;
	}

	public void setDeliCost(int deliCost) {
		this.deliCost = deliCost;
	}

	public String getDeliMsg() {
		return deliMsg;
	}

	public void setDeliMsg(String deliMsg) {
		this.deliMsg = deliMsg;
	}


	public String getCheckBD() {
		return checkBD;
	}

	public void setCheckBD(String checkBD) {
		this.checkBD = checkBD;
	}


	public String getDeliPackageFlag() {
		return deliPackageFlag;
	}

	public void setDeliPackageFlag(String deliPackageFlag) {
		this.deliPackageFlag = deliPackageFlag;
	}

	public String getDeliPrepaidFlag() {
		return deliPrepaidFlag;
	}

	public void setDeliPrepaidFlag(String deliPrepaidFlag) {
		this.deliPrepaidFlag = deliPrepaidFlag;
	}

	public int getPackageDeliCost() {
		return packageDeliCost;
	}

	public void setPackageDeliCost(int packageDeliCost) {
		this.packageDeliCost = packageDeliCost;
	}

	public Integer getDeliSeq() {
		return deliSeq;
	}

	public void setDeliSeq(Integer deliSeq) {
		this.deliSeq = deliSeq;
	}

	public String getDeliNo() {
		return deliNo;
	}

	public void setDeliNo(String deliNo) {
		this.deliNo = deliNo;
	}

	
	public String getDeliName() {
		return deliName;
	}

	public void setDeliName(String deliName) {
		this.deliName = deliName;
	}

	public String getSellerCode() {
		return sellerCode;
	}

	public void setSellerCode(String sellerCode) {
		this.sellerCode = sellerCode;
	}

	public String getTaxCode() {
		return taxCode;
	}

	public void setTaxCode(String taxCode) {
		this.taxCode = taxCode;
	}

	
	public String getTaxName() {
		return taxName;
	}

	public void setTaxName(String taxName) {
		this.taxName = taxName;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public Integer getSellerSeq() {
		return sellerSeq;
	}

	public void setSellerSeq(Integer sellerSeq) {
		this.sellerSeq = sellerSeq;
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public Integer getSellerMasterSeq() {
		return sellerMasterSeq;
	}

	public void setSellerMasterSeq(Integer sellerMasterSeq) {
		this.sellerMasterSeq = sellerMasterSeq;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getSellerMasterName() {
		return sellerMasterName;
	}

	public void setSellerMasterName(String sellerMasterName) {
		this.sellerMasterName = sellerMasterName;
	}

	public String getC10Date() {
		return c10Date;
	}

	public void setC10Date(String c10Date) {
		this.c10Date = c10Date;
	}

	public String getC20Date() {
		return c20Date;
	}

	public void setC20Date(String c20Date) {
		this.c20Date = c20Date;
	}

	public String getC30Date() {
		return c30Date;
	}

	public void setC30Date(String c30Date) {
		this.c30Date = c30Date;
	}

	public String getC40Date() {
		return c40Date;
	}

	public void setC40Date(String c40Date) {
		this.c40Date = c40Date;
	}

	public String getC50Date() {
		return c50Date;
	}

	public void setC50Date(String c50Date) {
		this.c50Date = c50Date;
	}

	public String getC55Date() {
		return c55Date;
	}

	public void setC55Date(String c55Date) {
		this.c55Date = c55Date;
	}

	public String getC60Date() {
		return c60Date;
	}

	public void setC60Date(String c60Date) {
		this.c60Date = c60Date;
	}

	public String getC61Date() {
		return c61Date;
	}

	public void setC61Date(String c61Date) {
		this.c61Date = c61Date;
	}

	public String getC69Date() {
		return c69Date;
	}

	public void setC69Date(String c69Date) {
		this.c69Date = c69Date;
	}

	public String getC70Date() {
		return c70Date;
	}

	public void setC70Date(String c70Date) {
		this.c70Date = c70Date;
	}

	public String getC71Date() {
		return c71Date;
	}

	public void setC71Date(String c71Date) {
		this.c71Date = c71Date;
	}

	public String getC79Date() {
		return c79Date;
	}

	public void setC79Date(String c79Date) {
		this.c79Date = c79Date;
	}

	public String getC90Date() {
		return c90Date;
	}

	public void setC90Date(String c90Date) {
		this.c90Date = c90Date;
	}

	public String getC99Date() {
		return c99Date;
	}

	public void setC99Date(String c99Date) {
		this.c99Date = c99Date;
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

	public String getStatusText() {
		return statusText;
	}

	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}

	public String getDeliCompanyName() {
		return deliCompanyName;
	}

	public void setDeliCompanyName(String deliCompanyName) {
		this.deliCompanyName = deliCompanyName;
	}

	public String getDeliTrackUrl() {
		return deliTrackUrl;
	}

	public void setDeliTrackUrl(String deliTrackUrl) {
		this.deliTrackUrl = deliTrackUrl;
	}

	public String getCompleteMsg() {
		return completeMsg;
	}

	public void setCompleteMsg(String completeMsg) {
		this.completeMsg = completeMsg;
	}

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}

	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	public long getSumPrice() {
		return sumPrice;
	}

	public void setSumPrice(long sumPrice) {
		this.sumPrice = sumPrice;
	}

	public long getOrgSumPrice() {
		return orgSumPrice;
	}

	public void setOrgSumPrice(long orgSumPrice) {
		this.orgSumPrice = orgSumPrice;
	}
	
	public long getInvestSumPrice() {
		return investSumPrice;
	}

	public void setInvestSumPrice(long investSumPrice) {
		this.investSumPrice = investSumPrice;
	}

	public int getMasterCommission() {
		return masterCommission;
	}

	public void setMasterCommission(int masterCommission) {
		this.masterCommission = masterCommission;
	}

	public int getSumSupplyPrice() {
		return sumSupplyPrice;
	}

	public void setSumSupplyPrice(int sumSupplyPrice) {
		this.sumSupplyPrice = sumSupplyPrice;
	}

	public int getProfit() {
		return profit;
	}

	public void setProfit(int profit) {
		this.profit = profit;
	}

	public String getSellDailyName() {
		return sellDailyName;
	}

	public void setSellDailyName(String sellDailyName) {
		this.sellDailyName = sellDailyName;
	}

	public Integer getLv1Seq() {
		return lv1Seq;
	}

	public void setLv1Seq(Integer lv1Seq) {
		this.lv1Seq = lv1Seq;
	}

	public Integer getLv2Seq() {
		return lv2Seq;
	}

	public void setLv2Seq(Integer lv2Seq) {
		this.lv2Seq = lv2Seq;
	}

	public Integer getLv3Seq() {
		return lv3Seq;
	}

	public void setLv3Seq(Integer lv3Seq) {
		this.lv3Seq = lv3Seq;
	}

	
	public Integer getLv4Seq() {
		return lv4Seq;
	}

	public void setLv4Seq(Integer lv4Seq) {
		this.lv4Seq = lv4Seq;
	}

	public int getTotalOrderFinishPrice() {
		return totalOrderFinishPrice;
	}

	public void setTotalOrderFinishPrice(int totalOrderFinishPrice) {
		this.totalOrderFinishPrice = totalOrderFinishPrice;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getWeekPeriodCount() {
		return weekPeriodCount;
	}

	public void setWeekPeriodCount(int weekPeriodCount) {
		this.weekPeriodCount = weekPeriodCount;
	}

	public String getTodayPeriodCount() {
		return todayPeriodCount;
	}

	public void setTodayPeriodCount(String todayPeriodCount) {
		this.todayPeriodCount = todayPeriodCount;
	}

	public String getSellerItemCode() {
		return sellerItemCode;
	}

	public void setSellerItemCode(String sellerItemCode) {
		this.sellerItemCode = sellerItemCode;
	}

	public Integer getStockCount() {
		return stockCount;
	}

	public void setStockCount(Integer stockCount) {
		this.stockCount = stockCount;
	}

	public Integer getAdminSeq() {
		return adminSeq;
	}

	public void setAdminSeq(Integer adminSeq) {
		this.adminSeq = adminSeq;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getPayMethodName() {
		return payMethodName;
	}

	public void setPayMethodName(String payMethodName) {
		this.payMethodName = payMethodName;
	}

	public String getMallName() {
		return mallName;
	}

	public void setMallName(String mallName) {
		this.mallName = mallName;
	}

	public String getMallId() {
		return mallId;
	}

	public void setMallId(String mallId) {
		this.mallId = mallId;
	}

	public String getCancelType() {
		return cancelType;
	}

	public void setCancelType(String cancelType) {
		this.cancelType = cancelType;
	}

	public Integer getMallSeq() {
		return mallSeq;
	}

	public void setMallSeq(Integer mallSeq) {
		this.mallSeq = mallSeq;
	}

	public int getPartCancelCnt() {
		return partCancelCnt;
	}

	public void setPartCancelCnt(int partCancelCnt) {
		this.partCancelCnt = partCancelCnt;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getApprovalNo() {
		return approvalNo;
	}

	public void setApprovalNo(String approvalNo) {
		this.approvalNo = approvalNo;
	}

	public String getAuthData() {
		return authData;
	}

	public void setAuthData(String authData) {
		this.authData = authData;
	}

	public String getPgKey() {
		return pgKey;
	}

	public void setPgKey(String pgKey) {
		this.pgKey = pgKey;
	}

	public String getPgCode() {
		return pgCode;
	}

	public void setPgCode(String pgCode) {
		this.pgCode = pgCode;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getModelName() {
		return modelName;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
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

	public String getSalesCell() {
		return salesCell;
	}

	public void setSalesCell(String salesCell) {
		this.salesCell = salesCell;
	}

	public String getSalesEmail() {
		return salesEmail;
	}

	public void setSalesEmail(String salesEmail) {
		this.salesEmail = salesEmail;
	}

	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}

	public Integer getEstimateCompareSeq() {
		return estimateCompareSeq;
	}

	public void setEstimateCompareSeq(Integer estimateCompareSeq) {
		this.estimateCompareSeq = estimateCompareSeq;
	}

	public String getEstimateCompareFlag() {
		return estimateCompareFlag;
	}

	public void setEstimateCompareFlag(String estimateCompareFlag) {
		this.estimateCompareFlag = estimateCompareFlag;
	}
		
	public int getEstimateCompareCnt() {
		return estimateCompareCnt;
	}

	public void setEstimateCompareCnt(int estimateCompareCnt) {
		this.estimateCompareCnt = estimateCompareCnt;
	}

	public Integer getEstimateSeq() {
		return estimateSeq;
	}

	public void setEstimateSeq(Integer estimateSeq) {
		this.estimateSeq = estimateSeq;
	}

	public int getEstimateCount() {
		return estimateCount;
	}

	public void setEstimateCount(int estimateCount) {
		this.estimateCount = estimateCount;
	}

	public String getAccountInfo() {
		return accountInfo;
	}
	public void setAccountInfo(String accountInfo) {
		this.accountInfo = accountInfo;
	}

	public String getNpPayFlag() {
		return npPayFlag;
	}

	public void setNpPayFlag(String npPayFlag) {
		this.npPayFlag = npPayFlag;
	}

	public String getNpPayDate() {
		return npPayDate;
	}

	public void setNpPayDate(String npPayDate) {
		this.npPayDate = npPayDate;
	}

	public String getInvestFlag() {
		return investFlag;
	}

	public void setInvestFlag(String investFlag) {
		this.investFlag = investFlag;
	}

	public String getBizNo() {
		return bizNo;
	}

	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}


	public String getAuthCategory() {
		return authCategory;
	}

	public void setAuthCategory(String authCategory) {
		this.authCategory = authCategory;
	}

	public String getSearchMember() {
		return searchMember;
	}

	public void setSearchMember(String searchMember) {
		this.searchMember = searchMember;
	}

	
	public String getSearchOrder() {
		return searchOrder;
	}

	public void setSearchOrder(String searchOrder) {
		this.searchOrder = searchOrder;
	}

	public String getSearchSeller() {
		return searchSeller;
	}

	public void setSearchSeller(String searchSeller) {
		this.searchSeller = searchSeller;
	}

	
	public String getSearchDateType() {
		return searchDateType;
	}

	public void setSearchDateType(String searchDateType) {
		this.searchDateType = searchDateType;
	}

	@Override
	public String getSearch() {
		return super.search;
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

	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public List<CategoryVo> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<CategoryVo> categoryList) {
		this.categoryList = categoryList;
	}
	
	public List<CommonVo> getAuthCategoryList() {
		return authCategoryList;
	}

	public void setAuthCategoryList(List<CommonVo> authCategoryList) {
		this.authCategoryList = authCategoryList;
	}

	public String getTaxRequest() {
		return taxRequest;
	}

	public void setTaxRequest(String taxRequest) {
		this.taxRequest = taxRequest;
	}

	public String getBusinessNum() {
		return businessNum;
	}

	public void setBusinessNum(String businessNum) {
		this.businessNum = businessNum;
	}

	public String getBusinessNum1() {
		return businessNum1;
	}

	public void setBusinessNum1(String businessNum1) {
		this.businessNum1 = businessNum1;
	}

	public String getBusinessNum2() {
		return businessNum2;
	}

	public void setBusinessNum2(String businessNum2) {
		this.businessNum2 = businessNum2;
	}

	public String getBusinessNum3() {
		return businessNum3;
	}

	public void setBusinessNum3(String businessNum3) {
		this.businessNum3 = businessNum3;
	}

	public String getBusinessCompany() {
		return businessCompany;
	}

	public void setBusinessCompany(String businessCompany) {
		this.businessCompany = businessCompany;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getBusinessAddr() {
		return businessAddr;
	}

	public void setBusinessAddr(String businessAddr) {
		this.businessAddr = businessAddr;
	}

	public String getBusinessCate() {
		return businessCate;
	}

	public void setBusinessCate(String businessCate) {
		this.businessCate = businessCate;
	}

	public String getBusinessItem() {
		return businessItem;
	}

	public void setBusinessItem(String businessItem) {
		this.businessItem = businessItem;
	}

	public String getRequestEmail() {
		return requestEmail;
	}

	public void setRequestEmail(String requestEmail) {
		this.requestEmail = requestEmail;
	}

	public String getRequestName() {
		return requestName;
	}

	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}

	public String getRequestCell() {
		return requestCell;
	}

	public void setRequestCell(String requestCell) {
		this.requestCell = requestCell;
	}

	public String getRequestCell1() {
		return requestCell1;
	}

	public void setRequestCell1(String requestCell1) {
		this.requestCell1 = requestCell1;
	}

	public String getRequestCell2() {
		return requestCell2;
	}

	public void setRequestCell2(String requestCell2) {
		this.requestCell2 = requestCell2;
	}

	public String getRequestCell3() {
		return requestCell3;
	}

	public void setRequestCell3(String requestCell3) {
		this.requestCell3 = requestCell3;
	}

	public String getRequestFlag() {
		return requestFlag;
	}

	public void setRequestFlag(String requestFlag) {
		this.requestFlag = requestFlag;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}
}
