<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="lnb">
    <h2>핫존</h2>
    <ul>
        <li <c:if test="${on eq '01'}">class="on"</c:if>><a href="/shop/event/plan">이벤트</a></li>
        <c:if test="${mallSeq eq '1'}">
        <li <c:if test="${on eq '02'}">class="on"</c:if>><a href="/shop/event/plan/plansub/2">묶음 특가</a></li>
        <li <c:if test="${on eq '03'}">class="on"</c:if>><a href="/shop/event/plan/plansub/3">카톤이벤트</a></li>
        <li <c:if test="${on eq '04'}">class="on"</c:if>><a href="/shop/event/plan/plansub/4">상품별이벤트</a></li>
        <li <c:if test="${on eq '05'}">class="on"</c:if>><a href="/shop/event/plan/plansub/${mallVo.seq}">이달의 특가</a></li>
        <li <c:if test="${on eq '06'}">class="on"</c:if>><a href="/shop/event/plan/plansub/5">최근 신규상품</a></li>
        <li <c:if test="${on eq '07'}">class="on"</c:if>><a href="/shop/event/plan/plansub/19">인기 구매 상품 100</a></li>
        </c:if>
</ul>
</div>