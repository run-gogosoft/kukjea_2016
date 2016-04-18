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
            <%@ include file="/WEB-INF/jsp/shop/include/cscenter_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/cscenter_anchor.jsp" %>
                <div class="sub_cont">
                    <div class="tit_box">
                        <dl class="order_fax">
                            <dt>FAX 주문이란?</dt>
                            <dd>온라인에 익숙하지 않거나 어려움이 있으신 회원분들에게 FAX로 주문하여 정상적으로 이용할 수 있도록 만드는<br />회원 편의 시스템입니다.</dd>
                        </dl>
                    </div>

                    <div class="order_list mt35">
                        <h4>주문 방법</h4>
                        <ol>
                            <li>1. FAX 주문양식을 내 컴퓨터로 다운 받습니다.</li>
                            <li class="mt35">
                                2. 해당 내용을 작성하여 국제몰로 FAX를 발송합니다.
                                <p class="number">국제몰 FAX <strong>02-888-9999</strong></p>
                            </li>
                            <li class="mt35">
                                3. 주문한 주문서 확인을 위해 고객센터로 전화 확인 부탁드립니다.
                                <p class="number">국제몰 고객센터 <strong>02-888-7777</strong></p>
                            </li>
                        </ol>

                        <h4 class="mt40">FAX 주문서</h4>
                        <ul class="fax_docu_list">
                            <li><a href="#"><img src="/images/contents/btn_fax_hwp.png" alt="한글 FAX 주문서" /></a></li>
                            <li><a href="#"><img src="/images/contents/btn_fax_word.png" alt="MS Word FAX 주문서" /></a></li>
                            <li><a href="#"><img src="/images/contents/btn_fax_excel.png" alt="MS EXCEL FAX 주문서" /></a></li>
                        </ul>
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

</body>
</html>
