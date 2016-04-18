<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>공공기관별 매출 현황  <small>주문 리스트</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>통계</li>
			<li>공공기관별 매출 현황</li>
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
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered">
							<colgroup>
								<col style="width:6%"/>
								<col style="width:7%"/>
								<col style="width:*"/>
								<col style="width:*"/>
								<col style="width:*"/>
								<col style="width:10%"/>
								<col style="width:8%"/>
								<col style="width:5%"/>
								<col style="width:*"/>
								<col style="width:4%"/>
								<col style="width:4%"/>
								<col style="width:6%"/>
								<col style="width:6%"/>
								<col style="width:4%"/>
							</colgroup>
							<thead>
								<tr>
									<th>
										결제 일자
										<div class="text-danger">취소 일자</div>
									</th>
									<th>기관 구분</th>
									<th>기관명</th>
									<th>
										부서명
										<div class="text-warning">직책</div>
									</th>
									<th>주문자</th>
									<th>
										입점업체명
										<div class="text-warning">사업자번호</div>
									</th>
									<th>인증구분</th>
									<th>상품<br/>주문번호</th>								
									<th>
										상품명
										<div class="text-warning">옵션</div>
									</th>
									<th>과/면세</th>
									<th>수량</th>
									<th>판매가</th>
									<th>공급가</th>
									<th>배송비</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="sumSellPrice" value="0"/>
							<c:set var="sumSupplyPrice" value="0"/>
							<c:set var="sumDeliCost" value="0"/>
							<c:forEach var="item" items="${list}">
								<tr ${item.c99Date ne '' ? "style=\"background-color:#ffe4e1\"":""}>
									<td class="text-center">
										${fn:substring(item.c10Date,0,10)}
										<div class="text-danger">${fn:substring(item.c99Date,0,10)}</div>
									</td>
									<td class="text-center">${item.investFlag eq 'Y' ? '투자출연기관':'공공기관'}</td>
									<td>${item.groupName}</td>
									<td>
										${item.deptName}
										<div class="text-warning">${item.posName}</div>
									</td>
									<td>${item.memberName}</td>
									<td class="text-center">
										${item.sellerName}
										<div class="text-warning">
											${fn:substring(item.bizNo,0,3)}-${fn:substring(item.bizNo,3,5)}-${fn:substring(item.bizNo,5,10)}
										</div>
									</td>
									<td>
										<c:forEach var="vo" items="${authCategoryList}">
											<c:if test="${fn:contains(item.authCategory,vo.value)}">
												<div>${vo.name}</div>
											</c:if>
										</c:forEach>
									</td>
									<td class="text-center">
										<a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}" target="_blank">${item.seq}</a>
									</td>
									<td>
										${item.itemName}
										<div class="text-warning">${item.optionValue}</div>
									</td>
									<td class="text-center">${item.taxName}</td>
									<td class="text-right">${item.orderCnt}</td>
									<td class="text-right"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.supplyPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.deliCost}"/></td>
								</tr>

								<c:set var="sumSellPrice" value="${sumSellPrice + item.sellPrice}"/>
								<c:set var="sumSupplyPrice" value="${sumSupplyPrice + item.supplyPrice}"/>
								<c:set var="sumDeliCost" value="${sumDeliCost + item.deliCost}"/>
							</c:forEach>
								<tr>
									<td class="text-right" colspan="11"><strong>합계</strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumSellPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumSupplyPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumDeliCost}"/></strong></td>
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
		location.href="/admin/stats/list/member/public/excel?searchDate1=${vo.searchDate1}&searchDate2=${vo.searchDate2}&jachiguCode=${vo.jachiguCode}";
	};
</script>
</body>
</html>