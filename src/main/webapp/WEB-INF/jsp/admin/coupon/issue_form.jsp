<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.inputLine td {
			background-color: #fff9e0 !important;
			border-top: 2px solid #999999 !important;
			border-bottom: 2px solid #999999 !important;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="main">
	<div class="container">
		<div class="row">
			<div class="span12">
				<%--쿠폰 상세정보--%>
				<div class="widget widget-table stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>쿠폰</h3>
					</div>
					<div class="widget-content">
						<table class="table table-striped table-bordered table-list">
							<caption>쿠폰</caption>
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<thead>
							<tr>
								<th>SEQ</th>
								<th>쿠폰 이름</th>
								<th>쿠폰 상태</th>
								<th>쿠폰 종류</th>
								<th>할인금액</th>
								<th>유효기간</th>
								<th>허용 판매가</th>
								<th>카테고리</th>
								<th>생성일</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">${data.couponSeq}<input type="hidden" id="couponSeq" value="${data.couponSeq}"/></td>
									<td class="text-center">${data.couponName}</td>
									<td class="text-center">${data.couponStatusCodeAlias}</td>
									<td class="text-center">${data.couponTypeCodeAlias}</td>
									<td class="text-center"><fmt:formatNumber value="${data.discountValue}" pattern="#,###" /></td>
									<td class="text-center">${data.startDate} ~ ${data.endDate}</td>
									<td class="text-center">
										<c:if test="${data.limitMinValue ne null}">
											<fmt:formatNumber value="${data.limitMinValue}" pattern="#,###" />원 ~
										</c:if>
										<c:if test="${data.limitMaxValue ne null}">
											<fmt:formatNumber value="${data.limitMaxValue}" pattern="#,###" />원
										</c:if>
									</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${data.categorySeq eq '0'}">
												전체
											</c:when>
											<c:otherwise>
												${data.categoryName}
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-center">${fn:substring(data.regDate,0,10)}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<%--허용 상품 리스트--%>
				<div class="widget widget-table stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>쿠폰 허용 상품 목록</h3>
					</div>
					<div class="widget-content">
						<table class="table table-striped table-bordered table-list" style="table-layout:fixed">
							<caption>쿠폰 허용 상품 목록</caption>
							<colgroup>
								<col style="width:15%;"/>
								<col style="width:55%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
							</colgroup>
							<thead>
							<tr>
								<th>상품번호</th>
								<th>상품명</th>
								<th>가격</th>
								<th>상태</th>
							</tr>
							</thead>
							<tbody id="couponLimitItemTarget">
							</tbody>
						</table>
					</div>
				</div>

				<%--허용 상품 리스트 페이징--%>
				<div class="limitItemPaging pagination alternate"></div>

				<%--쿠폰 발급내역 검색--%>
				<div class="widget-box">
					<div class="widget-title">
						<form id="searchForm" class="form-horizontal" method="get" action="/admin/item/coupon/issue/reg/form/${search.couponSeq} ">
							<input type="hidden" name="couponSeq" value="${search.couponSeq}" />
							<div class="widget widget-form stacked">
								<div class="widget-header">
									<div class="pull-left"><i class="icon-search"></i> 검색 조건</div>
									<div class="pull-right">
										<button type="submit" class="btn btn-small btn-default" style="margin-right:10px;">검색하기</button>
										<a href="/admin/item/coupon/issue/reg/form/${search.couponSeq}" class="btn btn-small btn-warning">초기화</a>
									</div>
								</div>
								<div class="widget-content">
									<div class="row-fluid">
										<div class="control-group span6">
											<label class="control-label">회원 아이디</label>
											<div class="controls">
												<input type="text" placeholder="회원 아이디" name="issueUserId" value="${search.issueUserId}"/>
											</div>
										</div>
										<div class="control-group span6">
											<label class="control-label">회원 이름</label>
											<div class="controls">
												<input type="text" placeholder="회원 이름" name="issueUserName" value="${search.issueUserName}"/>
											</div>
										</div>
									</div>
									<div class="row-fluid">
										<div class="control-group span6">
											<label class="control-label">상품주문번호</label>
											<div class="controls">
												<input type="text" placeholder="상품주문번호" name="orderDetailSeq" value="${search.orderDetailSeq}"/>
											</div>
										</div>
										<div class="control-group span6">
											<label class="control-label">이벤트</label>
											<div class="controls">
												<input type="text" placeholder="이벤트 번호" name="eventSeq" value="${search.eventSeq}"/>
											</div>
										</div>
									</div>
									<div class="row-fluid">
										<div class="control-group span6">
											<label class="control-label">상태</label>
											<div class="controls">
												<select id="issueStatusCode" name="issueStatusCode">
													<option value="">-- 전체 --</option>
													<option value="" ${search ne null || search.issueStatusCode eq '' ? "selected" :  ""}>전체</option>
													<option value="Y" ${search ne null && search.issueStatusCode eq 'Y' ? "selected" :  ""}>사용가능(미사용)</option>
													<option value="N" ${search ne null && search.issueStatusCode eq 'N' ? "selected" :  ""}>사용불가능(사용완료)</option>
												</select>
											</div>
										</div>
										<div class="control-group span6">
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>

				<%--쿠폰 발급내역 리스트--%>
				<div class="widget widget-table stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>쿠폰 발급 내역</h3>
						<div class="pull-right">
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
								<button onclick="showExcelModal();" class="btn btn-small btn-primary">엑셀업로드</button>
								<button onclick="downloadExcel();" class="btn btn-small btn-info" style="margin-right:10px;">엑셀다운</button>
							</c:if>
						</div>
					</div>
					<div class="widget-content">
						<table class="table table-striped table-bordered table-list" style="table-layout:fixed">
							<caption>쿠폰 발급 내역</caption>
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<col style="width:10%;"/>
								</c:if>
							</colgroup>
							<thead>
							<tr>
								<th>SEQ</th>
								<th>아이디</th>
								<th>이름</th>
								<th>상태</th>
								<th>사용상품주문</th>
								<th>사용일</th>
								<th>발급일</th>
								<th>이벤트</th>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
									<th>삭제</th>
								</c:if>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td class="text-center">${item.couponIssueSeq}</td>
									<td class="text-center">${item.issueUserId}</td>
									<td class="text-center">${item.issueUserName}</td>
									<td class="text-center">${item.issueStatusCodeAlias}</td>
									<td class="text-center">${item.orderDetailSeq}</td>
									<td class="text-center">${fn:substring(item.useDate,0,10)}</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
									<td class="text-center">
										<a href="/admin/event/exhlist?eventSeq=${item.eventSeq}">${item.eventSeq}</a>
									</td>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
										<td class="text-center">
											<c:if test="${item.issueStatusCode eq 'Y'}">
												<a href="/admin/item/coupon/issue/delete/${item.couponIssueSeq}?seq=${data.couponSeq}" target="zeroframe" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-danger btn-small">삭제</a>
											</c:if>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(list) eq 0}">
								<tr>
									<td colspan="9" class="text-center muted" style="padding:30px">
										등록된 내용이 없습니다
									</td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>

				<%--페이징--%>
				<div class="pagination alternate">${paging}</div>


				<%--발급--%>
				<div class="pull-left">
					<a href="/admin/item/coupon/list" class="btn">목록</a>
					<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
						<a href="/admin/item/coupon/mod/form/${data.couponSeq}" class="btn btn-warning">수정</a>
					</c:if>
				</div>
				<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
					<div class="pull-right">
						<form id="validation-form" method="post" action="/admin/item/coupon/issue/reg" target="zeroframe" class="form-horizontal" onsubmit="return doSubmit(this);">
							<input type="hidden" name="couponSeq" value="${data.couponSeq}" />
							<div class="control-group">
								<label class="control-label" for="issueUserId">회원 아이디</label>
								<div class="controls">
									<input type="text" id="issueUserId" name="issueUserId" class="span3" maxlength="50" required="required" />
									<button type="submit" class="btn btn-info">등록하기</button>
								</div>
							</div>
						</form>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<div id="excelModal" class="modal hide">
	<div class="modal-body">
		<legend>엑셀 업로드 하기</legend>
		<div class="alert alert-danger">
			엑셀은 반드시 2003 형식으로 업로드하셔야 합니다. 반드시 첫번째 열이 제목열이어야 합니다.
			<a href="${const.ASSETS_PATH}/assets/xls/coupon_example.xls" class="btn btn-warning">업로드용 쿠폰 샘플 엑셀 다운로드</a>
		</div>
		<div>
			<form action="/admin/item/coupon/issue/upload/excel" method="post" enctype="multipart/form-data" target="zeroframe">
				<span class="btn btn-success fileinput-button">
					<i class="icon-plus icon-white"></i>
					<span>엑셀 파일 업로드하기...</span>
					<input type="file" onchange="checkFileSize(this);" name="file[0]" value="" onchange="submitUploadProc(this)" />

				</span>
				<div id="upload-alert" class="hide">파일을 업로드하고 있습니다. 잠시만 기다려주세요 <img src="/assets/img/common/ajaxloader.gif" alt="" /></div>
			</form>
		</div>
	</div>
	<div class="modal-footer">
		<a data-dismiss="modal" class="btn" href="#">close</a>
	</div>
