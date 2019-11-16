{------------------------------------
  功能说明：权限控制服务接口
  创建日期：2010/11/25
  作者：ice
  版权：nova
-------------------------------------}
unit AuthoritySvrIntf;

{$weakpackageunit on}
interface
uses FunctionItemIntf;

Type
  IAuthorityCtrl=Interface
    ['{CF963009-33DB-4D7E-BA83-9ECACDCADB1E}']
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);
  end;

  IAuthoritySvr=Interface
    ['{29C85100-4229-4EE0-9B1E-031467C146CB}']
    procedure RegAuthority(aIntf:IAuthorityCtrl);
    procedure AuthorityCtrl(aIntf:IAuthorityCtrl);
    procedure UpdateAuthority;
  end;

implementation

end.
