<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="main">
	<div class="container">
		<div class="row">
			<div class="span12">
				<div class="widget widget-form stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>${title}</h3>
					</div>
					<div class="widget-content nopadding">
						<form id="validation-form" method="post" action="/admin/item/coupon/<c:if test="${data eq null}">reg</c:if><c:if test="${data ne null}">mod</c:if>" target="zeroframe" class="form-horizontal" onsubmit="return doSubmit(this);">
							<c:if test="${data ne null}">
							<div class="control-group">
								<label class="control-label" for="couponSeq">쿠폰 번호</label>
								<div class="controls">
									<input type="text" id="couponSeq" name="couponSeq" value="${data.couponSeq}" readonly class="span4 numeric" maxlength="20" required="required" />
								</div>
							</div>
							</c:if>
							<div class="control-group">
								<label class="control-label" for="couponName">쿠폰 이름</label>
								<div class="controls">
									<input type="text" id="couponName" name="couponName" value="${data.couponName}" class="span4" maxlength="20" required="required" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="couponStatusCode">쿠폰 상태</label>
								<div class="controls">
									<select id="couponStatusCode" name="couponStatusCode" class="span2" required="required">
										<option value="H" <c:if test="${data.couponStatusCode eq 'H'}">selected</c:if>>대기</option>
										<option value="Y" <c:if test="${data.couponStatusCode eq 'Y'}">selected</c:if>>정상</option>
										<option value="N" <c:if test="${data.couponStatusCode eq 'N'}">selected</c:if>>사용중지</option>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="couponTypeCode">쿠폰 타입</label>
								<div class="controls">
									<select id="couponTypeCode" name="couponTypeCode" class="span2" required="required">
										<option value="W" <c:if test="${data.couponTypeCode eq 'W'}">selected</c:if>>금액할인</option>
										<option value="P" <c:if test="${data.couponTypeCode eq 'P'}">selected</c:if>>퍼센트(%)할인</option>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="discountValue">할인금액 or %</label>
								<div class="controls">
									<input type="text" id="discountValue" name="discountValue" value="${data.discountValue}" class="span2 numeric" maxlength="20" required="required" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="startDate">쿠폰 사용 기간 (선택)</label>
								<div class="controls">
									<input type="text" id="startDate" name="startDate" value="${data.startDate}" class="span2 numeric datepicker" maxlength="20" /> ~
									<input type="text" id="endDate" name="endDate" value="${data.endDate}" class="span2 numeric datepicker" maxlength="20" />
									<br/>
									예) 20140101 ~ 20141212 (숫자만 입력하세요)
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="limitMinValue">허용 상품 판매가</label>
								<div class="controls">
									<input type="text" id="limitMinValue" name="limitMinValue" value="${data.limitMinValue}" class="span2 numeric" maxlength="20" /> ~
									<input type="text" id="limitMaxValue" name="limitMaxValue" value="${data.limitMaxValue}" class="span2 numeric" maxlength="20" />
									<br/>
									예) 10000 ~ 80000
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="categorySeq">적용 대분류 카테고리</label>
								<div class="controls">
									<select id="categorySeq" name="categorySeq" class="span2" required="required">
										<option value="0">전체</option>
									<c:forEach var="item" items="${categoryList}">
										<option value="${item.seq}" <c:if test="${data.categorySeq eq item.seq}">selected</c:if>>${item.name}</option>
									</c:forEach>
									</select>
								</div>
							</div>
							<c:if test="${data eq null}"><div style="color:red;font-size:13px;">※ 상품허용 등록은 쿠폰 등록후 수정 페이지에서 가능합니다.</div></c:if>
							<div class="form-actions">
								<button type="submit" class="btn btn-info">
									<c:if test="${data eq null}">등록하기</c:if>
									<c:if test="${data ne null}">수정하기</c:if>
								</button>
								&nbsp;&nbsp;
								<button type="button" class="btn" onclick="location.href='/admin/item/coupon/list';">목록보기</button>
							</div>
						</form>
					</div>
					<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
					<c:if test="${data ne null}"><div style="color:red;font-size:15px;text-align:center;margin-top:20px;">※ 상품허용 등록이 되어있지 않을때는 해당 쿠폰이 모든 상품에 적용됩니다.</div></c:if>
					<c:if test="${data ne null}">
						<%-- 상품제한 등록 리스트 --%>
						<div class="widget-box" style="margin-top:20px;">
							<div class="widget widget-form stacked">
								<div class="widget-header">
									<div class="pull-left"><i class="icon-th-list"></i> <h3>상품허용 등록</h3></div>
								</div>
								<div class="widget-content nopadding">
									<table class="table table-bordered table-striped">
										<caption>코맨트</caption>
										<thead>
										<tr>
											<th>상품번호</th>
											<th>상품명</th>
											<th>가격</th>
											<th>상태</th>
											<th></th>
										</tr>
										</thead>
										<tbody id="couponLimitItemTarget">
										</tbody>
									</table>
								</div>
									<%-- 상품허용 등록 폼 --%>
								<form action="/admin/item/coupon/limit/write/proc" method="post" class="form-horizontal" target="zeroframe">
									<input type="hidden" name="couponSeq" value="${data.couponSeq}"/>
										<%-- 상품 검색을 한뒤 상품추가를 했을경우 검색된 상품 검색 테이블을 유지하기 위한 데이터를 같이 보냄 --%>
									<input type="hidden" id="insertLv1" name="insertLv1" value="${vo.lv1}"/>
									<input type="hidden" id="insertLv2" name="insertLv2" value="${vo.lv2}"/>
									<input type="hidden" id="insertLv3" name="insertLv3" value="${vo.lv3}"/>
									<input type="hidden" id="insertItemName" name="insertItemName" value="${vo.name}"/>
									<input type="hidden" id="insertItemSeq" name="insertItemSeq" value="${vo.seq}"/>
									<div class="input-append pull-right" style="margin-top:5px;">
										<input type="text" placeholder="상품코드를 입력해주세요" name="itemSeq" value="0" maxlength="10" class="numeric" />
										<button type="submit" class="btn btn-primary">상품추가</button>
									</div>
								</form>
								<div class="row">
									<div class="span12">
										<div id="paging" class="pagination alternate" style="text-align:center"> ${paging} </div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				<c:if test="${data ne null}">
				<%-- 상품 검색 --%>
				<form id="searchForm" class="form-horizontal" action="#searchForm">
					<input type="hidden" name="couponSeq" value="${ data.couponSeq }"/>
					<div class="widget widget-form stacked">
						<div class="widget-header">
							<div class="pull-left"><i class="icon-search"></i> 검색 조건</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-small btn-default" style="margin-right:10px;">검색하기</button>
							</div>
						</div>
						<div class="widget-content">
							<div class="row-fluid">
								<div class="control-group span12">
									<label class="control-label">카테고리</label>
									<div class="controls">
										<select name="lv1" class="span3" onchange="$('#searchForm')[0].submit()">
											<option value="">대분류</option>
											<c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
												<option value="${item.seq}" <c:if test="${vo.lv1 eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
											</c:forEach>
										</select>
										<select name="lv2" class="span3" onchange="$('#searchForm')[0].submit()">
											<option value="">중분류</option>
											<c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
												<option value="${item.seq}" <c:if test="${vo.lv2 eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
											</c:forEach>
										</select>
										<select name="lv3" class="span3" onchange="$('#searchForm')[0].submit()">
											<option value="">소분류</option>
											<c:forEach var="item" items="${cateLv3List}" varStatus="status" begin="0" step="1">
												<option value="${item.seq}" <c:if test="${vo.lv3 eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group span6">
									<label class="control-label">상품명</label>
									<div class="controls">
										<input type="text" name="searchItemName" id="searchItemName" value="${vo.name}" class="span12" />
									</div>
								</div>
								<div class="control-group span6">
									<label class="control-label">상품코드</label>
									<div class="controls">
										<input type="text" name="searchItemSeq" id="searchItemSeq" value="${vo.seq}" class="span12" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>

					<%-- 현재 등록된 상품목록을 불러옴 --%>
					<c:if test="${vo.lv1 ne '' || vo.lv2 ne '' || vo.lv3 ne '' || vo.name ne '' || vo.seq ne ''}">
						<div class="row" id="searchItemList">
							<div class="span12">
								<div class="widget widget-table stacked">
									<div class="widget-header">
										<i class="icon-th-list"></i>
										<h3>${itemTitle}</h3>
									</div>
									<!-- widget-header -->
									<div class="widget-content">
										<table class="table table-bordered table-list table-striped">
											<caption>${itemTitle}</caption>
											<colgroup>
												<col style="width:25%" />
												<col style="width:15%" />
												<col style="width:50%"/>
												<col style="width:10%" />
											</colgroup>
											<thead>
											<tr>
												<th>카테고리</th>
												<th>상품코드</th>
												<th>상품명</th>
											</tr>
											</thead>
											<tbody id="categoryTarget">
											</tbody>
										</table>
									</div>
								</div>
								<div id="categoryPaging" style="text-align:center"></div>
								<!-- template -->
								<script id="categoryTrTemplate" type="text/html">
									<tr>
										<td style="width:25%" class="text-center">
											<%="${cateLv1Name}"%> &gt;
											<%="${cateLv2Name}"%> &gt;
											<%="${cateLv3Name}"%>
										</td>
										<td style="width:15%" class="text-center">
											<p><%="${seq}"%></p>
											<%--<a href="/shop/detail/<%="${seq}"%>" target="_blank" class="btn btn-mini" data-toggle="tooltip" title="미리보기"><i class="icon-search"></i></a>--%>
										</td>
										<td style="width:50%">
											<p><%="${name}"%></p>
										</td>
									</tr>
								</script>
							</div>
						</div>
						</c:if>
					</c:if>
				</c:if>
			</div>
			</div>
		</div>
	</div>
