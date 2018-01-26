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
		"orderSeq":"${item.orderSeq}",
		"statusText":"${item.statusText}",
		"payMethod":"${item.payMethod}",
		"payMethodName":"${item.payMethodName}",
		"memberName":"${item.memberName}",
		"receiverName":"${item.receiverName}",
		"itemSeq":"${item.itemSeq}",
		"itemName":"${item.itemName}",
		"optionValue":"${item.optionValue}",
		"sellPrice":"<fmt:formatNumber value="${item.sellPrice}"/>",
		"orderCnt":"${item.orderCnt}",
		"deliCost":"<fmt:formatNumber value="${item.deliCost}"/>",
		"deliName":"${item.deliName}",
		"deliNo":"${item.deliNo}",
		"boxCnt":"${item.boxCnt}",
		"totalDeliCost":"${item.totalDeliCost}",
		"sellerName":"${item.sellerName}",
		"salesName":"${item.salesName}",
		"salesTel":"${item.salesTel}",
		"salesCell":"${item.salesCell}",
		"salesEmail":"${item.salesEmail}",
		"regDate":"${fn:substring(item.regDate,0,10)}",
		"deliPrepaidFlag":"${item.deliPrepaidFlag}",
		"freeDeli":"${item.freeDeli}",
		"eventAdded":"${item.eventAdded}",
		"index":"${status.index}"
		}
	</c:forEach>
	],
	"total":"<fmt:formatNumber value="${total}"/>",
	"paging":"${paging}"
}