<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="header">
    <div class="global_top">
        <div class="layout_inner">
            <a href="#" id="favorite" class="btn_favorite">즐겨찾기 추가</a>
            <ul class="mall_links">
                <li><a href="#">병원몰</a></li>
                <li><a href="#">약국몰</a></li>
                <li><a href="#">B2B 몰</a></li>
            </ul>
            <c:choose>
            <c:when test="${sessionScope.loginSeq > 0}">
                <ul class="utils">
                    <li class="user">${sessionScope.loginName}님 ( <em data-access="point">---</em> 포인트)</li>
                    <li><a href="/shop/cart">장바구니</a></li>
                    <li><a href="/shop/mypage/main">마이페이지</a></li>
                    <li><a href="/shop/mypage/order/list">주문배송조회</a></li>
                    <li><a href="/shop/cscenter/list/notice">고객센터</a></li>
                    <li><a href="/shop/logout">로그아웃</a></li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="utils">
                    <li><a href="/shop/login">로그인</a></li>
                    <li><a href="/shop/cscenter/member/start">회원가입</a></li>
                    <li><a href="/shop/cscenter/search/id">ID/PW찾기</a></li>
                    <li><a href="/shop/mypage/main">마이페이지</a></li>
                    <li><a href="/shop/cscenter/list/notice">고객센터</a></li>
                </ul>
            </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="layout_inner search_section">
        <h1><a href="/shop/main"><img src="/images/common/logo.png" alt="국제몰 (KUK JE MALL)" /></a></h1>
        <div class="search">
            <form action="/shop/search" role="form" onsubmit="return checkRequiredValue(this, 'data-required-label');">
                <fieldset>
                    <legend>통합검색</legend>
                    <div class="search_area">
                        <input type="text" name="name" class="intxt search-input" placeholder="검색어 입력" style="ime-mode:active" />
                        <button type="submit" class="btn_total_search"><span class="blind">검색</span></button>
                    </div>
                </fieldset>
            </form>
            <div class="popular_keyword">
                <dl>
                    <dt><span class="icon icon_search"><span class="blind">인기검색어</span></span></dt>
                    <dd>
                        <a href="/shop/search?name=드레싱포셉">드레싱포셉</a>
                        <a href="/shop/search?name=일회용주사기">일회용주사기</a>
                        <a href="/shop/search?name=발마사지기">발마사지기</a>
                    </dd>
                </dl>
                <%-- div class="btn_paging">
                    <button class="btn_prev"><span class="blind">이전</span></button>
                    <button class="btn_next"><span class="blind">다음</span></button>
                </div --%>
            </div>
        </div>
        <div class="promotion_top">
            <img src="/images/thumb/thumb_promotion230x70.jpg" alt="">
        </div>
        <p class="noti">[공지] 국제몰 오픈 안내 공지사항 입니다. 공지공지공지공지 공지가 길면...</p>
    </div>

    <%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
</div>