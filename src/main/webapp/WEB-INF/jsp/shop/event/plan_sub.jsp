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
                <div class="event_detail">
                    <div class="subject">
                        <em>${vo.title}</em>
                        <span class="date">
                            <fmt:parseDate value="${vo.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                            <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
                            ~
                            <fmt:parseDate value="${vo.endDate}" var="endDate" pattern="yyyymmdd"/>
                            <fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>
                        </span>
                    </div>
                </div>
                <div class="event_cont">
                    <div class="img">
                        ${vo.html}
                    </div>
                </div>


                <c:forEach var="groupList" items="${groupList}" varStatus="status">
                    <h3 class="tit_box_type">* ${groupList.groupName}</h3>
                    <div class="goods_desc_list">
                        <div class="item_grp">
                        <c:forEach var="itemList" items="${itemList}" varStatus="status">
                            <c:if test="${groupList.eventGroupSeq == itemList.groupSeq }">
                            <div class="item col_lt" onclick="location.href='/shop/search?seq=${itemList.itemSeq}';" style="cursor:pointer">
                                <div class="thumb">
                                    <img src=/upload${fn:replace(itemList.img1, 'origin', 's270')}" onerror="noImage(this)" alt="">
                                </div>
                                <table class="default">
                                    <caption>상품 기본 설명</caption>
                                    <colgroup>
                                        <col style="width:75px" />
                                        <col style="width:auto" />
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th scope="row"><p>상 품 명</p></th>
                                        <td>${itemList.itemName}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><p>규 격</p></th>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><p>제 조 사</p></th>
                                        <td>${itemList.maker}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><p>단 위</p></th><td>1개</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><p>가 격</p></th>
                                        <td><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" />원</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><p>보 험 코 드</p></th>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            </c:if>
                        </c:forEach>
                        </div>
                    </div>

                </c:forEach>
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
