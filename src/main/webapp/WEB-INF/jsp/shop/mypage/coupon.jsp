<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/jw.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/coupon.css" type="text/css" rel="stylesheet">
</head>
<body>
<a class="sr-only" href="#content">Skip navigation</a>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<div class="eb-container" >
	<div class="jw-location">
		<div class="eb-container" style="margin-top:0;margin-bottom:0">
			<div class="eb-breadcrumb">
				<span class="">Home &gt; 마이페이지 &gt; 쿠폰</span>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>
	<div class="jw-content-wrap-mypage">
		<div class="jw-coupon">
			<div class="jw-coupon-box1">
				<p class="jw-coupon-box1-p">${availableCouponCount}</p>
			</div>
			<div class="jw-coupon-box2">
				<ul class="nav nav-tabs">
					<li <c:if test="${param.issueStatusCode eq 'Y'}">class="active"</c:if>><a href="coupon?issueStatusCode=Y">사용 가능 쿠폰</a></li>
					<li <c:if test="${param.issueStatusCode eq 'N'}">class="active"</c:if>><a href="coupon?issueStatusCode=N">사용한 쿠폰</a></li>
				</ul>
				<div class="jw-coupon-box3">
					<table class="table" style="table-layout:fixed">
						<colgroup>
							<col width="10%" />
							<col width="40%" />
							<col width="20%" />
							<col width="30%" />
						</colgroup>
						<thead>
							<tr class="active">
								<th></th>
								<th>쿠폰 이름</th>
								<th>할인금액</th>
								<th>
									<c:if test="${param.issueStatusCode eq 'Y'}">사용 가능 기간</c:if>
									<c:if test="${param.issueStatusCode eq 'N'}">쿠폰 만료일</c:if>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${list}">
							<tr>
								<td class="td-center">${total-item.rowNumber+1}</td>
								<td style="padding-left:20px">${item.couponName}</td>
								<td class="td-center">
									할인
									<c:if test="${item.couponTypeCode eq 'W'}">${item.discountValue}원</c:if>
									<c:if test="${item.couponTypeCode eq 'P'}">${item.discountValue}%</c:if>
								</td>
								<td class="td-center">
									${item.startDate} - ${item.endDate}
								</td>
							</tr>
							</c:forEach>
							<c:if test="${fn:length(list) eq 0}">
								<tr>
									<td colspan="4" style="padding:50px" class="text-center muted">
										등록된 내용이 없습니다.
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div id="paging" class="td-center">${paging}</div>
			</div>
		</div>
	</div>
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	$(document).ready(function(){
		$("#paging>ul").addClass("ch-pagination");
	});
</script>
</body>
</html>
