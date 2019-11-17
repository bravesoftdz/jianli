package cn.nova.bus.archive.model.zzbmodel;

import java.io.Serializable;

/**
 * @Author: 仉~~
 * @Date: 2019-01-16 9:28
 * @Description:   返回参数封装
 */
public class ResponseForm implements Serializable {

    private static final long serialVersionUID = -5273804224775481057L;
    private RspHead rspHead;

    private RspBody rspBody;


    public RspHead getRspHead() {
        return rspHead;
    }

    public void setRspHead(RspHead rspHead) {
        this.rspHead = rspHead;
    }

    public RspBody getRspBody() {
        return rspBody;
    }

    public void setRspBody(RspBody rspBody) {
        this.rspBody = rspBody;
    }
}
