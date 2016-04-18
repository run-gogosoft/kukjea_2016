<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/detail/detail.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
    #popup-zone {
          margin-top:-5px;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
<input type="hidden" id="loginSeq" value="${loginSeq}"/>
<c:if test="${fn:length(optionList) eq 0}">
	<script type="text/javascript">
		alert("판매중이 아닙니다.");
		history.back(-1);
	</script>
</c:if>
<div class="detail-wrap">
	 <div class="breadcrumb">
    <div class="pull-left" style="margin:8px 10px 0 0;"><img src="/front-assets/images/detail/home.png" alt="홈 아이콘"> 홈<span class="arrow">&gt;</span></div>
    <form id="searchForm" method="get" class="pull-left" style="margin-top:8px;">
      <select name="cateLv1Seq" style="display:inline;padding-left:5px;width:155px;border:1px solid #cccccc" onchange="submitCatagory(1, this, '');">
            <option value="">대분류</option>
            <c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
            	<%--함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.--%>
            	<c:choose>
					<c:when test="${sessionScope.loginMemberTypeCode eq 'P'}">
						<option value="${item.seq}" <c:if test="${vo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
					</c:when>
					<c:otherwise>
						<c:if test="${item.seq ne 53}">
							<option value="${item.seq}" <c:if test="${vo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:if>
					</c:otherwise>
            	</c:choose>
            </c:forEach>
      </select>

      <c:if test="${vo.cateLv2Seq ne null and vo.cateLv2Seq ne 0}">
      <span class="arrow-sub">&gt;</span>
      <select name="cateLv2Seq" style="display:inline;padding-left:5px;width:155px;border:1px solid #cccccc" onchange="submitCatagory(2, this, ${vo.cateLv1Seq});">
            <option value="">중분류(전체)</option>
            <c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
                  <option value="${item.seq}" <c:if test="${vo.cateLv2Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
            </c:forEach>
      </select>
      </c:if>

      <c:if test="${vo.cateLv3Seq ne null and vo.cateLv3Seq ne 0}">
      <span class="arrow-sub">&gt;</span>
	      <select name="cateLv3Seq" style="display:inline;padding-left:5px;width:155px;border:1px solid #cccccc" onchange="submitCatagory(3, this, ${vo.cateLv2Seq});">
	            <option value="">소분류(전체)</option>
	            <c:forEach var="item" items="${cateLv3List}" varStatus="status" begin="0" step="1">
	                  <option value="${item.seq}" <c:if test="${vo.cateLv3Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
	            </c:forEach>
	      </select>
      </c:if>

      <c:if test="${vo.cateLv4Seq ne null and vo.cateLv4Seq ne 0}">
            <span class="arrow">&gt;</span>
            <select name="cateLv4Seq" style="display:inline;padding-left:5px;width:155px;border:1px solid #cccccc" onchange="submitCatagory(4, this, ${vo.cateLv3Seq});">
                  <option value="">세분류(전체)</option>
                  <c:forEach var="item" items="${cateLv4List}" varStatus="status" begin="0" step="1">
                        <option value="${item.seq}" <c:if test="${vo.cateLv4Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                  </c:forEach>
            </select>
      </c:if>
    </form>
  </div>

	<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

	<div class="ch-container">
		<!-- 상품 이미지 영역 -->
		<div class="ch-gallery">
			<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s500/')}" alt="상품 대표 이미지1" />
			<div class="ch-gallery-thumb">
				<ul>
				<c:if test="${vo.img1 ne ''}">
					<li class="current">
						<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s206/')}" data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s500/')}" alt="상품 섬네일 이미지1" />
					</li>
				</c:if>
				<c:if test="${vo.img2 ne ''}">
					<li>
						<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img2, '/origin/', '/s206/')}" data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img2, '/origin/', '/s500/')}" alt="상품 섬네일 이미지2" />
					</li>
				</c:if>
				<c:if test="${vo.img3 ne ''}">
					<li>
						<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img3, '/origin/', '/s206/')}" data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img3, '/origin/', '/s500/')}" alt="상품 섬네일 이미지3" />
					</li>
				</c:if>
				<c:if test="${vo.img4 ne ''}">
					<li>
						<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img4, '/origin/', '/s206/')}" data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img4, '/origin/', '/s500/')}" alt="상품 섬네일 이미지4" />
					</li>
				</c:if>
				</ul>
			</div>
		</div>
		
		<!-- 상품 판매 정보 영역 -->
		<div class="ch-detail-box">
			<div>
			<table class="table">
				<colgroup>
					<col style="width:20%"/>
					<col style="width:*"/>
				</colgroup>
				<tbody>
					<tr>
						<td colspan="2"><strong style="font-size:21px;color:#000;">${vo.name}</strong></td>
					</tr>
					<tr>
						<td class="title">업체명</td>
						<td colspan="3">
							<a href="/shop/about/seller/${vo.sellerSeq}" target="_blank">${vo.sellerName}</a>
						</td>
					</tr>
					<tr>
						<td class="title">판매가</td>
						<td>
						<c:choose>
							<c:when test="${vo.typeCode eq 'N'}">
								<c:if test="${vo.marketPrice > vo.sellPrice}">
									<span class="origin-price"><fmt:formatNumber value="${vo.marketPrice}" pattern="#,###" /> 원</span>
								</c:if>
								<strong id="sell-price" style="${vo.marketPrice > vo.sellPrice ? "margin-left:5px;":""} font-size:16px;" data-price="${vo.sellPrice}"><fmt:formatNumber value="${vo.sellPrice}" pattern="#,###" /> 원</strong>
							</c:when>
			                <c:when test="${vo.typeCode eq 'E'}">
			                    <span class="korea">견적요청</span>
			                </c:when>
              			</c:choose>
              				<span class="text-warning" style="padding-left:10px;">${vo.taxCode eq "1" ? "(과세)":"(면세)"}</span>
						</td>
					</tr>
					<tr>
						<td class="title">수량</td>
						<td>
							<input type="hidden" id="payMethod" value="${mallVo.payMethod}">
							<div class="input-group" style="width:150px;">
								<input id="count" type="text" class="form-control input-sm" style="font-size:15px;" value="1" maxlength="5" onkeyup="PriceLB.calcOrderAmt();" />
								<span class="input-group-btn">
									<button type="button" class="btn btn-sm" onclick="addCount(+1);PriceLB.calcOrderAmt()" style="color:#666;background:#c8dBe5">+</button>
									<button type="button" class="btn btn-sm" onclick="addCount(-1);PriceLB.calcOrderAmt()" style="color:#666;background:#eee">-</button>
								</span>
							</div>
						</td>
					</tr>
					<tr <c:if test="${fn:length(optionList) eq 1 or statusCode eq 'S'}">class="hide"</c:if>>
						<td class="title">옵션</td>
						<td>
							<div class="dropdown" style="float:left;width:150px;">
								<button id="option-btn" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
								 선택하세요 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu optionList" role="menu">
									<li role="presentation" class="dropdown-header">옵션선택</li>
									<c:forEach var="item" items="${optionList}">
										<li class="optionItem">
											<a href="#" onclick="PriceLB.changeProc(this);PriceLB.calcOrderAmt();return false;" data-option-value="${item.seq}" data-option-price="${item.optionPrice}" data-stock-count="${item.stockCount}">
												<c:if test="${fn:length(optionList) ne 1 or item.optionPrice ne 0}">
												* ${item.optionName} : ${item.valueName} (+ <fmt:formatNumber value="${item.optionPrice}"/>원)
													<c:choose>
														<c:when test="${item.stockCount eq 0}"><span class="text-danger">품절</span></c:when>
														<c:otherwise><span class="text-info" style="display:none">/ 재고: <fmt:formatNumber value="${item.stockCount}"/> 개</span></c:otherwise>
													</c:choose>
												</c:if>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
							<c:if test="${fn:length(optionList)>0}">
								<input type="hidden" id="optionValueSeq" name="optionValueSeq" value="${optionList[0].seq}" />
							</c:if>
							<div id="option-name" colspan="2" style="display:none;color:#3A87AD;font-weight:bold;"></div>
						</td>
					</tr>
					<tr>
						<td class="title">배송비</td>
						<td>
							무료
						<%-- <c:choose>
							<c:when test="${vo.deliTypeCode eq '00'}">무료</c:when>
							<c:when test="${vo.deliTypeCode eq '10'}">
								<c:choose>
									<c:when test="${vo.deliFreeAmount eq 0}"><fmt:formatNumber value="${vo.deliCost}" pattern="#,###" />원</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${vo.deliCost}" pattern="#,###" />원
										<span style="font-size:12px;">(<fmt:formatNumber value="${vo.deliFreeAmount}" pattern="#,###" /> 원 이상 구매시 무료)</span>
									</c:otherwise>
								</c:choose>
								<div id="deliPrePaidFlagDIv" data-deli-prepaid-flag="${vo.deliPrepaidFlag}">
									<c:choose>
										<c:when test="${vo.deliPrepaidFlag eq ''}">
											<select id="deliPrepaidFlag" class="form-control">
												<option value="Y">주문시 결제(선결제)</option>
												<option value="N">상품 수령시 결제(착불)</option>
											</select>
										</c:when>
										<c:when test="${vo.deliPrepaidFlag eq 'Y'}">
											주문시 결제(선결제)
										</c:when>
										<c:when test="${vo.deliPrepaidFlag eq 'N'}">
											상품 수령시 결제(착불)
										</c:when>
									</c:choose>
								</div>
							</c:when>
						</c:choose> --%>
							<c:if test="${vo.deliPackageFlag eq 'Y'}">
								<span class="text-warning" style="padding-left:10px">(묶음배송 가능)</span>
							</c:if>
						</td>
					</tr>

					<tr>
						<td class="title">상품코드</td>
						<td>${vo.seq}</td>
					</tr>
					<c:if test="${vo.authCategory ne ''}">
					<tr>
						<td class="title">인증구분</td>
						<td>
						<c:forEach var="item" items="${authCategoryList}">
							<c:if test="${fn:contains(vo.authCategory, item.value)}">
								<span style="display:inline-block;width:180px;margin-bottom:10px;">${item.name}<img src="/front-assets/images/detail/auth_mark_${item.value}.png" style="margin-left:5px;vertical-align:-4px;" alt="${item.name}"></span>
							</c:if>
						</c:forEach>
						</td>
					</tr>
					</c:if>
					<tr>
						<td class="title">합계금액</td>
						<td>
							<c:choose>
								<c:when test="${vo.typeCode eq 'E'}">
									<strong style="font-size:24px;" class="text-danger">견적요청</strong>
								</c:when>
								<c:otherwise><strong id="order-amt" style="font-size:24px;" class="text-danger"><fmt:formatNumber value="${vo.sellPrice}"/></strong> 원</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
			<c:if test="${statusCode eq 'Y'}">
			<div>
				<c:choose>
					<c:when test="${vo.typeCode eq 'N'}">
				<!-- 일반 상품 -->
				<div>
					<a href="#" style="margin-right:3px;" onclick="return ${loginSeq eq null ? "EBProcess.guestAlert('cart');":"EBProcess.addCart('${loginSeq}','${vo.seq}');"}">
						<img src="/front-assets/images/detail/buy_N_1.png" alt="장바구니"/>
					</a>
					<a href="#" style="margin-right:3px;" onclick="return addWish('${sessionScope.loginSeq}')">
						<img src="/front-assets/images/detail/buy_N_2.png" alt="관심상품"/>
					</a>
					<a href="#" onclick="return CHBoardUtil.qnaWriteButton('${sessionScope.loginSeq}', 'top')">
						<img src="/front-assets/images/detail/buy_N_3.png" alt="상품문의"/>
					</a>
				</div>
				<div style="margin-top:7px">
					<a href="#" style="margin-right:3px;" onclick="return ${loginSeq eq null ? "EBProcess.guestAlert('buy');":"EBProcess.buy();"}">
						<img src="/front-assets/images/detail/buy_N_4.png" alt="바로구매"/>
					</a>
					<a href="#" onclick="return showEstimateModal()">
						<img src="/front-assets/images/detail/buy_N_5.png" alt="대량구매 견적요청"/>
					</a>
				</div>
					</c:when>
					<c:when test="${vo.typeCode eq 'E'}">
				<!-- 견적 상품 -->
				<div>
					<a href="#" style="margin-right:2px;" onclick="return addWish('${sessionScope.loginSeq}')"><img src="/front-assets/images/detail/buy_E_1.png" alt="관심상품"/></a>
					<a href="#" onclick="return CHBoardUtil.qnaWriteButton('${sessionScope.loginSeq}', 'top')"><img src="/front-assets/images/detail/buy_E_2.png" alt="상품문의"/></a>
				</div>
				<div style="margin-top:7px;">
					<a href="#" onclick="return showEstimateModal()"><img src="/front-assets/images/detail/buy_E_3.png" alt="견전문의"/></a>
				</div>
					</c:when>
				</c:choose>
			</div>
			</c:if>
			<c:if test="${statusCode eq 'S'}">
				<div style="text-align:center;font-size:24px;" class="text-danger">해당 상품은 품절되었습니다.</div>
			</c:if>
			<input type="hidden" id="seq" name="seq" value="${vo.seq}" />
			<input type="hidden" id="typeCode" name="typeCode" value="${vo.typeCode}" />
		</div>
	</div>
	
	<ul class="fiexd-bar" style="margin-top:50px;">
		<li onclick="moveTab(this, 'content');" class="current">상품상세정보</li>
		<li onclick="moveTab(this, 'delivery');">배송정보</li>
		<li onclick="moveTab(this, 'exchange');">교환/반품</li>
		<li onclick="moveTab(this, 'reputation');">상품 후기</li>
		<li onclick="moveTab(this, 'qna');">상품 Q&amp;A</li>
	</ul>
	
	<div id="content" class="ch-container tab">
		${vo.content}
		<c:if test="${vo.detailImg1 ne ''}"><p class="text-center"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${vo.detailImg1}" alt="${vo.detailAlt1}" /></p></c:if>
		<c:if test="${vo.detailImg2 ne ''}"><p class="text-center"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${vo.detailImg2}" alt="${vo.detailAlt2}" /></p></c:if>
		<c:if test="${vo.detailImg3 ne ''}"><p class="text-center"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${vo.detailImg3}" alt="${vo.detailAlt3}" /></p></c:if>
	</div>
	
	<div id="delivery" class="delivery-wrap tab" style="padding:20px 0 20px 0;display:none">
		<div style="font-size: 11px;">
			<ol style="margin-top: 10px;">
				<li style="line-height:25px;">
					<strong style="text-decoration: underline;">합계 구매액이 5만원 이하인 경우 택배비가 별도 부과</strong>되며 도서지역 및 제주도는 추가로 배송비가 부과됩니다.<br/>
					총 구매액이 5만원 이상인 경우 택배비가 무료입니다.<br/>
					단, 무료 배송상품이라도 물건을 배송받는 지역이 지방(경기포함)일 경우 배송료가 별도로 부과될 수 있으니 주문전 전화로 문의해주시기 바랍니다.<br/>
					<strong style="color: #F55C3D;font-size: 17px;">고객센터 : 02-2222-3896</strong>
				</li>
				<li style="line-height:25px;margin-top:10px;">
					평균 배송기간은 결제일로부터 영업일 기준으로 3~7일(토요일, 일요일, 공휴일 제외)정도 소요되며, 각생산시설의 재고상황에 따라 다소 지연될 수 있습니다.<br/>
					자세한 사항은 자주묻는 질문에서 확인하시기 바랍니다.
				</li>
			</ol>
		</div>
	</div>
	
	<div id="exchange" class="exchange-wrap tab" style="padding:30px 0 20px 0;display:none">
		<div style="font-size: 11px;">
			<ol>
				<li style="line-height:25px;">
					환불/취소 등의 신청은 고객님께서 먼저 전화(02-2222-3896)로 신청하신 후 직접 홈페이지 상에서 설정 변경을, 하셔야합니다.<br/>
					제품이 이미 출고되면 상품 반송과정을 거쳐야하므로 고객변심에 의한 교환/환불인 경우 상품 반송에 드는 배송비는 고객님께서 부담하셔야 합니다.<br/>
					단, 고객 변심에 의한 제품 환불인 경우 구매한 총금액이 5만원 이상이 되는 경우에는 초기 무료 배송에 대한 배송비를 포함한 반품 택배비를 지불하셔야 합니다.<br/>
					이때 무료로 상품을 배송받았으나 그 중 1만원짜리 상품을 환불받으면 총액이 5만원이 안되므로 배송비를 지불해야 합니다.<br/>
					그러나 반품을 하더라도 나머지 구매한 물품의 총금액이 5만원이 넘을 경우는 반품에 대한 택배비만 지불하시면 됩니다.<br/>
					<span style="color: #C0462D;"> 초기 무료배송으로 상품을 받으신 경우 왕복 배송료 부담 : 7,000원<br/>
					고객님께서 직접 택배비를 지불하고 상품을 받으신 경우 반송 배송료 부담 : 3,500원</span><br/>
				</li>
				<li style="line-height:25px;margin-top:10px;">
					아래의 경우에는 환불이 불가능합니다.<br/>
					- 고객님의 사유로 상품들이 멸실 또는 훼손되어 상품가치가 떨어지게 되었을 경우<br/>
					- 상품의 특성상 배송 후 새 상품으로 가치를 상실하게 되는 경우<br/>
				</li>
				<li style="line-height:25px;margin-top:10px;">
					환불은 고객님께서 물건을 보내신 후 판매시설 또는 생산시설에 물건이 입고가 확인되면 계좌로 해당 금액을 입금 또는 카드결제 취소를
					해드립니다.<br/>
					<strong style="color: #F55C3D;font-size: 17px;">고객센터 : 02-2222-3896</strong>
				</li>
			</ol>
		</div>
	</div>
		
	<!-- template -->
	<script id="trTemplate" type="text/html">
		<tr>
			<td style="text-align:center; vertical-align:middle"><%="${number}"%></td>
			<td data-seq-review="<%="${seq}"%>" class="content"></td>
			<td style="text-align:center; vertical-align:middle" class="name"><%="${name}"%></td>
			<td style="text-align:center; vertical-align:middle" class="star"><%="${reviewGradeStar}"%></td>
			<td style="text-align:center; vertical-align:middle" class="date"><%="${regDate}"%></td>
		</tr>
	</script>
	<div id="reputation" class="ch-container tab" style="display:none">
		<div id="reputation-counter" class="reputation-counter"></div>
		<div class="clearfix"></div>
		<table id="reviewTable" class="table eb-reputation-table">
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<tbody id="boardTarget"></tbody>
		</table>
		<div id="paging" style="text-align:center;"></div>
	</div>
	
	<!-- template -->
	<script id="trItemQnaTemplate" type="text/html">
		<tr>
			<td style="width:150px;text-align:center;"><div class="item-qna-icon">Q</div></td>
			<td style="text-align:center;"><%="${answerFlag}"%></td>
			<td class="content">
				<a href="#" onclick="$('#qna_a<%="${count}"%>').toggle();return false;"><%="${title}"%></a>
			</td>
			<td style="text-align:center;" class="name"><%="${name}"%></td>
			<td style="text-align:center;" class="date"><%="${regDate}"%></td>
		</tr>

		<%-- 클릭하면 열리는 tr id는 foreach의 ${status.count}를 가져옴--%>
		<tr style="height:40px; display:none;" id="qna_a<%="${count}"%>">
			<td style="background-color:#f5f5f5;text-align:center;padding:0;" colspan="5">
				<table id="qnaTable" style="vertical-align: middle;">
					<tr>
						<td style="width:150px;border-top:0;"><div class="item-qna-icon">Q</div></td>
						<td data-seq-content="<%="${seq}"%>" style="width:660px;text-align:left;vertical-align: middle;border:0;"></td>
						<td style="width:150px;border-top:0;vertical-align: middle;"></td>
						<td style="width:150px;border-top:0;vertical-align: middle;"></td>
					</tr>
					{{if answer!=''}}
						<tr>
							<td style="width:150px;"><div class="item-qna-icon" style="background-color:#4CB7C9;">A</div></td>
							<td data-seq-answer="<%="${seq}"%>" style="width:660px;background-color:#f5f5f5;text-align:left;vertical-align:middle;"><%="${answer}"%></td>
							<td style="width:150px;vertical-align:middle;"><%="${answerDate}"%></td>
							<td style="width:150px;vertical-align: middle;"></td>
						</tr>
					{{/if}}
				</table>
			</td>
		</tr>
	</script>
	<div id="qna" class="ch-container tab" style="margin-top:30px;margin-bottom:0;display:none;">
		<div id="qna-reputation-counter" class="reputation-counter"></div>
		<div class="reputation-counter-description"><strong>상품에 관한 문의가 아닌 배송, 결제, 교환/반품에 대한 문의는 고객센터 1:1 이메일 상담을 이용해 주세요.</strong></div>
		<button type="button" class="btn btn-qna-write" onclick="CHBoardUtil.qnaWriteButton('${sessionScope.loginSeq}','bottom')"><div>Q&amp;A 문의하기</div></button>

		<div class="clearfix"></div>

		<table class="table eb-reputation-table">
			<colgroup>
				<col width="10%" />
				<col width="10%" />
				<col width="*" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<tbody id="boardItemQnaTarget"></tbody>
		</table>
		<div id="itemQnaPaging" style="text-align:center;margin-bottom:80px;"></div>
	</div>

	
	<div class="ch-container">
		<div class="banner-title" style="margin-top:50px;">
		   <span class="left">입점업체 관련상품</span>
		</div>
		<input type="hidden" id="sellerSeq" value="${vo.sellerSeq}">
		<!-- template -->
		<script id="sellerTemplate" type="text/html">
			<li style="width:207px;">
		       	<div class="img">
		       		<a href="/shop/detail/<%="${seq}"%>">
		       			<img src="<%="${img1}"%>" alt="상품이미지" {{if img2 !== ""}}data-src="<%="${img2}"%>"{{/if}}/>
		       		</a>
		       	</div>
		       	<div class="info">
		       		<div class="name"><a href="/shop/detail/<%="${seq}"%>"><%="${name}"%></a></div>
		       		{{if typeCode==="N"}}
		       			<div class="price"><%="${sellPrice}"%><span>원<span></div>
		       		{{else typeCode==="E"}}
		       			<div class="price">견적요청</div>
		       		{{/if}}
		       	</div>
			</li>
		</script>

		<div class="banner-content" style="height:272px;margin-top:15px;">
	    <ul id="sellerTarget" class="ch-3col middle-banner"></ul>
	  </div>

	  <div id="sellerPaging" style="text-align:center;margin-bottom:30px;"></div>
	</div>

	<div class="ch-container">
		<div class="add-info-title">
			<span class="left"><i class="fa fa-tags"></i>&nbsp;상품정보 고시</span>
		</div>
		<div class="add-info-content">
			<div class="inner">
				<c:forEach var="item" items="${propList}" varStatus="status" begin="0" step="1">
					<c:if test="${status.index eq 0}">
					<div>
						<ul class="content">
							<li>+ 상품군</li>
							<li>${item.typeNm}</li>
						</ul>
					</div>
					</c:if>
					<div>
						<c:set var="tempPropVal" value="prop_val${status.count}"/>
						<ul class="content">
							<li>+ ${item.propNm}</li>
							<li>
									<c:choose>
									<c:when test="${(propInfo[tempPropVal] eq '') or (propInfo[tempPropVal] eq null)}">
										<c:choose>
											<c:when test="${item.defaultVal eq 'N'}">
												해당없음
											</c:when>
											<c:when test="${item.defaultVal eq 'Y'}">
												해당
											</c:when>
											<c:otherwise>
												${item.defaultVal}
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${propInfo[tempPropVal] eq 'N'}">
												해당없음
											</c:when>
											<c:when test="${propInfo[tempPropVal] eq 'Y'}">
												해당
											</c:when>
											<c:otherwise>
												${propInfo[tempPropVal]}
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</li>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
<%--Q&A질문하기 레이어--%>
<div class="hh-writebox-detail">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header"><span class="title">질문하기</span></div>
		<div class="hh-writebox-content">
			<form name="qnaProc" class="form-horizontal" onsubmit="return submitProc(this);" method="post" role="form" action="/shop/cscenter/write/proc/qna" target="zeroframe">
				<input type="hidden" name="integrationSeq" value="${itemSeq}"/>
				<input type="hidden" name="writerSeq" value="${loginSeq}"/>
				<div class="hh-writebox-text-check">
					<br/>
					<p>◇ 사이트 이용 관련 문의나 의견을 등록하시면 빠른 시일내에 답변을 드립니다.</p>
					<p>◇ 문의에 대한 답변은 마이페이지에서 확인하실 수 있습니다.</p>
				</div>
				<div class="hh-writebox-answer" style="padding-left:15px;">
					<div class="input-group">
						<span class="input-group-addon answer-title" style="width:122px;">제목</span>
						<input id="qnaTitle" type="text" class="form-control" name="title" alt="제목" placeholder="" style="float:left;width:350px;height:26px;font-size:12px;" maxlength="70">
					</div>
					<div class="input-group" style="height: 230px;">
						<span class="input-group-addon" style="width: 122px;font-size:12px;"><p>문의내용</p></span>
						<textarea id="qnaContent" rows="22" cols="77" class="form-control" name="content" style="display:inline-block;font-size:12px;" alt="내용"></textarea>
					</div>
				</div>
				<div class="hh-writebox-footer">
					<div class="inner">
						<button type="submit" class="btn btn-qna-submit">등록하기</button>
						<button type="button" class="btn btn-qna-cancel" onclick="CHBoardUtil.qnaWriteClose()">취소하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
	<div class="clearfix"></div>
