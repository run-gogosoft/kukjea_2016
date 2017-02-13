<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
	{
	"receiverName":"${vo.receiverName}"
	, "receiverCell":"${vo.receiverCell}"
	, "receiverTel":"${vo.receiverTel}"
	, "receiverPostcode":"${vo.receiverPostcode}"
	, "receiverAddr1":"${vo.receiverAddr1}"
	, "receiverAddr2":"${vo.receiverAddr2}"
	, "receiverEmail":"${vo.email}"
	}