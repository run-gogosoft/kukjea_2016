<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
</head>
<body>

<div id="skip_navi">
	<p><a href="#contents">본문바로가기</a></p>
</div>

<div id="wrap" class="sub">
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>

	<div id="container">
		<div id="contents" class="login">
			<h2>로그인</h2>
			<div class="login_box">
				<form action="/shop/login/proc" method="post" target="zeroframe" onsubmit="return submitProc(this);">
					<fieldset>
						<legend>로그인</legend>
						<dl>
							<dt><label for="loginId">아이디</label></dt>
							<dd><input type="text" class="intxt" id="loginId" name="id" maxlength="16" title="아이디 입력" /></dd>
						</dl>
						<dl>
							<dt><label for="userPw">패스워드</label></dt>
							<dd><input type="password" class="intxt" id="userPw" name="password" maxlength="16" title="패스워드 입력" /></dd>
						</dl>
						<div class="save_id">
							<input type="checkbox" id="rememberLoginId" name="rememberLoginId" />
							<label>아이디 저장</label>
						</div>

						<div class="login_links">
							<a href="/shop/cscenter/member/start" class="btn_join">회원가입</a>
							<span>|</span>
							<a href="/shop/cscenter/search/id" class="btn_find_idpw">ID / PW 찾기</a>
						</div>
						<p>- 로그인을 하시면, 국제몰닷컴의 서비스를 보다 원활하게 이용하실 수 있습니다.</p>

						<button type="submit" class="btn_login">로그인</button>
					</fieldset>
				</form>
			</div>
		</div>
	</div>

	${loginBanner}

	<div id="footer">
		<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
	</div>
</div>
<script>
	$(document).ready(function() {
		//checked rememberLoginId
		if($.cookie("lastLoginId") != undefined && $.cookie("lastLoginId") != "") {
			$("#rememberLoginId").prop("checked", true);
			$("#loginId").val($.cookie("lastLoginId"));
		}
	});
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
