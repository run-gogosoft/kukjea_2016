<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
    <%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
    <link rel="stylesheet" href="/front-assets/css/common/common.css" />
    <link href="/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
    <link href="/front-assets/css/mypage/order.css" type="text/css" rel="stylesheet">
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
                <div class="sub_cont mypage_home">
                    <div class="my_info">
                        <img src="../../images/common/icon_grade.png" alt="등급" class="level" />
                        <dl class="mylevel">
                            <dt>구매등급</dt>
                            <dd>회원님의 구매등급은 <strong data-access="grade">BASIC</strong> 입니다.</dd>
                        </dl>
                        <dl class="mypoint">
                            <dt>나의 포인트</dt>
                            <dd>회원님의 포인트는 <strong data-access="point">0</strong><span>점</span> 입니다.</dd>
                        </dl>
                    </div>

                    <div class="board_tit">
                        <h4>구매리스트</h4>
                        <span class="subtxt">구매하신 상품리스트입니다. 구매하신 상품을 클릭하시면, 재구매 가능하십니다.</span>
                        <div class="btns">
                            <a href="/shop/mypage/order/list" class="btn btn_default btn_xs">구매리스트 전체보기</a>
                        </div>
                    </div>
                    <table class="purchase_list">
                        <caption>구매리스트</caption>
                        <colgroup>
                            <col width="15%"/>
                            <!--col width="10%"/-->
                            <col width="10%"/>
                            <col width="*"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <%--<col width="10%"/>--%>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>주문번호(주문일자)</th>
                            <!--th>상세정보</th-->
                            <th colspan="2">상품정보</th>
                            <th>상품 금액</th>
                            <th>수량</th>
                            <%--<th>비교견적</th>--%>
                            <th>배송정보</th>
                        </tr>
                        </thead>
                        <tbody id="tbodyOrderList">
                        <c:forEach var="vo" items="${orderList}" varStatus="status">
                        <tr>
                            <td data-merge-flag="${vo.orderSeq}" style="letter-spacing:0;">
                                <a href="/shop/mypage/order/detail/${vo.orderSeq}"><strong>${vo.orderSeq}</strong></a><br/>
                                (${fn:substringBefore(vo.regDate,' ')})
                                <div class="cancelDiv" style="margin-top:3px;"></div>
                                <%--<c:if test="${vo.tid ne ''}">--%>
                                    <%--<button type="button" onclick="showReceipt(${vo.tid})" class="btn btn_xs btn_default">거래명세서</button>--%>
                                <%--</c:if>--%>
                            </td>
                            <!--td data-detail-merge-flag="${vo.orderSeq}" data-detail-merge-flag-statuscode="${vo.statusCode}">
                                <a href="/shop/mypage/order/detail/${vo.orderSeq}"><i class="fa fa-building-o fa-3x" style="color:#e5be34;"></i></a>
                            </td-->
                            <td>
                                <c:if test="${vo.img1 ne ''}">
                                    <a href="/shop/search?seq=${vo.itemSeq}"><img src="/upload${fn:replace(vo.img1, '/origin/', '/s60/')}" onerror="noImage(this)" style="width:70px;height:70px;border:1px solid #d7d7d7;" alt="" /></a>
                                </c:if>
                            </td>
                            <td class="text-left item-name">
                                <a href="/shop/search?seq=${vo.itemSeq}">${vo.itemName}</a><br/>
                                <c:if test="${vo.optionValue ne ''}">
                                    <span class="option-name">${vo.optionValue}</span><br/>
                                </c:if>
                            </td>
                            <td class="item-price">
                                <fmt:formatNumber value="${(vo.sellPrice)*vo.orderCnt}"/>원
                            </td>
                            <td>${vo.orderCnt}</td>
                                <%--<td>--%>
                                <%--<c:choose>--%>
                                <%--<c:when test="${vo.estimateCompareCnt > 0}">완료</c:when>--%>
                                <%--<c:otherwise>--%>
                                <%--${vo.estimateCompareFlag eq 'Y' ? "요청접수":"신청안함"}--%>
                                <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                                <%--</td>--%>
                            <td>
                                <c:choose>
                                    <c:when test="${vo.freeDeli eq 'Y'}">
                                        무료
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${vo.deliCost}" pattern="#,###" />
                                        <%--<br/>--%>
                                        <%--<c:when test="${vo.deliPrepaidFlag eq 'N'}">--%>
                                            <%--착불--%>
                                        <%--</c:when>--%>
                                        <%--<c:otherwise>--%>
                                            <%--선결제--%>
                                        <%--</c:otherwise>--%>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>


                    <div class="board_tit">
                        <h4>공지사항</h4>
                        <span class="subtxt">최근 공지 리스트입니다.</span>
                        <div class="btns">
                            <a href="/shop/cscenter/list/notice" class="btn btn_default btn_xs">공지사항 전체보기</a>
                        </div>
                    </div>
                    <table class="board_list">
                        <caption>게시글 목록</caption>
                        <colgroup>
                            <col style="width:10%" />
                            <col style="width:auto" />
                            <col style="width:13%" />
                            <col style="width:10%" />
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
                        <c:forEach var="item" items="${noticeList}" varStatus="status">
                        <tr>
                            <td>${item.seq}</td>
                            <td class="lt">
                                <a href="/shop/cscenter/view/notice/${item.seq}">${item.title }</a>
                                <c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
                            </td>
                            <td><fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                                <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/></td>
                            <td>${item.viewCount}</td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="board_tit">
                        <h4>진행중인 이벤트</h4>
                        <span class="subtxt">진행중인 이벤트 리스트입니다.</span>
                        <div class="btns">
                            <a href="/shop/event/plan" class="btn btn_default btn_xs">진행중인 이벤트 전체보기</a>
                        </div>
                    </div>
                    <div class="event_list">
                        <ul>
                            <c:forEach var="item" items="${eventList}" varStatus="status" begin="0" step="1">
                                <c:if test="${item.showFlag eq 'Y'}">
                                    <li>
                                        <dl>
                                            <dt><a href="/shop/event/plan/plansub/${item.seq}">${item.title}</a></dt>
                                            <dd class="date">
                                                <fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                                                <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
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
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="/front-assets/js/mypage/order.js"></script>
<script>
    $(document).ready(function() {
        <c:forEach var="item" items="${orderList}">
        mergeOrderSeqSell('${item.orderSeq}','${item.seq}','${item.partCancelCnt}');
        mergeOrderDetailSell('${item.orderSeq}','${item.seq}','${item.partCancelCnt}');
        </c:forEach>
    })
</script>
</body>
</html>
