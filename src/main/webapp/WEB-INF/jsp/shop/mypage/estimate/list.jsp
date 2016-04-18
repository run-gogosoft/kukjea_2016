<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/mypage/estimate.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.table > thead > tr > th {
			text-align: center;
			background-color: #eee;
		}

		.table > tbody > tr > th {
			text-align: right;
			background-color: #eee;
		}

		.ch-pagination {
			margin:2px 0 0 20px;
		}

		.mypage-search-bar {
			margin-top:60px;
		}

		.pagination {
			margin:2px 0 0 20px;
		}

		.btn-confirm:hover{
			background-color:#ed1c24;
			color:#fff;
		}
		.btn-4dc:hover{
			background-color:#4db7c9;
			color:#fff;
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
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 구매정보 <span class="breadcrumb-arrow">&gt;</span> <strong>견적요청 관리</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 최근 견적 구매 요청하신 내역 입니다.</div>
		<ul class="board-title-sub" style="border-bottom:0;">
			<li>판매기한이 지나거나 상품가의 변동으로 인해 견적가의 변동이 있을 수 있습니다.</li>
		</ul>

		<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>

		<div class="main-table" style="margin-bottom:20px;">
			<table class="table">
				<colgroup>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<td>견적번호</td>
						<td>상품코드</td>
						<td colspan="2">상품정보</td>
						<td>구분</td>
						<td>상태</td>
						<td>판매 단가</td>
						<td>수량</td>
						<td>
							합계금액<br/>
							<span class="text-info">견적가</span>
						<td>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="item" items="${list}">
					<tr id="row${item.seq}">
						<td>${item.seq}</td>
						<td>${item.itemSeq}</td>
						<td><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, '/origin/', '/s206/')}" width="70px"/></td>
						<td class="text-left itemName">
							<a href="/shop/detail/${item.itemSeq}" target="_blank">${item.itemName}</a>
							<c:if test="${item.optionValue ne ''}">
								<p class="option-name">${item.optionValue}</p>
							</c:if>
						</td>
						<td><strong class="text-warning">${item.typeName}</strong></td>
						<td><strong class="text-info">${item.statusText}</strong></td>
						<td class="right sellPrice">
							<c:choose>
								<c:when test="${item.typeCode eq 'N'}"><fmt:formatNumber value="${item.sellPrice}"/> 원</c:when>
								<c:otherwise>---</c:otherwise>
							</c:choose>
						</td>
						<td class="right">
							<fmt:formatNumber value="${item.qty}"/> 개
							<span class="qty" style="display:none">${item.qty}</span>
						</td>
						<td class="right">
							<c:if test="${item.typeCode eq 'N'}">
								<strong class="sum"><fmt:formatNumber value="${item.sellPrice * item.qty}"/> 원</strong>
							</c:if>
							<div>
								<strong class="text-info amount"><fmt:formatNumber value="${item.amount}"/> 원</strong>
							</div>
						</td>
						<td>
							<c:if test="${item.statusCode eq '1' }">
								<button onclick="showModal(${item.seq})" class="btn btn-info btn-xs btn-etc btn-4dc">견적서 수정</button>
							</c:if>
							<c:if test="${item.statusCode eq '2' or item.statusCode eq '3'}">
								<button onclick="doPrint(${item.seq})" class="btn btn-default btn-xs btn-etc btn-4dc">견적서 출력</button>
							</c:if>
							<c:if test="${item.statusCode eq '2' }">
							<p style="margin-top:5px;"><a href="/shop/order?seq=${item.seq}&estimate_flag=Y" class="btn btn-default btn-xs btn-etc btn-confirm">결제</a></p>
							</c:if>
						</td>
						<td class="request" style="display:none">${item.request}</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(list) == 0}">
					<tr><td colspan="10" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
				</c:if>
				</tbody>
			</table>
		</div>

		<div id="paging" class="pull-right">${paging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 총 <span><fmt:formatNumber value="${pvo.totalRowCount}"/></span>건의 내역이 있습니다.
		</div>
	</div>
</div>
<div class="clearfix"></div>

<!-- 견적신청 레이어 -->
<div id="estimateModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background-color:#3276B1">
				<h3 class="modal-title" style="font-weight:bold;font-size:16px;color:#fff">견적요청 내용 수정</h3>
			</div>
			<form class="form-horizontal" action="/shop/estimate/mod" method="post" target="zeroframe" onsubmit="return doSubmit(this);">
				<input type="hidden" id="seq" name="seq" value=""/>
				<input type="hidden" name="returnUrl" value=""/>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-md-3 control-label">견적 번호</label>
						<div class="col-md-9 form-control-static" id="seq_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">회원명</label>
						<div class="col-md-9 form-control-static" id="memberName_text">${sessionScope.loginName }</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">상품명</label>
						<div class="col-md-9 form-control-static" id="itemName_text">${vo.name}</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">판매 단가</label>
						<div class="col-md-9 form-control-static" id="sellPrice_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">희망 구매 수량 <i class="fa fa-check"></i></label>
						<div class="col-md-9">
							<div class="input-group">
								<input class="form-control text-right" type="text" id="qty" name="qty" onblur="numberCheck(this)" maxlength="9" />
								<div class="input-group-addon">개</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">합계 금액</label>
						<div class="col-md-9 form-control-static" id="sum_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">견적가</label>
						<div class="col-md-9 form-control-static" id="amount"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">기타 요청 사항</label>
						<div class="col-md-9">
							<textarea class="form-control" id="request" name="request" rows="10"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-md btn-primary">수정하기</button>
					<button type="button" data-dismiss="modal" class="btn btn-md btn-default">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	var doPrint = function(seq) {
		window.open("/shop/mypage/estimate/view/"+seq, "estimate_view", "width=710px,height=500px");
	};
	
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
	};
	
	/** 견적서 수정 모달 창 띄우기 */
	var showModal = function(seq) {
		$("#seq").val(seq);
		$("#seq_text").text(seq);
		$("#itemName_text").text($("#row"+seq+ " .itemName").text());
		$("#sellPrice_text").text($("#row"+seq+ " .sellPrice").text());
		$("#qty").val($("#row"+seq+ " .qty").text());
		$("#sum_text").text($("#row"+seq+ " .sum").text());
		$("#amount").text($("#row"+seq+ " .amount").text());
		$("#request").val($("#row"+seq+ " .request").text());

		$("#estimateModal").modal();
	};
	
	/** 견적서 폼 제출 */
	var doSubmit = function(obj) {
		if($.trim(obj.qty.value) <= 0) {
			alert("수량을 입력해 주세요.");
			obj.qty.focus();
			return false;
		}
		
		obj.returnUrl.value = location.pathname + "?pageNum=${pvo.pageNum}&searchDate1=${pvo.searchDate1}&searchDate2=${pvo.searchDate2}";
		
		return true;
	};
	
</script>
</body>
</html>