package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Parameterorgdetail;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 参数管理接口
 * @author hhz
 *
 */
public interface ParameterService {
	
	

	public Parameterorgdetail addParameterOrgDetail(
			Parameterorgdetail paramd,String ip,String sessionid) throws ServiceException;
	
	/**
	 * 查找参数表和机构参数明细表
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList,String orgids);
	
	/**
	 * 根据参数编码机构 ，查询参数值
	 * @param code 参数编码
	 * @param orgid 机构ID（ 可以为空）
	 * @return
	 */
	public String findParamValue(String code,Long orgid);
	
	/**
	 * 根据参数编码机构 ，查询参数值
	 * @param code 参数编码
	 * @param orgid 机构ID（ 可以为空）
	 * @return
	 */
	public  List<Map<String, Object>> findParamsValue(String codes,Long orgid);
	

	/**
	 * 根据参数编码机构 ，查询参数值
	 * @param code 参数编码
	 * @param departstationid 发车站 （ 可以为空）
	 * @return
	 */
	public String findParamByStation(String code,Long departstationid);
	
}
