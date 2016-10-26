
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="wrapper">
	<!-- Left side column. contains the logo and sidebar -->
	<header class="main-header">
		<!-- Logo -->
		<a href="/admin/index" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
			<span class="logo-mini">국제몰</span> <!-- logo for regular state and mobile devices -->
			<span class="logo-lg"><b>국제몰</b> 어드민</span>
		</a>
		<!-- Header Navbar: style can be found in header.less -->
		<nav class="navbar navbar-static-top" role="navigation">
			<!-- Sidebar toggle button-->
			<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span class="sr-only">Toggle navigation</span>
			</a>
			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav">
					<!-- User Account: style can be found in dropdown.less -->
					<li class="dropdown user user-menu">
						<a href="#"	class="dropdown-toggle" data-toggle="dropdown">
							<span class="hidden-xs">
								${sessionScope.loginName}
								<c:if test="${sessionScope.loginType eq 'A'}"> (관리자:${sessionScope.gradeCode})</c:if>
								<c:if test="${sessionScope.loginType eq 'S'}"> (입점공급사)</c:if>
							</span>
						</a>
						<ul class="dropdown-menu">
							<!-- Menu Footer-->
							<li class="user-footer">
								<div class="pull-left">
									<a href="${loginType eq 'A' ? '/admin/system/admin/view':'/admin/seller/mod'}/${loginSeq}" class="btn btn-default btn-flat">내 정보</a>
								</div>
								<div class="pull-right">
									<a href="/admin/logout" class="btn btn-default btn-flat">로그 아웃</a>
								</div>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
	</header>
	<!-- 좌측 메뉴 -->
	<aside class="main-sidebar">
		<!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar">
			<!-- sidebar menu: : style can be found in sidebar.less -->
			<ul class="sidebar-menu">
				<li class="${navi eq 'index' ? 'active':''} treeview">
					<a href="/admin/index"><i class="fa fa-dashboard"></i> <span>Home</span><i class="fa fa-angle-left pull-right"></i></a>
				</li>
				<c:if test="${sessionScope.loginType eq 'A'}">
					<li class="${navi eq 'system' ? 'active':''} treeview">
						<a href="#"><i class="fa fa-cogs"></i> <span>시스템 관리</span><i class="fa fa-angle-left pull-right"></i></a>
						<ul class="treeview-menu">
							<li ${naviSub eq '/mall/list' ? "class='active'":""}><a href="/admin/mall/list"><i class="fa fa-caret-right"></i>쇼핑몰 관리</a></li>
							<!--li ${naviSub eq '/system/delivery/list' ? "class='active'":""}><a href="/admin/system/delivery/list"><i class="fa fa-caret-right"></i>배송업체 관리</a></li-->
							<li ${naviSub eq '/system/admin/list' ? "class='active'":""}><a href="/admin/system/admin/list"><i	class="fa fa-caret-right"></i>어드민 관리자</a></li>
							<li ${naviSub eq '/system/notice/popup/list' ? "class='active'":""}><a href="/admin/system/notice/popup/list"><i class="fa fa-caret-right"></i>공지팝업창 관리</a></li>
							<li ${naviSub eq '/sms/list' ? "class='active'":""}><a href="/admin/sms/list"><i class="fa fa-caret-right"></i>SMS 관리</a></li>
						</ul>
					</li>
				</c:if>
				<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 5)}">
				<li class="${navi eq 'member' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-user"></i> <span>회원 관리</span><i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<c:if test="${sessionScope.loginType eq 'A'}">
						<li ${naviSub eq '/member/stats' ? "class='active'":""}><a href="/admin/member/stats"><i class="fa fa-caret-right"></i>회원 현황</a></li>
						</c:if>
						<li ${naviSub eq '/member/list' ? "class='active'":""}><a href="/admin/member/list"><i class="fa fa-caret-right"></i>회원 리스트</a></li>
						<li ${naviSub eq '/member/list/not_access' ? "class='active'":""}><a href="/admin/member/list/not_access"><i class="fa fa-caret-right"></i>회원 리스트(1년이상 미접속자)</a></li>
						<c:if test="${sessionScope.loginType eq 'A'}">
							<li ${naviSub eq '/point/list' ? "class='active'":""}><a href="/admin/point/list"><i class="fa fa-caret-right"></i>포인트 적립/사용내역</a></li>
							<li ${naviSub eq '/point/excel/list' ? "class='active'":""}><a href="/admin/point/excel/list"><i class="fa fa-caret-right"></i>포인트 내역 엑셀 다운로드</a></li>
							<li ${naviSub eq '/point/all/list' ? "class='active'":""}><a href="/admin/point/all/list"><i class="fa fa-caret-right"></i>포인트 상세 내역</a></li>
							<li ${naviSub eq '/point/excel/list' ? "class='active'":""}><a href="/admin/member/grade"><i class="fa fa-caret-right"></i>회원등급관리</a></li>
							<li ${naviSub eq '/point/all/list' ? "class='active'":""}><a href="/admin/member/list"><i class="fa fa-caret-right"></i>그룹관리</a></li>
						</c:if>
					</ul>
				</li>
				</c:if>
				<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 4 or sessionScope.gradeCode eq 5)}">
				<%-- only 관리자, 총판 --%>
				<li class="${navi eq 'seller' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-building-o"></i> <span>공급사 관리</span><i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<li ${naviSub eq '/seller/list/S' ? "class='active'":""}><a href="/admin/seller/list/S"><i class="fa fa-caret-right"></i>공급사 리스트</a></li>
					</ul>
				</li>
				</c:if>
				<li class="${navi eq 'item' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-gift"></i> <span>상품 관리</span><i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<li ${naviSub eq '/item/list' ? "class='active'":""}><a href="/admin/item/list"><i class="fa fa-caret-right"></i>상품 리스트</a></li>
					<c:if test="${sessionScope.loginType eq 'A'}">
						<%-- 관리자--%>
						<li ${naviSub eq '/item/form' ? "class='active'":""}><a href="/admin/item/form"><i class="fa fa-caret-right"></i>상품 등록</a></li>
					</c:if>
						<li ${naviSub eq '/item/excel/form' ? "class='active'":""}><a href="/admin/item/excel/form"><i class="fa fa-caret-right"></i>상품 대량 등록</a></li>
					<c:if test="${sessionScope.loginType eq 'A'}">
						<li ${naviSub eq '/event/list' ? "class='active'":""}><a href="/admin/event/list"><i class="fa fa-caret-right"></i>기획전 / 이벤트 관리</a></li>
						<li ${naviSub eq '/category' ? "class='active'":""}><a href="/admin/category"><i class="fa fa-caret-right"></i>카테고리 관리</a></li>
					</c:if>
					</ul>
				</li>
				<c:if test="${sessionScope.loginType eq 'A'  or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
				<li class="${navi eq 'order' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-won"></i> <span>판매 관리</span><i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<li ${naviSub eq '/order/list' ? "class='active'":""}><a href="/admin/order/list"><i class="fa fa-caret-right"></i>주문 리스트</a></li>
					<c:if test="${sessionScope.loginType eq 'A' or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'D'}">
						<li ${naviSub eq '/order/cancel/list' ? "class='active'":"" }><a href="/admin/order/cancel/list"><i class="fa fa-caret-right"></i>취소 요청 리스트</a></li>
						<li ${naviSub eq '/order/exchange/list' ? "class='active'":""}><a href="/admin/order/exchange/list"><i class="fa fa-caret-right"></i>교환 요청 리스트</a></li>
						<li ${naviSub eq '/order/return/list' ? "class='active'":""}><a href="/admin/order/return/list"><i class="fa fa-caret-right"></i>반품 요청 리스트</a></li>
					</c:if>
					<%--<c:if test="${sessionScope.loginType eq 'A'}">--%>
						<%--<li ${naviSub eq '/order/list/np' ? "class='active'":"" }><a href="/admin/order/list/np"><i class="fa fa-caret-right"></i>후청구/방문결제 리스트</a></li>--%>
					<%--</c:if>--%>
					<c:if test="${sessionScope.loginType eq 'A' }">
						<li ${naviSub eq '/order/delivery/proc/list' ? "class='active'":""}><a href="/admin/order/delivery/proc/list"><i class="fa fa-caret-right"></i>자동 배송완료 처리</a></li>
					</c:if>
					</ul>
				</li>
				</c:if>
				<%--<c:if test="${sessionScope.loginType eq 'A' }">--%>
				<li class="${navi eq 'stats' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-bar-chart-o"></i> <span>통계</span> <i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<li ${naviSub eq '/stats/list/category' ? "class='active'":""}><a href="/admin/stats/list/category"><i class="fa fa-caret-right"></i> 상품 카테고리별 매출 현황</a></li>
						<li ${naviSub eq '/stats/list/item' ? "class='active'":""}><a href="/admin/stats/list/item"><i class="fa fa-caret-right"></i> 기간별 상품 판매 현황</a></li>
						<li ${naviSub eq '/stats/list/item/jachigu/seller' ? "class='active'":""}><a href="/admin/stats/list/item/jachigu/seller"><i class="fa fa-caret-right"></i> 기간별 상품 판매 현황(입점업체)</a></li>
					</ul>
				</li>
				<%--</c:if>--%>

				<c:if test="${sessionScope.loginType eq 'A' }">
				<li class="${navi eq 'stats' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-bar-chart-o"></i> <span>메인화면관리</span> <i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<li ${naviSub eq '/item/filter/list' ? "class='active'":""}><a href="/admin/item/filter/list"><i class="fa fa-caret-right"></i> 인기검색어</a></li>
						<li ${naviSub eq '/stats/list/item' ? "class='active'":""}><a href="/admin/stats/list/item"><i class="fa fa-caret-right"></i> 광고배너</a></li>
					</ul>
				</li>
				</c:if>


				<c:if test="${sessionScope.loginType eq 'A' }">
				<li class="${navi eq 'board' or navi eq 'about' ? 'active':''} treeview">
					<a href="#"><i class="fa fa-clipboard"></i> <span>게시판 관리</span> <i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<li ${naviSub eq '/board/list/notice' ? "class='active'":""}><a href="/admin/board/list/notice"><i class="fa fa-caret-right"></i> 공지사항</a></li>
					<c:if test="${sessionScope.loginType eq 'A'}">
						<%-- only 관리자 --%>
						<li ${naviSub eq '/board/list/faq' ? "class='active'":""}><a href="/admin/board/list/faq"><i class="fa fa-caret-right"></i> 자주 묻는 질문</a></li>
					</c:if>
						<li ${naviSub eq '/board/list/qna' ? "class='active'":""}><a href="/admin/board/list/qna"><i class="fa fa-caret-right"></i> 상품 문의(Q&amp;A)</a></li>
					<c:if test="${sessionScope.loginType eq 'A'}">
						<li ${naviSub eq '/about/board/detail/list/2' ? "class='active'":""}><a href="/admin/about/board/detail/list/2"><i class="fa fa-caret-right"></i> 입점문의</a></li>
						<li ${naviSub eq '/about/board/detail/list/1' ? "class='active'":""}><a href="/admin/about/board/detail/list/1"><i class="fa fa-caret-right"></i> 판매요청</a></li>
						<li ${naviSub eq '/about/board/detail/list/10' ? "class='active'":""}><a href="/admin/about/board/detail/list/10"><i class="fa fa-caret-right"></i> 가격제안</a></li>
					</c:if>
					</ul>
				</li>
				</c:if>
			</ul>
		</section>
		<!-- /.sidebar -->
	</aside>