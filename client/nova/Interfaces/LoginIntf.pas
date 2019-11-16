{------------------------------------
  功能说明：登录接口
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit LoginIntf;

interface
{$weakpackageunit on}
Type
  ILogin=Interface
    ['{694033A7-8C4F-4FCC-ABA9-01ECD1FF4F28}']
    procedure CheckLogin;
    procedure ChangeUser;
    procedure LockSystem;
    procedure Logout;
  End;
implementation

end.
