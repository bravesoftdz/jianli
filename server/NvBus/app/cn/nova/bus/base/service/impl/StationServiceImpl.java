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

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import util.CurrentUtil;

import cn.nova.bus.base.dao.StationDao;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Stationstandard;
import cn.nova.bus.base.model.Ticketoutletsctr;
import cn.nova.bus.base.service.StationService;
import cn.nova.bus.encrypt.MD5;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
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
public class StationServiceImpl implements StationService {

	private StationDao dao = new StationDao();

	@Override
	public Station save(Station station) throws ServiceException{
		if (station.getId() == 0) {//操作码是否存在只对新增时候进行操作，修改时候不做判断，modify by liyi 20150330
			station = generateCode(station);
			if(station.getHelpcode()==null||station.getHelpcode().equals("")){
				station.setHelpcode(station.getCode().substring(6,station.getCode().length()));
			}
			
			/*if(qryStationhelpcode(station)){
				//该操作码已经存在，请重新输入！
				throw new ServiceException("0460");
			}*/
			
		} else {
			//Station st = findById(station.getId());
			// 如果更改了行政区划，需要重新生成唯一索引 code
			/*if (!st.getDistrictid().equals(station.getDistrictid())) {
				station = generateCode(station);
			}*/
			if(station.getHelpcode()==null||station.getHelpcode().equals("")){
				station.setHelpcode(station.getCode().substring(6,station.getCode().length()));
			}
			/*Station s = (Station) dao.get(Station.class,station.getId());
			s.setDistrictid(station.getDistrictid());
			s.setDescription(station.getDescription());
			s.setGrade(station.getGrade());
			s.setJianpin(station.getJianpin());
			s.setSecondname(station.getSecondname());
			s.setDistance(station.getDistance());
			s.setHelpcode(station.getHelpcode());
			s.setIsdepart(station.getIsdepart());
			s.setIsroundtrip(station.getIsroundtrip());
			station = s;
			dao.update(station);
			return station;*/
		}
		//关联站点与标准站点
		/*if(station.getStationstandard()!=null && station.getStationstandard().getId()>0){
			Stationstandard ss = (Stationstandard) dao.get(Stationstandard.class, station.getStationstandard().getId());
			if(ss!=null){
				station.setStationstandard(ss);
			}
		}*/
		
		return (Station) dao.merge(station);
	}

	@Override
	public Station findById(Long id) {
		return (Station) dao.get(Station.class, id);
	}

	public boolean delete(Long id) {
		return dao.delete(Station.class, id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List query(String sql) {
		return dao.find(sql);
	}

	@Override
	public List<Map<String, Object>> query(Object[] filed, String sql) {
		return dao.query(filed, sql);
	}

	@Override
	public List<Station> findList(Map<String, Object> where) {
		List<Station> list = dao.find(Station.class, where);
		return list;
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "code",
				"name", "jianpin", "helpcode", "description", "isdepart",
				"grade", "orgid", "isactive", "islocaldelete", "createtime",
				"createby", "updatetime", "updateby", "secondname", "synccode",
				"isroundtrip", "distance", "districtname", "createname",
				"dicgrade", "districtid", "updatename", "stationname",
				"stationaddress", "standardCode", "standradName", "province",
				"city", "area", "standradid" }, dao.query(propertyFilterList),
				new Object[] { Long.class,String.class,
						String.class, String.class, String.class, String.class,
						boolean.class, String.class, Long.class, boolean.class,
						boolean.class, Date.class, String.class, Date.class,
						String.class, String.class, String.class,
						boolean.class, String.class, String.class,
						String.class, String.class, Long.class, String.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						Long.class });
	}

	@Override
	public boolean isUnique(String name, String code) {
		return dao.isUnique(name, code);
	}

