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
		<h1>공급사 리스트 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>공급사 관리</li>
			<li class="active">공급사 리스트</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<form  class="form-horizontal" id="searchForm">
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
								<label class="col-md-2 control-label" for="statusCode">상태</label>
								<div class="col-md-2">
									<select class="form-control" id="statusCode" name="statusCode">
										<option value="">전체</option>
									<c:forEach var="item" items="${statusList}">
										<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
									</c:forEach>
									</select>
								</div>
								<label class="col-md-2 control-label" for="findword">상세 검색</label>
								<div class="col-md-2">
									<select class="form-control" id="search" name="search">
										<!-- <option value="">---검색 구분---</option> -->
										<option value="name" <c:if test="${pvo.search eq 'name'}">selected</c:if>>상호명(법인명)</option>
										<option value="id"   <c:if test="${pvo.search eq 'id'}">selected</c:if>>아이디</option>
									</select>
								</div>
								<div class="col-md-2">
									<input class="form-control" type="text" id="findword" name="findword" value="${pvo.findword}" maxlength="20"/>
								</div>
							</div>
							<!--
							<div class="form-group">
								<label class="col-md-2 control-label">인증구분</label>
								<div class="checkbox col-md-10">
								<c:forEach var="item" items="${authCategoryList}">
									<label>
										<input type="checkbox" name="authCategory" value="${item.value}" <c:if test="${fn:indexOf(pvo.authCategory, item.value) >= 0}">checked="checked"</c:if> />
										${item.name}<img src="/front-assets/images/detail/auth_mark_${item.value}.png" alt="${item.name }">
									</label>
								</c:forEach>
								</div>
							</div>
							-->
							<div class="form-group">
								<label class="col-md-2 control-label" for="statusCode">지역</label>
								<div class="col-md-2">
									<select class="form-control" id="jachiguSido" data-required-label="소속 자치구 시/도">
										<option value="">--- 시/도 ---</option>
										<option value="01">서울시</option>
										<option value="99">기타</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" id="jachiguCode" name="jachiguCode" style="display:none;" data-required-label="자치구">
										<option value="">--- 자치구 ---</option>
										<c:forEach var="item" items="${jachiguList}">
											<option value="${item.value}" <c:if test="${pvo.jachiguCode eq item.value}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" id="excelDownBtn" onclick="CHExcelDownload.excelDown();" class="btn btn-success btn-sm">엑셀다운</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<div class="pull-right"><a href="/admin/seller/reg/S" class="btn btn-sm btn-info">신규 등록</a></div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<%--<colgroup>--%>
								<%--<col style="width:3%;"/>--%>
								<%--<c:forEach var="mall" items="${mallList}" begin="0" step="1">--%>
									<%--<col style="width:8%;"/>--%>
								<%--</c:forEach>--%>
								<%--<col style="width:*;"/>--%>
								<%--<col style="width:10%"/>--%>
								<%--<col style="width:8%"/>--%>
								<%--<col style="width:10%"/>--%>
								<%--<col style="width:5%;"/>--%>
								<%--<col style="width:7%;"/>--%>
								<%--<col style="width:10%;"/>--%>
								<%--<col style="width:7%;"/>--%>
								<%--<col style="width:6%;"/>--%>
								<%--<col style="width:6%;"/>--%>
								<%--<col style="width:6%;"/>--%>
							<%--</colgroup>--%>
							<thead>
								<tr>
									<%--<th>No.</th>--%>
										<th>아이디</th>
										<th>상호명</th>
									<c:forEach var="mall" items="${mallList}" begin="0" step="1">
										<th>${mall.name}<br>운영권한</th>
									</c:forEach>

									<th>수수료(%)</th>
									<th>등록 상품수<br/>(판매중/전체)</th>
									<th>상태</th>
									<%--<th>대표전화</th>--%>
									<th>담당자<br/>연락처</th>
									<th>이메일</th>
									<th>판매건수</th>
									<th>판매금액</th>
									<th>원가계</th>
									<th>이익률</th>
									<th>배송비계</th>
									<th>실배송비계</th>
									<th>등록일자</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<%--<td class="text-center">${item.seq}</td>--%>
										<td>
											<c:choose>
												<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 4)}">
													<a href="/admin/seller/mod/${item.seq}">${item.id}</a>
													<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
												</c:when>
												<c:otherwise>
													${item.id}<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
												</c:otherwise>
											</c:choose>
										</td>
										<td>${item.name}</td>
									<c:forEach var="access" items="${item.mallAccessVos}">
										<c:if test="${access.accessStatus eq 'X'}"><td class="text-center"><span class="text-warning">미요청</span></td></c:if>
										<c:if test="${access.accessStatus eq 'A'}"><td class="text-center"><span class="text-success">이용</span></td></c:if>
										<c:if test="${access.accessStatus eq 'N'}"><td class="text-center"><span class="text-danger">거절</span></td></c:if>
										<c:if test="${access.accessStatus eq 'R'}"><td class="text-center"><span class="text-danger">요청</span></td></c:if>
										<c:if test="${access.accessStatus eq 'H'}"><td class="text-center"><span class="text-warning">보류</span></td></c:if>
									</c:forEach>

									<td class="text-center">${item.commission}%</td>
									<td class="text-center">${item.sellItemCount}&nbsp;/&nbsp;${item.totalItemCount}</td>
									<td class="text-center">${item.statusText}</td>
									<%--<td class="text-center">${item.tel}</td>--%>
									<td class="text-center">${item.salesTel}</td>
									<td class="text-center">${item.salesEmail}</td>
									<td class="text-center"><fmt:formatNumber value="${item.totalItemCount}"/>건</td>
									<td class="text-center"><fmt:formatNumber value="${item.totalSellPrice}"/>원</td>
									<td class="text-center"><fmt:formatNumber value="${item.totalSellOrgPrice}"/>원</td>
									<c:set var="profit" value="${item.totalSellPrice-item.totalSellOrgPrice+item.deliCost-item.totalDeliCost}" />
									<c:choose>
										<c:when test="${profit>0}">
											<td class="text-center"><fmt:formatNumber value="${profit*100/item.totalSellPrice}"/>%</td>
										</c:when>
										<c:otherwise>
											<td class="text-center"><fmt:formatNumber value="${0}"/>%</td>
										</c:otherwise>
									</c:choose>
									<td class="text-center"><fmt:formatNumber value="${item.deliCost}"/>원</td>
									<td class="text-center"><fmt:formatNumber value="${item.totalDeliCost}"/>원</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="12">등록된 공급사가 없습니다.</td></tr>
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
	$(document).ready(function(){
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
		
		//자치구 시/도 항목 기본 설정
		setJachiguSido();
	});

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

	var CHExcelDownload = {
		excelDown:function() {
			$("#searchForm").attr("action", "/admin/seller/list/download/excel");
			$("#searchForm").submit();
			$("#searchForm").attr("action",location.pathname);
		}
	};
	
	//소속 자치구 이벤트 컨트롤
	$("#jachiguSido").change(function() {
		if($(this).val() == "01") {
			//서울시일 경우에만 자치구 선택 가능
			$("#jachiguCode").css("display","block");
			$("#jachiguCode").val("");
		} else {
			$("#jachiguCode").css("display","none");
			$("#jachiguCode").val($(this).val());
		}
	});
	
	//자치구 시/도 항목 기본 설정
	var setJachiguSido = function() {
		if($("#jachiguCode").val() == "" || $("#jachiguCode").val() == "99") {
			$("#jachiguCode").css("display","none");
			$("#jachiguSido").val($("#jachiguCode").val());
		} else {
			$("#jachiguCode").css("display","block");
			$("#jachiguSido").val("01");
		}
	};
	
	var deleteProc = function(seq) {
		if(confirm('승인대기 중인 공급사만 삭제할 수 있습니다\n정말로 삭제하시겠습니까?\n이 과정은 복구하실 수 없습니다')) {
			$('#zeroframe').attr('src', '/admin/seller/delete?seq='+seq);
		}
	};
</script>
</body>
</html>
