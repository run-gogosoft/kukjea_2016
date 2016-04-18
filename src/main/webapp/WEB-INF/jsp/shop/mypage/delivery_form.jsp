<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
    <%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
    <link rel="stylesheet" href="/front-assets/css/common/common.css" />
    <link href="/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
    <link href="/front-assets/css/mypage/delivery.css" type="text/css" rel="stylesheet">
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
                    <h4><em class="must">*</em> 배송지정보</h4>
                    <form id="memberMod" action="<c:choose><c:when test="${vo eq null}">/shop/mypage/delivery/reg/proc</c:when><c:otherwise>/shop/mypage/delivery/mod/${vo.seq}/proc/</c:otherwise></c:choose>" method="post" target="zeroframe" onsubmit="return doSubmit(this);">
                        <table id="defaultTable" class="board_write">
                            <caption>회원 기본정보 작성</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>제목</th>
                                <td>
                                    <input type="text" class="intxt w250" name="title" id="title" value="${vo.title}" maxlength="15" data-required-label="제목">
                                    <label style="margin-left:10px;">
                                        <input type="checkbox" name="defaultFlag" value="Y" <c:if test="${vo.defaultFlag eq 'Y'}">checked="checked"</c:if> />
                                        &nbsp;기본 배송지로 설정
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <th>수취인</th>
                                <td><input type="text" class="intxt w180" name="name" value="${vo.name}" maxlength="15" data-required-label="수취인"></td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td>
                                    <input type="text" class="intxt w50" name="tel1" value="${vo.tel1}" maxlength="4" onblur="numberCheck(this);" data-required-label="전화번호">&nbsp;-&nbsp;
                                    <input type="text" class="intxt w50" name="tel2" value="${vo.tel2}" maxlength="4" onblur="numberCheck(this);" data-required-label="전화번호">&nbsp;-&nbsp;
                                    <input type="text" class="intxt w50" name="tel3" value="${vo.tel3}" maxlength="4" onblur="numberCheck(this);" data-required-label="전화번호">
                                </td>
                            </tr>
                            <tr>
                                <th>휴대폰번호</th>
                                <td>
                                    <input type="text" class="intxt w50" name="cell1" value="${vo.cell1}" maxlength="3" onblur="numberCheck(this);" data-required-label="휴대폰번호">&nbsp;-&nbsp;
                                    <input type="text" class="intxt w50" name="cell2" value="${vo.cell2}" maxlength="4" onblur="numberCheck(this);" data-required-label="휴대폰번호">&nbsp;-&nbsp;
                                    <input type="text" class="intxt w50" name="cell3" value="${vo.cell3}" maxlength="4" onblur="numberCheck(this);" data-required-label="휴대폰번호">
                                </td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td>
                                    <input type="text" class="intxt w180" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" alt="우편번호" data-required-label="우편번호" readonly />
                                    <button type="button" class="btn btn_gray btn_sm" onclick="CHPostCodeUtil.postWindow('open', '#defaultTable');"><span>우편번호찾기</span></button>
                                    <!-- <span class="description">사업자등록증 상의 주소를 입력해주세요.</span> -->
                                    <br/>
                                    <p class="mt10"><input type="text" class="intxt w560 addr" name="addr1" value="${vo.addr1}" maxlength="100" alt="주소" data-required-label="주소" readonly /></p>
                                    <p class="mt10"><input type="text" class="intxt w560 addr" name="addr2" value="${vo.addr2}" maxlength="100" alt="상세주소" data-required-label="상세주소"/></p>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="btn_action rt">
                            <button type="submit" class="btn btn_red">
                                <c:choose><c:when test="${vo eq null}">등록</c:when><c:otherwise>수정</c:otherwise></c:choose>
                            </button>

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
<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>
<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>
<script type="text/javascript">
    /** 배송지 등록/수정 */
    var doSubmit = function(frmObj) {
        /* 필수값 체크 */
        return checkRequiredValue(frmObj, "data-required-label");
    };
</script>
</body>
</html>
