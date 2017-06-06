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
		<h1>기획전 상품 등록/수정 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>상품 관리</li>
			<li>기획전/이벤트 관리</li>
			<li class="active">기획전 상품 등록/수정</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">${planTitle}</h3>
						<div class="="pull-center">
							<select alt="몰 리스트" id="mallList" onchange="CHPlan.mallSelect(this)">
								<c:forEach var="item" items="${mallList}">
									<option value="${item.seq}" ${mallSeq eq item.seq  ? "selected" : ""}>${item.name}</option>
								</c:forEach>
							</select>
							<select alt="기획전 리스트" id="planList" style="margin-left:5px" onchange="CHPlan.planSelect(this)">
								<option value="0">-- 기획전 선택 --</option>
							</select>
						</div>
						<div class="pull-right">
							<button class="btn btn-sm btn-default" onClick="goCancel()">목록</button>
							<div onclick="viewInsertItemModal()" role="button" class="btn btn-sm" data-toggle="modal"><i class="fa fa-plus"></i></div>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
					<c:forEach var="item" items="${titleListVo}" varStatus="status">
						<form action="/admin/event/item/title/edit/proc" method="post" target="zeroframe" class="form-horizontal">
							<input type="hidden" id="eventGroupSeq" name="eventGroupSeq" value="${ item.eventGroupSeq }"/>
							<input type="hidden" id="eventSeq" name="eventSeq" value="${ item.eventSeq }"/>
							<input type="hidden" id="seq" name="seq" value="${ seq }"/>
							<input type="hidden" name="mallSeq" value="${mallSeq}"/>
							<%-- 상품 검색을 한뒤 상품추가를 했을경우 검색된 상품 검색 테이블을 유지하기 위한 데이터를 같이 보냄 --%>
							<input type="hidden" name="titleModLv1" id="titleModLv1" value="${vo.cateLv1Seq}"/>
							<input type="hidden" name="titleModLv2" id="titleModLv2" value="${vo.cateLv2Seq}"/>
							<input type="hidden" name="titleModLv3" id="titleModLv3" value="${vo.cateLv3Seq}"/>
							<input type="hidden" name="titleModItemName" id="titleModItemName" value="${vo.name}"/>
							<input type="hidden" name="titleModItemSeq" id="titleModItemSeq" value="${vo.seq}"/>

							<div class="form-group">
								<label class="col-md-1 control-label">상품군 ${status.index+1}</label>
								<div class="col-md-3">
									<input type="text" class="form-control" placeholder="제목을 입력해주세요" name="groupName" id="groupName" value="${ item.groupName }" maxlength="60"/>
								</div>
								<label class="col-md-1 control-label">정렬순서</label>
								<div class="col-md-3">
									<input type="text" class="form-control" placeholder="정렬순서를 입력해주세요" name="orderNo" id="orderNo" onblur="numberCheck(this);" value="${ item.orderNo }" maxlength="3"/>
								</div>
								<div class="col-md-2">
									<button type="submit" id="" class="btn btn-primary">수정</button>
								</div>
								<div class="col-md-2 text-right">
									<button type="button" onclick="viewTitleModal('${item.eventGroupSeq}')" class="btn btn-sm btn-default" data-toggle="modal"><i class="fa fa-fw fa-remove"></i></button>
								</div>
							</div>
						</form>

						<form action="/admin/event/item/orderno/edit/proc" method="post" target="zeroframe" onsubmit="return submitProc(this);">
							<input type="hidden" name="seq" value="${seq}"/>
							<input type="hidden" name="mallSeq" value="${mallSeq}"/>
							<%-- 상품 검색을 한뒤 상품추가를 했을경우 검색된 상품 검색 테이블을 유지하기 위한 데이터를 같이 보냄 --%>
							<input type="hidden" name="orderModLv1" id="orderModLv1" value="${vo.cateLv1Seq}"/>
							<input type="hidden" name="orderModLv2" id="orderModLv2" value="${vo.cateLv2Seq}"/>
							<input type="hidden" name="orderModLv3" id="orderModLv3" value="${vo.cateLv3Seq}"/>
							<input type="hidden" name="orderModItemName" id="orderModItemName" value="${vo.name}"/>
							<input type="hidden" name="orderModItemSeq" id="orderModItemSeq" value="${vo.seq}"/>
						<div class="text-right">
							<button type="submit" class="btn btn-sm btn-primary">정렬순서 저장</button>
							<button type="button" class="btn btn-sm btn-danger" onclick="EBbatch.show({'method':'삭제','action':'delete','orderNum':'${ item.orderNo }'})">삭제</button>
						</div>
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th><input type="checkbox" id="itemCheckBox" onclick="itemCheckProc(this, ${ item.orderNo })" /></th>
									<th>상품번호</th>
									<th>정렬순서</th>
									<th>상품명</th>
									<th>규격</th>
									<th>단위</th>
									<th>가격</th>
									<th>상태</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="itemBoard${ item.orderNo }">
							<c:forEach var="item2" items="${itemListVo}">
								<c:if test="${ item.eventGroupSeq eq item2.groupSeq }">
								<tr>
									<td class="text-center"><input type="checkbox" name="eventItemSeq" value="${item2.eventItemSeq}"></td>
									<td class="text-center">
										${item2.itemSeq}
										<input type="hidden" name="itemSeq" value="${item2.itemSeq}"/>
										<input type="hidden" name="groupSeq" value="${ item2.groupSeq }"/>
									</td>
									<td class="text-center"><input type="text" name="orderNo" value="${item2.itemOrderNo}" onblur="numberCheck(this);" style="margin-top:7px; width:50px; text-align:center;" maxlength="3" /></td>
									<td>${item2.itemName}</td>
									<td>${item2.type1}
										<c:if test="${item2.type2 ne ''}">, ${item2.type2}</c:if>
										<c:if test="${item2.type3 ne ''}">, ${item2.type3}</c:if>
									</td>
									<td>${item2.originCountry}</td>
									<td class="text-center"><fmt:formatNumber value="${item2.sellPrice}" pattern="#,###" />원</td>
									<td class="text-center">${item2.statusFlag}</td>
									<td class="text-center">
										<div onclick="veiwModal('${item2.eventItemSeq}')" role="button" class="btn" data-toggle="modal"><i class="fa fa-times"></i></div>
										<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top:-10px;">×</button>
													</div>
													<div class="modal-body">
														<p>삭제 하시겠습니까?</p>
														<input type="hidden" id="deleteSeq"/>
													</div>
													<div class="modal-footer">
														<div onclick="goDeleteItemList('${ seq }')" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">확인</div>
														<button class="btn" data-dismiss="modal" aria-hidden="true">취소</button>
													</div>
												</div>
											</div>
										</div>
									</td>
								</tr>
								</c:if>
							</c:forEach>
							</tbody>
						</table>
						</form>
					</c:forEach>
					</div>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border"><h3 class="box-title">${itemTitle }</h3></div>
					<!--검색 영역-->
				<c:if test="${fn:length(titleListVo) ne 0}">
					<form id="searchForm" method="get" class="form-horizontal">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">카테고리</label>
								<div class="col-md-2">
									<select class="form-control" name="lv1" id="lv1" onchange="CHCategory.renderList(this, 2)">
										<option value="">-카테고리 선택-</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" name="lv2" id="lv2" onchange="CHCategory.renderList(this, 3)">
										<option value="">-카테고리 선택-</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" name="lv3" id="lv3" onchange="CHCategory.renderList(this, 4)">
										<option value="">-카테고리 선택-</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" name="lv4" id="lv4" style="display:none">
										<option value="">-카테고리 선택-</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상품명</label>
								<div class="col-md-2">
									<input type="text" class="form-control" name="name" id="searchItemName"/>
								</div>
								<label class="col-md-2 control-label">상품코드</label>
								<div class="col-md-2">
									<input type="text" class="form-control" name="searchItemSeq" id="searchItemSeq" onblur="numberCheck(this);"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">입점업체명</label>
								<div class="col-md-2">
									<input type="text" class="form-control" name="sellerName" id="sellerName"/>
								</div>
								<label class="col-md-2 control-label">한페이지출력수</label>
								<div class="col-md-2">
									<select class="form-control" name="rowCount" id="rowCount">
										<option value="20">20개씩 보기</option>
										<option value="40">40개씩 보기</option>
										<option value="60">60개씩 보기</option>
									</select>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <strong style="color:#00acd6;" id="totalRowCount">0</strong> 건이 조회 되었습니다.</div>
							<div class="pull-right">
									상품군 선택 :
									<select id="selectGroupSeq"  style="width:100px;height:30px;">
										<option>--선택--</option>
										<c:forEach var="item" items="${titleListVo}" varStatus="status">
											<option value="${item.eventGroupSeq}">${item.groupName}</option>
										</c:forEach>
									</select>
									<button type="button" onclick="batchShow({'method':'등록','action':'reg', 'statusCode':'Y', 'cateSeq':0})" class="btn btn-sm btn-success">상품등록</button>&nbsp;
									<button type="button" class="btn btn-sm btn-default" onclick="goPage(0)">검색하기</button>
								</div>
						</div>
					</form>
					</c:if>
				</div>
				<div class="box">
					<!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th><input type="checkbox" id="allCheckBox" onclick="checkProc(this)" /></th>
									<th>카테고리</th>
									<th>이미지</th>
									<th>상품가격</th>
									<th>상품코드</th>
									<th>상품명</th>
									<th>규격</th>
									<th>단위</th>
								</tr>
							</thead>
							<tbody id="boardTarget">
									<td colspan="10" class="text-center">등록된 내용이 없습니다.</td>
							</tbody>
						</table>
						<div id="paging" style="text-align:center"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="planTemplate" type="text/html">
	<option value="0">--기획전 선택--</option>
	{{each planList}}
	<option value="<%="${seq}"%>"><%="${title}"%></option>
	{{/each}}
