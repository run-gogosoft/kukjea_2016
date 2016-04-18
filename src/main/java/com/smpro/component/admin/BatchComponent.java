package com.smpro.component.admin;

import com.smpro.service.*;
import com.smpro.util.Const;
import com.smpro.vo.ItemVo;
import com.smpro.vo.OrderVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;

/**
 * 배치 작업 모듈
 * User: 유동재
 * Date: 2013. 12. 23.
 * Time: 오후 3:52
 */
@Component
public class BatchComponent {
	private static final Logger LOGGER = LoggerFactory.getLogger(BatchComponent.class);
	
	@Resource(name="adjustService")
	private AdjustService adjustService;
	
	@Resource(name="cartService")
	private CartService cartService;
	
	@Resource(name="itemService")
	private ItemService itemService;

	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="pointService")
	private PointService pointService;
	
	@Resource(name="mailService")
	private MailService mailService;
	
	/** 정산 확정 데이터 */
	@Scheduled(cron="0 0 1 * * *")
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public void regAdjustData() throws Exception {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 정산 배치 시작 ###");
			LOGGER.info("처리 건수: " + adjustService.regVo(adjustService.getListForAdjust()));
			LOGGER.info("### 정산 배치 종료 ###");

			LOGGER.info("### 취소 정산 배치 시작 ###");
			LOGGER.info("처리 건수: " + adjustService.regVo(adjustService.getListForAdjustCancel()));
			LOGGER.info("### 취소 정산 배치 종료 ###");
		}
	}

	/**
	 * 배송완료 배치
	 * User: 김찬호
	 * Date: 2015. 01. 09.
	 * Time: 오전 11:00
	 */
	/** 배송완료 배치 작업 */
	@Scheduled(cron="0 0 21 * * *")
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updateOrderDeliveryFinish() throws Exception {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 배송완료 배치 시작 ###");
			List<OrderVo> list = orderService.getOrderDeliveryFinish();
			int successCnt = 0;
			if(list != null) {
				for (int i = 0; i < list.size(); i++) {
					OrderVo tmpVo = list.get(i);
					LOGGER.info("### 상품 주문 번호 : " + tmpVo.getSeq() + " [" + orderService.updateDeliveryProc(tmpVo) + "]");
					successCnt++;
				}

				if (list.size() != successCnt) {
					throw new Exception("배송완료 업데이트 건수 일치 하지 않음.");
				}
			}
			LOGGER.info("### 처리건수 : " + successCnt);
			LOGGER.info("### 배송완료 배치 종료 ###");
		}
	}
	/**
	 * 구매확정 배치
	 * User: 김찬호
	 * Date: 2014. 08. 01.
	 * Time: 오전 11:00
	 */
	/** 구매확정 배치 작업 */
	@Scheduled(cron="0 0 22 * * *")
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updateOrderConfirmForDate() throws Exception {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 구매확정 배치 시작 ###");

			List<OrderVo> list = orderService.getOrderConfirm();
			int successCnt = 0;
			if(list != null) {
				for (int i = 0; i < list.size(); i++) {
					OrderVo vo = list.get(i);
					vo.setStatusCode("55");
					if (orderService.updateStatus(vo)) {
						LOGGER.info("### 상품 주문 번호 : " + vo.getSeq());
						successCnt++;
					}
				}

				if (list.size() != successCnt) {
					throw new Exception("구매확정 업데이트 건수 일치 하지 않음.");
				}
			}
			LOGGER.info("### 처리건수 : " + successCnt);
			LOGGER.info("### 구매확정 배치 종료 ###");
		}
	}

	/**
	 * 6개월 지난 상품로그 삭제
	 */
	@Scheduled(cron="0 0 2 * * *")
	public void deleteItemLogBatch() {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 상품로그 삭제 배치 시작 ###");
			LOGGER.info("### 처리건수 : " + itemService.deleteLogBatch());
			LOGGER.info("### 상품로그 삭제 배치 종료 ###");
		}
	}
	
	/**
	 * 3일 지난 장바구니 목록 삭제
	 */
	@Scheduled(cron="0 30 2 * * *")
	public void deleteCartBatch() {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 장바구니 목록 삭제 배치 시작 ###");
			LOGGER.info("### 처리건수 : " + cartService.deleteBatch());
			LOGGER.info("### 장바구니 목록 삭제 배치 종료 ###");
		}
	}
	
	/**
	 * 무통장입금 기한 지난 주문 건 취소 처리
	 */
	@Scheduled(cron="0 0 3 * * *")
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updateOrderCancelForExpire() throws Exception {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 무통장입금 기한 지난 주문 건 취소 처리 배치 시작 ###");
			List<Integer> list = orderService.getListExpire();
			int procCnt = 0;
			if(list != null) {
				for(Integer orderDetailSeq:list) {
					OrderVo vo = new OrderVo();
					vo.setSeq(orderDetailSeq);
					vo.setStatusCode("99");
					if(orderService.updateStatus(vo)) {
						LOGGER.info("### 상품 주문 번호 : " + orderDetailSeq);
						procCnt++;
					}
				}
				
				if (list.size() != procCnt) {
					throw new Exception("### 업데이트 건수 일치 하지 않음.");
				}
			}
			LOGGER.info("### 처리건수 : " + procCnt);
			LOGGER.info("### 무통장입금 기한 지난 주문 건 취소 처리 배치 종료 ###");
		}
	}
	
	/**
	 * 임시 파일 삭제 
	 */
	@Scheduled(cron="0 30 3 * * *")
	public void deleteTempFiles() {
		if("service".equals(Const.LOCATION)) {
			int delCnt;
			//임시파일 디렉토리
			File[] dirs = {
				new File(Const.UPLOAD_REAL_PATH+File.separator+"item"+File.separator+"temp"),
				new File(Const.UPLOAD_REAL_PATH+File.separator+"plan"+File.separator+"temp"),
				new File(Const.UPLOAD_REAL_PATH+File.separator+"editor"+File.separator+"temp")
			};
			
			for(File dir : dirs) {
				LOGGER.info("### 임시 파일 삭제 시작 ###");
				LOGGER.info("### 대상 디렉토리 : " + dir.getPath() + dir.getName());
				delCnt = 0;
				if(dir.isDirectory()) {
					long curTime = System.currentTimeMillis();
					for(File file: dir.listFiles()) {
						//최근 수정일이 하루 이상 지난 파일만 삭제한다.(24시간 * 60분 * 60초 * 1000 = 86400000ms)
						if(curTime - file.lastModified() > 86400000) {
							LOGGER.info("### 삭제 파일 : " + file.getPath() + file.getName());
							file.delete();
							delCnt++;
						}
					}
				}
				LOGGER.info("### 처리 건수 : " + delCnt);
				LOGGER.info("### 임시 파일 삭제 종료 ###");
			}
		}
	}
	
	/**
	 * 포인트 배치 작업
	 * User: 김찬호
	 * Date: 2014. 04. 08.
	 * Time: 오후 4:10
	 */
	/** 포인트 만료기간 배치 작업 */
	/** TODO : 포인트 사용 */
	/*
	@Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
	public void updatePointForEndDate() throws Exception {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 포인트 배치 시작 ###");
			List<PointVo> list = pointService.getBatchPointForEndDate();

			int successCnt = 0;
			for (int i = 0; i < list.size(); i++) {
				PointVo vo = new PointVo();
				vo.setPointSeq(list.get(i).getSeq());
				vo.setPoint(list.get(i).getUseablePoint());
				vo.setStatusCode("D");
				vo.setMemberSeq(list.get(i).getMemberSeq());

				//sm_point_history
				if (!pointService.insertHistoryData(vo)) {
					throw new Exception();
				}

				vo.setStatusCode("D");
				//sm_point_log
				if (!pointService.insertLogData(vo)) {
					throw new Exception();
				}

				//소멸이기 때문에 사용가능 포인트는 그대로 둔다
				vo.setUseablePoint(list.get(i).getUseablePoint());
				vo.setValidFlag("N");
				//sm_point
				if (!pointService.updateData(vo)) {
					throw new Exception();
				}
				successCnt++;
			}

			if (list.size() != successCnt) {
				throw new Exception("포인트 업데이트 건수 일치 하지 않음.");
			}

			LOGGER.info("### 포인트 배치 종료 ###");
		}
	}*/
	
	/** 재고가 없을때 판매중지 상태로 변경되는 배치 작업*/
	@Scheduled(cron="0 0 4 * * *")
	public void modItemStatusCode() {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 품절상품 상태변경 배치 시작 ###");
			List<ItemVo> list = itemService.getSoldOutList();

			for (ItemVo vo : list) {
				boolean flag = false;
				try {
					flag = itemService.modItemStatusCode(vo);
				} catch (Exception e) {
					e.printStackTrace();
					flag = false;
				}
				if (flag) {
					LOGGER.info("### 품절 상태 변경 성공 : 상품번호 [" + vo.getSeq() + "]");
				} else {
					LOGGER.info("### 품절 상태 변경 실패 : 상품번호 [" + vo.getSeq() + "]");
				}
			}
			LOGGER.info("### 품절상품 상태변경 배치 종료 ###");
		}
	}
	
	/** 장기 미접속자 비밀번호 변경 안내 메일 발송 */
	@Scheduled(cron="0 0 5 * * *")
	public void sendMailForPasswordNotice() {
		if("service".equals(Const.LOCATION)) {
			LOGGER.info("### 비밀번호 변경 안내 메일 발송 배치 시작 ###");
			try {
				mailService.sendMailToMemberForPasswordNotice();
			} catch (Exception e) {
				e.printStackTrace();
			}
			LOGGER.info("### 비밀번호 변경 안내 메일 발송 배치 종료 ###");
		}
	}
}
