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

import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.base.dao.InsuretypeDao;
import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.base.service.InsuretypeService;
import cn.nova.bus.base.service.InsuretypedetailService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
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
public class InsuretypeServiceImpl implements InsuretypeService {

	private InsuretypeDao dao = new InsuretypeDao();

	private UserTransaction usertransaction = new UserTransaction();

	private InsuretypedetailService detailService;
	
	private ParameterService parameterService = new ParameterServiceImpl();

	@Override
	public Insuretype save(Insuretype insure) throws ServiceException {
		detailService = new InsuretypedetailServiceImpl();
		Insuretype inss = dao.isExistCode(insure.getOrgid(), insure.getCode());
		if (inss!=null) {
			if(insure.getId() == 0 || insure.getId() != inss.getId()){
				//相同的车站不能存在相同的产品编码！
				throw new ServiceException("0260");
			}
		}
		Insuretype existname =dao.isExistName(insure.getOrgid(), insure.getInsurersid(),
				insure.getName());
		if (existname!=null) {
			if(insure.getId() == 0 || insure.getId() != existname.getId()){
				//该车站已经存在相同的保险公司和产品名称！
				throw new ServiceException("0261");
			}
		}
		
		try {
			usertransaction.begin();
			if (insure.getId() == 0) {		
				insure = (Insuretype)dao.merge(insure);
				Insuretypedetail insuretypedetail = new Insuretypedetail();
				insuretypedetail.setCode(insure.getCode());
				insuretypedetail.setName(insure.getName());
				insuretypedetail.setDescription(insure.getDescription());
				insuretypedetail.setInsureamount(insure.getMaxinsureamount());
				insuretypedetail.setCreateby(insure.getCreateby());
				insuretypedetail.setCreatetime(new Timestamp(System
						.currentTimeMillis()));
				insuretypedetail.setUpdateby(insure.getUpdateby());
				insuretypedetail.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
				insuretypedetail.setInsuretype(insure);
				detailService.save(insuretypedetail);				
			} else {
				Insuretype type = (Insuretype) dao.get(Insuretype.class, insure.getId()); 
				insure.setSynccode(type.getSynccode());				
				insure = (Insuretype)dao.merge(insure);
				
			}
            usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			play.Logger.error(e.getMessage(), e);
		}
		
		return insure;
		
	}

	@Override
	public boolean delete(Insuretype insurer) {
		if (insurer != null) {
			return dao.del(insurer);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) throws ServiceException {
		detailService = new InsuretypedetailServiceImpl();
		List<Insuretypedetail> listdetail = detailService.getResult(id);
		if (!listdetail.isEmpty()) {
			throw new ServiceException("0123");
		}
		return dao.delete(Insuretype.class, id);
	}

	@Override
	public List<Insuretype> query() {
		return dao.query(Insuretype.class, null);
	}

	@Override
	public Insuretype getById(Long id) {
		return (Insuretype) dao.get(Insuretype.class, id);
	}

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList) {
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_2626,CurrentUtil.getGlobal().getOrganization().getId()))){
			return ListUtil.listToMap(new Object[] { "insurersid","MAXINSUREAMOUNT","premium",
					 "insurersname","id","name" },
					dao.queryPlatformInsure(),
					new Object[] { Long.class,BigDecimal.class,BigDecimal.class,
					String.class,Long.class,String.class }); 
		}else{
			List<Object> lst=dao.query(propertyFilterList);
			//System.out.println("lst="+lst.size());
			return ListUtil.listToMap(new Object[] { "id", "orgid", "insurersid",
					"code", "name", "premium", "maxinsureamount", "dividedrate",
					"description", "createtime", "createby", "updatetime",
					"updateby", "synccode", "ywmoney", "shmoney", "emoney",
					"emmoney", "createname", "orgname", "updatename",
					"insurersname", "fromdistance", "enddistance" ,"insurersbankcode" }, lst,
					new Object[] { long.class, long.class,long.class,  String.class,
							String.class, BigDecimal.class, BigDecimal.class,
							BigDecimal.class, String.class, Timestamp.class,
							long.class, Timestamp.class, long.class, String.class,
							BigDecimal.class, BigDecimal.class, BigDecimal.class,
							BigDecimal.class, String.class, String.class,
							String.class, String.class, long.class, long.class, String.class });
		}
		
	}

	@Override
	public List<Map<String, Object>> qryInsuretypeByDistance(Long distance) {
		return ListUtil.listToMap(new Object[]{"insuretypeid"},
				dao.qryInsuretypeByDistance(distance),
				new Object[]{String.class});
	}

	@Override
	public List<Map<String, Object>> qryInsuretypeByPrice(long fullprice) {
		return ListUtil.listToMap(new Object[]{"insuretypeid"}, 
					dao.qryInsuretypeByPrice(fullprice),
					new Object[]{String.class});
	}

	@Override
	public List<Map<String, Object>> qryInsuretype(long orgid) {
		return ListUtil.listToMap( 
				new Object[] { "id", "code", "name", "premium",
						"maxinsureamount", "compname", "fromamount", "endamount","insurersid","insuretypeid","emoney","emmoney" },
				dao.queryinsuretype(orgid), new Object[] { long.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, 
						BigDecimal.class, BigDecimal.class,long.class,long.class,BigDecimal.class, BigDecimal.class });
	}

}
