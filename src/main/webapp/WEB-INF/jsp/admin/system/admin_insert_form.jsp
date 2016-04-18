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
		<h1>어드민 관리자 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">어드민 관리자</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-edit"></i> 관리자 신규 등록</h3>
					</div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="/admin/system/admin/insert" target="zeroframe" onsubmit="return doSubmit(this);" class="form-horizontal">
						<input type="hidden" id="checkFlagId" name="checkFlagId" value="N" />
						<input type="hidden" id="checkFlagNickName" name="checkFlagNickName" value="N" />
						<input type="hidden" id="validNickName" name="validNickName" />
						<div class="box-body">				
						
							<!-- <div class="form-group">
								<label for="" class="col-md-2 control-label"></label>
								<div class="col-md-10">
									<input type="text" class="form-control" id="">
								</div>
							</div> -->
							
							<div class="form-group">
								<label for="id" class="col-md-2 control-label">아이디 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="id" name="id" maxlength="20" required="required"/>
								</div>
								<div class="col-md-1 form-control-static">
									<button type="button" id="checkId" class="btn btn-xs btn-warning">아이디 중복체크</button>
								</div>								
							</div>
							<div class="form-group">
								<label for="name" class="col-md-2 control-label">이름 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<input type="text" id="name" name="name" class="form-control" maxlength="20" required="required" />
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-md-2 control-label">비밀번호 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<input type="password" class="form-control" id="password" name="password" maxlength="20" required="required"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="passwordConfirm">비밀번호 확인 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<input type="password" id="passwordConfirm" name="passwordConfirm" class="form-control" maxlength="20" required="required" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="nickname">닉네임 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<input type="text" id="nickname" name="nickname" class="form-control" maxlength="20" required="required" />
								</div>
								<div class="col-md-1 form-control-static">
									<button type="button" id="checkNickName" class="btn btn-warning btn-xs">닉네임 중복체크</button>
								</div>
								<div class="col-md-7">
									<span class="text-danger">
										<i class="fa fa-fw fa-info"></i>추후 문의 답변 또는 CS 등 외부에 노출될 수 있는 이름입니다.
										실제 입점업체 또는 고객사가 알아볼 수 있는 명칭을 사용해 주세요.
									</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="statusCode">상태 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<select id="statusCode" name="statusCode" class="form-control" required="required">
										<option value="">선택</option>
										<option value="Y">정상</option>
										<option value="H">승인대기</option>
										<option value="N">중지</option>
										<option value="X">탈퇴</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="gradeCode">등급 <i class="fa fa-fw fa-check"></i></label>
								<div class="col-md-2">
									<select id="gradeCode" name="gradeCode" class="form-control" required="required">
										<option value="">선택</option>
										<option value="0">연구소</option>
										<option value="1">최고 관리자</option>
										<option value="2">운영 관리자</option>
										<option value="3">디자이너</option>
										<option value="4">정산 관리자</option>
										<option value="5">CS 관리자</option>
										<option value="9">일반</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="email">이메일</label>
								<div class="col-md-2">
									<input type="text" id="email" name="email" class="form-control" maxlength="50" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="tel">전화번호</label>
								<div class="col-md-2">
									<input type="text" id="tel" name="tel" class="form-control" maxlength="20" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="cell">휴대폰 번호</label>
								<div class="col-md-2">
									<input type="text" id="cell" name="cell" class="form-control" maxlength="20" />
								</div>
							</div>
						</div><!-- /.box-body -->
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-info">등록하기</button>
							<a href="/admin/system/admin/list" class="btn btn-default">목록보기</a>
						</div><!-- /.box-footer -->
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	//새로고침시 아이디중복체크 초기화
	$(document).ready(function() {
		$("#checkFlagId").val("N");
	});

	//관리자 등록
	var doSubmit = function(frmObj) {
		//아이디 중복검사 여부
		if($("#checkFlagId").val() === "N") {
			$.msgbox("아이디 중복체크를 해주세요.", {type: "error"});
			return false;
		}
		//닉네임 중복검사 여부
		if($('#nickname').val() !== $("#validNickName").val()){
			$.msgbox("닉네임 중복체크를 해주세요.", {type: "error"});
			return false;
		}
		//필수값 체크
		var submit = checkRequiredValue(frmObj, "data-required-label");
		//submit
		if(submit) {
			if($("#password").val() != $("#passwordConfirm").val()) {
				alert("패스워드가 일치하지 않습니다.");
				$("#password").focus();
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
			url: '/admin/system/check/id/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message, {type: "info"});
					$("#checkFlagId").val("Y");
				} else {
					$.msgbox(data.message, {type: "error"});
					$("#id").focus();
				}
			}
		})
	});

	/** 닉네임 중복 체크 */
	$("#checkNickName").click(function() {
		var nickname = $("#nickname").val();
		//닉네임 입력여부 검사
		if(nickname === "") {
			$.msgbox("닉네임을 입력해주세요.");
			$("#nickname").focus();
			return;
		}

		//ajax:닉네임중복체크
		$.ajax({
			type: 'POST',
			data: {nickname:nickname},
			dataType: 'json',
			url: '/admin/system/check/nickname/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message, {type: "info"});
					$("#checkFlagNickName").val("Y");
					$("#validNickName").val($("#nickname").val());
				} else {
					$.msgbox(data.message, {type: "error"});
					$("#nickname").focus();
				}
			}
		})
	});
</script>
</body>
</html>
