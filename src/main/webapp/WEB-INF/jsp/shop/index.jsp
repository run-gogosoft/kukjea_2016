<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/main/main.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/plugin/mediaelementplayer.css" type="text/css" rel="stylesheet">
	<style type="text/css">
		#popup_notice_password table {
			border:0;
			border-spacing:0;
		}
		#popup_notice_password table td {
			padding:5px;
		}
		#popup_notice_password table td input {
			width:200px;
			height:25px;
			border:1px solid #ccc;
		}
	</style>
	<!--[if lt IE 9]>
		<style type="text/css">
			.ch-hero-list li .circle {
				width:10px;
			}

			.ch-long-list li .circle {
				width:6px;
			}
		</style>
	<![endif]-->
</head>
<body>
	<a class="sr-only" href="#content">Skip navigation</a>
	<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

	<div class="ch-hero ch-hero-detail">
		<div class="nav-wrap">
			<div class="side-nav" style="border-top: none;">
				<%--메인 좌단메뉴--%>
				<%--함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.--%>
				<script type="text/html" id="mainSubCategoryTemplate">
					{{each menu}}
						<c:choose>
							<c:when test="${sessionScope.loginMemberTypeCode eq 'P'}">
								<li data-seq="<%="${seq}"%>"><a href="/shop/lv1/<%="${seq}"%>"><%="${categoryName}"%></a></li>
							</c:when>
							<c:otherwise>
								{{if seq !== "53"}}
									<li data-seq="<%="${seq}"%>"><a href="/shop/lv1/<%="${seq}"%>"><%="${categoryName}"%></a></li>
								{{/if}}
							</c:otherwise>
						</c:choose>
					{{/each}}
				</script>

				<%--메인 중분류--%>
				<script type="text/html" id="mainLv2Template">
					{{each menu}}
						<li data-seq="<%="${seq}"%>"><a href="/shop/lv2/<%="${seq}"%>"><%="${categoryName}"%></a></li>
					{{/each}}
				</script>

				<%--메인 소분류--%>
				<script type="text/html" id="mainLv3Template">
					<li data-seq="<%="${seq}"%>"><a href="/shop/lv3/<%="${seq}"%>"><%="${categoryName}"%></a></li>
				</script>

				<ul id="mainSubCategoryList">
					<li><img src="${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif" style="margin:140px 0 0 45px;" alt="로딩중.." /></li>
				</ul>
			</div>
			<div class="side-nav-category-lv2-div">
				<ul id="side-nav-category-lv2" style="text-align:center;"></ul>
			</div>

			<%--<ul id="side-nav-category-lv3" style="text-align:center;"></ul>소분류 카테고리--%>

			<div class="clearfix"></div>
			<%-- 히어로배너 영역 --%>
			${fn:replace(mainHeroBanner,"${const.ASSETS_PATH}",const.ASSETS_PATH)}
	</div>
