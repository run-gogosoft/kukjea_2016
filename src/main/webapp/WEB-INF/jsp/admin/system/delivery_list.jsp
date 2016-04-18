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
			<h1>배송업체 관리<small></small></h1>
			<ol class="breadcrumb">
				<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
				<li>시스템 관리</li>
				<li class="active">배송업체 관리</li>
			</ol>
		</section>
        <!-- 콘텐츠 -->
        <section class="content">
        	<div class="row">
        		<div class="col-xs-12">
        			<div class="box">
        				<!-- 제목 -->
        				<div class="box-header with-border">
        					<!-- <h3 class="box-title"></h3> -->
        					<div class="pull-right">
								<button id="insertButton" class="btn btn-info btn-sm">신규 등록</button>
							</div>
        				</div>
        				<!-- 내용 -->
        				<div class="box-body">
        					<table id="list1" class="table table-bordered table-striped">
        						<thead>
        							<tr>
										<th>seq</th>
										<th>업체명</th>
										<th>전화번호</th>
										<th>송장조회 URL</th>
										<th>배송완료 메시지</th>
										<th>사용여부</th>
										<th></th>
									</tr>
        						</thead>
        						<tbody>
        						<c:forEach var="item" items="${list}" varStatus="status">
									<tr>
										<td class="text-center">${item.deliSeq}</td>
										<td class="text-center">${item.deliCompanyName}</td>
										<td class="text-center">${item.deliCompanyTel}</td>
										<td>${item.deliTrackUrl}</td>
										<td>${item.completeMsg}</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${item.useFlag=='Y'}">
													사용
												</c:when>
												<c:when test="${item.useFlag=='N'}">
													사용안함
												</c:when>
											</c:choose>
										</td>
										<td class="text-center">
											<button onclick="updateDelivery('${item.deliSeq}','${item.deliCompanyName}','${item.deliCompanyTel}','${item.deliTrackUrl}','${item.completeMsg}','${item.useFlag}');" class="btn btn-xs btn-warning">수정</button>
											<button onclick="deleteDelivery('${item.deliSeq}');" class="btn btn-xs btn-danger">삭제</button>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="7">등록된 내용이 없습니다.</td></tr>
								</c:if>
        						</tbody>
        					</table>
        				</div>
        			</div>
        		</div>
        	</div>
        </section>
	</div>
	<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>

<script type="text/javascript">
	//신규등록
	$("#insertButton").click(function () {
		$.msgbox("<p>배송업체 등록</p>", {
			type    : "prompt",
			inputs  : [
				{type: "text", label: "업체명:", required: true},
				{type: "text", label: "전화번호:", required: true},
				{type: "text", label: "송장조회 URL:", required: true},
				{type: "text", label: "배송완료 메시지:", required: true},
				{type: "radio", label: "사용", value: "Y", required: true},
				{type: "radio", label: "사용안함", value: "N", required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
			//OK,Exit 어느버튼을 누르던지 function은 실행된다
			//OK버튼을 누를시 텍스트값이 모두 submit 되지만
			//Exit버튼을 누르면 첫번째 텍스트에 값이 있던지 없던지 false로 보내진다(나머지 텍스트는 undefined)
			//그래서 조건을 걸어주어서 Exit버튼을 누르면 그냥 종료되고
			//OK버튼을 누르면 ajax가 실행되게 수정
		}, function(deliCompanyName, deliCompanyTel, deliTrackUrl, completeMsg) {
			if(!deliCompanyName){
			}else{
				$.ajax({
					type: 'POST',
					data: {
						deliCompanyName: deliCompanyName,
						deliCompanyTel: deliCompanyTel,
						deliTrackUrl: deliTrackUrl,
						completeMsg: completeMsg,
						useFlag: $('input[name=useFlag]:checked').val()
					},
					dataType: 'json',
					url: '/admin/system/delivery/insert/ajax',
					success: function (data) {
						if (data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function () {
								location.href = "/admin/system/delivery/list";
							});
						} else {
							$.msgbox(data.message, {type: "error"});
						}
					}
				})
			}
		});
	});

	//수정
	var updateDelivery = function(deliSeq, deliCompanyName, deliCompanyTel, deliTrackUrl, completeMsg, useFlag) {
		if(deliSeq === '0' || typeof deliSeq === 'undefined'){
			alert('오류가 발생하였습니다.');
			return;
		}

		$.msgbox("<p>배송업체 수정 (" + deliSeq +  ")</p>", {
			type: "prompt",
			inputs: [
				{type: "hidden", value: deliSeq, required: true},
				{type: "text", label: "업체명:", value: deliCompanyName, required: true},
				{type: "text", label: "전화번호:", value: deliCompanyTel, required: true},
				{type: "text", label: "송장조회 URL:", value: deliTrackUrl, required: true},
				{type: "text", label: "배송완료 메시지:", value: completeMsg, required: true},
				{type: "radio", label: "사용", value: "Y",checked: useFlag, required: true},
				{type: "radio", label: "사용안함", value: "N",checked: useFlag, required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
		}, function(deliSeq, deliCompanyName, deliCompanyTel, deliTrackUrl, completeMsg) {
			if(!deliCompanyName){
			}else{
				$.ajax({
					type: 'POST',
					data: {
						deliSeq: deliSeq,
						deliCompanyName: deliCompanyName,
						deliCompanyTel: deliCompanyTel,
						deliTrackUrl: deliTrackUrl,
						completeMsg: completeMsg,
						useFlag: $('input[name=useFlag]:checked').val()
					},
					dataType: 'json',
					url: '/admin/system/delivery/update/ajax',
					success: function (data) {
						if (data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function () {
								location.href = "/admin/system/delivery/list";
							});
						} else {
							$.msgbox(data.message, {type: "error"});
						}
					}
				})
			}
		});
	};

	//삭제
	var deleteDelivery = function(deliSeq) {
		$.msgbox("<p>정말로 " + deliSeq + "번 시퀀스의 배송업체를 삭제하시겠습니까?</p>", {
			type: "confirm",
			buttons : [
				{type: "submit", value: "Yes"},
				{type: "cancel", value: "Cancel"}
			]
		}, function(result) {
			if(result === "Yes") {
				$.ajax({
					type: 'POST',
					data: {
						deliSeq:deliSeq
					},
					dataType: 'json',
					url: '/admin/system/delivery/delete/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function() {
								location.href="/admin/system/delivery/list";
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