</script>

<script id="categoryTemplate" type="text/html">
	<option value="">-카테고리 선택-</option>
	{{each value}}
	<option value="<%="${seq}"%>"><%="${name}"%>{{if showFlag==='N'}}[노출안함]{{/if}}</option>
	{{/each}}
</script>

<div id="myTitleModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			</div>
			<div class="modal-body">
				<p>정말 삭제 하시겠습니까?</p>
				<input type="hidden" id="deleteTitleSeq"/>
			</div>
			<div class="modal-footer">
				<div onclick="goDeleteItemTitle(${ seq })" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">확인</div>
				<button class="btn btn-default" data-dismiss="modal" aria-hidden="true">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 상품군이 하나라도 등록이 되어 있을시  -->
<div id="myInsertItemModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding:1px 15px; background-color:#367FA9; color:#fff">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 style="margin-top:15px;">상품군 추가</h3>
			</div>

			<div class="modal-body">
				<form method="post" class="form-horizontal">
					<div class="form-group">
						<label class="col-md-3 control-label">상품군 제목</label>
						<div class="col-md-9">
							<input type="text" placeholder="제목을 입력해주세요" name="insertGroupName" class="form-control insertGroupName" alt="상품군 제목" maxlength="60"/>
						</div>
					</div>
				</form>
			</div>

			<div class="modal-footer">
				<div class="btn btn-primary" onClick="InsertItem(${ seq })">등록</div>
				<button class="btn" data-dismiss="modal" aria-hidden="true">취소</button>
			</div>
		</div>
	</div>
