package com.smpro.dao;

import com.smpro.vo.MallAccessVo;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MallAccessDao {
    /** 해당 mallSeq 에 대한 접근 정보를 가져온다 **/
    public List<MallAccessVo> getList(MallAccessVo reqVo);

    /** 몰 접근 정보를 모두 가져온다 **/
    public List<MallAccessVo> getListSimple();

    /** 몰 접근 정보를 추가한다 **/
    public void insertVo(MallAccessVo vo);

    /** 몰 접근 정보를 수정한다 **/
    public void modVo(MallAccessVo vo);

    /** 해당 사용자의 몰 접근 정보를 가져온다. **/
    public List<MallAccessVo> getVo(Integer seq);
}
