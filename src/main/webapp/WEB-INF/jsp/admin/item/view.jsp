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
						<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
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
								<col style="width:10%;"/>
								<col style="width:*;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<%--<col style="width:10%;"/>--%>
							</colgroup>
							<thead>
							<tr>
								<th>쇼핑몰</th>
								<th>판매자</th>
								<th>판매가격</th>
								<th>할인가격</th>
								<th>할인기간</th>
								<th>재고량</th>
								<th>무료배송여부</th>
								<th>이벤트</th>
								<th></th>
								<%--<th>재고관리</th>--%>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${optionList}" varStatus="status" begin="0" step="1">
								<tr>
									<td class="text-center">병원몰</td>
									<td class="text-center">${item.valueName}</td>
									<td class="text-center"><fmt:formatNumber value="${item.optionPrice}" pattern="#,###" /> 원</td>
									<td class="text-center"><fmt:formatNumber value="${item.salePrice}" pattern="#,###" /> 원</td>
									<td class="text-center">${item.salePeriod}</td>
									<td class="text-center">${item.stockCount}</td>
									<td class="text-center">${item.freeDeli}</td>
									<td class="text-center">${item.eventAdded}</td>
									<%--<td class="text-center">${item.stockFlag eq "Y" ? "재고관리":"재고관리 안함" }</td>--%>
									<td class="text-center">
										<button type="button" class="btn btn-sm btn-default" onclick="EBOption.showUpdateOptionValueModal(this, '${item.seq}')">수정</button>
										<button type="button" class="btn btn-sm btn-danger" onclick="EBOption.showDeleteOptionValueModal(this, '${item.seq}')">삭제</button>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(optionList)==0 }">
								<tr><td class="text-center" colspan="9">조회된 데이터가 없습니다.</td></tr>
							</c:if>

							</tbody>
						</table>
						<c:if test="${ fn:length(optionList)==0 }">
							<button type="button" id="OptionAddBtn" onclick="EBOption.showAddModal(${vo.seq})" class="btn btn-info pull-right">상품가격추가</button>
						</c:if>
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
<script id="propTemplate" type="text/html">
	{{each prop}}
	{{if $index===0}}
	<tr>
		<th>상품군</th>
		<td><%="${typeNm}"%></td>
	</tr>
	{{/if}}
	<tr class="propTr">
		<th><%="${propNm}"%></th>
		<td>
			{{if propType==="T"}}
			<input type="text" name="prop_val<%="${$index+1}"%>" value="<%="${defaultVal}"%>" alt="<%="${propNm}"%>" style="width:50%" maxlength="100"/>
			<input type="hidden" name="prop_cd<%="${$index+1}"%>" value="<%="${propCd}"%>">
			{{else propType==="R"}}
			{{each radioList.split("|")}}
			{{if $value.indexOf("[text]") > 0}}
			<input type="radio" class="radio" name="prop_val<%="${number+1}"%>" value="<%="${$value.replace(\"[text]\",\"\")}"%>" alt="<%="${$value.replace(\"[text]\",\"\")}"%>"/> <%="${$value.replace(\"[text]\",\"\")}"%>
			<input type="text" alt="<%="${$value.replace(\"[text]\",\"\")}"%>" value="제품 상세 설명내 표기" maxlength="40">
			{{else (/[\[][(Y|N)][\]]/).test($value)}}
			<input type="radio" name="prop_val<%="${number+1}"%>" value="<%="${((/[\\[][Y][\\]]/).test($value)?'Y':'N')}"%>" {{if $value.indexOf('['+defaultVal+']')>0 }}checked="checked"{{/if}}/> <%="${$value.replace( (/[\\[][(Y|N)][\\]]/),'')}"%>
			{{else}}
			<input type="radio" name="prop_val<%="${number+1}"%>" value="<%="${$value}"%>" alt="" {{if $value==defaultVal}}checked="checked"{{/if}}/> <%="${$value}"%>
			{{/if}}
			{{/each}}
			{{else}}
			비정상적인 데이터가 삽입되었습니다
			{{/if}}
		</td>
	</tr>
	{{/each}}
</script>


<script id="sellerTemplate" type="text/html">
	<tr style="cursor:hand;" data-seq="<%="${seq}"%>" onclick="sellerSelectProc(this)">
		<td class="text-center"><%="${id}"%></td>
		<td class="text-center" id="seller_name<%="${seq}"%>"><%="${name}"%></td>
		<td class="text-center"><%="${gradeCode}"%></td>
		<td class="text-center"><%="${adjustGradeCode}"%></td>
		<td class="text-center"><%="${statusCode}"%></td>
		<td class="text-center"><%="${ceoName}"%></td>
		<td class="text-center"><%="${tel}"%></td>
		<td class="text-center"><%="${salesName}"%></td>
		<td class="text-center"><%="${salesTel}"%></td>
		<td class="text-center"><%="${approvalDate}"%></td>
	</tr>
</script>
<script id="optionAddTemplate" type="text/html">
	<div class="modal-dialog">
		<div class="modal-content">
			<form class="form-horizontal" onsubmit="return false">
				<div class="modal-body">
					<legend>상품가격 추가</legend>
					<div class="alert alert-danger">
						이 작업은 <strong>바로 데이터베이스에 적용</strong>됩니다
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">쇼핑몰명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="optionName" value="병원몰" alt="쇼핑몰명" readonly="readonly" />
							<input type="hidden" name="showFlag" value="Y" />
						</div>
					</div>
					<hr/>
					<div class="form-group">
						<label class="col-md-3 control-label">공급자명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="valueName" value="${sessionScope.loginName}" alt="공급자명" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">상품 가격</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="optionPrice" value="0" alt="금액" onblur="numberCheck(this);"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">할인 가격</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="salePrice" value="0" alt="할인가격" onblur="numberCheck(this);"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">할인 기간</label>
						<div class="col-md-9">
							<div class="input-group">
								<input type="text" class="form-control datepicker" name="salePeriod"  maxlength="8" onblur="numberCheck(this);" value=""/>
								<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">재고수량</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="stockCount" maxlength="5" value="0" class="numeric" alt="재고수량" onblur="numberCheck(this);" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">무료배송</label>
						<div class="col-md-9">
							<div class="checkbox">
								<label><input type="checkbox" name="freeDeli" value="N">무료배송</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">이벤트</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="eventAdded" maxlength="5" value="" class="numeric" alt="이벤트" />
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<a data-dismiss="modal" class="btn" href="#">close</a>
					<button type="button" onclick="EBOption.submitAddProc(<%="${seq}"%>, this)" class="btn btn-primary">추가</button>
				</div>
			</form>
		</div>
		<div>
</script>

<script id="optionValueAddTemplate" type="text/html">

	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title">상품가격 추가</h3>
			</div>
			<form class="form-horizontal" onsubmit="return false">
				<div class="modal-body">
					<div class="alert alert-danger">이 작업은 <strong>바로 데이터베이스에 적용</strong>됩니다</div>
					<div class="form-group">
						<label class="col-md-3 control-label">쇼핑몰명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="valueName" value="병원몰" alt="쇼핑몰명" readonly="readonly" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-md-3 control-label">공급자명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="valueName" value="<%="${valueName}"%>"  alt="고급자명"  readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">상품 가격</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="optionPrice" value="0" alt="금액" onblur="numberCheck(this);"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">할인 가격</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="salePrice" value="0" alt="할인가격" onblur="numberCheck(this);"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">할인 기간</label>
						<div class="col-md-9">
							<div class="input-group">
								<input type="text" class="form-control datepicker" name="salePeriod"  maxlength="8" onblur="numberCheck(this);" />
								<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">재고수량</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="stockCount" value="999" maxlength="5" class="numeric" alt="재고수량" onblur="numberCheck(this);" />
							<%--<div class="checkbox">--%>
							<%--<label><input type="checkbox" name="stockFlag" value="N"> 재고관리 안함</label>	--%>
							<%--</div>--%>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">무료배송</label>
						<div class="col-md-9">
							<%--<input type="text" class="form-control" name="freeDe;o" value="Y" maxlength="5" class="numeric" alt="무료배송"  />--%>
							<div class="checkbox">
							<label><input type="checkbox" name="freeDeli" value="N">무료배송</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">이벤트</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="eventAdded" value="" maxlength="10" class="numeric" alt="이벤트"  />

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<a data-dismiss="modal" class="btn btn-md btn-default" href="#">취소</a>
					<button type="button btn-md btn-primary" onclick="EBOption.submitAddValueProc(<%="${optionSeq}"%>, this)" class="btn btn-primary">추가</button>
				</div>
			</form>
		</div>
	</div>
	</form>
</script>
<script id="optionUpdateTemplate" type="text/html">
	<form action="<%="${action}"%>" id="optionDiv" class="form-horizontal" method="post" target="zeroframe">
		<input type="hidden" name="seq" value="<%="${seq}"%>" />
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<legend>"<%="${optionName}"%>" 수정하기</legend>
					<div class="alert alert-danger">이 작업은 <strong>바로 데이터베이스에 적용</strong>됩니다</div>
					<label class="col-md-3 control-label">쇼핑몰명</label>
					<div class="col-md-9">
						<input type="text" class="form-control" name="optionName" value="병원몰" alt="쇼핑몰명" readonly="readonly" />
						<input type="hidden" name="showFlag" value="Y" />
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">상품옵션명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="optionName" value="<%="${optionName}"%>" alt="상품옵션명" />
							<input type="hidden" name="showFlag" value="Y" />
						</div>
					</div>
					<%--<div class="form-group">--%>
					<%--<label class="col-md-2 control-label">판매상태</label>--%>
					<%--<div class="col-md-10">--%>
					<%--<select class="form-control" name="showFlag" style="width:120px">--%>
					<%--<option value="Y" {{if showFlag=="Y"}}selected{{/if}}>판매</option>--%>
					<%--<option value="N" {{if showFlag=="N"}}selected{{/if}}>숨김</option>--%>
					<%--</select>--%>
					<%--</div>--%>
					<%--</div>--%>
				</div>
				<div class="modal-footer">
					<a data-dismiss="modal" class="btn btn-md btn-default" href="#">취소</a>
					<button type="submit" class="btn btn-md btn-primary">수정</button>
				</div>
			</div>
		</div>
	</form>
</script>
<script id="optionValueUpdateTemplate" type="text/html">
	<form action="<%="${action}"%>" id="optionValueDiv" class="form-horizontal" method="post" target="zeroframe" onsubmit="return optionSubmitProc(this)">
		<input type="hidden" name="seq" value="<%="${seq}"%>" />
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<legend>"<%="${valueName}"%>" 항목 수정하기</legend>
					<div class="alert alert-danger">이 작업은 <strong>바로 데이터베이스에 적용</strong>됩니다</div>


					<div class="form-group">
						<label class="col-md-3 control-label">쇼핑몰명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="optionName" value="병원몰" alt="쇼핑몰명" readonly="readonly" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-md-3 control-label">공급자명</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="valueName" value="<%="${valueName}"%>" alt="공급자명" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">상품 가격</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="optionPrice" value="<%="${optionPrice}"%>" alt="추가금액" onblur="numberCheck(this);"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">할인 가격</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="salePrice" value="<%="${salePrice}"%>" alt="할인가격" onblur="numberCheck(this);"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">할인 기간</label>
						<div class="col-md-9">
							<div class="input-group">
								<input type="text" class="form-control datepicker" name="salePeriod" value="<%="${salePeriod}"%>" maxlength="8"/>
								<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">재고수량</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="stockCount" maxlength="5" value="<%="${stockCount}"%>" class="numeric" alt="재고수량" onblur="numberCheck(this);" />
							<%--<div class="checkbox">--%>
							<%--<label><input type="checkbox" name="stockFlag" value="N" {{if stockFlag == 'N'}}checked{{/if}}> 재고관리 안함</label>	--%>
							<%--</div>--%>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">무료배송</label>
						<div class="col-md-9">
							<%--<input type="text" class="form-control" name="freeDe;o" value="Y" maxlength="5" class="numeric" alt="무료배송"  />--%>
							<div class="checkbox">
								<label><input type="checkbox" name="freeDeli" value="<%="${freeDeli}"%>">무료배송</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">이벤트</label>
						<div class="col-md-9">
							<input type="text" class="form-control" name="eventAdded" value="<%="${eventAdded}"%>" maxlength="10" class="numeric" alt="이벤트"  />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<a data-dismiss="modal" class="btn btn-md btn-default" href="#">취소</a>
					<button type="submit" class="btn btn-md btn-primary">수정</button>
				</div>
			</div>
		</div>
	</form>
</script>
<script id="optionDeleteTemplate" type="text/html">
	<form action="<%="${action}"%>" target="zeroframe">
		<input type="hidden" name="seq" value="<%="${seq}"%>" />
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<legend>정말로 "<%="${optionName}"%><%="${valueName}"%>" 공급자 가격을 삭제하시겠습니까?</legend>
					<p>이 작업은 (수정버튼을 누르지 않아도) <strong>바로 데이터베이스에 적용</strong>됩니다</p>
					<p>이 쇼핑몰 항목과 관련있는 데이터가 유실될 수 있습니다</p>
				</div>
				<div class="modal-footer">
					<a data-dismiss="modal" class="btn" href="#">취소</a>
					<button type="submit" class="btn btn-danger">삭제</button>
				</div>
			</div>
		</div>
	</form>
</script>
<div id="optionModal" class="modal"></div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/admin/item/form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	goPage(0);
	<c:if test="${vo eq null}">
	setTimeout(function(){
		EBCategory.renderList(1, 0, 0);
	}, 100);
	EBOption.add(); //옵션추가
	EBOption.addChild($('.optionValueAdd'));

	</c:if>

	<c:if test="${vo ne null}">
		//옵션
		EBOption.renderList(${vo.seq});
	</c:if>
});
var deleteItem = function(statusCode, loginType) {
	if(loginType === 'S' && statusCode === 'H' || loginType === 'S' && statusCode === 'Y') {
		alert('가승인,판매중 상태의 제품은 삭제 할 수 없습니다.');
		return;
	}
	$('#deleteModal').modal();
};
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
};

</script>
</body>
</html>
