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
		<h1>${title} <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li></li>
			<li class="active"></li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">${planTitle}</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table class="table table-bordered table-striped">
							<colgroup>
								<col width="5%"/>
								<col width="*"/>
								<col width="15%"/>
								<col width="10%"/>
								<col width="10%"/>
							</colgroup>
							<thead>
								<tr>
									<th>#</th>
									<th>제목</th>
									<th>글쓴이 ( 아이디 )</th>
									<th>등록일</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td><a href="javascript:;" onclick="$('#detailContent${status.count}').toggle();return false;">${item.content}</a></td>
									<td class="text-center">${item.name} ( ${item.id} )</td>
									<td class="text-center">${fn:substring(item.regDate, 0, 10)}</td>
									<td class="text-center"><button onclick="deleteComment(${item.seq}, ${vo.integrationSeq})" class="btn btn-default"><i class="fa fa-remove"></i></button></td>
								</tr>
								<tr id="detailContent${status.count}" style="display:none">
									<td class="text-center"><i class="fa fa-tag fa-2x"></i></td>
									<td colspan="4">${fn:replace(item.content, newLine, "<br/>")}</td>
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
<script type="text/javascript">
	var boardGroup = "${boardGroup}";
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&seq=${param.seq}";
	};
	
	var deleteComment = function(seq, eventSeq) {
		if(!confirm("정말로 삭제하시겠습니까?")) {
			return;
		}
		
		location.href = "/admin/event/plan/comment/delete/"+seq+"?eventSeq="+eventSeq;
	};
</script>
</body> </html>
