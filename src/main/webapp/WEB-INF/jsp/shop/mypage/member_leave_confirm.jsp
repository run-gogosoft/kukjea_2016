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
                <div class="sub_cont myinfo">
                    <form method="post" onsubmit="return submitProc(this);" action="/shop/mypage/confirm/proc?member=leave" target="zeroframe">
                        <div class="cont_box mt5">
                            <dl class="attention">
                                <dt>주의사항</dt>
                                <dd>
                                    <p>회원탈퇴를 하시면, 더 이상의 사이트 이용은 불가능합니다.</p>
                                    <p>탈퇴하신 계정의 아이디는 14일 동안 동일한 ID로 가입이 불가능 합니다.</p>
                                    <p>사용하지 않은 쿠폰/티켓 또는 충전된 포인트가 있는 경우, 사용하신 후 탈퇴해 주세요.</p>
                                    <p>잔여 포인트는 탈퇴와 함께 삭제되며 환불되지 않습니다</p>
                                </dd>
                            </dl>
                            <div class="member_pw">
                                <p class="bul_dot_gray">회원 탈퇴를 위해 <em class="txt_point">비밀번호</em>를 입력해주세요.</p>
                                <div class="pw">
                                    <label for="userPw">비밀번호</label>
                                    <input type="password" id="userPw" name="password" class="intxt" maxlength="16" placeholder="* * * * *" alt="비밀번호" />
                                </div>
                            </div>
                        </div>
                        <div class="btn_action rt">
                            <button type="submit" class="btn btn_red">확인</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>

</body>
</html>
