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
					<li><a href="/shop/logout">로그아웃</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="/shop/login">로그인</a></li>
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
	        <input type="text" name="name" class="form-control search-input" placeholder="찾는 상품을 검색하세요.(ex. 쿠키)" />
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

<div class="about-nav-wrap">
	<nav role="navigation">
		<div class="about-logo"><img src="${const.ASSETS_PATH}/front-assets/images/about/logo.png" alt="about 사회적경제 로고"></div>
		<ul class="hh-about-menu" id="mainMenu">
			<script id="subListTemplate" type="text/html">
				<li><a href="/shop/about/main?seq=<%="${seq}"%>"><%="${name}"%></a></li>
			</script>

			<c:forEach var="item" items="${menuList}" varStatus="status" begin="0" step="1">
				<li class="menu dropdown" data-seq="${item.seq}">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">${item.name}</a>
						<ul id="subListTarget" class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<c:forEach var="subItem" items="${subList}" varStatus="status" begin="0" step="1">
								<c:if test="${item.seq eq subItem.mainSeq}">
									<c:choose>
										<c:when test="${fn:contains(subItem.linkUrl, '.html')}">
											<li><a href="/shop/about/main?seq=${subItem.seq}">${subItem.name}</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="${subItem.linkUrl}">${subItem.name}</a></li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</ul>
				</li>
			</c:forEach>
			<li class="menu">
				<a href="/shop/about/seller">입점업체 정보</a>
			</li>
		</ul>
	</nav>
</div>

<div id="ch-category">
	<div class="inner-wrap">
		<div class="inner">
			<div class="category-wrap">
				<script type="text/html" id="lv1CategoryTemplate">
					<li class="first-category">
						<div class="title"><a href="/shop/lv1/<%="${seq}"%>"><%="${categoryName}"%></a></div>
						<ul class="sub-category">
							{{each lv2List}}
								<li><a href="/shop/lv2/<%="${seq}"%>"><%="${categoryName}"%></a></li>
							{{/each}}
						</ul>
					</li>
				</script>

				<ul id="lv1CategoryList">
					<img src="${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif" style="display:block;margin:170px auto 0 auto" alt="" />
				</ul>

				<div id="category-close" onclick="CHCateogory.hide()"><i class="fa fa-times fa-2x"></i></div>
			</div>
		</div>
	</div>
</div>
</header>