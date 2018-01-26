<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<!-- bootstrap wysihtml5 - text editor -->
	<link href="/admin_lte2/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.thumbimg {padding:0 5px;}
		.thumbimg div {float:left;text-align:center}
		.thumbimg img {margin-right:5px; cursor:pointer; width:120px; height:120px}
		.detail-content {display:none}
		.detail-image {display:none}
	</style>
</head>
<body class="skin-blue sidebar-sm">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>상품 관리<small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>상품 관리</li>
			<li>상품 리스트</li>
			<li class="active">${title}</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box container-fluid">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">
							<i class="fa fa-edit"></i> ${title}
						</h3>
					</div>
					<!-- 내용 -->
					<form id="validation-form" class="form-horizontal" method="post" action="<c:if test="${vo eq null}">/admin/item/form/new</c:if><c:if test="${vo ne null}">/admin/item/form/modify</c:if>" target="zeroframe" onsubmit="return submitProc(this)">
						<input type="hidden" id="updateType" name="updateType" />
						<input type="hidden" name="searchText" value="${param.search}" />
						<div class="box-body">
						<c:if test="${vo ne null}">
							<input id="seq" type="hidden" name="seq" value="${vo.seq}" />
						</c:if>
						<%--상품 수정시에만 해당 항목을 보여줌--%>
						<c:if test="${vo ne null}">
							<div class="form-group">
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-2 form-control-static">${mallName}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상품 코드</label>
								<div class="col-md-2 form-control-static">${vo.seq}</div>
							</div>
							<c:if test="${sessionScope.loginType eq 'A'}">

								<div class="form-group">
									<label class="col-md-2 control-label">관리코드</label>
									<div class="col-md-3">
										<input type="text" class="form-control" name="managedCode" value="${vo.managedCode}" maxlength="16" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">바코드</label>
									<div class="col-md-3">
										<input type="text" class="form-control" name="barcode" value="${vo.barcode}" maxlength="16" />
									</div>
								</div>


								<div class="form-group">
									<label class="col-md-2 control-label">판매 상태</label>
									<div class="radio">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A'}">
												<label><input type="radio" name="statusCode" value="H" <c:if test="${vo.statusCode eq 'H' or vo.statusCode eq 'E'}">checked="checked"</c:if> /> 가승인</label>
												<label><input type="radio" name="statusCode" value="Y" <c:if test="${vo.statusCode eq 'Y'}">checked="checked"</c:if> /> 판매중</label>
											</c:when>
											<c:when test="${sessionScope.loginType eq 'A' && vo.statusCode ne 'N'}">
												<label><input type="radio" name="statusCode" value="${vo.statusCode}" checked="checked" style="display: none;"/></label>
											</c:when>
										</c:choose>
										<label><input type="radio" name="statusCode" value="N" <c:if test="${vo.statusCode eq 'N'}">checked="checked"</c:if> /> 판매중지</label>
									</div>
								</div>
							</c:if>
							<c:if test="${sessionScope.loginType eq 'S'}">
								<input type="hidden" name="statusCode" value="${vo.statusCode}" />
							</c:if>
						</c:if>
							<script id="lvTemplate" type="text/html">
								<option value="">분류를 선택해주세요</option>
								{{each list}}
									<option value="<%="${seq}"%>"><%="${name}"%></option>
								{{/each}}
							</script>
							<c:if test="${vo eq null}">
								<div class="form-group">
									<label class="col-md-2 control-label">쇼핑몰</label>
									<div class="col-md-2 form-control-static">${mallName}</div>
									<input type="hidden" name="mallId" value="${mallSeq}" />
								</div>

								<div class="form-group">
									<label class="col-md-2 control-label">대분류 <i class="fa fa-check"></i></label>
									<div class="col-md-3">
										<select class="form-control col-md-2" id="lv1" name="cateLv1Seq" onchange="EBCategory.renderList(2, $(this).val(),${mallSeq})">데이터를 불러오고 있습니다</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-2 control-label">중분류</label>
									<div class="col-md-3">
										<select class="form-control" id="lv2" name="cateLv2Seq" onchange="EBCategory.renderList(3, $(this).val(), ${mallSeq})">데이터를 불러오고 있습니다</select>
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-2 control-label">소분류</label>
									<div class="col-md-3">
										<select class="form-control" id="lv3" name="cateLv3Seq" onchange="EBCategory.renderList(4, $(this).val(), ${mallSeq})">데이터를 불러오고 있습니다</select>
									</div>
								</div>

								<div id="regFormLv4SelectBox" class="form-group">
									<label class="col-md-2 control-label">세분류</label>
									<div class="col-md-3">
										<select class="form-control" id="lv4" name="cateLv4Seq"></select>
									</div>
								</div>

							</c:if>
							<c:if test="${vo ne null}">
								<div class="form-group">
									<label class="col-md-2 control-label">분류</label>
									<div class="col-md-10">
										<span id="categoryText">
										${vo.cateLv1Name}
										<c:if test="${vo.cateLv2Name ne ''}"> &gt; ${vo.cateLv2Name}</c:if>
										<c:if test="${vo.cateLv3Name ne ''}"> &gt; ${vo.cateLv3Name}</c:if>
										<c:if test="${vo.cateLv4Name ne ''}"> &gt; ${vo.cateLv4Name}</c:if>
										</span>
										<button type="button" onclick="$('#categoryModal').modal()" class="btn btn-sm btn-default">수정</button>
									</div>
									<input type="hidden" name="cateLv1Seq" value="${vo.cateLv1Seq}" />
									<input type="hidden" name="cateLv2Seq" value="${vo.cateLv2Seq}" />
									<input type="hidden" name="cateLv3Seq" value="${vo.cateLv3Seq}" />
									<input type="hidden" name="cateLv4Seq" value="${vo.cateLv4Seq}" />
								</div>
							</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label">상품 구분 <i class="fa fa-check"></i></label>
								<div class="radio">
									<label><input type="radio" onclick="setTypeCode()" name="typeCode" value="N" ${vo eq null or vo.typeCode eq 'N' ? "checked":""} alt="상품 구분" /> 일반 상품</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상품명 <i class="fa fa-check"></i></label>
								<div class="col-md-5">
									<input type="text" class="form-control" name="name" value="${vo.name}" maxlength="90" alt="상품명" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">규격1</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="type1" value="${vo.type1}" maxlength="16" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">규격2</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="type2" value="${vo.type2}" maxlength="16" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">규격3</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="type3" value="${vo.type3}" maxlength="16" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">보험 코드</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="insuranceCode" value="${vo.insuranceCode}" maxlength="16" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">제조사</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="maker" value="${vo.maker}" maxlength="16" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">진료 과목</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="subjectType" value="${vo.subjectType}" maxlength="16" />
								</div>
							</div>

