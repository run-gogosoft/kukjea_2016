<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<link href="/assets/css/summernote.css" rel="stylesheet">
	<style type="text/css">
		.thumbimg {padding:5px;}
		.thumbimg div {float:left;text-align:center}
		.thumbimg img {margin-right:5px; cursor:pointer; width:120px; height:120px}
		.detail-content {display:none}
		.detail-image {display:none}
		.logContent:hover{
			color: #08c;
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>상품 상세 정보  <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>상품 관리</li>
			<li>상품 리스트</li>
			<li class="active">상품 상세 정보</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">주요 정보</h3>
						<div class="pull-right">
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2 or sessionScope.gradeCode eq 3) or sessionScope.loginType eq 'S'}">
							<%--관리자, 입점업체일 경우에만 노출 --%>
							<a href="/admin/item/form/${vo.seq}" onclick="location.href='/admin/item/form/${vo.seq}?pageNum=${pageNum}&search='+encodeURIComponent('${param.search}');return false;" class="btn btn-sm btn-primary">수정하기</a>
						</c:if>
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2) or sessionScope.loginType eq 'S'}">
							<%--관리자일 경우에만 노출 --%>
							<button type="button" onclick="deleteItem('${vo.statusCode}','${sessionScope.loginType}')" class="btn btn-sm btn-danger">삭제하기</button>
							&nbsp;&nbsp;
						</c:if>
							<a href="/admin/item/list" onclick="location.href=decodeURIComponent('/admin/item/list'+(location.search)).split('&amp;').join('&');return false;" class="btn btn-sm btn-default">목록보기</a>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="view1" class="table table-bordered">
							<colgroup>
								<col style="width:15%;"/>
								<col style="*"/>
							</colgroup>
							<tbody>
								<tr>
									<th>카테고리</th>
									<td>
										${vo.cateLv1Name}
										<c:if test="${vo.cateLv2Name ne ''}">
											&gt; ${vo.cateLv2Name}
										</c:if>
										<c:if test="${vo.cateLv3Name ne ''}">
											&gt; ${vo.cateLv3Name}
										</c:if>
										<c:if test="${vo.cateLv4Name ne ''}">
											&gt; ${vo.cateLv4Name}
										</c:if>
									</td>
								</tr>
								<tr>
									<th>상품 구분</th>
									<td>${vo.typeName}</td>
								</tr>
								<tr>
									<th>판매 상태</th>
									<td>${vo.statusName}</td>
								</tr>
								<tr>
									<th>상품명</th>
									<td>${vo.name}</td>
								</tr>
								<tr>
									<th>제조사</th>
									<td>${vo.maker}</td>
								</tr>
								<tr>
									<th>규격1</th>
									<td>${vo.type1}</td>
								</tr>
								<tr>
									<th>규격2</th>
									<td>${vo.type2}</td>
								</tr>
								<tr>
									<th>규격3</th>
									<td>${vo.type3}</td>
								</tr>
								<tr>
									<th>진료과목</th>
									<td>${vo.subjectType}</td>
								</tr>
								<tr>
									<th>보험코드</th>
									<td>${vo.insuranceCode}</td>
								</tr>
								<tr>
									<th>발주처</th>
									<td>${vo.brand}</td>
								</tr>
								<tr>
									<th>단위</th>
									<td>${vo.originCountry}</td>
								</tr>
								<tr>
									<th>기준재고</th>
									<td>${vo.modelName}</td>
								</tr>
								<tr>
									<th>자동발주량</th>
									<td>${vo.minCnt}</td>
								</tr>
								<tr>
									<th>상품 이미지</th>
									<td>
										<div class="thumbimg">
											<div>
												<a href="/upload${vo.img1}" target="_blank">
													<img src="/upload${vo.img1}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
													<br/>원본
												</a>
											</div>
											<div>
												<a href="/upload${fn:replace(vo.img1, 'origin', 's60')}" target="_blank">
													<img src="/upload${fn:replace(vo.img1, 'origin', 's60')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
													<br/>60x60
												</a>
											</div>
											<div>
												<a href="/upload${fn:replace(vo.img1, 'origin', 's110')}" target="_blank">
													<img src="/upload${fn:replace(vo.img1, 'origin', 's110')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
													<br/>110x110
												</a>
											</div>
											<div>
												<a href="/upload${fn:replace(vo.img1, 'origin', 's170')}" target="_blank">
													<img src="/upload${fn:replace(vo.img1, 'origin', 's170')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
													<br/>170x170
												</a>
											</div>
											<div style="margin-left:20px;">
												<button type="button" class="btn btn-default" onclick="convertAgain('${vo.img1}')">이미지 다시 변환하기</button>
											</div>
										</div>

										<c:if test="${vo.img2 ne ''}">
											<div class="clearfix"></div>
											<div class="thumbimg">
												<div>
													<a href="/upload${vo.img2}" target="_blank">
														<img src="/upload${vo.img2}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>원본
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img2, 'origin', 's60')}" target="_blank">
														<img src="/upload${fn:replace(vo.img2, 'origin', 's60')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>60x60
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img2, 'origin', 's110')}" target="_blank">
														<img src="/upload${fn:replace(vo.img2, 'origin', 's110')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>110x110
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img2, 'origin', 's170')}" target="_blank">
														<img src="/upload${fn:replace(vo.img2, 'origin', 's170')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>170x170
													</a>
												</div>
												<div><button type="button" class="btn btn-default" onclick="convertAgain('${vo.img2}')">이미지 다시 변환하기</button></div>
											</div>
										</c:if>
										<c:if test="${vo.img3 ne ''}">
											<div class="clearfix"></div>
											<div class="thumbimg">
												<div>
													<a href="/upload${vo.img3}" target="_blank">
														<img src="/upload${vo.img3}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>원본
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img3, 'origin', 's60')}" target="_blank">
														<img src="/upload${fn:replace(vo.img3, 'origin', 's60')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>60x60
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img3, 'origin', 's110')}" target="_blank">
														<img src="/upload${fn:replace(vo.img3, 'origin', 's110')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>110x110
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img3, 'origin', 's170')}" target="_blank">
														<img src="/upload${fn:replace(vo.img3, 'origin', 's170')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>170x170
													</a>
												</div>
												<div><button type="button" class="btn btn-default" onclick="convertAgain('${vo.img3}')">이미지 다시 변환하기</button></div>
											</div>
										</c:if>
										<c:if test="${vo.img4 ne ''}">
											<div class="clearfix"></div>
											<div class="thumbimg">
												<div>
													<a href="/upload${vo.img4}" target="_blank">
														<img src="/upload${vo.img4}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>원본
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img4, 'origin', 's60')}" target="_blank">
														<img src="/upload${fn:replace(vo.img4, 'origin', 's60')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>60x60
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img4, 'origin', 's110')}" target="_blank">
														<img src="/upload${fn:replace(vo.img4, 'origin', 's110')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>110x110
													</a>
												</div>
												<div>
													<a href="/upload${fn:replace(vo.img4, 'origin', 's170')}" target="_blank">
														<img src="/upload${fn:replace(vo.img4, 'origin', 's170')}" alt="" width="120px" height="120px" style="width:120px;height:120px;margin-right:5px;"/>
														<br/>170x170
													</a>
												</div>
												<div><button type="button" class="btn btn-default" onclick="convertAgain('${vo.img4}')">이미지 다시 변환하기</button></div>
											</div>
										</c:if>
									</td>
								</tr>
								<tr>
									<th>상품 추가 정보</th>
									<td>
										<table class="table table-bordered">
											<colgroup>
												<col style="width:30%;"/>
												<col width="*"/>
											</colgroup>
											<tbody>
									<c:choose>
										<c:when test="${vo.typeCd ne 0}">
											<c:forEach var="item" items="${propList}" varStatus="status" begin="0" step="1">
												<tr>
													<c:if test="${status.index eq 0}">
														<th class="text-center">상품군</th>
														<td class="text-left">${item.typeNm}</td>
													</c:if>
												</tr>
												<tr>
													<c:set var="tempPropVal" value="prop_val${status.count}"/>
													<th class="text-center">${item.propNm}</th>
													<td>
														<c:choose>
															<c:when test="${(propInfo[tempPropVal] eq '') or (propInfo[tempPropVal] eq null)}">
																${item.defaultVal}
															</c:when>
															<c:otherwise>
																${propInfo[tempPropVal]}
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<td class="muted text-center" colspan="2">상품 추가정보가 존재하지 않습니다.</td>
										</c:otherwise>
									</c:choose>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<th>상품 상세정보</th>
									<td>
										${vo.content}
										<c:if test="${vo.detailImg1 ne ''}"><img src="/upload${vo.detailImg1}" alt="" /></c:if>
										<c:if test="${vo.detailImg2 ne ''}"><img src="/upload${vo.detailImg2}" alt="" /></c:if>
										<c:if test="${vo.detailImg3 ne ''}"><img src="/upload${vo.detailImg3}" alt="" /></c:if>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">상품 가격 / 재고량 정보 </h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-striped table-bordered">
							<colgroup>
								<col style="width:15%;"/>
								<col style="width:*;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:15%;"/>
								<col style="width:10%;"/>

							</colgroup>
							<thead>
							<tr>
								<th>쇼핑몰</th>
								<th>판매자</th>
								<th>판매가격</th>
								<th>할인가격</th>
								<th>할인기간</th>
								<th>재고량</th>
								<th>재고관리</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${optionList}" varStatus="status" begin="0" step="1">
								<tr>
									<td class="text-center">${item.optionName}</td>
									<td class="text-center">${item.valueName}</td>
									<td class="text-center"><fmt:formatNumber value="${item.optionPrice}" pattern="#,###" /> 원</td>
									<td class="text-center"><fmt:formatNumber value="${item.salePrice}" pattern="#,###" /> 원</td>
									<td class="text-center">${item.salePeriod}</td>
									<td class="text-center">${item.stockCount}</td>
									<td class="text-center">${item.stockFlag eq "Y" ? "재고관리":"재고관리 안함" }</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(optionList)==0 }">
								<tr><td class="text-center" colspan="7">조회된 데이터가 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">상품 정보 변경 이력</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<div id="logTable">
							이력을 불러오고 있습니다 <img src="/assets/img/common/ajaxloader.gif" alt="" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<form action="/admin/item/delete/proc/${vo.seq}" target="zeroframe" method="post">
	<input type="hidden" name="search" value="${param.search}" />
