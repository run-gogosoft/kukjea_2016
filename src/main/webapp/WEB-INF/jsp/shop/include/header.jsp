<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<%@ taglib prefix="smp" tagdir="/WEB-INF/tags" %>
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=0.1, maximum-scale=1.0, user-scalable=yes" />
<title> <c:if test="${title ne null}">${title} : </c:if>&nbsp;함께누리몰에 오신것을 환영합니다.</title>

<link href="/front-assets/css/plugin/bootstrap.css" type="text/css" rel="stylesheet">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css" rel="stylesheet">
<link href="/front-assets/css/common/common.css" type="text/css" rel="stylesheet">
<link href="/front-assets/css/plugin/base_admin.css" type="text/css" rel="stylesheet">
<link href="/front-assets/css/plugin/datepicker3.css" type="text/css" rel="stylesheet">
<link href="/front-assets/css/plugin/verticalslide/style.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}/menuJson.js"></script>
<script type="text/javascript">
	var constants = { "ASSETS_PATH":"${const.ASSETS_PATH}", "UPLOAD_PATH":"${const.IMG_DOMAIN}${const.UPLOAD_PATH}" };
</script>
<!--[if lt IE 9]>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/plugin/html5shiv.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/plugin/selectivizr-min.js"></script>
<![endif]-->