<%--
							<div class="form-group">
								<label class="col-md-2 control-label">제조사 <i class="fa fa-check"></i></label>
								<div class="col-md-3">
									<--입점업체 상품 등록시에는 입점업체명을 기본값으로 넣는다.-->
									<input type="text" class="form-control" id="maker" name="maker" value="${vo eq null && sessionScope.loginType eq 'S' ? sessionScope.loginName : vo.maker}" maxlength="26" alt="제조사"/>
								</div>
							</div>
--%>
							<div class="form-group">
								<label class="col-md-2 control-label">발주처 </label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="brand" value="${vo.brand}" maxlength="45"/>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">기준재고 </label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="modelName" value="${vo.modelName}" maxlength="45"/>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">단위</label>
								<div class="col-md-3">
									<input type="text" class="form-control" name="originCountry" value="${vo.originCountry}" maxlength="26" />
								</div>
							</div>

							<div class="form-group hide">
								<label class="col-md-2 control-label">자동발주량</label>
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" class="form-control text-right" name="minCnt" value="${vo.minCnt}" onblur="numberCheck(this);" maxlength="3" disabled="true"/>
										<div class="input-group-addon">개</div>
									</div>

								</div>
							</div>
							<%--입점업체의 경우 총판 공급가 숨김--%>
							<input type="hidden" name="supplyMasterPrice" value="${vo.supplyMasterPrice}" maxlength="10" disabled/>

							<div class="form-group">
								<label class="col-md-2 control-label">대표 이미지<c:if test="${vo eq null}"> <i class="fa fa-check"></i></c:if></label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="img1" readonly="readonly" <c:if test="${vo eq null}">alt="대표 이미지"</c:if>/>
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadModal(1)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.img1 ne ''}">
										<button type="button" onclick="showDeleteModal(1, '${vo.img1}', ${vo.seq})" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>


							<div class="form-group">
								<label class="col-md-2 control-label">서브 이미지1</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="img2" readonly="readonly" />
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadModal(2)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.img2 ne ''}">
										<button type="button" onclick="showDeleteModal(2, '${vo.img2}', ${vo.seq})" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">서브 이미지2</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="img3" readonly="readonly" />
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadModal(3)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.img3 ne ''}">
										<button type="button" onclick="showDeleteModal(3, '${vo.img3}', ${vo.seq})" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">서브 이미지3</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="img4" readonly="readonly" />
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadModal(4)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.img4 ne ''}">
										<button type="button" onclick="showDeleteModal(4, '${vo.img4}', ${vo.seq})" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상세 정보 <i class="fa fa-check"></i></label>
								<div class="radio">
									<label><input type="radio" name="useCode" value="C" onclick="showCode()" <c:if test="${vo eq null or vo.useCode eq 'C'}">checked="checked"</c:if> />컨텐츠</label>
									<label><input type="radio" name="useCode" value="I" onclick="showCode()" <c:if test="${vo.useCode eq 'I'}">checked="checked"</c:if> />이미지</label>
								</div>
							</div>

							<div class="detail-content form-group">
								<label class="col-md-2 control-label"></label>
								<div class="col-md-10">
									<textarea name="content">${vo.content}</textarea>
								</div>
							</div>

							<div class="detail-image form-group">
								<label class="col-md-2 control-label">상세 이미지 1</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="detailImg1" readonly="readonly" />
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadDetailModal(1)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.detailImg1 ne ''}">
										<button type="button" onclick="showDeleteDetailModal(1, '${vo.detailImg1}', '${vo.seq}')" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>

							<div class="detail-image form-group">
								<label class="col-md-2 control-label">상세 이미지1 ALT 값</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="detailAlt1" value="${vo.detailAlt1}"/>
								</div>
							</div>

							<div class="detail-image form-group">
								<label class="col-md-2 control-label">상세 이미지 2</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="detailImg2" readonly="readonly" />
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadDetailModal(2)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.detailImg2 ne ''}">
										<button type="button" onclick="showDeleteDetailModal(2, '${vo.detailImg2}', '${vo.seq}')" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>

							<div class="detail-image form-group">
								<label class="col-md-2 control-label">상세 이미지2 ALT 값</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="detailAlt2" value="${vo.detailAlt2}"/>
								</div>
							</div>

							<div class="detail-image form-group">
								<label class="col-md-2 control-label">상세 이미지 3</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="detailImg3" readonly="readonly" />
									<div class="thumbimg"></div>
								</div>
								<div>
									<button type="button" onclick="showUploadDetailModal(3)" class="btn btn-info">업로드</button>
									<c:if test="${vo ne null and vo.detailImg3 ne ''}">
										<button type="button" onclick="showDeleteDetailModal(3, '${vo.detailImg3}', '${vo.seq}')" class="btn btn-danger">삭제</button>
									</c:if>
								</div>
							</div>

							<div class="detail-image form-group">
								<label class="col-md-2 control-label">상세 이미지3 ALT 값</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="detailAlt3" value="${vo.detailAlt3}"/>
								</div>
							</div>
							<c:if test="${sessionScope.loginType ne 'A'}">
							<div class="form-group">
								<label class="col-md-2 control-label"></label>
								<div class="col-md-10">
									<script id="optionTemplate" type="text/html">
										<tr class="parent" data-pk="<%="${idx}"%>">
											<td class="text-center">
												<input type="text" class="form-control" name="optionName" value="옵션" alt="상품옵션명" maxlength="90" />
												<input type="hidden" name="showFlag" value="Y" />
											</td>
											<td class="text-center">
												<button class="btn btn-sm btn-default optionValueAdd" type="button" onclick="EBOption.addChild(this)">
													항목 추가 <i class="fa fa-fw fa-plus"></i>
												</button>
											</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<%--<td></td>--%>
											<td class="text-center">
												<!--<button type="button" onclick="EBOption.remove(this)" class="btn btn-sm btn-danger">삭제</button>-->
											</td>
										</tr>
									</script>
									<script id="optionChildTemplate" type="text/html">
										<tr class="child" data-pk="<%="${idx}"%>">
											<th class="text-center">
												병원몰
												<input type="hidden" name="optionName" value="병원몰" readonly="readonly"/>
												<input type="hidden" name="showFlag" value="Y"/>
											</th>
											<th class="text-center">
												<%="${sessionScope.loginName}"%>
												<input type="hidden" name="valueName" value="<%="${sessionScope.loginName}"%>"/>
											</th>
											<td class="text-center">
												<div class="input-group">
													<input type="text" class="form-control text-right" name="optionPrice" value="0" alt="판매가격" onblur="numberCheck(this);" maxlength="11" />
													<div class="input-group-addon">원</div>
												</div>
											</td>
											<td class="text-center">
												<div class="input-group">
													<input type="text" class="form-control text-right" name="salePrice" value="0" alt="할인가격" onblur="numberCheck(this);" maxlength="11" />
													<div class="input-group-addon">원</div>
												</div>
											</td>
											<td class="text-center">
												<div class="input-group">
													<input type="text" class="form-control text-right" name="salePeriod"  maxlength="8" onblur="numberCheck(this);"  />
												</div>
											</td>
											<td class="text-center">
												<div class="input-group">
													<input type="text" class="form-control text-right" id="stockCount" maxlength="5" name="재고량" onblur="numberCheck(this)" value="999" alt="재고수량" maxlength="6" />
													<div class="input-group-addon">개</div>
												</div>
											</td>
											<%--<td class="text-center">--%>
												<%--<div class="checkbox">--%>
													<%--<label><input type="checkbox" name="stockFlag" value="N"/> 재고관리 안함</label>--%>
												<%--</div>--%>
											<%--</td>--%>
											<td></td>
										</tr>

									</script>
									<script id="optionEditTemplate" type="text/html">
										{{each list}}
										<tr class="child" data-pk="<%="${idx}"%>">
											<td class="text-center">
												<%="${optionName}"%>
												<input type="hidden" name="optionName" value="<%="${optionName}"%>"/>
												<input type="hidden" name="showFlag" value="Y"/>
											</td>
											<td class="text-center">
												<%="${valueName}"%>
												<input type="hidden" name="valueName" value="<%="${valueName}"%>"/>
											</td>
											<td class="text-center">
												<%="${optionPrice}"%>
												<input type="hidden" name="optionPrice" value="<%="${optionPrice}"%>"/> 원
											</td>
											<td class="text-center">
												<%="${salePrice}"%>
												<input type="hidden" name="salePrice" value="<%="${salePrice}"%>"/> 원
											</td>
											<td class="text-center">
												<%="${salePeriod}"%>
												<input type="hidden" name="salePeriod" value="<%="${salePeriod}"%>" />
											</td>
											<td class="text-center">
												<%="${numeral(stockCount).format('0,0')}"%>
												<input type="hidden" name="stockCount" value="<%="${stockCount}"%>"/>
											</td>
											<%--<td class="text-center">--%>
												<%--{{if stockFlag == 'Y'}}--%>
												<%--재고관리--%>
												<%--{{else}}--%>
												<%--재고관리 안함--%>
												<%--{{/if}}--%>
												<%--<input type="checkbox" name="stockFlag" value="<%="${stockFlag}"%>" {{if stockFlag == 'N'}}checked{{/if}} style="display:none;"/>--%>
											<%--</td>--%>
											<td class="text-center">
												<button type="button" class="btn btn-sm btn-default" onclick="EBOption.showUpdateOptionValueModal(this, <%="${seq}"%>)">수정</button>
												<button type="button" class="btn btn-sm btn-danger" onclick="EBOption.showDeleteOptionValueModal(this, <%="${seq}"%>)">삭제</button>
											</td>
										</tr>
										{{/each}}
									</script>

									<c:if test="${vo ne null}">
									<table class="table table-bordered">
										<colgroup>
											<col style="width:10%;"/>
											<col style="width:*"/>
											<col style="width:10%;"/>
											<col style="width:10%;"/>
											<col style="width:10%;"/>
											<col style="width:10%;"/>
											<%--<col style="width:10%;"/>--%>
											<col style="width:10%;"/>
										</colgroup>
										<thead>
										<tr>
											<th>쇼핑몰</th>
											<th>공급사</th>
											<th>가격</th>
											<th>할인가격</th>
											<th>할인기간</th>
											<th>재고량</th>
											<%--<th>재고관리</th>--%>
											<th></th>
										</tr>
										</thead>
										<tbody id="eb-option-list">


										<tr><td class="muted text-center" colspan="7">
											데이터를 불러오고 있습니다 <img src="/assets/img/common/ajaxloader.gif" alt="" />
										</td></tr>

										</tbody>
									</table>
									</c:if>
									<c:if test="${vo ne null}">
										<button type="button" id="OptionAddBtn" onclick="EBOption.showAddModal(${vo.seq})" class="btn btn-info pull-right">상품가격추가</button>
									</c:if>
								</div>
							</div>
							</c:if>
						</div><!-- /.box-body -->
						<div id="submitButtons" class="box-footer text-center">
							<c:if test="${vo eq null}">
								<button type="button" class="btn btn-primary" onclick="doSubmit(this)">등록하기</button>
							</c:if>
							<c:if test="${vo ne null}">
								<button type="button" class="btn btn-primary" id="mod" onclick="doSubmit(this)">수정하기</button>
							</c:if>
							&nbsp;&nbsp;
							<button type="button" class="btn btn-default" onclick="history.go(-2)">목록보기</button>
						</div><!-- /.box-footer -->
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

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
			<%--<div class="control-group span6">--%>
				<%--<label class="control-label">판매상태</label>--%>
				<%--<div class="controls">--%>
					<%--<select name="showFlag" style="width:120px">--%>
						<%--<option value="Y">판매</option>--%>
						<%--<option value="N">숨김</option>--%>
					<%--</select>--%>
				<%--</div>--%>
			<%--</div>--%>
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
							<input type="text" class="form-control datepicker" name="salePeriod"  maxlength="8" onblur="numberCheck(this);" value="""/>
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

<div id="categoryModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>분류 수정</legend>
				<c:if test="${vo ne null}">
					<label class="label">대분류</label>
					<select class="form-control" id="lv1" name="cateLv1Seq" onchange="EBCategory.renderList(2, $(this).val(),${mallSeq})">데이터를 불러오고 있습니다</select>
					<br/>
					<label class="label">중분류</label>
					<select class="form-control" id="lv2" name="cateLv2Seq" onchange="EBCategory.renderList(3, $(this).val(),${mallSeq})">데이터를 불러오고 있습니다</select>
					<br/>
					<label class="label">소분류</label>
					<select class="form-control" id="lv3" name="cateLv3Seq" onchange="EBCategory.renderList(4, $(this).val(),${mallSeq})">데이터를 불러오고 있습니다</select>
					<br/>
					<div id="updateFormLv4SelectBox">
						<label class="label">세분류</label>
						<select class="form-control" id="lv4" name="cateLv4Seq"></select>
					</div>
				</c:if>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-sm btn-default" href="#">취소</a>
				<button type="button" onclick="EBCategory.update();" class="btn btn-sm btn-primary">적용</button>
				<br/>
				<i class="icon icon-info-sign"></i>적용을 눌러도 페이지 하단의 수정 버튼을 눌러야 저장됩니다
			</div>
		</div>
	</div>
</div>

<div id="okPropModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>상품 추가정보를 저장하고 있습니다</legend>
				<div class="progress progress-striped active">
					<div class="bar" style="width:0%;"></div>
				</div>
				<p class="text-right">작업이 끝날 때까지 조금만 기다려 주세요</p>
			</div>
		</div>
	</div>
</div>

<div id="okModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>저장이 완료되었습니다.</legend>
				<div class="progress progress-striped active">
					<div class="bar" style="width:0%;"></div>
				</div>
				<p class="text-right"><a href="/admin/item/list?mallSeq=${mallSeq}">리스트 페이지로 이동하기</a></p>
			</div>
		</div>
	</div>
</div>

<div id="uploadModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
		<form action="/admin/item/upload" enctype="multipart/form-data" target="zeroframe" method="post">
			<div class="modal-body">
				<legend>이미지 업로드</legend>
				<p>이미지 크기는 <strong>500*500</strong>으로 업로드해주시기 바랍니다</p>
				<p>이미지가 아닐 경우 업로드 되지 않습니다</p>
				<p>이미지는 jpg, jpeg 확장자만 가능합니다</p>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-default" href="#">취소</a>
				<span class="btn btn-success fileinput-button">
					<i class="fa fa-plus"></i>
					<span>이미지 첨부하기...</span>
					<input type="file" name="file[0]" value="" onchange="submitUploadProc(this)" />
					<input type="hidden" name="idx" value="1" />
				</span>
				<span>
					<img src="/assets/img/common/ajaxloader.gif" alt=""/>
				</span>
			</div>
		</form>
		</div>
	</div>
</div>

<form action="/admin/item/upload/detail" enctype="multipart/form-data" target="zeroframe" method="post">
<c:forEach var="item" items="${filterList}" varStatus="status">
	<input type="hidden" id="filter${status.count}" value="${item.filterWord}">
</c:forEach>
	<input type="hidden" id="filterCount" value="${fn:length(filterList)}">
<div id="uploadDetailModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<legend>상세정보 이미지 업로드</legend>
				<p>이미지 크기는 가로<strong>960px</strong>로 업로드해주시기 바랍니다</p>
				<p>이미지가 아닐 경우 업로드 되지 않습니다</p>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn" href="#">취소</a>
				<span class="btn btn-success fileinput-button">
					<i class="icon-plus icon-white"></i>
					<span>이미지 첨부하기...</span>
					<input type="file" name="file[0]" value="" onchange="submitUploadProc(this)" />
					<input type="hidden" name="idx" value="1" />
				</span>
				<span>
					<img src="/assets/img/common/ajaxloader.gif" alt=""/>
				</span>
			</div>
		</div>
	</div>
</div>
</form>

<div id="deleteModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
		<form action="/admin/item/img/delete" target="zeroframe" method="post">
			<div class="modal-body">
				<legend><span id="deleteModalText"></span> 삭제</legend>
				<p>정말로 삭제하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-default" href="#">취소</a>
				<button class="btn btn-danger">
					<i class="fa fa-trash"></i>
					<span>이미지 삭제</span>
					<input type="hidden" name="imageSeq"/>
					<input type="hidden" name="idx" value="1" />
					<input type="hidden" name="imgPath"/>
				</button>
			</div>
		</form>
		</div>
	</div>
</div>

<div id="deleteDetailModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
		<form action="/admin/item/img/delete/detail" target="zeroframe" method="post">
			<div class="modal-body">
				<legend><span id="deleteDetailModalText"></span> 삭제</legend>
				<p>정말로 삭제하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn btn-default a" href="#">취소</a>
				<button class="btn btn-danger">
					<i class="fa fa-trash"></i>
					<span>이미지 삭제</span>
					<input type="hidden" name="imageSeq"/>
					<input type="hidden" name="idx" value="1" />
					<input type="hidden" name="imgPath"/>
				</button>
			</div>
		</form>
		</div>
	</div>
</div>

<div id="previewImage" onclick="$(this).hide();"></div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/admin/item/form.js"></script>
<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>

<!-- CK Editor -->
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>

<!-- Bootstrap WYSIHTML5 -->
<script src="/admin_lte2/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var optionSubmitProc = function(obj) {
		var stockCount = $(obj).find('input[name=stockCount]');
		if(stockCount.val() === '') {
			stockCount.val(0);
		}
		return true;
	};


	var enterSearch = function() {
		var evt_code = (window.netscape) ? event.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			sellerProc(0); //jsonp사용시 enter검색
		}
	}
	
	var copyBtnId;
	var doSubmit = function(obj){
		//상품 수정페이지에서 상품수정인지 상품복사인지 버튼의 ID값으로 판단한다.
		copyBtnId = $(obj).attr('id');
		$('#validation-form').submit();
	}

	var submitProc = function(obj) {		
		var flag = true;
		<c:if test="${vo eq null}">
			if($('#lv1').val() === '') {
				alert('대분류 카테고리는 필수값입니다');
				flag = false;
				$('#lv1').focus();
			}
		</c:if>

		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "") {
				alert($(this).attr("alt") + "란을 입력(선택) 해주세요!");
				flag = false;
				$(this).focus();
			}
		});

		<c:if test="${vo eq null}">
			$('input[name="stockCount"]').each(function(){
				var stockCount = parseInt($(this).val(),10) || 0;
				if(flag && stockCount < 1) {
					alert('재고량을 1이상 입력해주세요.');
					flag = false;
				}
			});
		</c:if>

		<c:forEach var="item" items="${filterList}">
		$(obj).find("#eb-option-list input[alt],#ch-info-list input[alt]").each( function() {
			if(flag && $(this).val().indexOf("${item.filterWord}") != -1) {
				alert($(this).attr("alt") + "란에 금지어 ${item.filterWord}이 포함되어 있습니다!");
				flag = false;
				$(this).focus();
			}
		});
		</c:forEach>
		
		
		/*if(flag && $.trim(obj.marketPrice.value) == "") {
			obj.marketPrice.value = "0";
		} else {
			var marketPrice = parseInt(obj.marketPrice.value,10);
			if(marketPrice < 0) {
				flag = false;
				alert('시중가는 음수 값이 될 수 없습니다.');
				obj.marketPrice.focus();
			}
			if(marketPrice > 0 && marketPrice < parseInt($('input[name=sellPrice]').val(),10)) {
				flag = false;
				alert('시중가는 판매가보다 작게 입력 될 수 없습니다');
				$('input[name=marketPrice]').focus();
			}
		} */
		
		if(flag && $('input[name=deliTypeCode]:checked').val() === '10' && (parseInt($('input[name=deliCost]').val(),10) || 0) === 0){
			flag = false;
			alert('유료배송 일 때 배송비는 반드시 입력하여야 합니다.');
			$('input[name=deliCost]').focus();
		}
		
		//조건부 무료값은 유료배송일때 반드시 입력해야할 값은 아니고 공백으로 값이 넘어가는 상황이 발생하여 에러가 발생 할 수도 있기 때문에 0으로 초기화 한다.
		if((parseInt($('input[name=deliFreeAmount]').val(),10) || 0) === 0){
			$('input[name=deliFreeAmount]').val(0);
		}


		if(flag) {
			// 더블클릭 방지
			$("#submitButtons button").attr("disabled", "disabled");
			setTimeout(function(){
				$("#submitButtons button").attr("disabled", false);
			}, 5000);

			//상품등록시 옵션이 항목이 한개 이상있을경우 controller에서 bind가 되지 않아서 에러가 발생한다.
			//그래서 submit 상품기본정보를 submit할때는 option필드를 disable시켜 폼전송에서 제외시키고 callbackproc에서 sable시켜 활성화시킨다.
			//flag가 true일때만 disable시킨다.
			EBOption.disableOptionField();
			CHItemPropInfo.disablePropInfoField();
			setTimeout(function(){
				EBOption.sableOptionField();
				CHItemPropInfo.sablePropInfoField();
			}, 5000);
		}
		if(flag === true) {
			if (copyBtnId === 'copyBtn') {
				if (confirm('해당 상품정보로 신규 생성하시겠습니까?')) {
					$('#updateType').val('copy');
					$('#validation-form').attr('action', '/admin/item/form/new');
				} else {
					$('#updateType').val('');
					$('#validation-form').attr('action', '/admin/item/form/modify');
					EBOption.sableOptionField();
					CHItemPropInfo.sablePropInfoField();
					flag = false;
				}
			}
		}

		//세분류가 선택되지 않았다면 disabled 처리한다.
		if(parseInt($('input[name=cateLv4Seq]').val(),10) === 0) {
			$('select[name=cateLv4Seq]').prop('disabled',true);
			$('input[name=cateLv4Seq]').prop('disabled',true);
		} else {
			$('select[name=cateLv4Seq]').prop('disabled',false);
			$('input[name=cateLv4Seq]').prop('disabled',false);
		}

		//유효성검사가 모두 끝난 후 수정시 임시몰의 판매가와 상태코드가 중복(sellPrice,statusCode)되므로 에러가 발생되기 때문에 임시몰 부분을 disabled처리한다.
		if(flag === true) {
			$('#tempMall').find('input[name=sellPrice]').prop('disabled',true);
			//$('#tempMall').find('select[name=statusCode]').prop('disabled',true);
		}
		return flag;
	};

	var goPage = function (page) {
		sellerProc(page);
	};
	
	$(document).ready(function () {
		showDatepicker("yyyy-mm-dd");
		/* 견적상품일 경우 판매가를 숨긴다 */
		setTypeCode();

		<c:if test="${vo eq null}">
		setTimeout(function(){
			EBCategory.renderList(1, 0, ${mallSeq});
		}, 100);
		EBOption.add(); //옵션추가
		EBOption.addChild($('.optionValueAdd'));
		</c:if>
		<c:if test="${vo ne null}">
		setTimeout(function(){
			EBCategory.renderList(1, 0, ${mallSeq});
		}, 100);
		</c:if>

		// 수정 페이지 에서는 upload를 붙여줘야한다.
		<c:if test="${vo ne null and vo.img1 ne ''}">uploadProc(1, "/upload"+"${vo.img1}");</c:if>
		<c:if test="${vo ne null and vo.img2 ne ''}">uploadProc(2, "/upload"+"${vo.img2}");</c:if>
		<c:if test="${vo ne null and vo.img3 ne ''}">uploadProc(3, "/upload"+"${vo.img3}");</c:if>
		<c:if test="${vo ne null and vo.img4 ne ''}">uploadProc(4, "/upload"+"${vo.img4}");</c:if>

		<c:if test="${vo ne null and vo.detailImg1 ne ''}">uploadDetailProc(1, "/upload"+"${vo.detailImg1}");</c:if>
		<c:if test="${vo ne null and vo.detailImg2 ne ''}">uploadDetailProc(2, "/upload"+"${vo.detailImg2}");</c:if>
		<c:if test="${vo ne null and vo.detailImg3 ne ''}">uploadDetailProc(3, "/upload"+"${vo.detailImg3}");</c:if>

		<c:if test="${vo ne null}">
			//상품 추가정보
			<c:if test="${vo.typeCd ne 0}">
				CHItemPropInfo.renderList("${vo.typeCd}")
			</c:if>
			//저장된 상품 추가정보
			<c:choose>
				<c:when test="${propInfo ne null}">
					//주석 부분 수정해야함. 필히 볼것
					CHItemPropInfo.renderMappingList();
				</c:when>
				<c:otherwise>
					$("#ch-info-list").html("<tr><td class='text-center' colspan='2'>이 상품은 추가 정보를 입력할 수 없는 상품입니다</td></tr>");
				</c:otherwise>
			</c:choose>
			//옵션
			EBOption.renderList(${vo.seq});
		</c:if>

		// Replace the <textarea id="editor1"> with a CKEditor
        // instance, using default configuration.
        CKEDITOR.replace('content',{
        	width:'100%',
        	height:'500',
        	filebrowserImageUploadUrl: '/admin/editor/upload'
        });
        //bootstrap WYSIHTML5 - text editor
        //$(".textarea").wysihtml5();
	});
	
	var setTypeCode = function() {
		var typecode = $('input[name=typeCode]:checked').val();
		if(typecode === 'E') {
			$('#sellPrice').val(1).parents('.form-group').hide();
		} else {
			$('#sellPrice').val(${vo eq null ? 0 : vo.sellPrice}).parents('.form-group').show();
		}
	};

	var setMallId = function() {
		var mallName = $('input[name=mallName]:checked').val();
		if(mallName === '병원몰') {

		} if(mallName === '약국몰') {

		} else {//B2b몰

		}
	};
</script>
</body>
</html>
