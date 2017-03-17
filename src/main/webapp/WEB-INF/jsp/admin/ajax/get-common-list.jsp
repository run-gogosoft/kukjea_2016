<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	"list" : [
	<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
		<c:if test="${status.index ne 0}">,</c:if>
		{
			"seq":"${item.seq}"
			, "groupCode":"${item.groupCode}"
			, "groupName":"${item.groupName}"
			, "value":"${item.value}"
			, "name":"${item.name}"
			, "note":"${item.note}"
		}
	</c:forEach>
	],
	"mallList" : [
	<c:forEach var="mall" items="${mallList}" varStatus="statusx" begin="0" step="1">
		<c:if test="${statusx.index ne 0}">,</c:if>
		{
		"seq" :"${mall.seq}",
		"name":"${mall.name}"
		}
	</c:forEach>
	],
	"total":"<fmt:formatNumber value="${total}"/>",
	"paging":"${paging}"
}