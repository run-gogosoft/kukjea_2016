package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.MallService;
import com.smpro.service.MemberService;
import com.smpro.service.SmsService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.EditorUtil;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

@Controller
public class SystemController {
	@Resource(name = "systemService")
	private SystemService systemService;

	@Resource(name = "mallService")
	private MallService mallService;

	@Resource(name = "memberService")
	private MemberService memberService;

	@Resource(name = "smsService")
	private SmsService smsService;

	@CheckGrade(controllerName = "systemController", controllerMethod = "list")
	/** 관리자 리스트 */
	@RequestMapping("/system/admin/list")
	public String list(Model model) {
		model.addAttribute("list", systemService.getAdminList());
		model.addAttribute("title", "관리자");
		return "/system/admin_list.jsp";
	}

	@CheckGrade(controllerName = "systemController", controllerMethod = "view")
	/** 관리자 상세 정보 */
	@RequestMapping("/system/admin/view/{seq}")
	public String view(@PathVariable Integer seq, AdminVo vo, Model model) {
		vo.setSeq(seq);
		model.addAttribute("vo", systemService.getAdminData(vo));
		model.addAttribute("title", "관리자 상세정보");
		return "/system/admin_view.jsp";
	}

	/**
	 * 관리자 등록 폼 페이지
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "insertForm")
	@RequestMapping("/system/admin/insert/form")
	public static String insertForm(Model model) {
		model.addAttribute("title", "관리자 등록");
		return "/system/admin_insert_form.jsp";
	}

	/**
	 * 관리자 등록
	 */
	@RequestMapping("/system/admin/insert")
	public String insert(AdminVo vo, HttpSession session, Model model)
			throws Exception {

		/* 비밀번호 암호화 */
		try {
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		} catch (NoSuchAlgorithmException e) {
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다");
			return Const.ALERT_PAGE;
		}

		// small에서는 택배사 유형이 없기때문에 type_code필드를 무조건 A(어드민)으로 강제한다.
		vo.setTypeCode("A");
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		/* 관리자 등록 */
		if (systemService.insertData(vo) > 0) {
			model.addAttribute("message", "등록 성공.");
			model.addAttribute("returnUrl", "/admin/system/admin/list/");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "등록 실패.");
		return Const.ALERT_PAGE;

	}

	/**
	 * 관리자 정보 수정 폼 페이지
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "form")
	@RequestMapping("/system/admin/form/{seq}")
	public String form(@PathVariable Integer seq, AdminVo vo, Model model) {
		vo.setSeq(seq);
		model.addAttribute("vo", systemService.getAdminData(vo));
		model.addAttribute("title", "관리자 정보 수정");
		return "/system/admin_update_form.jsp";
	}

	/**
	 * 관리자 정보 수정
	 */
	@RequestMapping("/system/admin/modify")
	public String update(AdminVo vo, HttpSession session, Model model)
			throws Exception {
		// todo 입력값 검증 필요
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		if (systemService.updateData(vo)) {
			model.addAttribute("message", "수정 성공.");
			model.addAttribute("returnUrl",	"/admin/system/admin/view/" + vo.getSeq());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "수정 실패.");
		return Const.ALERT_PAGE;

	}

