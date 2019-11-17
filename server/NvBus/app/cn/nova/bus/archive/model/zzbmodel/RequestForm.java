package cn.nova.bus.archive.model.zzbmodel;

import java.io.Serializable;

/**
 * @Author: 仉~~
 * @Date: 2019-01-15 19:30
 * @Description:  用于调取中证宝接口，对参数的封装
 */
public class RequestForm implements Serializable {

    private static final long serialVersionUID = 5142323933212779302L;
    private ReqHead reqHead;

    private ReqBody reqBody;

    public ReqHead getReqHead() {
        return reqHead;
    }

    public void setReqHead(ReqHead reqHead) {
        this.reqHead = reqHead;
    }

    public ReqBody getReqBody() {
        return reqBody;
    }

    public void setReqBody(ReqBody reqBody) {
        this.reqBody = reqBody;
    }
}
