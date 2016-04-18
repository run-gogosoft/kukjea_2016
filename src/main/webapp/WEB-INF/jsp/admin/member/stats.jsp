<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<!-- Morris charts -->
    <link href="/assets/admin_lte2/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>회원 현황 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li class="active">회원 현황</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table class="table table-bordered">
							<colgroup>
								<col style="width:12%;" />
								<col style="width:22%;" />
								<col style="width:22%;" />
								<col style="width:22%;" />
								<col style="width:22%;" />
							</colgroup>
							<thead>
							<tr>
								<th>전체회원수</th>
								<th>신규가입<br />(금일)</th>
								<th>신규가입<br />(금주)</th>
								<th>신규가입<br />(금월)</th>
								<th>누적탈퇴<br />회원수</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-right"><fmt:formatNumber value="${vo.totalCnt}" type="number" /></td>
									<td class="text-right"><fmt:formatNumber value="${vo.todayJoinCnt}" type="number" /></td>
									<td class="text-right"><fmt:formatNumber value="${vo.weekJoinCnt}" type="number" /></td>
									<td class="text-right"><fmt:formatNumber value="${vo.monthJoinCnt}" type="number" /></td>
									<td class="text-right"><fmt:formatNumber value="${vo.quitCnt}" type="number" /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<!-- AREA CHART -->
				<div class="box box-primary">
					<div class="box-header with-border">
						<span id="monthTitle" style="margin:0 10px"></span><h3 class="box-title">한달간 전체 회원 현황 추이</h3>
						<div class="box-tools pull-right">
							<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
						</div>
					</div>
					<div class="box-body chart-responsive">
						<div class="chart" id="revenue-chart" style="height: 300px;"></div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col (LEFT) -->
			<div class="col-md-6">
				<!-- LINE CHART -->
				<div class="box box-info">
					<div class="box-header with-border">
						<span id="weekTitle" style="margin:0 10px"></span><h3 class="box-title">일주일간 신규 가입회원 현황 추이</h3>
						<div class="box-tools pull-right">
							<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
						</div>
					</div>
					<div class="box-body chart-responsive">
						<div class="chart" id="line-chart" style="height: 300px;"></div>
					</div><!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col (RIGHT) -->
		</div><!-- /.row -->
	</section>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/plugins/flot/jquery.flot.js"></script>
<script src="/assets/js/plugins/flot/jquery.flot.pie.js"></script>
<script src="/assets/js/plugins/flot/jquery.flot.orderBars.js"></script>
<script src="/assets/js/plugins/flot/jquery.flot.resize.js"></script>
<script src="/assets/js/Application.js"></script>
<script src="/assets/js/charts/modernizr.js"></script>
 <!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="/assets/admin_lte2/plugins/morris/morris.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var drawMonthMemberStats = function() {
		$.get("/admin/member/chartstats/month/json", function(datas){
			var list = $.parseJSON(datas);
			var period=0;

			//년,월
			var tmpPeriod1 = list[30].period.substr(0,4);
			var tmpPeriod2 = list[30].period.substr(5,2);
			period = tmpPeriod1+"-"+tmpPeriod2;

			$("#monthTitle").html(period+"월 기준");
			var area = new Morris.Area({
        element: 'revenue-chart',
        resize: true,
        data: list,
        xkey: 'period',
        ykeys: ['memberCount'],
        labels: ['회원수'],
        lineColors: ['#a0d0e0'],
        hideHover: 'auto'
      });
		});
	};
	var drawWeekMemberStats = function() {
		$.get("/admin/member/chartstats/week/json", function(datas){
			var list = $.parseJSON(datas);
			var period=0;
			//년,월
			var tmpPeriod1 = list[6].period.substr(0,4);
			var tmpPeriod2 = list[6].period.substr(5,2);
			period = tmpPeriod1+"-"+tmpPeriod2;

			$("#weekTitle").html(period+"월 기준");
			var line = new Morris.Line({
        element: 'line-chart',
        resize: true,
        data: list,
        xkey: 'period',
        ykeys: ['memberCount'],
        labels: ['회원수'],
        lineColors: ['#3c8dbc'],
        hideHover: 'auto'
      });
		});
	};

	$(document).ready(function(){
		drawMonthMemberStats();
		drawWeekMemberStats();
	});
</script>
</body>
</html>
