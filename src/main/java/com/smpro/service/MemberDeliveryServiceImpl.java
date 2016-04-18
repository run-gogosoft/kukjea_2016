package com.smpro.service;

import com.smpro.dao.MemberDeliveryDao;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.MemberDeliveryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberDeliveryServiceImpl implements MemberDeliveryService {
	@Autowired
	private MemberDeliveryDao memberDeliveryDao;

	/** 등록 */
	public boolean regData(MemberDeliveryVo vo) throws Exception {
		/* 특정 입력 항목 데이터 합치기 */
		combineData(vo);
		/* 기본 배송지 설정 값 초기화 */
		initDefaultFlag(vo);
		vo.setTel(CrypteUtil.encrypt(vo.getTel(), Const.ARIA_KEY,
				Const.ARIA_KEY.length * 8, null));
		vo.setCell(CrypteUtil.encrypt(vo.getCell(), Const.ARIA_KEY,
				Const.ARIA_KEY.length * 8, null));
		vo.setAddr2(CrypteUtil.encrypt(vo.getAddr2(), Const.ARIA_KEY,
				Const.ARIA_KEY.length * 8, null));
		return memberDeliveryDao.regData(vo) > 0;
	}

	/** 수정 */
	public boolean modData(MemberDeliveryVo vo) throws Exception {
		/* 특정 입력 항목 데이터 합치기 */
		combineData(vo);
		/* 기본 배송지 설정 값 초기화 */
		initDefaultFlag(vo);
		vo.setTel(CrypteUtil.encrypt(vo.getTel(), Const.ARIA_KEY,
				Const.ARIA_KEY.length * 8, null));
		vo.setCell(CrypteUtil.encrypt(vo.getCell(), Const.ARIA_KEY,
				Const.ARIA_KEY.length * 8, null));
		vo.setAddr2(CrypteUtil.encrypt(vo.getAddr2(), Const.ARIA_KEY,
				Const.ARIA_KEY.length * 8, null));
		return memberDeliveryDao.modData(vo) > 0;
	}

	/** 삭제 */
	public boolean delData(MemberDeliveryVo vo) {
		return memberDeliveryDao.delData(vo) > 0;
	}

	/** 상세 */
	public MemberDeliveryVo getData(Integer seq) throws Exception {
		MemberDeliveryVo vo = memberDeliveryDao.getData(seq);
		if(!"".equals(vo.getTel())) {
			vo.setTel(CrypteUtil.decrypt(vo.getTel(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null));
		}
		
		if(!"".equals(vo.getCell())) {
			vo.setCell(CrypteUtil.decrypt(vo.getCell(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null));
		}
		
		if(!"".equals(vo.getAddr2())) {
			vo.setAddr2(CrypteUtil.decrypt(vo.getAddr2(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null));
		}
		
		/* 우편번호 자르기 */
		if(vo.getPostcode().length() == 6) {
			vo.setPostcode1(vo.getPostcode().substring(0, 3));
			vo.setPostcode2(vo.getPostcode().substring(3, 6));
		}

		// 전화번호 자르기
		if (vo.getTel() != null) {
			String[] tmp = vo.getTel().split("-");
			if (tmp.length == 3) {
				vo.setTel1(tmp[0]);
				vo.setTel2(tmp[1]);
				vo.setTel3(tmp[2]);
			}
		}
		if (vo.getCell() != null) {
			String[] tmp = vo.getCell().split("-");
			if (tmp.length == 3) {
				vo.setCell1(tmp[0]);
				vo.setCell2(tmp[1]);
				vo.setCell3(tmp[2]);
			}
		}

		return vo;
	}

	/** 리스트 */
	public List<MemberDeliveryVo> getList(MemberDeliveryVo dvo)
			throws Exception {
		List<MemberDeliveryVo> getList = memberDeliveryDao.getList(dvo);
		for (MemberDeliveryVo vo : getList) {
			vo.setTel(CrypteUtil.decrypt(vo.getTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			vo.setCell(CrypteUtil.decrypt(vo.getCell(), Const.ARIA_KEY,	Const.ARIA_KEY.length * 8, null));
			vo.setAddr2(CrypteUtil.decrypt(vo.getAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}

		return getList;
	}

	/** 데이터 합치기 */
	private void combineData(MemberDeliveryVo vo) {
		/* 우편번호 합치기 */
		if(!"".equals(vo.getPostcode1()) && !"".equals(vo.getPostcode2())) {
			vo.setPostcode(vo.getPostcode1() + vo.getPostcode2());
		}

		/* 전화번호 붙이기 */
		vo.setTel(StringUtil.formatPhone(vo.getTel1(), vo.getTel2(),
				vo.getTel3()));
		vo.setCell(StringUtil.formatPhone(vo.getCell1(), vo.getCell2(),
				vo.getCell3()));
	}

	/** 배송지 기본값 초기화 */
	private void initDefaultFlag(MemberDeliveryVo vo) {
		if ("Y".equals(vo.getDefaultFlag())) {
			/* 해당 등록 및 수정 데이터가 기본 배송지일 경우 기존 기본값을 초기화 한다. */
			memberDeliveryDao.initDefaultFlag(vo.getMemberSeq());
		} else {
			/* 기본 배송지값이 널일 경우 디폴트값 설정 */
			vo.setDefaultFlag("N");
		}
	}
}
