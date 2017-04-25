<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp"%>
	<link href="/admin_lte2/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.thumbViewimg {padding:0;}
		.thumbViewimg div {float:left; text-align:center}
		.thumbViewimg img {margin-right:5px; cursor:pointer; width:243px; height:60px;}
		.detail-content {display:none}
		.detail-image {display:none;}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp"%>
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
						<h3 class="box-title"><i class="fa fa-edit"></i> ${title}</h3>
					</div>
					<!-- 내용 -->
					<form class="form-horizontal" id="mall_form" method="post" target="zeroframe" onsubmit="return doSubmit(this);">
						<input class="form-control" type="hidden" id="checkFlagId" name="checkFlagId" value="N" />
						<input class="form-control" type="hidden" id="validId" name="validId" />
						<input class="form-control" type="hidden" id="seq" name="seq" value="${vo.seq}"/>

						<input class="form-control" type="hidden" id="pg_code" name="pgCode" value="${vo.pgCode}"/>
						<input class="form-control" type="hidden" id="pg_id" name="pgId" value="${vo.pgId}"/>
						<input class="form-control" type="hidden" id="pg_key" name="pgKey" value="${vo.pgKey}"/>

						<%--<div class="form-group">--%>
							<%--<label class="col-md-2 control-label">결제 수단</label>--%>
							<%--<div class="checkbox col-md-10" style="padding-left:15px;">--%>
								<c:forEach var="item" items="${payMethodList}" begin="0" step="1" varStatus="status">
									<c:if test="${!fn:contains(item.value,'+POINT')}">
										<%--<label>--%>
											<input type="hidden" name="payMethod" value="${item.value}" <c:if test="${fn:indexOf(vo.payMethod,item.value) >= 0}">checked</c:if>/>
											 <%--${item.name}--%>
										<%--</label>--%>
									</c:if>
								</c:forEach>
							<%--</div>--%>
						<%--</div>--%>


						<%--<div class="form-group">--%>
							<%--<label class="col-md-2 control-label" for="pg_code">PG 선택</label>--%>
							<%--<div class="col-md-2">--%>
								<%--<select class="form-control" id="pg_code" name="pgCode">--%>
									<%--<option value="">----------선택----------</option>--%>
									<%--<c:forEach var="item" items="${pgList}">--%>
										<%--<option value="${item.value}" <c:if test="${vo.pgCode eq item.value}">selected</c:if>>${item.name}</option>--%>
									<%--</c:forEach>--%>
								<%--</select>--%>
							<%--</div>--%>
						<%--</div>--%>
						<%--<div class="form-group">--%>
							<%--<label class="col-md-2 control-label" for="pg_id">상점 아이디</label>--%>
							<%--<div class="col-md-2">--%>
								<%--<input class="form-control" type="text" id="pg_id" name="pgId" value="${vo.pgId}" style="ime-mode:disabled" maxlength="50"/>--%>
							<%--</div>--%>
						<%--</div>--%>
						<%--<div class="form-group">--%>
							<%--<label class="col-md-2 control-label" for="pg_key">상점 키</label>--%>
							<%--<div class="col-md-2">--%>
								<%--<input class="form-control" type="text" id="pg_key" name="pgKey" value="${vo.pgKey}" maxlength="100"/>--%>
							<%--</div>--%>
						<%--</div>--%>

						<div class="box-body">
							<%--<div class="form-group">--%>
								<%--<label class="col-md-2 control-label" for="id">쇼핑몰 아이디 <i class="fa fa-check"></i></label>--%>
						<%--<c:choose>--%>
							<%--<c:when test="${vo eq null}">--%>
								<%--<div class="col-md-2">--%>
									<%--<input class="form-control alphanumeric" type="text" id="id" name="id" maxlength="20" alt="아이디" placeholder="2~20자 이내"/>--%>
								<%--</div>--%>
								<%--<div class="col-md-1 form-control-static">--%>
									<%--<button type="button" id="checkId" class="btn btn-xs btn-warning">아이디 중복체크</button>--%>
								<%--</div>--%>
							<%--</c:when>--%>
							<%--<c:otherwise>--%>
								<%--<div class="col-md-2 form-control-static">${vo.id}</div>--%>
							<%--</c:otherwise>--%>
						<%--</c:choose>--%>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="name">쇼핑몰명 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="name" name="name" value="${vo.name}" maxlength="15" alt="쇼핑몰명"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="searchkey1">대표검색어 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="searchkey1" name="searchkey1" value="${vo.searchkey1}" maxlength="15" alt="대표검색어"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="searchkey2"></label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="searchkey2" name="searchkey2" value="${vo.searchkey2}" maxlength="15" alt="쇼핑몰명"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="searchkey3"></label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="searchkey3" name="searchkey3" value="${vo.searchkey3}" maxlength="15" alt="쇼핑몰명"/>
								</div>
							</div>
							<%--<div class="form-group">--%>
								<%--<label class="col-md-2 control-label" for="password">패스워드<c:if test="${vo eq null}"> <i class="fa fa-check"></i></c:if></label>--%>
								<%--<div class="col-md-2">--%>
									<%--<input class="form-control" type="password" id="password" name="password" maxlength="20" placeholder="영문+숫자+특수문자 8~20자" <c:if test="${vo eq null}">alt="패스워드"</c:if>/>--%>
								<%--</div>--%>
							<%--</div>--%>
							<%--<div class="form-group">--%>
								<%--<label class="col-md-2 control-label" for="password_confirm">패스워드 확인<c:if test="${vo eq null}"> <i class="fa fa-check"></i></c:if></label>--%>
								<%--<div class="col-md-2">--%>
									<%--<input class="form-control" type="password" id="password_confirm" maxlength="20" <c:if test="${vo eq null}">alt="패스워드 확인"</c:if>/>--%>
								<%--</div>--%>
							<%--</div>--%>
							<%--<c:if test="${vo ne null}">--%>
							<div class="form-group">
								<label class="col-md-2 control-label">쇼핑몰 상태 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" name="statusCode" alt="상태">
										<option value="">--선택--</option>
										<c:forEach var="item" items="${statusList}">
											<option value="${item.value}" <c:if test="${vo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
										</c:forEach>

									</select>
								</div>
							</div>
							<%--</c:if>--%>
							<%--&lt;%&ndash;--%>
							<%--<div class="form-group">--%>
								<%--<label class="col-md-2 control-label" for="url">쇼핑몰 URL</label>--%>
								<%--<div class="col-md-4">--%>
									<%--<input class="form-control" type="text" id="url" name="url" value="${vo.url}" maxlength="100"/>--%>
								<%--</div>--%>
							<%--</div>--%>
							<%--&ndash;%&gt;--%>


							<%--&lt;%&ndash;<div class="form-group">&ndash;%&gt;--%>
								<%--&lt;%&ndash;<label class="col-md-2 control-label" for="thumbImg">광고 배너 이미지</label>&ndash;%&gt;--%>
								<%--&lt;%&ndash;<div class="col-md-4">&ndash;%&gt;--%>
									<%--&lt;%&ndash;<input class="form-control" type="text" id="thumbImg" name="thumbImg" placeholder="배너 이미지를 등록해주세요" style="margin-bottom:5px;" readonly="readonly" <c:if test="${vo eq null}">alt="배너 이미지"</c:if>/>&ndash;%&gt;--%>
									<%--&lt;%&ndash;<div class="thumbViewimg"></div>&ndash;%&gt;--%>
								<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
								<%--&lt;%&ndash;<div>&ndash;%&gt;--%>
									<%--&lt;%&ndash;<button type="button" onclick="showUploadModal()" class="btn btn-info">업로드</button>&ndash;%&gt;--%>
									<%--&lt;%&ndash;<label class="col-md-4 control-label"> ! 이미지 크기 230 x 70 </label>&ndash;%&gt;--%>
								<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
							<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
							<%--<c:if test="${vo ne null}">--%>
								<%--<c:if test="${vo.openDate ne ''}">--%>
									<%--<div class="form-group">--%>
										<%--<label class="col-md-2 control-label">오픈 일자</label>--%>
										<%--<div class="col-md-10 form-control-static">${fn:substring(vo.openDate,0,10)}</div>--%>
									<%--</div>--%>
								<%--</c:if>--%>
								<%--<c:if test="${vo.closeDate ne ''}">--%>
									<%--<div class="form-group">--%>
										<%--<label class="col-md-2 control-label">폐쇄 일자</label>--%>
										<%--<div class="col-md-10 form-control-static">${fn:substring(vo.closeDate,0,10)}</div>--%>
									<%--</div>--%>
								<%--</c:if>--%>
								<%--<c:if test="${vo.modDate ne ''}">--%>
									<%--<div class="form-group">--%>
										<%--<label class="col-md-2 control-label">최종 수정 일자</label>--%>
										<%--<div class="col-md-10 form-control-static">${fn:substring(vo.modDate,0,10)}</div>--%>
									<%--</div>--%>
								<%--</c:if>--%>
								<%--<c:if test="${vo.regDate ne ''}">--%>
									<%--<div class="form-group">--%>
										<%--<label class="col-md-2 control-label">등록 일자</label>--%>
										<%--<div class="col-md-10 form-control-static">${fn:substring(vo.regDate,0,10)}</div>--%>
									<%--</div>--%>
								<%--</c:if>--%>
								<div class="form-group">
									<label class="col-md-2 control-label" for="logoImg">몰 로고</label>
									<div class="col-md-4">
										<input class="form-control" type="text" id="logoImg" name="logoImg" value="${vo.logoImg}" placeholder="몰 로고이미지를 등록해주세요" style="margin-bottom:5px;" readonly="readonly" <c:if test="${vo eq null}">alt="배너 이미지"</c:if>/>
										<div class="thumbViewimg"></div>
									</div>
									<%--<div class="col-md-10 form-control-static">--%>
										<div>
											<button type="button" onclick="showUploadModal()" class="btn btn-success">업로드</button>
											<label class="col-md-2 control-label"> ! 이미지 크기 243 x 60 </label>
										</div>
									<%--</div>--%>
								</div>
							<%--</c:if>--%>
						</div>
						<div class="box-footer text-center">
							<c:choose>
								<c:when test="${vo eq null}"><button type="submit" class="btn btn-info">등록하기</button></c:when>
								<c:otherwise><button type="submit" class="btn btn-info">수정하기</button></c:otherwise>
							</c:choose>
							<button type="button" onclick="javascript:history.go(-1);" class="btn btn-default">목록보기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<div id="uploadModal" class="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="/admin/mall/form/upload" enctype="multipart/form-data" target="zeroframe" method="post">
					<div class="modal-body">
						<legend>이미지 업로드</legend>
						<p>이미지 크기는 <strong> 243 x 60 </strong>으로 업로드해주시기 바랍니다</p>
						<p>이미지가 아닐 경우 업로드 되지 않습니다</p>
						<p>이미지는 gif,jpg, jpeg 확장자만 가능합니다</p>
					</div>
					<div class="modal-footer">
						<a data-dismiss="modal" class="btn btn-default" href="#">취소</a>
				<span class="btn btn-success fileinput-button">
					<i class="fa fa-plus"></i>
					<span>이미지 첨부하기...</span>
					<input type="file" name="file[0]" value="" onchange="submitUploadProc(this);" />
				</span>
				<span>
					<img src="/assets/img/common/ajaxloader.gif" alt=""/>
				</span>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<!-- CK Editor -->
