<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.title {cursor:pointer}
		.current {background:#D9EDF7; font-weight:bold;}
		.drag {background: #eee;}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>카테고리 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>상품 관리</li>
			<li class="active">카테고리 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header">
						<!-- <h3 class="box-title"></h3> -->
						<div class="alert alert-info">
							마우스로 드래그하고 저장 버튼을 누르면 해당 레벨의 카테고리 순서를 저장하실 수 있습니다.<br/>
							변경 내역을 쇼핑몰에 적용할 경우<button class="btn btn-danger btn-sm" onclick="modProc()">변경 내역 적용</button> 버튼을 반드시 눌러주시기 바랍니다.
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>대분류</h3>
										<div class="box-tools pull-right">
											<button type="button" class="btn btn-sm btn-default" onclick="EBCategory.showInsertModal(1,${mallSeq})">+추가</button>
										</div>
									</div>
									<div class="box-body no-padding">
										<table id="list1" class="table table-striped">
											<tbody id="lv1" data-seq="0"></tbody>
											<tfoot>
												<tr>
													<td colspan="2" class="text-right">
														<button type="button" class="btn btn-warning btn-sm" onclick="EBCategory.saveOrderNo('#lv1')">순서 저장하기</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>중분류</h3>
										<div class="box-tools pull-right">
											<button type="button" class="btn btn-sm btn-default" onclick="EBCategory.showInsertModal(2,${mallSeq})">+추가</button>
										</div>
									</div>
									<div class="box-body no-padding">
										<table id="list2" class="table table-striped">
											<tbody id="lv2" data-seq="0"></tbody>
											<tfoot>
												<tr>
													<td colspan="2" class="text-right">
														<button type="button" class="btn btn-warning btn-sm" onclick="EBCategory.saveOrderNo('#lv2')">순서 저장하기</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>소분류</h3>
										<div class="box-tools pull-right">
											<button type="button" class="btn btn-sm btn-default" onclick="EBCategory.showInsertModal(3,${mallSeq})">+추가</button>
										</div>
									</div>
									<div class="box-body no-padding">
										<table id="list3" class="table table-striped">
											<tbody id="lv3" data-seq="0"></tbody>
											<tfoot>
												<tr>
													<td colspan="2" class="text-right">
														<button type="button" class="btn btn-warning btn-sm" onclick="EBCategory.saveOrderNo('#lv3')">순서 저장하기</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-default box-solid">
									<div class="box-header">
										<h3 class="box-title"><i class="fa fa-fw fa-bars"></i>세분류</h3>
										<div class="box-tools pull-right">
											<button type="button" class="btn btn-sm btn-default" onclick="EBCategory.showInsertModal(4,${mallSeq})">+추가</button>
										</div>
									</div>
									<div class="box-body no-padding">
										<table id="list4" class="table table-striped">
											<tbody id="lv4" data-seq="0"></tbody>
											<tfoot>
												<tr>
													<td colspan="2" class="text-right">
														<button type="button" class="btn btn-warning btn-sm" onclick="EBCategory.saveOrderNo('#lv4')">순서 저장하기</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<form id="createJs" action="/admin/category/create/js" target="zeroframe" method="post">
	
</form>

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
		<td class="text-right">
			<button type="button" onclick="EBCategory.showUpdateModal(<%="${seq}"%>)" class="btn btn-xs btn-default">수정</button>
			<button type="button" onclick="EBCategory.showDeleteModal(this)" class="btn btn-xs btn-danger">삭제</button>
		</td>
	</tr>
</script>

<script id="formTemplate" type="text/html">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-body">
			<legend>카테고리 <span><%="${depth}"%></span>단 <%="${method}"%>하기</legend>

			{{if typeof parentCategory !== "undefined" && parentCategory !== ""}}
			<label class="control-label">상위 카테고리</label>
			<h4 class="text-info"><%="${parentCategory}"%></h4>
			{{/if}}

			<%--<div class="form-group">--%>
				<%--<label class="col-md-3 control-label">쇼핑몰명</label>--%>
				<%--<div class="col-md-5">--%>
				<%--<%="${mallId}"%>--%>
				<%--</div>--%>
			<%--</div>--%>

			<div class="form-group">
				<label class="col-md-3 control-label">카테고리명</label>
				<div class="col-md-5">
					<input type="text" name="name" class="form-control"  maxlength="50" value="<%="${name}"%>" alt="카테고리명" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label">노출여부</label>
				<div class="col-md-5">
					<select name="showFlag" class="form-control">
						<option value="Y" {{if showFlag=="Y"}}selected="selected"{{/if}}>보여주기</option>
						<option value="N" {{if showFlag=="N"}}selected="selected"{{/if}}>숨기기</option>
					</select>
				</div>
			</div>
			
			<input type="hidden" name="depth" value="<%="${depth}"%>" />
			<input type="hidden" name="parentSeq" value="<%="${parentSeq}"%>" />
			<input type="hidden" name="orderNo" value="<%="${orderNo}"%>" />
			<input type="hidden" name="seq" value="<%="${seq}"%>" />
			<input type="hidden" name="mallId" value="<%="${mallId}"%>" />
		</div>
		<div class="modal-footer text-center">
			<a data-dismiss="modal" class="btn btn-default" href="#">닫기</a>
			<button type="submit" class="btn btn-primary"><%="${method}"%>하기</button>
		</div>
	</div>
</div>
</script>

<div id="insertModal" class="modal"></div>

<form action="/admin/category/delete" method="post" target="zeroframe">
<div id="deleteModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>카테고리 삭제</legend>
				<blockquote>
					<p>정말 <strong>&quot;<span></span>&quot;</strong> 카테고리를 삭제하시겠습니까?</p>
					<p>하위 카테고리를 포함한 모든 카테고리 정보가 사라집니다!</p>
				</blockquote>
				<input type="hidden" name="seq" value="0" />
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-default" href="#">닫기</a>
				<button type="submit" class="btn btn-danger">삭제하기</button>
			</div>
		</div>
	</div>
</div>
</form>

<div id="orderModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>순서를 저장하고 있습니다</legend>
				<div class="progress progress-striped active">
					<div class="bar" style="width:0%;"></div>
				</div>
				<p class="text-right">작업이 끝날 때까지 조금만 기다려 주세요</p>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.tablednd.js"></script>
<script type="text/javascript">
var submitProc = function(obj) {
	var flag = true;
	$(obj).find("input[alt]").each( function() {
		if(flag && $(this).val() == "") {
			alert($(this).attr("alt") + "란을 입력해주세요");
			flag = false;
			$(this).focus();
		}
	});
	return flag;
};

var callbackProc = function(msg) {
	$("#insertModal").modal("hide");
	$("#deleteModal").modal("hide");

	var callBackMsg = msg.split(':');

	EBCategory.renderList(
		  parseInt(callBackMsg[0], 10) || 1 // depth
		, parseInt(callBackMsg[1], 10) || 0 // parentSeq
	);
};

var modProc = function() {
	if(confirm("해당 내용을 쇼핑몰에 적용하시겠습니까?")) {
		$('#createJs').submit();
	}
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
			data:{depth:depth, parentSeq:parentSeq, mallId:${mallSeq}},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				// 단계를 표시한다
				$("#lv"+depth).html(
					(list.length === 0) ?
						"<tr><td colspan='2' class='text-warning text-center'>" + "카테고리를 추가해 주세요" + "</td></tr>"
						: $("#itemTemplate").tmpl(list)
				);
				$("#lv"+depth).tableDnD({onDragClass:"drag"});

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
	, showInsertModal: function(depth,mallSeq) {
		var vo = {
			seq: 0
			, name: ""
			, parentSeq: parseInt($("#lv"+depth).attr("data-seq"), 10) || 0
			, orderNo: $("#lv"+depth).find("tr[data-seq]").length
			, depth: depth
			, showFlag: "Y"
			, method: "등록"
			, parentCategory: $("#lv"+(depth-1)).find(".current").text()
			, mallId:mallSeq
		};

		if(depth !== 1 && vo.parentSeq === 0) {
			alert("카테고리를 먼저 선택해 주세요");
			return;
		}

		$("#insertModal").html( $("#formTemplate").tmpl(vo) );
		$("#insertModal>div").wrapAll("<form class='form-horizontal' action='/admin/category/new?mallSeq=${mallSeq}' target='zeroframe' method='post' onsubmit='return submitProc(this)'></form>");
		$("#insertModal").modal().find("input").eq(0).focus();
	}
	, showUpdateModal: function(seq) {
		$.ajax({
			url:"/admin/category/vo/ajax",
			type:"get",
			data:{seq:seq},
			dataType:"text",
			success:function(data) {
				var vo = $.parseJSON(data);
				vo.method = "수정";
				
				$("#insertModal").html( $("#formTemplate").tmpl(vo) );
				$("#insertModal>div").wrapAll("<form class='form-horizontal' action='/admin/category/update' target='zeroframe' method='post' onsubmit='return submitProc(this)'></form>");
				$("#insertModal").modal().find("input").eq(0).focus();
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showDeleteModal: function(obj) {
		var seq = parseInt($(obj).parents("tr").attr("data-seq"), 10) || 0;
		var title = $(obj).parents("tr").find(".title").text();

		$("#deleteModal").find("blockquote span").text(title);
		$("#deleteModal").find("input[name=seq]").val(seq);
		$("#deleteModal").modal();
	}
	, saveOrderNo: function(id) {
		var current = 1;
		var length = $(id+">tr[data-seq]").length;
		if(length === 0) {
			alert("카테고리가 하나도 없습니다");
			return;
		}

		$("#orderModal").modal().find(".bar").width(0);
		var t = setTimeout(function(){
			$("#orderModal").modal("hide");
		},10000);
		$(id+">tr[data-seq]").each(function(idx){
			$.ajax({
				url:"/admin/category/update/order",
				type:"get",
				data:{seq:$(this).attr("data-seq"), orderNo:idx},
				dataType:"text",
				success:function(data) {
					$("#orderModal").find(".bar").width((current++/length*100)+"%");
					if(current === length) {
						setTimeout(function(){
							$("#orderModal").modal("hide").find(".bar").width(0);
						}, 1000);
						clearTimeout(t);
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		});
	}
};
$(document).ready(function () {
	setTimeout(function(){
		EBCategory.renderList(1, 0);
	}, 100);

});
</script>
</body>
</html>