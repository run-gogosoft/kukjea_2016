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

                    <form action="<c:choose><c:when test="${vo eq null}">/shop/about/board/detail/reg/proc</c:when><c:otherwise>/shop/about/board/detail/edit/proc</c:otherwise></c:choose>" method="post" target="zeroframe" onsubmit="return CHBoardUtil.submitProc(this, '${sessionScope.loginSeq}')" enctype="multipart/form-data">
                        <!-- board_write -->
                        <table class="board_write">
                            <caption>판매요청 양식 작성</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row"><label>작성자</label></th>
                                <td>
                                    <c:choose>
                                        <c:when test="${vo eq null}">
                                            <%--commonBoardSeq가 2이라면 입점문의이다.--%>
                                            <c:choose>
                                                <c:when test="${commonBoardSeq eq 1}">
                                                    ${sessionScope.loginName}
                                                </c:when>
                                                <c:when test="${commonBoardSeq eq 2}">
                                                    <c:choose>
                                                        <c:when test="${sessionScope.loginSeq > 0}">
                                                            ${sessionScope.loginName}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="text" id="userName" name="userName" value="${vo.userName}" class="form-control" maxlength="6" alt="이름" style="width:150px;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${vo.userSeq eq null}">
                                                    ${vo.userName}
                                                </c:when>
                                                <c:otherwise>
                                                    ${vo.memberName}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <th scope="row"><label>비밀글</label></th>
                                <td>
                                    <input type="checkbox" class="checkbox" id="secretFlag" style="vertical-align:middle" onclick="CHBoardUtil.secretCheck(this, '${sessionScope.loginSeq}')" <c:if test="${vo.secretFlag eq 'Y'}">checked</c:if>/> 비밀글 설정
                                    <input type="hidden" id="postSecretFlag" name="secretFlag" value="<c:choose><c:when test="${vo eq null}">N</c:when><c:otherwise>${vo.secretFlag}</c:otherwise></c:choose>">
                                </td>
                            </tr>

                            <%-- tr id="passTr" <c:if test="${vo.secretFlag ne 'Y'}">style="display:none"</c:if>>
                                <th scope="row"><label>비밀번호</label></th>
                                <td colspan="3"><input type="password" id="userPassword" name="userPassword" class="intxt w50" maxlength="150"></td>
                            </tr --%>

                            <%-- tr>
                                <th scope="row"><label for="email">E-mail</label></th>
                                <td colspan="3">
                                    <input type="text" id="email" class="intxt w360" />
                                </td>
                            </tr --%>
                            <tr>
                                <th scope="row"><label>제목</label></th>
                                <td colspan="3">
                                    <input type="text" name="title" class="intxt wfull" value="${vo.title}" maxlength="150" alt="제목" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>내용</label></th>
                                <td colspan="3">
                                    <textarea cols="30" rows="10" name="content" alt="내용" class="intxt h300">${vo.content}</textarea>
                                </td>
                            </tr>
                            <c:if test="${commonBoardSeq eq 1 or vo.commonBoardSeq eq 2}">
                            <tr>
                                <th scope="row">첨부파일</th>
                                <td colspan="3">
                                    <div class="attach_file default">
                                        <div class="inser_file"><input type="text" class="intxt wfull" readonly="readonly" title="사업자 첨부파일" /></div>
                                        <div class="btn_file">첨부파일 찾기<input type="file" class="file-search" title="File" onchange="checkFileSize(this);" id="file1" name="file1" /></div>
                                    </div>
                                    <p class="error_msg warning mt5">※ 첨부파일은 그림파일(.jpg. .jpeg, .bmp, .png,)만 등록 가능합니다.</p>
                                </td>
                            </tr>
                            </c:if>
                            </tbody>
                        </table>
                        <!-- //board_write -->
                        <!-- p class="mt10 mb-25">※ 작성된 글은 관리자에게만 발송이 되고 확인 후 연락처(휴대전화, e-mail)를 통해 연락을 드립니다.</p -->

                        <div class="btn_action rt">
                            <button type="submit" class="btn btn_red">등록하기</button>
                        </div>
                        <input type="hidden" name="commonBoardSeq" value="<c:choose><c:when test="${vo eq null}">${commonBoardSeq}</c:when><c:otherwise>${vo.commonBoardSeq}</c:otherwise></c:choose>">
                        <c:if test="${vo ne null}">
                            <input type="hidden" name="seq" value="${vo.seq}">
                        </c:if>
                        <input type="hidden" name="code" value="itemRequest">
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
<script type="text/javascript" src="/front-assets/js/commonboard/commonboard.js"></script>
</body>
</html>
