<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<%--about 사회적경제 헤더 네비게이션--%>
<%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>
<c:import url="${importUrl}" />

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
</body>
</html>