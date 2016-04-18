package com.smpro.dao;

import com.smpro.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SystemDao {
	/* 관리자 관리 */
	public List<AdminVo> getAdminList();

	public AdminVo getAdminData(AdminVo vo);

	public int insertData(AdminVo vo);

	public int updateDataUser(AdminVo vo);

	public int updateDataAdmin(AdminVo vo);

	public int getSeqCnt(Integer seq);

	/** 공통코드 리스트 */
	public List<CommonVo> getCommonList(CommonVo vo);

	/** 공통코드 리스트(그룹별) */
	public List<CommonVo> getCommonListByGroup(Integer groupCode);
	
	/** 공통코드 리스트(코드값 기준 정렬) */
	public List<CommonVo> getCommonListOrderByValue(Integer groupCode);

	public int insertCommon(CommonVo vo);

	public int updateCommon(CommonVo vo);

	public int deleteCommon(CommonVo vo);

	/* 배송업체 관리 */
	public List<CommonVo> getDeliveryList(DeliCompanyVo vo);

	public int insertDelivery(DeliCompanyVo vo);

	public int updateDelivery(DeliCompanyVo vo);

	public int deleteDelivery(DeliCompanyVo vo);

	public List<DeliCompanyVo> getDeliCompany();

	/* 공지팝업창 관리 */
	public List<NoticePopupVo> getNoticePopupList(NoticePopupVo vo);
	public NoticePopupVo getNoticePopupVo(Integer seq);
	public int createNoticePopupSeq(NoticePopupVo vo);
	public int insertNoticePopup(NoticePopupVo vo);
	public int updateNoticePopup(NoticePopupVo vo);

	/* 관리자 권한 체크 */
	public String getControllerAuth(MemberVo vo);

	/* 관리자 권한 관리 */
	public List<MemberVo> getAdminGradeList(MemberVo srchVo);

	public int getAdminGradeListCount(MemberVo srcjVo);

	public MemberVo getAdminGradeVo(MemberVo vo);

	public int insertGradeController(MemberVo vo);

	public int updateGradeController(MemberVo vo);

	public int deleteGradeController(MemberVo vo);

	public List<MemberVo> getControllerName();

	public int insertAdminLog(AdminVo vo);

	public List<CommonVo> getGroupName();

	/** 공통코드명 가져오기 */
	public String getCommonName(CommonVo vo);

	public DeliCompanyVo getDeliCompanyVo(Integer deliSeq);
	
	public List<PaymethodVo> getPaymethodFeeList();
	
	public int insertPaymethodFee(PaymethodVo vo);
	
	public int updatePaymethodFee(PaymethodVo vo);
	
	public int deletePaymethodFee(PaymethodVo vo);
}
