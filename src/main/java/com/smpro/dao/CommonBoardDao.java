package com.smpro.dao;

import com.smpro.vo.CommonBoardVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommonBoardDao {
	public int getListCount(CommonBoardVo vo);
	public List<CommonBoardVo> getList(CommonBoardVo vo);
	public int getDetailListCount(CommonBoardVo vo);
	public List<CommonBoardVo> getDetailList(CommonBoardVo vo);
	public CommonBoardVo getVo(Integer seq);
	public CommonBoardVo getDetailVo(Integer seq);
	public int createSeq(CommonBoardVo vo);
	public int insertVo(CommonBoardVo vo);
	public int updateVo(CommonBoardVo vo);
	public int updateViewCnt(Integer seq);
	public int getPasswordCnt(CommonBoardVo vo);
	public int deleteContentVo(CommonBoardVo vo);
	
	public int insertCommonVo(CommonBoardVo vo);
	public int updateCommonVo(CommonBoardVo vo);
	public int deleteCommonVo(Integer seq);
	
	// 코멘트
    public List<CommonBoardVo> getCommentList(CommonBoardVo vo); // 코멘트 리스트
    public int getCommentListTotalCount(CommonBoardVo vo); // 코멘트 레코드 수
    public CommonBoardVo getComment(Integer seq);
    public int insertComment(CommonBoardVo vo); // 코멘트 등록
    public int updateComment(CommonBoardVo vo); // 코멘드 수정
    public int deleteComment(Integer seq); // 코멘트 삭제
}
