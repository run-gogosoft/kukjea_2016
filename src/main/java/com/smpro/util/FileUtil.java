package com.smpro.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;

public class FileUtil {
	public static void mkdir(File dir) {
		if (!dir.exists()) {
			dir.mkdir();
		}
	}

	public static void move(File origin, File target) {
		if (target.exists()) {
			target.delete();
		}
		origin.renameTo(target);
	}

	public static void rm(File target) {
		if (target.exists()) {
			target.delete();
		}
	}
	
	public static boolean write(InputStream istream, OutputStream ostream) throws Exception {
		boolean writeFlag = true;
		InputStream iStream = null;
		BufferedOutputStream oStream = null;
		try {
			iStream = new BufferedInputStream(istream);
			oStream = new BufferedOutputStream(ostream);
			
			int bytesRead=0;
			byte[] byteArr = new byte[1024*1024];
			while( (bytesRead = iStream.read(byteArr)) != -1){
				oStream.write(byteArr, 0, bytesRead);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			writeFlag = false;
		} finally {
			if(oStream != null) {
				oStream.flush();
				oStream.close();
			}
			
			if(iStream != null) {
				iStream.close();
			}
		}
		
		return writeFlag;
	}
}
