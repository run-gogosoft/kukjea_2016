<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/commonboard/list.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}
	</style>
</head>
<body>
<c:choose>
	<c:when test="${vo.commonBoardSeq ge 3}">
		<%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
	</c:otherwise>
</c:choose>

<div class="ch-container" style="margin:0 auto">
<c:choose>
	<c:when test="${vo.commonBoardSeq eq 1}"><img src="${const.ASSETS_PATH}/front-assets/images/commonboard/item_reg.jpg" style="margin:0 auto" alt=""/></c:when>
	<c:when test="${vo.commonBoardSeq eq 2}"><img src="${const.ASSETS_PATH}/front-assets/images/commonboard/seller_reg.jpg" style="margin:0 auto" alt=""/></c:when>
</c:choose>
</div>

<div class="board-title">
	<div class="title">▣ ${title} 게시판 입니다.</div>
</div>

<!-- 본문 -->
<div class="main-table" style="margin:0px auto 20px auto">
  <div class="row">
    <c:forEach var="item" items="${list}" varStatus="status">
    <div class="col-md-3 col-sm-3 col-xs-3" style="margin-bottom:20px;">
        <div class="thumbnail">
            <div class="text-center">
                <a href="/shop/about/board/detail/view/${item.seq}?commonBoardSeq=${vo.commonBoardSeq}">
                  <img data-src="holder.js/300x300" src="${item.realFilename}" alt="${item.title}" style="max-width:237.5px; height:230px;">
                </a>
            </div>
            <div class="caption">
                <h4>
                    <c:choose>
                        <c:when test="${fn:length(item.title) > 16}">
                            <c:out value="${fn:substring(item.title,0,13)}" />...
                        </c:when>
                        <c:otherwise>
                            ${item.title}
                        </c:otherwise>
                    </c:choose>
                </h4>
                <div class="text-muted"><small>댓글: ${item.commentCnt} / 조회 : ${item.viewCnt}</small></div>
                <div class="text-muted">
                    <fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
                    <fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
                </div>
            </div>
        </div>
    </div>
    </c:forEach>
  </div>
</div>

<div class="ch-container" style="margin-bottom:120px">
	<div id="paging" class="pull-right"> ${paging} </div>
	<div class="pull-right total-count-title">
		현재 총 <span>${fn:length(list)}</span>건의 게시글이 있습니다.
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
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/commonboard/commonboard.js"></script>
</body>
</html>