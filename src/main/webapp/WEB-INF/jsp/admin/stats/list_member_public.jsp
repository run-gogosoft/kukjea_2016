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
		<h1>공공기관별 매출 현황 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>통계</li>
			<li class="active">공공기관별 매출 현황</li>
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
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<!-- <div class="pull-right"></div> -->
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped" style="width:50%;">
							<colgroup>
								<col style="width:*;"/>
								<col style="width:25%;"/>
								<col style="width:25%;"/>
								<col style="width:25%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>자치구</th>
									<th>투자출연기관</th>
									<th>공공기관</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="totalInvestSumPrice" value="0"/>
							<c:set var="totalSumPrice" value="0"/>
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td class="text-center">
										<a href="/admin/stats/list/member/public/detail?searchDate1=${vo.searchDate1}&searchDate2=${vo.searchDate2}&jachiguCode=${item.jachiguCode}">
											${item.jachiguName}
										</a>
									</td>
									<td class="text-right"><fmt:formatNumber value="${item.investSumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.sumPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.investSumPrice+item.sumPrice}"/></td>
								</tr>
								<c:set var="totalInvestSumPrice" value="${totalInvestSumPrice + item.investSumPrice}"/>
								<c:set var="totalSumPrice" value="${totalSumPrice + item.sumPrice}"/>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="3">조회된 데이터가 없습니다.</td></tr>
							</c:if>
								<tr>
									<td class="text-center"><strong>합계</strong></td>
									<td class="text-right"><span class="text-primary"><fmt:formatNumber value="${totalInvestSumPrice}"/></span></td>
									<td class="text-right"><span class="text-primary"><fmt:formatNumber value="${totalSumPrice}"/></span></td>
									<td class="text-right"><span class="text-primary"><fmt:formatNumber value="${totalInvestSumPrice+totalSumPrice}"/></span></td>
								</tr>
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
</script>
</body>
</html>
