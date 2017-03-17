<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
	"seq":"${item.seq}"
	, "parentSeq":"${item.parentSeq}"
	, "depth":"${item.depth}"
	, "name":"${item.name}"
	, "orderNo":"${item.orderNo}"
	, "regDate":"${item.regDate}"
	, "showFlag":"${item.showFlag}"
	, "mallId":"${item.mallId}"
	}
</c:forEach>
]