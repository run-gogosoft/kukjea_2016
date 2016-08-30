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
                <div class="sub_cont">
                    <div class="today_sale">
                        <ul>
                        <c:forEach var="groupList" items="${groupList}" varStatus="status">

                            <c:forEach var="itemList" items="${itemList}" varStatus="status">
                                <c:if test="${groupList.eventGroupSeq == itemList.groupSeq }">

                                    <li>
                                        <a href="/shop/search?seq=${itemList.itemSeq}">
                                            <span class="thumb">
                                                <img src="/upload${fn:replace(itemList.img1, 'origin', 's170')}" onerror="noImage(this)" alt=""/>
                                                <span class="icons">
                                                    <span class="icon icon_discount"><em>20 </em>%</span>
                                                </span>
                                            </span>
                                            <span class="tit">${itemList.itemName}</span>
                                            <span class="price">
                                                <del><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" />원</del>
                                                <span class="sale"><strong><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" /></strong>원</span>
                                            </span>
                                        </a>
                                        <!--span class="btns">
                                            <a href="#" class="btn btn_lightgray btn_xs">관심상품담기</a>
                                            <a href="#" class="btn btn_gray btn_xs">장바구니담기</a>
                                        </span-->
                                    </li>

                                </c:if>
                            </c:forEach>

                        </c:forEach>
                    </ul>
                </div>
               </div>
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
