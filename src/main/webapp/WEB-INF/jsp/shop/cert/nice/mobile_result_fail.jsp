<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    String sSiteCode = "G6121";						// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "A2HA3DK88ZQ9";				// NICE로부터 부여받은 사이트 패스워드

    String sCipherTime = "";					// 복호화한 시간
    String sRequestNumber = "";				// 요청 번호
    String sErrorCode = "";						// 인증 결과코드
    String sAuthType = "";						// 인증 수단
    String sMessage = "";
    String sPlainData = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();

        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber 	= (String)mapresult.get("REQ_SEQ");
        sErrorCode 			= (String)mapresult.get("ERR_CODE");
        sAuthType 			= (String)mapresult.get("AUTH_TYPE");

        //함께누리측의 요청으로 인해 인증 실패 코드를 숨긴다.(후에 정책이 변할수도 있으므로 사용하기 쉽도록 주석처리 한다.)
        //sMessage = "인증에 실패하였습니다.[sErrorCode: "+sErrorCode+"]";
        sMessage = "인증에 실패하였습니다.";
    }
    else if( iReturn == -1)
    {
        sMessage = "복호화 시스템 에러입니다.";
    }
    else if( iReturn == -4)
    {
        sMessage = "복호화 처리오류입니다.";
    }
    else if( iReturn == -5)
    {
        sMessage = "복호화 해쉬 오류입니다.";
    }
    else if( iReturn == -6)
    {
        sMessage = "복호화 데이터 오류입니다.";
    }
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }
    else if( iReturn == -12)
    {
        sMessage = "사이트 패스워드 오류입니다.";
    }
    else
    {
        //함께누리측의 요청으로 인해 인증 실패 코드를 숨긴다.(후에 정책이 변할수도 있으므로 사용하기 쉽도록 주석처리 한다.)
        //sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
        sMessage = "알수 없는 에러 입니다.";
    }

%>
<%!
public String requestReplace (String paramValue, String gubun) {
        String result = "";

        if (paramValue != null) {

        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");

        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}

        	result = paramValue;

        }
        return result;
  }

%>

<html>
<head>
    <title>NICE평가정보 - CheckPlus 안심본인인증 서비스</title>
    <script type="text/javascript">
		function alertMsg(rsltCode, rsltMsg) {
			opener.parent.document.formAgree.memberCertFlag.value = "N";

			alert(rsltMsg);
			window.close();
		}
	</script>
</head>
<body onload="alertMsg('<%= iReturn %>','<%= sMessage %>')">

</body>
</html>