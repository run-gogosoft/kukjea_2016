<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.textCenter{
			text-align:center;
			font-size:14px;
		}

		.fa-commenting {
			color:#666;

			&:hover {
				color:#666;
				text-decoration: none;
			}
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>기획전/이벤트 관리  <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>상품 관리</li>
			<li class="active">기획전/이벤트 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header">
						<h3 class="box-title"></h3>
					</div> -->
					<!-- 내용 -->
					<form class="form-horizontal" id="searchForm" method="get">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">이벤트 번호</label>
								<div class="col-md-3">
									<input class="form-control" type="text" name="eventSeq" value="${vo.eventSeq}"/>
								</div>
								<label class="col-md-2 control-label">기획전 / 이벤트 명</label>
								<div class="col-md-3">
									<input class="form-control" type="text" name="findword" value="${vo.findword}"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상태</label>
								<div class="col-md-3">
									<select class="form-control" name="statusCode">
										<option value="">---전체---</option>
										<option value="H" ${vo.statusCode eq 'H' ? "selected" :  ""}>대기중</option>
										<option value="Y" ${vo.statusCode eq 'Y' ? "selected" :  ""}>진행중</option>
										<option value="N" ${vo.statusCode eq 'N' ? "selected" :  ""}>종료</option>
									</select>
								</div>
								<label class="col-md-2 control-label">구분</label>
								<div class="col-md-3">
									<select class="form-control" name="typeCode">
										<option value="">---전체---</option>
										<option value="1" ${vo.typeCode eq '1' ? "selected" :  ""}>기획전</option>
										<option value="2" ${vo.typeCode eq '2' ? "selected" :  ""}>이벤트</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">카테고리</label>
								<div class="col-md-3">
									<select class="form-control" alt="대분류 카테고리" id="lv1Seq" name="lv1Seq">
										<option value="">---전체---</option>
										<c:forEach var="item" items="${lv1List}">
											<option value="${ item.lv1Seq }" ${vo.lv1Seq eq item.lv1Seq ? "selected" :  ""}> ${item.cateName} </option>
										</c:forEach>
									</select>
								</div>
								<label class="col-md-2 control-label">배너영역</label>
								<div class="col-md-3">
									<select class="form-control" alt="배너영역" id="mainSection" name="mainSection">
										<option value="">---전체---</option>
										<option value="A" ${vo.mainSection eq "A" ? "selected" :  ""}>A</option>
										<option value="B" ${vo.mainSection eq "B" ? "selected" :  ""}>B</option>
										<option value="C" ${vo.mainSection eq "C" ? "selected" :  ""}>C</option>
										<option value="D" ${vo.mainSection eq "D" ? "selected" :  ""}>D</option>
										<option value="E" ${vo.mainSection eq "E" ? "selected" :  ""}>E</option>
										<option value="F" ${vo.mainSection eq "F" ? "selected" :  ""}>F</option>
										<option value="G" ${vo.mainSection eq "G" ? "selected" :  ""}>G</option>
										<option value="H" ${vo.mainSection eq "H" ? "selected" :  ""}>H</option>
									</select>
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
					<!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>#</th>
									<th>구분</th>
									<th>쇼핑몰</th>
									<th>카테고리</th>
									<th>기획전/이벤트 명</th>
									<th>상태</th>
									<th>노출<br/>여부</th>
									<th>시작 예정일</th>
									<th>종료 예정일</th>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 3)}">
										<th></th>
									</c:if>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<th></th>
									</c:if>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td style="width:2%;" class="text-center">${item.seq}</td>
									<td style="width:8%;" class="text-center">
										<c:choose>
											<c:when test="${ item.typeCode == '1' }">
												기획전
											</c:when>
											<c:when test="${ item.typeCode == '2' }">
												이벤트
											</c:when>
										</c:choose>
									</td>
									<td style="width:8%;" class="text-center">
											${item.mallName}
									</td>
									<td style="width:15%;" class="text-center">
										<c:choose>
											<c:when test="${item.cateName eq ''}">
												없음
											</c:when>
											<c:otherwise>
												${ item.cateName }
											</c:otherwise>
										</c:choose>
									</td>
									<td style="width:22%;">
										${ item.title }
									</td>
									<td style="width:5%;" class="text-center">${ item.statusCode }</td>
									<td style="width:5%;" class="text-center">
										<c:choose>
											<c:when test="${ item.showFlag == 'Y' }">
												노출
											</c:when>
											<c:when test="${ item.showFlag == 'N' }">
												노출<br/>안함
											</c:when>
										</c:choose>
									</td>
									<td style="width:10%;" class="text-center">
										<fmt:parseDate value="${item.startDate}" var="startDate" pattern="yyyymmdd"/>
										<fmt:formatDate value="${startDate}" pattern="yyyy-mm-dd"/>
									</td>
									<td style="width:10%;" class="text-center">
										<fmt:parseDate value="${item.endDate}" var="endDate" pattern="yyyymmdd"/>
										<fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>
									</td>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 3)}">
									<td style="width:10%;" class="text-center">
										<c:choose>
											<c:when test="${ item.typeCode == '1' }">
												<a href="/admin/event/edit?typeCode=${ item.typeCode }&seq=${item.seq}">기획전 수정</a><br/>
												<a href="/admin/event/item/edit?seq=${item.seq}&mallSeq=${item.mallSeq}">상품등록/수정</a>
											</c:when>
											<c:when test="${ item.typeCode == '2' }">
												<a href="/admin/event/edit?typeCode=${ item.typeCode }&seq=${item.seq}">이벤트 수정</a>
											</c:when>
										</c:choose>
									</td>
									</c:if>

									<%--<td style="width:7%;" class="text-center"><a href="/shop/event/plan/plansub/${item.seq}" target="_blank" class="btn btn-mini"><i class="icon-search"></i></a></td>--%>

									<%--<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">--%>
									<td style="width:7%;" class="text-center">
										<div onclick="veiwModal('${ item.seq }')" role="button" class="btn btn-sm btn-default" data-toggle="modal"><i class="fa fa-remove"></i></div>
									</td>
									<%--</c:if>--%>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="11">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 3)}">
						<div class="pull-right">
							<a href="/admin/event/exhform?mallSeq=${mallSeq}" class="btn btn-sm btn-info">기획전 / 이벤트 등록</a>
						</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel1">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제 하시겠습니까?</p>
				<input type="hidden" id="deleteSeq"/>
			</div>
			<div class="modal-footer">
				<button class="btn btn-md btn-default" data-dismiss="modal" aria-hidden="true">취소</button>
				<div onclick="veiwModal2()" role="button" class="btn btn-md btn-danger" data-dismiss="modal" data-toggle="modal">확인</div>
			</div>
		</div>
	</div>
</div>

<div id="myModal2" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel2">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제하시면 다시는 복구할수 없습니다, 정말 삭제하시겠습니까?</p>
				<input type="hidden" id="deleteSeq2"/>
			</div>
			<div class="modal-footer">
				<button class="btn btn-md btn-default" data-dismiss="modal" aria-hidden="true">취소</button>
				<div class="btn btn-md btn-danger" onClick="goDelete()">확인</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var goDelete = function(){
		var seq = $("#deleteSeq2").val();
		location.href = "/admin/event/del/proc?seq="+seq;
	};

	var veiwModal = function(seq){
		$("#myModal").modal('show');
		$("#deleteSeq").val(seq);
	};

	var veiwModal2 = function(){
		$("#myModal2").modal('show');
		$("#deleteSeq2").val($("#deleteSeq").val());
	};
</script>
</body>
</html>
