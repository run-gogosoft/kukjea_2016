<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <title>함께누리몰 어드민</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <!-- Bootstrap 3.3.4 -->
    <link href="/front-assets/css/login/login.css" rel="stylesheet" type="text/css" />
    <link href="/assets/admin_lte2/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="/assets/admin_lte2/dist/css/AdminLTE.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="/assets/admin_lte2/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />
	<!-- jQuery message box -->
	<link href="/assets/js/plugins/msgbox/jquery.msgbox.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!--[if lte IE 8]>
			<style type="text/css">
				.main-logo-img { height:70px };
			</style>
    <![endif]-->
</head>
<body class="login-page">
	<div class="main-logo">
		<img src="/assets/img/main_logo.png" class="main-logo-img" alt="함께누리 로고"/>
	</div>

	<div class="admin-description"></div>

	<div class="login-box">
		<div class="login-logo login-description"></div>
		<!-- /.login-logo -->
		<div class="login-box-body" style="box-shadow:4px 5px 10px rgba(128, 128, 128, 0.8);">
			<!-- <h4 class="login-box-msg">함께누리몰 어드민<h4> -->
			<form method="post" action="/admin/login/proc" target="zeroframe" onsubmit="return loginSubmit();" class="text-center">
				<div class="col-xs-5" style="float:none; display:inline-block; padding:0;">
					<div class="form-group has-feedback" style="margin-bottom:5px;">
						<input type="text" id="id" name="id" class="form-control" style="display:inline-block; font-size:12px;" placeholder="아이디" />
					</div>
					<div class="form-group has-feedback">
						<input type="password" id="password" name="password" class="form-control" style="display:inline-block; font-size:12px;" placeholder="패스워드" />
						<span class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>
				</div>
				<button type="submit" class="btn btn-primary btn-flat col-xs-5 btn-login">Login</button>
				<div class="row text-center">
					<div class="col-xs-7">
						<div class="checkbox icheck">
							<label class="pull-left"><input type="checkbox" id="rememberLoginId" name="rememberLoginId"/> 아이디 기억하기</label>
						</div>
					</div>
					<div class="col-xs-5">
						<div class="checkbox icheck">
							<label class="text-muted" onclick="CHFindPassUtil.IdWriteButton();">
								아이디/비밀번호 찾기
							</label>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="text-right" style="margin-top:10px; font-size:12px; color:#888888;">이용문의: 함께누리몰 고객지원센터 <strong class="text-primary">02-2222-3896</strong> ( <strong class="text-primary">hknuri@happyict.co.kr</strong> )</div>
		<div class="text-warning text-right" style="font-size:12px;color:#787878;">
			<strong><i class="fa fa-exclamation"></i></strong>&nbsp;<strong>IE9</strong> 이상의 브라우저에 최적화 되어 있습니다.
		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->

<%--비밀번호 찾기--%>
<div id="findPassword" class="hh-writebox-find-password" style="height:395px;">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header" style="padding-top:0;height:39px;background-color:#fff;">
			<ul class="nav nav-tabs">
				<li><a href="javascript:CHFindPassUtil.IdWriteButton()" style="font-weight:bold;">아이디 찾기</a></li>
				<li class="active"><a href="javascript:CHFindPassUtil.writeButton()" style="background-color:#4DB7C9;font-weight:bold;color:#fff;">비밀번호찾기</a></li>
			</ul>
		</div>
		<div class="hh-writebox-content">
			<form class="form-horizontal" name="passwordSearchForm" role="form" method="post" onsubmit="return CHFindPassUtil.findPassProc(this);" action="/shop/member/password/proc" target="zeroframe">
				<div class="hh-writebox-customer">
					<img src="${const.ASSETS_PATH}/front-assets/images/login/member-pw-sub-title.png" style="margin-top: 20px;" alt="비밀번호 찾기">
					<table class="table">
						<tr>
							<td>구분</td>
							<td>
								<select name="typeCode" class="form-control">
									<option value="S">판매자</option>
									<option value="A">관리자</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><input type="text" id="id" name="id" class="form-control" maxlength="50" style="width: 245px;" alt="아이디" /></td>
						</tr>
						<tr>
							<td>Email</td>
							<td><input type="text" id="email" name="email" class="form-control" maxlength="60" style="width: 245px;" alt="Email" /></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" id="name" name="name" class="form-control" maxlength="15" style="width: 245px;" alt="이름" /></td>
						</tr>
					</table>
				</div>

				<div class="hh-writebox-footer" style="margin-top:30px;">
					<div class="inner">
						<button type="submit" id="submitBtn" class="btn btn-qna-submit">확인</button>
						<button type="button" onclick="CHFindPassUtil.writeClose()" class="btn btn-qna-cancel">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<%--아이디 찾기--%>
