<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/mypage/cancel.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}

		#popup-zone {
      margin-top:-5px;
    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="body-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>

	<div class="main-content-wrap">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 구매정보 <span class="breadcrumb-arrow">&gt;</span> <strong>취소/반품/교환 내역</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 최근 취소/반품/교환 내역 입니다</div>

		<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>

		<div class="main-table" style="margin-bottom:20px">
			<table class="table">
				<colgroup>
					<col width="15%"/>
					<col width="10%"/>
					<col width="8%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="5%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<td>주문번호(주문일자)</td>
						<td>상세정보</td>
						<td colspan="2">상품정보</td>
						<td>상품금액</td>
						<td>수량</td>
						<td>주문상태</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${list}">
						<tr>
							<td data-merge-flag="${vo.orderSeq}">
								<a href="/shop/mypage/cancel/detail/${vo.orderSeq}"><strong>${vo.orderSeq}</strong></a><br/>
								(${fn:substringBefore(vo.regDate,' ')})
								<c:if test="${vo.tid ne ''}">
									<button type="button" onclick="showReceipt('${vo.tid}')" class="btn btn-xs btn-default">영수증 출력</button>
								</c:if>
							</td>
							<td data-detail-merge-flag="${vo.orderSeq}">
								<a href="/shop/mypage/cancel/detail/${vo.orderSeq}"><i class="fa fa-building-o fa-3x" style="color:#e5be34;"></i></a>
							</td>
							<td>
								<c:if test="${vo.img1 ne ''}">
									<a href="/shop/detail/${vo.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s206/')}" style="width:70px;height:70px;" alt="" /></a>
								</c:if>
							</td>
							<td class="text-left item-name">
								<a href="/shop/detail/${vo.itemSeq}">${vo.itemName}</a><br/>
								<c:if test="${vo.optionValue ne ''}">
									<span class="option-name">${vo.optionValue}</span><br/>
								</c:if>
							</td>
							<td>
								<fmt:formatNumber value="${vo.sellPrice+vo.optionPrice}"/>원
							</td>
							<td>${vo.orderCnt}</td>
							<td>
								${vo.statusText}
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) eq 0}">
						<tr><td colspan="7" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<div id="paging" class="pull-right">${paging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 총 <strong class="text-info"><fmt:formatNumber value="${pvo.totalRowCount}"/></strong> 건의 내역이 있습니다.
		</div>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	var showReceipt = function(tid) {
		var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noMethod=1&noTid="+tid;
		window.open(receiptUrl,"receipt","width=430,height=700");
	};

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
	};
</script>
</body>
</html>