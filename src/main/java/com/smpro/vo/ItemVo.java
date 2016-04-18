package com.smpro.vo;

import java.util.List;

public class ItemVo extends PagingVo {
	private int rankNumber;

	private Integer seq;
	/** 상품명 */
	private String name = "";
	/** 상점명 */
	private String nickname = "";
	/** 상태코드 (Y=판매중, N=판매중지, H=가승인, E=엑셀 대량등록) */
	private String statusCode = "";
	/** 상태명 */
	private String statusName = "";
	/** 판매가 */
	private int sellPrice;
	private int tempSellPrice;
	
	/** 총판공급가 */
	private int supplyMasterPrice;
	/** 입점업체공급가 */
	private int supplyPrice;
	/** 담당자 연락처 */
	private String salesTel = "";
	/** 시중가 */
	private int marketPrice;
	/** 제조사 */
	private String maker = "";
	/** 원산지 */
	private String originCountry = "";
	/** 셀러 시퀀스 */
	private Integer sellerSeq;
	/** 셀러 아이디 */
	private String sellerId = "";
	/** 셀러 아이템 코드 (내부적으로만 쓰임) */
	private String sellerItemCode = "";
	/** 대분류 시퀀스 */
	private Integer cateLv1Seq;
	/** 중분류 시퀀스 */
	private Integer cateLv2Seq;
	/** 소분류 시퀀스 */
	private Integer cateLv3Seq;
	/** 세분류 시퀀스 */
	private Integer cateLv4Seq;
	/** 브랜드 */
	private String brand = "";
	/** 모델명 */
	private String modelName = "";
	/** 제조일자 (예:20140815) */
	private String makeDate = "";
	/** 유효일자 (예:20140815) */
	private String expireDate = "";
	/** 성인 여부 (Y=성인만이용가능, N=모두이용가능) */
	private String adultFlag = "";
	/** 상품이미지 */
	private String img1 = "";
	/** 상품이미지 */
	private String img2 = "";
	/** 상품이미지 */
	private String img3 = "";
	/** 상품이미지 */
	private String img4 = "";
	/** 과세여부 (1=과세, 2=면세) */
	private String taxCode = "";
	private String taxName = "";
	/** 수정일 */
	private String modDate = "";
	/** 등록일 */
	private String regDate = "";
	/** 최소 구매수량 */
	private int minCnt;
	/** 최대 구매수량 */
	private int maxCnt;
	/** 카테고리 노출여부 */
	private String showFlag = "";
	// ------- DETAIL ---------
	/** 상품 시퀀스 */
	private Integer itemSeq;
	/** 내용 */
	private String content = "";
	/** A/S 가능여부 */
	private String asFlag = "";
	/** A/S 전화번호 */
	private String asTel = "";
	private String asTel1 = "";
	private String asTel2 = "";
	private String asTel3 = "";
	/** A/S 내용 */
	private String asContent = "";
	/** 상세이미지1 */
	private String detailImg1 = "";
	/** 상세이미지2 */
	private String detailImg2 = "";
	/** 상세이미지3 */
	private String detailImg3 = "";
	/** 상세이미지1 alt 값 */
	private String detailAlt1 = "";
	/** 상세이미지2 alt 값 */
	private String detailAlt2 = "";
	/** 상세이미지3 alt 값 */
	private String detailAlt3 = "";
	/** 사용 코드 (C=컨텐츠, I=이미지) */
	private String useCode = "";

	/** 사용자 시퀀스 */
	private Integer memberSeq;
	/** 위시 시퀀스 */
	private int wishSeq;

	// ------- 장바구니 ---------
	/** 옵션 시퀀스 */
	private Integer optionSeq;
	/** 옵션 밸류 시퀀스 */
	private Integer optionValueSeq;
	/** 옵션 이름 */
	private String optionName = "";
	/** 옵션 밸류 이름 */
	private String valueName = "";
	private String optionValues = "";
	/** 옵션 가격 */
	private int optionPrice;
	private String optionPrices = "";
	/** 수량 */
	private int count;
	/** 견적 수량 */
	private int estimateCount;
	/** 옵션 개수 */
	private Integer optionCount;
	/** 즉시구매로 이동한 것인지? (Y=즉시구매, N=장바구니) */
	private String directFlag = "";
	/** 옵션 재고 수량 */
	private int stockCount;
	private String stockCounts = "";
	/** 옵션 재고 관리 여부 */
	private String stockFlag = "";

