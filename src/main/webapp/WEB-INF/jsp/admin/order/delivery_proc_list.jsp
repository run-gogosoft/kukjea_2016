<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>자동 배송완료 처리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>판매관리</li>
			<li class="active">자동 배송완료 처리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<div class="alert alert-info">
							<p>배송중인 주문의 송장 번호를 조회하여 <strong>배송이 완료</strong>되었으면 일괄 배송 완료로 변경하는 페이지입니다.</p>
							<p>이 프로세스는 많은 시간이 소요됩니다. 수행이 모두 완료될 때까지 다른 페이지로 이동하지 마세요!</p>
						</div>
						<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${fn:length(list)}"/></b> 건이 조회 되었습니다.</div>
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
							<div class="pull-right">
								<button type="button" onclick="deliveryProc(0);$(this).prop('disabled', true)" class="btn btn-sm btn-warning">자동 변경 수행</button>
							</div>
						</c:if>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col/>
								<col/>
								<col style="width:5%"/>
								<col style="width:4%"/>
								<col style="width:4%"/>
								<col style="width:10%"/>
								<col/>
								<col style="width:5%"/>
								<col style="width:5%"/>
							</colgroup>
							<thead>
								<tr>
									<th>상품<br/>주문번호</th>
									<th>주문번호</th>
									<th>주문상태</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>판매단가</th>
									<th>수량</th>
									<th>배송비</th>
									<th>송장조회</th>
									<th>입점업체명</th>
									<th>주문일자</th>
									<th>결과</th>
								</tr>
							</thead>
							<tbody id="deliveryBody" data-start="0" data-total="${fn:length(list)}">
							<c:forEach var="item" items="${list}">
								<tr data-seq="${item.seq}" data-deliNo="${item.deliNo}" data-deliSeq="${item.deliSeq}" data-deliTrackUrl="${item.deliTrackUrl}" data-completeMsg="${item.completeMsg}">
									<td class="text-center"><a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}">${item.seq}</a></td>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-center">${item.statusText}</td>
									<td>
										<p style="margin-bottom:3px;">
											상품번호 : <%--<a href="/shop/detail/${item.itemSeq}" target="_blank">--%><strong>${item.itemSeq}</strong><%--</a>--%><br/>
											<c:if test="${item.sellerItemCode ne ''}">업체상품번호 : <span style="color:#fd9f1a;"><strong>${item.sellerItemCode}</strong></span></c:if>
										</p>
										${item.itemName}
									</td>
									<td>${item.optionValue}</td>
									<td class="text-right"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-right">${item.orderCnt}</td>
									<td class="text-right"><fmt:formatNumber value="${item.deliCost}"/></td>
									<td class="text-center">
										<fmt:parseNumber var="parseIntStatusCode" value="${item.statusCode}" type="number"/>
										<c:if test="${parseIntStatusCode >= 30 and item.deliSeq ne 0 and item.deliNo ne ''}">
											배송업체: ${item.deliCompanyName}<br/>
											<c:choose>
												<c:when test="${item.deliSeq eq 2}">
													<a href="javascript:viewDeliveryForHlc('${item.deliTrackUrl}','${item.deliNo}');" class="btn btn-default btn-xs" style="margin-top:5px;" onfocus="this.blur();">배송조회</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:viewDelivery('${item.deliTrackUrl}','${item.deliNo}');" class="btn btn-default btn-xs" style="margin-top:5px;" onfocus="this.blur();">배송조회</a>
												</c:otherwise>
											</c:choose>
										</c:if>
									</td>
									<td class="text-center">${item.sellerName}</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
									<td class="text-center result"></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(list) == 0}">
								<tr><td colspan="12" class="text-center">배송중인 주문이 없습니다</td></tr>
							</c:if>
							</tbody>
						</table>
						<!--<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>-->
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<div class="progress progress-striped active">
	<div id="percent" class="bar" style="width:0%;"></div>
</div>
				
<form id="hlc" method="post" action="https://www.hlc.co.kr/home/personal/inquiry/track">
	<input type="hidden" name="InvNo" value="">
	<input type="hidden" name="action" value="processInvoiceSubmit">
</form>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var viewDelivery = function(url, no) {
		window.open(url+no);
	}

	//현대 택배 전용폼
	var viewDeliveryForHlc = function(trackUrl, deliNo) {
		var frm = document.getElementById("hlc");

		frm.InvNo.value = deliNo;
		frm.target = "_blank";

		frm.submit();
	}

	var deliveryProc = function(idx){
		// 그래프를 그린다
		var total = parseInt($("#deliveryBody").attr("data-total"),10) || 0;
		var percent = idx/total*100;
		$("#percent").width(percent+"%");

		if(total === 0){
			alert('처리할 주문이 존재하지 않습니다.');
			return;
		}

		var deliNo = $("#deliveryBody tr[data-deliNo]").eq(idx).attr("data-deliNo");
		var deliSeq = $("#deliveryBody tr[data-deliSeq]").eq(idx).attr("data-deliSeq");
		var deliTrackUrl = $("#deliveryBody tr[data-deliTrackUrl]").eq(idx).attr("data-deliTrackUrl");
		var completeMsg = $("#deliveryBody tr[data-completeMsg]").eq(idx).attr("data-completeMsg");

		if(typeof deliNo === "undefined") {
			$.msgbox("모든 작업이 완료되었습니다");
			return;
		}

		$("#deliveryBody tr[data-deliNo]").eq(idx).find(".result").html("<img src='/assets/img/common/ajaxloader.gif' />");

		$.ajax({
			url:"/admin/order/delivery/socket/proc",
			type:"get",
			data:{deliNo:deliNo, deliSeq:deliSeq, deliTrackUrl:deliTrackUrl, completeMsg:completeMsg, seq:$("#deliveryBody tr[data-deliNo]").eq(idx).attr("data-seq")},
			dataType:"text",
			success:function(data) {
				$("#deliveryBody tr[data-deliNo]").eq(idx).find(".result").html(data);
				deliveryProc(idx+1);
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};
</script>
</body>
</html>
