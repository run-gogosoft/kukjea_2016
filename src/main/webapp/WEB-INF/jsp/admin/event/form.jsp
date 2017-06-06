<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<!-- bootstrap wysihtml5 - text editor -->
	<link href="/admin_lte2/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.thumbViewimg {padding:0;}
		.thumbViewimg div {float:left; text-align:center}
		.thumbViewimg img {margin-right:5px; cursor:pointer; width:804px; height:270px;}
		.detail-content {display:none}
		.detail-image {display:none;}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>기획전/이벤트 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>상품 관리</li>
			<li>기획전/이벤트 관리</li>
			<li class="active">기획전/이벤트 등록</li>
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
					<form id="write" class="form-horizontal" method="post" onsubmit="return submitProc(this);" action="<c:choose><c:when test="${vo eq null}">/admin/event/write/proc</c:when><c:otherwise>/admin/event/edit/proc</c:otherwise></c:choose>" target="zeroframe">
						<input class="form-control" type="hidden" name="flag" id="flag"/>
						<div class="box-body">
							<input type="hidden" name="mallSeq" value="${mallSeq}">
							<input type="hidden" name="typeCode" value="1">
							<c:if test="${ vo ne null }">
							<input class="form-control" type="hidden" name="seq" id="seq" value="${ vo.seq }"/>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">등록일</label>
								<div class="col-md-8 form-control-static">
									<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
									<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
								</div>
							</div>
							</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">기획전 / 이벤트 명</label>
								<div class="col-md-8">
									<input class="form-control" type="text" id="title" name="title" value="${ vo.title }" placeholder="기획전/이벤트 명을 입력해주세요"  maxlength="60" alt="기획전/이벤트 명"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="html">html</label>
								<div class="col-md-8">
									<textarea id="html" name="html" alt="html">${ vo.html }</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="thumbImg">리스트 이미지</label>
								<div class="col-md-4">
									<input class="form-control" type="text" id="thumbImg" name="thumbImg" placeholder="리스트 이미지를 등록해주세요" style="margin-bottom:5px;" readonly="readonly" <c:if test="${vo eq null}">alt="리스트 이미지"</c:if>/>
									<div class="thumbViewimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadModal()" class="btn btn-info">업로드</button>
									<label class="col-md-4 control-label"> ! 이미지 크기 804 x 270 </label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="endDate">시작 예정일</label>
								<div class="col-md-2">
									<fmt:parseDate value="${vo.startDate}" var="startDate" pattern="yyyymmdd"/>
									<div class="input-group">
										<input class="form-control datepicker" type="text" id="startDate" name="startDate" value="<fmt:formatDate value="${startDate}" pattern="yyyy-mm-dd"/>" placeholder="시작 예정일을 입력해주세요."  maxlength="10"/>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="endDate">종료 예정일</label>
								<div class="col-md-2">
									<fmt:parseDate value="${vo.endDate}" var="endDate" pattern="yyyymmdd"/>
									<div class="input-group">
										<input class="form-control datepicker" type="text" id="endDate" name="endDate" value="<fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>" placeholder="종료 예정일을 입력해주세요."  maxlength="10"/>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상태</label>
								<div class="radio">
									<label><input type="radio" name="statusCode" alt="상태" value="H" ${vo ne null && vo.statusCode eq 'H' ? "checked" :  ""}>대기</label>
									<label><input type="radio" name="statusCode" alt="상태" value="Y" ${vo ne null && vo.statusCode eq 'Y' ? "checked" :  ""}>진행</label>
									<label><input type="radio" name="statusCode" alt="상태" value="N" ${vo ne null && vo.statusCode eq 'N' ? "checked" :  ""}>종료</label>
								</div>
							</div>
							<div class="form-group" id="showFlag">
								<label class="col-md-2 control-label">노출 여부</label>
								<div class="radio">
									<label><input type="radio" name="showFlag" alt="노출여부" value="Y" ${vo ne null && vo.showFlag eq 'Y' ? "checked" :  ""}>노출	</label>
									<label><input type="radio" name="showFlag" alt="노출여부" value="N" ${vo ne null && vo.showFlag eq 'N' ? "checked" :  ""}>노출안함</label>
								</div>
							</div>
							<div class="form-group" id="lv1Category">
								<label class="col-md-2 control-label">대분류 선택</label>
								<div class="col-md-10">
									<script id="categoryTemplate" type="text/html">
										<option value="">-카테고리 선택-</option>
										{{each value}}
										<option value="<%="${seq}"%>"><%="${name}"%></option>
										{{/each}}
									</script>

									<select class="form-control" id="lv1Seq" name="lv1Seq"><option value="0">-- 대분류 카테고리선택 --</option></select>
								</div>
							</div>
						</div><!-- /.box-body -->
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-md btn-primary" ><c:choose><c:when test="${vo eq null}">등록하기</c:when><c:otherwise>수정하기</c:otherwise></c:choose></button>
							<a href="/admin/event/list?mallSeq=${mallSeq}" class="btn btn-md btn-default">취소하기</a>
						</div><!-- /.box-footer -->
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<div id="uploadModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
		<form action="/admin/event/thumnail/upload" enctype="multipart/form-data" target="zeroframe" method="post">
			<div class="modal-body">
				<legend>이미지 업로드</legend>
				<p>이미지 크기는 <strong> 804 x 270 </strong>으로 업로드해주시기 바랍니다</p>
				<p>이미지가 아닐 경우 업로드 되지 않습니다</p>
				<p>이미지는 jpg, jpeg 확장자만 가능합니다</p>
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

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>

