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
            <%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/mypage_anchor.jsp" %>
                <div class="sub_cont myinfo">
                    <%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>
                    <table class="board_list">
                        <caption>질문 리스트</caption>
                        <colgroup>
                            <col width="10%"/>
                            <col width="20%"/>
                            <col width="*"/>
                            <col width="15%"/>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>구분</th>
                            <th>제목</th>
                            <th>등록일</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                            <tr>
                                <td>${total-item.rowNumber+1}</td>
                                <td>
                                    <c:forEach var="commonItem" items="${commonList}">
                                        <c:if test="${item.categoryCode eq commonItem.value}">${commonItem.name}</c:if>
                                    </c:forEach>
                                </td>
                                <td class="text-left">
                                    <a href="/shop/mypage/direct/edit/form/${item.seq}" style="color: #636363;">${item.title}</a>
                                    <c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
                                </td>
                                <td>
                                    <fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                                    <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
                                </td>
                                <td>
                                    <div class="answer-box">
                                        <c:choose>
                                            <c:when test="${item.answerFlag eq 2}">
                                                <div class="answer-box" onclick="CHToggleUtil.toggleContent('qna_c${status.count}');">미답변</div>
                                            </c:when>
                                            <c:when test="${item.answerFlag eq 1}">
                                                <div class="answer-box" onclick="CHToggleUtil.toggleAnswer('qna_c${status.count}','qna_a${status.count}');">답변완료</div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                            <tr style="height: 100px; display: none;" id="qna_c${status.count}">
                                <td style="text-align: center;border-right: none; background-color:#F8F8F8;"><i class="fa fa-comment-o fa-3x" style="color: #C2C2C2;"></i></td>
                                <td colspan="4" style="text-align: left;color: #636363;background-color:#F8F8F8;">${fn:replace(item.content, newLine, "<br/>")}</td>
                            </tr>
                            <tr style="height: 100px; display: none;" id="qna_a${status.count}">
                                <td style="text-align: center;border-right: none; background-color:#F8F8F8;"><img src="/front-assets/images/common/answer.png" alt="" /></td>
                                <td colspan="4" style="text-align: left;color: #636363;background-color:#F8F8F8;">${fn:replace(item.answer, newLine, "<br/>")}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="board_action">${paging}</div>
                    <div class="pull-right">
                        <a href="/shop/mypage/direct/form" class="btn btn_red">질문하기</a>
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
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="/front-assets/js/mypage/direct.js"></script>
<script type="text/javascript">
    var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
    };
</script>
</body>
</html>
