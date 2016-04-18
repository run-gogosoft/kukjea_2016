<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
  <link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
  <link href="${const.ASSETS_PATH}/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
  <link href="${const.ASSETS_PATH}/front-assets/css/commonboard/form.css" type="text/css" rel="stylesheet">
  <title>${title}</title>

</head>
<body>
<c:choose>
  <c:when test="${commonBoardSeq eq 3 or vo.commonBoardSeq eq 3}">
    <%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>
  </c:when>
  <c:otherwise>
    <%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
  </c:otherwise>
</c:choose>

<div class="main-title">
  ${vo.name}
</div>

<div class="sign-form form1" <c:if test="${vo.userTypeCode eq 'A'}">style="margin:25px auto 50px auto;"</c:if>>
  <div class="inner">
    <div class="title-back">
      <div class="title-wrap">
        <div class="title">${vo.name}</div>
      </div>
    </div>
    <table class="table sign-table">
      <tr>
        <td style="width:150px" class="text-center">조회수</td>
        <td>${vo.viewCnt}</td>
      </tr>
      <tr>
        <td style="width:150px" class="text-center">작성자</td>
        <td>
          <c:choose>
            <c:when test="${vo.userSeq eq null}">
              ${vo.userName}
            </c:when>
            <c:otherwise>
              <c:choose>
                <c:when test="${vo.userTypeCode eq 'A'}">
                  관리자
                </c:when>
                <c:otherwise>
                  ${vo.memberName}
                </c:otherwise>
              </c:choose>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <td style="width:150px" class="text-center">제목</td>
        <td>${vo.title}</td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:center">
          <%-- 첨부파일이 존재할 경우 --%>
          <c:if test="${vo.isFile eq 'Y'}">
            <div style="padding:5px 15px 5px 0;">
                <ul class="list-unstyled">
                    <c:forEach var="item" items="${file}">
                        <li>
                            <img src='/shop/about/board/file/download/proc?seq=${vo.seq}&num=${item.num}&commonBoardSeq=${vo.commonBoardSeq}' style="max-width:700px"/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
          </c:if>
          <!-- <iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe> -->
        </td>
      </tr>

      <c:if test="${vo.answerFlag eq 'Y'}">
        <tr>
          <td style="width:150px" class="text-center">답변자</td>
          <td>관리자</td>
        </tr>
        <tr>
          <td style="width:150px" class="text-center">답변</td>
          <td>
          	<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
          </td>
        </tr>
      </c:if>
    </table>
  </div>
</div>

<div class="button-wrap">
  <%-- <c:if test="${sessionScope.loginSeq > 0}"> --%>
    <c:if test="${(vo.userSeq ne null or vo.userPassword ne '') and vo.userTypeCode ne 'A'}">
      <button type="button" class="btn btn-confirm" onclick="CHCommonBoardUtil.editConfirm('${vo.secretFlag}','${vo.seq}','${sessionScope.loginSeq}', '${vo.userSeq}', '${vo.userTypeCode}')"><span>수정하기</span></button>
      <button type="button" class="btn btn-danger" onclick="CHCommonBoardUtil.showDeleteModal();" style="margin-left:26px;"><span>삭제하기</span></button>
    </c:if>
  <%-- </c:if> --%>
  <button type="button" class="btn btn-cancel" onclick="location.href='/shop/about/board/detail/list/${vo.commonBoardSeq}'"><span>목록보기</span></button>
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
            <td style="text-align: left;vertical-align:middle">
              <strong>비밀번호</strong><br/>
            </td>
            <td style="text-align: left;">
              <input type="password" id="lockPassword" name="password" class="form-control" maxlength="65" alt="비밀번호"/>
            </td>
          </tr>
        </table>
      </div>
      <div style="margin:10px 0 0 0;text-align: center">
        <button type="button" class="btn btn-info btn-default" onclick="CHCommonBoardUtil.submitProc('view');">확인</button>
        <button type="button" class="btn btn-default" onclick="CHCommonBoardUtil.close();">취소</button>
      </div>
    </div>
  </div>
</div>

<%-- 삭제 모달 --%>
<div id="myModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="padding:1px 15px; background-color:#D73925; color:#fff">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel" style="margin-top:15px;">경고</h3>
      </div>
      <div class="modal-body">
        <p>정말 삭제 하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">닫기</button>
        <a href="#myModal2" onclick="CHCommonBoardUtil.confirmDelete('${vo.seq}','${vo.commonBoardSeq}', '${vo.userSeq}', '${sessionScope.loginSeq}', '${vo.isFile}');" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">삭제하기</a>
      </div>
    </div>
  </div>
</div>
<div class="clearfix"></div>

<div id="iframe_content" style="display:none">${vo.content}</div>
<div id="iframe_content_answer" style="display:none">${vo.answer}</div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/commonboard/commonboard.js"></script>
<script type="text/javascript">
$(document).ready(function() {
  if($('.button-wrap li').length === 1) {
    $('.li-cancel').css({
      "marginTop": "0",
      "marginRight": "auto",
      "marginBottom": "0",
      "marginLeft": "auto",
      'float':'none'});
  }
});

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
</script>
</body>
</html>