</div>

<div id="cartModal" class="modal fade">
	<div class="modal-dialog" style="width:500px;">
		<div class="modal-content">
			<div class="modal-header modal-" style="background-color:#3276B1">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" style="font-weight:bold;color:#fff">장바구니에 등록되었습니다.</h4>
			</div>
			<div class="modal-body">
				<h5>장바구니로 이동하시겠습니까?</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">아니오</button>
				<a href="/shop/cart" class="btn btn-primary">예</a>
			</div>
		</div>
	</div>
</div>

<div id="guestCartModal" class="modal fade">
	<div class="modal-dialog" style="width:500px;">
		<div class="modal-content">
			<div class="modal-header modal-" style="background-color:#3276B1">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" style="font-weight:bold;color:#fff">장바구니 (비회원)</h4>
			</div>
			<div class="modal-body">
				<h5>비회원 입니다.<br/> 상품을 장바구니에 등록 하시겠습니까?</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">아니오</button>
				<button type="button" onclick="EBProcess.addCart('${loginSeq}', '${itemSeq}');" class="btn btn-primary">예</button>
			</div>
		</div>
	</div>
</div>

<div id="guestBuyModal" class="modal fade">
	<div class="modal-dialog" style="width:500px;">
		<div class="modal-content">
			<div class="modal-header modal-" style="background-color:#3276B1">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" style="font-weight:bold;color:#fff">상품 구매(비회원) </h4>
			</div>
			<div class="modal-body">
				<h5>비회원 입니다.<br/> 비회원 구매를 진행 하시겠습니까?</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">아니오</button>
				<button type="button" onclick="EBProcess.buy('${loginSeq}', '${itemSeq}');" class="btn btn-primary">예</button>
			</div>
		</div>
	</div>
