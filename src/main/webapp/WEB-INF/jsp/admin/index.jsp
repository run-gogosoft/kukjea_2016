<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<c:choose>
	<c:when test="${sessionScope.loginType eq 'S'}">
		<body class="skin-green sidebar-mini">
	</c:when>
	<c:otherwise>
		<body class="skin-blue sidebar-mini">
	</c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<!-- 매출현황 관련 변수 선언 -->
<c:set var="totalDayOrderCnt" value="0" /> <c:set var="totalDayOrderAmt" value="0" /> <%-- 금일 전체 주문 --%>
<c:set var="totalWeekOrderCnt" value="0" /> <c:set var="totalWeekOrderAmt" value="0" /> <%-- 금일 전체 주문 --%>
<c:set var="totalMonthOrderCnt" value="0" /> <c:set var="totalMonthOrderAmt" value="0" /> <%-- 금월 전체 주문 --%>
<c:set var="totalYearOrderCnt" value="0" /> <c:set var="totalYearOrderAmt" value="0" /> <%-- 금년 전체 주문 --%>

<c:set var="cnt00" value="0" /><c:set var="cnt10" value="0" /><c:set var="cnt20" value="0" />
<c:set var="cnt30" value="0" /><c:set var="cnt50" value="0" /><c:set var="cnt90" value="0" />
<c:set var="cnt99" value="0" />

<c:set var="amt00" value="0" /><c:set var="amt10" value="0" /><c:set var="amt20" value="0" />
<c:set var="amt30" value="0" /><c:set var="amt50" value="0" /><c:set var="amt90" value="0" />
<c:set var="amt99" value="0" />
<!-- 게시판 관리 변수 선언 -->
<c:set var="totalDirectRegCnt" value="0" /><c:set var="totalItemQnaRegCnt" value="0" /><c:set var="totalItemReviewRegCnt" value="0" />
<!-- 판매관리 변수 선언 -->
<c:set var="totalDistrRegCnt" value="0" /><c:set var="totalSellerRegCnt" value="0" />
<!-- 회원관리 변수 선언 -->
<c:set var="totalCMemberRegCnt" value="0" /><c:set var="totalOMemberRegCnt" value="0" /><c:set var="totalPMemberRegCnt" value="0" />

