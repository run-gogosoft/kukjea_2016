<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<c:choose>
	<c:when test="${sessionScope.loginType eq 'S'}">
		<body class="skin-green sidebar-mini">
	</c:when>
	<c:otherwise>
		<body class="skin-blue sidebar-mini">
	</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>${title}  <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>판매 관리</li>
			<li class="active">${title}</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<!--검색 영역-->
				<%@ include file="/WEB-INF/jsp/admin/include/order_search_form.jsp" %>
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<form id="modForm" method="post" target="zeroframe">
							<input type="hidden" id="updateStatusCode" name="updateStatusCode" value=""/>
							<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>상품<br/>주문번호</th>
									<th>주문번호</th>
									<th>주문상태</th>
									<th>상품명</th>
									<th>
										판매단가
										<div style="margin-top:5px;color:#6495ed">공급단가</div>
									</th>
									<th>수량</th>
									<th>배송비</th>
									<th>주문자<div style="margin-top:5px;color:#6495ed">수령자</div></th>
									<th>입점업체명</th>
									<th>
										주문일자<br/>
										<c:choose>
											<c:when test="${cs eq 'cancel'}">
												취소요청<br/>
												취소완료
											</c:when>
											<c:when test="${cs eq 'exchange'}">
												교환요청<br/>
												교환완료
											</c:when>
											<c:when test="${cs eq 'return'}">
												반품요청<br/>
												반품완료
											</c:when>
										</c:choose>
									</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
												<a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}">${item.seq}</a>
											</c:when>
											<c:otherwise>
												${item.seq}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-center"><strong>${item.statusText}</strong></td>
									<td>
										<p style="margin-bottom:3px;">
											상품번호 : <a href="/admin/item/view/${item.itemSeq}" target="_blank"><strong>${item.itemSeq}</strong></a><br/>
											<c:if test="${item.sellerItemCode ne ''}">업체상품번호 : <span style="color:#fd9f1a;"><strong>${item.sellerItemCode}</strong></span></c:if>
										</p>
											${item.itemName}
									</td>
									<td class="text-right">
										<fmt:formatNumber value="${item.sellPrice}"/>
										<div style="margin-top:5px;color:#6495ed"><fmt:formatNumber value="${item.orgPrice}"/></div>
									</td>
									<td class="text-right">${item.orderCnt}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.freeDeli eq 'Y'}">
												무료
											</c:when>
											<c:otherwise>
												<fmt:formatNumber value="${item.deliCost}" pattern="#,###" />
												<br/>
												<%--<c:when test="${item.deliPrepaidFlag eq 'N'}">--%>
													<%--착불--%>
												<%--</c:when>--%>
												<%--<c:otherwise>--%>
													선결제
												<%--</c:otherwise>--%>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
											${item.memberName}
										<div style="margin-top:5px;color:#6495ed">${item.receiverName}</div>
									</td>
									<td class="text-center">${item.sellerName}</td>
									<td class="text-center">
										${fn:substring(item.regDate,0,10)}<br/>
									<c:choose>
										<c:when test="${cs eq 'cancel'}">
											<c:if test="${item.c90Date ne ''}">
												${fn:substring(item.c90Date,0,10)}<br/>
											</c:if>
											<c:if test="${item.c99Date ne ''}">
												${fn:substring(item.c99Date,0,10)}
											</c:if>
										</c:when>
										<c:when test="${cs eq 'exchange'}">
											<c:if test="${item.c60Date ne ''}">
												${fn:substring(item.c60Date,0,10)}<br/>
											</c:if>
											<c:if test="${item.c69Date ne ''}">
												${fn:substring(item.c69Date,0,10)}
											</c:if>
										</c:when>
										<c:when test="${cs eq 'return'}">
											<c:if test="${item.c70Date ne ''}">
												${fn:substring(item.c70Date,0,10)}<br/>
											</c:if>
											<c:if test="${item.c79Date ne ''}">
												${fn:substring(item.c79Date,0,10)}
											</c:if>
										</c:when>
									</c:choose>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="11">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						</form>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	/** 페이지 로딩시 초기화 */
	$(document).ready(function () {
		/* 날짜 검색 달력 기능 */
		showDatepicker("yy-mm-dd");
	});


	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};
		
	var calcDate = function(val) {
		if(val === "clear") {
			$("input[name=searchDate1]").val( '2014-01-01' );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};

</script>
</body>
</html>
