/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.vo<br/>
 * <b>文件名：</b>OtherBalanceinfo.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-上午11:58:52<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <b>类描述：其他结算信息，用于结算界面显示的信息</b><br/>
 * <b>类名称：</b>OtherBalanceinfo<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class OtherBalanceinfo implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -4200086520127025225L;

	private BigDecimal balancemoney;// 回程结算金额
	private long returnpeople;// 回程人数
	private BigDecimal lateforfeit;// 晚点罚金
	private BigDecimal lostforfeit;// 脱班罚金
	private BigDecimal integralmoney;// 积分基金
	private BigDecimal lastlost;// 上次溢前款
	private BigDecimal lessmoney;// 保底差额
	private long lessnum;// 保底差额
	private long minpeople; // 保底人数
	private BigDecimal preupmoney;// 车辆预缴款
	private BigDecimal debit;//车辆违规罚款,暂扣金额
	private String sltId;   //脱班晚点罚金表的id
    public BigDecimal getPackfee() {
		return packfee;
	}

	public void setPackfee(BigDecimal packfee) {
		this.packfee = packfee;
	}

	private BigDecimal packfee;//
	private BigDecimal backmoney;//返还金额
	
	


	public BigDecimal getBackmoney() {
		return backmoney;
	}

	public void setBackmoney(BigDecimal backmoney) {
		this.backmoney = backmoney;
	}

	public BigDecimal getDebit() {
		return debit;
	}

	public void setDebit(BigDecimal debit) {
		this.debit = debit;
	}

	public BigDecimal getPreupmoney() {
		return preupmoney;
	}

	public void setPreupmoney(BigDecimal preupmoney) {
		this.preupmoney = preupmoney;
	}

	public BigDecimal getBalancemoney() {
		return balancemoney;
	}

	public void setBalancemoney(BigDecimal balancemoney) {
		this.balancemoney = balancemoney;
	}

	public BigDecimal getLateforfeit() {
		return lateforfeit;
	}

	public void setLateforfeit(BigDecimal lateforfeit) {
		this.lateforfeit = lateforfeit;
	}

	public BigDecimal getLostforfeit() {
		return lostforfeit;
	}

	public void setLostforfeit(BigDecimal lostforfeit) {
		this.lostforfeit = lostforfeit;
	}

	public BigDecimal getIntegralmoney() {
		return integralmoney;
	}

	public void setIntegralmoney(BigDecimal integralmoney) {
		this.integralmoney = integralmoney;
	}

	public BigDecimal getLastlost() {
		return lastlost;
	}

	public void setLastlost(BigDecimal lastlost) {
		this.lastlost = lastlost;
	}

	public long getReturnpeople() {
		return returnpeople;
	}

	public void setReturnpeople(long returnpeople) {
		this.returnpeople = returnpeople;
	}

	public BigDecimal getLessmoney() {
		return lessmoney;
	}

	public void setLessmoney(BigDecimal lessmoney) {
		this.lessmoney = lessmoney;
	}

	public long getMinpeople() {
		return minpeople;
	}

	public void setMinpeople(long minpeople) {
		this.minpeople = minpeople;
	}
	public long getLessnum() {
		return lessnum;
	}

	public void setLessnum(long lessnum) {
		this.lessnum = lessnum;
	}

	public String getSltId() {
		return sltId;
	}

	public void setSltId(String sltId) {
		this.sltId = sltId;
	}
}
