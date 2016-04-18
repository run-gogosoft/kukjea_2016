<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
<link href="/assets/css/template.css" type="text/css" rel="stylesheet">
</head>
<body class="skin-blue sidebar-xs">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>로그인페이지 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li>템플릿 관리</li>
			<li class="active">로그인페이지 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-list-ul"></i> ${title}</h3>
						<select alt="회원구분 리스트" id="memberTypeList" class="fix-height" style="margin-left:5px" readonly>
							<option value="C">전체</option>
						</select>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<div class="col-md-3">
							<div class="non-deco" style="width:250px">
								<div class="round" style="background:#4C4C4C;color:red;text-align:center;">header</div>

								<div class="clearfix t-margin">
										<div class="round t-padding" style="background:#4C4C4C;color:red;height:69px;line-height:40px;">content</div>
								</div>

								<!-- A banner -->
								<div class="round hand div-over clearfix t-margin t-padding" onclick="getDisplayVo('login','loginBanner');">login banner</div>

								<div class="clearfix"></div>
								<div class="round t-margin" style="background:#4C4C4C;color:red;text-align:center;">footer</div>
							</div>
						</div>

						<!-- No Style Code -->
						<div class="col-md-9" id="htmlDiv">
							<div class="widget">
								<form id="htmlForm" method="post" onsubmit="return submitProc(this);" target="zeroframe">
									<input type="hidden" name="location" id="location"/>
									<input type="hidden" name="title" id="title"/>
									<input type="hidden" name="memberTypeCode" id="memberTypeCode"/>
									<div class="widget-header">
										<i class="fa fa-pencil fa-2x" style="margin:5px 0 0 10px;vertical-align:-4px;"></i>

										<h3 id="getType" style="margin-top:10px">${title}</h3>

										<div id="htmlButtonBox" class="pull-right"></div>
									</div>
									<div class="widget-content" id="contentDiv" style="text-align:center;">
										<textarea rows="27" id="content" name="content" style="width:99%;height:600px;margin:0;" placeholder="내용을 입력해주세요" alt="내용"></textarea>
										<span id="blankHtml"><span style="color:red;font-size:14px;">왼쪽 메뉴를 선택하세요</span></span>
									</div>
								</form>
							</div>
						</div>

						<!-- item template -->
						<script id="trTemplate" type="text/html">
							<tr>
								<td style="width:10%;" class="text-center">
									<%="${itemSeq}"%>
									<input type="hidden" name="displaySeq" value="<%="${displaySeq}"%>"/>
									<input type="hidden" name="itemSeq" value="<%="${itemSeq}"%>"/>
								</td>
								<td style="width:10%;" class="text-center"><input type="text" name="orderNo" value="<%="${orderNo}"%>" style="margin-top:7px; width:50px; text-align:center;" onblur="numberCheck(this);" maxlength="2"/></td>
								<td style="width: 8%;" class="text-center">
									<img src="<%="${img1}"%>" alt="" style="width:60px;height:60px" />
								</td>
								<td style="width:40%;">
									<span><%="${itemName}"%></span><br/>
								</td>
								<td style="width:10%;" class="text-center"><%="${sellPrice}"%>
								</td>
								<td style="width:10%;" class="text-center"><%="${statusFlag}"%>
								</td>
								<td style="width:5%;" class="text-center">
									<div onclick="viewDeleteModal('<%="${seq}"%>','<%="${itemSeq}"%>')" role="button" class="btn" data-toggle="modal"><i class="fa fa-times fa-2x"></i></div>
								</td>
							</tr>
						</script>

						<!-- Style Code -->
						<div class="col-md-9" id="styleDiv" style="display:none;">
							<div class="widget">
								<div class="widget-header" style="line-height:0;">
									<i class="fa fa-pencil fa-2x pull-left" style="margin:8px 0 0 15px;"></i>

									<h3 id="StyleTitle" class="pull-left" style="margin:0"></h3>

									<form action="/admin/system/main/title/edit/proc" onsubmit="return submitProc(this);" method="post" class="pull-right" target="zeroframe">
										<div class="input-append" style="margin-top:3px;">
											<h3 style="margin:0 0 0 5px;">제목 :</h3>
											<input type="text" placeholder="제목을 입력해주세요" style="margin:0 0 0 15px;height:30px;" name="title" id="listTitle" alt="제목" maxlength="30"/>
											<button type="submit" class="btn btn-primary" style="margin-right:5px;">제목수정</button>
											<input type="hidden" name="styleCode" id="titleStyleCode"/>
											<input type="hidden" name="memberTypeCode" id="titleMemberTypeCode"/>
										</div>
									</form>
								</div>
								<div class="widget-content">
									<form action="/admin/system/main/orderno/edit/proc" onsubmit="return submitProc(this);" method="post" target="zeroframe">
										<input type="hidden" name="styleCode" id="modOrderNoStyleCode"/>
										<input type="hidden" name="memberTypeCode" id="modOrderNoMemberTypeCode"/>
										<button type="submit" id="orderNoBtn" class="btn btn-primary" style="float:right">정렬순서 저장</button>
										<div class="clearfix"></div>
										<input type="hidden" id="itemCnt"/>
										<table class="table table-bordered table-striped" style="margin-top:10px">
											<colgroup>
												<col style="width:10%;"/>
												<col style="width:10%;"/>
												<col style="width:8%;"/>
												<col style="width:42%;"/>
												<col style="width:10%;"/>
												<col style="width:10%;"/>
												<col style="width:5%;"/>
											</colgroup>
											<thead>
											<tr>
												<th>상품번호</th>
												<th>정렬순서</th>
												<th>이미지</th>
												<th>상품명</th>
												<th>가격</th>
												<th>상태</th>
												<th></th>
											</tr>
											</thead>
											<tbody id="boardTarget">
											</tbody>
										</table>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

				<%--하단 PREVIEW--%>
				<div class="row" style="margin-top:20px;" id="htmlDivPreView">
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-header">
								<i class="fa fa-search fa-2x" style="margin:5px 0 0 10px;vertical-align:-4px;"></i>

								<h3 style="left:5px;margin-top:10px;">PREVIEW</h3></div>
							<div id="preview" class="widget-content" style="text-align:center;">
							</div>
						</div>
					</div>
				</div>

				<div id="searchStyleDiv" style="display:none;margin-top:30px;">
					<%-- 상품 검색 --%>
					<form id="searchForm" class="form-horizontal">
						<div class="widget widget-form stacked">
							<div class="widget-header">
								<div class="pull-left"><i class="fa fa-search fa-2x" style="margin:5px 0 0 10px;vertical-align:-4px;"></i> 검색 조건</div>
								<div class="pull-right">
									<button type="button" class="btn btn-small btn-default" onclick="goPage(0)" style="margin-right:10px;">검색하기</button>&nbsp;
									<button type="button" onclick="batchShow({'method':'등록','action':'reg', 'statusCode':'Y'})" class="btn btn-small btn-success">상품등록</button>
								</div>
							</div>
							<div class="widget-content">
								<div class="row-fluid">
									<div class="control-group col-md-12">
										<label class="control-label fix-height">카테고리</label>

										<div class="controls">
											<script id="categoryTemplate" type="text/html">
												<option value="">-카테고리 선택-</option>
												{{each value}}
												<option value="<%="${seq}"%>"><%="${name}"%>{{if showFlag==='N'}}[노출안함]{{/if}}</option>
												{{/each}}
											</script>

											<select name="cateLv1Seq" id="cateLv1Seq" class="col-md-3 fix-height" onchange="renderList(this, 2)">
												<option value="">-카테고리 선택-</option>
											</select>
											<select name="cateLv2Seq" id="cateLv2Seq" class="col-md-3 fix-height" onchange="renderList(this, 3)" style="margin-left:5px;">
												<option value="">-카테고리 선택-</option>
											</select>
											<select name="cateLv3Seq" id="cateLv3Seq" class="col-md-3 fix-height" onchange="renderList(this, 4)" style="margin-left:5px;">
												<option value="">-카테고리 선택-</option>
											</select>

											<select name="cateLv4Seq" id="cateLv4Seq" class="col-md-3 fix-height" style="display:none;margin-left:5px;">
												<option value="">-카테고리 선택-</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="control-group col-md-6">
										<label class="control-label fix-height">상품명</label>

										<div class="controls">
											<input type="text" name="name" id="searchItemName" class="col-md-12 fix-height"/>
										</div>
									</div>
									<div class="control-group col-md-6">
										<label class="control-label fix-height">상품코드</label>

										<div class="controls">
											<input type="text" name="searchItemSeq" id="searchItemSeq" onblur="numberCheck(this);" class="col-md-12 fix-height"/>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>

					<div class="row" id="searchItemList">
						<div class="col-md-12" style="text-align:center;">
							<div class="widget widget-table stacked">
								<div class="widget-header text-left">
									<i class="fa fa-bars fa-2x" style="margin:5px 0 0 10px;vertical-align:-4px;"></i>

									<h3 style="margin-top:10px;">${itemTitle}</h3>
								</div>
								<!-- template -->
								<script id="trSearchTemplate" type="text/html">
									<tr>
										<td style="width:5%" class="text-center">
											<input type="checkbox" name="seq" value="<%="${seq}"%>">
										</td>
										<td style="width:36%" class="text-center">
											<%="${cateLv1Name}"%> &gt;
											<%="${cateLv2Name}"%> &gt;
											<%="${cateLv3Name}"%>
											{{if cateLv4Name !== ""}}
												&gt; <%="${cateLv4Name}"%>
											{{/if}}
										</td>
										<td style="width:8%" class="text-center">
											<img src="<%="${img1}"%>" alt="" style="width:60px;height:60px" />
										</td>
										<td style="width:8%" class="text-center">
											<p><%="${seq}"%>
											</p>
										</td>
										<td style="width:8%" class="text-center">
											<a href="/admin/item/view/<%="${seq}"%>" target="_blank" class="btn btn-mini" data-toggle="tooltip" title="미리보기">
												<i class="fa fa-search fa-2x item-detail"></i>
											</a>
										</td>
										<td style="width:35%">
											<p><%="${name}"%>
											</p>
										</td>
									</tr>
								</script>
								<!-- widget-header -->
								<div class="widget-content">
									<table class="table table-bordered table-list table-striped">
										<caption>${itemTitle}</caption>
										<colgroup>
											<col style="width:5%"/>
											<col style="width:36%"/>
											<col style="width:8%"/>
											<col style="width:8%"/>
											<col style="width:8%"/>
											<col style="width:35%"/>
										</colgroup>
										<thead>
										<tr>
											<th><input type="checkbox" id="allCheckBox" onclick="checkProc(this)" /></th>
											<th>카테고리</th>
											<th>이미지</th>
											<th>상품코드</th>
											<th>상세보기</th>
											<th>상품명</th>
										</tr>
										</thead>
										<tbody id="searchBoardTarget">
										<td colspan="6" class="text-center">등록된 내용이 없습니다.</td>
										</tbody>
									</table>
								</div>
							</div>
							<div class="clearfix"></div>
							<div id="paging" style="text-align:center;margin:0 auto 20px auto"></div>
						</div>
					</div>
				</div>
			</div>
      </section>