	// ------- 상품 리뷰 ---------
	/** 상품/배송 총 평점 */
	private int reviewGrade;
	/** 상품평 갯수 */
	private int reviewCount;
	/** 상품 평점 */
	private int itemGrade;
	/** 배송 평점 */
	private int deliveryGrade;

	// ------- 추가 필드 ---------
	/** 셀러명 */
	private String sellerName = "";
	/** 자치구 코드 */
	private String jachiguCode = "";
	/** 총판 시퀀스 */
	private Integer masterSeq;
	/** 총판명 */
	private String masterName = "";
	/** 대분류 카테고리명 */
	private String cateLv1Name = "";
	/** 중분류 카테고리명 */
	private String cateLv2Name = "";
	/** 소분류 카테고리명 */
	private String cateLv3Name = "";
	/** 세분류 카테고리명 */
	private String cateLv4Name = "";
	/** 품절여부 */
	private String soldOutFlag = "";
	/** 옵션 리스트 */
	private List<ItemOptionVo> optionList;
	/** 상품복사 인지 아닌지 판단 */
	private String updateType = "";
	/** 카트 시퀀스 배열로 넘어올 경우 받는 변수 **/
	private String cartSeqs = "";
	/** 장바구니 비회원 키값 */
	private String notLoginKey = "";
	
	/** 가격대별 검색 */
	private int startPrice;
	private int endPrice;

	// ------- 배송 관련 필드 ---------
	/** 배송 구분 */
	private String deliTypeCode = "";
	/** 배송비 */
	private int deliCost;
	/** 무료배송 조건금액 */
	private int deliFreeAmount;
	/** 선결제 여부 */
	private String deliPrepaidFlag = "";
	/** 묶음배송 가능 여부 */
	private String deliPackageFlag = "";
	/** 묶음배송비 */
	private int packageDeliCost;
	/** 상품타입(N:일반상품, C:쿠폰상품, E:견적상품) */
	private String typeCode = "";
	private String typeName = "";
	// -- 반품관련 정보 --
	private String returnName = "";
	private String returnCell = "";

	/** 변경내역 */
	private String modContent = "";
	private String column = "";

	/** 상품 정보 고시 분류코드 */
	private Integer typeCd;
	private String typeNm = "";

	/** 리스트 조회 용 **/
	private String itemSearchType = "";
	private String itemSearchValue = "";
	private String sellerSearchType = "";
	private String sellerSearchValue = "";
	private String orderType = ""; // 정렬순서 (regdate, highprice, lowprice)
	/** 인증구분 */
	private String authCategory = "";
	private String[] authCategoryArr;
	
	/** 함께누리몰 기존 입점업체 시퀀스 */
	private Integer oldSellerSeq;
	
	/** 회원 유형 코드 */
	private String memberTypeCode = "";
	
	@Override
	public String getSearch() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getSoldOutFlag() {
		return soldOutFlag;
	}

	public void setSoldOutFlag(String soldOutFlag) {
		this.soldOutFlag = soldOutFlag;
	}

	public int getStockCount() {
		return stockCount;
	}

	public void setStockCount(int stockCount) {
		this.stockCount = stockCount;
	}

	public String getStockCounts() {
		return stockCounts;
	}

	public void setStockCounts(String stockCounts) {
		this.stockCounts = stockCounts;
	}

	public String getStockFlag() {
		return stockFlag;
	}

	public void setStockFlag(String stockFlag) {
		this.stockFlag = stockFlag;
	}

	public Integer getMasterSeq() {
		return masterSeq;
	}

	public void setMasterSeq(Integer masterSeq) {
		this.masterSeq = masterSeq;
	}

