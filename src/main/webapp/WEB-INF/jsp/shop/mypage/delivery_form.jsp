<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/delivery.css" type="text/css" rel="stylesheet">
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
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 나의정보 <span class="breadcrumb-arrow">&gt;</span> <strong>나의 배송지 관리</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 나의 배송지 관리 입니다.</div>
		<div class="board-title-sub" style="margin-bottom:-10px">
			<div>고객님의 배송지 정보를 저장하실 수 있습니다.</div>
		</div>

		<%-- 배송지 정보 --%>
		<form id="member_form" class="form-horizontal" action="<c:choose><c:when test="${vo eq null}">/shop/mypage/delivery/reg/proc</c:when><c:otherwise>/shop/mypage/delivery/mod/${vo.seq}/proc/</c:otherwise></c:choose>" method="post" target="zeroframe" onsubmit="return doSubmit(this);" role="form" id="memberMod" style="font-size:15px;">
			<div class="sign-form form1">
				<div class="inner">
					<table id="defaultTable" class="table sign-table">
						<tr>
							<td>제목<span>*</span></td>
							<td>
								<input type="text" class="form-control" name="title" id="title" value="${vo.title}" maxlength="15" data-required-label="제목">
								<label style="margin-left:10px;"><input type="checkbox" name="defaultFlag" value="Y" style="width:15px;vertical-align:-10px;margin-right:2px" <c:if test="${vo.defaultFlag eq 'Y'}">checked="checked"</c:if> />&nbsp;기본 배송지로 설정</label>
							</td>
						</tr>
						<tr>
							<td>수취인<span>*</span></td>
							<td><input type="text" class="form-control" name="name" value="${vo.name}" maxlength="15" data-required-label="수취인"></td>
						</tr>
						<tr>
							<td>전화번호<span>*</span></td>
							<td>
								<input type="text" class="form-control" name="tel1" value="${vo.tel1}" maxlength="4" onblur="numberCheck(this);" data-required-label="전화번호">&nbsp;-&nbsp;
								<input type="text" class="form-control" name="tel2" value="${vo.tel2}" maxlength="4" onblur="numberCheck(this);" data-required-label="전화번호">&nbsp;-&nbsp;
								<input type="text" class="form-control" name="tel3" value="${vo.tel3}" maxlength="4" onblur="numberCheck(this);" data-required-label="전화번호">
							</td>
						</tr>
						<tr>
							<td>휴대폰번호<span>*</span></td>
							<td>
								<input type="text" class="form-control" name="cell1" value="${vo.cell1}" maxlength="3" onblur="numberCheck(this);" data-required-label="휴대폰번호">&nbsp;-&nbsp;
								<input type="text" class="form-control" name="cell2" value="${vo.cell2}" maxlength="4" onblur="numberCheck(this);" data-required-label="휴대폰번호">&nbsp;-&nbsp;
								<input type="text" class="form-control" name="cell3" value="${vo.cell3}" maxlength="4" onblur="numberCheck(this);" data-required-label="휴대폰번호">
							</td>
						</tr>
						<tr>
							<td>주소<span>*</span></td>
							<td>
								<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" alt="우편번호" data-required-label="우편번호" readonly />
								<button type="button" class="btn btn-default" onclick="CHPostCodeUtil.postWindow('open', '#defaultTable');"><span>우편번호찾기</span></button>
								<!-- <span class="description">사업자등록증 상의 주소를 입력해주세요.</span> -->
								<br/>
								<input type="text" class="form-control addr" name="addr1" value="${vo.addr1}" maxlength="100" alt="주소" data-required-label="주소" readonly /><br/>
								<input type="text" class="form-control addr" name="addr2" value="${vo.addr2}" maxlength="100" alt="상세주소" data-required-label="상세주소"/>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="button-wrap">
				<button type="submit" class="btn btn-confirm">
					<span>
						<c:choose>
							<c:when test="${vo eq null}">
								등록
							</c:when>
							<c:otherwise>
								수정
							</c:otherwise>
						</c:choose>
					</span>
				</button>
				<button type="button" class="btn btn-cancel" onclick="history.back()"><span>취소</span></button>
			</div>
		</form>
	</div>
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
	/** 배송지 등록/수정 */
	var doSubmit = function(frmObj) {
		/* 필수값 체크 */
		return checkRequiredValue(frmObj, "data-required-label");
	};
</script>
</body>
</html>