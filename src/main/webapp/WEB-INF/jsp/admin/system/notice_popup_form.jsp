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
		<h1>공지팝업창 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">공지팝업창 관리</li>
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
					<form id="validation-form" method="post" action="/admin/system/notice/popup/${vo.seq eq null ? "reg":"mod"}/proc" target="zeroframe" class="form-horizontal" onsubmit="return submitProc(this);">
						<input type="hidden" name="seq" value="${vo.seq}">
						<div class="box-body">
							<div class="form-group" ${fn:length(mall) <= 1 ? "style='display:none'":""}>
								<label class="col-md-2 control-label">쇼핑몰<i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select id="mallSeq" name="mallSeq" class="form-control">
										<option value="">전체몰</option>
										<c:forEach var="item" items="${mall}">
											<option value="${item.seq}" ${vo.mallSeq == item.seq ? "selected":""}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">타입 <i class="fa fa-check"></i></label>
								<div class="radio">
									<label><input type="radio" name="typeCode" value="C" <c:if test="${vo.typeCode eq null or vo.typeCode eq 'C'}">checked="checked"</c:if> /> 일반</label>
									<label><input type="radio" name="typeCode" value="S" <c:if test="${vo.typeCode eq 'S'}">checked="checked"</c:if> /> 입점업체</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">팝업명 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="title" name="title" class="span4" maxlength="30" alt="팝업명" value="${vo.title}"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="width">가로 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" class="form-control text-right" id="width" name="width" maxlength="3" alt="가로" value="${vo.width}" onblur="numberCheck(this);"/>
										<div class="input-group-addon">px</div>
									</div>
								</div>
								<div class="col-md-2 form-control-static">
									<strong class="text-info">(이미지 가로크기px + 14px)</strong>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="height">세로 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" class="form-control text-right" id="height" name="height" maxlength="3" alt="세로" value="${vo.height}" onblur="numberCheck(this);"/>
										<div class="input-group-addon">px</div>
									</div>
								</div>
								<div class="col-md-2 form-control-static">
									<strong class="text-info">(이미지 세로크기px + 60px)</strong>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="width">상단여백 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" class="form-control text-right" id="topMargin" name="topMargin" maxlength="3" alt="상단여백" value="${vo.topMargin}" onblur="numberCheck(this);"/>
										<div class="input-group-addon">px</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="height">왼쪽여백 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" class="form-control text-right" id="leftMargin" name="leftMargin" maxlength="3" alt="왼쪽여백" value="${vo.leftMargin}" onblur="numberCheck(this);"/>
										<div class="input-group-addon">px</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상태 <i class="fa fa-check"></i></label>
								<div class="radio">
									<label><input type="radio" id="statusCodeY" name="statusCode" alt="상태" value="Y" ${vo ne null && vo.statusCode eq 'Y' ? "checked" :  ""} alt="상태">진행	</label>
									<label><input type="radio" id="statusCodeN" name="statusCode" alt="상태" value="N" ${vo ne null && vo.statusCode eq 'N' ? "checked" :  ""} alt="상태">종료	</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="contentHtml">내용 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<div><textarea name="contentHtml" class="textarea">${vo.contentHtml}</textarea></div>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" id="regBtn" class="btn btn-primary">확인</button>
							<a href="/admin/system/notice/popup/list" class="btn btn-default">취소</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<!-- CK Editor -->
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$(document).ready(function(){
			// Replace the <textarea id="editor1"> with a CKEditor
	        // instance, using default configuration.		
	        CKEDITOR.replace('contentHtml',{
	        	width:'100%',
	        	height:'500',
	        	filebrowserImageUploadUrl: '/admin/editor/upload'
	        });
	        
	        //bootstrap WYSIHTML5 - text editor
	        //$(".textarea").wysihtml5();
		});
	});
	
	var submitProc = function(obj) {
		return checkRequiredValue(obj, "alt");
	};
	
	var callbackProc = function(msg) {
		if(msg.split("^")[0] === "EDITOR") {
			CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.')
		} 
	}
</script>
</body>
</html>