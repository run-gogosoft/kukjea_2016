package com.smpro.controller.shop;

import com.smpro.service.LoginService;
import com.smpro.service.MailService;
import com.smpro.service.MemberGroupService;
import com.smpro.service.MemberService;
import com.smpro.service.SystemService;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.CommonVo;
import com.smpro.vo.MailVo;
import com.smpro.vo.MallVo;
import com.smpro.vo.MemberGroupVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.UserVo;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

@Controller
public class MemberController {
	@Resource(name="memberService")
	private MemberService memberService;

	@Resource(name="mailService")
	private MailService mailService;

	@Resource(name="loginService")
	private LoginService loginService;
	
	@Resource(name="systemService")
	private SystemService systemService;
	
	@Resource(name = "memberGroupService")
	private MemberGroupService memberGroupService;
	
	/** 회원그룹 페이지 */
	@RequestMapping("/member/group")
	public String regGroup(Model model) {	
		model.addAttribute("title", "회원가입");
		return "/member/group.jsp";
	}

	
	/** 약관동의 페이지 */
	@RequestMapping("/member/start")
	public String regStart(HttpServletRequest request, String memberTypeCode, Model model) {
		HttpSession session = request.getSession();
		String title = "";
		if("C".equals(memberTypeCode)) {
			title = "개인회원";
		} else if("O".equals(memberTypeCode)) {
			title = "기업/시설/단체";
		} else {
			title = "공공기관회원";
		}
		
		//회원 구분값 세션 저장
		session.setAttribute("memberTypeCode", memberTypeCode);
		
		model.addAttribute("title", title + " 회원가입");
		
		return "/member/start.jsp";
	}

	/** 회원가입 폼 페이지 */
	@RequestMapping("/member/reg")
	public String regData(HttpServletRequest request, String allCheckFlag, Model model) {
		//약관 동의 체크
		if(StringUtil.isBlank(allCheckFlag)) {
			model.addAttribute("message", "약관에 모두 동의 해주세요");
			return Const.ALERT_PAGE;
		}
		
		HttpSession session = request.getSession();
		String memberTypeCode = (String)session.getAttribute("memberTypeCode");
		
		if("C".equals(memberTypeCode)) {
			//본인인증 확인을 거쳤는지 체크
			if(session.getAttribute("certKey") == null) {
				model.addAttribute("message", "본인인증(아이핀/휴대폰) 값이 유효하지 않습니다. ");
				return Const.ALERT_PAGE;
			}
			//본인인증 키값으로 중복가입 여부 체크
			if(memberService.checkCnt((String)session.getAttribute("certKey")) > 0) {
				model.addAttribute("message", "이미 가입된 회원입니다.");
				model.addAttribute("returnUrl", "/shop/member/start?memberTypeCode="+memberTypeCode);
				return Const.REDIRECT_PAGE;
			}
			model.addAttribute("title", "개인회원 회원가입");
		} else if("O".equals(memberTypeCode)) {
			model.addAttribute("title", "기업/시설/단체 회원가입");
		} else if("P".equals(memberTypeCode)) {
			model.addAttribute("title", "공공기관회원 회원가입");
		} else {
			model.addAttribute("message", "잘못된 접근입니다.");
			return Const.ALERT_PAGE;
		}
				
		CommonVo cvo = new CommonVo();
		//자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		
		return "/member/reg.jsp";
	}

	/** 회원가입 완료 페이지 */
	@RequestMapping("/member/finish")
	public String regFinish(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String memberTypeCode = (String)session.getAttribute("memberTypeCode");
		
		if("C".equals(memberTypeCode)) {
			model.addAttribute("title", "개인회원 회원가입");
		} else if("O".equals(memberTypeCode)) {
			model.addAttribute("title", "기업/시설/단체 회원가입");
		} else if("P".equals(memberTypeCode)){
			model.addAttribute("title", "공공기관 회원가입");
		} else {
			model.addAttribute("message", "잘못된 접근입니다.");
			return Const.ALERT_PAGE;
		}	
		
		if(session.getAttribute("seq") != null) {
			Integer seq = (Integer)session.getAttribute("seq");
			MemberVo mvo;
			try {
				mvo = memberService.getData(seq);
			} catch(Exception e) {
				model.addAttribute("message", "회원 정보 복호화에 실패했습니다.["+e.getMessage()+"]");
				return Const.ALERT_PAGE;
			}

			model.addAttribute("vo", mvo);
			//세션 초기화
			session.invalidate();
		}
		
		return "/member/finish.jsp";
	}

