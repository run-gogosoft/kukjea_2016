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
			<li class="active">쇼핑몰 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-list-ul"></i> 쇼핑몰 리스트</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="list1" class="table table-bordered">
							<thead>
								<tr>
									<%--<th>No.</th>--%>
									<%--<th>쇼핑몰 아이디</th>--%>
									<th>쇼핑몰 명</th>
									<th>상태</th>
									<!-- <th>템플릿</th> -->
									<th>오픈 일자</th>
									<th>등록 일자</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="vo" items="${list}">
								<tr>
									<%--<td class="text-center">${vo.seq}</td>--%>
									<%--<td>${vo.id}</td>--%>
									<td class="text-center"><a href="/admin/mall/form?seq=${vo.seq}"><b>${vo.name}</b></a></td>
									<td class="text-center">${vo.statusText}</td>
									<td class="text-center">${fn:substring(vo.openDate,0,10)}</td>
									<td class="text-center">${fn:substring(vo.regDate,0,10)}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="6">데이터가 존재하지 않습니다.</td></tr>
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
<script type="text/javascript">
	var deleteConfirm = function(seq) {
		if(confirm("정말로 삭제하시겠습니까?")) {
			location.href="/admin/mall/delete/"+seq;
		}
	};
</script>
</body>
</html>
