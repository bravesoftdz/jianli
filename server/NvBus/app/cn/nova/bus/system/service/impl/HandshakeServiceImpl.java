/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.service.impl<br/>
 * <b>文件名：</b>HandshakeServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-26-上午09:05:12<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.service.impl;

import cn.nova.utils.services.HandshakeService;

/**
 * <b>类描述：</b>参见接口 HandshakeService 的描述。<br/>
 * <b>类名称：</b>HandshakeServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class HandshakeServiceImpl implements HandshakeService {

  /* shake方法：<br/>
   * @return 系统是否可访问。
   * @see cn.nova.bus.system.service.HandshakeService#shake()
   */
  @Override
  public boolean shake() {
    return true;
  }

}
