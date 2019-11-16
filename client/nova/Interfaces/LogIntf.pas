{------------------------------------
  功能说明：系统日志接口
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit LogIntf;
interface

uses SysUtils;

Type
  ILog=Interface
    ['{28547D91-03D0-4997-B141-F8FC8E3438BC}']
    procedure WriteLog(const Module:String;const Operation:String;const Content:String);
    procedure WriteLogFmt(const Str:String;const Args: array of const);
    procedure WriteErr(const err:String);overload;
    procedure WriteErrFmt(const err:String;const Args: array of const);
  End;
  
implementation

end.
