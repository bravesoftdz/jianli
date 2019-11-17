package cn.nova.bus.base.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.PCticketentranecDao;
import cn.nova.bus.base.model.Pcticketentrance;
import cn.nova.bus.base.service.PCTicketentranceService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class PCTicketentranceServiceImpl implements PCTicketentranceService {

	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private IDAO<Pcticketentrance> entrancedao = new EntityManagerDaoSurport<Pcticketentrance>();
	
	private PCticketentranecDao dao = new PCticketentranecDao();

	@Override
	public Boolean savePcticketentrance(Pcticketentrance pcticketentrance,
			String ticketentranceids) throws ServiceException {
		Boolean isOK = false;
		String[] entranceid = ticketentranceids.split(",");
		// 判断指定机构和IP 是否已经保存有值，如果有，抛出错误，提示去修改，如果没有进行保存
		List<Pcticketentrance> isExist = dao.findPCentrance(
				pcticketentrance.getIp(), pcticketentrance.getOrgid(), 0);
		if (isExist != null && isExist.size() != 0) {
			throw new ServiceException("0043");
		} else {
			// 遍历售票点，逐个进行保存
			for (int i = 0; i < entranceid.length; i++) {
				Pcticketentrance entrance = new Pcticketentrance();
				long toAddid = Long.parseLong(entranceid[i]);
				List<Pcticketentrance> isExistentrance = dao.findPCentrance(
						pcticketentrance.getIp(), 0, toAddid);
				if (isExistentrance != null && isExistentrance.size() != 0) {
					throw new ServiceException("0043");
				}
				entrance.setTicketentranceid(toAddid);
				entrance.setUpdatetime(new Date());
				entrance.setIp(pcticketentrance.getIp());
				entrance.setOrgid(pcticketentrance.getOrgid());
				entrance.setCreateby(pcticketentrance.getCreateby());
				entrance.setUpdateby(pcticketentrance.getUpdateby());
				entrance.setCreatetime(new Date());
				isOK = dao.save(entrance);
			}
		}

		return isOK;
	}

	@Override
	public Boolean updatePcticketentrance(Pcticketentrance pcticketentrance,
			String ticketentranceids) {
		Boolean isupdate = false;
		String[] entranceid = ticketentranceids.split(","); // 所有新的检票口
		// 查找所有老的检票口。
		List<Pcticketentrance> oldentrances = dao.findPCentrance(
				pcticketentrance.getIp(), pcticketentrance.getOrgid(), 0);
		Long createby = oldentrances.get(0).getCreateby();
		Date createtime = oldentrances.get(0).getCreatetime();
		Long[] newid = new Long[entranceid.length]; // 用于把检票口id存到long类型的数组中,方便后面进行比较
		for (int i = 0; i < entranceid.length; i++) { // 循环遍历前端传过来的检票口信息
			Long toAddid = Long.parseLong(entranceid[i]); // 新检票口
			newid[i] = toAddid;
			List<Pcticketentrance> entranceExist = dao.findPCentrance(
					pcticketentrance.getIp(), pcticketentrance.getOrgid(),
					toAddid);
			if (entranceExist.size() == 0) {
				// 添加
				Pcticketentrance entrance = new Pcticketentrance();
				entrance.setTicketentranceid(toAddid);
				entrance.setUpdatetime(new Date());
				entrance.setIp(pcticketentrance.getIp());
				entrance.setOrgid(pcticketentrance.getOrgid());
				entrance.setCreateby(createby);
				entrance.setUpdateby(pcticketentrance.getUpdateby());
				entrance.setCreatetime(createtime);
				isupdate = dao.save(entrance);
			} else {
				// 修改
				pcticketentrance.setId(entranceExist.get(0).getId());
				pcticketentrance.setCreateby(createby);
				pcticketentrance.setCreatetime(createtime);
				pcticketentrance.setTicketentranceid(entranceExist.get(0)
						.getTicketentranceid());
				pcticketentrance.setUpdatetime(new Date());
				entrancedao.update(pcticketentrance);
			}
		}
		for (int j = 0; j < oldentrances.size(); j++) {
			long exist = oldentrances.get(j).getTicketentranceid();// 原来检票口
			Arrays.sort(newid); // 必须排序后，才能使用Arrays.binarySearch()
			int id = Arrays.binarySearch(newid, exist);
			if (id < 0) { // 小与0;该老的检票口（exist）不在要处理的新的检票口内，所以要删除该老的检票口
				dao.delpcticketentrance(pcticketentrance.getOrgid(),
						pcticketentrance.getIp(), exist);
			}
		}
		return true;
	}

	@Override
	public Boolean delpcticketentrance(long orgid, String ip) {
		return dao.delpcticketentrance(orgid, ip, 0);
	}

	@Override
	public List<Pcticketentrance> findPCentrance(String ip, long orgid,
			long entranceid) {
		return dao.findPCentrance(ip, orgid, entranceid);
	}

	@Override
	public List<Map<String, Object>> findPCTicketentrance(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "ip", "orgid", "orgname" },
				dao.query(propertyFilterList));
	}

	@Override
	public List<Map<String, Object>> findPCEntranceName(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "entrancename",
				"createtime", "createname", "updatename", "updatetime" },
				dao.findPCEntranceName(propertyFilterList));
	}

	@Override
	public List<Map<String, Object>> findTicketentrancename(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "name" },
				dao.findTicketentrancename(propertyFilterList), new Object[] {
						long.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryTicketentrance(String ip, String orgids) {
		/*String isctrol = parameterService.findParamValue(ParamterConst.Param_3011, orgid);
		if ("1".equals(isctrol)) {
			return ListUtil.listToMap(new Object[] { "id", "name", "code" },
					dao.qryTicketentrance(ip, orgid), new Object[] {
							long.class, String.class, String.class });
		} else {
			return ListUtil.listToMap(new Object[] { "id", "name", "code" },
					dao.qryTicketentrance(orgid), new Object[] { long.class,
							String.class, String.class });
		}*/
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				dao.qryTicketentrance(orgids), new Object[] { long.class,
						String.class, String.class });
	}

}
