package com.smpro.service;

import com.smpro.dao.EstimateDao;
import com.smpro.dao.SmsDao;
import com.smpro.util.StringUtil;
import com.smpro.vo.EstimateVo;
import com.smpro.vo.ItemVo;
import com.smpro.vo.SmsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EstimateServiceImpl implements EstimateService {

	@Autowired
	private EstimateDao estimateDao;

	@Autowired
	private SmsDao smsDao;

	public List<EstimateVo> getList(EstimateVo vo) {
		return estimateDao.getList(vo);
	}
	
	public int getListCount(EstimateVo vo) {
		return estimateDao.getListCount(vo);
	}
	
	public EstimateVo getVo(Integer seq) {
		return estimateDao.getVo(seq);
	}
	
	public int regVo(EstimateVo vo) {
		int result = estimateDao.regVo(vo);
		if(result == 1) {
			//입점업체 담당자에게 SMS발송
			String salesCell = estimateDao.getSalesCell(vo.getItemSeq());
			if(!StringUtil.isBlank(salesCell)) {
				SmsVo svo = new SmsVo();
				svo.setStatusType("E");
				svo.setStatusCode("1");
				svo.setTrMsg(smsDao.getContent(svo));
				svo.setTrSendStat("0");
				svo.setTrMsgType("0");
				svo.setTrPhone(salesCell.replace("-", ""));
				
				smsDao.insertSmsSendVo(svo);
			}
			
		}
		
		return result;
	}
	
	public int modVo(EstimateVo vo) {
		return estimateDao.modVo(vo);
	}
	
	public int delVo(Integer seq) {
		return estimateDao.delVo(seq);
	}
	
	public List<EstimateVo> getListCompare(EstimateVo vo) {
		return estimateDao.getListCompare(vo);
	}
	
	public List<EstimateVo> getListCompareFile(EstimateVo vo) {
		return estimateDao.getListCompareFile(vo);
	}

	public int getListCountCompare(EstimateVo vo) {
		return estimateDao.getListCountCompare(vo);
	}
	
	public EstimateVo getVoCompare(Integer seq) {
		return estimateDao.getVoCompare(seq);
	}
	
	public int regVoCompare(EstimateVo vo) {
		return estimateDao.regVoCompare(vo);
	}
	
	public int modVoCompare(EstimateVo vo) {
		return estimateDao.modVoCompare(vo);
	}
	
	public int delVoCompare(Integer seq) {
		return estimateDao.delVoCompare(seq);
	}

	public int createEstimateCompareSeq(EstimateVo vo) {
		return estimateDao.createEstimateCompareSeq(vo);
	}
	
	public List<ItemVo> getListForOrder(EstimateVo vo) {
		return estimateDao.getListForOrder(vo);
	}
	
}
