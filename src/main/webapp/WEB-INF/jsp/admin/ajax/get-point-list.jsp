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
		"seq":"${item.seq}",
		"regDate":"${fn:substring(item.regDate,0,10)}",
		"point":"<fmt:formatNumber value="${item.point}"/>",
		"name":"${item.name}",
		"mallName":"${item.mallName}",
		"orderSeq":"${item.orderSeq}",
		"orderDetailSeq":"${item.orderDetailSeq}",
		"note":"${item.note}",
		"statusName":"${item.statusName}"
		}
	</c:forEach>
	],
	"total":"<fmt:formatNumber value="${total}"/>",
	"paging":"${paging}"
}