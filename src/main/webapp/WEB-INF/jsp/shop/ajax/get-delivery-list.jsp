<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
[
<c:forEach var="item" items="${list}" varStatus="status" begin="0" step="1">
	<c:if test="${status.index ne 0}">,</c:if>
	{
	  "seq" : "${item.seq}"
	, "title" : "${item.title}"
	, "name" : "${item.name}"
	, "tel" : "${item.tel}"
	, "tel1" : "${item.tel1}"
	, "tel2" : "${item.tel2}"
	, "tel3" : "${item.tel3}"
	, "cell" : "${item.cell}"
	, "cell1" : "${item.cell1}"
	, "cell2" : "${item.cell2}"
	, "cell3" : "${item.cell3}"
	, "postcode" : "${item.postcode}"
	, "addr1" : "${item.addr1}"
	, "addr2" : "${item.addr2}"
	, "defaultFlag" : "${item.defaultFlag}"
	, "email": "${item.email}"
	}
</c:forEach>
]