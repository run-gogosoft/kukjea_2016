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
            <%@ include file="/WEB-INF/jsp/shop/include/cscenter_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/cscenter_anchor.jsp" %>
                <div class="sub_cont">
                    <div class="faq_list">
                        <ul>
                            <li <c:if test="${categoryCode eq '10'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=10">회원</a></li>
                            <li <c:if test="${categoryCode eq '20'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=20">주문/결제/배송</a></li>
                            <li <c:if test="${categoryCode eq '30'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=30">환불/취소/재고</a></li>
                            <li <c:if test="${categoryCode eq '40'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=40">영수증</a></li>
                            <li <c:if test="${categoryCode eq '50'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=50">이벤트</a></li>
                            <li <c:if test="${categoryCode eq '60'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=60">기타</a></li>
                        </ul>
                    </div>

                    <!-- board_list -->
                    <table class="board_list board_folding">
                        <caption>게시글 목록</caption>
                        <colgroup>
                            <col style="width:10%" />
                            <col style="width:20%" />
                            <col style="width:auto" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">분류</th>
                            <th scope="col">제목</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                        <tr>
                            <td>${item.seq}</td>
                            <td class="lt">
                                <c:if test="${item.categoryCode eq '10'}">회원</c:if>
                                <c:if test="${item.categoryCode eq '20'}">주문/결제/배송</c:if>
                                <c:if test="${item.categoryCode eq '30'}">환불/취소/재고</c:if>
                                <c:if test="${item.categoryCode eq '40'}">영수증</c:if>
                                <c:if test="${item.categoryCode eq '50'}">이벤트</c:if>
                                <c:if test="${item.categoryCode eq '60'}">기타</c:if>
                            </td>
                            <td class="lt">
                                <a href="#" class="ellipsis full fold_control">${item.title}</a>
                            </td>
                        </tr>
                        <tr class="folding_view"  >
                            <td colspan="3" >${item.content}</td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="board_action">${paging}</div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>

<script type="text/javascript">
var goPage = function (page) {
    location.href = location.pathname + "?pageNum=" + page +"&categoryCode=${categoryCode}";
};
</script>
</body>
</html>
