package cn.nova.bus.archive.model.zzbmodel;

import org.codehaus.jackson.annotate.JsonProperty;

import java.io.Serializable;

/**
 * @Author: 仉~~
 * @Date: 2019-01-15 19:31
 * @Description:  请求参数封装类
 */
public class ReqHead implements Serializable {

    private static final long serialVersionUID = 3214870905459812438L;
//    @JsonProperty("version")
    private String version;

//    @JsonProperty("sign")
    private String sign;

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }
}
