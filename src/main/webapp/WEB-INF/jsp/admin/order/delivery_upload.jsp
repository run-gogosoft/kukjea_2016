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
		<h1>송장 일괄 업로드  <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>판매관리</li>
			<li class="active">송장 일괄 업로드</li>
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
					<form  class="form-horizontal" method="post" enctype="multipart/form-data" action="/admin/order/delivery/upload/proc" target="zeroframe">
						<div class="box-body">
							<div class="alert alert-info">
								<ol>
									<li>엑셀은 반드시 정해진 폼에 맞춰서 작업을 해야 합니다.</li>
									<li>
										엑셀은 반드시 <strong>.xls (오피스 2003)</strong>으로 저장을 해주셔야 합니다. 오피스 2007은 적용되지 않습니다 <br/>
										(파일명만 바꾸는 것이 아니라 실제 저장형식을 오피스 2003으로 해야 합니다)
									</li>
									<li>경우에 따라서 수분의 시간이 소요될 수 있습니다. 절대 창을 닫지 마십시오</li>
									<li>발송처리 대상 주문 파일을 다운로드 한 뒤 아래 택배사 코드 안내를 참고하여 택배사코드와 송장번호를 작성해주세요.</li>
								</ol>
							</div>
					<c:choose>
						<c:when test="${sessionScope.loginType eq 'S'}">
							<input type="hidden" id="sellerSeq" name="sellerSeq" value="${sessionScope.loginSeq}" readonly="readonly" alt="입점업체" />
						</c:when>
						<c:otherwise>
							<div class="form-group">
								<label class="col-md-2 control-label">입점업체</label>
								<div class="col-md-10">
									<div class="row">
										<div class="col-md-2">
											<input class="form-control" type="text" id="sellerSeq" name="sellerSeq" value="" readonly="readonly" alt="입점업체"/>
										</div>
										<div class="col-md-2">
											<input class="form-control" type="text" name="seller" value="" placeholder="입점업체 검색" />
										</div>
										<div class="col-md-1">
											<button type="button" class="btn btn-info" onclick="sellerProc(0)">검색</button>
										</div>
									</div>
									<div class="row">
										<div class="col-md-10">
											<table class="table table-bordered table-striped" style="margin-top:10px;">
												<colgroup>
													<col style="width:10%;"/>
													<col style="width:10%;"/>
													<col style="width:7%;"/>
													<col style="width:7%;"/>
													<col style="width:6%;"/>
													<col style="width:12%;"/>
													<col style="width:12%;"/>
													<col style="width:12%;"/>
													<col style="width:12%;"/>
													<col style="width:12%;"/>
												</colgroup>
												<thead>
													<tr>
														<th>아이디</th>
														<th>입점업체명</th>
														<th>입점업체<br/>등급</th>
														<th>정산<br/>등급</th>
														<th>상태</th>
														<th>대표자명</th>
														<th>대표전화</th>
														<th>담당자명</th>
														<th>담당자<br/>연락처</th>
														<th>승인일자</th>
													</tr>
												</thead>
												<tbody id="eb-seller-list">
													<tr><td class="muted text-center" colspan="20">검색결과가 이 안에 표시됩니다.</td></tr>
												</tbody>
											</table>
											<div id="paging"></div>
											<i class="fa fa-fw fa-info"></i> 입점업체를 검색한 후에 선택해주세요
										</div>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
							<div class="form-group">
								<label for="xlsFile" class="col-md-2 control-label">엑셀 파일 선택</label>
								<div class="col-md-10">
									<input type="file" onchange="checkFileSize(this);" id="xlsFile" name="xlsFile" value="" style="width:30%;height:30px;" required/>
								</div>
							</div>
						</div><!-- /.box-body -->
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-warning btn-sm">업로드하기</button>
							<button type="button" onclick="downloadXls()" class="btn btn-success btn-sm">발송처리 대상 주문 다운로드</button>
						</div><!-- /.box-footer -->
					</form>
				</div>
				<div class="box">
					<div class="box-header with-border"><h3 class="box-title">택배사 코드 안내</h3></div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<table class="table table-bordered table-striped">
							<c:forEach var="item" items="${list}" varStatus="status">
								<c:if test="${status.count <= 10}">
									<tr>
										<th>${item.deliSeq}</th>
										<td>${item.deliCompanyName} <c:if test="${item.useFlag eq 'N'}">(사용안함)</c:if></td>
									</tr>
								</c:if>
							</c:forEach>
								</table>
							</div>
							<div class="col-md-4">
								<table class="table table-bordered table-striped">
							<c:forEach var="item" items="${list}" varStatus="status">
								<c:if test="${status.count > 10 && status.count <= 20}">
									<tr>
										<th>${item.deliSeq}</th>
										<td>${item.deliCompanyName} <c:if test="${item.useFlag eq 'N'}">(사용안함)</c:if></td>
									</tr>
								</c:if>
							</c:forEach>
								</table>
							</div>
							<div class="col-md-4">
								<table class="table table-bordered table-striped">
							<c:forEach var="item" items="${list}" varStatus="status">
								<c:if test="${status.count > 20 && status.count <= 30}">
									<tr>
										<th>${item.deliSeq}</th>
										<td>${item.deliCompanyName} <c:if test="${item.useFlag eq 'N'}">(사용안함)</c:if></td>
									</tr>
								</c:if>
							</c:forEach>
								</table>
							</div>
						</div> 
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="sellerTemplate" type="text/html">
<tr style="cursor:hand" data-seq="<%="${seq}"%>" onclick="sellerSelectProc(this)">
	<td class="text-center"><%="${id}"%></td>
	<td class="text-center"><%="${name}"%></td>
	<td class="text-center"><%="${gradeCode}"%></td>
	<td class="text-center"><%="${adjustGradeCode}"%></td>
	<td class="text-center"><%="${statusCode}"%></td>
	<td class="text-center"><%="${ceoName}"%></td>
	<td class="text-center"><%="${tel}"%></td>
	<td class="text-center"><%="${salesName}"%></td>
	<td class="text-center"><%="${salesTel}"%></td>
	<td class="text-center"><%="${approvalDate}"%></td>
