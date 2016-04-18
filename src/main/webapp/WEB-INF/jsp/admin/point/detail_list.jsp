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
		<h1>포인트 적립/사용내역 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li>포인트 적립/사용내역</li>
			<li class="active">포인트 적립/사용내역 상세정보</li>
		</ol>
	</section>



<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<form id="searchForm" class="form-horizontal" method="post" style="margin-bottom:0;">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">유효일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="endDate" name="endDate" value="${vo.endDate}">
									</div>
									<div style="color:red;font-size:12px;">
										※ 유효일자 검색을 사용하시면 선택하신 유효일자 이전의 포인트 내역이 검색됩니다.
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">구분</label>
								<div class="col-md-2">
									<select id="validFlag" name="validFlag" class="form-control">
										<option value="">전체</option>
										<option value="Y" <c:if test="${vo.validFlag eq 'Y'}">selected</c:if>>사용가능</option>
										<option value="N" <c:if test="${vo.validFlag eq 'N'}">selected</c:if>>사용불가</option>
									</select>
								</div>
								<label class="col-md-4 control-label">적립방식</label>
								<div class="col-md-2">
									<select id="reserveCode" name="reserveCode" class="form-control">
										<option value="">전체</option>
										<c:forEach var="item" items="${commonlist}">
											<option value="${item.value}" <c:if test="${vo.reserveCode eq item.value}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
								<input type="hidden" name="memberSeq" value="${detailVo.memberSeq}">
							</div>

							<div class="box-footer">
								<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
								<div class="pull-right">
									<button type="submit" class="btn btn-sm btn-default" style="margin-right:10px;">검색하기</button>
									<button type="button" onclick="downloadExcel();" class="btn btn-info btn-sm" style="margin-right:10px;">엑셀다운</button>
									<a href="/admin/point/list" class="btn btn-sm" style="margin-right:10px;">목록보기</a>
								</div>
							</div>
						</form>
					</div>

					<div class="box">
						<div class="box-body">
							<table class="table table-bordered table-list">
								<caption>현재 잔여 포인트</caption>
								<colgroup>
									<col style="width:25%;"/>
									<col style="width:25%;"/>
									<col style="width:25%;"/>
									<col style="width:25%;"/>
								</colgroup>
								<thead>
								<tr>
									<th>회원 아이디</th>
									<th>회원 이름</th>
									<th>회원 쇼핑몰</th>
									<th>잔여포인트</th>
								</tr>
								</thead>
								<tbody>
									<tr>
										<td class="text-center">${detailVo.id}</td>
										<td class="text-center">${detailVo.name}</td>
										<td class="text-center">${detailVo.mallName}</td>
										<td class="text-center">
											<fmt:formatNumber value="${detailVo.useablePoint}" pattern="#,###" /> P
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<div class="box">
						<div class="box-body">
							<table class="table table-bordered table-list">
								<caption>포인트 적립/사용 내역</caption>
								<colgroup>
									<col style="width:5%;"/>
									<col style="width:10%;"/>
									<col style="width:15%;"/>
									<col style="width:15%;"/>
									<col style="width:13%;"/>
									<col style="width:13%;"/>
									<col style="width:20%;"/>
								</colgroup>
								<thead>
								<tr>
									<th>Seq</th>
									<th>발생일</th>
									<th>포인트</th>
									<th>상태</th>
									<th>주문번호</th>
									<th>상품주문번호</th>
									<th>비고</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="item" items="${listPoint}">
									<tr>
										<td class="text-center">${item.seq}</td>
										<td class="text-center">
											<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
											<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
										</td>
										<td class="text-center">
											<fmt:formatNumber value="${item.point}" pattern="#,###" /> P
										</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${item.statusCode eq 'S'}">
													적립
												</c:when>
												<c:when test="${item.statusCode eq 'U'}">
													사용
												</c:when>
												<c:when test="${item.statusCode eq 'D'}">
													소멸
												</c:when>
												<c:when test="${item.statusCode eq 'C'}">
													취소적립
												</c:when>
											</c:choose>
										</td>
										<td class="text-center">
											<a href="/admin/order/list?searchOrder=orderSeq&orderSeq=${item.orderSeq}" target="_blank">${item.orderSeq}</a>
										</td>
										<td class="text-center">
											<a href="/admin/order/view/${item.orderSeq}?seq=${item.orderDetailSeq}" target="_blank">${item.orderDetailSeq}</a>
										</td>
										<td class="text-center">
											${item.note}
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="dataTables_paginate paging_simple_numbers text-center">${pointPaging}</div>

					<c:if test="${sessionScope.loginType eq 'A' and sessionScope.gradeCode eq 0}">
					<div class="box">
						<div class="box-body">
							<table class="table table-bordered table-list">
								<caption>포인트 적립 상세 내역</caption>
								<colgroup>
									<col style="width:5%;"/>
									<col style="width:10%;"/>
									<col style="width:10%;"/>
									<col style="width:13%;"/>
									<col style="width:13%;"/>
									<col style="width:6%;"/>
									<col style="width:8%;"/>
									<col style="width:23%;"/>
									<col style="width:12%;"/>
								</colgroup>
								<thead>
								<tr>
									<th>Seq</th>
									<th>발생일</th>
									<th>만료일</th>
									<th>적립 포인트</th>
									<th>사용가능 포인트</th>
									<th>구분</th>
									<th>적립방식</th>
									<th>비고</th>
									<th>지급자</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="item" items="${list}">
									<tr>
										<td class="text-center">${item.seq}</td>
										<td class="text-center">
											<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
											<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
										</td>
										<td class="text-center">
											<fmt:parseDate value="${item.endDate}" var="endDate" pattern="yyyy-mm-dd"/>
											<fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>
										</td>
										<td class="text-center">
											<fmt:formatNumber value="${item.point}" pattern="#,###" /> P
										</td>
										<td class="text-center">
											<fmt:formatNumber value="${item.useablePoint}" pattern="#,###" /> P
										</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${item.validFlag eq 'Y'}">
													사용가능
												</c:when>
												<c:when test="${item.validFlag eq 'N'}">
													사용불가
												</c:when>
											</c:choose>
										</td>
										<td class="text-center">${item.reserveText}</td>
										<td class="text-center">${item.reserveComment}</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${item.gradeText eq ''}">
													자동 지급
												</c:when>
												<c:otherwise>
													${item.adminName}(${item.gradeText})
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
				</c:if>
			</div>
		</div>
	</section>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
	});

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var goPointPage = function (page) {
		location.href = location.pathname + "?pg=" + page + "&" + $("#searchForm").serialize();
	};

	var downloadExcel = function() {
		$("#searchForm").attr("action", "/admin/point/detail/list/download");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	};
</script>
</body>
</html>
