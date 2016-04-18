package com.smpro.service;

import com.smpro.vo.AdminVo;
import com.smpro.vo.CommonVo;
import com.smpro.vo.DeliCompanyVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.NoticePopupVo;
import com.smpro.vo.PaymethodVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SystemService {

	/** 관리자 리스트 */
	public List<AdminVo> getAdminList();

	/** 관리자 상세 */
	public AdminVo getAdminData(AdminVo vo);

	/** 관리자 등록 */
	public int insertData(AdminVo vo) throws Exception;

	/** 관리자 정보 수정 */
	public boolean updateData(AdminVo vo) throws Exception;

	/** 관리자 계정 존재여부 검사 */
	public int getSeqCnt(Integer seq);

	/** 관리자 아이디 중복 검사 */
	public int getIdCnt(MemberVo vo);

	/** 관리자 비밀번호 변경 */
	public int updatePassword(AdminVo vo);

	/** 관리자 시퀀스 생성 */

	/** 공통 코드 리스트 */
	public List<CommonVo> getCommonList(CommonVo vo);

	/** 공통 코드 리스트(그룹별) */
	public List<CommonVo> getCommonListByGroup(Integer groupCode);
	
	/** 공통 코드 리스트(코드값 기준 정렬) */
	public List<CommonVo> getCommonListOrderByValue(Integer groupCode);

	/** 공통코드 추가 */
	public int insertCommon(CommonVo vo);

	/** 공통코드 수정 */
	public int updateCommon(CommonVo vo);

	/** 공통코드 삭제 */
	public int deleteCommon(CommonVo vo);

	/** 배송업체 관리 리스트 */
	public List<CommonVo> getDeliveryList(DeliCompanyVo vo);

	/** 배송업체 관리 추가 */
	public int insertDelivery(DeliCompanyVo vo);

	/** 배송업체 관리 수정 */
	public int updateDelivery(DeliCompanyVo vo);

	/** 배송업체 관리 삭제 */
	public int deleteDelivery(DeliCompanyVo vo);

	/** 배송업체 리스트 */
	public List<DeliCompanyVo> getDeliCompany();

	/** 공지팝업창 관리 */
	public List<NoticePopupVo> getNoticePopupList(NoticePopupVo vo);
	public NoticePopupVo getNoticePopupVo(Integer seq);
	public int createNoticePopupSeq(NoticePopupVo vo);
	public boolean insertNoticePopup(NoticePopupVo vo);
	public boolean updateNoticePopup(NoticePopupVo vo);

	/** 관리자 등급 권한 체크 */
	public boolean checkGrade(String controllerName, String controllerMethod);

	/** 관리자 권한 관리 */
	public List<MemberVo> getAdminGradeList(MemberVo srchVo);

	public int getAdminGradeListCount(MemberVo srchVo);

	public MemberVo getAdminGradeVo(MemberVo vo);

	public boolean insertGradeController(MemberVo vo);

	public boolean updateGradeController(MemberVo vo);

	public boolean deleteGradeController(MemberVo vo);

	public List<MemberVo> getControllerName();

	public void defaultFlag(MemberVo vo);

	

	/** 공통코드 그룹명 가져오기 */
	public List<CommonVo> getGroupName();

	/** 공통코드 명 가져오기 */
	public String getCommonName(CommonVo vo);

	
	public List<PaymethodVo> getPaymethodFeeList();
	
	public int insertPaymethodFee(PaymethodVo vo);
	
	public int updatePaymethodFee(PaymethodVo vo);
	
	public int deletePaymethodFee(PaymethodVo vo);
}