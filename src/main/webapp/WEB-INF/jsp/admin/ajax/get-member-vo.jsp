<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
"seq":"${vo.seq}"
, "id":"${vo.id}"
, "name":"${vo.name}"
, "nickname":"${vo.nickname}"
, "statusText":"${vo.statusText}"
, "gradeText":"${vo.gradeText}"
, "regDate":"${fn:substring(vo.regDate,0,10)}"
, "lastDate":"${fn:substring(vo.lastDate,0,10)}"
}