</div>

<%-- 삭제 모달 창 --%>
<div id="deleteModal" class="modal">
	<div class="modal-dialog">
			<div class="modal-content">
				<form action="/admin/system/main/item/delete/proc" method="post" target="zeroframe">
					<div class="modal-body">
						<legend>상품 삭제</legend>
						<blockquote>
							<p>정말 상품번호 <strong>&quot;<span id="viewItemSeq"></span>&quot;</strong> 를 삭제하시겠습니까?</p>
						</blockquote>
						<input type="hidden" name="seq" value=""/>
						<input type="hidden" name="styleCode" value="0"/>
						<input type="hidden" name="memberTypeCode" value="0"/>
					</div>
					<div class="modal-footer">
						<a data-dismiss="modal" class="btn" href="#">닫기</a>
						<button type="submit" class="btn btn-danger">삭제하기</button>
					</div>
				</form>
			</div>
	</div>
</div>
<%-- 상품등록 --%>
<div id="batchModal" class="modal"><div class="modal-dialog"><div id="batchContent" class="modal-content"></div></div></div>
<script id="batchTemplate" type="text/html">
	<form action="/admin/system/main/item/reg/proc" onsubmit="return batchSubmitProc(this)" method="post" target="zeroframe">
		<input type="hidden" name="displaySeq" value="<%="${displaySeq}"%>"/>
		<input type="hidden" name="memberTypeCode" value="<%="${memberTypeCode}"%>"/>
		<input type="hidden" name="styleCode" value="<%="${styleCode}"%>"/>
		<div class="modal-body">
			<h4>정말로 <%="${method}"%> 하시겠습니까?</h4>
			<p>선택된 <%="${count}"%> 개의 항목을 일괄로 처리합니다</p>
		</div>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn" href="#">취소</a>
			<button type="submit" class="btn btn-primary">등록</button>
			<div class="hide">{{html content}}</div>
		</div>
	</form>
