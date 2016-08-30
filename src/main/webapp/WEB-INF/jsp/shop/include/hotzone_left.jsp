<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="lnb">
    <h2>핫존</h2>
    <ul>
        <li <c:if test="${on eq '01'}">class="on"</c:if>><a href="/shop/event/plan">이벤트</a></li>
        <li <c:if test="${on eq '02'}">class="on"</c:if>><a href="/shop/event/plan/plansub/2">최신 판매상품 BEST</a></li>
        <li <c:if test="${on eq '03'}">class="on"</c:if>><a href="/shop/event/plan/plansub/3">월간 판매상품 BEST</a></li>
        <li <c:if test="${on eq '04'}">class="on"</c:if>><a href="/shop/event/plan/plansub/4">관심 상품 BEST</a></li>
        <li <c:if test="${on eq '05'}">class="on"</c:if>><a href="/shop/event/plan/plansub/1">오늘만 이가격</a></li>
        <li <c:if test="${on eq '06'}">class="on"</c:if>><a href="/shop/event/plan/plansub/5">최근 신규상품</a></li>
</ul>
</div>