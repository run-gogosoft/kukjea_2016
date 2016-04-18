<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/cscenter/cscenter.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/cscenter/faq.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}

		#popup-zone {
	      margin-top:-2px;
	    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="cscenter-main-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/cscenter_left.jsp" %>

	<div class="main-content-wrap" style="margin-bottom:50px;">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 고객센터 <span class="breadcrumb-arrow">&gt;</span> 자주 묻는 질문 <span class="breadcrumb-arrow">&gt;</span> <strong id="currentTitle"></strong>
		</div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="default-info-wrap">
			<div class="left-wrap">
				<div class="inner">
					<div class="img"><img src="${const.ASSETS_PATH}/front-assets/images/cscenter/faq_ic01.png" alt=""></div>
					<div class="content-wrap">
						<div class="detail-content">
							<div class="title">Call center</div>
							<div class="tel">02-2222-3896</div>
							<div class="default">[평일:오전9시~오후6시]</div>
							<div class="default">[점심:오후12시~오후1시]</div>
							<div class="default">주말 및 공휴일 휴무</div>
						</div>
					</div>
				</div>
			</div>
			<div class="right-wrap">
				<div class="inner">
					<div class="img"><img src="${const.ASSETS_PATH}/front-assets/images/cscenter/faq_ic02.png" alt=""></div>
					<div class="content-wrap">
						<div class="detail-content">
							<div class="title">Bank</div>
							<div class="tel">100-031-304688</div>
							<div class="default">신한은행</div>
							<div class="default">예금주: (재)행복한웹앤미디어 김병두</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="board-title">▣ [자주묻는질문]</div>
		<div class="board-title-sub" style="border-bottom:0;">
			<div>원하시는 질문을 찾으시지 못하셨다면 1:1문의나 콜센터로 문의바랍니다.</div>
		</div>

		<ul class="nav nav-tabs pull-left" style="margin-top:50px; width:515px; border-bottom:0; font-weight:bold; font-size:12px">
			<li <c:if test="${categoryCode eq '10'}">class="active"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=10" <c:if test="${categoryCode eq '10'}">style="background-color:#F9F7F7"</c:if>>회원</a></li>
			<li <c:if test="${categoryCode eq '20'}">class="active"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=20" <c:if test="${categoryCode eq '20'}">style="background-color:#F9F7F7"</c:if>>주문/결제/배송</a></li>
			<li <c:if test="${categoryCode eq '30'}">class="active"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=30" <c:if test="${categoryCode eq '30'}">style="background-color:#F9F7F7"</c:if>>환불/취소/재고</a></li>
			<li <c:if test="${categoryCode eq '40'}">class="active"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=40" <c:if test="${categoryCode eq '40'}">style="background-color:#F9F7F7"</c:if>>영수증</a></li>
			<li <c:if test="${categoryCode eq '50'}">class="active"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=50" <c:if test="${categoryCode eq '50'}">style="background-color:#F9F7F7"</c:if>>이벤트</a></li>
			<li <c:if test="${categoryCode eq '60'}">class="active"</c:if>><a href="/shop/cscenter/list/faq?categoryCode=60" <c:if test="${categoryCode eq '60'}">style="background-color:#F9F7F7"</c:if>>기타</a></li>
		</ul>

		<div style="float:right; margin-top:50px;">
			<form action="/shop/cscenter/list/faq" role="form">
				<input type="hidden" name="search" value="content">
				<input type="hidden" name="categoryCode" value="${categoryCode}">
			 <div class="search-input-group input-group">
				<input type="text" name="findword" class="form-control search-input" placeholder="내용을 입력하세요."/>
				<div class="input-group-btn">
				  <button type="submit" class="btn btn-default" style="height:34px">
					<img src="${const.ASSETS_PATH}/front-assets/images/common/search_icon.png" alt="검색 아이콘"/>
				  </button>
				</div>
			  </div>
			</form>
		</div>

		<table class="table faq-list" style="margin-top:0;">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<td colspan="3" style="border-top:1px solid #c0bfbf; background-color:#F9F7F7">내용</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}" varStatus="status">
					<c:if test="${item.categoryCode ne 40 or (item.categoryCode eq 40 and fn:contains(mallVo.payMethod,'POINT'))}">
						<tr class="question">
							<td><div class="QBox">Q</div></td>
							<td><a href="#" onclick="$('#faq_a${status.count}').toggle();return false;">${item.title}</a></td>
						</tr>
						<tr class="answer" id="faq_a${status.count}">
							<td><div class="ABox">A</div></td>
							<td style="padding-right:30px;">${item.content}</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(list) == 0}">
					<tr><td colspan="2" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>

		<div id="paging" class="pull-right">${paging}</div>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
var goPage = function (page) {
	location.href = location.pathname + "?pageNum=" + page +"&categoryCode=${categoryCode}";
};

$(document).ready(function() {
	//페이징 클래스 추가
	$("#paging>ul").addClass("ch-pagination");

	// toggle images
	var categoryCode = "${categoryCode}";
	$(".sub-list li").each(function(){
		if($(this).find('a').attr('href').match(categoryCode)) {
			$('#currentTitle').text($(this).find('a').text());
			$(this).find('a').addClass('current');
			return false;
		}
	});
});
</script>
</body>
</html>