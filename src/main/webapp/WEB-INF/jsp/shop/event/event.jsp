<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/event/event.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="breadcrumb">
	<i class="fa fa-home fa-2x"></i> 홈 <span class="arrow-sub">&gt;</span> <strong>이벤트</strong>
</div>


<ul class="title-list">
	<c:forEach var="item" items="${list}" varStatus="status">
		<li><a href="/shop/event/sub/${item.seq}">${item.title}</a></li>
	</c:forEach>
</ul>

<dl class="content-list">
	<c:forEach var="item" items="${list}" varStatus="status">
		<dt>${item.title}</dt>
		<dd>
			<a href="/shop/event/sub/${item.seq}">
				<img src="${fn:replace(fn:replace(item.thumbImg,"${const.ASSETS_PATH}",const.ASSETS_PATH), "${mallId}",mallVo.id)}" alt="">
			</a>
		</dd>
	</c:forEach>
</dl>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
</body>
</html>