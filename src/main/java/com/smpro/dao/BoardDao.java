package com.smpro.dao;

import com.smpro.vo.BoardVo;
import com.smpro.vo.MemberVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BoardDao {
	public List<BoardVo> getList(BoardVo vo);

	public List<BoardVo> getListAll(BoardVo vo);

	public int getListCount(BoardVo vo);

	public BoardVo getVo(BoardVo vo);

	public int createSeq(BoardVo vo);
	
	public int insertData(BoardVo vo);

	public int updateData(BoardVo vo);

	public int deleteData(BoardVo vo);

	public int updateViewCnt(BoardVo vo);

	public Integer getDirectBoardRegCntForWeek(MemberVo vo);

	public Integer getItemQnaBoardRegCntForWeek(MemberVo vo);
}
