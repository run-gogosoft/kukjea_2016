<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	, "salePrice":"${item.salePrice}"
	, "salePeriod":"${item.salePeriod}"
	, "optionPrice":"${item.optionPrice}"
	, "originalPrice":"${item.originalPrice}"
	, "freeDeli":"${item.freeDeli}"
	, "eventAdded":"${item.eventAdded}"
}
