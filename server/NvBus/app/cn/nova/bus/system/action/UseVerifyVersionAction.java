package cn.nova.bus.system.action;

import play.Play;
import cn.nova.bus.common.NvBusVerifyConst;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.UseVerifyVersionService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.system.service.impl.UseVerifyVersionServiceImpl;

/**
 *兼容测试版本的相关处理 
 */
public class UseVerifyVersionAction {
	private String fileXML;
	
	/**
	 * 查询参数判断是否启用测试版本
	 * @return
	 */
	public String useVerifyFlag() {
		UseVerifyVersionService service = new UseVerifyVersionServiceImpl();
		fileXML = service.qryVerifyInfos();
		return "json";
	}
	

	public String getFileXML() {
		return fileXML;
	}

	public void setFileXML(String fileXML) {
		this.fileXML = fileXML;
	}
}
