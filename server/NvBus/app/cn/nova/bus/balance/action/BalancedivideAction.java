package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balancedivide;
import cn.nova.bus.balance.service.BalancedivideService;
import cn.nova.bus.balance.service.impl.BalancedivideServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <b>类描述：结算分层协议设置</b><br/>
 * <b>类名称：</b>BalancedivideAction<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class BalancedivideAction extends BaseAction{

	private List<Map<String, Object>> datamap;
	private Balancedivide balancedivide;
	private long balancedivideid;
	private BalancedivideService balancedivideService;

	// 查询
	public String qrybalancedivide() {
		try {
			balancedivideService = new BalancedivideServiceImpl();
			datamap = balancedivideService
					.qryBalancedivide(ServletPropertyFilterUtil
							.buildFromHttpRequest());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 保存
	public String saveBalancedivide() {
		Global global = CurrentUtil.getGlobal();
		try {
			balancedivideService = new BalancedivideServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedivide.getId() == 0) {
					markSuccess();
					setMsg("添加成功！");
					balancedivide.setCreateby(global.getUserinfo().getId());
					balancedivide.setUpdateby(global.getUserinfo().getId());
					balancedivide.setCreatetime(new Date());
					balancedivide.setUpdatetime(new Date());
				} else {
					markSuccess();
					setMsg("修改成功！");
					balancedivide.setUpdateby(global.getUserinfo().getId());
					balancedivide.setUpdatetime(new Date());
				}
				balancedivide = balancedivideService
						.saveBalancedivide(balancedivide);
				balancedivideid = balancedivide.getId();
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	public String delBalancedivide() {
		balancedivideService = new BalancedivideServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedivideService.deleteBalancedivide(balancedivide)){
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	
	public List<Map<String, Object>> getDatamap() {
		return datamap;
	}

	public void setDatamap(List<Map<String, Object>> datamap) {
		this.datamap = datamap;
	}

	public Balancedivide getBalancedivide() {
		return balancedivide;
	}

	public void setBalancedivide(Balancedivide balancedivide) {
		this.balancedivide = balancedivide;
	}

	public long getBalancedivideid() {
		return balancedivideid;
	}

	public void setBalancedivideid(long balancedivideid) {
		this.balancedivideid = balancedivideid;
	}
}
