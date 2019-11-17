package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Functionpermissionreg;
import cn.nova.bus.system.service.FunctionpermissionregService;
import cn.nova.bus.system.service.impl.FunctionpermissionregServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 * 
 */
public class FunctionpermissionregAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private Functionpermissionreg functionpermissionreg;
	private FunctionpermissionregService functionpermissionregService;
	private List<Map<String, Object>> functionpermissionregmap;

	private Long functionpermissionregid;

	public String queryFunctionpermissionreg(){
		functionpermissionregService = new FunctionpermissionregServiceImpl();
		setFunctionpermissionregmap(functionpermissionregService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String saveFunctionpermissionreg() {
		setMsg("");
		functionpermissionregService = new FunctionpermissionregServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		getFunctionpermissionreg().setUpdateby(global.getUserinfo().getId());
		getFunctionpermissionreg().setUpdatetime(now);
		if(functionpermissionreg.getId()<=0){
			try {
				getFunctionpermissionreg().setCreateby(global.getUserinfo().getId());
				getFunctionpermissionreg().setCreatetime(now);
				functionpermissionreg = functionpermissionregService.add(getFunctionpermissionreg());
				markSuccess();
				setMsg("添加子功能成功");
				setFunctionpermissionregid(functionpermissionreg.getId());
			} catch (ServiceException e) {
				markFailure();
				setMsg(e.getExceptionMessage());
			}
		}
		else{
			try {
				functionpermissionreg = functionpermissionregService.update(getFunctionpermissionreg());
				markSuccess();
				setMsg("修改子功能成功");
				setFunctionpermissionregid(functionpermissionreg.getId());
			} catch (ServiceException e) {
				markFailure();
				setMsg(e.getExceptionMessage());
			}
		}
		return "json";
	}

	public String deleteFunctionpermissionreg() {
		setMsg("");
		try {
			functionpermissionregService = new FunctionpermissionregServiceImpl();
			if (functionpermissionregService.delete(getFunctionpermissionreg())){
				markSuccess();
				setMsg("删除子功能成功");
			}
			else{
				markFailure();
				setMsg("删除子功能失败，未知原因");
			}
		} catch (Exception e) {
			markFailure();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public void setFunctionpermissionreg(Functionpermissionreg functionpermissionreg) {
		this.functionpermissionreg = functionpermissionreg;
	}

	public Functionpermissionreg getFunctionpermissionreg() {
		return functionpermissionreg;
	}

	public void setFunctionpermissionregmap(List<Map<String, Object>> functionpermissionregmap) {
		this.functionpermissionregmap = functionpermissionregmap;
	}

	public List<Map<String, Object>> getFunctionpermissionregmap() {
		return functionpermissionregmap;
	}

	public void setFunctionpermissionregid(Long functionpermissionregid) {
		this.functionpermissionregid = functionpermissionregid;
	}

	public Long getFunctionpermissionregid() {
		return functionpermissionregid;
	}

}
