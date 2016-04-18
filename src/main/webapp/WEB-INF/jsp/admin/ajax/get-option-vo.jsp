<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="const" className="com.smpro.util.Const" />
<% pageContext.setAttribute("newLine","\n"); %>
<% pageContext.setAttribute("carriageReturn","\r"); %>
{
	  "seq":"${item.seq}"
	, "itemSeq":"${item.itemSeq}"
	, "optionName":"${item.optionName}"
	, "showFlag":"${item.showFlag}"
	, "modDate":"${item.modDate}"
	, "regDate":"${item.regDate}"
	, "option":"${item.optionSeq}"
	, "valueName":"${item.valueName}"
	, "stockCount":"${item.stockCount}"
	, "stockFlag":"${item.stockFlag}"
	, "optionPrice":"${item.optionPrice}"
}
