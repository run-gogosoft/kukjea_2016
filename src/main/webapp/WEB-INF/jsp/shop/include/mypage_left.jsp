<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<ul class="main-menu">
	<li class="main">마이페이지</li>
	<li class="buy-info">구매정보</li>
	<li class="buy-sub">
		<ul class="sub-list">
			<li><a href="/shop/mypage/order/list">주문 / 배송조회</a></li>
			<li><a href="/shop/mypage/cancel/list">취소 / 반품 / 교환 내역</a></li>
			<li><a href="/shop/mypage/estimate/list">견적요청 관리</a></li>
			<%if("P".equals(session.getAttribute("loginMemberTypeCode"))) { //공공기관 회원일 경우에만 노출%>
			<li><a href="/shop/mypage/compare/list">비교견적요청 관리</a></li>
			<li><a href="/shop/mypage/NP_CARD/list">후청구(신용카드) 결제하기</a></li>
			<li><a href="/shop/mypage/taxrequest/list">세금계산서</a></li>
			<%} %>
		</ul>
	</li>
	<li class="user-info">나의 정보</li>
	<li class="user-sub" style="height:120px;">
		<ul class="sub-list">
			<li><a href="/shop/mypage/confirm">개인정보 관리/수정</a></li>
			<li><a href="/shop/mypage/delivery/list">나의 배송지 관리</a></li>
			<li><a href="/shop/mypage/direct/list">나의 1:1 문의내역</a></li>
		</ul>
	</li>
	<li class="qna-info"><a href="/shop/mypage/point">포인트 현황</a></li>
	<li class="qna-info" style="margin-top:2px;"><a href="/shop/mypage/qna/list">상품 Q&amp;A</a></li>
	<li class="qna-info" style="margin-top:2px;"><a href="/shop/mypage/review">나의 상품후기</a></li>
	<li class="qna-info" style="margin-top:2px;"><a href="/shop/wish/list">위시리스트</a></li>
	<li class="member-leave"><a href="/shop/mypage/leave/confirm">회원탈퇴</a></li>
</ul>