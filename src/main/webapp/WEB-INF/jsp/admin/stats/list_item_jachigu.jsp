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
		<h1>공급사 판매 현황 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>통계</li>
			<li class="active">공급사 판매 현황</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<form  class="form-horizontal" id="searchForm">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">검색일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${vo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${vo.searchDate2}">
									</div>
								</div>
								<div class="col-md-6 form-control-static">
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
							<div class="pull-right">
								<!-- <button type="button" id="excelDownBtn" onclick="CHExcelDownload.excelDown();" class="btn btn-success btn-sm">엑셀다운</button> -->
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>

<%--<c:forEach var="list" items="${lists}" varStatus="listStatus">--%>
	<%--<c:if test="${listStatus.index == 0 or (listStatus.index+1) % 2== 1}">--%>
		<div class="row">
	<%--</c:if>--%>
			<div class="col-md-12">
				<div class="box box-warning box-solid">
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:*;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>공급사명</th>
									<th>판매몰</th>
									<th>주문횟수</th>
									<th>매출금액 <br/>(${vo.searchDate1} - ${vo.searchDate2})</th>
									<th>배송비계</th>
									<th>매출원가</th>
									<th>실배송비</th>
									<th>이익금</th>
									<th>이익률(%)</th>
									<th>수수료 %</th>
									<th>수수료 금액</th>
								</tr>
							</thead>
							<tbody>

							<c:forEach var="list" items="${lists}" varStatus="listStatus">
								<c:set var="profit" value="${list.sumPrice-list.orgPrice+list.deliCost-list.totalDeliCost}" />
									<tr>
										<td class="text-center"><strong class="text-primary">${list.sellerName}</strong></td>
										<td>${list.mallName}</td>
										<td class="text-center" >${list.orderCnt}</td>
										<td class="text-right"><fmt:formatNumber value="${list.sumPrice}"/>원</td>
										<td class="text-right"><fmt:formatNumber value="${list.deliCost}"/>원</td>
										<td class="text-right"><fmt:formatNumber value="${list.orgPrice}"/>원</td>
										<td class="text-right"><fmt:formatNumber value="${list.totalDeliCost}"/>원</td>
										<td><fmt:formatNumber value="${profit}"/>원</td>
										<td class="text-right"><fmt:formatNumber value="${profit*100/list.sumPrice}"/>%</td>
										<td class="text-center"><fmt:formatNumber value="${list.masterCommission}"/>%</td>
										<td class="text-right"><fmt:formatNumber value="${profit * list.masterCommission / 100}" pattern="#,###"/>원</td>
									</tr>
									<tr>
										<td class="text-center" ></td>
										<td>약국몰</td>
										<td class="text-center" >0</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>%</td>
										<td class="text-center"><fmt:formatNumber value="${list.masterCommission}"/>%</td>
										<td class="text-right"><fmt:formatNumber value="${list.sumPrice * list.masterCommission / 100}" pattern="#,###"/>원</td>
									</tr>
									<tr>
										<td class="text-center" ></td>
										<td>B2B몰</td>
										<td class="text-center" >0</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>원</td>
										<td class="text-right"><fmt:formatNumber value="0"/>%</td>
										<td class="text-center"><fmt:formatNumber value="${list.masterCommission}"/>%</td>
										<td class="text-right"><fmt:formatNumber value="${list.sumPrice * list.masterCommission / 100}" pattern="#,###"/>원</td>
									</tr>
								<tr>
									<td class="text-center" ></td>
									<td><strong class="text-primary">계</strong></td>
									<td class="text-center" ><strong class="text-primary">${list.orderCnt}</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${list.sumPrice}"/>원</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${list.deliCost}"/>원</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${list.orgPrice}"/>원</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${list.totalDeliCost}"/>원</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${profit}"/>원</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${profit*100/list.sumPrice}"/>%</strong></td>
									<td class="text-center"><strong class="text-primary"><fmt:formatNumber value="${list.masterCommission}"/>%</strong></td>
									<td class="text-right"><strong class="text-primary"><fmt:formatNumber value="${profit * list.masterCommission / 100}" pattern="#,###"/>원</strong></td>
								</tr>
							</c:forEach>

							<c:if test="${ fn:length(lists)==0 }">
								<tr><td class="text-center" colspan="4">조회된 데이터가 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<%-- <div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div> --%>
					</div>
				</div>
			</div>

	<%--<c:if test="${listStatus.index > 0 and (listStatus.index+1) % 4 == 0}">--%>
		</div>
	<%--</c:if>--%>
<%--</c:forEach>--%>

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
