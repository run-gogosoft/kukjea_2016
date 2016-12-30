<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="lnb">
    <h2>마이페이지</h2>
    <ul>
        <li <c:if test="${on eq '01'}">class="on"</c:if>><a href="/shop/mypage/confirm">나의정보</a></li>
        <li <c:if test="${on eq '02'}">class="on"</c:if>><a href="/shop/mypage/delivery/list">배송지 관리</a></li>
        <li <c:if test="${on eq '03'}">class="on"</c:if>><a href="/shop/mypage/point">나의포인트</a></li>
        <%-- li <c:if test="${on eq '04'}">class="on"</c:if>><a href="">내구매통계</a></li --%>
        <li <c:if test="${on eq '05'}">class="on"</c:if>><a href="/shop/cart">장바구니</a></li>
        <li <c:if test="${on eq '06'}">class="on"</c:if>><a href="/shop/mypage/order/list">구매리스트</a></li>
        <li <c:if test="${on eq '06'}">class="on"</c:if>><a href="/shop/mypage/cancel/list">취소리스트</a></li>
        <li <c:if test="${on eq '07'}">class="on"</c:if>><a href="/shop/wish/list">관심상품</a></li>
        <%-- li <c:if test="${on eq '08'}">class="on"</c:if>><a href="">둘러본상품</a></li --%>
        <%-- li <c:if test="${on eq '09'}">class="on"</c:if>><a href="">내검색결과</a></li --%>
        <%-- li <c:if test="${on eq '10'}">class="on"</c:if>><a href="">쿠폰함</a></li --%>
        <%-- li <c:if test="${on eq '11'}">class="on"</c:if>><a href="">쪽지함</a></li --%>
        <li <c:if test="${on eq '12'}">class="on"</c:if>><a href="/shop/mypage/direct/list">내질문보기</a></li>
        <%-- li <c:if test="${on eq '13'}">class="on"</c:if>><a href="">개별구매하기</a></li --%>
        <li <c:if test="${on eq '13'}">class="on"</c:if>><a href="/shop/mypage/modpassword">비밀번호변경</a></li>
        <li <c:if test="${on eq '14'}">class="on"</c:if>><a href="/shop/mypage/leave/confirm">회원탈퇴</a></li>
        <%-- li <c:if test="${on eq '15'}">class="on"</c:if>><a href="">외상구매</a></li --%>
    </ul>
</div>