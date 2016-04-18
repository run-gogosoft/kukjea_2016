<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
	<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
	<div class="content-wrapper">
		<!-- 제목 -->
		<section class="content-header">
			<h1>결제수단별 수수료 관리 <small></small></h1>
			<ol class="breadcrumb">
            <li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
            <li>시스템 관리</li>
            <li class="active">결제수단별 수수료 관리</li>
          </ol>
        </section>
        <!-- 콘텐츠 -->
        <section class="content">
        	<div class="row">
        		<div class="col-md-12">
        			<div class="box">
        				<div class="box-header with-border">
        					<!-- <h3 class="box-title"></h3> -->
									<div class="pull-right">
										<button id="insertButton" class="btn btn-sm btn-info">신규 등록</button>
									</div>
        				</div>
        				<div class="box-body">
        					<table id="list1" class="table table-bordered table-striped">
        						<thead>
        							<tr>
        								<th>No.</th>
												<th>결제수단명</th>
												<th>값</th>
												<th>수도권</th>
												<th>지방</th>
        							</tr>
        						</thead>
        						<tbody>
	        						<c:forEach var="item" items="${list}" varStatus="status">
												<tr>
													<td class="text-center">${item.seq}</td>
													<td class="text-center">${item.name}</td>
													<td class="text-center">${item.value}</td>
													<td class="text-center">${item.feeRate1}</td>
													<td class="text-center">${item.feeRate2}</td>
													<td class="text-center">
														<button onclick="updateCommon('${item.seq}', '${item.name}', '${item.value}', '${item.feeRate1}', '${item.feeRate2}');" class="btn btn-xs btn-default">수정</button>
														<button onclick="deleteCommon(${item.seq});" class="btn btn-xs btn-danger">삭제</button>
													</td>
												</tr>
											</c:forEach>
											<c:if test="${ fn:length(list)==0 }">
												<tr><td class="text-center" colspan="5">데이터가 없습니다.</td></tr>
											</c:if>
        						</tbody>
        					</table>
        				</div> <!-- .box-body -->
        			</div> <!-- .box -->
        		</div>
        	</div>
        </section>
	</div>
	<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>

<script type="text/javascript">
	//신규등록
	$("#insertButton").click(function () {
		$.msgbox("<p>수수료 관리 신규 등록</p>", {
			type    : "prompt",
			inputs  : [
				{type: "text", label: "결제수단명:", required: true},
				{type: "text", label: "값:", required: true},
				{type: "text", label: "수수료1:", required: true},
				{type: "text", label: "수수료2:", required: true},
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: 'cancel', value: 'Exit'}
			]
		}, function(name, value, feeRate1, feeRate2) {
			$.ajax({
				type: 'POST',
				data: {
					name:name,
					value:value,
					feeRate1:feeRate1,
					feeRate2:feeRate2
				},
				dataType: 'json',
				url: '/admin/system/paymethod/fee/insert/ajax',
				success: function(data) {
					if(data.result === "true") {
						$.msgbox(data.message, {type: "info"}, function() {
							location.href="/admin/system/paymethod/fee/list";
						});
					} else {
						$.msgbox(data.message, {type: "error"});
					}
				}
			});
		});
	});


	//수정
	var updateCommon = function(seq, curName, curValue, curFeeRate1, curFeeRate2) {
		$.msgbox("<p>수수료 관리 수정 (" + seq +  ")</p>", {
			type: "prompt",
			inputs: [
				{type: "text", label: "결제수단명:", value: curName, required: true},
				{type: "text", label: "값:", value: curValue, required: true},
				{type: "text", label: "수수료1:", value: curFeeRate1, required: true},
				{type: "text", label: "수수료2:", value: curFeeRate2, required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
		}, function(name, value, feeRate1, feeRate2) {
				$.ajax({
					type: 'POST',
					data: {
						seq:seq,
						name:name,
						value:value,
						feeRate1:feeRate1,
						feeRate2:feeRate2
					},
					dataType: 'json',
					url: '/admin/system/paymethod/fee/update/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function() {
								location.href="/admin/system/paymethod/fee/list";
							});
						} else {
							$.msgbox(data.message, {type: "error"});
						}
					}
				})
		});
	};

	//삭제
	var deleteCommon = function(seq) {
		$.msgbox("<p>정말로 " + seq + "번 시퀀스의 수수료 관리를 삭제하시겠습니까?</p>", {
			type: "confirm",
			buttons : [
				{type: "submit", value: "Yes"},
				{type: "cancel", value: "Exit"}
			]
		}, function(result) {
			if(result === "Yes") {
				$.ajax({
					type: 'POST',
					data: {
						seq:seq
					},
					dataType: 'json',
					url: '/admin/system/paymethod/fee/delete/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function() {
								location.href="/admin/system/paymethod/fee/list";
							});
						} else {
							$.msgbox(data.message, {type: "error"});
						}
					}
				})
			}
		})
	}
</script>
</body>
</html>
