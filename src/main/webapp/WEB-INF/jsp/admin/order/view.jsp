<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
	.box.box-style {
	  border-top-color: #e5be34;
	}
	
	.box.box-solid.box-style {
	  border: 1px solid #e5be34;
	}
	
	.box.box-solid.box-style > .box-header {
	  color: #ffffff;
	  background: #e5be34;
	  background-color: #e5be34;
	}
	.box.box-solid.box-style > .box-header a,
	.box.box-solid.box-style > .box-header .btn {
	  color: #ffffff;
	}
	</style>
</head>
<c:choose>
	<c:when test="${sessionScope.loginType eq 'S'}">
		<body class="skin-green sidebar-mini">
	</c:when>
	<c:otherwise>
		<body class="skin-blue sidebar-mini">
	</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>
			주문 상세 정보 
			<small></small>
			<c:choose>
				<c:when test="${sessionScope.cs eq 'cancel'}">
					<button onclick="location.href='/admin/order/cancel/list'" class="btn btn-sm btn-default">목록보기</button>
				</c:when>
				<c:when test="${sessionScope.cs eq 'exchange'}">
					<button onclick="location.href='/admin/order/exchange/list'" class="btn btn-sm btn-default">목록보기</button>
				</c:when>
				<c:when test="${sessionScope.cs eq 'return'}">
					<button onclick="location.href='/admin/order/return/list'" class="btn btn-sm btn-default">목록보기</button>
				</c:when>
				<c:otherwise>
					<button onclick="location.href='/admin/order/list'" class="btn btn-sm btn-default">목록보기</button>
				</c:otherwise>
			</c:choose>
				<button onclick="doPrint()" class="btn btn-sm btn-primary">인쇄하기</button>
		</h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>판매 관리</li>
			<li class="active">주문 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">
							주문 상품 정보
						</h3>
						<div class="pull-right" style="font-size:15px;">
							<span style="margin-right:30px;">
								<strong>주문번호:</strong> 
								<strong style="color:#444;">${vo.orderSeq}</strong>
								<c:if test="${sessionScope.loginType eq 'A' }">
								<c:set var="confirmCnt" value="0"/>
								<c:forEach var="item" items="${list}">
									<c:if test="${item.statusCode eq '00'}">
										<c:set var="confirmCnt" value="${confirmCnt+1}"/>
									</c:if>
								</c:forEach>
								<c:if test="${confirmCnt > 0}">
									<a href="/admin/order/status/update/confirm?orderSeq=${vo.orderSeq}&seq=${pvo.seq}&statusCode=10" onclick="if(!confirm('결제완료 처리를 하시겠습니까?')){return false;}" class="btn btn-sm btn-info" target="zeroframe">입금확인</a>
								</c:if>
								<c:if test="${checkCancelAll}">
									<button type="button" onclick="cancel('ALL');" class="btn btn-sm btn-danger">전체취소</button>
								</c:if>
								</c:if>
							</span>
							<span style="margin-right:30px;">
								<strong>주문일자:</strong> 
								<strong style="color:#444;">${fn:substring(vo.regDate,0,19)}</strong>
							</span>
							<c:if test="${sessionScope.loginType eq 'A' }">
							<span style="margin-right:30px;">
								<strong>주문합계금액:</strong> 
								<strong style="color:#444;"><fmt:formatNumber value="${vo.totalPrice}"/></strong>
							</span>
							<span style="margin-right:30px;">
								<strong>사용 포인트:</strong> 
								<strong style="color:#444;"><fmt:formatNumber value="${vo.point}"/></strong>
							</span>
							<span style="margin-right:30px;">
								<strong>결제 금액:</strong> 
								<strong style="color:#444;"><fmt:formatNumber value="${vo.payPrice}"/></strong>
							</span>
							<span>
								<strong>결제 수단:</strong> 
								<strong style="color:#444;">${vo.payMethodName}</strong>
							</span>
							</c:if>
						</div>
					</div>
					<div class="box-body">
						<c:set var="seq" value="" />
						<c:set var="statusCode" value="" />
						<c:set var="deliNo" value="" />
						<c:set var="boxCnt" value="" />
						<c:set var="totalDeliCost" value="" />
						<c:set var="deliSeq" value="0" />
						<c:set var="deliCompanyName" value="" />
						<c:set var="deliTrackUrl" value="" />
						<c:set var="sellerSeq" value=""/>
						<c:set var="checkBD" value="${vo.checkBD}"/>
						<table class="table table-bordered">
							<colgroup>
								<col style="width:7%;"/>
								<col style="width:7%;"/>
								<col style="width:7%;"/>
								<col style="width:*;"/>
								<col style="width:12%;"/>
								<col style="width:7%;"/>
								<col style="width:7%;"/>
								<col style="width:5%;"/>
								<col style="width:7%;"/>
								<col style="width:6%;"/>
								<col style="width:6%;"/>
								<col style="width:6%;"/>
								<col style="width:6%;"/>
								<col style="width:6%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>
										<div style="color:#72afd2;">상품주문번호</div>
									</th>
									<th>상품번호</th>
									<th>이미지</th>
									<th>상품명</th>
									<th>규격</th>
									<th>단위</th>
									<th>제조사</th>
									<th>보험코드</th>
									<th>이벤트</th>
									<th>주문상태</th>
									<th>입점업체명</th>
									<th>판매가</th>
									<th>수량</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="total" value="0"/>
							<c:set var="totalDeliCost" value="0"/>
							<c:set var="count10" value="0" />
							<c:forEach var="vo" items="${list}" varStatus="status">
								<c:if test="${vo.statusCode eq '10'}">
									<c:set var="count10" value="${count10+1}" />
								</c:if>
								<tr <c:if test="${vo.seq==pvo.seq}"> class="tr-selected" </c:if>>
									<td class="text-center">
										<strong><a href="/admin/order/view/${vo.orderSeq}?seq=${vo.seq}" style="color:#72afd2;">${vo.seq}</a></strong>
										<c:if test="${vo.seq==pvo.seq}">
											<br/>(현재 주문)
											<%-- 현재 상세 주문의 배송정보 관련 데이터를 담는다. --%>
											<c:set var="seq" value="${vo.seq}" />
											<c:set var="statusCode" value="${vo.statusCode}" />
											<c:set var="deliNo" value="${vo.deliNo}" />
											<c:set var="boxCnt" value="${vo.boxCnt}" />
											<c:set var="deliNo" value="${vo.deliNo}" />
											<%--<c:set var="totalDeliCost" value="${vo.totalDeliCost}" />--%>
											<c:set var="deliCompanyName" value="${vo.deliCompanyName}" />
											<c:set var="deliTrackUrl" value="${vo.deliTrackUrl}" />
											<c:set var="sellerSeq" value="${vo.sellerSeq}" />
										</c:if>
									</td>
									<td class="text-center">${vo.itemSeq}</td>
									<td class="text-center">
										<c:if test="${vo.img1 ne ''}">
											<img src="/upload${fn:replace(vo.img1, 'origin', 's60')}" alt="" style="width:60px;height:60px" />
										</c:if>
									</td>
									<td><strong>${vo.itemName}</strong></td>
									<td>
										${vo.type1}
										<c:if test="${vo.type2 ne ''}">,${vo.type2}</c:if>
										<c:if test="${vo.type3 ne ''}">,${vo.type3}</c:if>
									</td>
									<td>${vo.originCountry}</td>
									<td>${vo.maker}</td>
									<td>${vo.insuranceCode}</td>
									<td>
										<c:choose>
											<c:when test="${vo.eventAdded !='' && vo.eventAdded !=' ' && vo.eventAdded !='0'}">
												${vo.eventAdded}
											</c:when>
											<c:otherwise>
												이벤트없음
											</c:otherwise>
										</c:choose>
									</td>
									<td><strong>
										<c:choose>
											<c:when test="${vo.statusCode eq '99'}">
												<div style="color:#ff0000;">${vo.statusText}</div>
											</c:when>
											<c:otherwise>
												<div style="color:#72afd2;">${vo.statusText}</div>
											</c:otherwise>
										</c:choose>
									</strong></td>
									<td>${vo.sellerName}</td>
									<td class="text-right"><fmt:formatNumber value="${vo.sellPrice}"/></td>
									<td class="text-right">${vo.orderCnt}</td>
									<%--<td class="text-center">--%>
										<%--<c:choose>--%>
											<%--<c:when test="${(vo.sellPrice * vo.orderCnt) >= 50000}">--%>
												<%--무료배송--%>
											<%--</c:when>--%>
											<%--<c:otherwise>--%>
												<%--<c:choose>--%>
													<%--<c:when test="${vo.freeDeli eq 'Y'}">무료배송</c:when>--%>
													<%--<c:otherwise>--%>
														<%--<c:if test="${vo.deliCost > 0}">--%>
															<%--<fmt:formatNumber value="${vo.deliCost}" pattern="#,###" />--%>
														<%--</c:if>--%>
														<%--<br/>선결제--%>
													<%--</c:otherwise>--%>
												<%--</c:choose>--%>
											<%--</c:otherwise>--%>
										<%--</c:choose>--%>
									<%--</td>--%>
									<%----%>
									<td class="text-right">
										<c:set var="subTotal" value="${vo.sellPrice * vo.orderCnt}"/>
										<c:if test="${vo.statusCode ne '99'}">
											<c:set var="total" value="${total + subTotal}"/>
										</c:if>
										<fmt:formatNumber value="${subTotal}"/>
										<c:choose>
											<c:when test="${checkBD eq 'Y'}">
												<c:set var="totalDeliCost" value="${totalDeliCost+vo.deliCost}"/>
											</c:when>
											<c:otherwise>
												<c:if test="${total >= 50000}">
													<c:set var="totalDeliCost" value="0"/>
												</c:if>
												<c:if test="${total < 50000}">
													<c:set var="totalDeliCost" value="3300"/>
												</c:if>
											</c:otherwise>
										</c:choose>

									</td>
								</tr>
							</c:forEach>
								<tr>
									<th colspan="13" style="font-size:15px;">
										주문 합계 금액 :
										상품금액(<fmt:formatNumber value="${total}"/>원) + 배송료(
										<c:choose>
											<c:when test="${totalDeliCost eq 0}">
												무료
											</c:when>
											<c:otherwise>
												<fmt:formatNumber value="${totalDeliCost}"/>원
											</c:otherwise>
										</c:choose>
										)
										<c:if test="${vo.couponPrice>0}">
											- 할인금액(<fmt:formatNumber value="${vo.couponPrice}"/>원)
										</c:if>
										<c:if test="${vo.point >0}">
											- 포인트 차감(<fmt:formatNumber value="${vo.point}"/>원)
										</c:if>
										<c:if test="${vo.payMethod eq 'CASH' or vo.payMethod eq 'CASH+POINT'}">
											= 무통장 입금 금액(

											<%--<c:choose>--%>
												<%--<c:when test="${checkBD eq 'Y'}">--%>
													<fmt:formatNumber value="${total+totalDeliCost-vo.point}"/>
												<%--</c:when>--%>
												<%--<c:otherwise>--%>
													<%--<c:choose>--%>
														<%--<c:when test="${total>= 50000}">--%>
															<%--<fmt:formatNumber value="${total-vo.point}"/>--%>
														<%--</c:when>--%>
														<%--<c:otherwise>--%>
															<%--<fmt:formatNumber value="${total+totalDeliCost-vo.point}"/>--%>

														<%--</c:otherwise>--%>
													<%--</c:choose>--%>
												<%--</c:otherwise>--%>
											<%--</c:choose>--%>
											)
										</c:if>
									</th>
									<td class="text-right">
										<c:choose>
											<c:when test="${checkBD eq 'Y'}">
												<fmt:formatNumber value="${total+totalDeliCost}"/>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${total>= 50000}">
														<fmt:formatNumber value="${total}"/>
													</c:when>
													<c:otherwise>
														<fmt:formatNumber value="${total+totalDeliCost}"/>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>

								</tr>
							</tbody>
						</table>
					</div>
					<div class="box-footer">
						<form id="viewForm2" class="form-horizontal">
						<fmt:parseNumber var="parseIntStatusCode" value="${statusCode}" type="number"/>
							<div class="form-group">
								<c:if test="${sessionScope.loginType ne 'M'}">
									<label class="col-md-1 control-label">
									<c:if test="${statusCode ne '99'}">
										현재 주문 상태 변경
									</c:if>
									</label>
									<div class="col-md-10">
									<c:if test="${sessionScope.loginType eq 'A'}">
										<c:if test="${statusCode eq '10' and vo.payMethod eq 'CASH'}">
											<c:if test="${fn:length(list) eq count10}">
												<!-- 전체 결제완료 상태일 경우에만 가능 -->
												<button type="button" onclick="updateStatus('00');" class="btn btn-sm btn-warning">입금확인취소</button>
											</c:if>
										</c:if>
										<c:if test="${statusCode eq '00' or statusCode eq '10' or statusCode eq '79' or statusCode eq '90'}">
											<c:choose>
												<c:when test="${fn:length(list) == 1}">
													<!-- 단건 주문인 경우는 전체 취소 처리한다. -->
													<button type="button" onclick="cancel('ALL');" class="btn btn-sm btn-danger">취소완료</button>
												</c:when>
												<c:otherwise>
													<button type="button" onclick="cancel('PART');" class="btn btn-sm btn-danger">부분취소</button>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:if>
										<c:if test="${statusCode eq '30'}">
											<button type="button" onclick="updateStatus('50');" class="btn btn-sm btn-info">배송완료</button>
										</c:if>
										<c:if test="${sessionScope.loginType eq 'A'}">
										<c:if test="${statusCode eq '60' or statusCode eq '61' or statusCode eq '70' or statusCode eq '71'}">
										<%-- <c:if test="${statusCode eq '60' or statusCode eq '61' or statusCode eq '70' or statusCode eq '71' or statusCode eq '90'}"> --%>
											<button type="button" onclick="updateStatus('10');" class="btn btn-sm btn-info">결제완료</button>
										</c:if>
										<c:if test="${statusCode eq '55' or parseIntStatusCode >= 60 and parseIntStatusCode <= 69}">
											<button type="button" onclick="updateStatus('90');" class="btn btn-sm btn-info">취소요청</button>
										</c:if>
										<c:if test="${statusCode eq '55'}">
											<button type="button" onclick="updateStatus('70');" class="btn btn-sm btn-info">반품요청</button>
										</c:if>
										<c:if test="${statusCode eq '70'}">
											<button type="button" onclick="updateStatus('30');" class="btn btn-sm btn-info">배송중</button>
										</c:if>
									</c:if>
									<c:if test="${parseIntStatusCode < 30}">
										<button type="button" onclick="updateStatus('90');" class="btn btn-sm btn-info">취소요청</button>
									</c:if>
									<c:if test="${statusCode eq '60' or statusCode eq '30' or statusCode eq '50'}">
										<button type="button" onclick="updateStatus('61');" class="btn btn-sm btn-info">교환 진행중</button>
									</c:if>
									<c:if test="${statusCode eq '61'}">
										<button type="button" onclick="updateStatus('69');" class="btn btn-sm btn-info">교환완료</button>
									</c:if>
									<c:if test="${statusCode eq '70' or statusCode eq '30' or statusCode eq '50'}">
										<button type="button" onclick="updateStatus('71');" class="btn btn-sm btn-info">반품 진행중</button>
									</c:if>
									<c:if test="${statusCode eq '71'}">
										<c:choose>
											<c:when test="${sessionScope.loginType eq 'A'}">
												<!-- 관리자 반품완료 처리시 취소완료로 처리한다. -->
												<c:choose>
													<c:when test="${fn:length(list) == 1}">
														<!-- 단건 주문인 경우는 전체 취소 처리한다. -->
														<button type="button" onclick="cancel('ALL');" class="btn btn-sm btn-danger">반품완료</button>
													</c:when>
													<c:otherwise>
														<!-- 부분 취소 처리한다. -->
														<button type="button" onclick="cancel('PART');" class="btn btn-sm btn-danger">반품완료</button>
													</c:otherwise>
												</c:choose>
												<c:if test="${sessionScope.id eq 'mlm' or sessionScope.id eq 'antler28' or sessionScope.id eq 'pofp81' or
														sessionScope.id eq 'rlacksgh08' or sessionScope.id eq 'nohave821' or sessionScope.id eq 'nahonest01'}">
													<button type="button" onclick="updateStatus('99');" class="btn btn-sm btn-danger">취소완료(수동)</button>
												</c:if>
											</c:when>
											<c:when test="${sessionScope.loginType eq 'S'}">
												<button type="button" onclick="updateStatus('79');" class="btn btn-sm btn-info">반품완료</button>
											</c:when>
										</c:choose>
									</c:if>
									</div>
								</c:if>
							</div>
							<div class="form-group">
								<label class="col-md-1 control-label">처리내용</label>
								<div class="col-md-10">
									<input class="form-control" type="text" id="contents" placeholder="처리내용 미 입력시 상태변경이 불가합니다. 반드시 입력하세요." maxlength="150"/>
								</div>
							</div>
						</form>
					</div>
				</div>
				
				<!-- 취소/교환/반품 사유 -->
				<c:if test="${vo.reason ne ''}">
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">
							<c:choose>
								<c:when test="${statusCode >= 60 and statusCode <= 69}">교환</c:when>
								<c:when test="${statusCode >= 70 and statusCode <= 79}">반품</c:when>
								<c:when test="${statusCode >= 90 and statusCode <= 99}">취소</c:when>
							</c:choose>사유
						</h3>
					</div>
					<div class="box-body">
						<div class="form-group">
							<label class="col-md-2 control-label" style="text-align:right;padding-right:26px;">내용</label>
							<div class="col-md-2">${vo.reason}</div>
						</div>
					</div>
				</div>
				</c:if>
				
				<!-- 첨부서류 파일 첨부 -->
				<c:if test="${vo.estimateCompareFlag eq 'Y'}">
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">첨부서류 파일 첨부</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered" style="width:50%">
							<thead>
								<tr>
									<th>번호</th>
									<th>주문번호</th>
									<th>입점업체명</th>
									<th>파일명 (다운로드)</th>
									<th>등록 일자</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${estimateCompareFileList}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-center">${item.sellerName}</td>
									<td>
										<a href="/admin/estimate/compare/download/${item.seq}">
											<c:choose>
												<c:when test="${item.fileName eq ''}">
													비교견적서_${item.sellerName}_${item.seq}.${fn:substringAfter(item.file, '.')}
												</c:when>
												<c:otherwise>
													${item.fileName}
												</c:otherwise>
											</c:choose>
										</a>
									</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
									<td class="text-center">
										<a href="/admin/estimate/compare/del/${item.seq}?orderDetailSeq=${seq}" onclick="if(!confirm('해당 파일을 삭제하시겠습니까?')){return false;}" target="zeroframe"><i class="fa fa-remove"></i></a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(estimateCompareFileList) == 0 }">
								<tr>
									<td colspan="6" class="text-center">등록된 데이터가 없습니다.</td>
								</tr>
							</c:if>
							</tbody>
						</table>

						<form class="form-horizontal" action="/admin/estimate/compare/reg" enctype="multipart/form-data" method="post" target="zeroframe" onsubmit="return doSubmit(this);">
							<input type="hidden" name="orderSeq" value="${vo.orderSeq}"/>
							<input type="hidden" name="orderDetailSeq" value="${seq}"/>
							<input type="hidden" name="sellerSeq" value="${sellerSeq}"/>
							<div class="form-group" style="margin-top:20px;">
								<div class="col-md-12">
									<input type="file" onchange="checkFileSize(this);" id="file" name="file" style="width:44%;height:33px;display:inline"/>
									<button type="submit" class="btn btn-warning" style="margin:0 0 5px 10px">등록하기</button>
								</div>
							</div>
						</form>

					</div>
				</div>
				</c:if>
				
				<!-- 기관, 기업 정보 -->
				<c:if test="${mgVo ne null}">
				<div class="box box-style box-solid">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">기관(기업) 정보</h3></div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="view1" class="table table-bordered">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:*"/>
								<col style="width:10%;"/>
								<col style="width:*"/>
								<col style="width:10%;"/>
								<col style="width:*"/>
							</colgroup>
							<tbody>
								<tr>
									<th>업체명</th>
									<td>${mgVo.name}</td>
									<th>대표자</th>
									<td colspan="3">${mgVo.ceoName}</td>
								</tr>
								<tr>
									<th>사업자 등록 번호</th>
									<td>
										${fn:substring(mgVo.bizNo,0,3)}-${fn:substring(mgVo.bizNo,3,5)}-${fn:substring(mgVo.bizNo,5,10)}
									</td>
									<th>사업자 주소</th>
									<td colspan="3">${fn:substring(vo.postcode,0,3)}-${fn:substring(vo.postcode,3,6)} ${vo.addr1} ${vo.addr2}</td>
								</tr>
								<tr>
									<th>업태 / 종목</th>
									<td>${mgVo.bizType} / ${mgVo.bizKind}</td>
									<th>소속 자치구</th>
									<td colspan="3">${mgVo.jachiguName}</td>
								</tr>
								<tr>
									<th>팩스 번호</th>
									<td colspan="5">${mgVo.fax}</td>
								</tr>
								<tr>
									<th>세금계산서 담당자</th>
									<td>${mgVo.taxName}</td>
									<th>세금계산서 이메일</th>
									<td>${mgVo.taxEmail}</td>
									<th>세금계산서 연락처</th>
									<td>${mgVo.taxTel}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				</c:if>
				
				<!-- 세금계산서 요청 -->
				<%-- 무통장이어야만 세금계산서를 요청할 수 있다 --%>
				<c:if test="${taxRequest ne null and vo.payMethod eq 'NP_CASH'}">
				<div class="box box-style box-solid">
					<!-- 제목 -->
					<div class="box-header"><h3 class="box-title">세금계산서 요청서</h3></div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="view1" class="table table-bordered">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:*"/>
								<col style="width:10%;"/>
								<col style="width:*"/>
								<col style="width:10%;"/>
								<col style="width:*"/>
							</colgroup>
							<tbody>
								<tr>
									<th>진행상태</th>
									<td colspan="5">
										<c:choose>
											<c:when test="${taxRequest.requestFlag eq 'N'}">
												진행중
												<button class="btn btn-danger" onclick="completeTaxRequest(${vo.orderSeq});" style="margin-left:50px">완료처리</button>
												<span class="text-danger">세금계산서 업무를 완료했을 때 클릭하여 주십시오</span>
											</c:when>
											<c:when test="${taxRequest.requestFlag eq 'Y'}">발송완료 (${taxRequest.completeDate})</c:when>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>상호(법인명)</th>
									<td>${taxRequest.businessCompany}</td>
									<th>대표자</th>
									<td colspan="3">${taxRequest.businessName}</td>
								</tr>
								<tr>
									<th>사업자 등록 번호</th>
									<td>
										${taxRequest.businessNum}
									</td>
									<th>사업자 주소</th>
									<td colspan="3">${taxRequest.businessAddr}</td>
								</tr>
								<tr>
									<th>업태 / 종목</th>
									<td colspan="5">
										${taxRequest.businessCate} / ${taxRequest.businessItem}
									</td>
								</tr>
								<tr>
									<th>담당자</th>
									<td>${taxRequest.requestName}</td>
									<th>세금계산서 이메일</th>
									<td>${taxRequest.requestEmail}</td>
									<th>세금계산서 연락처</th>
									<td>${taxRequest.requestCell}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				</c:if>
				
				<!-- 주문자 정보 -->
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">주문자 정보</h3>
					</div>
					<form id="viewForm2" class="form-horizontal" method="post" action="/admin/order/member/change">
						<c:choose>
						<c:when test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
							<input type="hidden" name="seq" value="${seq}" />
							<input type="hidden" name="orderSeq" value="${vo.orderSeq}" />
							<div class="box-body">
								<div class="form-group">
									<label class="col-md-2 control-label">주문자 명</label>
									<div class="col-md-2 form-control-static">
										<input type="text" name="memberName" class="form-control" value="${vo.memberName}" />
									</div>
									<label class="col-md-2 control-label">주문자 아이디</label>
									<div class="col-md-2 form-control-static">
										<a href="/admin/member/view/${vo.memberSeq}" target="_blank">${vo.memberId}</a>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">주문자 전화번호</label>
									<div class="col-md-2 form-control-static">
										${vo.memberTel}
									</div>
									<label class="col-md-2 control-label">주문자 휴대폰번호</label>
									<div class="col-md-2 form-control-static">
										${vo.memberCell}
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">주문자 이메일</label>
									<div class="col-md-2 form-control-static">
										<input type="text" name="memberEmail" class="form-control" value="${vo.memberEmail}" />
									</div>
									<div class="col-md-1 form-control-static">
										<button type="submit" class="btn btn-primary">주문자 정보 수정</button>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="box-body">
								<div class="form-group">
									<label class="col-md-2 control-label">주문자 명</label>
									<div class="col-md-2 form-control-static">${vo.memberName}</div>
									<label class="col-md-2 control-label">주문자 아이디</label>
									<div class="col-md-2 form-control-static">${vo.memberId}</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">주문자 전화번호</label>
									<div class="col-md-2 form-control-static">${vo.memberTel}</div>
									<label class="col-md-2 control-label">주문자 휴대폰번호</label>
									<div class="col-md-2 form-control-static">${vo.memberCell}</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">주문자 이메일</label>
									<div class="col-md-2 form-control-static">${vo.memberEmail}</div>
								</div>
							</div>
						</c:otherwise>
						</c:choose>
					</form>
				</div>
				
				<!-- 배송정보 -->
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">배송 정보</h3>
					</div>
					<form id="viewForm1" class="form-horizontal" method="post" action="/admin/order/delivery/change">
						<input type="hidden" name="seq" value="${seq}" />
						<input type="hidden" name="orderSeq" value="${vo.orderSeq}" />
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">수취인 명</label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="receiverName" name="receiverName" maxlength="15" <c:if test="${sessionScope.loginType ne 'A' || (statusCode ne 10 && statusCode ne 60) }">disabled</c:if> value="${vo.receiverName}" />
								</div>
							<c:if test="${parseIntStatusCode >= 30 and parseIntDeliSeq ne 0 and deliNo ne ''}">
								<label class="col-md-2 control-label">송장 정보</label>
								<div class="col-md-2 form-control-static">
									${deliCompanyName} / ${deliNo}
									<c:if test="${deliSeq != 25}">
										<c:choose>
											<c:when test="${deliSeq eq 2}">
												<a href="javascript:viewDeliveryForHlc('${deliTrackUrl}','${deliNo}');" class="btn btn-warning btn-xs" onfocus="this.blur();">배송조회</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:viewDelivery('${deliTrackUrl}','${deliNo}');" class="btn btn-warning btn-xs" onfocus="this.blur();">배송조회</a>
											</c:otherwise>
										</c:choose>
									</c:if>
								</div>
							</c:if>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">수취인 전화번호</label>
								<div class="col-md-2 form-control-static">${vo.receiverTel}</div>
								<label class="col-md-2 control-label">수취인 휴대폰번호</label>
								<div class="col-md-2 form-control-static">${vo.receiverCell}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">수취인 이메일</label>
								<div class="col-md-2 form-control-static">${vo.receiverEmail}</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">배송지 주소</label>
								<div class="col-md-10">
									<div class="row" style="margin-bottom: 3px;">
										<div class="col-md-1">
											<input type="text" class="form-control" id="receiverPostcode" name="receiverPostcode" maxlength="6" onblur="numberCheck(this);" <c:if test="${sessionScope.loginType ne 'A' || (statusCode > 10 && statusCode ne 60) }">disabled</c:if> value="${vo.receiverPostcode}" />
										</div>
										<div class="col-md-6">
											<input type="text" class="form-control" id="receiverAddr1" name="receiverAddr1" maxlength="100" <c:if test="${sessionScope.loginType ne 'A' || (statusCode > 10 && statusCode ne 60) }">disabled</c:if> value="${vo.receiverAddr1}" />
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 col-md-offset-1">
											<input type="text" class="form-control" id="receiverAddr2" name="receiverAddr2" maxlength="100" <c:if test="${sessionScope.loginType ne 'A' || (statusCode > 10 && statusCode ne 60) }">disabled</c:if> value="${vo.receiverAddr2}" />
										</div>
										<c:if test="${sessionScope.loginType eq 'A'}">
											<div class="col-md-1">
												<button type="submit" class="btn btn-primary" ${(statusCode > 10 && statusCode ne 60) ? "disabled":""}>배송정보 수정</button>
											</div>
											<div class="col-md-4" style="padding-left:50px;">
												<span class="text-danger">'주문확인' 이전 단계 또는 '교환요청' 단계일 경우에만 변경이 가능합니다.</span>
											</div>
										</c:if>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">배송 메세지</label>
								<div class="col-md-10 form-control-static">${vo.request}</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%--PG 결제 정보 조회 및 승인 취소(관리자에게만 노출)--%>
		<c:if test="${sessionScope.loginType eq 'A'}">
		<div class="row">
			<div class="col-md-6">
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">PG 거래 내역</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
							<tr>
								<th>주문번호</th>
								<th>결제금액</th>
								<th>승인일시</th>
								<th>승인번호</th>
								<th></th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${payInfoList}">
								<tr>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-right"><fmt:formatNumber value="${item.amount}"/></td>
									<td class="text-center">${item.transDate}</td>
									<td class="text-center">${item.approvalNo}</td>
									<td></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(payInfoList) == 0}">
								<tr>
									<td colspan="5" class="text-center"><strong>내역이 존재하지 않습니다.</strong></td>
								</tr>
							</c:if>
							</tbody>
						</table>
						<c:if test="${fn:length(payListCancel) > 0}">
						<h5 class="box-title">취소 내역</h5>
						<table class="table table-bordered">
							<colgroup>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
							<tr>
								<th>주문번호</th>
								<th>취소금액</th>
								<th>취소유형</th>
								<th>상품주문번호</th>
								<th>취소일시</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${payListCancel}">
								<tr>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-right"><fmt:formatNumber value="${item.amount}"/></td>
									<td class="text-center">${item.typeCode eq 'ALL' ? '전체':'부분'}</td>
									<td class="text-center">${item.orderDetailSeq}</td>
									<td class="text-center">${fn:substring(item.regDate, 0,19)}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</c:if>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">포인트 거래 내역</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
							<tr>
								<th>주문번호</th>
								<th>포인트</th>
								<th>상태</th>
								<th>상품주문번호</th>
								<th>거래 일시</th>
							</tr>
							</thead>
							<tbody>
							<c:set var="cancelPoint" value="0"/>
							<c:forEach var="item" items="${pointList}" varStatus="status">
								<c:if test="${item.statusCode eq 'C'}">
									<c:set var="cancelPoint" value="${cancelPoint + item.point}"/>
								</c:if>
							</c:forEach>
							<c:forEach var="item" items="${pointList}" varStatus="status">

								<tr>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-right"><fmt:formatNumber value="${item.point}"/></td>
									<td class="text-center">${item.statusName}</td>
									<td class="text-center">${item.orderDetailSeq}</td>
									<td class="text-center">${fn:substring(item.regDate, 0,19)}</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(pointList) == 0}">
								<tr>
									<td colspan="6" class="text-center"><strong>내역이 존재하지 않습니다.</strong></td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		</c:if>
		<div class="row">
			<div class="col-md-12">
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">CS 처리 내역</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered">
							<colgroup>
								<col />
								<col style="width:10%;"/>
								<col style="width:15%;"/>
								<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
									<col style="width:90px;"/>
								</c:if>
							</colgroup>
							<thead>
								<tr>
									<th>처리 내용</th>
									<th>담당자</th>
									<th>처리일자</th>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
										<th>삭제</th>
									</c:if>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${csList}">
								<tr>
									<td>${item.contents}</td>
									<td class="text-center">${item.regName}</td>
									<td class="text-center">${fn:substring(item.regDate,0,19)}</td>
									<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1)}">
										<td class="text-center">
											<button type="button" onclick="deleteOrderCs(${item.seq})" class="btn btn-sm btn-danger">삭제</button>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(csList) == 0}">
								<tr>
									<td class="text-center" colspan="4">내역이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
					<div class="box-footer">
					<c:if test="${sessionScope.loginType eq 'A' or sessionScope.loginType eq 'S'}">
						<%--관리자, 입점업체만 CS 등록 가능 --%>
						<form id="regForm" action="/admin/order/cs/reg/${vo.orderSeq}" method="post" class="form-horizontal" target="zeroframe">
							<input type="hidden" name="orderDetailSeq" value="${pvo.seq}"/>
							<div class="form-group">
								<div class="col-md-10">
									<input type="text" class="form-control" name="contents" value="" placeholder="CS처리내용 신규등록(150자이내)" maxlength="150" required/>
								</div>
								<div class="col-md-2">
									<button type="submit" class="btn btn-info">등록하기</button>
								</div>
							</div>
						</form>
					</c:if>
					</div>
				</div>
				<div class="box box-style box-solid">
					<div class="box-header">
						<h3 class="box-title">주문 변경 이력</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:9%;"/>
								<col style="width:10%;"/>
								<col/>
								<col style="width:10%;"/>
								<col style="width:15%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>이력 번호</th>
									<th>상품주문번호</th>
									<th>처리 내용</th>
									<th>변경자</th>
									<th>변경 일자</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${logList}">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td class="text-center">${item.orderDetailSeq}</td>
									<td>${item.contents}</td>
									<td class="text-center">
										<c:choose>
											<%--배치로 상태가 변경되면 loginSeq가 0으로 들어간다.--%>
											<c:when test="${item.loginSeq eq null}">
												시스템
											</c:when>
											<c:otherwise>
												${item.loginName}
											</c:otherwise>
										</c:choose>

									</td>
									<td class="text-center">${fn:substring(item.regDate,0,19)}</td>
								</tr>
								<c:if test="${fn:length(logList) == 0}">
									<tr>
										<td class="text-center" colspan="5">변경 이력이 존재하지 않습니다.</td>
									</tr>
								</c:if>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<div id="orderModal" class="modal fade" data-backdrop="static">
	<div class="modal-dialog" style="width: 400px;">
		<div class="modal-content" style="top: 130px;">
			<div class="modal-body">
				<h4>취소 처리 중입니다.. <img src="/assets/img/common/ajaxloader.gif" alt="" /></h4>
				<h7>(취소 처리가 끝나기 전까지는 이 창을 닫지 마세요)</h7>
			</div>
		</div>
	</div>
