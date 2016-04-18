<%@ tag import="com.smpro.util.crypt.CrypteUtil" import="com.smpro.util.Const" %><%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="clearXSS" %><%@ attribute name="value" %><%
	if(value != null) {
		String decryptStr = CrypteUtil.decrypt(value.trim(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null);
		if(decryptStr != null) {
			out.print(decryptStr.trim());
		}
	}
%>