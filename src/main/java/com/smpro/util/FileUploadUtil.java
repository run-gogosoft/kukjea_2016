package com.smpro.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import javax.swing.ImageIcon;

import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUploadUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(FileUploadUtil.class);
	
	/**
	 * 이미지를 업로드하고 유일한 파일명으로 포장해서 던져주는 메서드 이 리스트는 업로드된 디렉토리를 포함하지 않음, 오로지 파일명만을
	 * 반환한다
	 * 
	 * @param formFile
	 * @param realPath
	 * @return
	 * @throws java.io.IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 */
	public String uploadImageFile(MultipartFile formFile, String realPath) throws IOException, ImageIsNotAvailableException {
		// 랜덤으로 생성된 이미지에 확장자를 붙인다
		String fileName = UUID.randomUUID().toString() + formFile.getOriginalFilename().substring(formFile.getOriginalFilename().lastIndexOf(".")).toLowerCase();

		upload(realPath, formFile, fileName);
		// 이미지 파일인지 아닌지 검사한다 (이 부분은 서버 부하가 있으므로 추후 문제되면 제거한다)
		ImageIcon ii = new ImageIcon(realPath + "/" + fileName);
		if (ii.getIconWidth() == -1 && ii.getIconHeight() == -1) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageIsNotAvailableException();
		}
		return fileName;
	}
	
	/**
	 * 이미지를 업로드하고 유일한 파일명으로 포장해서 던져주는 메서드 이 리스트는 업로드된 디렉토리를 포함하지 않음, 오로지 파일명만을
	 * 반환한다(이벤트 리스트 이미지 등록시에 사용한다)
	 * 
	 * @param formFile
	 * @param realPath
	 * @return
	 * @throws java.io.IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 * @throws ImageSizeException
	 *             (이미지가 사이즈가 804x270 아닐경우 발생하는 예외)
	 */
	public String uploadEventImageFile(MultipartFile formFile, String realPath) throws IOException, ImageIsNotAvailableException, ImageSizeException {
		// 랜덤으로 생성된 이미지에 확장자를 붙인다
		String fileName = UUID.randomUUID().toString() + formFile.getOriginalFilename().substring(formFile.getOriginalFilename().lastIndexOf(".")).toLowerCase();

		upload(realPath, formFile, fileName);
		// 이미지 파일인지 아닌지 검사한다 (이 부분은 서버 부하가 있으므로 추후 문제되면 제거한다)
		ImageIcon ii = new ImageIcon(realPath + "/" + fileName);
		System.out.print("ii.getWidth:"+ii.getIconWidth());
		System.out.print("ii.getIconHeight:"+ii.getIconHeight());
		if (ii.getIconWidth() == -1 && ii.getIconHeight() == -1) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageIsNotAvailableException();
		} else if(ii.getIconWidth() > 804 || ii.getIconWidth() < 804 && ii.getIconHeight() > 270 || ii.getIconHeight() < 270) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageSizeException();
		}
		return fileName;
	}

	/**
	 * 이미지를 업로드하고 유일한 파일명으로 포장해서 던져주는 메서드 이 리스트는 업로드된 디렉토리를 포함하지 않음, 오로지 파일명만을
	 * 반환한다(이벤트 리스트 이미지 등록시에 사용한다)
	 *
	 * @param formFile
	 * @param realPath
	 * @return
	 * @throws java.io.IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 * @throws ImageSizeException
	 *             (이미지가 사이즈가 243x60 아닐경우 발생하는 예외)
	 */
	public String uploadLogoImageFile(MultipartFile formFile, String realPath) throws IOException, ImageIsNotAvailableException, ImageSizeException {
		// 랜덤으로 생성된 이미지에 확장자를 붙인다
		String fileName = UUID.randomUUID().toString() + formFile.getOriginalFilename().substring(formFile.getOriginalFilename().lastIndexOf(".")).toLowerCase();

		upload(realPath, formFile, fileName);
		System.out.print("[[[realPath:"+realPath+", fileName:"+fileName);
		// 이미지 파일인지 아닌지 검사한다 (이 부분은 서버 부하가 있으므로 추후 문제되면 제거한다)
		ImageIcon ii = new ImageIcon(realPath + "/" + fileName);
		System.out.print("ii.getWidth:"+ii.getIconWidth());
		System.out.print("ii.getIconHeight:"+ii.getIconHeight());
		if (ii.getIconWidth() == -1 && ii.getIconHeight() == -1) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageIsNotAvailableException();
		} else if(ii.getIconWidth() > 243 || ii.getIconWidth() < 243 && ii.getIconHeight() > 60 || ii.getIconHeight() < 60) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageSizeException();
		}
		return fileName;
	}

	/**
	 * 이미지를 업로드하고 유일한 파일명으로 포장해서 던져주는 메서드 이 리스트는 업로드된 디렉토리를 포함하지 않음, 오로지 파일명만을
	 * 반환한다(이벤트 리스트 이미지 등록시에 사용한다)
	 *
	 * @param formFile
	 * @param realPath
	 * @return
	 * @throws java.io.IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 * @throws ImageSizeException
	 *             (이미지가 사이즈가 243x60 아닐경우 발생하는 예외)
	 */
	public String uploadBannermageFile(MultipartFile formFile, String realPath) throws IOException, ImageIsNotAvailableException, ImageSizeException {
		// 랜덤으로 생성된 이미지에 확장자를 붙인다
		String fileName = UUID.randomUUID().toString() + formFile.getOriginalFilename().substring(formFile.getOriginalFilename().lastIndexOf(".")).toLowerCase();

		upload(realPath, formFile, fileName);
		System.out.print("[[[realPath:"+realPath+", fileName:"+fileName);
		// 이미지 파일인지 아닌지 검사한다 (이 부분은 서버 부하가 있으므로 추후 문제되면 제거한다)
		ImageIcon ii = new ImageIcon(realPath + "/" + fileName);
		System.out.print("ii.getWidth:"+ii.getIconWidth());
		System.out.print("ii.getIconHeight:"+ii.getIconHeight());
		if (ii.getIconWidth() == -1 && ii.getIconHeight() == -1) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageIsNotAvailableException();
		} else if(ii.getIconWidth() > 168 || ii.getIconWidth() < 168 && ii.getIconHeight() > 52 || ii.getIconHeight() < 52) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageSizeException();
		}
		return fileName;
	}

	/**
	 * 이미지를 업로드하고 유일한 파일명으로 포장해서 던져주는 메서드 이 리스트는 업로드된 디렉토리를 포함하지 않음, 오로지 파일명만을
	 * 반환한다(이벤트 리스트 이미지 등록시에 사용한다)
	 *
	 * @param formFile
	 * @param realPath
	 * @return
	 * @throws java.io.IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 * @throws ImageSizeException
	 *             (이미지가 사이즈가 804x270 아닐경우 발생하는 예외)
	 */
	public String uploadEventBannerImageFile(MultipartFile formFile, String realPath) throws IOException, ImageIsNotAvailableException, ImageSizeException {
		// 랜덤으로 생성된 이미지에 확장자를 붙인다
		String fileName = UUID.randomUUID().toString() + formFile.getOriginalFilename().substring(formFile.getOriginalFilename().lastIndexOf(".")).toLowerCase();

		upload(realPath, formFile, fileName);
		// 이미지 파일인지 아닌지 검사한다 (이 부분은 서버 부하가 있으므로 추후 문제되면 제거한다)
		ImageIcon ii = new ImageIcon(realPath + "/" + fileName);
		if (ii.getIconWidth() == -1 && ii.getIconHeight() == -1) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageIsNotAvailableException();
		} else if(ii.getIconWidth() > 804 || ii.getIconWidth() < 804 && ii.getIconHeight() > 270 || ii.getIconHeight() < 270) {
			new File(realPath + "/" + fileName).delete();
			throw new ImageSizeException();
		}
		return fileName;
	}

	/**
	 * 파일을 업로드하고 유일한 파일명으로 포장해서 던져주는 메서드 이 리스트는 업로드된 디렉토리를 포함하지 않음, 오로지 파일명만을
	 * 반환한다
	 * 
	 * @param formFile
	 * @param realPath
	 * @return
	 * @throws java.io.IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 */
	public String uploadFile(MultipartFile formFile, String realPath) throws IOException {
		// 랜덤으로 생성된 이미지에 확장자를 붙인다
		String fileName = UUID.randomUUID().toString() + formFile.getOriginalFilename().substring(formFile.getOriginalFilename().lastIndexOf(".")).toLowerCase();
		upload(realPath, formFile, fileName);
		return fileName;
	}

	private void upload(String realPath, MultipartFile formFile, String fileName) throws IOException {
		File tempDir = new File(realPath);
		if (!tempDir.exists()) {
			tempDir.mkdir();
		}
		LOGGER.debug("[UPLOAD_PATH] " + realPath);
		LOGGER.debug("[UPLOAD_FILENAME] " + fileName);

		InputStream stream = formFile.getInputStream();
		OutputStream bos = new FileOutputStream(realPath + "/" + fileName);
		int bytesRead = 0;
		byte[] buffer = new byte[8192];
		while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
			bos.write(buffer, 0, bytesRead);
		}
		bos.close();
		stream.close();
		LOGGER.debug("[FINISH upload] " + fileName);
	}

	public String upload(String path, String realPath, MultipartFile file) throws IOException {

		String fileName = UUID.randomUUID().toString();
		File tempDir = new File(realPath);
		if(!tempDir.exists()) {
			tempDir.mkdirs();
		}

		InputStream stream = file.getInputStream();
		String streamPath = tempDir.getAbsoluteFile() + "/" + fileName;
		LOGGER.info("------------------------------------");
		LOGGER.info("realPath:: " + streamPath);

		OutputStream bos = new FileOutputStream(streamPath);
		int bytesRead = 0;
		byte[] buffer = new byte[8192];
		while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
			bos.write(buffer, 0, bytesRead);
		}
		bos.close();
		stream.close();

		LOGGER.info("result:: " + realPath + fileName);
		LOGGER.info("------------------------------------");
		return path + fileName;
	}
	
	public boolean uploadCKEditorImage(MultipartHttpServletRequest mRequest, Model model) {
		String editorFuncNum = mRequest.getParameter("CKEditorFuncNum");
		
		MultipartFile mFile = mRequest.getFile("upload");
		
		//파일 생성
		String fileName = mFile.getOriginalFilename();
		
		// 이미지만 허용한다
		if(!checkImageExt(fileName)) {
			model.addAttribute("message", "이미지 파일만 첨부하실 수 있습니다");
			return false;
		}
		
		//저장 경로 생성
		FileUtil.mkdir(new File(Const.UPLOAD_REAL_PATH + "/editor/"));
		FileUtil.mkdir(new File(Const.UPLOAD_REAL_PATH + "/editor/temp"));
		
		
		//원본 파일명에서 고유한 임시 파일명으로 생성한다.(사용자간 파일명이 중복되는 경우 방지) 
		fileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf('.')).toLowerCase();
		File file = new File(Const.UPLOAD_REAL_PATH + "/editor/temp/", fileName);

		boolean writeFlag = false;
		try {
			writeFlag = FileUtil.write(mFile.getInputStream(), new FileOutputStream(file));
		} catch (Exception e) {
			e.printStackTrace();
		}

		if(writeFlag) {
			//에디터가 파일 업로드 완료를 인식할 수 있도록 콜백함수를 호출하여 알려준다.
			model.addAttribute("callback", "EDITOR^"+editorFuncNum+"^"+"http://"+Const.DOMAIN+Const.UPLOAD_PATH+"/editor/temp/"+fileName);
			return true;
		}
		
		model.addAttribute("message", "이미지 업로드에 실패하였습니다.");
		return false;
	}
	
	private boolean checkImageExt(String filename) {
		String[] checkExt = {"jpg", "gif", "png"}; // 소문자로만 쓸 것
	
		for (String s : checkExt) {
			if(filename.toLowerCase().matches(".*\\."+s+"$")) {
				return true;
			}
		}
		return false;
	}
}
