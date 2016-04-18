<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-xs">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>쇼핑몰 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">템플릿 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-list-ul"></i> 템플릿 관리</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="list1" class="table table-bordered">
							<thead>
								<tr>
									<th>회원등급</th>
									<th>템플릿</th>
									<th>비고/설명</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="vo" items="${list}">
								<tr>
									<td class="text-center">${vo.name}</td>
									<td class="text-center">
										<a href="/admin/system/login?memberTypeCode=C"  class="btn btn-mini btn-warning">로그인페이지</a>
										<a href="/admin/system/main?memberTypeCode=${vo.value}"  class="btn btn-mini btn-warning">메인페이지</a>
										<a href="/admin/system/sub?memberTypeCode=${vo.value}" class="btn btn-mini btn-warning">서브페이지</a>
									</td>
									<td class="text-center">${vo.note}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="3">데이터가 존재하지 않습니다.</td></tr>
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
