/* ======================================================================== */
/*  System     : PAY ADAPTER                                                */
/*  Subsystem  : pg - cli                                                   */
/* ------------------------------------------------------------------------ */
/*  File Name  : C_PP_CLI.java                                              */
/*  Desc.      :                                                            */
/* ------------------------------------------------------------------------ */
/*  Copyrights (c) 2004 - 2004   KCP Inc.                                   */
/*  All Rights Reserved.                                                    */
/* ------------------------------------------------------------------------ */
/*  AUTHOR : (01)  2004/04/21   Hyeon-Cheol, Cho   (amoeba@kcp.co.kr)       */
/* ======================================================================== */

package com.kcp;

import java.io.*;
import java.util.*;

public class C_PP_CLI_T {
	/* -------------------------------------------------------------------- */
	/* - 환경 설정 관련 변수 - */
	/* -------------------------------------------------------------------- */
	private boolean m_bSetEnv = false;
	private String m_c_strHomeDir = "";
	private String m_c_strPAURL = "";
	private String m_c_strPAPorts = "";
	private int m_nTxMode = 0;

	/* -------------------------------------------------------------------- */
	/* - 처리 정보 관련 변수 - */
	/* -------------------------------------------------------------------- */
	private String m_c_strSite_CD = "";
	private String m_c_strSite_Key = "";
	private String m_c_strTx_CD = "";
	private String m_c_strOrdr_IDxx = "";
	private String m_c_strPayx_Data = "";
	private String m_c_strOrdr_Data = "";
	private String m_c_strRcvr_Data = "";
	private String m_c_strEscw_Data = "";
	private String m_c_strModx_Data = "";
	private String m_c_strEncData = "";
	private String m_c_strEncInfo = "";
	private String m_c_strTraceNo = "";
	private String m_c_strCust_IP = "";
	private String m_c_strLogLevel = "";
	private String m_c_strOpt = "";
	private int m_nReqDataNo = 0;

	/* -------------------------------------------------------------------- */
	/* - 처리 결과 관련 변수 - */
	/* -------------------------------------------------------------------- */
	private String[][] m_c_straReqData;
	private String[][] m_c_straResData;
	private int m_nResDataCnt = 0;
	public String m_res_cd = "";
	public String m_res_msg = "";
	public String m_res_ShopStatus = "";

	/* -------------------------------------------------------------------- */
	/* - 원시 메소드 선언 - */
	/* -------------------------------------------------------------------- */
	/*
	 * native byte[] mf_PAYPLUS_DL__do_tx( String parm_c_strHomeDir, String
	 * parm_c_strSiteID, String parm_c_strTxCD, String parm_c_strSiteKey, String
	 * parm_c_strPubKey, String parm_c_strKCPPGSvr, int parm_nKCPPGPort, byte[]
	 * parm_c_strOrdr_IDxx, byte[] parm_c_strEncData, byte[] parm_c_strComData,
	 * int parm_nLogLevel, int parm_nOpt );
	 */

	public void mf_init(String parm_c_strHomeDir, String parm_c_strPAURL,
			String parm_c_strPAPorts, int parm_nTxMode) {
		this.m_bSetEnv = true;

		this.m_c_strHomeDir = parm_c_strHomeDir;
		this.m_c_strPAURL = parm_c_strPAURL;
		this.m_c_strPAPorts = parm_c_strPAPorts;
		this.m_nTxMode = parm_nTxMode;
	}

	public void mf_init_set() {
		try {
			int nInx;

			this.m_c_straReqData = new String[20][2];

			for (nInx = 0; nInx < 20; nInx++) {
				this.m_c_straReqData[nInx][0] = "";
				this.m_c_straReqData[nInx][1] = "";
			}

			this.m_nReqDataNo = 0;

			this.m_c_strEncData = "";
			this.m_c_strEncInfo = "";
		} catch (Exception e) {
			this.m_res_cd = "S301";
			this.m_res_msg = "요청 정보 저장 BUFFER 생성 오류 : " + e;
		}
		/*
		 * finally { }
		 */
	}

	public int mf_add_set(String parm_c_strName) {
		int nInx;

		for (nInx = 0; nInx < this.m_nReqDataNo; nInx++) {
			if (this.m_c_straReqData[nInx][0].equals(parm_c_strName)) {
				break;
			}
		}

		if (nInx == this.m_nReqDataNo) {
			this.m_c_straReqData[nInx][0] = parm_c_strName;

			this.m_nReqDataNo++;
		}

		return nInx;
	}