<!-- CK Editor -->
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt]").each( function() {
			if(flag && $(this).val() == "") {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});

		return flag;
	};

	var typeCode = "${vo.typeCode}";
	var lv1Seq = "${vo.lv1Seq}";
	$(document).ready(function () {
		showDatepicker("yy-mm-dd");
		//에디터 textarea 네임 설정
		CKEDITOR.replace('html',{
        	width:'100%',
        	height:'500',
        	filebrowserImageUploadUrl: '/admin/editor/upload'
        });

		if(typeCode == "1"){
			$("#lv1Category").show();
			$("#showFlag").show();
			$("#showFlag input[name=showFlag]").prop('disabled',false);
			$("#showFlag input[name=showFlag]").attr("alt","노출여부");
			$("#lv1Seq").prop('disabled',false);
			$("#lv1Seq").attr("alt","대분류 카테고리");
		}
		if(typeCode == "2"){
			$("#lv1Category").hide();
			$("#showFlag").hide();
			$("#showFlag input[name=showFlag]").prop('disabled',true);
			$("#showFlag input[name=showFlag]").removeAttr("alt");
			$("#lv1Seq").prop('disabled',true);
			$("#lv1Seq").removeAttr("alt");
		}

		$('input:radio[name="typeCode"]').click(function(){
			if($(':radio[name="typeCode"]:checked').val()=="1"){
				$("#lv1Category").show();
				$("#showFlag").show();
				$("#showFlag input[name=showFlag]").prop('disabled',false);
				$("#showFlag input[name=showFlag]").attr("alt","노출여부");
				$("#lv1Seq").prop('disabled',false);
				$("#lv1Seq").attr("alt","대분류 카테고리");
			}
			if($(':radio[name="typeCode"]:checked').val()=="2"){
				$("#lv1Category").hide();
				$("#showFlag").hide();
				$("#showFlag input[name=showFlag]").prop('disabled',true);
				$("#showFlag input[name=showFlag]").removeAttr("alt");
				$("#lv1Seq").prop('disabled',true);
				$("#lv1Seq").removeAttr("alt");
			}
		});

		mallCategoryRenderList(${mallSeq});

		<c:if test="${vo ne null and vo.thumbImg ne ''}">uploadMappingProc("/upload"+"${vo.thumbImg}");</c:if>
	});

	<%--var mallSelect = function(){--%>
		<%--var mallSeq = parseInt($('#mallList option:selected').val(),10);--%>
		<%--mallCategoryRenderList(${mallSeq});--%>
	<%--};--%>

	var mallCategoryRenderList = function(mallSeq){
		//카테고리를 불러온다.
		$.ajax({
			url:"/admin/category/list/simple/ajax",
			type:"get",
			data:{depth:1, parentSeq:0, showFlag:'Y', mallSeq: mallSeq},
			dataType:"text",
			success:function(data) {
				var valueList = {value:[]};
				var list = $.parseJSON(data);
				valueList.value = list;

				if(list.length === 0){
					//최초 몰선택시 좌측상단, 상품검색 대분류 카테고리를 가져온다.
					$('#lv1Seq').html('<option value="0">-- 대분류 카테고리선택 --</option>');
				} else {
					//최초 몰선택시 좌측상단, 상품검색 대분류 카테고리를 가져온다.
					$('#lv1Seq').html($("#categoryTemplate").tmpl(valueList));
					$('#lv1Seq').val(lv1Seq);
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};

	var showUploadModal = function() {
		$("#uploadModal").modal();
		$("#uploadModal").find(".fileinput-button").show().next().hide();
	};

	var submitUploadProc = function(obj) {
		if(!checkFileSize(obj)) {
			return;
		}
		
		$(obj).parents('form')[0].submit();
		$(obj).parents("span").hide().next().show();
	};

	var showDeleteModal = function(imgPath, seq) {
		$('#deleteModalText').text('리스트 이미지');
		$("#deleteModal").find("input[name=imgPath]").val(imgPath);
		$("#deleteModal").find("input[name=imageSeq]").val(seq);
	}

	var callbackProc = function(msg) {
		if(msg.split("^")[0] === "EDITOR") {
			CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.')
		}  else {
			uploadProc(msg);
		}
	};

	var uploadProc = function(filename) {
		var html = "";
		html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>리스트 이미지</div>";

		$("input[name=thumbImg]").val(filename).parents(".form-group").find(".thumbViewimg").html(html);
		$("#uploadModal").modal("hide");
	};

	var uploadMappingProc = function(filename) {
		var html = "";
		html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>리스트 이미지</div>";

		$("input[name=thumbImg]").parents(".form-group").find(".thumbViewimg").html(html);
		$("#uploadModal").modal("hide");
	};

	var imgProc = function(obj, size) {
//		804 || ii.getIconWidth() < 804 && ii.getIconHeight() > 270 || ii.getIconHeight() < 270
		if($(obj).width() === 804 && size !== 0) {
			$(obj).css({width:size, height:size});
		} else if(size === 0 && $(obj).width() === 270 ) {
			$(obj).css({width:"auto", height:"auto"});
		} else {
			$(obj).css({width:804, height:270});
		}
	};
</script>
</body>
</html>