</div>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<div class="ch-nuri-back">
	<div class="ch-nuri-wrap">
		<div class="side-nav-wrap">
			<ul class="side-nav nuri-side-nav">
				<li id="nuriList1" class="current" onclick="HknuriUtil.toggle(this)">사회적 기업상품<img src="${const.ASSETS_PATH}/front-assets/images/main/nuri_menu_on.png" alt="사회적 기업상품"/></li>
				<li id="nuriList2" onclick="HknuriUtil.toggle(this)">협동조합상품<img src="${const.ASSETS_PATH}/front-assets/images/main/nuri_menu_off.png" alt="협동조합상품"/></li>
				<li id="nuriList3" onclick="HknuriUtil.toggle(this)">장애인 기업상품<img src="${const.ASSETS_PATH}/front-assets/images/main/nuri_menu_off.png" alt="장애인기업상품"/></li>
				<li id="nuriList4" onclick="HknuriUtil.toggle(this)">공정무역상품<img src="${const.ASSETS_PATH}/front-assets/images/main/nuri_menu_off.png" alt="공정무역상품"/></li>
				<li id="nuriList5" onclick="HknuriUtil.toggle(this)">마을기업상품<img src="${const.ASSETS_PATH}/front-assets/images/main/nuri_menu_off.png" alt="마을기업상품"/></li>
			</ul>
		</div>

		<div class="center-wrap">
			<div class="item-list">
				<%--사회적 기업상품--%>
				<ul class="ch-big-list nuriList1">
					<c:forEach var="item" items="${gallery1}" varStatus="status" begin="0" step="1">
						<c:if test="${status.index < item.limitCnt}">
							<li>
								<div class="thumb">
									<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}"/></a>
								</div>
								<div class="price-info">
									<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<span class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /></span><span style="font-size: 12px;">원</span>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<span class="price" style="font-size:20px;">견적요청</span>
										</c:when>
									</c:choose>
								</div>
								<div class="description">
									<a href="/shop/detail/${item.itemSeq}">${item.itemName}</a>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>

				<%--장애인 기업상품--%>
				<ul class="ch-big-list nuriList2">
					<c:forEach var="item" items="${gallery2}" varStatus="status" begin="0" step="1">
						<c:if test="${status.index < item.limitCnt}">
							<li>
								<div class="thumb">
									<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a>
								</div>
								<div class="price-info">
									<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<span class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /></span><span style="font-size: 12px;">원</span>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<span class="price" style="font-size:20px;">견적요청</span>
										</c:when>
									</c:choose>
								</div>
								<div class="description">
									<a href="/shop/detail/${item.itemSeq}">${item.itemName}</a>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>

				<%--MD 추천상품--%>
				<ul class="ch-big-list nuriList3">
					<c:forEach var="item" items="${gallery3}" varStatus="status" begin="0" step="1">
						<c:if test="${status.index < item.limitCnt}">
							<li>
								<div class="thumb">
									<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a>
								</div>
								<div class="price-info">
									<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<span class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /></span><span style="font-size: 12px;">원</span>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<span class="price" style="font-size:20px;">견적요청</span>
										</c:when>
									</c:choose>
								</div>
								<div class="description">
									<a href="/shop/detail/${item.itemSeq}">${item.itemName}</a>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>

				<ul class="ch-big-list nuriList4">
					<c:forEach var="item" items="${gallery9}" varStatus="status" begin="0" step="1">
						<c:if test="${status.index < item.limitCnt}">
							<li>
								<div class="thumb">
									<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a>
								</div>
								<div class="price-info">
									<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<span class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /></span><span style="font-size: 12px;">원</span>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<span class="price" style="font-size:20px;">견적요청</span>
										</c:when>
									</c:choose>
								</div>
								<div class="description">
									<a href="/shop/detail/${item.itemSeq}">${item.itemName}</a>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>

				<ul class="ch-big-list nuriList5">
					<c:forEach var="item" items="${gallery10}" varStatus="status" begin="0" step="1">
						<c:if test="${status.index < item.limitCnt}">
							<li>
								<div class="thumb">
									<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a>
								</div>
								<div class="price-info">
									<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<span class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /></span><span style="font-size: 12px;">원</span>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<span class="price" style="font-size:20px;">견적요청</span>
										</c:when>
									</c:choose>
								</div>
								<div class="description">
									<a href="/shop/detail/${item.itemSeq}">${item.itemName}</a>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>

			<ul class="user-menu">
				<li>
					<a href="/shop/mypage/order/list">
						<div class="img">
							<img src="${const.ASSETS_PATH}/front-assets/images/main/user_order.png" alt="주문배송조회"/>
						</div>
						<div class="title">
							주문배송조회
						</div>
					</a>
				</li>
				<li>
					<a href="/shop/wish/list">
						<div class="img">
							<img src="${const.ASSETS_PATH}/front-assets/images/main/user_wish.png" alt="관심상품" />
						</div>
						<div class="title">
							관심상품
						</div>
					</a>
				</li>
				<li>
					<a href="/shop/mypage/direct/list">
						<div class="img">
							<img src="${const.ASSETS_PATH}/front-assets/images/main/user_direct.png" alt="1:1문의" />
						</div>
						<div class="title">
							1:1문의
						</div>
					</a>
				</li>
				<li>
					<a href="/shop/about/board/detail/list/1">
						<div class="img">
							<img src="${const.ASSETS_PATH}/front-assets/images/main/user_item_reg.png" alt="상품등록요청" />
						</div>
						<div class="title">
							상품등록요청
						</div>
					</a>
				</li>
				<li>
					<a href="/shop/cscenter/list/faq?categoryCode=10">
						<div class="img">
							<img src="${const.ASSETS_PATH}/front-assets/images/main/user_faq.png" alt="자주묻는질문"/>
						</div>
						<div class="title">
							자주묻는질문
						</div>
					</a>
				</li>
				<li>
					<a href="/shop/about/board/detail/list/2">
						<div class="img">
							<img src="${const.ASSETS_PATH}/front-assets/images/main/user_store_reg.png" alt="입점문의" />
						</div>
						<div class="title">
							입점문의
						</div>
					</a>
				</li>
			</ul>
		</div>

		<div class="news-board">
			<div class="board-wrap">
				<div class="board-title"><span class="title">공지사항</span><span class="etc"><a href="/shop/cscenter/list/notice">more ></a></span></div>
				<ul class="board-content">
					<c:forEach var="item" items="${noticeList}">
						<li><div class="point"></div><a href="/shop/cscenter/view/notice/${item.seq}">${item.title}</a></li>
					</c:forEach>
					<c:if test="${fn:length(noticeList) eq 0}">
						<li class="text-center" style="font-size:12px;">등록된 내용이 없습니다.</li>
					</c:if>
				</ul>

				<div class="board-title" style="margin-top:20px;border-bottom:1px solid #4cb7c9;"><span class="title">사회적 경제 소식</span><span class="etc"><a href="/shop/about/board/detail/list/3">more ></a></span></div>
				<ul class="board-content">
					<c:forEach var="item" items="${socialList}">
						<li><div class="point"></div><a href="/shop/about/board/detail/view/${item.seq}?commonBoardSeq=3">${item.title}</a></li>
					</c:forEach>
					<c:if test="${fn:length(socialList) eq 0}">
						<li class="text-center" style="font-size:12px;">등록된 내용이 없습니다.</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<%-- A banner --%>