<div id="deleteModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>정말로 "${vo.name}" 상품을 삭제하시겠습니까?</legend>
				<p>이 상품과 관련된 정보들이 유실될 수 있습니다</p>
				<p>단지 리스트에 노출되지 않으려면 상태를 숨김으로 변경하십시오</p>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-sm btn-default" href="#">close</a>
				<button class="btn btn-sm btn-danger">삭제하기</button>
			</div>
		</div>
	</div>
</div>
</form>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	goPage(0);
});
var deleteItem = function(statusCode, loginType) {
	if(loginType === 'S' && statusCode === 'H' || loginType === 'S' && statusCode === 'Y') {
		alert('가승인,판매중 상태의 제품은 삭제 할 수 없습니다.');
		return;
	}
	$('#deleteModal').modal();
}
var goPage = function(page) {
	$.ajax({
		url:"/admin/item/view/${vo.seq}/log/ajax",
		type:"get",
		data:{pageNum:page},
		dataType:"text",
		success:function(data) {
			$("#logTable").html(data);
		},
		error:function(error) {
			alert( error.status + ":" +error.statusText );
		}
	});
};
var convertAgain = function(filename) {
	$("#zeroframe").attr("src", "/admin/item/image/resize/again?filename=" + filename);
};
var showLog = function(seq){
	$('#'+seq).toggle();
}
</script>
</body>
</html>
