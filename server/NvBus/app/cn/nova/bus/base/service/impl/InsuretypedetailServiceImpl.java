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

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.db.jpa.JPA;
import util.SystemException;
import util.UserTransaction;

import cn.nova.bus.base.dao.InsuretypedetailDao;
import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.base.service.InsuretypeService;
import cn.nova.bus.base.service.InsuretypedetailService;
import cn.nova.bus.exception.ServiceException;
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
public class InsuretypedetailServiceImpl implements InsuretypedetailService { 

	private InsuretypedetailDao dao = new InsuretypedetailDao();

	private UserTransaction usertransaction = new UserTransaction();
	private InsuretypeService insuretypeService;

	@Override
	public Insuretypedetail save(Insuretypedetail detail) throws ServiceException {
		insuretypeService = new InsuretypeServiceImpl();
		Insuretypedetail insdet = dao.isExist(detail.getInsuretype().getId(), detail.getCode(),"code");
		if (insdet!=null) {
			if(detail.getId() == 0 || detail.getId() != insdet.getId()){
				//该险种的产品编码已经存在！
				throw new ServiceException("0258");
			}
		}
		Insuretypedetail exitname = dao.isExist(detail.getInsuretype().getId(), detail.getName(),"name");
		if (exitname!=null) {
			if(detail.getId() == 0 || detail.getId() != exitname.getId()){
				//该险种的保险责任名称已经存在！
				throw new ServiceException("0259");
			}
		}
		
		if (detail.getId() == 0) {
			detail = (Insuretypedetail) dao.merge(detail);
		} else {
			Insuretypedetail typedetail = (Insuretypedetail) dao.get(
					Insuretypedetail.class, detail.getId());
			detail.setSynccode(typedetail.getSynccode());
			detail = (Insuretypedetail) dao.merge(detail);
		}
		Insuretype insuretype = insuretypeService.getById(detail
				.getInsuretype().getId());
		BigDecimal amount = getInsuremount(insuretype.getId());
		if(amount==null){
			insuretype.setMaxinsureamount(insuretype.getMaxinsureamount());
		}else{
			insuretype.setMaxinsureamount(amount);
		}
		
		insuretypeService.save(insuretype);
		return detail;
	}

	@Override
	public boolean delete(Insuretypedetail detail) {
		if (detail != null) {
			return dao.del(detail);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) throws ServiceException {
		insuretypeService = new InsuretypeServiceImpl();
		Insuretypedetail detail = getById(id);
		Insuretype insuretype = insuretypeService.getById(detail
				.getInsuretype().getId());
		BigDecimal amount = getInsuremount(insuretype.getId());
		insuretype
				.setMaxinsureamount(amount.subtract(detail.getInsureamount()));
		insuretypeService.save(insuretype);
		try {
			usertransaction.begin();
			boolean result = dao.delete(Insuretypedetail.class, id);
			usertransaction.commit();
			return result;
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		}
	}

	@Override
	public List<Insuretypedetail> query() {
		return dao.query(Insuretypedetail.class, null);
	}

	@Override
	public Insuretypedetail getById(Long id) {
		return (Insuretypedetail) dao.get(Insuretypedetail.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Insuretypedetail.class,
				"createname", "updatename", "typename" },
				dao.query(propertyFilterList), new Object[] {
						Insuretypedetail.class, String.class, String.class,
						String.class });
	}

	@Override
	public Long getInsuretypeid() {
		return dao.getInsuretypeid();
	}

	@Override
	public Long getId(Long id) {
		return dao.getId(id);
	}

	@Override
	public Insuretypedetail getInsuretypedetail(Insuretype insuretype) {
		insuretypeService = new InsuretypeServiceImpl();
		Insuretype type = null;
		Insuretypedetail insuretypedetail = new Insuretypedetail();
		Long id = getId(insuretype.getId());
		if (id > 0) {
			type = insuretypeService.getById(insuretype.getId());
			insuretypedetail.setId(id);
		} else {
			Long detailid = getInsuretypeid();
			type = insuretypeService.getById(detailid);
		}
		insuretypedetail.setCode(type.getCode());
		insuretypedetail.setName(type.getName());
		insuretypedetail.setDescription(type.getDescription());
		insuretypedetail.setInsureamount(type.getMaxinsureamount());
		insuretypedetail.setCreateby(insuretype.getCreateby());
		insuretypedetail
				.setCreatetime(new Timestamp(System.currentTimeMillis()));
		insuretypedetail.setUpdateby(insuretype.getUpdateby());
		insuretypedetail
				.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		insuretypedetail.setInsuretype(type);
		return insuretypedetail;
	}

	private BigDecimal getInsuremount(Long insuretypeid) {
		return dao.getMount(insuretypeid);
	}

	@Override
	public List<Insuretypedetail> getResult(Long insuretypeid) {
		return dao.getResult(insuretypeid);
	}
}
