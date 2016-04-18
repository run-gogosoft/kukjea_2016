<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%@ attribute name="max" %><%
	value = value.replaceAll("\n", "\\\\n");
	value = value.replaceAll("\r", "\\\\r");
	value = value.replaceAll("\"", "\\\\\"");
	value = value.replaceAll("\t", "\\\\t");
	value = value.replaceAll(new Character((char)3).toString(), "");

	out.print(value);
%>