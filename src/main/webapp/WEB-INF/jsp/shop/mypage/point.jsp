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
                    <div class="mypoint_intro">
                        <div class="point">
                            <p>현재 회원님의 보유포인트는</p>
                            <strong class="txt_sub_point">
                                <fmt:formatNumber value="${availablePoint}" pattern="#,###" /><span>점</span>
                            </strong> 입니다.
                        </div>
                        <ul class="bul_dot_gray">
                            <li>포인트는 국제몰에서 현금처럼 사용할 수 있는 점수입니다.</li>
                        </ul>
                    </div>

                    <h4 class="tit_style"><em class="must">*</em> 사용리스트</h4>
                    <div class="inner" style="margin:0">
                        <%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>
                    </div>
                    <table class="board_list">
                        <caption>포인트 사용리스트</caption>
                        <colgroup>
                            <col style="width:10%" />
                            <col style="width:20%" />
                            <col style="width:auto" />
                            <col style="width:20%" />
                            <col style="width:15%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">포인트명</th>
                            <th scope="col">포인트내용</th>
                            <th scope="col" class="rt">지급/사용 포인트</th>
                            <th scope="col">발생일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                        <tr>
                            <td>00</td>
                            <td>${item.statusName}</td>
                            <td class="lt">${item.note}</td>
                            <td class="rt">
                                <span class="txt_sub_point">
                                    <c:if test="${item.statusCode eq 'U' or item.statusCode eq 'D'}">-</c:if>
                                    <fmt:formatNumber value="${item.point}"/>
                                </span>
                            </td>
                            <td>${fn:substring(item.regDate, 0,10)}</td>
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
<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>
<script type="text/javascript" src="/front-assets/js/plugin/moment.min.js"></script>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
    var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&search=${pvo.search}" + $("#search_form").serialize();
    };
</script>
</body>
</html>
