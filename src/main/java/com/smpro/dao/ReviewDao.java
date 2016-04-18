package com.smpro.dao;

import com.smpro.vo.MemberVo;
import com.smpro.vo.ReviewVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewDao {
	public List<ReviewVo> getList(ReviewVo vo);

	public int getListCount(ReviewVo vo);

	public ReviewVo getVo(ReviewVo vo);

	public int insertData(ReviewVo vo);

	public int deleteData(Integer seq);

	public int updateData(ReviewVo vo);

	public Integer getReviewBoardRegCntForWeek(MemberVo vo);
}
