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
		<h1>${title} 게시판<small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>about 사회적경제</li>
			<li>게시판 관리</li>
			<li class="active">${title} 게시판</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<form id="searchForm" action="/admin/about/board/detail/list/${vo.commonBoardSeq}" method="get" class="form-horizontal" style="margin-bottom:0;">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">등록일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${vo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${vo.searchDate2}">
									</div>
								</div>
								<div class="col-md-3 form-control-static">
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전체</button>
								</div>
							</div>
						</div>

						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${vo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-sm btn-warning">검색하기</button>
							</div>
						</div>
					</form>
				</div>

				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->

						<%--관리자만 작성 가능 --%>
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
							<div class="pull-right">
								<a href="/admin/about/board/detail/form/${vo.commonBoardSeq}" class="btn btn-sm btn-info">등록하기</a>
							</div>
						</c:if>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:5%;"/>
								<col style="width:*"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
							</colgroup>
							<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>작성자</th>
								<th>답변여부</th>
								<th>공지글여부</th>
								<th>비밀글여부</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td>
										<a href="/admin/about/board/detail/view/${item.seq}?commonBoardSeq=${vo.commonBoardSeq}">
											${item.title}
											<c:if test="${cvo.commentUseFlag eq 'Y'}">[${item.commentCnt}]</c:if>
										</a>
										<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.userSeq eq null}">
												${item.userName}(회원)
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${item.userTypeCode eq 'A'}">
														${item.memberName}(관리자)
													</c:when>
													<c:otherwise>
														${item.memberName}(회원)
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.answerFlag eq 'Y'}">
												답변
											</c:when>
											<c:otherwise>
												미답변
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.noticeFlag eq 'Y'}">
												공지글
											</c:when>
											<c:otherwise>
												일반글
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.secretFlag eq 'Y'}">
												비밀글
											</c:when>
											<c:otherwise>
												공개글
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${item.viewCnt}</td>
									<td class="text-center">${fn:substring(item.regDate, 0, 10)}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="8">등록된 내용이 없습니다.</td></tr>
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
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

		/** 날짜 계산 */
	var calcDate = function(days) {
		if(days === "clear") {
			$("#searchDate1").val( '2014-01-01' );
			$("#searchDate2").val( moment().format("YYYY-MM-DD"));
		} else {
			$("#searchDate1").val( moment().subtract('days', parseInt(days,10)).format("YYYY-MM-DD") );
			$("#searchDate2").val( moment().format("YYYY-MM-DD"));
		}
	};
</script>
</body>
</html>
