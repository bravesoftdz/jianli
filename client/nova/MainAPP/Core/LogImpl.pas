{------------------------------------
  功能说明：实现ILog接口
  创建日期：2008/11/21
  作者：wzw
  版权：wzw
-------------------------------------}
unit LogImpl;

interface

uses SysUtils,LogIntf,services;

Type
  TLogObj=Class(TInterfacedObject,ILog)
  private
    function ErrFileName:String;
  protected
    {ILog}
    procedure WriteLog(const Str:String);
    procedure WriteLogFmt(const Str:String;const Args: array of const);
    procedure WriteErr(const err:String);overload;
    procedure WriteErrFmt(const err:String;const Args: array of const);
  public

  End;
  
implementation

uses SysSvc,SysFactory,SysInfoIntf;

{ TLogObj }

function TLogObj.ErrFileName: String;
begin
  Result:=(SysService as ISysInfo).ErrPath+'\'+FormatDateTime('YYYY-MM-DD',Now)+'.txt';
end;

procedure TLogObj.WriteErr(const err: String);
var FileName:String;
    FileHandle:TextFile;
begin
  FileName:=ErrFileName;
  assignfile(FileHandle,FileName);
  try
    if FileExists(FileName) then
      append(FileHandle)//Reset(FileHandle)
    else ReWrite(FileHandle);
    WriteLn(FileHandle,FormatDateTime('[HH:MM:SS]',now)+'  '+err);
  finally
    CloseFile(FileHandle);
  end;
end;

procedure TLogObj.WriteErrFmt(const err: String; const Args: array of const);
begin
  WriteErr(Format(err,Args));
end;

procedure TLogObj.WriteLog(const Str: String);
begin
  //这个可能要写入数据表。。。
  Raise Exception.Create('未实现。。。');
end;

procedure TLogObj.WriteLogFmt(const Str: String; const Args: array of const);
begin
  //这个可能要写入数据表。。。
  Raise Exception.Create('未实现。。。');
end;

procedure Create_LogObj(out anInstance: IInterface);
begin
  anInstance:=TLogObj.Create;
end;

initialization
  TIntfFactory.Create(ILog,@Create_LogObj);
finalization

end.
