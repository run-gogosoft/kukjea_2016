package com.smpro.controller.admin;

import com.smpro.component.admin.annotation.CheckGrade;
import com.smpro.service.CategoryService;
import com.smpro.service.ItemOptionService;
import com.smpro.service.ItemService;
import com.smpro.service.SellerService;
import com.smpro.util.*;
import com.smpro.util.exception.ExcelOutOfBoundsException;
import com.smpro.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Slf4j
@Controller
public class ItemExcelController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private ItemOptionService itemOptionService;

	@Autowired
	private SellerService sellerService;

	@RequestMapping("/item/excel/list")
	public static String list(Model model) {
		model.addAttribute("title", "엑셀 대량등록 상품리스트");
		return "/item/excel_list.jsp";
	}

	@CheckGrade(controllerName = "itemExcelController", controllerMethod = "form")
	@RequestMapping("/item/excel/form")
	public String form(HttpSession session, Model model) {
		model.addAttribute("title", "엑셀 상품 대량등록");

		List<FilterVo> list = itemService.getFilterList();
		for (int i = 0; i < list.size(); i++) {
			if ("\\\"".equals(list.get(i).getFilterWord())) {
				list.get(i).setFilterWord("\"");
			}
			if ("\\\\".equals(list.get(i).getFilterWord())) {
				list.get(i).setFilterWord("\\");
			}
		}
		session.setAttribute("filterList", list);

		Map<String, String> statusMap = new LinkedHashMap<>();
		statusMap.put("imageCount", "0");
		statusMap.put("dbCount", "0");
		statusMap.put("listCount", "계산중");
		session.setAttribute("excelStatus", statusMap);

		return "/item/excel_form.jsp";
	}

	@RequestMapping(value = "/item/excel/upload", method = RequestMethod.POST)
	public String upload(HttpServletRequest request, Model model) {
		// todo : 업로드할 수 있는 권한이 있는지 검사

		Map<String, String> fileMap;
		try {
			fileMap = itemService.uploadFilesByMap(request);
		} catch (IOException ie) {
			log.error(ie.getMessage());
			model.addAttribute("message", "서버상의 문제가 발생했습니다. 관리자에게 문의하여 주십시오.");
			ie.printStackTrace();
			return Const.ALERT_PAGE;
		} catch (MaxUploadSizeExceededException me) {
			model.addAttribute("message", "한번에 너무 큰 용량의 파일을 첨부하실 수 없습니다");
			me.printStackTrace();
			return Const.ALERT_PAGE;
		}

		String files = "";
		if (fileMap != null) {
			if (fileMap.get("file[0]") != null) {
				files += "filename:/item/temp/" + fileMap.get("file[0]");
			}
		}

		// 업로드된 파일 리스트를 던진다
		model.addAttribute("callback", files);
		return Const.REDIRECT_PAGE;
	}

	@RequestMapping("/item/excel/check")
	public String checkExcel(@RequestParam String filepath, @RequestParam(required=false) Integer sellerSeq, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);

		/** 엑셀 컬럼 개수 */
		String loginType = (String)session.getAttribute("loginType");

		int LIST_SIZE = 18;
		int OPTION_SIZE = 0;
		if(loginType.equals("S")) {
			//공급사인경우
			OPTION_SIZE = 6;
		}
		


		List<String> errorList = new ArrayList<>();
		List<ItemVo> list = new ArrayList<>();
		List<ItemOptionVo> optionList = new ArrayList<>();
		String realPath = Const.UPLOAD_REAL_PATH;

		// filepath에 ..을 포함하고 있다면 해킹의 가능성이 있다
		if (filepath.indexOf("\\.\\.") > 0) {
			log.warn("/item/excel/check ==> " + filepath);
			errorList.add("파일명이 잘못 되었거나, 비정상적인 경로로 접근하고 있습니다");
		}

		// filepath는 반드시 /item/temp/로 시작하여야 한다
		if (!filepath.startsWith("/item/temp/")) {
			errorList.add("해당 경로에 접근할 권한이 없습니다");
		}

		if (errorList.size() > 0) {
			log.error(errorList.toString());
			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "/ajax/get-error-list.jsp";
		}

		// 해당 경로에 정말 파일이 존재하는가?
		File f = new File(realPath + "/" + filepath);
		if (!f.exists()) {
			errorList.add("엑셀 파일 업로드가 정상적으로 되지 않은 것 같습니다. 다시 시도해주세요");
		}

		// 엑셀을 읽는다
		Vector<ArrayList<Object>> v;
		try {
			v = ExcelUtil.read(new FileInputStream(f));
		} catch (Exception e) {
			e.printStackTrace();
			errorList.add("정상적인 엑셀 파일이 아니거나 읽을 수 없었습니다. (첫번째 행은 반드시 각 항목에 대한 제목이 있어야합니다.)");
			errorList.add(e.getMessage());

			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "/ajax/get-error-list.jsp";
		}

		// 엑셀 첫번쨰 라인에 공백이 있는지 없는지 판단한다.
		int blankCount = 0;
		ArrayList<Object> arrList = v.get(0);
		for (int i = 0; i < arrList.size(); i++) {
			if (StringUtil.isBlank(String.valueOf(arrList.get(i)))) {
				blankCount++;
			}
		}

		if (blankCount > 0) {
			errorList.add("첫번째 행은 반드시 각 항목에 대한 제목이 있어야합니다."+arrList.size()+","+"blankCount:"+blankCount);
		}

		if (errorList.size() > 0) {
			log.error(errorList.toString());

			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "/ajax/get-error-list.jsp";
		}

		// 유효성 검사
		for (int i = 1; i < v.size(); i++) {
			// 오류를 검증한다
			errorList.addAll(getErrorList(i + 1, v.get(i), LIST_SIZE+OPTION_SIZE)); // i에 1를 더하는 이유는 idx는 0부터 시작하니까 제목행을 포함해서 줄번호가 1 더 증가하기 때문이다.
		}

		if (errorList.size() > 0) {
			log.error(errorList.toString());

			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "/ajax/get-error-list.jsp";
		}

		// ItemVo로 매핑한다
		for (int i = 1; i < v.size(); i++) {
			
			try {
				ItemVo vo = itemMapper(v.get(i), LIST_SIZE);
				// 셀러 시퀀스를 매핑한다
				/*if(sellerSeq == null) {
					Integer sellerSeqFromDb = sellerService.getSeqByOldSeq(vo.getOldSellerSeq());
					if(sellerSeqFromDb == null) {
						errorList.add("입점업체가 존재하지 않습니다. 입점업체 조회/선택 후 업로드하시기 바랍니다..");
						model.addAttribute("errorCount", new Integer(errorList.size()));
						model.addAttribute("list", errorList);
						return "/ajax/get-error-list.jsp";
					}
					vo.setSellerSeq(sellerSeqFromDb);
				} else {
					vo.setSellerSeq(sellerSeq);
				}
				*/
				list.add(i - 1, vo);
				if(OPTION_SIZE>0) {
					ItemOptionVo ovo = optionMapper(v.get(i), LIST_SIZE, OPTION_SIZE);
					ovo.setValueName((String) session.getAttribute("loginName"));
					optionList.add(i-1,ovo);
					System.out.println("optionList added size is:"+optionList.size());
				}
			} catch (Exception e) {
				e.printStackTrace();
				errorList.add("[" + (i + 1) + "] 번째 아이템을 매핑하던 도중 오류가 발생했습니다");
				errorList.add(e.getMessage());
				log.error(e.getMessage());
			}
		}

		// 해당 상태를 세션에 공유한다
		Map<String, Object> statusMap = new LinkedHashMap<>();
		int startInsertSeq= 0;
		statusMap.put("imageCount", "0");
		statusMap.put("dbCount", "0");
		statusMap.put("listCount", new Integer(list.size()));
		session.setAttribute("excelStatus", statusMap);

		// 외부 이미지를 불러와서 imagemagick으로 변환한다
		for (int i = 0; i < list.size(); i++) {
			if (errorList.size() > 0) {
				log.error(errorList.toString());

				model.addAttribute("errorCount", new Integer(errorList.size()));
				model.addAttribute("list", errorList);
				return "/ajax/get-error-list.jsp";
			}

			if(list.get(i).getSeq()==null || list.get(i).getSeq().intValue()==0) { //아이쳄 추가의 경우, 이미지 데이타 리사이징 처리 및 데이타 변경
				if (!"".equals(list.get(i).getImg1())) {
					//시퀀스 생성
					itemService.createSeq(list.get(i));
					if(startInsertSeq==0) startInsertSeq = list.get(i).getSeq();
					try {
						String resolvedImg1 = imgProc(list.get(i).getImg1(), realPath, errorList, model);

						list.get(i).setImg1(itemService.imageProc(realPath + "/item", "1", resolvedImg1, list.get(i).getSeq()));
					} catch (Exception e) {
						list.get(i).setImg1("/old/no_image1.jpg");
					}


				} else {
					errorList.add("반드시 상품이미지1 항목이 입력되어야 합니다");

					model.addAttribute("errorCount", new Integer(errorList.size()));
					model.addAttribute("list", errorList);
					return "/ajax/get-error-list.jsp";
				}

				if (!"".equals(list.get(i).getImg2())) {
					try {
						String resolvedImg2 = imgProc(list.get(i).getImg2(), realPath, errorList, model);

						list.get(i).setImg2(itemService.imageProc(realPath + "/item", "2", resolvedImg2, list.get(i).getSeq()));
					} catch (Exception e) {
						list.get(i).setImg2("/old/no_image1.jpg");
					}

				}
				statusMap.put("imageCount", new Integer(i + 1));
				session.setAttribute("excelStatus", statusMap);
				log.info(list.get(i).toString());
			}
		}

		if (errorList.size() > 0) {
			log.error(errorList.toString());

			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "/ajax/get-error-list.jsp";
		}

		ItemLogVo lvo = new ItemLogVo();
		lvo.setLoginSeq((Integer)session.getAttribute("loginSeq"));
		lvo.setLoginType((String)session.getAttribute("loginType"));

		// DB에 저장한다
		// todo : commit과 rollback이 되어야 한다
		//상품 추가.수정은 최상의 관리자만 가능하다
		if("A".equals(session.getAttribute("loginType"))) {
			for (int i = 0; i < list.size(); i++) {
				System.out.println(">>> check seq ... insert or update :" + list.get(i).getSeq() + ", " + startInsertSeq);
				//아이템 추가
				if (startInsertSeq > 0 && list.get(i).getSeq() >= startInsertSeq) {
					itemService.insertVo(list.get(i));
					itemService.insertDetailVo(list.get(i));

					// 로그 (이력)
					lvo.setAction("등록");
					lvo.setItemSeq(list.get(i).getSeq());
					lvo.setContent(list.get(i).toString());
					itemService.insertLogVo(lvo);
				} else {
					// 존재하는 아이템인 경우. 수정
					itemService.updateVo(list.get(i));
					itemService.updateDetailVo(list.get(i));

					// 로그 (이력)
					lvo.setAction("수정");
					lvo.setItemSeq(list.get(i).getSeq());
					lvo.setContent(list.get(i).toString());
					itemService.insertLogVo(lvo);
				}
				statusMap.put("dbCount", new Integer(i + 1));
				session.setAttribute("excelStatus", statusMap);
			}
		}



		for(int i = 0;i<optionList.size();i++){
			// 옵션 등록/변경
			List<ItemOptionVo> optionVoList = itemOptionService.getList(optionList.get(i).getItemSeq());
			Integer optionSeq;
			ItemOptionVo ovo;
			if(optionVoList == null || optionVoList.size()<=0){
				//해당 아이템의 가격이 없는 경우. 추가
				ovo = new ItemOptionVo();

				ovo.setOptionName(optionList.get(i).getOptionName());
				ovo.setShowFlag("Y");
				ovo.setItemSeq(optionList.get(i).getItemSeq());

				System.out.println(">>> ovo sequence:"+optionList.get(i).getItemSeq());
				if (!itemOptionService.insertVo(ovo)) {
					model.addAttribute("message", "옵션 데이터 삽입 도중 오류가 발생했습니다[4]");
					return Const.ALERT_PAGE;
				}

				optionSeq = itemOptionService.getSeq(optionList.get(i).getItemSeq());
				System.out.println(">>>optionSeq:"+optionSeq);
				//optionvalue추가
				ovo.setOptionSeq(optionSeq);
				ovo.setValueName((String)session.getAttribute("loginName"));
				ovo.setOptionPrice(optionList.get(i).getOptionPrice());
				ovo.setSalePrice(optionList.get(i).getSalePrice());
				ovo.setSalePeriod(optionList.get(i).getSalePeriod());
				ovo.setStockCount(optionList.get(i).getStockCount());
				ovo.setStockFlag(optionList.get(i).getStockFlag());

				if (!itemOptionService.insertValueVo(ovo)) {
					model.addAttribute("message", "옵션데이터 삽입 도중 오류가 발생했습니다[5]");
					return Const.ALERT_PAGE;
				}
			}
			else {
				//아이템 가격이 있는 경우.....
				//해당 리스트에서 현재 공급사가 측적한 가격 정보가 있는지 확인해서
				//수정할건지 추가할건지 결정한다
				for(int ov = 0;ov<optionVoList.size();ov++) {
					optionSeq = optionVoList.get(ov).getSeq();
					ovo = optionVoList.get(ov);
					System.out.println(">>>optionSeq:"+optionSeq);
					System.out.println(">>>>ovo.getValueName():"+ovo.getValueName());
					System.out.println(">>(String)session.getAttribute(\"loginName\")):"+(String)session.getAttribute("loginName"));
					if(!ovo.getValueName().equals((String)session.getAttribute("loginName"))){
						//추가
						ovo.setValueName((String)session.getAttribute("loginName"));
						ovo.setOptionPrice(optionList.get(i).getOptionPrice());
						ovo.setSalePrice(optionList.get(i).getSalePrice());
						ovo.setSalePeriod(optionList.get(i).getSalePeriod());
						ovo.setStockCount(optionList.get(i).getStockCount());
						ovo.setStockFlag(optionList.get(i).getStockFlag());

						if (!itemOptionService.insertValueVo(ovo)) {
							model.addAttribute("message", "옵션데이터 삽입 도중 오류가 발생했습니다[5]");
							return Const.ALERT_PAGE;
						}
					}
					else {
						//update
						ovo.setOptionPrice(optionList.get(i).getOptionPrice());
						ovo.setSalePrice(optionList.get(i).getSalePrice());
						ovo.setSalePeriod(optionList.get(i).getSalePeriod());
						ovo.setStockCount(optionList.get(i).getStockCount());
						ovo.setStockFlag(optionList.get(i).getStockFlag());
						if (!itemOptionService.updateValueVo(ovo)) {
							model.addAttribute("message", "옵션데이터 삽입 도중 오류가 발생했습니다[5]");
							return Const.ALERT_PAGE;
						}
					}
				}
			}
		}

		if (errorList.size() > 0) {
			log.error(errorList.toString());

			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "/ajax/get-error-list.jsp";
		}

		// 모든 작업이 끝났다면 excel 파일을 삭제한다
		f.delete();

		model.addAttribute("message", "OK");
		return Const.AJAX_PAGE;
	}

	@RequestMapping("/item/excel/status/json")
	public static String getExcelStatus(HttpSession session, Model model) {
		Object map = session.getAttribute("excelStatus");
		if (map == null) {
			model.addAttribute("message", "ERROR");
			return Const.AJAX_PAGE;
		}
		model.addAttribute("map", map);
		return "/ajax/get-excel-status-map.jsp";
	}

	private String imgProc(String imagePath, String realPath, List<String> errorList, Model model) throws Exception {
		String tempExt = imagePath.substring(imagePath.lastIndexOf(".")).toLowerCase();
		ImageDownloadUtil iu = new ImageDownloadUtil();
		String tempFilename = UUID.randomUUID().toString();

		log.debug("TRACE: tempExt --> " + tempExt);
		log.debug("TRACE: tempFilename --> " + tempFilename);

		BufferedImage b = iu.readImage(StringUtil.restoreClearXSS(imagePath));
		ImageDownloadUtil.writeImage(b, realPath + "/item/temp/" + tempFilename + tempExt);
		
		if (errorList.size() > 0) {
			log.error(errorList.toString());

			model.addAttribute("errorCount", new Integer(errorList.size()));
			model.addAttribute("list", errorList);
			return "";
		}

		CommandUtil.imageResizeForImageMagick(tempFilename, realPath+ "/item/temp", tempExt);
		
		return tempFilename + tempExt;
	}

	/**
	 * 올바르게 입력되었는지 검증한다
	 * 
	 * 이 과정만으로는 에러를 완벽하게 발견할 수 없다. 따라서 추후 에러가 발견될 때마다 여기에 예외를 계속 추가해주길 바란다 특히
	 * 업로드부는 네트워크 에러가 발생할 수 있으니 예외 가이드가 반드시 필요하다
	 * 
	 * @param idx
	 *            몇 번째의 row인지
	 * @param list
	 *            해당 column의 리스트
	 * @return
	 */
	private List<String> getErrorList(int idx, ArrayList<Object> list, int LIST_SIZE) {
		List<String> errorList = new ArrayList<>();
		List<FilterVo> fList = itemService.getFilterList();

		// 사이즈를 검사한다
		if (list.size() != LIST_SIZE) {
			errorList.add(idx + " 번째 행이 잘못 작성되었습니다. [" + LIST_SIZE	+ "] 개의 항목이 있어야 하는데 [" + list.size()	+ "] 개의 항목이 검색되었습니다");
			return errorList;
		}

		int index = 1;//index 0 = item_seq
		// 1대분류 코드(필수)
		Map map = new HashMap();

		CategoryVo lv1 = null;
		//if (!StringUtil.isNum(String.valueOf(list.get(index)))) {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 대분류 코드는 숫자만 허용됩니다.");
		//} else {

		map.put("seq",0);
		map.put("name", String.valueOf(list.get(index)));
		lv1 = categoryService.getVoByName(map);

			if (lv1 == null) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 대분류 이름 ("+String.valueOf(list.get(index))+") 이  존재하지 않습니다.");
			} else {
				if (lv1.getDepth() != 1) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 대분류 이름("+String.valueOf(list.get(index))+") 이 아닙니다.");
				}
			}
		//}
		index++;
		map.clear();
		//2 중분류 코드(선택)
		CategoryVo lv2 = null;
		if(!StringUtil.isBlank(""+list.get(index))) {
			//if (!StringUtil.isNum(String.valueOf(list.get(index)))) {
			//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 중분류 코드는 숫자만 허용됩니다.");
			//}
			if(lv1 != null) {
				map.put("seq", lv1.getSeq());
				map.put("name", String.valueOf(list.get(index)));
				lv2 = categoryService.getVoByName(map);
			}
			if (lv2 == null) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 중분류 이름("+String.valueOf(list.get(index))+") 이 존재하지 않습니다.");
			} else if (lv1 != null) {
				if (lv1.getSeq().intValue() != lv2.getParentSeq().intValue()) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 중분류 이름("+String.valueOf(list.get(index))+") 이 대분류 코드에 맞지 않습니다.");
				} else if (lv2.getDepth() != 2) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 중분류 이름("+String.valueOf(list.get(index))+") 이 아닙니다.");
				}
			}
		}
		index++;
		map.clear();
		// 3소분류 코드(선택)
		CategoryVo lv3 = null;
		if(!StringUtil.isBlank(""+list.get(index))) {
			//if (!StringUtil.isNum(String.valueOf(list.get(index)))) {
			//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 소분류 코드는 숫자만 허용됩니다.");
			//}
			if(lv2 !=null) {
				map.put("seq", lv2.getSeq());
				map.put("name", String.valueOf(list.get(index)));
				lv3 = categoryService.getVoByName(map);
			}
			if (lv3 == null) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 소분류 이름("+String.valueOf(list.get(index))+") 이 존재하지 않습니다.");
			} else if (lv2 != null) {
				if (lv3.getParentSeq().intValue() != lv2.getSeq().intValue()) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 소분류 이름이("+String.valueOf(list.get(index))+")  중분류 코드에 맞지 않습니다.");
				}
				if (lv3.getDepth() != 3) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 소분류 이름("+String.valueOf(list.get(index))+") 이 아닙니다.");
				}
			}
		}
		index++;
		map.clear();
		// 4세분류 코드(선택)
		CategoryVo lv4 = null;
		if(!StringUtil.isBlank(""+list.get(index))) {
			//if (!StringUtil.isNum(String.valueOf(list.get(index)))) {
			//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 세분류 코드는 숫자만 허용됩니다.");
			//}
			if(lv3 != null) {
				map.put("seq", lv3.getSeq());
				map.put("name", String.valueOf(list.get(index)));
				lv4 = categoryService.getVoByName(map);
			}
		
			if (lv4 == null) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 세분류 이름("+String.valueOf(list.get(index))+") 이 존재하지 않습니다.");
			} else if (lv3 != null) {
				if (lv4.getParentSeq().intValue() != lv3.getSeq().intValue()) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 세분류 이름("+String.valueOf(list.get(index))+") 이 소분류 코드에 맞지 않습니다.");
				}
				if (lv4.getDepth() != 4) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 세분류 이름("+String.valueOf(list.get(index))+") 이 아닙니다.");
				}
			}
		}

		index++;
		//5 진료과목//(필수)
		//if (StringUtil.isBlank((String)list.get(index))) {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 진료과목은 필수 값입니다.");
		//}
		//if (!(String.valueOf(list.get(index)).matches("^[NE]$"))) {
		//	errorList.add(idx + " 번째 행:" + (index + 1)
		//			+ "번째 열: 상품구분은 N 또는 E의 코드 값만 허용됩니다.");
		//}
		index++;
		//6 상품명(필수)
		if (StringUtil.isBlank((String)list.get(index))) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품명은 필수 값입니다.");
		}
		String nameFilter = StringUtil.filterWord(fList,
				(String)list.get(index));
		if (nameFilter != "") {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품명에 금지어 "	+ nameFilter + "이 포함 되었습니다.");
		}
		if (StringUtil.getByteLength((String)list.get(index)) > 300) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품명이 허용 길이를 초과하였습니다.[최대:300byte / 실제:" + StringUtil.getByteLength((String)list.get(index)) + "byte]");
		}
		index++;
		//7 규격1(선택)
		//if (!StringUtil.isBlank(String.valueOf(list.get(index)))) {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 규격 1은 필수값이며 숫자만 허용됩니다.");
		//}
		index++;
		//8 규격2(선택)
		//if (!StringUtil.isBlank(String.valueOf(list.get(index))) && StringUtil.getByteLength(String.valueOf(list.get(index))) > 20) {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 입점업체 상품코드가 허용 길이를 초과하였습니다. [최대:20byte / 실제:" + StringUtil.getByteLength((String)list.get(index)) + "byte]");
		//}
		index++;
		//9 규격3 (선택)
		index++;
		// 보험코드 (선택)
		index++;
		//10  제조사(필수)
		if (StringUtil.isBlank((String)list.get(index))) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 제조사는 반드시 입력되어야 합니다");
		}
		if (StringUtil.getByteLength("" + list.get(index)) > 100) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 제조사가 허용 길이를 초과하였습니다. [최대:100byte / 실제:"+ StringUtil.getByteLength((String)list.get(index))+ "byte]");
		}
		String madeFilter = StringUtil.filterWord(fList, (String)list.get(index));
		if (madeFilter != "") {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 제조사에 금지어 "	+ madeFilter + "이 포함 되었습니다.");
		}
		index++;
		//11 단위 (선택)
		//String brand = String.valueOf(list.get(index));
		//String brandFilter = StringUtil.filterWord(fList, String.valueOf(list.get(index)));
		//if (brandFilter != "") {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 브랜드에 금지어 "	+ brandFilter + "이 포함 되었습니다.");
		//}
		//if (StringUtil.getByteLength(brand) > 150) {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 브랜드가 허용 길이를 초과하였습니다. [최대:150byte / 실제:" + StringUtil.getByteLength((String)list.get(index)) + "byte]");
		//}
		index++;
		//12 기준재고(선택
		// String modelName = String.valueOf(list.get(index));
		//String modelFilter = StringUtil.filterWord(fList, modelName);
		//if (modelFilter != "") {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 모델명에 금지어 "	+ modelFilter + "이 포함 되었습니다.");
		//}
		//if (StringUtil.getByteLength(modelName) > 200) {
		//	errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 모델명이 허용 길이를 초과하였습니다. [최대:200byte / 실제:" + StringUtil.getByteLength((String)list.get(index)) + "byte]");
		//}
		index++;
		//14. 발주처
		index++;
		//15. 자동 발주량
		index++;
		//16.상품이미지1(필수)
		String img1 = Const.ITEM_IMAGE_PATH+String.valueOf(list.get(index));
		if (!img1.startsWith("http://")) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품 이미지1 경로가 올바른 형식이 아닙니다.");
		}

		if (img1.toLowerCase().lastIndexOf(".jpg") == -1 && img1.toLowerCase().lastIndexOf(".jpeg") == -1 && img1.toLowerCase().lastIndexOf(".png") == -1 && img1.toLowerCase().lastIndexOf(".gif") == -1) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품 이미지1 확장자가 올바른 형식이 아닙니다. (.jpg, .jpeg 확장자를 제외한 이미지는 업로드 할 수 없습니다.)");
		}

		/*if (String.valueOf(list.get(index)).indexOf(" ") > -1) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품 이미지 URL은 공백(띄어쓰기)이 포함 될 수 없습니다.");
		}*/

		index++;
		//17 상품이미지2(선택)
		String img2 = String.valueOf(list.get(index));
		if (!StringUtil.isBlank(img2)) {
			if (!img2.startsWith("http://")) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품 이미지2가 올바른 형식이 아닙니다");
			}

			if (img2.toLowerCase().lastIndexOf(".jpg") == -1 && img2.toLowerCase().lastIndexOf(".jpeg") == -1 && img2.toLowerCase().lastIndexOf(".png") == -1 && img2.toLowerCase().lastIndexOf(".gif") == -1) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품 이미지2 확장자가 올바른 형식이 아닙니다. (.jpg, .jpeg 확장자를 제외한 이미지는 업로드 할 수 없습니다.)");
			}

			/*if (String.valueOf(list.get(index)).indexOf(" ") > -1) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상품 이미지 URL은 공백(띄어쓰기)이 포함 될 수 없습니다.");
			}*/
		}
		index++;

		//공급자의 경우, 상품 옵션값 필드 오류 체스

		if("".equals(list.get(index++))){
			//아이템 시퀀스값
			errorList.add(idx + " 번째 행:" + index  + "번째 열: 아이템 시퀀스값이 비어있습니다. ");
		}

		if("".equals(list.get(index++))){
			//optionName
			errorList.add(idx + " 번째 행:" + index  + "번째 열: 쇼핑몰 값이 비어있습니다. ");
		}
		if("".equals(list.get(index))){
			//setOptionPrice
			errorList.add(idx + " 번째 행:" + index  + "번째 열: 가격 값이 비어있습니다. ");
		}

		try {
			Integer.valueOf("" + list.get(index++));
			//setOptionPrice int value check
		}catch (Exception e){
			//setOptionPrice
			errorList.add(idx + " 번째 행:" + index  + "번째 열: 가격 값이 잘못되어 있습니다.. ");
		}

		//saleprice
		if(!"".equals(list.get(index))) {
			try {
				Integer.valueOf("" + list.get(index++));
				//saleprice int value check
			} catch (Exception e) {
				//saleprice
				errorList.add(idx + " 번째 행:" + index + "번째 열: 가격 값이 잘못되어 있습니다 ");
			}
		}
		else {
			index++;
		}
		//salePeriod
		index++;//TODO salePeriod
		if("".equals(list.get(index++))){
			//setStockCount
		}

		// 18 상세정보(필수)
		/*if (StringUtil.isBlank(String.valueOf(list.get(index)))) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상세정보는 반드시 입력되어야 합니다");
		}
		for (int i = 0; i < fList.size(); i++) {
			if (!"&lt;".equals(fList.get(i).getFilterWord()) && !"&gt;".equals(fList.get(i).getFilterWord()) && !"<".equals(fList.get(i).getFilterWord()) && !">".equals(fList.get(i).getFilterWord())) {
				if (!(String.valueOf(list.get(index)).toLowerCase().indexOf(fList.get(i).getFilterWord().toLowerCase()) == -1)) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 상세정보에 금지어 " + fList.get(i).getFilterWord() + "이 포함 되었습니다");
				}
			}
		}*/
		/*
		// 옵션여부(필수)
		if (!(String.valueOf(list.get(index)).matches("^[YN]$"))) {
			errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션여부는 Y 또는 N의 코드 값만 허용됩니다.");
		}
		String optionFlag = String.valueOf(list.get(index));
		index++;

		if ("Y".equals(optionFlag)) {
			// 옵션명(필수)
			if (StringUtil.isBlank(String.valueOf(list.get(index)))) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션명은 반드시 입력되어야 합니다");
			}
			String optionFilter = StringUtil.filterWord(fList, (String)list.get(index));
			if (optionFilter != "") {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션명에 금지어 "	+ optionFilter + "이 포함 되었습니다.");
			}
			if (StringUtil.getByteLength("" + list.get(index)) > 300) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션명이 허용 길이를 초과하였습니다.[최대:300byte / 실제:" + StringUtil.getByteLength("" + list.get(index)) + "byte]");
			}
			index++;
			// 옵션항목(필수)
			if (StringUtil.isBlank(String.valueOf(list.get(index)))) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션항목은 반드시 입력되어야 합니다");
			}
			String option = StringUtil.filterWord(fList, String.valueOf(list.get(index)));
			if (option != "") {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션항목에 금지어 " + option + "이 포함 되었습니다.");
			}
			String optionItem = String.valueOf(list.get(index));
			int optionItemCount = optionItem.trim().split(",").length;
			index++;
			// 추가가격(필수)
			if (StringUtil.isBlank(String.valueOf(list.get(index)))) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 추가가격은 반드시 입력되어야 합니다");
			}
			String optionAddPrice = String.valueOf(list.get(index));
			int optionAddPriceCount = optionAddPrice.trim().split(",").length;
			index++;
			// 재고량(필수)
			if (StringUtil.isBlank(String.valueOf(list.get(index)))) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 재고량은 반드시 입력되어야 합니다");
			}
			String optionStock = String.valueOf(list.get(index));
			int optionStockCount = optionStock.trim().split(",").length;
			index++;

			// 옵션항목, 추가가격, 재고량은 모두 컴마로 split 했을 때 사이즈가 동일해야 한다
			if (optionItemCount != optionAddPriceCount || optionAddPriceCount != optionStockCount) {
				errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션과 관련된 항목이 잘못 입력되었습니다. 옵션항목, 추가가격, 재고량이 올바르게 입력되었는지 다시 확인해주세요");
			}

			// 옵션항목 검증
			for (int i = 0; i < optionItem.split(",").length; i++) {
				if (optionItem.split(",")[i].trim().length() == 0) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션항목이 잘못 입력되었습니다");
				}

				if (StringUtil.getByteLength(""+ optionItem.split(",")[i].trim()) > 150) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 옵션항목이 허용 길이를 초과하였습니다.[최대:150byte / 실제:" + StringUtil.getByteLength("" + optionItem.split(",")[i].trim()) + "byte]");
				}
			}
			// 추가가격 검증
			
			String[] optAddPriceArr = optionAddPrice.split(",");
			for (int i = 0; i < optAddPriceArr.length; i++) {
				if (optAddPriceArr[i].trim().length() == 0) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 추가가격이 잘못 입력되었습니다");
				}
				if (!optAddPriceArr[i].trim().matches("^-?[\\d]+$")) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 추가가격은 반드시 숫자로만 입력되어야 합니다");
				}
			}
			// 재고량 검증
			for (int i = 0; i < optionStock.split(",").length; i++) {
				if (optionStock.split(",")[i].trim().length() == 0) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 재고량이 잘못 입력되었습니다");
				}
				if (!StringUtil.isNum(optionStock.split(",")[i].trim())) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 재고량은 반드시 숫자로만 입력되어야 합니다");
				}
				if (!StringUtil.isNum(optionStock.split(",")[i].trim())	|| Integer.parseInt(optionStock.split(",")[i].trim()) == 0) {
					errorList.add(idx + " 번째 행:" + (index + 1) + "번째 열: 재고량은 0이상으로 입력되어야 합니다");
				}
			}

		} else if ("N".equals(optionFlag)) {
			index += 4;
		}*/

		return errorList;
	}

	private ItemOptionVo optionMapper(ArrayList<Object> list, int LIST_SIZE, int OPTION_SIZE) throws ExcelOutOfBoundsException {
		ItemOptionVo vo = new ItemOptionVo();
		int index = LIST_SIZE;
		System.out.println(">>>seq:"+list.get(index));
		vo.setItemSeq((Integer.valueOf("" + list.get(index++))).intValue());

		System.out.println("setOptionName:"+list.get(index));
		vo.setOptionName(String.valueOf(list.get(index++)));

		System.out.println("setOptionPrice:"+list.get(index));
		vo.setOptionPrice(Integer.valueOf("" +list.get(index++)));

		System.out.println("setSalePrice:"+list.get(index));
		if(!("".equals(list.get(index)))) {
			vo.setSalePrice(Integer.valueOf("" + list.get(index++)));
		}
		else{
			index++;
		}

		//System.out.println("setSalePeriod:"+list.get(index));
		//vo.setSalePeriod(String.valueOf(list.get(index++)));
		index++;//TODO salePeriod

		System.out.println("setStockCount:"+list.get(index));
		vo.setStockCount(Integer.valueOf("" +list.get(index++)));

		return vo;
	}

	private ItemVo itemMapper(ArrayList<Object> list, int LIST_SIZE) throws ExcelOutOfBoundsException {

		ItemVo vo = new ItemVo();
		int index = 0;
		// 1대분류 코드
		Map map = new HashMap();

		try {
			vo.setSeq((Integer.valueOf("" + list.get(index++))).intValue());//item seq
		}catch(Exception e){
			e.printStackTrace();
		}

		map.put("seq", 0);
		map.put("name", String.valueOf(list.get(index++)));

		CategoryVo category = categoryService.getVoByName(map);
		vo.setCateLv1Seq(category.getSeq());
		//2 중분류 코드
		if (!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			map.clear();
			map.put("seq", category.getSeq());
			map.put("name", String.valueOf(list.get(index++)));
			category = categoryService.getVoByName(map);
			vo.setCateLv2Seq(category.getSeq());
		} else {
			index++;
		}
		//3 소분류 코드
		if (!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			map.clear();
			map.put("seq", category.getSeq());
			map.put("name", String.valueOf(list.get(index++)));
			category = categoryService.getVoByName(map);
			vo.setCateLv3Seq(category.getSeq());
		} else {
			index++;
		}
		//4 세분류 코드
		if (!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			map.clear();
			map.put("seq", category.getSeq());
			map.put("name", String.valueOf(list.get(index++)));
			category = categoryService.getVoByName(map);
			vo.setCateLv4Seq(category.getSeq());
		} else {
			index++;
		}
		//5 진료과목
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))){
			vo.setSubjectType(""+list.get(index++));
		} else {
			index++;
		}
		//6 상품명
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setName(String.valueOf(list.get(index++)));
		}else {
			index++;
		}
		//7. 규격1
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setType1(String.valueOf(list.get(index++)));
		}else {
			index++;
		}
		//8 규격2
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setType2(String.valueOf(list.get(index++)));
		}else {
			index++;
		}
		//9. 규격3
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setType3(String.valueOf(list.get(index++)));
		}else {
			index++;
		}
		//보험코드
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setInsuranceCode(String.valueOf(list.get(index++)));
		}else {
			index++;
		}

		//10 제조사
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setMaker(String.valueOf(list.get(index++)));
		}else {
			index++;
		}
		//11 단위
		vo.setOriginCountry(String.valueOf(list.get(index++)));
		//12 기준재고
		vo.setModelName(String.valueOf(list.get(index++)));
		//13 판매가
		vo.setSellPrice(1);//임의의 값으로 넣는다. ODO change value.....
		// 입점업체 공급가
		vo.setSupplyPrice(vo.getSellPrice());
		// 14. 발주처
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setBrand(String.valueOf(list.get(index++)));
		}else {
			index++;
		}
		// 15. 자동발주
		if(!StringUtil.isBlank(String.valueOf(list.get(index)))) {
			vo.setMinCnt((Integer.valueOf(""+list.get(index++))).intValue());
		}else {
			index++;
		}
		// 16 상품이미지1 20
		vo.setImg1(encodeHttpURL(String.valueOf(list.get(index++))));
		// 17 상품이미지2
		vo.setImg2(encodeHttpURL(String.valueOf(list.get(index++))));
		// 18 상세정보
		//vo.setContent(StringUtil.clearXSS((String)list.get(index++)));
		//List<ItemOptionVo> optionList = new ArrayList<>();

		/*String optionFlag = String.valueOf(list.get(index++));
		try {
			if ("Y".equals(optionFlag)) {
				int length = ("" + list.get(index + 2)).split(",").length;
				for (int i = 0; i < length; i++) {
					int itemIndex = index; // 여기서 index를 고정시킨다 (option항목은 돌아  가면서 인덱스를 변경할 것이다)
					ItemOptionVo ovo = new ItemOptionVo();
					// 옵션명
					ovo.setOptionName(("" + list.get(itemIndex++)).trim());
					log.info("getOptionName=" + ovo.getOptionName());

					// 옵션항목
					ovo.setValueName(("" + list.get(itemIndex++)).split(",")[i].trim());
					log.info("getValueName=" + ovo.getValueName());
					// 추가가격
					ovo.setOptionPrice(Integer.parseInt(("" + list.get(itemIndex++)).split(",")[i].trim()));
					// 재고량
					ovo.setStockCount(Integer.parseInt(("" + list.get(itemIndex++)).split(",")[i].trim()));
					ovo.setShowFlag("Y");
					optionList.add(ovo);
				}
			} else if ("N".equals(optionFlag)) {
				ItemOptionVo ovo = new ItemOptionVo();
				// 옵션명
				ovo.setOptionName("옵션");
				log.info("getOptionName=" + ovo.getOptionName());

				// 옵션항목
				ovo.setValueName("기본");
				log.info("getValueName=" + ovo.getValueName());
				// 추가가격
				ovo.setOptionPrice(0);
				// 재고량
				ovo.setStockCount(999);
				ovo.setShowFlag("Y");
				optionList.add(ovo);
			}
		} catch (IndexOutOfBoundsException e) {
			throw new ExcelOutOfBoundsException();
		}
		vo.setOptionList(optionList);
		*/
		// 상태코드 E=엑셀 대량 등록 상태
		vo.setStatusCode("E");
		// 사용 코드 C=컨텐츠
		vo.setUseCode("C");
			
		//if(LIST_SIZE == 18) {
		//	vo.setOldSellerSeq(Integer.valueOf(String.valueOf(list.get(index+4))));
		//}
		return vo;
	}
	
	//http URL 인코딩
	private String encodeHttpURL(String str) {
		String encStr = "";
		System.out.println(str);
		String[] arrStr = str.split("/");
		if( arrStr != null ) {
			for( int i=0; i<arrStr.length; i++) {
				String tmpStr = arrStr[i];
				if(i > 0 && tmpStr.indexOf(":") < 0) {
					try {
						tmpStr = java.net.URLEncoder.encode(arrStr[i],"UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				encStr = encStr + tmpStr;
				if( i < arrStr.length-1 ) {
					encStr = encStr + "/";
				}
			}
		}
		encStr = encStr.replace("+", "%20");

		System.out.println("===>");
		System.out.println(encStr);

		return encStr;
	}

}