<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta property="og:type" content="website">
<meta property="og:title" content="국제몰닷컴">
<meta property="og:description" content="의료소모품 전문 쇼핑몰">
<meta property="og:image" content="http://kukjemall.com/images/common/logo.gif">
<meta property="og:url" content="http://www.kukjemall.com">
<title><c:if test="${title ne null}">${title} : </c:if>국제몰</title>
<meta name="keywords" content="국제몰, KUKJE MALL, 국제실업" />
<link rel="stylesheet" href="/css/nanumbarungothic.css" />
<link rel="stylesheet" href="/css/common.css" />
<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<script>function noImage(obj) { obj.src='/images/thumb/no_image.jpg'; }</script>