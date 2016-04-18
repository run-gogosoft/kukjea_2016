<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/mypage/order.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		#popup-zone {
      margin-top:-5px;
    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="body-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>

	<div class="main-content-wrap" style="margin-bottom:70px">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 구매정보 <span class="breadcrumb-arrow">&gt;</span> <strong>주문배송조회</strong> <span class="breadcrumb-arrow">&gt;</span> <strong>주문 상세정보</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<%--주문금액계산--%>
		<c:set var="totalSellPrice" value="0" />
		<c:set var="totalDeliveryPrice" value="0" />
		<c:set var="addrButton" value="0" />
		<c:forEach var="item" items="${list}" varStatus="status">
			<c:if test="${item.statusCode eq '10'}">
				<c:set var="addrButton" value="${addrButton+1}" />
			</c:if>
			<%--착불 배송비 제외--%>
			<c:if test="${item.deliPrepaidFlag eq 'Y'}">
				<c:set var="totalDeliveryPrice" value="${totalDeliveryPrice + item.deliCost}" />
			</c:if>
			<c:set var="totalSellPrice" value="${totalSellPrice + ((item.sellPrice + item.optionPrice) * item.orderCnt)}" />
		</c:forEach>

		<div class="top-table">
			<div style="text-align:right;padding-bottom:5px;">
				<a href="/shop/mypage/order/list" class="btn btn-default">목록보기</a>
			</div>
			<table class="table">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
					<tr>
						<td>주문번호</td>
						<td>총 상품금액</td>
						<td>총 배송비</td>
						<td>포인트</td>
						<td>총 주문금액</td>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td>${vo.orderSeq}</td>
							<td><fmt:formatNumber value="${totalSellPrice}"/>원</td>
							<td><fmt:formatNumber value="${totalDeliveryPrice}"/>원</td>
							<td><fmt:formatNumber value="${vo.point}"/>원</td>
							<td><strong><fmt:formatNumber value="${vo.payPrice}"/>원</strong></td>
						</tr>
				</tbody>
			</table>
		</div>

		<div class="top-table">
			<table class="table">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
				<thead>
					<tr>
						<td>결제수단</td>
						<td>총 결제 금액</td>
						<td colspan="4">비고</td>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td>${vo.payMethodName}</td>
							<td><strong><fmt:formatNumber value="${vo.payPrice + vo.point}"/></strong>원</td>
							<td colspan="4">${vo.accountInfo}</td>
						</tr>
				</tbody>
			</table>
		</div>
		<!-- 후청구 결제일 경우 결제여부 상태를 보여준다. -->
		<c:if test="${vo.npPayFlag ne ''}">
			<div class="top-table">
				<table class="table">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
							<tr>
								<td>결제여부</td>
								<td>
									<strong>
										<c:choose>
											<c:when test="${vo.npPayFlag eq 'Y'}">결제완료</c:when>
											<c:otherwise>미결제</c:otherwise>
										</c:choose>
									</strong>
								</td>
							</tr>
					</tbody>
				</table>
			</div>
		</c:if>

		<div class="title-back">
			<div class="title-wrap">
				<div class="title">주문 상품 리스트</div>
			</div>
		</div>
		<div class="main-table">
			<table class="table">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<td colspan="2">상품정보</td>
						<td>상품금액</td>
						<td>수량</td>
						<td>주문금액</td>
						<td>업체</td>
						<td>배송정보</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td>
								<c:if test="${item.img1 ne ''}">
									<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's206')}" style="width:70px;height:70px;border:1px solid #d7d7d7;" alt="${item.itemName}" /></a>
								</c:if>
							</td>
							<td class="text-left item-name">
								<a href="/shop/detail/${item.itemSeq}">${item.itemName}</a><br/>
								<c:if test="${item.optionValue ne ''}">
									<span class="option-name">${item.optionValue}</span><br/>
								</c:if>
							</td>
							<td><fmt:formatNumber value="${item.sellPrice+item.optionPrice}"/>원</td>
							<td><strong>${item.orderCnt}개</strong></td>
							<td class="item-price">
								<fmt:formatNumber value="${(item.sellPrice+item.optionPrice)*item.orderCnt}"/>원
							</td>
							<td>${item.sellerName}</td>
							<td>
								<c:choose>
									<c:when test="${vo.payMethod eq 'OFFLINE' or fn:startsWith(vo.payMethod,'NP')}">
										<c:choose>
											<c:when test="${item.statusCode eq '10'}">
												접수완료<br/>
											</c:when>
											<c:otherwise>
												${item.statusText}<br/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										${item.statusText}<br/>
									</c:otherwise>
								</c:choose>
								<c:if test="${item.statusCode eq '10'}">
									<c:set var="addrButton" value="${addrButton+1}" />
								</c:if>

								<c:if test="${item.statusCode eq '30'}">
									<fmt:parseNumber var="parseIntStatusCode" value="${item.statusCode}" type="number"/>
									<c:if test="${parseIntStatusCode >= 30 and item.deliSeq ne 0 and item.deliNo ne ''}">
										<button class="btn btn-default btn-xs btn-etc" onclick="viewDelivery('${item.deliTrackUrl}','${item.deliNo}');">배송추적</button>
									</c:if>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<%-- 비교견적 다운로드 --%>
		<c:if test="${vo.estimateCompareFlag eq 'Y'}">
		<div class="sign-form form3" style="margin-top:35px;">
			<div class="inner" style="height:auto;">
				<div class="title-back">
					<div class="title-wrap">
						<div class="title">비교견적 다운로드</div>
					</div>
				</div>
				<table class="table sign-table">
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
						<col width="15%"/>
						<col width="10%"/>
					</colgroup>
					<c:forEach var="item" items="${estimateCompareFileList}">
					<tr>
						<td>파일명<span>*</span></td>
						<td>비교견적서_${item.sellerName}_${item.seq}.${fn:substringAfter(item.file, '.')}</td>
						<td>${fn:substring(item.regDate,0,10)}</td>
						<td><button type="button" onclick="location.href='/shop/estimate/compare/download/${item.seq}'" class="btn btn-default btn-xs btn-etc">다운로드</button></td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(estimateCompareFileList) == 0 }">
						<tr>
							<td colspan="4" class="text-center">등록된 데이터가 없습니다.</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
		</c:if>
		
		<%-- 주문자 정보 --%>
		<div class="sign-form form2" style="margin-top:35px;height:auto">
			<div class="inner" style="height:auto">
				<div class="title-back">
					<div class="title-wrap">
						<div class="title" style="width:760px;">주문자 정보</div>
					</div>
				</div>
				<table class="table sign-table">
					<tr>
						<td>주문자명</td>
						<td>
							${vo.memberName}
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td style="letter-spacing:0;">
							${vo.memberCell}
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td style="letter-spacing:0;">
							${vo.memberEmail}
						</td>
					</tr>
				</table>
			</div>
		</div>

		<%-- 배송지 정보 --%>
		<div class="sign-form form2" style="margin-top:35px;height:auto">
			<div class="inner" style="height:auto">
				<div class="title-back">
					<div class="title-wrap">
						<div class="title" style="width:760px;">
							배송지 정보
							<c:if test="${addrButton eq fn:length(list)}">
								<button type="button" class="btn btn-default btn-xs btn-etc bnt-deli" onclick="addrChange();" style="float:right;width:105px;">배송지 주소 수정</button>
							</c:if>
						</div>
					</div>
				</div>
				<table class="table sign-table">
					<tr>
						<td>수신자명</td>
						<td>
							<c:choose>
								<c:when test="${addrButton ne fn:length(list)}">
									${vo.receiverName}
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" id="receiverName" name="receiverName" style="width:;" maxlength="15" value="${vo.receiverName}" style="width: 200px;"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td style="letter-spacing:0;">
							<c:choose>
								<c:when test="${addrButton ne fn:length(list)}">
									${vo.receiverTel}
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" id="receiverTel" name="receiverTel" maxlength="20" value="${vo.receiverTel}" style="width: 200px;"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>휴대폰번호</td>
						<td style="letter-spacing:0;">
							<c:choose>
								<c:when test="${addrButton ne fn:length(list)}">
									${vo.receiverCell}
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" id="receiverCell" name="receiverCell" maxlength="20" value="${vo.receiverCell}" style="width: 200px;"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td style="letter-spacing:0;">
							<c:choose>
								<c:when test="${addrButton ne fn:length(list)}">
									${vo.receiverEmail}
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" id="receiverEmail" name="receiverEmail" maxlength="20" value="${vo.receiverEmail}" style="width: 200px;"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>
							<c:choose>
								<c:when test="${addrButton ne fn:length(list)}">
									${vo.receiverPostcode}<br/>
									${vo.receiverAddr1}<br/>
									${vo.receiverAddr2}
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" id="receiverPostcode" name="receiverPostcode" maxlength="6" onblur="numberCheck(this);" value="${vo.receiverPostcode}" style="width:75px;"/><br/>
									<input type="text" class="form-control" id="receiverAddr1" name="receiverAddr1" maxlength="100" value="${vo.receiverAddr1}" style="margin-top:2px;width:400px;"/><br/>
									<input type="text" class="form-control" id="receiverAddr2" name="receiverAddr2" maxlength="100" value="${vo.receiverAddr2}" style="margin-top:2px;width:400px;"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>배송 메세지</td>
						<td>
							${vo.request}
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<%-- 세금계산서 요청서 --%>
		<c:if test="${taxRequest ne null}">
		<div class="sign-form form2" style="margin-top:35px;height:auto">
			<div class="inner" style="height:auto">
				<div class="title-back">
					<div class="title-wrap">
						<div class="title" style="width:760px;">
							세금계산서 요청서
						</div>
					</div>
				</div>
				<table class="table sign-table">
					<tr>
						<td>진행상태</td>
						<td>
							<c:choose>
								<c:when test="${taxRequest.requestFlag eq 'N'}">진행중</c:when>
								<c:when test="${taxRequest.requestFlag eq 'Y'}">발송완료 (${taxRequest.completeDate})</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>사업자번호</td>
						<td>
							${taxRequest.businessNum}
						</td>
					</tr>
					<tr>
						<td>상호(법인명)</td>
						<td>
							${taxRequest.businessCompany}
						</td>
					</tr>
					<tr>
						<td>대표자</td>
						<td>
							${taxRequest.businessName}
						</td>
					</tr>
					<tr>
						<td>소재지</td>
						<td>
							${taxRequest.businessAddr}
						</td>
					</tr>
					<tr>
						<td>업태</td>
						<td>
							${taxRequest.businessCate}
						</td>
					</tr>
					<tr>
						<td>종목</td>
						<td>
							${taxRequest.businessItem}
						</td>
					</tr>
					<tr>
						<td>수신 이메일</td>
						<td>
							${taxRequest.requestEmail}
						</td>
					</tr>
					<tr>
						<td>담당자</td>
						<td>
							${taxRequest.requestName}
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>
							${taxRequest.requestCell}
						</td>
					</tr>
				</table>
			</div>
		</div>
		</c:if>

		<div class="button-wrap">
			<c:if test="${vo.tid ne ''}">
				<button type="button" onclick="showReceipt('${vo.tid}')" class="btn btn-info" style="margin-right:10px"><span>카드 영수증</span></button>
			</c:if>
			<button type="button" class="btn btn-primary" style="margin-right:10px" onclick="doPrint(${vo.orderSeq},'receipt')"><span>영수증</span></button>
			<button type="button" class="btn btn-warning" style="margin-right:10px" onclick="doPrint(${vo.orderSeq},'statement')"><span>거래명세표</span></button>
			<button type="button" class="btn btn-success" style="margin-right:10px" onclick="doPrint(${vo.orderSeq},'estimate')"><span>견적서</span></button>
			<button type="button" class="btn btn-danger" onclick="doPrint(${vo.orderSeq},'deliveryConfirm')"><span>납품확인서</span></button>
		</div>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	var doPrint = function(orderSeq, pageType) {
		if(pageType === 'deliveryConfirm') {
			window.open("/shop/mypage/order/view/"+orderSeq+"?pageType="+pageType, "order_view", "width=710px,height=700px,scrollbars=yes");
		} else {
			window.open("/shop/mypage/order/view/"+orderSeq+"?pageType="+pageType, "order_view", "width=710px,height=500px,scrollbars=yes");
		}
	};

	var showReceipt = function(tid) {
		var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noMethod=1&noTid="+tid;
		window.open(receiptUrl,"receipt","width=430,height=700");
	};
</script>
</body>
</html>