	public String getDirectFlag() {
		return directFlag;
	}

	public void setDirectFlag(String directFlag) {
		this.directFlag = directFlag;
	}

	public Integer getOptionCount() {
		return optionCount;
	}

	public void setOptionCount(Integer optionCount) {
		this.optionCount = optionCount;
	}

	public int getOptionPrice() {
		return optionPrice;
	}

	public void setOptionPrice(int optionPrice) {
		this.optionPrice = optionPrice;
	}

	public String getOptionPrices() {
		return optionPrices;
	}

	public void setOptionPrices(String optionPrices) {
		this.optionPrices = optionPrices;
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

	public String getOptionValues() {
		return optionValues;
	}

	public void setOptionValues(String optionValues) {
		this.optionValues = optionValues;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
	public int getEstimateCount() {
		return estimateCount;
	}

	public void setEstimateCount(int estimateCount) {
		this.estimateCount = estimateCount;
	}

	public Integer getOptionSeq() {
		return optionSeq;
	}

	public void setOptionSeq(Integer optionSeq) {
		this.optionSeq = optionSeq;
	}

	public Integer getOptionValueSeq() {
		return optionValueSeq;
	}

	public void setOptionValueSeq(Integer optionValueSeq) {
		this.optionValueSeq = optionValueSeq;
	}

	public Integer getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(Integer memberSeq) {
		this.memberSeq = memberSeq;
	}

	public int getWishSeq() {
		return wishSeq;
	}

	public void setWishSeq(int wishSeq) {
		this.wishSeq = wishSeq;
	}

	public int getItemGrade() {
		return itemGrade;
	}

	public void setItemGrade(int itemGrade) {
		this.itemGrade = itemGrade;
	}

	public int getDeliveryGrade() {
		return deliveryGrade;
	}

	public void setDeliveryGrade(int deliveryGrade) {
		this.deliveryGrade = deliveryGrade;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getReviewGrade() {
		return reviewGrade;
	}

	public void setReviewGrade(int reviewGrade) {
		this.reviewGrade = reviewGrade;
	}

	public int getRankNumber() {
		return rankNumber;
	}

	public void setRankNumber(int rankNumber) {
		this.rankNumber = rankNumber;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
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

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public int getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}

	public int getTempSellPrice() {
		return tempSellPrice;
	}

	public void setTempSellPrice(int tempSellPrice) {
		this.tempSellPrice = tempSellPrice;
	}
	
	public int getSupplyMasterPrice() {
		return supplyMasterPrice;
	}

	public void setSupplyMasterPrice(int supplyMasterPrice) {
		this.supplyMasterPrice = supplyMasterPrice;
	}

	public int getSupplyPrice() {
		return supplyPrice;
	}

	public void setSupplyPrice(int supplyPrice) {
		this.supplyPrice = supplyPrice;
	}

	public String getSalesTel() {
		return salesTel;
	}

	public void setSalesTel(String salesTel) {
		this.salesTel = salesTel;
	}

	public int getMarketPrice() {
		return marketPrice;
	}

	public void setMarketPrice(int marketPrice) {
		this.marketPrice = marketPrice;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getOriginCountry() {
		return originCountry;
	}

	public void setOriginCountry(String originCountry) {
		this.originCountry = originCountry;
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

	public String getSellerItemCode() {
		return sellerItemCode;
	}

	public void setSellerItemCode(String sellerItemCode) {
		this.sellerItemCode = sellerItemCode;
	}

	public Integer getCateLv1Seq() {
		return cateLv1Seq;
	}

	public void setCateLv1Seq(Integer cateLv1Seq) {
		this.cateLv1Seq = cateLv1Seq;
	}

	public Integer getCateLv2Seq() {
		return cateLv2Seq;
	}

	public void setCateLv2Seq(Integer cateLv2Seq) {
		this.cateLv2Seq = cateLv2Seq;
	}

	public Integer getCateLv3Seq() {
		return cateLv3Seq;
	}

	public void setCateLv3Seq(Integer cateLv3Seq) {
		this.cateLv3Seq = cateLv3Seq;
	}

	public Integer getCateLv4Seq() {
		return cateLv4Seq;
	}

	public void setCateLv4Seq(Integer cateLv4Seq) {
		this.cateLv4Seq = cateLv4Seq;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getModelName() {
		return modelName;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	public String getMakeDate() {
		return makeDate;
	}

	public void setMakeDate(String makeDate) {
		this.makeDate = makeDate;
	}

	public String getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}

	public String getAdultFlag() {
		return adultFlag;
	}

	public void setAdultFlag(String adultFlag) {
		this.adultFlag = adultFlag;
	}

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}

	public String getImg2() {
		return img2;
	}

	public void setImg2(String img2) {
		this.img2 = img2;
	}

	public String getImg3() {
		return img3;
	}

	public void setImg3(String img3) {
		this.img3 = img3;
	}

	public String getImg4() {
		return img4;
	}

	public void setImg4(String img4) {
		this.img4 = img4;
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

	public int getMinCnt() {
		return minCnt;
	}

	public void setMinCnt(int minCnt) {
		this.minCnt = minCnt;
	}

	public int getMaxCnt() {
		return maxCnt;
	}

	public void setMaxCnt(int maxCnt) {
		this.maxCnt = maxCnt;
	}

	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
	}

	public Integer getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAsFlag() {
		return asFlag;
	}

	public void setAsFlag(String asFlag) {
		this.asFlag = asFlag;
	}

	public String getAsTel() {
		return asTel;
	}

	public void setAsTel(String asTel) {
		this.asTel = asTel;
	}

	public String getAsTel1() {
		return asTel1;
	}

	public void setAsTel1(String asTel1) {
		this.asTel1 = asTel1;
	}

	public String getAsTel2() {
		return asTel2;
	}

	public void setAsTel2(String asTel2) {
		this.asTel2 = asTel2;
	}

	public String getAsTel3() {
		return asTel3;
	}

	public void setAsTel3(String asTel3) {
		this.asTel3 = asTel3;
	}

	public String getAsContent() {
		return asContent;
	}

	/**
	 * HTML 코드가 들어갈 수 있기 때문에 여기에 clearXSS와 같은 처리를 하지 않았다 반드시 SLASH(')를 처리하는 로직이
	 * 포함되어야 한다
	 * 
	 * @param asContent
	 */
	public void setAsContent(String asContent) {
		this.asContent = asContent;
	}

	public String getDetailImg1() {
		return detailImg1;
	}

	public void setDetailImg1(String detailImg1) {
		this.detailImg1 = detailImg1;
	}

	public String getDetailImg2() {
		return detailImg2;
	}

	public void setDetailImg2(String detailImg2) {
		this.detailImg2 = detailImg2;
	}

	public String getDetailImg3() {
		return detailImg3;
	}

	public void setDetailImg3(String detailImg3) {
		this.detailImg3 = detailImg3;
	}
	
	public String getDetailAlt1() {
		return detailAlt1;
	}

	public void setDetailAlt1(String detailAlt1) {
		this.detailAlt1 = detailAlt1;
	}

	public String getDetailAlt2() {
		return detailAlt2;
	}

	public void setDetailAlt2(String detailAlt2) {
		this.detailAlt2 = detailAlt2;
	}

	public String getDetailAlt3() {
		return detailAlt3;
	}

	public void setDetailAlt3(String detailAlt3) {
		this.detailAlt3 = detailAlt3;
	}

	public String getUseCode() {
		return useCode;
	}

	public void setUseCode(String useCode) {
		this.useCode = useCode;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	
	public String getJachiguCode() {
		return jachiguCode;
	}

	public void setJachiguCode(String jachiguCode) {
		this.jachiguCode = jachiguCode;
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

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public List<ItemOptionVo> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<ItemOptionVo> optionList) {
		this.optionList = optionList;
	}

	public String getUpdateType() {
		return updateType;
	}

	public void setUpdateType(String updateType) {
		this.updateType = updateType;
	}

	public String getDeliTypeCode() {
		return deliTypeCode;
	}

	public void setDeliTypeCode(String deliTypeCode) {
		this.deliTypeCode = deliTypeCode;
	}

	public int getDeliCost() {
		return deliCost;
	}

	public void setDeliCost(int deliCost) {
		this.deliCost = deliCost;
	}

	public int getDeliFreeAmount() {
		return deliFreeAmount;
	}

	public void setDeliFreeAmount(int deliFreeAmount) {
		this.deliFreeAmount = deliFreeAmount;
	}

	public String getDeliPrepaidFlag() {
		return deliPrepaidFlag;
	}

	public void setDeliPrepaidFlag(String deliPrepaidFlag) {
		this.deliPrepaidFlag = deliPrepaidFlag;
	}

	public String getDeliPackageFlag() {
		return deliPackageFlag;
	}

	public void setDeliPackageFlag(String deliPackageFlag) {
		this.deliPackageFlag = deliPackageFlag;
	}

	public int getPackageDeliCost() {
		return packageDeliCost;
	}

	public void setPackageDeliCost(int packageDeliCost) {
		this.packageDeliCost = packageDeliCost;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getCartSeqs() {
		return cartSeqs;
	}

	public void setCartSeqs(String cartSeqs) {
		this.cartSeqs = cartSeqs;
	}
	
	
	public String getNotLoginKey() {
		return notLoginKey;
	}

	public void setNotLoginKey(String notLoginKey) {
		this.notLoginKey = notLoginKey;
	}

	public int getStartPrice() {
		return startPrice;
	}

	public void setStartPrice(int startPrice) {
		this.startPrice = startPrice;
	}

	public int getEndPrice() {
		return endPrice;
	}

	public void setEndPrice(int endPrice) {
		this.endPrice = endPrice;
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

	public String getModContent() {
		return modContent;
	}

	public void setModContent(String modContent) {
		this.modContent = modContent;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public Integer getTypeCd() {
		return typeCd;
	}

	public void setTypeCd(Integer typeCd) {
		this.typeCd = typeCd;
	}

	public String getTypeNm() {
		return typeNm;
	}

	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}

	public String getItemSearchType() {
		return itemSearchType;
	}

	public void setItemSearchType(String itemSearchType) {
		this.itemSearchType = itemSearchType;
	}

	public String getItemSearchValue() {
		return itemSearchValue;
	}

	public void setItemSearchValue(String itemSearchValue) {
		this.itemSearchValue = itemSearchValue;
	}

	public String getSellerSearchType() {
		return sellerSearchType;
	}

	public void setSellerSearchType(String sellerSearchType) {
		this.sellerSearchType = sellerSearchType;
	}

	public String getSellerSearchValue() {
		return sellerSearchValue;
	}

	public void setSellerSearchValue(String sellerSearchValue) {
		this.sellerSearchValue = sellerSearchValue;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getAuthCategory() {
		return authCategory;
	}

	public void setAuthCategory(String authCategory) {
		this.authCategory = authCategory;
	}
	
	public String[] getAuthCategoryArr() {
		return authCategoryArr;
	}

	public void setAuthCategoryArr(String[] authCategoryArr) {
		this.authCategoryArr = authCategoryArr;
	}

	public Integer getOldSellerSeq() {
		return oldSellerSeq;
	}

	public void setOldSellerSeq(Integer oldSellerSeq) {
		this.oldSellerSeq = oldSellerSeq;
	}
	
	public String getMemberTypeCode() {
		return memberTypeCode;
	}

	public void setMemberTypeCode(String memberTypeCode) {
		this.memberTypeCode = memberTypeCode;
	}

	@Override
	public String toString() {
		return "ItemVo [rankNumber=" + rankNumber + ", seq=" + seq + ", name="
				+ name + ", nickname=" + nickname + ", statusCode="
				+ statusCode + ", statusName=" + statusName + ", sellPrice="
				+ sellPrice + ", tempSellPrice=" + tempSellPrice
				+ ", supplyMasterPrice=" + supplyMasterPrice + ", supplyPrice=" + supplyPrice
				+ ", salesTel=" + salesTel + ", marketPrice=" + marketPrice
				+ ", maker=" + maker + ", originCountry=" + originCountry
				+ ", sellerSeq=" + sellerSeq + ", sellerId=" + sellerId
				+ ", sellerItemCode=" + sellerItemCode + ", cateLv1Seq="
				+ cateLv1Seq + ", cateLv2Seq=" + cateLv2Seq + ", cateLv3Seq="
				+ cateLv3Seq + ", cateLv4Seq=" + cateLv4Seq + ", brand="
				+ brand + ", modelName=" + modelName + ", makeDate=" + makeDate
				+ ", expireDate=" + expireDate + ", adultFlag=" + adultFlag
				+ ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3
				+ ", img4=" + img4 + ", taxCode=" + taxCode + ", modDate="
				+ modDate + ", regDate=" + regDate + ", minCnt=" + minCnt
				+ ", maxCnt=" + maxCnt + ", showFlag=" + showFlag
				+ ", itemSeq=" + itemSeq + ", content=" + content + ", asFlag="
				+ asFlag + ", asTel=" + asTel + ", asTel1=" + asTel1
				+ ", asTel2=" + asTel2 + ", asTel3=" + asTel3 + ", asContent="
				+ asContent + ", detailImg1=" + detailImg1 + ", detailImg2="
				+ detailImg2 + ", detailImg3=" + detailImg3 + ", detailAlt1="
				+ detailAlt1 + ", detailAlt2=" + detailAlt2 + ", detailAlt3="
				+ detailAlt3 + ", useCode=" + useCode + ", memberSeq="
				+ memberSeq + ", wishSeq=" + wishSeq + ", optionSeq="
				+ optionSeq + ", optionValueSeq=" + optionValueSeq
				+ ", optionName=" + optionName + ", valueName=" + valueName
				+ ", optionValues=" + optionValues + ", optionPrice="
				+ optionPrice + ", optionPrices=" + optionPrices + ", count="
				+ count + ", optionCount=" + optionCount + ", directFlag="
				+ directFlag + ", stockCount=" + stockCount + ", stockCounts="
				+ stockCounts + ", reviewGrade=" + reviewGrade
				+ ", reviewCount=" + reviewCount + ", itemGrade=" + itemGrade
				+ ", deliveryGrade=" + deliveryGrade + ", sellerName="
				+ sellerName + ", jachiguCode=" + jachiguCode + ", masterSeq="
				+ masterSeq + ", masterName=" + masterName + ", cateLv1Name="
				+ cateLv1Name + ", cateLv2Name=" + cateLv2Name
				+ ", cateLv3Name=" + cateLv3Name + ", cateLv4Name="
				+ cateLv4Name + ", soldOutFlag=" + soldOutFlag
				+ ", optionList=" + optionList + ", updateType=" + updateType
				+ ", cartSeqs=" + cartSeqs + ", notLoginKey=" + notLoginKey
				+ ", startPrice=" + startPrice + ", endPrice=" + endPrice
				+ ", deliTypeCode=" + deliTypeCode + ", deliCost=" + deliCost
				+ ", deliFreeAmount=" + deliFreeAmount + ", deliPrepaidFlag="
				+ deliPrepaidFlag + ", deliPackageFlag=" + deliPackageFlag
				+ ", packageDeliCost=" + packageDeliCost + ", typeCode="
				+ typeCode + ", returnName=" + returnName + ", returnCell="
				+ returnCell + ", modContent=" + modContent + ", column="
				+ column + ", typeCd=" + typeCd + ", typeNm=" + typeNm
				+ ", itemSearchType=" + itemSearchType + ", itemSearchValue="
				+ itemSearchValue + ", sellerSearchType=" + sellerSearchType
				+ ", sellerSearchValue=" + sellerSearchValue + ", orderType="
				+ orderType + ", authCategory=" + authCategory + "]";
	}
}
