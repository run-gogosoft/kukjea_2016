package com.smpro.vo;

/**
 * Created by aubergine on 2017. 2. 28..
 */
public class MallAccessVo extends UserVo{

    private Integer userSeq;
    /**
     (A)이용, (N)거절,(R)요청, (H)보류, (X)미요청
     */
    private String accessStatus;

    /**
     * 사유
     */
    private String note;

    public void setNote(String note){this.note = note;}
    public String getNote(){return this.note;}

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

    @Override
    public String toString() {
        return "MallAccessVo [mallSeq="+mallSeq+", userSeq="+userSeq+", accessStatus="+accessStatus+", note="+note+"]";
    }
}
