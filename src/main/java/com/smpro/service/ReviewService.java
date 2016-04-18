package com.smpro.service;

import java.util.List;

import com.smpro.vo.MemberVo;

import com.smpro.vo.ReviewVo;
import org.springframework.stereotype.Service;

@Service
public interface ReviewService {

	public List<ReviewVo> getList(ReviewVo vo);

	public int getListCount(ReviewVo vo);

	public boolean insertData(ReviewVo vo);

	public boolean deleteData(Integer seq);

	public boolean updateData(ReviewVo vo);

	public ReviewVo getVo(ReviewVo vo);

	public Integer getReviewBoardRegCntForWeek(MemberVo vo);
}
