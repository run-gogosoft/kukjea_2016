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
                <div class="sub_cont">
                    <div class="goods_list">
                        <table class="data_type2">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="allChk" onclick="Cart.checkProc(this)" checked/></th>
                                <th colspan="2">상품정보</th>
                                <th>판매가</th>
                                <th>수량</th>
                                <th>상품 금액</th>
                                <th>업체</th>
                                <th>배송료</th>
                                <th>이벤트</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody id="cartBody">
                            <tr>
                                <td colspan="10" class="text-center" style="padding:50px;">
                                    데이터를 불러오고 있습니다. 잠시만 기다려 주세요... <img src="/front-assets/images/common/ajaxloader.gif" alt="로딩중.." />
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div id="totalBody" class="cart-total-wrap">
                            <div class="left">
                                <div class="total-body-loading">
                                    데이터를 불러오고 있습니다. 잠시만 기다려 주세요... <img src="/front-assets/images/common/ajaxloader.gif" alt="로딩중.." />
                                </div>
                            </div>
                            <div class="right"></div>
                        </div>

                        <div class="btn_action rt mt10">
                            <button type="button" onclick="Cart.buy()" class="btn btn_red">선택한 상품구매하기</button>
                            <button type="button" onclick="Cart.removeSelected()" class="btn btn_default">장바구니 비우기</button>
                            <a href="/shop/main" class="btn btn_default">쇼핑 계속하기</a>
                        </div>
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

<script id="cartTemplate" type="text/html">
    <tr {{if stockCount==="0"}}class="danger"{{/if}}>
        <td><input type="checkbox" id="seq" name="seq" value="<%="${seq}"%>" wish-value="<%="${itemSeq}"%>"  checked = "checked"/></td>
        <td>
            {{if img1 !== ''}}
            <a href="/shop/search?seq=<%="${itemSeq}"%>">
            <img src="<%="${img1}"%>" alt="" onerror="noImage(this)" style="width:70px"/>
            </a>
            {{/if}}
        </td>

        <td class="text-left item-name">
            <a href="/shop/search?seq=<%="${itemSeq}"%>">
                    {{if stockCount==="0"}}
                    <span class="text-danger" data-danger="true">품절</span>
                    {{else stockFlag =="Y" && parseInt(stockCount,10) < count}}
                    <span class="text-danger" data-danger="true">재고<%="${stockCount}"%>개</span>
                    {{/if}}

                    <%="${name}"%><br/>
                    <span class="option-name">
                        <%--<%="${optionName}"%>{{if optionName !== ''}} : {{/if}}<%="${valueName}"%>--%>
                        <%="${valueName}"%>
                    </span><br/>
                    <input type="hidden" name="stockCount" value="<%="${stockCount}"%>"/>
                    <input type="hidden" name="stockFlag" value="<%="${stockFlag}"%>"/>
                    <input type="hidden" name="optionValueSeq" value="<%="${optionValueSeq}"%>"/>
            </a>
        </td>
        <td>
            <span><%="${sellPriceText}"%>원</span>
        </td>
        <td>
            <div class="input-group" style="width:88px;">
                <input type="text" id="count<%="${seq}"%>" name="count" value="<%="${count}"%>" class="intxt w40 input-count" maxlength="3" onblur="numberCheck(this);"/>
                <div class="input-group-btn"><button type="button" class="btn btn_default btn_xs" onclick="Cart.add(<%="${seq}"%>, this);">변경</button></div>
            </div>
            <button type="button" onclick="Cart.amount('plus',<%="${seq}"%>);" class="btn btn-link btn-xs" style="font-size:8px"><span class="glyphicon glyphicon-plus"></span></button>
            <button type="button" onclick="Cart.amount('minus',<%="${seq}"%>);" class="btn btn-link btn-xs" style="font-size:8px"><span class="glyphicon glyphicon-minus" style="color:gray"></span></button>
        </td>
        <td class="item-price">
            <%="${totalPriceText}"%>원
        </td>
        <td>
            <%="${sellerName}"%>
        </td>
        <td>
            {{if freeDeli=="Y"}}<span class="icon icon_txt icon_txt_gray">무료배송</span>
            {{else}}<%="${deliCost}"%> 원
            {{/if}}
        </td>
        <td>
            {{if eventAdded !="" && eventAdded !=" " && eventAdded !="0"}}
                <span class="icon icon_txt icon_txt_yellow"><%="${eventAdded}"%></span>
            {{else}}없음
            {{/if}}
        </td>
        <td>
            <div class="item-delete" remove-value="<%="${seq}"%>" style="cursor:pointer" onclick="Cart.oneRemoveSelected(this)">
                <button type="button" class="btn btn_default btn_xs">
                    삭제
                </button>
            </div>
        </td>
    </tr>
</script>


<form id="buyForm" class="hide" action="/shop/order/direct" target="zeroframe"><div></div></form>
<script type="text/javascript" src="/front-assets/js/plugin/account.js"></script>
<script type="text/javascript" src="/front-assets/js/order/cart.js"></script>
</body>
</html>
