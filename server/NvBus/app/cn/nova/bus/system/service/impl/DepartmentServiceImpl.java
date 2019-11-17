package cn.nova.bus.system.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.DepartmentDao;
import cn.nova.bus.system.model.Department;
import cn.nova.bus.system.service.DepartmentService;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("deprecation")
public class DepartmentServiceImpl implements DepartmentService {

	private IDAO<Department> dao = new EntityManagerDaoSurport<Department>();

	DepartmentDao deparmentdao = new DepartmentDao();

	@Override
	public boolean save(Department depart) throws ServiceException {
		if (depart.getId() == 0) {
			if (isExist(depart.getCode(), "code",depart.getParentid())) {
				throw new ServiceException("0110");
			}
			if (isExist(depart.getName(), "name",depart.getParentid())) {
				throw new ServiceException("0111");
			}
			return dao.save(depart);
		} else {
			if (!getById(depart.getId()).getCode().equals(depart.getCode())) {
				if (isExist(depart.getCode(), "code",depart.getParentid())) {
					throw new ServiceException("0110");
				}
			}
			if (!getById(depart.getId()).getName().equals(depart.getName())) {
				if (isExist(depart.getName(), "name",depart.getParentid())) {
					throw new ServiceException("0111");
				}
			}
			return dao.update(depart);
		}
	}

	private boolean isExist(String value, String key, Long parentId) {
		StringBuffer sql = new StringBuffer("select t from Department t ");
		if ("code".equals(key)) {
			sql.append("where t.code='");
			sql.append(value);
			sql.append("'");
		} else if ("name".equals(key)) {
			sql.append("where t.name='");
			sql.append(value);
			sql.append("'");
			sql.append(" and t.parentid='");
			sql.append(parentId);
			sql.append("'");
		}
		Query query = dao.getEntityManager().createQuery(sql.toString());
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public boolean delete(Department depart) {
		if (depart != null) {
			return dao.del(depart);
		}
		return false;
	}

	@Override
	public List<Map<String, Object>> query(long prentid) {
		return ListUtil.listToMap(new Object[] { "id", "code", "contactperson",
				"contactphone", "createby", "createtime", "describe", "name",
				"parentid", "supervisorid", "updateby", "updatetime",
				"orgname", "createname", "updatename", "supervisor" },
				deparmentdao.query(prentid),
				new Object[] { Long.class, String.class, String.class,
						String.class, Long.class, Timestamp.class,
						String.class, String.class, Long.class, Long.class,
						Long.class, Timestamp.class, String.class,
						String.class, String.class, String.class });
	}

	@Override
	public Department getById(Long id) {
		return dao.get(Department.class, id);
	}

	@Override
	public boolean delete(Long id) {
		if (id != null) {
			return dao.delete(Department.class, id);
		}
		return false;
	}

	public List<Department> query() {
		return dao.query(Department.class, null);
	}

	@Override
	public boolean qryUserByOrgId(Long departmentid,Long orgid) {
		if(departmentid != null){
			return deparmentdao.qryUserByOrgId(departmentid,orgid);
		}
		return false;
	}

}
