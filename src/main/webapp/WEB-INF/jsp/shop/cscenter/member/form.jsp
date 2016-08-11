<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
    <%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
    <link rel="stylesheet" href="/front-assets/css/common/common.css" />
</head>
<body>

<div id="skip_navi">
    <p><a href="#contents">본문바로가기</a></p>
</div>

<div id="wrap" class="sub">
    <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
    <div id="container">
        <div class="layout_inner sub_container">
            <%@ include file="/WEB-INF/jsp/shop/include/cscenter_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/cscenter_anchor.jsp" %>
                <div class="sub_cont">
                    <div class="join_form">

                        <form name="reg" role="form" method="post" onsubmit="return CHInsertUtil.submitProc(this,'P');" action="/shop/cscenter/member/proc" target="zeroframe">
                            <ul class="join_step step02">
                                <li class="step01"><span>STEP.1</span>약관동의</li>
                                <li class="step02"><span>STEP.2</span>정보입력</li>
                                <li class="step03"><span>STEP.3</span>가입완료</li>
                            </ul>

                            <%@ include file="/WEB-INF/jsp/shop/include/member_form.jsp" %>

                            <div class="btn_action rt">
                                <button type="submit" class="btn btn_red">회원가입</button>
                                <button type="reset" class="btn btn_gray">다시작성하기</button>
                            </div>
                        </form>
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

<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>
<script type="text/javascript" src="/front-assets/js/plugin/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/front-assets/js/member/member.js"></script>
</body>
</html>
