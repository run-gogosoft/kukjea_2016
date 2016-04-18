<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
  <link href="/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
  <link href="/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
  <link href="/front-assets/css/commonboard/form.css" type="text/css" rel="stylesheet">
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
    <table class="table">
      <colgroup>
      	<col style="width:15%"/>
      	<col style="width:85%"/>
      </colgroup>
      <tr>
        <th class="text-center">조회수</th>
        <td>${vo.viewCnt}</td>
      </tr>
      <tr>
        <th class="text-center">작성자</th>
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
        <th class="text-center">제목</th>
        <td>${vo.title}</td>
      </tr>
       <%-- 첨부파일이 존재할 경우 --%>
      <c:if test="${vo.isFile eq 'Y'}">
      <tr>
      	<th class="text-center">첨부파일</th>
        <td>
	       <c:forEach var="item" items="${file}">
	       	<div>
		        <a href="/shop/about/board/file/download/proc?seq=${vo.seq}&num=${item.num}&commonBoardSeq=${vo.commonBoardSeq}" target="zeroframe">
		            <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
		            ${item.filename}
		        </a>
	        </div>
	       </c:forEach>
        </td>
      </tr>
	  </c:if>
	  <tr>
	  	<td colspan="2" class="text-center">
	  		<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
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

<c:if test="${cvo.commentUseFlag eq 'Y'}">
<div class="sign-form form1" style="margin:25px auto 50px auto;">
	<div class="inner">
		<div class="title-back">
		<div class="title-wrap">
			<div class="title">댓글</div>
			</div>
		</div>
		<table class="table sign-table">
		<c:forEach var="item" items="${clist}">
		<tr>
			<td style="width:150px" class="text-center">
				${item.userName}
			</td>
			<td>
				<div class="pull-right">
					<c:if test="${sessionScope.loginSeq eq item.userSeq}">
						<button type="button" class="close" style="font-size: 14px;" onclick="showDeleteModal(${item.seq});">
							<span aria-hidden="true">&times;</span><span class="sr-only">Delete</span>
						</button>
					</c:if>
				</div>
				<div style="white-space:pre">${item.content}</div>
			</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(clist) eq 0}">
		<tr><td colspan="2" class="text-center text-muted">등록된 댓글이 없습니다</td></tr>
		</c:if>
		</table>
		
		<c:if test="${sessionScope.loginSeq > 0}">
		<form id="commentForm" role="form" action="/shop/about/board/detail/comment/insert" onsubmit="return isValidCommentForm();" target="zeroframe" method="post">
			<div class="well">
				<div class="form-group">
					<label for="content">댓글 쓰기 <i data-code="content" class="fa fa-check-square-o"></i></label>
					<button type="submit" class="pull-right btn btn-xs btn-default"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 등록</button>
					<textarea id="content" name="content" class="form-control" rows="3" style="margin-top:10px;"></textarea>
				</div>
			</div>
			<input type="hidden" name="commonBoardSeq" value="${vo.commonBoardSeq}" />
			<input type="hidden" name="boardSeq" value="${vo.seq}" />
		</form>
		</c:if>
	</div>
</div>
</c:if>

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

function isValidCommentForm() {
    var flag = true;
    // 폼체크
    $('#commentForm i.fa-check-square-o').each(function () {
        var e = $(this).parents().parents('.form-group').find('input:text, input:password, option, textarea');
        if (flag && e.length > 0 && $.trim(e.val()) === '') {
            alert($.trim($(this).parent().text()) + ' 항목이 입력되지 않았습니다');
            e.focus();
            flag = false;
            return;
        }
    });
    return flag;
}

function showDeleteModal(seq) {
	if(confirm("정말로 삭제하시겠습니까?")) {
		$('#zeroframe').attr("src", "/shop/about/board/detail/comment/delete?seq="+seq);
	}
}
</script>
</body>
</html>