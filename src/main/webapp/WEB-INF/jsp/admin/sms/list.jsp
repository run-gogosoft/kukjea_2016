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
		<h1>SMS 관리  <small></small></h1>
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
					<!-- 소제목 -->
					<!-- <div class="box-header with-border">
						<h3 class="box-title"></h3>
					</div> -->
					<!-- 내용 -->
					<div class="box-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="/admin/sms/list">발송 메세지 리스트</a></li>
							<li><a href="/admin/sms/log/list">발송내역 리스트</li>
							<!--<li><a href="/admin/sms/send">SMS 발송하기</a></li>-->
						</ul>
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>No.</th>
									<th>제목</th>
									<th>발송대상</th>
									<th>종류</th>
									<th>상태</th>
									<th>내용</th>
									<th>등록일</th>
									<%--<th></th>--%>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center"><a href="/admin/sms/form/${item.seq}">${item.title}</a></td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.typeCode eq 'C'}">고객</c:when>
											<c:otherwise>입점업체	</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.statusType eq 'O'}">주문</c:when>
											<c:when test="${item.statusType eq 'S'}">입점업체</c:when>
											<c:when test="${item.statusType eq 'C'}">회원</c:when>
											<c:when test="${item.statusType eq 'E'}">견적</c:when>
										</c:choose>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.statusType eq 'O'}">
												${item.orderStatusText}
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${item.statusCode eq 'H'}">승인대기</c:when>
													<c:when test="${item.statusCode eq 'Y'}">정상</c:when>
													<c:when test="${item.statusCode eq 'X'}">탈퇴/폐점</c:when>
													<c:when test="${item.statusCode eq '1'}">접수</c:when>
													<c:otherwise>중지/보류</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${item.content}</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
									<%--<td class="text-center"><button onclick="deleteConfirm(${item.seq})" class="btn btn-danger btn-sm">삭제</button></td>--%>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="8">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
					<%--<div class="box-footer">--%>
						<%--<div class="pull-right">--%>
							<%--<a href="/admin/sms/form" class="btn btn-info btn-sm">발송 메세지 신규 등록</a>--%>
						<%--</div>--%>
					<%--</div>--%>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>

<script type="text/javascript">
	var deleteConfirm = function(seq) {
		if(confirm("정말로 삭제하시겠습니까?")) {
			location.href="/admin/sms/delete/"+seq;
		}
	};
</script>
</body>
</html>
