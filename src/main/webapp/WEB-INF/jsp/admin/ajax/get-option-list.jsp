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
		, "itemSeq":"${item.itemSeq}"
		, "optionName":"${item.optionName}"
		, "showFlag":"${item.showFlag}"
		, "modDate":"${item.modDate}"
		, "regDate":"${item.regDate}"
		, "idx":"${fn:length(list)}"
		, "list":[
			<c:forEach var="value" items="${item.valueList}" varStatus="status2" begin="0" step="1">
			<c:if test="${status2.index ne 0}">,</c:if>
			{
				  "seq":"${value.seq}"
				, "option":"${value.optionSeq}"
				, "valueName":"${value.valueName}"
				, "stockCount":"${value.stockCount}"
				, "stockFlag":"${value.stockFlag}"
				, "salePrice":"${value.salePrice}"
				, "salePeriod":"${value.salePeriod}"
				, "optionPrice":"${value.optionPrice}"
				, "freeDeli":"${value.freeDeli}"
				, "eventAdded":"${value.eventAdded}"
			}
			</c:forEach>
		]
	}
</c:forEach>
]