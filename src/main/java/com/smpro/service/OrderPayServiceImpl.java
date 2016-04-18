package com.smpro.service;

import com.smpro.dao.OrderPayDao;
import com.smpro.vo.OrderPayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class OrderPayServiceImpl implements OrderPayService {
	@Autowired
	private OrderPayDao orderPayDao;

	@Override
	public boolean regOrderPay(OrderPayVo vo) {
		return orderPayDao.regOrderPay(vo) > 0;
	}
}
