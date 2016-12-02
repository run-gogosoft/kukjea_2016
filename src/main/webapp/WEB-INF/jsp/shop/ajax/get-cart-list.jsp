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
		"minCnt":"${item.minCnt}"
		, "maxCnt":"${item.maxCnt}"
		, "seq":"${item.seq}"
		, "img1":"/upload${fn:replace(item.img1, 'origin', 's60')}"
		, "itemSeq":"${item.itemSeq}"
		, "name":"${item.name}"
		<%--
			옵션은 무조건 하나 이상 존재할 수 밖에 없도록 정책이 확정되어 있지만,
			옵션이 하나 밖에 없고, 옵션가가 0원일 경우 옵션과 옵션값의 이름을 보여주지 않는다
			detail도 order도 동일한 정책이다 (참고 바람)
		--%>
		, "optionValueSeq":"${item.optionValueSeq}"
		, "optionName":"<c:if test="${!(item.optionCount eq 1 and item.optionPrice eq 0)}">${item.optionName}</c:if>"
		, "valueName":"<c:if test="${!(item.optionCount eq 1 and item.optionPrice eq 0)}">${item.valueName}</c:if>"
		, "count":"${item.count}"
		, "freeDeli":"${item.freeDeli}"
		, "eventAdded":"${item.eventAdded}"
		, "sellPrice":"${item.sellPrice}"
		, "sellPriceText":"<fmt:formatNumber value="${item.sellPrice}" pattern="#,###" />"
		, "totalPriceText":"<fmt:formatNumber value="${(item.sellPrice)*item.count}" pattern="#,###" />"
		, "deliTypeCode":"${item.deliTypeCode}"
		, "deliCost":"${item.deliCost}"
		, "deliCostText":"<fmt:formatNumber value="${item.deliCost}" pattern="#,###" />"
		, "deliFreeAmount":"${item.deliFreeAmount}"
		, "deliFreeAmountText":"<fmt:formatNumber value="${item.deliFreeAmount}" pattern="#,###" />"
		, "deliPrepaidFlag":"${item.deliPrepaidFlag}"
		, "deliPackageFlag":"${item.deliPackageFlag}"
		, "packageDeliCost":"${item.packageDeliCost}"
		, "sellerName":"${item.valueName}"
		, "stockCount":"${item.stockCount}"
		, "stockFlag":"${item.stockFlag}"
	}
</c:forEach>
]
