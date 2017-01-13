package com.smpro.dao;

import com.smpro.vo.GradeVo;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public interface GradeDao {
    public List<GradeVo> getList();
    public int getListCount(GradeVo vo);
}
