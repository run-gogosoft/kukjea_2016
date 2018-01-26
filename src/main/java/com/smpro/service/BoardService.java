package com.smpro.service;

import com.smpro.vo.BoardVo;
import com.smpro.vo.MemberVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BoardService {
	public List<BoardVo> getList(BoardVo vo);

	public List<BoardVo> getListAll(BoardVo vo);

	public int getListCount(BoardVo vo);

	public int createSeq(BoardVo vo);
	
	public boolean insertData(BoardVo vo);

	public boolean updateData(BoardVo vo);

	public boolean deleteData(BoardVo vo);

	public BoardVo getVo(BoardVo vo);

	public int updateViewCnt(BoardVo vo);

	public Integer getDirectBoardRegCntForWeek(MemberVo vo);

	public Integer getItemQnaBoardRegCntForWeek(MemberVo vo);

}
