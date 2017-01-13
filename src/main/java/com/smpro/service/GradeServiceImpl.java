package com.smpro.service;


import com.smpro.dao.GradeDaoImpl;
import com.smpro.vo.GradeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GradeServiceImpl implements GradeService {
    @Autowired
    private GradeDaoImpl gradeDao;

    @Override
    public List<GradeVo> getList(GradeVo vo) {
        return gradeDao.getList(vo);
    }

    @Override
    public int getListCount(GradeVo vo) {
        return gradeDao.getListCount(vo);
    }
}