</div>
<!-- 상품 허용 리스트 template -->
<script id="trTemplate" type="text/html">
	<tr>
		<td style="width:15%;text-align:center;"><%="${itemSeq}"%></td>
		<td style="width:55%;text-align:left;">
			<span><%="${itemName}"%></span><br/>
		</td>
		<td style="width:15%;text-align:center;"><%="${sellPrice}"%></td>
		<td style="width:15%;text-align:center;"><%="${statusFlag}"%></td>
	</tr>
</script>
<script id="errorTemplate" type="text/html">
	<p class="text-error"><%="${message}"%></p>
</script>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var downloadExcel = function() {
		$("#searchForm").attr("action", "/admin/item/coupon/issue/download/excel");
		//$("#searchForm").attr("target", "zeroframe");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	};

	var showExcelModal = function(){
		$("#upload-alert").hide().prev().show();
		$("#excelModal").modal();
	};

	var submitUploadProc = function(obj) {
		$(obj).parents('form')[0].submit();
		$(obj).parents("span").hide().next().show();
	};

	var callbackProc = function(msg) {
		var key = msg.split(":")[0];
		var value = msg.split(":")[1];
		if(key === "filename") {
			$("#upload-alert").html('이제 이 파일이 유효한지 검사합니다. 잠시만 기다려주세요 <img src="/assets/img/common/ajaxloader.gif" alt="" />');

			$.ajax({
				url:"/admin/item/coupon/issue/check/excel",
				type:"get",
				data:{
					filepath:value
					, couponSeq:parseInt($("#validation-form input[name=couponSeq]").val(), 10)
				},
				dataType:"text",
				success:function(data) {
					if(data === "OK") {
						$("#errorList").html("");
						alert('모든 작업이 완료되었습니다');
						location.href = location.href;
					} else {
						var vo = $.parseJSON(data);
						$("#upload-alert").html( $("#errorTemplate").tmpl(vo.errorList) );
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		} else {
			alert(msg);
		}
	}

	var getLimitItemList = function(pageNum){
		$.ajax({
			type:"GET",
			url:"/admin/item/coupon/limit/list/ajax",
			dataType:"text",
			data:{couponSeq:$("#couponSeq").val(),pageNum:pageNum},
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.length != 0){
					$("#couponLimitItemTarget").html( $("#trTemplate").tmpl(list));
				} else {
					$("#couponLimitItemTarget").html("<tr><td class='text-center' colspan='4'>등록된 내용이 없습니다.</td></tr>");
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};
	var getLimitItemListPaging = function(pageNum){
		$.ajax({
			type:"GET",
			url:"/admin/item/coupon/limit/list/paging/ajax",
			dataType:"text",
			data:{couponSeq:$("#couponSeq").val(),pageNum:pageNum},
			success:function(data) {
				$(".limitItemPaging").html(data);
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};
	var goLimitItemPage = function (page) {
		getLimitItemList(page);
		getLimitItemListPaging(page);
	};

	$(document).ready(function(){
		getLimitItemList(0);
		getLimitItemListPaging(0);
	});
</script>
</body>
</html>
