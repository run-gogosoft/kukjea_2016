<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<link href="/assets/css/postcode.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>회원 정보 수정 <small>Modify Member Infomation</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li>회원 리스트</li>
			<li class="active">회원 정보 수정</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<c:if test="${gvo ne null}">
			<div class="col-md-6">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border"><h3 class="box-title"><i class="fa fa-edit"></i> ${vo.memberTypeName} 정보 수정</h3></div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="/admin/member/group/mod" target="zeroframe" class="form-horizontal" onsubmit="return submitForm(this)">
						<input class="form-control" type="hidden" name="memberSeq" value="${vo.seq}"/>
						<input class="form-control" type="hidden" name="seq" value="${gvo.seq}"/>
						<div id="groupBox" class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">${vo.memberTypeName}명</label>
								<div class="col-md-3 form-control-static">${gvo.name}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">사업자 등록 번호</label>
								<div class="col-md-3 form-control-static">${fn:substring(gvo.bizNo,0,3)}-${fn:substring(gvo.bizNo,3,5)}-${fn:substring(gvo.bizNo,5,10)}</div>	
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">사업자 주소</label>
								<div class="col-md-4">
									<div class="input-group">
										<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" data-required-label="우편번호" alt="우편번호" readonly />		
									</div>
								</div>
								<div class="col-md-1 form-control-static">
									<a href="#" onclick="CHPostCodeUtil.postWindow('open' , '#groupBox');" class="btn btn-xs btn-primary">우편번호검색</a>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-4">
									<input class="form-control" type="text" id="addr1" name="addr1" value="${vo.addr1}" maxlength="100" placeholder="주소" data-required-label="주소" readonly/>
								</div>
								<div class="col-md-5">
									<input class="form-control" type="text" id="addr2" name="addr2" value="${vo.addr2}" maxlength="100" placeholder="상세 주소" data-required-label="상세 주소"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">대표자</label>
								<div class="col-md-3">
									<input class="form-control" type="text" id="ceoName" name="ceoName" value="${gvo.ceoName}" maxlength="10"/>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">업태 / 종목</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" id="bizType" name="bizType" value="${gvo.bizType}" maxlength="30" placeholder="업태"/>
										<div class="input-group-addon" style="border:0"> / </div>
										<input class="form-control" type="text" id="bizKind" name="bizKind" value="${gvo.bizKind}" maxlength="30" placeholder="종목"/>
									</div>
									
								</div>									
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">소속 자치구</label>
								<div class="col-md-3">
									<select class="form-control" id="jachiguSido" alt="소속 자치구 시/도">
										<option value="">--- 시/도 ---</option>
										<option value="01">서울시</option>
										<option value="99">기타</option>
									</select>
								</div>
								<div class="col-md-3">
									<select class="form-control" id="jachiguCode" name="jachiguCode" style="display:none;" alt="자치구">
										<option value="">--- 자치구 ---</option>
										<c:forEach var="item" items="${jachiguList}">
											<option value="${item.value}" ${gvo.jachiguCode eq item.value ? "selected":""}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="tel1">팩스 번호</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" id="fax1" name="fax1" value="${gvo.fax1}" maxlength="4" onblur="numberCheck(this);"/>
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="fax2" name="fax2" value="${gvo.fax2}" maxlength="4" onblur="numberCheck(this);"/>
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="fax3" name="fax3" value="${gvo.fax3}" maxlength="4" onblur="numberCheck(this);"/>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">세금계산서 담당자</label>
								<div class="col-md-3">
									<input class="form-control" type="text" id="taxName" name="taxName" value="${gvo.taxName}" maxlength="15"/>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">세금계산서 이메일</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" name="taxEmail1" value="${gvo.taxEmail1}" maxlength="50"/>
										<div class="input-group-addon" style="border:0">@</div>
										<input class="form-control" type="text" name="taxEmail2" value="${gvo.taxEmail2}" maxlength="50"/>
									</div>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">세금계산서 연락처</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" id="taxTel1" name="taxTel1" value="${gvo.taxTel1}" maxlength="4" onblur="numberCheck(this);"/>
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="taxTel2" name="taxTel2" value="${gvo.taxTel2}" maxlength="4" onblur="numberCheck(this);"/>
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="taxTel3" name="taxTel3" value="${gvo.taxTel3}" maxlength="4" onblur="numberCheck(this);"/>
									</div>
								</div>	
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-info">수정하기</button>
							<button type="button" class="btn btn-default" onclick="history.go(-1);">목록보기</button>
						</div>
					</form>
				</div>
			</div>
			</c:if>
			<div class="col-md-${gvo eq null ? "12":"6" }">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border"><h3 class="box-title"><i class="fa fa-edit"></i> ${gvo eq null ? "회원" : "담당자"} 정보 수정</h3></div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="/admin/member/mod" target="zeroframe" class="form-horizontal">
						<input class="form-control" type="hidden" name="seq" value="${vo.seq}"/>
						<div id="normalBox" class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">아이디</label>
								<div class="col-md-2 form-control-static">${vo.id}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">이름</label>
								<div class="col-md-2 form-control-static">${vo.name}</div>
							</div>
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
								<div class="form-group">
									<label class="col-md-2 control-label">비밀번호</label>
									<div class="col-md-3">
										<button type="button" id="changePassword" class="btn btn-sm btn-warning">비밀번호 변경</button>
									</div>
								</div>
							</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label">상태</label>
								<div class="col-md-2 form-control-static">${vo.statusText}</div>
							</div>
							<%--
							<div class="form-group">
								<label class="col-md-2 control-label">등급</label>
								<div class="col-md-2 form-control-static">${vo.gradeText}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2 form-control-static">${vo.mallName}</div>
							</div> 
							<div class="form-group">
								<label class="col-md-2 control-label">보유 포인트</label>
								<div class="col-md-2 form-control-static">
									<fmt:formatNumber value="${vo.point}" pattern="#,###" /> P
								</div>
							</div> 
							--%>
							<div class="form-group">
								<label class="col-md-2 control-label">부서명</label>
								<div class="col-md-3">
									<input class="form-control" type="text" id="deptName" name="deptName" value="${vo.deptName}" maxlength="15"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">직책</label>
								<div class="col-md-3">
									<input class="form-control" type="text" id="posName" name="posName" value="${vo.posName}" maxlength="15"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">이메일</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" name="email1" value="${vo.email1}" maxlength="50"/>
										<div class="input-group-addon" style="border:0">@</div>
										<input class="form-control" type="text" name="email2" value="${vo.email2}" maxlength="50"/>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="tel1">유선 전화</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" id="tel1" name="tel1" value="${vo.tel1}" maxlength="4" onblur="numberCheck(this);"/>
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="tel2" name="tel2" value="${vo.tel2}" maxlength="4" onblur="numberCheck(this);"/>
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="tel3" name="tel3" value="${vo.tel3}" maxlength="4" onblur="numberCheck(this);"/>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">휴대 전화</label>
								<div class="col-md-6">
									<div class="input-group">
										<input class="form-control" type="text" id="cell1" name="cell1" value="${vo.cell1}" maxlength="4" onblur="numberCheck(this);" />
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="cell2" name="cell2" value="${vo.cell2}" maxlength="4" onblur="numberCheck(this);" />
										<div class="input-group-addon" style="border:0">-</div>
										<input class="form-control" type="text" id="cell3" name="cell3" value="${vo.cell3}" maxlength="4" onblur="numberCheck(this);" />
									</div>
								</div>
							</div>
							<div class="form-group" ${gvo eq null ? "" : "style='display:none'"}>
								<label class="col-md-2 control-label">주소</label>
								<div class="col-md-4">
									<div class="input-group">
										<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" data-required-label="우편번호" alt="우편번호" readonly />		
									</div>
								</div>
								<div class="col-md-1 form-control-static">
									<a href="#" onclick="CHPostCodeUtil.postWindow('open' , '#normalBox');" class="btn btn-xs btn-primary">우편번호검색</a>
								</div>
							</div>
							<div class="form-group" ${gvo eq null ? "" : "style='display:none'"}>
								<div class="col-md-2"></div>
								<div class="col-md-4">
									<input class="form-control" type="text" id="addr1" name="addr1" value="${vo.addr1}" maxlength="100" placeholder="주소" data-required-label="주소" readonly/>
								</div>
								<div class="col-md-5">
									<input class="form-control" type="text" id="addr2" name="addr2" value="${vo.addr2}" maxlength="100" placeholder="상세 주소" data-required-label="상세 주소"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">SMS 수신 여부</label>
								<div class="radio">
									<label><input type="radio" id="smsFlag" name="smsFlag" value="Y" ${vo.smsFlag eq 'Y' ? "checked":"" }/>수신</label>
									<label><input type="radio" id="smsFlag" name="smsFlag" value="N" ${vo.smsFlag eq 'N' ? "checked":"" }/>수신 안함</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">이메일 수신 여부</label>
								<div class="radio">
									<label><input type="radio" id="emailFlag" name="emailFlag" value="Y" ${vo.emailFlag eq 'Y' ? "checked":"" }/>수신</label>
									<label><input type="radio" id="emailFlag" name="emailFlag" value="N" ${vo.emailFlag eq 'N' ? "checked":"" }/>수신 안함</label>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-info">수정하기</button>
							<button type="button" class="btn btn-default" onclick="history.go(-1);">목록보기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script type="text/javascript">
	/* 페이지 로딩시 초기화 */
	$(document).ready(function () {
		//숫자 입력 칸 나머지 문자 입력 막기
		$(".numeric").css("ime-mode", "disabled").numeric();
		//자치구 시/도 항목 기본 설정
		setJachiguSido();
	});
	
	//소속 자치구 이벤트 컨트롤
	$("#jachiguSido").change(function() {
		if($(this).val() == "01") {
			//서울시일 경우에만 자치구 선택 가능
			$("#jachiguCode").css("display","block");
			$("#jachiguCode").val("");
		} else {호
			$("#jachiguCode").css("display","none");
			$("#jachiguCode").val($(this).val());
		}
	});
	
	//자치구 시/도 항목 기본 설정
	var setJachiguSido = function() {
		if($("#jachiguCode").val() == "" || $("#jachiguCode").val() == "99") {
			$("#jachiguCode").css("display","none");
			$("#jachiguSido").val($("#jachiguCode").val());
		} else {
			$("#jachiguCode").css("display","block");
			$("#jachiguSido").val("01");
		}
	}
	
	//비밀번호 변경
	$("#changePassword").click(function () {
		$.msgbox("<p>비밀번호 변경</p>", {
			type    : "prompt",
			inputs  : [
				{type: "password", label: "비밀번호:", required: true},
				{type: "password", label: "비밀번호 확인:", required: true}
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
					url: '/admin/system/member/password/update/ajax',
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
	
	var submitForm = function(formObj) {
		var flag = checkRequiredValue(formObj, "alt")
		if(flag) {
			if(!confirm("수정하시겠습니까?")) {
				return false;
			}
		}
		return flag;
	}
	
	/** 기본 주소찾기 DAUM API */
	var openDaumPostCode = function() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
				$("input[name='postcode1']").val(data.postcode1);
				$("input[name='postcode2']").val(data.postcode2);
				$("input[name='addr1']").val(data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, ''));
	
				//전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
				//아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
				//var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
				//document.getElementById('addr').value = addr;
	
				$("input[name='addr2']").focus();
			}
		}).open();
	}
</script>
<!--[if lte IE 9]>
<style type="text/css">
	.jquery-msgbox-wrapper {
		min-height:0;
		height:150px !important;
	}
</style>
<![endif]-->
</body>
</html>
