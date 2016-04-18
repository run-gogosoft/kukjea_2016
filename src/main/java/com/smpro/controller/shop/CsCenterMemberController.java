package com.smpro.controller.shop;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.MallVo;
import com.smpro.vo.MemberGroupVo;
import com.smpro.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;

@Controller
public class CsCenterMemberController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private MailService mailService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private MemberGroupService memberGroupService;

	/** 약관동의 페이지 */
	@RequestMapping("/cscenter/member/start")
	public String regStart(Model model) {
		model.addAttribute("on", "12");
		model.addAttribute("title", "회원가입");
		return "/cscenter/member/start.jsp";
	}

	/** 회원가입 폼 페이지 */
	@RequestMapping("/cscenter/member/form")
	public String form(String allCheckFlag, Model model) {
		model.addAttribute("on", "12");
		//약관 동의 체크
		if(StringUtil.isBlank(allCheckFlag)) {
			model.addAttribute("message", "약관에 모두 동의 해주세요");
			return Const.BACK_PAGE;
		}
		//		//본인인증 확인을 거쳤는지 체크
		//		if(session.getAttribute("certKey") == null) {
		//			model.addAttribute("message", "본인인증(아이핀/휴대폰) 값이 유효하지 않습니다. ");
		//			return Const.ALERT_PAGE;
		//		}
		//		//본인인증 키값으로 중복가입 여부 체크
		//		if(memberService.checkCnt((String)session.getAttribute("certKey")) > 0) {
		//			model.addAttribute("message", "이미 가입된 회원입니다.");
		//			model.addAttribute("returnUrl", "/shop/member/start?memberTypeCode="+memberTypeCode);
		//			return Const.REDIRECT_PAGE;
		//		}
		model.addAttribute("title", "회원가입");
		//		CommonVo cvo = new CommonVo();
		//		//자치구 코드
		//		cvo.setGroupCode(new Integer(29));
		//		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		return "/cscenter/member/form.jsp";
	}

	/** 회원가입 */
	@RequestMapping(value="/cscenter/member/proc", method= RequestMethod.POST)
	public String regData(HttpServletRequest request, MemberVo vo, MemberGroupVo gvo, Model model) {
		MallVo mallVo = (MallVo)request.getAttribute("mallVo");
		boolean flag = false;
		String errMsg = "";

//		HttpSession session = request.getSession();
//		String memberTypeCode = (String)session.getAttribute("memberTypeCode");

//		if(memberTypeCode == null) {
//			model.addAttribute("message", "잘못된 접근입니다.");
//			return Const.ALERT_PAGE;
//		}
		vo.setMemberTypeCode("O"); // 기업회원(O)

//		if("C".equals(vo.getMemberTypeCode())) {
//			//본인인증 확인을 거쳤는지 체크
//			if(session.getAttribute("certKey") == null || session.getAttribute("certName") == null) {
//				model.addAttribute("message", "본인인증 값이 유효하지 않습니다.\n\n회원가입을 처음부터 다시 진행해 주시기 바랍니다.");
//				return Const.ALERT_PAGE;
//			}
//			//인증키 저장
//			vo.setCertKey( (String)session.getAttribute("certKey") );
//			//실명 저장
//			vo.setName( (String)session.getAttribute("certName") );
//		}

		// 유효성 검사
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
//			if("C".equals(vo.getMemberTypeCode())) {
//				flag = memberService.regData(vo);
//			} else {
				gvo.setName(vo.getGroupName());
				resultGroup = memberGroupService.regVo(gvo);

				if(resultGroup > 0) {
					vo.setGroupSeq(gvo.getSeq());
					flag = memberService.regData(vo);
				}
//			}

			// 회원가입 메일
//			try {
//				MailVo mvo = new MailVo();
//				mvo.setSubject("[Hknuri] 함께누리 가입을 진심으로 축하드립니다");
//				mvo.setText(mailService.getMember(vo.getId(), vo.getName(), request.getSession().getServletContext().getRealPath("/")));
//				mvo.setFromUser("hknuri@hknuri.co.kr");
//				mvo.setToUser(vo.getEmail());
//				mailService.sendMail(mvo);
//			} catch(Exception e) {
//				e.printStackTrace();
//			}

			if(flag) {
				//회원가입 완료 페이지 이동
				model.addAttribute("message", "회원 가입이 완료되었습니다. 로그인 후 사용해 주시기 바랍니다.");
				//다음페이지에서 가입 정보를 표시해 줄때 회원시퀀스 파라메타 노출을 방지하기 위해 세션에 저장한다.
				request.getSession().setAttribute("seq",vo.getSeq());
				model.addAttribute("returnUrl", "/shop/cscenter/member/finish");
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

	/** 회원가입 완료 페이지 */
	@RequestMapping("/cscenter/member/finish")
	public String regFinish(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
//		String memberTypeCode = (String)session.getAttribute("memberTypeCode");

//		if("C".equals(memberTypeCode)) {
//			model.addAttribute("title", "개인회원 회원가입");
//		} else if("O".equals(memberTypeCode)) {
//			model.addAttribute("title", "기업/시설/단체 회원가입");
//		} else if("P".equals(memberTypeCode)){
//			model.addAttribute("title", "공공기관 회원가입");
//		} else {
//			model.addAttribute("message", "잘못된 접근입니다.");
//			return Const.ALERT_PAGE;
//		}
		model.addAttribute("title", "회원가입");
		model.addAttribute("on", "12");

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

		return "/cscenter/member/finish.jsp";
	}


	private boolean memberValidCheck(MemberVo vo, MemberGroupVo gvo, Model model) {
		boolean flag = true;
		/* 유효성 검사 */
		//공통부분
		if("".equals(vo.getId())) {
			model.addAttribute("message", "아이디를 입력해주세요.");
			flag = false;
		} else if(StringUtil.getByteLength(vo.getId()) > 50) {
			model.addAttribute("message", "아이디가 50글자를 초과하였습니다.");
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

		if(StringUtil.getByteLength(vo.getId()) < 4) {
			model.addAttribute("message", "아이디를 4자 이상 입력해주세요.");
			flag = false;
		}

		if("".equals(vo.getName())) {
			model.addAttribute("message", "이름을 입력해주세요.");
			flag = false;
//		} else if("".equals(vo.getEmail1()) || "".equals(vo.getEmail2())) {
//			model.addAttribute("message", "이메일을 입력해주세요.");
//			flag = false;
//		} else if(!vo.getEmail1().matches("^[a-zA-Z0-9._-]*$") || !vo.getEmail2().matches("^[a-zA-Z0-9._-]*$")) {
//			model.addAttribute("message", "이메일은 영문/숫자/._-만 가능 합니다.");
//			flag = false;
		} else if("".equals(vo.getCell1()) || "".equals(vo.getCell2()) || "".equals(vo.getCell3())) {
			model.addAttribute("message", "휴대폰번호를 입력해주세요.");
			flag = false;
		} else if("".equals(vo.getPostcode())) {
			model.addAttribute("message", "우편번호를 입력해주세요.");
			flag = false;
		} else if("".equals(vo.getAddr1()) || "".equals(vo.getAddr2())) {
			model.addAttribute("message", "주소를 입력해주세요.");
			flag = false;
//		} else if("".equals(vo.getEmailFlag())) {
//			model.addAttribute("message", "뉴스레터 수신여부를 선택해주세요.");
//			flag = false;
//		} else if("".equals(vo.getSmsFlag())) {
//			model.addAttribute("message", "SMS 수신여부를 선택해주세요.");
//			flag = false;
		} else if("".equals(vo.getGroupName())) {
			model.addAttribute("message", "기관명을 입력해주세요.");
			flag = false;
		} else if(("".equals(gvo.getBizNo1()) || "".equals(gvo.getBizNo2()) || "".equals(gvo.getBizNo3()))) {
			model.addAttribute("message", "사업자 등록번호를 입력해주세요.");
			flag = false;
		} else if("".equals(gvo.getCeoName())) {
			model.addAttribute("message", "대표자를 입력해주세요.");
			flag = false;
//		} else if("P".equals(vo.getMemberTypeCode()) && "".equals(gvo.getJachiguCode())) { //공공기관일때만 검증
//			model.addAttribute("message", "자치구를 입력해주세요.");
//			flag = false;
//		} else if("".equals(vo.getName())) {
//			model.addAttribute("message", "담당자 이름을 입력해주세요.");
//			flag = false;
//		}  else if("".equals(vo.getEmail1()) || "".equals(vo.getEmail2())) {
//			model.addAttribute("message", "담당자 이메일을 입력해주세요.");
//			flag = false;
//		} else if(!vo.getEmail1().matches("^[a-zA-Z0-9._-]*$") || !vo.getEmail2().matches("^[a-zA-Z0-9._-]*$")) {
//			model.addAttribute("message", "담당자 이메일은 영문/숫자/._-만 가능 합니다.");
//			flag = false;
//		} else if("".equals(vo.getCell1()) || "".equals(vo.getCell2()) || "".equals(vo.getCell3())) {
//			model.addAttribute("message", "담당자 휴대폰번호를 입력해주세요.");
//			flag = false;
//		} else if("".equals(vo.getTel1()) || "".equals(vo.getTel2()) || "".equals(vo.getTel3())) {
//			model.addAttribute("message", "담당자 전화번호를 입력해주세요.");
//			flag = false;
//		} else if("".equals(vo.getEmailFlag())) {
//			model.addAttribute("message", "뉴스레터 수신여부를 선택해주세요.");
//			flag = false;
//		} else if("".equals(vo.getSmsFlag())) {
//			model.addAttribute("message", "SMS 수신여부를 선택해주세요.");
//			flag = false;
//		} else if(!gvo.getTaxEmail1().matches("^[a-zA-Z0-9._-]*$") || !gvo.getTaxEmail2().matches("^[a-zA-Z0-9._-]*$")) {
//			model.addAttribute("message", "계산서 담당자 이메일은 영문/숫자/._-만 가능 합니다.");
//			flag = false;
		}

		return flag;
	}
}
