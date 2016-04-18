<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/member_mod.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		#popup-zone {
      margin-top:-5px;
    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="body-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>

	<div class="main-content-wrap">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 나의정보 <span class="breadcrumb-arrow">&gt;</span> <strong>개인정보 관리/수정</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는 기재하신 회원정보가 공개되지 않습니다.</div>
		<div class="board-title-sub">
			<div>고객님의 회원정보를 수정하실 수 있습니다.</div>
			<div>보다 다양한 서비스를 받으시려면 정확한 정보를 항상 유지해 주셔야 합니다.</div>
			<div>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</div>
		</div>

		<form class="form-horizontal" role="form" method="post" onsubmit="return CHProcessUtil.submitProc(this);" action="/shop/mypage/mod/proc" target="zeroframe">
			<c:choose>
				<c:when test="${sessionScope.loginMemberTypeCode eq 'C'}">
					<%--개인회원--%>
					<div class="sign-form form1" style="height:700px">
						<div class="inner">
							<div class="title-back">
								<div class="title-wrap">
									<div class="title">기본정보</div>
									<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
								</div>
							</div>
							<table id="defaultTable" class="table sign-table">
								<tr>
									<td>이름</td>
									<td>${vo.name}</td>
								</tr>
								<tr>
									<td>아이디</td>
									<td>${vo.id}</td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td>
										<button type="button" id="pwdBtn" class="btn btn-default" style="margin-left:0;" onclick="CHPasswordUtil.writeButton()">
											<span>비밀번호 변경</span>
										</button>
										<!-- <span class="description">8~16자의 영문과 국문이 포함이 되어야 합니다.</span> -->
									</td>
								</tr>
								<tr>
									<td>이메일<span>*</span></td>
									<td>
										<input type="text" class="form-control" name="email1" value="${vo.email1}" maxlength="30" alt="이메일" />
										@
										<input type="text" class="form-control" id="email2" name="email2" value="${vo.email2}" alt="이메일" maxlength="30"/>
										<select class="form-control" id="getEmail">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="nate.com">nate.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="paran.com">paran.com</option>
											<option value="korea.com">korea.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="yahoo.co.kr">yahoo.co.kr</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>휴대폰번호<span>*</span></td>
									<td>
										<input type="text" name="cell1" value="${vo.cell1}" class="form-control" onblur="numberCheck(this);" maxlength="3" alt="휴대폰번호">&nbsp;-&nbsp;
										<input type="text" name="cell2" value="${vo.cell2}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="휴대폰번호">&nbsp;-&nbsp;
										<input type="text" name="cell3" value="${vo.cell3}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="휴대폰번호">
									</td>
								</tr>
								<tr>
									<td>전화번호</td>
									<td>
										<input type="text" name="tel1" value="${vo.tel1}" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
										<input type="text" name="tel2" value="${vo.tel2}" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
										<input type="text" name="tel3" value="${vo.tel3}" class="form-control" onblur="numberCheck(this);" maxlength="4">
									</td>
								</tr>
								<tr>
									<td>주소<span>*</span></td>
									<td>
										<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" alt="우편번호" readonly />
										<button type="button" class="btn btn-default" onclick="CHPostCodeUtil.postWindow('open', '#defaultTable');"><span>우편번호찾기</span></button>
										<span class="description">사업자등록증 상의 주소를 입력해주세요.</span>
										<br/>
										<input type="text" class="form-control addr" name="addr1" value="${vo.addr1}" maxlength="100" alt="주소" readonly /><br/>
										<input type="text" class="form-control addr" name="addr2" value="${vo.addr2}" maxlength="100" alt="상세주소" />
									</td>
								</tr>
								<tr>
									<td style="height: 96px;">
										이메일/SMS
										<br/>
										수신여부<span>*</span>
									</td>
									<td>
										<div class="radio-wrap">
											<div class="description">· 뉴스레터 수신동의</div>
											<div>
												<input type="radio" class="radio" id="emailReceiveFlagY" name="emailFlag" value="Y" style="vertical-align:none;" alt="이메일 수신여부" <c:if test="${vo.emailFlag eq 'Y'}">checked="checked"</c:if> />
												<span>수신동의</span>
											</div>
											<div>
												<input type="radio" class="radio" id="emailReceiveFlagN" name="emailFlag" value="N" alt="이메일 수신여부" <c:if test="${vo.emailFlag eq 'N'}">checked="checked"</c:if> />
												<span>수신거부</span>
											</div>
										</div>
										<div class="radio-wrap">
											<div class="description">· SMS(문자메세지) 수신동의</div>
											<div>
												<input type="radio" class="radio" id="smsReceiveFlagY" name="smsFlag" value="Y" alt="SMS 수신여부" <c:if test="${vo.smsFlag eq 'Y'}">checked="checked"</c:if> />
												<span>수신동의</span>
											</div>
											<div>
												<input type="radio" class="radio" id="smsReceiveFlagN" name="smsFlag" value="N" alt="SMS 수신여부" <c:if test="${vo.smsFlag eq 'N'}">checked="checked"</c:if> />
												<span>수신거부</span>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<%--기업/시설/단체회원, 기관회원--%>
					<input type="hidden" name="groupSeq" value="${vo.groupSeq}"> <%--공공기관, 기업 회원일경우 그룹 시퀀스가 존재하기때문에 넘겨줘야한다.--%>
					<div class="sign-form form1" <c:if test="${sessionScope.loginMemberTypeCode eq 'O'}">style="height:670px"</c:if>>
						<div class="inner">
							<div class="title-back">
								<div class="title-wrap">
									<div class="title">기본정보</div>
									<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
								</div>
							</div>
							<table id="defaultTable" class="table sign-table">
								<tr>
									<td>기관명</td>
									<td>
										<!-- <input type="text" name="groupName" class="form-control" maxlength="30" alt="기관명"> -->
										${gvo.name}
									</td>
								</tr>
								<tr>
									<td>사업자 등록번호</td>
									<td>
										<!-- <input type="text" name="bizNo1" class="form-control" onblur="numberCheck(this);" maxlength="3" alt="사업자 등록번호">&nbsp;-&nbsp; -->
										<!-- <input type="text" name="bizNo2" class="form-control" onblur="numberCheck(this);" maxlength="2" alt="사업자 등록번호">&nbsp;-&nbsp; -->
										<!-- <input type="text" name="bizNo3" class="form-control" onblur="numberCheck(this);" maxlength="5" alt="사업자 등록번호"> -->
										${fn:substring(gvo.bizNo,0,3)}-${fn:substring(gvo.bizNo,3,5)}-${fn:substring(gvo.bizNo,5,10)}
									</td>
								</tr>
								<tr>
									<td>회원아이디</td>
									<td>
										${vo.id}
									</td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td>
										<button type="button" id="pwdBtn" class="btn btn-default" style="margin-left:0;" onclick="CHPasswordUtil.writeButton()">
											<span>비밀번호 변경</span>
										</button>
									</td>
								</tr>
								<tr>
									<td>대표자<span>*</span></td>
									<td>
										<input type="text" name="ceoName" value="${gvo.ceoName}" class="form-control" maxlength="10" alt="대표자">
									</td>
								</tr>
								<tr>
									<td>업태/업종</td>
									<td><input type="text" name="bizType" value="${gvo.bizType}" class="form-control" maxlength="30"> / <input type="text" name="bizKind" value="${gvo.bizKind}" class="form-control" maxlength="30"></td>
								</tr>
								<tr>
									<td>팩스번호</td>
									<td>
										<c:set var="splitFax" value="${fn:split(gvo.fax, '-')}"/>
										<input type="text" name="fax1" value="${splitFax[0]}" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
										<input type="text" name="fax2" value="${splitFax[1]}" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
										<input type="text" name="fax3" value="${splitFax[2]}" class="form-control" onblur="numberCheck(this);" maxlength="4">
									</td>
								</tr>
								<%-- 공공기관일 경우만 소속 자치구 항목이 존재한다. --%>
								<c:if test="${sessionScope.loginMemberTypeCode eq 'P'}">
									<tr>
										<td>소속 자치구<span>*</span></td>
										<td>
											<select class="form-control" id="jachiguSido" alt="소속 자치구 시/도">
												<option value="">-- 시/도 --</option>
												<option value="01" <c:if test="${gvo.jachiguCode ne ''}">selected</c:if>>서울시</option>
												<option value="99" <c:if test="${gvo.jachiguCode eq ''}">selected</c:if>>기타</option>
											</select>
											&nbsp;&nbsp;
											<select class="form-control" id="jachiguCode" name="jachiguCode" style="display:none;" alt="자치구">
												<option value="">-- 자치구 --</option>
												<c:forEach var="item" items="${jachiguList}">
													<option value="${item.value}" <c:if test="${gvo.jachiguCode eq item.value}">selected</c:if>>${item.name}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
								</c:if>
								<tr>
									<td>주소<span>*</span></td>
									<td>
										<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" alt="우편번호" readonly />
										<button type="button" class="btn btn-default" onclick="CHPostCodeUtil.postWindow('open' , '#defaultTable');"><span>우편번호찾기</span></button>
										<span class="description">사업자등록증 상의 주소를 입력해주세요.</span>
										<br/>
										<input type="text" class="form-control addr" name="addr1" value="${vo.addr1}" maxlength="100" alt="주소" readonly /><br/>
										<input type="text" class="form-control addr" name="addr2" value="${vo.addr2}" maxlength="100" alt="상세주소" />
									</td>
								</tr>
							</table>
						</div>
					</div>

					<div class="sign-form form2">
						<div class="inner">
							<div class="title-back">
								<div class="title-wrap">
									<div class="title">기본정보</div>
									<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
								</div>
							</div>
							<table class="table sign-table">
								<tr>
									<td>담당자 이름<span>*</span></td>
									<td><input type="text" name="name" value="${vo.name}" class="form-control" maxlength="15" alt="담당자 이름"></td>
								</tr>
								<tr>
									<td>부서명 / 직책</td>
									<td>
										<input type="text" name="deptName" value="${vo.deptName}" class="form-control" maxlength="15">&nbsp;&nbsp;/&nbsp;&nbsp;<input type="text" name="posName" value="${vo.posName}" class="form-control" maxlength="15">
									</td>
								</tr>
								<tr>
									<td>담당자 이메일<span>*</span></td>
									<td>
										<input type="text" class="form-control" name="email1" value="${vo.email1}" maxlength="30" alt="담당자 이메일" />
										@
										<input type="text" class="form-control" id="email2" name="email2" value="${vo.email2}" alt="담당자 이메일" maxlength="30"/>
										<select class="form-control" id="getEmail">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="nate.com">nate.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="paran.com">paran.com</option>
											<option value="korea.com">korea.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="yahoo.co.kr">yahoo.co.kr</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>담당자 휴대폰번호<span>*</span></td>
									<td>
										<input type="text" name="cell1" value="${vo.cell1}" class="form-control" onblur="numberCheck(this);" maxlength="3" alt="담당자 휴대폰번호">&nbsp;-&nbsp;
										<input type="text" name="cell2" value="${vo.cell2}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 휴대폰번호">&nbsp;-&nbsp;
										<input type="text" name="cell3" value="${vo.cell3}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 휴대폰번호">
									</td>
								</tr>
								<tr>
									<td>담당자 유선전화<span>*</span></td>
									<td>
										<input type="text" name="tel1" value="${vo.tel1}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 유선전화">&nbsp;-&nbsp;
										<input type="text" name="tel2" value="${vo.tel2}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 유선전화">&nbsp;-&nbsp;
										<input type="text" name="tel3" value="${vo.tel3}" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 유선전화">
									</td>
								</tr>
								<tr>
									<td style="height: 96px;">
										이메일/SMS
										<br/>
										수신여부<span>*</span>
									</td>
									<td>
										<div class="radio-wrap">
											<div class="description">· 뉴스레터 수신동의</div>
											<div>
												<input type="radio" class="radio" id="emailReceiveFlagY" name="emailFlag" value="Y" style="vertical-align:none;" alt="이메일 수신여부" <c:if test="${vo.emailFlag eq 'Y'}">checked="checked"</c:if>/>
												<span>수신동의</span>
											</div>
											<div>
												<input type="radio" class="radio" id="emailReceiveFlagN" name="emailFlag" value="N" alt="이메일 수신여부" <c:if test="${vo.emailFlag eq 'N'}">checked="checked"</c:if>/>
												<span>수신거부</span>
											</div>
										</div>
										<div class="radio-wrap">
											<div class="description">· SMS(문자메세지) 수신동의</div>
											<div>
												<input type="radio" class="radio" id="smsReceiveFlagY" name="smsFlag" value="Y" alt="SMS 수신여부" <c:if test="${vo.smsFlag eq 'Y'}">checked="checked"</c:if>/>
												<span>수신동의</span>
											</div>
											<div>
												<input type="radio" class="radio" id="smsReceiveFlagN" name="smsFlag" value="N" alt="SMS 수신여부" <c:if test="${vo.smsFlag eq 'N'}">checked="checked"</c:if>/>
												<span>수신거부</span>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>

					<div class="sign-form form3">
						<div class="inner">
							<div class="title-back">
								<div class="title-wrap">
									<div class="title">기본정보</div>
									<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
								</div>
							</div>
							<table class="table sign-table">
								<tr>
									<td>계산서 담당자 성명</td>
									<td><input type="text" name="taxName" value="${gvo.taxName}" class="form-control" maxlength="15"></td>
								</tr>
								<tr>
									<td>계산서 담당자 이메일</td>
									<td>
										<input type="text" class="form-control" name="taxEmail1" value="${gvo.taxEmail1}" maxlength="30"/>
										@
										<input type="text" class="form-control" id="taxEmail2" name="taxEmail2" value="${gvo.taxEmail2}" maxlength="30"/>
										<select class="form-control" id="getTaxEmail">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="nate.com">nate.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="paran.com">paran.com</option>
											<option value="korea.com">korea.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="yahoo.co.kr">yahoo.co.kr</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>계산서 담당자 전화번호</td>
									<td>
										<input type="text" name="taxTel1" value="${gvo.taxTel1}" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
										<input type="text" name="taxTel2" value="${gvo.taxTel2}" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
										<input type="text" name="taxTel3" value="${gvo.taxTel3}" class="form-control" onblur="numberCheck(this);" maxlength="4">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</c:otherwise>
			</c:choose>

			<div class="button-wrap">
				<button type="submit" class="btn btn-confirm"><span>확인</span></button>
				<button type="button" class="btn btn-cancel" onclick="location.href='/shop/mypage/confirm'"><span>취소</span></button>
			</div>
		</form>
	</div>
