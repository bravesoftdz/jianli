{------------------------------------
  功能说明：注册插件接口
  创建日期：2010/11/22
  作者：ice
  版权：nova
-------------------------------------}
unit RegPluginIntf;
{$weakpackageunit on}
interface

Uses FunctionItemIntf;

Type
  IRegPlugin=Interface
    ['{3E2FB798-6217-43BF-BB57-5FB3362C595B}']
    procedure RegisterFunctionItem(FunctionItem:IFunctionItem);
  End;
implementation

end.
