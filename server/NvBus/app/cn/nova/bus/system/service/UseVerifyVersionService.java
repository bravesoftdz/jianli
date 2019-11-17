package cn.nova.bus.system.service;

import java.util.Map;

import play.Play;
import util.RpcUtil;
import cn.nova.bus.common.NvBusVerifyConst;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;

/**
 *正式版、测试版本兼容
 */
public interface UseVerifyVersionService {
	/**
	 * 查询是否启用测试版
	 */
	public String qryVerifyInfos();
	
	/**
	 * 查询系统测试版NvBusVerify配置信息
	 */
	public Map<String, String> qryVerifySettingInfos();
}
