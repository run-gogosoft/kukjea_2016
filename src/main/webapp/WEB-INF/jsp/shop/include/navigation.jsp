<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<header>
<div class="header-back">
	<div class="hearder-top">
		<div class="header-left">
			<div class="header-title">
				서울시가 운영하는 사회적 경제 기업 전용 쇼핑몰 <span class="point-text">함께누리</span>
			</div>
		</div>
		<ul class="header-right">
			<c:choose>
				<c:when test="${sessionScope.loginSeq > 0}">
					<li class="header-login-name">
						<c:if test="${sessionScope.loginType eq 'C'}">
							${sessionScope.loginName}
							<span style="color:#fbac18">
								<c:choose>
									<c:when test="${sessionScope.loginMemberTypeCode eq 'C'}">(개인고객)</c:when>
									<c:when test="${sessionScope.loginMemberTypeCode eq 'O'}">(기업고객)</c:when>
									<c:when test="${sessionScope.loginMemberTypeCode eq 'P'}">(공공기관)</c:when>
								</c:choose>
							</span>
						</c:if>
					</li>
					<li><a href="/shop/logout"><strong>로그아웃</strong></a></li>
				</c:when>
				<c:otherwise>
					<li><a href="/shop/login"><strong>로그인</strong></a></li>
					<li><a href="/shop/member/group">회원가입</a></li>
				</c:otherwise>
			</c:choose>
			<li><a href="/shop/mypage/order/list">주문배송조회</a></li>
			<li><a href="/shop/cart">장바구니</a></li>
			<li><a href="/shop/mypage/order/list">마이페이지</a></li>
			<li><a href="/shop/cscenter/list/faq?categoryCode=10">고객센터</a></li>
		</ul>
	</div>
</div>

<div class="header-wrap-back">
	<div class="header-wrap">
	  <div class="logo">
	  	<a href="/shop/main"><img src="${const.ASSETS_PATH}/front-assets/images/common/logo.png" alt="함께누리 로고"/></a>
	  </div>
	  <div class="header-search">
		<form action="/shop/search" role="form" onsubmit="return checkRequiredValue(this, 'data-required-label');">
		 <div class="search-input-group input-group">
			<input type="text" name="name" class="form-control search-input" placeholder="찾는 상품을 검색하세요.(ex. 쿠키)" style="ime-mode:active"/>
			<div class="input-group-btn">
			  <button type="submit" class="btn btn-default" style="height:34px">
				<img src="${const.ASSETS_PATH}/front-assets/images/common/search_icon.png" alt="검색 아이콘"/>
			  </button>
			</div>
		  </div>
		</form>
		<ul class="lately-search-keyword">
			<li>추천검색어 : </li>
			<li><a href="/shop/search?name=복사용지">복사용지</a></li>
			<li><a href="/shop/search?name=차">차</a></li>
			<li><a href="/shop/search?name=커피">커피</a></li>
			<li><a href="/shop/search?name=토너">토너</a></li>
			<li><a href="/shop/search?name=청소">청소</a></li>
			<li><a href="/shop/search?name=행정봉투">행정봉투</a></li>
		</ul>
	  </div>
	  <div class="info"><a href="/shop/about/main"><img src="${const.ASSETS_PATH}/front-assets/images/common/header-content-back.png" alt="about 사회적경제 이동"/></a></div>
	</div>
</div>

<div class="navigation-wrap">
	<nav role="navigation">
		<ul class="ch-nav">
			<li id="NavFirst" onclick="CHCateogory.toggle()"><img src="${const.ASSETS_PATH}/front-assets/images/common/category_bar_off.png" style="margin:-4px 5px 0 0" alt="네비 아이콘"/>전체카테고리</li>
			<li><span class='navi-text' onclick="location.href='/shop/event/plan'">이벤트/기획전</span><a href="/shop/event/plan" class="navi-a"><img src="${const.ASSETS_PATH}/front-assets/images/common/navi_off.png" alt="네비 아이콘"/></a></li>
			<li><span class='navi-text' onclick="location.href='/shop/best'">베스트상품</span><a href="/shop/best" class="navi-a"><img src="${const.ASSETS_PATH}/front-assets/images/common/navi_off.png" alt="네비 아이콘"/></a></li>
			<li><span class='navi-text' onclick="location.href='/shop/seller/reg'">입점신청</span><a href="/shop/seller/reg" class="navi-a"><img src="${const.ASSETS_PATH}/front-assets/images/common/navi_off.png" alt="네비 아이콘"/></a></li>
			<li><span class='navi-text' onclick="location.href='/shop/jachigu/00'">자치구 상품</span><a href="/shop/jachigu/00" class="navi-a"><img src="${const.ASSETS_PATH}/front-assets/images/common/navi_off.png" alt="네비 아이콘"/></a></li>
			<li><span class='navi-text' onclick="location.href='/shop/about/main?seq=9'">함께누리</span><a href="/shop/about/main?seq=9" class="navi-a"><img src="${const.ASSETS_PATH}/front-assets/images/common/navi_off.png" alt="네비 아이콘"/></a></li>
		</ul>
	</nav>
</div>

<div id="ch-category">
	<div class="inner-wrap">
		<div class="inner">
			<div class="category-wrap">
				<%--함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.--%>
				<script type="text/html" id="lv1CategoryTemplate">
					{{if index < 12 }}
					<li class="first-category">
						<div class="title"><a href="/shop/lv1/<%="${seq}"%>"><%="${categoryName}"%></a></div>
						<ul class="sub-category">
							{{each lv2List}}
								<li><a href="/shop/lv2/<%="${seq}"%>"><%="${categoryName}"%></a></li>
							{{/each}}
						</ul>
					</li>
					{{/if}}
				</script>

				<ul id="lv1CategoryList">
					<li><img src="${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif" style="display:block;margin:170px auto 0 auto" alt="" /></li>
				</ul>

				<div id="category-close" onclick="CHCateogory.hide()"><i class="fa fa-times fa-2x"></i></div>
			</div>
		</div>
	</div>
</div>
</header>
