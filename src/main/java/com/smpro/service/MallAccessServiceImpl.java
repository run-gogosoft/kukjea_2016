package com.smpro.service;

import com.smpro.dao.MallAccessDao;
import com.smpro.dao.MallDao;
import com.smpro.vo.MallAccessVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MallAccessServiceImpl implements MallAccessService{
    @Autowired
    private MallAccessDao mallAccessDao;

    @Override
    public List<MallAccessVo> getList(MallAccessVo reqVo) {
        return mallAccessDao.getList(reqVo);
    }

    @Override
    public List<MallAccessVo> getListSimple() {
        return mallAccessDao.getListSimple();
    }

    @Override
    public void insertVo(MallAccessVo vo) {
        mallAccessDao.insertVo(vo);
    }

    @Override
    public void modVo(MallAccessVo vo) {
        mallAccessDao.modVo(vo);
    }

    @Override
    public List<MallAccessVo> getVo(Integer seq) {
        return mallAccessDao.getVo(seq);
    }
}
