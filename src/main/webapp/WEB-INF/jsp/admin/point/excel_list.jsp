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
		<h1>포인트 내역 엑셀 다운로드 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li class="active">포인트 내역 엑셀 다운로드</li>
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
					<form id="searchForm" action="/admin/point/excel/list" class="form-horizontal" method="get">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">등록일자</label>
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
									<button type="button" onclick="dateProc(0)" class="btn btn-info btn-xs">오늘</button>
									<button type="button" onclick="dateProc(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="dateProc(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="dateProc(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="dateProc(365)" class="btn btn-default btn-xs">1 년</button>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${vo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" onclick="downloadExcel();" class="btn btn-success btn-sm">엑셀다운</button>
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
							<colgroup>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>회원 아이디</th>
									<th>회원 이름</th>
									<th>쇼핑몰</th>
									<th>적립 포인트</th>
									<th>지급일</th>
									<th>비고</th>
									<th>사용가능여부</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.id}</td>
									<td class="text-center">${item.name}</td>
									<td class="text-center">${item.mallName}</td>
									<td class="text-center">
										<fmt:formatNumber value="${item.point}" pattern="#,###" /> P
									</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
									<td class="text-center">${item.reserveComment}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.validFlag eq 'Y'}">
												가능
											</c:when>
											<c:when test="${item.validFlag eq 'N'}">
												불가능
											</c:when>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="7">등록된 내용이 없습니다.</td></tr>
							</c:if>
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
	$(document).ready(function(){
		showDatepicker("yy-mm-dd");
	});

	var dateProc = function(val) {
		if(val === "clear") {
			$("input[name=searchDate1]").val("");
			$("input[name=searchDate2]").val("");
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
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
		$("#searchForm").attr("action", "/admin/point/list/download/excel");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	};
</script>
</body>
</html>
