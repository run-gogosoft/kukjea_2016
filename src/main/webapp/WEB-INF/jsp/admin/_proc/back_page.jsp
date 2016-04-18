<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript">
		<c:if test="${message ne null}">
		alert("${message}"); 
		</c:if>
		<c:if test="${message eq null}">
		alert("해당 요청 기능이 차단되었습니다.");
		</c:if>
		history.back();
	</script>
</head>
</html>