<c:if test="${(mainBannerA ne '') and (mainBannerA ne null)}">
	${fn:replace(mainBannerA,"${const.ASSETS_PATH}",const.ASSETS_PATH)}
</c:if>

<%-- B banner & B itemList --%>
<c:if test="${(mainBannerB ne '') and (mainBannerB ne null) and fn:length(gallery4) > 0}">
	<div class="ch-container">
		<div class="banner-title">
			<img src="/upload/banner/main/bbanner/b_title.png" alt="BEST 최대구매" />
		</div>

		${fn:replace(mainBannerB,"${const.ASSETS_PATH}",const.ASSETS_PATH)}

	    <ul class="ch-3col banner-content middle-banner">
	    	<c:forEach var="item" items="${gallery4}" varStatus="status" begin="0" step="1">
	    		<c:if test="${status.index < item.limitCnt}">
		        <li>
		        	<div class="img"><a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a></div>
		        	<div class="info">
		        		<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
		        		<c:choose>
							<c:when test="${item.typeCode eq 'N'}">
								<div class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
							</c:when>
							<c:when test="${item.typeCode eq 'E'}">
								<div class="price" style="font-size:20px;">견적요청</div>
							</c:when>
						</c:choose>
		        	</div>
		        </li>
			    </c:if>
			</c:forEach>
	    </ul>
	</div>
</c:if>
<div class="clearfix"></div>

<%-- C banner & C itemList --%>
<c:if test="${(mainBannerC ne '') and (mainBannerC ne null) and fn:length(gallery5) > 0}">
	<div class="ch-container">
		<div class="banner-title">
			<img src="/upload/banner/main/cbanner/c_title.png" alt="NEW 신규상품" />
		</div>
		${fn:replace(mainBannerC,"${const.ASSETS_PATH}",const.ASSETS_PATH)}

		<!-- 배너 이미지 -->
		<div class="banner-content" style="margin-top:0;">
		    <ul class="ch-3col banner-content middle-banner">
	    	<c:forEach var="item" items="${gallery5}" varStatus="status" begin="0" step="1">
	    		<c:if test="${status.index < item.limitCnt}">
		        <li>
		        	<div class="img"><a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a></div>
		        	<div class="info">
		        		<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
		        		<c:choose>
									<c:when test="${item.typeCode eq 'N'}">
										<div class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
									</c:when>
									<c:when test="${item.typeCode eq 'E'}">
										<div class="price" style="font-size:20px;">견적요청</div>
									</c:when>
								</c:choose>
		        	</div>
		        </li>
			    </c:if>
				</c:forEach>
	    </ul>
		</div>
	</div>
