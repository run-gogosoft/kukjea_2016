package com.smpro.controller.admin;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.smpro.util.Const;
import com.smpro.util.FileUploadUtil;

@Controller
public class EditController {
	
	/** 에디터 이미지 업로드 기능을 사용할 경우 해당 이미지를 임시 저장 */
	@RequestMapping("/editor/upload")
	public String uploadImage(MultipartHttpServletRequest mRequest, Model model) {
		return (new FileUploadUtil().uploadCKEditorImage(mRequest, model)) ? Const.REDIRECT_PAGE : Const.ALERT_PAGE;
	}
}