	/** 회원가입 */
	@RequestMapping(value="/member/reg/proc", method=RequestMethod.POST)
	public String regData(HttpServletRequest request, MemberVo vo, MemberGroupVo gvo, Model model) {
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		boolean flag = false;
		String errMsg = "";
		
		HttpSession session = request.getSession();
		String memberTypeCode = (String)session.getAttribute("memberTypeCode");
		
		if(memberTypeCode == null) {
			model.addAttribute("message", "잘못된 접근입니다.");
			return Const.ALERT_PAGE;
		}	
		vo.setMemberTypeCode(memberTypeCode);
		
		if("C".equals(vo.getMemberTypeCode())) {
			//본인인증 확인을 거쳤는지 체크
			if(session.getAttribute("certKey") == null || session.getAttribute("certName") == null) {
				model.addAttribute("message", "본인인증 값이 유효하지 않습니다.\n\n회원가입을 처음부터 다시 진행해 주시기 바랍니다.");
				return Const.ALERT_PAGE;
			}
			//인증키 저장
			vo.setCertKey( (String)session.getAttribute("certKey") );
			//실명 저장
			vo.setName( (String)session.getAttribute("certName") );
		} 
				
		//개인회원
		if(!memberValidCheck(vo, gvo, model)){
			return Const.ALERT_PAGE;
		}
	
		/* 유저 시퀀스 생성 및 기본값 설정 */
		//유형 (A:관리자,S:입점업체,D:총판,C:회원)
		vo.setTypeCode("C");
		//상태 (H:대기,Y:정상,N:중지,X:폐점/탈퇴)
		vo.setStatusCode("Y");
		//몰시퀀스
		vo.setMallSeq(mallVo.getSeq());
		if(memberService.getIdCnt(vo) > 0) {
			model.addAttribute("message", "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		try {
			int resultGroup = 0;
			/** 공공기관, 기업 회원일 경우는 memberGroup을 사용한다. */
			if("C".equals(vo.getMemberTypeCode())) {
				flag = memberService.regData(vo);
			} else {
				gvo.setName(vo.getGroupName());
				resultGroup = memberGroupService.regVo(gvo);

				if(resultGroup > 0) {
					vo.setGroupSeq(gvo.getSeq());
					flag = memberService.regData(vo);
				}
			}
			
			// 회원가입 메일
			try {
				MailVo mvo = new MailVo();
				mvo.setSubject("[Hknuri] 함께누리 가입을 진심으로 축하드립니다");
				mvo.setText(mailService.getMember(vo.getId(), vo.getName(), request.getSession().getServletContext().getRealPath("/")));
				mvo.setFromUser("hknuri@hknuri.co.kr");
				mvo.setToUser(vo.getEmail());
				mailService.sendMail(mvo);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			if(flag) {
				//회원가입 완료 페이지 이동
				model.addAttribute("message", "회원 가입이 완료되었습니다. 로그인 후 사용해 주시기 바랍니다.");
				//다음페이지에서 가입 정보를 표시해 줄때 회원시퀀스 파라메타 노출을 방지하기 위해 세션에 저장한다.
				request.getSession().setAttribute("seq",vo.getSeq());
				model.addAttribute("returnUrl", "/shop/member/finish");
				return Const.REDIRECT_PAGE;
			}
		} catch(NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			errMsg = "알수 없는 오류가 발생했습니다.";
			flag = false;
		} catch(Exception e) {
			e.printStackTrace();
			flag = false;
			errMsg = "회원 가입에 실패했습니다.";
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;

	}

	/** 관리자 테스트용 회원가입 폼 페이지 */
	@RequestMapping("/member/reg/admin")
	public String regAdminForm(Model model) {
		
		model.addAttribute("title", "관리자 테스트 계정 회원가입");
		return "/member/reg_admin.jsp";
	}

	/** 관리자 테스트용 회원가입 처리 */
	@RequestMapping(value="/member/reg/admin/proc", method=RequestMethod.POST)
	public String regAdminDataForm(HttpServletRequest request, MemberVo vo, Model model) {
		boolean flag;
		String errMsg = "";

		/* 유효성 체크 */
		if(StringUtil.isBlank(vo.getId())) {
			model.addAttribute("message", "아이디를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.getByteLength(vo.getId()) > 50) {
			model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
			return Const.ALERT_PAGE;
		} else if(!vo.getId().matches("^[a-z0-9._-]*$")){
			model.addAttribute("message", "아이디는 영소문자/숫자/._-만 가능 합니다.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "이름을 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(vo.getPassword().length() < 4 || vo.getPassword().length() > 16) {
			model.addAttribute("message", "비밀번호는 4-16자가 되어야 합니다.");
			return Const.ALERT_PAGE;
		} else if(!vo.getPassword().matches("^[a-zA-Z0-9~!@#$%^&*()]*$")){
			model.addAttribute("message", "비밀번호는 영문/숫자/특수문자만 가능 합니다.");
			return Const.ALERT_PAGE;
		}

		/* 유저 시퀀스 생성 및 기본값 설정 */
		vo.setTypeCode("C"); //유형 (A:관리자,S:입점업체,D:총판,C:회원)
		vo.setStatusCode("Y"); //상태 (H:대기,Y:정상,N:중지,X:폐점/탈퇴)
		vo.setMallSeq(((MallVo)request.getAttribute("mallVo")).getSeq());
		if(memberService.getIdCnt(vo) > 0) {
			model.addAttribute("message", "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
			return Const.ALERT_PAGE;
		}

		try {
			flag = memberService.regData(vo);
		} catch(NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			errMsg = "알수 없는 오류가 발생했습니다.";
			flag = false;
		} catch(Exception e) {
			e.printStackTrace();
			flag = false;
			if(e.getMessage() != null && e.getMessage().indexOf("ORA-00001") > -1) {
				errMsg = "아이디가 이미 존재합니다.";
			} else {
				errMsg = "회원 가입에 실패했습니다.";
			}
		}

		if(flag) {
			//회원가입 완료 페이지 이동
			model.addAttribute("message", "회원 가입이 완료되었습니다. 로그인 후 사용해 주시기 바랍니다.");
			//다음페이지에서 가입 정보를 표시해 줄때 회원시퀀스 파라메타 노출을 방지하기 위해 세션에 저장한다.
			request.getSession(true).setAttribute("seq",vo.getSeq());
			model.addAttribute("returnUrl", "/shop/member/finish");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;

	}

	/** 비밀번호 갱신 */
	@RequestMapping(value="/member/password/update", method=RequestMethod.POST)
	public String updatePassword(HttpServletRequest request, UserVo vo, Model model) {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 세션이 만료되었습니다.\n\n재로그인하시기 바랍니다.");
			return Const.ALERT_PAGE;
		}
		
		if("".equals(vo.getPassword())) {
			model.addAttribute("message", "기존 비밀번호를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if("".equals(vo.getNewPassword())) {
			model.addAttribute("message", "새 비밀번호를 입력해주세요.");
			return Const.ALERT_PAGE;
		} else if(vo.getNewPassword().length() < 8 || vo.getNewPassword().length() > 16) {
			model.addAttribute("message", "새 비밀번호는 8~16자가 되어야 합니다.");
			return Const.ALERT_PAGE;
		} else if(!vo.getNewPassword().matches("^[a-zA-Z0-9~!@#$%^&*()]*$")){
			model.addAttribute("message", "새 비밀번호는 영문/숫자/특수문자만 가능 합니다.");
			return Const.ALERT_PAGE;
		}
		
		//기존 비밀번호가 인증되어야 변경할 수 있다.
		vo.setLoginType((String)session.getAttribute("loginType"));
		vo.setId((String)session.getAttribute("loginId"));
		try {
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			model.addAttribute("message", "기존 비밀번호 암호화 처리 중 문제가 발생하였습니다.");
			return Const.ALERT_PAGE;
		}
		if(loginService.getData(vo)==null) {
			model.addAttribute("message", "기존 비밀번호가 틀렸습니다.");
			return Const.ALERT_PAGE;
		}

		//새 비밀번호로 갱신
		vo.setSeq((Integer)session.getAttribute("loginSeq"));
		try {
			vo.setNewPassword(StringUtil.encryptSha2(vo.getNewPassword()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			model.addAttribute("message", "새 비밀번호 암호화 처리 중 문제가 발생하였습니다.");
			return Const.ALERT_PAGE;
		}
		if(memberService.updatePassword(vo) == 1) {
			model.addAttribute("message", "비밀번호 변경이 완료되었습니다.");
			model.addAttribute("callback", "Y");
			//비밀번호 변경이 완료되었으므로 현재 세션에서 팝업창을 띄우지 않는다.
			session.setAttribute("notiPasswordFlag", "N");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "비밀번호 변경에 실패했습니다.");
		return Const.ALERT_PAGE;
	}
	
	/** 비밀번호 갱신 유예*/
	@RequestMapping("/member/password/update/delay")
	public String updatePasswordDelay(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "로그인 세션이 만료되었습니다.\n\n재로그인하시기 바랍니다.");
			return Const.ALERT_PAGE;
		}
		
		if(memberService.updatePasswordDelay((Integer)session.getAttribute("loginSeq")) == 1) {
			//비밀번호 갱신이 유예 되었으므로 현재 세션에서 팝업창을 띄우지 않는다.
			session.setAttribute("notiPasswordFlag", "N");
		}
		return Const.AJAX_PAGE;
		
	}
	
	/** 비밀번호 찾기 */
	@RequestMapping(value="/member/password/proc", method=RequestMethod.POST)
	public String getPassword(UserVo vo, HttpServletRequest request, Model model) {

		if(StringUtil.isBlank(vo.getName())) {
			model.addAttribute("message", "이름을 입력해 주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getEmail())) {
			model.addAttribute("message", "이메일을 입력해 주세요.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(vo.getId())) {
			model.addAttribute("message", "아이디를 입력해 주세요.");
			return Const.ALERT_PAGE;
		}
		/* encrypt하기전의 이메일을 저장한다.  */
		String validEmail = vo.getEmail();
		String typeCode = vo.getTypeCode();
		int result = 0;
		try {
			MallVo mallVo = (MallVo)request.getAttribute("mallVo");
			vo.setMallSeq(mallVo.getSeq()); //비밀번호를 찾으려는 현재 쇼핑몰의 시퀀스도 같이 조회한다.

			if(typeCode == null || "".equals(typeCode) || "C".equals(typeCode)) {
				// 일반 사용자일 경우
				result = memberService.updateTempPassword(vo);
			} else if("S".equals(typeCode)) {
				// 셀러일 경우
				result = memberService.updateTempPasswordForSeller(vo);
			} else if("A".equals(typeCode)) {
				// 관리자일 경우
				result = memberService.updateTempPasswordForAdmin(vo);
			} else {
				throw new Exception("존재하지 않는 회원입니다");
			}
		} catch(Exception e) {
			model.addAttribute("message", "오류가 발생했습니다.["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		if(result > 0) {
			try {
				MailVo mvo = new MailVo();
				mvo.setSubject("[Hknuri] 임시 비밀번호를 안내해드립니다.");
				mvo.setText(mailService.getPasswordHtml(vo.getTempPassword(), vo.getName(), request.getSession().getServletContext().getRealPath("/")));
				mvo.setFromUser("hknuri@hknuri.co.kr");
				mvo.setToUser(validEmail);
				mailService.sendMail(mvo);
			} catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "오류가 발생했습니다.");
				return Const.ALERT_PAGE;
			}

			model.addAttribute("message", "임시비밀번호가 생성 및 메일이 발송되었습니다.");
			if(typeCode == null || "".equals(typeCode) || "C".equals(typeCode)) {
				model.addAttribute("returnUrl", "/shop/login");
			} else {
				model.addAttribute("returnUrl", "/admin/login");
			}
			return Const.REDIRECT_PAGE;
		} 

		model.addAttribute("message", "입력하신 정보가 잘못 입력되었거나, 존재하지 않는 정보입니다.");
		return Const.ALERT_PAGE;
	}
	
	/** 아이디 찾기 */
	@RequestMapping(value="/member/id/proc", method=RequestMethod.POST)
	public String getId(UserVo vo, HttpServletRequest request, Model model) {
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		vo.setMallSeq(mallVo.getSeq());
		String email = vo.getEmail();
		String typeCode = vo.getTypeCode();
		String resultId = null;
		try {
			if(typeCode == null || "".equals(typeCode) || "C".equals(typeCode)) {
				// 일반 사용자일 경우
				resultId = memberService.getFindId(vo);
			} else if("S".equals(typeCode)) {
				// 셀러일 경우
				resultId = memberService.getFindIdForSeller(vo);
			} else if("A".equals(typeCode)) {
				resultId = memberService.getFindIdForAdmin(vo);
			} else {
				throw new Exception("존재하지 않는 회원입니다");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "시스템 오류가 발생하였습니다. ["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		if(!StringUtil.isBlank(resultId)) {
			try {
				MailVo mvo = new MailVo();
				mvo.setSubject("[Hknuri] 아이디를 안내해드립니다.");
				mvo.setText(mailService.getIdHtml(resultId, vo.getName(), request.getSession().getServletContext().getRealPath("/")));
				mvo.setFromUser("hknuri@hknuri.co.kr");
				mvo.setToUser(email);
				mailService.sendMail(mvo);
			} catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "오류가 발생했습니다.");
				return Const.ALERT_PAGE;
			}

			model.addAttribute("message", "아이디가 메일로 발송되었습니다.");
			if(typeCode == null || "".equals(typeCode) || "C".equals(typeCode)) {
				model.addAttribute("returnUrl", "/shop/login");
			} else {
				model.addAttribute("returnUrl", "/admin/login");
			}
			return Const.REDIRECT_PAGE;
		} 
		
		model.addAttribute("message", "입력하신 정보가 잘못 입력되었거나, 존재하지 않는 정보입니다.");
		return Const.ALERT_PAGE;
	}
	
	/** 아이디 체크 */
	@RequestMapping("/member/check/id/ajax")
	public String checkId(@RequestParam String id, HttpServletRequest request, HttpSession session, Model model) {
		String memberTypeCode = (String)session.getAttribute("memberTypeCode");
		
		/* 입력값 검증 */
		if(StringUtil.isBlank(id)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if(StringUtil.getByteLength(id) > 50) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		} else if(!id.matches("^[a-z0-9._-]*$")){
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디는 영소문자/숫자/._-만 가능 합니다.");
			return "/ajax/get-message-result.jsp";
		}
		
		if("C".equals(memberTypeCode)) {
			if(StringUtil.getByteLength(id) < 6) {
				model.addAttribute("result", "false");
				model.addAttribute("message", "아이디를 6자 이상 입력해주세요.");
				return "/ajax/get-message-result.jsp";
			}
		} else {
			if(StringUtil.getByteLength(id) < 4) {
				model.addAttribute("result", "false");
				model.addAttribute("message", "아이디를 4자 이상 입력해주세요.");
				return "/ajax/get-message-result.jsp";
			}
		}

		/* 아이디 중복 체크 */
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		MemberVo vo = new MemberVo();
		vo.setId(id);
		vo.setTypeCode("C");
		vo.setMallSeq(mallVo.getSeq());
		if(memberService.getIdCnt(vo) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "사용가능한 아이디입니다.");
			return "/ajax/get-message-result.jsp";
		} 
		
		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
		return "/ajax/get-message-result.jsp";
	}

	/** 테스트 아이디 체크 */
	@RequestMapping("/member/check/test/id/ajax")
	public String checkTestId(@RequestParam String id, HttpServletRequest request, Model model) {
		/* 입력값 검증 */
		if(StringUtil.isBlank(id)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if(StringUtil.getByteLength(id) > 50) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		} else if(!id.matches("^[a-z0-9._-]*$")){
			model.addAttribute("result", "false");
			model.addAttribute("message", "아이디는 영소문자/숫자/._-만 가능 합니다.");
			return "/ajax/get-message-result.jsp";
		}

		/* 아이디 중복 체크 */
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		MemberVo vo = new MemberVo();
		vo.setId(id);
		vo.setTypeCode("C");
		vo.setMallSeq(mallVo.getSeq());
		if(memberService.getIdCnt(vo) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "사용가능한 아이디입니다.");
			return "/ajax/get-message-result.jsp";
		} 
		
		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
		return "/ajax/get-message-result.jsp";
	}
	
	/** 이메일 체크 */
	@RequestMapping("/member/check/email/ajax")
	public String checkEmail(@RequestParam String email, HttpServletRequest request, HttpSession session, Model model) {
		/* 입력값 검증 */
		if(StringUtil.isBlank(email)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "이메일을 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		} else if(StringUtil.getByteLength(email.split("@")[0]) > 30) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "이메일이 30Bytes를 초과하였습니다.");
			return "/ajax/get-message-result.jsp";
		}

		/* 이메일 중복 체크 */
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		MemberVo vo = new MemberVo();
		vo.setName((String)session.getAttribute("loginName"));
		vo.setEmail(email);
		vo.setTypeCode("C");
		vo.setMallSeq(mallVo.getSeq());
		
		try {
			if(memberService.getEmailCnt(vo) == 0) {
				model.addAttribute("result", "true");
				model.addAttribute("message", "사용가능한 이메일입니다.");
				return "/ajax/get-message-result.jsp";
			} 
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "시스템 오류 발생 ["+e.getMessage()+"]");
			return Const.AJAX_PAGE;
		}
		
		
		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 사용중인 이메일입니다. 다른 이메일을 입력해주세요.");
		return "/ajax/get-message-result.jsp";
	}
	
	/** 사업자번호 체크 */
	@RequestMapping("/member/check/bizno/ajax")
	public String checkBizNo(@RequestParam String bizNo, Model model) {
		/* 필수 값 체크 */
		if (StringUtil.isBlank(bizNo)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "사업자 번호를 입력해주세요.");
			return "/ajax/get-message-result.jsp";
		}
		/* 숫자 체크 */
		if (!StringUtil.isNum(bizNo)) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "숫자만 허용됩니다.");
			return "/ajax/get-message-result.jsp";
		}
		/* 길이 체크 */
		if (StringUtil.getByteLength(bizNo) != 10) {
			model.addAttribute("result", "false");
			model.addAttribute("message", "10자리를 입력해 주세요.");
			return "/ajax/get-message-result.jsp";
		}

		/* DB체크 */
		if (memberGroupService.getBizNoCnt(bizNo) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "등록 가능한 사업자번호입니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 등록된 사업자번호입니다.");
		return "/ajax/get-message-result.jsp";

	}
	
	/**
	 * 멤버 정보를 json으로 반환하는 메서드
	 * 반드시 자기 정보만 가져와야 한다.
	 * (타인의 시퀀스에 접근하게 되면 중대한 보안 문제가 생길 수 있음!)
	 *
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/member/json")
	public String getJson(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		// 로그인 되었는지 체크
		if(session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "세션이 만료되었습니다. 재로그인 해주시기 바랍니다.");
			return Const.AJAX_PAGE;
		}
		Integer memberSeq = Integer.valueOf( (""+session.getAttribute("loginSeq")) );
		if(memberSeq == null) {
			model.addAttribute("message", "ERROR");
			return Const.AJAX_PAGE;
		}

		MemberVo mvo;
		try {
			mvo = memberService.getData(memberSeq);
		} catch(Exception e) {
			model.addAttribute("message", "회원 정보 복호화에 실패했습니다.["+e.getMessage()+"]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("vo", mvo);
		return "/ajax/get-member-vo.jsp";
	}
	
	
	/** 회원 탈퇴하기 */
	@Transactional(propagation= Propagation.REQUIRES_NEW)
	@RequestMapping("/close/proc")
	public String memberClose(MemberVo vo, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		boolean flag = false;
		String errMsg = "";

		// 로그인 되었는지 체크
		if(session.getAttribute("loginSeq") == null) {
			model.addAttribute("message", "세션이 만료되었습니다. 재로그인 해주시기 바랍니다.");
			return Const.AJAX_PAGE;
		}

		/* 로그인 seq, type 세션으로부터 가져와서 vo 셋팅 */
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setSeq((Integer)session.getAttribute("loginSeq"));
		vo.setLogLoginSeq((Integer)session.getAttribute("loginSeq"));

		/** statusCode 탈퇴로 설정 */
		vo.setStatusCode("X");

		MemberVo mvo = new MemberVo();
		try {
			mvo = memberService.getData(vo.getSeq());
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "회원탈퇴에 실패하였습니다.");
			return Const.ALERT_PAGE;
		}
		String name = mvo.getName().substring(0, 1);
		for(int i=1; i<mvo.getName().length(); i++){
			name += "*";
		}
		vo.setName(name);

		String id = mvo.getId().substring(0,3);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		GregorianCalendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, 0);
		id += "*" + dateFormat.format(cal.getTime());

		vo.setId(id);

		try {
			MallVo mallVo = (MallVo)request.getAttribute("mallVo");
			vo.setMallSeq(mallVo.getSeq());
			flag = memberService.modData(vo);
			flag = memberService.leaveMember(vo.getSeq());
		} catch (NoSuchAlgorithmException nsae) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			nsae.printStackTrace();
			errMsg = "알 수 없는 오류가 발생했습니다.";
			flag = false;
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			errMsg = "회원탈퇴에 실패하였습니다.";
			flag = false;
		}

		if (flag) {
			//탈퇴 처리되었으므로 세션을 초기화 해준다.
			session.invalidate();
			
			model.addAttribute("message", "탈퇴완료 되었습니다.");
			model.addAttribute("returnUrl", "/shop/login");
			return Const.REDIRECT_PAGE;
		} 
		
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
		
	}

	/** 비밀번호 초기화 */
	@RequestMapping("/member/init/password/ajax")
	public String initPassword(String initId, HttpServletRequest request, Model model) {
		/* 아이디 중복 체크 */
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");

		MemberVo vo = new MemberVo();
		vo.setId(initId);
		vo.setTypeCode("C");
		vo.setMallSeq(mallVo.getSeq());
		if(memberService.getIdCnt(vo) > 0) {
			/* 입력받은 패스워드 암호화 */
			try {
				vo.setPassword(StringUtil.encryptSha2(initId));
			} catch (NoSuchAlgorithmException e1) {
				e1.printStackTrace();
				model.addAttribute("message", "알 수 없는 오류가 발생했습니다.");
				return Const.ALERT_PAGE;
			}
			memberService.initPassword(vo);
			model.addAttribute("message", "비밀번호가 초기화 되었습니다.");
			return Const.AJAX_PAGE;
		} 
		
		model.addAttribute("message", "존재하지 않는 아이디입니다.");
		return Const.AJAX_PAGE;
	}

	/** 이메일, SMS수신동의  */
	@RequestMapping("/member/receive/agree/ajax")
	public String receiveAgree(MemberVo vo, HttpSession session, Model model) {
		vo.setSeq(Integer.valueOf( (""+session.getAttribute("loginSeq")) ));
		try {
			memberService.updateReceiverAgree(vo);
		} catch(Exception e) {
			model.addAttribute("message", "수신여부 수정이 실패하였습니다. ["+e.getMessage()+"]");
			return Const.AJAX_PAGE;
		}

		GregorianCalendar today = new GregorianCalendar ( );

		String day = today.get(Calendar.YEAR) + "년 " + (today.get(Calendar.MONTH) + 1) + "월 " + today.get(Calendar.DAY_OF_MONTH) + "일 ";
		model.addAttribute("message", day + "이메일 수신 " + ("Y".equals(vo.getEmailFlag()) ? "동의" : "거부") + "처리 되었습니다.\r" + day + "SMS 수신 " + ("Y".equals(vo.getSmsFlag()) ? "동의" : "거부") + "처리 되었습니다.");
		return Const.AJAX_PAGE;
	}
	
	private boolean memberValidCheck(MemberVo vo, MemberGroupVo gvo, Model model) {
		boolean flag = true;
		/* 유효성 검사 */
		//공통부분
		if("".equals(vo.getId())) {
			model.addAttribute("message", "아이디를 입력해주세요.");
			flag = false;
		} else if(StringUtil.getByteLength(vo.getId()) > 50) {
			model.addAttribute("message", "아이디가 50Bytes를 초과하였습니다.");
			flag = false;
		} else if(!vo.getId().matches("^[a-z0-9._-]*$")){
			model.addAttribute("message", "아이디는 영소문자/숫자/._-만 가능 합니다.");
			flag = false;
		} else if("".equals(vo.getPassword())) {
			model.addAttribute("message", "비밀번호를 입력해주세요.");
			flag = false;
		} else if(vo.getPassword().length() < 8 || vo.getPassword().length() > 16) {
			model.addAttribute("message", "비밀번호는 8-16자가 되어야 합니다.");
			flag = false;
		} else if(!vo.getPassword().matches("^[a-zA-Z0-9~!@#$%^&*()]*$")){
			model.addAttribute("message", "비밀번호는 영문/숫자/특수문자만 가능 합니다.");
			flag = false;
		}
		
		if("C".equals(vo.getMemberTypeCode())) {
			if(StringUtil.getByteLength(vo.getId()) < 6) {
				model.addAttribute("message", "아이디를 6자 이상 입력해주세요.");
				flag = false;
			}
		} else {
			if(StringUtil.getByteLength(vo.getId()) < 4) {
				model.addAttribute("message", "아이디를 4자 이상 입력해주세요.");
				flag = false;
			}
		}
		
		//일반회원
		
		if("C".equals(vo.getMemberTypeCode())) {
			//공공기관, 기업
			if("".equals(vo.getName())) {
				model.addAttribute("message", "이름을 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getEmail1()) || "".equals(vo.getEmail2())) {
				model.addAttribute("message", "이메일을 입력해주세요.");
				flag = false;
			} else if(!vo.getEmail1().matches("^[a-zA-Z0-9._-]*$") || !vo.getEmail2().matches("^[a-zA-Z0-9._-]*$")) {
				model.addAttribute("message", "이메일은 영문/숫자/._-만 가능 합니다.");
				flag = false;
			} else if("".equals(vo.getCell1()) || "".equals(vo.getCell2()) || "".equals(vo.getCell3())) {
				model.addAttribute("message", "휴대폰번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getPostcode())) {
				model.addAttribute("message", "우편번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getAddr1()) || "".equals(vo.getAddr2())) {
				model.addAttribute("message", "주소를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getEmailFlag())) {
				model.addAttribute("message", "뉴스레터 수신여부를 선택해주세요.");
				flag = false;
			} else if("".equals(vo.getSmsFlag())) {
				model.addAttribute("message", "SMS 수신여부를 선택해주세요.");
				flag = false;
			}
		} else {
			//공공기관, 기업
			if("".equals(vo.getGroupName()))	{
				model.addAttribute("message", "기관명을 입력해주세요.");
				flag = false;
			} else if("O".equals(vo.getMemberTypeCode()) && ("".equals(gvo.getBizNo1()) || "".equals(gvo.getBizNo2()) || "".equals(gvo.getBizNo3()))) {
				model.addAttribute("message", "사업자 등록번호를 입력해주세요.");
				flag = false;
			} else if("".equals(gvo.getCeoName())) {
				model.addAttribute("message", "대표자를 입력해주세요.");
				flag = false;
			} else if("P".equals(vo.getMemberTypeCode()) && "".equals(gvo.getJachiguCode())) { //공공기관일때만 검증
				model.addAttribute("message", "자치구를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getPostcode())) {
				model.addAttribute("message", "우편번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getAddr1()) || "".equals(vo.getAddr2())) {
				model.addAttribute("message", "주소를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getName())) {
				model.addAttribute("message", "담당자 이름을 입력해주세요.");
				flag = false;
			}  else if("".equals(vo.getEmail1()) || "".equals(vo.getEmail2())) {
				model.addAttribute("message", "담당자 이메일을 입력해주세요.");
				flag = false;
			} else if(!vo.getEmail1().matches("^[a-zA-Z0-9._-]*$") || !vo.getEmail2().matches("^[a-zA-Z0-9._-]*$")) {
				model.addAttribute("message", "담당자 이메일은 영문/숫자/._-만 가능 합니다.");
				flag = false;
			} else if("".equals(vo.getCell1()) || "".equals(vo.getCell2()) || "".equals(vo.getCell3())) {
				model.addAttribute("message", "담당자 휴대폰번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getTel1()) || "".equals(vo.getTel2()) || "".equals(vo.getTel3())) {
				model.addAttribute("message", "담당자 전화번호를 입력해주세요.");
				flag = false;
			} else if("".equals(vo.getEmailFlag())) {
				model.addAttribute("message", "뉴스레터 수신여부를 선택해주세요.");
				flag = false;
			} else if("".equals(vo.getSmsFlag())) {
				model.addAttribute("message", "SMS 수신여부를 선택해주세요.");
				flag = false;
			} else if(!gvo.getTaxEmail1().matches("^[a-zA-Z0-9._-]*$") || !gvo.getTaxEmail2().matches("^[a-zA-Z0-9._-]*$")) {
				model.addAttribute("message", "계산서 담당자 이메일은 영문/숫자/._-만 가능 합니다.");
				flag = false;
			}
		}
		return flag;
	} 
}
