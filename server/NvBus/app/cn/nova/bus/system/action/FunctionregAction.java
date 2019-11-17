package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Functionreg;
import cn.nova.bus.system.service.FunctionregService;
import cn.nova.bus.system.service.impl.FunctionregServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 * 
 */
public class FunctionregAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private Functionreg functionreg;
	private FunctionregService functionregService;
	private List<Map<String, Object>> functionregmap;
	private String key;
	private Long functionregid;
	
	public String queryFunctionreg(){
		functionregService = new FunctionregServiceImpl();
		setFunctionregmap(functionregService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String saveFunctionreg() {
		setMsg("");
		functionregService = new FunctionregServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		getFunctionreg().setUpdateby(global.getUserinfo().getId());
		getFunctionreg().setUpdatetime(now);
		if(functionreg.getId()<=0){
			try {
				getFunctionreg().setCreateby(global.getUserinfo().getId());
				getFunctionreg().setCreatetime(now);
				functionreg = functionregService.add(getFunctionreg());
				markSuccess();
				setMsg("添加功能成功");
				setFunctionregid(functionreg.getId());
			} catch (ServiceException e) {
				markFailure();
				setMsg(e.getExceptionMessage());
			}
		}
		else{
			try {
				functionreg = functionregService.update(getFunctionreg());
				markSuccess();
				setMsg("修改功能成功");
				setFunctionregid(functionreg.getId());
			} catch (ServiceException e) {
				markFailure();
				setMsg(e.getExceptionMessage());
			}
		}
		return "json";
	}

	public String deleteFunctionreg() {
		setMsg("");
		try {
			functionregService = new FunctionregServiceImpl();
			if (functionregService.delete(getFunctionreg())){
				markSuccess();
				setMsg("删除功能成功");
			}
			else{
				setMsg("删除功能失败，未知原因");
			}
		} catch (ServiceException e) {
			markFailure();
			setMsg(e.getExceptionMessage());
		} catch (Exception e) {
			markFailure();
			setMsg(e.getMessage());
		}
		return "json";
	}
	/**
	 *  
	 * @return
	 */
	public String qryFuncInfo(){
		functionregService = new FunctionregServiceImpl();
		functionregmap=functionregService.qryFuncByKey(key);		
		return "json";
	}
	public void setFunctionreg(Functionreg functionreg) {
		this.functionreg = functionreg;
	}

	public Functionreg getFunctionreg() {
		return functionreg;
	}

	public void setFunctionregmap(List<Map<String, Object>> functionregmap) {
		this.functionregmap = functionregmap;
	}

	public List<Map<String, Object>> getFunctionregmap() {
		return functionregmap;
	}

	public void setFunctionregid(Long functionregid) {
		this.functionregid = functionregid;
	}

	public Long getFunctionregid() {
		return functionregid;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
}
