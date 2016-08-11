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
                    <div class="privacy_intro">
                        <div class="cont">
                            <p>
                            목적<br />
                            - 판매자와 구매자의 거래의 원활한 진행, 본인의사의 확인, 고객 상담 및 불만처리, 상품과 경품 배송을 위한 배송지 확인 등<br />
                                <br />
                            항목<br />
                            - 구매자 이름, 전화번호, ID, 휴대폰번호, 이메일주소, 상품 구매정보<br />
                            - 상품 수취인 정보(이름, 주소, 전화번호)<br />
                                <br />
                            제공받는자<br />
                            - 선택한 상품의 공급업체<br />
                            - 구매한 상품 배송관련업체<br />
                                <br />
                            보유 및 이용기간<br />
                            - 배송 후 1달
                            </p>
                        </div>
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
