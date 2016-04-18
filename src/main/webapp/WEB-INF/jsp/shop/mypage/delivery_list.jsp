<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/delivery.css" type="text/css" rel="stylesheet">
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
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 나의정보 <span class="breadcrumb-arrow">&gt;</span> <strong>나의 배송지 관리</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 나의 배송지 관리 입니다.</div>
		<div class="board-title-sub" style="margin-bottom:-10px">
			<div>고객님의 배송지 정보를 저장하실 수 있습니다.</div>
		</div>

		<div class="main-table" style="margin-bottom:20px;">
			<table class="table">
				<colgroup>
					<col width="5%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="*"/>
					<col width="5%"/>
				</colgroup>
				<thead>
					<tr>
						<td></td>
						<td>배송지 구분</td>
						<td>수취인</td>
						<td>휴대폰번호</td>
						<td>주소</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td><c:if test="${item.defaultFlag eq 'Y'}"><i class="fa fa-check fa-2x"></i></c:if></td>
							<td><a href="/shop/mypage/delivery/mod/${item.seq}">${item.title}</a></td>
							<td>${item.name}</td>
							<td style="letter-spacing:0;">${item.cell}</td>
							<td>
								<span style="letter-spacing:0;">${item.postcode}</span><br/>
								${item.addr1}, ${item.addr2}
							</td>
							<td>
								<div class="item-delete" onclick="doDel('${item.seq}')"><i class="fa fa-times fa-2x" style="color:#fff"></i></div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div id="paging" class="pull-right">${paging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 총 <span>${fn:length(list)}</span>건의 내역이 있습니다.
		</div>

		<div class="button-wrap">
			<div class="inner"><button class="btn btn-buy" onclick="location.href='/shop/mypage/delivery/reg'"><span>배송지 등록하기</span></button></div>
		</div>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
	};

	var doDel = function(seq) {
		if(!confirm("정말로 삭제하시겠습니까?")) {
			return;
		}
		location.href="/shop/${mallId}/mypage/delivery/del/"+seq+"/proc";
	};
</script>
</body>
</html>