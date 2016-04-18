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
		<h1>입점업체 정산리스트  <small>입점업체별 정산 상세 내역 리스트</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>정산 관리</li>
			<li class="active">입점업체 정산 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<form class="form-horizontal" id="searchForm" method="get">
							<input type="hidden" name="adjustDate" value="${pvo.adjustDate}"/>
							<input type="hidden" name="sellerSeq" value="${pvo.sellerSeq}"/>
							<input type="hidden" name="completeFlag" value="${pvo.completeFlag}"/>
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">결제 수단</label>
								<div class="col-md-2">
									<select  class="form-control" name="payMethod">
										<option value="">---전체---</option>
										<c:forEach var="item" items="${payMethodList}">
										<option value="${item.value}" ${item.value eq pvo.payMethod ? "selected":""}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${fn:length(list)}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" onclick="downloadExcel();" class="btn btn-success btn-sm">엑셀다운</button>
								<button onclick="history.go(-1)" class="btn btn-warning btn-sm">목록보기</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<div class="pull-right">
							<c:if test="${sessionScope.loginType eq 'A' and pvo.completeFlag eq 'N'}">
								<button onclick="updateStatus()" class="btn btn-sm btn-info">정산 완료 처리</button>
							</c:if>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered">
							<colgroup>
								<col style="width:7%"/>
								<col style="width:7%"/>
								<col style="width:12%"/>
								<col style="width:10%"/>
								<col style="width:5%"/>
								<col style="width:*"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:7%"/>
								<col style="width:7%"/>
								<col style="width:7%"/>
							</colgroup>
							<thead>
								<tr>
									<th>주문<br/>년월</th>
									<th>정산<br/>완료일</th>
									<th>입점업체명</th>
									<th>결제수단</th>
									<th>상품<br/>주문번호</th>								
									<th>상품명</th>
									<th>과/면세</th>
									<th>정산<br/>구분</th>
									<th>수량</th>
									<th>판매가</th>
									<th>공급가</th>
									<th>배송비</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="sumSellPrice" value="0"/>
							<c:set var="sumSupplyPrice" value="0"/>
							<c:set var="sumDeliCost" value="0"/>
							<c:forEach var="item" items="${list}">
								<c:set var="sellPrice" value="${item.sellPrice * item.orderCnt}"/>
								<c:set var="supplyPrice" value="${item.supplyPrice * item.orderCnt}"/>
								<c:set var="deliCost" value="${item.deliCost}"/>
								<%--취소 정산 마이너스 처리--%>
								<c:if test="${item.cancelFlag eq 'Y'}">
									<c:set var="sellPrice" value="${-sellPrice}"/>
									<c:set var="supplyPrice" value="${-supplyPrice}"/>
									<c:set var="deliCost" value="${-deliCost}"/>
								</c:if>
								<tr ${item.cancelFlag eq "Y" ? "style=\"background-color:#ffe4e1\"":""}>
									<td class="text-center">
										<fmt:parseDate var="parseOrderYm" value="${item.orderYm}" pattern="yyyyMM"/>
										<fmt:formatDate value="${parseOrderYm}" pattern="yyyy-MM"/>
									</td>
									<td class="text-center">${fn:substring(item.completeDate,0,10)}</td>
									<td class="text-center">${item.sellerName}</td>
									<td class="text-center">${item.payMethodName}</td>
									<td class="text-center"><a href="/admin/order/view/${item.orderSeq}?seq=${item.orderDetailSeq}" target="_blank">${item.orderDetailSeq}</a></td>
									<td>${item.itemName}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.taxCode == 1}">과세</c:when>
											<c:when test="${item.taxCode == 2}">면세</c:when>
										</c:choose>
									</td>
									<td class="text-center">${item.cancelFlag eq 'Y' ? '취소':'정상'}</td>
									<td class="text-right">${item.orderCnt}</td>
									<td class="text-right"><fmt:formatNumber value="${sellPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${supplyPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${deliCost}"/></td>
								</tr>
								
								<c:set var="sumSellPrice" value="${sumSellPrice + sellPrice}"/>
								<c:set var="sumSupplyPrice" value="${sumSupplyPrice + supplyPrice}"/>
								<c:set var="sumDeliCost" value="${sumDeliCost + deliCost}"/>
							</c:forEach>
							<tr>
								<td class="text-right" colspan="9"><strong>합계</strong></td>
								<td class="text-right"><strong><fmt:formatNumber value="${sumSellPrice}"/></strong></td>
								<td class="text-right"><strong><fmt:formatNumber value="${sumSupplyPrice}"/></strong></td>
								<td class="text-right"><strong><fmt:formatNumber value="${sumDeliCost}"/></strong></td>
							</tr>
							<c:forEach var="item" items="${manualList}">
								<c:set var="sellPrice" value="${item.sellPrice * item.orderCnt}"/>
								<c:set var="supplyPrice" value="${item.supplyPrice * item.orderCnt}"/>
								<c:set var="deliCost" value="${item.deliCost}"/>
								<%--취소 정산 마이너스 처리--%>
								<c:if test="${item.cancelFlag eq 'Y'}">
									<c:set var="sellPrice" value="${-sellPrice}"/>
									<c:set var="supplyPrice" value="${-supplyPrice}"/>
									<c:set var="deliCost" value="${-deliCost}"/>
								</c:if>
								<tr ${item.cancelFlag eq "Y" ? "style=\"background-color:#ffe4e1\"":""}>
									<td class="text-center">
										<c:if test="${sessionScope.loginType eq 'A' and pvo.completeFlag ne 'Y'}">
											<a href="#" class="btn btn-xs btn-danger" target="zeroframe"
												onclick="if(!confirm('정말로 삭제하시겠습니까?')){return false;}	location.href='/admin/adjust/del/${item.seq}?returnUrl='+location.pathname+'?'+encodeURIComponent($('#searchForm').serialize());">삭제</a>
										</c:if>
									</td>
									<td class="text-center"><strong>금액조정사유</strong></td>
									<td colspan="5"><span class="text-danger">${item.reason}</span></td>
									<td class="text-center">${item.cancelFlag eq 'Y' ? '취소':'정상'}</td>
									<td class="text-right">${item.orderCnt}</td>
									<td class="text-right"><fmt:formatNumber value="${sellPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${supplyPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${deliCost}"/></td>
								</tr>
								
								<c:set var="sumSellPrice" value="${sumSellPrice + sellPrice}"/>
								<c:set var="sumSupplyPrice" value="${sumSupplyPrice + supplyPrice}"/>
								<c:set var="sumDeliCost" value="${sumDeliCost + deliCost}"/>
							</c:forEach>
							<c:if test="${fn:length(manualList) > 0}">
								<tr>
									<td class="text-right" colspan="9"><strong>최종 합계</strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumSellPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumSupplyPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${sumDeliCost}"/></strong></td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<c:if test="${sessionScope.loginType eq 'A' and pvo.completeFlag ne 'Y'}">
		<div class="row">
			<div class="col-md-7">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">정산 내역 추가</h3>
					</div>
					<!-- 내용 -->
					<form class="form-horizontal" id="validation-from" action="/admin/adjust/reg" onsubmit="return doSubmit(this)" method="post" target="zeroframe">
						<input type="hidden" name="adjustDate" value="${pvo.adjustDate}"/>
						<input type="hidden" name="sellerSeq" value="${pvo.sellerSeq}"/>
						<input type="hidden" name="completeFlag" value="${pvo.completeFlag}"/>
						<input type="hidden" name="mallSeq" value="1"/>
						<input type="hidden" name="orderCnt" value="1"/>
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">정산 구분</label>
								<div class="col-md-2">
									<select class="form-control" name="cancelFlag">
										<option value="N">정상</option>
										<option value="Y">취소</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">판매가</label>
								<div class="col-md-2">
									<input type="text" class="form-control text-right" name="sellPrice" value="0"/>
								</div>
								<label class="col-md-2 control-label">공급가</label>
								<div class="col-md-2">
									<input type="text" class="form-control text-right" name="supplyPrice" value="0"/>
								</div>
								<label class="col-md-2 control-label">배송비</label>
								<div class="col-md-2">
									<input type="text" class="form-control text-right" name="deliCost" value="0"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">금액 조정 사유</label>
								<div class="col-md-10">
									<input type="text" class="form-control" name="reason" maxlength="100" placeholder="100자 이내 입력" data-required-label="금액 조정 사유"/>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-primary btn-md">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		</c:if>
	</section>
</div>

<form id="batchForm" method="post" action="/admin/adjust/update/status/batch" target="zeroframe">
	<input type="hidden" name="adjustDate" value="${pvo.adjustDate}"/>
	<input type="hidden" name="sellerSeq" value="${pvo.sellerSeq}"/>
	<input type="hidden" name="completeFlag" value="Y"/>
</form>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	/** 페이지 로딩시 초기화 */
	$(document).ready(function () {

	});

	var updateStatus = function() {
		if(!confirm("정산 완료 처리를 하시겠습니까?")) return;
		$("#batchForm").submit();
	};

	/** 정산 내역 추가 */
	var doSubmit = function(formObj) {
		if(!checkRequiredValue(formObj, "data-required-label")) {
			return false;
		}
		return true;
	}

	/** 엑셀 다운로드 */
	var downloadExcel = function() {
		location.href="/admin/adjust/list/excel/order?"+$("#searchForm").serialize();
	};
</script>
</body>
</html>