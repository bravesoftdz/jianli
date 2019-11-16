{------------------------------------
  功能说明：应用服务器连接配置接口
  创建日期：2010/11/25
  作者：ice
  版权：nova
-------------------------------------}
unit ConnectCFGIntf;

interface
type
  IConnectCFG=interface
  ['{910B24D6-F3D1-45C5-AC26-7325D33AC613}']
    //测试服务器连接
    function connectToServer():Boolean;
  end;

implementation

end.
