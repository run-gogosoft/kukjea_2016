<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
		"itemSeq":"${item.itemSeq}"
		, "itemName":"${item.itemName}"
		, "typeCode":"${item.typeCode}"
		, "sellPrice":"<fmt:formatNumber value="${item.sellPrice}" pattern="#,###" />"
		, "img1":"<c:if test="${item.img1 ne ''}">${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's110')}</c:if>"
		, "limitCnt":"${item.limitCnt}"
		, "index":"${status.index}"
		, "itemCount":"${status.index}"
	}
</c:forEach>
]