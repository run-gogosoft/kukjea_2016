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
                            <li class="on"><a href="/shop/cscenter/search/id">ID 찾기</a></li>
                            <li><a href="/shop/cscenter/search/pw">PW 찾기</a></li>
                        </ul>
                    </div>
                    <dl class="attention">
                        <dt>안내</dt>
                        <dd>
                            <p>회원님의 정보를 입력하시면 가입한 아이디를 조회하실 수 있습니다.</p>
                        </dd>
                    </dl>
                    <form method="post" action="/shop/member/id/proc" target="zeroframe">
                        <!-- board_write -->
                        <table class="board_write">
                            <caption>회원정보 작성</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
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
                        <div class="btn_action rt">
                            <button type="submit" class="btn btn_red">찾기</button>
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
<div class="info_box"><div class="id_info"><p>해당 정보와 일치하는 ID 는 <%="${id}"%> 입니다.</p></div></div>
<p class="info_txt txt_point">※ 개인정보 보호를 위해 일부는 * 표 처리 합니다.</p>
</script>
<script>
    function callbackProc(id) {
        $('#SearchBody').html( $('#SearchTemplate').tmpl({id:id}) );
    }
</script>
</body>
</html>
