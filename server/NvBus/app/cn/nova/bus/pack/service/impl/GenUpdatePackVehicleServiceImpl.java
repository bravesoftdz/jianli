package cn.nova.bus.pack.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.mapping.Array;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.GenUpdatePackVehicleDao;

import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.service.GenUpdatePackVehicleService;
import cn.nova.bus.price.service.GenScheduleplanService;

public class GenUpdatePackVehicleServiceImpl implements GenUpdatePackVehicleService{

	@Override
	public void GenUpdatePackVehicle() {
		GenUpdatePackVehicleDao dao = new GenUpdatePackVehicleDao();
//		Pack pack = new Pack();
		//查询报班车辆与行包车辆不一致的数据
		List<Object> packList= dao.qryReportPack();
		if (packList!=null && packList.size()>0 ){
			for (Object obj : packList) {
				Object[] arr = (Object[]) obj;
				//System.out.println("packid=" + arr[0].toString() + ",  vehicleid=" + arr[1].toString());
				Pack pack=(Pack) dao.get(Pack.class,Long.valueOf(arr[0].toString()));
				if (pack!=null && pack.getId()>0){
				pack.setVehicleid(Long.valueOf(arr[1].toString()));
				dao.save(pack);
				}
			}
		}
		
//		Pack pack = dao.getEntityManager().find(Pack.class, 31675126L);
//		pack.setVehicleid(31674086L);
//		dao.merge(pack);
	
	}
	
}
