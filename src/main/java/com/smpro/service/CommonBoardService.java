package com.smpro.service;

import com.smpro.vo.CommonBoardVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CommonBoardService {
	public int getListCount(CommonBoardVo vo);
	public List<CommonBoardVo> getList(CommonBoardVo vo);
	public int getDetailListCount(CommonBoardVo vo);
	public List<CommonBoardVo> getDetailList(CommonBoardVo vo);
	public CommonBoardVo getVo(Integer seq);
	public CommonBoardVo getDetailVo(Integer seq);
	public int createSeq(CommonBoardVo vo);
	public boolean insertVo(CommonBoardVo vo) throws Exception;
	public boolean updateVo(CommonBoardVo vo) throws Exception;
	public boolean updateViewCnt(Integer seq);
	public int getPasswordCnt(CommonBoardVo vo);
	public boolean deleteContentVo(CommonBoardVo vo);
	
	public boolean insertCommonVo(CommonBoardVo vo);
	public boolean updateCommonVo(CommonBoardVo vo);
	public boolean deleteCommonVo(Integer seq);
	
	// 댓글
	public List<CommonBoardVo> getCommentList(CommonBoardVo vo); // 코멘트 리스트
    public int getCommentListTotalCount(CommonBoardVo vo); // 코멘트 레코드 수
    public CommonBoardVo getComment(Integer seq);
    public boolean insertComment(CommonBoardVo vo); // 코멘트 등록
    public boolean updateComment(CommonBoardVo vo); // 코멘드 수정
    public boolean deleteComment(Integer seq); // 코멘트 삭제
}