<div id="findId" class="hh-writebox-find-password" style="height:395px;">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header" style="padding-top:0;height:39px;background-color:#fff">
			<ul class="nav nav-tabs">
				<li class="active"><a href="javascript:CHFindPassUtil.IdWriteButton()" style="background-color:#4DB7C9;font-weight:bold;color:#fff;">아이디 찾기</a></li>
				<li><a href="javascript:CHFindPassUtil.writeButton()" style="font-weight:bold;">비밀번호찾기</a></li>
			</ul>
		</div>
		<div class="hh-writebox-content">
			<form class="form-horizontal" name="idSearchForm" role="form" method="post" onsubmit="return CHFindPassUtil.findPassProc(this);" action="/shop/member/id/proc" target="zeroframe">
				<div class="hh-writebox-customer">
					<img src="${const.ASSETS_PATH}/front-assets/images/login/member-id-title.png" style="margin-top: 20px;" alt="아이디 찾기">
					<table class="table">
						<tr>
							<td>구분</td>
							<td>
								<select name="typeCode" class="form-control">
									<option value="S">판매자</option>
									<option value="A">관리자</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Email</td>
							<td><input type="text" id="email" name="email" class="form-control" maxlength="60" style="width: 245px;" alt="Email" /></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" id="name" name="name" class="form-control" maxlength="15" style="width: 245px;" alt="이름" /></td>
						</tr>
					</table>
				</div>
				<div class="hh-writebox-footer">
					<div class="inner">
						<button type="submit" id="submitBtn" class="btn btn-qna-submit">확인</button>
						<button type="button" onclick="CHFindPassUtil.writeClose()" class="btn btn-qna-cancel">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<!--제로프레임 -->
<iframe id="zeroframe" name="zeroframe" width="0" height="0" frameborder="0"></iframe>

<!-- jQuery 2.1.4 -->
<script src="/assets/admin_lte2/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="/assets/admin_lte2/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="/assets/admin_lte2/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

<!-- jQuery cookie -->
<script src="/assets/js/libs/jquery.cookie-1.4.0.js"></script>
<!-- jQuery message box -->
<script src="/assets/js/plugins/msgbox/jquery.msgbox.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var width = $(window).width();
		if(width > 940) {
			$('.admin-description').html('서울시가 운영하는 사회적 경제 기업 전용 쇼핑몰 <span>함께누리 어드민 로그인</span> 입니다!');
		} else {
			$('.admin-description').html('서울시가 운영하는 사회적 경제 기업 전용 쇼핑몰 <br/><span>함께누리 어드민 로그인</span> 입니다!');
		}

		if(width > 640) {
			$('.login-description').html('<strong>관리자</strong>만 접속이 가능합니다. <strong>관리자</strong> 아이디와 패스워드를 입력하세요!');
		} else {
			$('.login-description').html('<strong>관리자</strong>만 접속이 가능합니다. <br/><strong>관리자</strong> 아이디와 패스워드를 입력하세요!');
		}

		//alert
		if (location.search === "?status=expired") {
			$.msgbox("세션이 만료되었습니다");
		}

		//checked rememberLoginId
		if($.cookie("lastLoginId") != undefined && $.cookie("lastLoginId") != "") {
			$("#rememberLoginId").prop("checked", true);
			$("#id").val($.cookie("lastLoginId"));
		}

		 $('input').iCheck({
	         checkboxClass: 'icheckbox_square-blue',
	         radioClass: 'iradio_square-blue',
	         increaseArea: '20%' // optional
	       });
	});
	
	var CHFindPassUtil = {
		writeButton:function (){
			$("#findId").hide();
			$("#findPassword").show();
		}
		, IdWriteButton:function (){
			$("#findId").show();
			$("#findPassword").hide();
		}
		, writeClose:function () {
			$('#findId').val("");
			$('#findEmail').val("");
			$('#findName').val("");
			$("#findPassword").hide();
			$("#findId").hide();
		}
		, findPassProc:function(obj) {
			var flag = true;
			$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
				if(flag && $(this).val() == "") {
					alert($(this).attr("alt") + "란을 입력해주세요!");
					flag = false;
					$(this).focus();
				}
			});
			return flag;
		}
	};

	var loginSubmit = function() {
		if($("#id").val() == "") {
			$.msgbox("아이디를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if($("#password").val() == "") {
			$.msgbox("비밀번호를 입력해주세요.");
			$("#id").focus();
			return false;
		}

		//아이디 기억하기
		if($("#rememberLoginId").is(":checked")) {
			$.cookie("lastLoginId", $("#id").val(), {expires:7});
		} else {
			$.removeCookie("lastLoginId");
		}

		return true;
	}

</script>
</body>
</html>
