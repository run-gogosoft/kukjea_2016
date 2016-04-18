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
                <div class="sub_cont">
                    <%--<div class="btn_action_top lt">--%>
                        <%--<button type="button" class="btn btn_default btn_xs">전체선택</button>--%>
                        <%--<button type="button" class="btn btn_default btn_xs">선택항목 비우기</button>--%>
                        <%--<button type="button" class="btn btn_default btn_xs">외상결제만 보기</button>--%>
                        <%--<button type="button" class="btn btn_default btn_xs">선택상품 반품요청</button>--%>
                        <%--<div class="btn_grp rt">--%>
                            <%--<a href="KJ-I-007-2.html" class="btn btn_gray btn_xs">반품리스트</a>--%>
                            <%--<a href="KJ-I-007-4.html" class="btn btn_gray btn_xs">취소리스트</a>--%>
                        <%--</div>--%>
                    <%--</div>--%>

                    <table class="purchase_list">
                        <caption>구매리스트</caption>
                        <colgroup>
                            <col width="15%"/>
                            <col width="10%"/>
                            <col width="8%"/>
                            <col width="*"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <%--<col width="10%"/>--%>
                            <col width="10%"/>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>주문번호(주문일자)</th>
                            <th>상세정보</th>
                            <th colspan="2">상품정보</th>
                            <th>상품 금액</th>
                            <th>수량</th>
                            <%--<th>비교견적</th>--%>
                            <th>배송정보</th>
                            <th>확인/취소</th>
                        </tr>
                        </thead>
                        <tbody id="tbodyOrderList">
                        <c:forEach var="vo" items="${list}" varStatus="status">
                        <div class="hh-review-writebox review-layer${status.count}" style="z-index: 100;">
                            <div class="hh-writebox-wrap">
                                <div class="hh-writebox-header"><span class="title">상품후기</span></div>
                                <div class="hh-writebox-content">
                                    <form class="form-horizontal" name="directForm" role="form" method="post" action="/shop/mypage/review/reg/proc" onsubmit="return submitProc(this);" target="zeroframe">
                                        <input type="hidden" name="itemSeq" value="${vo.itemSeq}"/>
                                        <input type="hidden" name="statusCode" value="55"/>
                                        <input type="hidden" name="detailSeq" value="${vo.seq}"/>

                                        <div class="ch-writebox-item-info">
                                            <img src="/upload${fn:replace(vo.img1, '/origin/', '/s206/')}" style="display:inline-block;width:70px;height:70px;border:1px solid #CCC;" alt="" />
                                            <div style="height:120px;display:inline-block;margin-left:18px;">
                                                <span class="ch-item-name">${vo.itemName}</span><br/>
                                                <span class="ch-item-value-name">
                                                    <c:if test="${vo.valueName ne ''}">
                                                        옵션:&nbsp;<span class="option-name">${vo.valueName}</span>
                                                    </c:if>
                                                </span>
                                            </div>
                                        </div>

                                        <hr/>

                                        <div class="ch-item-rating-wrap">
                                            <div class="pull-left" style="display:inline-block; padding:0;margin:0;width:190px;">
                                                <div class="start-back">
                                                    <div class="star">
                                                        <div class="star-left-1 star-left"></div>
                                                        <div class="star-right-1 star-right"></div>
                                                    </div>
                                                    <div class="star">
                                                        <div class="star-left-2 star-left"></div>
                                                        <div class="star-right-2 star-right"></div>
                                                    </div>
                                                    <div class="star">
                                                        <div class="star-left-3 star-left"></div>
                                                        <div class="star-right-3 star-right"></div>
                                                    </div>
                                                    <div class="star">
                                                        <div class="star-left-4 star-left"></div>
                                                        <div class="star-right-4 star-right"></div>
                                                    </div>
                                                    <div class="star">
                                                        <div class="star-left-5 star-left"></div>
                                                        <div class="star-right-5 star-right"></div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="ch-item-rating pull-left" style="display:inline-block;">
                                                <span id="itemRating">0</span>
                                                <span style="font-size:12px;">/5점</span>
                                            </div>

                                            <div class="ch-item-rating-select pull-left" style="display:inline-block; margin-left:5px; padding-left:0; padding-right:0;">
                                                <input type="radio" name="goodGrade" class="goodGrade" value="1" onclick="CHBoardUtil.selectRate(this)">1점
                                                <input type="radio" name="goodGrade" class="goodGrade" value="2" onclick="CHBoardUtil.selectRate(this)">2점
                                                <input type="radio" name="goodGrade" class="goodGrade" value="3" onclick="CHBoardUtil.selectRate(this)">3점
                                                <input type="radio" name="goodGrade" class="goodGrade" value="4" onclick="CHBoardUtil.selectRate(this)">4점
                                                <input type="radio" name="goodGrade" class="goodGrade" value="5" onclick="CHBoardUtil.selectRate(this)">5점
                                            </div>
                                        </div>

                                        <div class="hh-writebox-answer">
                                            <div class="input-group" style="height: 260px;">
                                                <span class="input-group-addon" style="width: 154px; height:260px; line-height:200px;"><p>상품후기</p></span>
                                                <!-- <span id="contentLength" style="color:#00bff3;">0</span>&nbsp;/&nbsp;<span style="font-size:12px;">500자</span></span> -->
                                                <textarea id="reviewContent" class="form-control" name="review" style="display:inline-block; height: 260px; resize: none;" alt="상품후기"></textarea>
                                            </div>
                                        </div>

                                        <div class="hh-writebox-footer">
                                            <div class="inner">
                                                <button type="submit" id="submitBtn" class="btn btn-qna-submit">등록하기</button>
                                                <button type="button" onclick="CHBoardUtil.writeClose()" class="btn btn-qna-cancel">취소하기</button>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="hh-writebox-text-check" style="width:500px;">
                                        <br/>
                                        <p style="width:500px;">◇ 사이트 이용 관련 문의나 의견을 등록하시면 빠른 시일내에 답변을 드립니다.</p>
                                        <p style="width:500px;">◇ 문의에 대한 답변은 이메일에서 확인하시거나 마이페이지 에서 확인하실 수 있습니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <tr>
                            <td data-merge-flag="${vo.orderSeq}" data-merge-flag-statuscode="${vo.statusCode}" style="letter-spacing:0;">
                                <a href="/shop/mypage/order/detail/${vo.orderSeq}"><strong>${vo.orderSeq}</strong></a><br/>
                                (${fn:substringBefore(vo.regDate,' ')})
                                <div class="cancelDiv" style="margin-top:3px;"></div>
                                <c:if test="${vo.tid ne ''}">
                                    <button type="button" onclick="showReceipt('${vo.tid}')" class="btn btn_xs btn_default">영수증 출력</button>
                                </c:if>
                            </td>
                            <td data-detail-merge-flag="${vo.orderSeq}" data-detail-merge-flag-statuscode="${vo.statusCode}">
                                <a href="/shop/mypage/order/detail/${vo.orderSeq}"><i class="fa fa-building-o fa-3x" style="color:#e5be34;"></i></a>
                            </td>
                            <td>
                                <c:if test="${vo.img1 ne ''}">
                                    <a href="/shop/search?seq=${vo.itemSeq}"><img src="/upload${fn:replace(vo.img1, '/origin/', '/s206/')}" onerror="noImage(this)" style="width:70px;height:70px;border:1px solid #d7d7d7;" alt="" /></a>
                                </c:if>
                            </td>
                            <td class="text-left item-name">
                                <a href="/shop/search?seq=${vo.itemSeq}">${vo.itemName}</a><br/>
                                <c:if test="${vo.optionValue ne ''}">
                                    <span class="option-name">${vo.optionValue}</span><br/>
                                </c:if>
                            </td>
                            <td class="item-price">
                                <fmt:formatNumber value="${(vo.sellPrice+vo.optionPrice)*vo.orderCnt}"/>원
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
                                    <c:when test="${vo.deliCost eq 0}">
                                        무료
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${vo.deliCost}" pattern="#,###" />
                                        <br/>
                                        <c:if test="${vo.deliPrepaidFlag eq 'Y'}">
                                            선결제
                                        </c:if>
                                        <c:if test="${vo.deliPrepaidFlag eq 'N'}">
                                            착불
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:startsWith(vo.payMethod,'OFFLINE') or fn:startsWith(vo.payMethod,'NP')}">
                                        <c:choose>
                                            <c:when test="${vo.statusCode eq '10'}">
                                                접수완료<br/>
                                            </c:when>
                                            <c:otherwise>
                                                ${vo.statusText}<br/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        ${vo.statusText}<br/>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${vo.statusCode >= 30}">
                                        <c:if test="${vo.deliSeq ne 0 and vo.deliSeq ne 19 and vo.deliNo ne ''}">
                                            <c:choose>
                                                <c:when test="${vo.deliSeq eq 2}">
                                                    <button class="btn btn_default btn_xs" onclick="viewDeliveryForHlc('${vo.deliTrackUrl}','${vo.deliNo}');" onfocus="this.blur();">배송추적</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn_default btn_xs" onclick="viewDelivery('${vo.deliTrackUrl}','${vo.deliNo}');" onfocus="this.blur();">배송추적</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                        <c:if test="${vo.statusCode eq 50}">
                                            <!-- <button class="btn btn-danger btn-xs" onclick="updateOrderStatus('${vo.seq}','${vo.orderSeq}','55');" style="width: 75px;margin-top: 2px;">구매확정</button> -->
                                            <button class="btn btn_red btn_xs" onclick="CHBoardUtil.writeButton('${status.count}')" style="width: 75px;margin-top: 2px;">구매확정</button>
                                        </c:if>
                                        <c:if test="${vo.statusCode <= 50}">
                                            <button class="btn btn_default btn_xs" onclick="hhWrite.writeButton('70',${vo.seq}, ${vo.orderSeq},'');">반품신청</button>
                                            <button class="btn btn_default btn_xs" onclick="hhWrite.writeButton('60',${vo.seq}, ${vo.orderSeq},'');">교환신청</button>
                                        </c:if>
                                    </c:when>
                                    <c:when test="${vo.statusCode == 20}">
                                        <button class="btn btn_default btn_xs" onclick="hhWrite.writeButton('90',${vo.seq}, ${vo.orderSeq},'');">취소신청</button>
                                    </c:when>
                                    <c:when test="${vo.statusCode < 20}">
                                        <c:choose>
                                            <c:when test="${vo.orderCount == 1}">
                                                <!-- 단건 주문인 경우는 전체 취소 처리한다. -->
                                                <button class="btn btn_default btn_xs" onclick="hhWrite.writeButton('99',${vo.seq}, ${vo.orderSeq},'ALL');">주문취소</button>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${!(fn:startsWith(vo.payMethod,'ARS') and vo.statusCode eq '00')}">
                                                    <!-- ARS결제 주문일 경우에는 입금대기 상태에서 부분취소 요청을 할 수 없다. -->
                                                    <button class="btn btn_default btn_xs" onclick="hhWrite.writeButton('90',${vo.seq}, ${vo.orderSeq},'');">취소신청</button>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        </c:forEach>
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
<div class="clearfix"></div>
<div class="hh-writebox-layer">
    <div class="hh-writebox-wrap">
        <div class="hh-writebox-header"><span class="title"></span></div>
        <div class="hh-writebox-content">
            <form class="form-horizontal" id="updateOrderStatus" role="form" method="post" onsubmit="return submitProc(this);" target="zeroframe">
                <input type="hidden" id="seq" name="seq" />
                <input type="hidden" id="orderSeq" name="orderSeq" />
                <input type="hidden" id="statusCode" name="statusCode" />
                <input type="hidden" id="cancelType" name="cancelType" />

                <script id="itemTemplate" type="text/html">
                    <img src="<%="${img1}"%>" style="display:inline-block;width:70px;height:70px;border:1px solid #d7d7d7;" alt="" />
                    <div class="item-info-wrap">
                        <span class="ch-item-name"><%="${itemName}"%></span><br/>
                        <span class="ch-item-value-name">
                            {{if valueName !== ''}}
                                옵션:&nbsp;<span class="option-name"><%="${valueName}"%></span>
                            {{/if}}
                        </span>
                    </div>
                </script>

                <div id="itemTarget" class="ch-writebox-item-info">

                </div>

                <div class="hh-writebox-answer">
                    <div class="input-group" style="height: 70px;">
                        <span class="input-group-addon" style="width: 70px;"><p id="reasonText"></p></span>
                        <textarea class="form-control reason" id="reason" name="reason" style="width:335px;height: 170px; resize: none;"></textarea>
                    </div>
                </div>

                <div class="hh-writebox-footer">
                    <div class="inner">
                        <button type="submit" id="submitBtn" class="btn btn-qna-submit">신청하기</button>
                        <button type="button" onclick="hhWrite.writeClose()" class="btn btn-qna-cancel">취소</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="orderModal" class="modal fade" data-backdrop="static">
    <div class="modal-dialog" style="width: 400px;">
        <div class="modal-content" style="top: 130px;">
            <div class="modal-body">
                <h4>취소 처리 중입니다.. <img src="/assets/img/common/ajaxloader.gif" alt="" /></h4>
                <h7>(취소 처리가 끝나기 전까지는 이 창을 닫지 마세요)</h7>
            </div>
        </div>
    </div>
</div>
<form id="hlc" method="post" action="https://www.hlc.co.kr/home/personal/inquiry/track">
    <input type="hidden" name="InvNo" value="">
    <input type="hidden" name="action" value="processInvoiceSubmit">
</form>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="/front-assets/js/mypage/order.js"></script>
<script type="text/javascript">
    var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
    };

    $(document).ready(function() {
        <c:forEach var="item" items="${list}">
        mergeOrderSeqSell('${item.orderSeq}','${item.seq}','${item.partCancelCnt}');
        mergeOrderDetailSell('${item.orderSeq}','${item.seq}','${item.partCancelCnt}');
        </c:forEach>
    });

    var showReceipt = function(tid) {
        var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noMethod=1&noTid="+tid;
        window.open(receiptUrl,"receipt","width=430,height=700");
    };
</script>
</body>
</html>