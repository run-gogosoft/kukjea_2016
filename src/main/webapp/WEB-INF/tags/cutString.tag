<%@ tag import="com.smpro.util.StringUtil" %><%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%@ attribute name="length" %><%
	out.print(StringUtil.cutString(value, Integer.parseInt(length)));
%>