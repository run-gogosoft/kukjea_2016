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
		<h1>포인트 등록 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li class="active">포인트 등록</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="alert alert-info">
					<ol>
						<li>엑셀은 반드시 정해진 폼에 맞춰서 작업을 해야 합니다. 샘플파일을 참고하세요</li>
						<li>엑셀은 금액부분을 제외하고 반드시 셀서식을 텍스트 형식으로 저장하셔야 합니다. 샘플파일을 참고하세요</li>
						<li>
							엑셀은 반드시 <strong>.xls (오피스 2003)</strong>으로 저장을 해주셔야 합니다. 오피스 2007은 적용되지 않습니다 <br/>
							(파일명만 바꾸는 것이 아니라 실제 저장형식을 오피스 2003으로 해야 합니다)
						</li>
						<li>1회 업로드는 1000개로 제한되어 있습니다</li>
						<li>경우에 따라서 수분의 시간이 소요될 수 있습니다. 절대 창을 닫지 마십시오</li>
						<li>샘플파일을 다운로드하여 아래표의 양식에 맞추어 작성해 주세요</li>
					</ol>
				</div>
				<%--
				<div class="box">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">회원 등록</h3></div>
					<!-- 내용 -->
					<form id="uploadForm" enctype="multipart/form-data" action="/admin/member/excel/upload/proc" method="post" onsubmit="submitProc(this)" target="zeroframe" class="form-horizontal">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">샘플파일</label>
								<div class="col-md-10">
									<a href="/assets/xls/sample_member_list.xls" target="_blank" class="btn btn-success">파일 다운로드 (sample_member_list.xls)</a>
								</div>
							</div>
							<div class="form-group" ${fn:length(mallList) <= 1 ? "style='display:none;'":""}>
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2">
									<select class="form-control" id="mallSeq" name="mallSeq" alt="쇼핑몰">
										<option value="">--몰선택--</option>
										<c:forEach var="item" items="${mallList}">
											<option value="${item.seq}" ${fn:length(mallList) <= 1 ? "selected":""}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">업로드</label>
								<div class="col-md-2">
									<input type="file" onchange="checkFileSize(this);" id="xlsFile" name="xlsFile" alt="업로드" style="width:100%;height:35px;">
								</div>
								<div class="col-md-2">
									<button type="submit" class="btn btn-success fileinput-button">
										<i class="fa fa-plus"></i>
										<span>엑셀 파일 업로드하기...</span>
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				--%>
				<div class="box">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">포인트 등록</h3></div>
					<!-- 내용 -->
					<form id="uploadPointForm" enctype="multipart/form-data" action="/admin/point/excel/upload/proc" method="post" onsubmit="submitPointProc(this)" target="zeroframe" class="form-horizontal">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">샘플파일</label>
								<div class="col-md-10">
									<a href="/assets/xls/sample_point_list.xls" target="_blank" class="btn btn-success">파일 다운로드 (sample_point_list.xls)</a>
								</div>
							</div>
							<div class="form-group" ${fn:length(mallList) <= 1 ? "style='display:none;'":""}>
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2">
									<select class="form-control" id="mallPointSeq" name="mallSeq" alt="쇼핑몰">
										<option value="">--몰선택--</option>
										<c:forEach var="item" items="${mallList}">
											<option value="${item.seq}" ${fn:length(mallList) <= 1 ? "selected":""}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">업로드</label>
								<div class="col-md-4">
								<input type="file" onchange="checkFileSize(this);" id="xlsPointFile" name="xlsFile" alt="업로드"  style="width:100%;height:35px;">
								</div>
								<div class="col-md-2">
									<button type="submit" class="btn btn-success fileinput-button">
										<i class="fa fa-plus"></i>
										<span>엑셀 파일 업로드하기...</span>
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">오류 내역</h3></div>
					<!-- 내용 -->
					<div class="box-body">
						<script id="errorTemplate" type="text/html">
							<tr><td class="text-error"><%="${message}"%></td></tr>
						</script>
						<table class="table table-striped table-bordered table-list">
							<thead>
								<th>내용</th>
							</thead>
							<tbody id="errorList">
								<tr><td class="text-center muted">업로드 후에 오류가 있으면 여기에 표시됩니다.</td></tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script id="uploadTemplate" type="text/html">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<h4><%="${title}"%></h4>
			<%="{{html content}}"%>
			<div class="status"></div>
		</div>
	</div>
</div>
</script>
<div id="uploadModal" class="modal"></div>
<div id="downloadModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<h4>회원 정보 업로드 중입니다.. <img src="/assets/img/common/ajaxloader.gif" alt="" /></h4>
				<h7>(회원 정보 업로드가 끝나기 전까지는 이 창을 닫지 마세요)</h7>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/libs/jquery.form.min.js"></script>
<script type="text/javascript">
	var submitProc = function(obj) {
		if($("#xlsFile").val() === "") {
			alert("업로드하실 파일을 등록해주세요");
			$("#xlsFile").focus();
			return false;
		} else if($("#mallSeq").val() == ""){
			alert("쇼핑몰을 선택해 주세요");
			$("#mallSeq").focus();
			return false;
		}

		$("#downloadModal").modal();
	};

	var submitPointProc = function(obj) {
		if($("#xlsPointFile").val() === "") {
			alert("업로드하실 파일을 등록해주세요");
			$("#xlsPointFile").focus();
			return false;
		} else if($("#mallPointSeq").val() == ""){
			alert("쇼핑몰을 선택해 주세요");
			$("#mallPointSeq").focus();
			return false;
		}

		$("#downloadModal").modal();
	};

	var callbackProc = function(msg) {
		var returnMsg = msg.split(":");
		var tempList = [];
		var type = returnMsg[0];
		var value = returnMsg[1];

		if(type === 'LIST') {
			$("#downloadModal").modal('hide');

			var html = "";
			var tempList = value.split("|");
			for(var i=0; i<tempList.length; i++) {
				html += "<tr><td class='text-error'>"+tempList[i].replace("[","").replace("]","")+"</td></tr>";
			}

			$("#errorList").html(html);
		} else if(type === 'MSG') {
			$("#downloadModal").modal('hide');
			$("#errorList").html(value);
		} else if(type === 'MEMBER') {
			$("#downloadModal").modal('hide');
			$("#errorList").html("");
			$("#uploadModal").modal("show");
			$("#uploadModal").html(
					$("#uploadTemplate").tmpl({
						"title": "모든 작업이 완료되었습니다!", "content": '<a href="/admin/member/list">리스트 페이지로 이동하기</a>'
					})
			)
		} else if(type === 'POINT') {
			//else는 OK, 등록 성공이다
			$("#downloadModal").modal('hide');
			$("#errorList").html("");
			$("#uploadModal").modal("show");
			$("#uploadModal").html(
					$("#uploadTemplate").tmpl({
						"title": "모든 작업이 완료되었습니다!", "content": '<a href="/admin/point/list">리스트 페이지로 이동하기</a>'
					})
			)
		}
	};
</script>
</body>
</html>
