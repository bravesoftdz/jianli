{------------------------------------
  功能说明：系统常量&系统对象
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}

///	<remarks>本单元定义系统常量，各bpl都使用这个单元</remarks>
unit Constant;
{$weakpackageunit on}
interface
const
  SplashFormWaitTime=1000;//Flash窗口最少等待时间(毫秒)
  EncryptDefaultKey='aA#2%EF3x'; //默认加密键
  applicationCfgName='App.ini';  //应用程序配置文件名称
  ERR_IntfNotFound='找不到%s接口！';

implementation

end.
