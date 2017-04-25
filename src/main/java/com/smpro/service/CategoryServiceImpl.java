package com.smpro.service;

import com.smpro.dao.CategoryDao;
import com.smpro.dao.MallDao;
import com.smpro.vo.CategoryVo;
import com.smpro.vo.ItemVo;
import com.smpro.vo.MallVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	private CategoryDao categoryDao;

	@Autowired
	private MallDao mallDao;

	@Override
	public List<CategoryVo> getList(CategoryVo vo) {
		return categoryDao.getList(vo);
	}

	@Override
	public List<CategoryVo> getListSimple(CategoryVo vo) {
		return categoryDao.getListSimple(vo);
	}

	@Override
	public List<CategoryVo> getListForSearch(ItemVo vo) {
		return categoryDao.getListForSearch(vo);
	}

	@Override
	public CategoryVo getVo(Integer seq) {
		return categoryDao.getVo(seq);
	}

	@Override
	public CategoryVo getVoByName(Map name) { return categoryDao.getVoByName(name);}

	@Override
	public boolean insertVo(CategoryVo vo) {
		return categoryDao.insertVo(vo) > 0;
	}

	@Override
	public boolean updateVo(CategoryVo vo) {
		return categoryDao.updateVo(vo) > 0;
	}

	@Override
	public boolean updateOrderNo(CategoryVo vo) {
		return categoryDao.updateOrderNo(vo) > 0;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean deleteVo(Integer seq) throws Exception {
		/** 문제없이 잘 실행되나 매우 지저분해 보이는 로직이므로 리펙토링이 필요하다. (김찬호) */
		// 삭제하려는 카테고리의 자식이 있나 확인한다.
		CategoryVo vo = new CategoryVo();
		vo.setParentSeq(seq);
		List<CategoryVo> secondList = getList(vo);
		try {
			// 중분류(소분류) 카테고리가 존재한다면
			if (secondList.size() > 0) {
				int secondResultCnt = 0;
				for (int i = 0; i < secondList.size(); i++) {
					// 만약 중분류 카테고리라면 소분류 카테고리도 존재할 수 있기때문에 중분류 카테고리를 삭제하기 전에 소분류
					// 카테고리도 검색한다.
					vo.setParentSeq(secondList.get(i).getSeq());
					List<CategoryVo> thirdList = getList(vo);
					// 소분류 카테고리가 존재한다면 먼저 삭제한다.
					if (thirdList.size() > 0) {
						int thirdResultCnt = 0;
						for (int j = 0; j < thirdList.size(); j++) {
							thirdResultCnt += categoryDao.deleteVo(thirdList
									.get(j).getSeq());
						}
						if (thirdResultCnt != thirdList.size()) {
							throw new Exception();
						}
					}
					// 소분류 카테고리를 모두 삭제했다면 중분류 카테고리를 삭제한다.
					secondResultCnt += categoryDao.deleteVo(secondList.get(i)
							.getSeq());
				}
				if (secondResultCnt != secondList.size()) {
					throw new Exception();
				}
			}
			// 중분류와 소분류를 모두 삭제했다면(존재했다면) 대분류를 삭제한다.
			if (categoryDao.deleteVo(seq) <= 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			// 중요 : 익셉션을 반드시 던져야지 롤백된다.
			throw e;
		}

		return true;
	}

	@Override
	public String getFirstDepthSeq(CategoryVo vo) {
		return categoryDao.getFirstDepthSeq(vo);
	}

	/**
	 * 카테고리의 json 파일을 생성한다
	 * 
	 * @param targetPath
	 *            생성할 js 파일의 목적지
	 * @throws Exception
	 */
	@Override
	public void createJs(String targetPath) throws Exception {
		// 먼저 파일을 없앤다
		new File(targetPath).delete();

		OutputStreamWriter ou = new OutputStreamWriter(new FileOutputStream(
				targetPath), "utf-8");
		BufferedWriter out = new BufferedWriter(ou);
		List<MallVo> mallVos = mallDao.getListSimple();
		for(MallVo mall:mallVos){
			out.write(makeString(mall.getSeq()));
		}
		out.close();
		ou.close();
	}

	@Override
	public Integer getLv1Value(Integer seq) {
		return categoryDao.getLv1Value(seq);
	}

	@Override
	public Integer getLv2Value(Integer seq) {
		return categoryDao.getLv2Value(seq);
	}


	/**
	 * 모든 카테고리를 순회하면서 json 형태의 string을 반환한다
	 */
	private String makeString(int mallSeq) {
		StringBuffer sb = new StringBuffer();

		sb.append("/* Generated json : Date ").append(new Date()).append("  */ ");
		String varStr = "var menuJson_"+mallSeq;
		sb.append(varStr + " = [");
		CategoryVo vo = new CategoryVo();
		vo.setDepth(1);
		vo.setMallId(mallSeq);
		vo.setShowFlag("Y");
		List<CategoryVo> list = getList(vo);
		for (int i = 0; i < list.size(); i++) {
			if (i != 0) {
				sb.append(",");
			}
			sb.append("{");
			sb.append("seq:'").append(list.get(i).getSeq()).append("'");
			sb.append(", categoryName:'").append(list.get(i).getName())
					.append("'");

			vo.setDepth(2);
			vo.setParentSeq(list.get(i).getSeq());
			list.get(i).setList(getList(vo));

			sb.append(", lv2List:[");
			for (int j = 0; j < list.get(i).getList().size(); j++) {
				if (j != 0) {
					sb.append(",");
				}
				sb.append("{");
				sb.append("seq:'")
						.append(list.get(i).getList().get(j).getSeq())
						.append("'");
				sb.append(", categoryName:'")
						.append(list.get(i).getList().get(j).getName())
						.append("'");

				vo.setDepth(3);
				vo.setParentSeq(list.get(i).getList().get(j).getSeq());
				list.get(i).getList().get(j).setList(getList(vo));

				sb.append(", lv3List:[");
				for (int k = 0; k < list.get(i).getList().get(j).getList()
						.size(); k++) {
					if (k != 0) {
						sb.append(",");
					}
					sb.append("{");
					sb.append("seq:'")
							.append(list.get(i).getList().get(j).getList()
									.get(k).getSeq()).append("'");
					sb.append(", categoryName:'")
							.append(list.get(i).getList().get(j).getList()
									.get(k).getName()).append("'");

					vo.setDepth(4);
					vo.setParentSeq(list.get(i).getList().get(j).getList()
							.get(k).getSeq());
					list.get(i).getList().get(j).getList().get(k)
							.setList(getList(vo));

					sb.append(", lv4List:[");
					for (int n = 0; n < list.get(i).getList().get(j).getList()
							.get(k).getList().size(); n++) {
						if (n != 0) {
							sb.append(",");
						}
						sb.append("{");
						sb.append("seq:'")
								.append(list.get(i).getList().get(j).getList()
										.get(k).getList().get(n).getSeq())
								.append("'");
						sb.append(", categoryName:'")
								.append(list.get(i).getList().get(j).getList()
										.get(k).getList().get(n).getName())
								.append("'");
						sb.append("}");
					}
					sb.append("]"); // 4단계
					sb.append("}"); // 3단계
				}
				sb.append("]"); // 3단계
				sb.append("}"); // 2단계
			}
			sb.append("]"); // 2단계
			sb.append("}"); // 1단계
		}
		sb.append("];");
		return sb.toString();
	}
}
