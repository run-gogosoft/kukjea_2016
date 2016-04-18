package com.smpro.service;

import java.util.List;

import com.smpro.vo.MailVo;
import com.smpro.vo.OrderVo;
import org.springframework.stereotype.Service;

@Service
public interface MailService {
	
	/** 메일 발송(공통) */
	public void sendMail(MailVo vo);

	/** 임시 비밀번호 */
	public String getPasswordHtml(String password, String name,	String realPath) throws Exception;

	public String getPasswordHtmlString(String realPath) throws Exception;

	/** 아이디 */
	public String getIdHtml(String id, String name, String realPath) throws Exception;
	
	/** 회원가입 */
	public String getMember(String id, String name, String realPath) throws Exception;
	
	/** 고객 주문 메일 발송 */
	public void sendMailToMemberForOrder(OrderVo vo, List<OrderVo> list, String srcRealPath);
	 
	/** 입점업체 주문확인 메일 발송 */
	public void sendMailToSellerForOrder(OrderVo vo, String srcRealPath);
	
	/** 고객 비밀번호 변경 안내 메일 발송 */
	public void sendMailToMemberForPasswordNotice();
}
