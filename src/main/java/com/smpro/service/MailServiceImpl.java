package com.smpro.service;

import com.smpro.dao.MemberDao;
import com.smpro.dao.OrderDao;
import com.smpro.util.Const;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.MailVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.OrderVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.BufferedReader;
import java.io.FileReader;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

@Slf4j
@Service
public class MailServiceImpl implements MailService {
	@Autowired
	private JavaMailSender javaMailSender;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private MemberDao memberDao;

	@Override
	public void sendMail(MailVo vo) {
		MimeMessage message = javaMailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, false, "UTF-8");
			messageHelper.setSubject(vo.getSubject());
			messageHelper.setTo(vo.getToUser());
			messageHelper.setCc(vo.getToCc());
			messageHelper.setFrom(vo.getFromUser());
			messageHelper.setText(vo.getText(), true);
			javaMailSender.send(message);
		} catch (MessagingException e) {
			log.error("mail-messaging-exception]" + e.getMessage());
		}
	}

	@Override
	public String getPasswordHtml(String password, String name,	String realPath) throws Exception {
		String str = getPasswordHtmlString(realPath);
		// 고정이미지 생성
		str = str.replace("{$titleMemberName$}", name);
		str = str.replace("{$memberName$}", name);
		str = str.replace("{$logo$}", "<img src='http://www.kukjemall.com/images/common/logo.png'/>");
		str = str.replace("{$searchBtn$}", "<a href='http://"+Const.DOMAIN+"/shop/main' target='_blank'><button type='text' class='btn btn_gray'>페이지 바로가기</button></a>");
		str = str.replace("{$footer$}", "<img src='http://www.kukjemall.com/images/common/footer.png'/>");
		str = str.replace("{$password$}", password);
		str = str.replace("{$sendDate$}",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
		return str;
	}

	@Override
	public String getPasswordHtmlString(String realPath) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(realPath + "/WEB-INF/jsp/shop/_system/mail_password.html"));
		StringBuffer sb = new StringBuffer();
		if (br.ready()) {
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		}
		br.close();
		return sb.toString();
	}
	
	@Override
	public String getMember(String id, String name, String realPath) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(realPath + "/WEB-INF/jsp/shop/_system/mail_member.html"));
		StringBuffer sb = new StringBuffer();
		if (br.ready()) {
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		}
		br.close();
		String str = sb.toString();
		str = str.replace("{$name$}", name);
		str = str.replace("{$logo$}", "<img src='http://www.kukjemall.com/images/common/logo.png'/>");
		str = str.replace("{$join$}", "<img src='http://" + Const.DOMAIN + Const.UPLOAD_PATH + "/mail/join.png'/>");
		str = str.replace("{$searchBtn$}", "<a href='http://"+Const.DOMAIN+"/shop/main' target='_blank'><button type='text' class='btn btn_gray'>페이지 바로가기</button></a>");
		str = str.replace("{$footer$}", "<img src='http://www.kukjemall.com/images/common/footer.png'/>");
		str = str.replace("{$id$}", id);

		return str;
	}
	
	@Override
	public String getIdHtml(String id, String name, String realPath) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(realPath + "/WEB-INF/jsp/shop/_system/mail_id.html"));
		StringBuffer sb = new StringBuffer();
		if (br.ready()) {
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		}
		br.close();
		String str = sb.toString();
		str = str.replace("{$titleMemberName$}", name);
		str = str.replace("{$memberName$}", name);
		str = str.replace("{$logo$}", "<img src='http://www.kukjemall.com/images/common/logo.png'/>");
		str = str.replace("{$searchBtn$}", "<a href='http://"+Const.DOMAIN+"/shop/main' target='_blank'><button type='text' class='btn btn_gray'>페이지 바로가기</button></a>");
		str = str.replace("{$footer$}", "<img src='http://www.kukjemall.com/images/common/footer.png'/>");
		str = str.replace("{$id$}", id);
		str = str.replace("{$sendDate$}",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));

		return str;
	}
	
	@Override
	public void sendMailToMemberForOrder(OrderVo vo, List<OrderVo> list, String srcRealPath) {
		try {
			MailVo mvo = new MailVo();
			mvo.setSubject("[" + vo.getMallName() + "] 주문하신 상품내역입니다.");
			mvo.setText(getOrderAcceptHTML(vo, list, srcRealPath));
			mvo.setFromUser(Const.MALL_MAIL);
			mvo.setToUser(vo.getMemberEmail());
			sendMail(mvo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private String getOrderAcceptHTML(OrderVo vo, List<OrderVo> list, String srcRealPath) throws Exception {
		int totalSellPrice = 0, totalDeliveryPrice = 0, totalDiscountPrice = 0;

		StringBuilder itemList = new StringBuilder();
		NumberFormat fmt = NumberFormat.getInstance(Locale.KOREAN);
		// 주문한 내역 리스트
		for (int i = 0; i < list.size(); i++) {
			itemList.append("<tr style='height:85px;'>");
			itemList.append("<td style='width:240px;border-bottom: 1px solid #e1e1e1;text-align:center;'>");
			itemList.append(list.get(i).getItemName()+"<br/><span style='color:#66cccc;'>"+list.get(i).getOptionValue()+"</span>");
			itemList.append("</td>");
			itemList.append("<td style='border-bottom: 1px solid #e1e1e1;text-align:center;'>");
			itemList.append(fmt.format(list.get(i).getSellPrice())+"원");
			itemList.append("</td>");
			itemList.append("<td style='border-bottom: 1px solid #e1e1e1;text-align:center;font-weight:bold;'>");
			itemList.append(list.get(i).getOrderCnt()+"개");
			itemList.append("</td>");
//			itemList.append("<td style='border-bottom: 1px solid #e1e1e1;text-align:center;font-weight:bold;'>");
			
//			if(list.get(i).getDeliCost() != 0) {
//				itemList.append(fmt.format(list.get(i).getDeliCost())+"원");
//			}else {
//				itemList.append("무료");
//			}
			
//			itemList.append("</td>");
			itemList.append("</tr>");
			totalSellPrice += (list.get(i).getSellPrice()) * list.get(i).getOrderCnt();
//			totalDeliveryPrice += list.get(i).getDeliCost();
		}

//		for (int i = 0; i < list.size(); i++) {
//			if(list.get(i).getDeliCost() != 0) {
//				totalDeliveryPrice += list.get(i).getDeliCost();
//				break;
//			}
//		}

		if(totalSellPrice<=50000){
			totalDeliveryPrice = Const.DELI_COST;
		}

		if (vo.getPoint() > 0) {
			totalDiscountPrice += vo.getPoint();
		}

		BufferedReader br = new BufferedReader(new FileReader(srcRealPath + "/WEB-INF/jsp/shop/_system/mail_order.html"));
		StringBuffer sb = new StringBuffer();
		if (br.ready()) {
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		}
		br.close();
		
		String html = sb.toString();
		// 고정이미지 생성
		html = html.replace("{$header$}", "<img src='http://" + Const.DOMAIN + Const.UPLOAD_PATH + "/mail/mail-find-pw-header-img.png'/>");
		html = html.replace("{$searchBtn$}", "<a href='http://"+Const.DOMAIN+"/shop/main' target='_blank'><button type='text' class='btn btn_gray'>페이지 바로가기</button></a>");
		html = html.replace("{$orderBtn$}", "<a href='http://" + Const.DOMAIN + "/shop/mypage/order/list' style='margin-left:20px;'><button type='text' class='btn btn_gray'>주문 바로가기</button></a></a>");
		
		html = html.replace("{$logo$}", "<img src='http://www.kukjemall.com/images/common/logo.png'/>");
		html = html.replace("{$footer$}", "<img src='http://www.kukjemall.com/images/common/footer.png'/>");
		html = html.replace("{$memberName$}", vo.getMemberName());
		html = html.replace("{$receiveAddr$}", vo.getReceiverAddr1() + " " + vo.getReceiverAddr2());
		html = html.replace("{$receiveCell$}", vo.getReceiverCell());
		html = html.replace("{$receiveName$}", vo.getReceiverName());

		html = html.replace("{$totalSellPrice$}", fmt.format(totalSellPrice));
		html = html.replace("{$totalDeliveryPrice$}",	fmt.format(totalDeliveryPrice));
		html = html.replace("{$totalDiscountPrice$}",	fmt.format(totalDiscountPrice));
		html = html.replace("{$totalPrice$}", fmt.format(totalSellPrice + totalDeliveryPrice - totalDiscountPrice));
		html = html.replace("{$regDate$}", vo.getRegDate().split(" ")[0]);
		html = html.replace("{$orderCount$}", String.valueOf(list.size()));
		html = html.replace("{$itemList$}", itemList.toString());

		return html;
	}
	
	@Override
	public void sendMailToSellerForOrder(OrderVo vo, String srcRealPath) {
		//주문번호내 입점업체별로 메일을 발송한다.
		List<String> list = orderDao.getListSellerEmail(vo.getOrderSeq());
		if(list != null) {
			for(String salesEmail : list) {
				try {
					MailVo mvo = new MailVo();
					mvo.setSubject("[" + vo.getMallName() + "] 주문이 접수되었습니다");
					mvo.setText(getOrderSellerAcceptHTML(vo, srcRealPath));
					mvo.setFromUser(Const.MALL_MAIL);
					mvo.setToUser(salesEmail);
					sendMail(mvo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	private String getOrderSellerAcceptHTML(OrderVo vo, String srcRealPath) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(srcRealPath + "/WEB-INF/jsp/shop/_system/mail_order_seller.html"));
		StringBuffer sb = new StringBuffer();
		if (br.ready()) {
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		}
		String html = sb.toString();
		br.close();
	
		// 고정이미지 생성
		html = html.replace("{$header$}", "<img src='http://" + Const.DOMAIN + Const.UPLOAD_PATH + "/mail/mail-find-pw-header-img.png'/>");
		html = html.replace("{$searchBtn$}", "<a href='http://"+Const.DOMAIN+"/shop/main' target='_blank'><button type='text' class='btn btn_gray'>페이지 바로가기</button></a>");
		html = html.replace("{$logo$}", "<img src='http://www.kukjemall.com/images/common/logo.png'/>");
		html = html.replace("{$footer$}", "<img src='http://www.kukjemall.com/images/common/footer.png'/>");
		// 데이터 맵핑
		html = html.replace("{$memberName$}", vo.getMemberName());
		html = html.replace("{$receiveAddr$}", vo.getReceiverAddr1() + " " + vo.getReceiverAddr2());
		html = html.replace("{$receiveCell$}", vo.getReceiverCell());
		html = html.replace("{$receiveName$}", vo.getReceiverName());
		html = html.replace("{$regDate$}", vo.getRegDate().split(" ")[0]);

		return html;
	}
	
	@Override
	public void sendMailToMemberForPasswordNotice() {
		List<MemberVo> list = memberDao.getListForPasswordNotice();
		if(list != null) {
			for(MemberVo vo : list) {
				try {
					MailVo mvo = new MailVo();
					mvo.setSubject("[" + vo.getMallName() + "] 비밀번호 변경 안내 메일");
					mvo.setText(getMemberForPasswordNoticeHTML(vo));
					mvo.setFromUser(Const.MALL_MAIL);
					mvo.setToUser(CrypteUtil.decrypt(vo.getEmail(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null));
					sendMail(mvo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	private String getMemberForPasswordNoticeHTML(MemberVo vo) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(Const.WEBAPP_HOME_REAL_PATH + "/WEB-INF/jsp/shop/_system/mail_notice_password.html"));
		StringBuffer sb = new StringBuffer();
		if (br.ready()) {
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		}
		String html = sb.toString();
		br.close();
	
		// 고정이미지 생성
		html = html.replace("{$logo$}", "<img src='http://www.kukjemall.com/images/common/logo.png'/>");
		html = html.replace("{$footer$}", "<img src='http://www.kukjemall.com/images/common/footer.png'/>");
		// 데이터 맵핑
		html = html.replace("{$memberName$}", vo.getName());
		
		return html;
	}
	
}
