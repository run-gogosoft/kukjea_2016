package com.smpro.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;

public class CommandUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(CommandUtil.class);
	
	/**
	 * 이 메서드는 synchronized하고 성능상의 문제가 많습니다!! thread가 응답하지 않을 경우 서버에 문제가 생길 수 있기
	 * 때문에 반드시 주의하여 사용해주십시오
	 * 
	 * @param filename
	 * @param savepath
	 * @param fileExtension
	 * @return
	 */
	public synchronized static boolean imageResizeForImageMagick( String filename, String savepath, String fileExtension) {
		String outputFileName = "";
		String originalFileName = "";

		for (int j = 0; j < Const.ITEM_IMAGE_SIZE.length; j++) {
			// Reisize
			outputFileName = savepath + File.separator + filename + "_"	+ Const.ITEM_IMAGE_SIZE[j] + fileExtension;
			originalFileName = savepath + File.separator + filename	+ fileExtension;

			try {
				ProcessBuilder pb = new ProcessBuilder(Const.IMAGE_MAGICK_PATH,	"-geometry", Const.ITEM_IMAGE_SIZE[j] + "x"	+ Const.ITEM_IMAGE_SIZE[j] + "!", originalFileName, outputFileName);
				pb.directory(new File(savepath));

				pb.redirectErrorStream(true);
				Process p = pb.start();
				BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
				String line = "";
				while ((line = br.readLine()) != null) {
					LOGGER.info(line);
				}
				LOGGER.info("original/output : " + originalFileName + "/" + outputFileName);
				LOGGER.info("imageResizeForImageMagick.waitFor -->" + p.waitFor());
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public synchronized static boolean imageResizeForImageMagickAgain(String filename, String savepath, String fileExtension) {
		String outputFileName = "";
		String originalFileName = "";

		for (int j = 0; j < Const.ITEM_IMAGE_SIZE.length; j++) {
			outputFileName = savepath + filename.replace("/origin/", "/s" + Const.ITEM_IMAGE_SIZE[j] + "/") + fileExtension;
			originalFileName = savepath + filename + fileExtension;

			try {
				LOGGER.info("original/output : " + originalFileName + "/" + outputFileName);
				// LOGGER.info("process : " +
				// Const.IMAGE_MAGICK_PATH + " -geometry " +
				// Const.ITEM_IMAGE_SIZE[j] + "x" + Const.ITEM_IMAGE_SIZE[j] +
				// "! " + originalFileName + " " + outputFileName);

				FileUtil.rm(new File(outputFileName));
				ProcessBuilder pb = new ProcessBuilder(Const.IMAGE_MAGICK_PATH, "-geometry", Const.ITEM_IMAGE_SIZE[j] + "x" + Const.ITEM_IMAGE_SIZE[j] + "!", originalFileName, outputFileName);
				pb.directory(new File(savepath));

				pb.redirectErrorStream(true);
				Process p = pb.start();
				BufferedReader br = new BufferedReader(new InputStreamReader(
						p.getInputStream()));
				String line = "";
				while ((line = br.readLine()) != null) {
					LOGGER.info(line);
				}
				LOGGER.info(
						"imageResizeForImageMagick.waitFor -->" + p.waitFor());
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}
}
