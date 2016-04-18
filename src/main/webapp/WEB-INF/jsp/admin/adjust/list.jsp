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
		<h1>입점업체 정산리스트  <small>입점업체별 정산 내역 조회 페이지</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>정산 관리</li>
			<li class="active">입점업체 정산리스트</li>
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
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">정산 확정 년월</label>
								<div class="col-md-1">
									<select  class="form-control" id="year" name="year">
										<c:forEach varStatus="year" begin="2015" end="${pvo.lastYear}" step="1">
											<option value="${year.index}" <c:if test="${pvo.year == year.index}">selected</c:if>>${year.index}년</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-1">
									<select  class="form-control" id="month" name="month">
										<c:forEach varStatus="month" begin="1" end="12" step="1">
											<option value="<c:if test="${month.index < 10}">0</c:if>${month.index}" <c:if test="${pvo.month == month.index}">selected</c:if>>
												<c:if test="${month.index < 10}">0</c:if>${month.index}월
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상태</label>
								<div class="col-md-2">
									<select  class="form-control" id="completeFlag" name="completeFlag"">
										<option value="">---전체---</option>
										<option value="Y" <c:if test="${pvo.completeFlag eq 'Y'}">selected</c:if>>완료</option>
										<option value="N" <c:if test="${pvo.completeFlag eq 'N'}">selected</c:if>>미완료</option>
									</select>
								</div>
							<c:if test="${sessionScope.loginType eq 'A'}">
								<label class="col-md-2 control-label">상세 검색</label>
								<div class="col-md-2">
									<select  class="form-control" id="search" name="search"">
										<option value="">---구분---</option>
										<option value="seller_id" 		<c:if test="${pvo.search eq 'seller_id'}">selected</c:if>>입점업체ID</option>
										<option value="seller_name" 	<c:if test="${pvo.search eq 'seller_name'}">selected</c:if>>입점업체명</option>
									</select>
								</div>
								<div class="col-md-2">
									<input  class="form-control" type="text" name="findword" value="${pvo.findword}" maxlength="30"/>
								</div>
							</c:if>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${fn:length(list)}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 4)}">
									<span id="allOrderMsg" style="color:red"></span>
									<button type="button" onclick="allOrderDownloadExcel();" class="btn btn-success btn-sm">전체 주문내역 엑셀다운</button>
									<button type="button" onclick="downloadExcel();" class="btn btn-success btn-sm">엑셀다운</button>
								</c:if>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header with-border"><h3 class="box-title">입점업체 정산 리스트</h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:10%"/>
								<col style="width:*"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<tr>
									<th>정산 확정 년월</th>
									<th>입점업체명</th>
									<th>완료 여부</th>
									<th>판매가</th>
									<th>공급가</th>
									<th>배송비</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="totalSellPrice" value="0"/>
							<c:set var="totalSupplyPrice" value="0"/>
							<c:set var="totalDeliCost" value="0"/>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">
										<fmt:parseDate var="parseAdjustDate" value="${item.adjustDate}" pattern="yyyyMM"/>
										<fmt:formatDate value="${parseAdjustDate}" pattern="yyyy-MM"/>
									</td>
									<td>
										<a href="/admin/adjust/order/list?adjustDate=${item.adjustDate}&mallSeq=${item.mallSeq}&sellerSeq=${item.sellerSeq}&completeFlag=${item.completeFlag}">${item.sellerName}</a>
									</td>
									<td class="text-center">${item.completeFlag eq 'Y' ? '완료':'미완료'}</td>
									<td class="text-right"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.supplyPrice}"/></td>
									<td class="text-right"><fmt:formatNumber value="${item.deliCost}"/></td>
								</tr>
								<c:set var="totalSellPrice" value="${totalSellPrice + item.sellPrice}"/>
								<c:set var="totalSupplyPrice" value="${totalSupplyPrice + item.supplyPrice}"/>
								<c:set var="totalDeliCost" value="${totalDeliCost + item.deliCost}"/>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="7">등록된 내용이 없습니다.</td></tr>
							</c:if>
							<c:if test="${sessionScope.loginType eq 'A'}">
								<tr>
									<td colspan="3" class="text-right"><strong>합계</strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${totalSellPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${totalSupplyPrice}"/></strong></td>
									<td class="text-right"><strong><fmt:formatNumber value="${totalDeliCost}"/></strong></td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	/** 페이지 로딩시 초기화 */
	$(document).ready(function () {
		
	});
	

	/** 엑셀 다운로드 */
	var downloadExcel = function() {
		$("#searchForm").attr("action", "/admin/adjust/list/excel/seller");
		$("#searchForm").submit();
		$("#searchForm").attr("action", location.pathname);
	};

	/** 엑셀 다운로드 */
	var allOrderDownloadExcel = function() {
		$('#allOrderMsg').text("경우에 따라서 수분의 시간이 소요될 수 있습니다. 잠시만 기다려 주세요.");
		setTimeout(function(){
			$('#allOrderMsg').text("");
		}, 20000);
		$('#adjustDate').val($('#year').val()+$('#month').val());
		$("#searchForm").attr("action", "/admin/adjust/list/excel/order");
		$("#searchForm").submit();
		$("#searchForm").attr("action", location.pathname);
	};
</script>
</body>
</html>