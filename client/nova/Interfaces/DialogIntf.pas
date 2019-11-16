{------------------------------------
  ����˵����ͳһ����Ϣ��ʾ��ӿ�
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit DialogIntf;
{$weakpackageunit on}
interface

uses SysUtils;

Type
  IDialog=Interface
    ['{CBCB3734-0FEC-4090-B0C4-50E1646D5758}']
    procedure ShowMessage(const APrompt:String);
    procedure ShowMessageFmt(const APrompt:string;const Args: array of const);
    procedure ShowInfo(const APrompt:string);
    procedure ShowError(const APrompt:string);overload;
    procedure ShowError(E:Exception);overload;
    procedure ShowErrorFmt(const APrompt:string;const Args: array of const);
    procedure Warning(const APrompt:String);
    function  Confirm(const ACaption,APrompt:string):Boolean;
    function  Ask(const ACaption,APrompt:string):Boolean;
    function  InputBox(const ACaption,APrompt:string;var Value:string):Boolean;
  End;
  
implementation

end.
