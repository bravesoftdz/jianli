package cn.nova.bus.system.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang.StringUtils;

import util.CurrentUtil;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.UserinfoDao;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Userrole;
import cn.nova.bus.system.model.UserrolePK;
import cn.nova.bus.system.model.Userticketoutlets;
import cn.nova.bus.system.service.UserService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class UserServiceImpl implements UserService {

	
	private UserinfoDao dao = new UserinfoDao();
	
	private IDAO idao = new EntityManagerDaoSurport();
	@Override
	public Userinfo save(Userinfo user) throws ServiceException {
		String roles = user.getRoles();
		if (user.getId() > 0) {
			if (user.getPassword() == null && "".equals(user)) {
				String password = dao.getPassword(user.getId());
				user.setPassword(password);
			}
			Long id = dao.getIdByCode(user.getCode());
			if (user.getId() != id) {
				if (dao.isExist(user.getCode())) {
					throw new ServiceException("0250");
				}
			}
			List<Userrole> userroles = dao.getUserRole(user.getId());
			for (Userrole userrole : userroles) {
				idao.delete(userrole);
			}
			dao.getEntityManager().flush();
		} else {
			if (dao.isExist(user.getCode())) {
				if (dao.isLocaldelete(user.getCode())) {
					Userinfo use = dao.getByCode(user.getCode());
					user.setId(use.getId());
					user.setIsactive(true);
					user.setIslock(false);
				} else {
					throw new ServiceException("0250");
				}
			}
		}
		user = (Userinfo) dao.merge(user);
		if (roles != null && StringUtils.isNotEmpty(roles)) {
			String[] role = roles.split(",");
			for (int i = 0; i < role.length; i++) {
				if (!"".equals(role[i])) {
					Userrole userrole = new Userrole();
					userrole.setCreateby(user.getCreateby());
					userrole.setCreatetime(new Date());
					UserrolePK idobject = new UserrolePK();
					idobject.setRoleid(new Long(role[i]));
					idobject.setUserid(user.getId());
					userrole.setId(idobject);
					idao.merge(userrole);
				}
			}
		}
		return user;
	}



	public List<Userinfo> findList() {
		List<Userinfo> list = dao.query(Userinfo.class, null);
		return list;
	}

	public Userinfo findById(Long id) {
		return (Userinfo) dao.get(Userinfo.class, id);
	}

	@Override
	public boolean delete(Long id) {
		// 先删中间表
		// userroleservice.delete(id);
		return dao.delete(Userinfo.class, id);

	}

	public List<Userinfo> find(Map<String, Object> map) {
		return dao.find(Userinfo.class, map);
	}

	@Override
	public List<Userinfo> findList(Map<String, Object> where) {
		List<Userinfo> list = dao.find(Userinfo.class, where);

		return list;
	}

	@Override
	public List<Map<String, Object>> query(Object[] filed, String sql) {

		return dao.query(filed, sql);
	}

	@Override
	public List<Map<String, Object>> query(Object[] fileds, String sql,
			Object[] filedtype) {
		return dao.query(fileds, sql, filedtype);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean checkPassword(String name, String password) {
		List list = dao.getResult(name, password);
		if (!list.isEmpty()) {
			return true;
		}
		return false;
	}

	@Override
	public boolean updatepass(Userinfo user) {
		return dao.update(user);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { 
				"id","cardno","code","createby","createtime","departmentid","email","idcard",
				 "islock","ismultipoint","name","orgid","password","phone","ticketdiscount",
				"updateby","updatetime","isactive", "orgname",
				"depname", "createname", "updatename","ticketoutlet","ticketoutletid" },
				dao.query(buildFromHttpRequest),
				new Object[] { 
			long.class, String.class, String.class, long.class, Date.class,		
			long.class, String.class, String.class, boolean.class, boolean.class,		
			String.class, long.class, String.class, String.class, 		
			BigDecimal.class, long.class, Date.class, boolean.class, 
			String.class, String.class, String.class, String.class,String.class,long.class });
	}
	
	@Override
	public List<Map<String, Object>> queryEntrypacker(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { Userinfo.class, "orgname",
				"depname", "createname", "updatename" },
				dao.queryEntrypacker(buildFromHttpRequest),
				new Object[] { Userinfo.class, String.class, String.class,
						String.class, String.class });
	}

	public IDAO getIdao() {
		return idao;
	}

	public void setIdao(IDAO idao) {
		this.idao = idao;
	}

	@Override
	public Userinfo findByCard(String cardno) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!cardno", cardno));		
		return (Userinfo) idao.uniqueResult(Userinfo.class, propertyFilters);
	}
	
	public boolean saveticketoutlet(Userinfo user, long ticketoutlet) {
		Userticketoutlets ut = new Userticketoutlets();
		Date now = new Date();
		List<Userticketoutlets> list = dao.getUserticketoutlets(user.getId());
		if (list != null && list.size()>0) {
			ut = list.get(0);
			ut.setTicketoutletsid(ticketoutlet);
			ut.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ut.setUpdatetime(now);
		} else {
			ut.setUserinfoid(user.getId());
			ut.setTicketoutletsid(ticketoutlet);
			ut.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ut.setCreatetime(now);
			ut.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ut.setUpdatetime(now);
		}
		idao.merge(ut);
		return true;
	}

}
