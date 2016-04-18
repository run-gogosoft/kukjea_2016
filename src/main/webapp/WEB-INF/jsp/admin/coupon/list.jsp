<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.inputLine td {
			background-color: #fff9e0 !important;
			border-top: 2px solid #999999 !important;
			border-bottom: 2px solid #999999 !important;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="main">
	<div class="container">
		<div class="row">
			<div class="span12">
				<%--리스트--%>
				<div class="widget widget-table stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>${title}</h3>
					</div>
					<div class="widget-content">
						<table class="table table-striped table-bordered table-list">
							<caption>${title}</caption>
							<colgroup>
								<col style="width:3%;"/>
								<col style="width:20%;"/>
								<col style="width:5%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:8%;"/>
								<col style="width:14%;"/>
								<col style="width:8%;"/>
								<col style="width:7%;"/>
								<col style="width:7%;"/>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<col style="width:8%;"/>
								</c:if>
							</colgroup>
							<thead>
							<tr>
								<th>SEQ</th>
								<th>쿠폰 이름</th>
								<th>쿠폰 상태</th>
								<th>쿠폰 종류</th>
								<th>할인금액</th>
								<th>유효기간</th>
								<th>허용 판매가</th>
								<th>허용 상품</th>
								<th>카테고리</th>
								<th>생성일</th>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<th></th>
								</c:if>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.couponSeq}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5)}">
												<a href="/admin/item/coupon/issue/reg/form/${item.couponSeq}">${item.couponName}</a>
											</c:when>
											<c:otherwise>
												${item.couponName}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${item.couponStatusCodeAlias}</td>
									<td class="text-center">${item.couponTypeCodeAlias}</td>
									<td class="text-center"><fmt:formatNumber value="${item.discountValue}" pattern="#,###" /></td>
									<td class="text-center">${item.startDate} ~ ${item.endDate}</td>
									<td class="text-center">
										<c:if test="${item.limitMinValue ne null}">
											<fmt:formatNumber value="${item.limitMinValue}" pattern="#,###" />원 ~
										</c:if>
										<c:if test="${item.limitMaxValue ne null}">
											<fmt:formatNumber value="${item.limitMaxValue}" pattern="#,###" />원
										</c:if>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.limitItemCnt eq 0}">
												허용상품없음
											</c:when>
											<c:otherwise>
												${item.limitItemCnt}개
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.categorySeq eq '0'}">
												전체
											</c:when>
											<c:otherwise>
												${item.categoryName}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
										<td class="text-center">
											<a href="/admin/item/coupon/mod/form/${item.couponSeq}" class="btn btn-info btn-mini">수정</a>
											<a href="/admin/item/coupon/del/${item.couponSeq}" class="btn btn-warning btn-mini">삭제</a>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(list) eq 0}">
								<tr>
									<td colspan="11" class="text-center muted" style="padding:30px">
										등록된 내용이 없습니다
									</td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
				<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
					<div class="pull-right">
						<a href="/admin/item/coupon/reg/form" class="btn btn-info">쿠폰 등록</a>
					</div>
				</c:if>
				<div class="pagination alternate">${paging}</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};
</script>
</body>
</html>
