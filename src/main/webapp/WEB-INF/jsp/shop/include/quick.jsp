<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script id="popCartTemplate" type="text/html">
    <li class="va-slice va-slice-<%="${count}"%>">
        <div class="va-title" style="width:83px;height:83px">
            <a href="/shop/search?seq=<%="${seq}"%>"><img src="<%="${img}"%>" alt="" onerror="noImage(this)" /></a>
        </div>
        <%-- button type="button" class="btn_del"><span class="blind">상품 삭제</span></button --%>
    </li>
</script>

<div id="quick">
    <div class="look_product">
        <h3>둘러본상품</h3>
        <!-- 둘러본상품이 있는경우 노출 -->
        <div class="look_list active"> <!-- 상품이 3개 이상일 때: active 클래스 추가 -->
            <ul id="vaWrapper"></ul>
            <button type="button" onclick="quickMove(-93)" class="btn_prev_up"><span class="blind">이전 상품</span></button>
            <button type="button" onclick="quickMove(93)" class="btn_next_down"><span class="blind">다음 상품</span></button>
        </div>
        <!-- //둘러본상품이 있는경우 노출 -->
    </div>
    <ul class="menus">
        <li><a href="/shop/mypage/order/list">주문배송조회</a></li>
        <li><a href="#" onclick="alert('준비중입니다');return false;">배송환불문의</a></li>
        <li><a href="/shop/mypage/direct/list">문의게시판</a></li>
        <li class="cs"><a href="/shop/cscenter/list/notice">고객센터<em>070-4693-1971</em></a></li>
        <li class="cs"><a href="/shop/cscenter/fax">FAX 주문하기<em>02-812-3302</em></a></li>
    </ul>
</div>