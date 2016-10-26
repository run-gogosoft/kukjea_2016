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
                    <div class="privacy_intro">
                        <em>이벤트 기간 </em>
                        <span class="date">
                            <fmt:parseDate value="${vo.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                            <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
                            ~
                            <fmt:parseDate value="${vo.endDate}" var="endDate" pattern="yyyymmdd"/>
                            <fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>
                        </span>
                        ${vo.html}
                    </div>
                </div>


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
                                                <c:if test="${itemList.salePercent <100 && itemList.salePercent >0}">
                                                <span class="icons">
                                                    <span class="icon icon_discount"><em>${itemList.salePercent} </em>%</span>
                                                </span>
                                                </c:if>
                                                <c:if test="${item.sellPrice >= 50000}">
                                                    <span class="icon icon_txt icon_txt_gray">무료배송</span>
                                                </c:if>
                                            </span>
                                            <span class="tit">${itemList.itemName}</span>
                                            <span class="price">
                                                <c:if test="${itemList.salePercent <100 && itemList.salePercent >0}">
                                                    <del><fmt:formatNumber value="${itemList.optionPrice}" pattern="#,###" />원</del>
                                                    <span class="sale"><strong><fmt:formatNumber value="${itemList.salePrice}" pattern="#,###" /></strong>원</span>
                                                </c:if>
                                                <c:if test="${itemList.salePercent eq 0 || itemList.salePercent eq 100}">
                                                    <span class="sale"><strong><fmt:formatNumber value="${itemList.optionPrice}" pattern="#,###" /></strong>원</span>
                                                </c:if>
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
