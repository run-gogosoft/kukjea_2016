<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/main/main.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/login/login.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<!--[if lt IE 9]>
		<style type="text/css">
			.ch-hero-list li .circle {
				width:10px;
			}

			.ch-long-list li .circle {
				width:6px;
			}
		</style>
	<![endif]-->
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="main-title">
	로그인
</div>

<div class="main-description">
	서울시가 운영하는 사회적 경제 기업 전용 쇼핑몰 <span>함께누리</span>입니다!
</div>

<div class="login-wrap">
	<%-- 회원 --%>
	<div class="member-login">
		<div class="title"><span>회원님</span>의 함께누리 아이디와 패스워드를 입력하세요!</div>
		<div class="login-box-wrap">
			<form id="memberLoginForm" method="post" action="/shop/login/proc" target="zeroframe" onsubmit="return submitProc(this);">
				<input type="hidden" name="DirectURL" value="${DirectURL}">

				<div class="login-box">
					<div class="item-box">
						<input type="text" id="loginId" name="id" class="form-control" placeholder="아이디" alt="아이디">
						<input type="password" id="password" name="password" class="form-control" style="margin-top:8px;" placeholder="비밀번호" maxlength="16" alt="비밀번호">
					</div>
					<button type="submit" class="item-box btn member-button">
						<img src="${const.ASSETS_PATH}/front-assets/images/login/member_button.png" alt="회원 로그인"/>
					</button>
				</div>

				<div class="remember-id">
					<input type="checkbox" id="rememberLoginId" name="rememberLoginId" />
					<label for="rememberLoginId" style="font-weight: normal;color:#979797;font-size:11px;">아이디 저장</label>
				</div>
			</form>
		</div>
		<ol class="login-description">
			<li>구매시 매번 이름 주소를 번거롭게 입력하실 필요가 없습니다.</li>
			<li>회원가입시 이메일주소를 가입하시면 함께누리몰 안내메일을 받아보실 수 있습니다.</li>
			<li>필요하신 계산서 등 서류출력이 가능합니다.</li>
			<li>기관의 경우 구매실적 확인 및 조회가 가능합니다.</li>
			<li>부가서비스를 자유롭게 이용할 수 있으며 각종 이벤트에 참여하실 수 있습니다.</li>
		</ol>
	</div>

	<%-- 비회원 --%>
	<div class="member-login">
		<div class="title"><span>비회원구매</span>확인을 위해 구매자명과 이메일을 입력하세요!</div>
		<div class="login-box-wrap">
			<form id="nonMemberLoginForm" method="post" action="/shop/notlogin/proc" target="zeroframe" onsubmit="return submitProc(this);">
				<div class="login-box">
					<div class="item-box">
						<input type="text" class="form-control" name="name" placeholder="구매자명" alt="구매자명">
						<input type="text" class="form-control" name="email" style="margin-top:8px;" placeholder="이메일" alt="이메일">
					</div>
					<button class="item-box btn non-member-button">
						<img src="${const.ASSETS_PATH}/front-assets/images/login/non_member_button.png" alt="비회원 로그인"/>
					</button>
				</div>

				<!-- <div class="remember-id">
					<input type="checkbox" id="rememberLoginId" name="rememberLoginId" />
					<label for="rememberLoginId" style="font-weight: normal;color:#979797;font-size:11px;">아이디 저장</label>
				</div> -->
			</form>
		</div>
		<ol class="login-description">
			<li>비회원 로그인의 경우 기존 주문내역이 있는 경우에만 로그인 가능합니다.</li>
		</ol>
	</div>
</div>

<div class="login-bottom">
	<div class="element-wrap">
		<img src="${const.ASSETS_PATH}/front-assets/images/login/signup_icon.png" alt="회원가입 아이콘">
		<div class="description"><span class="bold-text">함께누리 회원이 아니세요?</span> 회원이 되시면 다양한 회원혜택과 새소식을 만나실수 있습니다.</div>
		<div class="button-box">
			<button class="btn" onclick="location.href='/shop/member/group'">
				<img src="${const.ASSETS_PATH}/front-assets/images/login/signup_button.png" alt="회원가입">
			</button>
		</div>
	</div>
</div>
<div class="login-bottom" style="margin:0 auto 30px auto;">
	<div class="element-wrap">
		<img src="${const.ASSETS_PATH}/front-assets/images/login/find_info_icon.png" class="find-icon-img" alt="아이디/비밀번호 찾기 아이콘">
		<div class="description" style="margin-left:15px;"><span class="bold-text">로그인에 문제가 있으세요?</span> 비밀번호를 잊어버리셨습니까? 지금 바로 조회 하실수 있습니다.</div>
		<div class="button-box" style="margin-top:0;">
			<button class="btn" onclick="CHFindPassUtil.IdWriteButton();">
				<img src="${const.ASSETS_PATH}/front-assets/images/login/find_info_button.png" alt="아이디/비밀번호 찾기">
			</button>
		</div>
	</div>
</div>

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
					<hr style="margin-bottom: 0;" />
					<div style="margin: 10px 0 0 20px;color: #B4B4B4;">◇ 임시 비밀번호가 이메일로 전송됩니다.</div>
					<table class="table">
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
					<hr style="margin-bottom: 0;" />
					<div style="margin: 10px 0 0 20px;color: #B4B4B4;">◇ 아이디가 이메일로 전송됩니다.</div>
					<table class="table">
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

${fn:replace(loginBanner,"${const.ASSETS_PATH}",const.ASSETS_PATH)}
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/main/main.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//checked rememberLoginId
		if($.cookie("lastLoginId") != undefined && $.cookie("lastLoginId") != "") {
			$("#rememberLoginId").prop("checked", true);
			$("#loginId").val($.cookie("lastLoginId"));
		}

		$('#getEmail').change(function(){
			$('#email2').val($('#getEmail').val());
		});
	});

	var numberCheck = function(obj){
		obj.value=obj.value.replace(/[^\d]/g, '');
	};

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

	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "") {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});

		//아이디 기억하기
		if($("#rememberLoginId").is(":checked")) {
			$.cookie("lastLoginId", $("#loginId").val(), {expires:7});
		} else {
			$.removeCookie("lastLoginId");
		}

		return flag;
	};
</script>
</body>
</html>