	/**
	 * generateCode方法：为station插入实际主键。<br/>
	 * 
	 * @param station
	 *            待插入实际主键的station的对象
	 * @return 插入实际主键后的station对象
	 */
	protected Station generateCode(Station station) {
		String tempstr = getMaxcode(station);
		String district_code = getDistrictCode(station);
		String temp = findCode(district_code); 
		if (temp != null) {
			tempstr = temp;
		}
		if (tempstr == null) {
			station.setCode(district_code + "001");
		} else {
			Long count = new Long(tempstr.toString());
			count++;
			station.setCode(count.toString());
		}
		return station;
	}
	private boolean qryStationhelpcode(Station st) {
		if(st.getId()==0){
			Query query = dao.getEntityManager().createQuery(
					"select t from Station t where t.helpcode='"+st.getHelpcode()+"'");
	        List<Station> sts= query.getResultList();
	        return sts!=null&&sts.size()>0?true:false;
		}else{
			Query query = dao.getEntityManager().createQuery(
					"select t from Station t where t.helpcode='"+st.getHelpcode()+"' and t.id!="+st.getId());
	        List<Station> sts= query.getResultList();
	        return sts!=null&&sts.size()>0?true:false;
		}
	}
	private String getDistrictCode(Station station) {
		Query query_district_code = dao.getEntityManager().createQuery(
				"select t.code from District t " + "where t.id="
						+ station.getDistrictid());
		String district_code = ((String) query_district_code
				.getSingleResult()).substring(0, 6);
		return district_code;
	}

	private String getMaxcode(Station station) {
		Query query_max_code = dao.getEntityManager().createQuery(
				"select max(t.code) as maxno from Station t where t.districtid="
						+ station.getDistrictid());
		if (query_max_code.getResultList().isEmpty()) {
			return null;
		} else {
			return (String) query_max_code.getSingleResult();
		}
	}

