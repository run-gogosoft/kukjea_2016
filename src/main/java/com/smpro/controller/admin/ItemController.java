package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.filter.ImageFileNameFilter;
import com.smpro.service.*;
import com.smpro.util.CommandUtil;
import com.smpro.util.Const;
import com.smpro.util.EditorUtil;
import com.smpro.util.FileUtil;
import com.smpro.util.StringUtil;
import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.vo.*;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

@Slf4j
@Controller
public class ItemController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private ItemOptionService itemOptionService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private MallService mallService;

	@Autowired
	private SystemService systemService;
	
	@Autowired
	DataSourceTransactionManager transactionManager;
	public void setTransactionManager(
		DataSourceTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "best")
	@RequestMapping("/item/best/form")
	public String best(Model model) {
		model.addAttribute("title", "베스트상품 관리");
		return "/best/form.jsp";
	}
	
	@CheckGrade(controllerName = "itemController", controllerMethod = "view")
	@RequestMapping("/item/view/{seq}")
	public String view(@PathVariable Integer seq, Integer pageNum, HttpSession session, Model model) {
		// 상품 소유자 체크
		String loginType = (String) session.getAttribute("loginType");
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
/*
		if ("S".equals(loginType)) {
			if (!itemService.diffSellerSeq(seq, loginSeq)) {
				model.addAttribute("message", "잘못된 접근입니다.");
				model.addAttribute("returnUrl", "/admin/item/list");
				return Const.REDIRECT_PAGE;
			}
		} else if ("D".equals(loginType)) {
			if (!itemService.diffMasterSeq(seq, loginSeq)) {
				model.addAttribute("message", "잘못된 접근입니다.");
				model.addAttribute("returnUrl", "/admin/item/list");
				return Const.REDIRECT_PAGE;
			}
		}
		*/
		ItemVo vo = itemService.getVo(seq);

		model.addAttribute("pageNum", pageNum);
		model.addAttribute("title", "상품");
		model.addAttribute("vo", itemService.getVo(seq));
		model.addAttribute("optionList", itemOptionService.getList(seq));
		model.addAttribute("propList", itemService.getPropList(vo.getTypeCd()));
		model.addAttribute("propInfo", itemService.getInfo(seq));
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/item/view.jsp";
	}

	@RequestMapping("/item/view/{seq}/log/ajax")
	public String viewLog(@PathVariable Integer seq, ItemLogVo vo, Model model) {
		vo.setSeq(seq);
		vo.setTotalRowCount(itemService.getLogListTotalCount(vo).intValue());
		model.addAttribute("list", itemService.getLogList(vo));
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));
		return "/item/log.jsp";
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "delete")
	@RequestMapping("/item/delete/proc/{seq}")
	public String delete(@PathVariable Integer seq, String search, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		// 상품 소유자 체크
		String loginType = (String) session.getAttribute("loginType");
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");

		if ("S".equals(loginType)) {
			if (!itemService.diffSellerSeq(seq, loginSeq)) {
				model.addAttribute("message", "잘못된 접근입니다.");
				return Const.ALERT_PAGE;
			}
		} else if ("D".equals(loginType)) {
			model.addAttribute("message", "잘못된 접근입니다.");
			return Const.ALERT_PAGE;
		}

		/** 주문이 하나라도 있으면 삭제불가능 */
		if (orderService.getItemOrderCnt(seq)) {
			model.addAttribute("message", "주문이 있는 상품은 삭제할수 없습니다.");
			return Const.ALERT_PAGE;
		}

		itemService.deleteFiles(Const.UPLOAD_REAL_PATH, seq);

		// 로그 (이력)
		ItemVo vo = itemService.getVo(seq);
		ItemLogVo lvo = new ItemLogVo();
		lvo.setItemSeq(vo.getSeq());
		lvo.setAction("삭제");
		lvo.setContent(vo.toString());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));

		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "데이터 삭제 도중 오류가 발생했습니다[3]");
			return Const.ALERT_PAGE;
		}

		if (!itemService.deleteVo(seq)) {
			model.addAttribute("message", "상품을 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "삭제되었습니다");
		model.addAttribute("returnUrl", "/admin/item/list?" + (search == null ? "" : search.replace("&amp;", "&")));
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "list")
	@RequestMapping("/item/list")
	public String list(HttpServletRequest request, ItemVo vo, Model model) {
		HttpSession session = request.getSession(false);
		
		vo.setLoginType((String) session.getAttribute("loginType"));
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));

		// 카테고리를 가져온다
		CategoryVo cvo = new CategoryVo();
		//대분류
		cvo.setDepth(1);
		model.addAttribute("cateLv1List", categoryService.getList(cvo));

		//중분류
		if (vo.getCateLv1Seq() != null) {
			cvo.setDepth(2);
			cvo.setParentSeq(vo.getCateLv1Seq());
			model.addAttribute("cateLv2List", categoryService.getList(cvo));
		}
		
		//소분류
		if (vo.getCateLv1Seq() != null && vo.getCateLv2Seq() != null) {
			cvo.setDepth(3);
			cvo.setParentSeq(vo.getCateLv2Seq());
			model.addAttribute("cateLv3List", categoryService.getList(cvo));
		}
		
		//세분류
		if (vo.getCateLv1Seq() != null && vo.getCateLv2Seq() != null && vo.getCateLv3Seq() != null) {
			cvo.setDepth(4);
			cvo.setParentSeq(vo.getCateLv3Seq());
			model.addAttribute("cateLv4List", categoryService.getList(cvo));
		}

		if (vo.getRowCount() == 20) {
			vo.setRowCount(50);
		}
		
		// 인증구분
		if(!"".equals(vo.getAuthCategory()) ) {
			vo.setAuthCategoryArr( vo.getAuthCategory().split(",") );
		}

		vo.setTotalRowCount(itemService.getListTotalCount(vo));

		List<ItemVo> list = itemService.getList(vo);
		model.addAttribute("list",list);
		model.addAttribute("vo", vo);
		model.addAttribute("paging", vo.drawPagingNavigation("goPage"));

		/* 마스터 벤더
		SellerVo svo = new SellerVo();
		svo.setTypeCode("D");
		svo.setRowCount(9999);
		model.addAttribute("masterList", sellerService.getList(svo));*/
		
		// 인증구분 공통코드
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/item/list.jsp";
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "form")
	@RequestMapping("/item/form")
	public String form(Model model) {
		model.addAttribute("title", "상품 등록");
		model.addAttribute("typeInfoList", itemService.getTypeInfoList());
		model.addAttribute("filterList", itemService.getFilterList());
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/item/form.jsp";
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "updateForm")
	@RequestMapping("/item/form/{seq}")
	public String updateForm(@PathVariable Integer seq, Integer pageNum, HttpSession session, Model model) {
		// 상품 소유자 체크
		String loginType = (String) session.getAttribute("loginType");
		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
/*
		if ("S".equals(loginType)) {
			if (!itemService.diffSellerSeq(seq, loginSeq)) {
				model.addAttribute("message", "잘못된 접근입니다.");
				model.addAttribute("returnUrl", "/admin/item/list");
				return Const.REDIRECT_PAGE;
			}
		} else if ("D".equals(loginType)) {
			model.addAttribute("message", "잘못된 접근입니다.");
			model.addAttribute("returnUrl", "/admin/item/list");
			return Const.REDIRECT_PAGE;
		}
*/

		model.addAttribute("pageNum", pageNum);
		// todo : 아이템을 수정할 수 있는 권한이 있는지 검사하여야 함
		model.addAttribute("title", "상품 수정");
		model.addAttribute("vo", itemService.getVo(seq));
		model.addAttribute("typeInfoList", itemService.getTypeInfoList()); // 상품 고시정보 분류 목록		
		model.addAttribute("propInfo", itemService.getInfo(seq)); // 해당 상품에 저장된 상품고시정보
		model.addAttribute("filterList", itemService.getFilterList());
		model.addAttribute("authCategoryList", systemService.getCommonListOrderByValue(new Integer(35)));
		return "/item/form.jsp";
	}

	@RequestMapping("/item/form/new")
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public String insert(ItemVo vo, HttpServletRequest request, Model model) throws IOException {
		HttpSession session = request.getSession(false);
		
		//파라메타 유효성 검증
		String reqParamErrMsg = checkReqParam(vo, session, "new");
		if(reqParamErrMsg != null) {
			model.addAttribute("message", reqParamErrMsg);
			return Const.ALERT_PAGE;
		}
		
		//판매상태 기본 승인 대기
		vo.setStatusCode("H");
		/*
		if(!"copy".equals(vo.getUpdateType())) {
			if (vo.getTypeCd() == null) {
				model.addAttribute("message", "상품 추가정보는 반드시 입력되어야 합니다");
				return Const.ALERT_PAGE;
			}
		}
		*/
		// 복사할 대상 상품의 데이터를 가지고 오기 위해 새로운 시퀀스를 생성해서 seq변수에 적용하기전 form으로부터 넘겨받은
		// seq값을 임시 저장한다.
		Integer originSeq = vo.getSeq();
		
		//시퀀스 생성
		if(itemService.createSeq(vo) != 1) {
			model.addAttribute("message", "상품 일련번호 생성에 실패하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		String realPath = Const.UPLOAD_REAL_PATH + "/item";
		/** 상품 복사 일때 저장된 이미지 경로를 가져온다. */
		if ("copy".equals(vo.getUpdateType())) {
			String errMsg = "";

			ItemVo ivo = itemService.getVo(originSeq);

			if (!"".equals(ivo.getImg1())) {
				errMsg = copyItemImageUpload(ivo.getImg1(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg1(itemService.imageProc(realPath, "1", String.valueOf(vo.getSeq()) + ivo.getImg1().substring(ivo.getImg1().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(ivo.getImg2())) {
				errMsg = copyItemImageUpload(ivo.getImg2(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg2(itemService.imageProc(realPath, "2", String.valueOf(vo.getSeq()) + ivo.getImg2().substring(ivo.getImg2().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(ivo.getImg3())) {
				errMsg = copyItemImageUpload(ivo.getImg3(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg3(itemService.imageProc(realPath, "3",	String.valueOf(vo.getSeq()) + ivo.getImg3().substring(ivo.getImg3().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(ivo.getImg4())) {
				errMsg = copyItemImageUpload(ivo.getImg4(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg4(itemService.imageProc(realPath, "4",	String.valueOf(vo.getSeq()) + ivo.getImg4().substring(ivo.getImg4().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(ivo.getDetailImg1())) {
				errMsg = copyItemImageUpload(ivo.getDetailImg1(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				vo.setDetailImg1(itemService.imageDetailProc(realPath, "1",	String.valueOf(vo.getSeq()) + ivo.getDetailImg1().substring(ivo.getDetailImg1().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(ivo.getDetailImg2())) {
				errMsg = copyItemImageUpload(ivo.getDetailImg2(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				vo.setDetailImg2(itemService.imageDetailProc(realPath, "2",	String.valueOf(vo.getSeq()) + ivo.getDetailImg2().substring(ivo.getDetailImg2().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(ivo.getDetailImg3())) {
				errMsg = copyItemImageUpload(ivo.getDetailImg3(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				vo.setDetailImg3(itemService.imageDetailProc(realPath, "3",	String.valueOf(vo.getSeq()) + ivo.getDetailImg3().substring(ivo.getDetailImg3().lastIndexOf(".")), vo.getSeq()));
			}
			
			//에디터로 업로드한 이미지 복사
			vo.setContent(copyEditorImage(originSeq, vo.getSeq(), vo.getContent()));
		} else {
			if (!"".equals(vo.getImg1())) {
				vo.setImg1(itemService.imageProc(realPath, "1", vo.getImg1().replace("/upload/item/temp/", ""), vo.getSeq()));
			}
			if (!"".equals(vo.getImg2())) {
				vo.setImg2(itemService.imageProc(realPath, "2", vo.getImg2().replace("/upload/item/temp/", ""), vo.getSeq()));
			}
			if (!"".equals(vo.getImg3())) {
				vo.setImg3(itemService.imageProc(realPath, "3", vo.getImg3().replace("/upload/item/temp/", ""), vo.getSeq()));
			}
			if (!"".equals(vo.getImg4())) {
				vo.setImg4(itemService.imageProc(realPath, "4", vo.getImg4().replace("/upload/item/temp/", ""), vo.getSeq()));
			}

			if (!"".equals(vo.getDetailImg1())) {
				vo.setDetailImg1(itemService.imageDetailProc(realPath, "1", vo.getDetailImg1().replace("/upload/item/temp/", ""), vo.getSeq()));
			}
			if (!"".equals(vo.getDetailImg2())) {
				vo.setDetailImg2(itemService.imageDetailProc(realPath, "2", vo.getDetailImg2().replace("/upload/item/temp/", ""), vo.getSeq()));
			}
			if (!"".equals(vo.getDetailImg3())) {
				vo.setDetailImg3(itemService.imageDetailProc(realPath, "3", vo.getDetailImg3().replace("/upload/item/temp/", ""), vo.getSeq()));
			}
			
			//에디터 업로드 이미지 처리
			vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "item"));
		}

		// Programmatic Transaction management
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);

		try {
			// 데이터베이스에 삽입한다
			if (!itemService.insertVo(vo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[1]");
			}
			if (!itemService.insertDetailVo(vo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[3]");
			}

			// 로그 (이력)
			ItemLogVo lvo = new ItemLogVo();
			lvo.setItemSeq(vo.getSeq());
			lvo.setAction("등록");
			lvo.setContent(vo.toString());
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			lvo.setLoginType("" + session.getAttribute("loginType"));
			if (!itemService.insertLogVo(lvo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[4]");
			}

			// 오류 메시지를 포함하고 있었다면
			if (model.containsAttribute("message")) {
				transactionManager.rollback(status);
				return Const.ALERT_PAGE;
			}

			transactionManager.commit(status);

		} catch (Exception e) {
			transactionManager.rollback(status);
			model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다 >>> " + e.getMessage());
			log.error(e.getMessage());
			return Const.REDIRECT_PAGE;
		}

		// 시퀀스를 넘겨 호출시킨다
		model.addAttribute("callback", "OK:" + vo.getSeq());
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping(value = "/item/upload", method = RequestMethod.POST)
	public String upload(@RequestParam int idx, HttpServletRequest request,	Model model) {
		// todo : 업로드할 수 있는 권한이 있는지 검사

		Map<String, String> fileMap;
		try {
			fileMap = itemService.uploadImagesByMap(request);
		} catch (IOException ie) {
			log.error(ie.getMessage());
			model.addAttribute("message", "서버상의 문제가 발생했습니다. 관리자에게 문의하여 주십시오.");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (MaxUploadSizeExceededException me) {
			model.addAttribute("message", "한번에 너무 큰 용량의 이미지를 첨부하실 수 없습니다");
			me.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (ImageIsNotAvailableException ie) {
			model.addAttribute("message", "첨부한 파일은 이미지 파일이 아닙니다");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		}
		String files = "";
		if (fileMap != null) {
			if (fileMap.get("file[0]") != null) {
				files += idx + ":/upload/item/temp/" + fileMap.get("file[0]");

				// 이미지 매직 변환
				// String savePath =
				// request.getSession().getServletContext().getRealPath("/upload/item/temp");
				// //build path
				String savePath = Const.UPLOAD_REAL_PATH + "/item/temp";
				if (!CommandUtil.imageResizeForImageMagick(fileMap.get("file[0]").split("\\.")[0], savePath, "." + fileMap.get("file[0]").split("\\.")[1])) {
					model.addAttribute("message", "이미지를 변환하던 도중에 오류가 발생했습니다");
					return Const.ALERT_PAGE;
				}
			}
		}
		// 업로드된 파일 리스트를 던진다
		model.addAttribute("callback", files);
		return Const.REDIRECT_PAGE;
	}

	public String copyItemImageUpload(String urlString, Integer fileName) throws IOException {
		String fileExt = urlString.substring(urlString.lastIndexOf("."));
		String savePath = Const.UPLOAD_REAL_PATH + "/item/temp/";
		
		InputStream origin = null;
		OutputStream target = null;
		try {
			origin = new FileInputStream(Const.UPLOAD_REAL_PATH + urlString);
			target = new FileOutputStream(savePath + "/" + fileName + fileExt);
			if(FileUtil.write(origin, target)){
				//상품상세 이미지는 원본파일 하나만 사용하므로 리사이징이 필요없다.
				if (!urlString.startsWith("/item/detail/")) {
					// 이미지 리사이징
					if (!CommandUtil.imageResizeForImageMagick(String.valueOf(fileName), savePath, fileExt)) {
						return "이미지를 변환하던 도중에 오류가 발생했습니다";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(origin != null) origin.close();
			if(target != null) target.close();			
		}
		
		return "";
	}
	
	/** 에디터로 업로드된 이미지 복사 */
	private String copyEditorImage(Integer originSeq, Integer seq, String content) throws IOException {
		String newContent = content;
		
		String dirHome = Const.UPLOAD_REAL_PATH + "/editor/item/";
		String originDirName = dirHome + EditorUtil.calcPerSeq(originSeq);
		String newDirName = dirHome + EditorUtil.calcPerSeq(seq);
		//원본 디렉토리		
		File originDir = new File(originDirName);
		//원본 파일들
		File[] originFiles = originDir.listFiles(new ImageFileNameFilter(String.valueOf(originSeq)));
		if(originFiles != null) {
			//복사할 디렉토리 생성
			File newDir = new File(newDirName);
			FileUtil.mkdir(newDir);

			//원본 이미지 갯수만큼 복사
			for(int i=0; i < originFiles.length; i++) {
				InputStream origin = null;
				OutputStream target= null;
				String originFileName = originFiles[i].getName();
				String newFileName = seq+"_"+(i+1)+originFileName.substring(originFileName.lastIndexOf("."));
				try {
					origin = new FileInputStream(originFiles[i]);
					target = new FileOutputStream(new File(newDir, newFileName));
					FileUtil.write(origin, target);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if(origin != null) origin.close();
					if(target != null) target.close();			
				}
				
				String originUrl = "http://" + Const.DOMAIN+Const.UPLOAD_PATH + originDirName.replace(Const.UPLOAD_REAL_PATH, "") + "/" + originFileName;
				String newUrl = "http://" + Const.DOMAIN+Const.UPLOAD_PATH + newDirName.replace(Const.UPLOAD_REAL_PATH, "") + "/" + newFileName; 
				
				log.debug("### originUrl : " + originUrl);
				log.debug("### newUrl : " + newUrl);
				newContent = newContent.replace(originUrl, newUrl);
			}
		}
		
		return newContent;
	}
	
	@RequestMapping(value = "/item/upload/detail", method = RequestMethod.POST)
	public String uploadDetail(@RequestParam int idx,
			HttpServletRequest request, Model model) {
		// todo : 업로드할 수 있는 권한이 있는지 검사

		Map<String, String> fileMap;
		try {
			fileMap = itemService.uploadImagesByMap(request);
		} catch (IOException ie) {
			log.error(ie.getMessage());
			model.addAttribute("message", "서버상의 문제가 발생했습니다. 관리자에게 문의하여 주십시오.");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (MaxUploadSizeExceededException me) {
			model.addAttribute("message", "한번에 너무 큰 용량의 이미지를 첨부하실 수 없습니다");
			me.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (ImageIsNotAvailableException ie) {
			model.addAttribute("message", "첨부한 파일은 이미지 파일이 아닙니다");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		}
		String files = "DETAIL:";
		if (fileMap != null) {
			if (fileMap.get("file[0]") != null) {
				files += idx + ":/upload/item/temp/" + fileMap.get("file[0]");
			}
		}

		// 업로드된 파일 리스트를 던진다
		model.addAttribute("callback", files);
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping("/item/image/resize/again")
	public static String resizeAgain(String filename, Model model) {
		// todo : 수정할 수 있는 권한이 있는지 검사

		if (!filename.startsWith("/item/origin/")) {
			model.addAttribute("message", "비정상적인 접근입니다!");
			return Const.ALERT_PAGE;
		}

		// String savePath =
		// request.getSession().getServletContext().getRealPath(""); //build
		// path
		String savePath = Const.UPLOAD_REAL_PATH;
		if (!CommandUtil.imageResizeForImageMagickAgain(
				filename.split("\\.")[0], savePath, "."
						+ filename.split("\\.")[1])) {
			model.addAttribute("message", "변환 도중에 오류가 발생했습니다");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("message", "이미지가 다시 변환되었습니다. 새로고침을 해보세요");
		return Const.ALERT_PAGE;
	}
	
	@RequestMapping(value = "/item/img/delete", method = RequestMethod.POST)
	public String imgDelete(@RequestParam int idx, @RequestParam String imgPath, @RequestParam Integer imageSeq, Model model) {
		if(imageSeq == null) {
			model.addAttribute("message", "올바르지 않은 데이터가 존재합니다.[1]");
			return Const.ALERT_PAGE;
		} else if(idx <= 0) {
			model.addAttribute("message", "올바르지 않은 데이터가 존재합니다.");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(imgPath)) {
			model.addAttribute("message", "이미지 경로가 존재하지 않습니다.");
			return Const.ALERT_PAGE;
		}
		
		
		if (!itemService.imgDelete(idx, imgPath, model)) {
			return Const.ALERT_PAGE;
		}
		
		ItemVo vo = new ItemVo();
		if(idx == 1) {
			vo.setImg1(imgPath);
		} else if(idx == 2) {
			vo.setImg2(imgPath);
		} else if(idx == 3) {
			vo.setImg3(imgPath);
		} else if(idx == 4) {
			vo.setImg4(imgPath);
		}
		vo.setSeq(imageSeq);
		if(!itemService.deleteImgPath(vo)) {
			model.addAttribute("message", "이미지 경로 삭제가 실패하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		// 업로드된 파일 리스트를 던진다
		String imgText = "";
		if(idx == 1) {
			imgText = "대표";
		} else {
			imgText = "서브";
		}
		model.addAttribute("message", "["+imgText+" 이미지"+idx+"] 정상적으로 삭제되었습니다.");
		model.addAttribute("returnUrl", "/admin/item/form/"+imageSeq);
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping(value = "/item/img/delete/detail", method = RequestMethod.POST)
	public String detailImgDelete(@RequestParam int idx, @RequestParam String imgPath, @RequestParam Integer imageSeq, Model model) {
		if(imageSeq == null) {
			model.addAttribute("message", "올바르지 않은 데이터가 존재합니다.[1]");
			return Const.ALERT_PAGE;
		} else if(idx <= 0) {
			model.addAttribute("message", "올바르지 않은 데이터가 존재합니다.[2]");
			return Const.ALERT_PAGE;
		} else if(StringUtil.isBlank(imgPath)) {
			model.addAttribute("message", "상세 이미지 경로가 존재하지 않습니다.");
			return Const.ALERT_PAGE;
		}
		
		if (!itemService.detailImgDelete(idx, imgPath, model)) {
			return Const.ALERT_PAGE;
		}
		
		ItemVo vo = new ItemVo();
		if(idx == 1) {
			vo.setDetailImg1(imgPath);
		} else if(idx == 2) {
			vo.setDetailImg2(imgPath);
		} else if(idx == 3) {
			vo.setDetailImg3(imgPath);
		}
		vo.setSeq(imageSeq);
		if(!itemService.deleteDetailImgPath(vo)) {
			model.addAttribute("message", "상세 이미지 경로 삭제가 실패하였습니다.");
			return Const.ALERT_PAGE;
		}
		
		// 업로드된 파일 리스트를 던진다
		model.addAttribute("message", "[상세이미지"+idx+"] 정상적으로 삭제되었습니다.");
		model.addAttribute("returnUrl", "/admin/item/form/"+imageSeq);
		return Const.REDIRECT_PAGE;
	}
	
	@RequestMapping("/item/form/modify")
	public String update(ItemVo vo, String searchText, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		// todo : 권한 검사
		if ("S".equals(session.getAttribute("loginType"))) {
			if (vo.getSellPrice() != vo.getTempSellPrice()) {
				vo.setStatusCode("H");
			}
		}

		//파라메타 유효성 검증
		String reqParamErrMsg = checkReqParam(vo, session, "modify");
		if(reqParamErrMsg != null) {
			model.addAttribute("message", reqParamErrMsg);
			return Const.ALERT_PAGE;
		}

		// 이미지 경로 변환
		// String realPath =
		// request.getSession().getServletContext().getRealPath("/upload/item");
		String realPath = Const.UPLOAD_REAL_PATH + "/item";
		if (!"".equals(vo.getImg1())) {
			vo.setImg1(itemService.imageProc(realPath, "1", vo.getImg1().replace("/upload/item/temp/", ""), vo.getSeq()));
		}
		if (!"".equals(vo.getImg2())) {
			vo.setImg2(itemService.imageProc(realPath, "2", vo.getImg2().replace("/upload/item/temp/", ""), vo.getSeq()));
		}
		if (!"".equals(vo.getImg3())) {
			vo.setImg3(itemService.imageProc(realPath, "3", vo.getImg3().replace("/upload/item/temp/", ""), vo.getSeq()));
		}
		if (!"".equals(vo.getImg4())) {
			vo.setImg4(itemService.imageProc(realPath, "4", vo.getImg4().replace("/upload/item/temp/", ""), vo.getSeq()));
		}

		if (!"".equals(vo.getDetailImg1())) {
			vo.setDetailImg1(itemService.imageDetailProc(realPath, "1", vo.getDetailImg1().replace("/upload/item/temp/", ""), vo.getSeq()));
		}
		if (!"".equals(vo.getDetailImg2())) {
			vo.setDetailImg2(itemService.imageDetailProc(realPath, "2", vo.getDetailImg2().replace("/upload/item/temp/", ""), vo.getSeq()));
		}
		if (!"".equals(vo.getDetailImg3())) {
			vo.setDetailImg3(itemService.imageDetailProc(realPath, "3", vo.getDetailImg3().replace("/upload/item/temp/", ""), vo.getSeq()));
		}
		
		//에디터 업로드 이미지 처리
		vo.setContent(EditorUtil.procImage(vo.getContent(), vo.getSeq(), "item"));
		
		ItemVo ivo = itemLogCheck(vo);

		// 데이터베이스에 삽입한다
		if (!itemService.updateVo(vo)) {
			model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[1]");
			return Const.ALERT_PAGE;
		}
		if (!itemService.updateDetailVo(vo)) {
			model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[2]");
			return Const.ALERT_PAGE;
		}

		// 로그 (이력)
		ItemLogVo lvo = new ItemLogVo();
		lvo.setItemSeq(vo.getSeq());
		lvo.setAction("수정");
		lvo.setContent(vo.toString());
		lvo.setModContent(ivo.getModContent());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));
		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[3]");
			return Const.ALERT_PAGE;
		}
		
		String search = searchText.replaceAll("=", "%3D");
		search = search.replaceAll("&amp;", "%26");

		// 시퀀스를 넘겨 호출시킨다
		model.addAttribute("message", "수정되었습니다");
		model.addAttribute("returnUrl", "/admin/item/view/"+vo.getSeq()+"?search=" + search);
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/item/option/new")
	public String insertOption(ItemOptionVo vo, HttpSession session, Model model) {
		if (vo.getItemSeq() == null) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.AJAX_PAGE;
		}
		if ("".equals(vo.getOptionName())) {
			model.addAttribute("message", "옵션명은 반드시 입력되어야 합니다");
			return Const.AJAX_PAGE;
		}
		List<FilterVo> list = itemService.getFilterList();
		if (StringUtil.filterWord(list, vo.getOptionName()) != "") {
			model.addAttribute("message", "상품옵션명에 금지어 " + StringUtil.filterWord(list, vo.getOptionName())	+ "가 포함되어있습니다");
			return Const.AJAX_PAGE;
		}
		if (StringUtil.getByteLength(vo.getOptionName()) > 300) {
			model.addAttribute("message", "옵션명은 300byte 이하로 입력되어야 합니다");
			return Const.AJAX_PAGE;
		}
		if ("".equals(vo.getShowFlag())) {
			model.addAttribute("message", "판매상태는 반드시 입력되어야 합니다");
			return Const.AJAX_PAGE;
		}
		if (!itemOptionService.insertVo(vo)) {
			model.addAttribute("message", "옵션을 등록하던 도중 오류가 발생했습니다");
			return Const.AJAX_PAGE;
		}

		// 로그 (이력)
		ItemLogVo lvo = new ItemLogVo();
		lvo.setItemSeq(vo.getItemSeq());
		lvo.setAction("옵션등록");
		lvo.setContent(vo.toString());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));
		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "FAIL");
			return Const.AJAX_PAGE;
		}
		model.addAttribute("message", vo.getSeq());
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/item/option/child/new")
	public String insertOptionValue(ItemOptionVo vo, HttpSession session, Model model) {
		if (vo.getOptionSeq() == null) {
			model.addAttribute("message", "FAIL[1]");
			return Const.AJAX_PAGE;
		}
		if ("".equals(vo.getValueName())) {
			model.addAttribute("message", "FAIL[2]");
			return Const.AJAX_PAGE;
		}
		List<FilterVo> list = itemService.getFilterList();
		if (StringUtil.filterWord(list, vo.getValueName()) != "") {
			model.addAttribute("message", "FAIL[5]");
			return Const.AJAX_PAGE;
		}

		if (StringUtil.isBlank("" + vo.getStockCount()) || vo.getStockCount() == 0) {
			model.addAttribute("message", "FAIL[6]");
			return Const.AJAX_PAGE;
		}

		if (!itemOptionService.insertValueVo(vo)) {
			model.addAttribute("message", "FAIL[4]");
			return Const.AJAX_PAGE;
		}

		// 로그 (이력)
		ItemLogVo lvo = new ItemLogVo();
		Integer itemSeq = itemOptionService.getVo(vo.getOptionSeq()).getItemSeq();
		lvo.setItemSeq(itemSeq);
		lvo.setAction("옵션항목등록");
		lvo.setContent(vo.toString());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));
		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "FAIL");
			return Const.AJAX_PAGE;
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/item/option/update")
	public String updateOption(ItemOptionVo vo, HttpSession session, Model model) {
		// todo : 해당 옵션을 수정할 수 있는 권한이 있는지 검사하여야 함

		if (vo.getSeq() == null) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.ALERT_PAGE;
		}
		if ("".equals(vo.getOptionName())) {
			model.addAttribute("message", "옵션명은 반드시 입력되어야 합니다");
			return Const.ALERT_PAGE;
		}
		List<FilterVo> list = itemService.getFilterList();
		if (StringUtil.filterWord(list, vo.getOptionName()) != "") {
			model.addAttribute("message","상품옵션명에 금지어 " + StringUtil.filterWord(list, vo.getOptionName()) + "가 포함되어있습니다.");
			return Const.ALERT_PAGE;
		}
		if (StringUtil.getByteLength(vo.getOptionName()) > 300) {
			model.addAttribute("message", "옵션명은 300byte 이하로 입력되어야 합니다");
			return Const.AJAX_PAGE;
		}
		if ("".equals(vo.getShowFlag())) {
			model.addAttribute("message", "판매상태는 반드시 입력되어야 합니다");
			return Const.ALERT_PAGE;
		}

		ItemOptionVo ivo = optionLogCheck(vo);

		if (!itemOptionService.updateVo(vo)) {
			model.addAttribute("message", "옵션을 수정하던 도중 오류가 발생했습니다");
			return Const.ALERT_PAGE;
		}

		// 로그 (이력)
		ItemLogVo lvo = new ItemLogVo();
		lvo.setItemSeq(itemOptionService.getVo(vo.getSeq()).getItemSeq());
		lvo.setAction("옵션수정");
		lvo.setContent(vo.toString());
		lvo.setModContent(ivo.getModContent());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));
		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "옵션 항목을 수정하던 도중 오류가 발생했습니다[2]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback", "OPTION");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/item/option/value/update")
	public String updateValueOption(ItemOptionVo vo, HttpSession session, Model model) {
		// todo : 해당 옵션항목을 수정할 수 있는 권한이 있는지 검사하여야 함

		if (vo.getSeq() == null) {
			model.addAttribute("message", "비정상적인 접근입니다");
			return Const.ALERT_PAGE;
		}
		if ("".equals(vo.getValueName().trim())) {
			model.addAttribute("message", "옵션명은 반드시 입력되어야 합니다");
			return Const.ALERT_PAGE;
		}
		List<FilterVo> list = itemService.getFilterList();
		if (StringUtil.filterWord(list, vo.getValueName()) != "") {
			model.addAttribute("message", "옵션항목에 금지어 " + StringUtil.filterWord(list, vo.getValueName()) + "가 포함되어있습니다.");
			return Const.ALERT_PAGE;
		}

		ItemOptionVo ivo = optionValueLogCheck(vo);

		if (!itemOptionService.updateValueVo(vo)) {
			model.addAttribute("message", "옵션 항목을 수정하던 도중 오류가 발생했습니다[1]");
			return Const.ALERT_PAGE;
		}

		// 로그 (이력)
		ItemLogVo lvo = new ItemLogVo();
		Integer itemSeq = itemOptionService.getValueVo(vo.getSeq()).getItemSeq();
		lvo.setItemSeq(itemSeq);
		lvo.setAction("옵션항목수정");
		lvo.setContent(vo.toString());
		lvo.setModContent(ivo.getModContent());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));

		log.info("lvo" + lvo.toString());

		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "옵션 항목을 수정하던 도중 오류가 발생했습니다[2]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback", "OPTION");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/item/option/delete")
	public String deleteOption(Integer seq, HttpSession session, Model model) {
		// todo : 해당 옵션을 지울 수 있는 권한이 있는지 검사하여야 함

		// 로그 (이력)
		ItemOptionVo vo = itemOptionService.getVo(seq);
		ItemLogVo lvo = new ItemLogVo();
		lvo.setItemSeq(vo.getItemSeq());
		lvo.setAction("옵션삭제");
		lvo.setContent(vo.toString());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));
		if (!itemService.insertLogVo(lvo)) {
			model.addAttribute("message", "옵션을 삭제하던 도중 오류가 발생했습니다[1]");
			return Const.ALERT_PAGE;
		}
		if (!itemOptionService.deleteVo(seq)) {
			model.addAttribute("message", "옵션을 삭제하던 도중 오류가 발생했습니다[2]");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback", "OPTION");
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/item/option/value/delete")
	public String deleteValueOption(Integer seq, HttpSession session, Model model) {
		// todo : 해당 옵션을 지울 수 있는 권한이 있는지 검사하여야 함

		// 로그 (이력)
		ItemOptionVo vo = itemOptionService.getValueVo(seq);
		ItemLogVo lvo = new ItemLogVo();
		lvo.setItemSeq(vo.getItemSeq());
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType((String) session.getAttribute("loginType"));

		// 만약 옵션항목이 1개였다면 상품 옵션까지 삭제한다
		try {
			Integer optionSeq = vo.getOptionSeq();
			List<ItemOptionVo> list = itemOptionService.getValueList(optionSeq);
			if (list.size() == 1) {
				// 옵션에 대한 이력 설정
				lvo.setAction("옵션삭제");
				lvo.setContent(list.get(0).toString());

				itemOptionService.deleteVo(optionSeq);
			} else {
				if (!itemOptionService.deleteValueVo(seq)) {
					model.addAttribute("message", "옵션항목을 삭제하던 도중 오류가 발생했습니다 ["
							+ seq + "]");
					return Const.ALERT_PAGE;
				}
				lvo.setAction("옵션항목삭제");
				lvo.setContent(vo.toString());
			}

			// 로그 삽입
			itemService.insertLogVo(lvo);
		} catch (NullPointerException e) {
			// 아무래도 seq가 잘못들어오면 optionValueList가 출력되기 전에 NullpointException이 날
			// 것이 분명하다
			model.addAttribute("message", "비정상적인 접근입니다!");
			return Const.ALERT_PAGE;
		}

		model.addAttribute("callback", "OPTION");
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 옵션의 모든 리스트를 반환
	 * 
	 * @param seq
	 * @param model
	 * @return
	 */
	@RequestMapping("/item/option/json/{seq}")
	public String getOptionList(@PathVariable Integer seq, Model model, HttpSession session) throws  Exception {

		Integer loginSeq = (Integer) session.getAttribute("loginSeq");
		if (loginSeq == null) {
			throw new Exception("비정상적인 접근입니다");
		}
		MemberVo memberVo = memberService.getData(loginSeq);
		if (memberVo == null) {
			throw new Exception("비정상적인 접근입니다");
		}

		List<ItemOptionVo> list = itemOptionService.getOptionList(seq);

		if ("A".equals(memberVo.getTypeCode())) {
			for (ItemOptionVo vo : list) {
				vo.setValueList(itemOptionService.getValueList(vo.getSeq()));
			}
		} else {
			for (ItemOptionVo vo : list) {
				Map map = new HashMap();
				map.put("seq", vo.getSeq());
				map.put("loginName", memberVo.getName());
				vo.setValueList(itemOptionService.getValueListForSeller(map));
			}
		}
		model.addAttribute("list", list);

		return "/ajax/get-option-list.jsp";
	}

	@RequestMapping("/item/option/json")
	public String getOptionVo(@RequestParam Integer seq, Model model) {
		model.addAttribute("item", itemOptionService.getVo(seq));
		return "/ajax/get-option-vo.jsp";
	}

	@RequestMapping("/item/option/value/json")
	public String getOptionValueVo(@RequestParam Integer seq, Model model) {
		model.addAttribute("item", itemOptionService.getValueVo(seq));
		return "/ajax/get-option-vo.jsp";
	}

	/**
	 * 일괄 삭제
	 * 
	 * @param procSeq
	 * @param searchText
	 * @param model
	 * @return
	 */
	@CheckGrade(controllerName = "itemController", controllerMethod = "batchDelete")
	@RequestMapping("/item/batch/delete")
	public String batchDelete(@RequestParam Integer[] procSeq, String searchText, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		// todo : 해당 배치를 실행시킬 수 있는지 검사하여야 함

		/** 주문이 하나라도 있으면 삭제불가능 */
		for (int i = 0; i < procSeq.length; i++) {
			if (orderService.getItemOrderCnt(procSeq[i])) {
				model.addAttribute("message", "주문이 있는 상품은 삭제할수 없습니다.[상품번호:"+ procSeq[i] + "]");
				return Const.ALERT_PAGE;
			}
		}

		// String realPath =
		// request.getSession().getServletContext().getRealPath("/"); //build
		// Path
		String realPath = Const.UPLOAD_REAL_PATH;
		// 로그 (이력)

		ItemLogVo lvo = new ItemLogVo();
		lvo.setAction("삭제");
		lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		lvo.setLoginType("" + session.getAttribute("loginType"));
		for (int i = 0; i < procSeq.length; i++) {
			try {
				ItemVo vo = itemService.getVo(procSeq[i]);
				lvo.setItemSeq(vo.getSeq());
				lvo.setContent(vo.toString());
				itemService.insertLogVo(lvo);
			} catch (NullPointerException e) {
				model.addAttribute("message", "삭제하던 도중 오류가 발생했습니다:" + e.getMessage());
				e.printStackTrace();
				return Const.ALERT_PAGE;
			}

			itemService.deleteFiles(realPath, procSeq[i]);
			itemService.deleteVo(procSeq[i]);
		}
		model.addAttribute("message", "삭제되었습니다");
		model.addAttribute("returnUrl", "/admin/item/list?" + (searchText == null ? "" : searchText.replace("&amp;", "&")));
		return Const.REDIRECT_PAGE;
	}

	/**
	 * 일괄 상태 변경
	 * 
	 * @param procSeq
	 * @param statusCode
	 * @param searchText
	 * @param model
	 * @return
	 */
	@CheckGrade(controllerName = "itemController", controllerMethod = "batchUpdate")
	@RequestMapping("/item/batch/update")
	public String batchUpdate(@RequestParam Integer[] procSeq, HttpServletRequest request, String statusCode, String searchText, Model model) {
		HttpSession session = request.getSession(false);
		// todo : 해당 배치를 실행시킬 수 있는지 검사하여야 함
		for (int i = 0; i < procSeq.length; i++) {
			ItemVo vo = new ItemVo();
			vo.setSeq(procSeq[i]);
			vo.setStatusCode(statusCode);
			ItemVo ivo = itemLogCheck(vo);

			itemService.updateStatusCode(vo);

			// 로그 (이력)
			ItemLogVo lvo = new ItemLogVo();
			lvo.setItemSeq(vo.getSeq());
			lvo.setAction("일괄수정");
			lvo.setContent(vo.toString());
			lvo.setModContent(ivo.getModContent());
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			lvo.setLoginType(String.valueOf(session.getAttribute("loginType")));
			itemService.insertLogVo(lvo);

		}
		model.addAttribute("message", "변경되었습니다");
		model.addAttribute("returnUrl", "/admin/item/list?" + (searchText == null ? "" : searchText.replace("&amp;", "&")));
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "batchCategoryUpdate")
	@RequestMapping("/item/batch/category")
	public String batchCategoryUpdate(@RequestParam Integer[] procSeq, Integer cateLv1Seq, Integer cateLv2Seq, Integer cateLv3Seq, Integer cateLv4Seq, String searchText,
			HttpSession session, Model model) {

		// todo : 해당 배치를 실행시킬 수 있는지 검사하여야 함
		// 존재하는 카테고리인지 검사
		if (categoryService.getVo(cateLv1Seq) == null) {
			model.addAttribute("message", "대분류 카테고리의 입력이 잘못되었습니다");
			return Const.ALERT_PAGE;
		}

		// 이제 하나하나 넣는다
		for (int i = 0; i < procSeq.length; i++) {
			ItemVo vo = new ItemVo();
			vo.setSeq(procSeq[i]);
			vo.setCateLv1Seq(cateLv1Seq);
			vo.setCateLv2Seq(cateLv2Seq);
			vo.setCateLv3Seq(cateLv3Seq);
			vo.setCateLv4Seq(cateLv4Seq);
			ItemVo ivo = itemLogCheck(vo);

			itemService.updateCategory(vo);

			// 로그 (이력)
			ItemLogVo lvo = new ItemLogVo();
			lvo.setItemSeq(vo.getSeq());
			lvo.setAction("일괄수정");
			lvo.setContent(vo.toString());
			lvo.setModContent(ivo.getModContent());
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			lvo.setLoginType((String) session.getAttribute("loginType"));
			itemService.insertLogVo(lvo);

		}
		model.addAttribute("message", "변경되었습니다");
		model.addAttribute("returnUrl", "/admin/item/list?" + (searchText == null ? "" : searchText.replace("&amp;", "&")));
		return Const.REDIRECT_PAGE;
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "batchContentUpdate")
	@RequestMapping("/item/batch/content")
	public String batchContentUpdate(@RequestParam Integer[] procSeq, ItemVo vo, String searchText, HttpSession session, Model model) {
		if (!"".equals(vo.getName()) && StringUtil.getByteLength(vo.getName()) > 300) {
			model.addAttribute("message", "상품명은 300byte 이하로 입력되어야 합니다");
			return Const.ALERT_PAGE;
		}

		if (!StringUtil.isBlank(vo.getAsTel1())	&& !StringUtil.isBlank(vo.getAsTel2()) && !StringUtil.isBlank(vo.getAsTel3())) {
			// 받은 A/S 전화번호 합치기
			vo.setAsTel(vo.getAsTel1() + "-" + vo.getAsTel2() + "-"	+ vo.getAsTel3());
		}

		// 총판공급가가 없을 경우 & 입점업체공급가보다 작을 경우 입점업체공급가와 동일 처리
		if (!StringUtil.isBlank("" + vo.getSupplyPrice()) && StringUtil.isBlank("" + vo.getSupplyMasterPrice())) {
			vo.setSupplyMasterPrice(vo.getSupplyPrice());
		} else if (!StringUtil.isBlank("" + vo.getSupplyPrice()) && vo.getSupplyMasterPrice() < vo.getSupplyPrice()) {
			vo.setSupplyMasterPrice(vo.getSupplyPrice());
		}

		if (!"".equals(vo.getDeliTypeCode()) && "10".equals(vo.getDeliTypeCode()) && vo.getDeliCost() == 0) {
			model.addAttribute("message", "착불 일 때 배송비는 반드시 입력하여야 합니다");
			return Const.ALERT_PAGE;
		}

		/** 금지어 검사 */
		if (!StringUtil.isBlank(validFilter(vo))) {
			model.addAttribute("message", validFilter(vo));
			return Const.ALERT_PAGE;
		}

		// 이제 하나하나 넣는다
		for (int i = 0; i < procSeq.length; i++) {
			vo.setSeq(procSeq[i]);
			ItemVo ivo = itemService.getVo(procSeq[i]);

			if ((vo.getSupplyPrice() > 0 && vo.getSellPrice() > 0) && vo.getSupplyPrice() >= vo.getSellPrice()) {
				model.addAttribute("message", "공급가는 판매가 보다 클 수 없습니다.");
				return Const.ALERT_PAGE;
			} else if (vo.getSupplyPrice() > 0 && vo.getSupplyPrice() >= ivo.getSellPrice()) {
				model.addAttribute("message", "공급가는 판매가 보다 클 수 없습니다.");
				return Const.ALERT_PAGE;
			} 
			
			if (vo.getSellPrice() > 0 && vo.getSellPrice() < ivo.getSupplyPrice() ) {
				model.addAttribute("message", "판매가는 공급가보다 작을 수 없습니다.");
				return Const.ALERT_PAGE;
			}

			if ((vo.getMarketPrice() > 0 && vo.getSellPrice() > 0) && vo.getMarketPrice() < vo.getSellPrice()) {
				model.addAttribute("message", "시중가는 판매가보다 작을 수 없습니다.");
				return Const.ALERT_PAGE;
			} else if (vo.getMarketPrice() > 0 && vo.getMarketPrice() < ivo.getSellPrice()) {
				model.addAttribute("message", "시중가는 판매가보다 작을 수 없습니다.");
				return Const.ALERT_PAGE;
			} 
			
			if (vo.getSellPrice() > 0 && vo.getSellPrice() > ivo.getMarketPrice() ) {
				model.addAttribute("message", "판매가는 시중가보다 클 수 없습니다.");
				return Const.ALERT_PAGE;
			}

			ivo = itemLogCheck(vo);
			itemService.batchUpdateVo(vo);
			itemService.batchUpdateDetailVo(vo);

			// 로그 (이력)
			ItemLogVo lvo = new ItemLogVo();
			lvo.setItemSeq(vo.getSeq());
			lvo.setAction("일괄수정");
			lvo.setContent(vo.toString());
			lvo.setModContent(ivo.getModContent());
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			lvo.setLoginType((String) session.getAttribute("loginType"));
			itemService.insertLogVo(lvo);

		}
		model.addAttribute("message", "변경되었습니다");
		model.addAttribute("returnUrl", "/admin/item/list?" + (searchText == null ? "" : searchText.replace("&amp;", "&")));
		return Const.REDIRECT_PAGE;
	}

	/** 일괄 상품 복사하기 
	 * @throws IOException */
	@CheckGrade(controllerName = "itemController", controllerMethod = "batchDuplicate")
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	@RequestMapping("/item/batch/dupli")
	public String batchDuplicate(@RequestParam Integer[] procSeq, Integer cateLv1Seq, Integer cateLv2Seq, Integer cateLv3Seq, Integer cateLv4Seq, String searchText, HttpSession session, Model model) throws IOException {

		// 존재하는 카테고리인지 검사
		if (categoryService.getVo(cateLv1Seq) == null) {
			model.addAttribute("message", "대분류 카테고리의 입력이 잘못되었습니다");
			return Const.ALERT_PAGE;
		}
		
		// 이제 하나하나 넣는다
		for (int i = 0; i < procSeq.length; i++) {
			ItemVo ivo = new ItemVo();
			ivo.setSeq(procSeq[i]);
			ItemVo vo = itemService.getVo(procSeq[i]);

			//상품 시퀀스 생성
			if(itemService.createSeq(vo) != 1) {
				model.addAttribute("message", "상품 시퀀스 생성에 실패하였습니다.");
				return Const.ALERT_PAGE;
			}
			
			vo.setCateLv1Seq(cateLv1Seq);
			vo.setCateLv2Seq(cateLv2Seq);
			vo.setCateLv3Seq(cateLv3Seq);
			vo.setCateLv4Seq(cateLv4Seq);
			
			String realPath = Const.UPLOAD_REAL_PATH + "/item";
			String errMsg = "";

			if (!"".equals(vo.getImg1())) {
				errMsg = copyItemImageUpload(vo.getImg1(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg1(itemService.imageProc(realPath, "1", String.valueOf(vo.getSeq()) + vo.getImg1().substring(vo.getImg1().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(vo.getImg2())) {
				errMsg = copyItemImageUpload(vo.getImg2(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg2(itemService.imageProc(realPath, "2", String.valueOf(vo.getSeq()) + vo.getImg2().substring(vo.getImg2().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(vo.getImg3())) {
				errMsg = copyItemImageUpload(vo.getImg3(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg3(itemService.imageProc(realPath, "3",	String.valueOf(vo.getSeq()) + vo.getImg3().substring(vo.getImg3().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(vo.getImg4())) {
				errMsg = copyItemImageUpload(vo.getImg4(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				// 에러가 발생하지 않았다면 upload/item/temp에 업로드가 잘 된것이다/
				vo.setImg4(itemService.imageProc(realPath, "4",	String.valueOf(vo.getSeq()) + vo.getImg4().substring(vo.getImg4().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(vo.getDetailImg1())) {
				errMsg = copyItemImageUpload(vo.getDetailImg1(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				vo.setDetailImg1(itemService.imageDetailProc(realPath, "1",	String.valueOf(vo.getSeq()) + vo.getDetailImg1().substring(vo.getDetailImg1().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(vo.getDetailImg2())) {
				errMsg = copyItemImageUpload(vo.getDetailImg2(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				vo.setDetailImg2(itemService.imageDetailProc(realPath, "2",	String.valueOf(vo.getSeq()) + vo.getDetailImg2().substring(vo.getDetailImg2().lastIndexOf(".")), vo.getSeq()));
			}
			if (!"".equals(vo.getDetailImg3())) {
				errMsg = copyItemImageUpload(vo.getDetailImg3(), vo.getSeq()); // 원본
				// 에러가 발생했는지 검사
				if (!StringUtil.isBlank(errMsg)) {
					model.addAttribute("message", errMsg);
					return Const.ALERT_PAGE;
				}

				vo.setDetailImg3(itemService.imageDetailProc(realPath, "3",	String.valueOf(vo.getSeq()) + vo.getDetailImg3().substring(vo.getDetailImg3().lastIndexOf(".")), vo.getSeq()));
			}

			if (!itemService.insertVo(vo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[1]");
				return Const.ALERT_PAGE;
			}
			if (!itemService.insertDetailVo(vo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[2]");
				return Const.ALERT_PAGE;
			}

			HashMap<String, String> map = itemService.getInfo(procSeq[i]);
			List<String> propValList = new ArrayList<>();
			if(map == null) {
				for (int k = 1; k < 21; k++) {
					propValList.add("");
				}
			} else {
				for (int k = 1; k < 21; k++) {
					propValList.add(String.valueOf(map.get("prop_val" + k)));
				}
			}
			
			ItemInfoNoticeVo pvo = new ItemInfoNoticeVo();
			pvo.setItemSeq(vo.getSeq());
			pvo.setPropValList(propValList);
			if (pvo.getPropValList() != null) {
				if (!itemService.insertProp(pvo)) {
					model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[3]");
					return Const.ALERT_PAGE;
				}
			}

			ItemOptionVo ovo = itemOptionService.getVo(itemOptionService.getSeq(procSeq[i]));
			List<ItemOptionVo> list = itemOptionService.getValueList(itemOptionService.getSeq(procSeq[i]));

			ovo.setItemSeq(vo.getSeq());
			if (!itemOptionService.insertVo(ovo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[4]");

				return Const.ALERT_PAGE;
			}

			Integer optionSeq = itemOptionService.getSeq(vo.getSeq());
			for (int j = 0; j < list.size(); j++) {
				list.get(j).setOptionSeq(optionSeq);
				if (!itemOptionService.insertValueVo(list.get(j))) {
					model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[5]");
					return Const.ALERT_PAGE;
				}
			}

			// 로그 (이력)
			ItemLogVo lvo = new ItemLogVo();
			lvo.setItemSeq(vo.getSeq());
			lvo.setAction("일괄 복사하기(상품)");
			lvo.setContent(vo.toString());
			lvo.setModContent(ivo.getModContent());
			lvo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
			lvo.setLoginType("" + session.getAttribute("loginType"));
			if (!itemService.insertLogVo(lvo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[6]");
				return Const.ALERT_PAGE;
			}
			lvo.setAction("일괄 복사하기(옵션)");
			lvo.setContent(ovo.toString());
			lvo.setModContent(ovo.getModContent());
			if (!itemService.insertLogVo(lvo)) {
				model.addAttribute("message", "데이터 삽입 도중 오류가 발생했습니다[7]");
				return Const.ALERT_PAGE;
			}
		}
		model.addAttribute("message", "등록 되었습니다");
		model.addAttribute("returnUrl", "/admin/item/list?" + (searchText == null ? "" : searchText.replace("&amp;", "&")));
		return Const.REDIRECT_PAGE;
	}

	/** 상품 추가 정보 */
	@RequestMapping("/item/prop/json")
	public String getPropList(Integer typeCd, Model model) {
		List<ItemInfoNoticeVo> list = itemService.getPropList(typeCd);
		model.addAttribute("list", list);
		return "/ajax/get-prop-list.jsp";
	}

	@RequestMapping("/item/prop/new")
	public String insertInfo(
			Integer itemSeq,
			@RequestParam(value = "propValList[]", required = false) List<String> propValList,
			Model model) {
		ItemInfoNoticeVo vo = new ItemInfoNoticeVo();
		vo.setItemSeq(itemSeq);
		vo.setPropValList(propValList);

		if (vo.getPropValList() == null) {
			vo.setPropValList(new ArrayList<String>());
		}

		List<FilterVo> list = itemService.getFilterList();
		for (int i = 0; i < vo.getPropValList().size(); i++) {
			if (StringUtil.filterWord(list, vo.getPropValList().get(i)) != "") {
				model.addAttribute("message", "FILTER");
				return Const.AJAX_PAGE;
			}
		}

		if (!itemService.insertInfo(vo)) {
			model.addAttribute("message", "FAIL");
			return Const.AJAX_PAGE;

		}
		model.addAttribute("message", "OK");
		//return Const.AJAX_PAGE;
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/item/prop/mod")
	public String updateInfo(Integer itemSeq, Integer typeCd, @RequestParam(value = "propValList[]", required = false) List<String> propValList, Model model) {
		ItemInfoNoticeVo vo = new ItemInfoNoticeVo();
		vo.setItemSeq(itemSeq);
		vo.setPropValList(propValList);
		vo.setTypeCd(typeCd);
		log.info("### itemSeq :::: [" + vo.getItemSeq() + "]");
		//log.info("### propValList size :::: [" + propValList.size() + "]");
		log.info("### typeCd :::: [" + typeCd + "]");

		if (vo.getPropValList() == null) {
			vo.setPropValList(new ArrayList<String>());
		}

		List<FilterVo> list = null;
		try {
			list = itemService.getFilterList();
		} catch (Exception e) {
			log.info("### 필터정보를 불러오지 못하였습니다. [" + e.getMessage() + "]");
			model.addAttribute("message", "FILTERLIST");
			return Const.AJAX_PAGE;
		}

		for (int i = 0; i < vo.getPropValList().size(); i++) {
			if (StringUtil.filterWord(list, vo.getPropValList().get(i)) != "") {
				model.addAttribute("message", "FILTER");
				return Const.AJAX_PAGE;
			}
		}

		try {
			if (!itemService.updateInfo(vo)) {
				model.addAttribute("message", "FAIL");
				return Const.AJAX_PAGE;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("### 데이터를 삽입하던 도중, 오류가 발생했습니다. 상품 추가정보를 다시 수정해주세요. ["+ e.getMessage() + "]");
		}

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/item/seller/tel")
	public String getSellerTel(Integer sellerSeq, Model model) {
		SellerVo getVo;
		try {
			getVo = sellerService.getData(sellerSeq);
		} catch (Exception e) {
			model.addAttribute("message", "입점업체 정보 복호화에 실패했습니다. [" + e.getMessage() + "]");
			return Const.AJAX_PAGE;
		}
		model.addAttribute("message", getVo.getSalesTel());
		return Const.AJAX_PAGE;
	}

	/** 상품 리스트 엑셀 다운로드 */
	@CheckGrade(controllerName = "itemController", controllerMethod = "writeExcelItemList")
	@RequestMapping("/item/list/download/excel")
	public void writeExcelItemList(ItemVo vo, HttpSession session, HttpServletResponse response) throws IOException {
		// 엑셀 다운로드시 row수를 1000개로 무조건 고정한다.
		vo.setRowCount(itemService.getListTotalCount(vo));
		// 엑셀 파일명
		response.setHeader("Content-Disposition", "attachment; filename = item_list_" + StringUtil.getDate(0, "yyyyMMdd") + ".xls");
		// 워크북
		System.out.println(">>>> download excel , vo.seq:"+vo.getSeq());
		System.out.println(">>>> download excel , vo.name:"+vo.getName());
		Workbook wb = itemService.writeExcelItemList(vo, "xls", session);

		// 파일스트림
		OutputStream fileOut = response.getOutputStream();

		if (wb != null) {
			wb.write(fileOut);
			wb.close();
		}

		if (fileOut != null) {
			fileOut.flush();
			fileOut.close();
		}
	}

	@RequestMapping("/item/list/download/excel/check")
	public String writeExcelCheck(ItemVo vo, HttpSession session, Model model) {
		/* 상품리스트 */
		vo.setLoginSeq((Integer) session.getAttribute("loginSeq"));
		vo.setLoginType((String) session.getAttribute("loginType"));
		//if (itemService.getListTotalCount(vo) > 1000) {
		//	model.addAttribute("result", "false");
		//	model.addAttribute("message", "엑셀 다운로드는 1000건 까지만 다운로드 됩니다.");
		//	return "/ajax/get-message-result.jsp";
		//}
		model.addAttribute("result", "true");
		return "/ajax/get-message-result.jsp";
	}

	@CheckGrade(controllerName = "itemController", controllerMethod = "adminExcelItemList")
	@RequestMapping("/item/list/count/ajax")
	public String getAjaxItemListCount(ItemVo vo, Model model) {
		model.addAttribute("message", new Integer(itemService.getListTotalCount(vo)));
		return Const.AJAX_PAGE;
	}

	/** 금지어 리스트 */
	@CheckGrade(controllerName = "itemController", controllerMethod = "getFilterList")
	@RequestMapping("/item/filter/list")
	public String getFilterList(Model model) {

		model.addAttribute("list", itemService.getFilterList());
		model.addAttribute("title", "금지어 관리");

		return "/item/filter_list.jsp";
	}

	/** 금지어 등록 */
	@CheckGrade(controllerName = "itemController", controllerMethod = "regFilter")
	@RequestMapping("/item/filter/reg")
	public String regFilter(String word, Model model) {

		if (!itemService.insertFilter(word)) {
			model.addAttribute("message", "금지어를 등록할 수 없었습니다");
			return Const.BACK_PAGE;
		}
		model.addAttribute("message", "등록되었습니다");
		model.addAttribute("returnUrl", "/admin/item/filter/list");
		return Const.REDIRECT_PAGE;
	}

	/** 금지어 삭제 */
	@CheckGrade(controllerName = "itemController", controllerMethod = "deleteFilter")
	@RequestMapping("/item/filter/delete/{seq}")
	public String deleteFilter(@PathVariable Integer seq, Model model) {

		if (!itemService.deleteFilter(seq)) {
			model.addAttribute("message", "금지어를 삭제할 수 없었습니다");
			return Const.ALERT_PAGE;
		}
		model.addAttribute("message", "삭제되었습니다");
		model.addAttribute("returnUrl", "/admin/item/filter/list");
		return Const.REDIRECT_PAGE;
	}

	private String validFilter(ItemVo vo) {
		/** 금지어 검사 */
		List<FilterVo> list = itemService.getFilterList();
		String name = StringUtil.filterWord(list, vo.getName());
		String maker = StringUtil.filterWord(list, vo.getMaker());
		String brand = StringUtil.filterWord(list, vo.getBrand());
		String modelName = StringUtil.filterWord(list, vo.getModelName());
		String originCountry = StringUtil.filterWord(list, vo.getOriginCountry());

		if (!"".equals(name)) {
			return "상품명에 금지어 " + name + "이 포함되어 있습니다.";
		}
		if (!"".equals(maker)) {
			return "제조사에 금지어 " + maker + "이 포함되어 있습니다.";
		}
		if (!"".equals(brand)) {
			return "브랜드에 금지어 " + brand + "이 포함되어 있습니다.";
		}
		if (!"".equals(modelName)) {
			return "모델명에 금지어 " + modelName + "이 포함되어 있습니다.";
		}
		if (!"".equals(originCountry)) {
			return "원산지에 금지어 " + originCountry + "이 포함되어 있습니다.";
		}

		for (int i = 0; i < list.size(); i++) {
			if (!"&lt;".equals(list.get(i).getFilterWord())
					&& !"&gt;".equals(list.get(i).getFilterWord())
					&& !"<".equals(list.get(i).getFilterWord())
					&& !">".equals(list.get(i).getFilterWord())) {
				if (!(vo.getContent().toLowerCase().indexOf(list.get(i).getFilterWord().toLowerCase()) == -1)) {
					log.info("#### 상세정보 : " + vo.getContent());
					return "상세정보에 금지어 " + list.get(i).getFilterWord() + "이 포함되어 있습니다.";
				}
			}
		}

		return "";
	}

	private ItemVo itemLogCheck(ItemVo vo) {
		String message = "";
		String column = "( ";
		ItemVo ivo = itemService.getVo(vo.getSeq());

		if (vo.getName() != null && !vo.getName().equals(ivo.getName())) {
			message += "상품명=" + vo.getName();
			column += "상품명";
		}
		if (vo.getStatusCode() != null && !vo.getStatusCode().equals(ivo.getStatusCode())) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 상품상태=" + vo.getStatusCode();
			column += " 상품상태";
		}
		if (ivo.getSellPrice() != vo.getSellPrice() && vo.getSellPrice() > 0) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 판매가=" + vo.getSellPrice();
			column += " 판매가";
		}
		if (ivo.getSupplyPrice() != vo.getSupplyPrice() && vo.getSupplyPrice() > 0) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 공급가=" + vo.getSupplyPrice();
			column += " 공급가";
		}
		if (ivo.getMarketPrice() != vo.getMarketPrice() && vo.getMarketPrice() > 0) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 시중가=" + vo.getMarketPrice();
			column += " 시중가";
		}
		if (!ivo.getMaker().equals(vo.getMaker()) && "" != vo.getMaker()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 제조사=" + vo.getMaker();
			column += " 제조사";
		}

		if(!vo.getType1().equals(vo.getType1()) && "" != vo.getType1()){
			if(message !=""){
				message +=",";
			}
			if(column !=""){
				column += ",";
			}
			message += " 규격1=" + vo.getType1();
			column += " 규격1";
		}
		if(!vo.getType2().equals(vo.getType2()) && "" != vo.getType2()){
			if(message !=""){
				message +=",";
			}
			if(column !=""){
				column += ",";
			}
			message += " 규격2=" + vo.getType2();
			column += " 규격2";
		}

		if(!vo.getType3().equals(vo.getType3()) && "" != vo.getType3()){
			if(message !=""){
				message +=",";
			}
			if(column !=""){
				column += ",";
			}
			message += " 규격3=" + vo.getType3();
			column += " 규격3";
		}

		if(!vo.getSubjectType().equals(vo.getSubjectType()) && "" != vo.getSubjectType()){
			if(message !=""){
				message +=",";
			}
			if(column !=""){
				column += ",";
			}
			message += " 진료과목=" + vo.getSubjectType();
			column += " 진료과목";
		}

		if(!vo.getInsuranceCode().equals(vo.getInsuranceCode()) && "" != vo.getInsuranceCode()){
			if(message !=""){
				message +=",";
			}
			if(column !=""){
				column += ",";
			}
			message += " 보험코드=" + vo.getInsuranceCode();
			column += " 보험코드";
		}


		if (!ivo.getOriginCountry().equals(vo.getOriginCountry()) && "" != vo.getOriginCountry()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 단위=" + vo.getOriginCountry();
			column += " 단위";
		}
		if (ivo.getMinCnt() != vo.getMinCnt()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 자동발주량=" + vo.getMinCnt();
			column += " 자동발주량";
		}
		/*if (null != vo.getSellerSeq() && !ivo.getSellerSeq().equals(vo.getSellerSeq()) ) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 입점업체번호=" + vo.getSellerSeq();
			column += " 입점업체번호";
		}*/
		if (!ivo.getSellerItemCode().equals(vo.getSellerItemCode()) && "" != vo.getSellerItemCode()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 입점업체 상품코드=" + vo.getSellerItemCode();
			column += " 입점업체 상품코드";
		}
		if (ivo.getCateLv1Seq() != null) {
			if (vo.getCateLv1Seq() != null && !ivo.getCateLv1Seq().equals(vo.getCateLv1Seq())	) {
				if (message != "") {
					message += ",";
				}
				if (column != "") {
					column += ",";
				}
				message += " 대분류 카테고리=" + vo.getCateLv1Seq();
				column += " 대분류 카테고리";
			}
		}
		if (ivo.getCateLv2Seq() != null) {
			if (!ivo.getCateLv2Seq().equals(vo.getCateLv2Seq())	&& null != vo.getCateLv2Seq()) {
				if (message != "") {
					message += ",";
				}
				if (column != "") {
					column += ",";
				}
				message += " 중분류 카테고리=" + vo.getCateLv2Seq();
				column += " 중분류 카테고리";
			}
		}
		if (ivo.getCateLv3Seq() != null) {
			if (!ivo.getCateLv3Seq().equals(vo.getCateLv3Seq())	&& null != vo.getCateLv3Seq()) {
				if (message != "") {
					message += ",";
				}
				if (column != "") {
					column += ",";
				}
				message += " 소분류 카테고리=" + vo.getCateLv3Seq();
				column += " 소분류 카테고리";
			}
		}
		if (ivo.getCateLv4Seq() != null) {
			if (!ivo.getCateLv4Seq().equals(vo.getCateLv4Seq())	&& null != vo.getCateLv4Seq()) {
				if (message != "") {
					message += ",";
				}
				if (column != "") {
					column += ",";
				}
				message += " 세분류 카테고리=" + vo.getCateLv1Seq();
				column += " 세분류 카테고리";
			}
		}
		if (vo.getBrand() != null && !ivo.getBrand().equals(vo.getBrand()) ) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 발주처=" + vo.getBrand();
			column += " 발주처";
		}
		if (!ivo.getModelName().equals(vo.getModelName()) && "" != vo.getModelName()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 기준재고=" + vo.getModelName();
			column += " 기준재고";
		}
		if (!ivo.getMakeDate().equals(vo.getMakeDate()) && "" != vo.getMakeDate()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 제조일자=" + vo.getMakeDate();
			column += " 제조일자";
		}
		if (!ivo.getExpireDate().equals(vo.getExpireDate()) && "" != vo.getExpireDate()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 유효일자=" + vo.getExpireDate();
			column += " 유효일자";
		}
		if (!ivo.getAdultFlag().equals(vo.getAdultFlag()) && "" != vo.getAdultFlag()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 성인여부=" + vo.getAdultFlag();
			column += " 성인여부";
		}
		if (!ivo.getImg1().equals(vo.getImg1()) && "" != vo.getImg1()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 대표이미지=" + vo.getImg1();
			column += " 대표이미지";
		}
		if (!ivo.getImg2().equals(vo.getImg2()) && "" != vo.getImg2()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 서브이미지=" + vo.getImg2();
			column += " 서브이미지";
		}
		if (!ivo.getImg3().equals(vo.getImg3()) && "" != vo.getImg3()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 서브이미지=" + vo.getImg3();
			column += " 서브이미지";
		}
		if (!ivo.getImg4().equals(vo.getImg4()) && "" != vo.getImg4()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 서브이미지=" + vo.getImg4();
			column += " 서브이미지";
		}
		if (!ivo.getTaxCode().equals(vo.getTaxCode()) && "" != vo.getTaxCode()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 과세여부=" + vo.getTaxCode();
			column += " 과세여부";
		}
		if (!ivo.getDeliTypeCode().equals(vo.getDeliTypeCode())	&& "" != vo.getDeliTypeCode()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 배송비 구분=" + vo.getDeliTypeCode();
			column += " 배송비 구분";
		}
		if (ivo.getDeliCost() != vo.getDeliCost() && 0 != vo.getDeliCost()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 배송비=" + vo.getDeliCost();
			column += " 배송비";
		}
		if (ivo.getDeliFreeAmount() != vo.getDeliFreeAmount() && 0 != vo.getDeliFreeAmount()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 무료배송 조건부 금액=" + vo.getDeliFreeAmount();
			column += " 무료배송 조건부 금액";
		}
		if (!ivo.getDeliPrepaidFlag().equals(vo.getDeliPrepaidFlag()) && "" != vo.getDeliPrepaidFlag()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 선결제 구분=" + vo.getDeliPrepaidFlag();
			column += " 선결제 구분";
		}
		if (!ivo.getAsFlag().equals(vo.getAsFlag()) && "" != vo.getAsFlag()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " AS가능 여부=" + vo.getAsFlag();
			column += " AS가능 여부";
		}
		if (!ivo.getAsTel().equals(vo.getAsTel()) && "" != vo.getAsTel()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " AS 전화번호=" + vo.getAsTel();
			column += " AS 전화번호";
		}
		if (!ivo.getAsContent().equals(vo.getAsContent()) && "" != vo.getAsContent()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " AS 내용" + vo.getAsContent();
			column += " AS 내용";
		}
		if (!ivo.getDetailImg1().equals(vo.getDetailImg1()) && "" != vo.getDetailImg1()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 상세 이미지1=" + vo.getDetailImg1();
			column += " 상세 이미지1";
		}
		if (!ivo.getDetailImg2().equals(vo.getDetailImg2()) && "" != vo.getDetailImg2()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 상세 이미지2=" + vo.getDetailImg2();
			column += " 상세 이미지2";
		}
		if (!ivo.getDetailImg3().equals(vo.getDetailImg3()) && "" != vo.getDetailImg3()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 상세 이미지3=" + vo.getDetailImg3();
			column += " 상세 이미지3";
		}
		if (!ivo.getUseCode().equals(vo.getUseCode()) && "" != vo.getUseCode()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 사용코드=" + vo.getUseCode();
			column += " 사용코드";
		}
		if (!ivo.getContent().equals(vo.getContent()) && "" != vo.getContent()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 상세정보=" + vo.getContent();
			column += " 상세정보";
		}
	
		column += " )";
		ivo.setModContent(message);
		ivo.setColumn(column);
		return ivo;
	}

	private ItemOptionVo optionLogCheck(ItemOptionVo vo) {
		String message = "";
		String column = "( ";
		ItemOptionVo ovo = itemOptionService.getVo(vo.getSeq());

		if (!ovo.getOptionName().equals(vo.getOptionName())) {
			message += " 옵션명=" + vo.getOptionName();
			column += " 옵션명";
		}
		if (!ovo.getShowFlag().equals(vo.getShowFlag())) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 노출여부=" + vo.getShowFlag();
			column += " 노출여부";
		}
		column += " )";
		ovo.setModContent(message);
		ovo.setColumn(column);
		return ovo;
	}

	private ItemOptionVo optionValueLogCheck(ItemOptionVo vo) {
		String message = "";
		String column = "( ";
		ItemOptionVo ovo = itemOptionService.getValueVo(vo.getSeq());

		if (!ovo.getValueName().equals(vo.getValueName())) {
			message += " 옵션상품명=" + vo.getValueName();
			column += " 옵션상품명";
		}
		if (ovo.getStockCount() == vo.getStockCount()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 재고수량=" + vo.getStockCount();
			column += " 재고수량";
		}
		if (ovo.getOptionPrice() != vo.getOptionPrice()) {
			if (message != "") {
				message += ",";
			}
			if (column != "") {
				column += ",";
			}
			message += " 옵션 추가금액=" + vo.getOptionPrice();
			column += " 옵션 추가금액";
		}
		column += " )";
		ovo.setModContent(message);
		ovo.setColumn(column);
		return ovo;
	}
	
	//상품 정보 request parameter 유효성 검증
	private String checkReqParam(ItemVo vo, HttpSession session, String type) {
		/* 입점업체 검증 */
		if("S".equals(session.getAttribute("loginType"))) {
			//입점업체 로그인일 경우 세션값에서 시퀀스를 가져온다.
			vo.setSellerSeq((Integer)session.getAttribute("loginSeq"));
			//입점업체 로그인일 경우 세션값에서 입점업체명을 가져와 제조사 항목에 값을 셋팅한다.
			/*vo.setMaker((String)session.getAttribute("loginName"));*/
		}
		
		///if(vo.getSellerSeq() == null) {
		//	return "입점업체가 선택되지 않았습니다.";
		//}
		
		//SellerVo seller = sellerService.getVoSimple(vo.getSellerSeq());
		//if(seller == null) {
		//	return "입점업체가 존재하지 않습니다.";
		//}
		
		/* 기본값 설정 */
		//함께누리몰은 공급가가 존재하지 않으므로 판매가와 동일하게 설정한다.
		vo.setSupplyPrice(0);
		
		//함께누리몰은 총판 공급가가존재하지 않으므로 입점업체 공급가와 동일하게 설정
		vo.setSupplyMasterPrice(0);
		
		
		// 받은 A/S 전화번호 합치기
		if (!"".equals(vo.getAsTel1())	&& !"".equals(vo.getAsTel2())	&& !"".equals(vo.getAsTel3())) {
			vo.setAsTel(vo.getAsTel1() + "-" + vo.getAsTel2() + "-"	+ vo.getAsTel3());
		}
		
		/* 필수값 체크 */
		/*if ("".equals(vo.getTypeCode())) {
			return "상품타입은 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getName())) {
			return "상품명은 반드시 입력되어야 합니다";
		} else if (StringUtil.getByteLength(vo.getName()) > 300) {
			return "상품명은 300byte 이하로 입력되어야 합니다";
		} else if ("".equals(vo.getAdultFlag())) {
			return "미성년자 정보는 반드시 입력되어야 합니다";
		} else if ("modify".equals(type) && "".equals(vo.getStatusCode())) { //판매상태는 상품수정일 경우에만 체크
			return "판매 상태는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getMaker())) {
			return "제조사는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getTaxCode())) {
			return "과세 정보는 반드시 입력되어야 합니다";
		} else if ("".equals(vo.getAsFlag())) {
			return "A/S 가능여부는 반드시 선택되어야 합니다";
		} else if ("".equals(vo.getDeliTypeCode())) {
			return "배송구분 여부는 반드시 선택되어야 합니다";
		} else if ("".equals(vo.getDeliPackageFlag())) {
			return "묶음배송 여부는 반드시 선택되어야 합니다";
		} else if ("".equals(vo.getAuthCategory())) {
			return "인증구분은 반드시 선택되어야 합니다.";
		}
		*/
		/* 금액 체크 */
		if (vo.getMarketPrice() < 0) {
			return "시중가는 음수 값이 될 수 없습니다";
		} 
		//if (vo.getSellPrice() <= 0) {
		//	return "판매가는 0원 이하가 될 수 없습니다";
		//}
		if (vo.getMarketPrice() > 0 && vo.getMarketPrice() < vo.getSellPrice()) {
			return "시중가는 판매가보다 작을 수 없습니다.";
		}
		if ("10".equals(vo.getDeliTypeCode()) && vo.getDeliCost() == 0) {
			return "착불 일 때 배송비는 반드시 입력하여야 합니다";
		}
		
		/* 금지어 검사 */
		String validFilterErrMsg = validFilter(vo);
		if (!"".equals(validFilterErrMsg)) {
			return validFilterErrMsg;
		} 
		
		return null;
	}
}