</script>
<input type="hidden" id="tempDisplaySeq"/>
<input type="hidden" id="tempMemberTypeCode"/>
<input type="hidden" id="tempStyleCode"/>
<%-- 해당 스타일이 등록이 안되어 있다면 등록하도록 모달창을 띄운다. --%>
<div id="regStyleModal" class="modal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" onclick="closeStyleModal()" data-dismiss="modal" aria-hidden="true">×</button>
				<h3>상품군 추가</h3>
			</div>
			<div class="modal-body text-center">
				<p>제목을 입력하세요</p>
				<input type="text" placeholder="제목을 입력해주세요" name="title" id="modalTitle" alt="스타일 제목" maxlength="60"/>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" onclick="closeStyleModal()" aria-hidden="true">닫기</button>
				<div class="btn btn-primary" onClick="regStyle()">등록</div>
			</div>
		</div>
	</div>
</div>

<form id="regStyleForm" action="/admin/system/main/style/reg/proc" method="post" target="zeroframe">
	<input type="hidden" name="memberTypeCode" id="regStyleMemberTypeCode"/>
	<input type="hidden" name="styleCode" id="regStyleCode"/>
	<input type="hidden" name="orderNo" id="regStyleOrderNo" onblur="checkOrderNoPrevent(this)"/>
	<input type="hidden" name="limitCnt" id="regStyleLimitCnt"/>
	<input type="hidden" name="title" id="regStyleTitle"/>
