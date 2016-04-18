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
	, "regDate" : "${fn:substring(vo.regDate,0,10)}"
	, "amount" : "<fmt:formatNumber value="${vo.amount}"/> 원 (부가세 포함)" 
	, "bizNo" : "${vo.bizNo}"
	, "sellerName" : "${vo.sellerName}"
	, "ceoName" : "${vo.ceoName}"
	, "addr" : "${vo.postcode} ${vo.addr1} ${vo.addr2}"
	, "bizType" : "${vo.bizType}"
	, "bizKind" : "${vo.bizKind}"
	, "tel" : "${vo.tel}"
	, "fax" : "${vo.fax}"
	, "itemName" : "${vo.itemName}"
	, "sellPrice" : "<fmt:formatNumber value="${vo.sellPrice}"/> 원"
	, "qty" : "<fmt:formatNumber value="${vo.qty}"/> 개"
	, "sum" : "<fmt:formatNumber value="${vo.sellPrice * vo.qty}"/> 원"
}