package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Parameter;
import cn.nova.bus.system.model.Parameterorgdetail;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 参数管理
 * @author hhz
 *
 */
public class ParameterAction extends BaseAction{

	ParameterService parameterservice;
	//添加的参数
	private Parameter param;
	private Parameterorgdetail paramorgdetail;

	private List<Parameter> paramterlist;
	//返回结果
	private List<Map<String,Object>>  paramlistmap;
	private List<Map<String,Object>>  valuelistmap;
	//查询条件
	private String code;
	private String type;
	private String isvisible;
	private long orgid;
	private String parametervalue;
	private String orgids;
	private long detailid;
	
	private Map<String,String> paramtersvalue;
	
	public Map<String, String> getParamtersvalue() {
		return paramtersvalue;
	}

	public void setParamtersvalue(Map<String, String> paramtersvalue) {
		this.paramtersvalue = paramtersvalue;
	}

	public List<Parameter> getParamterlist() {
		return paramterlist;
	}

	public void setParamterlist(List<Parameter> paramterlist) {
		this.paramterlist = paramterlist;
	}

	/**
	 * 添加和修改参数
	 * @return
	 */
	public String saveParameterDetail(){
		if(paramorgdetail!=null){
			Global global = CurrentUtil.getGlobal();

			paramorgdetail.setCreateby(global.getUserinfo().getId());
			paramorgdetail.setCreatetime(new Date());
			paramorgdetail.setUpdateby(global.getUserinfo().getId());
			paramorgdetail.setUpdatetime(new Date());
			
			try{
				parameterservice = new ParameterServiceImpl();
				Parameterorgdetail p =parameterservice.addParameterOrgDetail(
						paramorgdetail,global.getIpAddress(),global.getSessionID());
				if(p!=null){
					detailid =  p.getId();
					msg = "修改成功!";
					markSuccess();
				}else {			
					msg = "修改失败!";
					markFailure();
				}
			}catch(ServiceException ex){
				setMsg("修改失败;"+ex.getExceptionMessage());
				markFail();
			}
		}
			return "json";
	}
	
	/**
	 * 根据实体类查找参数对象
	 * @return
	 */
	public String findParameter(){
		try {
			parameterservice = new ParameterServiceImpl();
			setParamlistmap(parameterservice.query(ServletPropertyFilterUtil.buildFromHttpRequest(),orgids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 根据机构id 参数编码 查找参数值
	 * @return
	 */
	public String findParameterValue(){
    	try {
    		parameterservice = new ParameterServiceImpl();
    		setParametervalue(parameterservice.findParamValue(code, orgid));
    	}catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
    	return "json";
	}
	
	public String findParametersValue(){
		try{
			parameterservice = new ParameterServiceImpl();
			setParamlistmap(parameterservice.findParamsValue(code, orgid));
		}catch(Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public Parameter getParam() {
		return param;
	}

	public void setParam(Parameter param) {
		this.param = param;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIsvisible() {
		return isvisible;
	}

	public void setIsvisible(String isvisible) {
		this.isvisible = isvisible;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getParametervalue() {
		return parametervalue;
	}

	public void setParametervalue(String parametervalue) {
		this.parametervalue = parametervalue;
	}

	public List<Map<String, Object>> getParamlistmap() {
		return paramlistmap;
	}

	public void setParamlistmap(List<Map<String, Object>> paramlistmap) {
		this.paramlistmap = paramlistmap;
	}

	public List<Map<String, Object>> getValuelistmap() {
		return valuelistmap;
	}

	public void setValuelistmap(List<Map<String, Object>> valuelistmap) {
		this.valuelistmap = valuelistmap;
	}

	public Parameterorgdetail getParamorgdetail() {
		return paramorgdetail;
	}

	public void setParamorgdetail(Parameterorgdetail paramorgdetail) {
		this.paramorgdetail = paramorgdetail;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public String getOrgids() {
		return orgids;
	}

	public long getDetailid() {
		return detailid;
	}

	public void setDetailid(long detailid) {
		this.detailid = detailid;
	}
	
}
