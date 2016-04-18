<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.textCenter{
			text-align:center;
			font-size:14px;
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>공지팝업창 관리  <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">공지팝업창 관리</li>
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
						<select id="typeCode" name="typeCode" style="height:30px;border:1px #ccc solid">
							<option value="">----- 타입별 조회 -----</option>
							<option value="C" <c:if test="${vo.typeCode eq 'C'}">selected="selected"</c:if>>일반</option>
							<option value="S" <c:if test="${vo.typeCode eq 'S'}">selected="selected"</c:if>>입점업체</option>
						</select>
						<select id="statusCode" name="statusCode" style="height:30px;border:1px #ccc solid">
							<option value="">----- 상태별 조회 -----</option>
							<option value="Y" <c:if test="${vo.statusCode eq 'Y'}">selected="selected"</c:if>>진행</option>
							<option value="N" <c:if test="${vo.statusCode eq 'N'}">selected="selected"</c:if>>종료</option>
						</select>
						<div class="pull-right">
							<a href="/admin/system/notice/popup/form" class="btn btn-info btn-sm">공지팝업창 등록</a>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>#</th>
									<th>타입</th>
									<th>팝업명</th>
									<th>상태</th>
									<th>가로</th>
									<th>세로</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td style="width:5%;" class="text-center">${item.seq}</td>
									<td style="width:5%;" class="text-center">
										<c:choose>
											<c:when test="${item.typeCode eq 'C'}">일반</c:when>
											<c:when test="${item.typeCode eq 'S'}">입점업체</c:when>
										</c:choose>
									</td>
									<td style="width:24%;" class="text-center"><a href="/admin/system/notice/popup/edit/form/${item.seq}">${item.title}</a></td>
									<td style="width:8%;" class="text-center">
										<c:choose>
											<c:when test="${item.statusCode eq 'Y'}">
												진행
											</c:when>
											<c:when test="${item.statusCode eq 'N'}">
												종료
											</c:when>
										</c:choose>
									</td>
									<td style="width:7%;" class="text-center">${item.width}px</td>
									<td style="width:7%;" class="text-center">${item.height}px</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="6">등록된 내용이 없습니다.</td></tr>
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
	$(document).ready(function () {
		$("#statusCode, #typeCode").change(function() {
			var statusCode=$("#statusCode").val(), typeCode=$('#typeCode').val();
			location.href = location.pathname + "?statusCode="+statusCode+'&typeCode='+typeCode;
		});
	});

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var goDelete = function(){
		var seq = $("#deleteSeq2").val();
		location.href = "/admin/event/del/proc?seq="+seq;
	};

	var veiwModal = function(seq){
		$("#myModal").modal('show');
		$("#deleteSeq").val(seq);
	};

	var veiwModal2 = function(){
		$("#myModal2").modal('show');
		$("#deleteSeq2").val($("#deleteSeq").val());
	};
</script>
</body>
</html>
