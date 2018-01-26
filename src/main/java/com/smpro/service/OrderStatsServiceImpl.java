package com.smpro.service;

import com.smpro.dao.OrderStatsDao;
import com.smpro.vo.MemberGroupVo;
import com.smpro.vo.OrderVo;
import com.smpro.vo.SellerVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class OrderStatsServiceImpl implements OrderStatsService {

	@Autowired
	private OrderStatsDao orderStatsDao;

	public List<HashMap<String,Integer[]>> getListByCategory(OrderVo vo) {
		return orderStatsDao.getListByCategory(vo);
	}
	
	public HashMap<String, Integer[] > getSumByCategory(OrderVo vo) {
		return orderStatsDao.getSumByCategory(vo);
	}
	
	public List<OrderVo> getListByCategoryDetail(OrderVo vo) {
		return orderStatsDao.getListByCategoryDetail(vo);
	}
	
	public OrderVo getListByCategoryDetailSum(OrderVo vo) {
		return orderStatsDao.getListByCategoryDetailSum(vo);
	}
	
	public OrderVo getListByCategoryDetailCancelSum(OrderVo vo) {
		return orderStatsDao.getListByCategoryDetailCancelSum(vo);
	}

	public List<HashMap<String, Integer>> getListByAuthCategory(OrderVo vo) {
		return orderStatsDao.getListByAuthCategory(vo);
	}

	public HashMap<String, Integer> getSumByAuthCategory(OrderVo vo) {
		return orderStatsDao.getSumByAuthCategory(vo);
	}

	public List<HashMap<String, Integer>> getListByMember(OrderVo vo) {
		return orderStatsDao.getListByMember(vo);
	}

	public HashMap<String, Integer> getSumByMember(OrderVo vo) {
		return orderStatsDao.getSumByMember(vo);
	}

	public List<HashMap<String, Integer>> getListByMemberPublic(OrderVo vo) {
		return orderStatsDao.getListByMemberPublic(vo);
	}

	public List<OrderVo> getListByMemberPublicDetail(MemberGroupVo vo) {
		return orderStatsDao.getListByMemberPublicDetail(vo);
	}

	public List<OrderVo> getListByItem(OrderVo vo) {
		return orderStatsDao.getListByItem(vo);
	}
	
	public OrderVo getListByItemSum(OrderVo vo) {
		return orderStatsDao.getListByItemSum(vo);
	}
	
	public OrderVo getListByItemCancelSum(OrderVo vo) {
		return orderStatsDao.getListByItemCancelSum(vo);
	}

	public List<OrderVo> getListByItemForSellerJachigu(SellerVo vo) {
		return orderStatsDao.getListByItemForSellerJachigu(vo);
	}

	public OrderVo getListByItemForSellerJachiguSum(SellerVo vo) {
		return orderStatsDao.getListByItemForSellerJachiguSum(vo);
	}
	
	public List<OrderVo> getListByItemForMemberJachigu(SellerVo vo) {
		return orderStatsDao.getListByItemForMemberJachigu(vo);
	}

	public OrderVo getListByItemForMemberJachiguSum(SellerVo vo) {
		return orderStatsDao.getListByItemForMemberJachiguSum(vo);
	}
}
