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
		<h1>상품 리스트 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>상품 관리</li>
			<li class="active">상품 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<!--검색 영역-->
				<%@ include file="/WEB-INF/jsp/admin/include/item_search_form.jsp" %>
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<div class="text-right" style="margin-bottom:5px;">
							<b>■판매상태</b>
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
								<button type="button" onclick="EBbatch.show({'method':'가승인으로 일괄변경 처리','action':'update', 'statusCode':'H'})" class="btn btn-xs btn-default">가승인</button>
								<button type="button" onclick="EBbatch.show({'method':'판매중으로 일괄변경 처리','action':'update', 'statusCode':'Y'})" class="btn btn-xs btn-info">판매중</button>
							</c:if>
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2) or sessionScope.loginType eq 'S'}">
								<button type="button" onclick="EBbatch.show({'method':'판매중지로 일괄변경 처리','action':'update', 'statusCode':'N'})" class="btn btn-xs btn-warning">판매중지</button>
								<button type="button" onclick="EBbatch.show({'method':'품절로 일괄변경 처리','action':'update', 'statusCode':'S'})" class="btn btn-xs btn-warning">품 절</button>
								<c:if test="${sessionScope.loginType eq 'A'}">
									<button type="button" onclick="EBbatch.show({'method':'일괄 삭제 처리','action':'delete'})" class="btn btn-xs btn-danger">삭 제</button>
								</c:if>
								<b style="margin-left:25px">■카테고리</b>
								<button type="button" onclick="EBbatch.showCategoryModal({'method':'카테고리 일괄변경 처리','action':'category'})" class="btn btn-xs btn-default">일괄 변경</button>
								<b style="margin-left:25px">■상품내용</b>
								<!--button type="button" onclick="EBbatch.showContentModal({'method':'상품내용 일괄변경 처리','action':'content'})" class="btn btn-xs btn-default">일괄 변경</button-->
							</c:if>
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
								<button type="button" onclick="EBbatch.showDupliModal({'method':'상품 일괄 복사하기','action':'dupli'})" class="btn btn-xs btn-default">일괄 복사하기</button>
							</c:if>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:2%"/>
								<col style="width:10%"/>
								<col style="width:6%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:12%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>

							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" onclick="checkProc(this)" /></th>
									<th>카테고리</th>
									<th><div class="text-primary">이미지</div></th>
									<th>상품코드</th>
									<th>관리코드</th>
									<th>
										<div class="text-primary">상품명</div>
									</th>
									<th>규격</th>
									<th>단위</th>
									<th>제조사</th>
									<th>
										<a href="#" onclick="searchOrderBy('A.status_code','${vo.orderByType}'); return false;">판매상태</a>
										<c:if test="${vo.orderByType eq 'ASC' or vo.orderByType eq 'DESC'}">
											<span class="text-warning"><i class="fa fa-caret-${vo.orderByType eq 'ASC' ? "up":"down"}"></i></span>
										</c:if>
									</th>
									<th>상품원가</th>
									<th><div class="text-primary">최저가</div></th>
									<c:if test="${sessionScope.loginType eq 'S'}">
										<th><div class="text-primary">공급가</div></th>
									</c:if>
								</tr>
							</thead>
							<tbody id="itemList">
							<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
								<tr>
									<td class="text-center">
										<input type="checkbox" name="seq" value="${item.seq}" data-status-code-value="${item.statusCode}">
									</td>

									<td>
									<c:if test="${item.cateLv1Seq ne null}">
										<i class="fa fa-caret-right"></i> ${item.cateLv1Name}
									</c:if>
									<c:if test="${item.cateLv2Seq ne null}">
										<div><i class="fa fa-caret-right"></i> ${item.cateLv2Name}</div>
									</c:if>
									<c:if test="${item.cateLv3Seq ne null}">
										<div><i class="fa fa-caret-right"></i> ${item.cateLv3Name}</div>
									</c:if>
									<c:if test="${item.cateLv4Seq ne null}">
										<div><i class="fa fa-caret-right"></i> ${item.cateLv4Name}</div>
									</c:if>
									</td>
									<td class="text-center">
										<c:if test="${item.img1 ne ''}">
											<img src="/upload${fn:replace(item.img1, 'origin', 's60')}" alt="" style="width:60px;height:60px" />
										</c:if>
									</td>
									<td class="text-center">
										${item.seq}
									</td>
									<td class="text-center">${item.managedCode}</td>
									<td>
										<div class="text-primary">
											<strong>
												<a href="#" onclick="location.href='view/${item.seq}?search='+encodeURIComponent($('#searchForm').serialize());return false;">${item.name}</a>
											</strong>
										</div>
									</td>
									<td class="text-center">
										<div class="text-warning">${item.type1}</div>
										<div class="text-warning">${item.type2}</div>
										<div class="text-warning">${item.type3}</div>
									</td>
									<td class="text-center">
										<div class="text-warning">${item.originCountry}</div>
									</td>
									<td class="text-center">
										<div class="text-warning">${item.maker}</div>
									</td>
									<td class="text-center">
									<c:choose>
										<c:when test="${item.statusCode eq 'Y'}"><strong class="text-primary">${item.statusName}</strong></c:when>
										<c:when test="${item.statusCode eq 'N'}"><strong class="text-danger">${item.statusName}</strong></c:when>
										<c:when test="${item.statusCode eq 'S'}"><strong class="text-danger">${item.statusName}</strong></c:when>
										<c:otherwise><span>${item.statusName}</span></c:otherwise>
									</c:choose>
									</td>
									<td class="text-center"><div class="text-warning">${item.originalPrice}</div></td>
									<td class="text-center">
										<div class="text-warning">${item.sellPrice}</div>
									</td>
									<c:if test="${sessionScope.loginType eq 'S'}">
										<td class="text-center">
											<div class="text-primary"><strong>${item.tempSellPrice}</strong></div>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(list)==0}">
								<tr><td colspan="16" class="text-center muted">등록된 내용이 없습니다</td></tr>
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

