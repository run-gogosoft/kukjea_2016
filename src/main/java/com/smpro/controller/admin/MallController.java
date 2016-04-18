package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.util.StringUtil;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Slf4j
@Controller
public class MallController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private MallService mallService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private SystemService systemService;

	/** 쇼핑몰 리스트 */
	@CheckGrade(controllerName = "mallController", controllerMethod = "getList")
	@RequestMapping("/mall/list")
	public String getList(MallVo reqVo, Model model) {
		model.addAttribute("title", "쇼핑몰 리스트");
		CommonVo cvo = new CommonVo();
		// 쇼핑몰 상태
		cvo.setGroupCode(new Integer(18));
		model.addAttribute("statusList", systemService.getCommonList(cvo));
		// 쇼핑몰 유형
		cvo.setGroupCode(new Integer(19));
		model.addAttribute("mallTypeList", systemService.getCommonList(cvo));
		// 제휴사
		cvo.setGroupCode(new Integer(23));
		model.addAttribute("partnerList", systemService.getCommonList(cvo));

		model.addAttribute("pvo", reqVo);
		model.addAttribute("list", mallService.getList(reqVo));
		return "/mall/list.jsp";
	}

	/** 쇼핑몰 등록/수정 폼 */
	@CheckGrade(controllerName = "mallController", controllerMethod = "getForm")
	@RequestMapping("/mall/form")
	public String getForm(MallVo paramVo, Model model) {
		String title = "쇼핑몰 신규 등록";
		if (paramVo.getSeq() != null) {
			title = "쇼핑몰 정보 수정";
			model.addAttribute("vo", mallService.getVo(paramVo.getSeq()));
		}
		model.addAttribute("title", title);

		/** 공통 코드 리스트 */
		// 쇼핑몰 상태
		model.addAttribute("statusList", systemService.getCommonListByGroup(new Integer(18)));
		// 쇼핑몰 유형
		model.addAttribute("mallTypeList", systemService.getCommonListByGroup(new Integer(19)));
		// 템플릿 유형
		model.addAttribute("tmplTypeList", systemService.getCommonListByGroup(new Integer(20)));
		// 결제 수단
		model.addAttribute("payMethodList", systemService.getCommonListByGroup(new Integer(21)));
		// KCP 카드사
		model.addAttribute("kcpCardList", systemService.getCommonListByGroup(new Integer(17)));
		// 제휴사 코드
		model.addAttribute("partnershipList", systemService.getCommonListByGroup(new Integer(23)));
		// PG사 리스트
		model.addAttribute("pgList", systemService.getCommonListByGroup(new Integer(28)));
		// 상품 제한 코드
		model.addAttribute("itemLimitList", systemService.getCommonListByGroup(new Integer(29)));
		return "/mall/form.jsp";
	}

	/** 쇼핑몰 정보 등록 */
	@CheckGrade(controllerName = "mallController", controllerMethod = "regVo")
	@RequestMapping(value = "/mall/reg", method = RequestMethod.POST)
	public String regVo(MallVo vo, Model model) {
		// form parameter 유효성 체크
		String errMsg = checkFormParameter(vo);
		if (!"".equals(errMsg)) {
			model.addAttribute("message", errMsg);
			return Const.ALERT_PAGE;
		}

		// 사용자 구분 default 값 설정 - M:쇼핑몰
		vo.setTypeCode("M");
		// 상태값 설정 default 값 설정 - H:대기
		vo.setStatusCode("H");
		// 닉네임 default 아이디로 동일하게 설정(추후 필요시 입력받도록 수정)
		vo.setNickname(vo.getId());
		try {
			// 패스워드 sha2 암호화
			vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
			if (mallService.regVo(vo)) {				
				MemberVo mvo = new MemberVo();
				mvo.setId("test");
				mvo.setName("테스트");
				mvo.setMallSeq(mallService.getMainInfo(vo.getId()).getSeq());
				mvo.setPassword("1234");
				mvo.setTel("010-0000-0000");
				mvo.setCell("010-0000-0000");
				mvo.setEmail("test@test.com");
				mvo.setAddr1("테스트주소 1");
				mvo.setAddr2("테스트주소 2");
				mvo.setTypeCode("C");
				mvo.setStatusCode("Y");
				if (!memberService.regData(mvo)) {
					model.addAttribute("message", "테스트 계정 생성에 실패했습니다.");
					return Const.ALERT_PAGE;
				}
				
				model.addAttribute("returnUrl", "/admin/mall/list");
				model.addAttribute("message", "쇼핑몰 생성에 성공하였습니다.");
				return Const.REDIRECT_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = e.getMessage();
		}

		errMsg = "시스템 오류가 발생하였습니다." + " [" + errMsg + "]";
		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;

	}

	/** 쇼핑몰 정보 수정 */
	@CheckGrade(controllerName = "mallController", controllerMethod = "modVo")
	@RequestMapping(value = "/mall/mod", method = RequestMethod.POST)
	public String modVo(MallVo vo, Model model) {
		String errMsg = checkFormParameter(vo);
		if (!"".equals(errMsg)) {
			model.addAttribute("message", errMsg);
			return Const.ALERT_PAGE;
		}

		try {
			// 패스워드 sha2 암호화
			if (!StringUtil.isBlank(vo.getPassword())) {
				vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
			}
			log.info(
					"### password to sha2 encryption : " + vo.getPassword());
			if (mallService.modVo(vo)) {
				model.addAttribute("returnUrl", "/admin/mall/list");
				model.addAttribute("message", "쇼핑몰 수정에 성공하였습니다");
				return Const.REDIRECT_PAGE;
			}
			errMsg = "쇼핑몰 수정에 실패했습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = e.getMessage();
		}

		if (errMsg == null) {
			errMsg = "시스템 오류가 발생하였습니다.";
		} else {
			errMsg = "시스템 오류가 발생하였습니다." + " [" + errMsg + "]";
		}

		model.addAttribute("message", errMsg);
		return Const.ALERT_PAGE;
	}

	/** 쇼핑몰 삭제 */
	@CheckGrade(controllerName = "mallController", controllerMethod = "delVo")
	@RequestMapping("/mall/delete/{seq}")
	public String delVo(@PathVariable Integer seq, String mallTypeCode,	Model model) {

		if (!mallService.deleteMall(seq)) {
			model.addAttribute("message", "오픈 했던 쇼핑몰은 삭제할수 없습니다.");
		} else {
			model.addAttribute("message", "쇼핑몰 삭제에 성공하였습니다.");
		}

		if (mallTypeCode.equals("90")) {
			model.addAttribute("returnUrl", "/admin/mall/other/list");
		} else {
			model.addAttribute("returnUrl", "/admin/mall/list");
		}
		return Const.REDIRECT_PAGE;
	}

	/** 쇼핑몰 등록/수정시 form parameter 유효성 체크 */
	private String checkFormParameter(MallVo vo) {
		String errMsg = "";

		// 필수값 체크
		if (vo.getSeq() == null) {
			// 등록시에만 체크
			if (StringUtil.isBlank(vo.getPassword())) {
				errMsg = "패스워드는 필수 입력 항목입니다.";
			}

			if (StringUtil.getByteLength(vo.getPassword()) > 20) {
				errMsg = "패스워드는 20자 이하여야 합니다";
			}

			if (StringUtil.getByteLength(vo.getPassword()) < 8) {
				errMsg = "패스워드는 8자 이상이여야 합니다";
			}

			if (StringUtil.getByteLength(vo.getId()) > 20) {
				errMsg = "쇼핑몰 아이디 입력 값이 최대 허용 길이를 초과하였습니다. [최대:20byte, 실제:"
						+ StringUtil.getByteLength(vo.getId()) + "]";
			}
			if (StringUtil.getByteLength(vo.getId()) < 2) {
				errMsg = "쇼핑몰 아이디 입력 값의 최소 허용 길이에 미달하였습니다. [최소:2byte, 실제:"
						+ StringUtil.getByteLength(vo.getId()) + "]";
			}

		} else {
			// 수정시에만 체크
			if (StringUtil.isBlank(vo.getStatusCode())) {
				errMsg = "쇼핑몰 상태는 필수 선택 항목입니다.";
			}
			if (!StringUtil.isBlank(vo.getPassword())) {
				if (StringUtil.getByteLength(vo.getPassword()) > 20) {
					errMsg = "패스워드는 20자 이하여야 합니다";
				}

				if (StringUtil.getByteLength(vo.getPassword()) < 8) {
					errMsg = "패스워드는 8자 이상이여야 합니다";
				}
			}
		}
		if (StringUtil.isBlank(vo.getName())) {
			errMsg = "쇼핑몰명은 필수 입력 항목입니다.";
		} 
		
		// 길이 체크(byte 단위)
		if (StringUtil.getByteLength(vo.getName()) > 50) {
			errMsg = "쇼핑몰명 입력 값이 최대 허용 길이를 초과하였습니다. [최대:50byte, 실제:" + StringUtil.getByteLength(vo.getName()) + "]";
		}

		return errMsg;
	}
	
	/** 함께누리몰 기주문정보 암호화 작업 */
	@RequestMapping("/mall/order/encrypt")
	public String orderEncrypt(Model model) {
		List<OrderVo> list = orderService.getListForEncrypt();
		int result = 0;
		
		try {
			for(OrderVo vo : list) {
				result += orderService.updateForEncrypt(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "암호화 실패, 성공["+result+"]");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "암호화 완료, 성공["+result+"]");
		return Const.ALERT_PAGE;
	}
	
	/** 함께누리몰 기회원 개인정보 암호화 작업 */
	@RequestMapping("/mall/member/encrypt")
	public String memberEncrypt(Model model) {
		List<MemberVo> list = memberService.getListForEncrypt();
		int result = 0;
		for(int i=0; i<list.size(); i++) {
			MemberVo vo = list.get(i);
			try {
				result += memberService.updateForEncrypt(vo);
			} catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "암호화 실패 ["+e.getMessage()+"]");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("message", "암호화 완료, 성공["+result+"]");
		model.addAttribute("returnUrl", "/admin/mall/list");
		return Const.REDIRECT_PAGE;
	}
	
	/** 함께누리몰 기회원,입점업체 패스워드 암호화 작업 */
	@RequestMapping("/mall/user/encrypt/password/{typeCode}")
	public String userEncryptPassword(@PathVariable String typeCode, Model model) {
		List<UserVo> list = memberService.getUserListForEncrypt(typeCode);
		int result = 0;
		for(UserVo vo : list) {
			try {
				result += memberService.updateUserForEncrypt(vo);
			} catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("message", "암호화 실패 ["+e.getMessage()+"]");
				return Const.ALERT_PAGE;
			}
		}

		model.addAttribute("message", "암호화 완료, 성공["+result+"]");
		model.addAttribute("returnUrl", "/admin/mall/list");
		return Const.REDIRECT_PAGE;
	}
}
