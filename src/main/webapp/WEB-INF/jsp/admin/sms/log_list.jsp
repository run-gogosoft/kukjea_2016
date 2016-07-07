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
		<h1>SMS 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">SMS 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<ul class="nav nav-tabs">
							<ul class="nav nav-tabs">
								<li><a href="/admin/sms/list">SMS 관리 리스트</a></li>
								<li class="active"><a href="/admin/sms/log/list">SMS 발송내역 리스트</a></li>
							</ul>
						</ul>

						<form id="searchForm1" action="/admin/sms/log/list" method="POST" style="margin-top:5px;">
						<table id="search1" class="table table-bordered" style="width:auto;">
							<tbody>
								<tr>
									<th>검색일자</th>
									<td>
										<input type="text" id="logDate" name="logDate" value="${vo.logDate}" class="span9 datepicker" />
										<a href="#" onclick="$(this).prev().focus()"><i class="fa fa-fw fa-calendar"></i></a>
									</td>
									<th>검색구분</th>
									<td>
										<select id="search" name="search" class="span4">
											<option value="">---전체 선택---</option>
											<option value="tr_phone"  <c:if test="${vo.search eq 'tr_phone' or vo.search eq ''}">selected</c:if>>받는사람 번호</option>
											<option value="tr_msg" <c:if test="${vo.search eq 'tr_msg'}">selected</c:if>>메시지 내용</option>
										</select>
										<input type="text" id="findword" name="findword" value="${vo.findword}" class="span8" maxlength="20"/>
									</td>
									<td>
										<button type="submit" class="btn btn-xs btn-warning">조회하기</button>
									</td>
								</tr>
							</tbody>
						</table>
						</form>

						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>No.</th>
									<th>받는사람</th>
									<th>보낸사람</th>
									<th>내용</th>
									<th>발송일</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">${item.trPhone}</td>
									<td class="text-center">${item.trCallBack}</td>
									<td>${item.trMsg}</td>
									<td class="text-center">${item.trRealSendDate}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="5">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
					</div>
					<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		showDatepicker("yymm");
	});
</script>
</body>
</html>
