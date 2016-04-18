package com.smpro.controller.shop;

import com.smpro.service.FilenameService;
import com.smpro.service.MemberService;
import com.smpro.service.SellerService;
import com.smpro.service.SystemService;
import com.smpro.util.*;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class SellerController {

	@Autowired
	private SellerService sellerService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private FilenameService filenameService;

	@RequestMapping("/seller/reg")
	public String getList(Model model) {
		model.addAttribute("title", "입점 신청");

		//자치구 코드
		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		model.addAttribute("deliCompanyList", systemService.getDeliCompany());
		return "/seller/form.jsp";
	}

	@RequestMapping("/seller/mod")
	public String getModForm(SellerVo svo, Model model) {
		model.addAttribute("title", "입점신청 정보수정");

		/* 필수값 체크 */
		if("".equals(svo.getId())) {
			model.addAttribute("message", "아이디를 입력해 주세요.");
			model.addAttribute("returnUrl", "/shop/seller/reg");
			return Const.REDIRECT_PAGE;
		} else if("".equals(svo.getPassword())) {
			model.addAttribute("message", "비밀번호를 입력해 주세요.");
			model.addAttribute("returnUrl", "/shop/seller/reg");
			return Const.REDIRECT_PAGE;
		}

		/* 입력받은 패스워드 암호화 */
		try {
			svo.setPassword(StringUtil.encryptSha2(svo.getPassword()));
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "알 수 없는 오류가 발생했습니다.");
			model.addAttribute("returnUrl", "/shop/seller/reg");
			return Const.REDIRECT_PAGE;
		}

		UserVo rvo = sellerService.getShopSellerSeq(svo);

		if(rvo == null) {
			model.addAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addAttribute("returnUrl", "/shop/seller/reg");
			return Const.REDIRECT_PAGE;
		}

		/* 콤보박스 리스트 가져오기 */
		CommonVo cvo = new CommonVo();
		cvo.setGroupCode(new Integer(8));
		model.addAttribute("gradeList", systemService.getCommonList(cvo));
		//자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));

		/* 입점업체 상세 정보 */
		SellerVo vo;
		try {
			vo = sellerService.getData(rvo.getSeq());
		} catch (Exception e) {
			model.addAttribute("message", "입점업체 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			model.addAttribute("returnUrl", "/shop/seller/reg");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("deliCompanyList", systemService.getDeliCompany());
		model.addAttribute("vo", vo);


		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "seller");
		map.put("parentSeq", rvo.getSeq());
		model.addAttribute("file", filenameService.getList(map));
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/seller/form.jsp";
	}

	@RequestMapping(value = "/seller/reg/proc", method = RequestMethod.POST)
	public String regData(HttpServletRequest request, String allCheckFlag, String code, Model model, String authCategory) {
		boolean flag = false;
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		SellerVo vo = getSellerVo(map);
		vo.setAuthCategory(authCategory);

		//약관 동의 체크
		if(StringUtil.isBlank(allCheckFlag)) {
			model.addAttribute("message", "약관에 모두 동의 해주세요");
			return Const.ALERT_PAGE;
		}

		//파라메타 유효성 체크
		String reqParamErrMsg = validCheck(vo, "REG");
		if (reqParamErrMsg != null) {
			model.addAttribute("message", reqParamErrMsg);
			return Const.ALERT_PAGE;
		}

		vo.setStatusCode("H"); //상태 기본값 : 승인대기
		vo.setTypeCode("S");

		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while (iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);

			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				try {
					if(formName.indexOf("file") == 0) {
						FilenameVo fvo =  new FilenameVo();
						fvo.setParentCode("seller");
						fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
						fvo.setFilename(file.getOriginalFilename());
						fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
						fileList.add(fvo);
					}
				} catch(Exception e) {
					log.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}

		try {
			//패스원드 암호화
			if (!StringUtil.isBlank(vo.getPassword())) {
				vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
			}
			flag = sellerService.regData(vo);
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}

		if (flag) {
			// 파일 내역을 DB에 저장한다
			for(FilenameVo fvo : fileList) {
				fvo.setParentSeq(vo.getSeq());
				filenameService.replaceFilename(fvo);
			}

			model.addAttribute("message", "입점 신청 완료");
			model.addAttribute("returnUrl", "/shop/main");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "입점 신청 실패");
		return Const.ALERT_PAGE;
	}

	/** 입점업체수정 */
	@RequestMapping(value = "/seller/mod/{seq}/proc", method = RequestMethod.POST)
	public String modData(@PathVariable Integer seq, HttpServletRequest request, String allCheckFlag, String code,  Model model,String authCategory) {
		boolean flag = false;
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		SellerVo vo = getSellerVo(map);
		vo.setSeq(seq);
		vo.setAuthCategory(authCategory);

		//약관 동의 체크
		if(StringUtil.isBlank(allCheckFlag)) {
			model.addAttribute("message", "약관에 모두 동의 해주세요");
			return Const.ALERT_PAGE;
		}

		//파라메타 유효성 체크
		String reqParamErrMsg = validCheck(vo, "MOD");
		if (reqParamErrMsg != null) {
			model.addAttribute("message", reqParamErrMsg);
			return Const.ALERT_PAGE;
		}

		Iterator<String> iter = mpRequest.getFileNames();
		FileUploadUtil util = new FileUploadUtil();
		List<FilenameVo> fileList = new ArrayList<>();

		while (iter.hasNext()) {
			String formName = iter.next();
			MultipartFile file = mpRequest.getFile(formName);

			String uploadRealPath = Const.UPLOAD_REAL_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			String uploadPath = Const.UPLOAD_PATH + "/file/" + code + "/" + new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + "/";
			if (file.getSize() > 0) {
				try {
					if(formName.indexOf("file") == 0) {
						FilenameVo fvo =  new FilenameVo();
						fvo.setParentCode("seller");
						fvo.setNum(Integer.valueOf(formName.replaceAll("file", "")));
						fvo.setFilename(file.getOriginalFilename());
						fvo.setRealFilename(util.upload(uploadPath, uploadRealPath, file));
						fvo.setParentSeq(vo.getSeq());
						fileList.add(fvo);
					}
				} catch(Exception e) {
					log.error(e.getMessage());
					model.addAttribute("message", "업로드에 실패했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}

		try {
			/* 입력받은 패스워드 암호화 */
			if (!StringUtil.isBlank(vo.getPassword())) {
				vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
			}
			flag = sellerService.modData(vo);
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}

		if (flag) {
			// 파일 내역을 DB에 저장한다
			for(FilenameVo fvo : fileList) {
				filenameService.replaceFilename(fvo);
			}

			model.addAttribute("message", "수정 성공.");
			model.addAttribute("returnUrl", "/shop/main");
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "수정 실패.");
		return Const.ALERT_PAGE;
	}

	@RequestMapping("/seller/file/delete/proc")
	public String fileDelete(@RequestParam int seq, @RequestParam int num, HttpServletRequest request, Model model) throws Exception {
		SellerVo vo = sellerService.getData(new Integer(seq));
		if(vo == null) {
			model.addAttribute("message", "비정상적인 접근입니다!!");
			return Const.ALERT_PAGE;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "seller");
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);
		String deletePath = request.getServletContext().getRealPath("/") + fvo.getRealFilename();

		// 파일을 삭제
		try {
			log.info("file>>delete>> " + deletePath);
			filenameService.deleteVo(fvo);
			new File(deletePath).delete();
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		model.addAttribute("callback", new Integer(num));
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/seller/file/download/proc")
	public String download(@RequestParam int seq, @RequestParam int num, HttpServletResponse response) throws Exception {
		SellerVo vo = sellerService.getData(new Integer(seq));
		if(vo == null) {
			return null;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "seller");
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);

		response.setContentType("application/octet-stream; charset=UTF-8;");
		response.setHeader("Content-Disposition", "attachment; filename=\""+ new String(fvo.getFilename().getBytes("utf-8"), "ISO-8859-1") +"\";");

		// 바보같겠지만... upload하는 메서드를 수정하긴 너무 빡셌다. 리얼에서만 돌아가는 것을 확인
		log.info(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		File file = new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "")+fvo.getRealFilename());
		FileDownloadUtil.download(response, file);
		return null;
	}

	/**
	 * 아이디 중복 체크
	 */
	@RequestMapping("/seller/check/id/ajax")
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
		vo.setTypeCode("S");
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
	@RequestMapping("/seller/check/nickname/ajax")
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

	/** 사업자번호 체크 */
	@RequestMapping("/seller/check/bizno/ajax")
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
		if (sellerService.getBizNoCnt(bizNo) == 0) {
			model.addAttribute("result", "true");
			model.addAttribute("message", "등록 가능한 사업자번호입니다.");
			return "/ajax/get-message-result.jsp";
		}

		model.addAttribute("result", "false");
		model.addAttribute("message", "이미 등록된 사업자번호입니다.");
		return "/ajax/get-message-result.jsp";

	}

	private String validCheck(SellerVo vo, String typeCode) {
		MemberVo mvo = new MemberVo();
		mvo.setId(vo.getId());
		mvo.setTypeCode("S");

		/* 유효성 검사 */
		if ("REG".equals(typeCode)) {
			if ("".equals(vo.getId())) {
				return "아이디는 반드시 입력되어야 합니다";
			} else if (!vo.getId().matches("^[a-z0-9._-]*$")) {
				return "아이디는 영소문자/숫자/._-만 가능 합니다.";
			} else if (StringUtil.getByteLength(vo.getId()) > 50) {
				return "아이디가 50Bytes를 초과하였습니다.";
			} else if (systemService.getIdCnt(mvo) != 0) {
				return "이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.";
			}
			if ("".equals(vo.getName())) {
				return "상호명(법인명)은 반드시 입력되어야 합니다";
			} else if ("".equals(vo.getPassword())) {
				return "비밀번호는 반드시 입력되어야 합니다";
			} else if (StringUtil.getByteLength(vo.getPassword()) > 20) {
				return "비밀번호를 20자 이하로 입력해주세요.";
			} else if (StringUtil.getByteLength(vo.getPassword()) < 8) {
				return "비밀번호를 8자 이상 입력해주세요.";
			} else if ("".equals(vo.getBizNo1()) || "".equals(vo.getBizNo2()) || "".equals(vo.getBizNo3())) {
				return "사업자번호는 반드시 입력되어야 합니다";
			} else if (StringUtil.getByteLength(vo.getBizNo1()+vo.getBizNo2()+vo.getBizNo3()) > 10) {
				return "사업자번호가 10Bytes를 초과하였습니다.";
			} else if (sellerService.getBizNoCnt(vo.getBizNo1()+vo.getBizNo2()+vo.getBizNo3()) != 0) {
				return "이미 사용중인 사업자 번호 입니다 .";
			}
		}

		if (!"".equals(vo.getPassword())) {
			if (StringUtil.getByteLength(vo.getPassword()) > 20) {
				return "비밀번호를 20자 이하로 입력해주세요.";
			} else if (StringUtil.getByteLength(vo.getPassword()) < 8) {
				return "비밀번호를 8자 이상 입력해주세요.";
			} else if (!vo.getPassword().matches("^[a-zA-Z0-9~!@#$%^&*()]*$")) {
				return "비밀번호는 영문/숫자/특수문자만 가능 합니다.";
			}
		}
		if ("".equals(vo.getCeoName())) {
			return "대표자명은 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getBizType())) {
			return "업태는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getBizKind())) {
			return "업종은 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getTel())) {
			return "대표전화는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getPostcode())) {
			return "우편번호는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getAddr1()) || "".equals(vo.getAddr2())) {
			return "주소는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getSalesName())) {
			return "담당자명은 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getSalesEmail())) {
			return "담당자 이메일은 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getSalesTel())) {
			return "담당자 전화번호는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getSalesCell())) {
			return "담당자 휴대폰번호는 반드시 입력되어야 합니다";
		} else if(!vo.getJachiguCode().matches("^\\d{2}$")) {
			return "자치구가 선택되지 않았습니다.";
		} else if ("".equals(vo.getTotalSales())) {
			return "매출액은 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getAmountOfWorker())) {
			return "종업원수는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getAuthCategory())) {
			return "인증구분은 반드시 선택되어야 합니다";
		}

		return null;
	}

	private SellerVo getSellerVo(HashMap<String, Object> map) {
		SellerVo vo = new SellerVo();
		vo.setId((String)map.get("id") == null ? "" : (String)map.get("id"));
		vo.setName((String)map.get("name") == null ? "" : (String)map.get("name"));
		vo.setPassword((String)map.get("password") == null ? "" : (String)map.get("password"));
		vo.setNickname((String)map.get("nickname") == null ? "" : (String)map.get("nickname"));
		vo.setBizNo1((String)map.get("bizNo1") == null ? "" : (String)map.get("bizNo1"));
		vo.setBizNo2((String)map.get("bizNo2") == null ? "" : (String)map.get("bizNo2"));
		vo.setBizNo3((String)map.get("bizNo3") == null ? "" : (String)map.get("bizNo3"));
		vo.setCeoName((String)map.get("ceoName") == null ? "" : (String)map.get("ceoName"));
		vo.setBizType((String)map.get("bizType") == null ? "" : (String)map.get("bizType"));
		vo.setBizKind((String)map.get("bizKind") == null ? "" : (String)map.get("bizKind"));
		vo.setTel((String)map.get("tel") == null ? "" : (String)map.get("tel"));
		vo.setFax((String)map.get("fax") == null ? "" : (String)map.get("fax"));
		vo.setJachiguCode((String)map.get("jachiguCode") == null ? "" : (String)map.get("jachiguCode"));
		vo.setPostcode((String)map.get("postcode") == null ? "" : (String)map.get("postcode"));
		vo.setAddr1((String)map.get("addr1") == null ? "" : (String)map.get("addr1"));
		vo.setAddr2((String)map.get("addr2") == null ? "" : (String)map.get("addr2"));
		vo.setSalesName((String)map.get("salesName") == null ? "" : (String)map.get("salesName"));
		vo.setSalesEmail((String)map.get("salesEmail") == null ? "" : (String)map.get("salesEmail"));
		vo.setSalesTel((String)map.get("salesTel") == null ? "" : (String)map.get("salesTel"));
		vo.setSalesCell((String)map.get("salesCell") == null ? "" : (String)map.get("salesCell"));
		vo.setAdjustName((String)map.get("adjustName") == null ? "" : (String)map.get("adjustName"));
		vo.setAdjustEmail((String)map.get("adjustEmail") == null ? "" : (String)map.get("adjustEmail"));
		vo.setAdjustTel((String)map.get("adjustTel") == null ? "" : (String)map.get("adjustTel"));
		vo.setAccountBank((String)map.get("accountBank") == null ? "" : (String)map.get("accountBank"));
		vo.setAccountNo((String)map.get("accountNo") == null ? "" : (String)map.get("accountNo"));
		vo.setAccountOwner((String)map.get("accountOwner") == null ? "" : (String)map.get("accountOwner"));
		vo.setDefaultDeliCompany(Integer.valueOf((String)map.get("defaultDeliCompany")));
		vo.setReturnName((String)map.get("returnName") == null ? "" : (String)map.get("returnName"));
		vo.setReturnCell((String)map.get("returnCell") == null ? "" : (String)map.get("returnCell"));
		vo.setReturnPostCode((String)map.get("returnPostCode") == null ? "" : (String)map.get("returnPostCode"));
		vo.setReturnAddr1((String)map.get("returnAddr1") == null ? "" : (String)map.get("returnAddr1"));
		vo.setReturnAddr2((String)map.get("returnAddr2") == null ? "" : (String)map.get("returnAddr2"));
		vo.setIntro((String)map.get("intro") == null ? "" : StringUtil.clearXSS((String)map.get("intro")));
		vo.setMainItem((String)map.get("mainItem") == null ? "" : StringUtil.clearXSS((String)map.get("mainItem")));
		vo.setSocialActivity((String)map.get("socialActivity") == null ? "" : StringUtil.clearXSS((String)map.get("socialActivity")));
		vo.setAmountOfWorker((String)map.get("amountOfWorker") == null ? "" : (String)map.get("amountOfWorker"));
		vo.setTotalSales((String)map.get("totalSales") == null ? "" : (String)map.get("totalSales"));
		vo.setTaxTypeFlag((String)map.get("taxTypeFlag") == null ? "" : (String)map.get("taxTypeFlag"));
		return vo;
	}
}
