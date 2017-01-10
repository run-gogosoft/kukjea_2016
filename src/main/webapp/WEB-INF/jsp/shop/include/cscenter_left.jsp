<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="lnb">
    <h2>고객센터</h2>
    <ul>
        <li <c:if test="${on eq '01'}">class="on"</c:if>><a href="/shop/cscenter/list/notice">공지사항</a></li>
        <li <c:if test="${on eq '02'}">class="on"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=10">자주하는 질문</a></li>
        <%--<li <c:if test="${on eq '03'}">class="on"</c:if>><a href="/shop/mypage/qna/list">Q&amp;A</a></li>--%>
        <!--li <c:if test="${on eq '04'}">class="on"</c:if>><a href="/shop/cscenter/guide">이용안내</a></li-->
        <li <c:if test="${on eq '05'}">class="on"</c:if>><a href="/shop/cscenter/policy">이용약관</a></li>
        <li <c:if test="${on eq '06'}">class="on"</c:if>><a href="/shop/cscenter/privacy">개인정보처리방침</a></li>
        <li <c:if test="${on eq '07'}">class="on"</c:if>><a href="/shop/cscenter/reject/email/collection">이메일무단수집거부</a></li>
        <li <c:if test="${on eq '08'}">class="on"</c:if>><a href="/shop/about/board/detail/list/1">판매요청</a></li>
        <li <c:if test="${on eq '09'}">class="on"</c:if>><a href="/shop/about/board/detail/list/2">제휴신청</a></li>
        <li <c:if test="${on eq '10'}">class="on"</c:if>><a href="/shop/about/board/detail/list/10">가격제안</a></li>
        <li <c:if test="${on eq '11'}">class="on"</c:if>><a href="/shop/cscenter/fax">FAX 주문</a></li>
        <c:if test="${sessionScope.loginSeq eq null || sessionScope.loginSeq eq 0}">
        <li <c:if test="${on eq '12'}">class="on"</c:if>><a href="/shop/cscenter/member/start">회원가입</a></li>
        <li <c:if test="${on eq '13'}">class="on"</c:if>><a href="/shop/cscenter/search/id">ID/PW 찾기</a></li>
        </c:if>
    </ul>
</div>