</div>

<c:if test="${fn:length(titleListVo) eq 0}">
<div style="text-align:center;">
	<%--<button class="btn btn-large" onClick="goCancel()">목록</button>--%>
	<!-- 상품군이 없을 시 -->
	<%--<div onclick="viewInsertItemModal()" role="button" class="btn btn-large" data-toggle="modal"><i class="fa fa-plus"></i></div>--%>

	<div id="myInsertItemModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="padding:1px 15px; background-color:#367FA9; color:#fff">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 style="margin-top:15px;">상품군 추가</h3>
				</div>

				<div class="modal-body">
					<form method="post" class="form-horizontal">
						<div class="form-group">
							<label class="col-md-3 control-label">상품군 제목</label>
							<div class="col-md-9">
								<input type="text" placeholder="제목을 입력해주세요" name="insertGroupName" class="form-control insertGroupName" alt="상품군 제목" maxlength="60"/>
							</div>
						</div>
					</form>
				</div>

				<div class="modal-footer">
					<button class="btn btn-primary" onClick="InsertItem(${ seq })">등록</button>
					<button class="btn" data-dismiss="modal" aria-hidden="true">취소</button>
				</div>
			</div>
		</div>
	</div><br/><br/>
	<%--<span style="font-size:12px;color:red">상품군이 등록되어 있지 않습니다.&nbsp;+&nbsp;버튼을 클릭하여 상품군을 등록하세요.</span>--%>
