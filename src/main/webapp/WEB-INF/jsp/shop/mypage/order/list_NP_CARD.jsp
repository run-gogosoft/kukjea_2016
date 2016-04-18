<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/mypage/order_paymethod.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="body-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>

	<div class="main-content-wrap">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 구매정보 <span class="breadcrumb-arrow">&gt;</span> <strong>후청구(신용카드 결제)</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 최근 결제 요청하신 내역 입니다.</div>

		<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>

		<div class="main-table">
			<table class="table">
				<colgroup>
					<col style="width:7%"/>
					<col style="width:*"/>
					<col style="width:8%"/>
					<col style="width:7%"/>
					<col style="width:8%"/>
					<col style="width:9%"/>
					<col style="width:11%"/>
					<col style="width:9%"/>
					<col style="width:10%"/>
				</colgroup>
				<thead>
					<tr>
						<td>주문번호</td>
						<td>상품명</td>
						<td>판매가</td>
						<td>수량</td>
						<td>배송비</td>
						<td>주문상태</td>
						<td>
							합계금액
							<div class="text-info">결제(예정) 금액</div>
						</td>
						<td>입금상태</td>
						<td>
							주문일자
							<div class="text-info">완료일자</div>
						</td>
					</tr>
				</thead>
				<tbody id="order-list">
				<c:forEach var="item" items="${list}">
					<tr>
						<td class="text-center" data-order-seq="${item.orderSeq}">
							<a href="/shop/mypage/order/detail/${item.orderSeq}" target="_blank"><strong>${item.orderSeq}</strong></a>
						</td>
						<td class="text-center">
							${item.itemName}
							<c:if test="${item.optionValue ne ''}">
								(${item.optionValue})
							</c:if>
						</td>
						<td class="text-center"><fmt:formatNumber value="${item.sellPrice+item.optionPrice}"/></td>
						<td class="text-center"><fmt:formatNumber value="${item.orderCnt}"/></td>
						<td class="text-center"><fmt:formatNumber value="${item.deliCost}"/></td>
						<td class="text-center">${item.statusCode eq "10" ? "접수완료" : item.statusText}</td>
						<td class="text-center" data-total-price="${item.orderSeq}">
							<strong><fmt:formatNumber value="${item.totalPrice}"/></strong>
							<c:if test="${item.payPrice > 0}">
							<div class="text-info"><strong><fmt:formatNumber value="${item.payPrice}"/></strong></div>
							</c:if>
						</td>
						<td class="text-center" data-np-pay-flag="${item.orderSeq}">
						<c:choose>
							<c:when test="${item.npPayFlag eq 'Y'}">
								<strong class="text-info">입금완료</strong>
							</c:when>
							<c:otherwise>
								<c:if test="${item.payPrice > 0}">
								<strong class='text-danger'>입금대기</strong>
								<p><a href="/shop/order/start/${item.orderSeq}" target="zeroframe" class="btn btn-default btn-xs btn-etc btn-confirm">결제</a></p>
								</c:if>
								<c:if test="${item.payPrice == 0}">
								<strong class='text-danger'>입금대기중 취소</strong>
								</c:if>
							</c:otherwise>
						</c:choose>
						</td>																	
						<td class="text-center" data-np-date="${item.orderSeq}">
							<strong>${fn:substring(item.regDate,0,10)}</strong>
							<div class="text-info"><strong>${fn:substring(item.npPayDate,0,10)}</strong></div>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(list) == 0}">
					<tr><td colspan="13" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
				</c:if>
				</tbody>
			</table>
		</div>

		<div id="paging" class="pull-right">
			${paging}
		</div>
		<div class="pull-right total-count-title">
			고객님은 현재 총 <span><fmt:formatNumber value="${pvo.totalRowCount}"/></span>건의 내역이 있습니다.
		</div>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//주문번호 별로 묶기
		<c:forEach var="item" items="${list}">
		mergeByOrderSeq('${item.orderSeq}');
		</c:forEach>
	});
	
	var callbackProc = function(arg) {
		//이니시스 결제 프로세스 창 닫기
		var openwin = window.open("/pg/inicis/childwin.html","childwin","width=299,height=149");
		openwin.close();
	}
	
	//주문번호 별로 묶기
	var mergeByOrderSeq = function(orderSeq) {
		var obj = "#order-list td[data-order-seq='"+orderSeq+"']";
		if( $(obj).size() >= 2 ) {
			$(obj).each(function(idx) {
				if(idx === 0) {
					$(this).attr("rowspan", $(obj).size());
				} else {
					$(this).remove();
				}
			});
		}
		
		obj = "#order-list td[data-total-price='"+orderSeq+"']";
		if( $(obj).size() >= 2 ) {
			$(obj).each(function(idx) {
				if(idx === 0) {
					$(this).attr("rowspan", $(obj).size());
				} else {
					$(this).remove();
				}
			});
		}
		
		obj = "#order-list td[data-np-pay-flag='"+orderSeq+"']";
		if( $(obj).size() >= 2 ) {
			$(obj).each(function(idx) {
				if(idx === 0) {
					$(this).attr("rowspan", $(obj).size());
				} else {
					$(this).remove();
				}
			});
		}
		
		obj = "#order-list td[data-np-date='"+orderSeq+"']";
		if( $(obj).size() >= 2 ) {
			$(obj).each(function(idx) {
				if(idx === 0) {
					$(this).attr("rowspan", $(obj).size());
				} else {
					$(this).remove();
				}
			});
		}
	}
	
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
	};
	
</script>
</body>
</html>