<%--<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>--%>

<script type="text/javascript">
	$(document).ready(function(){
//		CKEDITOR.replace('html',{
//			width:'100%',
//			height:'60',
//			filebrowserImageUploadUrl: '/admin/editor/upload'
//		});
		//아이디 입력칸 숫자,영문만 입력되도록....
		$(".alphanumeric").css("ime-mode", "disabled").alphanumeric();
		uploadMappingProc("/upload"+"${vo.logoImg}");
	});

	var mallTypeSelected = function(obj) {
		if($(obj).val() === '90') {
			$('#joinFlagDiv').hide();
			$('#mobileFlagDiv').hide();
		} else {
			$('#joinFlagDiv').show();
			$('#mobileFlagDiv').show();
		}
	};

	/** 폼 전송 */
	var doSubmit = function(frmObj) {
		//필수값 체크
		var submit = checkRequiredValue(frmObj, "alt");

		if(submit) {
			if(${vo eq null}) {
				if ($('#id').val() !== $("#validId").val()) {
					$.msgbox("아이디 중복체크를 해주세요.", {type: "error"});
					return false;
				}
			}

			if($("#password").val() != $("#password_confirm").val()) {
				alert("패스워드가 일치하지 않습니다.");
				$("#password").focus();
				return false;
			}

			// 등록/수정 action URL 구분 셋팅
			$(frmObj).attr("action","/admin/mall/reg");
			var confirmMsg = "등록 하시겠습니까?";
			var seq = $(frmObj).find("#seq").val();
			if(  seq > 0 ) {
				$(frmObj).attr("action","/admin/mall/mod");
				confirmMsg = "수정 하시겠습니까?";
			}

			if(!confirm(confirmMsg)) {
				return false;
			}
		}
		return submit;
	};

	/* 아이디 중복체크 */
	$("#checkId").click(function() {
		var id = $("#id").val();
		//아이디 입력여부 검사
		if(id === "") {
			$.msgbox("아이디를 입력해주세요.", {type: "error"});
			$("#id").focus();
			return false;
		}
		//ajax:아이디중복체크
		$.ajax({
			type: 'POST',
			data: {id:id},
			dataType: 'json',
			url: '/admin/system/check/mall/id/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message, {type: "info"});
					$("#checkFlagId").val("Y");
					$("#validId").val($("#id").val());
				} else {
					$.msgbox(data.message, {type: "error"});
					$("#id").focus();
				}
			}
		})
	});

	var submitUploadProc = function(obj) {
		if(!checkFileSize(obj)) {
			return;
		}

		$(obj).parents('form')[0].submit();
		$(obj).parents("span").hide().next().show();
	};

	var showUploadModal = function() {
		$("#uploadModal").modal();
		$("#uploadModal").find(".fileinput-button").show().next().hide();
	};

	var callbackProc = function(msg) {
//		if(msg.split("^")[0] === "EDITOR") {
//			CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.')
//		}  else {
			uploadProc(msg);
//		}
	};


	var uploadProc = function(filename) {
		var html = "";
		html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>로고 이미지</div>";

		$("input[name=logoImg]").val(filename).parents(".form-group").find(".thumbViewimg").html(html);
		$("#uploadModal").modal("hide");
	};

	var uploadMappingProc = function(filename) {
		var html = "";
		html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>로고 이미지</div>";

		$("input[name=logoImg]").parents(".form-group").find(".thumbViewimg").html(html);
		$("#uploadModal").modal("hide");
	};


	var imgProc = function(obj, size) {
		$(obj).css({width:243, height:60});
		if($(obj).width() === 243 && size !== 0) {
			$(obj).css({width:size, height:size});
		} else if(size === 0 && $(obj).width() === 243 ) {
			$(obj).css({width:"auto", height:"auto"});
		} else {
			$(obj).css({width:243, height:60});
		}

	};
</script>
</body>
</html>
