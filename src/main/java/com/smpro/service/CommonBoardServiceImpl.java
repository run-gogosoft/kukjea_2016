package com.smpro.service;

import com.smpro.dao.CommonBoardDao;
import com.smpro.util.StringUtil;
import com.smpro.vo.CommonBoardVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommonBoardServiceImpl implements CommonBoardService {
	@Autowired
	private CommonBoardDao commonBoardDao;
	
	@Override
	public int getListCount(CommonBoardVo vo) {
		return commonBoardDao.getListCount(vo);
	}

	@Override
	public List<CommonBoardVo> getList(CommonBoardVo vo) {
		return commonBoardDao.getList(vo);
	}
	
	@Override
	public int getDetailListCount(CommonBoardVo vo) {
		return commonBoardDao.getDetailListCount(vo);
	}
	
	@Override
	public List<CommonBoardVo> getDetailList(CommonBoardVo vo) {
		return commonBoardDao.getDetailList(vo);
	}

	@Override
	public CommonBoardVo getVo(Integer seq) {
		return commonBoardDao.getVo(seq);
	}
	
	@Override
	public CommonBoardVo getDetailVo(Integer seq) {
		CommonBoardVo cvo = commonBoardDao.getDetailVo(seq);
		cvo.setContent(StringUtil.restoreClearXSS(cvo.getContent()));
		cvo.setAnswer(StringUtil.restoreClearXSS(cvo.getAnswer()));
		// 스크립트 replace
		cvo.setContent(cvo.getContent().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		cvo.setAnswer(cvo.getAnswer().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		return cvo;
	}

	@Override
	public int createSeq(CommonBoardVo vo) {
		return commonBoardDao.createSeq(vo);
	}

	@Override
	public boolean insertVo(CommonBoardVo vo) throws Exception {
		/* 입력받은 패스워드 암호화 */
		if(!"".equals(vo.getUserPassword())) {
			vo.setUserPassword(StringUtil.encryptSha2(vo.getUserPassword()));
		}
		
		return commonBoardDao.insertVo(vo) > 0;
	}

	@Override
	public boolean updateVo(CommonBoardVo vo) throws Exception {
		/* 입력받은 패스워드 암호화 */
		if(!"".equals(vo.getUserPassword())) {
			vo.setUserPassword(StringUtil.encryptSha2(vo.getUserPassword()));
		}
		
		return commonBoardDao.updateVo(vo) > 0;
	}

	@Override
	public boolean updateViewCnt(Integer seq) {
		return commonBoardDao.updateViewCnt(seq) > 0;
	}

	@Override
	public int getPasswordCnt(CommonBoardVo vo) {
		return commonBoardDao.getPasswordCnt(vo);
	}

	@Override
	public boolean deleteContentVo(CommonBoardVo vo) {
		return commonBoardDao.deleteContentVo(vo) > 0;
	}

	@Override
	public boolean insertCommonVo(CommonBoardVo vo) {
		return commonBoardDao.insertCommonVo(vo) > 0;
	}

	@Override
	public boolean updateCommonVo(CommonBoardVo vo) {
		return commonBoardDao.updateCommonVo(vo) > 0;
	}

	@Override
	public boolean deleteCommonVo(Integer seq) {
		return commonBoardDao.deleteCommonVo(seq) > 0;
	}

	@Override
	public List<CommonBoardVo> getCommentList(CommonBoardVo vo) {
		return commonBoardDao.getCommentList(vo);
	}

	@Override
	public int getCommentListTotalCount(CommonBoardVo vo) {
		return commonBoardDao.getCommentListTotalCount(vo);
	}

	@Override
	public CommonBoardVo getComment(Integer seq) {
		return commonBoardDao.getComment(seq);
	}

	@Override
	public boolean insertComment(CommonBoardVo vo) {
		return commonBoardDao.insertComment(vo) > 0;
	}

	@Override
	public boolean updateComment(CommonBoardVo vo) {
		return commonBoardDao.updateComment(vo) > 0;
	}

	@Override
	public boolean deleteComment(Integer seq) {
		return commonBoardDao.deleteComment(seq) > 0;
	}
}
