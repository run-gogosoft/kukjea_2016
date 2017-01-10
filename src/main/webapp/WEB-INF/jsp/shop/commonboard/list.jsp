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
                    <!-- board_list -->
                    <table class="board_list">
                        <caption>게시글 목록</caption>
                        <colgroup>
                            <col style="width:10%" />
                            <col style="width:auto" />
                            <col style="width:15%" />
                            <col style="width:15%" />
                            <col style="width:15%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${list}" varStatus="status">
                        <tr>
                            <td>${item.seq}</td>
                            <td class="lt">
                                <a href="/shop/about/board/detail/view/${item.seq}?commonBoardSeq=${vo.commonBoardSeq}">${item.title }</a>
                                <c:if test="${item.isFile eq 'Y'}"><i class="fa fa-save"></i></c:if>
                                <c:if test="${cvo.commentUseFlag eq 'Y'}">[${item.commentCnt}]</c:if>
                                <c:if test="${item.secretFlag eq 'Y'}"><i class="fa fa-lock" style="margin-left:10px;color:#555"></i></c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.userSeq eq null}">
                                        <strong>${item.userName}</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${item.userTypeCode eq 'A'}">
                                                <strong>관리자</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <strong>${item.memberName}</strong>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                                <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/></td>
                            <td><strong>${item.viewCnt}</strong></td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <!-- //board_list -->
                    <div class="board_action">${paging}</div>
                </div>
                <div>
                    <div class="btn_rt">
                        <button class="btn btn_red" onclick="CHCommonBoardUtil.pageMove('${sessionScope.loginSeq}','${vo.commonBoardSeq}')">
                            <c:choose>
                                <c:when test="${vo.commonBoardSeq eq 1}">판매요청하기</c:when>
                                <c:when test="${vo.commonBoardSeq eq 2}">제휴문의</c:when>
                                <c:when test="${vo.commonBoardSeq eq 10}">가격요청하기</c:when>
                            </c:choose>
                        </button>
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
<div id="lockLayer" class="hh-writebox-lock">
    <div class="hh-writebox-wrap">
        <div class="hh-writebox-header">
            비밀번호 확인
        </div>
        <div class="hh-writebox-content">
            <div style="font-size: 11px; list-style:none; padding:0; margin-left:10px;">
                <div style="text-indent: -11px">* 게시물의 열람을 원하시면 비밀번호를 입력하세요. </div>
            </div>

            <div style="text-align: center; margin-top:20px;">
                <table class="table">
                    <tr>
                        <td style="text-align:center; vertical-align:middle; width:120px;">
                            <strong>비밀번호</strong><br/>
                        </td>
                        <td style="text-align: left;">
                            <input type="password" id="lockPassword" name="password" class="form-control" maxlength="65" style="width:150px;" alt="비밀번호"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin:10px 0 0 0;text-align: center">
                <button type="button" class="btn btn-info btn-default" onclick="CHCommonBoardUtil.submitProc('list');">확인</button>
                <button type="button" class="btn btn-default" onclick="CHCommonBoardUtil.close();">취소</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/front-assets/js/commonboard/commonboard.js"></script>
<script>
var goPage = function (page) {
    location.href = location.pathname + "?pageNum=" + page;
};
</script>
</body>
</html>