</c:if>
<div class="clearfix"></div>

<div class="ch-container" <c:if test="${(fn:length(gallery6) eq 0) and (fn:length(gallery7) eq 0)}">style="margin:0;"</c:if>>
		<%-- D banner --%>
		<div class="ch-half-container" style="float:left">
			<div class="banner-title">
			   <img src="/upload/banner/main/dbanner/d_title.png" alt="TREND 대세상품" />
			</div>

			<div class="banner-half-content">
			    <ul class="ch-4col">
			    	<c:forEach var="item" items="${gallery6}" varStatus="status" begin="0" step="1">
		    			<c:if test="${status.index < item.limitCnt}">
				        <li class="col-${status.count}">
				        	<div class="item">
					        	<div class="img">
					        		<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a>
					        	</div>
					        	<div class="info">
					        		<div class="name"><a href="/shop/detail/${item.itemSeq}"><smp:cutString value="${item.itemName}" length="40"/></a></div>
					        		<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<div class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<div class="price" style="font-size:20px;">견적요청</div>
										</c:when>
									</c:choose>
					        	</div>
				        	</div>
				        </li>
				      </c:if>
						</c:forEach>
			    </ul>
			</div>
		</div>

		<div class="ch-half-container" style="float:left;margin-left:14px;">
			<%-- education banner --%>
			<div class="banner-title">
			   <img src="/upload/banner/main/ebanner/e_title.png" alt="FOOD 먹거리존" />
			</div>

			<!-- 배너 이미지 -->
			<div class="banner-half-content">
			    <ul class="ch-4col">
			    	<c:forEach var="item" items="${gallery7}" varStatus="status" begin="0" step="1">
			    		<c:if test="${status.index < item.limitCnt}">
				        <li class="col-${status.count}">
				        	<div class="item">
					        	<div class="img">
					        		<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" alt="${item.itemName}" /></a>
					        	</div>
					        	<div class="info">
					        		<div class="name"><a href="/shop/detail/${item.itemSeq}"><smp:cutString value="${item.itemName}" length="40"/></a></div>
					        		<c:choose>
										<c:when test="${item.typeCode eq 'N'}">
											<div class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
										</c:when>
										<c:when test="${item.typeCode eq 'E'}">
											<div class="price" style="font-size:20px;">견적요청</div>
										</c:when>
									</c:choose>
					        	</div>
				        	</div>
				        </li>
				      </c:if>
						</c:forEach>
			    </ul>
			</div>
		</div>
</div>
<div class="clearfix"></div>

<%--나중에 비디오 배너부분이 어떻게 바뀔지 모르나 현재는 AJAX로 상품을 호출한다.--%>
<c:if test="${(mainBannerF ne '') and (mainBannerF ne null)}">
	<script id="trTemplate" type="text/html">
		{{if itemCount < limitCnt}}
			<li>
				<div class="item-detail item-index<%="${itemCount}"%>">
					<div class="image">
						<a href="/shop/detail/<%="${itemSeq}"%>"><img src="<%="${img1}"%>" alt="상품이미지"/></a>
					</div>
					<div class="description">
						<div class="title"><a href="/shop/detail/<%="${itemSeq}"%>"><%="${itemName}"%></a></div>
						{{if typeCode === "N"}}
							<div class="price"><%="${sellPrice}"%><span>원</span></div>
						{{else typeCode === "E"}}
							<div class="price" style="font-size:16px;">견적요청</div>
						{{/if}}
					</div>
				</div>
			</li>
		{{/if}}
	</script>

	${fn:replace(mainBannerF,"${const.ASSETS_PATH}",const.ASSETS_PATH)}
</c:if>

<c:forEach var="item" items="${noticePopup}" varStatus="status">
	<div id="popupNotice${status.count}" class="popup-writebox" style="display:none;position:absolute;z-index:150;background-color:#ffffff;display:none;border: 1px solid #CCC; border-radius: 5px; position: absolute; width: ${item.width}px;height:${item.height}px !important; top:${item.topMargin}px; left:${item.leftMargin}px; overflow:hidden">
		<div class="popup-writebox-wrap" style="width:${item.width-14}px; height:${item.height-30}px;">
			<div class="popup-writebox-content" style="padding:0;">
					${item.contentHtml}
			</div>
			<div class="popup-writebox-footer text-right" style="padding:5px;">
				<input type="checkbox" id="popup${status.count}"/><label for="popup${status.count}" style="font-size: 11px;font-weight: normal;"> 하루동안 열지 않기</label>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-xs btn-primary" onclick="closePopup(${status.count})">닫기</button>
			</div>
		</div>
	</div>
