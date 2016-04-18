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
            <%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/mypage_anchor.jsp" %>
                <div class="sub_cont myinfo">
                    <div class="join_form">
                        <form method="post" onsubmit="return CHProcessUtil.submitProc(this);" action="/shop/mypage/mod/proc" target="zeroframe">
                            <%@ include file="/WEB-INF/jsp/shop/include/member_form.jsp" %>

                            <div class="btn_action rt">
                                <button type="submit" class="btn btn_red">정보 수정하기</button>
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
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script>
    var CHProcessUtil = {
        submitProc:function(obj) {
            var flag = true;
            $(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
                if(flag && $(this).val() == "") {
                    alert($(this).attr("alt") + "란을 입력해주세요!");
                    flag = false;
                    $(this).focus();
                }
            });
            return flag;
        }
        , passwordProc:function(obj) {
            var flag = true;
            $(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
                if(flag && $(this).val() == "") {
                    alert($(this).attr("alt") + "란을 입력해주세요!");
                    flag = false;
                    $(this).focus();
                }
            });
            if(!flag) {
                return false;
            }

            if($("#newPassword").val() != $("#newPassword_confirm").val()) {
                alert("패스워드가 일치하지 않습니다.");
                $("#newPassword").focus();
                return false;
            }

            return true;
        }
    };
</script>
</body>
</html>
