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
                        <dl class="offer_price">
                            <dt>가격제안이란?</dt>
                            <dd>국제실업쇼핑몰의 회원님께 최저가 정책을 실현하기 위해 회원님과 소통을 통해 이뤄지는 상호운영서비스 입니다.<br />
                                국제실업쇼핑몰의 상품을 다른 몰에서 더 싸게 제공 할 경우 참고자료(해당 URL 또는 캡쳐 화면)를 보내주세요.<br />
                                국제실업에서 확인 후 가격 조정 및 상응하는 조치를 하여 회원님께 보다 양질의 서비스를 제공하도록 노력하겠습니다.<br />
                                아울러 자료를 제공해주신 회원님께는 감사의 의미로 국제실업쇼핑몰에서 현금처럼 사용할 수 있는 포인트를 지급하여 드립니다.
                            </dd>
                        </dl>
                    </div>

                    <div class="order_list mt30">
                        <h4>제안방법</h4>
                        <ol>
                            <li>
                                1. 우리 사이트의 <em>상품설명에 우측</em>에 있는  <em>“가격제안” 버튼</em>을 누르세요.
                                <p class="img ct"><img src="/images/contents/img_offer_price01.png" alt=""></p>
                            </li>
                            <li>
                                2. 작성을 위한 안내 창이 뜨면 작성을 해주세요.
                                <p class="img lt"><img src="/images/contents/img_offer_price02.png" alt=""></p>
                            </li>
                        </ol>
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
