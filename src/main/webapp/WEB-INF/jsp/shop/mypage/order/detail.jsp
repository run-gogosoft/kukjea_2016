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

                    <%--주문금액계산--%>
                    <c:set var="totalSellPrice" value="0" />
                    <c:set var="totalDeliveryPrice" value="0" />
                    <c:set var="addrButton" value="0" />
                    <c:forEach var="item" items="${list}" varStatus="status">
                        <c:if test="${item.statusCode eq '00' or item.statusCode eq '10'}">
                            <c:set var="addrButton" value="${addrButton+1}" />
                        </c:if>
                        <%--착불 배송비 제외--%>
                        <c:if test="${item.deliPrepaidFlag eq 'Y'}">
                            <c:set var="totalDeliveryPrice" value="${totalDeliveryPrice + item.deliCost}" />
                        </c:if>
                        <c:set var="totalSellPrice" value="${totalSellPrice + ((item.sellPrice + item.optionPrice) * item.orderCnt)}" />
                    </c:forEach>

                    <table class="purchase_list">
                        <colgroup>
                            <col width="20%"/>
                            <col width="20%"/>
                            <col width="20%"/>
                            <col width="20%"/>
                            <col width="20%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>주문번호</th>
                            <th>총 상품금액</th>
                            <th>총 배송비</th>
                            <th>포인트</th>
                            <th>총 주문금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${vo.orderSeq}</td>
                            <td><fmt:formatNumber value="${totalSellPrice}"/>원</td>
                            <td><fmt:formatNumber value="${totalDeliveryPrice}"/>원</td>
                            <td><fmt:formatNumber value="${vo.point}"/>원</td>
                            <td><strong><fmt:formatNumber value="${vo.payPrice}"/>원</strong></td>
                        </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <table class="purchase_list">
                        <colgroup>
                            <col width="20%"/>
                            <col width="20%"/>
                            <col width="*"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>결제수단</th>
                            <th>총 결제 금액</th>
                            <th colspan="4">비고</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${vo.payMethodName}</td>
                            <td><strong><fmt:formatNumber value="${vo.payPrice + vo.point}"/></strong>원</td>
                            <td colspan="4">${vo.accountInfo}</td>
                        </tr>
                        </tbody>
                    </table>

                    <!-- 후청구 결제일 경우 결제여부 상태를 보여준다. -->
                    <c:if test="${vo.npPayFlag ne ''}">
                        <div class="top-table">
                            <table class="table">
                                <colgroup>
                                    <col width="20%"/>
                                    <col width="*"/>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th>결제여부</th>
                                    <td>
                                        <strong>
                                            <c:choose>
                                                <c:when test="${vo.npPayFlag eq 'Y'}">결제완료</c:when>
                                                <c:otherwise>미결제</c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <div class="board_tit mt30">
                        <h4>주문 상품 리스트</h4>
                    </div>
                    <table class="purchase_list">
                        <colgroup>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="10%"/>
                            <col width="10%"/>
                            <col width="10%"/>
                            <col width="15%"/>
                            <col width="10%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">상품정보</th>
                            <th>상품금액</th>
                            <th>수량</th>
                            <th>주문금액</th>
                            <th>업체</th>
                            <th>배송정보</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                            <tr>
                                <td>
                                    <c:if test="${item.img1 ne ''}">
                                        <a href="/shop/search?seq=${item.itemSeq}"><img src="/upload${fn:replace(item.img1, 'origin', 's60')}" style="width:70px;height:70px;border:1px solid #d7d7d7;" alt="${item.itemName}" onerror="noImage(this)" /></a>
                                    </c:if>
                                </td>
                                <td class="text-left item-name">
                                    <a href="/shop/search?seq=${item.itemSeq}">${item.itemName}</a><br/>
                                    <c:if test="${item.optionValue ne ''}">
                                        <span class="option-name">${item.optionValue}</span><br/>
                                    </c:if>
                                </td>
                                <td><fmt:formatNumber value="${item.sellPrice+item.optionPrice}"/>원</td>
                                <td><strong>${item.orderCnt}개</strong></td>
                                <td class="item-price">
                                    <fmt:formatNumber value="${(item.sellPrice+item.optionPrice)*item.orderCnt}"/>원
                                </td>
                                <td>${item.sellerName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${vo.payMethod eq 'OFFLINE' or fn:startsWith(vo.payMethod,'NP')}">
                                            <c:choose>
                                                <c:when test="${item.statusCode eq '10'}">
                                                    접수완료<br/>
                                                </c:when>
                                                <c:otherwise>
                                                    ${item.statusText}<br/>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            ${item.statusText}<br/>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${item.statusCode eq '10'}">
                                        <c:set var="addrButton" value="${addrButton+1}" />
                                    </c:if>

                                    <c:if test="${item.statusCode eq '30'}">
                                        <fmt:parseNumber var="parseIntStatusCode" value="${item.statusCode}" type="number"/>
                                        <c:if test="${parseIntStatusCode >= 30 and item.deliSeq ne 0 and item.deliNo ne ''}">
                                            <button class="btn btn-default btn-xs btn-etc" onclick="viewDelivery('${item.deliTrackUrl}','${item.deliNo}');">배송추적</button>
                                        </c:if>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="board_tit mt30">
                        <h4>주문자 정보</h4>
                    </div>
                    <table class="board_write">
                        <colgroup>
                            <col style="width:140px" />
                            <col style="width:auto" />
                        </colgroup>
                        <tr>
                            <th>주문자명</th>
                            <td>
                                ${vo.memberName}
                            </td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td style="letter-spacing:0;">
                                ${vo.memberCell}
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td style="letter-spacing:0;">
                                ${vo.memberEmail}
                            </td>
                        </tr>
                    </table>


                    <div class="board_tit mt30">
                        <h4>
                            배송지 정보
                        </h4>
                    </div>

                    <table class="board_write">
                        <colgroup>
                            <col style="width:140px" />
                            <col style="width:auto" />
                        </colgroup>
                        <tr>
                            <th>수신자명</th>
                            <td>
                                <c:choose>
                                    <c:when test="${addrButton ne fn:length(list)}">
                                        ${vo.receiverName}
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="intxt w180" id="receiverName" name="receiverName" style="width:;" maxlength="15" value="${vo.receiverName}" style="width: 200px;"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td style="letter-spacing:0;">
                                <c:choose>
                                    <c:when test="${addrButton ne fn:length(list)}">
                                        ${vo.receiverTel}
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="intxt w180" id="receiverTel" name="receiverTel" maxlength="20" value="${vo.receiverTel}" style="width: 200px;"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>휴대폰번호</th>
                            <td style="letter-spacing:0;">
                                <c:choose>
                                    <c:when test="${addrButton ne fn:length(list)}">
                                        ${vo.receiverCell}
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="intxt w180" id="receiverCell" name="receiverCell" maxlength="20" value="${vo.receiverCell}" style="width: 200px;"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td style="letter-spacing:0;">
                                <c:choose>
                                    <c:when test="${addrButton ne fn:length(list)}">
                                        ${vo.receiverEmail}
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="intxt w180" id="receiverEmail" name="receiverEmail" maxlength="20" value="${vo.receiverEmail}" style="width: 200px;"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>
                                <c:choose>
                                    <c:when test="${addrButton ne fn:length(list)}">
                                        ${vo.receiverPostcode}<br/>
                                        ${vo.receiverAddr1}<br/>
                                        ${vo.receiverAddr2}
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="intxt w100" id="receiverPostcode" name="receiverPostcode" maxlength="6" onblur="numberCheck(this);" value="${vo.receiverPostcode}" style="width:75px;"/><br/>
                                        <input type="text" class="intxt w560" id="receiverAddr1" name="receiverAddr1" maxlength="100" value="${vo.receiverAddr1}" style="margin-top:2px;width:400px;"/><br/>
                                        <input type="text" class="intxt w560" id="receiverAddr2" name="receiverAddr2" maxlength="100" value="${vo.receiverAddr2}" style="margin-top:2px;width:400px;"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>배송 메세지</th>
                            <td>
                                ${vo.request}
                            </td>
                        </tr>
                    </table>

                    <%-- 세금계산서 요청서 --%>
                    <c:if test="${taxRequest ne null}">
                        <div class="board_tit mt30">
                            <h4>세금계산서 요청서</h4>
                        </div>
                        <table class="table sign-table">
                            <tr>
                                <th>진행상태</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${taxRequest.requestFlag eq 'N'}">진행중</c:when>
                                        <c:when test="${taxRequest.requestFlag eq 'Y'}">발송완료 (${taxRequest.completeDate})</c:when>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>사업자번호</th>
                                <td>
                                        ${taxRequest.businessNum}
                                </td>
                            </tr>
                            <tr>
                                <th>상호(법인명)</th>
                                <td>
                                        ${taxRequest.businessCompany}
                                </td>
                            </tr>
                            <tr>
                                <th>대표자</th>
                                <td>
                                        ${taxRequest.businessName}
                                </td>
                            </tr>
                            <tr>
                                <th>소재지</th>
                                <td>
                                        ${taxRequest.businessAddr}
                                </td>
                            </tr>
                            <tr>
                                <th>업태</th>
                                <td>
                                        ${taxRequest.businessCate}
                                </td>
                            </tr>
                            <tr>
                                <th>종목</th>
                                <td>
                                        ${taxRequest.businessItem}
                                </td>
                            </tr>
                            <tr>
                                <th>수신 이메일</th>
                                <td>
                                        ${taxRequest.requestEmail}
                                </td>
                            </tr>
                            <tr>
                                <th>담당자</th>
                                <td>
                                        ${taxRequest.requestName}
                                </td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td>
                                        ${taxRequest.requestCell}
                                </td>
                            </tr>
                        </table>
                    </c:if>
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
<script type="text/javascript">
    var showReceipt = function(tid) {
        var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noMethod=1&noTid="+tid;
        window.open(receiptUrl,"receipt","width=430,height=700");
    };
</script>
</body>
</html>