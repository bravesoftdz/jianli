package cn.nova.bus.archive.model.zzbmodel;

import java.io.Serializable;

/**
 * @Author: 仉~~
 * @Date: 2019-01-15 19:32
 * @Description:  请求参数封装类
 */
public class ReqBody implements Serializable {


    private static final long serialVersionUID = 5180441694760276272L;
    private String mchId;

    public String getMchId() {
        return mchId;
    }

    public void setMchId(String mchId) {
        this.mchId = mchId;
    }
}
