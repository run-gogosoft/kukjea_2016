<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

	<style type="text/css">
		body {
			margin: 0px;
		}

		ul {
			padding: 0px;
		}

		ul > li {
			list-style: none;
			float: left;
		}

		.text-right {
			text-align:right;
		}

		.text-center {
			text-align:center;
		}

		.table {
			font-size: 12px;
			border-spacing: 0px;
		}

		.table th, .table td {
			padding:7px 5px 7px 5px;
		}

		.table-solid {
			border:1px solid #ccc;
		}

		.table-bordered {
			border-left: 1px solid #ccc;
			border-bottom: 1px solid #ccc;
		}

		.table-bordered th, .table-bordered td {
			border-top: 1px solid #ccc;
			border-right: 1px solid #ccc;
		}

		.table-bordered th {
			background-color: #eee;
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
<center>
<table style="border:2px solid #000;width:700px;border-spacing:10px;margin-top:10px;">
	<tr>
		<td colspan="2" style="text-align:center;"><strong style="font-size:20px;">${title}</strong></td>
	</tr>
	<tr>
		<td style="padding-top:20px;">
			<table class="table table-bordered" style="width:100%">
				<thead>
					<tr>
						<th rowspan="3">공급자</th>
						<th>상호(법인명)</th>
						<td>재단법인 행복한웹앤미디어</td>
						<th>사업자등록번호</th>
						<td>129-82-12399</td>
					</tr>
					<tr>
						<th>성명(대표자명)</th>
						<td>김 병 두<img src="${const.ASSETS_PATH}/front-assets/images/common/seal.png" style="position:absolute; top:75px; right:280px; width:70px; height:69px;" alt="직인생략"></td>
						<th>전화번호</th>
						<td>02-2222-3896</td>
					</tr>
					<tr>
						<th>사업장주소</th>
						<td colspan="4">경기도 성남시 분당구 황새울로256번길 29 (수내동, 비에스타워 10층)</td>
					</tr>
				</thead>
			</table>
			<table class="table table-bordered" style="width:100%;margin-top:3px;">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
					<tr>
						<th>품 명</th>
						<th>수 량</th>
						<th>단가</th>
						<th>공급가액</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="name" value="''"/>
					<c:set var="totalAmount" value="0"/>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td class="text-center">${item.itemName}</td>
							<td class="text-center"><fmt:formatNumber value="${item.orderCnt}"/></td>
							<td class="text-center"><fmt:formatNumber value="${item.sellPrice + item.optionPrice}"/></td>
							<td class="text-center"><fmt:formatNumber value="${(item.sellPrice + item.optionPrice) * item.orderCnt}"/></td>
							<td class="text-center">(VAT포함)</td>
						</tr>
						<c:set var="totalAmount" value="${totalAmount+((item.sellPrice + item.optionPrice) * item.orderCnt)}"/>
					</c:forEach>
				</tbody>
				<tfooter>
					<tr>
						<td colspan="4" class="text-right"><strong>합계금액(VAT포함)<strong></strong></td>
						<td class="text-center"><strong style="color:red"><fmt:formatNumber value="${totalAmount}"/>원</strong></td>
					</tr>
				</tfooter>
			</table>
		<c:if test="${sessionScope.loginMemberTypeCode ne 'C'}">
			<table class="table table-solid" style="width:100%;margin-top:3px;">
				<colgroup>
					<col width="15%"/>
					<col width="12%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr><td colspan="3" style="padding-top:20px;padding-left:15px;">위와 같이 납품 완료하였음을 확인합니다.</td></tr>
					<tr>
						<td colspan="3" class="text-center" style="padding-top:30px;padding-bottom:50px;">
							${fn:substring(nowDate, 0,4)} <strong>년</strong> &nbsp; &nbsp;
							${fn:substring(nowDate, 5,7)} <strong>월</strong> &nbsp; &nbsp;
							<strong>일</strong>
						</td>
					</tr>
					<tr>
						<th rowspan="3" style="vertical-align:top;">공급 받는자</th>
						<th class="text-right">상&nbsp;  &nbsp;  &nbsp;  &nbsp;  호 : </th>
						<td>${sessionScope.loginName}(${memberGvo.name})</td>
					</tr>
					<tr>
						<th class="text-right">대표이사 : </th>
						<td>${memberGvo.ceoName}</td>
					</tr>
					<tr>
						<th class="text-right">소&nbsp; 재&nbsp; 지 : </th>
						<td>${memberVo.addr1} ${memberVo.addr2}</td>
					</tr>
					<tr>
						<td colspan="3"></td>
					</tr>
				</tbody>
			</table>
		</c:if>
		</td>
	</tr>
</table>
<p class="no-print" style="margin-top:10px">
	<button type="button" onclick="window.print();">인쇄하기</button>
	<button type="button" onclick="window.close();">닫기</button>
</p>
</center>
</body>
</html>