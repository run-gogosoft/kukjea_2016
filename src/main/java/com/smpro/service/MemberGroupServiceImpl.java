package com.smpro.service;

import com.smpro.dao.MemberGroupDao;
import com.smpro.util.Const;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.MemberGroupVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberGroupServiceImpl implements MemberGroupService {

	@Autowired
	private MemberGroupDao memberGroupDao;

	public int regVo(MemberGroupVo vo) {
		//이메일, 우편번호, 전화번호, 팩스 합치기
		formatStr(vo);
		return memberGroupDao.regVo(vo);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean modVo(MemberGroupVo vo) throws Exception {
		//이메일, 우편번호, 전화번호, 팩스 합치기
		formatStr(vo);
		//상세주소 암호화
		vo.setAddr2(CrypteUtil.encrypt(vo.getAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		int procCnt = memberGroupDao.modVo(vo);
		if(procCnt == 1) {
			procCnt += memberGroupDao.modAddr(vo);
		}
		
		if (procCnt != 2) {
			throw new Exception("업데이트가 정상적으로 처리되지 않았습니다.");
		}
		return procCnt == 2;
	}

	public MemberGroupVo getVo(Integer seq) {
		MemberGroupVo vo = memberGroupDao.getVo(seq);
		if(vo != null) {
			String[] fax = vo.getFax().split("-");
			if(fax.length == 3) {
				vo.setFax1(fax[0]);
				vo.setFax2(fax[1]);
				vo.setFax3(fax[2]);
			}
			
			String[] taxTel = vo.getTaxTel().split("-");
			if(taxTel.length == 3) {
				vo.setTaxTel1(taxTel[0]);
				vo.setTaxTel2(taxTel[1]);
				vo.setTaxTel3(taxTel[2]);
			}
			
			String[] taxEmail = vo.getTaxEmail().split("@");
			if(taxEmail.length == 2) {
				vo.setTaxEmail1(taxEmail[0]);
				vo.setTaxEmail2(taxEmail[1]);
			}
		}
				
		return vo;
	}
	
	/** 우편번호, 이메일, 전화번호, 휴대폰번호 합치기 */
	private void formatStr(MemberGroupVo vo) {
		if (!"".equals(vo.getPostcode1()) && !"".equals(vo.getPostcode2())) {
			vo.setPostcode(vo.getPostcode1() + vo.getPostcode2());
		}
		
		if (!"".equals(vo.getBizNo1()) && !"".equals(vo.getBizNo2()) && !"".equals(vo.getBizNo3())) {
			vo.setBizNo(vo.getBizNo1()+vo.getBizNo2()+vo.getBizNo3());
		}
		
		if (!"".equals(vo.getFax1()) && !"".equals(vo.getFax2()) && !"".equals(vo.getFax3())) {
			vo.setFax(vo.getFax1()+"-"+vo.getFax2()+"-"+vo.getFax3());
		}
		
		if (!"".equals(vo.getTaxEmail1()) && !"".equals(vo.getTaxEmail2())) {
			vo.setTaxEmail(vo.getTaxEmail1() + "@" + vo.getTaxEmail2()+" ");
		}		

		if (!"".equals(vo.getTaxTel1()) && !"".equals(vo.getTaxTel2()) && !"".equals(vo.getTaxTel3())) {
			vo.setTaxTel(vo.getTaxTel1()+"-"+vo.getTaxTel2()+"-"+vo.getTaxTel3());
		}

	}
	
	/** 사업자 번호 체크 */
	@Override
	public int getBizNoCnt(String bizNo) {
		return memberGroupDao.getBizNoCnt(bizNo);
	}
}
