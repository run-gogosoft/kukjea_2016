package com.smpro.vo;

/**
 * Created by aubergine on 2017. 2. 28..
 */
public class MallAccessVo extends UserVo{

    private Integer userSeq;
    /**
     * R : 요청
     * NR : 미요청
     * A : 이용중
     * NA : 거절
     * H : 보류
     */
    private String accessStatus;

    public void setMallSeq(int mallSeq){
        this.mallSeq = mallSeq;
    }

   public Integer getUserSeq(){
       return this.userSeq;
   }

    public void setUserSeq(Integer userSeq) {
        this.userSeq = userSeq;
    }

    public String getAccessStatus(){
        return this.accessStatus;
    }

    public void setAccessStatus(String accessStatus){
        this.accessStatus = accessStatus;
    }
}
