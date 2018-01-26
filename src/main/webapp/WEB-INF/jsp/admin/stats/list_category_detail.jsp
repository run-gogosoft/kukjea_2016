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
		<h1>상품 카테고리별 매출 현황 <small>주문 리스트</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>통계</li>
			<li>상품 카테고리별 매출 현황</li>
			<li class="active">주문 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<div class="pull-left">
							총  <b style="color:#00acd6;"><fmt:formatNumber value="${fn:length(list)}"/></b> 건이 조회되었습니다.
						</div>
						<div class="pull-right">
							<button type="button" onclick="downloadExcel();" class="btn btn-success btn-sm">엑셀다운</button>
							<button onclick="history.go(-1)" class="btn btn-default btn-sm">목록보기</button>
						</div>
					</div>
					<!-- 합계 -->
					<div class="box-body">
						<table id="sumlist" class="table table-bordered" >
							<colgroup>
								<col style="width:150px"/>
								<col style="width:150px"/>
								<col style="width:150px"/>
								<%--<col style="width:150px"/>--%>
							</colgroup>
							<thead>
								<tr>
									<th>구분</th>
									<th>판매가합</th>
									<th>공급가합</th>
									<%--<th>배송비합계</th>--%>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">정상주문</td>
									<td class="text-right"><fmt:formatNumber value="${orderSum.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${orderSum.supplyPrice}"/></td>
									<%--<td class="text-right"><fmt:formatNumber value="${orderSum.deliCost}"/></td>--%>
								</tr>
								<tr>
									<td class="text-center">취소주문</td>
									<td class="text-right"><fmt:formatNumber value="${orderCancelSum.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${orderCancelSum.supplyPrice}"/></td>
									<%--<td class="text-right"><fmt:formatNumber value="${orderCancelSum.deliCost}"/></td>--%>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered">
							<colgroup>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<col style="width:"/>
								<%--<col style="width:"/>--%>
							</colgroup>
							<thead>
								<tr>
									<th>
										결제 일자
										<div class="text-danger">취소 일자</div>
									</th>
									<th>기관 구분</th>
									<th>공급자</th>
									<th>
										부서명
										<div class="text-warning">직책</div>
									</th>
									<th>주문자</th>
									<th>상품<br/>주문번호</th>
									<th>카테고리</th>
									<th>
										상품명
										<div class="text-warning">옵션</div>
									</th>
									<th>과/면세</th>
									<th>수량</th>
									<th>판매가</th>
									<th>공급가</th>
									<%--<th>배송비</th>--%>
								</tr>
							</thead>
							<tbody>
							<c:set var="sumSellPrice" value="0"/>
							<c:set var="sumSupplyPrice" value="0"/>
							<%--<c:set var="sumDeliCost" value="0"/>--%>
							<c:forEach var="item" items="${list}">
								<tr ${item.c99Date ne '' ? "style=\"background-color:#ffe4e1\"":""}>
									<td class="text-center">
										${fn:substring(item.c10Date,0,10)}
										<div class="text-danger">${fn:substring(item.c99Date,0,10)}</div>
									</td>
									<td class="text-center">${item.investFlag eq 'Y' ? '투자출연기관':'공공기관'}</td>
									<td>${item.optionValue}</td>
									<td>
										${item.deptName}
										<div class="text-warning">${item.posName}</div>
									</td>
									<td>${item.memberName}</td>
									<td class="text-center">
										<a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}" target="_blank">${item.seq}</a>
									</td>
									<td>
										<c:if test="${item.cateLv1Name ne null and item.cateLv1Name ne ''}">${item.cateLv1Name}</c:if>
										<c:if test="${item.cateLv2Name ne null and item.cateLv2Name ne ''}"><br/>${item.cateLv2Name}</c:if>
										<c:if test="${item.cateLv3Name ne null and item.cateLv3Name ne ''}"><br/>${item.cateLv3Name}</c:if>
										<c:if test="${item.cateLv4Name ne null and item.cateLv4Name ne ''}"><br/>${item.cateLv4Name}</c:if>
									</td>
									<td>
										${item.itemName}
										<div class="text-warning">${item.optionValue}</div>
									</td>
									<td class="text-center">${item.taxName}</td>
									<td class="text-right">${item.orderCnt}</td>
									<td class="text-right"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.supplyPrice}"/></td>
									<%--<td class="text-right"><fmt:formatNumber value="${item.deliCost}"/></td>--%>
								</tr>

								<c:set var="sumSellPrice" value="${sumSellPrice + item.sellPrice}"/>
								<c:set var="sumSupplyPrice" value="${sumSupplyPrice + item.supplyPrice}"/>
								<%--<c:set var="sumDeliCost" value="${sumDeliCost + item.deliCost}"/>--%>
							</c:forEach>
								<tr>
									<td class="text-right" colspan="10"><strong>합계</strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumSellPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumSupplyPrice}"/></strong></td>
									<%--<td class="text-right"><strong><fmt:formatNumber value="${sumDeliCost}"/></strong></td>--%>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	/** 엑셀 다운로드 */
	var downloadExcel = function() {
		location.href="/admin/stats/list/category/excel?payDate=${vo.payDate}";
	};
</script>
</body>
</html>