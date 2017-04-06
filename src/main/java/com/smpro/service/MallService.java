package com.smpro.service;

import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;
import com.smpro.vo.MallVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public interface MallService {
	public List<MallVo> getList(MallVo reqVo);

	public List<MallVo> getListSimple();

	public MallVo getVo(Integer seq);

	public MallVo getLoginTmpl(String mallId);

	public MallVo getMainInfo(String mallId);

	public boolean regVo(MallVo vo) throws Exception;

	public boolean modVo(MallVo vo) throws Exception;

	public boolean deleteMall(Integer seq);

	public Map<String, String> uploadImagesByMap(HttpServletRequest request) throws IOException, ImageIsNotAvailableException, ImageSizeException;

	public String imageProc(String realPath, String filename, Integer seq);
}
