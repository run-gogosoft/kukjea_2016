<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

	<style type="text/css">
		body {
			font-size:12px;
			margin: 0 0 0 3px;
		}
		
		th, td {
			line-height: 15px;
		}
		
		.table {
			width:100%;
		}
		
		.table-bordered {
			border-spacing: 0px;
			border-left: 1px solid #ccc;
			border-bottom: 1px solid #ccc;
		}

		.table-bordered th {
			background-color: #eee;
		}
		
		.table-bordered th, .table-bordered td {
			padding:7px 5px 7px 5px;
			border-top: 1px solid #ccc;
			border-right: 1px solid #ccc;
			font-size: 11px;
		}

		.table tbody > tr > th {
			text-align: right;
		}

		.text-center {
			text-align:center;
		}
		
		.text-right {
			text-align:right;
		}
		
		.box {
			margin-bottom:25px;
		}
		
		h4 {
			margin-bottom:5px;
			padding:5px 0 5px 10px;
			background-color:#f6cf45;
		}
		
		@media print {
			.no-print {
				display: none;
			}

			@page {
				margin-top: 20mm;
			}
		}
	</style>
</head>
<body>
<div class="wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h3><span style="padding-left:5px;">주문서 <button type="button" onclick="window.print()" class="no-print">인쇄하기</button></span><hr/></h3>
		<table class="table">
			<c:if test="${sessionScope.loginType eq 'S'}">
			<colgroup>
				<col style="width:5%"/>
				<col style="width:5%"/>
				<col style="width:5%"/>
				<col style="width:40%"/>
			</colgroup>
			</c:if>
			<tbody>
				<tr>
					<td class="text-right">주문번호</td>
					<td><strong>${vo.orderSeq}</strong></td>
					<td class="text-right">주문일자</td>
					<td><strong>${fn:substring(vo.regDate,0,19)}</strong></td>
					<c:if test="${sessionScope.loginType eq 'A'}">
					<td class="text-right">주문합계금액</td>
					<td><strong><fmt:formatNumber value="${vo.totalPrice}"/></strong></td>
					<td class="text-right">사용 포인트</td>
					<td><strong><fmt:formatNumber value="${vo.point}"/></strong></td>
					<td class="text-right">결제 금액</td>
					<td><strong><fmt:formatNumber value="${vo.payPrice}"/></strong></td>
					<td class="text-right">결제 수단</td>
					<td><strong>${vo.payMethodName}</strong></td>
					</c:if>
				</tr>
			</tbody>
		</table>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="box">		
			<h4>주문 상품 정보</h4>
			<table class="table table-bordered">
				<colgroup>
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
						<th>상품주문번호</th>
						<th>상품번호</th>
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
				<c:set var="checkBD" value="${vo.checkBD}"/>
				<c:forEach var="vo" items="${list}" varStatus="status">
					<tr <c:if test="${vo.seq==pvo.seq}"> class="tr-selected" </c:if>>
						<td class="text-center">${vo.seq}</td>
						<td class="text-center">${vo.itemSeq}</td>
						<td><strong>${vo.itemName}<br/></strong></td>
						<td>${vo.type1}
							<c:if test="${vo.type2 ne ''}">
								, ${vo.type2}
							</c:if>
							<c:if test="${vo.type3 ne ''}">
								, ${vo.type3}
							</c:if>
						</td>
						<td>${vo.originCountry}</td>
						<td>${vo.maker}</td>
						<td>${vo.insuranceCode}</td>
						<td class="text-center">
							<c:choose>
								<c:when test="${vo.eventAdded ne '' && vo.eventAdded ne ' ' && vo.eventAdded ne '0'}">
									${vo.eventAdded}
								</c:when>
								<c:otherwise>이벤트없음</c:otherwise>
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
						<td class="text-right">
							<c:set var="subTotal" value="${vo.sellPrice  * vo.orderCnt}"/>
							<%--<c:set var="total" value="${total + subTotal}"/>--%>
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
						<th colspan="12" style="font-size:15px;">
							주문합계금액 :
							상품금액(<fmt:formatNumber value="${total}"/>원) + 배송료(
							<c:choose>
								<c:when test="${totalDeliCost eq 0}">
									무료배송
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
								- 포인트차감(<fmt:formatNumber value="${vo.point}"/>원)
							</c:if>
							<c:if test="${vo.payMethod eq 'CASH' or vo.payMethod eq 'CASH+POINT'}">
								= 무통장입금금액(
										<fmt:formatNumber value="${total+totalDeliCost-vo.point}"/>
								)
							</c:if>
						</th>
						<td class="text-right">
							<%--<c:choose>--%>
								<%--<c:when test="${total>= 50000}">--%>
									<%--<fmt:formatNumber value="${total}"/>--%>
								<%--</c:when>--%>
								<%--<c:otherwise>--%>
									<fmt:formatNumber value="${total+totalDeliCost}"/>
								<%--</c:otherwise>--%>
							<%--</c:choose>--%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	<!-- 기관, 기업 정보 -->
	<c:if test="${mgVo ne null}">
		<div class="box">
			<h4>기관(기업) 정보</h4>
			<table id="view1" class="table table-bordered">
				<colgroup>
					<col style="width:15%"/>
					<col style="width:25%"/>
					<col style="width:15%"/>
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
						<td>${fn:substring(mgVo.bizNo,0,3)}-${fn:substring(mgVo.bizNo,3,5)}-${fn:substring(mgVo.bizNo,5,10)}</td>
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
						<td colspan="3">담당자:${mgVo.taxName} / 이메일:${mgVo.taxEmail} / 연락처:${mgVo.taxTel}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</c:if>
		
		<!-- 주문자 정보 -->	
		<div class="box">
			<h4>주문자 정보</h4>
			<table class="table table-bordered">
				<colgroup>
					<col style="width:15%"/>
					<col style="width:25%"/>
					<col style="width:15%"/>
					<col style="width:*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>주문자 명</th>
						<td>${vo.memberName}</td>
						<th>주문자 아이디</th>
						<td>${vo.memberId}</td>
					</tr>
					<tr>
						<th>주문자 전화번호</th>
						<td>${vo.memberTel}</td>
						<th>주문자 휴대폰번호</th>
						<td>${vo.memberCell}</td>
					</tr>
					<tr>
						<th>주문자 이메일</label>
						<td colspan="3">${vo.memberEmail}</div>
					</th>
				</tbody>
			</table>
		</div>
		
		<!-- 배송지 정보 -->
		<div class="box">
			<h4>배송지 정보</h4>
			<table class="table table-bordered">
				<colgroup>
					<col style="width:15%"/>
					<col style="width:25%"/>
					<col style="width:15%"/>
					<col style="width:*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>수취인 명</th>
						<td colspan="3">${vo.receiverName}</td>
					</tr>
					<tr>
						<th>수취인 전화번호</th>
						<td>${vo.receiverTel}</td>
						<th>수취인 휴대폰번호</th>
						<td>${vo.receiverCell}</td>
					</tr>
					<tr>
						<th>수취인 이메일</th>
						<td colspan="3">${vo.receiverEmail}</td>
					</tr>
					<tr>
						<th>배송지 주소</th>
						<td colspan="3">
							${vo.receiverPostcode}<br/>
							${vo.receiverAddr1}<br/>
							${vo.receiverAddr2}
						</td>
					</tr>
					<tr>
						<th>배송 메세지</th>
						<td colspan="3">${vo.request}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="box">
			<table style="border:1px #000 solid;width:100%;height:40px;">
				<colgroup>
					<col style="width:15%"/>
					<col style="width:20%"/>
					<col style="width:15%"/>
					<col style="width:*"/>
				</colgroup>
				<tbody>
					<tr>
						<td><strong style="font-size:15px">납품확인 :</strong></td>
						<td></td>
						<td><strong style="font-size:15px">사인</strong></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
</div>
</body>
</html>
