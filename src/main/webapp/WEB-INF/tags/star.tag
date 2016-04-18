<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="" %><%@ attribute name="value" %><%@ attribute name="max" %><%
	int count, maxCount;
	try {
		count = Integer.parseInt(String.valueOf(value));
		maxCount = Integer.parseInt(String.valueOf(max));
	} catch(Exception e) {
		count = 0;
		maxCount = 10;
	}

	for (int i = 0; i < count; i++) {
		out.print("★");
	}

	for(int i=count; i<maxCount; i++) {
		out.print("☆");
	}

%>