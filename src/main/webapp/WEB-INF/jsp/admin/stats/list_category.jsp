<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<!-- Morris charts -->
    <link href="/assets/admin_lte2/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
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
		<h1>상품 카테고리별 매출 현황 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>통계</li>
			<li class="active">상품 카테고리별 매출 현황</li>
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
							<div class="form-group">
								<label class="col-md-2 control-label">검색구분</label>
								<div class="radio">
									<label><input type="radio" name="searchDateType" value="day" ${vo.searchDateType eq "day" ? "checked":""}/> 일별</label>
									<label><input type="radio" name="searchDateType" value="month" ${vo.searchDateType eq "month" ? "checked":""}/> 월별</label>
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
				
				<div class="box box-info box-solid">
					<div class="box-header">
						<h3 class="box-title">매출 통계</h3>
						<div class="box-tools pull-right">
							<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
						</div>
					</div>
					<div class="box-body chart-responsive">
						<div class="chart" id="bar-chart" style="height: 300px;"></div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
				
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<!-- <div class="pull-right"></div> -->
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:5%;"/>
								<c:forEach items="${lv1CategoryList}">
								<col style="width:6%;"/>
								</c:forEach>
								<col style="width:5%;"/>
								<col style="width:5%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>결제일자</th>
									<c:forEach var="item" items="${lv1CategoryList}">
									<th>${item.name}</th>
									</c:forEach>
									<th>미지정</th>	
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
													
							<c:forEach var="item" items="${list}">
								<c:set var="sumRow" value="0"/>
								<c:set var="orgSumRow" value="0"/>
								<tr>
									<td class="text-center">
										<a href="/admin/stats/list/category/detail?payDate=${item.payDate}">${item.payDate}</a>
									</td>
									<c:forEach items="${lv1CategoryList}" varStatus="status">
										<c:set var="propName" value="sumPrice${status.index+1}"/>
										<c:set var="orgPropName" value="orgSumPrice${status.index+1}"/>
										<td class="text-right">
											<%--${propName}</br>--%>
											<%--${orgPropName}</br>--%>
											<fmt:formatNumber value="${item[propName]}"/>
											<div class="text-primary"><fmt:formatNumber value="${item[orgPropName]}"/></div>
											<c:set var="sumRow" value="${sumRow + item[propName]}"/>
											<c:set var="orgSumRow" value="${orgSumRow + item[orgPropName]}"/>
										</td>
									</c:forEach>
									<td class="text-right">
										<fmt:formatNumber value="${item.sumNull}"/>
										<div class="text-primary"><fmt:formatNumber value="${item.sumNull}"/></div>
										<c:set var="sumRow" value="${sumRow + item.sumNull}"/>
										<c:set var="orgSumRow" value="${orgSumRow + item.sumNull}"/>
									</td>
									<td class="text-right">
										<fmt:formatNumber value="${sumRow}"/>
										<div class="text-primary"><fmt:formatNumber value="${orgSumRow}"/>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="${fn:length(lv1CategoryList)+2}">조회된 데이터가 없습니다.</td></tr>
							</c:if>
							<c:set var="sumRow" value="0"/>
							<c:set var="orgSumRow" value="0"/>
								<tr>
									<td class="text-center"><strong>합계</strong></td>
									<c:forEach items="${lv1CategoryList}" varStatus="status">
										<c:set var="propName" value="sumPrice${status.index+1}"/>
										<c:set var="orgPropName" value="orgSumPrice${status.index+1}"/>
									<td class="text-right">
										<%--<span class="text-primary">--%>
											<fmt:formatNumber value="${data[propName]}"/></br>
											<div class="text-primary"><fmt:formatNumber value="${data[orgPropName]}"/></div>
										<%--</span>--%>
										<c:set var="sumRow" value="${sumRow + data[propName]}"/>
										<c:set var="orgSumRow" value="${orgSumRow + data[orgPropName]}"/>
									</td>
									</c:forEach>
									<td class="text-right">
										<span class="text-primary"><fmt:formatNumber value="${data.sumNull}"/></span>
										<c:set var="sumRow" value="${sumRow + data.sumNull}"/>
										<c:set var="orgSumRow" value="${orgSumRow + data.sumNull}"/>
									</td>
									<td class="text-right">
										<%--<span class="text-primary">--%>
										<fmt:formatNumber value="${sumRow}"/></br>
										<div class="text-primary"><fmt:formatNumber value="${orgSumRow}"/></div>
										<%--</span>--%>
									</td>
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
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="/assets/admin_lte2/plugins/morris/morris.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
		
		//BAR CHART
		setTimeout("drawChart()",500);
		
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
	
	 var drawChart = function() {
		 new Morris.Bar({
			element: 'bar-chart',
			resize: true,
			data: [
			<c:forEach var="item" items="${lv1CategoryList}" varStatus="status">
				<c:set var="propName" value="sumPrice${status.index+1}"/>
				{y: '${item.name}', a: ${data[propName]}},
			</c:forEach>
				{y: '미지정', a: ${data.sumNull}}
			],
			barColors: ['#edc240'],
			barSizeRatio: 0.4,
			xkey: 'y',
			ykeys: ['a'],
			labels: ['합계'],
			gridTextWeight: 'bold',
			xLabelMargin: 10,
			hideHover: 'auto'
     	});
	 };
</script>
</body>
</html>
