{------------------------------------
  ����˵������¼�ӿ�
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
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
