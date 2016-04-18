package com.smpro.util.pg;

import com.inicis.inipay.INIpay50;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.OrderPayVo;
import com.smpro.vo.OrderVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Inicis {
	private static final Logger LOGGER = LoggerFactory.getLogger(Inicis.class);
	
	private INIpay50 inipay = null;
	
	public Inicis() {
		// 결제 모듈 인스턴스 생성
		inipay = new INIpay50();
	}

	//이니시스 PG 결제
	public OrderPayVo doPay(HttpServletRequest request, int calcPayPrice) {
		HttpSession session = request.getSession();
		//지불 정보 설정
		if( "linux".equals(Const.OS) ) {
	    	inipay.SetField("inipayhome", "/web/out/hknuri/conf/inicis"); // 이니페이 홈디렉터리(상점수정 필요)
	    } else {
	    	inipay.SetField("inipayhome", session.getServletContext().getRealPath("/WEB-INF/conf/inicis")); // 이니페이 홈디렉터리(상점수정 필요)
	    }
		 
		inipay.SetField("type", "securepay");  // 고정 (절대 수정 불가)
		inipay.SetField("admin", session.getAttribute("admin"));  // 키패스워드(상점아이디에 따라 변경)
		//***********************************************************************************************************
		//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
		//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
		//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
		//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
		//***********************************************************************************************************
		inipay.SetField("debug", "true");  // 로그모드("true"로 설정하면 상세로그가 생성됨.)
		inipay.SetField("crypto", "execure");	// Extrus 암호화모듈 사용(고정)
		
		inipay.SetField("uid", request.getParameter("uid") );  // INIpay User ID (절대 수정 불가)
		inipay.SetField("oid", request.getParameter("oid") );  // 상품명 
		inipay.SetField("goodname", request.getParameter("goodname") );  // 상품명 
		inipay.SetField("currency", request.getParameter("currency") );  // 화폐단위
		
		inipay.SetField("mid", session.getAttribute("INI_MID") );  // 상점아이디
		inipay.SetField("enctype", session.getAttribute("INI_ENCTYPE") );  //웹페이지 위변조용 암호화 정보
		inipay.SetField("rn", session.getAttribute("INI_RN") );  //웹페이지 위변조용 RN값
		inipay.SetField("price", String.valueOf(calcPayPrice));  //가격

		/**---------------------------------------------------------------------------------------
		 * price 등의 중요데이터는
		 * 브라우저상의 위변조여부를 반드시 확인하셔야 합니다.
		 *
		 * 결제 요청페이지에서 요청된 금액과
		 * 실제 결제가 이루어질 금액을 반드시 비교하여 처리하십시오.
		 *
		 * 설치 메뉴얼 2장의 결제 처리페이지 작성부분의 보안경고 부분을 확인하시기 바랍니다.
		 * 적용참조문서: 이니시스홈페이지->가맹점기술지원자료실->기타자료실 의
		 *              '결제 처리 페이지 상에 결제 금액 변조 유무에 대한 체크' 문서를 참조하시기 바랍니다.
		 * 예제)
		 * 원 상품 가격 변수를 OriginalPrice 하고  원 가격 정보를 리턴하는 함수를 Return_OrgPrice()라 가정하면
		 * 다음 같이 적용하여 원가격과 웹브라우저에서 Post되어 넘어온 가격을 비교 한다.
		 *
		   String originalPrice = merchant.getOriginalPrice();
		   String postPrice = inipay.GetResult("price"); 
		   if ( originalPrice != postPrice )
		   {
			//결제 진행을 중단하고  금액 변경 가능성에 대한 메시지 출력 처리
			//처리 종료 
			}
		---------------------------------------------------------------------------------------**/

		inipay.SetField("paymethod", request.getParameter("paymethod") );  // 지불방법 (절대 수정 불가)
		inipay.SetField("encrypted", request.getParameter("encrypted") );  // 암호문
		inipay.SetField("sessionkey",request.getParameter("sessionkey") ); // 암호문
		inipay.SetField("buyername", request.getParameter("buyername") );  // 구매자 명
		inipay.SetField("buyertel", request.getParameter("buyertel") );	   // 구매자 연락처(휴대폰 번호 또는 유선전화번호)
		inipay.SetField("buyeremail",request.getParameter("buyeremail") ); // 구매자 이메일 주소
		inipay.SetField("url", "http://www.hknuri.co.kr" ); 	       	   // 실제 서비스되는 상점 SITE URL로 변경할것
		inipay.SetField("cardcode", request.getParameter("cardcode") );    // 카드코드 리턴
		inipay.SetField("parentemail", request.getParameter("parentemail") ); 			    // 보호자 이메일 주소(핸드폰 , 전화결제시에 14세 미만의 고객이 결제하면  부모 이메일로 결제 내용통보 의무, 다른결제 수단 사용시에 삭제 가능)
		
		/*-----------------------------------------------------------------*
		 * 수취인 정보 *                                                   *
		 *-----------------------------------------------------------------*
		 * 실물배송을 하는 상점의 경우에 사용되는 필드들이며               		
		 * 아래의 값들은 INIsecurestart.jsp 페이지에서 포스트 되도록       
		 * 필드를 만들어 주도록 하십시요.                             
		 * 컨텐츠 제공업체의 경우 삭제하셔도 무방합니다.                 
		 *-----------------------------------------------------------------*/
		inipay.SetField("recvname",request.getParameter("recvname") );	// 수취인 명
		inipay.SetField("recvtel",request.getParameter("recvtel") );		// 수취인 연락처
		inipay.SetField("recvaddr",request.getParameter("recvaddr") );	// 수취인 주소
		inipay.SetField("recvpostnum",request.getParameter("recvpostnum") );  // 수취인 우편번호
		inipay.SetField("recvmsg",request.getParameter("recvmsg") );		// 전달 메세지
		
		inipay.SetField("joincard",request.getParameter("joincard") );        // 제휴카드코드
		inipay.SetField("joinexpire",request.getParameter("joinexpire") );    // 제휴카드유효기간
		inipay.SetField("id_customer",request.getParameter("id_customer") );  // 일반적인 경우 사용하지 않음, user_id

		/* 면/과세 금액 구분 */
		int taxFreeAmt = Integer.parseInt(String.valueOf(request.getAttribute("taxFreeAmt"))); 		//면세금액		
		inipay.SetXPath("INIpay/GoodsInfo/Tax", String.valueOf(calcVat(calcPayPrice, taxFreeAmt))); //부가세
		inipay.SetXPath("INIpay/GoodsInfo/TaxFree", String.valueOf(taxFreeAmt));
		
		inipay.SetField("taxFreeAmt", String.valueOf(taxFreeAmt));
		//지불 요청
		inipay.startAction();
				
		return getOrderPayVo();
	}
	
	//이니시스 ARS 결제
	public OrderPayVo doPayARS(HttpServletRequest request, int calcPayPrice) {
		HttpSession session = request.getSession();
		OrderVo vo = (OrderVo)session.getAttribute("orderMain");
//
//		INIars iniars = new INIars();
//
//		//지불 정보 설정
//		if( "linux".equals(Const.OS) ) {
//			iniars.setField("inipayhome", "/web/out/hknuri/conf/inicis"); // 이니페이 홈디렉터리(상점수정 필요)
//	    } else {
//	    	iniars.setField("inipayhome", session.getServletContext().getRealPath("/WEB-INF/conf/inicis")); // 이니페이 홈디렉터리(상점수정 필요)
//	    }
//
//		iniars.setField("mid", "happyitARS");        				//상점마다 부여 받은 상점 ID를 입력(중요)
//		iniars.setField("key", "nUQ2JsupAk2BbCKpgocLYw==");			//상점 마다 부여 받은 상점 Key를 입력(중요)
//		iniars.setField("oid", String.valueOf(vo.getOrderSeq()));	//주문 번호
//		iniars.setField("buyername", vo.getMemberName());			//구매자 이름
//		iniars.setField("goodsname", vo.getItemName());				//상품명
//		iniars.setField("price", String.valueOf(calcPayPrice));		//가격
//		iniars.setField("mername", "함께누리몰");					//상점 이름
//		iniars.setField("buyertel", vo.getMemberCell());			//구매자 전화번호
//		iniars.setField("buyerhpp", vo.getMemberCell());			//구매자 핸드폰 번호(SMS 수신)
//		iniars.setField("buyeremail", vo.getMemberEmail());  		//구매자 이메일
//		iniars.setField("arstel", "02-2222-3896");					//ARS 또는 상담원 전화 번호
//		iniars.setField("reqtype", "SMS");							//SMS 접수 여부
//
//		/* 면/과세 금액 구분 */
//		int taxFreeAmt = Integer.parseInt(String.valueOf(request.getAttribute("taxFreeAmt")));
//		iniars.setField("tax", String.valueOf(calcVat(calcPayPrice, taxFreeAmt)));				//과세 금액 설정(부가세?)
//		iniars.setField("taxfree", String.valueOf(taxFreeAmt));        							//면세 금액 설정
//
//		iniars.setField("uip", request.getRemoteAddr());					//클라이언트 접속 IP
//		iniars.setField("debug", "true");                                   //상세 로그 출력
//		iniars.setField("paymethod", "Card");								//지불 방법("Card":고정)
//		iniars.setField("type", "arscard");									//서비스 타입(“arscard”:고정)
//
//		//iniars.setField("test", "true");									//실제 반영시 해당 설정을 반드시 삭제
//
//		//호전환 요청
//		iniars.startAction();
//
//		//호전환 요청 결과 확인
//		String ResultCode 	= iniars.getResult("ResultCode");
//		String ResultMsg	= iniars.getResult("ResultMsg");
//		String tid 			= iniars.getResult("tid");
//
//		LOGGER.info("TID : " + tid);
//		LOGGER.info("ResultCode : " + ResultCode);
//		LOGGER.info("ResultMsg  : " + ResultMsg);
//
//		return getOrderPayVo(iniars);
		return null;
	}

	// 이니시스 PG 결제 자동 취소
	public OrderPayVo doCancel() {
		inipay.SetField("type", "cancel");
		inipay.SetField("tid", inipay.GetResult("tid"));
		inipay.SetField("cancelmsg", "주문 DB 처리 실패");   // 취소사유
		
		inipay.startAction();
		return getOrderPayVoCancel();
	}

	// 이니시스 PG 결제 취소
	public OrderPayVo doCancel(String configPath, OrderPayVo vo, String taxCode) throws Exception {
		//취소 정보 설정 *
		inipay.SetField("inipayhome", configPath);  // 이니페이 홈디렉터리(상점수정 필요)
		inipay.SetField("debug", "true");           // 로그모드("true"로 설정하면 상세로그가 생성됨.)
		inipay.SetField("mid", vo.getMid());        // 상점아이디
		inipay.SetField("admin", "1111");           //상점 키패스워드 (비대칭키)
		//inipay.SetField("cancelreason", request.getParameter("cancelreason") );   // 현금영수증 취소코드
		//***********************************************************************************************************
		//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
		//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
		//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
		//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
		//***********************************************************************************************************
		
		inipay.SetField("cancelmsg", "고객 요청에 의한 취소" );		// 취소사유
		inipay.SetField("crypto", "execure");						// Extrus 암호화모듈 사용(고정)

		if (vo.getPartCancelAmt() > 0) {
			//부분취소
			inipay.SetField("type", "repay");   										// 고정 (절대 수정 불가)
			inipay.SetField("oldtid"       , vo.getTid());								// 취소할 거래의 거래아이디
			inipay.SetField("currency"     , "WON");									// 화폐단위
			inipay.SetField("price"        , String.valueOf(vo.getPartCancelAmt()));	// 취소금액
			inipay.SetField("confirm_price", String.valueOf(vo.getCurAmount()-vo.getPartCancelAmt())); 		// 승인요청금액
			//inipay.SetField("buyeremail"   , request.getParameter("buyeremail"));    	// 구매자 이메일 주소
			//inipay.SetField("no_acct"      , request.getParameter("no_acct"));       	// 국민은행 부분취소 환불계좌번호
			//inipay.SetField("nm_acct"      , request.getParameter("nm_acct"));       	// 국민은행 부분취소 환불계좌주명
			
			LOGGER.info("### 부분취소 금액 : " + vo.getPartCancelAmt());
			LOGGER.info("### 잔여 금액 : " + vo.getCurAmount());
			
			//면/과세 여부에 따라 분기하여 처리한다.
			if ("1".equals(taxCode)) {
				//과세대상 부분취소
				int supplyPrice = (int)(Math.ceil((vo.getPartCancelAmt()) / 1.1)); //공급가
				int vat = vo.getPartCancelAmt() - supplyPrice; //부가세
				
				inipay.SetField("tax"      , String.valueOf(vat));	// 부가세
				inipay.SetField("tax_free" , "0");       			// 비과세
			} else {		
				//면세대상 부분취소
				inipay.SetField("tax"      , "0");	// 부가세
				inipay.SetField("tax_free" , String.valueOf(vo.getPartCancelAmt()));  // 비과세
			}

		} else {
			//전체취소
			inipay.SetField("type", "cancel");   // 고정 (절대 수정 불가)
			inipay.SetField("tid", vo.getTid()); // 취소할 거래의 거래아이디
		}

		  
		//취소 요청
		inipay.startAction();

		/****************************************************************
		 * 취소 결과
		 *
		 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 취소 성공)
		 * 결과내용 : inipay.GetResult("ResultMsg") (취소결과에 대한 설명)
		 * 취소날짜 : inipay.GetResult("CancelDate") (YYYYMMDD)
		 * 취소시각 : inipay.GetResult("CancelTime") (HHMMSS)
		 * 현금영수증 취소 승인번호 : inipay.GetResult("CSHR_CancelNum")
		 * (현금영수증 발급 취소시에만 리턴됨)
		 ****************************************************************/
		
		LOGGER.info("### 이니시스 취소 처리 결과 코드 : " + inipay.GetResult("ResultCode"));
		LOGGER.info("### 이니시스 취소 처리 결과 메세지 : " + inipay.GetResult("ResultMsg"));
		
		if ("00".equals(inipay.GetResult("ResultCode"))) {
			LOGGER.info("### 결제 취소요청이 완료되었습니다");
		} else {
			LOGGER.info("### 결제 취소요청이 실패하였습니다.");
			throw new Exception("결제 요청에 실패하였습니다.[" + inipay.GetResult("ResultCode") + ": " + inipay.GetResult("ResultMsg") + "]");
		}

		return getOrderPayVoCancel(vo);
	}

	// 결제 결과 맵핑
	private OrderPayVo getOrderPayVo() {
		OrderPayVo vo = new OrderPayVo();
		if (!StringUtil.isBlank(inipay.GetResult("MOID"))) {
			vo.setOrderSeq(Integer.valueOf(inipay.GetResult("MOID")));
		}
		vo.setTid(inipay.GetResult("tid"));
		vo.setOid(inipay.GetResult("MOID"));
		vo.setMid(inipay.GetResult("mid"));
		//vo.setPgKey("");
		vo.setResultCode(inipay.GetResult("ResultCode"));
		vo.setResultMsg(inipay.GetResult("ResultMsg"));
		if (!StringUtil.isBlank(inipay.GetResult("TotPrice"))) {
			vo.setAmount(Integer.parseInt(inipay.GetResult("TotPrice")));
		}
		// 면세 대상 금액 저장
		vo.setTaxFreeAmount(Integer.parseInt(inipay.GetResult("taxFreeAmt")));

		vo.setMethodCode(inipay.GetResult("PayMethod"));
		vo.setOrgCode(inipay.GetResult("CARD_Code"));
		vo.setOrgName("");
		vo.setEscrowFlag("N");
		vo.setApprovalNo(inipay.GetResult("ApplNum"));
		vo.setCardMonth(inipay.GetResult("CARD_Quota"));
		String interestFlag = "Y";
		if ("1".equals(inipay.GetResult("CARD_Interest"))) {
			// 무이자 설정
			interestFlag = "N";
		}
		vo.setInterestFlag(interestFlag);
		vo.setCashReceiptTypeCode(inipay.GetResult("CSHR_Type"));
		//vo.setCashReceiptNo("");
		vo.setAccountNo(inipay.GetResult("VACT_Num"));
		vo.setTransDate(inipay.GetResult("ApplDate")+inipay.GetResult("ApplTime"));
		vo.setPgCode("inicis");

		// 처리결과 여부 저장
		if ("00".equals(inipay.GetResult("ResultCode"))) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}
	
	// ARS 결제요청 결과 맵핑 ARS
//	private OrderPayVo getOrderPayVo(INIars iniars) {
//		OrderPayVo vo = new OrderPayVo();
//
//		if (!StringUtil.isBlank(iniars.getResult("oid"))) {
//			vo.setOrderSeq(Integer.valueOf(iniars.getResult("oid")));
//		}
//
//		vo.setTid(iniars.getResult("tid"));
//
//		vo.setResultCode(iniars.getResult("ResultCode"));
//		vo.setResultMsg(iniars.getResult("ResultMsg"));
//
//		if (!StringUtil.isBlank(iniars.getResult("price"))) {
//			vo.setAmount(Integer.parseInt(iniars.getResult("price")));
//		}
//
//		// 면세 대상 금액 저장
//		vo.setTaxFreeAmount(Integer.parseInt(iniars.getResult("taxfree")));
//
//		vo.setMethodCode(iniars.getResult("paymethod"));
//		vo.setEscrowFlag("N");
//		vo.setInterestFlag("Y");
//
//		vo.setPgCode("inicis");
//
//		// 처리결과 여부 저장
//		if ("00".equals(vo.getResultCode())) {
//			vo.setResultFlag("Y"); // 정상
//		} else {
//			vo.setResultFlag("N"); // 실패
//		}
//
//		return vo;
//	}
	
	// 결제 자동 취소 처리 결과 맵핑
	private OrderPayVo getOrderPayVoCancel() {
		OrderPayVo vo = new OrderPayVo();
		vo.setResultCode(inipay.GetResult("ResultCode"));
		vo.setResultMsg(inipay.GetResult("ResultMsg"));
		// 처리결과 여부 저장
		if ("00".equals(inipay.GetResult("ResultCode"))) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}

	// 결제 취소 처리 결과 맵핑
	private OrderPayVo getOrderPayVoCancel(OrderPayVo payVo) {
		OrderPayVo vo = new OrderPayVo();
		vo.setOrderPaySeq(payVo.getSeq());
		if (payVo.getPartCancelAmt() > 0) {
			// 부분취소금액, 상품주문번호 저장
			vo.setTypeCode("PART");
			vo.setAmount(payVo.getPartCancelAmt());
			vo.setOrderDetailSeq(payVo.getOrderDetailSeq());
		} else {
			// 전체취소금액 저장
			vo.setTypeCode("ALL");
			vo.setAmount(payVo.getAmount());
			vo.setOrderDetailSeq(null);
		}
		vo.setResultCode(inipay.GetResult("ResultCode"));
		vo.setResultMsg(inipay.GetResult("ResultMsg"));

		// 처리결과 여부 저장
		if ("00".equals(inipay.GetResult("ResultCode"))) {
			vo.setResultFlag("Y"); // 정상
		} else {
			vo.setResultFlag("N"); // 실패
		}

		return vo;
	}
	
	//부가세 계산
	private int calcVat(int calcPayPrice, int taxFreeAmtArg) {
		int vat  = 0; //부가세
		int taxAmt = 0;  	   //과세금액
		int taxAmtSupply  = 0; //과세 공급가액
		int taxFreeAmt = taxFreeAmtArg;
		if(calcPayPrice < taxFreeAmt) {
			taxFreeAmt = calcPayPrice; //면세금액이 결제금액보다 클경우 최대 금액을 결제금액으로 설정한다.
		}
		
		taxAmt = calcPayPrice - taxFreeAmt;
		if(taxAmt > 0) {
			taxAmtSupply = (int)(Math.ceil((taxAmt) / 1.1));
			vat = taxAmt - taxAmtSupply;
		}
		
		return vat;
	}

}
