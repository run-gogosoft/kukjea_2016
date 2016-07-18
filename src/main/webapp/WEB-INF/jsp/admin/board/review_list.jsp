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
		<h1>${title}<small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>게시판 관리</li>
			<li class="active">${title}</li>
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
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:5%;" />
								<col style="width:7%;" />
								<col style="width:8%;"/>
								<col style="width:10%;" />
								<col style="width:10%;" />
								<col/>
								<col style="width:8%;" />
								<col style="width:9%;" />
								<col style="width:7%;" />
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<col style="width:3%;" />
								</c:if>
							</colgroup>
							<thead>
								<tr>
									<th>#</th>
									<th>상품번호</th>
									<th>상품이미지</th>
									<th>상품명</th>
									<th>쇼핑몰</th>
									<th>구매평</th>
									<th>상품평가</th>
									<th>글쓴이</th>
									<th>등록일</th>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
										<th></th>
									</c:if>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">
										${ item.itemSeq }
									</td>
									<td class="text-center">
										<img src="/upload${fn:replace(item.img1, 'origin', 's60')}" style="width:70px;" alt=""/>
									</td>
									<td class="text-center">
										${ item.itemName }
									</td>
									<td class="text-center">
											${ item.mallName }
									</td>
									<td>
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5 or sessionScope.gradeCode eq 9) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
												<a href="/admin/board/review/view/${item.seq}">${item.review}</a>
											</c:when>
											<c:otherwise>
												${item.review}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
										<smp:reviewStar max="5" value="${item.goodGrade}" />
									</td>
									<td class="text-center">${item.name}</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
										<td class="text-center">
												<%--관리자만 삭제 가능 --%>
											<div onclick="veiwModal('${ item.seq }')" role="button" class="btn" data-toggle="modal"><i class="fa fa-remove"></i></div>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							</tbody>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="10">등록된 내용이 없습니다.</td></tr>
							</c:if>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<div id="myModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel1">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제 하시겠습니까?</p>
				<input type="hidden" id="seq"/>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<div onclick="veiwModal2()" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">Confirm</div>
			</div>
		</div>
	</div>
</div>

<div id="myModal2" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel2">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제하시면 다시는 복구할수 없습니다, 정말 삭제하시겠습니까?</p>
				<input type="hidden" id="seq2"/>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<div class="btn btn-danger" onClick="goDelete()">Delete</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var searchProc = function searchProc(obj) {
		$(obj).parent().parent().next().val($(obj).attr("data-value"));
		$(obj).parent().parent().prev().prev().text($(obj).text());
		if ($(obj).attr("data-submit") === "true") {
			$("#searchForm").submit();
		}
	};

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var goDelete = function(){
		var seq = $("#seq2").val();
		location.href = "/admin/board/review/del/proc/"+seq;
	};

	var veiwModal = function(seq){
		$("#myModal").modal('show');
		$("#seq").val(seq);
	};

	var veiwModal2 = function(){
		$("#myModal2").modal('show');
		$("#seq2").val($("#seq").val());
	};
</script>
</body> </html>
