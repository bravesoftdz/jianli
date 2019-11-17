/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.balance.action<br/>
 * <b>文件名：</b>VipcardturnoverAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-12-6 下午02:36:45<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Vipcardturnover;
import cn.nova.bus.balance.service.VipcardturnoverService;
import cn.nova.bus.balance.service.impl.VipcardturnoverServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipcardturnoverAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-12-6 下午02:36:45<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VipcardturnoverAction extends BaseAction{
	private VipcardturnoverService turnoverService;
	private List<Map<String, Object>> vipturnoverMap;
	private Vipcardturnover vipcardturnover;
	private Date startdate;
	private Date enddate;
	private Long userid;
	private Long id;
	private String moneydate;
	
	public String query() {
		try {
			turnoverService = new VipcardturnoverServiceImpl();
			setVipturnoverMap(turnoverService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询VIP应缴款
	 * 
	 * @return
	 */
	public String queryTurnover() {
		try {
			turnoverService = new VipcardturnoverServiceImpl();
			setVipturnoverMap(turnoverService.queryTurnover(startdate, enddate,
					userid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 根据缴款人ID，查询上次缴款的信息
	 * 
	 * @return
	 */
	public String queryVipturnover() {
		try {
			turnoverService = new VipcardturnoverServiceImpl();
			setVipturnoverMap(turnoverService.queryVipturnover(userid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveVipturnover() {
		Global global = CurrentUtil.getGlobal();
		try {
			turnoverService = new VipcardturnoverServiceImpl();
			if (vipcardturnover != null) {
				vipcardturnover = turnoverService.save(vipcardturnover, global, moneydate);
				markSuccess();
				setMsg("缴款成功");
				setId(vipcardturnover.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getVipturnoverMap() {
		return vipturnoverMap;
	}

	public void setVipturnoverMap(List<Map<String, Object>> vipturnoverMap) {
		this.vipturnoverMap = vipturnoverMap;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public Vipcardturnover getVipcardturnover() {
		return vipcardturnover;
	}

	public void setVipcardturnover(Vipcardturnover vipcardturnover) {
		this.vipcardturnover = vipcardturnover;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMoneydate() {
		return moneydate;
	}

	public void setMoneydate(String moneydate) {
		this.moneydate = moneydate;
	}

}
