package cn.nova.bus.check.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.check.dao.SecuritycheckplanDao;
import cn.nova.bus.check.model.Securitycheckplan;
import cn.nova.bus.check.service.SecuritycheckplanService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SecuritycheckplanServiceImpl implements SecuritycheckplanService {

	
	private SecuritycheckplanDao dao = new SecuritycheckplanDao();

	@Override
	public Securitycheckplan save(Securitycheckplan security)
			throws ServiceException {
		if (security.getId() == 0) {
			if (isExist(security.getVehicleid(), security.getStartdate(),
					security.getEnddate(), security.getPeriodtype())) {
				throw new ServiceException("0256");
			}
			return (Securitycheckplan) dao.merge(security);
		} else {
			return (Securitycheckplan) dao.merge(security);
		}
	}

	private boolean isExist(long vehicleid, Date startdate, Date enddate,
			String type) {
		return dao.isExist(vehicleid, startdate, enddate, type);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Securitycheckplan.class, id);
	}

	@Override
	public List<Securitycheckplan> query() {
		return dao.query(Securitycheckplan.class, null);
	}

	@Override
	public boolean delete(Securitycheckplan security) {
		if (security != null) {
			return dao.del(security);
		}
		return false;
	}

	@Override
	public Securitycheckplan getById(Long id) {
		return (Securitycheckplan) dao.get(Securitycheckplan.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(
				new Object[] { Securitycheckplan.class, "vehicleno",
						"unitname", "modelid", "unitid", "nextcheckdate" },
				dao.query(propertyFilterList), new Object[] {
						Securitycheckplan.class, String.class, String.class,
						String.class, Long.class, Date.class });
	}

	@Override
	public long getByVehicleId(long vehicleid) {
		Securitycheckplan security = dao.getcheckplan(vehicleid);
		if (security != null) {
			return security.getVehicleid();
		}
		return (long) 0;
	}

	@Override
	public Securitycheckplan getcheckplan(Long vehicleid) {
		return dao.getcheckplan(vehicleid);
	}

	@Override
	public boolean hasCheckplan(Long vehicleid) throws ServiceException {
		if (dao.getcheckplanList(vehicleid) != null) {
			return true;
		} else {
			throw new ServiceException("0254");
		}
	}

}
