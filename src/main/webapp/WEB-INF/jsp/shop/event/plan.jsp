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
        <div class="layout_inner sub_container">
            <%@ include file="/WEB-INF/jsp/shop/include/hotzone_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/hotzone_anchor.jsp" %>
                <div class="event_list board_type">
                    <ul>
                        <c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
                        <c:if test="${item.showFlag eq 'Y'}">
                        <li>
                            <dl>
                                <dt><a href="/shop/event/plan/plansub/${item.seq}">${item.title}</a></dt>
                                <dd class="date">
                                    <fmt:parseDate value="${item.startDate}" var="startDate" pattern="yyyy-mm-dd"/>
                                    <fmt:formatDate value="${startDate}" pattern="yyyy-mm-dd"/>
                                    ~
                                    <fmt:parseDate value="${item.endDate}" var="endDate" pattern="yyyymmdd"/>
                                    <fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>
                                </dd>
                                <dd class="thumb">
                                    <a href="/shop/event/plan/plansub/${item.seq}">
                                <img src="/upload${item.thumbImg}" alt="${item.title}" onerror="noImage(this)" />
                            </a>
                                </dd>
                            </dl>
                        </li>
                        </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>

</body>
</html>
