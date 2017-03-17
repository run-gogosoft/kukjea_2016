package com.smpro.service;

import com.smpro.util.exception.ImageIsNotAvailableException;
import com.smpro.util.exception.ImageSizeException;
import com.smpro.vo.MallAccessVo;
import com.smpro.vo.MallVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public interface MallAccessService {
    /** 해당 mallSeq 에 대한 접근 정보를 가져온다 **/
    public List<MallAccessVo> getList(MallAccessVo reqVo);

    /** 몰 접근 정보를 모두 가져온다 **/
    public List<MallAccessVo> getListSimple();

    /** 몰 접근 정보를 추가한다 **/
    public void insertVo(MallAccessVo vo);

    /** 몰 접근 정보를 수정한다 **/
    public void modVo(MallAccessVo vo);

    /** 몰 접근 정보를 가져온다. **/
    public List<MallAccessVo> getVo(Integer seq);
}
