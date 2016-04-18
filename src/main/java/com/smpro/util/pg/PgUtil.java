package com.smpro.util.pg;

import com.smpro.util.Const;
import com.smpro.vo.OrderPayVo;
import com.smpro.vo.OrderVo;

import javax.servlet.http.HttpServletRequest;

public class PgUtil {
	//LG 유플러스
	private Lguplus lguplus = null; 
	
	//KCP
	private Kcp kcp = null; //윈도우
	private KcpLinux kcpLinux = null; //리눅스
	
	//이니시스
	private Inicis inicis = null;

	public PgUtil(String pgCode) {
		if ("lguplus".equals(pgCode)) {
			lguplus = new Lguplus();
		} else if ("kcp".equals(pgCode)) {
			switch (Const.OS) {
			case "window":
				kcp = new Kcp();
				break;
			case "linux":
				kcpLinux = new KcpLinux();
				break;
			default:
				// do nothing
				break;
			}
		} else if(("inicis").equals(pgCode)) {
			inicis = new Inicis();
		}
	}

	/**
	 * 결제
	 * 
	 * @param request
	 * @param calcPayPrice
	 * @return
	 * @throws Exception
	 */
	public OrderPayVo doPay(HttpServletRequest request, int calcPayPrice) throws Exception {
		if (lguplus != null) {
			
			return lguplus.doPay(request, calcPayPrice);
			
		} else if (kcp != null || kcpLinux != null) {
			
			if (kcp != null) {
				return kcp.doPay(request, calcPayPrice);
			}
			
			return kcpLinux.doPay(request, calcPayPrice);

		} else if (inicis != null) {
			OrderVo vo = (OrderVo)request.getSession().getAttribute("orderMain");
			//신용카드 ARS 결제
			if(vo != null && "ARS".equals(vo.getPayMethod())) {
				return inicis.doPayARS(request, calcPayPrice);
			}
			return inicis.doPay(request, calcPayPrice);
			
		} else {
			
			return null;
			
		}
	}

	/**
	 * 결제 실패시 자동 취소
	 * 
	 * @return
	 */
	public OrderPayVo doCancelDirect() {
		if (lguplus != null) {
			
			return lguplus.doCancel();
			
		} else if (kcp != null || kcpLinux != null) {
			
			if (kcp != null) {
				return kcp.doCancel();
			} 
			return kcpLinux.doCancel();
			
		} else if (inicis != null ) {
			
			return inicis.doCancel();
			
		} else {
			
			return null;
			
		}
	}

	/**
	 * 결제 취소
	 * 
	 * @param request
	 * @param vo
	 * @return
	 */
	public OrderPayVo doCancel(HttpServletRequest request, OrderPayVo vo, String taxCode) throws Exception {
		if (lguplus != null) {
			
			if ("linux".equals(Const.OS)) {
				return lguplus.doCancel("/web/out/hknuri/conf/lguplus", vo);
			}
			
			return lguplus.doCancel(request.getSession().getServletContext().getRealPath("/WEB-INF/conf/lguplus"), vo);

		} else if (kcp != null || kcpLinux != null) {
			
			if (kcp != null) {
				return kcp.doCancel(vo, taxCode);
			} 
			return kcpLinux.doCancel(vo, request.getRemoteAddr(), taxCode);
			
		} else if (inicis != null) {
			
			if( "linux".equals(Const.OS) ) {
				return inicis.doCancel("/web/out/hknuri/conf/inicis", vo, taxCode);
		    }
			
			return inicis.doCancel(request.getSession().getServletContext().getRealPath("/WEB-INF/conf/inicis"), vo, taxCode);
			
		} else {
			return null;
		}
	}

	// 특수문자 제거
	public static String escapeCharForKcp(String str) {
		if (str != null) {
			return str.replaceAll("[,&;\\n\\|'\"<]", "");
		}
		return str;
	}
}
