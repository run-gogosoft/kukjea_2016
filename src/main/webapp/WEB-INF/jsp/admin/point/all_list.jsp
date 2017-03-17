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
		<h1>포인트 상세 내역 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li class="active">포인트 상세 내역</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<form id="searchForm" method="get" class="form-horizontal" action="/admin/point/all/list">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label" for="searchDate1">발생 일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${vo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${vo.searchDate2}">
									</div>
								</div>
								<div class="col-md-3" style="padding-top: 10px;">
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전체</button>
								</div>
							</div>
							<div class="form-group" ${fn:length(mallList) <= 1 ? "style='display:none'":""}>
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2">
									<select class="form-control" name="mallSeq">
										<option value="">---쇼핑몰 선택---</option>
										<c:forEach var="item" items="${mallList}">
											<option value="${item.seq}" <c:if test="${item.seq eq vo.mallSeq}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상태</label>
								<div class="col-md-2">
									<select class="form-control" name="statusCode">
										<option value="">---상태 선택---</option>
										<option value="S" <c:if test="${vo.statusCode eq 'S'}">selected</c:if>>적립</option>
										<option value="U" <c:if test="${vo.statusCode eq 'U'}">selected</c:if>>사용</option>
										<option value="D" <c:if test="${vo.statusCode eq 'D'}">selected</c:if>>소멸</option>
										<option value="C" <c:if test="${vo.statusCode eq 'C'}">selected</c:if>>취소적립</option>
									</select>
								</div>
								<label class="col-md-2 control-label" for="name">회원명</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="name" name="name" value="${vo.name}" maxlength="20" />
								</div>
							</div>
						</div>

						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${vo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" onclick="downloadExcel();" class="btn btn-info btn-sm">엑셀다운</button>
							</div>
						</div>
					</form>
				</div>

				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Seq</th>
									<th>발생일</th>
									<th>포인트</th>
									<th>아이디</th>
									<th>회원명</th>
									<th ${fn:length(mallList) <= 1 ? "style='display:none'":"" }>쇼핑몰</th>
									<th>상태</th>
									<th>주문번호</th>
									<th>상품주문번호</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${listPoint}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
									<td class="text-center">
										<fmt:formatNumber value="${item.point}" pattern="#,###" /> P
									</td>
									<td class="text-center">
										<a href="/admin/member/view/${item.memberSeq}">${item.id}</a>
									</td>
									<td class="text-center">${item.name}</td>
									<td class="text-center" ${fn:length(mallList) <= 1 ? "style='display:none'":"" }>${item.mallName}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.statusCode eq 'S'}">적립</c:when>
											<c:when test="${item.statusCode eq 'U'}">사용</c:when>
											<c:when test="${item.statusCode eq 'D'}">소멸</c:when>
											<c:when test="${item.statusCode eq 'C'}">취소적립</c:when>
										</c:choose>
									</td>
									<td class="text-center">
										<a href="/admin/order/list?searchOrder=orderSeq&orderSeq=${item.orderSeq}">${item.orderSeq}</a>
									</td>
									<td class="text-center">
										<a href="/admin/order/view/${item.orderSeq}?seq=${item.orderDetailSeq}">${item.orderDetailSeq}</a>
									</td>
									<td class="text-center">${item.note}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showDatepicker("yy-mm-dd");
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

	var searchProc = function searchProc(obj) {
		$(obj).parent().parent().next().val($(obj).attr("data-value"));
		$(obj).parent().parent().prev().prev().text($(obj).text());

		if ($(obj).attr("data-submit") === "true") {
			alert($("#search").val($(obj).attr("data-value")));
			$("#search").val($(obj).attr("data-value"));
			$("#searchForm").submit();
		}
	};

	var searchList = function searchList() {
		if($("#search").val() == "" && $.trim($("#findword").val()) != "") {
			alert("검색 구분을 선택해 주세요.");
			$("#search").focus();
			return;
		}

		$("#searchForm").submit();
	};

	var downloadExcel = function() {
		$("#searchForm").attr("action", "/admin/point/all/list/download");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	};
</script>
</body>
</html>
