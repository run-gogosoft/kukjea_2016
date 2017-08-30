<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/jsp/admin/include/header.jsp"%>
    <link href="/admin_lte2/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .thumbViewimg {padding:0;}
        .thumbViewimg div {float:left; text-align:center}
        .thumbViewimg img {margin-right:5px; cursor:pointer; width:168px; height:52px;}
        .detail-content {display:none}
        .detail-image {display:none;}
    </style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp"%>
<div class="content-wrapper">
    <!-- 헤더 -->
    <section class="content-header">
        <h1>배너 관리 <small></small></h1>

        <ol class="breadcrumb">
            <li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
            <li>시스템 관리</li>
            <li class="active">배너 관리</li>
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
                        <input class="form-control" type="hidden" id="name" name="name" value="${vo.name}"/>
                        <input class="form-control" type="hidden" id="statusCode" name="statusCode" value="${vo.statusCode}"/>

                        <div class="box-body">
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label" for="logoImg">몰 배너</label>
                            <div class="col-md-4">
                                <input class="form-control" type="text" id="logoImg" name="logoImg" placeholder="몰 배너이미지를 등록해주세요" style="margin-bottom:5px;" readonly="readonly" <c:if test="${vo eq null}">alt="배너 이미지"</c:if>/>
                                <div class="thumbViewimg"></div>
                            </div>
                            <%--<div class="col-md-10 form-control-static">--%>
                            <div>
                                <button type="button" onclick="showUploadModal()" class="btn btn-success">업로드</button>
                                <label class="col-md-2 control-label"> ! 이미지 크기 168 x 52 </label>
                            </div>
                            <%--</div>--%>
                        </div>
                        <%--</c:if>--%>
                </div>
                <div class="box-footer text-center">
                    <button type="submit" class="btn btn-info">수정하기</button>
                </div>
                </form>
            </div>
        </div>
</div>
</section>

<div id="uploadModal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/admin/mall/form/uploadbanner" enctype="multipart/form-data" target="zeroframe" method="post">
                <div class="modal-body">
                    <legend>이미지 업로드</legend>
                    <p>이미지 크기는 <strong> 168 x 52 </strong>으로 업로드해주시기 바랍니다</p>
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
        html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>배너 이미지</div>";

        $("input[name=logoImg]").val(filename).parents(".form-group").find(".thumbViewimg").html(html);
        $("#uploadModal").modal("hide");
    };

    var uploadMappingProc = function(filename) {
        var html = "";
        html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>배너 이미지</div>";

        $("input[name=logoImg]").parents(".form-group").find(".thumbViewimg").html(html);
        $("#uploadModal").modal("hide");
    };


    var imgProc = function(obj, size) {
        $(obj).css({width:168, height:52});
        if($(obj).width() === 168 && size !== 0) {
            $(obj).css({width:size, height:size});
        } else if(size === 0 && $(obj).width() === 168 ) {
            $(obj).css({width:"auto", height:"auto"});
        } else {
            $(obj).css({width:168, height:52});
        }

    };
</script>
</body>
</html>
