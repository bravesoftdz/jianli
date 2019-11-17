package cn.nova.bus.system.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.system.dao.ParameterDao;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Parameter;
import cn.nova.bus.system.model.Parameterorgdetail;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 参数管理实现类
 * @author huanghaoze
 *
 */
public class ParameterServiceImpl implements ParameterService {
	
	
	private IDAO<Parameter> dao = new EntityManagerDaoSurport<Parameter>();
	
	private IDAO<Parameterorgdetail> pdao = new EntityManagerDaoSurport<Parameterorgdetail>();
	
	private IDAO<Organization> orgdao = new EntityManagerDaoSurport<Organization>();
	
	private ParameterDao paramdao = new ParameterDao();
	
	
	private OperationLogService operationLogService = new OperationLogServiceImpl();
	
	@Override
	public Parameterorgdetail addParameterOrgDetail(
			Parameterorgdetail paramd,String ip,String sessionid) throws ServiceException{
		List<Parameterorgdetail> isExte = paramdao.getDetail(paramd.getOrgid(), paramd.getParameterid());
		Parameterorgdetail result=null;
		String oldvalue = "";
		Parameter parameter = dao.get(Parameter.class, paramd.getParameterid());
		//如果存在相同的机构和参数ID，则存在参数明细表的主键ID ，进行修改
		if(isExte.size() != 0 ){
			oldvalue= pdao.get(Parameterorgdetail.class, paramd.getId()).getValue();
			result = pdao.merge(paramd);	
		}else{//如果不存在相同的，则进行添加
			Parameterorgdetail pd=new Parameterorgdetail();
			pd.setCreateby(paramd.getCreateby());
			pd.setCreatetime(paramd.getCreatetime());
			pd.setUpdateby(paramd.getUpdateby());
			pd.setUpdatetime(paramd.getUpdatetime());
			pd.setOrgid(paramd.getOrgid());
			pd.setParameterid(paramd.getParameterid());
			pd.setValue(paramd.getValue());			
			result = pdao.merge(pd);
			oldvalue = parameter.getValue();
		}
		//将修改的值覆盖进缓存
//		RedisUtil.set(RedisDBApp.parameter ,parameter.getCode()+paramd.getOrgid(), paramd.getValue(), 600);
		
		String orgname = orgdao.get(Organization.class, paramd.getOrgid()).getName();
			// 保存操作日志
			Operationlog operationLog = new Operationlog();
			operationLog.setIp(ip);
			String content="将"+orgname+"的参数（编码;"+parameter.getCode()+" 备注内容为;"+parameter.getRemark()+
							" ）的参数值"+oldvalue+",修改为"+paramd.getValue();
			operationLog.setContent(content);
			operationLog.setModule("参数设置");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("修改参数");
			operationLog.setSessionid(sessionid);
			operationLog.setUserid(paramd.getCreateby());
			operationLogService.savelog(operationLog);
		
		
		return	result;
	}
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList,String orgids){
		return ListUtil.listToMap(
//							 "updatetime","updatename","showvalue","orgname","orgids",
//							 "type","codes","unit","pid","did","iseditable","remark"
				new Object[]{"updatetime","updatename","showvalue","orgname","orgids",
						"type","code","unit","pid","did","iseditable","remark"},
				paramdao.queryParameter(propertyFilterList,orgids),
				new Object[]{Timestamp.class,String.class,String.class,String.class,Long.class,
					String.class,String.class,String.class,Long.class,Long.class,boolean.class,String.class,});
		
	}
	
	public List<Map<String, Object>> findParamsValue(String codes,Long orgid){
		List<Object> list = paramdao.findParamsValue(codes, orgid);
		if(list == null){
			return null;
		}
		Object[] fields = new Object[list.size()];
		Object[] values =  new Object[list.size()];
		Object[] types = new Object[list.size()];
		for (int i = 0; i < list.size(); i++) {
			Object[] reslut = (Object[]) list.get(i);
			fields[i] = reslut[0].toString();
			values[i] = reslut[1].toString();
			types[i] = String.class;
		}
		ArrayList<Object> reslutList = new ArrayList<Object>();
		reslutList.add(values);
		return ListUtil.listToMap(fields, reslutList, types);
	}
	
	public String findParamValue(String code, Long orgid){
		//优化 获取参数时，放入缓存,修改参数处已经覆盖
		/*String par = RedisUtil.get(RedisDBApp.parameter, code+orgid);
		if(par==null||"".equals(par)){
			par =  paramdao.findParamValue(code, orgid);
			RedisUtil.set(RedisDBApp.parameter ,code+orgid, par, 600);
		}*/
		return paramdao.findParamValue(code, orgid);
	}

	@Override
	public String findParamByStation(String code, Long departstationid) {
		return paramdao.findParamByStatoin(code, departstationid);
	}
}
