<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<ul class="main-menu">
	<li class="main">고객센터</li>
	<li class="faq">자주 묻는 질문</li>
	<li class="faq-sub">
		<ul class="sub-list">
			<li><a href="/shop/cscenter/list/faq?categoryCode=10">회원</a></li>
			<li><a href="/shop/cscenter/list/faq?categoryCode=20">주문/결제/배송</a></li>
			<li><a href="/shop/cscenter/list/faq?categoryCode=30">환불/취소/재고</a></li>
			<li><a href="/shop/cscenter/list/faq?categoryCode=40">영수증</a></li>
			<li><a href="/shop/cscenter/list/faq?categoryCode=50">이벤트</a></li>
			<li><a href="/shop/cscenter/list/faq?categoryCode=60">기타</a></li>
		</ul>
	</li>
	<li class="notice" style="cursor:pointer" onclick="location.href='/shop/cscenter/list/notice'">공지사항</li>
</ul>