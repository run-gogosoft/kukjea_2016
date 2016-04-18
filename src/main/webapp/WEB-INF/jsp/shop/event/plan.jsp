<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
  <link href="${const.ASSETS_PATH}/front-assets/css/plan/plan.css" type="text/css" rel="stylesheet">
  <title>${title}</title>

  <style type="text/css">
    #popup-zone {
          margin-top:0;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="breadcrumb">
  <div class="pull-left" style="margin:8px 10px 0 0;">
    <img src="/front-assets/images/detail/home.png" alt="홈"> 홈<span class="arrow-sub">&gt;</span><strong>기획전</strong>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<ul class="widget-3th-type">
  <c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
    <c:if test="${item.showFlag eq 'Y'}">
      <li style="margin-bottom: 10px;">
        <a href="/shop/event/plan/plansub/${item.seq}">
          <img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${item.thumbImg}" style="width:270px;height:495px;"/>
        </a>
        <div class="item">
          <span class="title"><a href="/shop/event/plan/plansub/${item.seq}">${item.title}</a></span>
        </div>
      </li>
    </c:if>
  </c:forEach>
</ul>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
</body>
</html>