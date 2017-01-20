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
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>${title} <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>게시판 관리</li>
			<li class="active">${title}</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<form id="searchForm" method="get" class="form-horizontal" action="/admin/board/list/${boardGroup}">
						<div class="box-body">
							<c:if test="${ boardGroup ne 'faq'}">
							<div class="form-group" ${fn:length(mallList) <= 1 ? "style='display:none'":""}>
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2">
									<select class="form-control" id="mallSeq" name="mallSeq">
										<option value="" >-- 전체 --</option>
										<c:forEach var="item" items="${mallList}">
											<option value="${item.seq}" <c:if test="${item.seq==vo.mallSeq}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							</c:if>
							<div class="form-group">
							<c:choose>
								<c:when test="${ boardGroup eq 'faq'}">
								<label class="col-md-2 control-label">구분</label>
								<div class="col-md-2">
									<select class="form-control" name="categoryCode">
										<option value="">-- 선택 --</option>
										<option value="10" ${vo ne null && vo.categoryCode eq 10 ? "selected" : ""}>회원</option>
										<option value="20" ${vo ne null && vo.categoryCode eq 20 ? "selected" : ""}>주문/결제/배송</option>
										<option value="30" ${vo ne null && vo.categoryCode eq 30 ? "selected" : ""}>환불/취소/재고</option>
										<option value="40" ${vo ne null && vo.categoryCode eq 40 ? "selected" : ""}>영수증</option>
										<option value="50" ${vo ne null && vo.categoryCode eq 50 ? "selected" : ""}>이벤트</option>
										<option value="60" ${vo ne null && vo.categoryCode eq 60 ? "selected" : ""}>기타</option>
									</select>
								</div>
								</c:when>
								<c:when test="${ boardGroup eq 'qna' or boardGroup eq 'one'}">
								<label class="col-md-2 control-label">답변 여부</label>
								<div class="col-md-2">
									<select class="form-control" id="answerFlag" name="answerFlag">
										<option value="">-- 전체 --</option>
										<option value="1" ${vo ne null && vo.answerFlag eq 1 ? "selected" : ""}>답변</option>
										<option value="2" ${vo ne null && vo.answerFlag eq 2 ? "selected" : ""}>미답변</option>
									</select>
								</div>
								</c:when>
							</c:choose>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상세 검색</label>
								<div class="col-md-1">
									<select class="form-control" id="search" name="search">
										<option value="">전체</option>
										<option value="title" ${vo.search eq 'title' ? 'selected':''}>제목</option>
										<option value="content" ${vo.search eq 'content' ? 'selected':''}>내용</option>
										<option value="name" ${vo.search eq 'name' ? 'selected':''}>작성자</option>
									</select>
								</div>
								<div class="col-md-2">
									<input class="form-control" type="text" placeholder="search" name="findword" value="${vo.findword}" />
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${vo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right"><button type="submit" class="btn btn-sm btn-default">검색하기</button></div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
				<c:if test="${boardGroup eq 'notice' or boardGroup eq 'faq'}">
					<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
						<%--관리자만 작성 가능 --%>
						<div class="pull-right">
							<a href="/admin/board/form/${boardGroup}" class="btn btn-sm btn-info">등록하기</a>
						</div>
					</c:if>
				</c:if>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table class="table table-bordered table-striped">
						<c:choose>
							<c:when test="${boardGroup eq 'notice'}">
							<thead>
								<tr>
									<th>#</th>
									<th>유형</th>
									<c:if test="${sessionScope.loginType ne 'S'}"><th ${fn:length(mallList) <= 1 ? "style='display:none'":""}>쇼핑몰</th></c:if>
									<th>제목</th>
									<th>글쓴이</th>
									<th>등록일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${ item.categoryCode eq 1 }">
												고객
											</c:when>
											<c:when test="${ item.categoryCode eq 2 }">
												입점업체
											</c:when>
										</c:choose>
									</td>
									<c:if test="${sessionScope.loginType ne 'S'}">
										<td class="text-center" ${fn:length(mallList) <= 1 ? "style='display:none'":""}>
											<c:choose>
												<c:when test="${item.mallName ne ''}">
													${item.mallName}
												</c:when>
												<c:otherwise>
													없음
												</c:otherwise>
											</c:choose>
										</td>
									</c:if>
									<td>
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5 or sessionScope.gradeCode eq 9) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
												<a href="/admin/board/view/${boardGroup}/${item.seq}">${item.title}</a><c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
											</c:when>
											<c:otherwise>
												${item.title}<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${item.name}</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
									<td class="text-center">${item.viewCount}</td>
								</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="7">등록된 내용이 없습니다.</td></tr>
								</c:if>
							</tbody>
							</c:when>
							<c:when test="${boardGroup eq 'one'}">
							<thead>
								<tr>
									<th class="text-center">#</th>
									<th class="text-center">구분</th>
									<%--<th class="text-center">주문번호</th>--%> <%--주문번호에 대한 문의는 2차개발로 한다.--%>
									<th ${fn:length(mallList) <= 1 ? "style='display:none'":""}>쇼핑몰</th>
									<th class="text-center">제목</th>
									<th class="text-center">처리상태</th>
									<th class="text-center">글쓴이</th>
									<th class="text-center">등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">
										<c:forEach var="commonItem" items="${commonList}">
											<c:if test="${item.categoryCode eq commonItem.value}">${commonItem.name}</c:if>
										</c:forEach>
									</td>
									<%--
									<td class="text-center">
									<c:choose>
										<c:when test="${item.integrationSeq eq 0}">
											일반
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5)}">
													<a href="/admin/order/view/${item.orderSeq}?seq=${item.integrationSeq}">${item.integrationSeq}</a>
												</c:when>
												<c:otherwise>
													${item.integrationSeq}
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									</td>
									--%>
									<td class="text-center" ${fn:length(mallList) <= 1 ? "style='display:none'":""}>${item.mallName}</td>
									<td><a href="/admin/board/view/${boardGroup}/${item.seq}">${item.title}</a><c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if></td>
									<c:choose>
										<c:when test="${item.answerFlag eq 2}">
											<td class="text-center">미답변</td>
										</c:when>
										<c:when test="${item.answerFlag eq 1}">
											<td class="text-center">답변완료</td>
										</c:when>
									</c:choose>
									<td class="text-center">${item.name}</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
								</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="7">등록된 내용이 없습니다.</td></tr>
								</c:if>
							</tbody>
							</c:when>
							<c:when test="${boardGroup eq 'qna'}">
							<thead>
								<tr>
									<th>#</th>
									<th>상품번호</th>
									<th colspan="2">상품명</th>
									<th ${fn:length(mallList) <= 1 ? "style='display:none'":""}>쇼핑몰</th>
									<th>제목</th>
									<th>처리상태</th>
									<th>글쓴이</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}">
								<tr>
									<td style="width:5%;" class="text-center">${item.seq}</td>
									<td style="width:8%;" class="text-center">
                                        ${ item.integrationSeq }<br/>
                                        <%--<a href="/shop/detail/${item.integrationSeq}" target="_blank" class="btn btn-mini" data-toggle="tooltip" title="미리보기"><i class="icon-search"></i></a>--%>
									</td>
									<td style="width:5%; border-right: none;" class="text-center">
										<img src="/upload${fn:replace(item.img1, 'origin', 's60')}" style="width:70px;" alt=""/>
									</td>
									<td style="width:20%;" class="text-center">${ item.itemName }</td>
									<td class="text-center" ${fn:length(mallList) <= 1 ? "style='display:none'":""}>${item.mallName}</td>
									<td style="width:*;">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5 or sessionScope.gradeCode eq 9) or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
												<a href="/admin/board/view/${boardGroup}/${item.seq}">${item.title}</a><c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
											</c:when>
											<c:otherwise>
												${item.title}<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
											</c:otherwise>
										</c:choose>
									</td>
									<c:choose>
										<c:when test="${item.answerFlag eq 2}">
											<td style="width:10%;" class="text-center">미답변</td>
										</c:when>
										<c:when test="${item.answerFlag eq 1}">
											<td style="width:10%;" class="text-center">답변완료</td>
										</c:when>
									</c:choose>
									<td style="width:10%;" class="text-center">${item.name}</td>
									<td style="width:10%;" class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
								</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="9">등록된 내용이 없습니다.</td></tr>
								</c:if>
							</tbody>
							</c:when>
							<c:when test="${boardGroup eq 'faq'}">
							<thead>
								<tr>
									<th>#</th>
									<th>구분</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${ item.categoryCode eq 10 }">
												회원
											</c:when>
											<c:when test="${ item.categoryCode eq 20 }">
												주문/결제/배송
											</c:when>
											<c:when test="${ item.categoryCode eq 30 }">
												환불/취소/재고
											</c:when>
											<c:when test="${ item.categoryCode eq 40 }">
												영수증
											</c:when>
											<c:when test="${ item.categoryCode eq 50 }">
												이벤트
											</c:when>
											<c:when test="${ item.categoryCode eq 60 }">
												기타
											</c:when>
										</c:choose>
									<td>
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5 or sessionScope.gradeCode eq 9)}">
												<a href="/admin/board/view/${boardGroup}/${item.seq}">${item.title}</a><c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
											</c:when>
											<c:otherwise>
												${item.title}<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${item.name}</td>
									<td class="text-center">
										<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</td>
								</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="5">등록된 내용이 없습니다.</td></tr>
								</c:if>
							</tbody>
							</c:when>
						</c:choose>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var boardGroup = "${boardGroup}";
	$(document).ready(function () {

	});

	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};
</script>
</body> </html>
