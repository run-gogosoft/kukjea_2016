<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/member_confirm.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		#popup-zone {
      margin-top:-5px;
    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="body-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>

	<div class="main-content-wrap">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 나의정보 <span class="breadcrumb-arrow">&gt;</span> <strong>개인정보 관리/수정</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는 기재하신 회원정보가 공개되지 않습니다.</div>
		<div class="board-title-sub">
			<div>고객님의 회원정보를 수정하실 수 있습니다.</div>
			<div>보다 다양한 서비스를 받으시려면 정확한 정보를 항상 유지해 주셔야 합니다.</div>
			<div>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</div>
		</div>
		<form class="form-horizontal" role="form" method="post" onsubmit="return submitProc(this);" action="/shop/mypage/confirm/proc?member=mod" target="zeroframe">
			<div class="sign-form form2" style="margin-top:55px;">
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">함께누리 회원을 확인합니다.</div>
							<div class="sub-description">현재 사용중인회원님의 아이디입니다. 패스워드를 입력해 주세요</div>
						</div>
					</div>

						<table class="table sign-table">
							<tr>
								<td>회원 아이디</td>
								<td>
									<span style="color:#ff00ff;letter-spacing:0;">${sessionScope.loginId}</span>
								</td>
							</tr>
							<tr>
								<td>회원 패스워드</td>
								<td>
									<input type="password" id="password" name="password" class="form-control password" maxlength="16"  alt="비밀번호">
									<span class="description">8~16자의 영문과 숫자가 포함이 되어야 합니다.</span>
								</td>
							</tr>
						</table>

				</div>
			</div>

			<div class="button-wrap">
				<div class="inner"><button type="submit" class="btn btn-buy"><span>확인</span></button></div>
			</div>
		</form>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each(function () {
			if (flag && $(this).val() == "" || flag && $(this).val() == 0) {
				alert($(this).attr("alt") + "란을 입력해주세요!");
				flag = false;
				$(this).focus();
			}
		});
		return flag;
	}
</script>
</body>
</html>