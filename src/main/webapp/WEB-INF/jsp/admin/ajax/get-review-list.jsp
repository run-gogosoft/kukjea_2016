<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	"list" : [
	<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
		<c:if test="${status.index ne 0}">,</c:if>
		{
			"seq":"${item.seq}",
			"itemSeq":"${item.itemSeq}",
			"itemName":"${item.itemName}",
			"img1":"/upload${fn:replace(item.img1, 'origin', 's60')}",
			"mallName":"${item.mallName}",
			"review":"${item.review}",
			"goodGrade":"<smp:reviewStar max="5" value="${item.goodGrade}" />",
			"name":"${item.name}",
			"regDate":"${fn:substring(item.regDate,0,10)}"
		}
	</c:forEach>
	],
	"total":"<fmt:formatNumber value="${total}"/>",
	"paging":"${paging}"
}