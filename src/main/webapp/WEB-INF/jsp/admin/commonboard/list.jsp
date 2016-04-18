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
		<h1>게시판 관리<small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>about 사회적경제</li>
			<li class="active">게시판 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<form id="searchForm" action="/admin/about/board/list" method="get" class="form-horizontal" style="margin-bottom:0;">
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
								<div class="col-md-6 form-control-static">
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
								<button type="submit" class="btn btn-sm btn-default">검색하기</button>
							</div>
						</div>
					</form>
				</div>

				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col width="10%"/>
								<col width="120px"/>
								<col width="*"/>
								<col width="150px"/>
								<col width="120px"/>
							</colgroup>
							<thead>
							<tr>
								<th>No.</th>
								<th>종류</th>
								<th>게시판 이름</th>
								<th>등록일</th>
								<th></th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${item.typeCode eq 'N'}">일반게시판</c:when>
											<c:when test="${item.typeCode eq 'Y'}">유투브게시판</c:when>
											<c:when test="${item.typeCode eq 'B'}">보도자료게시판</c:when>
											<c:when test="${item.typeCode eq 'G'}">갤러리게시판</c:when>
										</c:choose>
									</td>
									<td><a href="/admin/about/board/detail/list/${item.seq}">${item.name}</a></td>
									<td class="text-center">${fn:substring(item.regDate, 0, 10)}</td>
									<td class="text-center">
										<button type="button" onclick="editProc({seq:${item.seq}, name:'${item.name}', typeCode:'${item.typeCode}', commentUseFlag:'${item.commentUseFlag}'})" class="btn btn-xs btn-primary">수정</button>
										<c:if test="${item.seq > 3}">
										<a href="/admin/about/board/list/delete/proc/?seq=${item.seq}" class="btn btn-xs btn-danger" onclick="return confirm('정말로 삭제하시겠습니까? 삭제하면 복구하실 수 없습니다')">삭제</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="3">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
					<div class="box-footer">
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
							<button type="button" onclick="showInsertModal()" class="btn btn-sm btn-primary">등록하기</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="formTemplate" type="text/html">
	<div class="modal-dialog" role="document">
		<form onsubmit="return submitProc(this);" target="zeroframe" action="<%="${action}"%>" method="post">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">게시판 양식</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>게시판이름</label>
						<input type="text" class="form-control" name="name" maxlength="100" value="<%="${name}"%>" />
					</div>
					<div class="form-group">
						<label>종류</label>
						<select class="form-control" name="typeCode">
							<option value="N" {{if typeCode}}{{if typeCode=='N'}}selected="selected"{{/if}}{{/if}}>일반게시판</option>
							<option value="B" {{if typeCode}}{{if typeCode=='B'}}selected="selected"{{/if}}{{/if}}>보도자료게시판</option>
							<option value="Y" {{if typeCode}}{{if typeCode=='Y'}}selected="selected"{{/if}}{{/if}}>유투브게시판</option>
							<option value="G" {{if typeCode}}{{if typeCode=='G'}}selected="selected"{{/if}}{{/if}}>갤러리게시판</option>
						</select>
					</div>
					<div class="form-group">
						<label>댓글</label>
						<select class="form-control" name="commentUseFlag">
							<option value="N" {{if commentUseFlag}}{{if commentUseFlag=='N'}}selected="selected"{{/if}}{{/if}}>비허용</option>
							<option value="Y" {{if commentUseFlag}}{{if commentUseFlag=='Y'}}selected="selected"{{/if}}{{/if}}>허용</option>
						</select>
						<p class="text-muted">댓글 기능은 일반게시판일 경우에만 사용할 수 있습니다</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-primary">저장</button>
				</div>
			</div>
			<input type="hidden" name="seq" value="<%="${seq}"%>" />
		</form>
	</div>
</script>

<div class="modal fade" id="form" role="dialog"></div>

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
	
	var submitProc = function(obj) {
		if($('#form input[name=name]').val().trim() === '') {
			alert('게시판이름은 반드시 입력되어야 합니다');
			return false;
		}
	};
	
	var showInsertModal = function() {
		$('#form').html( $('#formTemplate').tmpl({
			action: '/admin/about/board/list/proc'
		}) ).modal();
	};
	
	var editProc = function(obj) {
		obj.action = '/admin/about/board/list/edit/proc';
		$('#form').html( $('#formTemplate').tmpl(obj) ).modal();
	};
</script>
</body>
</html>
