<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    String sSiteCode = "G6121";				   		// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "A2HA3DK88ZQ9";			// NICE로부터 부여받은 사이트 패스워드

    String sCipherTime = "";				 // 복호화한 시간
    String sRequestNumber = "";			 // 요청 번호
    String sResponseNumber = "";		 // 인증 고유번호
    String sAuthType = "";				   // 인증 수단
    String sName = "";							 // 성명
    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";					 // 생일
    String sGender = "";						 // 성별
    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();

        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        sAuthType 			= (String)mapresult.get("AUTH_TYPE");
        sName 					= (String)mapresult.get("NAME");
        sBirthDate 			= (String)mapresult.get("BIRTHDATE");
        sGender 				= (String)mapresult.get("GENDER");
        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        sDupInfo 				= (String)mapresult.get("DI");
        sConnInfo 			= (String)mapresult.get("CI");

        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(sRequestNumber.equals(session_sRequestNumber)){
        	//인증정보값 저장
        	sMessage = "인증에 성공하였습니다.";
            session.setAttribute("certKey", sDupInfo);
    		session.setAttribute("certName", sName);
        } else {
        	sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
            sResponseNumber = "";
            sAuthType = "";
        }

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
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
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
			if(rsltCode == "0") {
				opener.parent.document.formAgree.memberCertFlag.value = "Y";
                opener.parent.document.getElementById("authWrap").style.display = "none";
			}
			alert(rsltMsg);
			window.close();
		}
	</script>
</head>
<body onload="alertMsg('<%= iReturn %>','<%= sMessage %>')">

</body>
</html>