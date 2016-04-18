package com.smpro.service;

import com.smpro.dao.OrderPayDao;
import com.smpro.vo.OrderPayVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("orderPayService")
public class OrderPayServiceImpl implements OrderPayService {
	@Resource(name = "orderPayDao")
	private OrderPayDao orderPayDao;

	public boolean regOrderPay(OrderPayVo vo) {
		return orderPayDao.regOrderPay(vo) > 0;
	}
}
