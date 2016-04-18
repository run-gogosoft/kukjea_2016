<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.file-select {
			width:50%; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>
			행사 참여
			<small>행사 정보 관리 및 입점업체 참여 정보 관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>행사 참여</li>
		<c:if test="${vo ne null}">
			<li>행사 리스트</li>
			<li>상세 정보</li>
		</c:if>
			<li class="active">${title}</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-edit"></i> ${title}</h3>
					</div>
					<!-- 내용 -->
					<form id="validation-form" method="post" enctype="multipart/form-data" action="/admin/festival/${vo eq null ? "reg":"mod/"}${vo eq null ? "": vo.seq}" target="zeroframe" class="form-horizontal" onsubmit="return submitProc(this);">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">제목 <i class="fa fa-check"></i></label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="title" class="span4" maxlength="30" alt="제목" value="${vo.title}"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">신청 기간 <i class="fa fa-check"></i></label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input type="text" class="form-control datepicker" name="startDate" maxlength="10" alt="신청기간 시작일" value="${vo.startDate}"/>
										<div class="input-group-addon" style="border:0;">~</div>
										<div class="input-group-addon" style="border-right-width:0"><i class="fa fa-calendar"></i></div>
										<input type="text" class="form-control datepicker" name="endDate" maxlength="10" alt="신청기간 종료일" value="${vo.endDate}"/>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">행사 내용 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<textarea name="content" class="textarea">${vo.content}</textarea></div>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-md-2 control-label">파일 첨부</label>
								<div class="col-md-8">
									<div id="fileList">
				                <c:if test="${vo ne null}">
				                    <c:forEach var="item" items="${fileList}">
										<div id="uploaded_file${item.seq}" class="form-control-static" style="margin-bottom:5px">
										    <input type="file" onchange="checkFileSize(this);" id="file${item.num}" name="file${item.num}" class="display-none" style="display:none"/>
										    ${item.filename}
											<a href="/admin/festival/file/download/${item.seq}" target="zeroframe">[다운로드]</a>
											<a href="/admin/festival/file/delete/${item.seq}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" target="zeroframe" class="text-danger">[삭제]</a>
										</div>
				                    </c:forEach>
				                </c:if>
									</div>
									<div>
										<button type="button" onclick="addFile()" class="btn btn-link btn-sm"><i class="fa fa-plus"></i> 파일 추가하기</button>
									</div>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-primary">저장하기</button>
							<button type="button" onclick="history.go(-1)" class="btn btn-default">뒤로가기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="fileTemplate" type="text/html">
	<div style="margin-bottom:10px">
		<input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted file-select"/>
	</div>
</script>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<!-- CK Editor -->
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	$(document).ready(function(){	
        CKEDITOR.replace('content',{
        	width:'100%',
        	height:'500',
        	filebrowserImageUploadUrl: '/admin/editor/upload'
        });
        		
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
		
		<c:if test="${vo eq null}">
			addFile();
		</c:if>
	});
	
	var submitProc = function(obj) {
		$(".display-none").prop("disabled", "true");
		return checkRequiredValue(obj, "alt");
	};
	
	var addFile = function() {
		var num = 1;
		$('#fileList input[type=file]').each(function(){
			var n = parseInt( $(this).attr('name').replace('file', ''), 10);
			if(num <= n) {
				num = n+1;
			}
		});
  		
		$('#fileList').append( $('#fileTemplate').tmpl({num:num}) );
	}
	
	var callbackProc = function(msg) {
		if(msg.split("^")[0] === "EDITOR") {
			CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.')
		} 
		else if(msg.split("^")[0] === "FILE") {
			alert(msg.split("^")[1]);
			$("#uploaded_file"+msg.split("^")[2]).remove();
	  	}
	}
</script>
</body>
</html>