</div>
</c:if>
<script id="trTemplate" type="text/html">
	<tr>
		<td style="width:5%" class="text-center">
			<input type="checkbox" name="seq" value="<%="${seq}"%>">
		</td>
		<td style="width:20%" class="text-center">
			<%="${cateLv1Name}"%> &gt;
			<%="${cateLv2Name}"%> &gt;
			<%="${cateLv3Name}"%>
			{{if cateLv4Name !== ""}}
			&gt; <%="${cateLv4Name}"%>
			{{/if}}
		</td>
		<td style="width:10%" class="text-center">
			<img src="<%="${img1}"%>" alt="" style="width:60px;height:60px" />
		</td>
		<td style="width:10%" class="text-center">
			<%="${sellPrice}"%>원
		</td>
		<td style="width:5%" class="text-center">
			<p><%="${seq}"%>
			</p>
			<%--<a href="/shop/detail/<%="${seq}"%>" target="_blank" class="btn btn-mini"--%>
			   <%--data-toggle="tooltip" title="미리보기"><i class="icon-search"></i></a>--%>
		</td>
		<td style="width:20%">
			<p><%="${name}"%>
			</p>
		</td>
		<td style="width:20%">
			<p><%="${type1}"%>
				{{if type2 !== ""}}, <%="${type2}"%>{{/if}}
				{{if type3 !== ""}}, <%="${type3}"%>{{/if}}
			</p>
		</td>
		<td style="width:10%" class="text-center">
			<p><%="${originCountry}"%>
			</p>
		</td>
	</tr>
</script>
<script id="delTemplate" type="text/html">
<form action="/admin/event/del/batch/proc" onsubmit="return EBbatch.submitProc(this)" method="post" target="zeroframe">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<h4>정말로 <%="${method}"%> 하시겠습니까?</h4>
			<p>선택된 <%="${count}"%> 개의 항목을 일괄로 처리합니다</p>
		</div>
		<input type="hidden" name="rSeq" value=<%="${seq}"%>>
		<input type="hidden" name="mallSeq" value=<%="${mallSeq}"%>>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn btn-default" href="#">close</a>
			<button type="submit" class="btn btn-primary">실행</button>
			<div class="hide">{{html content}}</div>
		</div>
	</div>
</div>
</form>
</script>
<div id="delModal" class="modal"></div>
<div id="batchModal" class="modal"></div>

<input type="hidden" id="tempDisplaySeq"/>
<input type="hidden" id="tempMallSeq"/>
<input type="hidden" id="tempStyleCode"/>
<input type="hidden" id="tempCateSeq"/>

