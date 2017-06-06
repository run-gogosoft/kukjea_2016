package com.smpro.vo;

/**
 * Created by aubergine on 2016. 10. 6..
 */
public class GradeVo {
    /** 등급명 **/
    private String name;
    /** 회원수 **/
    private int count;
    /** 할인율 **/
    private int salePercent;
    /** 적립율 **/
    private int pointPercent;
    /** 장랼슨사 **/
    private int sortOrder;
    /** 아이콘 **/
    private String iconPath;
    /** 등급조건 **/
    private long payCondition;

    public void setName(String name){this.name = name;}
    public String getName(){return this.name;}
    public void setCount(int count){this.count = count;}
    public int getCount(){return this.count;}
    public void setSalePercent(int salePercent){this.salePercent = salePercent;}
    public int getSalePercent(){return this.salePercent;}

    public void setPointPercent(int pointPercent){this.pointPercent = pointPercent;}
    public int getPointPercent(){return this.pointPercent;}
    public void setSortOrder(int sortOrder){this.sortOrder = sortOrder;}
    public int getSortOrder(){return this.sortOrder;}
    public void setIconPath(String iconPath){ this.iconPath = iconPath;}
    public String getIconPath(){return this.iconPath;}
    public void setPayCondition(long condition){this.payCondition = condition;}
    public long getPayCondition(){return this.payCondition;}

}
