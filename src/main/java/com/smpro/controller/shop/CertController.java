package com.smpro.controller.shop;

import com.smpro.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CertController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/cert/nice/{type}/start")
	public String start(@PathVariable String type) {
		return "/cert/nice/"+type+"_start.jsp";
	}

	@RequestMapping("/cert/nice/ipin/result")
	public String resultIpin() {
		return "/cert/nice/ipin_result.jsp";
	}

	@RequestMapping("/cert/nice/mobile/result/{type}")
	public String resultMobile(@PathVariable String type) {
		return "/cert/nice/mobile_result_"+type+".jsp";
	}
}
