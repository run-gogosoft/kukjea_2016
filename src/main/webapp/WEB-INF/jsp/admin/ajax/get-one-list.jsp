<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	"list" : [
	<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
		<c:if test="${status.index ne 0}">,</c:if>
		{
		"seq":"${item.seq}",
		"orderSeq":"${item.orderSeq}",
		"categoryCode":"${item.categoryCode}",
		"integrationSeq":"${item.integrationSeq}",
		"mallName":"${item.mallName}",
		"title":"${item.title}",
		"name":"${item.name}",
		"answerFlag":"${item.answerFlag}",
		"regDate":"${item.regDate}"

		}
	</c:forEach>
	],
	"total":"<fmt:formatNumber value="${total}"/>",
	"paging":"${paging}"
}