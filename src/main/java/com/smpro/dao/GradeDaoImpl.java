package com.smpro.dao;

import com.smpro.vo.GradeVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GradeDaoImpl {
    @Autowired
    private SqlSession sqlSession;

    public List<GradeVo> getList(GradeVo vo){return sqlSession.selectList("grade.getList", vo);}
    public int getListCount(GradeVo vo){return ((Integer)sqlSession.selectOne("grade.getListCount", vo)).intValue();}
}
