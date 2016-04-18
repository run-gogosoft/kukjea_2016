<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	<c:if test="${message != null}">
		alert("${message}");
	</c:if>
	<c:if test="${callback != null}">
		parent.window.callbackProc("${callback}");
	</c:if>
</script>
</head>
</html>