/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b> cn.nova.bus.system.action<br/>
 * <b>文件名：</b>UpgradelogAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-05-08<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Version;
import cn.nova.bus.system.service.UpgradelogService;
import cn.nova.bus.system.service.impl.UpgradelogServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：系统升级日志</b><br/>
 * <b>类名称：</b>UpgradelogAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-05-03 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class UpgradelogAction extends BaseAction {

	private UpgradelogService upgradelogservice;

	private List<Map<String, Object>> resultmap;

	private Long id;
	private List<Map<String, Object>> contextmap;
	private Version version;
	private List<Map<String, Object>> versionmap;

	/**
	 * 查询升级版本
	 * 
	 * @return
	 */
	public String qryversion() {
		upgradelogservice = new UpgradelogServiceImpl();
		try {
			setVersionmap( upgradelogservice.qryversion());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询系统升级日志表
	 * 
	 * @return
	 */
	public String QryUpgradelog() {
		upgradelogservice = new UpgradelogServiceImpl();
		setResultmap(upgradelogservice.QryUpgradelog(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		return "json";
	}

	/**
	 * 根据日志ID 获取升级日志内容
	 * 
	 * @return
	 */
	public String QryContext() {
		upgradelogservice = new UpgradelogServiceImpl();
		setContextmap(upgradelogservice.getContextbyid(id));
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public List<Map<String, Object>> getContextmap() {
		return contextmap;
	}

	public void setContextmap(List<Map<String, Object>> contextmap) {
		this.contextmap = contextmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Version getVersion() {
		return version;
	}

	public void setVersion(Version version) {
		this.version = version;
	}

	public List<Map<String, Object>> getVersionmap() {
		return versionmap;
	}

	public void setVersionmap(List<Map<String, Object>> versionmap) {
		this.versionmap = versionmap;
	}
}
