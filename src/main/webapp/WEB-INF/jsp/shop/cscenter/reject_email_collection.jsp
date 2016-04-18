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
                        <p>국제몰에서 취급되는 모든 개인정보는 개인정보 보호법 및 관련 법령상의 개인정보보호 규정을 준수하고 있습니다.</p>
                    </div>
                    <p class="txt_point">* 본 사이트에 게재 또는 등록된 이메일 주소를 수집하는 사항에 대한 위반은 아래 법령에 의하여 형사처벌될 수 있음을 유념하시기 바랍니다.</p>

                    <div class="terms_cont">
                        <h4>▶ 개인정보 보호법</h4>
                        <div class="scroll_box h315">
                            <dl>
                                <dt>제15조(개인정보의 수집ㆍ이용)</dt>
                                <dd>① 개인정보처리자는 다음 각 호의 어느 하나에 해당하는 경우에는 개인정보를 수집할 수 있으며 그 수집 목적의 범위에서 이용할 수 있다.
                                    <ol>
                                        <li>1. 정보주체의 동의를 받은 경우</li>
                                        <li>2. 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우</li>
                                        <li>3. 공공기관이 법령 등에서 정하는 소관 업무의 수행을 위하여 불가피한 경우</li>
                                        <li>4. 정보주체와의 계약의 체결 및 이행을 위하여 불가피하게 필요한 경우</li>
                                        <li>5. 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우</li>
                                        <li>6. 개인정보처리자의 정당한 이익을 달성하기 위하여 필요한 경우로서 명백하게 정보주체의 권리보다 우선하는 경우. 이 경우 개인정보처리자의 정당한 이익과 상당한 관련이 있고 합리적인 범위를 초과하지 아니하는 경우에 한한다.</li>
                                    </ol>
                                </dd>
                                <dd>② 개인정보처리자는 제1항제1호에 따른 동의를 받을 때에는 다음 각 호의 사항을 정보주체에게 알려야 한다. 다음 각 호의 어느 하나의 사항을 변경하는 경우에도 이를 알리고 동의를 받아야 한다.
                                    <ol>
                                        <li>1. 개인정보의 수집·이용 목적</li>
                                        <li>2. 수집하려는 개인정보의 항목</li>
                                        <li>3. 개인정보의 보유 및 이용 기간</li>
                                        <li>4. 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익이 있는 경우에는 그 불이익의 내용</li>
                                    </ol>
                                </dd>
                            </dl>
                        </div>
                    </div>

                    <div class="terms_cont">
                        <h4>▶ 정보통신망 이용촉진 및 정보보호등에 관한 법률</h4>
                        <div class="scroll_box h176">
                            <dl>
                                <dt>제15조(개인정보의 수집ㆍ이용)</dt>
                                <dd>① 개인정보처리자는 다음 각 호의 어느 하나에 해당하는 경우에는 개인정보를 수집할 수 있으며 그 수집 목적의 범위에서 이용할 수 있다.
                                    <ol>
                                        <li>1. 정보주체의 동의를 받은 경우</li>
                                        <li>2. 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우</li>
                                        <li>3. 공공기관이 법령 등에서 정하는 소관 업무의 수행을 위하여 불가피한 경우</li>
                                        <li>4. 정보주체와의 계약의 체결 및 이행을 위하여 불가피하게 필요한 경우</li>
                                        <li>5. 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우</li>
                                        <li>6. 개인정보처리자의 정당한 이익을 달성하기 위하여 필요한 경우로서 명백하게 정보주체의 권리보다 우선하는 경우. 이 경우 개인정보처리자의 정당한 이익과 상당한 관련이 있고 합리적인 범위를 초과하지 아니하는 경우에 한한다.</li>
                                    </ol>
                                </dd>
                                <dd>② 개인정보처리자는 제1항제1호에 따른 동의를 받을 때에는 다음 각 호의 사항을 정보주체에게 알려야 한다. 다음 각 호의 어느 하나의 사항을 변경하는 경우에도 이를 알리고 동의를 받아야 한다.
                                    <ol>
                                        <li>1. 개인정보의 수집·이용 목적</li>
                                        <li>2. 수집하려는 개인정보의 항목</li>
                                        <li>3. 개인정보의 보유 및 이용 기간</li>
                                        <li>4. 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익이 있는 경우에는 그 불이익의 내용</li>
                                    </ol>
                                </dd>
                            </dl>
                        </div>
                    </div>

                    <div class="btn_action rt">
                        <a href="http://www.law.go.kr" class="btn btn_gray" target="_blank">관련 법령 보러가기</a>
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
