package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.FilenameService;
import com.smpro.service.ItemService;
import com.smpro.service.SellerService;
import com.smpro.service.SystemService;
import com.smpro.util.*;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Workbook;
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
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class SellerController {

	@Autowired
	private SellerService sellerService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private FilenameService filenameService;
	
	/** 총판/입점업체 리스트 */
	@CheckGrade(controllerName = "sellerController", controllerMethod = "getList")
	@RequestMapping(value = "/seller/list/{typeCode}")
	public String getList(@PathVariable String typeCode, HttpSession session, SellerVo pvo, Model model) {
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		if ("D".equals(typeCode)) {
			model.addAttribute("title", "총판 리스트");
		} else {
			model.addAttribute("title", "입점업체 리스트");
		}

		/* 공통코드 리스트 가져오기 */
		CommonVo cvo = new CommonVo();
		// 상태
		cvo.setGroupCode(new Integer(1));
		model.addAttribute("statusList", systemService.getCommonList(cvo));
		// 등급
		cvo.setGroupCode(new Integer(8));
		model.addAttribute("gradeList", systemService.getCommonList(cvo));
		// 자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		
		// 인증구분
		if(pvo.getAuthCategory() != null && !"".equals(pvo.getAuthCategory()) ) {
			pvo.setAuthCategoryArr( pvo.getAuthCategory().split(",") );
		}

		pvo.setLoginSeq(loginSeq);
		pvo.setLoginType((String) session.getAttribute("loginType"));
		pvo.setTypeCode(typeCode);
		pvo.setTotalRowCount(sellerService.getListCount(pvo));
		model.addAttribute("list", sellerService.getList(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		model.addAttribute("paging", pvo.drawPagingNavigation("goPage"));
		model.addAttribute("pvo", pvo);
		model.addAttribute("typeCode", typeCode);
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/seller/list.jsp";
	}

	/** 총판/입점업체 신규 등록 폼 */
	@CheckGrade(controllerName = "sellerController", controllerMethod = "getRegForm")
	@RequestMapping("/seller/reg/{typeCode}")
	public String getRegForm(@PathVariable String typeCode, Model model) {
		if ("D".equals(typeCode)) {
			model.addAttribute("title", "총판 신규 등록");
		} else {
			model.addAttribute("title", "입점업체 신규 등록");
			/* 총판 콤보박스 리스트 */
			SellerVo pvo = new SellerVo();
			pvo.setStatusCode("Y"); // 승인 상태이고
			pvo.setTypeCode("D"); // 구분값이 총판
			model.addAttribute("masterList", sellerService.getSimpleList(pvo));
		}
		
		CommonVo cvo = new CommonVo();
		//자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));
		model.addAttribute("deliCompanyList", systemService.getDeliCompany());
		model.addAttribute("typeCode", typeCode);
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/seller/form.jsp";
	}

	/** 총판/입점업체 수정 폼 */
	@CheckGrade(controllerName = "sellerController", controllerMethod = "getModForm")
	@RequestMapping("/seller/mod/{seq}")
	public String getModForm(@PathVariable int seq, Model model) {

		/* 콤보박스 리스트 가져오기 */
		CommonVo cvo = new CommonVo();
		// 회원 상태
		// cvo.setGroupCode(1);
		// model.addAttribute("statusList", systemService.getCommonList(cvo));
		// 회원 등급
		cvo.setGroupCode(new Integer(8));
		model.addAttribute("gradeList", systemService.getCommonList(cvo));
		//자치구 코드
		cvo.setGroupCode(new Integer(29));
		model.addAttribute("jachiguList", systemService.getCommonList(cvo));

		/* 총판 콤보박스 리스트 */
		SellerVo pvo = new SellerVo();
		pvo.setStatusCode("Y"); // 승인 상태이고
		pvo.setTypeCode("D"); // 구분값이 총판
		model.addAttribute("masterList", sellerService.getSimpleList(pvo));

		/* 입점업체 상세 정보 */
		SellerVo vo;
		try {
			vo = sellerService.getData(new Integer(seq));
		} catch (Exception e) {
			model.addAttribute("message", "입점업체 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.ALERT_PAGE;
		}

		if (vo != null) {
			if ("D".equals(vo.getTypeCode())) {
				model.addAttribute("title", "총판 정보 수정");
			} else {
				model.addAttribute("title", "입점업체 정보 수정");
			}
		}
		model.addAttribute("deliCompanyList", systemService.getDeliCompany());
		model.addAttribute("vo", vo);
		

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "seller");
		map.put("parentSeq", new Integer(seq));
		model.addAttribute("file", filenameService.getList(map));
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/seller/form.jsp";
	}

	/** 입점업체 등록 */
	@RequestMapping(value = "/seller/reg/proc", method = RequestMethod.POST)
	public String regData(HttpServletRequest request, String code, Model model,String authCategory) {
		boolean flag = false;
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		SellerVo vo = getSellerVo(map);
		vo.setAuthCategory(authCategory);

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
						
			model.addAttribute("message", "등록 성공.");
			model.addAttribute("returnUrl",	"/admin/seller/list/" + vo.getTypeCode());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "등록 실패.");
		return Const.ALERT_PAGE;
	}

	/** 입점업체수정 */
	@RequestMapping(value = "/seller/mod/{seq}/proc", method = RequestMethod.POST)
	public String modData(@PathVariable Integer seq, HttpServletRequest request, String code,  Model model,String authCategory) {
		//관리자가 아니면  해당 정보의 소유자를 체크한다.
		HttpSession session = request.getSession();
		if(!"A".equals(session.getAttribute("loginType"))) {
			Integer loginSeq = Integer.valueOf(String.valueOf(session.getAttribute("loginSeq")));
			if(!seq.equals(loginSeq)) {
				model.addAttribute("message", "본인 이외의 정보는 수정할 수 없습니다. !!!");
				return Const.ALERT_PAGE;
			}
		}
		
		boolean flag = false;
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		//멀티파트로 보내기때문에 파라미터를 따로 처리한다.
		HashMap<String,Object> map = CommonServletUtil.getRequestParameterMap(request);
		SellerVo vo = getSellerVo(map);
		vo.setSeq(seq);
		vo.setLoginType((String)session.getAttribute("loginType"));
		vo.setAuthCategory(authCategory);

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
			model.addAttribute("returnUrl", "/admin/seller/mod/" + vo.getSeq());
			return Const.REDIRECT_PAGE;
		}

		model.addAttribute("message", "수정 실패.");
		return Const.ALERT_PAGE;
	}
	
	/** 총판/입점업체 삭제 */
	@RequestMapping("/seller/delete")
	public String deleteProc(Integer seq, Model model) {
		
		if(!sellerService.deleteSeller(seq)) {
			model.addAttribute("message", "삭제 실패.");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "<script>alert('삭제되었습니다');top.location.reload();</script>");
		return Const.AJAX_PAGE;
	}
	
	/* 업체 코멘트 등록/수정 */
	@RequestMapping("/seller/comment/reg")
	public String commentReg(SellerVo vo, Model model){
		if(sellerService.updateComment(vo)<1){
			model.addAttribute("message", "코멘트 등록 실패");
			return Const.ALERT_PAGE;
		}
		
		model.addAttribute("message", "코멘트 등록 성공");
		model.addAttribute("returnUrl", "/admin/seller/mod/" + vo.getSeq());
		return Const.REDIRECT_PAGE;
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
	public void download(@RequestParam int seq, @RequestParam int num, HttpServletResponse response) throws Exception {
		SellerVo vo = sellerService.getData(new Integer(seq));
		if(vo == null) {
			return;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("parentCode", "seller");
		map.put("parentSeq", new Integer(seq));
		map.put("num", new Integer(num));

		FilenameVo fvo = filenameService.getVo(map);
		
		fvo.setFilename(java.net.URLEncoder.encode(fvo.getFilename(),"UTF-8"));
		
		response.setHeader("Content-Type", "application/octet-stream;");	
		response.setHeader("Content-Disposition", "attachment; filename="+fvo.getFilename());
				
		try {
			FileUtil.write(new FileInputStream(new File(Const.UPLOAD_REAL_PATH.replaceAll("(upload)$", "") + fvo.getRealFilename())), response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/** 승인/폐점 처리 */
	@RequestMapping(value = "/seller/status/update")
	public String updateStatus(HttpSession session, SellerVo vo, Model model) {
		boolean flag = false;
		try {
			flag = sellerService.updateStatus(vo);
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
		
		//폐점처리일 경우 상품 판매중지 처리
		if(flag && "X".equals(vo.getStatusCode())) {
			ItemVo pvo = new ItemVo();
			pvo.setSellerSeq(vo.getSeq());
			List<ItemVo> originList = itemService.getListForSelling(pvo);
			
			if(originList != null) {
				for(int i=0; i<originList.size(); i++) {
					ItemVo originVo = originList.get(i); 
					
					ItemVo paramVo = new ItemVo();
					paramVo.setSeq(originVo.getSeq());
					paramVo.setStatusCode("N");
					itemService.updateStatusCode(paramVo);
					
					String message = getLogMessage(originVo);
					if(!"".equals(message)) {
						// 로그 이력 생성
						ItemLogVo logVo = new ItemLogVo();
						logVo.setItemSeq(originVo.getSeq());
						logVo.setAction("업체 폐점 처리");
						logVo.setContent("statusCode="+paramVo.getStatusCode());
						logVo.setModContent(message);
						logVo.setLoginSeq(Integer.valueOf(String.valueOf(session.getAttribute("loginSeq"))));
						logVo.setLoginType(String.valueOf(session.getAttribute("loginType")));
						itemService.insertLogVo(logVo);
					}
					
				}
			}
		}

		if (flag) {
			model.addAttribute("message", "상태 업데이트 성공.");
			model.addAttribute("returnUrl", "/admin/seller/mod/" + vo.getSeq());
			return Const.REDIRECT_PAGE;
		}
		
		model.addAttribute("message", "상태 업데이트 실패.");
		return Const.ALERT_PAGE;
	}

	@RequestMapping("/seller/{seq}/json")
	public String getVoForJson(@PathVariable Integer seq, Model model) {
		// TODO : 셀러 vo에 접근할 수 있는 권한을 체크하여야 한다
		// 상품 등록 시에 셀러 리스트를 json으로 호출하고 있음. (상품 등록이 가능한 유저에게 권한 설정)

		SellerVo vo;
		try {
			vo = sellerService.getData(seq);
		} catch (Exception e) {
			model.addAttribute("message",
					"입점업체 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.AJAX_PAGE;
		}
		model.addAttribute("item", vo);
		return "/ajax/get-seller-vo.jsp";
	}

	@RequestMapping("/seller/list/{typeCode}/json")
	public String getListForJson(@PathVariable String typeCode, SellerVo pvo, Model model) {
		// TODO : 셀러 리스트에 접근할 수 있는 권한을 체크하여야 한다
		// 상품 등록 시에 셀러 리스트를 json으로 호출하고 있음. (상품 등록이 가능한 유저에게 권한 설정)
		pvo.setStatusCode("Y");
		pvo.setTypeCode(typeCode);
		pvo.setRowCount(10);
		pvo.setTotalRowCount(sellerService.getListCount(pvo));

		model.addAttribute("list", sellerService.getList(pvo));
		model.addAttribute("total", new Integer(pvo.getTotalRowCount()));
		return "/ajax/get-seller-list.jsp";
	}

	@RequestMapping("/seller/list/{typeCode}/json/paging")
	public String getAjaxItemListPaging(@PathVariable String typeCode, SellerVo pvo, Model model) {
		pvo.setStatusCode("Y");
		pvo.setTypeCode(typeCode);
		pvo.setRowCount(10);
		pvo.setTotalRowCount(sellerService.getListCount(pvo));
		model.addAttribute("message", pvo.drawPagingNavigation("goPage"));
		return Const.AJAX_PAGE;
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
				return "이미 사용중인 아이디입니다.";
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

	/** 회원 리스트 엑셀 다운로드 */
	@CheckGrade(controllerName = "sellerController", controllerMethod = "writeExcelSellerList")
	@RequestMapping("/seller/list/download/excel")
	public void writeExcelSellerList(SellerVo pvo, HttpSession session,
			HttpServletResponse response) throws IOException {
		// 엑셀 다운로드시 row수를 3000개로 무조건 고정한다.
		pvo.setRowCount(3000);
		// 세션
		String loginId = String.valueOf(session.getAttribute("loginId"));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = seller_list_" + loginId + "_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		// 워크북
		Workbook wb = sellerService.writeExcelSellerList(pvo, "xls");
		// 파일스트림
		OutputStream fileOut = response.getOutputStream();

		wb.write(fileOut);
		fileOut.flush();

		wb.close();
		fileOut.close();
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
	
	//상품 변경 로그에 저장될 정보 체크
	private String getLogMessage(ItemVo vo) {
		String message = "";
		ItemVo dbVo = itemService.getVo(vo.getSeq());

		if (!vo.getStatusCode().equals(dbVo.getStatusCode())) {
			if (!"".equals(message)) {
				message += ",";
			}
			message += " 상품상태=" + dbVo.getStatusCode();
		}	
		
		return message;
	}
}
