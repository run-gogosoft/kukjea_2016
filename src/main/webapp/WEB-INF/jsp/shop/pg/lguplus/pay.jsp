<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.smpro.util.Const" %>
<%@ page import="com.smpro.util.StringUtil" %>
<%@ page import="com.smpro.vo.MallVo" %>
<%@ page import="com.smpro.vo.OrderVo" %>
<%@ page import="java.security.MessageDigest, java.util.*" %>
<%@ page import="java.security.MessageDigest" %><%

    //쇼핑몰 정보 가져오기
    MallVo mallVo = (MallVo)request.getAttribute("mallVo");

    //주문페이지로부터 넘어온 정보 가져오기
    OrderVo vo = (OrderVo)session.getAttribute("orderMain");
    /*
     * [결제 인증요청 페이지(STEP2-1)]
     *
     * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
     */

    /*
     * 1. 기본결제 인증요청 정보 변경
     *
     * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
     */
    String CST_PLATFORM         = Const.LOCATION;                                                                               //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
    String CST_MID              = "kukjemedi";// : mallVo.getPgCode();                    //LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;                                          //테스트 아이디는 't'를 제외하고 입력하세요.
    //상점아이디(자동생성)
    String LGD_OID              = String.valueOf(vo.getOrderSeq());                                                             //주문번호(상점정의 유니크한 주문번호를 입력하세요)
    String LGD_AMOUNT           = String.valueOf(vo.getPayPrice());                                                             //결제금액("," 를 제외한 결제금액을 입력하세요)
    String LGD_MERTKEY          = "cdca9f29d6411811c53c2887bb94d582" ;//: mallVo.getPgKey(); //상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
    String LGD_BUYER            = vo.getMemberName();                                                                           //구매자명
    String LGD_PRODUCTINFO      = vo.getItemName();                                                                             //상품명
    String LGD_BUYEREMAIL       = vo.getMemberEmail();                                                                           //구매자 이메일
    String LGD_TIMESTAMP        = StringUtil.getDate(0, "yyyyMMddhhmmss");                                                      //타임스탬프
    String LGD_CUSTOM_SKIN      = "red";                                                                                        //상점정의 결제창 스킨(red, purple, yellow)
    String LGD_WINDOW_VER       = "2.5";                                                                                  //구매자 아이디
    String LGD_BUYERID          = vo.getMemberId();                                                                             //구매자 아이디
    String LGD_BUYERIP          = request.getRemoteAddr();


    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
     *
     * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
     *************************************************
     *
     * 해쉬 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : 상점아이디
     * LGD_OID          : 주문번호
     * LGD_AMOUNT       : 금액
     * LGD_TIMESTAMP    : 타임스탬프
     * LGD_MERTKEY      : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
     *
     * MD5 해쉬데이터 암호화 검증을 위해
     * LG유플러스에서 발급한 상점키(MertKey)를 환경설정 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
     */
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - END
     *************************************************
     */


%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <title>LG유플러스 eCredit서비스 결제테스트</title>
    <script type="text/javascript">
        /*
         * 수정불가.
         */
        var LGD_window_type = 'iframe';

        /*
         * 수정불가
         */
        function launchCrossPlatform(){
            lgdwin  = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
        }
        /*
         * FORM 명만  수정 가능
         */
        function getFormObject() {
            return document.getElementById("LGD_PAYINFO");
        }

        /*
         * 인증결과 처리
         */
        function payment_return() {
            var fDoc;
            fDoc = lgdwin.contentWindow || lgdwin.contentDocument;

            if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
                document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
                closeIframe();
                document.getElementById("LGD_PAYINFO").target = "_self";
                document.getElementById("LGD_PAYINFO").action = "/shop/${mallId}/order/result";
                document.getElementById("LGD_PAYINFO").submit();
            } else {
                alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
                closeIframe();
                document.getElementById("LGD_PAYINFO").target = "_self";
                document.getElementById("LGD_PAYINFO").action = "/shop/cart";
                document.getElementById("LGD_PAYINFO").submit();
            }
        }
    </script>