<script id="lvTemplate" type="text/html">
	<option value="">분류를 선택해주세요</option>
	{{each list}}
		<option value="<%="${seq}"%>"><%="${name}"%></option>
	{{/each}}
</script>
<script id="batchCategoryTemplate" type="text/html">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title"><%="${method}"%></h3>
		</div>
		<form class="form-horizontal" action="/admin/item/batch/<%="${action}"%>?mallSeq=<%="${mallSeq}"%>" onsubmit="return EBbatch.submitProc(this)" method="post" target="zeroframe">
			<div class="modal-body">
				<p>선택된 <%="${count}"%> 개의 항목을 일괄로 처리합니다</p>
				<div class="form-group">
					<label class="col-md-3 control-label">대분류</label>
					<div class="col-md-9">
						<select class="form-control" id="lv1" name="cateLv1Seq" onchange="EBCategory.renderList(2, $(this).val())">데이터를 불러오고 있습니다</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">중분류</label>
					<div class="col-md-9">
						<select class="form-control" id="lv2" name="cateLv2Seq" onchange="EBCategory.renderList(3, $(this).val())">데이터를 불러오고 있습니다</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">소분류</label>
					<div class="col-md-9">
						<select class="form-control" id="lv3" name="cateLv3Seq" onchange="EBCategory.renderList(4, $(this).val())">데이터를 불러오고 있습니다</select>
					</div>
				</div>
				<div class="form-group" id="updateFormLv4SelectBox">
					<label class="col-md-3 control-label">세분류</label>
					<div class="col-md-9">
						<select class="form-control" id="lv4" name="cateLv4Seq"></select>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-default" href="#">close</a>
				<input type="hidden" name="searchText" value="<%="${searchText}"%>" />
				<button type="submit" class="btn btn-primary">실행</button>
				<div class="hide">{{html content}}</div>
			</div>
		</form>
	</div>