<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>어드민 현황 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li class="active">어드민 현황</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-${sessionScope.loginType eq 'A' ? "6":"12"}">
			<div class="box box-warning">
					<div class="box-header">
						<h3 class="box-title">공지사항</h3>
						<div class="pull-right">
							<a href="/admin/board/list/notice">more <i class="fa fa-plus"></i></a>
						</div>
					</div>
					<div class="box-body no-padding">
						<table class="table">
						<c:forEach var="item" items="${noticeList}">
							<tr>
								<td><a href="/admin/board/view/notice/${item.seq}">${item.title}</a></td>
								<td class="text-center" >${fn:substring(item.regDate,0,10)}</td>
							</tr>
						</c:forEach>
						</table>
					</div>
				</div>
			</div>
			<!--
			<div class="col-md-${sessionScope.loginType eq 'A' ? "4":"6"}">
			<div class="box box-warning">
					<div class="box-header">
						<h3 class="box-title">미답변 상품 Q&A</h3>
						<div class="pull-right">
							<a href="/admin/board/list/qna?answerFlag=2">more <i class="fa fa-plus"></i></a>
						</div>
					</div>
					<div class="box-body no-padding">
						<table class="table">
						<c:forEach var="item" items="${qnaList}">
							<tr>
								<td><a href="/admin/board/view/qna/${item.seq}">${item.title}</a></td>
								<td class="text-center" style="width:20%;">${fn:substring(item.regDate,0,10)}</td>
							</tr>
						</c:forEach>
						</table>
					</div>
				</div>
			</div>
			-->
			<c:if test="${sessionScope.loginType eq 'A'}">
			<!-- 관리자에게만 보여준다. -->
			<div class="col-md-6">
				<div class="box box-warning">
					<div class="box-header">
						<h3 class="box-title">미답변 Q&A</h3>
						<div class="pull-right">
							<a href="/admin/board/list/one?answerFlag=2">more <i class="fa fa-plus"></i></a>
						</div>
					</div>
					<div class="box-body no-padding">
						<table class="table">
						<c:forEach var="item" items="${oneList}">
							<tr>
								<td><a href="/admin/board/view/one/${item.seq}">${item.title}</a></td>
								<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
							</tr>
						</c:forEach>
						</table>
					</div>
				</div>
			</div>
			</c:if>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="box box-info">
					<div class="box-header">
						<h3 class="box-title">최근 7일간 쇼핑몰 현황</h3>
					</div>
					<div class="box-body no-padding">
						<table class="table table-bordered">
							<thead>
								<th colspan="2">구분</th>
								<th>전체</th>
							</thead>
							<tbody>
								<tr>
									<td rowspan="2" class="text-center">판매 관리</td>
									<td class="text-center">매출액</td>
									<td  class="text-right"><fmt:formatNumber value="${orderWeekVo.sumPrice}" /> 원</td>
								</tr>
								<tr>
									<td class="text-center">주문수(건)</td>
									<td class="text-right"><fmt:formatNumber value="${orderWeekVo.orderCount}" /> 건</td>
								</tr>
								<tr>
									<td class="text-center">상품 관리</td>
									<td class="text-center"><a href="#" onclick="goDetailPage('itemCount')">등록상품수(판매중)</a></td>
									<td class="text-right"><fmt:formatNumber value="${itemWeekCnt}" /> 개</td>
								</tr>
								<%-- 업체관리 --%>
								<c:forEach var="item" items="${companyWeekList}">
									<c:choose>
										<c:when test="${item.typeCode eq 'S'}">
											<c:set var="totalSellerRegCnt" value="${item.userCount}" />
										</c:when>
										<c:when test="${item.typeCode eq 'D'}">
											<c:set var="totalDistrRegCnt" value="${item.userCount}" />
										</c:when>
										<c:when test="${item.typeCode eq 'C'}">
											<c:set var="totalCMemberRegCnt" value="${item.userCount}" />
										</c:when>
										<c:when test="${item.typeCode eq 'O'}">
											<c:set var="totalOMemberRegCnt" value="${item.userCount}" />
										</c:when>
										<c:when test="${item.typeCode eq 'P'}">
											<c:set var="totalPMemberRegCnt" value="${item.userCount}" />
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${sessionScope.loginType eq 'A'}">
								<tr>
									<td class="text-center" rowspan="2">업체관리</td>
									<td class="text-center"><a href="#" onclick="goDetailPage('seller')">입점신청</a></td>
									<td class="text-right">${totalSellerRegCnt} 건</td>
								</tr>
								<tr>
									<td class="text-center">입점승인</td>
									<td class="text-right">${sellerWeekApproveCnt} 건</td>
								</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="box box-info">
					<div class="box-header">
						<h3 class="box-title">최근 7일간 회원 현황</h3>
					</div>
					<div class="box-body no-padding">
						<table class="table table-bordered">
							<thead>
								<th colspan="2">구분</th>
								<th>전체</th>
							</thead>
							<tbody>
							<c:if test="${sessionScope.loginType eq 'A'}">
								<tr>
									<td rowspan="3" class="text-center">회원 관리</td>
									<td class="text-center"><a href="#" onclick="goDetailPage('C')">개인회원 가입수</a></td>
									<td class="text-right"><fmt:formatNumber value="${totalCMemberRegCnt}" /> 명</td>
								</tr>
								<tr>
									<td class="text-center"><a href="#" onclick="goDetailPage('O')">기업/시설/단체 회원수</a></td>
									<td class="text-right"><fmt:formatNumber value="${totalOMemberRegCnt}" /> 명</td>
								</tr>
								<tr>
									<td class="text-center"><a href="#" onclick="goDetailPage('P')">공공기관회원 회원수</a></td>
									<td class="text-right"><fmt:formatNumber value="${totalPMemberRegCnt}" /> 명</td>
								</tr>
							</c:if>
							<c:choose>
								<c:when test="${sessionScope.loginType eq 'A'}">
								<tr>
									<td rowspan="3" class="text-center">게시판 관리</td>
									<td class="text-center"><a href="#" onclick="goDetailPage('boardDirect')">1:1 문의</a></td>
									<td class="text-right">${directBoardWeekList}개</td>
								</tr>
									<!--
								<tr>
									<td class="text-center"><a href="#" onclick="goDetailPage('boardQNA')">상품 Q&A</a></td>
									<td class="text-right">${itemqnaBoardWeekList}개</td>
								</tr>
									-->
								<tr>
									<td class="text-center"><a href="#" onclick="goDetailPage('boardReview')">고객 상품평</a></td>
									<td class="text-right">${reviewBoardWeekList}개</td>
								</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td rowspan="2" class="text-center">게시판 관리</td>
									<td class="text-center"><a href="#" onclick="goDetailPage('boardQNA')">상품 Q&A</a></td>
									<td class="text-right">${itemqnaBoardWeekList}개</td>
								</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="box box-default">
					<div class="box-header">
						<h3 class="box-title">매출현황</h3>
					</div>
					<div class="box-body no-padding">
						<table class="table table-striped table-bordered">
							<thead>
							<tr>
								<th></th>
								<th>전체주문</th>
								<th>입금대기</th>
								<th>결제완료</th>
								<th>주문확인</th>
								<th>배송중</th>
								<th>배송완료</th>
								<th>취소요청</th>
								<th class="td-actions">취소완료</th>
							</tr>
							</thead>
							<tbody>
							<!--  금일 주문상태별 매출 현황 -->
							<c:forEach var="item" items="${dayOrderStatus}">
								<c:choose>
									<c:when test="${item.statusCode eq '00'}">
										<c:set var="cnt00" value="${item.orderCount}" />
										<c:set var="amt00" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '10'}">
										<c:set var="cnt10" value="${item.orderCount}" />
										<c:set var="amt10" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '20'}">
										<c:set var="cnt20" value="${item.orderCount}" />
										<c:set var="amt20" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '30'}">
										<c:set var="cnt30" value="${item.orderCount}" />
										<c:set var="amt30" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '50'}">
										<c:set var="cnt50" value="${item.orderCount}" />
										<c:set var="amt50" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '90'}">
										<c:set var="cnt90" value="${item.orderCount}" />
										<c:set var="amt90" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '99'}">
										<c:set var="cnt99" value="${item.orderCount}" />
										<c:set var="amt99" value="${item.sumPrice}" />
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<c:set var="totalDayOrderCnt" value="${totalDayOrderCnt + item.orderCount}" />
								<c:set var="totalDayOrderAmt" value="${totalDayOrderAmt + item.sumPrice}" />
							</c:forEach>

							<tr>
								<td class="text-center">금일</td>
								<td><fmt:formatNumber value="${totalDayOrderCnt}" type="number" />건<br />
									<fmt:formatNumber value="${totalDayOrderAmt}" type="number" />원
								</td>
								<td><fmt:formatNumber value="${cnt00}" type="number" />건<br />
									<fmt:formatNumber value="${amt00}" type="number" />원
								</td>
								<td class="text-danger">
									<strong>
										<fmt:formatNumber value="${cnt10}" type="number" />건<br />
										<fmt:formatNumber value="${amt10}" type="number" />원
									</strong>
								</td>
								<td class="text-warning">
									<strong>
										<fmt:formatNumber value="${cnt20}" type="number" />건<br />
										<fmt:formatNumber value="${amt20}" type="number" />원
									</strong>
								</td>
								<td>
									<fmt:formatNumber value="${cnt30}" type="number" />건<br />
									<fmt:formatNumber value="${amt30}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt50}" type="number" />건<br />
									<fmt:formatNumber value="${amt50}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt90}" type="number" />건<br />
									<fmt:formatNumber value="${amt90}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt99}" type="number" />건<br />
									<fmt:formatNumber value="${amt99}" type="number" />원
								</td>
							</tr>
							<!--  금주 주문상태별 매출 현황 -->
							<c:forEach var="item" items="${WeekOrderStatus}">
								<c:choose>
									<c:when test="${item.statusCode eq '00'}">
										<c:set var="cnt00" value="${item.orderCount}" />
										<c:set var="amt00" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '10'}">
										<c:set var="cnt10" value="${item.orderCount}" />
										<c:set var="amt10" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '20'}">
										<c:set var="cnt20" value="${item.orderCount}" />
										<c:set var="amt20" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '30'}">
										<c:set var="cnt30" value="${item.orderCount}" />
										<c:set var="amt30" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '50'}">
										<c:set var="cnt50" value="${item.orderCount}" />
										<c:set var="amt50" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '90'}">
										<c:set var="cnt90" value="${item.orderCount}" />
										<c:set var="amt90" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '99'}">
										<c:set var="cnt99" value="${item.orderCount}" />
										<c:set var="amt99" value="${item.sumPrice}" />
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<c:set var="totalWeekOrderCnt" value="${totalWeekOrderCnt + item.orderCount}" />
								<c:set var="totalWeekOrderAmt" value="${totalWeekOrderAmt + item.sumPrice}" />
							</c:forEach>

							<tr>
								<td class="text-center">금주</td>
								<td><fmt:formatNumber value="${totalWeekOrderCnt}" type="number" />건<br />
									<fmt:formatNumber value="${totalWeekOrderAmt}" type="number" />원
								</td>
								<td><fmt:formatNumber value="${cnt00}" type="number" />건<br />
									<fmt:formatNumber value="${amt00}" type="number" />원
								</td>
								<td class="text-danger">
									<strong>
										<fmt:formatNumber value="${cnt10}" type="number" />건<br />
										<fmt:formatNumber value="${amt10}" type="number" />원
									</strong>
								</td>
								<td class="text-warning">
									<strong>
										<fmt:formatNumber value="${cnt20}" type="number" />건<br />
										<fmt:formatNumber value="${amt20}" type="number" />원
									</strong>
								</td>
								<td>
									<fmt:formatNumber value="${cnt30}" type="number" />건<br />
									<fmt:formatNumber value="${amt30}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt50}" type="number" />건<br />
									<fmt:formatNumber value="${amt50}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt90}" type="number" />건<br />
									<fmt:formatNumber value="${amt90}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt99}" type="number" />건<br />
									<fmt:formatNumber value="${amt99}" type="number" />원
								</td>
							</tr>
							<!--  금월 주문상태별 매출 현황 -->
							<c:forEach var="item" items="${monthOrderStatus}">
								<c:choose>
									<c:when test="${item.statusCode eq '00'}">
										<c:set var="cnt00" value="${item.orderCount}" />
										<c:set var="amt00" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '10'}">
										<c:set var="cnt10" value="${item.orderCount}" />
										<c:set var="amt10" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '20'}">
										<c:set var="cnt20" value="${item.orderCount}" />
										<c:set var="amt20" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '30'}">
										<c:set var="cnt30" value="${item.orderCount}" />
										<c:set var="amt30" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '50'}">
										<c:set var="cnt50" value="${item.orderCount}" />
										<c:set var="amt50" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '90'}">
										<c:set var="cnt90" value="${item.orderCount}" />
										<c:set var="amt90" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '99'}">
										<c:set var="cnt99" value="${item.orderCount}" />
										<c:set var="amt99" value="${item.sumPrice}" />
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<c:set var="totalMonthOrderCnt" value="${totalMonthOrderCnt + item.orderCount}" />
								<c:set var="totalMonthOrderAmt" value="${totalMonthOrderAmt + item.sumPrice}" />
							</c:forEach>

							<tr>
								<td class="text-center">금월</td>
								<td><fmt:formatNumber value="${totalMonthOrderCnt}" type="number" />건<br />
									<fmt:formatNumber value="${totalMonthOrderAmt}" type="number" />원
								</td>
								<td><fmt:formatNumber value="${cnt00}" type="number" />건<br />
									<fmt:formatNumber value="${amt00}" type="number" />원
								</td>
								<td class="text-danger">
									<strong>
										<fmt:formatNumber value="${cnt10}" type="number" />건<br />
										<fmt:formatNumber value="${amt10}" type="number" />원
									</strong>
								</td>
								<td class="text-warning">
									<strong>
										<fmt:formatNumber value="${cnt20}" type="number" />건<br />
										<fmt:formatNumber value="${amt20}" type="number" />원
									</strong>
								</td>
								<td>
									<fmt:formatNumber value="${cnt30}" type="number" />건<br />
									<fmt:formatNumber value="${amt30}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt50}" type="number" />건<br />
									<fmt:formatNumber value="${amt50}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt90}" type="number" />건<br />
									<fmt:formatNumber value="${amt90}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt99}" type="number" />건<br />
									<fmt:formatNumber value="${amt99}" type="number" />원
								</td>
							</tr>
							<!--  금년 주문상태별 매출 현황 -->
							<c:forEach var="item" items="${yearOrderStatus}">
								<c:choose>
									<c:when test="${item.statusCode eq '00'}">
										<c:set var="cnt00" value="${item.orderCount}" />
										<c:set var="amt00" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '10'}">
										<c:set var="cnt10" value="${item.orderCount}" />
										<c:set var="amt10" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '20'}">
										<c:set var="cnt20" value="${item.orderCount}" />
										<c:set var="amt20" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '30'}">
										<c:set var="cnt30" value="${item.orderCount}" />
										<c:set var="amt30" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '50'}">
										<c:set var="cnt50" value="${item.orderCount}" />
										<c:set var="amt50" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '90'}">
										<c:set var="cnt90" value="${item.orderCount}" />
										<c:set var="amt90" value="${item.sumPrice}" />
									</c:when>
									<c:when test="${item.statusCode eq '99'}">
										<c:set var="cnt99" value="${item.orderCount}" />
										<c:set var="amt99" value="${item.sumPrice}" />
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<c:set var="totalYearOrderCnt" value="${totalYearOrderCnt + item.orderCount}" />
								<c:set var="totalYearOrderAmt" value="${totalYearOrderAmt + item.sumPrice}" />
							</c:forEach>
							<tr>
								<td class="text-center">금년</td>
								<td>
									<fmt:formatNumber value="${totalYearOrderCnt}" type="number" />건<br />
									<fmt:formatNumber value="${totalYearOrderAmt}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt00}" type="number" />건<br />
									<fmt:formatNumber value="${amt00}" type="number" />원
								</td>
								<td class="text-danger">
									<fmt:formatNumber value="${cnt10}" type="number" />건<br />
									<fmt:formatNumber value="${amt10}" type="number" />원
								</td>
								<td class="text-warning">
									<fmt:formatNumber value="${cnt20}" type="number" />건<br />
									<fmt:formatNumber value="${amt20}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt30}" type="number" />건<br />
									<fmt:formatNumber value="${amt30}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt50}" type="number" />건<br />
									<fmt:formatNumber value="${amt50}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt90}" type="number" />건<br />
									<fmt:formatNumber value="${amt90}" type="number" />원
								</td>
								<td>
									<fmt:formatNumber value="${cnt99}" type="number" />건<br />
									<fmt:formatNumber value="${amt99}" type="number" />원
								</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<c:forEach var="item" items="${noticePopup}" varStatus="status">
		<div id="popupNotice${status.count}" class="popup-writebox" style="display:none;position:absolute;z-index:9999;background-color:#ffffff;display:none;border: 1px solid #CCC; border-radius: 5px; position: absolute; width: ${item.width}px;height:${item.height}px !important; top:${item.topMargin}px; left:${item.leftMargin}px; overflow:hidden">
			<div class="popup-writebox-wrap" style="width:${item.width-14}px; height:${item.height-30}px;">
				<div class="popup-writebox-content" style="padding:0;">
						${item.contentHtml}
				</div>
				<div class="popup-writebox-footer text-right" style="padding:5px;">
					<input type="checkbox" id="popup${status.count}"/><label for="popup${status.count}" style="font-size: 11px;font-weight: normal;"> 하루동안 열지 않기</label>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-xs btn-primary" onclick="closePopup(${status.count})">닫기</button>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<!-- /.content-wrapper -->
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp"%>
<script type="text/javascript" src="/assets/js/plugins/cookie/jquery.cookie.min.js"></script>
<script type="text/javascript">
	var goDetailPage = function(code){
		switch(code) {
			case "C":
				location.href = "/admin/member/list?memberTypeCode=C&searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "O":
				location.href = "/admin/member/list?memberTypeCode=O&searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "P":
				location.href = "/admin/member/list?memberTypeCode=P&searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "boardDirect":
				location.href = "/admin/board/list/one?searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "boardQNA":
				location.href = "/admin/board/list/qna?searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "boardReview":
				location.href = "/admin/board/review/list?searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "seller":
				location.href = "/admin/seller/list/S?searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD") + "&statusCode=H";
				break;
			case "dist":
				location.href = "/admin/seller/list/D?searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD");
				break;
			case "itemCount":
				location.href = "/admin/item/list?searchDate1=" + moment().add('days', -7).format("YYYY-MM-DD") + "&searchDate2=" + moment().format("YYYY-MM-DD") + "&statusCode=Y";
				break;
		}
	};

var closePopup = function(num) {
	if($('#popup'+num).prop('checked')) {
		$.cookie("closePopup"+num, "disabled", {expires: 1});
	}
	$('#popupNotice'+num).hide();
};

$(document).ready(function() {
	for(var i=1; i<=${fn:length(noticePopup)}; i++) {
		if ($.cookie("closePopup"+i) !== "disabled") {
			$('#popupNotice' + i).show();
		}
	}
});
</script>
<style type="text/css">
.popup-writebox{display:none;position:absolute;z-index:10;background-color:#fff;display:none;border:1px solid #000;border-radius:10px}.popup-writebox .popup-writebox-wrap{margin:7px}.popup-writebox .popup-writebox-wrap .popup-writebox-content{border-radius:3px;border:1px solid #cacaca;padding-left:25px;overflow:hidden}.popup-writebox .popup-writebox-wrap .popup-writebox-content p{margin:0}.popup-writebox .popup-writebox-wrap .popup-writebox-footer{text-align:right;margin-top:10px}
</style>
</body>
</html>