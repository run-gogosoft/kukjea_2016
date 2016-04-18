package com.smpro.dao;

import com.smpro.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SystemDaoImpl implements SystemDao {
	@Autowired
	private SqlSession sqlSession;

	/** 관리자 리스트 */
	@Override
	public List<AdminVo> getAdminList() {
		return sqlSession.selectList("admin.getAdminList");
	}

	/** 관리자 상세 */
	@Override
	public AdminVo getAdminData(AdminVo vo) {
		return sqlSession.selectOne("admin.getAdminData", vo);
	}

	/** 관리자 등록 */
	@Override
	public int insertData(AdminVo vo) {
		return sqlSession.insert("admin.insertData", vo);
	}

	/** 관리자 정보 수정 - sm_user */
	@Override
	public int updateDataUser(AdminVo vo) {
		return sqlSession.update("admin.updateDataUser", vo);
	}

	/** 관리자 정보 수정 - sm_admin */
	@Override
	public int updateDataAdmin(AdminVo vo) {
		return sqlSession.update("admin.updateDataAdmin", vo);
	}

	/** 관리자 계정 존재여부 검사 */
	@Override
	public int getSeqCnt(Integer seq) {
		return ((Integer) sqlSession.selectOne("admin.getSeqCnt", seq)).intValue();
	}

	@Override
	public List<CommonVo> getCommonList(CommonVo vo) {
		return sqlSession.selectList("system.getCommonList", vo);
	}

	@Override
	public List<CommonVo> getCommonListByGroup(Integer groupCode) {
		return sqlSession.selectList("system.getCommonListByGroup", groupCode);
	}
	
	@Override
	public List<CommonVo> getCommonListOrderByValue(Integer groupCode) {
		return sqlSession.selectList("system.getCommonListOrderByValue", groupCode);
	}

	/** 공통코드 추가 */
	@Override
	public int insertCommon(CommonVo vo) {
		return sqlSession.insert("system.insertCommon", vo);
	}

	/** 공통코드 수정 */
	@Override
	public int updateCommon(CommonVo vo) {
		return sqlSession.update("system.updateCommon", vo);
	}

	/** 공통코드 삭제 */
	@Override
	public int deleteCommon(CommonVo vo) {
		return sqlSession.delete("system.deleteCommon", vo);
	}

	/** 배송업체 관리 리스트 */
	@Override
	public List<CommonVo> getDeliveryList(DeliCompanyVo vo) {
		return sqlSession.selectList("system.getDeliveryList", vo);
	}

	/** 배송업체 관리 추가 */
	@Override
	public int insertDelivery(DeliCompanyVo vo) {
		return sqlSession.insert("system.insertDelivery", vo);
	}

	/** 배송업체 관리 수정 */
	@Override
	public int updateDelivery(DeliCompanyVo vo) {
		return sqlSession.update("system.updateDelivery", vo);
	}

	/** 배송업체 관리 삭제 */
	@Override
	public int deleteDelivery(DeliCompanyVo vo) {
		return sqlSession.delete("system.deleteDelivery", vo);
	}

	/** 배송업체 리스트 */
	@Override
	public List<DeliCompanyVo> getDeliCompany() {
		return sqlSession.selectList("system.getDeliCompany");
	}

	/** 공지팝업창 관리 */
	@Override
	public NoticePopupVo getNoticePopupVo(Integer seq) {
		return sqlSession.selectOne("system.getNoticePopupVo", seq);
	}

	/** 공지팝업창 수정 */
	@Override
	public int updateNoticePopup(NoticePopupVo vo) {
		return sqlSession.update("system.updateNoticePopup", vo);
	}

	/** 관리자 권한 체크 */
	@Override
	public String getControllerAuth(MemberVo vo) {
		return sqlSession.selectOne("system.getControllerAuth", vo);
	}

	/** 관리자 권한 관리 */
	@Override
	public List<MemberVo> getAdminGradeList(MemberVo srchVo) {
		return sqlSession.selectList("system.getAdminGradeList", srchVo);
	}

	@Override
	public int getAdminGradeListCount(MemberVo srchVo) {
		return ((Integer) sqlSession.selectOne("system.getAdminGradeListCount", srchVo)).intValue();
	}

	@Override
	public MemberVo getAdminGradeVo(MemberVo vo) {
		return sqlSession.selectOne("system.getAdminGradeVo", vo);
	}

	@Override
	public int insertGradeController(MemberVo vo) {
		return sqlSession.insert("system.insertGradeController", vo);
	}

	@Override
	public int updateGradeController(MemberVo vo) {
		return sqlSession.update("system.updateGradeController", vo);
	}

	@Override
	public int deleteGradeController(MemberVo vo) {
		return sqlSession.delete("system.deleteGradeController", vo);
	}

	@Override
	public List<MemberVo> getControllerName() {
		return sqlSession.selectList("system.getControllerName");
	}

	@Override
	public int createNoticePopupSeq(NoticePopupVo vo) {
		return sqlSession.update("system.createNoticePopupSeq", vo);
	}
	
	@Override
	public int insertNoticePopup(NoticePopupVo vo) {
		return sqlSession.insert("system.insertNoticePopup", vo);
	}

	@Override
	public int insertAdminLog(AdminVo vo) {
		return sqlSession.insert("admin.insertAdminLog", vo);
	}

	@Override
	public List<CommonVo> getGroupName() {
		return sqlSession.selectList("system.getGroupName");
	}

	@Override
	public String getCommonName(CommonVo vo) {
		return sqlSession.selectOne("system.getCommonName", vo);
	}

	@Override
	public List<NoticePopupVo> getNoticePopupList(NoticePopupVo vo) {
		return sqlSession.selectList("system.getNoticePopupList", vo);
	}

	@Override
	public DeliCompanyVo getDeliCompanyVo(Integer deliSeq) {
		return sqlSession.selectOne("system.getDeliCompanyVo", deliSeq);
	}

	@Override
	public List<PaymethodVo> getPaymethodFeeList() {
		return sqlSession.selectList("system.getPaymethodFeeList");
	}

	@Override
	public int insertPaymethodFee(PaymethodVo vo) {
		return sqlSession.insert("system.insertPaymethodFee", vo);
	}

	@Override
	public int updatePaymethodFee(PaymethodVo vo) {
		return sqlSession.update("system.updatePaymethodFee", vo);
	}

	@Override
	public int deletePaymethodFee(PaymethodVo vo) {
		return sqlSession.delete("system.deletePaymethodFee", vo);
	}
}
