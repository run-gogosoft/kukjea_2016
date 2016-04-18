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
                    <!-- board_view -->
                    <div class="board_view">
                        <div class="view_tit">
                            <em>${vo.title}</em>
                        </div>
                        <div class="view_info">
                            <dl>
                                <dt>작성자</dt>
                                <dd>${vo.name}</dd>
                                <dt>등록일</dt>
                                <dd><fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
                                    <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/></dd>
                                <dt>조회수</dt>
                                <dd>${vo.viewCount}</dd>
                            </dl>
                        </div>
                        <%-- 첨부파일이 존재할 경우 --%>
                        <c:if test="${vo.isFile eq 'Y'}">
                        <div class="view_info">
                            <dl>
                                <c:forEach var="item" items="${file}">
                                <dt>
                                    <a href="/shop/cscenter/notice/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
                                        <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
                                            ${item.filename}
                                    </a>
                                </dt>
                                </c:forEach>
                            </dl>
                        </div>
                        </c:if>
                        <div class="view_cont">
                            <iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
                        </div>
                        <div class="view_cont">
                            <div class="btn_rt">
                                <a href="/shop/cscenter/list/notice" class="btn btn_gray">목록보기</a>
                            </div>
                        </div>
                    </div>
                    <!-- //board_view -->
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>

<div id="iframe_content" style="display:none">${content}</div>

<script type="text/javascript">
$(window).load(function() {
    $("#content_view").contents().find("body").html($("#iframe_content").html());
    $("#content_view").height($("#content_view").contents().find("body")[0].scrollHeight + 30);
});
</script>
</body>
</html>