</div>
<form id="updateForm" method="post" target="zeroframe">
	<input type="hidden" name="seq" value="${seq}"/>
	<input type="hidden" name="orderSeq" value="${vo.orderSeq}"/>
	<input type="hidden" name="cancelType" value=""/>
	<input type="hidden" name="statusCode" value=""/>
	<input type="hidden" name="contents" value=""/>
</form>
<form id="hlc" method="post" action="https://www.hlc.co.kr/home/personal/inquiry/track">
	<input type="hidden" name="InvNo" value="">
	<input type="hidden" name="action" value="processInvoiceSubmit">
</form>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript">
/* 페이지 로딩시 초기화 */
$(document).ready(function () {
	//숫자 입력 칸 나머지 문자 입력 막기
	$(".numeric").css("ime-mode", "disabled").numeric();
});

var viewDelivery = function(url, no) {
	window.open(url+no);
}

//현대 택배 전용폼
var viewDeliveryForHlc = function(trackUrl, deliNo) {
	var frm = document.getElementById("hlc");

	frm.InvNo.value = deliNo;
	frm.target = "_blank";

	frm.submit();
}

/* 주문 취소 */
var cancel = function(cancelType) {
	var cMsg = "해당 주문번호로 생성된 모든 주문이 전체 취소됩니다.\n\n진행하시겠습니까?";

	$("#updateForm input[name='cancelType']").val(cancelType);
	$("#updateForm").attr("action", "/admin/order/cancel");

	if(cancelType == "PART") {
		cMsg = "부분취소 하시겠습니까?";
	}
	if(!confirm(cMsg)) {
		return;
	}
	$("#orderModal").modal('show');

	$("#updateForm").submit();
}

