<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
<% pageContext.setAttribute("etx", new Character((char)3));%>
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
	"seq":"${item.seq}"
	, "itemSeq":"${item.itemSeq}"
	, "img1":"<c:if test="${item.img1 ne ''}">/upload${fn:replace(item.img1, 'origin', 's60')}</c:if>"
	, "displaySeq":"${item.displaySeq}"
	, "listTitle":"${ item.listTitle }"
	, "orderNo":"${item.orderNo}"
	, "itemName":"${item.itemName}"
	, "sellPrice":"<fmt:formatNumber value="${item.sellPrice}" pattern="#,###" />"
	, "statusFlag":"${item.statusFlag}"
	, "mallId":"${item.mallId}"
	}
</c:forEach>
]