	public void mf_set_us(int parm_nSetNo, String parm_c_strName,
			String parm_c_strVal) {
		if (parm_c_strVal != null && parm_c_strVal.length() != 0) {
			this.m_c_straReqData[parm_nSetNo][1] += (parm_c_strName + "="
					+ parm_c_strVal + String.valueOf((char) 0x1f));
		}
	}

	public void mf_set_gs(int parm_nSetNo, String parm_c_strName,
			String parm_c_strVal) {
		if (parm_c_strVal != null && parm_c_strVal.length() != 0) {
			this.m_c_straReqData[parm_nSetNo][1] += (parm_c_strName + "="
					+ parm_c_strVal + String.valueOf((char) 0x1d));
		}
	}

	public void mf_set_enc_data(String parm_c_strEncData,
			String parm_c_strEncInfo) {
		this.m_c_strEncData = parm_c_strEncData;
		this.m_c_strEncInfo = parm_c_strEncInfo;
	}

	public void mf_set_trace_no(String parm_c_strTraceNo) {
		this.m_c_strTraceNo = parm_c_strTraceNo;
	}

	public void mf_add_rs(int parm_nNameSetNo, int parm_nValSetNo) {
		this.m_c_straReqData[parm_nNameSetNo][1] += (this.m_c_straReqData[parm_nValSetNo][0]
				+ "=" + this.m_c_straReqData[parm_nValSetNo][1] + String
				.valueOf((char) 0x1e));
	}

	public void mf_do_tx(String parm_c_strSite_CD, String parm_c_strSite_Key,
			String parm_c_strTx_CD, String parm_c_strCust_IP,
			String parm_c_strOrdr_IDxx, String parm_c_strLogLevel,
			String parm_c_strOpt) {
		String c_strResData = "";
		int nResDataLen;
		int nStrInx;
		int nInx;
		boolean bCont = true;

		if (this.m_bSetEnv == true) {
			this.m_c_strSite_CD = parm_c_strSite_CD;
			this.m_c_strSite_Key = parm_c_strSite_Key;
			this.m_c_strTx_CD = parm_c_strTx_CD;
			this.m_c_strCust_IP = parm_c_strCust_IP;
			this.m_c_strOrdr_IDxx = parm_c_strOrdr_IDxx;
			this.m_c_strLogLevel = parm_c_strLogLevel;
			this.m_c_strOpt = parm_c_strOpt;

			this.m_c_strPayx_Data = cf_set_tx_data("payx_data");
			this.m_c_strOrdr_Data = cf_set_tx_data("ordr_data");
			this.m_c_strRcvr_Data = cf_set_tx_data("rcvr_data");
			this.m_c_strEscw_Data = cf_set_tx_data("escw_data");
			this.m_c_strModx_Data = cf_set_tx_data("mod_data");

			if (this.m_nTxMode == 1) {
				/*
				 * c_strResData = cf_PAYPLUS__do_tx_lib( parm_c_strTxCD,
				 * parm_c_strOrdr_IDxx, parm_nLogLevel, parm_nOpt );
				 */
			} else {
				c_strResData = cf_do_tx_exe();
			}
		} else {
			c_strResData = "res_cd=9551" + String.valueOf((char) 0x1f)
					+ "res_msg=초기화 함수를 호출하지 않았습니다.";
		}

		if (c_strResData == null) {
			c_strResData = "ABCD";
		}

		nResDataLen = c_strResData.length();

		for (nInx = 0, this.m_nResDataCnt = 1; nInx < nResDataLen; nInx++) {
			if (c_strResData.charAt(nInx) == (char) 0x1f) {
				this.m_nResDataCnt++;
			}
		}

		try {
			this.m_c_straResData = new String[this.m_nResDataCnt][2];
		} catch (Exception e) {
			bCont = false;

			this.m_res_cd = "9552";
			this.m_res_msg = "결과값 저장 BUFFER 생성 오류 : " + e;
			this.m_nResDataCnt = 0;
		}
		/*
		 * finally { }
		 */

		if (bCont == true) {
			try {
				StringTokenizer c_Token = new StringTokenizer(c_strResData,
						String.valueOf((char) 0x1f));
				String c_strTmp = "";

				for (nInx = 0; nInx < this.m_nResDataCnt
						&& c_Token.hasMoreTokens(); nInx++) {
					c_strTmp = c_Token.nextToken();

					nStrInx = c_strTmp.indexOf("=");

					if (nStrInx > -1) {
						this.m_c_straResData[nInx][0] = c_strTmp.substring(0,
								nStrInx);
						this.m_c_straResData[nInx][1] = c_strTmp
								.substring(nStrInx + 1);

						if (this.m_c_straResData[nInx][0].equals("res_cd")) {
							this.m_res_cd = this.m_c_straResData[nInx][1];
						} else if (this.m_c_straResData[nInx][0]
								.equals("res_msg")) {
							this.m_res_msg = this.m_c_straResData[nInx][1];
						} else if (m_c_straResData[nInx][0]
								.equals("shop_status")) {
							m_res_ShopStatus = m_c_straResData[nInx][1];
						}
					} else {
						this.m_c_straResData[nInx][0] = c_strTmp;
						this.m_c_straResData[nInx][1] = "";
					}
				}

				if (nInx == 0)
					this.m_nResDataCnt = 0;
			} catch (Exception e) {
				bCont = false;

				this.m_res_cd = "9553";
				this.m_res_msg = "결과 DATA 오류 : " + e;
				this.m_nResDataCnt = 0;
			}
			/*
			 * finally { }
			 */
		}
	}