</div>
</script>
<script id="batchContentTemplate" type="text/html">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title"><%="${method}"%></h3>
		</div>
		<form action="/admin/item/batch/<%="${action}"%>?mallSeq=<%="${mallSeq}"%>" onsubmit="return EBbatch.contentSubmitProc(this)" class="form-horizontal" method="post" target="zeroframe">
			<div class="modal-body">
				<p>선택된 <%="${count}"%> 개의 항목을 일괄로 처리합니다</p>
				<div class="form-group">
					<label class="col-md-3 control-label">상품명</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="name" value="${vo.name}" maxlength="90" alt="상품명" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">제조사</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="cgmaker" maxlength="26" alt="제조사" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">브랜드</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="brand" maxlength="45" alt="브랜드" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">모델명</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="modelName" maxlength="45" alt="모델명" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">원산지</label>
					<div class="col-md-9">
						<input class="form-control" type="text" name="originCountry" maxlength="26" alt="원산지" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">제조일자</label>
					<div class="col-md-9">
						<div class="input-group">
							<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							<input class="form-control datepicker" type="text" name="makeDate" maxlength="8" onblur="numberCheck(this);" alt="제조일자" placeholder="- 을 제외하고 입력하세요. ex)20150101"/>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">유효일자</label>
					<div class="col-md-9">
						<div class="input-group">
							<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							<input class="form-control datepicker" type="text" name="expireDate" maxlength="8" onblur="numberCheck(this);"  placeholder="- 을 제외하고 입력하세요. ex)20150101" />
						</div>
					</div>
				</div>
				<div class="form-group" style="display:none">
					<label class="col-md-3 control-label">성인용품</label>
					<div class="radio">
						<label><input type="radio" name="adultFlag" value="N" alt="성인용품"/> 가능</label>
						<label><input type="radio" name="adultFlag" value="Y" alt="성인용품"/> 불가능</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">부가세 </label>
					<div class="radio">
						<label><input id="tax" type="radio" name="taxCode" value="1" />과세</label>
						<label><input id="duty" type="radio" name="taxCode" value="2" />면세</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">A/S 가능여부</label>
					<div class="radio">
						<label><input type="radio" name="asFlag" value="Y" alt="A/S가능여부"/> 가능</label>
						<label><input type="radio" name="asFlag" value="N" alt="A/S가능여부"/> 불가능</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">A/S 전화번호</label>
					<div class="col-md-7">
						<div class="input-group">
							<input class="form-control" type="text" name="asTel1" maxlength="4" onblur="numberCheck(this);"/>
							<div class="input-group-addon" style="border:0">-</div>
							<input class="form-control" type="text" name="asTel2" maxlength="4" onblur="numberCheck(this);"/>
							<div class="input-group-addon" style="border:0">-</div>
							<input class="form-control" type="text" name="asTel3" maxlength="4" onblur="numberCheck(this);"/>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">판매가</label>
					<div class="col-md-5">
						<div class="input-group">
							<input class="form-control text-right" type="text" name="sellPrice" maxlength="10" onblur="numberCheck(this);" alt="판매가" />
							<div class="input-group-addon">원</div>
						</div>
					</div>
				</div>
				<div class="form-group" style="display:none">
					<label class="col-md-3 control-label">공급가</label>
					<div class="col-md-5">
						<div class="input-group">
							<input class="form-control text-right" type="text" name="supplyPrice" maxlength="10" onblur="numberCheck(this);" alt="공급가" />
							<div class="input-group-addon">원</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">시중가</label>
					<div class="col-md-5">
						<div class="input-group">
							<input class="form-control text-right" type="text" name="marketPrice" maxlength="10" onblur="numberCheck(this);" alt="시중가" />
							<div class="input-group-addon">원</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">배송비 구분</label>
					<div class="radio">
						<label><input type="radio" name="deliTypeCode" value="00" onclick="deliTypeCodeChange()"  alt="배송비구분"/> 무료</label>
						<label><input type="radio" name="deliTypeCode" value="10" onclick="deliTypeCodeChange()"  alt="배송비구분"/> 유료</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">배송비</label>
					<div class="col-md-5">
						<div class="input-group">
							<input class="form-control text-right" type="text" name="deliCost" maxlength="10" onblur="numberCheck(this);"/>
							<div class="input-group-addon">원</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">무료배송 조건금액</label>
					<div class="col-md-5">
						<div class="input-group">
							<input class="form-control text-right" type="text" name="deliFreeAmount" maxlength="10" onblur="numberCheck(this);"/>
							<div class="input-group-addon">원</div>
						</div>
					</div>
					<div class="col-md-4 form-control-static">이상 주문시 무료 배송</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">선결제 여부</label>
					<div class="col-md-5">
						<select class="form-control" id="deliPrepaidFlag" name="deliPrepaidFlag">
							<option value="">--- 선택 ---</option>
							<option value="YN">선결제/착불 선택가능</option>
							<option value="Y">선결제 필수</option>
							<option value="N">선결제 불가</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">묶음배송 여부</label>
					<div class="radio">
						<label><input type="radio" name="deliPackageFlag" value="Y" alt="묶음배송 여부"/> 가능</label>
						<label><input type="radio" name="deliPackageFlag" value="N" alt="묶음배송 여부"/> 불가능</label>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-default" href="#">close</a>
				<input type="hidden" name="searchText" value="<%="${searchText}"%>" />
				<button type="submit" class="btn btn-primary">실행</button>
				<div class="hide">{{html content}}</div>
			</div>
		</form>
	</div>
