package cn.nova.bus.archive.model.zzbmodel;

import java.io.Serializable;

/**
 * @Author: 仉~~
 * @Date: 2019-01-16 9:28
 * @Description:  返回参数封装
 */
public class RspHead implements Serializable {

    private static final long serialVersionUID = -1654339294610648518L;
    private String version;
    private String retCode;
    private String retMsg;
    private String signMsg;

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getRetCode() {
        return retCode;
    }

    public void setRetCode(String retCode) {
        this.retCode = retCode;
    }

    public String getRetMsg() {
        return retMsg;
    }

    public void setRetMsg(String retMsg) {
        this.retMsg = retMsg;
    }

    public String getSignMsg() {
        return signMsg;
    }

    public void setSignMsg(String signMsg) {
        this.signMsg = signMsg;
    }
}
