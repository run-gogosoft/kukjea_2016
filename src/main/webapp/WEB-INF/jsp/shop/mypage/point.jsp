<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/point.css" type="text/css" rel="stylesheet">
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
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> <strong>포인트 현황</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="review-search-wrap" style="margin-top:0; border-top:0;">
			<div class="board-title">▣ 나의 포인트 현황 입니다.</div>

			<div class="ch-mypage-point-available-info-wrap">
				<div class="ch-mypage-point-available-info">
					<span class="available-point"><fmt:formatNumber value="${availablePoint}" pattern="#,###" /></span>
					<span class="point-text"><img src="${const.ASSETS_PATH}/front-assets/images/mypage/point/current-point-text.png" alt="포인트 금액"></span>
				</div>
			</div>

			<div class="inner" style="margin:0">
				<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>
			</div>
		</div>

		<div class="main-table" style="margin:190px 0 20px; 0">
			<ul class="nav nav-tabs" style="font-weight:bold;">
				<li <c:if test="${pvo.search eq ''}">class="active"</c:if>><a href="#" onclick="location.href=location.pathname + '?' + $('#search_form').serialize()" <c:if test="${pvo.search eq ''}">style="background-color:#F9F7F7"</c:if>>전체내역</a></li>
				<li <c:if test="${pvo.search eq 'save'}">class="active"</c:if>><a href="#" onclick="location.href=location.pathname + '?search=save&' + $('#search_form').serialize()" <c:if test="${pvo.search eq 'save'}">style="background-color:#F9F7F7"</c:if>>적립내역</a></li>
				<li <c:if test="${pvo.search eq 'used'}">class="active"</c:if>><a href="#" onclick="location.href=location.pathname + '?search=used&' + $('#search_form').serialize()" <c:if test="${pvo.search eq 'used'}">style="background-color:#F9F7F7"</c:if>>사용내역</a></li>
			</ul>

			<table class="table table-striped table-list">
				<colgroup>
					<col width="15%"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="18%"/>
						<col/>
				</colgroup>
				<thead>
					<tr >
						<td style="vertical-align: middle;">발행일자</td>
						<td style="vertical-align: middle;">거래구분</td>
						<td style="vertical-align: middle;">포인트</td>
						<td style="vertical-align: middle;">주문번호<br/>(상품주문번호)</td>
						<td style="vertical-align: middle;">비고</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td>${fn:substring(item.regDate, 0,10)}</td>
							<td>${item.statusName}</td>
							<td class="text-center">
								<span style="color:#00aeef;font-size:12px;font-weight:bold">
									<c:if test="${item.statusCode eq 'U' or item.statusCode eq 'D'}">-</c:if><fmt:formatNumber value="${item.point}"/>
								</span>
							</td>
							<td>
								<c:if test="${item.orderSeq ne null}">
									<a href="/shop/${mallId}/mypage/order/detail/${item.orderSeq}" target="_blank">
											${item.orderSeq}
										<c:if test="${item.orderDetailSeq ne null}">
											<br/>(${item.orderDetailSeq})
										</c:if>
									</a>
								</c:if>
							</td>
							<td>${item.note}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) == 0}">
							<tr><td colspan="5" class="text-center non-row" style="height:50px;">등록된 내용이 없습니다.</td></tr>
						</c:if>
				</tbody>
			</table>
		</div>

		<div class="paging" style="float:right">${paging}</div>
		<div class="clearfix"></div>
	</div>
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&search=${pvo.search}" + $("#search_form").serialize();
	};
</script>
</body>
</html>