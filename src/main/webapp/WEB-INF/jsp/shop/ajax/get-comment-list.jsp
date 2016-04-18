<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	"totalCount":"${totalCount}"
	, "pageNum":"${pageNum}"
	, "list":[
		<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
			<c:if test="${status.index ne 0}">,</c:if>
			{
				"seq":"${item.seq}"
				, "userSeq":"${item.userSeq}"
				, "number":"${status.count}"
				, "name":"${fn:replace(item.name, fn:substring(item.name,1,2), '*')}"
				, "nickName":"${item.nickName}"
				, "content":"<smp:jsonHelper value="${item.content}" />"
				, "regDate":"<fmt:parseDate value='${item.regDate}' var="regDate" pattern="yyyy-mm-dd"/><fmt:formatDate value='${regDate}' pattern="yyyy-mm-dd"/>"
			}
		</c:forEach>
	]
}