</div>
</script>
<script id="batchTemplate" type="text/html">
<form action="/admin/item/batch/<%="${action}"%>" onsubmit="return EBbatch.submitProc(this)" method="post" target="zeroframe">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<h4><%="${method}"%> 하시겠습니까?</h4>
			<p>선택된 <%="${count}"%> 개의 항목을 일괄로 처리합니다</p>
		</div>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn" href="#">close</a>
			<input type="hidden" name="searchText" value="<%="${searchText}"%>" />
			<input type="hidden" name="statusCode" value="<%="${statusCode}"%>" />
			<button type="submit" class="btn btn-primary">실행</button>
			<div class="hide">{{html content}}</div>
		</div>
	</div>
</div>
</form>
</script>
<div id="batchModal" class="modal fade"></div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>
<script type="text/javascript" src="/assets/js/libs/moment.js"></script>
<script type="text/javascript" src="/assets/js/Application.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		showDatepicker("yy-mm-dd");
	});

	//미리보기 & Resize 툴팁
	$("[data-toggle='tooltip']").tooltip();

	var checkProc = function(obj) {
		$("#itemList input:checkbox").each(function(){
			$(this).prop("checked", $(obj).prop("checked"));
		});
	};

	var calcDate = function(val) {
		if(val === "clear") {
			$("input[name=searchDate1]").val( '2014-01-01' );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};

	var EBbatch = {
		show:function(json){
			json.searchText = $("#searchForm").serialize();
			json.count = $("#itemList input:checkbox:checked").length;
			json.delErrorCount = 0;
			json.updateErrorCount = 0;
			json.content = (function(){
				var html = "";
				$("#itemList input:checkbox:checked").each(function(){
					html += "<input type='hidden' name='procSeq' value='" + $(this).val() + "' />";

					//관리자(어드민)가 가승인을 한 상품에 대해서는 협력사가 삭제할 수 없다
					if(json.action === 'delete' && "${sessionScope.loginType}" === 'S' && ($(this).attr('data-status-code-value') === 'H' || $(this).attr('data-status-code-value') === 'Y' || $(this).attr('data-status-code-value') === 'E')) {
						json.delErrorCount += 1;
					}
				});
				return html;
			})();

			if(json.count === 0) {
				alert("선택된 항목이 하나도 없습니다");
				return;
			}
			if(json.delErrorCount > 0) {
				alert('가승인,판매중 상태의 제품은 삭제 할 수 없습니다.');
				return;
			}
			$("#batchModal").modal().html( $("#batchTemplate").tmpl(json) );
		}
		, showCategoryModal:function(json) {
			json.searchText = $("#searchForm").serialize();
			json.count = $("#itemList input:checkbox:checked").length;
			json.content = (function(){
				var html = "";
				$("#itemList input:checkbox:checked").each(function(){
					html += "<input type='hidden' name='procSeq' value='" + $(this).val() + "' />";
				});
				return html;
			})();
			if(json.count === 0) {
				alert("선택된 항목이 하나도 없습니다");
				return;
			}
			EBCategory.renderList(1,0);
			$("#batchModal").modal().html( $("#batchCategoryTemplate").tmpl(json) );
		}
		, showDupliModal:function(json) {
			json.searchText = $("#searchForm").serialize();
			json.count = $("#itemList input:checkbox:checked").length;
			json.content = (function(){
				var html = "";
				$("#itemList input:checkbox:checked").each(function(){
					html += "<input type='hidden' name='procSeq' value='" + $(this).val() + "' />";
				});
				return html;
			})();
			if(json.count === 0) {
				alert("선택된 항목이 하나도 없습니다");
				return;
			}
			EBCategory.renderList(1,0);
			$("#batchModal").modal().html( $("#batchCategoryTemplate").tmpl(json) );
		}
		, showContentModal:function(json) {
			json.searchText = $("#searchForm").serialize();
			json.count = $("#itemList input:checkbox:checked").length;
			json.content = (function(){
				var html = "";
				$("#itemList input:checkbox:checked").each(function(){
					html += "<input type='hidden' name='procSeq' value='" + $(this).val() + "' />";
				});
				return html;
			})();
			if(json.count === 0) {
				alert("선택된 항목이 하나도 없습니다");
				return;
			}

			$("#batchModal").modal().html( $("#batchContentTemplate").tmpl(json) );
//			deliTypeCodeChange();
		}
		, submitProc:function(obj) {
			// 중복 클릭 방지
			$(obj).find("button").prop("disabled", true);
			return true;
		}
		, contentSubmitProc:function(obj) {
			var marketPrice = parseInt(obj.marketPrice.value, 10) || 0;
			var sellPrice = parseInt(obj.sellPrice.value, 10) || 0;
			if(marketPrice > 0 && marketPrice < sellPrice) {
				alert('시중가는 판매가보다 작을 수 없습니다.');
				$('input[name=marketPrice]').focus();
				return false;
			}

			if($(obj).find("input[name='deliTypeCode']:checked").val() == '10' && obj.deliCost.value == 0){
				alert('유료배송 일 때 배송비는 반드시 입력하여야 합니다.');
				$('input[name=deliCost]').focus();
				return false;
			}

			//값을 입력하지 않은 항목은 disable 시켜 전송하지 않는다.
			$(obj).find("input, select").each( function() {
				if( $.trim($(this).val()) == "" ) {
					$(this).attr("disabled", true);
				}
			});

			if(!confirm("일괄 수정하시겠습니까?")) {
				$(obj).find("input, select").attr("disabled", false);
				return false;
			}

			// 중복 클릭 방지
			$(obj).find("button").prop("disabled", true);
			setTimeout(function(){
				$(obj).find("button").prop("disabled", false);
			}, 2000);

			return true;
		}
	};

	/**
	 * 카테고리와 관련된 모든 업무를 담당함
	 * @type {{renderList: Function}}
	 */
	var EBCategory = {
		/** 카테고리를 그림 */
		renderList: function(depth, parentSeq) {
			// 로딩 메시지
			$("#lv"+depth).html("<option value=''></option>");

			var parseParentSeq = parseInt(parentSeq, 10) || 0;
			$.ajax({
				url:"/admin/category/list/ajax",
				type:"get",
				data:{depth:depth, parentSeq:parseParentSeq,mallId:${mallSeq}},
				dataType:"text",
				success:function(data) {
					var list = $.parseJSON(data);
					// 단계를 표시한다
					var categoryList = {list:[]};
					categoryList.list = list;
					$("#lv"+depth).html($("#lvTemplate").tmpl(categoryList));
						
					// 다음 단계를 초기화한다
					$("[id^=lv]").each(function(){
						if( parseInt($(this).attr("id").replace(/lv/, ""),10) > depth ) {
							$(this).html( '<option value="">분류를 선택해주세요</option>' );
						}
					});

				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
	};
	 
	var CHExcelDownload = {
		excelDownCheck:function() {

			CHExcelDownload.excelDownAjax();
		}
		, excelDownAjax:function() {
			//ajax:엑셀다운로드 유효성 체크
			$.ajax({
				type: 'GET',
				data: $("#searchForm").serialize(),
				dataType: 'json',
				url: '/admin/item/list/download/excel/check',
				success: function(data) {
					if(data.result === "true") {
						if(data.message !== '') {
							alert(data.message);
						}
						else {
							alert("파일을 다운로드 합니다.....");
						}
	
						CHExcelDownload.downloadExcel('Y');
					} else {
						alert(data.message);
						CHExcelDownload.downloadExcel('N');
					}
				}
			});
		}
		, downloadExcel:function(validflag) {
			if(validflag === 'N') {
				return;
			}
	
			$("#searchForm").attr("action", "/admin/item/list/download/excel?mallSeq=${mallSeq}");
			$("#searchForm").submit();
			$("#searchForm").attr("action",location.pathname);
		}
	};


	var deliTypeCodeChange = function(){
		if($('input[name=deliTypeCode]:checked').val() === '00'){
			$('input[name=deliCost]').val(0);
			$('input[name=deliFreeAmount]').val(0);
			$('select[name=deliPrepaidFlag] option:eq(0)').prop('selected',true);

			$('input[name=deliCost]').prop('disabled',true);
			$('input[name=deliFreeAmount]').prop('disabled',true);
			$('select[name=deliPrepaidFlag]').prop('disabled',true);
		} else if($('input[name=deliTypeCode]:checked').val() === '10'){
			$('input[name=deliCost]').prop('disabled',false);
			$('input[name=deliFreeAmount]').prop('disabled',false);
			$('select[name=deliPrepaidFlag]').prop('disabled',false);
		}
	};
	
	var search = function(obj) {
		obj.pageNum.value = "0";	
		obj.orderByName.value = "";
		obj.orderByType.value = "";
	};
	
	var goPage = function (page) {
		$("#pageNum").val(page);
		location.href = location.pathname + "?" + $("#searchForm").serialize()+"&mallSeq=${mallSeq}";
	};
	
	var searchOrderBy = function(orderByName, orderByType) {
		$("#orderByName").val(orderByName);
		if(orderByType == "ASC") {
			$("#orderByType").val("DESC");
		} else if(orderByType == "DESC") {
			$("#orderByType").val("ASC");
		} else {
			$("#orderByType").val("ASC");
		} 
		
		location.href = location.pathname + "?" + $("#searchForm").serialize()+"&mallSeq=${mallSeq}";
	};
</script>
</body>
</html>