	public String mf_get_res(String parm_c_strName) {
		String c_strRT = "";
		int nInx;

		for (nInx = 0; nInx < this.m_nResDataCnt; nInx++) {
			if (this.m_c_straResData[nInx][0].equals(parm_c_strName)) {
				c_strRT = this.m_c_straResData[nInx][1];

				break;
			}
		}

		// ////////////////////////////////////////////////////////////////////////////////
		if (nInx == this.m_nResDataCnt) {
			if (parm_c_strName.equals("res_cd")) {
				c_strRT = this.m_res_cd;
			} else if (parm_c_strName.equals("res_msg")) {
				c_strRT = this.m_res_msg;
			}
		}
		// ////////////////////////////////////////////////////////////////////////////////

		return c_strRT;
	}

	private String cf_set_tx_data(String parm_c_strDataName) {
		int nInx;

		for (nInx = 0; nInx < 20; nInx++) {
			if (this.m_c_straReqData[nInx][0].equals(parm_c_strDataName)) {
				return parm_c_strDataName + "=" + this.m_c_straReqData[nInx][1];
			}
		}

		return "";
	}

	private String cf_do_tx_exe() {
		BufferedReader c_ExecOut;
		Process c_Proc;
		String[] c_straCmd;
		String c_strRT = "";
		// boolean bCont = true;

		try {
			String c_strTmp;

			c_straCmd = new String[] {
					this.m_c_strHomeDir + "/bin/pp_cli",
					"-h",
					"home=" + this.m_c_strHomeDir + "," + "site_cd="
							+ this.m_c_strSite_CD + "," + "site_key="
							+ this.m_c_strSite_Key + "," + "tx_cd="
							+ this.m_c_strTx_CD + "," + "pa_url="
							+ this.m_c_strPAURL + "," + "pa_port="
							+ this.m_c_strPAPorts + "," + "ordr_idxx="
							+ this.m_c_strOrdr_IDxx + "," + "payx_data="
							+ this.m_c_strPayx_Data + "," + "ordr_data="
							+ this.m_c_strOrdr_Data + "," + "rcvr_data="
							+ this.m_c_strRcvr_Data + "," + "escw_data="
							+ this.m_c_strEscw_Data + "," + "modx_data="
							+ this.m_c_strModx_Data + "," + "enc_data="
							+ this.m_c_strEncData + "," + "enc_info="
							+ this.m_c_strEncInfo + "," + "trace_no="
							+ this.m_c_strTraceNo + "," + "cust_ip="
							+ this.m_c_strCust_IP + "," + "log_level="
							+ this.m_c_strLogLevel + "," + "opt="
							+ this.m_c_strOpt + "" };

			c_Proc = Runtime.getRuntime().exec(c_straCmd);

			c_ExecOut = new BufferedReader(new InputStreamReader(
					c_Proc.getInputStream(), "EUC-KR"));

			while ((c_strTmp = c_ExecOut.readLine()) != null) {
				c_strRT += c_strTmp;
			}
		} catch (Exception e) {
			// bCont = false;

			c_strRT = "res_cd=S102" + String.valueOf((char) 0x1f)
					+ "res_msg=연동 모듈 실행 오류 : " + getStackTrace(e);
		}
		/*
		 * finally { }
		 */

		return c_strRT;
	}

	public static String getStackTrace(Throwable aeRcv) {
		ByteArrayOutputStream oBOS = null;
		PrintWriter oPW = null;

		if (aeRcv == null) {
			return "";
		}

		oBOS = new ByteArrayOutputStream();
		oPW = new PrintWriter(oBOS);
		aeRcv.printStackTrace(oPW);
		oPW.flush();

		return oBOS.toString();
	}
}
