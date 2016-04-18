<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%@ attribute name="max" %><%
	int count, maxCount;
	try {
		count = Integer.parseInt(String.valueOf(value));
		if(count>5){
			count = 5;
		}
		maxCount = Integer.parseInt(String.valueOf(max));
	} catch(Exception e) {
		count = 0;
		maxCount = 5;
	}

	for (int i = 0; i < count; i++) {
		out.print("★");
	}

%>