</div>
<%-- 상품목록 끝 --%>
<!-- 상품 허용 리스트 template -->
<script id="trTemplate" type="text/html">
	<tr>
		<td style="width:15%;text-align:center;"><%="${itemSeq}"%></td>
		<td style="width:50%;text-align:left;">
			<span><%="${itemName}"%></span><br/>
		</td>
		<td style="width:15%;text-align:center;"><%="${sellPrice}"%></td>
		<td style="width:15%;text-align:center;"><%="${statusFlag}"%></td>
		<td>
			<div onclick="veiwModal('<%="${couponItemSeq}"%>')" role="button" class="btn" data-toggle="modal"><i class="icon-remove"></i></div>
			<%-- 첫번째 삭제 모달 --%>
			<div id="limitItemListModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel1">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제 하시겠습니까?</p>
				<input type="hidden" id="deletelimitItemSeq"/>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<div onclick="veiwModal2()" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">Confirm</div>
			</div>
		</div>
			<%-- 두번째 삭제 모달 --%>
			<div id="limitItemListModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel2">경고</h3>
			</div>
			<div class="modal-body">
				<p>삭제하시면 다시는 복구할수 없습니다, 정말 삭제하시겠습니까?</p>
				<input type="hidden" id="deletelimitItemSeq2"/>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<div class="btn btn-danger" onClick="goDelete()">Delete</div>
			</div>
		</div>
		</td>
	</tr>
