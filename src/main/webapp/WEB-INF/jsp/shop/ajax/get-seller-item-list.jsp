<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	"list":[
	<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
		<c:if test="${status.index ne 0}">,</c:if>
		{
			"seq":"${item.seq}"
			, "count":"${status.count}"
			, "soldOutFlag":"${item.soldOutFlag}"
			, "name":"${item.name}"
			, "typeCode":"${item.typeCode}"
			, "sellPrice":"<fmt:formatNumber value="${item.sellPrice}" pattern="#,###" />"
			, "img1":"<c:if test="${item.img1 ne ''}">/upload${fn:replace(item.img1, 'origin', 's110')}</c:if>"
			, "img2":"<c:if test="${item.img2 ne ''}">/upload${fn:replace(item.img2, 'origin', 's110')}</c:if>"
		}
	</c:forEach>
	],
	"total":"<fmt:formatNumber value="${vo.totalRowCount}"/>",
	"paging":"${paging}"
}