package com.zcx.crm.vo;

import java.util.List;

public class PaginationVO<T> {  //视图对象，方便返回值的封装

    private int total;
    private List<T> dataList;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }
}
