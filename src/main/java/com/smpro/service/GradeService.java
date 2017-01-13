package com.smpro.service;

import com.smpro.vo.GradeVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface GradeService {
    public List<GradeVo> getList(GradeVo vo);
    public int getListCount(GradeVo vo);
}
