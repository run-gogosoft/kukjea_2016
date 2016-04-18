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
		<h1>어드민 관리자  <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">어드민 관리자</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-edit"></i> 관리자 상세 정보</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="view1" class="table table-striped">
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:80%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td>${vo.id}</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>${vo.name}</td>
								</tr>
								<tr>
									<th>닉네임/가칭</th>
									<td>${vo.nickname}</td>
								</tr>
								<tr>
									<th>유형</th>
									<td>
										<%--유형 (A:관리자,S:입점업체,P:택배사,M:회원)--%>
										<c:choose>
											<c:when test="${vo.typeCode eq 'A'}">관리자</c:when>
											<c:when test="${vo.typeCode eq 'S'}">입점업체</c:when>
											<c:when test="${vo.typeCode eq 'M'}">회원</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>상태</th>
									<td>
										<%--상태(H:승인대기, Y:정상, N:중지, X:폐점/탈퇴)--%>
										<c:choose>
											<c:when test="${vo.statusCode eq 'H'}">승인대기</c:when>
											<c:when test="${vo.statusCode eq 'Y'}">정상</c:when>
											<c:when test="${vo.statusCode eq 'X'}">폐점/탈퇴</c:when>
											<c:when test="${vo.statusCode eq 'N'}">중지</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>등급</th>
									<td>${vo.gradeText}</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>${vo.email}</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>${vo.tel}</td>
								</tr>
								<tr>
									<th>핸드폰번호</th>
									<td>${vo.cell}</td>
								</tr>
								<tr>
									<th>마지막 접속 아이피</th>
									<td>${vo.lastIp}</td>
								</tr>
								<tr>
									<th>마지막 접속일</th>
									<td>${vo.lastDate}</td>
								</tr>
								<tr>
									<th>비밀번호 변경일</th>
									<td>${vo.modPasswordDate}</td>
								</tr>
								<tr>
									<th>정보 수정일</th>
									<td>${vo.modDate}</td>
								</tr>
								<tr>
									<th>등록일</th>
									<td>${vo.regDate}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="box-footer text-center">
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
						<a href="/admin/system/admin/form/${vo.seq}" class="btn btn-info">수정하기</a>
						</c:if>
						<button type="button" class="btn" onclick="location.href='/admin/system/admin/list';">목록보기</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
</body>
</html>