</tr>
</script>
									
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
/* 페이지 로딩시 초기화 */
$(document).ready(function () {

});

var downloadXls = function() {
	if( $("#sellerSeq").val() == "" ) {
		alert("입점업체 아이디를 입력해 주세요.");
		$("#sellerSeq").focus();
		return;
	}
	location.href="/admin/order/delivery/xls?sellerSeq="+$("#sellerSeq").val();
}

var goPage = function (page) {
	sellerProc(page);
};

var sellerProc = function(pageNum) {
	/* $("#eb-seller-list")
		.html( "<tr><td colspan='20' class='muted text-center' style='padding:10px'>데이터를 불러오고 있습니다</td></tr>" )
		.parents(".hide").show(); */
	$.ajax({
		url:"/admin/seller/list/S/json",
		type:"post",
		data:{findword:$("input[name=seller]").val(), search:'id', pageNum:pageNum},
		dataType:"text",
		success:function(data) {
			var list = $.parseJSON(data);

			if(list.length === 0) {
				$("#eb-seller-list").html( "<tr><td colspan='20' class='muted text-center' style='padding:10px'>검색된 결과가 없습니다</td></tr>" );
			} else {
				$("#eb-seller-list").html( $("#sellerTemplate").tmpl(list) );
			}
			/** 입점업체리스트를 불러온후 페이징을 호출한다. */
			sellerProcPaging(pageNum);
		},
		error:function(error) {
			alert( error.status + ":" +error.statusText );
		}
	});
};

var sellerProcPaging = function(pageNum){
	$.ajax({
		type:"post",
		url:"/admin/seller/list/S/json/paging",
		dataType:"text",
		data:{findword:$("input[name=seller]").val(), search:'id', pageNum:pageNum},
		success:function(data) {
			$("#paging").html(data);
			$("#paging").addClass("dataTables_paginate").addClass("paging_simple_numbers").addClass("text-center");
		},
		error:function(error) {
			alert( error.status + ":" +error.statusText );
		}
	});
};

var sellerSelectProc = function(obj) {
	var seq = parseInt($(obj).attr("data-seq"), 10) || 0;
	$("input[name=sellerSeq]").val(seq);
	$("#eb-seller-list tr[data-seq]").each(function(){
		if(parseInt($(this).attr("data-seq"), 10) !== seq) {
			$(this).remove();
		} else {
			$(this).addClass("info");
		}
	});
};
</script>
</body>
</html>
