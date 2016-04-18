package com.smpro.util;

import java.io.*;
import java.net.*;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileDownloadUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(FileDownloadUtil.class);
	
	private static final int BUFFER_SIZE = 8192;
		
	public static boolean chkDelivComplete(Integer deliSeq, String deliNo, String trackUrl, String completeMsg) throws Exception {
		boolean rval = false;

		// html reading
		URL u;
		HttpURLConnection httpConnection = null;
		String line, content = "";
		BufferedReader reader = null;

		String enCoder = "EUC-KR";
		//UTF-8 통신 택배사
		if (deliSeq.intValue() == 1 || deliSeq.intValue() == 6 || deliSeq.intValue() == 5 || deliSeq.intValue() == 9 || deliSeq.intValue() == 12 || deliSeq.intValue() == 15 || deliSeq.intValue() == 16 || deliSeq.intValue() == 20) {
			enCoder = "UTF-8";
		}

		try {
			String httpTrackUrl = StringUtil.restoreClearXSS(trackUrl) + deliNo;
			//CJ대한통운은 https 접속 오류로 무조건 http로 접속한다.
			if(deliSeq.intValue() == 1 || deliSeq.intValue() == 6) {
				httpTrackUrl = httpTrackUrl.replace("https://", "http://");
			}
			
			u = new URL(httpTrackUrl);

			httpConnection = (HttpURLConnection) u.openConnection();

			httpConnection.setReadTimeout(10000);

			if (httpConnection.getResponseCode() == 200) {

				reader = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), enCoder));

				while ((line = reader.readLine()) != null) {
					content += line + "\n";
				}
				reader.close();
				LOGGER.debug(content);

				if (content.indexOf(completeMsg) > -1) {
					rval = true;
				}

			} else {
				LOGGER.error("httpConnection Error: "	+ httpConnection.getResponseCode());
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			throw new Exception("통신중 오류가 발생하였습니다.(" + ex.getMessage() + ")");
		} finally {
			if (reader != null) {
				reader.close();
			}

			if (httpConnection != null) {
				httpConnection.disconnect();
			}
		}

		return rval;
	}

	public static void download(HttpServletResponse response, File file) throws IOException {

		if (file == null || !file.exists() || file.length() <= 0 || file.isDirectory()) {
			throw new IOException("파일 객체가 Null 혹은 존재하지 않거나 길이가 0, 혹은 파일이 아닌 디렉토리이다.");
		}

		InputStream is = null;
		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			is = new FileInputStream(file);
			byte[] buffer = new byte[BUFFER_SIZE];

			fin = new BufferedInputStream(is);
			outs = new BufferedOutputStream(response.getOutputStream());

			int read = 0;
			while ((read = fin.read(buffer)) != -1) {
				outs.write(buffer, 0, read);
			}
		} finally {
			try {
				if(outs != null) outs.close();
			} catch (Exception e) {e.printStackTrace();}
			try {
				if(fin != null) fin.close();
			} catch (Exception e) {e.printStackTrace();}
			try {
				if(is != null) is.close();
			} catch (Exception e) {e.printStackTrace();}
		}
	}
}
