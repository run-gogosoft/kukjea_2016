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
                    <!-- board_list -->
                    <table class="board_list">
                        <caption>게시글 목록</caption>
                        <colgroup>
                            <col style="width:10%" />
                            <col style="width:auto" />
                            <col style="width:15%" />
                            <col style="width:15%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                        <tr>
                            <td>${item.seq}</td>
                            <td class="lt">
                                <a href="/shop/cscenter/view/${boardGroup}/${item.seq}">${item.title }</a>
                                <c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
                            </td>
                            <td><fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                                <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/></td>
                            <td>${item.viewCount}</td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <!-- //board_list -->

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
<script>
var goPage = function (page) {
    location.href = location.pathname + "?pageNum=" + page;
};
</script>
</body>
</html>
