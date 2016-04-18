package com.smpro.service;

import com.smpro.dao.MallDao;
import com.smpro.dao.UserDao;
import com.smpro.vo.MallVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("mallService")
public class MallServiceImpl implements MallService {
	@Resource(name = "mallDao")
	private MallDao mallDao;

	@Resource(name = "userDao")
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
}