</form>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
var displaySeq = 0;

$(document).ready(function () {
	categoryRenderList();
	initMainPage();
});

var batchShow = function(json){
	json.count = $("#searchBoardTarget input:checkbox:checked").length;
	json.displaySeq = $('#tempDisplaySeq').val();
	json.memberTypeCode = $('#tempMemberTypeCode').val();
	json.styleCode = $('#tempStyleCode').val();
	json.content = (function(){
		var html = "";
		$("#searchBoardTarget input:checkbox:checked").each(function(){
			html += "<input type='hidden' name='procSeq' value='" + $(this).val() + "' />";
		});
		return html;
	})();
	if(json.count === 0) {
		alert("선택된 항목이 하나도 없습니다");
		return;
	}

	$("#batchModal").modal().find('#batchContent').html( $("#batchTemplate").tmpl(json) );
}

var batchSubmitProc = function(obj) {
	// 중복 클릭 방지
	$(obj).find("button").prop("disabled", true);
	$("#searchBoardTarget input:checkbox:checked").each(function() {
		$(this).attr("checked", false);
	});
	return true;
};

//상품 체크박스
var checkProc = function(obj) {
	$("#searchBoardTarget input:checkbox").each(function(){
		$(this).prop("checked", $(obj).prop("checked"));
	});
};

