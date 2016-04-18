<%@ tag import="com.smpro.util.StringUtil" %><%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%@ attribute name="sumValue" %><%
	double cutValue = Double.valueOf(String.valueOf(value));
	int validSumValue = Integer.parseInt(sumValue);
	if(cutValue%3==0){
		out.print(((Math.floor(cutValue/3))*430)+validSumValue);
	}else{
		out.print(((Math.floor(cutValue/3)+1)*430)+validSumValue);
	}
%>