</head>

<body onload="launchCrossPlatform();">
<form method="post" name ="LGD_PAYINFO" id="LGD_PAYINFO" action="/shop/${mallId}/order/result" target="_self">
    <br>
    <input type="hidden" name="CST_PLATFORM"                id="CST_PLATFORM"		value="<%= CST_PLATFORM %>">                   	<!-- 테스트, 서비스 구분 -->
    <input type="hidden" name="CST_MID"                     id="CST_MID"			value="<%= CST_MID %>">                        	<!-- 상점아이디 -->
    <input type="hidden" name="LGD_MID"                     id="LGD_MID"			value="<%= LGD_MID %>">                        	<!-- 상점아이디 -->
    <input type="hidden" name="LGD_OID"                     id="LGD_OID"			value="<%= LGD_OID %>">                        	<!-- 주문번호 -->
    <input type="hidden" name="LGD_BUYER"                   id="LGD_BUYER"			value="<%= LGD_BUYER %>">                      	<!-- 구매자 -->
    <input type="hidden" name="LGD_PRODUCTINFO"             id="LGD_PRODUCTINFO"	value="<%= LGD_PRODUCTINFO %>">                	<!-- 상품정보 -->
    <input type="hidden" name="LGD_AMOUNT"                  id="LGD_AMOUNT"			value="<%= LGD_AMOUNT %>">                     	<!-- 결제금액 -->
    <input type="hidden" name="LGD_BUYEREMAIL"              id="LGD_BUYEREMAIL"		value="<%= LGD_BUYEREMAIL %>">                 	<!-- 구매자 이메일 -->
    <input type="hidden" name="LGD_CUSTOM_SKIN"             id="LGD_CUSTOM_SKIN" 	value="<%= LGD_CUSTOM_SKIN %>">                	<!-- 결제창 SKIN -->
    <input type="hidden" name="LGD_WINDOW_VER"              id="LGD_WINDOW_VER" 	value="<%= LGD_WINDOW_VER %>">                 	<!-- 결제창 버젼정보 -->
    <input type="hidden" name="LGD_CUSTOM_PROCESSTYPE"      id="LGD_CUSTOM_PROCESSTYPE"		value="<%= LGD_CUSTOM_PROCESSTYPE %>"> 	<!-- 트랜잭션 처리방식 -->
    <input type="hidden" name="LGD_TIMESTAMP"               id="LGD_TIMESTAMP"		value="<%= LGD_TIMESTAMP %>">                  	<!-- 타임스탬프 -->
    <input type="hidden" name="LGD_HASHDATA"                id="LGD_HASHDATA"		value="<%= LGD_HASHDATA %>">                   	<!-- MD5 해쉬암호값 -->
    <input type="hidden" name="LGD_PAYKEY"                  id="LGD_PAYKEY">   							   							<!-- LG유플러스 PAYKEY(인증후 자동셋팅)-->
    <input type="hidden" name="LGD_VERSION"         		id="LGD_VERSION"		value="JSP_XPay_2.5">
    <input type="hidden" name="LGD_BUYERIP"                 id="LGD_BUYERIP"		value="<%= LGD_BUYERIP %>">           			<!-- 구매자IP -->
    <input type="hidden" name="LGD_BUYERID"                 id="LGD_BUYERID"		value="<%= LGD_BUYERID %>">
    <input type="hidden" name="LGD_RETURNURL"               id="LGD_RETURNURL"      value="http://localhost:8080/returnurl.jsp<%--= LGD_CASNOTEURL --%>"><!-- 구매자ID -->

    <!-- 주문페이지에서 선택한 결제 수단만 결제 팝업창에 띄우기 -->
    <input type="hidden" name="LGD_CUSTOM_USABLEPAY" id="LGD_CUSTOM_USABLEPAY" value="<%=vo.getPayMethod().replace("CARD","SC0010").replace("RA","SC0030")%>"/>

</form>
</body>
<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript">
</script>
</html>