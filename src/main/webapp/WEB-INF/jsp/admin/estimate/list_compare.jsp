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
		<h1>비교견적 신청 리스트 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>견적 관리</li>
			<li class="active">비교견적 신청 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!--검색 영역-->
					<form class="form-horizontal" id="searchForm" method="get">
						<div class="box-body">
							<div class="form-group">									
								<label class="col-md-2 control-label">주문 일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${pvo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${pvo.searchDate2}">
									</div>
								</div>
								<div class="col-md-3 form-control-static">								
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오 늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전 체</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">처리 상태</label>
								<div class="col-md-2">
									<select class="form-control" name="statusCode">
										<option value="">---전체 검색---</option>
										<option value="N" ${pvo.statusCode eq 'N' ? "selected":"" }>요청</option>
										<option value="Y" ${pvo.statusCode eq 'Y' ? "selected":"" }>처리완료</option>
									</select>
								</div>
								<label class="col-md-2 control-label">상세 검색</label>
								<div class="col-md-2">
									<select class="form-control" name="search">
										<option value="">---검색 구분---</option>
										<option value="order_detail_seq" <c:if test="${pvo.search eq 'order_detail_seq'}">selected</c:if>>상품주문번호</option>
										<option value="order_seq" <c:if test="${pvo.search eq 'order_seq'}">selected</c:if>>주문번호</option>
										<option value="member_name" <c:if test="${pvo.search eq 'member_name'}">selected</c:if>>주문자명</option>
									</select>
								</div>
								<div class="col-md-2">
									<input  class="form-control" type="text" name="findword" value="${pvo.findword}" maxlength="20"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" onclick="location.href='/admin/estimate/compare/list'" class="btn btn-warning btn-sm">검색초기화</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:6%"/>
								<col style="width:6%"/>
								<col style="width:7%"/>
								<col style="width:7%"/>
								<col style="width:7%"/>
								<col style="width:7%"/>
								<col/>
								<col style="width:7%"/>
								<col style="width:5%"/>
								<col/>
								<col style="width:8%"/>
								<!-- <col style="width:10%"/> -->
							</colgroup>
							<thead>
								<tr>
									<th>상품<br/>주문번호</th>
									<th>주문번호</th>
									<th>주문 상태</th>
									<th>처리 상태</th>
									<th>주문자</th>
									<th>이미지</th>
									<th>상품명</th>
									<th>판매단가</th>
									<th>수량</th>
									<th>입점업체명</th>
									<th>
										주문 일자
										<p class="text-info">처리 일자</p>
									</th>
									<!-- <th>비교견적서 파일</th> -->
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center orderDetailSeq">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
												<a href="/admin/order/view/${item.orderSeq}?seq=${item.orderDetailSeq}">${item.orderDetailSeq}</a>
											</c:when>
											<c:otherwise>
												${item.orderDetailSeq}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center orderSeq">${item.orderSeq}</td>
									<td class="text-center"><strong>${item.orderStatusText}</strong></td>
									<td class="text-center">
										${item.seq eq null ? "<strong class='text-danger'>요청</strong>":"<strong class='text-info'>처리완료</strong>"}	
									</td>
									<td class="text-center memberName">
										<a href="/admin/member/view/${item.memberSeq}" target="_blank">${item.memberName}</a>
									</td>
									<td>
										<c:if test="${item.img1 ne ''}">
											<img src="/upload${fn:replace(item.img1, 'origin', 's60')}" alt="" style="width:60px;height:60px" />
										</c:if>
									</td>
									<td class="itemName">
										${item.itemName}
										<c:if test="${item.optionValue ne ''}">
											- ${item.optionValue}
										</c:if>
									</td>
									<td class="text-right sellPrice"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-center orderCnt">${item.orderCnt}</td>
									<td class="text-center">${item.sellerName}</td>
									<td class="text-center">
										${fn:substring(item.orderRegDate,0,10)}
										<p class="text-info">${fn:substring(item.regDate,0,10)}</p>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="11">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
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
		/* 날짜 검색 달력 기능 */
		showDatepicker("yy-mm-dd");
	});

	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	/** 날짜 계산 */
	var calcDate = function(val) {
		if(val == "clear") {
			$("input[name=searchDate1]").val( '2014-01-01' );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};
</script>
</body>
</html>
