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
		<h1>CS 처리내역 리스트 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>판매 관리</li>
			<li class="active">CS처리내역 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!--검색 영역-->
					<form class="form-horizontal" id="searchForm" method="get">
						<div class="box-body">
							<div class="form-group">									
								<label class="col-md-2 control-label">주문일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${pvo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${pvo.searchDate2}">
									</div>
								</div>
								<div class="col-md-3 form-control-static">								
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오 늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전 체</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">주문 상태</label>
								<div class="col-md-2">
									<select class="form-control" name="statusCode">
										<option value="">---전체 검색---</option>
										<c:forEach var="item" items="${statusList}">
											<c:if test="${item.value ne '00' and item.value ne '55'}">
												<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-2"></div>
								<label class="col-md-2 control-label">답변자</label>
								<div class="col-md-2">
									<input class="form-control" type="text" name="loginName" value="${pvo.loginName}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상세 검색</label>
								<div class="col-md-2">
									<select class="form-control" name="search" onchange="findText();">
										<option value="">---검색 구분---</option>
										<option value="seq" 			<c:if test="${pvo.search eq 'seq'}">selected</c:if>>상품주문번호</option>
										<option value="order_seq" 		<c:if test="${pvo.search eq 'order_seq'}">selected</c:if>>주문번호</option>
										<option value="seller_name" 	<c:if test="${pvo.search eq 'seller_name'}">selected</c:if>>입점업체명</option>
									</select>
								</div>
								<div class="col-md-2">
									<input  class="form-control" type="text" name="findword" value="${pvo.findword}" maxlength="20" onblur="numberCheck(this);"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" onclick="location.href='/admin/order/cs/log/list'" class="btn btn-warning btn-sm">검색초기화</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>상품<br/>주문번호</th>
									<th>주문번호</th>
									<!-- <th>쇼핑몰</th> -->
									<th>주문상태</th>
									<th>CS내용</th>
									<th>답변자</th>
									<th>업체명</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
												<a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}">${item.seq}</a>
											</c:when>
											<c:otherwise>
												${item.seq}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${item.orderSeq}</td>
									<%-- <td class="text-center">${item.mallName}</td> --%>
									<td class="text-center"><strong>${item.statusText}</strong></td>
									<td class="text-left">${item.contents}</td>
									<td class="text-center">${item.loginName}</td>
									<td class="text-center">${item.sellerName}</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="8">등록된 내용이 없습니다.</td></tr>
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
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	/** 페이지 로딩시 초기화 */
	$(document).ready(function () {
		/* 날짜 검색 달력 기능 */
		showDatepicker("yy-mm-dd");
	});

	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	/** 날짜 계산 */
	var calcDate = function(val) {
		if(val == "clear") {
			$("input[name=searchDate1]").val( '2014-01-01' );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};

</script>
</body>
</html>
