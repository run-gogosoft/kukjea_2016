package com.smpro.dao;

import com.smpro.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class ItemDaoImpl implements ItemDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ItemVo> getList(ItemVo vo) {
		return sqlSession.selectList("item.getList", vo);
	}

	@Override
	public int getListTotalCount(ItemVo vo) {
		return ((Integer) sqlSession.selectOne("item.getListTotalCount", vo)).intValue();
	}

	@Override
	public List<ItemVo> getListSimple(ItemVo vo) {
		return sqlSession.selectList("item.getListSimple", vo);
	}

	@Override
	public int getListSimpleTotalCount(ItemVo vo) {
		return ((Integer)sqlSession.selectOne("item.getListSimpleTotalCount", vo)).intValue();
	}

	@Override
	public ItemVo getVo(Integer seq) {
		return sqlSession.selectOne("item.getVo", seq);
	}

	@Override
	public OrderVo getVoForOrderReg(ItemVo vo) {
		return sqlSession.selectOne("item.getVoFo, mod_date\n" +
				"\t\t\t, reg_daterOrderReg", vo);
	}

	@Override
	public int createSeq(ItemVo vo) {
		return sqlSession.update("item.createSeq", vo);
	}

	@Override
	public int insertVo(ItemVo vo) {
		return sqlSession.insert("item.insertVo", vo);
	}

	@Override
	public int insertDetailVo(ItemVo vo) {
		return sqlSession.insert("item.insertDetailVo", vo);
	}

	@Override
	public int updateImgPath(ItemVo vo) {
		return sqlSession.update("item.updateImgPath", vo);
	}

	@Override
	public int updateVo(ItemVo vo) {
		return sqlSession.update("item.updateVo", vo);
	}

	@Override
	public int updateDetailVo(ItemVo vo) {
		return sqlSession.update("item.updateDetailVo", vo);
	}

	@Override
	public int updateCategory(ItemVo vo) {
		return sqlSession.update("item.updateCategory", vo);
	}

	@Override
	public int deleteVo(Integer seq) {
		return sqlSession.delete("item.deleteVo", seq);
	}

	@Override
	public int updateStatusCode(ItemVo vo) {
		return sqlSession.update("item.updateStatusCode", vo);
	}

	@Override
	public int insertLogVo(ItemLogVo vo) {
		return sqlSession.insert("item.insertLogVo", vo);
	}

	@Override
	public List<ItemLogVo> getLogList(ItemLogVo vo) {
		return sqlSession.selectList("item.getLogList", vo);
	}

	@Override
	public Integer getLogListTotalCount(ItemLogVo vo) {
		return sqlSession.selectOne("item.getLogListTotalCount", vo);
	}

	@Override
	public List<ItemVo> getListForBest(ItemVo vo) {
		return sqlSession.selectList("item.getListForBest", vo);
	}

	@Override
	public int getItemCnt(Integer itemSeq) {
		return ((Integer) sqlSession.selectOne("item.getItemCnt", itemSeq)).intValue();
	}

	@Override
	public Integer getItemRegCntForWeek(MemberVo memberVo) {
		return sqlSession.selectOne("item.getItemRegCntForWeek", memberVo);
	}

	@Override
	public Integer getItemSellerSeq(Integer seq) {
		return sqlSession.selectOne("item.getItemSellerSeq", seq);
	}

	@Override
	public Integer getItemMasterSeq(Integer seq) {
		return sqlSession.selectOne("item.getItemMasterSeq", seq);
	}

	@Override
	public List<ItemVo> getTypeInfoList() {
		return sqlSession.selectList("item.getTypeInfoList");
	}

	@Override
	public List<ItemInfoNoticeVo> getPropList(Integer typeCd) {
		return sqlSession.selectList("item.getPropList", typeCd);
	}

	@Override
	public HashMap<String, String> getInfo(Integer seq) {
		return sqlSession.selectOne("item.getInfo", seq);
	}

	@Override
	public int insertInfo(ItemInfoNoticeVo vo) {
		return sqlSession.insert("item.insertInfo", vo);
	}

	@Override
	public int updateInfo(ItemInfoNoticeVo vo) {
		return sqlSession.update("item.updateInfo", vo);
	}

	@Override
	public int deleteInfo(Integer seq) {
		return sqlSession.delete("item.deleteInfo", seq);
	}

	@Override
	public int updateTypeCd(ItemInfoNoticeVo vo) {
		return sqlSession.update("item.updateTypeCd", vo);
	}

	@Override
	public List<FilterVo> getFilterList() {
		return sqlSession.selectList("item.getFilterList");
	}

	@Override
	public int deleteFilter(Integer seq) {
		return sqlSession.delete("item.deleteFilter", seq);
	}

	@Override
	public int insertFilter(String word) {
		return sqlSession.insert("item.insertFilter", word);
	}

	@Override
	public List<ItemVo> getSoldOutList() {
		return sqlSession.selectList("item.getSoldOutList");
	}

	@Override
	public int batchUpdateVo(ItemVo vo) {
		return sqlSession.update("item.batchUpdateVo", vo);
	}

	@Override
	public int batchUpdateDetailVo(ItemVo vo) {
		return sqlSession.update("item.batchUpdateDetailVo", vo);
	}

	@Override
	public List<ItemVo> getListExcel(ItemVo vo) {
		return sqlSession.selectList("item.getListExcel", vo);
	}

	@Override
	public int deleteImgPath(ItemVo vo) {
		return sqlSession.update("item.deleteImgPath", vo);
	}

	@Override
	public int deleteDetailImgPath(ItemVo vo) {
		return sqlSession.update("item.deleteDetailImgPath", vo);
	}

	@Override
	public int deleteLogBatch() {
		return sqlSession.delete("item.deleteLogBatch");
	}

	@Override
	public List<ItemVo> getListForSelling(ItemVo vo) {
		return sqlSession.selectList("item.getListForSelling", vo);
	}
}
