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
		<h1>금지어 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>상품 관리</li>
			<li class="active">금지어 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border"><h3 class="box-title">금지어 등록</h3></div>
					<!--  내용 -->
					<form class="form-horizontal" id="regFilter" method="post" action="/admin/item/filter/reg" onsubmit="return regFilter();">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">금지어</label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="word" name="word" placeholder="금지어를 입력해주세요" maxlength="20"/>
								</div>
								<div class="col-md-1">
									<button type="submit" class="btn btn-primary">등록</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border"><h3 class="box-title">금지어 리스트</h3></div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:60%;"/>
								<col style="width:15%;"/>
								<col style="width:5%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>seq</th>
									<th>금지어</th>
									<th>등록일</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">${item.filterWord}</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
									<td class="text-center">
										<div class="btn" data-toggle="modal" role="button" onclick="deleteFilter('${item.seq}')">
											<i class="fa fa-fw fa-remove"></i>
										</div>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="4">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<!--<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>-->
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">

	var deleteFilter = function(seq){
		if(confirm("정말로 삭제하시겠습니까?")) {
			location.href="/admin/item/filter/delete/"+seq;
		}
	}

	var regFilter = function(){
		if($('#word').val() !== '') {
			if (confirm("정말로 등록하시겠습니까?")) {
				return true;
			}else {
				return false;
			}
		}else{
			alert('금지어를 입력해주세요');
			return false;
		}
	}
</script>
</body>
</html>
