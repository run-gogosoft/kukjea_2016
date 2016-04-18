<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member_finish.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

	<div class="main-title">
		${title}
	</div>

	<%@ include file="/WEB-INF/jsp/shop/include/member_header.jsp" %>

	<div class="finish-wrap">
		<div class="back-image">
			<div class="finish-text-wrap">
				<div class="text1">회원에 가입하여 주셔서 감사합니다.</div>
				<div class="text2">로그인을 하시면 다양한 혜택과 정보를 이용하실 수 있습니다.</div>
			</div>
		</div>
	</div>

	<div class="button-wrap" style="margin-top:5px;">
		<button class="btn btn-confirm" onclick="location.href='/shop/login'"><span>로그인하기</span></button>
		<button class="btn btn-cancel" onclick="location.href='/shop/main'"><span>메인으로</span></button>
	</div>
	<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/member/member.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
</body>
</html>