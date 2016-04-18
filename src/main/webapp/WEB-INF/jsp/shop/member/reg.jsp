<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member_reg.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="main-title">
	${title}
</div>

<%@ include file="/WEB-INF/jsp/shop/include/member_header.jsp" %>
<form name="reg" role="form" method="post" onsubmit="return CHInsertUtil.submitProc(this,'${sessionScope.memberTypeCode}');" action="/shop/member/reg/proc" target="zeroframe">
	<c:choose>
		<c:when test="${sessionScope.memberTypeCode eq 'C'}">
			<%--개인회원--%>
			<div class="sign-form form1" style="height:750px">
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">기본정보</div>
							<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
						</div>
					</div>
					<table id="defaultTable" class="table sign-table">
						<tr>
							<td>이름<span>*</span></td>
							<td><input type="text" name="name" class="form-control" maxlength="15" alt="이름" value="${sessionScope.certName}" readonly/></td>
						</tr>
						<tr>
							<td>아이디<span>*</span></td>
							<td>
								<input type="text" id="id" name="id" class="form-control" maxlength="50" alt="아이디">
								<input type="hidden" id="id_check_flag" value="">
								<button type="button" id="btnIdCheck" class="btn btn-default" onclick="CHInsertUtil.validIdCheck()">
									<span>아이디중복확인</span>
								</button>
								<span class="description">아이디는 6자 이상이어야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td>비밀번호<span>*</span></td>
							<td><input type="password" id="password" name="password" class="form-control" maxlength="16" alt="비밀번호"><span class="description">8~16자의 영문과 숫자가 포함이 되어야 합니다.</span></td>
						</tr>
						<tr>
							<td>비밀번호 재확인<span>*</span></td>
							<td><input type="password" id="passwordCheck" name="passwordCheck" class="form-control" maxlength="16" alt="비밀번호 재확인"><span class="description">비밀번호를 한번 더 입력하여 주십시요.</span></td>
						</tr>
						<tr>
							<td>이메일<span>*</span></td>
							<td>
								<input type="text" class="form-control" id="email1" name="email1" maxlength="30" alt="이메일" />
								@
								<input type="text" class="form-control" id="email2" name="email2" alt="이메일" maxlength="30"/>
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
								<input type="hidden" id="emailCheckFlag" value="">
								<button type="button" id="btnEmailCheck" class="btn btn-default" onclick="CHInsertUtil.validEmailCheck()">
									<span>이메일중복확인</span>
								</button>
							</td>
						</tr>
						<tr>
							<td>휴대폰번호<span>*</span></td>
							<td>
								<input type="text" name="cell1" class="form-control" onblur="numberCheck(this);" maxlength="3" alt="휴대폰번호">&nbsp;-&nbsp;
								<input type="text" name="cell2" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="휴대폰번호">&nbsp;-&nbsp;
								<input type="text" name="cell3" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="휴대폰번호">
							</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td>
								<input type="text" name="tel1" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
								<input type="text" name="tel2" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
								<input type="text" name="tel3" class="form-control" onblur="numberCheck(this);" maxlength="4">
							</td>
						</tr>
						<tr>
							<td>주소<span>*</span></td>
							<td>
								<input type="text" class="form-control" id="postcode" name="postcode" maxlength="5" alt="우편번호" readonly />
								<button type="button" class="btn btn-default" onclick="CHPostCodeUtil.postWindow('open', '#defaultTable');"><span>우편번호찾기</span></button>
								<!-- <span class="description">사업자등록증 상의 주소를 입력해주세요.</span> -->
								<br/>
								<input type="text" class="form-control addr" name="addr1" maxlength="100" alt="주소" readonly /><br/>
								<input type="text" class="form-control addr" name="addr2" maxlength="100" alt="상세주소" />
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
										<input type="radio" class="radio" id="emailReceiveFlagY" name="emailFlag" value="Y" style="vertical-align:none;" alt="이메일 수신여부" checked/>
										<span>수신동의</span>
									</div>
									<div>
										<input type="radio" class="radio" id="emailReceiveFlagN" name="emailFlag" value="N" alt="이메일 수신여부"/>
										<span>수신거부</span>
									</div>
								</div>
								<div class="radio-wrap">
									<div class="description">· SMS(문자메세지) 수신동의</div>
									<div>
										<input type="radio" class="radio" id="smsReceiveFlagY" name="smsFlag" value="Y" alt="SMS 수신여부" checked/>
										<span>수신동의</span>
									</div>
									<div>
										<input type="radio" class="radio" id="smsReceiveFlagN" name="smsFlag" value="N" alt="SMS 수신여부"/>
										<span>수신거부</span>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="sign-form form3" <c:choose><c:when test="${sessionScope.memberTypeCode eq 'O'}">style="height:300px"</c:when><c:when test="${sessionScope.memberTypeCode eq 'C'}">style="height:230px"</c:when></c:choose>>
				<div class="inner">
					<%-- 기업/시설/단체일 경우 부가정보가 보이지 않는다. --%>
					<c:if test="${sessionScope.memberTypeCode ne 'O'}">
						<div class="title-back">
							<div class="title-wrap" style="width:400px">
								<div class="title" style="width:100px;">부가정보</div>
							</div>
							<table class="table sign-table">
								<tr>
									<td>생년월일</td>
									<td>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyy" var="year"/>
										<select name="birthyyyy" class="form-control" style="width:100px;">
											<c:forEach var="i" begin="0" end="${year-1900}">
													<option value="${year-i}">${year-i}</option>
											</c:forEach>
										</select>
										년
										<select name="birthmm" class="form-control" style="width:70px;">
											<c:forEach var="i" begin="1" step="1" end="12">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										월
										<select name="birthdd" class="form-control" style="width:70px;">
											<c:forEach var="i" begin="1" step="1" end="31">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										일
									</td>
								</tr>
								<tr>
									<td>가입경로</td>
									<td>
										<div class="radio-list">
											<div>
												<input type="radio" id="joinPathCode" name="joinPathCode" class="radio" value="1" alt="가입경로"/>
												<span>인터넷</span>
											</div>
											<div>
												<input type="radio" name="joinPathCode" class="radio" value="2" alt="가입경로"/>
												<span>전단지/카탈로그</span>
											</div>
											<div>
												<input type="radio" name="joinPathCode" class="radio" value="3" alt="가입경로"/>
												<span>소개</span>
											</div>
											<div>
												<input type="radio" name="joinPathCode" class="radio" value="9" alt="가입경로"/>
												<span>기타</span>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<%--기업/시설/단체회원, 기관회원--%>
			<div class="sign-form form1" <c:if test="${sessionScope.memberTypeCode eq 'O'}">style="height:750px"</c:if>>
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">기본정보</div>
							<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
						</div>
					</div>
					<table id="defaultTable" class="table sign-table">
						<tr>
							<td>기관명<span>*</span></td>
							<td>
								<input type="text" name="groupName" class="form-control" maxlength="30" alt="기관명">
								<span class="description">ex) 서울시청 사회적경제과</span>
							</td>
						</tr>
						<tr>
							<td>사업자 등록번호<c:if test="${sessionScope.memberTypeCode eq 'O'}"><span>*</span></c:if></td>
							<td>
								<input type="hidden" id="bizno_check_flag" value="N"/>
								<input type="text" id="bizNo1" name="bizNo1" class="form-control" onblur="numberCheck(this);" maxlength="3" <c:if test="${sessionScope.memberTypeCode eq 'O'}">alt="사업자 등록번호"</c:if>>&nbsp;-&nbsp;
								<input type="text" id="bizNo2" name="bizNo2" class="form-control" onblur="numberCheck(this);" maxlength="2" <c:if test="${sessionScope.memberTypeCode eq 'O'}">alt="사업자 등록번호"</c:if>>&nbsp;-&nbsp;
								<input type="text" id="bizNo3" name="bizNo3" class="form-control" onblur="numberCheck(this);" maxlength="5" <c:if test="${sessionScope.memberTypeCode eq 'O'}">alt="사업자 등록번호"</c:if>>
								<c:if test="${sessionScope.memberTypeCode eq 'O'}">
									<button type="button" onclick="CHInsertUtil.checkBizNo()" class="btn btn-default" style="width:120px;"><span>사업자번호 중복확인</span></button>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>회원아이디<span>*</span></td>
							<td>
								<input type="text" id="id" name="id" class="form-control" maxlength="50" alt="회원 아이디">
								<input type="hidden" id="id_check_flag" value="">
								<button type="button" id="btnIdCheck" class="btn btn-default" onclick="CHInsertUtil.validIdCheck()">
									<span>아이디중복확인</span>
								</button>
								<span class="description">아이디는 4자 이상이어야 합니다.</span>
							</td>
						</tr>
						<tr>
							<td>비밀번호<span>*</span></td>
							<td><input type="password" id="password" name="password" class="form-control" maxlength="16" alt="비밀번호"><span class="description">8~16자의 영문과 숫자가 포함이 되어야 합니다.</span></td>
						</tr>
						<tr>
							<td>비밀번호 재확인<span>*</span></td>
							<td><input type="password" id="passwordCheck" name="passwordCheck" class="form-control" maxlength="16" alt="비밀번호 재확인"><span class="description">비밀번호를 한번 더 입력하여 주십시요.</span></td>
						</tr>
						<tr>
							<td>대표자<span>*</span></td>
							<td><input type="text" name="ceoName" class="form-control" maxlength="10" alt="대표자"></td>
						</tr>
						<tr>
							<td>업태/업종</td>
							<td><input type="text" name="bizType" class="form-control" maxlength="15"> / <input type="text" name="bizKind" class="form-control" maxlength="15"></td>
						</tr>
						<tr>
							<td>팩스번호</td>
							<td>
								<input type="text" name="fax1" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
								<input type="text" name="fax2" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
								<input type="text" name="fax3" class="form-control" onblur="numberCheck(this);" maxlength="4">
							</td>
						</tr>
						<%-- 공공기관일 경우만 소속 자치구 항목이 존재한다. --%>
						<c:if test="${sessionScope.memberTypeCode eq 'P'}">
							<tr>
								<td>소속 자치구<span>*</span></td>
								<td>
									<select class="form-control" id="jachiguSido" alt="소속 자치구 시/도">
										<option value="">-- 시/도 --</option>
										<option value="01">서울시</option>
										<option value="99">기타</option>
									</select>
									&nbsp;&nbsp;
									<select class="form-control" id="jachiguCode" name="jachiguCode" style="display:none;" alt="자치구">
										<option value="">-- 자치구 --</option>
										<c:forEach var="item" items="${jachiguList}">
											<option value="${item.value}" <c:if test="${gvo.jachiguCode eq item.value}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
									&nbsp;&nbsp;
									<input type="checkbox" class="checkbox" name="investFlag" value="Y"/>
									<span>투자출연기관</span>
								</td>
							</tr>
						</c:if>
						<tr>
							<td>주소<span>*</span></td>
							<td>
								<input type="text" class="form-control" id="postcode" name="postcode" maxlength="5" alt="우편번호" readonly />
								<button type="button" class="btn btn-default" onclick="CHPostCodeUtil.postWindow('open' , '#defaultTable');"><span>우편번호찾기</span></button>
								<span class="description">사업자등록증 상의 주소를 입력해주세요.</span>
								<br/>
								<input type="text" class="form-control addr" name="addr1" maxlength="100" alt="주소" readonly /><br/>
								<input type="text" class="form-control addr" name="addr2" maxlength="100" alt="상세주소" />
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="sign-form form2">
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">담당자 정보</div>
							<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
						</div>
					</div>
					<table class="table sign-table">
						<tr>
							<td>담당자 이름<span>*</span></td>
							<td><input type="text" name="name" class="form-control" maxlength="15" alt="담당자 이름"></td>
						</tr>
						<tr>
							<td>부서명 / 직책</td>
							<td>
								<input type="text" name="deptName" class="form-control" maxlength="15">&nbsp;&nbsp;/&nbsp;&nbsp;<input type="text" name="posName" class="form-control" maxlength="15">
							</td>
						</tr>
						<tr>
							<td>담당자 이메일<span>*</span></td>
							<td>
								<input type="text" class="form-control" id="email1" name="email1" maxlength="30" alt="담당자 이메일" />
								@
								<input type="text" class="form-control" id="email2" name="email2" alt="담당자 이메일" maxlength="30"/>
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
								<input type="hidden" id="emailCheckFlag" value="">
								<c:if test="${sessionScope.memberTypeCode eq 'O'}">
									<button type="button" id="btnEmailCheck" class="btn btn-default" onclick="CHInsertUtil.validEmailCheck()">
										<span>이메일중복확인</span>
									</button>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>담당자 휴대폰번호<span>*</span></td>
							<td>
								<input type="text" name="cell1" class="form-control" onblur="numberCheck(this);" maxlength="3" alt="담당자 휴대폰번호">&nbsp;-&nbsp;
								<input type="text" name="cell2" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 휴대폰번호">&nbsp;-&nbsp;
								<input type="text" name="cell3" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 휴대폰번호">
							</td>
						</tr>
						<tr>
							<td>담당자 유선전화<span>*</span></td>
							<td>
								<input type="text" name="tel1" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 유선전화">&nbsp;-&nbsp;
								<input type="text" name="tel2" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 유선전화">&nbsp;-&nbsp;
								<input type="text" name="tel3" class="form-control" onblur="numberCheck(this);" maxlength="4" alt="담당자 유선전화">
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
										<input type="radio" class="radio" id="emailReceiveFlagY" name="emailFlag" value="Y" style="vertical-align:none;" alt="이메일 수신여부" checked/>
										<span>수신동의</span>
									</div>
									<div>
										<input type="radio" class="radio" id="emailReceiveFlagN" name="emailFlag" value="N" alt="이메일 수신여부"/>
										<span>수신거부</span>
									</div>
								</div>
								<div class="radio-wrap">
									<div class="description">· SMS(문자메세지) 수신동의</div>
									<div>
										<input type="radio" class="radio" id="smsReceiveFlagY" name="smsFlag" value="Y" alt="SMS 수신여부" checked/>
										<span>수신동의</span>
									</div>
									<div>
										<input type="radio" class="radio" id="smsReceiveFlagN" name="smsFlag" value="N" alt="SMS 수신여부"/>
										<span>수신거부</span>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="sign-form form3" <c:if test="${sessionScope.memberTypeCode eq 'O'}">style="height:300px"</c:if>>
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">세금계산서 담당자</div>
							<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
						</div>
					</div>
					<table class="table sign-table">
						<tr>
							<td>계산서 담당자 성명</td>
							<td><input type="text" name="taxName" class="form-control" maxlength="15"></td>
						</tr>
						<tr>
							<td>계산서 담당자 이메일</td>
							<td>
								<input type="text" class="form-control" name="taxEmail1" maxlength="30"/>
								@
								<input type="text" class="form-control" id="taxEmail2" name="taxEmail2" maxlength="30"/>
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
								<input type="text" name="taxTel1" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
								<input type="text" name="taxTel2" class="form-control" onblur="numberCheck(this);" maxlength="4">&nbsp;-&nbsp;
								<input type="text" name="taxTel3" class="form-control" onblur="numberCheck(this);" maxlength="4">
							</td>
						</tr>
					</table>

					<%-- 기업/시설/단체일 경우 부가정보가 보이지 않는다. --%>
					<c:if test="${sessionScope.memberTypeCode ne 'O'}">
						<div class="title-back">
							<div class="title-wrap" style="width:400px">
								<div class="title" style="width:100px;">부가정보</div>
							</div>
							<table class="table sign-table">
								<tr>
									<td>가입경로</td>
									<td>
										<div class="radio-list">
											<div>
												<input type="radio" id="joinPathCode" name="joinPathCode" class="radio" value="1" alt="가입경로"/>
												<span>인터넷</span>
											</div>
											<div>
												<input type="radio" name="joinPathCode" class="radio" value="2" alt="가입경로"/>
												<span>전단지/카탈로그</span>
											</div>
											<div>
												<input type="radio" name="joinPathCode" class="radio" value="3" alt="가입경로"/>
												<span>소개</span>
											</div>
											<div>
												<input type="radio" name="joinPathCode" class="radio" value="9" alt="가입경로"/>
												<span>기타</span>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
				</div>
			</div>
		</c:otherwise>
	</c:choose>

	<div class="button-wrap">
		<button type="submit" class="btn btn-confirm"><span>확인</span></button>
		<button type="button" class="btn btn-cancel" onclick="goCancel()"><span>취소</span></button>
	</div>
</form>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/member/member.js"></script>
<script type="text/javascript">
	var goCancel = function() {
		if(confirm("회원가입을 취소하시겠습니까?")) {
			location.href='/shop/member/group'
		}
	}

	$(document).ready(function() {
		//email selected
		$('#getEmail').change(function(){
			$('#email2').val($('#getEmail').val());
		});

		$('#getTaxEmail').change(function(){
			$('#taxEmail2').val($('#getTaxEmail').val());
		});

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
</script>
</body>
</html>