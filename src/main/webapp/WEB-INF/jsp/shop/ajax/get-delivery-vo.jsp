<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	"seq" : "${vo.seq}"
	, "name" : "${vo.name}"
	, "tel" : "${vo.tel}"
	, "tel1" : "${vo.tel1}"
	, "tel2" : "${vo.tel2}"
	, "tel3" : "${vo.tel3}"
	, "cell" : "${vo.cell}"
	, "cell1" : "${vo.cell1}"
	, "cell2" : "${vo.cell2}"
	, "cell3" : "${vo.cell3}"
	, "postcode" : "${vo.postcode}"
	, "addr1" : "${vo.addr1}"
	, "addr2" : "${vo.addr2}"
	, "email" : "${vo.email}
}