	private String findCode(String district_code) {
		return dao.isExistCode(district_code);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.base.service.StationService#hasApply(long)
	 * 判断该站点是否被组织机构使用
	 */
	@Override
	public boolean hasApplyOrganization(long id) throws ServiceException {
		if (dao.hasApplyOrganization(id)) {
			throw new ServiceException("0255");
		}
		return dao.hasApplyOrganization(id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.base.service.StationService#hasApply(long)
	 * 判断该站点是否被线路停靠点使用
	 */
	@Override
	public boolean hasApplyRoutestop(long id) throws ServiceException {
		if (dao.hasApplyRoutestop(id)) {
			throw new ServiceException("0255");
		}
		return dao.hasApplyRoutestop(id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.base.service.StationService#hasExist(java.lang.String)
	 * 判断该站点名与站点编码在isactive=0状态中是否存在,如果存在返回它对应的ID
	 */
	@Override
	public Long getId(String name) {
		return dao.getByName(name);
	}
	/**
	 * 添加标准站点
	 * @throws Exception 
	 */
	@Override
	public MethodResult dispose(List<List<String>> sheeplist) throws Exception {
		MethodResult result = new MethodResult(MethodResult.SUCCESS,"导入成功！",null);
		Date currentTime = new Date();
		boolean iiBreakpoint = false;
		Long userId = 1158013L;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		int line = 3;//行号
		//处理sheet页中的二维数组数据
		try {
			for (List<String> rowList : sheeplist) {
				//加密原始数据
				String check = "";
				//code码，用来判断是否应存在
				String code = "";
				String stationName = "";//站点名称
				String address = "";//详细地址
				Stationstandard standard = new Stationstandard();
				standard.setCreateby(userId);
				standard.setCreatetime(currentTime);
				standard.setUpdateby(userId);
				standard.setUpdatetime(currentTime);
				if(rowList.size()>8){//导入文件的列只允许是8列，若不符合规则则提示用户：“导入文件的列数超过系统规定的列数（8列）
					iiBreakpoint = true;
					result.setResultMsg("前"+(line-1)+"条数据导入成功,第"+line+"行数据有问题，导入文件的列数超过系统规定的列数（8列）！");
					break;
				}
				//处理每一行数据
				for (int i = 0; i < rowList.size()-1; i++) {
					if(StringUtils.isNotBlank(rowList.get(i))){
						switch (i){
						case 0:
							standard.setCode(rowList.get(i).trim());
							code = rowList.get(i).trim();
							check += rowList.get(i).trim();
							break;
						case 1:
							standard.setName(rowList.get(i).trim());
							stationName = rowList.get(i).trim();
							check += rowList.get(i).trim();
							break;
						case 2:
							standard.setProvince(rowList.get(i).trim());
							check += rowList.get(i).trim();
							break;
						case 3:
							standard.setCity(rowList.get(i).trim());
							check += rowList.get(i).trim();
							break;
						case 4:
							standard.setArea(rowList.get(i).trim());
							check += rowList.get(i);
							break;
						case 5:
							standard.setStationname(rowList.get(i).trim());
							check += rowList.get(i).trim();
							break;
						case 6:
							standard.setStationaddress(rowList.get(i).trim());
							address = rowList.get(i).trim();
							break;
						default:
							break;	
						}
					}
				}
				check += "BUS365!@#";
				if(code.length()> 12 || code.matches("\\d")){//导入文件的编码信息必须是9位数字，若不符合规则，则提示用户第N行导入的站点编码长度不对，如“前9条数据导入成功，第10行导入的站点编码长度超过系统规定（9个字符）的长度”，遇到不符合规则的行，则直接返回不再继续处理下面数据。
					result.setResultMsg("前"+(line-1)+"条数据导入成功,第"+line+"行导入的站点编码长度超过系统规定（12个字符的长度!");
					iiBreakpoint = true;
					break;
				}
				if(stationName.length()>50){//	导入的站点名称 必须是50个字符以内，若不符合规则，则提示用户第N行导入站点名称长度不对
					result.setResultMsg("前"+(line-1)+"条数据导入成功,第"+line+"行导入的站点名称长度超过系统规定（50个字符）的长度!");
					iiBreakpoint = true;
					break;
				}
				if(address.length()>200){//导入的站点详细地址必须是200个字符以内，若不符合规则，则提示用户第N行导入站点名称长度不对，如：“前9条数据导入成功，第10行导入的站点详细地址长度超过系统规定（200个字符）的长度”
					result.setResultMsg("前"+(line-1)+"条数据导入成功,第"+line+"行导入的站点详细地址长度超过系统规定（200个字符）的长度!");
					iiBreakpoint = true;
					break;
				}
				//验证excle数据是否被修改
				if(StringUtils.isNotBlank(check) &&
						new String(MD5.HEXAndMd5(check)).equals(rowList.get(rowList.size()-1))
						&& StringUtils.isNotBlank(code)){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!code",code));
					Stationstandard ss = (Stationstandard) dao.uniqueResult(LockModeType.PESSIMISTIC_WRITE,Stationstandard.class,propertyFilters);
					if(ss != null){//修改标准站点
						boolean isEdit = false;
						if(!ss.getCode().equals(standard.getCode())){
							isEdit = true;
							ss.setCode(standard.getCode());
						}
						if(!ss.getName().equals(standard.getName())){
							isEdit = true;
							ss.setName(standard.getName());
						}
						if(!ss.getProvince().equals(standard.getProvince())){
							isEdit = true;
							ss.setProvince(standard.getProvince());
						}
						if(!ss.getCity().equals(standard.getCity())){
							isEdit = true;
							ss.setCity(standard.getCity());
						}
						if(!ss.getArea().equals(standard.getArea())){
							isEdit = true;
							ss.setArea(standard.getArea());
						}
						if(!ss.getStationaddress().equals(standard.getStationaddress())){
							isEdit = true;
							ss.setStationaddress(standard.getStationaddress());
						}
						if(!ss.getStationname().equals(standard.getStationname())){
							isEdit = true;
							ss.setStationname(standard.getStationname());
						}
						if(isEdit){
							dao.update(ss);
						}
					}else{
						//新增标准站点信息
						dao.save(standard);
					}
				}else{
					result.setResultMsg("前"+(line-1)+"条数据导入成功,第"+line+"行导入的站点信息的MD5校验不通过!");
					iiBreakpoint = true;
					break;
				}
				line++;
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			throw e;
		}
		if(!iiBreakpoint){
			result.setResultMsg("数据导入成功，共"+sheeplist.size()+"条记录");
		}
		return result;
	}

}
