package com.smpro.util;

import com.smpro.util.exception.ImageDownloadException;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.net.URL;

public class ImageDownloadUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(ImageDownloadUtil.class);
	
	public BufferedImage readImage(String urlString) throws ImageDownloadException {
		String realUrl = Const.ITEM_IMAGE_PATH +urlString;
		BufferedImage originImage = null;
		DataInputStream dis = null;
		boolean hasError = false;
		try {
			dis = new DataInputStream(new URL(realUrl).openConnection().getInputStream());
			originImage = ImageIO.read(dis);
			dis.close();
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("Download fail:: " + e.getMessage());
			hasError = true;
		} finally {
			IOUtils.closeQuietly(dis);
		}

		if (hasError) {
			throw new ImageDownloadException();
		}
		return originImage;
	}

	public static void writeImage(BufferedImage image, String path)	throws IOException {
		if (image == null || image.getHeight() < 1) {
			return;
		}
		File file = new File(path);
		image.getScaledInstance(image.getWidth(), image.getHeight(), Image.SCALE_SMOOTH);
		ImageIO.write(image, "jpg", file);
	}

}