</div>
<div class="clearfix"></div>
<%--비밀번호 변경 레이어--%>
<div class="hh-password-box">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header"><span class="title">비밀번호 변경</span></div>
		<div class="hh-writebox-content">
			<form class="form-horizontal" name="pwForm" role="form" method="post" onsubmit="return CHProcessUtil.passwordProc(this)" action="/shop/member/password/update" target="zeroframe">
				<div class="hh-mypage-pw-text">
					8~16자의 영문/숫자/특수문자만 가능 합니다.<br/>
				</div>
				<div class="hh-mypage-pw-form">
					<div>·기존 비밀번호 입력<input type="password" id="password" name="password" class="form-control" maxlength="16" alt="기존비밀번호" /></div>
					<div style="margin-top: 5px;">·새 비밀번호 입력<input type="password" id="newPassword" class="form-control" name="newPassword" style="margin-left: 40px;" maxlength="16" alt="새 비밀번호입력" /></div>
					<div style="margin-top: 5px;">·새 비밀번호 확인<input type="password" id="newPassword_confirm" class="form-control" style="margin-left: 40px;" maxlength="16" alt="새 비밀번호확인" /></div>
				</div>

				<div class="hh-writebox-footer">
					<div class="inner">
						<button type="submit" class="btn btn-qna-submit">변경하기</button>
						<button type="button" onclick="CHPasswordUtil.writeClose();" class="btn btn-qna-cancel">취소하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" >
	CHPasswordUtil = {
		writeButton:function (){
			$(".hh-password-box").show().css({top:$("#pwdBtn").offset().top-100});
		}
		, writeClose:function () {
			$("#password").val('');
			$("#newPassword").val('');
			$("#newPassword_confirm").val('');
			$(".hh-password-box").hide();
		}
	};


	CHProcessUtil = {
		submitProc:function(obj) {
			var flag = true;
			$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
				if(flag && $(this).val() == "") {
					alert($(this).attr("alt") + "란을 입력해주세요!");
					flag = false;
					$(this).focus();
				}
			});
			return flag;
		}
		, passwordProc:function(obj) {
			var flag = true;
			$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
				if(flag && $(this).val() == "") {
					alert($(this).attr("alt") + "란을 입력해주세요!");
					flag = false;
					$(this).focus();
				}
			});
			if(!flag) {
				return false;
			}
			
			if($("#newPassword").val() != $("#newPassword_confirm").val()) {
				alert("패스워드가 일치하지 않습니다.");
				$("#newPassword").focus();
				return false;
			}
			
			return true;
		}
	};

	$(document).ready(function(){
		$('#getEmail').change(function(){
			$('#email2').val($('#getEmail').val());
		});

		$('#getTaxEmail').change(function(){
			$('#taxEmail2').val($('#getTaxEmail').val());
		});

		//자치구 데이터가 존재한다면 자치구 selectbox를 노출시킨다.
		var jachiguCode = "${gvo.jachiguCode}";
		if(jachiguCode !== '') {
			$("#jachiguCode").css("display","inline");
		}

		//소속 자치구 이벤트 컨트롤
		$("#jachiguSido").change(function() {
			if($(this).val() == "01") {
				//서울시일 경우에만 자치구 선택 가능
				$("#jachiguCode").css("display","inline");
				$("#jachiguCode").val("");
			} else {
				$("#jachiguCode").css("display","none");
				$("#jachiguCode").val($(this).val());
			}
		});
	});
	
	var callbackProc = function(flag) {
		if( flag == "Y" ) {
			CHPasswordUtil.writeClose();
		}
	};
</script>
</body>
</html>