</div>

<div id="soldOutModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<h4>이 상품은 품절되었습니다.</h4>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- 견적신청 레이어 -->
<div id="estimateModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background-color:#3276B1">
				<h3 class="modal-title" style="font-weight:bold;font-size:16px;color:#fff">견적요청</h3>
			</div>
			<form class="form-horizontal" action="/shop/estimate/reg" method="post" target="zeroframe" onsubmit="return submitEstimate(this);">
				<input type="hidden" name="itemSeq" value="${vo.seq}"/>
				<input type="hidden" name="optionValueSeq"/>
				<input type="hidden" name="typeCode" value="${vo.typeCode}"/>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-md-3 control-label">회원명</label>
						<div class="col-md-9 form-control-static" id="memberName_text">${sessionScope.loginName }</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">상품명</label>
						<div class="col-md-9 form-control-static" id="itemName_text">${vo.name}</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">옵션</label>
						<div class="col-md-9 form-control-static" id="option_text"></div>
					</div>

					<div class="form-group">
						<label class="col-md-3 control-label">희망 구매 수량 <i class="fa fa-check"></i></label>
						<div class="col-md-9">
							<div class="input-group">
								<input class="form-control text-right" type="text" name="qty" onblur="numberCheck(this)" maxlength="9" />
								<div class="input-group-addon">개</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">기타 요청 사항</label>
						<div class="col-md-9">
							<textarea class="form-control" name="request" rows="10"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-md btn-primary">견적요청</button>
					<button type="button" data-dismiss="modal" class="btn btn-md btn-default">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<form id="buyForm" class="hide" action="/shop/order/direct" method="post" target="zeroframe"><div></div></form>
