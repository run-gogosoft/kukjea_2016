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
		<h1>포인트 적립/사용내역 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li class="active">포인트 적립/사용내역</li>
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
					<form id="searchForm" method="get" class="form-horizontal" action="/admin/point/list">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2">
									<select class="form-control" name="mallSeq">
										<option value="">---쇼핑몰 선택---</option>
										<c:forEach var="item" items="${mallList}">
											<option value="${item.seq}" <c:if test="${item.seq eq vo.mallSeq}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
								<label class="col-md-2 control-label" for="findword">상세 검색</label>
								<div class="col-md-1">
									<select class="form-control" id="search" name="search">
										<option value="id" <c:if test="${vo.search eq 'id' or vo.search eq ''}">selected</c:if>>아이디</option>
										<option value="name" <c:if test="${vo.search eq 'name'}">selected</c:if>>이름</option>
									</select>
								</div>
								<div class="col-md-2">
									<input class="form-control" type="text" id="findword" name="findword" value="${vo.findword}" maxlength="20" />
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
								<col style="width:20%;"/>
								<col style="width:20%;"/>
								<col style="width:20%;"/>
								<col style="width:20%;"/>
								<col style="width:20%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>회원 아이디</th>
									<th>회원 이름</th>
									<th>쇼핑몰</th>
									<th>총적립포인트</th>
									<th>잔여포인트</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">
										<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
											<a href="/admin/point/detail/list/${item.memberSeq}">${item.id}</a>
										</c:if>
									</td>
									<td class="text-center">${item.name}</td>
									<td class="text-center">${item.mallName}</td>
									<td class="text-center">
										<fmt:formatNumber value="${item.point}" pattern="#,###" /> P
									</td>
									<td class="text-center">
										<fmt:formatNumber value="${item.useablePoint}" pattern="#,###" /> P
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="5">등록된 내용이 없습니다.</td></tr>
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
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
	});

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
		$("#searchForm").attr("action", "/admin/point/list/download");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	};
</script>
</body>
</html>
