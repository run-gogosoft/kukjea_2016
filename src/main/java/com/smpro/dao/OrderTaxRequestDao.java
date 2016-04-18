package com.smpro.dao;

import com.smpro.vo.OrderVo;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderTaxRequestDao {
    public int mergeData(OrderVo vo);
    public OrderVo getData(Integer orderSeq);
    public int completeTaxRequest(Integer orderSeq);
}