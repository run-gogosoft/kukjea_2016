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
		<h1>어드민 관리자 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">어드민 관리자</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-edit"></i> 관리자 정보 수정</h3>
					</div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="/admin/system/admin/modify" target="zeroframe" class="form-horizontal" onsubmit="return doSubmit(this);">
						<input class="form-control" type="hidden" id="checkFlagNickName" name="checkFlagNickName" value="N" />
						<input class="form-control" type="hidden" name="seq" value="${vo.seq}" />
						<input class="form-control" type="hidden" id="validNickName" name="validNickName" />
						<input class="form-control" type="hidden" id="myNickName" value="${vo.nickname}"/>
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">아이디</label>
								<div class="col-md-2 form-control-static">${vo.id}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="name">이름 <i class="fa fa-check"></i></label>
								<div class="col-md-2 form-control-static">
									<input class="form-control" type="text" id="name" name="name" value="${vo.name}" alt="이름" maxlength="20" required/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="name">비밀번호</label>
								<div class="col-md-2 form-control-static">
									<button type="button" id="changePassword" class="btn btn-xs btn-warning">비밀번호 변경</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="nickname">닉네임 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="nickname" name="nickname" value="${vo.nickname}" alt="닉네임" maxlength="20" required/>
								</div>
								<div class="col-md-1 form-control-static">
									<button type="button" id="checkNickName" class="btn btn-xs btn-warning">닉네임 중복체크</button>
								</div>
								<div class="col-md-5">
									* 추후 문의 답변 또는 CS 등 외부에 노출될 수 있는 이름입니다. (현재 미구현)<br />
									* 실제 입점업체 또는 고객사가 알아볼 수 있는 명칭을 사용해 주세요.
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="statusCode">상태 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="statusCode" name="statusCode" required="required">
										<option value="">선택</option>
										<option value="Y" <c:if test="${vo.statusCode == 'Y'}">selected</c:if>>정상</option>
										<option value="H" <c:if test="${vo.statusCode == 'H'}">selected</c:if>>승인대기</option>
										<option value="N" <c:if test="${vo.statusCode == 'N'}">selected</c:if>>중지</option>
										<option value="X" <c:if test="${vo.statusCode == 'X'}">selected</c:if>>탈퇴</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="gradeCode">등급 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="gradeCode" name="gradeCode" required="required">
										<option value="">선택</option>
										<option value="0" <c:if test="${vo.gradeCode == 0}">selected</c:if>>연구소</option>
										<option value="1" <c:if test="${vo.gradeCode == 1}">selected</c:if>>최고 관리자</option>
										<option value="2" <c:if test="${vo.gradeCode == 2}">selected</c:if>>운영 관리자</option>
										<option value="3" <c:if test="${vo.gradeCode == 3}">selected</c:if>>디자이너</option>
										<option value="4" <c:if test="${vo.gradeCode == 4}">selected</c:if>>정산 관리자</option>
										<option value="5" <c:if test="${vo.gradeCode == 5}">selected</c:if>>CS 관리자</option>
										<option value="9" <c:if test="${vo.gradeCode == 9}">selected</c:if>>일반</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="email">이메일</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="email" name="email" value="${vo.email}" maxlength="50"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="tel">전화번호</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="tel" name="tel" value="${vo.tel}" maxlength="20"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="cell">휴대폰 번호</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="cell" name="cell" value="${vo.cell}" maxlength="20"/>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-info">수정하기</button>
							<button type="button" class="btn btn-default" onclick="location.href='/admin/system/admin/list';">목록보기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	//새로고침시 아이디중복체크 초기화
	$(document).ready(function() {
		$("#checkFlag").val("N");
	});

	//관리자 등록
	var doSubmit = function(frmObj) {
		if($('#nickname').val() !== $("#validNickName").val() || $("#checkFlag").val() === "N"){
			//닉네임 중복검사 여부
			if($('#myNickName').val() !== $('#nickname').val()) {
				$.msgbox("닉네임 중복체크를 해주세요.", {type: "error"});
				return false;
			}
		}
		//필수값 체크
		var submit = checkRequiredValue(frmObj, "data-required-label");

		return submit;
	};

	//비밀번호 변경
	$("#changePassword").click(function () {
		$.msgbox("<p>비밀번호 변경</p>", {
			type    : "prompt",
			inputs  : [
				{type: "password", label: "기존 비밀번호:", required: true},
				{type: "password", label: "신규 비밀번호:", required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
		}, function(password, newPassword) {
			if(password) {
				$.ajax({
					type: 'POST',
					data: {
						seq:${vo.seq},
						password:password,
						newPassword:newPassword
					},
					dataType: 'json',
					url: '/admin/system/admin/password/update/ajax',
					success: function(data) {
						if(data.result === "true") {
							$.msgbox(data.message, {type: "info"});
						} else {
							$.msgbox(data.message, {type: "error"});
						}
					}
				})
			}
		});
	});
	/** 닉네임 중복 체크 */
	$("#checkNickName").click(function() {
		var nickname = $("#nickname").val();
		//닉네임 입력여부 검사
		if(nickname === "") {
			alert("닉네임을 입력해주세요.");
			$("#nickname").focus();
			return;
		}
		if($('#myNickName').val() === nickname){
			alert("기존 닉네임 입니다.");
			return;
		}

		//ajax:닉네임중복체크
		$.ajax({
			type: 'POST',
			data: {nickname:nickname},
			dataType: 'json',
			url: '/admin/system/check/nickname/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message, {type: "info"});
					$("#checkFlagNickName").val("Y");
					$("#validNickName").val($("#nickname").val());
				} else {
					$.msgbox(data.message, {type: "error"});
					$("#nickname").focus();
				}
			}
		})
	});
</script>
</body>
</html>
