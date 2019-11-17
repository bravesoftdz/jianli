package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Msgreadlog;

public interface MsgreadlogService {

	public List<Map<String,Object>> queryUpgradereadlog();
	
	public boolean savaMsgreadlog(Msgreadlog msgreadlog);
	
	public boolean isNeedReadMsg() ;
}
