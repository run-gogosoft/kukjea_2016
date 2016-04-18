<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style class="msgbox-style" type="text/css">
		div.msgbox-input{
			border:1px solid red;
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
	<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
	<div class="content-wrapper">
		<!-- 헤더 -->
		<section class="content-header">
			<h1>관리자 등급 관리  <small>어드민 접속자 유형별 메뉴 접속 권한 관리</small></h1>
			<ol class="breadcrumb">
				<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
				<li>시스템 관리</li>
				<li class="active">관리자 등급 관리</li>
			</ol>
		</section>
		<!-- 콘텐츠 -->
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<!-- 제목 -->
						<div class="box-header with-border">
							<!-- <h3 class="box-title"></h3> -->
							<select id="searchControllerName" style="height:30px;border:1px #ccc solid;">
								<option value="">----컨트롤러 선택----</option>
								<c:forEach var="item" items="${controllerNameList}">
									<option value="${item.controllerName}" ${vo ne null && vo.controllerName eq item.controllerName ? "selected" :  ""}>${item.controllerName}</option>
								</c:forEach>
							</select>
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0)}">
							<div class="pull-right">
								<a href="/admin/system/grade/manage/form" class="btn btn-info btn-sm">신규 등록</a>
							</div>
						</c:if>
						</div>
						<!-- 내용 -->
						<div class="box-body">
							<table id="list1" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>번호</th>
										<th>컨트롤러 이름</th>
										<th>컨트롤러 메소드</th>
										<th>컨트롤러 구분</th>
										<th>연구소</th>
										<th>최고 관리자</th>
										<th>운영 관리자</th>
										<th>디자이너</th>
										<th>정산 관리자</th>
										<th>CS 관리자</th>
										<th>일반 관리자</th>
										<th>입점업체</th>
										<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0)}">
											<th></th>
										</c:if>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="item" items="${list}" varStatus="status">
									<tr>
										<td class="text-center">${item.seq}</td>
										<td class="text-center">
											<c:choose>
											<c:when test="${item.controllerDescription ne ''}">
												<a href="#" onclick="toggleDisplay('controllerDescription${status.count}');return false;">${item.controllerName}</a>
											</c:when>
											<c:otherwise>
												${item.controllerName}
											</c:otherwise>
											</c:choose>
										</td>
										<td class="text-center">${item.controllerMethod}</td>
										<td class="text-center">${item.controllerDivision}</td>
										<td class="text-center">
											<c:if test="${item.admin0Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.admin1Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.admin2Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.admin3Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.admin4Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.admin5Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.admin9Flag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${item.sellerFlag eq 'Y'}">
												<i class="fa fa-check"></i>
											</c:if>
										</td>
										<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0)}">
											<td class="text-center">
												<a href="/admin/system/grade/manage/edit/${item.seq}" class="btn btn-xs btn-warning">수정</a>
												<button class="btn btn-xs btn-danger" onclick="confirmDelete('${item.seq}')">삭제</button>
											</td>
										</c:if>
									</tr>
									<tr style="display:none;" id="controllerDescription${status.count}">
										<td colspan="14">
											<c:choose>
												<c:when test="${item.controllerDescription eq ''}">
													설명이 존재하지 않습니다.
												</c:when>
												<c:otherwise>
													${item.controllerDescription}
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="14">등록된 내용이 없습니다.</td></tr>
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
<%-- 삭제모달 --%>
<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제 하시겠습니까?</p>
				<input type="hidden" id="deleteSeq"/>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" aria-hidden="true">닫기</button>
				<a href="#myModal2" onClick="goDelete()" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">확인</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function () {
		$("#searchControllerName").change(function() {
			var searchControllerName=$("#searchControllerName").val();
			location.href = "/admin/system/grade/manage/list?controllerName="+searchControllerName;
		});
	});

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&controllerName=" + $("#searchControllerName").val();
	};

	var toggleDisplay = function(arg) {
		if($('#'+arg).css("display")=='none') {
			$('#'+arg).show();
		} else {
			$('#'+arg).hide();
		}
	};

	var confirmDelete = function(seq){
		$("#deleteSeq").val(seq);
		$("#myModal").modal("show");
	};

	var goDelete = function(){
		location.href = "/admin/system/grade/manage/del/proc/"+$("#deleteSeq").val();
	};
</script>
</body>
</html>
