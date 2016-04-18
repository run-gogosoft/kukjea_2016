package com.smpro.util;

import java.io.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smpro.filter.ImageFileNameFilter;

public class EditorUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(EditorUtil.class);
	
	/** 임시 이미지 파일을 정식 등록 처리함 */
	public static String procImage(String content, Integer seq, String group) {
		int perSeq = calcPerSeq(seq);
		String newContent = content;
		String[] imgUrl = content.replace("&quot;", "").split("http://"+Const.DOMAIN);
		if(imgUrl.length >= 2) {
			int idx = 0;
			//신규 추가될 idx값을 구하기 위하여 기존 등록된 이미지중에서 가장 높은 idx값을 가져온다. 
			for(int i=0; i < imgUrl.length; i++) {
				String fileName = imgUrl[i];
				if(fileName.startsWith("/upload/editor/"+group+"/"+perSeq+"/"+seq)) {
					fileName = fileName.replace("/upload/editor/"+group+"/"+perSeq+"/","");
					fileName = fileName.substring(0, fileName.indexOf(" "));
					fileName = fileName.substring(0, fileName.indexOf("."));
					int fileIdx = Integer.valueOf(fileName.split("_")[1]).intValue();
					if(idx < fileIdx) {
						idx = fileIdx;
					}
				}
			}
			
			for(int i=0; i < imgUrl.length; i++) {
				String tempFileName = imgUrl[i];
				LOGGER.debug("### tempFileName1 : " + tempFileName);
				if(tempFileName.startsWith("/upload/editor/temp/")) {
					tempFileName = tempFileName.replace("/upload/editor/temp/","");
					tempFileName = tempFileName.substring(0, tempFileName.indexOf(" "));
					LOGGER.debug("### tempFileName2 : " + tempFileName);
					newContent = newContent.replace(tempFileName, moveImage(tempFileName, seq, ++idx, group));
				}
			}
			//임시 디렉토리 경로를 정식 경로로 변환한다.
			newContent = newContent.replace("http://"+Const.DOMAIN+"/upload/editor/temp/", "http://"+Const.DOMAIN+"/upload/editor/"+group+"/");
		}
		
		//기존 등록된 이미지가 에디터상에서 삭제되었을 경우 해당 파일도 함께 삭제 처리
		String realPath = Const.UPLOAD_REAL_PATH + "/editor/"+group+"/"+perSeq;
		File dir = new File(realPath); 
		String[] fileNames = dir.list(new ImageFileNameFilter(String.valueOf(seq)));
		if(fileNames != null) {	
			for(int i=0; i < fileNames.length; i++) {
				String fileName = fileNames[i];
				if(!newContent.contains("http://"+Const.DOMAIN+"/upload/editor/"+group+"/"+perSeq+"/"+fileName)) {
					new File(dir, fileName).delete();
				}
			}
		}
		
		return newContent;
	}
	
	//에디터를 통해 업로드된 이미지 삭제
	public static void deleteImage(Integer seq, String group) {
		File dir = new File(Const.UPLOAD_REAL_PATH + "/editor/"+group+"/"+calcPerSeq(seq)); 
		String[] fileNames = dir.list(new ImageFileNameFilter(String.valueOf(seq)));
		if(fileNames != null) {	
			for(int i=0; i < fileNames.length; i++) {
				new File(dir, fileNames[i]).delete();
			}
		}
	}
	
	private static String moveImage(String tempFileName, Integer seq, int idx, String group) {
		String realPath = Const.UPLOAD_REAL_PATH + "/editor";
		String ext = "." + tempFileName.split("\\.")[1];
		int perSeq = calcPerSeq(seq);

		//해당 데이터의 고유번호를 기반으로 정식 파일명 생성
		String fileName = seq + "_" + idx + ext;
		
		// 디렉토리 검증
		FileUtil.mkdir(new File(realPath));
		FileUtil.mkdir(new File(realPath + "/" + group + "/"));
		FileUtil.mkdir(new File(realPath + "/" + group + "/" + perSeq + "/"));

		//임시 디렉토리에서 정식 디렉토리로 파일을 옮긴다
		FileUtil.move(new File(realPath + "/temp/" + tempFileName), new File(realPath + "/" +group+ "/" + perSeq + "/" + fileName));
		
		return perSeq + "/" + fileName;
	}
	
	public static int calcPerSeq(Integer seq) {
		return ((seq.intValue() / 1000) * 1000 + 1000);
	}
}
