<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
<meta charset="UTF-8">
<title><c:if test="${title ne null}"> ${title} : </c:if> 국제몰어드민
    <%--<c:if test="${sessionScope.loginType ne 'A'}">${sessionScope.loginName}</c:if>--%>
</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="apple-mobile-web-app-capable" content="yes">
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

<!-- Bootstrap 3.3.4 -->
<link href="/assets/admin_lte2/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<!-- FontAwesome 4.3.0 -->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<!-- Ionicons 2.0.0 -->
<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href="/assets/admin_lte2/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
<!-- AdminLTE Skins. Choose a skin from the css/skins
     folder instead of downloading all of them to reduce the load. -->
<link href="/assets/admin_lte2/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
<!-- iCheck -->
<link href="/assets/admin_lte2/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />

<!-- jQuery UI css -->
<link href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
<!-- jQuery msgbox -->
<link href="/assets/js/plugins/msgbox/jquery.msgbox.css" rel="stylesheet">
<!-- custom CSS -->
<link href="/assets/css/custom.css" rel="stylesheet" type="text/css" />

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

