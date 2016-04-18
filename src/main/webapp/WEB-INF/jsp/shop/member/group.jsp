<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member_group.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

	<div class="main-title">
		${title}
	</div>

	<%@ include file="/WEB-INF/jsp/shop/include/member_header.jsp" %>

	<div class="ch-container sign-info-wrap" style="margin-top:70px">
		<div class="inner">
			<div class="sign-info-text">
				<div class="title back-img1" style="cursor:pointer;" onclick="location.href='/shop/member/start?memberTypeCode=C'">
					<div class="text">
						개인회원<br/>
						<span>회원가입</span>
					</div>
				</div>
				<div class="description">
					<div class="inner">
						<div>만14세 이상 개인회원</div>
					</div>
				</div>
				<div class="title2">
					<a href="/shop/member/start?memberTypeCode=C"><div class="text">가입하기<i class="fa fa-angle-right fa-2x"></i></div></a>
				</div>
			</div>

			<div class="sign-info-text" style="margin-left:110px">
				<div class="title back-img2" style="cursor:pointer;" onclick="location.href='/shop/member/start?memberTypeCode=O'">
					<div class="text">
						기업/시설/단체<br/>
						<span>회원가입</span>
					</div>
				</div>
				<div class="description">
					<div class="inner">
						<div>일반업체 및 기업체</div>
						<div>사회기업 및 단체</div>
						<div>기타 사회단체 등</div>
					</div>
				</div>
				<div class="title2">
					<a href="/shop/member/start?memberTypeCode=O"><div class="text">가입하기<i class="fa fa-angle-right fa-2x"></i></div></a>
				</div>
			</div>

			<div class="sign-info-text" style="margin-left:110px">
				<div class="title back-img3" style="cursor:pointer;" onclick="location.href='/shop/member/start?memberTypeCode=P'">
					<div class="text">
						공공기관회원<br/>
						<span>회원가입</span>
					</div>
				</div>
				<div class="description">
					<div class="inner">
						<div>아래 내용 참조</div>
					</div>
				</div>
				<div class="title2">
					<a href="/shop/member/start?memberTypeCode=P"><div class="text">가입하기<i class="fa fa-angle-right fa-2x"></i></div></a>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<div class="organ-description">
		<div>
			<div class="title">공공기관회원이란?</div>
			<div class="description">
				<ul>
					<li>국가기관 : 중앙부처 및 그 소속기관</li>
					<li>지방지차단체 : 시ㆍ도, 시ㆍ군ㆍ구 및 소속사업소/직속기관, 시 산하 출연, 투자, 출자기관</li>
					<li>교육청 : 시ㆍ도 교육청, 지역교육청 및 학교</li>
					<li>특별법에 따라 설립된 법인 중 대통령령으로 정하는 기관 : 중소기업중앙회, 농업협동중앙회, 수산업협동조합중앙회, 산림조합중앙회, 한국은행, 대한상공희의소</li>
					<li>[공공기관의 운영에 관한법률] 제5조에 따른 공기업 및 준 정부기관</li>
					<li>[공공기관의 운연에 관한법률] 제5조에 따른 기타공공기관</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/member/member.js"></script>
</body>
</html>