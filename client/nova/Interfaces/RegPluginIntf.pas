{------------------------------------
  ����˵����ע�����ӿ�
  �������ڣ�2010/11/22
  ���ߣ�ice
  ��Ȩ��nova
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
