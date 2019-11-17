/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Schedulediscount;
import cn.nova.bus.base.service.CardissueService;
import cn.nova.bus.base.service.impl.CardissueServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class CardissueAction extends BaseAction{

	private Cardissue cardissue;
	private Vip vip;
	private Long id;
	private List<Map<String, Object>> cardmap;
	private List<Schedulediscount> cardlist;
	private String cardno;
	private BigDecimal money;
	private Long activityid;
	private BigDecimal amount;
	private BigDecimal balancemoney;

	private CardissueService cardissueService;

	public String query() {
		try {
			cardissueService = new CardissueServiceImpl();
			setCardmap(cardissueService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (cardissue != null) {
				if (cardissue.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					cardissue.setUpdateby(global.getUserinfo().getId());
					cardissue.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					cardissue.setStatus("0");
					cardissue.setIssueby(global.getUserinfo().getId());
					cardissue.setIssueip(global.getIpAddress());
					cardissue.setIssueorgid(global.getOrganization().getId());
					cardissue.setIssuetime(new Timestamp(System
							.currentTimeMillis()));
					cardissue.setTicketoutletsid(global.getTicketoutlets()
							.getId());
					cardissue.setCreateby(global.getUserinfo().getId());
					cardissue.setUpdateby(global.getUserinfo().getId());
					cardissue.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					cardissue.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					BigDecimal big = new BigDecimal(0);
					vip.setMoney(big);
					vip.setVipamount(big);
				}
				cardissue = cardissueService.save(cardissue,
						global.getIpAddress(), vip);
				setId(cardissue.getId());
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	public String cancel() {
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (cardissue != null) {
				Cardissue card = null;
				if (cardissue.getId() > 0) {
					card = cardissueService.getById(cardissue.getId());
					card.setStatus("2");
					card.setUpdateby(global.getUserinfo().getId());
					card.setUpdatetime(new Date());
					setMsg("操作成功！");
					markSuccess();
				} else {
					setMsg("请选择一条记录！");
					markSuccess();
					return "json";
				}
				card = cardissueService.save(card, global.getIpAddress(), vip);
				setId(card.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("退卡异常：" + e.getMessage());
		}
		return "json";
	}

	public String logout() {// 注销
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (cardissue != null) {
				Cardissue card = null;
				if (cardissue.getId() > 0) {
					card = cardissueService.getById(cardissue.getId());
					vip.setStatus(card.getStatus());
					card.setStatus("3");
					card.setUpdateby(global.getUserinfo().getId());
					card.setUpdatetime(new Date());
					setMsg("操作成功！");
					markSuccess();
				} else {
					setMsg("请选择一条记录！");
					markSuccess();
					return "json";
				}
				card = cardissueService.save(card, global.getIpAddress(), vip);
				setId(card.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("注销异常：" + e.getMessage());
		}
		return "json";
	}

	public String recover() {
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (cardissue != null) {
				Cardissue card = null;
				if (cardissue.getId() > 0) {
					card = cardissueService.getById(cardissue.getId());
					card.setUpdateby(global.getUserinfo().getId());
					card.setUpdatetime(new Date());
					card.setStatus("0");
					setMsg("恢复成功！");
					markSuccess();
				} else {
					setMsg("请选择一条记录！");
					markSuccess();
					return "json";
				}
				card = cardissueService.save(card, global.getIpAddress(), vip);
				setId(card.getId());
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("恢复异常：" + e.getMessage());
		}
		return "json";
	}

	public String returncardissue() {
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (cardissue != null) {
				Cardissue card = null;
				if (cardissue.getId() > 0) {
					card = cardissueService.getById(cardissue.getId());
					card.setUpdateby(global.getUserinfo().getId());
					card.setUpdatetime(new Date());
					card.setStatus("1");
					setMsg("退卡成功！");
					markSuccess();
				} else {
					setMsg("请选择一条记录！");
					markSuccess();
					return "json";
				}
				card = cardissueService.save(card, global.getIpAddress(), vip);
				setId(card.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("退卡异常：" + e.getMessage());
		}
		return "json";
	}

	public String replaceCardissue() {// 挂失补卡
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (cardissue != null) {
				if (cardissue.getId() == 0) {
					msg = "挂失补卡成功！";
					markSuccess();
					cardissue.setStatus("0");
					cardissue.setIssueby(global.getUserinfo().getId());
					cardissue.setIssueip(global.getIpAddress());
					cardissue.setIssueorgid(global.getOrganization().getId());
					cardissue.setIssuetime(new Timestamp(System
							.currentTimeMillis()));
					cardissue.setTicketoutletsid(global.getTicketoutlets()
							.getId());
					cardissue.setCreateby(global.getUserinfo().getId());
					cardissue.setUpdateby(global.getUserinfo().getId());
					cardissue.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					cardissue.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				cardissue = cardissueService.replaceCard(cardissue,
						global.getIpAddress(), vip);
				setId(cardissue.getId());
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public String recharge() {// VIP充值
		Global global = CurrentUtil.getGlobal();
		try {
			cardissueService = new CardissueServiceImpl();
			if (money != null && cardno != null) {
				cardissue = cardissueService.saveCardRecharge(cardno, money,
						activityid, global, balancemoney, amount);
				if (cardissue.getId() > 0) {
					markSuccess();
					setMsg("卡号：" + cardissue.getCardno() + " 已成功充值 " + money
							+ " 元");
					setId(cardissue.getId());
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 激活卡有效期
	 * @return
	 */
	public String cardActive() {
		try {
			cardissueService = new CardissueServiceImpl();
			Cardissue c = cardissueService.cardActive(cardissue);
			if(c!=null){
				setId(c.getId());
				markSuccess();
				setMsg("有效期激活成功！");
			}else{
				setMsg("激活失败");
				markSuccess();
			}			
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
		}		
		return "json";
	}

	public Cardissue getCardissue() {
		return cardissue;
	}

	public void setCardissue(Cardissue cardissue) {
		this.cardissue = cardissue;
	}

	public List<Map<String, Object>> getCardmap() {
		return cardmap;
	}

	public void setCardmap(List<Map<String, Object>> cardmap) {
		this.cardmap = cardmap;
	}

	public List<Schedulediscount> getCardlist() {
		return cardlist;
	}

	public void setCardlist(List<Schedulediscount> cardlist) {
		this.cardlist = cardlist;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setVip(Vip vip) {
		this.vip = vip;
	}

	public Vip getVip() {
		return vip;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public Long getActivityid() {
		return activityid;
	}

	public void setActivityid(Long activityid) {
		this.activityid = activityid;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getBalancemoney() {
		return balancemoney;
	}

	public void setBalancemoney(BigDecimal balancemoney) {
		this.balancemoney = balancemoney;
	}

}
