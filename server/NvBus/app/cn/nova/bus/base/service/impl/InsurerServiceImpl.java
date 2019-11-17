/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.InsurerDao;
import cn.nova.bus.base.model.Insurers;
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.base.service.InsurerService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class InsurerServiceImpl implements InsurerService {

	private InsurerDao dao = new InsurerDao();

	@Override
	public Insurers save(Insurers insurer, String ip) throws ServiceException {
		if (insurer.getId() == 0) {
			if (dao.isExistName(insurer.getOrgid(), insurer.getName())) {
				throw new ServiceException("0257");
			}
			String result = "保险公司名称：" + insurer.getName() + "添加成功。";
			saveOperationlog(insurer, ip, result, "添加");
		} else {
			Insurers insur = (Insurers) dao.get(Insurers.class, insurer.getId());
			insurer.setSynccode(insur.getSynccode());
			String result = "保险公司名称由：" + insur.getName() + "改为" + insurer.getName();
			saveOperationlog(insurer, ip, result,"修改");
		}
		
		return (Insurers) dao.merge(insurer);
	}

	private void saveOperationlog(Insurers insurer, String ip, String result, String operation) {
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		operationLog.setContent(result);
		operationLog.setModule("业务管理->保险公司");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation(operation);
		operationLog.setSessionid("无session");
		operationLog.setUserid(insurer.getUpdateby());
		dao.merge(operationLog);
	}

	@Override
	public boolean delete(Insurers insurer) {
		if (insurer != null) {
			return dao.del(insurer);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id, String ip) throws ServiceException {
		List<Insuretypedetail> listdetail = dao.getInsuretype(id);
		if (!listdetail.isEmpty()) {
			throw new ServiceException("0262");
		}
		Insurers insurers = (Insurers) dao.get(Insurers.class, id);
		String result = "保险公司：" + insurers.getName() + "删除成功。";
		saveOperationlog(insurers, ip, result, "删除");
		return dao.delete(Insurers.class, id);
	}

	@Override
	public List<Insurers> query() {
		return dao.query(Insurers.class, null);
	}

	@Override
	public Insurers getById(Long id) {
		return (Insurers) dao.get(Insurers.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] {"Id", "orgid", "Name", "address", "contactperson", "contactphone"
											, "createtime", "createby", "updatetime", "updateby", "synccode"
											, "interfacetype", "selladdress", "returnaddress", "bankcode"
											, "createname",	"orgname", "updatename","interfacetypename" }
				, dao.query(propertyFilterList),
				new Object[] {Long.class, Long.class, String.class, String.class, String.class, String.class
						, Timestamp.class, Long.class, Timestamp.class, Long.class, String.class
						, String.class, String.class, String.class, String.class
						,String.class, String.class,String.class,String.class });
	}

}
