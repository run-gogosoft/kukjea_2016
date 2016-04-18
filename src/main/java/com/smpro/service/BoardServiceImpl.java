package com.smpro.service;

import com.smpro.dao.BoardDao;
import com.smpro.util.StringUtil;
import com.smpro.vo.BoardVo;
import com.smpro.vo.MemberVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Resource(name = "boardDao")
	private BoardDao boardDao;

	public List<BoardVo> getList(BoardVo vo) {
		return boardDao.getList(vo);
	}

	public int getListCount(BoardVo vo) {
		return boardDao.getListCount(vo);
	}

	public int createSeq(BoardVo vo) {
		return boardDao.createSeq(vo);
	}

	public boolean insertData(BoardVo vo) {
		return boardDao.insertData(vo) > 0;
	}

	public boolean updateData(BoardVo vo) {
		return boardDao.updateData(vo) > 0;
	}

	public boolean deleteData(BoardVo vo) {
		return boardDao.deleteData(vo) > 0;
	}

	public BoardVo getVo(BoardVo vo) {
		BoardVo cvo = boardDao.getVo(vo);
		cvo.setContent(StringUtil.restoreClearXSS(cvo.getContent()));
		// 스크립트 replace
		cvo.setContent(cvo.getContent().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		return cvo;
	}

	public int updateViewCnt(BoardVo vo) {
		return boardDao.updateViewCnt(vo);
	}

	public Integer getDirectBoardRegCntForWeek(MemberVo vo) {
		return boardDao.getDirectBoardRegCntForWeek(vo);
	}

	public Integer getItemQnaBoardRegCntForWeek(MemberVo vo) {
		return boardDao.getItemQnaBoardRegCntForWeek(vo);
	}

}
