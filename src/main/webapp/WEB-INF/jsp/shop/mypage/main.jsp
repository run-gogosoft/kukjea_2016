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
                            <dd>회원님의 구매등급은 <strong>GOLD</strong> 입니다.</dd>
                        </dl>
                        <dl class="mypoint">
                            <dt>나의 포인트</dt>
                            <dd>회원님의 포인트는 <strong data-access="point">---</strong><span>점</span> 입니다.</dd>
                        </dl>
                    </div>

                    <!-- 나의그룹 -->
                    <%--<div class="mygroup">--%>
                        <%--<dl>--%>
                            <%--<dt>나의 그룹</dt>--%>
                            <%--<dd>--%>
                                <%--<button type="button" class="btn btn_red btn_sm">그룹 신청하기</button>--%>
                                <%--<!-- <span>고대 동문 (승인대기중)</span>  --> <!-- 승인대기중 상태 -->--%>
                                <%--<!-- <button type="button" class="btn btn_gray btn_sm">고대 동문 (탈퇴하기)</button> --> <!-- 승인롼료 상태 -->--%>
                            <%--</dd>--%>
                        <%--</dl>--%>
                    <%--</div>--%>
                    <!-- //나의그룹 -->

                    <%--<div class="mycredit">--%>
                        <%--<dl>--%>
                            <%--<dt>나의 외상구매</dt>--%>
                            <%--<dd class="amount">--%>
                                <%--<span>구매 금액</span>--%>
                                <%--<strong class="txt_sub_point">900,000<span>원</span></strong>--%>
                            <%--</dd>--%>
                            <%--<dd class="able_amount">--%>
                                <%--<span>구매 가능금액</span>--%>
                                <%--<strong class="txt_accent">1,100,000<span>원</span></strong>--%>
                            <%--</dd>--%>
                        <%--</dl>--%>
                    <%--</div>--%>

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
                                <c:if test="${vo.tid ne ''}">
                                    <button type="button" onclick="showReceipt('${vo.tid}')" class="btn btn_xs btn_default">영수증 출력</button>
                                </c:if>
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
                        </tr>
                        </c:forEach>
                    </table>
                    <%--<div class="btn_action rt">--%>
                        <%--<a href="#" class="btn btn_red">선택한 상품구매하기</a>--%>
                    <%--</div>--%>

                    <%--<div class="board_tit">--%>
                        <%--<h4>관심상품리스트</h4>--%>
                        <%--<span class="subtxt">관심상품으로 등록하신 상품리스트입니다.</span>--%>
                        <%--<div class="btns">--%>
                            <%--<a href="#" class="btn btn_default btn_xs">관심상품 전체보기</a>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="goods_list">--%>
                        <%--<table class="data_type2">--%>
                            <%--<caption>관심상품리스트</caption>--%>
                            <%--<colgroup>--%>
                                <%--<col style="width:25px" />--%>
                                <%--<col style="width:70px" />--%>
                                <%--<col style="width:auto" />--%>
                                <%--<col style="width:55px" />--%>
                                <%--<col style="width:100px" />--%>
                                <%--<col style="width:90px" />--%>
                                <%--<col style="width:60px" />--%>
                                <%--<col style="width:90px" />--%>
                                <%--<col style="width:70px" />--%>
                                <%--<col style="width:70px" />--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr>--%>
                                <%--<th scope="col"><span class="hide">상품 선택</span></th>--%>
                                <%--<th scope="col"><span class="hide">상품 이미지</span></th>--%>
                                <%--<th scope="col">상품명</th>--%>
                                <%--<th scope="col"><span class="hide">프로모션 아이콘</span></th>--%>
                                <%--<th scope="col">규격</th>--%>
                                <%--<th scope="col">제조사</th>--%>
                                <%--<th scope="col">단가</th>--%>
                                <%--<th scope="col">수량</th>--%>
                                <%--<th scope="col">금액</th>--%>
                                <%--<th scope="col">판매처</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tfoot>--%>
                            <%--<tr>--%>
                                <%--<td colspan="10">--%>
                                    <%--<div class="total">--%>
                                        <%--<dl>--%>
                                            <%--<dt>선택내역</dt>--%>
                                            <%--<dd><strong>2</strong>개의 상품 선택</dd>--%>
                                        <%--</dl>--%>
                                        <%--<div class="price">--%>
                                            <%--<span><em>2</em>개</span>--%>
                                            <%--<span><em>11,800</em>원</span>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--</tfoot>--%>
                            <%--<tbody>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">5,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                    <%--<div class="btn_action rt">--%>
                        <%--<a href="#" class="btn btn_red">선택한 상품구매하기</a>--%>
                    <%--</div>--%>

                    <%--<div class="board_tit">--%>
                        <%--<h4>장바구니</h4>--%>
                        <%--<span class="subtxt">장바구니에 등록하신 상품리스트입니다.</span>--%>
                        <%--<div class="btns">--%>
                            <%--<a href="#" class="btn btn_default btn_xs">장바구니 전체보기</a>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="goods_list">--%>
                        <%--<table class="data_type2">--%>
                            <%--<caption>장바구니리스트</caption>--%>
                            <%--<colgroup>--%>
                                <%--<col style="width:25px" />--%>
                                <%--<col style="width:70px" />--%>
                                <%--<col style="width:auto" />--%>
                                <%--<col style="width:55px" />--%>
                                <%--<col style="width:100px" />--%>
                                <%--<col style="width:90px" />--%>
                                <%--<col style="width:60px" />--%>
                                <%--<col style="width:90px" />--%>
                                <%--<col style="width:70px" />--%>
                                <%--<col style="width:70px" />--%>
                            <%--</colgroup>--%>
                            <%--<thead>--%>
                            <%--<tr>--%>
                                <%--<th scope="col"><span class="hide">상품 선택</span></th>--%>
                                <%--<th scope="col"><span class="hide">상품 이미지</span></th>--%>
                                <%--<th scope="col">상품명</th>--%>
                                <%--<th scope="col"><span class="hide">프로모션 아이콘</span></th>--%>
                                <%--<th scope="col">규격</th>--%>
                                <%--<th scope="col">제조사</th>--%>
                                <%--<th scope="col">단가</th>--%>
                                <%--<th scope="col">수량</th>--%>
                                <%--<th scope="col">금액</th>--%>
                                <%--<th scope="col">판매처</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tfoot>--%>
                            <%--<tr>--%>
                                <%--<td colspan="10">--%>
                                    <%--<div class="total">--%>
                                        <%--<dl>--%>
                                            <%--<dt>선택내역</dt>--%>
                                            <%--<dd><strong>2</strong>개의 상품 선택</dd>--%>
                                        <%--</dl>--%>
                                        <%--<div class="price">--%>
                                            <%--<span><em>2</em>개</span>--%>
                                            <%--<span><em>11,800</em>원</span>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--</tfoot>--%>
                            <%--<tbody>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">5,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<td><input type="checkbox" class="check" title="상품 선택" /></td>--%>
                                <%--<td>--%>
                                    <%--<span class="thumb"><img src="../../images/thumb/thumb_product.jpg" alt="" /></span>--%>
                                <%--</td>--%>
                                <%--<td class="lt"><a href="#">일회용주사기(Syringe)+거즈  2*2*28P +한신 일회용스왑100매</a></td>--%>
                                <%--<td>--%>
                                    <%--<span class="icon icon_txt icon_txt_gray">무료배송</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_yellow">10+1</span>--%>
                                    <%--<span class="icon icon_txt icon_txt_red">50%</span>--%>
                                <%--</td>--%>
                                <%--<td>주사기0.5cc 31g, 300개, 거즈(400매)</td>--%>
                                <%--<td>한국백신/국제</td>--%>
                                <%--<td class="rt">2,500원</td>--%>
                                <%--<td>--%>
                                    <%--<div class="form_grp">--%>
                                        <%--<input type="text" class="inp_txt" title="구매 수량 입력" value="10" />--%>
                                        <%--<button type="button" class="btn btn_gray btn_xs">수정</button>--%>
                                    <%--</div>--%>
                                <%--</td>--%>
                                <%--<td class="rt"><em class="txt_accent">53,140</em>원</td>--%>
                                <%--<td>나래메디컬</td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                    <%--<div class="btn_action rt">--%>
                        <%--<a href="#" class="btn btn_red">선택한 상품구매하기</a>--%>
                    <%--</div>--%>

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
