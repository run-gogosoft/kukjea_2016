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
          <h1>공통코드 관리 <small></small></h1>
          <ol class="breadcrumb">
            <li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
            <li>시스템 관리</li>
            <li class="active">공통코드 관리</li>
          </ol>
        </section>
        <!-- 콘텐츠 -->
        <section class="content">
        	<div class="row">
        		<div class="col-md-12">
        			<div class="box">
        				<div class="box-header with-border">
        					<!-- <h3 class="box-title"></h3> -->
        					<select id="searchGroupName" style="height:30px;border:1px #ccc solid">
								<option value="">------- 그룹별 조회 -------</option>
							<c:forEach var="item" items="${groupNameList}">
								<option value="${item.groupCode}" ${vo.groupCode eq item.groupCode ? "selected" :  ""}>${item.groupName}</option>
							</c:forEach>
							</select>
							<div class="pull-right">
								<button id="insertButton" class="btn btn-sm btn-info">신규 등록</button>
							</div>
        				</div>
        				<div class="box-body">
        					<table id="list1" class="table table-bordered table-striped">
        						<thead>
        							<tr>
        								<th>seq</th>
										<th>그룹코드</th>
										<th>그룹명</th>
										<th>값</th>
										<th>명칭</th>
										<th>비고/설명</th>
										<th></th>
        							</tr>
        						</thead>
        						<tbody>
        						<c:forEach var="item" items="${list}" varStatus="status">
									<tr>
										<td class="text-center">${item.seq}</td>
										<td class="text-center">${item.groupCode}</td>
										<td class="text-center">${item.groupName}</td>
										<td class="text-center">${item.value}</td>
										<td class="text-center">${item.name}</td>
										<td>${item.note}</td>
										<td class="text-center">
											<button onclick="updateCommon('${item.seq}', '${item.groupCode}', '${item.groupName}', '${item.value}', '${item.name}', '${item.note}');" class="btn btn-xs btn-default">수정</button>
											<button onclick="deleteCommon(${item.seq});" class="btn btn-xs btn-danger">삭제</button>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${ fn:length(list)==0 }">
									<tr><td class="text-center" colspan="7">데이터가 없습니다.</td></tr>
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
	$(document).ready(function () {
		$("#searchGroupName").change(function() {
			var searchGroupCode=$("#searchGroupName").val();
			location.href = "/admin/system/common/list?groupCode="+ searchGroupCode;
		});
	});
	//신규등록
	$("#insertButton").click(function () {
		$.msgbox("<p>공통코드 신규 등록</p>", {
			type    : "prompt",
			inputs  : [
				{type: "text", label: "그룹코드:", required: true},
				{type: "text", label: "그룹명:", required: true},
				{type: "text", label: "값:", required: true},
				{type: "text", label: "명칭:", required: true},
				{type: "text", label: "비고/설명:", required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: 'cancel', value: 'Exit'}
			]
		}, function(groupCode, groupName, value, name, note) {
			if(!groupCode){
			}else if(/[\D]/.test(groupCode)){
				$.msgbox("그룹코드는 문자 입력이 불가능합니다.", {type: "error"});
			}else{
				$.ajax({
					type: 'POST',
					data: {
						groupCode:groupCode,
						groupName:groupName,
						value:value,
						name:name,
						note:note
					},
					dataType: 'json',
					url: '/admin/system/common/insert/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function() {
								location.href="/admin/system/common/list?groupCode=" + groupCode + "&groupName=" + groupName;
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
	var updateCommon = function(seq, curGroupCode, curGroupName, curValue, curName, curNote) {
		$.msgbox("<p>공통코드 수정 (" + seq +  ")</p>", {
			type: "prompt",
			inputs: [
				{type: "text", label: "그룹코드:", value: curGroupCode, required: true},
				{type: "text", label: "그룹명:", value: curGroupName, required: true},
				{type: "text", label: "값:", value: curValue, required: true},
				{type: "text", label: "명칭:", value: curName, required: true},
				{type: "text", label: "비고/설명:", value: curNote, required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
		}, function(groupCode, groupName, value, name, note) {
			if(!groupCode){
			}else if(/[\D]/.test(groupCode)){
				$.msgbox("그룹코드는 문자 입력이 불가능합니다.", {type: "error"});
			}else{
				$.ajax({
					type: 'POST',
					data: {
						seq:seq,
						groupCode:groupCode,
						groupName:groupName,
						value:value,
						name:name,
						note:note
					},
					dataType: 'json',
					url: '/admin/system/common/update/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function() {
								location.href="/admin/system/common/list?groupCode=" + groupCode + "&groupName=" + groupName;
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
	var deleteCommon = function(seq) {
		$.msgbox("<p>정말로 " + seq + "번 시퀀스의 공통코드를 삭제하시겠습니까?</p>", {
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
					url: '/admin/system/common/delete/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"}, function() {
								location.href="/admin/system/common/list";
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
