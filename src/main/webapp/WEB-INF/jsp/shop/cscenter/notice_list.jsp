<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/cscenter/cscenter.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/cscenter/notice.css" type="text/css" rel="stylesheet">
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

		<table class="table notice-list">
			<colgroup>
				<col width="10%"/>
				<col width="*"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<td style="border-top:1px solid #c0bfbf;">번호</td>
					<td style="border-top:1px solid #c0bfbf;">제목</td>
					<td style="border-top:1px solid #c0bfbf;">등록일</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}" varStatus="status">
					<tr>
						<td>${item.seq}</td>
						<td>
							<a href="/shop/cscenter/view/${boardGroup}/${item.seq}">${item.title }</a>
							<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
						</td>
						<td>
							<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
							<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(list) == 0}">
					<tr><td colspan="3" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
		<div id="paging" class="pull-right"> ${paging} </div>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() { 
		$("#paging>ul").addClass("ch-pagination"); 
	});
	
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page;
	};
</script>
</body>
</html>