package cn.nova.bus.system.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.dao.MsgreadlogDao;
import cn.nova.bus.system.model.Msgreadlog;
import cn.nova.bus.system.service.MsgreadlogService;
import cn.nova.utils.orm.jpa.ListUtil;


/**
 * <b>类描述：信息阅读记录</b><br/>
 * <b>类名称：</b>MsgreadlogServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-5-08  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class MsgreadlogServiceImpl implements MsgreadlogService{


	private MsgreadlogDao dao = new MsgreadlogDao();
	
	/**
	 * 查询最后一条需要提醒的升级日志
	 */
	@Override
	public List<Map<String, Object>> queryUpgradereadlog() {	
		return ListUtil.listToMap(new Object[] { 
				"msgtypename","id","upgradecontext","upgradetime","version"},
				dao.queryUpgradelogMsg(),
			new Object[] {String.class,Long.class,String.class,Timestamp.class,String.class});		
	}
	
	
	/**
	 * 判断是否需要弹窗提示升级日志
	 */
	@Override
	public boolean isNeedReadMsg() {		
		List<Map<String, Object>> readmsg = 
			ListUtil.listToMap(new Object[] {"upgid","readid"},
					dao.isReadMsg(),new Object[] {Long.class,Long.class});
		if(readmsg!=null && readmsg.size()!=0){
			Map<String,Object> result=readmsg.get(0);			
			Object updid=0l;
			Object readid=0l;
			updid = result.get("upgid");
			readid = result.get("readid");			
			if(updid != null && (readid == null ||readid.equals(""))){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}		
	}		

	
	
	@Override
	public boolean savaMsgreadlog(Msgreadlog msgreadlog) {
		return dao.save(msgreadlog);
	}
		
}
