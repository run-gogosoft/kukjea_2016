<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
    "list":[
    <c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
        <c:if test="${status.index ne 0}">,</c:if>
        {
        "seq":"${item.seq}",
        "gradeName":"${item.gradeName}",
        "groupName":"${item.groupName}",
        "id":"${item.id}",
        "name":"${item.name}",
        "deptName":"${item.deptName}",
        "posName":"${item.posName}",
        "cell":"<smp:decrypt value="${item.cell}"/>",
        "email":"${item.email}",
        "totalOrderPrice":"<fmt:formatNumber value="${item.totalOrderPrice}"/>",
        "regDate":"${fn:substring(item.regDate,0,10)}",
        "lastDate":"${fn:substring(item.lastDate,0,10)}",
        "point":"<fmt:formatNumber value="${item.point}"/>"
        , "access":[
        <c:forEach var="value" items="${item.mallAccessVos}" varStatus="status2" begin="0" step="1">
            <c:if test="${status2.index ne 0}">,</c:if>
            {
            "accessStatus":"${value.accessStatus}",
            "mallSeq":"${value.mallSeq}"
            }
        </c:forEach>
        ]
        }
    </c:forEach>
    ],
    "total":"<fmt:formatNumber value="${total}"/>",
    "paging":"${paging}"
}