</script>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript">
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
					$("#couponLimitItemTarget").html("<tr><td class='text-center' colspan='5'>등록된 내용이 없습니다.</td></tr>");
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
				$("#paging").html(data);
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

	var goDelete = function(){
		var seq = $("#deletelimitItemSeq2").val();
		var couponSeq = $("#couponSeq").val();
		location.href = "/admin/item/coupon/limit/list/del/proc/"+seq+"?couponSeq="+couponSeq;
	};

	var veiwModal = function(seq){
		$("#limitItemListModal").modal('show');
		$("#deletelimitItemSeq").val(seq);
	};

	var veiwModal2 = function(){
		$("#limitItemListModal2").modal('show');
		$("#deletelimitItemSeq2").val($("#deletelimitItemSeq").val());
	};

	var getPlanItemtList = function(pageNum, callback){
		if($("select[name=lv1]").val() != "" || $("select[name=lv2]").val() != "" || $("select[name=lv3]").val() != "" || $("#searchItemSeq").val() != "" || $("#searchItemName").val() != ""){
			$.ajax({
				type:"GET",
				url:"/admin/event/item/edit/itemlist",
				dataType:"text",
				data:{lv1:$("select[name=lv1]").val(),lv2:$("select[name=lv2]").val(),lv3:$("select[name=lv3]").val(),seq:$("#searchItemSeq").val(),name:$("#searchItemName").val(),pageNum:pageNum},
				success:function(data) {
					var list = $.parseJSON(data);
					if(list.length != 0){
						$("#categoryTarget").html( $("#categoryTrTemplate").tmpl(list));
					} else {
						$("#categoryTarget").html("<tr><td class='text-center' colspan='4'>无撰写内容</td></tr>");
					}
					if(typeof callback === "function") {
						callback();
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
	};

	var getPlanItemListPaging = function(pageNum){
		if($("select[name=lv1]").val() != "" || $("select[name=lv2]").val() != "" || $("select[name=lv3]").val() != "" || $("#searchItemSeq").val() != "" || $("#searchItemName").val() != ""){
			$.ajax({
				type:"GET",
				url:"/admin/event/item/edit/itemlist/paging",
				dataType:"text",
				data:{lv1:$("select[name=lv1]").val(),lv2:$("select[name=lv2]").val(),lv3:$("select[name=lv3]").val(),seq:$("#searchItemSeq").val(),name:$("#searchItemName").val(),pageNum:pageNum},
				success:function(data) {
					$("#categoryPaging").html(data);
					$("#categoryPaging").addClass("pagination").addClass("alternate");
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
	};

	var goPage = function (page) {
		getPlanItemtList(page, (function(){
			getPlanItemListPaging(page);
		})());

	};
$(document).ready(function(){
	$(".numeric").css("ime-mode", "disabled").numeric();
	$(".datepicker").datepicker({
		dateFormat:"yymmdd"
	});
	getLimitItemList(0);
	getLimitItemListPaging(0);
	getPlanItemtList(0, (function(){
		getPlanItemListPaging(0);
	})());
});
</script>
</body>
</html>