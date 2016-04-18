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
                <div class="sub_cont find_idpw">
                    <div class="tab_content item2">
                        <ul>
                            <li><a href="/shop/cscenter/search/id">ID 찾기</a></li>
                            <li class="on"><a href="/shop/cscenter/search/pw">PW 찾기</a></li>
                        </ul>
                    </div>
                    <dl class="attention">
                        <dt>안내</dt>
                        <dd>
                            <p>본인 확인을 위해 회원가입시의 정보를 입력바랍니다.</p>
                        </dd>
                    </dl>
                    <form method="post" action="/shop/member/password/proc" target="zeroframe">
                        <!-- board_write -->
                        <table class="board_write">
                            <caption>회원정보 작성</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row"><label for="userId">아이디</label></th>
                                <td>
                                    <input type="text" id="userId" class="intxt w180" maxlength="50" name="id" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="userName">이름</label></th>
                                <td>
                                    <input type="text" id="userName" class="intxt w180" maxlength="15" name="name" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="email">이메일</label></th>
                                <td>
                                    <input type="email" id="email" class="intxt w220" maxlength="60" name="email" />
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- //board_write -->
                        <div class="btn_action rt">
                            <button type="submit" class="btn btn_red">임시비밀번호 받기</button>
                        </div>

                        <div id="SearchBody"></div>
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
<script id="SearchTemplate" type="text/html">
<dl class="attention align_top">
    <dt>안내</dt>
    <dd>
        <p>정보조회가 완료되었습니다.</p>
        <p>수신하신 메일에 임시 비밀번호를 이용하여 로그인하여 주시기 바랍니다.</p>
        <p>원활한 이용을 위해 로그인 하신 후 비밀번호 재설정을 하여주시기 바랍니다.</p>
    </dd>
</dl>
</script>
<script>
function callbackProc(flag) {
    if(flag === 'true') {
        $('#SearchBody').html( $('#SearchTemplate').tmpl({}) );
    }
}
</script>
</body>
</html>
