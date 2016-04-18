<%@ tag import="com.smpro.util.StringUtil" %><%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%
	out.print(StringUtil.clearXSS(value));
%>