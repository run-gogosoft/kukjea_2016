<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
	<title>about 입점업체 정보</title>
</head>
<body>
<%--about 사회적경제 헤더 네비게이션--%>
<%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>

<div style="margin:0 auto; width:1080px; background-color:#fff">
	<img src="/front-assets/images/about/header_seller.png" alt="입점업체 정보" />
</div>
	
<div style="margin:0 auto; width:1080px; background-color:#fff; padding-top: 50px;">
	<div style="padding: 0 50px;">
		<form>
			<div class="row" style="border:1px #bbb solid; padding: 20px;">
				<div class="col-md-8">
					<c:forEach var="item" items="${authCategoryList}" begin="0" step="1" varStatus="status">
						<label style="width:150px;">
							<input type="checkbox" style="width:15px;height:15px;" name="authCategory" value="${item.value}" <c:if test="${fn:indexOf(pvo.authCategory,item.value) >= 0}">checked</c:if>/> ${item.name}
							<img src="/front-assets/images/detail/auth_mark_${item.value}.png" alt="${item.name}">
						</label>
					</c:forEach>
				</div>
				<div class="col-md-4">
					<div class="search-input-group input-group" style="padding-top:30px">
						<input name="search" type="hidden" value="name" />
						<input name="findword" class="form-control search-input" placeholder="내용을 입력하세요" style="ime-mode:active" type="text">
						<div class="input-group-btn">
							<button type="submit" class="btn btn-default" style="height:34px">
								<img src="/front-assets/images/common/search_icon.png" alt="검색 아이콘">
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<div style="margin:0 auto; width:1080px; background-color:#fff; padding-top: 50px;">
	<div style="padding: 0 50px;">
		<div class="row" style="padding: 20px;">
		<c:forEach var="item" items="${list}" varStatus="status">
			<div class="col-md-6" style="margin-bottom:30px;cursor:pointer;" onclick="location.href='/shop/about/seller/${item.seq}'">
				<table style="width:100%;">
				<tr>
					<td style="position:relative;background:#EEE3CF;padding:10px 20px;border-bottom:2px #fff dotted" colspan="2">
						<h4 style="color:#4EB8C8">${item.name}</h4>
						<p>
							<c:choose>
								<c:when test="${fn:length(item.intro) < 120}">${item.intro}</c:when>
								<c:otherwise><c:out value="${fn:substring(item.intro,0,120)}"/><i class="fa fa-ellipsis-h"></i></c:otherwise>
							</c:choose>
						</p>
						<div style="background:#4EB8C8;padding:10px;position:absolute;right:0;top:0;color:#fff">
							정보 자세히보기 +
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:20%;color:#fff;background:#F89D20;text-align:center;vertical-align:center;padding: 30px 0;">
						인증구분
					</td>
					<td style="width:80%;padding:15px 30px; border-right: 1px #ddd solid; border-bottom: 1px #ddd solid;">
						<c:forEach var="vo" items="${authCategoryList}">
							<c:if test="${fn:contains(item.authCategory,vo.value)}">
								<label style="width:150px;">
									${vo.name}
									<img src="/front-assets/images/detail/auth_mark_${vo.value}.png" alt="${vo.name}">
								</label>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				</table>
			</div>
			<c:if test="${status.index % 2 eq 1}"><div class="clearfix"></div></c:if>
		</c:forEach>
		</div>
		<div>
			<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
		</div>
	</div>
</div>


<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
var goPage = function (page) {
	location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
};
</script>
</body>
</html>