<script id="batchTemplate" type="text/html">
<form action="/admin/event/item/write/proc" onsubmit="return batchSubmitProc(this)" method="post" target="zeroframe">
<div class="modal-dialog">
	<div class="modal-content">
		<input type="hidden" name="eventGroupSeq" value="<%="${eventGroupSeq}"%>"/>
		<input type="hidden" name="seq" value="<%="${seq}"%>"/>
		<input type="hidden" name="mallSeq" value="<%="${mallSeq}"%>"/>

		<div class="modal-body">
			<h4>정말로 <%="${method}"%> 하시겠습니까?</h4>
			<p>선택된 <%="${count}"%> 개의 항목을 일괄로 처리합니다</p>
		</div>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn" href="#">취소</a>
			<button type="submit" class="btn btn-primary">등록</button>
			<div class="hide">{{html content}}</div>
		</div>
	</div>
</div>
</form>
</script>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript">
	var mallSeq = "${mallSeq}";
	var seq = "${seq}";

	var goCancel = function(){
		$("#flag").val("N");
		location.href = "/admin/event/list?mallSeq=mallSeq";

	};
	var submitProc = function(obj) {
		var flag = true;

		//상품리스트에 상품이 하나도 존재하지 않을 때
		if(typeof $(obj).find('input[name=orderNo]').val() === 'undefined'){
			alert('상품을 한개 이상 추가해주세요.');
			return false;
		}

		$(obj).find("input[alt]").each( function() {
			if(flag && $(this).val() == "") {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});
		return flag;
	};

	//상품 체크박스
	var checkProc = function(obj) {
		$("#boardTarget input:checkbox").each(function(){
			$(this).prop("checked", $(obj).prop("checked"));
		});
	};

	//상품 체크박스
	var itemCheckProc = function(obj, orderNum) {
		$("#itemBoard"+orderNum+" input:checkbox").each(function(){
			$(this).prop("checked", $(obj).prop("checked"));
		});
	};

	var EBbatch = {
		show: function (json) {
			json.count = $("#itemBoard" + json.orderNum + " input:checkbox:checked").length;
			json.delErrorCount = 0;
			json.content = (function () {
				var html = "";
				$("#itemBoard" + json.orderNum + " input:checkbox:checked").each(function () {
					html += "<input type='hidden' name='seq' value='" + $(this).val() + "' />";

					//관리자(어드민)가 가승인을 한 상품에 대해서는 협력사가 삭제할 수 없다
					if (json.action === 'delete') {
						json.delErrorCount += 1;
					}
				});
				return html;
			});

			if (json.count === 0) {
				alert("선택된 항목이 하나도 없습니다");
				return;
			}
			$("#delModal").modal().html($("#delTemplate").tmpl(json));
		}
		, submitProc:function(obj) {
			// 중복 클릭 방지
			$(obj).find("button").prop("disabled", true);
			return true;
		}
	}

	var batchShow = function(json){
		json.count = $("#boardTarget input:checkbox:checked").length;
		json.seq = seq;
		json.eventGroupSeq = parseInt($('#selectGroupSeq option:selected').val(),10) || 0;
		json.mallSeq = mallSeq;
		json.content = (function(){
			var html = "";
			$("#boardTarget input:checkbox:checked").each(function(){
				html += "<input type='hidden' name='procSeq' value='" + $(this).val() + "' />";
			});
			return html;
		})();
		if(json.count === 0) {
			alert("선택된 항목이 하나도 없습니다");
			return;
		} else if(json.eventGroupSeq === 0) {
			alert("상품군을 선택해 주세요");
			return;
		}

		$("#batchModal").modal().html( $("#batchTemplate").tmpl(json) );
	}

	var batchSubmitProc = function(obj) {
		// 중복 클릭 방지
		$(obj).find("button").prop("disabled", true);
		$("#boardTarget input:checkbox:checked").each(function() {
			$(this).attr("checked", false);
		});
		return true;
	};

	var goPage = function (page) {
		var lv1Value = parseInt($('#lv1 option:selected').val(),10) || 0;
		getItemtList(page);
	};

	var callbackProc = function(msg) {
		alert(msg);
		checkProc();
	};


var CHCategory = {
	categoryInit:function(depth) {
		if(depth <= 4){ //여기서 3의 의미는 현재 대,중,소 카테고리 밖에 존재하지 않아 3이다. 만약 추후 세분류가 추가된다면 4로 고쳐주면된다.
			while(depth <= 4){
				$('#lv'+depth).html('<option value="">--카테고리 선택--</option>');
				depth++;
			}
		}
	}
	, initRenderList:function() {
		var paramMallSeq = mallSeq;
		$.ajax({
			url:"/admin/category/list/simple/ajax",
			type:"get",
			data:{depth:1, parentSeq:0, mallSeq:paramMallSeq},
			dataType:"text",
			success:function(data) {
				var valueList = {value:[]};
				var list = $.parseJSON(data);
				valueList.value = list;

				if(list.length === 0){
					//상품검색 대분류 카테고리를 가져온다.
					$('#lv1').html('<option value="0">--카테고리 선택--</option>');
				} else {
					//상품검색 대분류 카테고리를 가져온다.
					$('#lv1').html($("#categoryTemplate").tmpl(valueList));
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, renderList:function(obj, depth) {
		var parentSeq = depth === 1 ? 0 : parseInt($(obj).val(),10) || 0;
		var paramMallSeq = mallSeq;
		//대분류 카테고리를 변경하면 세분류는 무조건 숨긴다.
		if(depth === 2) {
			$('#lv4').hide();
		}

		if((depth === 1 && parentSeq === 0) || (depth > 1 && parentSeq > 0)){
			//상품 검색폼의 카테고리를 불러온다.
			//상시몰 메인페이지 카테고리는 mallSeq를 null로 사용하기로 정책적으로 결정하였기 때문에
			//mallSeq가 null인 카테고리만 가지고온다.(null:상시몰, not null:임시몰)
			//임시몰 메인페이지 관리는 mallSeq가 파라미터로 넘어가야 할것이다.
			$.ajax({
				url:"/admin/category/list/simple/ajax",
				type:"get",
				data:{depth:depth, parentSeq:parentSeq, mallSeq:paramMallSeq},
				dataType:"text",
				success:function(data) {
					var valueList = {value:[]};
					var list = $.parseJSON(data);
					valueList.value = list;

					CHCategory.categoryInit(depth);//상위카테고리 클릭시 하위카테고리를 먼저 초기화 시킨다.

					if(parseInt(depth,10) <= 3) {
						$('#lv'+depth).html(list.length === 0 ? '<option value="">--카테고리 선택--</option>' : $("#categoryTemplate").tmpl(valueList));
					} else if(parseInt(depth,10) === 4) {
						// 세분류가 존재하지않는다면 세분류 SelectBox를 숨긴다.
						if(list.length === 0) {
							$('#lv4').hide();
						} else {
							$('#lv'+depth).html($("#categoryTemplate").tmpl(valueList));
							$('#lv4').show();
						}
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}

		//상위 카테고리가의 값이 없다면 하위 카테고리를 초기화시킨다.
		if((parseInt($(obj).val(),10) || 0)===0){
			CHCategory.categoryInit(depth);
		}
	}
};

var CHPlan = {
	mallSelect:function(obj){
		var mallSeq = $(obj).val();
		if(mallSeq > 0) {
			CHPlan.planRenderList(mallSeq);
		}
	}
	, planSelect:function(obj){
		var planSeq = $(obj).val();
		var mallSeq = $('#mallList option:selected').val();
		if(planSeq > 0) {
			location.href = '/admin/event/item/edit?seq=' + planSeq + '&mallSeq=' + mallSeq;
		}
	}
	, planRenderList:function(mallSeq){
		$.ajax({
			url:"/admin/event/plan/list/ajax",
			type:"get",
			data:{mallSeq:mallSeq},
			dataType:"text",
			success:function(data) {
				var planList = {planList:[]};
				var list = $.parseJSON(data);
				planList.planList = list;
				$('#planList').html($("#planTemplate").tmpl(planList));

				$('#planList').val("${seq}");
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
};

	var viewTitleModal = function(seq){
		$("#myTitleModal").modal('show');
		$("#deleteTitleSeq").val(seq);
	};

	var goDeleteItemTitle = function(seq){
		var redirectSeq = seq;
		var eventItemSeq = $("#deleteTitleSeq").val();
		location.href = "/admin/event/itemtitle/del/proc?seq="+redirectSeq+"&eventGroupSeq="+eventItemSeq+"&delLv1="+$("#insertLv1").val()+"&delLv2="+$("#insertLv2").val()+"&delLv3="+$("#insertLv3").val()+"&delItemSeq="+$("#insertItemSeq").val()+"&delItemName="+$("#insertItemName").val()+"&mallSeq="+mallSeq;
	};

	var veiwModal = function(seq){
		$("#myModal").modal('show');
		$("#deleteSeq").val(seq);
	};

	var goDeleteItemList = function(seq){
		var redirectSeq = seq;
		var eventItemSeq = $("#deleteSeq").val();
		location.href = "/admin/event/item/del/proc?seq="+redirectSeq+"&eventItemSeq="+eventItemSeq+"&delLv1="+$("#insertLv1").val()+"&delLv2="+$("#insertLv2").val()+"&delLv3="+$("#insertLv3").val()+"&delItemSeq="+$("#insertItemSeq").val()+"&delItemName="+$("#insertItemName").val()+"&mallSeq="+mallSeq;
	};

	var viewInsertItemModal = function(){
		$("#myInsertItemModal").modal('show');
	};

	var InsertItem = function(seq){
		var redirectSeq = seq;
		if(mallSeq === 0) {
			alert("쇼핑몰을 선택해 주세요.");
			return;
		} else if($(".insertGroupName").val()===""){
			alert("상품군 제목을 입력해 주세요.");
			return;
		}

		var groupName = $(".insertGroupName").val();

		location.href = "/admin/event/item/title/edit/proc?seq="+redirectSeq+"&groupName="+groupName+"&mallSeq="+mallSeq;
	};

	var getItemtList = function (pageNum, callback) {
		$.ajax({
			type: "GET",
			url: "/admin/system/tmpl/sub/item/list",
			dataType: "text",
			data: {mallSeq:mallSeq, cateLv1Seq: $("select[name=lv1]").val(), cateLv2Seq: $("select[name=lv2]").val(), cateLv3Seq: $("select[name=lv3]").val(), cateLv4Seq: $("select[name=lv4]").val(), seq: $("#searchItemSeq").val(), name: $("#searchItemName").val(),  sellerName: $("#sellerName").val(), rowCount: $("#rowCount").val(), pageNum: pageNum},
			success: function (data) {
				var vo = $.parseJSON(data);

				if (vo.list.length != 0) {
					$("#boardTarget").html($("#trTemplate").tmpl(vo.list));
				} else {
					$("#boardTarget").html("<tr><td class='text-center' colspan='8'>등록된 내용이 없습니다.</td></tr>");
				}

				$("#totalRowCount").html(vo.total);

				$("#paging").html(vo.paging);
				$("#paging").addClass("pagination").addClass("alternate");

				if (typeof callback === "function") {
					callback();
				}
			},
			error: function (error) {
				alert(error.status + ":" + error.statusText);
			}
		});
	};

	$(document).ready(function() {
		//숫자 입력 칸 나머지 문자 입력 막기
		$(".numeric").css("ime-mode", "disabled").numeric();

		CHCategory.initRenderList();
		CHPlan.planRenderList("${mallSeq}");
	});
</script>
</body>
</html>