</c:forEach>

<!-- 기존 패스워드 6개월이상 유지 회원 변경 안내 레이어 -->
<c:if test="${sessionScope.notiPasswordFlag eq 'Y'}">
	<div id="popup_notice_password" style="display:none;position:absolute;border: 2px solid #444; border-radius: 5px;background-color:#fff;z-index:151;width:345px;height:420px !important; top:200px; left:750px; overflow:hidden;">
		<div style="background-color:#c09853;padding:5px 10px 5px 10px;font-size:18px;font-weight:bold;color:#fff">
			<i class="fa fa-exclamation-circle"></i> 비밀번호 변경 안내
		</div>
		<div style="font-size:13px;color:#666;padding:10px;">
			<strong style="font-size:16px">${sessionScope.loginName}</strong> 님께 알려드립니다.<br/><br/>
			회원님은 현재 비밀번호를 <strong>최근 6개월(180일)</strong> 이상<br/>변경없이 사용하고 계십니다.<br/><br/>
			회원님의 소중한 <strong>개인정보 보호</strong>를 위하여 <strong>6개월마다</strong><br/> 비밀번호를 변경해 주시기 바랍니다.<br/>
		</div>
		<form method="post" action="/shop/member/password/update" target="zeroframe" onsubmit="return updatePassword(this)">
		<div style="font-size:13px;color:#666;padding:10px;">
			<table>
				<tr>
					<td>기존 비밀번호</td>
					<td><input type="password" name="password" alt="기존 비밀번호"/></td>
				</tr>
				<tr>
					<td>새 비밀번호</td>
					<td><input type="password" name="newPassword" alt="새 비밀번호" maxlength="16"/></td>
				</tr>
				<tr>
					<td>새 비밀번호 확인</td>
					<td><input type="password" name="newPassword_confirm" alt="새 비밀번호 확인" maxlength="16"/></td>
				</tr>
			</table>
		</div>
		<div style="padding-left:15px;padding-bottom:5px;" class="text-danger">
			<i class="fa fa-exclamation"></i> 비밀번호는 영문/숫자/특수문자(~!@#$%^&*())를 조합하여<br/>
			8~16자리까지 허용됩니다.
		</div>
		<div class="text-center" style="border-top:1px solid #ddd;padding:10px;">
			<button type="submit" class="btn btn-sm btn-primary">비밀번호 변경하기</button>
			<a href="/shop/member/password/update/delay" onclick="$('#popup_notice_password').hide();" target="zeroframe" class="btn btn-sm btn-default">30일간 보이지 않기</a>  
		</div>
		</form>
	</div>
</c:if>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/main/main.js"></script>
<script type="text/javascript">
	var closePopup = function(num) {
		if($('#popup'+num).prop('checked')) {
			$.cookie("closePopup"+num, "disabled", {expires: 1});
		}
		$('#popupNotice'+num).hide();
	};

	$(document).ready(function() {
		for(var i=1; i<=${fn:length(noticePopup)}; i++) {
			if ($.cookie("closePopup"+i) !== "disabled") {
				$('#popupNotice' + i).show();
			}
		}
		
		//패스원드 변경 알림 팝업창 띄우기
		<c:if test="${sessionScope.notiPasswordFlag eq 'Y'}">
		$('#popup_notice_password').show();
		</c:if>
	});
	
	var updatePassword = function(formObj) {
		//필수값 체크
		if(!checkRequiredValue(formObj, "alt")) {
			return false;
		}
		
		//변경 비밀번호 일치 여부 체크
		if(formObj.newPassword.value != formObj.newPassword_confirm.value) {
			alert("새 비밀번호가 일치하지 않습니다.");
			formObj.newPassword_confirm.focus();
			return false;
		}
		
		return true;
	}
	
	var callbackProc = function(flag) {
		if( flag == "Y" ) {
			$('#popup_notice_password').hide();
		}
	};
</script>
</body>
</html>