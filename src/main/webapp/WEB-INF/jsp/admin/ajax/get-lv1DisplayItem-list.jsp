<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
	"cateLv1Name":"${item.cateLv1Name}"
	, "cateLv2Name":"${item.cateLv2Name}"
	, "cateLv3Name":"${item.cateLv3Name}"
	, "cateLv4Name":"${item.cateLv4Name}"
	, "sellPrice":"<fmt:formatNumber value="${item.sellPrice}" pattern="#,###" />"
	, "seq":"${item.seq}"
	, "name":"${item.name}"
	, "sellerName":"${item.sellerName}"
	, "img1":"<c:if test="${item.img1 ne ''}">${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's206')}</c:if>"
	}
</c:forEach>
]