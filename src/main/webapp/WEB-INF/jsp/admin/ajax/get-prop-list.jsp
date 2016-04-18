<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
	"typePropId":"${item.typePropId}"
	, "typeCd":"${item.typeCd}"
	, "propCd":"${item.propCd}"
	, "seqNo":"${item.seqNo}"
	, "propNm":"${item.propNm}"
	, "propType":"${item.propType}"
	, "propNote":"${item.propNote}"
	, "defaultVal":"${item.defaultVal}"
	, "extPropCd1":"${item.extPropCd1}"
	, "radioList":"${item.radioList}"
	, "typeNm":"${item.typeNm}"
	, "number":${status.index}
	}
</c:forEach>
]