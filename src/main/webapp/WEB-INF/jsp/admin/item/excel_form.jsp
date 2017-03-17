<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.title {cursor:pointer}
		.current {background:#D9EDF7; font-weight:bold;}
		.eb-category {
			max-height:250px;
			overflow: auto;
		}
	</style>
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
		<h1>상품 대량등록 <small>상품 정보를 엑셀 파일로 작성하여 일괄 등록할 수 있는 페이지입니다. </small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>상품 관리</li>
			<li class="active">엑셀 상품 대량등록</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="alert alert-info">
			<ol>
				<li>엑셀은 반드시 정해진 폼에 맞춰서 작업을 해야 합니다. <strong> - 상품리스트에서 다운받은 엑셀 파일을 참고하세요</strong></li>
				<li>엑셀은 금액부분을 제외하고 반드시 셀서식을 텍스트 형식으로 저장하셔야 합니다. 샘플파일을 참고하세요</li>
				<li>
					엑셀은 반드시 <strong>.xls (오피스 2003)</strong>으로 저장을 해주셔야 합니다. 오피스 2007은 적용되지 않습니다 <br/>
					(파일명만 바꾸는 것이 아니라 실제 저장형식을 오피스 2003으로 해야 합니다)
				</li>
				<li>1회 업로드는 1000개로 제한되어 있습니다</li>
				<li>경우에 따라서 수분의 시간이 소요될 수 있습니다. 절대 창을 닫지 마십시오</li>
				<li>샘플파일을 다운로드하여 아래표의 양식에 맞추어 작성해 주세요</li>
				<li>각 분류코드는 가이드에 맞춰 참고하여 주십시오</li>
				<li>
					이미지는 .jpg, .jpeg 확장자만<br/>
					업로드 가능합니다
				</li>
			</ol>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">상품 분류 코드</h3></div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header with-border">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>대분류</h3>
										<div class="box-tools pull-right"></div>
									</div>
									<div class="box-body eb-category">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>카테고리명</th>
													<th>코드</th>
												</tr>
											</thead>
											<tbody id="lv1" data-seq="0">
												<tr>
													<td class="text-warning text-center" colspan="2">데이터를 불러오고 있습니다  <img src='/assets/img/common/ajaxloader.gif' alt='' /></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header with-border">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>중분류</h3>
										<div class="box-tools pull-right"></div>
									</div>
									<div class="box-body eb-category">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>카테고리명</th>
													<th>코드</th>
												</tr>
											</thead>
											<tbody id="lv2" data-seq="0">
												<tr>
													<td class="text-warning text-center" colspan="2">데이터를 불러오고 있습니다  <img src='/assets/img/common/ajaxloader.gif' alt='' /></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header with-border">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>소분류</h3>
										<div class="box-tools pull-right"></div>
									</div>
									<div class="box-body eb-category">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>카테고리명</th>
													<th>코드</th>
												</tr>
											</thead>
											<tbody id="lv3" data-seq="0">
												<tr>
													<td class="text-warning text-center" colspan="2">데이터를 불러오고 있습니다  <img src='/assets/img/common/ajaxloader.gif' alt='' /></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header with-border">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>세분류</h3>
										<div class="box-tools pull-right"></div>
									</div>
									<div class="box-body eb-category">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>카테고리명</th>
													<th>코드</th>
												</tr>
											</thead>
											<tbody id="lv4" data-seq="0">
												<tr>
													<td class="text-warning text-center" colspan="2">데이터를 불러오고 있습니다  <img src='/assets/img/common/ajaxloader.gif' alt='' /></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="alert alert-warning"><span class="fa fa-fw fa-info"></span> 위 상품 분류 코드를 참고하여 엑셀 파일을 작성해 주세요</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">엑셀 파일 작성/업로드</h3></div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="/admin/item/excel/upload" target="zeroframe" class="form-horizontal" onsubmit="return submitProc(this)" enctype="multipart/form-data">
						<div class="box-body">
					<c:choose>
						<c:when test="${sessionScope.loginType eq 'A' or sessionScope.loginType eq 'S'}">
							<input type="hidden" name="sellerSeq" value="${sessionScope.loginSeq}" readonly="readonly" alt="관리자" />
							<div class="form-group">
								<label class="col-md-2 control-label">샘플 다운로드</label>
								<div class="col-md-10">
									<a href="/admin/item/list?mallSeq=${mallSeq}" target="_self" class="btn btn-sm btn-success">상품 리스트</a> 에서 <strong>엑셀다운</strong>하세요
								</div>
							</div>
						</c:when>
						<c:otherwise>

							<div class="form-group">
								<label class="col-md-2 control-label">샘플 다운로드</label>
								<div class="col-md-10">
									<a href="/admin/item/list" target="_self" class="btn btn-sm btn-success">상품 리스트</a> 에서 <strong>엑셀다운</strong>하세요
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">입점업체</label>
								<div class="col-md-2">
									<input type="text" class="form-control" name="sellerSeq" value="" readonly="readonly" ${param.transfer eq 'Y' ? '':'alt="입점업체"'}/>
								</div>
								<div class="col-md-2">
									<select id="search" name="search" class="form-control">
										<option value="name">업체명</option>
										<option value="id">아이디</option>
										<!-- <option value="nickname">닉네임</option> -->
									</select>
								</div>
								<div class="col-md-2">
									<input type="text" class="form-control" name="seller" value="" onkeydown="enterSearch();" placeholder="입점업체 검색" />
								</div>
								<div class="col-md-1">
									<button type="button" class="btn btn-default" onclick="sellerProc(0)">검색</button>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2">입점업체</div>
								<div class="col-md-10">
									<table class="table table-bordered table-striped" style=margin-top:5px;>
										<thead>
											<tr>
												<th>아이디</th>
												<th>입점업체명</th>
												<th>입점업체<br/>등급</th>
												<th>정산<br/>등급</th>
												<th>상태</th>
												<th>대표자명</th>
												<th>대표전화</th>
												<th>담당자명</th>
												<th>담당자<br/>연락처</th>
												<th>승인일자</th>
											</tr>
										</thead>
										<tbody id="eb-seller-list">
											<tr><td class="muted text-center" colspan="20">	검색결과가 이 안에 표시됩니다</td></tr>
										</tbody>
									</table>
									<div id="paging"></div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
						<div class="form-group">
							<label class="col-md-2 control-label">업로드</label>
							<div class="col-md-3">
								<input style="height:30px;width:400px;" type="file" name="file[0]" onchange="checkFileSize(this)" alt="엑셀 파일 업로드">
								<input type="hidden" name="idx" value="1" />
							</div>

						</div>
						<div class="form-group">
							<label class="col-md-2 control-label"></label>
							<div class="col-md-3">
								<button type="button" class="btn btn-sm btn-success fileinput-button" onclick="doSubmit();">
									<i class="fa fa-fw fa-plus"></i>
									<span>엑셀 파일 업로드하기</span>
								</button>
								<div id="upload-alert" class="hide">파일을 업로드하고 있습니다. 잠시만 기다려주세요 <img src="/assets/img/common/ajaxloader.gif" alt="" /></div>
							</div>
						</div>
						</div><!-- /.box-body -->
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header"><h3 class="box-title"><i class="fa fa-fw fa-list"></i> 오류 내역</h3></div>
					<div class="box-body">
						<table class="table table-striped table-bordered table-list">
							<thead>
								<th>내용</th>
							</thead>
							<tbody id="errorList">
								<tr><td class="text-center muted" style="padding:50px">업로드 후에 오류가 있으면 여기에 표시됩니다</td></tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="errorTemplate" type="text/html">
	<tr><td class="text-error"><%="${message}"%></td></tr>
</script>

<script id="sellerTemplate" type="text/html">
	<tr style="cursor:hand" data-seq="<%="${seq}"%>" onclick="sellerSelectProc(this)">
		<td class="text-center"><%="${id}"%></td>
		<td class="text-center"><%="${name}"%></td>
		<td class="text-center"><%="${gradeCode}"%></td>
		<td class="text-center"><%="${adjustGradeCode}"%></td>
		<td class="text-center"><%="${statusCode}"%></td>
		<td class="text-center"><%="${ceoName}"%></td>
		<td class="text-center"><%="${tel}"%></td>
		<td class="text-center"><%="${salesName}"%></td>
		<td class="text-center"><%="${salesTel}"%></td>
		<td class="text-center"><%="${approvalDate}"%></td>
	</tr>
</script>

<script id="itemTemplate" type="text/html">
	<tr data-seq="<%="${seq}"%>" data-depth="<%="${depth}"%>">
		<td class="title" onclick="EBCategory.select(this)">
			{{if showFlag=="Y"}}
			<i class="fa fa-fw fa-chevron-down"></i>
			{{else}}
			<i class="fa fa-fw fa-close"></i>
			{{/if}}
			<%="${name}"%>
		</td>
		<td class="text-center">
			<%="${seq}"%>
		</td>
	</tr>
</script>

<script id="uploadTemplate" type="text/html">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<h4><%="${title}"%></h4>
			<%="{{html content}}"%>
			<div class="status"></div>
		</div>
	</div>
<div>
</script>
<script id="statusTemplate" type="text/html">
	<dl class="dl-horizontal">
		<dt>이미지처리</dt>
		<dd><%="${imageCount}"%>/<%="${listCount}"%></dd>
		<dt>데이터베이스처리</dt>
		<dd><%="${dbCount}"%>/<%="${listCount}"%></dd>
	</dl>
</script>
<div id="uploadModal" class="modal">
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var getStatusProc = function() {
		$.ajax({
			url:"/admin/item/excel/status/json",
			type:"get",
			data:{},
			dataType:"text",
			success:function(data) {
				if(data !== "ERROR") {
					var map = $.parseJSON(data);
					var parseListCount = parseInt(map.listCount, 10) || 0;
					var parseDbCOunt = parseInt(map.dbCount,10) || 0;
					if(parseListCount === parseDbCOunt) {
						return;
					}
					$("#uploadModal .status").html( $("#statusTemplate").tmpl(map) );
				}

				if($("#uploadModal .status:visible").length != 0) {
					setTimeout(function(){
						getStatusProc();
					}, 1500);
				}
			},
			error: function (error) {
				alert(error.status + ":" + error.statusText);
			}
		});
	};

	var EBCategory = {
		select:function(obj) {
			var seq = parseInt($(obj).parents("tr").attr("data-seq"), 10) || 0;
			var depth = parseInt($(obj).parents("tr").attr("data-depth"), 10) || 0;
			EBCategory.renderList(depth+1, seq);

			$(obj).parents("tbody").find(".current").removeClass("current");
			$(obj).addClass("current");
		}
		, renderList: function(depth, parentSeq) {
			// 로딩 메시지
			$("#lv"+depth).html(
					"<tr><td colspan='2' class='text-warning text-center'>" +
							"데이터를 불러오고 있습니다 <img src='/assets/img/common/ajaxloader.gif' alt='' />" +
							"</td></tr>"
			);

			$.ajax({
				url:"/admin/category/list/ajax",
				type:"get",
				data:{depth:depth, parentSeq:parentSeq,mallId:${mallSeq}},
				dataType:"text",
				success:function(data) {
					var list = $.parseJSON(data);
					// 단계를 표시한다
					$("#lv"+depth).html(
							(list.length === 0) ?
									"<tr><td colspan='2' class='text-warning text-center'>" +
											"데이터가 하나도 입력되어 있지 않습니다.<br/>" +
											"</td></tr>"
									: $("#itemTemplate").tmpl(list)
					);

					// 단계를 초기화한다
					$("[id^=lv]").each(function(){
						if( parseInt($(this).attr("id").replace(/lv/, ""),10) > depth ) {
							$(this).html(
									'<tr><td class="text-warning text-center" colspan="2">분류를 선택해주세요</td></tr>'
							).attr("data-seq", "0");
						}
					});
					$("#lv"+depth).attr("data-seq", parentSeq);
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
	};

	var sellerProc = function(pageNum) {
		$("#eb-seller-list")
				.html( "<tr><td colspan='20' class='muted text-center' style='padding:10px'>데이터를 불러오고 있습니다</td></tr>" )
				.parents(".hide").show();
		$.ajax({
			url:"/admin/seller/list/S/json",
			type:"post",
			data:{findword:$("input[name=seller]").val(), search:$("#search option:selected").val(), pageNum:pageNum},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);

				if(list.length === 0) {
					$("#eb-seller-list").html( "<tr><td colspan='20' class='muted text-center' style='padding:10px'>검색된 결과가 없습니다</td></tr>" );
				} else {
					$("#eb-seller-list").html( $("#sellerTemplate").tmpl(list) );
				}
				/** 입점업체리스트를 불러온후 페이징을 호출한다. */
				sellerProcPaging(pageNum);
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};

	var sellerProcPaging = function(pageNum){
		$.ajax({
			type:"post",
			url:"/admin/seller/list/S/json/paging",
			dataType:"text",
			data:{findword:$("input[name=seller]").val(), search:$("#search option:selected").val(), pageNum:pageNum},
			success:function(data) {
				$("#paging").html(data);
				$("#paging").addClass("dataTables_paginate").addClass("paging_simple_numbers").addClass("text-center");
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};


	var sellerSelectProc = function(obj) {
		var seq = parseInt($(obj).attr("data-seq"), 10) || 0;
		$("input[name=sellerSeq]").val(seq);
		$("#eb-seller-list tr[data-seq]").each(function(){
			if(parseInt($(this).attr("data-seq"), 10) !== seq) {
				$(this).remove();
			} else {
				$(this).addClass("info");
			}
		});
	};

	var doSubmit = function() {
		$('#validation-form').submit();
	}
	
	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt]").each( function() {
			if(flag && $(this).val() === "") {
				alert($(this).attr("alt") + "란을 입력해주세요");
				flag = false;
				$(this).focus();
			}
		});
		return flag;
	};

	var callbackProc = function(msg) {
		var key = msg.split(":")[0];
		var value = msg.split(":")[1];
		if(key === "filename") {
//			$("#upload-alert").html( value );
//			$("#temp-upload-alert").html( value );
			$("#uploadModal")
					.modal()
					.html($("#uploadTemplate")
							.tmpl({
								"title": "업로드에 성공했습니다", "content": '<p class="text-center">이제 이 파일이 유효한지 검사합니다. 잠시만 기다려주세요 <img src="/assets/img/common/ajaxloader.gif" alt="" /></p>'
							})
			);

			// 진행 상태를 갱신한다
			getStatusProc();

			$("#upload-alert").html(value);
	
			$.ajax({
				url: "/admin/item/excel/check",
				type: "get",
				data: {
					filepath: value, sellerSeq: $("input[name=sellerSeq]").val(), mallSeq:${mallSeq}
				},
				dataType: "text",
				success: function (data) {
					if (data === "OK") {
						$("#errorList").html("");
						$("#uploadModal").html(
								$("#uploadTemplate").tmpl({
									"title": "모든 작업이 완료되었습니다!", "content": '<a href="/admin/item/list?mallSeq=${mallSeq}&statusCode=E">리스트 페이지로 이동하기</a>'
								})
						)
					} else {
						$("#uploadModal").modal("hide");
						var vo = $.parseJSON(data);
						$("#errorList").html($("#errorTemplate").tmpl(vo.errorList));
	
						$(document.documentElement).animate({
							scrollTop: 5000
						}, "slow");
					}
				},
				error: function (error) {
					alert(error.status + ":" + error.statusText);
				}
			});
			
		}
	};
	var goPage = function (page) {
		sellerProc(page);
	};
	
	var enterSearch = function() {
		var evt_code = (window.netscape) ? event.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			sellerProc(0); //jsonp사용시 enter검색
		}
	}
	
	$(document).ready(function(){
		setTimeout(function(){
			EBCategory.renderList(1, 0);
		}, 100);
	});
</script>
</body>
</html>
