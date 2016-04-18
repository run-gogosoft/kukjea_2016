<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
<% pageContext.setAttribute("tab","\t"); %>
<% pageContext.setAttribute("etx", new Character((char)3));%>
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
	"seq":"${item.seq}"
	, "name":"${item.name}"
	, "nickName":"${item.nickName}"
	, "answerFlag":"<c:choose><c:when test="${ item.answer eq null || item.answer eq ''}">미답변</c:when><c:otherwise>답변</c:otherwise></c:choose>"
	, "title":"<smp:jsonHelper value="${item.title}"/>"
	, "content":"<smp:jsonHelper value="${item.content}"/>"
	, "count":"${status.count}"
	, "answer":"<smp:jsonHelper value="${item.answer}"/>"
	, "regDate":"<fmt:parseDate value='${item.regDate}' var="regDate" pattern="yyyy-mm-dd"/><fmt:formatDate value='${regDate}' pattern="yyyy-mm-dd"/>"
	, "answerDate":"<fmt:parseDate value='${item.answerDate}' var="answerDate" pattern="yyyy-mm-dd"/><fmt:formatDate value='${answerDate}' pattern="yyyy-mm-dd"/>"
	}
</c:forEach>
]