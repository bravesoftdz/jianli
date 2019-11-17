/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.base.action<br/>
 * <b>文件名：</b>VipAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-12-11 下午04:44:45<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipcardreturn;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-12-11 下午04:44:45<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("serial")
public class VipAction extends BaseAction{

	private VipService vipService;
	private List<Map<String, Object>> vipMap;
	private Vip vip;
	private Vipcardreturn vipreturn;
	private Long id;

	public String queryVip() {
		try {
			vipService = new VipServiceImpl();
			setVipMap(vipService.getVipByCardno(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveVipreturn() {
		Global global = CurrentUtil.getGlobal();
		try {
			vipService = new VipServiceImpl();
			if (vipreturn != null) {
				id = vipService.saveVipreturn(vipreturn, global);
				if (id > 0) {
					markSuccess();
					setMsg("退卡成功");
				} else {
					markSuccess();
					setMsg("退卡失败");
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("退卡失败");
		}
		return "json";
	}

	/**
	 * VIP卡补卡后明细查询
	 * @return
	 */
	public String queryVipremainmoneytranfer() {
		try {
			vipService = new VipServiceImpl();
			setVipMap(vipService
					.queryVipremainmoneytransfer(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getVipMap() {
		return vipMap;
	}

	public void setVipMap(List<Map<String, Object>> vipMap) {
		this.vipMap = vipMap;
	}

	public Vip getVip() {
		return vip;
	}

	public void setVip(Vip vip) {
		this.vip = vip;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Vipcardreturn getVipreturn() {
		return vipreturn;
	}

	public void setVipreturn(Vipcardreturn vipreturn) {
		this.vipreturn = vipreturn;
	}

}
