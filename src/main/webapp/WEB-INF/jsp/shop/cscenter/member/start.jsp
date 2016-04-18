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
                    <form action="form" onsubmit="return submitProc()">
                        <ul class="join_step step01">
                            <li class="step01"><span>STEP.1</span>약관동의</li>
                            <li class="step02"><span>STEP.2</span>정보입력</li>
                            <li class="step03"><span>STEP.3</span>가입완료</li>
                        </ul>

                        <div class="agree_cont">
                            <h4>이용약관 (필수)</h4>
                            <div class="scroll_box">
                                이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다.이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다. 이용약관내용 들어갑니다.
                            </div>
                            <div class="rt">
                                <label><input type="checkbox" class="check" name="termsService" value="y" />위 사항에 동의합니다.</label>
                                <a href="#" class="btn btn_gray btn_xs" title="이용약관 전체보기">전체보기</a>
                            </div>
                        </div>

                        <div class="agree_cont">
                            <h4>개인정보수집 및 이용목적 (필수)</h4>
                            <div class="scroll_box">
                                개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다. 개인정보수집 및 이용목적 들어갑니다.
                            </div>
                            <div class="rt">
                                <label><input type="checkbox" class="check" name="termsPrivacy" value="y" />위 사항에 동의합니다.</label>
                                <a href="#" class="btn btn_gray btn_sm" title="개인정보수집 및 이용목적 전체보기">전체보기</a>
                            </div>
                        </div>

                        <div class="agree_cont">
                            <h4>개인정보 제3자 제공 (필수)</h4>
                            <div class="scroll_box">
                                개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다. 개인정보 제3자 제공 내용이 들어갑니다.
                            </div>
                            <div class="rt">
                                <label><input type="checkbox" class="check" name="termsThirdParty" value="y" />위 사항에 동의합니다.</label>
                                <a href="#" class="btn btn_gray btn_sm" title="개인정보 제3자 제공">전체보기</a>
                            </div>
                        </div>

                        <div class="btn_action rt">
                            <button type="submit" class="btn btn_red">약관동의</button>
                            <button type="reset" class="btn btn_gray">취소하기</button>
                        </div>
                        <input type="hidden" name="allCheckFlag" value="" />
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


<script>
    function submitProc() {
        $('input[name=termsService]').prop('checked') &&
            $('input[name=termsPrivacy]').prop('checked') &&
            $('input[name=termsThirdParty]').prop('checked') &&
            $('input[name=allCheckFlag]').val('Y');
    }
</script>
</body>
</html>
