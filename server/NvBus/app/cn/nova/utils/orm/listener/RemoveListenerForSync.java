/**
 * <b>项目名：</b>NvDataSyncEJB<br/>
 * <b>包名：</b>cn.nova.datasync.listener<br/>
 * <b>文件名：</b>RemoveListenerForSync.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-11-29-下午07:29:39<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.utils.orm.listener;

import javax.naming.NamingException;
import javax.persistence.PreRemove;

import org.apache.commons.lang.reflect.MethodUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.SyncDeleteEntity;
import cn.nova.utils.business.EjbFinder;
import cn.nova.utils.business.EntityUtil;
import cn.nova.utils.business.NvSystemConfig;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * <b>类描述：</b>本类用于监听实体类的删除事件，并将被删除的实体的信息按规则保存到
 * {@link cn.nova.datasync.model.SyncDeleteEntity} 表，以便后续与其他站点、机构同步删除。<br/>
 * <b>类名称：</b>RemoveListenerForSync<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class RemoveListenerForSync {
  private static final Logger log=LoggerFactory.getLogger(RemoveListenerForSync.class);

  @SuppressWarnings("rawtypes")
  public IDAO getDao() throws NamingException {
    //return (IDAO) EjbFinder.getEJB(NvSystemConfig.getIDaoImpl(),false);
	  return new EntityManagerDaoSurport();
  }
  
  @SuppressWarnings("unchecked")
  @PreRemove
  public void recordToDeleteTablePostDelete(Object entity) throws Exception{
    try {
      SyncDeleteEntity syncdeleteentity=new SyncDeleteEntity(
          entity.getClass()
          ,(Long) EntityUtil.readPrimaryKey(entity)
          ,(String)MethodUtils.invokeExactMethod(entity, "getSynccode", null)
          ,(Long) EntityUtil.readOrgid(entity)
      );
      
      getDao().merge(syncdeleteentity);
    } catch (Exception e) {
      log.error(entity.getClass().getName()+"(id="+EntityUtil.readPrimaryKey(entity)
          +")实体删除时同步保存到SyncDeleteEntity表时发生异常，将导致数据无法与其他机构同步删除。",e);
    }
  }
}