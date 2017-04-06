<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>회원 정보 상세<small>Member Detail Infomation</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>회원 관리</li>
			<li>회원 리스트</li>
			<li class="active">회원 상세 정보 </li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<c:if test="${gvo ne null}">
			<div class="col-md-6">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border"><h3 class="box-title"><i class="fa fa-newspaper-o"></i> 회원정보</h3></div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="table-left" class="table table-bordered">
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:*"/>
							</colgroup>
							<tbody>
								<tr>
									<th>업체명</th>
									<td>
										${gvo.name}
										<c:if test="${gvo.investFlag eq 'Y'}">
										<span class="text-warning">(투자출연기관)</span>
										</c:if>
									</td>
								</tr>
								<tr>
									<th>사업자 등록 번호</th>
									<td>${fn:substring(gvo.bizNo,0,3)}-${fn:substring(gvo.bizNo,3,5)}-${fn:substring(gvo.bizNo,5,10)}</td>
								</tr>
								<tr>
									<th>사업자 주소</th>
									<td>${fn:substring(vo.postcode,0,3)}-${fn:substring(vo.postcode,3,6)} ${vo.addr1} ${vo.addr2}</td>
								</tr>
								<tr>
									<th>대표자</th>
									<td>${gvo.ceoName}</td>
								</tr>
								<tr>
									<th>업태 / 종목</th>
									<td>${gvo.bizType} / ${gvo.bizKind}</td>
								</tr>
								<tr>
									<th>소속 자치구</th>
									<td>${gvo.jachiguName}</td>
								</tr>
								<tr>
									<th>팩스 번호</th>
									<td>${gvo.fax}</td>
								</tr>
								<tr>
									<th>담당자</th>
									<td>${gvo.taxName}</td>
								</tr>
								<tr>
									<th>담당자 이메일</th>
									<td>${gvo.taxEmail}</td>
								</tr>
								<tr>
									<th>담당자 연락처</th>
									<td>${gvo.taxTel}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			</c:if>
			<div class="col-md-${gvo eq null ? "12":"6" }">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-newspaper-o"></i> ${gvo eq null ? "회원" : "담당자"} 정보</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="table-right" class="table table-bordered">
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:80%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td>${vo.id}</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>${vo.name}</td>
								</tr>
								<tr>
									<th>상태</th>
									<td>${vo.statusText}</td>
								</tr>
								<tr>
									<th>부서명 / 직책</th>
									<td>${vo.deptName} / ${vo.posName}</td>
								</tr>
								<%-- <tr>
									<th>등급</th>
									<td>${vo.gradeText}</td>
								</tr> --%>
								<%-- <tr>
									<th>쇼핑몰</th>
									<td>${vo.mallName}</td>
								</tr> --%>
								<%-- <tr>
									<th>보유 포인트</th>
									<td><fmt:formatNumber value="${vo.point}" pattern="#,###" /> P</td>
								</tr> --%>
								<tr>
									<th>이메일</th>
									<td>${vo.email}</td>
								</tr>
								<tr>
									<th>유선 전화</th>
									<td>${vo.tel}</td>
								</tr>
								<tr>
									<th>휴대 전화</th>
									<td>${vo.cell}</td>
								</tr>
								<c:if test="${gvo eq null}">
								<tr>
									<th>주소</th>
									<td>${fn:substring(vo.postcode,0,3)}-${fn:substring(vo.postcode,3,6)} ${vo.addr1} ${vo.addr2}</td>
								</tr>
								</c:if>
								<tr>
									<th>SMS 수신 여부</th>
									<td>
										${vo.smsFlag eq "Y" ? "수신":"수신 안함"}
										<c:if test="${vo.smsFlagDate ne ''}">
											(변경일: ${fn:substring(vo.smsFlagDate,0,10)})
										</c:if>
									</td>
								</tr>
								<tr>
									<th>이메일 수신 여부</th>
									<td>
										${vo.emailFlag eq "Y" ? "수신":"수신 안함"}
										<c:if test="${vo.emailFlagDate ne ''}">
											(변경일: ${fn:substring(vo.emailFlagDate,0,10)})
										</c:if>
									</td>
								</tr>
								<%--<tr>--%>
									<%--<th>가입 경로</th>--%>
									<%--<td>${vo.joinPathName}</td>--%>
								<%--</tr>--%>
								<tr>
									<th>관심 카테고리</th>
									<td>${vo.interestCategoryName}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<%--<c:if test="${sessionScope.loginType eq 'A'}">--%>
						<div class="box-footer text-right">
							<button type="button" class="btn btn-sm btn-success" onclick="addPoint()">포인트지급</button>
							<a href="/admin/member/mod/${vo.seq}" class="btn btn-sm btn-info">수정하기</a>
							<button type="button" class="btn btn-sm btn-danger" onclick="leaveMember();">탈퇴하기</button>
							<button type="button" class="btn btn-sm btn-default" onclick="history.go(-1);">목록보기</button>
						</div>
					<%--</c:if>--%>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-newspaper-o"></i> * 추가몰 이용 상태</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered">
							<%--<colgroup>--%>
								<%--<col style="width:10%;"/>--%>
								<%--<col style="width:45%;"/>--%>
								<%--<col style="width:45%;"/>--%>
							<%--</colgroup>--%>
							<thead>
								<tr>
									<th>쇼핑몰</th>
									<c:forEach var="mall" items="${mallList}" begin="0" step="1">
										<th>${mall.name}<br>이용권한</th>
									</c:forEach>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center" ><strong>이용상태</strong></td>
									<c:forEach var="mall" items="${vo.mallAccessVos}" begin="0" step="1">
										<td class="text-center">
											<c:if test="${mall.accessStatus eq 'X'}"><button type="button" class="btn btn-sm btn-info text-center" onclick="changeAccessStatus(${mall.mallSeq}, ${vo.seq},'${mall.accessStatus}','${mall.note}')">미요청</button></c:if>
											<c:if test="${mall.accessStatus eq 'A'}"><button type="button" class="btn btn-sm btn-success text-center" onclick="changeAccessStatus(${mall.mallSeq}, ${vo.seq},'${mall.accessStatus}','${mall.note}')">이용중</button></c:if>
											<c:if test="${mall.accessStatus eq 'N'}"><button type="button" class="btn btn-sm btn-danger text-center" onclick="changeAccessStatus(${mall.mallSeq}, ${vo.seq},'${mall.accessStatus}','${mall.note}')">거절</button></c:if>
											<c:if test="${mall.accessStatus eq 'R'}"><button type="button" class="btn btn-sm btn-danger text-center" onclick="changeAccessStatus(${mall.mallSeq}, ${vo.seq},'${mall.accessStatus}','${mall.note}')">승인요청</button></c:if>
											<c:if test="${mall.accessStatus eq 'H'}"><button type="button" class="btn btn-sm btn-default text-center" onclick="changeAccessStatus(${mall.mallSeq}, ${vo.seq},'${mall.accessStatus}','${mall.note}')">보류</button></c:if>
										</td>
									</c:forEach>
								</tr>
								<tr>
									<td class="text-center"><strong>처리사유</strong></td>
									<c:forEach var="mall" items="${vo.mallAccessVos}" begin="0" step="1">
										<td class="text-center">${mall.note}</td>
									</c:forEach>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	<%--<c:if test="${sessionScope.loginType eq 'A'}">--%>
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header">
						<!-- <h3 class="box-title"></h3> -->
						<ul id="tab-menu" class="nav nav-tabs">
							<li id="tab-order"><a href="#" onclick="drawList('order',0);">주문리스트</a></li>
							<li id="tab-point"><a href="#" onclick="drawList('point',0);">포인트 내역</a></li>
							<li id="tab-one"><a href="#" onclick="drawList('one',0);">1:1문의</a></li>
							<li id="tab-review"><a href="#" onclick="drawList('review',0);">구매평</a></li>
							<li id="tab-delivery"><a href="#" onclick="drawList('delivery',0);">배송지 정보</a></li>
							<%--<li id="tbl-cs-list"><a href="#" onclick="drawList('cs',0);">CS 이력</a></li>--%>
						</ul>
					</div>
					<!-- 내용 -->
					<div class="box-body" id="cs-list">
						<!-- 주문 리스트 -->
						<table id="tbl-order-list" class="table table-bordered table-striped" style="display:none;">
							<colgroup>
								<col style="width:5%;"/>
								<col style="width:5%;"/>
								<col style="width:7%;"/>
								<col style="width:7%;"/>
								<col/>
								<col/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:10%;"/>
								<col style="width:7%;"/>
								<col style="width:5%;"/>							
							</colgroup>
							<thead>
								<tr>
									<th>상품<br/>주문번호</th>
									<th>주문번호</th>
									<th>
										주문상태
										<div style="margin-top:5px;color:#6495ed">결제수단</div>
										<%-- <c:if test="${sessionScope.loginType eq 'A'}"><div style="margin-top:5px;">(결제장비)</div></c:if> --%>
									</th>
									<th>주문자<div style="margin-top:5px;color:#6495ed">수령자</div></th>
									<th>상품명</th>
									<th>옵션</th>
									<th>판매단가</th>
									<th>수량</th>
									<th>송장번호</th>
									<th>입점업체명</th>
									<th>주문일자</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<!-- 포인트 리스트 -->
						<table id="tbl-point-list" class="table table-bordered table-striped" style="display:none;">
							<thead>
								<tr>
									<th>No.</th>
									<th>발생일</th>
									<th>포인트</th>
									<th>회원명</th>
									<!-- <th>쇼핑몰</th> -->
									<th>상태</th>
									<th>주문번호</th>
									<%--<th>상품주문번호</th>--%>
									<th>비고</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<!-- 1:1문의 리스트 -->
						<table id="tbl-one-list" class="table table-bordered table-striped" style="display:none;">
							<thead>
								<tr>
									<th>No.</th>
									<th>구분</th>
									<!-- <th>주문번호</th> -->
									<!-- <th>쇼핑몰</th> -->
									<th>제목</th>
									<th>처리상태</th>
									<th>글쓴이</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<!-- 구매평 -->
						<table id="tbl-review-list" class="table table-bordered table-striped" style="display:none;">
							<thead>
								<tr>
									<th>No.</th>
									<th>상품번호</th>
									<th>상품이미지</th>
									<th>상품명</th>
									<!-- <th>쇼핑몰</th> -->
									<th>구매평</th>
									<th>상품평가</th>
									<th>글쓴이</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<!-- 배송지 정보 -->
						<table id="tbl-delivery-list" class="table table-bordered table-striped" style="display:none;">
							<thead>
								<tr>
									<th>No.</th>
									<th>배송지 이름</th>
									<th>수령자</th>
									<th>
										휴대폰 번호
										<p>집 전화번호</p>
									</th>
									<th>배송지 주소</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<div id="paging" class="dataTables_paginate paging_simple_numbers text-center"></div>
					</div>
				</div>
			</div>
		</div>
	<%--</c:if>--%>
	</section>
