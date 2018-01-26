package com.smpro.service;

import com.smpro.vo.*;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public interface OrderStatsService {
	/** 상품 카테고리별 매출 통계 */
	public List<HashMap<String,Integer[]>> getListByCategory(OrderVo vo);
	public HashMap<String,Integer[]> getSumByCategory(OrderVo vo);
	public List<OrderVo> getListByCategoryDetail(OrderVo vo);
	public OrderVo getListByCategoryDetailSum(OrderVo vo);
	public OrderVo getListByCategoryDetailCancelSum(OrderVo vo);
	
	/** 인증 구분별 매출 통계 */
	public List<HashMap<String,Integer>> getListByAuthCategory(OrderVo vo);
	public HashMap<String,Integer> getSumByAuthCategory(OrderVo vo);
	
	/** 회원 구분별 매출 통계 */
	public List<HashMap<String,Integer>> getListByMember(OrderVo vo);
	public HashMap<String,Integer> getSumByMember(OrderVo vo);
	
	/** 회원 구분별 매출 통계(공공기관) */
	public List<HashMap<String,Integer>> getListByMemberPublic(OrderVo vo);
	
	/** 회원 구분별 매출 통계(공공기관) 상세 */
	public List<OrderVo> getListByMemberPublicDetail(MemberGroupVo vo);
	
	/** 상품별 누적 판매 수 */
	public List<OrderVo> getListByItem(OrderVo vo);
	public OrderVo getListByItemSum(OrderVo vo);
	public OrderVo getListByItemCancelSum(OrderVo vo);
	
	/** 자치구별 상품 누적 판매 수(입점업체) */
	public List<OrderVo> getListByItemForSellerJachigu(SellerVo vo);
	public OrderVo getListByItemForSellerJachiguSum(SellerVo vo);
	
	/** 자치구별 상품 누적 판매 수(구매자-공공기관) */
	public List<OrderVo> getListByItemForMemberJachigu(SellerVo vo);
	public OrderVo getListByItemForMemberJachiguSum(SellerVo vo);
}	
