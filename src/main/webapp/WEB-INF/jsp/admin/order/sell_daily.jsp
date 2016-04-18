<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>

<div class="main">
	<div class="container">
		<div class="row">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3 class="pull-left"><c:if test="${title ne null}">${title}</c:if></h3>
						<form id="searchForm" class="form-horizontal" action="/admin/order/selldaily/${sellDailyName}">
							<div class="widget widget-form stacked">
								<div class="widget-header">
									<div class="pull-left"><i class="icon-search"></i> 검색 조건</div>
									<div class="pull-right">
										<button type="submit" class="btn btn-small btn-default" style="margin-right:10px;">검색하기</button>
									</div>
								</div>
								<div class="widget-content">
									<div class="row-fluid">
										<div class="control-group span6">
											<label class="control-label">등록일자</label>
											<div class="controls">
												<div class="input-append" style="width:150px;">
													<c:choose>
														<c:when test="${sellDailyName eq 'day'}">
															<fmt:parseDate value="${vo.srchDate1}" var="srchDate1" pattern="yyyymmdd"/>
															<input type="text" name="srchDate1" value="<fmt:formatDate value="${srchDate1}" pattern="yyyy-mm-dd"/>" class="span8 datepicker"/>
														</c:when>
														<c:when test="${sellDailyName eq 'month'}">
															<fmt:parseDate value="${vo.srchDate1}" var="srchDate1" pattern="yyyymm"/>
															<input type="text" name="srchDate1" value="<fmt:formatDate value="${srchDate1}" pattern="yyyy-mm"/>" class="span8 monthdatepicker"/>
														</c:when>
													</c:choose>


													<button type="button" onclick="$(this).prev().focus()" class="btn"><i class="icon-calendar"></i></button>
												</div>
												<strong>~</strong>
												<div class="input-append" style="width:150px;text-align:right;">
													<c:choose>
														<c:when test="${sellDailyName eq 'day'}">
															<fmt:parseDate value="${vo.srchDate2}" var="srchDate2" pattern="yyyymmdd"/>
															<input type="text" name="srchDate2" value="<fmt:formatDate value="${srchDate2}" pattern="yyyy-mm-dd"/>" class="span8 datepicker"/>
														</c:when>
														<c:when test="${sellDailyName eq 'month'}">
															<fmt:parseDate value="${vo.srchDate2}" var="srchDate2" pattern="yyyymm"/>
															<input type="text" name="srchDate2" value="<fmt:formatDate value="${srchDate2}" pattern="yyyy-mm"/>" class="span8 monthdatepicker"/>
														</c:when>
													</c:choose>
													<button type="button" onclick="$(this).prev().focus()"  class="btn"><i class="icon-calendar"></i></button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped">
							<caption><c:if test="${title ne null}">${title}</c:if></caption>
							<colgroup>
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<thead>
							<tr>
								<th>일자</th>
								<th>매출합계</th>
								<th>공급가합계</th>
								<th>영업이익(%)</th>
								<th>포인트할인</th>
							</tr>
							<tbody>
								<c:forEach var="item" items="${list}">
								<tr>
									<td style="width:11%;" class="text-center">
									<c:choose>
										<c:when test="${sellDailyName eq 'day'}">
											<fmt:parseDate value="${item.payDate}" var="payDate" pattern="yyyymmdd"/>
											<fmt:formatDate value="${payDate}" pattern="yyyy-mm-dd"/>
										</c:when>
										<c:when test="${sellDailyName eq 'month'}">
											<fmt:parseDate value="${item.payDate}" var="payDate" pattern="yyyymm"/>
											<fmt:formatDate value="${payDate}" pattern="yyyy-mm"/>
										</c:when>
									</c:choose>
									</td>
									<td style="width:11%;text-align:right;"><fmt:formatNumber value="${item.sumPrice}" pattern="#,###" /></td>
									<td style="width:11%;text-align:right;"><fmt:formatNumber value="${item.sumSupplyPrice}" pattern="#,###" /></td>
									<td style="width:11%;text-align:right;">
										<c:choose>
											<c:when test="${(item.sumPrice > 0)}">
												<fmt:formatNumber value="${item.profit}" pattern="#,###" />
												(<fmt:formatNumber value="${(item.profit / item.sumPrice * 100)}" pattern="#.#" /> %)
											</c:when>
											<c:otherwise>
												<fmt:formatNumber value="${item.sumPrice}" pattern="#,###" />(0 %)
											</c:otherwise>
										</c:choose>
									</td>
									<td style="width:11%;text-align:right;"><fmt:formatNumber value="${item.point}" pattern="#,###" /></td>
								</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="6">등록된 내용이 없습니다.</td></tr>
								</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		$(".datepicker").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm-dd"
		});

		$(".monthdatepicker").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm"
		});
	});
</script>
</body> </html>
