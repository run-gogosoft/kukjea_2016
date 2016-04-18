<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    String sSiteCode = "G6121";				   		// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "A2HA3DK88ZQ9";			// NICE�κ��� �ο����� ����Ʈ �н�����

    String sCipherTime = "";				 // ��ȣȭ�� �ð�
    String sRequestNumber = "";			 // ��û ��ȣ
    String sResponseNumber = "";		 // ���� ������ȣ
    String sAuthType = "";				   // ���� ����
    String sName = "";							 // ����
    String sDupInfo = "";						 // �ߺ����� Ȯ�ΰ� (DI_64 byte)
    String sConnInfo = "";					 // �������� Ȯ�ΰ� (CI_88 byte)
    String sBirthDate = "";					 // ����
    String sGender = "";						 // ����
    String sNationalInfo = "";       // ��/�ܱ������� (���߰��̵� ����)
    String sMessage = "";
    String sPlainData = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();

        // ����Ÿ�� �����մϴ�.
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
        	//���������� ����
        	sMessage = "������ �����Ͽ����ϴ�.";
            session.setAttribute("certKey", sDupInfo);
    		session.setAttribute("certName", sName);
        } else {
        	sMessage = "���ǰ��� �ٸ��ϴ�. �ùٸ� ��η� �����Ͻñ� �ٶ��ϴ�.";
            sResponseNumber = "";
            sAuthType = "";
        }

    }
    else if( iReturn == -1)
    {
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }
    else if( iReturn == -4)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }
    else if( iReturn == -5)
    {
        sMessage = "��ȣȭ �ؽ� �����Դϴ�.";
    }
    else if( iReturn == -6)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }
    else if( iReturn == -12)
    {
        sMessage = "����Ʈ �н����� �����Դϴ�.";
    }
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
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
    <title>NICE������ - CheckPlus �Ƚɺ������� ����</title>
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