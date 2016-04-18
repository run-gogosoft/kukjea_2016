<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

    String sSiteCode = "G6121";						// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "A2HA3DK88ZQ9";				// NICE�κ��� �ο����� ����Ʈ �н�����

    String sCipherTime = "";					// ��ȣȭ�� �ð�
    String sRequestNumber = "";				// ��û ��ȣ
    String sErrorCode = "";						// ���� ����ڵ�
    String sAuthType = "";						// ���� ����
    String sMessage = "";
    String sPlainData = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();

        // ����Ÿ�� �����մϴ�.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber 	= (String)mapresult.get("REQ_SEQ");
        sErrorCode 			= (String)mapresult.get("ERR_CODE");
        sAuthType 			= (String)mapresult.get("AUTH_TYPE");

        //�Բ��������� ��û���� ���� ���� ���� �ڵ带 �����.(�Ŀ� ��å�� ���Ҽ��� �����Ƿ� ����ϱ� ������ �ּ�ó�� �Ѵ�.)
        //sMessage = "������ �����Ͽ����ϴ�.[sErrorCode: "+sErrorCode+"]";
        sMessage = "������ �����Ͽ����ϴ�.";
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
        //�Բ��������� ��û���� ���� ���� ���� �ڵ带 �����.(�Ŀ� ��å�� ���Ҽ��� �����Ƿ� ����ϱ� ������ �ּ�ó�� �Ѵ�.)
        //sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
        sMessage = "�˼� ���� ���� �Դϴ�.";
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

			alert(rsltMsg);
			window.close();
		}
	</script>
</head>
<body onload="alertMsg('<%= iReturn %>','<%= sMessage %>')">

</body>
</html>