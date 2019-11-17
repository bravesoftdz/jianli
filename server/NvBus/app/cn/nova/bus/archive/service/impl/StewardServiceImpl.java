package cn.nova.bus.archive.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.StewardDao;
import cn.nova.bus.archive.model.Driverworkexperience;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.archive.model.Stewardworkexperience;
import cn.nova.bus.archive.service.StewardService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class StewardServiceImpl implements StewardService {
	
	
	private IDAO<Steward> dao = new EntityManagerDaoSurport<Steward>();
	
	private IDAO<Stewardworkexperience> workdao = new EntityManagerDaoSurport<Stewardworkexperience>();
	
	private StewardDao stewardDao = new StewardDao();
	
	@Override
	public Steward saveSteward(Steward steward) throws ServiceException {
		
		if(steward.getId()!=0){
			if(stewardDao.isExistStward( steward.getIdcard(), null,null)!=0 && 
					stewardDao.isExistStward(steward.getIdcard(), null,null)!=steward.getId()){
				throw new ServiceException("0113");	
			}
			if(stewardDao.isExistStward(null,steward.getCardno(),null)!=0 &&
					stewardDao.isExistStward(null, steward.getCardno(),null)!=steward.getId()){
				throw new ServiceException("0114");	
			}
			if(stewardDao.isExistStward(null,null,steward.getCode())!=0 &&
					stewardDao.isExistStward(null,null,steward.getCode())!=steward.getId()){			
				throw new ServiceException("0033");				
			}
			Steward n = dao.get(Steward.class, steward.getId());
			n.setArchiveno(steward.getArchiveno());
			n.setBirthday(steward.getBirthday());
			n.setCardno(steward.getCardno());
			n.setCode(steward.getCode());
			n.setEducation(steward.getEducation());
			n.setFamilyaddress(steward.getFamilyaddress());
			n.setFamilyphone(steward.getFamilyphone());
			n.setGrade(steward.getGrade());
			n.setIdcard(steward.getIdcard());
			n.setIstemporary(steward.getIstemporary());
			n.setJianpin(steward.getJianpin());
			n.setMobilephone(steward.getMobilephone());
			n.setName(steward.getName());
			n.setPicture(steward.getPicture());
			n.setPoliticsstatus(steward.getPoliticsstatus());
			n.setQualificationenddate(steward.getQualificationenddate());
			n.setQualificationno(steward.getQualificationno());
			n.setQualificationstartdate(steward.getQualificationstartdate());
			n.setSalary(steward.getSalary());
			n.setSex(steward.getSex());
			n.setSubunit(steward.getSubunit());
			n.setUnitid(steward.getUnitid());
			n.setUpdateby(steward.getUpdateby());
			n.setUpdatetime(new Date());
			n.setVehicleid(steward.getVehicleid());
			n.setVehicleno(steward.getVehicleno());
			return dao.merge(n);
		}else{
			if(stewardDao.isExistStward( steward.getIdcard(), null,null)!=0 ){
				throw new ServiceException("0113");
			}
			if(stewardDao.isExistStward(null, steward.getCardno(),null)!=0){
				throw new ServiceException("0114");
			}
			if(stewardDao.isExistStward(null,null,steward.getCode())!=0){			
				throw new ServiceException("0033");				
			}
			return dao.merge(steward);
		}
	}

	@Override
	public Boolean delSteward(long stewarid) throws ServiceException{
		if (stewardDao.isExistVehicleSteward(stewarid)){
			throw new ServiceException("0272");
		}else{
			stewardDao.update("Stewardworkexperience", stewarid,false);
			stewardDao.update("Steward", stewarid,false);
			return true;
		}
	}

	@Override
	public Boolean delSteward(Steward steward) {
		return null;
	}

	@Override
	public List<Map<String, Object>> querySteward(
			List<PropertyFilter> propertyFilterList,String isfinger) {
		Object[] fileds = { Steward.class,"unitname","createname","updatename","isfinger"};// 初始化要查询的字段
		Object[] filedtypes = { Steward.class,String.class,String.class,String.class,Boolean.class};// 初始化要查询的字段 类型
	return ListUtil.listToMap(fileds, stewardDao.querySteward(propertyFilterList,isfinger),filedtypes);
	}
	

	public List<Map<String, Object>> findPicturebyId(List<PropertyFilter> propertyFilterList){
		Object[] fileds = {"id","picture"};
		Object[] filedtypes = {Long.class,String.class};
		return ListUtil.listToMap(fileds, stewardDao.findPicturebyId(propertyFilterList),filedtypes);
	}

	@Override
	public Page<Steward> findPage(Page<Steward> entrace, Map<Object, Object> map) {
		return null;
	}

	@Override
	public Steward findbyid(Long id) {
		return dao.get(Steward.class, id);
	}

	@Override
	public Stewardworkexperience saveworkexperience(Stewardworkexperience workexperience) {
		return workdao.merge(workexperience);
		
	}

	@Override
	public Boolean delworkexperience(long id) {
		return  stewardDao.update("Stewardworkexperience", id, true);
	}

	@Override
	public Boolean updworkexperience(Stewardworkexperience workexperience) {
		return null;
	}

	@Override
	public List<Map<String, Object>> queryWork(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Stewardworkexperience.class,"createname","updatename" };// 初始化要查询的字段
		Object[] filedtypes = { Stewardworkexperience.class,String.class,String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds, stewardDao.queryWork(propertyFilterList),filedtypes);
	}

	@Override
	public Page<Stewardworkexperience> findWorkPage(
			Page<Driverworkexperience> entrace, Map<Object, Object> map) {
		return null;
	}

	@Override
	public Driverworkexperience findWorkBid(Long id) {
		return null;
	}

	@Override
	public List<Map<String, Object>> queryStewardFinger() {
		Object[] fileds = { "id", "fingerstr","name" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				stewardDao.queryStewardFinger(), filedtypes);
	}
	
	@Override
	public List<Map<String, Object>> findStewardBystewardid(long stewardid) {
		Object[] fileds = { "id","name" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				stewardDao.queryStewardBystewardid(stewardid),filedtypes);
	}

	@Override
	public boolean saveStewardFinger(Steward steward) throws ServiceException {
		Steward dr=dao.get(Steward.class, steward.getId());
		if(dr.getFingerstr1()==null){
			dr.setFingerprint1(steward.getFingerprint1());
			dr.setFingerstr1(steward.getFingerstr1());
		}else if(dr.getFingerstr2()==null){
			dr.setFingerprint2(steward.getFingerprint1());
			dr.setFingerstr2(steward.getFingerstr1());
		}else{
			dr.setFingerprint3(steward.getFingerprint1());
			dr.setFingerstr3(steward.getFingerstr1());
		}
		dr.setUpdatetime(new Date());
		dao.merge(dr);	
		
		return true;
	}

	

}
