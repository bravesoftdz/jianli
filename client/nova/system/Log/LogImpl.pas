{------------------------------------
  功能说明：实现ILog接口
  创建日期：2011/03/30
  作者：qjw
  版权：nova
-------------------------------------}
unit LogImpl;

interface

uses SysUtils,LogIntf,services,jsonConnection,DB,DBClient,jsonClientDataSet
      ,UDMPublic;

Type
  TLogObj=Class(TInterfacedObject,ILog)
  private
    function ErrFileName:String;
  protected
    {ILog}
    procedure WriteLog(const Module:String;const Operation:String;const Content:String);  //记录操作日志
    procedure WriteLogFmt(const Str:String;const Args: array of const);
    procedure WriteErr(const err:String);overload;
    procedure WriteErrFmt(const err:String;const Args: array of const);
  public
  {ILog}
    jcdsLog:TjsonClientDataSet;
    constructor create();
    destructor destroy;
  End;

implementation

uses SysFactory,SysInfoIntf;

{ TLogObj }

constructor TLogObj.create();
begin
  inherited create;
  jcdsLog:=TjsonClientDataSet.Create(nil);
  jcdsLog.RemoteServer:= DMPublic.jcon;
  jcdsLog.SaveAddress:='log/savelog';
  //创建输入参数
  jcdsLog.Params.CreateParam(ftString,'operationlog.module',ptInput);
  jcdsLog.Params.CreateParam(ftString,'operationlog.operation',ptInput);
  jcdsLog.Params.CreateParam(ftString,'operationlog.content',ptInput);
  //创建输出参数
  jcdsLog.Params.CreateParam(ftString,'msg',ptOutput);
  jcdsLog.Params.CreateParam(ftBCD,'flag',ptOutput);

//  jcdsLog.DataSourceName:='logmap';
end;

destructor TLogObj.destroy;
begin
  inherited destroy;
  jcdsLog.Free;
end;

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

{  功能：添加操作日志到数据库
   Module:String  功能模块名称
   Operation: String 操作 如：添加 修改 删除等。
   Content:String 操作的具体内容
}
procedure TLogObj.WriteLog(const Module:String;const Operation:String;const Content:String);
begin
  try
    //给输入参数赋值
    jcdsLog.Active:=False;
    jcdsLog.Params.ParamByName('operationlog.module').Value:=trim(Module);
    jcdsLog.Params.ParamByName('operationlog.operation').Value:=trim(Operation);
    jcdsLog.Params.ParamByName('operationlog.content').Value:=trim(Content);
    jcdsLog.Execute;
    if jcdsLog.Params.ParamValues['flag']=-1 then
    begin
      SysDialogs.ShowMessage(jcdsLog.Params.ParamValues['msg']);
    end;
  except
    Raise Exception.Create('日志写入数据库失败。。。');
    Exit;
  end;
  //这个可能要写入数据表。。。

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
