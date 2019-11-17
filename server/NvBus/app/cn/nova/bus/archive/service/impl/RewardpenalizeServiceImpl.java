package cn.nova.bus.archive.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.RewardpenalizeDao;
import cn.nova.bus.archive.model.Driverrewardpenalize;
import cn.nova.bus.archive.model.Stewardrewardpenalize;
import cn.nova.bus.archive.service.RewardpenalizeService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class RewardpenalizeServiceImpl implements 
		RewardpenalizeService {

	
	private IDAO<Driverrewardpenalize> dao = new EntityManagerDaoSurport<Driverrewardpenalize>();
	
	private IDAO<Stewardrewardpenalize> stewardrpdao = new EntityManagerDaoSurport<Stewardrewardpenalize>();
	
	private RewardpenalizeDao RPdao = new RewardpenalizeDao();


	@Override
	public Driverrewardpenalize saveDriverrewardpenalize(
			Driverrewardpenalize driverrewardpenalize) {
		if(driverrewardpenalize.getDeductdistance()==null){
			driverrewardpenalize.setDeductdistance(0l);
		}
		if(driverrewardpenalize.getDeductscore()== null){
			driverrewardpenalize.setDeductscore(0l);
		}
		return dao.merge(driverrewardpenalize);
		
	}

	@Override
	public Boolean delDriverrewardpenalize(long id) {
		return RPdao.updateByid(id);
	}


	@Override
	public List<Map<String, Object>> queryDriverrewardpenalize(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Driverrewardpenalize.class,"drivername","createname","updatename"};// 初始化要查询的字段
		Object[] filedtypes = { Driverrewardpenalize.class,String.class,String.class,String.class};// 初始化要查询的字段 类型
	return ListUtil.listToMap(fileds,RPdao.queryDriverrewardpenalize(propertyFilterList),filedtypes);
	}
	
	@Override
	public List<Map<String, Object>> queryStewardrewardpenalize(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Stewardrewardpenalize.class,"stewardname","createname","updatename"};// 初始化要查询的字段
		Object[] filedtypes = { Stewardrewardpenalize.class,String.class,String.class,String.class};// 初始化要查询的字段 类型
	return ListUtil.listToMap(fileds,RPdao.queryStewardrewardpenalize(propertyFilterList),filedtypes);
	
	}
	
	@Override
	public Stewardrewardpenalize saveStewardrewardpenalize(
			Stewardrewardpenalize stewardrewardpenalize) {		
			return stewardrpdao.merge(stewardrewardpenalize);
		
	}

	@Override
	public Boolean delStewardrewardpenalize(long id) {
		return RPdao.uptStweardByid(id);
	}

	@Override
	public Boolean updStewardrewardpenalize(
			Stewardrewardpenalize stewardrewardpenalize) {
		return null;
	}

	@Override
	public Boolean updDriverrewardpenalize(
			Driverrewardpenalize driverrewardpenalize) {
		return null;
	}
	

	@Override
	public Page<Stewardrewardpenalize> findPage(
			Page<Stewardrewardpenalize> entrace, Map<Object, Object> map) {
		return null;
	}

	@Override
	public Stewardrewardpenalize findbyid(Long id) {
		return null;
	}


}
