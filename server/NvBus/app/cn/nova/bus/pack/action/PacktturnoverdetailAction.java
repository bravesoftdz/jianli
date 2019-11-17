package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.pack.service.PacktturnoverdetailService;
import cn.nova.bus.pack.service.impl.PacktturnoverdetailServiceImpl;
import cn.nova.bus.sale.model.Depositcash;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PacktturnoverdetailAction extends BaseAction{
	
	private List<Map<String, Object>> turnoverdetailMap;
	

	private PacktturnoverdetailService turnoverdetailService;

	/**
	 * 查询行包缴款明细
	 * @return
	 */
	public String query() {
		try {
			turnoverdetailService = new PacktturnoverdetailServiceImpl();
			setTurnoverdetailMap(turnoverdetailService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getTurnoverdetailMap() {
		return turnoverdetailMap;
	}

	public void setTurnoverdetailMap(List<Map<String, Object>> turnoverdetailMap) {
		this.turnoverdetailMap = turnoverdetailMap;
	}

	
	


//	public String save() {
//		Global global = CurrentUtil.getGlobal();
//		try {
//			turnoverdetailService = new TicketturnoverdetailServiceImpl();
//			if (ticketturnoverdetail != null) {
//				if (ticketturnoverdetail.getId() > 0) {
//					markSuccess();
//					setMsg("修改成功");
//				} else {
//					markSuccess();
//					setMsg("缴款成功");
//					ticketturnoverdetail.setCreateby(global.getUserinfo()
//							.getId());
//					ticketturnoverdetail.setCreatetime(new Date());
//				}
//				if (!turnoverdetailService.save(ticketturnoverdetail)) {
//					markSuccess();
//					setMsg("缴款失败");
//				}
//			}
//		} catch (Exception e) {
//			play.Logger.error(e.getMessage(), e);
//			setMsg("缴款异常 :" + e.getMessage());
//		}
//		return "json";
//	}
	

}
