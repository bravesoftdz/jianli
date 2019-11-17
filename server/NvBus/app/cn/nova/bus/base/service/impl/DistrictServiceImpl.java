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

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.DistrictDao;
import cn.nova.bus.base.model.District;
import cn.nova.bus.base.service.DistrictService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class DistrictServiceImpl implements DistrictService {
	@SuppressWarnings("rawtypes")
	
	private DistrictDao dao = new DistrictDao<District>();

	@Override
	public District save(District district) throws ServiceException {
		if (district.getId() == 0) {
			district.setSynccode(null);
			if (getIdByCode(district.getCode(), null) > 0) {
				Long id = getIdByCode(district.getCode(), "0");
				if (id > 0) {
					getDistrict(district, id);
				} else {
					throw new ServiceException("0281");
				}
			}
			if (getIdByName(district.getName(), null) > 0) {
				Long id = getIdByName(district.getName(), "0");
				if (id > 0) {
					getDistrict(district, id);
				} else {
					throw new ServiceException("0282");
				}
			}
			if (getIdByFullname(district.getFullname(), null) > 0) {
				Long id = getIdByFullname(district.getFullname(), "0");
				if (id > 0) {
					getDistrict(district, id);
				} else {
					throw new ServiceException("0283");
				}
			}
		}
		return (District) dao.merge(district);
	}

	private void getDistrict(District district, Long id) {
		District dist = getById(id);
		district.setId(dist.getId());
		district.setCode(dist.getCode());
		district.setName(dist.getName());
		district.setFullname(dist.getFullname());
		district.setSynccode(dist.getSynccode());
	}

	private Long getIdByFullname(String fullname, String string) {
		return dao.getIdByFullname(fullname, string);
	}

	private Long getIdByName(String name, String string) {
		return dao.getIdByName(name, string);
	}

	private Long getIdByCode(String code, String string) {
		return dao.getIdByCode(code, string);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(District.class, id);
	}

	@Override
	public List<District> query() {
		return dao.query(District.class, null);
	}

	@Override
	public boolean delete(District district) {
		if (district != null) {
			return dao.del(district);
		}
		return false;
	}

	@Override
	public District getById(Long id) {
		return (District) dao.get(District.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { District.class, "username",
				"updatename" }, dao.query(propertyFilterList), new Object[] {
				District.class, String.class, String.class });
	}

	@Override
	public boolean isContainSta(Long id) {		
		return dao.isContainSta(id);
	}

}