</div>

<!-- 템플릿 호출  -->
<%@ include file="/WEB-INF/jsp/admin/include/member_view_tmpl.jsp" %>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript">
	/* 페이지 로딩시 초기화 */
	$(document).ready(function () {
		//숫자 입력 칸 나머지 문자 입력 막기
		$(".numeric").css("ime-mode", "disabled").numeric();
		<%--<c:if test="${sessionScope.loginType eq 'A'}">--%>
		//CS리스트 최초 주문리스트로 이동
		drawList('order',0);
		<%--</c:if>--%>
	});

	var leaveMember = function() {
		$.msgbox("<p>회원 탈퇴를 하시겠습니까?<br/>(회원탈퇴시 모든정보가 삭제됩니다)</p>", {
			buttons : [
				{type: "submit", value: "확인"},
				{type: "cancel", value: "취소"}
			]
		}, function(result) {
			if(result) {
				$.ajax({
					type: 'POST',
					data: {
						seq:${vo.seq}
					},
					dataType: 'json',
					url: '/admin/system/member/leave',
					success: function(data) {
						if(data.result === "true") {
							location.replace('/admin/member/view/${vo.seq}');
						} else {
							$.msgbox(data.message, {type: "error"});
						}
					}
				})
			}
		});
	};

	var changeAccessStatus = function (mallSeq, userSeq,accessStatus,note) {
		$.msgbox("<p>몰이용 승인조정</p>", {
			type    : "prompt",
			inputs  : [
				{type: "hidden", value: mallSeq, required: true},
				{type: "hidden", value: userSeq, required: true},
				{type: "radio", label: "승인", value:"A" , required: true},
				{type: "radio", label: "보류", value:"H" , required: true},
				{type: "radio", label: "거절", value:"N" , required: true},
				{type: "text", label: "처리사유:",  value:note, required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
		}, function(mallSeq, userSeq,accessStatus,accessStatus,accessStatus,note) {
			$.ajax({
				type: 'POST',
				data: {
					mallSeq:mallSeq,
					userSeq:userSeq,
					accessStatus: $('input[type="radio"]:checked').val(),
					note:note
				},
				dataType: 'json',
				url: '/admin/member/access/change',
				success: function(data) {
					alert( data.message);
//					if(data.result === "true") {
						location.replace('/admin/member/view/${vo.seq}');
//					}
				}
			})
		});
	}

	var addPoint = function() {
		$.msgbox("<p>포인트지급</p>", {
			type    : "prompt",
			inputs  : [
				{type: "text", label: "지급포인트:", required: true},
				{type: "text", label: "지급사유:", required: true}
			],
			buttons : [
				{type: "submit", value: "OK"},
				{type: "cancel", value: "Exit"}
			]
		}, function(addPoint, addResone) {

			$.ajax({
					type: 'POST',
					data: {
						seq:${vo.seq},
						addPoint:addPoint,
						addResone:addResone
					},
					dataType: 'json',
					url: '/admin/point/write/proc',
					success: function(data) {
						alert( data.message);
						if(data.result === "true") {
							location.replace('/admin/member/view/${vo.seq}');
						}
					}
				})
		});
	};
	
	var drawList = function(listType, pageNum) {
		currentListType = listType;//현제 tab-menu 구하는 함수 알때까지 전역변수로 일단 사용하자;;
		$.ajax({
			url:"/admin/member/cs/list/"+listType,
			type:"post",
			data:{memberSeq:${vo.seq}, pageNum:pageNum},
			dataType:"text",
			success:function(data) {
				//탭메뉴 전체 비활성화
				$("#tab-menu li").removeClass("active");
				//테이블 전체 비활성화
				$("#cs-list table").css("display","none"); 
				//$("#cs-list table tbody").html("");
				
				//선택 메뉴 활성화
				$("#tab-"+listType).addClass("active");
				//선택 메뉴 테이블 활성화
				$("#tbl-"+listType+"-list").css("display","table");
				//선택 메뉴 테이블 데이터 렌더링
				$("#tbl-"+listType+"-list tbody").html("<tr><td colspan='20' class='text-center'><img src='/assets/img/common/ajaxloader.gif'/> 데이터를 불러오고 있습니다.</td></tr>");

				var vo = $.parseJSON(data);			
				if(vo.list.length == 0) {
					$("#tbl-"+listType+"-list tbody").html("<tr><td colspan='20' class='muted text-center'>검색된 결과가 없습니다</td></tr>");
				} else {
					$("#tbl-"+listType+"-list tbody").html( $("#tmpl-"+listType+"-list").tmpl(vo.list) );
				}

				//페이징 네비게이션 렌더링
				$("#paging").html(vo.paging);	
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};
	
	var goPage = function (pageNum) {
		//var listType = $("#tab-menu li").("id").split("-")[1];
		// TODO current tab-menu 확인하는 방법
		drawList(currentListType, pageNum);
	};
</script>
</body>
</html>
