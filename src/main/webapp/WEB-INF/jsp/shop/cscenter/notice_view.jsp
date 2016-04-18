<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/cscenter/cscenter.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/cscenter/notice.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		#popup-zone {
	      margin-top:-5px;
	    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="cscenter-main-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/cscenter_left.jsp" %>

	<div class="main-content-wrap">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 고객센터 <span class="breadcrumb-arrow">&gt;</span> <strong>공지사항</strong>
		</div>

		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 공지사항 입니다</div>
		<div class="board-title-sub" style="border-bottom:0;">
			<div>공지사항에 대한 더 자세한 안내를 원하시면 1:1문의나 콜센터로 문의바랍니다.</div>
		</div>

		<table class="table view-table">
			<colgroup>
				<col style="width:20%;" />
				<col style="width:80%;" />
			</colgroup>
			<tbody>
				<tr>
					<th>등록일</th>
					<td>
						<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
						<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><strong>${vo.title}</strong></td>
				</tr>
				<tr>
					<td colspan="2" class="content">
						<%-- 첨부파일이 존재할 경우 --%>
	          <c:if test="${vo.isFile eq 'Y'}">
	            <div style="padding:5px 15px 5px 0;">
	                <ul class="list-unstyled">
	                    <c:forEach var="item" items="${file}">
	                        <li>
	                            <a href="/shop/cscenter/notice/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
	                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
	                                    ${item.filename}
	                            </a>
	                        </li>
	                    </c:forEach>
	                </ul>
	            </div>
	          </c:if>
						<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="pull-right" style="margin-bottom:50px">
			<button class="btn btn-default btn-sm" onClick="location.href='/shop/cscenter/list/notice'">목록보기</button>
		</div>
	</div>
</div>
<div class="clearfix"></div>

<div id="iframe_content" style="display:none">${content}</div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
	$(window).load(function() {
		$("#content_view").contents().find("body").html($("#iframe_content").html());
		$("#content_view").height($("#content_view").contents().find("body")[0].scrollHeight + 30);
	});
</script>
</body>
</html>