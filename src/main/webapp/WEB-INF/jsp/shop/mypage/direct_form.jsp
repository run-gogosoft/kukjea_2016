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
            <%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/mypage_anchor.jsp" %>
                <div class="sub_cont myinfo">
                    <form method="post" onsubmit="return submitProc(this);" action="<c:choose><c:when test="${vo eq null}">/shop/mypage/direct/reg/proc</c:when><c:otherwise>/shop/mypage/direct/mod/proc</c:otherwise></c:choose>" target="zeroframe" enctype="multipart/form-data">
                        <input type="hidden" name="seq" value="${vo.seq}">
                        <table id="defaultTable" class="board_write">
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>구분<span>*</span></th>
                                <td>
                                    <select name="categoryCode" id="categoryCode">
                                    <option value="">-- 선택 --</option>
                                    <c:forEach var="item" items="${commonList}">
                                    <option value="${item.value}" <c:if test="${vo.categoryCode eq item.value}">selected</c:if>>${item.name}</option>
                                    </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>제목<span>*</span></th>
                                <td><input type="text" class="intxt w560" name="title" value="${vo.title}" maxlength="15" alt="제목"/></td>
                            </tr>
                            <tr>
                                <th>문의내용<span>*</span></th>
                                <td>
                                    <textarea name="content" style="width:100%;height:303px;resize: none;" alt="문의내용">${vo.content}</textarea>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <%-- div class="sign-form form6">
                            <div class="inner" style="height:auto;">
                                <div class="title-back">
                                    <div class="title-wrap">
                                        <div class="title">파일첨부</div>
                                        <div class="sub-description">최대 250MB까지 업로드하실 수 있습니다</div>
                                    </div>
                                </div>
                                <table class="table sign-table">
                                    <tr>
                                        <td>
                                            <div id="fileDiv">
                                                <div id="FileList" style="padding-left: 15px;">
                                                    <c:if test="${vo eq null}">
                                                        <div>
                                                            <div class="form-group">
                                                                <label></label>
                                                                <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
                                                                <input type="file" onchange="checkFileSize(this);" id="file1" name="file1" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${vo ne null}">
                                                        <c:forEach var="item" items="${file}">
                                                            <div class="file-wrap${item.num}">
                                                                <div class="form-group">
                                                                    <span class="btn btn-default btn-file">
                                                                    <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
                                                                    <input type="file" onchange="checkFileSize(this);" id="file${item.num}" name="file${item.num}" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
                                                                    </span>
                                                                    <label></label>
                                                                    <p class="help-block" style="padding-left: 40px">
                                                                            ${item.filename} 파일이 등록되어 있습니다
                                                                        <a href="/shop/mypage/direct/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">[다운로드]</a>
                                                                        <a href="/shop/mypage/direct/file/delete/proc?seq=${vo.seq}&num=${item.num}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" class="text-danger" target="zeroframe">[삭제]</a>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </c:if>
                                                </div>
                                                <div>
                                                    <button type="button" onclick="addFilePane()" class="btn btn-link btn-sm"><i class="fa fa-plus"></i> 항목 더 추가하기</button>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div --%>

                        <div class="pull-right" style="margin-top:15px;">
                            <button type="submit" class="btn btn_blue">
                                <c:choose>
                                    <c:when test="${vo eq null}">등록하기</c:when>
                                    <c:otherwise>수정하기</c:otherwise>
                                </c:choose>
                            </button>
                            <button type="button" class="btn btn_gray" onclick="history.back()">목록으로</button>
                        </div>
                        <input type="hidden" name="code" value="directBoard">
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

<script id="FileTemplate" type="text/html">
    <div>
        <div class="form-group">
            <label></label>
            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="/front-assets/js/mypage/direct.js"></script>
</body>
</html>