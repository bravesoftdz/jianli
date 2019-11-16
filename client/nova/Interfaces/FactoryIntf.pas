{------------------------------------
  功能说明：工厂接口
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit FactoryIntf;

interface

Type
  ISysFactory=Interface
  ['{87DC8DDF-0975-40FD-9B80-64F1308A85D5}']
    procedure CreateInstance(const IID : TGUID; out Obj);
    procedure ReleaseInstance;
    function Supports(IID:TGUID):Boolean;
  end;
implementation

end.
