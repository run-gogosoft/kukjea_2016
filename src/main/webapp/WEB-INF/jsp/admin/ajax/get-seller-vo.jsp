<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	  "seq":"${item.seq}"
	, "id":"${item.id}"
	, "name":"${item.name}"
	, "gradeCode":"${item.gradeCode}"
	, "adjustGradeCode":"${item.adjustGradeCode}"
	, "statusCode":"${item.statusCode}"
	, "ceoName":"${item.ceoName}"
	, "tel":"${item.tel}"
	, "salesName":"${item.salesName}"
	, "salesTel":"${item.salesTel}"
	, "approvalDate":"${fn:substring(item.approvalDate,0,10)}"
	, "regDate":"${fn:substring(item.regDate,0,10)}"
	, "commission":"${item.commission}
}
