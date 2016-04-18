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

		.table-bordered {
			font-size: 12px;
			border-spacing: 0px;
			border-left: 1px solid #ccc;
			border-bottom: 1px solid #ccc;
		}

		.table-bordered th, .table-bordered td {
			padding:7px 5px 7px 5px;
			border-top: 1px solid #ccc;
			border-right: 1px solid #ccc;
		}

		.table-bordered th {
			background-color: #eee;
		}

		.table-bordered tbody > tr > th {
			text-align: right;
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
<c:set var="totalAmount" value="0"/>
<c:forEach var="item" items="${list}" varStatus="status">
	<c:set var="totalAmount" value="${totalAmount+((item.sellPrice + item.optionPrice) * item.count)}"/>
</c:forEach>

<table style="border:2px solid #000;width:700px;border-spacing:10px;margin-top:10px;">
	<tr>
		<td colspan="2" style="text-align:center;"><strong style="font-size:20px;">${title}</strong></td>
	</tr>
	<tr>
		<td style="width:300px;vertical-align:top;">
			<table class="table-bordered" style="width:100%">
				<colgroup>
					<col style="width:35%"/>
					<col style="width:*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>견적일자</th>
						<td>
							${nowDate}
						</td>
					</tr>
					<c:if test="${sessionScope.loginName ne null and sessionScope.loginName ne ''}">
						<tr>
							<th>이름</th>
							<td>${sessionScope.loginName}</td>
						</tr>
					</c:if>
					<tr>
						<th>견적합계</th>
						<td><strong style="color:red"><fmt:formatNumber value="${totalAmount}"/>원 (부가세 포함)</strong></td>
					</tr>
				</tbody>
			</table>
		</td>
		<td style="width:400px;">
			<table class="table-bordered" style="width:100%">
				<colgroup>
					<col style="width:25%"/>
					<col style="width:30%"/>
					<col style="width:*"/>
					<col style="width:30%"/>
				</colgroup>
				<tbody>
					<tr>
						<td colspan="4" style="text-align:center;background-color:#eee"><strong>공급사</strong></td>
					</tr>
					<tr>
						<th>사업자번호</th>
						<td colspan="3"><img src="${const.ASSETS_PATH}/front-assets/images/common/seal.png" style="position:absolute; top:100px; right:20px; width:70px; height:69px;" alt="직인생략">129-82-12399</td>
					</tr>
					<tr>
						<th>상호명</th>
						<td>재단법인 행복한웹앤미디어</td>
						<th>대표자</th>
						<td>김병두</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">경기도 성남시 분당구 황새울로256번길 29<br/>(수내동, 비에스타워 10층)</td>
					</tr>
					<tr>
						<th>업태</th>
						<td>서비스</td>
						<th>종목</th>
						<td>소프트웨어개발 및 공급 외</td>
					</tr>
					<tr>
						<th>대표전화</th>
						<td>02-2222-3896</td>
						<th>팩스</th>
						<td>070-7864-2698</td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="padding-top:20px;">
			<table class="table-bordered" style="width:100%">
				<colgroup>
					<col style="width:5%"/>
					<col style="width:15%"/>
					<col style="width:*"/>
					<col style="width:12%"/>
					<col style="width:8%"/>
					<col style="width:12%"/>
				</colgroup>
				<thead>
					<tr>
						<th>No.</th>
						<th>분류</th>
						<th>품명</th>
						<th>판매가</th>
						<th>수량</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="item" items="${list}" varStatus="status">
					<tr>
						<td style="text-align:center">${status.index + 1}</td>
						<td style="text-align:center">${item.cateLv1Name}</td>
						<td style="text-align:center">${item.name}</td>
						<td style="text-align:right"><fmt:formatNumber value="${item.sellPrice + item.optionPrice}"/>원</td>
						<td style="text-align:right"><fmt:formatNumber value="${item.count}"/>개</td>
						<td style="text-align:right"><fmt:formatNumber value="${(item.sellPrice + item.optionPrice) * item.count}"/>원</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
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