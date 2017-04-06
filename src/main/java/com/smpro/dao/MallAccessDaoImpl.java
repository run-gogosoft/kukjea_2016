package com.smpro.dao;

import com.smpro.vo.MallAccessVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MallAccessDaoImpl implements MallAccessDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<MallAccessVo> getList(MallAccessVo reqVo) {
        return sqlSession.selectList("mall_access.getList", reqVo);
    }

    @Override
    public List<MallAccessVo> getListSimple() {
        return sqlSession.selectList("mall_access.getListSimple");
    }

    @Override
    public void insertVo(MallAccessVo vo) {
        sqlSession.insert("mall_access.insertVo", vo);
    }

    @Override
    public void modVo(MallAccessVo vo) {
        sqlSession.update("mall_access.modVo", vo);
    }

    @Override
    public List<MallAccessVo> getVo(Integer seq) {
        return sqlSession.selectList("mall_access.getVo", seq);
    }
}