var goPage = function (page) {
	var lv1Value = parseInt($('#cateLv1Seq option:selected').val(),10) || 0;
	if(lv1Value===0){
		alert('카테고리가 선택되지 않았습니다.');
		return;
	}
	getItemtList(page);
};

var initMainPage = function(){
	//초기 htmlBox의 문구를 입력한다.
	$('#getType').text('${title}');
	//하단 preview의 내용을 초기화 시킨다.
	$('#preview').text('');
	//화면에 보여지는 스타일 BOX를 숨긴다.
	$("#styleDiv").hide();
	$("#searchStyleDiv").hide();
	$("#content").hide();
	$('#submitBtn').hide();
	//초기화면을 다시 보여준다.
	$('#htmlDiv').show();
	$("#blankHtml").show();
	$("#htmlDivPreView").show();
};
var categoryInit = function(depth){
	if(depth <= 4){ //여기서 3의 의미는 현재 대,중,소 카테고리 밖에 존재하지 않아 3이다. 만약 추후 세분류가 추가된다면 4로 고쳐주면된다.
		while(depth <= 4){
			$('#cateLv'+depth+'Seq').html('<option value="">--카테고리 선택--</option>');
			depth++;
		}
	}
}
var renderList = function(obj, depth){
	var parentSeq = depth === 1 ? 0 : parseInt($(obj).val(),10) || 0;
	var memberTypeCode = $('#memberTypeList option:selected').val();

	//대분류 카테고리를 변경하면 세분류는 무조건 숨긴다.
	if(depth === 2) {
		$('#cateLv4Seq').hide();
	}

	if((depth === 1 && parentSeq === 0) || (depth > 1 && parentSeq > 0)){
		$.ajax({
			url:"/admin/category/list/simple/ajax",
			type:"get",
			data:{depth:depth, parentSeq:parentSeq},
			dataType:"text",
			success:function(data) {
				var valueList = {value:[]};
				var list = $.parseJSON(data);
				valueList.value = list;

				categoryInit(depth);//상위카테고리 클릭시 하위카테고리를 먼저 초기화 시킨다.

				if(parseInt(depth,10) <= 3) {
					$('#cateLv'+depth+'Seq').html(list.length === 0 ? '<option value="">--카테고리 선택--</option>' : $("#categoryTemplate").tmpl(valueList));
				} else if(parseInt(depth,10) === 4) {
					// 세분류가 존재하지않는다면 세분류 SelectBox를 숨긴다.
					if(list.length === 0) {
						$('#cateLv4Seq').hide();
					} else {
						$('#cateLv'+depth+'Seq').html($("#categoryTemplate").tmpl(valueList));
						$('#cateLv4Seq').show();
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
		categoryInit(depth);
	}
};

var categoryRenderList = function(){
	$.ajax({
		url:"/admin/category/list/simple/ajax",
		type:"get",
		data:{depth:1, parentSeq:0},
		dataType:"text",
		success:function(data) {
			var valueList = {value:[]};
			var list = $.parseJSON(data);
			valueList.value = list;

			if(list.length === 0){
				//최초 몰선택시 좌측상단, 상품검색 대분류 카테고리를 가져온다.
				$('#cateLv1Seq').html('<option value="0">--카테고리 선택--</option>');
			} else {
				//최초 몰선택시 좌측상단, 상품검색 대분류 카테고리를 가져온다.
				$('#cateLv1Seq').html($("#categoryTemplate").tmpl(valueList));
			}
		},
		error:function(error) {
			alert( error.status + ":" +error.statusText );
		}
	});
};

//몰리스트가 변경되었을 경우 카테고리를 초기화시키고 초기화면으로 리셋한다.
var memberTypeSelect = function(){
	var memberTypeCode = $('#memberTypeList option:selected').val();

	if(memberTypeCode !== '') {
		location.href='/admin/system/main?memberTypeCode='+memberTypeCode;
	}
};

var renderMainPage = function(location, title, memberTypeCode, styleCode){
	//memberTypeCode가 실제로 필요한 파라미터는 아니다. 단지 callback으로 받아 올때 index개념으로 사용하고 있다.
	//배너 값 선택
	if (location !== '' && title !== '') {
		getDisplayVo(location, title);
	}

	//스타일 선택(상품군)
	if (styleCode !== '') {
		goStyle(styleCode, '', '', '.styleBanner'+styleCode);
	}
};

var callbackProc = function(msg) {
	$('#regStyleModal').modal('hide');
	$('#deleteModal').modal('hide');
	$('#batchModal').modal('hide');

	var callBackMsg = msg.split(':');
	//memberTypeCode 실제로 필요한 파라미터는 아니다. 단지 callback으로 받아 올때 index개념으로 사용하고 있다.
	if(parseInt(callBackMsg.length,10) === 2){ //length == 2 이라면 상품추가, 스타일(상품군) 등록
		renderMainPage('', '', callBackMsg[0], callBackMsg[1]);
	} else if(parseInt(callBackMsg.length,10) === 3){ //length == 3 이라면 배너 등록. 수정
		//0:location, 1:title, 2:memberTypeCode
		renderMainPage(callBackMsg[0], callBackMsg[1], callBackMsg[2], '');
	} else if(parseInt(callBackMsg.length,10) === 7){ //length == 7 상품군에 대한 수정(제목, 정렬순서, 상품삭제)
		//0:memberTypeCode, 1:styleCode, 3:lv1, 4:lv2, 5:lv3, 6:itemSeq, 7:itemName
		//이곳에서 상품검색 폼에 대한 검색조건을 매칭시킨다.
		renderMainPage('', '', callBackMsg[0], callBackMsg[1]);
	}

	checkProc();
};

//스타일 등록 모달창을 닫을 때
var closeStyleModal = function(){
	//모달창을 자의로 닫았다면 초기화면으로 돌아간다.
	initMainPage();
};

var regStyle = function(){
	if($("#modalTitle").val() === ''){
		alert('제목을 입력해주세요.');
		return;
	}
	$('#regStyleTitle').val($("#modalTitle").val());//모달창의 제목을 form title태그에 넣는다.
	$('#regStyleForm').submit();
};
//배너 등록/수정시의 항목 검증
var submitProc = function (obj) {
	var flag = true;

	var memberTypeCode = $('#memberTypeList option:selected').val();
	if (memberTypeCode === '') {
		alert('몰이 선택되지 않았습니다.');
		flag = false;
	} else {
		$('#memberTypeCode').val(memberTypeCode);
	}

	//정렬순서 저장 버튼을 클릭하였는데 상품이 하나도 등록되어 있지 않을 경우 유효성검사
	if($(obj).find('#orderNoBtn').length > 0) {
		var itemCnt = parseInt($(obj).find('#itemCnt').val(),10) || 0;
		if(itemCnt === 0){
			alert('상품이 등록 되어있지 않습니다.');
			flag = false;
		}
	}

	$(obj).find("input[alt], select[alt]").each( function() {
		if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
			alert($(this).attr("alt") + "란을 채워주세요!");
			flag = false;
			$(this).focus();
		}
	});

	return flag;
};
//배너추가
var getDisplayVo = function (location, title) {
	var memberTypeCode = $('#memberTypeList option:selected').val();
	if (memberTypeCode === '') {
		alert('몰이 선택되지 않았습니다.');
		return;
	}

	//데이터를 불러오기전 html, preview box를 초기화시킨다.
	$('#content').val('');
	$('#preview').text('');

	$("#location").val(location);
	$("#title").val(title);

	//스타일 Div를 클릭해서 HTML Textarea와 HTML Preview가 사라졌을 경우 다시 보이기
	if ($("#htmlDiv").hide() && $("#htmlDivPreView").hide()) {
		$("#styleDiv").hide();
		$("#searchStyleDiv").hide();
		$("#htmlDiv").show();
		$("#htmlDivPreView").show();
	}

	if (location != "" && title != "") {
		$("#blankHtml").hide();
		$("#submitBtn").show();
		$("#content").show();
	}

	$.ajax({
		type: "GET",
		url: "/admin/system/tmpl/main/ajax",
		dataType: "text",
		data: {location: location, title: title, memberTypeCode:memberTypeCode},
		success: function (data) {
			var vo = $.parseJSON(data);
			if (vo.title === "" && vo.content === "") {
				$("#getType").html("<span style='color:blue'>" + title + "</span> HTML 등록");
				$('#htmlButtonBox').html('<button type="submit" class="btn btn-primary" style="margin-bottom:3px;" id="submitBtn">등록</button>');
				$('#htmlForm').attr('action', '/admin/system/main/reg/proc');
			} else {
				$("#getType").html("<span style='color:blue'>" + vo.title + "</span> HTML 수정");
				$('#htmlButtonBox').html('<button type="submit" class="btn btn-primary" style="margin-bottom:3px;" id="submitBtn">수정</button>');
				$('#htmlForm').attr('action', '/admin/system/main/edit/proc');
				$("#content").val(vo.content);
				$("#preview").html(vo.content);
			}
		},
		error: function (error) {
			alert(error.status + ":" + error.statusText);
		}
	});
};
//상품추가
var goStyle = function (styleCode,limitCnt,orderNo, obj) {
	var memberTypeCode = $('#memberTypeList option:selected').val();
	if (memberTypeCode === '') {
		alert('몰이 선택되지 않았습니다.');
		return;
	}

	//html입력 textarea를 없애고 스타일 테이블을 불러옴
	$("#htmlDiv").hide();
	$("#htmlDivPreView").hide();
	$("#styleDiv").show();
	$("#searchStyleDiv").show();
	//스타일 클릭시 각 form에 필수 데이터를 입력한다.
	//title form 전송시 보낼 해당 스타일의 코드
	$("#titleMemberTypeCode").val(memberTypeCode);
	$("#titleStyleCode").val(styleCode);
	//orderNo form 전송시 보낼 해당 스타일의 코드
	$("#modOrderNoMemberTypeCode").val(memberTypeCode);
	$("#modOrderNoStyleCode").val(styleCode);
	//delete form 전송시 보낼 해당 스타일의 코드
	$("#deleteModal").find("input[name=memberTypeCode]").val(memberTypeCode);
	$("#deleteModal").find("input[name=styleCode]").val(styleCode);
	//상품 검색 전송시 보낼 해당 스타일의 코드
	$("#searchMemberTypeCode").val(memberTypeCode);
	$("#searchStyleCode").val(styleCode);
	//상품 추가시 필요한 요소들
	$("#tempStyleCode").val(styleCode);
	$("#tempMemberTypeCode").val(memberTypeCode);

	$("#StyleTitle").html("<span style='display:inline-block;margin-top:10px;color:blue'>" + $(obj).text() + "</span>");
	// if (styleCode != 4) {
	// 	$("#StyleTitle").html("<span style='color:blue'>gallery" + styleCode + "</span>");
	// } else {
	// 	$("#StyleTitle").html("<span style='color:blue'>Best Product</span>");
	// }
	//리스트타이틀
	$.ajax({
		type: "GET",
		url: "/admin/system/getTitle",
		dataType: "text",
		data: {styleCode: styleCode,memberTypeCode:memberTypeCode},
		success: function (data) {
			//만약 스타일이 등록되어 있지않다면 등록하도록 유도한다.(모달창)
			if($.parseJSON(data).listTitle === ''){
				//모달창이 표시될때 제목입력창과 상품 리스트에 값이 있다면 보기 안좋을수 있으므로 공백으로 만든다.
				$('#listTitle').val('');
				$('input[name=itemSeq]').val('');
				$("#boardTarget").html("<tr><td class='text-center' colspan='7'>등록된 내용이 없습니다.</td></tr>");
				$("#modalTitle").val('');
				//
				$('#regStyleMemberTypeCode').val(memberTypeCode);
				$('#regStyleCode').val(styleCode);
				$('#regStyleLimitCnt').val(limitCnt);
				$('#regStyleOrderNo').val(orderNo);
				$("#regStyleModal").modal('show');
				return;
			} else {
				$('#listTitle').val('');

				try {
					$("#listTitle").val($.parseJSON(data).listTitle);
					//list form 전송시 보낼 해당 스타일의 코드
//					$("#displaySeq").val($.parseJSON(data).seq);//sm_display_item의 seq를 가지고 있음
					var displaySeq = $.parseJSON(data).seq;
					$('#tempDisplaySeq').val(displaySeq);
					//아이템리스트
					$.ajax({
						type: "GET",
						url: "/admin/system/getList",
						dataType: "text",
						data: {styleCode: styleCode, displaySeq:displaySeq,memberTypeCode:memberTypeCode},
						success: function (data) {
							var list = $.parseJSON(data);
							//정렬순서 저장버튼 클릭시 상품있는지 없는지에 대한 유효성검사를 위해 등록된 상품 갯수를 저장한다.
							$('#itemCnt').val(list.length);
							if (list.length != 0) {
								$("#boardTarget").html($("#trTemplate").tmpl(list));
							} else {
								$("#boardTarget").html("<tr><td class='text-center' colspan='7'>등록된 내용이 없습니다.</td></tr>");
							}
						},
						error: function (error) {
							alert(error.status + ":" + error.statusText);
						}
					});
				} catch (e) {
					alert("데이터를 불러올 수 없었습니다");
				}
			}
		},
		error: function (error) {
			alert(error.status + ":" + error.statusText);
		}
	});
};

var viewDeleteModal = function (seq, itemSeq) {
	var memberTypeCode = $('#memberTypeList option:selected').val();
	if (memberTypeCode === '') {
		alert('몰이 선택되지 않았습니다.');
		return;
	}

	$("#deleteModal").find("input[name=seq]").val(seq);
	$("#deleteModal").find("#viewItemSeq").text(itemSeq);
	$("#deleteModal").find("input[name=cateLv1Seq]").val($("#insertLv1").val());
	$("#deleteModal").find("input[name=cateLv12eq]").val($("#insertLv2").val());
	$("#deleteModal").find("input[name=cateLv3Seq]").val($("#insertLv3").val());
	$("#deleteModal").find("input[name=searchItemSeq]").val($("#insertItemSeq").val());
	$("#deleteModal").find("input[name=name]").val($("#insertItemName").val());
	$("#deleteModal").modal('show');
};

var getItemtList = function (pageNum, callback) {
	var memberTypeCode = $('#memberTypeList option:selected').val();

	$.ajax({
		type: "GET",
		url: "/admin/system/tmpl/sub/item/list",
		dataType: "text",
		data: {cateLv1Seq: $("select[name=cateLv1Seq]").val(), cateLv2Seq: $("select[name=cateLv2Seq]").val(), cateLv3Seq: $("select[name=cateLv3Seq]").val(), cateLv4Seq: $("select[name=cateLv4Seq]").val(), seq: $("#searchItemSeq").val(), name: $("#searchItemName").val(), pageNum: pageNum},
		success: function (data) {
			var vo = $.parseJSON(data);
			if (vo.list.length != 0) {
				$("#searchBoardTarget").html($("#trSearchTemplate").tmpl(vo.list));
			} else {
				$("#searchBoardTarget").html("<tr><td class='text-center' colspan='6'>등록된 내용이 없습니다.</td></tr>");
			}

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
</script>
</body>
</html>