	/**
	 * 비밀번호 변경
	 */
	@RequestMapping("/system/admin/password/update/ajax")
	public String updateAdminPassword(AdminVo vo, Model model) {
		/* 입력값 검증 */
		if (systemService.getSeqCnt(vo.getSeq()) < 1) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "잘못된 접근 입니다.");
			return "/ajax/get-message-result.jsp";
		}
		if (StringUtil.isBlank(vo.getPassword())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "변경할 비밀번호를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		if (StringUtil.isBlank(vo.getNewPassword())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "기존 비밀번호를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 비밀번호 암호화 */
		try {
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
			vo.setNewPassword(StringUtil.encryptSha2(vo.getNewPassword()));
		} catch (NoSuchAlgorithmException e) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다");
			return "/ajax/get-message-result.jsp";
		}

		/* 비밀번호 변경 */
		if (systemService.updatePassword(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "비밀번호가 정상적으로 변경되었습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "비밀번호 변경에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 회원 비밀번호 변경
	 */
	@RequestMapping("/system/member/password/update/ajax")
	public String updateMemberPassword(MemberVo vo, Model model) {
		/* 입력값 검증 */
		if (systemService.getSeqCnt(vo.getSeq()) < 1) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "잘못된 접근 입니다.");
			return "/ajax/get-message-result.jsp";
		}
		if (StringUtil.isBlank(vo.getNewPassword())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "기존 비밀번호를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		if (!vo.getNewPassword().equals(vo.getPassword())) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "비밀번호 확인이 다릅니다.");
			return "/ajax/get-message-result.jsp";
		}

		/* 비밀번호 암호화 */
		try {
			vo.setNewPassword(StringUtil.encryptSha2(vo.getNewPassword()));
		} catch (NoSuchAlgorithmException e) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다");
			return "/ajax/get-message-result.jsp";
		}

		/* 비밀번호 변경 */
		if (memberService.updateMemberPassword(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "비밀번호가 정상적으로 변경되었습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "비밀번호 변경에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 아이디 중복 체크
	 */
	@RequestMapping("/system/check/id/ajax")
	public String checkId(@RequestParam String id, Model model) {
		/* 입력값 검증 */
		if (StringUtil.isBlank(id)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(id) > 50) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(id) < 4) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 4자 이상 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (!id.matches("^[a-z0-9._-]*$")) {
			model.addAttribute("message", "아이디는 영소문자/숫자/._-만 가능 합니다.");
			return "/ajax/get-message-result.jsp";
		}

		/* 아이디 중복 체크 */
		MemberVo vo = new MemberVo();
		vo.setId(id);
		vo.setTypeCode("A");
		if (systemService.getIdCnt(vo) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "사용가능한 아이디입니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 쇼핑몰 아이디 중복 체크
	 */
	@RequestMapping("/system/check/mall/id/ajax")
	public String checkMallId(@RequestParam String id, Model model) {
		/* 입력값 검증 */
		if (StringUtil.isBlank(id)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(id) > 20) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디가 20자를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(id) < 2) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 2자 이상 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 아이디 중복 체크 */
		MemberVo vo = new MemberVo();
		vo.setId(id);
		if (systemService.getIdCnt(vo) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "사용가능한 아이디입니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 닉네임 체크
	 */
	@RequestMapping("/system/check/nickname/ajax")
	public String checkNickName(@RequestParam String nickname, Model model) {
		/* 입력값 검증 */
		if (StringUtil.isBlank(nickname)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "내용을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(nickname) > 50) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "50Bytes를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		/* 닉네임 중복 체크 */
		if (memberService.getNickNameCnt(nickname) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "사용가능 합니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 사용중 입니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 공통 코드 리스트
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "getCommonList")
	@RequestMapping("/system/common/list")
	public String getCommonList(CommonVo vo, Model model) {

		model.addAttribute("groupNameList", systemService.getGroupName());
		model.addAttribute("list", systemService.getCommonList(vo));
		model.addAttribute("vo", vo);
		model.addAttribute("title", "공통코드 관리");
		return "/system/common_list.jsp";
	}

	/**
	 * 공통 코드 등록
	 */
	@RequestMapping("/system/common/insert/ajax")
	public String insertCommon(CommonVo vo, Model model) {
		/* 입력값 검증 */
		// 결과 실패로 초기화
		model.addAttribute("result", "false");
		// 그룹명
		if (StringUtil.isBlank(vo.getGroupName())) {
			model.addAttribute("message", "그룹명을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getGroupName()) > 100) {
			model.addAttribute("message", "그룹명을 100Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 값
		if (StringUtil.isBlank(vo.getValue())) {
			model.addAttribute("message", "값을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getValue()) > 20) {
			model.addAttribute("message", "값을 20자 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 명칭
		if (StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "명칭을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getName()) > 100) {
			model.addAttribute("message", "명칭을 100Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 등록 */
		if (systemService.insertCommon(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "정상적으로 등록되었습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", "등록을 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 공통 코드 수정
	 */
	@RequestMapping("/system/common/update/ajax")
	public String updateCommon(CommonVo vo, Model model) {
		/* 입력값 검증 */
		// 결과 실패로 초기화
		model.addAttribute("result", "false");
		// 그룹명
		if (StringUtil.isBlank(vo.getGroupName())) {
			model.addAttribute("message", "그룹명을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getGroupName()) > 100) {
			model.addAttribute("message", "그룹명을 100Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 값
		if (StringUtil.isBlank(vo.getValue())) {
			model.addAttribute("message", "값을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getValue()) > 20) {
			model.addAttribute("message", "값을 20자 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 명칭
		if (StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "명칭을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getName()) > 100) {
			model.addAttribute("message", "명칭을 100Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 등록 */
		if (systemService.updateCommon(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", vo.getSeq() + "번 코드를 정상적으로 수정하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", vo.getSeq() + "번 코드의 수정에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 공통 코드 삭제
	 */
	@RequestMapping("/system/common/delete/ajax")
	public String deleteCommon(CommonVo vo, Model model) {
		/* 등록 */
		if (systemService.deleteCommon(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", vo.getSeq() + "번 코드를 정상적으로 삭제하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", vo.getSeq() + "번 코드의 수정에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}
	
	/**
	 * 결제수단별 수수료 관리 리스트
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "getPaymethodFeeList")
	@RequestMapping("/system/paymethod/fee/list")
	public String getPaymethodFeeList(Model model) {
		model.addAttribute("list", systemService.getPaymethodFeeList());
		model.addAttribute("title", "결제수단별 수수료 관리");
		return "/system/paymethod_fee_list.jsp";
	}
	
	/**
	 * 결제수단별 수수료 관리 등록
	 */
	@RequestMapping("/system/paymethod/fee/insert/ajax")
	public String insertFee(PaymethodVo vo, Model model) {
		/* 입력값 검증 */
		// 결과 실패로 초기화
		model.addAttribute("result", "false");
		// 결제수단명
		if (StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "결제수단명을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getName()) > 100) {
			model.addAttribute("message", "결제수단명을 100Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} 
		
		if (StringUtil.isBlank(vo.getValue())) {
			model.addAttribute("message", "값을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getValue()) > 20) {
			model.addAttribute("message", "값을 20자 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 수수료
		if (StringUtil.isBlank(""+vo.getFeeRate1())) {
			model.addAttribute("message", "수수료1을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		if (StringUtil.isBlank(""+vo.getFeeRate2())) {
			model.addAttribute("message", "수수료2를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 등록 */
		if (systemService.insertPaymethodFee(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "정상적으로 등록되었습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", "등록을 실패하였습니다.");
		return "/ajax/get-message-result.jsp";
	}
	
	/**
	 * 결제수단별 수수료 관리 수정
	 */
	@RequestMapping("/system/paymethod/fee/update/ajax")
	public String updateFee(PaymethodVo vo, Model model) {
		/* 입력값 검증 */
		// 결과 실패로 초기화
		model.addAttribute("result", "false");
		// 결제수단명
		if (StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "결제수단명을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getName()) > 100) {
			model.addAttribute("message", "결제수단명을 100Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} 
		
		if (StringUtil.isBlank(vo.getValue())) {
			model.addAttribute("message", "값을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getValue()) > 20) {
			model.addAttribute("message", "값을 20자 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 수수료
		if (StringUtil.isBlank(""+vo.getFeeRate1())) {
			model.addAttribute("message", "수수료1을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		if (StringUtil.isBlank(""+vo.getFeeRate2())) {
			model.addAttribute("message", "수수료2를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 등록 */
		if (systemService.updatePaymethodFee(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", vo.getSeq() + "번 코드를 정상적으로 수정하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", vo.getSeq() + "번 코드의 수정에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 결제수단별 수수료 관리 삭제
	 */
	@RequestMapping("/system/paymethod/fee/delete/ajax")
	public String deleteFee(PaymethodVo vo, Model model) {
		/* 등록 */
		if (systemService.deletePaymethodFee(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", vo.getSeq() + "번 코드를 정상적으로 삭제하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", vo.getSeq() + "번 코드의 수정에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 허용되지 않는 접근 알림
	 */
	@RequestMapping("/system/alert/auth")
	public static String alertAuth(Model model) {
		model.addAttribute("message", "허용되지 않는 접근입니다.");
		return Const.ALERT_PAGE;
	}

	/**
	 * 공지 팝업창 리스트
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "getNoticePopupForm")
	@RequestMapping("/system/notice/popup/list")
	public String getNoticePopupList(NoticePopupVo vo, Model model) {
		MallVo mvo = new MallVo();
		model.addAttribute("title", "공지 팝업창리스트");
		model.addAttribute("mall", mallService.getList(mvo));
		model.addAttribute("list", systemService.getNoticePopupList(vo));
		model.addAttribute("vo", vo);
		return "/system/notice_popup_list.jsp";
	}

	/**
	 * 공지 팝업창 등록 폼
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "getNoticePopupForm")
	@RequestMapping("/system/notice/popup/form")
	public String getNoticePopupInsertForm(Model model) {
		model.addAttribute("title", "공지 팝업창 등록");
		model.addAttribute("mall", mallService.getListSimple());
		return "/system/notice_popup_form.jsp";
	}

	/**
	 * 공지 팝업창 수정 폼
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "getNoticePopupForm")
	@RequestMapping("/system/notice/popup/edit/form/{seq}")
	public String getNoticePopupEditForm(@PathVariable Integer seq, Model model) {
		model.addAttribute("title", "공지 팝업창 수정");
		model.addAttribute("mall", mallService.getListSimple());
		model.addAttribute("vo", systemService.getNoticePopupVo(seq));
		return "/system/notice_popup_form.jsp";
	}

	/**
	 * 공지 팝업창 등록
	 */
	@RequestMapping("/system/notice/popup/reg/proc")
	public String getNoticePopupWriteProc(NoticePopupVo vo, Model model) {
		if (vo.getTitle().length() != 0 && (vo.getTitle().length() > 30)) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getTitle().length() == 0 && "".equals(vo.getTitle())) {
			model.addAttribute("message", "제목이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getWidth() == 0) {
			model.addAttribute("message", "가로값이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getHeight() == 0) {
			model.addAttribute("message", "세로값이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getStatusCode().length() == 0 && "".equals(vo.getStatusCode())) {
			model.addAttribute("message", "상태가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getContentHtml().length() == 0 && "".equals(vo.getContentHtml())) {
			model.addAttribute("message", "내용이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		
		//시퀀스 생성
		systemService.createNoticePopupSeq(vo);
		
		//에디터상에서 업로드한 임시 이미지 파일을 정식 등록 처리
		vo.setContentHtml(EditorUtil.procImage(vo.getContentHtml(), vo.getSeq(), "notice_popup"));
				
		if (!systemService.insertNoticePopup(vo)) {
			model.addAttribute("message", "게시물을 등록할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("returnUrl", "/admin/system/notice/popup/list");
		model.addAttribute("message", "게시물이 등록 되었습니다.");
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 공지 팝업창 수정
	 */
	@RequestMapping("/system/notice/popup/mod/proc")
	public String getNoticePopupEditProc(NoticePopupVo vo, Model model) {
		if (vo.getTitle().length() != 0 && (vo.getTitle().length() > 30)) {
			model.addAttribute("message", "제목 입력값이 초과되었습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getTitle().length() == 0 && "".equals(vo.getTitle())) {
			model.addAttribute("message", "제목이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getWidth() == 0) {
			model.addAttribute("message", "가로값이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getHeight() == 0) {
			model.addAttribute("message", "세로값이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getStatusCode().length() == 0 && "".equals(vo.getStatusCode())) {
			model.addAttribute("message", "상태가 선택되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		if (vo.getContentHtml().length() == 0 && "".equals(vo.getContentHtml())) {
			model.addAttribute("message", "내용이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		//에디터상에서 업로드한 임시 이미지 파일을 정식 등록 처리
		vo.setContentHtml(EditorUtil.procImage(vo.getContentHtml(), vo.getSeq(), "notice_popup"));

				
		if (!systemService.updateNoticePopup(vo)) {
			model.addAttribute("message", "게시물을 수정할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("returnUrl", "/admin/system/notice/popup/list");
		model.addAttribute("message", "게시물이 수정 되었습니다.");
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 관리자 등급 관리 리스트
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "gradeList")
	@RequestMapping("/system/grade/manage/list")
	public String gradeList(MemberVo vo, Model model) {
		model.addAttribute("title", "관리자 등급 관리");

		model.addAttribute("controllerNameList",
				systemService.getControllerName());
		vo.setTotalRowCount(systemService.getAdminGradeListCount(vo));
		model.addAttribute("list", systemService.getAdminGradeList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		model.addAttribute("vo", vo);
		return "/system/grade_manage_list.jsp";
	}

	/**
	 * 관리자 등급 관리 등록 폼
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "gradeForm")
	@RequestMapping("/system/grade/manage/form")
	public static String gradeForm(Model model) {
		model.addAttribute("title", "관리자 등급 등록");
		return "/system/grade_manage_form.jsp";
	}

	/**
	 * 관리자 등급 컨트롤러 등록
	 */
	@RequestMapping("/system/grade/manage/write/proc")
	public String gradeWriteProc(MemberVo vo, Model model) {
		/* 입력값 검증 추가 할 것 */
		if (vo.getControllerName().length() == 0 && "".equals(vo.getControllerName())) {
			model.addAttribute("message", "컨트롤러 이름이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		if (vo.getControllerMethod().length() == 0 && "".equals(vo.getControllerMethod())) {
			model.addAttribute("message", "컨트롤러 메소드 이름이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		/* 등록 */
		if (!systemService.insertGradeController(vo)) {
			model.addAttribute("message", "등록을 실패 하였습니다.");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "등록 되었습니다.");
		model.addAttribute("returnUrl",	"/admin/system/grade/manage/list?controllerName=" + vo.getControllerName());
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 관리자 등급 관리 수정 폼
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "gradeEdit")
	@RequestMapping("/system/grade/manage/edit/{seq}")
	public String gradeEdit(@PathVariable Integer seq, MemberVo vo, Model model) {
		model.addAttribute("title", "관리자 등급 수정");
		vo.setSeq(seq);
		model.addAttribute("vo", systemService.getAdminGradeVo(vo));
		return "/system/grade_manage_form.jsp";
	}

	/**
	 * 관리자 등급 관리 수정
	 */
	@RequestMapping("/system/grade/manage/edit/proc/{seq}")
	public String gradeEditProc(@PathVariable Integer seq, MemberVo vo,
			Model model) {
		/* 입력값 검증 추가 할 것 */
		if (vo.getControllerName().length() == 0 && "".equals(vo.getControllerName())) {
			model.addAttribute("message", "컨트롤러 이름이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}
		if (vo.getControllerMethod().length() == 0 && "".equals(vo.getControllerMethod())) {
			model.addAttribute("message", "컨트롤러 메소드 이름이 입력되지 않았습니다.");
			return Const.ALERT_PAGE;
		}

		vo.setSeq(seq);
		/* 수정 */
		if (!systemService.updateGradeController(vo)) {
			model.addAttribute("message", "수정을 실패 하였습니다.");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "수정 되었습니다.");
		model.addAttribute("returnUrl", "/admin/system/grade/manage/list?controllerName="+ vo.getControllerName());
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 관리자 등급 관리 삭제
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "delProc")
	@RequestMapping("/system/grade/manage/del/proc/{seq}")
	public String delProc(MemberVo vo, @PathVariable Integer seq, Model model) {
		vo.setSeq(seq);

		if (!systemService.deleteGradeController(vo)) {
			model.addAttribute("message", "삭제할 수 없었습니다");
			model.addAttribute("returnUrl", "/admin/system/grade/manage/list");
			return Const.REDIRECT_PAGE;
		}
		model.addAttribute("message", "삭제 되었습니다");
		model.addAttribute("returnUrl", "/admin/system/grade/manage/list");

		return Const.REDIRECT_PAGE;
	}

	/**
	 * 배송업체 관리 리스트
	 */
	@CheckGrade(controllerName = "systemController", controllerMethod = "getDeliveryList")
	@RequestMapping("/system/delivery/list")
	public String getDeliveryList(DeliCompanyVo vo, Model model) {
		model.addAttribute("list", systemService.getDeliveryList(vo));
		model.addAttribute("title", "배송업체 관리");
		return "/system/delivery_list.jsp";
	}

	/**
	 * 배송업체 관리 등록
	 */
	@RequestMapping("/system/delivery/insert/ajax")
	public String insertDelivery(DeliCompanyVo vo, Model model) {
		/* 입력값 검증 */
		// 결과 실패로 초기화
		model.addAttribute("result", "false");
		// 업체명
		if (StringUtil.isBlank(vo.getDeliCompanyName())) {
			model.addAttribute("message", "업체 명을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getDeliCompanyName()) > 60) {
			model.addAttribute("message", "업체 명을 60Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 값
		if (StringUtil.isBlank(vo.getDeliCompanyTel())) {
			model.addAttribute("message", "전화번호을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getDeliCompanyTel()) > 20) {
			model.addAttribute("message", "전화번호을 20Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 명칭
		if (StringUtil.isBlank(vo.getDeliTrackUrl())) {
			model.addAttribute("message", "송장조회 URL을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getDeliTrackUrl()) > 200) {
			model.addAttribute("message", "송장조회 URL을 200Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 등록 */
		if (systemService.insertDelivery(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "정상적으로 등록되었습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", "등록을 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 배송업체 관리 수정
	 */
	@RequestMapping("/system/delivery/update/ajax")
	public String updateDelivery(DeliCompanyVo vo, Model model) {
		/* 입력값 검증 */
		// 결과 실패로 초기화
		model.addAttribute("result", "false");
		// 업체명
		if (StringUtil.isBlank(vo.getDeliCompanyName())) {
			model.addAttribute("message", "업체 명을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if (StringUtil.getByteLength(vo.getDeliCompanyName()) > 60) {
			model.addAttribute("message", "업체 명을 60Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 값
		if (StringUtil.getByteLength(vo.getDeliCompanyTel()) > 20) {
			model.addAttribute("message", "전화번호를 20Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		// 명칭
		if (StringUtil.getByteLength(vo.getDeliTrackUrl()) > 200) {
			model.addAttribute("message", "송장조회 URL을 200Bytes 이하로 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* 등록 */
		if (systemService.updateDelivery(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", vo.getDeliSeq()
					+ "번 배송업체를 정상적으로 수정하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", vo.getDeliSeq() + "번 배송업체의 수정에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 배송업체 관리 삭제
	 */
	@RequestMapping("/system/delivery/delete/ajax")
	public String deleteDelivery(DeliCompanyVo vo, Model model) {
		/* 등록 */
		if (systemService.deleteDelivery(vo) > 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", vo.getDeliSeq()
					+ "번 배송업체를 정상적으로 삭제하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("message", vo.getDeliSeq() + "번 배송업체의 삭제에 실패하였습니다.");
		return "/ajax/get-message-result.jsp";

	}

	/**
	 * 회원 탈퇴하기 기능
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	@RequestMapping("/system/member/leave")
	public String leaveMember(Integer seq, Model model) {
		MemberVo vo = new MemberVo();
		vo.setSeq(seq);
		vo.setStatusCode("X");

		MemberVo mvo = new MemberVo();
		try {
			mvo = memberService.getData(seq);
		} catch (Exception e) {
			model.addAttribute("message", "회원 탈퇴에 실패했습니다.");
			e.printStackTrace();
			return "/ajax/get-message-result.jsp";
		}
		String name = mvo.getName().substring(0, 1);
		for (int i = 1; i < mvo.getName().length(); i++) {
			name += "*";
		}
		vo.setName(name);

		String id = mvo.getId().substring(0, 3);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		GregorianCalendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, 0);
		id += "*" + dateFormat.format(cal.getTime());

		vo.setId(id);

		try {
			if (memberService.modData(vo) && memberService.leaveMember(seq)) {
				model.addAttribute("result", "true");
				model.addAttribute("message", "회원 탈퇴에 성공했습니다.");
			} else {
				TransactionAspectSupport.currentTransactionStatus()
						.setRollbackOnly();
				model.addAttribute("message", "회원 탈퇴에 실패했습니다.");
			}
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus()
					.setRollbackOnly();
			model.addAttribute("message", "회원 탈퇴에 실패했습니다.");
			e.printStackTrace();
		}

		return "/ajax/get-message-result.jsp";
	}

	@RequestMapping("/system/search/member/ajax")
	public String getSearchForAjax(MemberVo vo, Model model)
			throws UnsupportedEncodingException, InvalidKeyException {

		model.addAttribute("list", memberService.getSearchMemberList(vo));
		return "/ajax/get-member-list.jsp";
	}
}
