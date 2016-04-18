<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<%--
	이 파일은 ajax로 통신되어 문자열만 반환하기 위해 사용하므로 doctype이나 헤더나 풋터가 필요없다
--%>
<table class="table table-striped table-bordered">
	<colgroup>
		<col width="10%" />
		<col width="*"/>
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
	</colgroup>
	<thead>
	<tr>
		<th></th>
		<th>내용</th>
		<th>사용자</th>
		<th>타입</th>
		<th>등록일</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
			<tr>
				<td class="text-center"><span
						<c:choose>
							<c:when test="${item.modContent ne ''}">
								onclick="showLog('${item.seq}')"
							</c:when>
							<c:otherwise>
								onclick="alert('수정된 항목이없습니다.')"
							</c:otherwise>
						</c:choose>
						style="cursor: pointer;">${item.action}</span></td>
				<td><smp:clearXss value="${item.content}"/></td>
				<td class="text-center">${item.name}</td>
				<td class="text-center">
					<c:if test="${item.loginType eq 'A'}">관리자</c:if>
					<c:if test="${item.loginType eq 'S'}">입점업체</c:if>
					<c:if test="${item.loginType eq 'D'}">총판</c:if>
				</td>
				<td class="text-center">
					${item.regDate}
				</td>
			</tr>
			<tr id="${item.seq}" style="display: none;">
				<td colspan="5" style="padding: 15px;">변경사항 : <smp:clearXss value="${item.modContent}"/></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(list) eq 0}">
		<tr>
			<td colspan="5" class="text-center muted">
				등록된 내용이 없습니다
			</td>
		</tr>
		</c:if>
	</tbody>
</table>
<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>