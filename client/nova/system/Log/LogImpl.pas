{------------------------------------
  ����˵����ʵ��ILog�ӿ�
  �������ڣ�2011/03/30
  ���ߣ�qjw
  ��Ȩ��nova
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
    procedure WriteLog(const Module:String;const Operation:String;const Content:String);  //��¼������־
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
  //�����������
  jcdsLog.Params.CreateParam(ftString,'operationlog.module',ptInput);
  jcdsLog.Params.CreateParam(ftString,'operationlog.operation',ptInput);
  jcdsLog.Params.CreateParam(ftString,'operationlog.content',ptInput);
  //�����������
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

{  ���ܣ���Ӳ�����־�����ݿ�
   Module:String  ����ģ������
   Operation: String ���� �磺��� �޸� ɾ���ȡ�
   Content:String �����ľ�������
}
procedure TLogObj.WriteLog(const Module:String;const Operation:String;const Content:String);
begin
  try
    //�����������ֵ
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
    Raise Exception.Create('��־д�����ݿ�ʧ�ܡ�����');
    Exit;
  end;
  //�������Ҫд�����ݱ�����

end;

procedure TLogObj.WriteLogFmt(const Str: String; const Args: array of const);
begin
  //�������Ҫд�����ݱ�����
  Raise Exception.Create('δʵ�֡�����');
end;

procedure Create_LogObj(out anInstance: IInterface);
begin
  anInstance:=TLogObj.Create;
end;

initialization
  TIntfFactory.Create(ILog,@Create_LogObj);
finalization

end.
