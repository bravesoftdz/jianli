package cn.nova.bus.archive.model.zzbmodel;

import java.io.Serializable;

/**
 * @Author: 仉~~
 * @Date: 2019-01-16 9:31
 * @Description:   返回的用户信息
 */
public class UserList implements Serializable {
    private static final long serialVersionUID = -6172986011249466962L;

    private String memberId;   //	会员id
    private String headimgUrl;   //	APP用户头像
    private String liveimgUrl;   //	活体头像
    private String cardimgUrl;   //	身份证照片
    private String realName;   //	真实姓名
    private String identityCard;   //	身份证号
    private String  mobile;   //	手机号码
    private String address;   //	籍贯
    private String nation;   //	民族
    private String issue;   //	签发机关
    private String integral;   //	剩余积分
    private String validityBegin;   //	身份证有效开始时间
    private String validityEnd;   //	身份证有效结束时间
    private int isTestPeople;   //	是否内部人员：1是0否
    private int isAuthentication;   //	是否已认证：1是0否
    private int isSetPaymentPassword;   //	是否已设置支付密码：1是0否
    private String mobileMact;   //	手机MAC
    private int status;   //	状态：0-不可用 1-可用',
    private int sex;   //	性别：1男，2女，3未知'

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getHeadimgUrl() {
        return headimgUrl;
    }

    public void setHeadimgUrl(String headimgUrl) {
        this.headimgUrl = headimgUrl;
    }

    public String getLiveimgUrl() {
        return liveimgUrl;
    }

    public void setLiveimgUrl(String liveimgUrl) {
        this.liveimgUrl = liveimgUrl;
    }

    public String getCardimgUrl() {
        return cardimgUrl;
    }

    public void setCardimgUrl(String cardimgUrl) {
        this.cardimgUrl = cardimgUrl;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getIdentityCard() {
        return identityCard;
    }

    public void setIdentityCard(String identityCard) {
        this.identityCard = identityCard;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }

    public String getIntegral() {
        return integral;
    }

    public void setIntegral(String integral) {
        this.integral = integral;
    }

    public String getValidityBegin() {
        return validityBegin;
    }

    public void setValidityBegin(String validityBegin) {
        this.validityBegin = validityBegin;
    }

    public String getValidityEnd() {
        return validityEnd;
    }

    public void setValidityEnd(String validityEnd) {
        this.validityEnd = validityEnd;
    }

    public int getIsTestPeople() {
        return isTestPeople;
    }

    public void setIsTestPeople(int isTestPeople) {
        this.isTestPeople = isTestPeople;
    }

    public int getIsAuthentication() {
        return isAuthentication;
    }

    public void setIsAuthentication(int isAuthentication) {
        this.isAuthentication = isAuthentication;
    }

    public int getIsSetPaymentPassword() {
        return isSetPaymentPassword;
    }

    public void setIsSetPaymentPassword(int isSetPaymentPassword) {
        this.isSetPaymentPassword = isSetPaymentPassword;
    }

    public String getMobileMact() {
        return mobileMact;
    }

    public void setMobileMact(String mobileMact) {
        this.mobileMact = mobileMact;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    @Override
    public String toString() {
        return "UserList{" +
                "memberId='" + memberId + '\'' +
                ", headimgUrl='" + headimgUrl + '\'' +
                ", liveimgUrl='" + liveimgUrl + '\'' +
                ", cardimgUrl='" + cardimgUrl + '\'' +
                ", realName='" + realName + '\'' +
                ", identityCard='" + identityCard + '\'' +
                ", mobile='" + mobile + '\'' +
                ", address='" + address + '\'' +
                ", nation='" + nation + '\'' +
                ", issue='" + issue + '\'' +
                ", integral='" + integral + '\'' +
                ", validityBegin='" + validityBegin + '\'' +
                ", validityEnd='" + validityEnd + '\'' +
                ", isTestPeople=" + isTestPeople +
                ", isAuthentication=" + isAuthentication +
                ", isSetPaymentPassword=" + isSetPaymentPassword +
                ", mobileMact=" + mobileMact +
                ", status=" + status +
                ", sex=" + sex +
                '}';
    }
}
