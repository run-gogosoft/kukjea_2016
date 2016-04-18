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
			<h1>어드민 관리자 <small></small></h1>
			<ol class="breadcrumb">
				<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
				<li>시스템 관리</li>
				<li class="active">어드민 관리자</li>
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
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
							<div class="pull-right">
								<a href="/admin/system/admin/insert/form" class="btn btn-info btn-sm">관리자 신규 등록</a>
							</div>
						</c:if>
						</div>
						<!-- 내용 -->
						<div class="box-body">
							<table id="list1" class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>No.</th>
										<th>아이디</th>
										<th>이름</th>
										<th>닉네임</th>
										<th>상태</th>
										<th>등급</th>
										<th>마지막 접속일</th>
										<th>등록일자</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="item" items="${list}">
									<tr>
										<td class="text-center">${item.seq}</td>
										<td>
											<c:choose>
												<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
													<a href="/admin/system/admin/view/${item.seq}">${item.id}</a>
												</c:when>
												<c:otherwise>
													${item.id}
												</c:otherwise>
											</c:choose>
										</td>
										<td>${item.name}</td>
										<td>${item.nickname}</td>
										<td class="text-center">
											<%--상태(H:승인대기, Y:정상, N:중지, X:폐점/탈퇴)--%>
											<c:choose>
												<c:when test="${item.statusCode eq 'H'}">승인대기</c:when>
												<c:when test="${item.statusCode eq 'Y'}">정상</c:when>
												<c:when test="${item.statusCode eq 'N'}">중지</c:when>
												<c:when test="${item.statusCode eq 'X'}">폐점/탈퇴</c:when>
											</c:choose>
										</td>
										<td class="text-center">${item.gradeText}</td>
										<td class="text-center">${fn:substring(item.lastDate,0,10)}</td>
										<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
									</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="8">등록된 관리자가 없습니다.</td></tr>
								</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
       </section>
	</div>
	<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
</body>
</html>
