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
                    <!-- board_view -->
                    <div class="board_view">
                        <div class="view_tit">
                            <em>${vo.title}</em>
                        </div>
                        <div class="view_info">
                            <dl>
                                <dt>작성자</dt>
                                <dd>${vo.name}</dd>
                                <dt>등록일</dt>
                                <dd><fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
                                    <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/></dd>
                                <dt>조회수</dt>
                                <dd>${vo.viewCnt}</dd>
                            </dl>
                        </div>
                        <%-- 첨부파일이 존재할 경우 --%>
                        <c:if test="${vo.isFile eq 'Y'}">
                            <div class="view_info">
                                <dl>
                                    <c:forEach var="item" items="${file}">
                                        <dt>
                                            <a href="/shop/cscenter/notice/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
                                                <i class="fa fa-floppy-o"></i> ${item.filename}
                                            </a>
                                        </dt>
                                    </c:forEach>
                                </dl>
                            </div>
                        </c:if>
                        <div class="view_cont">
                            <iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
                        </div>
                        <div class="view_cont">
                            <div class="btn_rt">
                            <c:if test="${(vo.userSeq ne null or vo.userPassword ne '') and vo.userTypeCode ne 'A'}">
                                <button type="button" class="btn btn_blue" onclick="CHCommonBoardUtil.editConfirm('${vo.secretFlag}','${vo.seq}','${sessionScope.loginSeq}', '${vo.userSeq}', '${vo.userTypeCode}')">수정하기</button>
                                <button type="button" class="btn btn_red" onclick="CHCommonBoardUtil.showDeleteModal();">삭제</button>
                            </c:if>
                                <a href="/shop/about/board/detail/list/${vo.commonBoardSeq}" class="btn btn_gray">목록보기</a>
                            </div>
                        </div>
                    </div>
                    <!-- //board_view -->

                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>
<div id="iframe_content" style="display:none">${vo.content}</div>
<div id="iframe_content_answer" style="display:none">${vo.answer}</div>

<script type="text/javascript" src="/front-assets/js/commonboard/commonboard.js"></script>
<script>
    $(document).ready(function(){
        $(window).load(function() {
            //글내용
            $("#content_view").contents().find("body").html($("#iframe_content").html());
            $("#content_view").height($("#content_view").contents().find("body")[0].scrollHeight + 30);
            <c:if test="${vo.answerFlag eq 'Y'}">
            //답변
            $("#answer_view").contents().find("body").html($("#iframe_content_answer").html());
            $("#answer_view").height($("#answer_view").contents().find("body")[0].scrollHeight + 30);
            </c:if>
        });
    });
</script>
</body>
</html>
