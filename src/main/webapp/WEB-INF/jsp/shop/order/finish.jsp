<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/order/finish.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="main-title">
	주문완료
</div>

<%@ include file="/WEB-INF/jsp/shop/include/order_header.jsp" %>

<div class="finish-text-wrap">
	<div class="main-text">
		<div>이용해주셔서 감사합니다.</div>
		<div>고객님의 <span>주문/결제가 정상적으로 완료</span>되었습니다.</div>
	</div>
	<div class="sub-text">
		<fmt:parseDate value="${vo.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
		<div>
			<strong>${vo.memberName}</strong> 고객님이
			<strong><fmt:formatDate value="${regDate}" pattern="yyyy년 mm월 dd일"/></strong>
			에 주문하신 상품의 주문번호는 <span class="order-seq">${vo.orderSeq}</span>입니다.
		</div>
		<div>주문내역을 다시 확인하실려면 마이페이지 > 주문/배송조회 에서 하실 수 있습니다.</div>
	</div>
</div>

<c:set var="totalSellPrice" value="0" />
<c:set var="totalDeliveryPrice" value="0" />
<c:set var="totalDiscountPrice" value="0" />
<c:forEach var="item" items="${list}" varStatus="status">
	<c:if test="${item.deliPrepaidFlag eq 'Y'}">
		<c:set var="totalDeliveryPrice" value="${totalDeliveryPrice + item.deliCost}" />
	</c:if>
	<c:set var="totalSellPrice" value="${totalSellPrice + ((item.sellPrice +item.optionPrice) * item.orderCnt)}" />
</c:forEach>
<c:set var="totalDiscountPrice" value="${vo.point}" />
<div class="last-total-wrap">
	<div class="left">
		<div class="price-wrap">
			<div>총 상품금액 : <fmt:formatNumber value="${totalSellPrice}" pattern="#,###"/>원</div>
			<div>총 할인금액 : <fmt:formatNumber value="${totalDiscountPrice}" pattern="#,###"/>원</div>
		</div>
		<div class="price-wrap" style="margin-top:8px">
			<div>총 배송비 합계(선결제): <fmt:formatNumber value="${totalDeliveryPrice}" pattern="#,###"/>원</div>
		</div>
	</div>

	<div class="right">
		<div class="total-buy-price"><strong>최종 결제금액:</strong> <span><fmt:formatNumber value="${vo.payPrice}" pattern="#,###"/></span><span>원</span></div>
	</div>
</div>
<div class="buy-history-bar">
	<div class="price-wrap">
		<div>결제 내역</div>
		<div style="width:850px;">
			${vo.payMethodName}
			<c:if test="${vo.accountInfo ne ''}">
			( ${vo.accountInfo} )
			</c:if> 
			<c:if test="${vo.payPrice > 0}">
			<fmt:formatNumber value="${vo.payPrice}" pattern="#,###"/>원
			</c:if>
			<c:if test="${vo.point > 0}">
				${fn:indexOf(vo.payMethodName, "+") > 0 ? "+":""} 
				<fmt:formatNumber value="${vo.point}"/> 원
			</c:if>
		</div>
	</div>
</div>
<div class="buy-history-bar">
	<div class="price-wrap">
		<div>비교 견적</div>
		<div style="width:400px;">${vo.estimateCompareFlag eq 'Y' ? "요청":"요청 안함"}</div>
	</div>
</div>

<%-- 배송지 정보 --%>
<div class="sign-form form2" style="margin-top:80px;">
	<div class="inner">
		<div class="title-back">
			<div class="title-wrap">
				<div class="title">배송지 정보</div>
			</div>
		</div>
		<table class="table sign-table">
			<tr>
				<td>수신자명</td>
				<td>
					${vo.receiverName}
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					${vo.receiverTel}
				</td>
			</tr>
			<tr>
				<td>휴대폰번호</td>
				<td>
					${vo.receiverCell}
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
					${vo.receiverEmail}
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					${vo.receiverAddr1}, ${vo.receiverAddr2}
				</td>
			</tr>
		</table>
	</div>
</div>

<div class="title-back">
	<div class="title-wrap">
		<div class="title">전체 상품 리스트</div>
		<div class="sub-description">(${fn:length(list)})</div>
	</div>
</div>
<div class="cart-main-table">
	<table class="table">
		<colgroup>
			<col width="10%"/>
			<col width="*"/>
			<col width="10%"/>
			<col width="7%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>배송정보</td>
				<td>업체</td>
				<td>합계</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${list}" varStatus="status">
				<tr>
					<td>
						<c:if test="${item.img1 ne ''}">
							<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, '/origin/', '/s206/')}" style="width:70px;height:70px;border:1px solid #d7d7d7;" alt="" />
						</c:if>
					</td>
					<td class="text-left item-name">
						${item.itemName}<br/>
						<span class="option-name">
							<c:if test="${item.optionValue ne ''}">
								<span style="color: #6dcff6">${item.optionValue}</span>
							</c:if>
						</span>
						<br/>
					</td>
					<td>
						<span style="letter-spacing:0"><fmt:formatNumber value="${((item.sellPrice+item.optionPrice) * item.orderCnt) - item.couponPrice}" pattern="#,###" />원</span>
					</td>
					<td>
						${item.orderCnt}
					</td>
					<td>
						<c:choose>
							<c:when test="${item.deliCost eq 0}">
								무료
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${item.deliCost}" pattern="#,###" /><br/>
								<c:if test="${item.deliPrepaidFlag eq 'Y'}">
									선결제
								</c:if>
								<c:if test="${item.deliPrepaidFlag eq 'N'}">
									착불
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						${item.sellerName}
					</td>
					<td class="item-price" style="letter-spacing:0">
						<fmt:formatNumber value="${((item.sellPrice+item.optionPrice) * item.orderCnt)+item.deliCost}" pattern="#,###" />원
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="button-wrap">
	<c:if test="${vo.tid ne ''}">
		<button type="button" onclick="showReceipt('${vo.tid}')" class="btn btn-primary" style="margin-right:10px;"><span>카드 영수증</span></button>
	</c:if>
	<button class="btn btn-warning" style="margin-right:10px;" onclick="location.href='/shop/mypage/order/list'"><span>주문 상세내역 확인</span></button>
	<button class="btn btn-info" style="margin-right:10px;" onclick="location.href='/shop/main'"><span>쇼핑 계속하기</span></button>
</div>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$('.finish').find('img').attr("src", $('.finish').find('img').attr("src").replace("_off", "_on"));
		//이니시스 결제 프로세스 창 닫기
		var openwin = window.open("/pg/inicis/childwin.html","childwin","width=299,height=149");
		openwin.close();
	});
	
	var showReceipt = function(tid) {
		var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noMethod=1&noTid="+tid;
		window.open(receiptUrl,"receipt","width=430,height=700");
	};
	
</script>
</body>
</html>