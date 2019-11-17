/**
 * <b>项目名：</b>NvCentreEJB<br/>
 * <b>包名：</b>cn.nova.centre.system.service.impl<br/>
 * <b>文件名：</b>OrganizationConnectableServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2012-1-7-下午09:58:43<br/>
 * <b>Copyright (c)</b> 2012深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.service.impl;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.commons.TestNetWork;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.services.OrganizationConnectableService;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>OrganizationConnectableServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class OrganizationConnectableServiceImpl implements OrganizationConnectableService {
  @SuppressWarnings("rawtypes")
  private IDAO dao = new EntityManagerDaoSurport();  
  @Override
  public void check(String code) {

  }

  @Override
  public void check(long id) {
    
  }

  @SuppressWarnings("unchecked")
  @Override
  public void check(Object org) {
    if(null==org)
      return;
    
    Organization organizatoin = (Organization) org;
    if(null == organizatoin.getServersaddress() || organizatoin.getServersaddress().length()<7){
      return;
    }
    
    boolean connectable = 
      TestNetWork.isConnectable(organizatoin.getServersaddressIp(), Integer.parseInt(organizatoin.getServersaddressPort()) );
    
    if(connectable==organizatoin.getIsonline()){
      return;
    }else{
      organizatoin.setIsonline(connectable);
      dao.merge(organizatoin);
    }
  }

}
