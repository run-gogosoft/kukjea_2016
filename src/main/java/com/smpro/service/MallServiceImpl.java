package com.smpro.service;

import com.smpro.dao.MallDao;
import com.smpro.dao.UserDao;
import com.smpro.util.Const;
import com.smpro.util.FileUploadUtil;
import com.smpro.util.FileUtil;
import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;
import com.smpro.vo.EventVo;
import com.smpro.vo.MallVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class MallServiceImpl implements MallService {
	@Autowired
	private MallDao mallDao;

	@Autowired
	private UserDao userDao;

	public List<MallVo> getList(MallVo reqVo) {
		return mallDao.getList(reqVo);
	}

	public List<MallVo> getListSimple() {
		return mallDao.getListSimple();
	}

	public MallVo getVo(Integer seq) {
		return mallDao.getVo(seq);
	}

	public MallVo getLoginTmpl(String mallId) {
		return mallDao.getLoginTmpl(mallId);
	}

	public MallVo getMainInfo(String mallId) {
		return mallDao.getMainInfo(mallId);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean regVo(MallVo vo) throws Exception {
		int result = userDao.insertData(vo);
		if (result > 0) {
			result = result + mallDao.regVo(vo);
		}

		if (result == 2) {
			return true;
		}

		throw new Exception();

	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean modVo(MallVo vo) throws Exception {
		boolean flag = false;
		try {
			int result = userDao.updateData(vo);
			if (result > 0) {
				result = result + mallDao.modVo(vo);
			}
			if (result == 2) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}

		return flag;
	}

	public boolean deleteMall(Integer seq) {
		return userDao.deleteMall(seq);
	}

	/**
	 * 순차적으로 이미지 파일을 업로드한 후에, 맵을 반환하는 메서드
	 *
	 * @param request
	 * @return
	 * @throws IOException
	 *             (물리적인 IO에 문제가 발생했을 경우 발생하는 예외, 디스크 용량부족 등...)
	 * @throws ImageIsNotAvailableException
	 *             (이미지가 아닐 경우 발생하는 예외)
	 */
	public Map<String, String> uploadImagesByMap(HttpServletRequest request) throws IOException, ImageIsNotAvailableException, ImageSizeException {
		Map<String, String> fileMap = new LinkedHashMap<>();
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iter = mpRequest.getFileNames();
		while (iter.hasNext()) {
			MultipartFile file = mpRequest.getFile(iter.next());
			if (file.getSize() > 0) {
				// temp 디렉토리 생성
				File tempDir = new File(Const.UPLOAD_REAL_PATH);
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/logo/");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}
				tempDir = new File(Const.UPLOAD_REAL_PATH + "/logo/temp");
				if (!tempDir.exists()) {
					tempDir.mkdir();
				}

				if(request.getAttribute("banner")!=null && request.getAttribute("banner").equals("Y")){
					fileMap.put(file.getName(), new FileUploadUtil().uploadBannermageFile(file, Const.UPLOAD_REAL_PATH + "/logo/temp"));
				}
				else {
					fileMap.put(file.getName(), new FileUploadUtil().uploadLogoImageFile(file, Const.UPLOAD_REAL_PATH + "/logo/temp"));
				}
			}
		}
		return fileMap;
	}

	public String imageProc(String realPath, String filename, Integer seq) {
		String ext = "." + filename.split("\\.")[1];
		String perSeq = "" + ((seq.intValue() / 1000) * 1000 + 1000);

		// 디렉토리를 검증한다
		FileUtil.mkdir(new File(realPath + "/" + perSeq + "/"));
		// 파일이 존재한다면 미리 삭제해야 한다
		FileUtil.move(new File(realPath + "/temp/" + filename), new File(realPath + "/" + perSeq + "/" + seq + ext));

		return "/logo/" + perSeq + "/" + seq + ext;
	}

	/**
	 * 해당 seq의 파일을 삭제한다
	 *
	 * @param realPath
	 * @param seq
	 */
	public void deleteFiles(String realPath, Integer seq) {
		MallVo paramVo = new MallVo();
		paramVo.setSeq(seq);
		MallVo vo = getVo(paramVo.getSeq());
		new File(realPath + vo.getLogoImg()).delete();
	}
}
