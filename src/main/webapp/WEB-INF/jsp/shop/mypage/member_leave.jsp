<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/member_leave.css" type="text/css" rel="stylesheet">
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
			홈 &gt; 마이페이지 &gt; <strong>회원탈퇴</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 회원 탈퇴를 하실 경우 회원님의 모든 정보가 삭제 되니 신중하게 결정하셔서 신청해 주세요.</div>
		<div class="board-title-sub">
			<div>탈퇴하신 계정의 아이디는 14일 동안 동일한 ID로 가입이 불가능 합니다.</div>
			<div>사용하지 않은 쿠폰/티켓 또는 충전된 포인트가 있는 경우, 사용하신 후 탈퇴해 주세요.</div>
			<div>잔여 포인트는 탈퇴와 함께 삭제되며 환불되지 않습니다</div>
		</div>

		<div class="finish-text-wrap">
			<div class="main-text">
				<div class="sub-text">그동안 이용해주셔서 감사합니다.</div>
				<div class="sub-text">더욱 개선하여 <span>좋은 서비스와 품질</span>로 보답하겠습니다.</div>
			</div>
		</div>

		<%-- 회원탈퇴 사유 --%>
		<form class="form-horizontal" role="form" method="post" onsubmit="return submitProc(this);" action="/shop/close/proc" target="zeroframe">
			<div class="sign-form form2" style="margin-top:35px;">
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">회원탈퇴 사유</div>
						</div>
					</div>
					<table class="table sign-table">
						<tr>
							<td>개인정보  관련</td>
							<td>
								<ul class="leave-reason-list">
									<li><input type="radio" name="closeCode" class="radio" value="R">&nbsp;아이디 변경을 위해 탈퇴 후 재가입</li>
									<li><input type="radio" name="closeCode" class="radio" value="M">&nbsp;장기간 부재(군입대, 유학 등)</li>
									<li><input type="radio" name="closeCode" class="radio" value="P">&nbsp;개인정보 누출 우려</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>사이트 이용관련</td>
							<td>
								<ul class="leave-reason-list">
									<li><input type="radio" name="closeCode" class="radio" value="C">&nbsp;컨텐츠 등 이용할 만한 서비스 부족</li>
									<li><input type="radio" name="closeCode" class="radio" value="S">&nbsp;사이트 속도 및 안정성 불만</li>
									<li><input type="radio" name="closeCode" class="radio" value="U">&nbsp;사이트 이용 불편</li>
									<li><input type="radio" name="closeCode" class="radio" value="L">&nbsp;이용빈도 낮음</li>
									<li><input type="radio" name="closeCode" class="radio" value="G">&nbsp;실질적인 혜택 부족</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>서비스 이용관련</td>
							<td>
								<ul class="leave-reason-list">
									<li><input type="radio" name="closeCode" class="radio" value="D">&nbsp;상품의 다양성/품질 불만</li>
									<li><input type="radio" name="closeCode" class="radio" value="I">&nbsp;상품 가격 불만</li>
									<li><input type="radio" name="closeCode" class="radio" value="B">&nbsp;배송 불만</li>
									<li><input type="radio" name="closeCode" class="radio" value="K">&nbsp;교환/환불/반품 불만</li>
									<li><input type="radio" name="closeCode" class="radio" value="T">&nbsp;탈퇴사유 직접 입력(기타)</li>
									<li><input type="radio" name="closeCode" class="radio" value="J">&nbsp;사후조치 불만</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>개선사항 및 탈퇴사유<br/>직접입력</td>
							<td>
								<textarea name="closeText" cols="55" rows="10" maxlength="100" style="resize: none;"></textarea>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="button-wrap">
				<div class="inner"><button type="submit" class="btn btn-buy"><span>회원 탈퇴하기</span></button></div>
			</div>
		</form>
	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
	var submitProc = function(obj) {
		var flag = true;

		if(typeof $('input[name="closeCode"]:checked').val() === 'undefined') {
			alert('탈퇴 사유를 선택 해주세요.');
			flag = false;
		}
		return flag;
	};

</script>
</body>
</html>