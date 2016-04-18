<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
<c:if test="${message != null}">
alert("${message}");
</c:if>
<c:if test="${returnUrl != null}">
<%--
	target가 top을 가리키는 것이 아니라면 항상 parent를 가리키는 것이 좋다
	특정 구현을 위한 기본 값이 최상위인 것보다 바로 전 단계를 가리키는 것이 더 안전한 구현이 될 수 있기 때문이다.
	이와 같은 이유에서 self를 추가하는 것을 고려해봤으나, 기본적으로 모든 소스의 방향이 zeroframe을 가리키도록 되어 있기 때문에 굳이 self를 추가할 필요는 없다고 생각했다.
 --%>
<c:choose><c:when test="${target eq 'top'}">top</c:when><c:otherwise>parent</c:otherwise></c:choose>.location.replace("${returnUrl}");
</c:if>
<c:if test="${callback != null}">
parent.window.callbackProc("${callback}");
</c:if>
</script>
</head>
</html>