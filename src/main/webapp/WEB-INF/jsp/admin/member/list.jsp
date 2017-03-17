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
		<h1>회원 리스트 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li class="active">회원 리스트</li>
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
					<form id="searchForm" method="get" class="form-horizontal" style="margin-bottom:0;">
						<input type="hidden" name="longTermNotLoginFlag" value="${pvo.longTermNotLoginFlag}"/>
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">등록일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${pvo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${pvo.searchDate2}">
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
							<div class="form-group">
								<label class="col-md-2 control-label">회원 등급</label>
								<div class="col-md-2">
									<select class="form-control" name="memberTypeCode">
										<option value="">---전체---</option>
									<c:forEach var="item" items="${gradeList}">
										<option value="${item.name}" <c:if test="${pvo.gradeName == item.name}">selected</c:if>>${item.name}</option>
									</c:forEach>
									</select>
								</div>
								<label class="col-md-4 control-label">상태</label>
								<div class="col-md-2">
									<select class="form-control" name="statusCode">
										<option value="">---전체---</option>
									<c:forEach var="item" items="${statusList}">
										<option value="${item.value}" <c:if test="${pvo.statusCode == item.value}">selected</c:if>>${item.name}</option>
									</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="findword">상세 검색</label>
								<div class="col-md-2">
									<select class="form-control" id="search" name="search">
										<option value="id"   <c:if test="${pvo.search eq 'id'}">selected</c:if>>아이디</option>
										<option value="name" <c:if test="${pvo.search eq 'name' or pvo.search eq ''}">selected</c:if>>이름</option>
										<option value="groupName" <c:if test="${pvo.search eq 'groupName'}">selected</c:if>>업체명</option>
										<option value="email" <c:if test="${pvo.search eq 'email'}">selected</c:if>>이메일</option>
									</select>
								</div>
								<div class="col-md-2">
									<input class="form-control" type="text" id="findword" name="findword" value="${pvo.findword}" maxlength="50"/>
								</div>
								<label class="col-md-2 control-label">한페이지출력수</label>
								<div class="col-md-2">
									<select class="form-control" name="rowCount">
										<option value="20" <c:if test="${pvo.rowCount eq '20'}">selected="selected"</c:if>>20개씩보기</option>
										<option value="50" <c:if test="${pvo.rowCount eq '50'}">selected="selected"</c:if>>50개씩보기</option>
										<option value="100" <c:if test="${pvo.rowCount eq '100'}">selected="selected"</c:if>>100개씩보기</option>
									</select>
								</div>
							</div>
							<div class="form-group">
							<label class="col-md-2 control-label"></label>
								<div class="col-md-4" style="font-size:12px;">* 이메일 검색의 경우 이메일 주소까지 정확히 입력하셔야 검색됩니다.</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">이메일 수신 허용</label>
								<div class="col-md-2">
									<select class="form-control" name="emailFlag">
										<option value="">---전체---</option>
										<option value="Y" <c:if test="${pvo.emailFlag eq 'Y'}">selected="selected"</c:if>>허용</option>
										<option value="N" <c:if test="${pvo.emailFlag eq 'N'}">selected="selected"</c:if>>허용안함</option>
									</select>
								</div>

								<label class="col-md-4 control-label">SMS 수신 허용</label>
								<div class="col-md-2">
									<select class="form-control" name="smsFlag">
										<option value="">---전체---</option>
										<option value="Y" <c:if test="${pvo.smsFlag eq 'Y'}">selected="selected"</c:if>>허용</option>
										<option value="N" <c:if test="${pvo.smsFlag eq 'N'}">selected="selected"</c:if>>허용안함</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">이용권한</label>
								<div class="col-md-2">
									<select class="form-control" name="mallaccess">
										<option value="">---전체---</option>
										<c:forEach var="mallList" items="${mallList}">
											<option value="${mallList.name}" <c:if test="${pvo.gradeName == mallList.name}">selected</c:if>>${mallList.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-sm btn-default">검색하기</button>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<button type="button" onclick="downloadExcel();" class="btn btn-success btn-sm">엑셀다운</button>
								</c:if>
							</div>
						</div>
					</form>
				</div>

				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->

					<div class="box-body">
						<div class="box-header">
							<ul id="tab-menu" class="nav nav-tabs">
								<li id="tab-member"><a href="#" onclick="memberType('member',0);">일반회원</a></li>
								<li id="tab-request"><a href="#" onclick="memberType('request',0);">요청회원</a></li>
							</ul>
						</div>
						<div class="box-body" id="cs-list">
							<!-- 일반회원 -->
							<table id="tbl-member-list" class="table table-bordered table-striped">
								<thead>
								<tr>
									<th>No.</th>
									<th>회원등급</th>
									<c:forEach var="mall" items="${mallList}" begin="0" step="1">
										<th>${mall.name}<br>이용권한</th>
									</c:forEach>
									<th>업체명</th>
									<th>아이디</th>
									<th>이름(담당자)</th>
									<th>부서/직책</th>
									<th>휴대 전화</th>
									<th>이메일</th>
									<th>주문액</th>
									<th>포인트</th>
									<th>등록일자<br/><span class="text-info">마지막 접속일</span></th>
								</tr>
								</thead>
								<tbody></tbody>
							</table>
							<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<!-- 템플릿 호출  -->
<%@ include file="/WEB-INF/jsp/admin/include/memberAccess_list_tmpl.jsp" %>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showDatepicker("yy-mm-dd");
		memberType('member',0);
	});

	var goPage = function (page) {
		memberType(currentListType, pageNum);
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

	var downloadExcel = function() {
		$("#searchForm").attr("action", "/admin/member/list/download/excel");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	};
	var downloadThatDayExcel = function() {
		if($("#thatDayMemberRegDate").val()==""){
			alert("일자를 입력해주세요.");
			return;
		}
		location.href = "/admin/member/list/download/excel?thatDayMemberRegDate="+$("#thatDayMemberRegDate").val();
	};

	var memberType = function(listType, pageNum) {
		currentListType = listType;//현제 tab-menu 구하는 함수 알때까지 전역변수로 일단 사용하자;;
		$.ajax({
			url:"/admin/member/all/list/"+listType,
			type:"post",
			data:{pageNum:pageNum},
			dataType:"text",
			success:function(data) {
				//탭메뉴 전체 비활성화
				$("#tab-menu li").removeClass("active");
				//테이블 전체 비활성화
				$("#cs-list table").css("display","none");
				//$("#cs-list table tbody").html("");

				//선택 메뉴 활성화
				$("#tab-"+listType).addClass("active");
				//선택 메뉴 테이블 활성화
				$("#tbl-"+listType+"-list").css("display","table");
				//선택 메뉴 테이블 데이터 렌더링
				$("#tbl-"+listType+"-list tbody").html("<tr><td colspan='20' class='text-center'><img src='/assets/img/common/ajaxloader.gif'/> 데이터를 불러오고 있습니다.</td></tr>");

				var vo = $.parseJSON(data);

				if(vo.list.length == 0) {
					$("#tbl-member-list tbody").html("<tr><td colspan='20' class='muted text-center'>검색된 결과가 없습니다</td></tr>");
				} else {
					$("#tbl-member-list tbody").html( $("#tmpl-member-list").tmpl(vo.list) );
				}

				//페이징 네비게이션 렌더링
				$("#paging").html(vo.paging);
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};

</script>
</body>
</html>
