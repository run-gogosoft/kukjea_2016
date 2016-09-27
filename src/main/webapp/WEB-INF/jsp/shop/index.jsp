<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
<%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
</head>
<body>

<div id="skip_navi">
	<p><a href="#contents">본문바로가기</a></p>
</div>

<div id="wrap" class="main">
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>

	<div id="container">
		<div class="main_visual">
			<div class="login_area">
				<c:choose>
				<c:when test="${sessionScope.loginSeq > 0}">
					<div class="my_area">
						<div class="user_icon"><img src="/images/common/icon_grade_sm.png" alt="" /></div>
						<div class="private">
							<span class="username"><em>${sessionScope.loginName}</em> 님</span>
							<%--<span class="user_message">새쪽지<span class="badge">3</span></span>--%>
						</div>
						<div class="user_point">
							포인트 (<em data-access="point">---</em>)
						</div>
						<div class="user_links btn_grp">
							<a href="/shop/cart" class="btn btn_default">장바구니</a>
							<a href="/shop/mypage/main" class="btn btn_default">마이페이지</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<form action="/shop/login/proc" method="post" target="zeroframe" onsubmit="return submitProc(this);">
						<fieldset>
							<legend>로그인</legend>
							<div class="login_info">
								<input type="text" id="loginId" name="id" class="intxt" maxlength="16" title="아이디 입력" placeholder="Id" />
								<input type="password" class="intxt" title="패스워드 입력" name="password" maxlength="16" placeholder="Password" />
							</div>
							<div class="save_id">
								<input type="checkbox" id="rememberLoginId" name="rememberLoginId" />
								<label>아이디 저장</label>
							</div>
							<button type="submit" class="btn_login">로그인</button>
						</fieldset>
						<div class="login_links">
							<a href="/shop/cscenter/search/id" class="btn_find_idpw">ID / PW 찾기</a>
							<a href="/shop/cscenter/member/start" class="btn_join">회원가입</a>
						</div>
					</form>
				</c:otherwise>
				</c:choose>
				<ul class="bann_list">
					<li><a href="#"><img src="/images/contents/btn_popular_product.png" alt="인기구매 상품 100" /></a></li>
					<li><a href="/shop/wish/list"><img src="/images/contents/btn_my_product.png" alt="나의 관심상품" /></a></li>
				</ul>
			</div>
			${mainHeroBanner}
		</div>

		<div id="contents" class="main_contents">
			<!-- 국제 TOP10 -->
			<div class="best_ranking">
				<h2>국제 <strong>TOP10</strong></h2>
				<ul>
					<li class="latest"><a href="/shop/event/plan/plansub/2">최신 판매 랭킹</a></li>
					<li class="month"><a href="/shop/event/plan/plansub/3">월간 상품별 판매 랭킹</a></li>
					<li class="member_best"><a href="/shop/event/plan/plansub/4">회원이 뽑은 관심상품 Best</a></li>
				</ul>
			</div>
			<!-- //국제 TOP10 -->
			<!-- 메인 상품목록 -->
			<div class="tab_wrap product_tab">
				<ul class="tab">
					<li class="tab1"><a href="#today_product">오늘만 이가격<span></span></a></li>
					<li class="tab2"><a href="#new_product">신규상품<span></span></a></li>
					<li class="tab3"><a href="#offer_price">가격제안<span></span></a></li>
				</ul>
				<div class="tab_list">
					<div id="today_product" class="img_list_type01">
						<ul>
							<c:forEach var="itemList" items="${eventItemList}" varStatus="status" end="19">
							<li>
								<a href="/shop/search?seq=${itemList.itemSeq}">
									<span class="thumb">
										<img src="/upload${fn:replace(itemList.img1, 'origin', 's170')}" onerror="noImage(this)" alt="" />
										<span class="icons">
											<!--span class="icon icon_txt icon_txt_gray">무료배송</span-->
											<!--span class="icon icon_txt icon_txt_yellow">10+1</span-->
											<c:if test="${itemList.salePercent <100 && itemList.salePercent >0}">
												<span class="icon icon_discount"><em>${itemList.salePercent} </em>%</span>
											</c:if>
										</span>
									</span>
									<span class="tit">${itemList.itemName}</span>
									<span class="price">
										<%-- del><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" />원</del --%>
										<c:if test="${itemList.salePercent <100 && itemList.salePercent >0}">
											<del><fmt:formatNumber value="${itemList.optionPrice}" pattern="#,###" />원</del>
											<span class="sale"><strong><fmt:formatNumber value="${itemList.salePrice}" pattern="#,###" /></strong>원</span>
										</c:if>
											<c:if test="${itemList.salePercent eq 0 || itemList.salePercent eq 100 }">
												<span class="sale"><strong><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" /></strong>원</span>
											</c:if>
									</span>
								</a>
							</li>
						</c:forEach>
						</ul>
						<a href="/shop/event/plan/plansub/1" class="btn_more_full"><span>오늘만 이가격 상품 전체보기</span></a>
					</div>
					<div id="new_product" class="img_list_type01">
						<ul>
							<c:forEach var="itemList" items="${newItemList}" varStatus="status" end="19">
							<li>
								<a href="/shop/search?seq=${itemList.seq}">
									<span class="thumb">
										<img src="/upload${fn:replace(itemList.img1, 'origin', 's170')}" onerror="noImage(this)" alt="" />
										<span class="icons">
											<!--span class="icon icon_txt icon_txt_gray">무료배송</span-->
											<!--span class="icon icon_txt icon_txt_yellow">10+1</span-->
											<c:if test="${itemList.salePercent <100 && itemList.salePercent >0}">
												<span class="icon icon_discount"><em>${itemList.salePercent} </em>%</span>
											</c:if>
										</span>
									</span>
									<span class="tit">${itemList.name}</span>
									<span class="price">
										<c:if test="${itemList.salePercent <100 && itemList.salePercent >0}">
											<del><fmt:formatNumber value="${itemList.optionPrice}" pattern="#,###" />원</del>
											<span class="sale"><strong><fmt:formatNumber value="${itemList.salePrice}" pattern="#,###" /></strong>원</span>
										</c:if>
										<c:if test="${itemList.salePercent eq 0 || itemList.salePercent eq 100}">
											<span class="sale"><strong><fmt:formatNumber value="${itemList.sellPrice}" pattern="#,###" /></strong>원</span>
										</c:if>
									</span>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
					<div id="offer_price">
						<div class="tit_box">
							<dl class="offer_price">
								<dt>가격제안이란?</dt>
								<dd>국제실업쇼핑몰의 회원님께 최저가 정책을 실현하기 위해 회원님과 소통을 통해 이뤄지는 상호운영서비스 입니다.<br />
									국제실업쇼핑몰의 상품을 다른 몰에서 더 싸게 제공 할 경우 참고자료(해당 URL 또는 캡쳐 화면)를 보내주세요.<br />
									국제실업에서 확인 후 가격 조정 및 상응하는 조치를 하여 회원님께 보다 양질의 서비스를 제공하도록 노력하겠습니다.<br />
									아울러 자료를 제공해주신 회원님께는 감사의 의미로 국제실업쇼핑몰에서 현금처럼 사용할 수 있는 포인트를 지급하여 드립니다.
								</dd>
							</dl>
						</div>

						<div class="order_list mt30">
							<h4>제안방법</h4>
							<ol>
								<li>
									1. 우리 사이트의 <em>상품설명에 우측</em>에 있는  <em>“가격제안” 버튼</em>을 누르세요.
									<p class="img ct"><img src="/images/contents/img_offer_price01.png" alt=""></p>
								</li>
								<li>
									2. 작성을 위한 안내 창이 뜨면 작성을 해주세요.
									<p class="img ct"><img src="/images/contents/img_offer_price02.png" alt=""></p>
								</li>
							</ol>
						</div>
					</div>
				</div>
			</div>
			<!-- //메인 상품목록 -->
			<!-- 공지사항/공급자몰 -->
			<div class="cols">
				<div class="col_lt notice">
					<h2>공지사항</h2>
					<ul>
						<c:forEach var="item" items="${noticeList}">
						<li>
							<a href="#"><a href="/shop/cscenter/view/notice/${item.seq}">${item.title}</a></a>
							<span class="date">
								<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
								<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
							</span>
						</li>
						</c:forEach>
						<c:if test="${fn:length(noticeList) eq 0}">
						<li class="text-center" style="font-size:12px;">등록된 내용이 없습니다.</li>
						</c:if>
					</ul>
					<a href="/shop/cscenter/list/notice" class="btn_more">더보기</a>
				</div>
				<div class="col_rt brand_mall">
					<h2>공급자몰</h2>
					<ul>
						<li><a href="http://www.jongromedical.co.kr"><img src="/images/thumb/thumb_company01.jpg" alt="종료의료기" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company02.jpg" alt="명진산업" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company03.jpg" alt="DARA" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company04.jpg" alt="SAMYOUNG" /></a></li>
					</ul>
				</div>
			</div>
			<!-- //공지사항/공급자몰 -->
			<%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
		</div>
		<!-- 반복 주문 상품-->

			<!-- 반복 주문 상품 -->
			<div class="repeat_order">
				<div class="layout_inner">
					<h2>반복 주문 상품</h2>
					<div class="scrollable_wrap">
						<div class="scrollable">
							<table class="data">
								<caption>반복 주문 상품 정보</caption>
								<thead>
								<tr>
									<th scope="col" class="col1"><div>최근 구매일</div></th>
									<th scope="col" class="col2"><div>상품명</div></th>
									<th scope="col" class="col3"><div>규격</div></th>
									<th scope="col" class="col4"><div>제조사</div></th>
									<th scope="col" class="col5"><div>공급사</div></th>
									<th scope="col" class="col6"><div>공급가</div></th>
									<th scope="col" class="col7"><div><input type="checkbox" title="상품 전체 선택" class="check" /></div></th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="repeatList" items="${repeatList}">
									<tr data-seq="${item.seq}">
										<td class="col1"><div>${repeatList.regDate}</div></td>
										<td class="col2"><div><a href="/shop/search?seq=${repeatList.itemSeq}">${repeatList.itemName}</a></div></td>
										<td class="col3"><div>${repeatList.postcode} ${repeatList.postcode1} ${repeatList.postcode2}</div></td>
										<td class="col4"><div>${repeatList.addr1}</div></td>
										<td class="col5"><div>${repeatList.sellerName}</div></td>
										<td class="col6"><div>${repeatList.optionPrice}</div></td>
										<td class="col7"><div><input type="checkbox" title="상품 선택" class="check" /></div></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!--a href="#" class="btn btn_default">선택상품 장바구니 담기</a-->
				</div>
			</div>
			<!-- //반복 주문 상품 -->

		<!-- //반복 주문 상품 -->
	</div>

	<div id="footer">
		<div class="cs_service">
			<div class="layout_inner">
				<dl class="quick_service">
					<dt>빠른 서비스</dt>
					<dd><a href="#" onclick="alert('준비중입니다');return false;"><img src="/images/common/icon_quick_service01.png" alt="거래내역서 출력" /></a></dd>
					<dd><a href="#" onclick="alert('준비중입니다');return false;"><img src="/images/common/icon_quick_service02.png" alt="배송&middot;환불&middot;반품안내" /></a></dd>
					<dd><a href="/shop/about/board/detail/list/2"><img src="/images/common/icon_quick_service03.png" alt="제휴 및 입점 안내" /></a></dd>
					<dd><a href="#" onclick="alert('준비중입니다');return false;"><img src="/images/common/icon_quick_service04.png" alt="세금계산서 발급안내" /></a></dd>
					<dd><a href="/shop/mypage/order/list"><img src="/images/common/icon_quick_service05.png" alt="주문/배송 조회" /></a></dd>
					<dd><a href="/shop/mypage/direct/list"><img src="/images/common/icon_quick_service06.png" alt="1:1 문의게시판" /></a></dd>
				</dl>
				<dl class="cs_center">
					<dt>고객센터</dt>
					<dd class="tel"><span>070-4693-1971</span></dd>
					<dd class="time">
						<span>평 일 : 09:00~18:00</span>
						<span>토요일 : 09:00~13:00</span>
					</dd>
				</dl>
			</div>
		</div>
		<div class="layout_inner">
			<div class="slide_wrap" id="banner_slide">
				<div class="slide_list">
					<ul>
						<li><a href="http://www.jongromedical.co.kr"><img src="/images/thumb/thumb_company01.jpg" alt="종료의료기" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company02.jpg" alt="명진산업" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company03.jpg" alt="DARA" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company01.jpg" alt="종료의료기" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company03.jpg" alt="DARA" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company01.jpg" alt="종료의료기" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company03.jpg" alt="DARA" /></a></li>
						<li><a href="#"><img src="/images/thumb/thumb_company01.jpg" alt="종료의료기" /></a></li>
					</ul>
				</div>
				<div class="slide_control">
					<a href="#" class="prev"><span class="blind">이전</span></a>
					<a href="#" class="next"><span class="blind">다음</span></a>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
	</div>
</div>

<script>
	$(document).ready(function() {
		//checked rememberLoginId
		if($.cookie("lastLoginId") != undefined && $.cookie("lastLoginId") != "") {
			$("#rememberLoginId").prop("checked", true);
			$("#loginId").val($.cookie("lastLoginId"));
		}
	});
	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "") {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});

		//아이디 기억하기
		if($("#rememberLoginId").is(":checked")) {
			$.cookie("lastLoginId", $("#loginId").val(), {expires:7});
		} else {
			$.removeCookie("lastLoginId");
		}

		return flag;
	};
</script>
</body>
</html>