<form id="cartForm" class="hide" action="/shop/cart/add" method="post" target="zeroframe"><div></div></form>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/detail/detail.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		addInfoBoxHeight();
	});

	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "") {
				alert($(this).attr("alt") + "란을 입력해주세요!");
				flag = false;
				$(this).focus();
			}
		});

		return flag;
	};

	var showEstimateModal = function() {
		//회원만 이용 가능하다.
		if(!${sessionScope.loginSeq eq null ? false:true}) {
			alert("회원 로그인 후 이용하시기 바랍니다.");
			return false;
		}
		//옵션이 존재하는 상품은 옵션 선택 여부를 체크한다.
		if($("#option-name").text() == "" && $("#optionValueSeq").parents("tr.hide").length == 0) {
			alert("옵션을 선택해 주세요");
			return false;
		}

		//선택된 옵션명을 모달창에 뿌려준다.
		var optionValue = "";
		if($("#option-name").text() != "") {
			optionValue = $("#option-name").text().substring(0,$("#option-name").text().indexOf("(+"));
		}
		$("#option_text").text(optionValue);

		$("#estimateModal").modal();
	};

	var submitEstimate = function(form) {
		//선택된 옵션 시퀀스를 셋팅한다.
		form.optionValueSeq.value = $("#optionValueSeq").val();
		if(form.optionValueSeq.value > 0) {
			$(optionValueSeq).attr("disabled", false);
		} else {
			$(optionValueSeq).attr("disabled", true);
		}

		if( form.qty.value > 0 ) {
			return true;
		}

		alert("희망 구매 수량을 입력해 주세요.");
		form.qty.focus();

		return false;
	}
	
	//탭메뉴 이동
	var moveTab = function(selObj, area) {
		//초기화
		$(".tab").css("display", "none");
		$(".fiexd-bar .current").removeClass("current");
		
		//해당 선택 영역 표시
		$(selObj).addClass("current");
		$("#"+area).css("display", "block");
	}
</script>
</body>
</html>