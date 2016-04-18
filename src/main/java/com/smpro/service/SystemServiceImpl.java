package com.smpro.service;

import com.smpro.dao.SystemDao;
import com.smpro.dao.UserDao;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class SystemServiceImpl implements SystemService {
	@Autowired
	private SystemDao systemDao;

	@Autowired
	private UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/** 관리자 리스트 */
	public List<AdminVo> getAdminList() {
		return systemDao.getAdminList();
	}

	/** 관리자 상세 */
	public AdminVo getAdminData(AdminVo vo) {
		return systemDao.getAdminData(vo);
	}

	/** 관리자 등록 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertData(AdminVo vo) throws Exception {
		int result = userDao.insertData(vo);
		if (result > 0) {
			result += systemDao.insertData(vo);
			result += systemDao.insertAdminLog(vo);
		}

		// insert 결과가 2가 아닐경우 롤백
		if (result != 3) {
			throw new Exception();
		}

		return result;
	}

	/** 관리자 정보 수정 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean updateData(AdminVo vo) throws Exception {
		int result = 0;
		int equalResult = 2;
		try {
			if (vo.getGradeCode() != systemDao.getAdminData(vo).getGradeCode()) { // 권한이
																					// 변경되었다면
																					// log를
																					// 남긴다.
				result += systemDao.insertAdminLog(vo);
				equalResult = 3;
			}

			result += systemDao.updateDataUser(vo);
			result += systemDao.updateDataAdmin(vo);
		} catch (Exception e) {
			// 중요 : 익셉션을 반드시 던져야지 롤백된다.
			throw e;
		}

		// update 결과가 2가 아닐경우 롤백
		if (result != equalResult) {
			throw new Exception();
		}

		return true;
	}

	/** 관리자 계정 존재여부 검사 */
	public int getSeqCnt(Integer seq) {
		return systemDao.getSeqCnt(seq);
	}

	/** 관리자 아이디 중복 검사 */
	public int getIdCnt(MemberVo vo) {
		return userDao.getIdCnt(vo);
	}

	/** 관리자 비밀번호 변경 */
	public int updatePassword(AdminVo vo) {
		return userDao.updatePassword(vo);
	}

	/** 관리자 시퀀스 생성 */
	/*
	 * public int getSeqNextVal() { return systemDao.getSeqNextVal(); }
	 */

	public List<CommonVo> getCommonList(CommonVo vo) {
		return systemDao.getCommonList(vo);
	}

	public List<CommonVo> getCommonListByGroup(Integer groupCode) {
		return systemDao.getCommonListByGroup(groupCode);
	}
	
	public List<CommonVo> getCommonListOrderByValue(Integer groupCode) {
		return systemDao.getCommonListOrderByValue(groupCode);
	}

	/** 공통코드 추가 */
	public int insertCommon(CommonVo vo) {
		return systemDao.insertCommon(vo);
	}

	/** 공통코드 수정 */
	public int updateCommon(CommonVo vo) {
		return systemDao.updateCommon(vo);
	}

	/** 공통코드 삭제 */
	public int deleteCommon(CommonVo vo) {
		return systemDao.deleteCommon(vo);
	}

	/** 배송업체 관리 리스트 */
	public List<CommonVo> getDeliveryList(DeliCompanyVo vo) {
		return systemDao.getDeliveryList(vo);
	}

	/** 배송업체 관리 추가 */
	public int insertDelivery(DeliCompanyVo vo) {
		return systemDao.insertDelivery(vo);
	}

	/** 배송업체 관리 수정 */
	public int updateDelivery(DeliCompanyVo vo) {
		return systemDao.updateDelivery(vo);
	}

	/** 배송업체 관리 삭제 */
	public int deleteDelivery(DeliCompanyVo vo) {
		return systemDao.deleteDelivery(vo);
	}

	/** 배송업체 리스트 */
	public List<DeliCompanyVo> getDeliCompany() {
		return systemDao.getDeliCompany();
	}

	/** 공지팝업창 관리 */
	public List<NoticePopupVo> getNoticePopupList(NoticePopupVo vo) {
		List<NoticePopupVo> list = systemDao.getNoticePopupList(vo);
		if (list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				NoticePopupVo nvo = list.get(i);
				nvo.setContentHtml(StringUtil.restoreClearXSS(nvo.getContentHtml()));
				// 스크립트 replace
				nvo.setContentHtml(nvo.getContentHtml().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
			}
		}
		return list;
	}
	public NoticePopupVo getNoticePopupVo(Integer seq) {
		NoticePopupVo nvo = systemDao.getNoticePopupVo(seq);
		if (nvo != null) {
			nvo.setContentHtml(nvo.getContentHtml().replace("<script", "<not allow tag").replace("</script>", "</not allow tag>"));
		}
		return nvo;
	}
	public int createNoticePopupSeq(NoticePopupVo vo) {
		return systemDao.createNoticePopupSeq(vo);
	}
	public boolean insertNoticePopup(NoticePopupVo vo) {
		return systemDao.insertNoticePopup(vo) > 0;
	}
	public boolean updateNoticePopup(NoticePopupVo vo) {
		return systemDao.updateNoticePopup(vo) > 0;
	}

	/** 관리자 등급 권한 체크 */
	public boolean checkGrade(String controllerName, String controllerMethod) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		MemberVo mvo = new MemberVo();
		mvo.setLoginType(String.valueOf(request.getSession().getAttribute("loginType")));
		mvo.setGradeCode((Integer) request.getSession(false).getAttribute("gradeCode"));
		mvo.setControllerName(controllerName);
		mvo.setControllerMethod(controllerMethod);

		// 특정 URL들은 예외가 존재하기 때문에 검사를 수행해야 한다
		mvo.setControllerDivision(getControllerDivisionForUrl(request));

		// 권한검증
		return ("Y".equals(systemDao.getControllerAuth(mvo)));
	}

	/**
	 * 여러페이지로 분기하는 Controller Method는 분기 코드가 URL에 붙어 있기 떄문에 분기코드 정보를 얻기 위해
	 * request.getPathInfo()를 사용하여 URL 알아낸다.
	 * 
	 * @param request
	 * @return (controller_division)
	 */
	private String getControllerDivisionForUrl(HttpServletRequest request) {
		String p = request.getPathInfo();
		String returnStatusCode = "";

		if (p.matches("^/board/review/.*")) {
			// 상품추천평일 경우
			return "";
		} else if (p.matches("^/board/.*")) {
			// 나머지 게시판일 경우
			if ((p.split("/").length >= 4) && !"del".equals(p.split("/")[2])) {
				return p.split("/")[3];
			} else if ((p.split("/").length >= 4) && "del".equals(p.split("/")[2])) { // 삭제일경우 url의 주소를split으로 자르면 길이가 다르기 때문에 else if로 한번 더 조건을 건다.
				return p.split("/")[4];
			} else {
				return "";
			}
		} else if (p.matches("^/order/status/update/batch")) {
			// 주문리스트 일괄 상태 변경
			if (Const.RECEIVE_REQUEST_CODE.equals(request.getParameter("updateStatusCode"))) {
				returnStatusCode = Const.RECEIVE_REQUEST_CODE;
			} else if (Const.ORDER_CONFIRM_REQUEST_CODE.equals(request.getParameter("updateStatusCode"))) {
				returnStatusCode = Const.ORDER_CONFIRM_REQUEST_CODE;
			} else if (Const.DELIVERY_REQUEST_CODE.equals(request.getParameter("updateStatusCode"))) {
				returnStatusCode = Const.DELIVERY_REQUEST_CODE;
			}
			return returnStatusCode;
		} else if (p.matches("^/item/batch/update")) {
			// 일괄 상태 변경
			if ("H".equals(request.getParameter("statusCode"))) {
				returnStatusCode = "H";
			} else if ("Y".equals(request.getParameter("statusCode"))) {
				returnStatusCode = "Y";
			} else if ("N".equals(request.getParameter("statusCode"))) {
				returnStatusCode = "N";
			} else if ("S".equals(request.getParameter("statusCode"))) {
				returnStatusCode = "S";
			}
			return returnStatusCode;
		} else {
			return "";
		}
	}

	/** 관리자 권한 관리 */
	public List<MemberVo> getAdminGradeList(MemberVo srchVo) {
		return systemDao.getAdminGradeList(srchVo);
	}

	public int getAdminGradeListCount(MemberVo srchVo) {
		return systemDao.getAdminGradeListCount(srchVo);
	}

	public MemberVo getAdminGradeVo(MemberVo vo) {
		return systemDao.getAdminGradeVo(vo);
	}

	public boolean insertGradeController(MemberVo vo) {
		defaultFlag(vo);
		return systemDao.insertGradeController(vo) > 0;
	}

	public boolean updateGradeController(MemberVo vo) {
		defaultFlag(vo);
		return systemDao.updateGradeController(vo) > 0;
	}

	public boolean deleteGradeController(MemberVo vo) {
		return systemDao.deleteGradeController(vo) > 0;
	}

	public List<MemberVo> getControllerName() {
		return systemDao.getControllerName();
	}

	public void defaultFlag(MemberVo vo) {
		if (!"Y".equals(vo.getAdmin0Flag())) {
			vo.setAdmin0Flag("N");
		}
		if (!"Y".equals(vo.getAdmin1Flag())) {
			vo.setAdmin1Flag("N");
		}
		if (!"Y".equals(vo.getAdmin2Flag())) {
			vo.setAdmin2Flag("N");
		}
		if (!"Y".equals(vo.getAdmin3Flag())) {
			vo.setAdmin3Flag("N");
		}
		if (!"Y".equals(vo.getAdmin4Flag())) {
			vo.setAdmin4Flag("N");
		}
		if (!"Y".equals(vo.getAdmin5Flag())) {
			vo.setAdmin5Flag("N");
		}
		if (!"Y".equals(vo.getAdmin6Flag())) {
			vo.setAdmin6Flag("N");
		}
		if (!"Y".equals(vo.getAdmin7Flag())) {
			vo.setAdmin7Flag("N");
		}
		if (!"Y".equals(vo.getAdmin8Flag())) {
			vo.setAdmin8Flag("N");
		}
		if (!"Y".equals(vo.getAdmin9Flag())) {
			vo.setAdmin9Flag("N");
		}
		if (!"Y".equals(vo.getSellerFlag())) {
			vo.setSellerFlag("N");
		}
		if (!"Y".equals(vo.getDistributorFlag())) {
			vo.setDistributorFlag("N");
		}
	}

	/** 공통코드 그룹명 가져오기 */
	public List<CommonVo> getGroupName() {
		return systemDao.getGroupName();
	}

	/** 공통코드 명 가져오기 */
	public String getCommonName(CommonVo vo) {
		return systemDao.getCommonName(vo);
	}
	
	public List<PaymethodVo> getPaymethodFeeList() {
		return systemDao.getPaymethodFeeList();
	}
	
	public int insertPaymethodFee(PaymethodVo vo) {
		return systemDao.insertPaymethodFee(vo);
	}

	@Override
	public int updatePaymethodFee(PaymethodVo vo) {
		return systemDao.updatePaymethodFee(vo);
	}

	@Override
	public int deletePaymethodFee(PaymethodVo vo) {
		return systemDao.deletePaymethodFee(vo);
	}
}