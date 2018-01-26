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
		<h1>기간별 상품 판매 현황 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>통계</li>
			<li class="active">기관별 상품 판매 현황</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<form  class="form-horizontal" id="searchForm">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">결제일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${vo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${vo.searchDate2}">
									</div>
								</div>
								<div class="col-md-3 form-control-static">
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전체</button>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${fn:length(list)}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<!-- <button type="button" id="excelDownBtn" onclick="CHExcelDownload.excelDown();" class="btn btn-success btn-sm">엑셀다운</button> -->
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<c:set var="profit" value="0"/>
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<!-- <div class="pull-right"></div> -->
					</div>
					<!-- 합계 -->
					<div class="box-body">

						<table id="sumlist" class="table table-bordered" ">
							<colgroup>
								<col style="width:150px"/>
								<col style="width:150px"/>
								<col style="width:150px"/>
								<col style="width:150px"/>
								<col style="width:150px"/>
							</colgroup>
							<thead>
								<tr>
									<th>구분</th>
									<th>판매가합</th>
									<th>판매원가합</th>
									<th>이익금</th>
									<th>이익률(%)</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">정상주문</td>
									<td class="text-right"><fmt:formatNumber value="${itemSum.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${itemSum.orgPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${itemSum.sumPrice-itemSum.orgPrice}"/></td>
									<c:set var="profit" value="${itemSum.sumPrice-itemSum.orgPrice}"/>
									<td class="text-right"><fmt:formatNumber value="${profit/itemSum.sumPrice*100}"/></td>
								</tr>
								<tr>
									<td class="text-center">취소주문</td>
									<td class="text-right"><fmt:formatNumber value="${itemCancelSum.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${itemCancelSum.orgPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${itemCancelSum.sumPrice-itemCancelSum.orgPrice}"/></td>
									<c:set var="profit" value="${itemCancelSum.sumPrice-itemCancelSum.orgPrice}"/>
									<td class="text-right"><fmt:formatNumber value="${profit/itemCancelSum.sumPrice*100}"/></td>
								</tr>
								<tr>
									<td class="text-center">합계</td>
									<td class="text-right"><fmt:formatNumber value="${itemSum.sumPrice-itemCancelSum.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${itemSum.orgPrice-itemCancelSum.orgPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${(itemSum.sumPrice-itemCancelSum.sumPrice)-(itemSum.orgPrice-itemCancelSum.orgPrice)}"/></td>
									<c:set var="profit" value="${(itemSum.sumPrice-itemCancelSum.sumPrice)-(itemSum.orgPrice-itemCancelSum.orgPrice)}"/>
									<td class="text-right"><fmt:formatNumber value="${profit/(itemSum.sumPrice-itemCancelSum.sumPrice)*100}"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:*;"/>
								<col style="width:*;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>상품명</th>
									<th>규격</th>
									<th>판매 수량</th>
									<th>판매 금액</th>
									<th>판매원가합</th>
									<th>이익금</th>
									<th>이익률(%)</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td class="text-center">${status.index + 1}</td>
									<td>${item.itemName}</td>
									<td>${item.type1}
										<c:if test="${item.type2 ne ''}">,${item.type2}</c:if>
										<c:if test="${item.type3 ne ''}">,${item.type3}</c:if>
									</td>
									<td class="text-right"><fmt:formatNumber value="${item.orderCnt}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.orgPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.sumPrice-item.orgPrice}"/></td>
									<c:set var="profit" value="${item.sumPrice-item.orgPrice}"/>
									<td class="text-right"><fmt:formatNumber value="${profit/item.sumPrice*100}"/></td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="5">조회된 데이터가 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<%-- <div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div> --%>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
	});

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	/** 날짜 계산 */
	var calcDate = function(days) {
		if(days === "clear") {
			$("#searchDate1").val( '2014-01-01' );
			$("#searchDate2").val( moment().format("YYYY-MM-DD"));
		} else {
			$("#searchDate1").val( moment().subtract('days', parseInt(days,10)).format("YYYY-MM-DD") );
			$("#searchDate2").val( moment().format("YYYY-MM-DD"));
		}
	};

	var CHExcelDownload = {
		excelDown:function() {
			$("#searchForm").attr("action", "/admin/seller/list/download/excel");
			$("#searchForm").submit();
			$("#searchForm").attr("action",location.pathname);
		}
	};
</script>
</body>
</html>
