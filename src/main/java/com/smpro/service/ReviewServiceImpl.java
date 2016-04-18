package com.smpro.service;

import com.smpro.dao.ReviewDao;
import com.smpro.util.StringUtil;
import com.smpro.vo.MemberVo;
import com.smpro.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private ReviewDao reviewDao;

	public List<ReviewVo> getList(ReviewVo vo) {
		List<ReviewVo> reviewVo = reviewDao.getList(vo);
		for (int i = 0; i < reviewVo.size(); i++) {
			ReviewVo tmpVo = reviewVo.get(i);
			tmpVo.setTmpReview(StringUtil.cutString(tmpVo.getReview(), 90));
		}
		return reviewVo;
	}

	public int getListCount(ReviewVo vo) {
		return reviewDao.getListCount(vo);
	}

	public boolean insertData(ReviewVo vo) {
		return reviewDao.insertData(vo) > 0;
	}

	public boolean deleteData(Integer seq) {
		return reviewDao.deleteData(seq) > 0;
	}

	public boolean updateData(ReviewVo vo) {
		return reviewDao.updateData(vo) > 0;
	}

	public ReviewVo getVo(ReviewVo vo) {
		return reviewDao.getVo(vo);
	}

	public Integer getReviewBoardRegCntForWeek(MemberVo vo) {
		return reviewDao.getReviewBoardRegCntForWeek(vo);
	}
}
