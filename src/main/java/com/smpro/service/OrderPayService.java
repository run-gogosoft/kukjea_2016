package com.smpro.service;

import com.smpro.vo.*;
import org.springframework.stereotype.Service;

@Service
public interface OrderPayService {
	public boolean regOrderPay(OrderPayVo vo);
}
