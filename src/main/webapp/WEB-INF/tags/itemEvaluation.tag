<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%
	int itemEvaluation;
	try {
		itemEvaluation = Integer.parseInt(String.valueOf(value));
	} catch(Exception e) {
		itemEvaluation = 0;
	}
	if(itemEvaluation==0){
		out.print("ERROR");
	} else if(itemEvaluation==1) {
		out.print("불만");
	} else if(itemEvaluation==2) {
		out.print("약간불만");
	} else if(itemEvaluation==3) {
		out.print("보통");
	} else if(itemEvaluation==4) {
		out.print("약간만족");
	} else if(itemEvaluation==5) {
		out.print("만족");
	}
%>
