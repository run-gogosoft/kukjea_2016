<%@page language="java" contentType="text/html;charset=utf-8" %>
<%@page import="com.inicis.inipay.ars.*"%>
<%
	request.setCharacterEncoding("utf-8");
	INIars iniars = new INIars();
	String mid = "happyicARS";
	String key = "Sfz0CTPT9Lq+hqJP9pdLZQ==";
	/* if("nc3tc02000".equals(mid))
	{
		key = "QCMhJEAjJCUkI0AjISQjQA==";
	}
	else if("test001012".equals(mid))
	{
		key = "3Fw5KzN0co2CWgwUFz/rQg==";
	}
	else if("test001013".equals(mid))
	{
		key = "3Fw5KzN0co2CWgwUFz/rQg==";
	} */
	//중요:상점마다 부여받는 키를 입력 합니다.
	//ARS 카드 결제 접수 요청 필드 세팅
	iniars.setField("inipayhome", session.getServletContext().getRealPath("/pg/inicis/sample"));      	//상점 수정 필요(설치 절대 경로)
	iniars.setField("mid", mid);        		//상점마다 부여 받은 상점 ID를 입력(중요)
	iniars.setField("key", key);        								//상점 마다 부여 받은 상점 Key를 입력(중요)
	iniars.setField("oid", request.getParameter("oid"));				//주문 번호
	iniars.setField("buyername", request.getParameter("buyername"));	//구매자 이름
	iniars.setField("goodsname", request.getParameter("goodsname"));	//상품명  
	iniars.setField("price", request.getParameter("price"));			//가격
	iniars.setField("mername", request.getParameter("mername"));		//상점 이름
	iniars.setField("buyertel", request.getParameter("buyertel"));		//구매자 전화번호
	iniars.setField("buyerhpp", request.getParameter("buyerhpp"));		//구매자 핸드폰 번호(SMS 수신)
	iniars.setField("buyeremail", request.getParameter("buyeremail"));  //구매자 이메일
	iniars.setField("arstel", request.getParameter("arstel"));			//ARS 또는 상담원 전화 번호
	iniars.setField("reqtype", request.getParameter("reqtype"));		//SMS 접수 여부	
	iniars.setField("tax", request.getParameter("tax"));				//과세 금액 설정
	iniars.setField("taxfree", request.getParameter("taxfree"));        //과세 금액 설정
	iniars.setField("uip", request.getRemoteAddr());					//클라이언트 접속 IP
	iniars.setField("debug", "true");                                   //상세 로그 출력
	iniars.setField("paymethod", "Card");								//지불 방법("Card":고정)
	iniars.setField("type", "arscard");									//서비스 타입(“arscard”:고정)

	//iniars.setField("test", "true");									//실제 반영시 해당 설정을 반드시 삭제

	//호전환 요청
	iniars.startAction();

	//호전환 요청 결과 확인
	String ResultCode 	= iniars.getResult("ResultCode");
	String ResultMsg	= iniars.getResult("ResultMsg");
	String tid 			= iniars.getResult("tid");
	
	out.println("test");
	out.println("TID : " + tid + "<br>");
	out.println("ResultCode : " + ResultCode + "<br>");
	out.println("ResultMsg  : " + ResultMsg + "<br>");
%>

