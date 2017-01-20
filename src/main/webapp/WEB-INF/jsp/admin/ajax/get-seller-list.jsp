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
	, "id":"${item.id}"
	, "name":"${item.name}"
	, "gradeCode":"${item.gradeCode}"
	, "statusCode":"${item.statusCode}"
	, "ceoName":"${item.ceoName}"
	, "tel":"${item.tel}"
	, "salesName":"${item.salesName}"
	, "salesTel":"${item.salesTel}"
	, "approvalDate":"${fn:substring(item.approvalDate,0,10)}"
	, "regDate":"${fn:substring(item.regDate,0,10)}"
	, "commission":"${item.commission}"
	}
</c:forEach>
]