/* 주문 상태 변경 */
var updateStatus = function(statusCode) {
	var cMsg = "해당 주문 상태로 업데이트 하시겠습니까?";

	$("#updateForm input[name='statusCode']").val(statusCode);
	
	if(statusCode !== '00') {
		$("#updateForm").attr("action", "/admin/order/status/update/one");
	} else {
		$("#updateForm").attr("action", "/admin/order/status/update/00");
	}

	if(statusCode == "90" || statusCode == "99" || statusCode == "70" || statusCode == "71" || statusCode == "79" || statusCode == "61" || statusCode == "69" || statusCode == "00") {
		if($.trim($("#contents").val()) == "") {
			if(statusCode == "90") {
				alert("취소요청 사유를 입력해 주세요.");
			} else if(statusCode == "99") {
				alert("취소 사유를 입력해 주세요.");
			} else if(statusCode == "70") {
				alert("반품요청 사유를 입력해 주세요.");
			} else if(statusCode == "71") {
				alert("반품 진행중 사유를 입력해 주세요.");
			} else if(statusCode == "79") {
				alert("반품 사유를 입력해 주세요.");
			} else if(statusCode == "61") {
				alert("교환 진행중 사유를 입력해 주세요.");
			} else if(statusCode == "69") {
				alert("교환 사유를 입력해 주세요.");
			} else if(statusCode == "00") {
				alert("입금확인취소 사유를 입력해 주세요.");
			}
			$("#contents").focus();
			return;
		}
		if(statusCode == "99") {
			cMsg ="주의!!!\n해당 주문 건의 PG(신용카드) 및 포인트 결제 금액은 환불 처리되지 않습니다.\n취소완료로 변경하시겠습니까?";
		} else if(statusCode == "00") {
			cMsg ="주의!!!\n현재 주문을 포함한 해당 주문번호의 주문이 모두 입금대기 상태로 돌아갑니다\n입금대기로 변경하시겠습니까?";
		}

		$("#updateForm input[name='contents']").val($("#contents").val());
	} else if(statusCode === '10') {
		cMsg = "해당 주문을 결제완료로 변경하시겠습니까?";
	}

	if(!confirm(cMsg)) {
		return;
	}
	if(statusCode == "99") {
		$("#orderModal").modal('show');
	}

	$("#updateForm").submit();
};


/** 견적서 업로드 */
var doSubmit = function(form) {
	if($("#file").val() == "") {
		alert("첨부하실 파일을 선택해 주세요.");
		return false;
	}
	return true;
};

/** 인쇄용 팝업창 열기 */
var doPrint = function() {
	window.open("/admin/order/view/${vo.orderSeq}?view_type=print","print_order_detail","scrollbars=yes,width=770,height=800");
}

/** 세금계산서 완료처리 */
var completeTaxRequest = function(seq) {
	$.get('/admin/order/view/taxrequest/complete?orderSeq='+seq, function(data){
		if((''+data) === 'success') {
			location.reload();
		} else {
			alert( '완료처리를 할 수 없었습니다' );
		}
	});
};


/** cs 삭제 */
function deleteOrderCs(seq) {
	if(confirm('정말로 삭제하시겠습니까?\n이 과정은 복구하실 수 없습니다.')) {
		$('#zeroframe').attr('src', '/admin/order/cs/delete/?seq='+seq);
	}
}

</script>
</body>
</html>
