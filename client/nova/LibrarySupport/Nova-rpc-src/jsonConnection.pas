unit jsonConnection;
{------------------------------------
  功能说明：用于跟数据库的连接
  创建日期：2011/01/30
  作者：lanck
  版权：nova
-------------------------------------}
interface

uses
  Windows, Messages, SysUtils, Classes, msxml, DB, DBClient, Midas,
  Provider, ComObj, Variants, MidConst, superobject, DBJson, jsonFunc, Base64,
  Generics.Collections;

type
  // 连接状态
  TConnectState = (csGetRecords, csApplyUpdates, csDownLoad, csDisconnect);

  TjsonConnection = class(TCustomRemoteServer, IAppServer)
  private
    { Private declarations }


    FURLHost: string;
    FURLRead: string;
    FURLWrite: string;
    FUserName: string;
    FPassword: string;
    FCreateRequestFile: Boolean;
    FBatchUpdates: Boolean;
    FProviders: TList;
    FXmlHttp: IXMLHTTPREQUEST;
    FcdsResult: TCustomClientDataSet;
    FState: TConnectState;
    FOnStateChange: TNotifyEvent;
    FConnectWeb: Boolean;
    FDeltaJSON: string;
    FBeforeCommitUpdates: TNotifyEvent;
    FAfterCommitUpdates: TNotifyEvent;
    FAppServer: IAppServer;
    function GetProviderCount: integer;
    procedure SetURLHost(const Value: string);
    function ApplyUpdatesWeb(const ProviderName: WideString; DeltaXML: string;
      MaxErrors: integer; out ErrorCount: integer; var OwnerData: OleVariant)
      : OleVariant;
    function ApplyUpdatesFile(const ProviderName: WideString; DeltaXML: string;
      MaxErrors: integer; out ErrorCount: integer; var OwnerData: OleVariant)
      : OleVariant;
    function GetParamStr(CommandText: string; Params: OleVariant): string;
    // 将Delta的内容生成JSON字符串，删除更新前的内容
    function GetDeltaJSON(cdsDelta: TCustomClientDataSet;
      ProviderName: string): string;
    // 根据更新后的返回数据列新Delta(根据主键更新Delta，以第一个字段作为主键处理)
    procedure SetResultData(AResultJSON: string;
      cdsResult: TCustomClientDataSet;
      var AErrorCount: integer);

    // 将返回的数据更新到参数中
    procedure SetParams(json: ISuperObject; var Params: OleVariant);

    // 批量更新Web数据
    function BatchUpdatesWeb(): string;
    // 批量更新文件数据
    function BatchUpdatesFile(): string;
    // 刷新数据集内容
    procedure RefreshDataSets(AResultJSON: string);
    // 设置数据集内容为已更新成功
    procedure SetDataSetsUpdatesOK();
    // 取ProviderName对应的数据集
    function GetDataSetByProvider(AProviderName: string): TCustomClientDataSet;
    // 取CommitProvider对应的数据集
    function GetDataSetByCommitProvider(AProviderName: string)
      : TCustomClientDataSet;

    // 取XML文件名，用于根据URL、ProviderName、CommandText、Params取出对应的文件名
    function GetJSONFileName(APath, AProviderName, ARequest: string): string;

    // 将JSON文本保存到对应的文件中
    procedure SaveJSONFile(AJSON, AFileName: string);

    // 取出当前连接对应的ProviderName字符串
    function GetProvidersName(): string;
  protected
    { Protected declarations }
    function GetProvider(const ProviderName: string): TCustomProvider; virtual;
    { IAppServer }
    function AS_GetProviderNames: OleVariant; safecall;

    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant;
      MaxErrors: integer; out ErrorCount: integer; var OwnerData: OleVariant)
      : OleVariant; safecall;

    function AS_GetRecords(const ProviderName: WideString; Count: integer;
      out RecsOut: integer; Options: integer; const CommandText: WideString;
      var Params, OwnerData: OleVariant): OleVariant; safecall;

    function AS_DataRequest(const ProviderName: WideString;
      Data: OleVariant): OleVariant; safecall;

    function AS_GetParams(const ProviderName: WideString;
      var OwnerData: OleVariant): OleVariant; safecall;

    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant;
      RequestType: integer; var OwnerData: OleVariant): OleVariant; safecall;

    procedure AS_Execute(const ProviderName: WideString;
      const CommandText: WideString; var Params, OwnerData: OleVariant);
      safecall;
    function GetConnected: Boolean; override;
    // procedure GetProviderNames(Proc: TGetStrProc); override;
    procedure RegisterProvider(Prov: TCustomProvider);
    procedure UnRegisterProvider(Prov: TCustomProvider);
    procedure DoAfterCommitUpdates(); virtual;
    procedure DoBeforeCommitUpdates(); virtual;
    procedure DoStateChange(); virtual;
    function TransformUrl(URL: string): string;

    function SafetySend(xmlRequest:IXMLHTTPRequest;varBody: OleVariant):boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AppServer: IAppServer read FAppServer;
    function GetServer: IAppServer; override;
    procedure DownLoadFile(AURL, ASourceFileName, ATargetFileName: string);
      virtual; // 下载文件
    property Providers[const ProviderName: string]
      : TCustomProvider read GetProvider;
    property ProviderCount: integer read GetProviderCount;
    property DeltaJSON: string read FDeltaJSON write FDeltaJSON;
    property XmlHttp: IXMLHTTPREQUEST read FXmlHttp;
    // Delta对应的XML，用于动态更新数据
    procedure AddDeltaJSON(ADeltaJSON: string);
    procedure ApplyUpdates(); virtual; // 对所有数据集保存数据
    procedure CommitUpdates(); virtual; // 提交更新数据
    procedure CancelUpdates(); virtual; // 取消更新数据
    property State: TConnectState read FState; // 连接状态
  published
    { Published declarations }
    property URLHost: string read FURLHost write SetURLHost; // URL主机地址
    property URLRead: string read FURLRead write FURLRead; // 用于读数据的地址
    property URLWrite: string read FURLWrite write FURLWrite; // 用于写数据的地址
    property UserName: string read FUserName write FUserName; // 连接地址的用户名
    property Password: string read FPassword write FPassword; // 连接地址的口令

    property CreateRequestFile
      : Boolean read FCreateRequestFile write FCreateRequestFile default
      false; // 是否创建请求文件，为true时，于本地创建请求对应的XML文件

    property BatchUpdates
      : Boolean read FBatchUpdates write FBatchUpdates default
      false; // 是否批量更新，批量更新时，由Connection将对应的数据集更新信息同时提交

    property BeforeCommitUpdates: TNotifyEvent read FBeforeCommitUpdates write
      FBeforeCommitUpdates; // 批量提交数据前的事件
    property AfterCommitUpdates
      : TNotifyEvent read FAfterCommitUpdates write FAfterCommitUpdates;
    // 批量提交数据后的事件
    property OnStateChange
      : TNotifyEvent read FOnStateChange write FOnStateChange;
    // 连接状态改变时的处理事件
  end;

procedure Register;

implementation

uses jsonClientDataSet;

procedure Register;
begin
  RegisterComponents('Nova', [TjsonConnection]);
end;

{ TjsonConnection }
procedure TjsonConnection.AddDeltaJSON(ADeltaJSON: string);
begin
  if (ADeltaJSON = '') then
  begin
    FDeltaJSON := ADeltaJSON;
  end
  else
  begin
    // 删除</DATASET></DATAPACKET>
    Delete(FDeltaJSON, Length(FDeltaJSON) - 12, 13);
    // 删除起始内容
    Delete(ADeltaJSON, 1, 106);
    FDeltaJSON := FDeltaJSON + ADeltaJSON;
  end;
end;

procedure TjsonConnection.ApplyUpdates;
var
  i: integer;
  dsCurror: TDataSet;
  cdsCurror: TClientDataSet;
  xcdsCurror: TjsonClientDataSet;
  sDeltaJSON: string;
begin

  sDeltaJSON := FDeltaJSON;
  try
    // 将对应的数据集保存更新
    for i := 0 to Self.DataSetCount - 1 do
    begin
      dsCurror := Self.DataSets[i];
      // 插入或修改状态时，先Post，避免后面的处理出错（xDBTreeView中处理会出错）
      if ((dsCurror.State = dsInsert) or (dsCurror.State = dsEdit)) then
        dsCurror.Post();
      if (dsCurror.InheritsFrom(TjsonClientDataSet)) then
      begin
        xcdsCurror := TjsonClientDataSet(dsCurror);
        if (xcdsCurror.Active and (xcdsCurror.ChangeCount > 0)) then
        begin
          if (FBatchUpdates) then
            xcdsCurror.ApplyDelta()
          else
            xcdsCurror.ApplyUpdates(0);
        end;
      end
      else if (dsCurror.InheritsFrom(TClientDataSet)) then
      begin
        cdsCurror := TClientDataSet(dsCurror);
        if (cdsCurror.Active and (cdsCurror.ChangeCount > 0)) then // or (cdsCurror.State = dsInsert) or (cdsCurror.State = dsEdit))) then
          cdsCurror.ApplyUpdates(0);
      end;
    end;
    // 提交数据
    CommitUpdates();
  except
    // 出错时恢复原Delta
    FDeltaJSON := sDeltaJSON;
    raise ;
  end;

end;

function TjsonConnection.ApplyUpdatesFile(const ProviderName: WideString;
  DeltaXML: string; MaxErrors: integer; out ErrorCount: integer;
  var OwnerData: OleVariant): OleVariant;
var
  sl, EncryptFiledList: TStringList;
begin
  FcdsResult := TCustomClientDataSet.Create(nil);
  // 将修改信息生成xml格式
  FcdsResult.Data := NULL;
  sl := TStringList.Create();
  EncryptFiledList := TStringList.Create;
  try
    // 将修改信息写到文件中
    if (FCreateRequestFile) then
    begin
      sl.Text := DeltaXML;
      sl.SaveToFile(FURLHost + FURLWrite + '\' + ProviderName + '_Save.XML');
    end;
    // 将返回信息回写数据
    sl.LoadFromFile(FURLHost + FURLWrite + '\' + ProviderName + '_Back.XML');
    // 检查是否成功
    // CheckResult(sl.Text);
    SetResultData(sl.Text, FcdsResult, ErrorCount);
  finally
    EncryptFiledList.Free;
    FreeAndNil(FcdsResult);
    if (Assigned(sl)) then
      FreeAndNil(sl);
  end;
  Result := FcdsResult.Data;

end;

function TjsonConnection.ApplyUpdatesWeb(const ProviderName: WideString;
  DeltaXML: string; MaxErrors: integer; out ErrorCount: integer;
  var OwnerData: OleVariant): OleVariant;
var
  xmldoc: Variant;
  sResultJSON: string;
  sResultXML: string;
  Params: OleVariant;
  MyParams: TParams;
  sDataset, sJson: WideString;
  cdsCurr: TCustomClientDataSet;
  // EncryptFiledList: TStringList; //加密字段串
  // LogFilePath: String;
  json: ISuperObject;
  actionName, sKeyField,fieldtypes, fieldtypesize,dataSourceName: String;
  spost: WideString;
  i:integer;
begin
  // cdsCurr:=FcdsResult;
  FcdsResult := TCustomClientDataSet.Create(nil);
  cdsCurr := GetDataSetByProvider(ProviderName);
  actionName := (cdsCurr as TjsonClientDataSet).SaveAddress;
  if (actionName = '') then
  begin
    raise Exception.Create(cdsCurr.Name + '保存地址未设置！');
  end;
  dataSourceName := (cdsCurr as TjsonClientDataSet).DataSourceName;
  FcdsResult.Data := NULL;
  // xmldoc := CreateOleObject('Msxml2.DOMDocument');
  FXmlHttp := CoXMLHTTP.Create();

  try
    FState := csApplyUpdates;
    DoStateChange();

    MyParams:=(cdsCurr as TjsonClientDataSet).Params;
    Params:=PackageParams(MyParams);
    spost := GetParamStr('', Params);
    DeltaXML:=DeltaXML+spost;
    {$IFDEF CONSOLE}  //
      Writeln('spost='+spost);
      Writeln('dataSourceName='+dataSourceName);
      Writeln('DeltaXML='+DeltaXML);
    {$ENDIF}
    // 当要创建请求文件时，将请求信息生成相应的文件
    if (FCreateRequestFile) then
      SaveJSONFile(DeltaXML, ProviderName + '_Save.TXT');

    // 写入本地日志文件(Add by HBin 2007-01-24)
    // if IsWriteToLogFile(LogFilePath) then
    // WriteToLogFile(DeltaXML, LogFilePath, ProviderName);
    // sPost := GetParamStr('', cdsCurr.);
    // xmldoc.LoadXml(DeltaXML);
    // 将修改信息写到服务器中
    FXmlHttp.open('POST', FURLHost + TransformUrl((actionName)), false,
      FUserName, FPassword);
    FXmlHttp.setRequestHeader('Content-Type',
      'application/x-www-form-urlencoded;charset=utf-8');
//    FXmlHttp.send(DeltaXML);
    SafetySend(FXmlHttp,DeltaXML);
    sResultJSON := FXmlHttp.responseText;
    json := SO(sResultJSON);
    {$IFDEF CONSOLE}  //
      Writeln('sResultJSON='+sResultJSON);
    {$ENDIF}
    if (FCreateRequestFile) then
      SaveJSONFile(sResultJSON, ProviderName + '_Back.TXT');

    SetParams(json, Params);
    UnpackParams(Params, MyParams);
    // 写入本地日志文件(Add by HBin 2007-01-24)
    // if IsWriteToLogFile(LogFilePath) then
    // WriteToLogFile(sXML, LogFilePath, ProviderName);

    if (cdsCurr as TjsonClientDataSet).refreshAfterApplyUpdates then
    begin
      if json[dataSourceName+'_type']=nil then
        raise Exception.Create('返回值中不存在“'+dataSourceName+'_type'+'”参数');
      fieldtypes:= json[dataSourceName+'_type'].AsString;
      if json[dataSourceName+'_typelength']=nil then
        raise Exception.Create('返回值中不存在“'+dataSourceName+'_typelength'+'”参数');
      fieldtypesize:= json[dataSourceName+'_typelength'].AsString;
      FcdsResult.Active := false;
      // 将返回信息回写数据
      TTableJSon.CDSFromJSon2(FcdsResult,SO(sResultJSON)[dataSourceName].AsString,fieldtypes,fieldtypesize);
      // sResultXML := TTableJSon.XMLFromJSon(ProviderName, json);
      // CheckResult(sResultXML);
      FcdsResult.Active := true;
      FcdsResult.MergeChangeLog;
      Result := FcdsResult.Data;
      cdsCurr.Data := FcdsResult.Data;
    end;

  finally
    // EncryptFiledList.Free;
    // xmldoc := Unassigned;
    //FreeAndNil(MyParams);
    FXmlHttp := nil;
    FreeAndNil(FcdsResult);
    FState := csDisconnect;
    DoStateChange();
  end;

end;

function TjsonConnection.AS_ApplyUpdates(const ProviderName: WideString;
  Delta: OleVariant; MaxErrors: integer; out ErrorCount: integer;
  var OwnerData: OleVariant): OleVariant;
var
  cdsDelta: TjsonClientDataSet;
  sDeltaJSON: string;
  vResult: OleVariant;
begin
  // 将修改信息生成xml格式
  try
    vResult := NULL;
    cdsDelta := TjsonClientDataSet.Create(nil);
    try
      cdsDelta.Data := Delta;

      sDeltaJSON := GetDeltaJSON(cdsDelta, ProviderName);
      if (sDeltaJSON <> '') then
      begin
        if (FBatchUpdates) then
        begin
          // 批量更新，则记录Delta的XML
          AddDeltaJSON(sDeltaJSON);
        end
        else
        begin
          // 立即更新
          if (FConnectWeb) then
          begin
            vResult := ApplyUpdatesWeb(ProviderName, sDeltaJSON, MaxErrors,
              ErrorCount, OwnerData);
          end
          else
          begin
            vResult := ApplyUpdatesFile(ProviderName, sDeltaJSON, MaxErrors,
              ErrorCount, OwnerData);
          end;
        end;
      end;
    finally
      FreeAndNil(cdsDelta);
    end;
  except
    on E: Exception do
    begin
      // 出错时，记录错误信息
      ErrorCount := 1;
      vResult := E.Message;
    end;
  end;
  Result := vResult;

end;

function TjsonConnection.AS_DataRequest(const ProviderName: WideString;
  Data: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].DataRequest(Data);
end;

procedure TjsonConnection.AS_Execute(const ProviderName,
  CommandText: WideString; var Params, OwnerData: OleVariant);
var
  json: ISuperObject;
  spost, actionName: String;
  cdsCurr: TCustomClientDataSet;
begin
  // 注释默认执行SQL语句的方法
  // Providers[ProviderName].Execute(CommandText, Params, OwnerData);
  // 重写执行语句
 // showmessage('--------------');
  cdsCurr := GetDataSetByProvider(ProviderName);
  actionName := (cdsCurr as TjsonClientDataSet).SaveAddress;
  if (actionName = '') then
  begin
    raise Exception.Create(cdsCurr.Name + '保存地址未设置！');
  end;
  FXmlHttp := CoXMLHTTP.Create();
  spost := GetParamStr('', Params);
 // showmessage('aa='+spost);
  try
    FXmlHttp.open('post', FURLHost + TransformUrl(actionName), false,
      FUserName, FPassword);
    FXmlHttp.setRequestHeader('Content-Type',
      'application/x-www-form-urlencoded;charset=utf-8');
    {$IFDEF CONSOLE}  //
         Writeln('spost:'+spost);
    {$ENDIF}
//    FXmlHttp.send(spost);
    SafetySend(FXmlHttp,spost);
    json := SO(FXmlHttp.responseText);
    {$IFDEF CONSOLE}  //
         Writeln('FXmlHttp.responseText:'+FXmlHttp.responseText);
    {$ENDIF}
    SetParams(json, Params);
  finally
    FXmlHttp := nil;
  end;

end;

function TjsonConnection.AS_GetParams(const ProviderName: WideString;
  var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].GetParams(OwnerData);
end;

function TjsonConnection.AS_GetProviderNames: OleVariant;
var
  List: TStringList;
  i: integer;
begin
  List := TStringList.Create;
  try
    for i := 0 to FProviders.Count - 1 do
      if TCustomProvider(FProviders[i]).Exported then
        List.Add(TCustomProvider(FProviders[i]).Name);
    List.Sort;
    Result := VarArrayFromStrings(List);
  finally
    List.Free;
  end;

end;

function TjsonConnection.AS_GetRecords(const ProviderName: WideString;
  Count: integer; out RecsOut: integer; Options: integer;
  const CommandText: WideString; var Params, OwnerData: OleVariant)
  : OleVariant;
var
  spost: string;
  ss: TStringStream; // smTmp:
  fs: TFileStream;
  sJson: WideString;
  cdsCurr: TCustomClientDataSet;
  sFileName: string;
  sXML: WideString;
  json: ISuperObject;
  sDataset: string;
  sDatasetType: string;
  sFiledSize: string;
  jo: ISuperObject;
  stream: TStream;
  i: integer;
  MyField: TField;
  starttime, endtime: TDateTime;
  runtime: double;
  sKeyField, dataSourceName,actionName: String;
begin

  FcdsResult := TCustomClientDataSet.Create(nil);
  FXmlHttp := CoXMLHTTP.Create();
  try
    // Options=-1表示只激活不取数据
    if (Options = -1) then
    begin
      // 取出数据集
      cdsCurr := GetDataSetByProvider(ProviderName);
      // 根据数据集取出对应的字段列表作为空数据返回
      // sXML := GetDataSetXML(cdsCurr);

      sJson := TTableJSon.JSonFromDataSet(cdsCurr);
      try
        FcdsResult.Active := false;
       // json := TSuperObject.ParseStream(ss, false);
        // TTableJSon.CDSFromJSon(FcdsResult, json);

        FcdsResult.Active := true;
        RecsOut := 0;
        Result := FcdsResult.Data;
        FcdsResult.Active := false;
      finally
        // FreeAndNil(ss);
      end;
    end
    else
    begin
      // 激活时取数据
      FState := csGetRecords;
      DoStateChange();
      // 取出参数XML
      cdsCurr := GetDataSetByProvider(ProviderName);
      // 先不考虑分页
      // sPost := TTableJSon.JSonFromDataSetParam(ProviderName,PackageParams((cdsCurr as TjsonClientDataSet).Params), '');
      spost := GetParamStr((cdsCurr as TjsonClientDataSet).CommandText, Params);
      // spost := '&';
      if (FConnectWeb) then
      begin
        // 当要创建请求文件时，将请求信息生成相应的文件
        if (FCreateRequestFile) then
          SaveJSONFile(spost, ProviderName + '_.txt');
        try
          // 用xmldoc进行转义符处理。即将">、&"等字符转义再传到后台。
          // xmldoc.LoadXml(sPost);
          // 将修改信息写到服务器中
          // 写入本地日志文件
          // if IsWriteToLogFile(LogFilePath) then
          // WriteToLogFile(sPost, LogFilePath, ProviderName);
          actionName := (cdsCurr as TjsonClientDataSet).QueryAddress;
          if (actionName = '') then
          begin
            raise Exception.Create(cdsCurr.Name + '未设置查询地址！');
          end;
          dataSourceName := (cdsCurr as TjsonClientDataSet).dataSourceName;
          FXmlHttp.open('post',
            FURLHost + TransformUrl(actionName), false, FUserName, FPassword);

          FXmlHttp.setRequestHeader('Content-Type',
            'application/x-www-form-urlencoded;charset=utf-8');
          // FXmlHttp.setRequestHeader('ContentEncoding', 'UTF-8');
//          FXmlHttp.send(spost);
          SafetySend(FXmlHttp,spost);
          {$IFDEF CONSOLE}  //
               Writeln('spost='+spost);
          {$ENDIF}
          json := SO(FXmlHttp.responseText);
          {$IFDEF CONSOLE}  //
               Writeln('responseText:'+FXmlHttp.responseText);
               Writeln('dataSourceName:'+dataSourceName);
          {$ENDIF}

          if json[dataSourceName]=nil then
            raise Exception.Create('返回值中不存在“'+dataSourceName+'”参数');
          sDataset := json[dataSourceName].AsString;
          if json[dataSourceName+'_type']=nil then
          begin
            if (json['flag']<>nil) and (json['msg']<>nil) and (trim(json['msg'].AsString)<>'') then
            begin
              RecsOut := -77;
              Result := json['msg'].AsString;
              exit;
            end
            else
            begin
              raise Exception.Create('返回值中不存在“'+dataSourceName+'_type'+'”参数');
            end;
          end;
          sDatasetType := json[dataSourceName+'_type'].AsString;
          if json[dataSourceName+'_typelength']=nil then
          begin
            if (json['flag']<>nil) and (json['msg']<>nil) and (trim(json['msg'].AsString)<>'') then
            begin
              RecsOut := -77;
              Result := json['msg'].AsString;
              exit;
            end
            else
            begin
              raise Exception.Create('返回值中不存在“'+dataSourceName+'_typelength'+'”参数');
            end;
          end;
          sFiledSize := json[dataSourceName+'_typelength'].AsString;
          {$IFDEF CONSOLE}  //
               Writeln('sDataset:'+sDataset);
               Writeln('sDatasetType:'+sDatasetType);
               Writeln('sFiledSize:'+sFiledSize);
          {$ENDIF}
        finally
          // xmldoc := Unassigned;
          // sDataset := '[{"msg":}]';
        end;
        try
           {  if ((sDataset = 'null') or (sDataset = '[]')) then
          begin
            // SetParams(json, Params); cdsCurr

          FcdsResult.Active := false;
            FcdsResult.LoadFromStream();
            TTableJSon.CDSFromJSon2(FcdsResult, sDataset);
            FcdsResult.Active := true;
            RecsOut := 0;
            FcdsResult.MergeChangeLog;
            Result := FcdsResult.Data;

            ss := TStringStream.Create(_nullDataXml);
            FcdsResult.Active := false;
            FcdsResult.LoadFromStream(ss);
            FcdsResult.Active := true;

            //将接收到的数据直接返回
            RecsOut := FcdsResult.RecordCount;
            Result := FcdsResult.Data;
            FcdsResult.Active := false;

          end
          else  }
          begin
           // FcdsResult.FieldDefList.Clear;
           // FcdsResult.FieldDefList:=cdsCurr.FieldDefList;
            SetParams(json, Params) ;
            FcdsResult.Active := false;
            TTableJSon.CDSFromJSon2(FcdsResult, sDataset,sDatasetType,sFiledSize);
            FcdsResult.Active := true;
            RecsOut := FcdsResult.RecordCount;
            if (cdsCurr as TjsonClientDataSet).MergeLog then
              FcdsResult.MergeChangeLog;
           // FcdsResult:=cdsCurr;
            Result := FcdsResult.Data;
          end;
        except
          on E: Exception do
            raise Exception.Create(e.ToString + '服务器传输的数据格式有误！');
        end;
        // 写入本地日志文件
        // if IsWriteToLogFile(LogFilePath) then
        // WriteToLogFile(sXML, LogFilePath, ProviderName);

        if (FCreateRequestFile) then
          SaveJSONFile(sJson, ProviderName);
      end
      else
      begin
        // 当要创建请求文件时，将请求信息生成相应的文件
        if (FCreateRequestFile) then
          SaveJSONFile(spost,
            FURLHost + FURLRead + '\' + ProviderName + '_.txt');
        // 取数据
        sFileName := GetJSONFileName(FURLHost + TransformUrl(FURLRead) + '/',
          ProviderName, GetParamStr(CommandText, Params));
        fs := TFileStream.Create(sFileName, fmOpenRead);
        ss := TStringStream.Create('');
        ss.CopyFrom(fs, fs.Size);
        FreeAndNil(fs);
        sJson := ss.DataString;
      end;
    end;
  except
    on E: Exception do
    begin
      // 出错时，记录错误信息，以负记录数表示出错
      RecsOut := -1;
      Result := E.Message;
    end;
  end;
  FXmlHttp := nil;
  FreeAndNil(FcdsResult);
  FState := csDisconnect;
  DoStateChange();

end;

function TjsonConnection.AS_RowRequest(const ProviderName: WideString;
  Row: OleVariant; RequestType: integer; var OwnerData: OleVariant)
  : OleVariant;
begin
  Result := Providers[ProviderName].RowRequest(Row, RequestType, OwnerData);
end;

function TjsonConnection.BatchUpdatesFile: string;
var
  xmldoc: Variant;
  sProviderNames: string;
  sResultJSON: string;
begin
  sProviderNames := GetProvidersName();
  xmldoc := CreateOleObject('Msxml2.DOMDocument');
  FXmlHttp := CoXMLHTTP.Create();
  try
    FState := csApplyUpdates;
    DoStateChange();
    if (FCreateRequestFile) then
      SaveJSONFile(FDeltaJSON, sProviderNames + '_Save.xml');
    xmldoc.LoadXml(FDeltaJSON);
    // 将修改信息写到服务器中
    FXmlHttp.open('POST', FURLHost + TransformUrl(FURLWrite), false, FUserName,
      FPassword);
    FXmlHttp.send(xmldoc);

    // FXMLDomDoc := FXmlHttp.ResponseXml as IXMLDOMDocument;
    sResultJSON := FXmlHttp.responseText;
    if (FCreateRequestFile) then
      SaveJSONFile(sResultJSON, sProviderNames + '_Back.xml');
    // Result := FXMLDomDoc.XML;
    Result := sResultJSON;
  finally
    xmldoc := Unassigned;
    FXmlHttp := nil;
    FState := csDisconnect;
    DoStateChange();
  end;

end;

function TjsonConnection.BatchUpdatesWeb: string;
var
  xmldoc: Variant;
  sProviderNames: string;
  sResultJSON: string;
begin
  sProviderNames := GetProvidersName();
  xmldoc := CreateOleObject('Msxml2.DOMDocument');
  FXmlHttp := CoXMLHTTP.Create();
  try
    FState := csApplyUpdates;
    DoStateChange();
    if (FCreateRequestFile) then
      SaveJSONFile(FDeltaJSON, sProviderNames + '_Save.xml');
    xmldoc.LoadXml(FDeltaJSON);
    // 将修改信息写到服务器中
    FXmlHttp.open('POST', FURLHost + TransformUrl(FURLWrite), false, FUserName,
      FPassword);
    FXmlHttp.send(xmldoc);

    sResultJSON := FXmlHttp.responseText;
    if (FCreateRequestFile) then
      SaveJSONFile(sResultJSON, sProviderNames + '_Back.xml');

    Result := sResultJSON;
  finally
    xmldoc := Unassigned;
    FXmlHttp := nil;
    FState := csDisconnect;
    DoStateChange();
  end;

end;

procedure TjsonConnection.CancelUpdates;
var
  i: integer;
  dsCurror: TDataSet;
  cdsCurror: TjsonClientDataSet;
begin
  // 将对应的数据集取消更新
  for i := 0 to Self.DataSetCount - 1 do
  begin
    dsCurror := Self.DataSets[i];
    if (dsCurror.InheritsFrom(TCustomClientDataSet)) then
    begin
      cdsCurror := (dsCurror as TjsonClientDataSet);
      if ((cdsCurror.State = dsInsert) or (cdsCurror.State = dsEdit)) then
        cdsCurror.Cancel();
      // 因cdsCurror.CancelUpdates会触发Post，故先Cancel
      if (cdsCurror.Active and (cdsCurror.ChangeCount > 0)) then
      begin
        cdsCurror.CancelUpdates();
        cdsCurror.Refresh;
      end;
    end;
  end;

end;

function TjsonConnection.SafetySend(xmlRequest: IXMLHTTPRequest;varBody: OleVariant): boolean;
var _rstr:String;
begin
  try
    xmlRequest.send(varBody);
  except on E: Exception do
    raise Exception.Create('无法连接服务器');
  end;
//  OutputDebugString(PWideChar('httpStatus:'+inttostr(xmlRequest.status)+xmlRequest.statusText+#13+'responseHeader:'+xmlRequest.getAllResponseHeaders+'responseText:'+xmlRequest.responseText));
  if (xmlRequest.status<>200) and (xmlRequest.status<>0) then
  begin
    _rstr:=xmlRequest.responseText;
    if pos('<pre>',_rstr)>0 then
    begin
      raise Exception.Create('服务器返回出错：'+'httpStatus:'+inttostr(xmlRequest.status)+' '+xmlRequest.statusText
                            +#13+copy(_rstr,pos('<pre>',_rstr)+length('<pre>'),pos('</pre>',_rstr)-pos('<pre>',_rstr)-length('<pre>')));
    end
    else
      raise Exception.Create('服务器返回出错：'+'httpStatus:'+inttostr(xmlRequest.status)+' '+xmlRequest.statusText
                            +#13+xmlRequest.responseText);
  end;
//  case xmlRequest.status of
//    100 Continue
//    101 Switching protocols
//    200 OK
//    201 Created
//    202 Accepted
//    203 Non-Authoritative Information
//    204 No Content
//    205 Reset Content
//    206 Partial Content
//    300 Multiple Choices
//    301 Moved Permanently
//    302 Found
//    303 See Other
//    304 Not Modified
//    305 Use Proxy
//    307 Temporary Redirect
//    400 Bad Request
//    401 Unauthorized
//    402 Payment Required
//    403 Forbidden
//    404 Not Found
//    405 Method Not Allowed
//    406 Not Acceptable
//    407 Proxy Authentication Required
//    408 Request Timeout
//    409 Conflict
//    410 Gone
//    411 Length Required
//    412 Precondition Failed
//    413 Request Entity Too Large
//    414 Request-URI Too Long
//    415 Unsupported Media Type
//    416 Requested Range Not Suitable
//    417 Expectation Failed
//    500 Internal Server Error
//    501 Not Implemented
//    502 Bad Gateway
//    503 Service Unavailable
//    504 Gateway Timeout
//    505 HTTP Version Not Supported
//
//  end;

end;

procedure TjsonConnection.CommitUpdates;
var
  sResultJSON: string;
begin
  DoBeforeCommitUpdates();
  if (FDeltaJSON <> '') then
  begin
    // 更新数据
    if (FConnectWeb) then
    begin
      sResultJSON := BatchUpdatesWeb();
    end
    else
    begin
      sResultJSON := BatchUpdatesFile();
    end;

    // 检查是否成功
    // CheckResult(sResultJSON);

    // 将返回信息制新数据
    RefreshDataSets(sResultJSON);

    // 将数据设为已更新成功
    SetDataSetsUpdatesOK();

    // 清空DeltaXML
    FDeltaJSON := '';
  end;
  DoAfterCommitUpdates();

end;

constructor TjsonConnection.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
//  FcdsResult := TCustomClientDataSet.Create(nil);
  FState := csDisconnect;
  FCreateRequestFile := false;
  FProviders := TList.Create;
  FAppServer := Self as IAppServer;
  // FBatchUpdates := true;
  if (Assigned(AOwner)) then
  begin
    for i := 0 to AOwner.ComponentCount - 1 do
      if AOwner.Components[i] is TCustomProvider then
        RegisterProvider(TCustomProvider(AOwner.Components[i]));
  end;

end;

destructor TjsonConnection.Destroy;
begin
//  FreeAndNil(FcdsResult);
  FProviders.Free;
  FAppServer := nil;
  inherited Destroy;
end;

procedure TjsonConnection.DoAfterCommitUpdates;
begin
  if Assigned(FAfterCommitUpdates) then
    FAfterCommitUpdates(Self);
end;

procedure TjsonConnection.DoBeforeCommitUpdates;
begin
  if Assigned(FBeforeCommitUpdates) then
    FBeforeCommitUpdates(Self);
end;

procedure TjsonConnection.DoStateChange;
begin
  if Assigned(FOnStateChange) then
    FOnStateChange(Self);
end;

procedure TjsonConnection.DownLoadFile(AURL, ASourceFileName,
  ATargetFileName: string);
begin

end;

function TjsonConnection.GetConnected: Boolean;
begin
  Result := true;
end;

function TjsonConnection.GetDataSetByCommitProvider(AProviderName: string)
  : TCustomClientDataSet;
var
  i: integer;
  cdsCurror: TDataSet;
  cdsResult: TCustomClientDataSet;
  sProviderName: string;
begin
  cdsResult := nil;
  for i := 0 to Self.DataSetCount - 1 do
  begin
    cdsCurror := Self.DataSets[i];
    if (cdsCurror.InheritsFrom(TjsonClientDataSet)) then
      sProviderName := TjsonClientDataSet(cdsCurror).CommitProvider
    else if (cdsCurror.InheritsFrom(TClientDataSet)) then
      sProviderName := TClientDataSet(cdsCurror).ProviderName;
    if (sProviderName = AProviderName) then
    begin
      cdsResult := TCustomClientDataSet(cdsCurror);
      break;
    end;
  end;
  Result := cdsResult;

end;

function TjsonConnection.GetDataSetByProvider(AProviderName: string)
  : TCustomClientDataSet;
var
  i: integer;
  cdsCurror: TDataSet;
  cdsResult: TCustomClientDataSet;
  sProviderName: string;
begin
  cdsResult := nil;
  for i := 0 to Self.DataSetCount - 1 do
  begin
    cdsCurror := Self.DataSets[i];
    if (cdsCurror.InheritsFrom(TjsonClientDataSet)) then
      sProviderName := TjsonClientDataSet(cdsCurror).ProviderName
    else if (cdsCurror.InheritsFrom(TClientDataSet)) then
      sProviderName := TClientDataSet(cdsCurror).ProviderName;
    if (sProviderName = AProviderName) then
    begin
      cdsResult := TCustomClientDataSet(cdsCurror);
      break;
    end;
  end;
  Result := cdsResult;

end;

function TjsonConnection.GetDeltaJSON(cdsDelta: TCustomClientDataSet;
  ProviderName: string): string;
var
  sXML: string;
  sRow: string;
  sChangeFields: string;
  sAllRow, tempAllRow: string;
  i, j: integer;
  MyField, fldSource: TField;
  cdsSource: TCustomClientDataSet;
  usCurr: TUpdateStatus;
  vFieldsValue: Variant;
  bCheckChange: Boolean;
  pkey, cdsName: String;
  isMerge: Boolean;
  row_dt:TDictionary<String,String>;
  looppair:TPair<String,String>;
begin
  // 取出原数据集
  cdsSource := GetDataSetByCommitProvider(ProviderName);
  cdsName := (cdsSource as TjsonClientDataSet).UpdateDataSet;
  // 是否检查原记录，检查原记录则将原记录与修改后记录分开2行，原记录取InKey、InWhere的内容，修改后记录取InUpdate的内容
  // 不检查原记录，则取原记录的InKey、修改后记录的InUpdate或没有被更新的原记录InWhere
  if (cdsSource is TjsonClientDataSet) then
  begin
    bCheckChange := (cdsSource as TjsonClientDataSet).CheckChange;
  end
  else
  begin
    bCheckChange := false;
  end;

  // 删除不保存的字段
  i := cdsDelta.Fields.Count - 1;
  while i >= 0 do
  begin
    MyField := cdsDelta.Fields.Fields[i];
    fldSource := cdsSource.FindField(MyField.FieldName);
    if ((fldSource = nil) or ((not(pfInUpdate in fldSource.ProviderFlags)) and
          (not(pfInKey in fldSource.ProviderFlags)) and (not bCheckChange) or
          (not(pfInWhere in fldSource.ProviderFlags)))) then
    begin
      cdsDelta.Fields.Remove(MyField);
    end
    else
    begin
      MyField.ProviderFlags := fldSource.ProviderFlags;
    end;
    // 记录主键字段
    // if (pfInKey in fldSource.ProviderFlags) then
    // pkey:= MyField.FieldName;
    Dec(i);
  end;

  // 创建字段值数组
  // vFieldsValue := VarArrayCreate([0, cdsDelta.Fields.Count - 1], varVariant);

  // 取字段信息 删掉了

  // 取记录内容
  j := 0;
  row_dt:=TDictionary<String,String>.create;
  cdsDelta.First();
  while (not cdsDelta.Eof) do
  begin
    usCurr := cdsDelta.UpdateStatus();

    case usCurr of
      usInserted:
        begin
          row_dt.Clear;
          sRow := cdsName + '[' + IntToStr(j) + '].opertype=4';
          for i := 0 to cdsDelta.Fields.Count - 1 do
          begin
            MyField := cdsDelta.Fields.Fields[i];
            if (not MyField.IsNull) and (MyField.FieldName<>'opertype') then
            begin
              { *Modify By HBin(黄斌) 2006-09-19
                解决转义符问题，将标志encrypt="true"的字段进行Base64加密
                * }
              if (TjsonClientDataSet(cdsDelta).EncryptFieldNames.IndexOf
                  (MyField.FieldName) < 0) then
                sRow := sRow + '&' + cdsName + '[' + IntToStr(j)
                  + '].' + MyField.FieldName + '=' + GetXMLFmtFieldValue
                  (MyField)
              else
                // 进行Base64加密转义
                sRow := sRow + '&' + cdsName + '[' + IntToStr(j)
                  + '].' + MyField.FieldName + '=' + Base64Encode
                  (MyField.AsString);
            end;
          end;
          j := j + 1;
        end;
      usUnmodified:
        begin
          row_dt.Clear;
          if (bCheckChange) then
          begin
            // 检查是否修改过，则分开2行(修改前)
            sRow := cdsName + '[' + IntToStr(j) + '].opertype=1';
            for i := 0 to cdsDelta.Fields.Count - 1 do
            begin
              MyField := cdsDelta.Fields.Fields[i];
              { * Modify By HBin(黄斌) 2006-09-19
                解决字段的更新问题（即没有修改过的值也要传到后台）即判断pfInUpdate为真时传到后台
                * }
              if ( (MyField.FieldName<>'opertype') and (pfInKey in MyField.ProviderFlags) or
                  (pfInWhere in MyField.ProviderFlags) or
                  (pfInUpdate in MyField.ProviderFlags)) then
              begin
                { *Modify By HBin(黄斌) 2006-09-19
                  解决转义符问题，将标志encrypt="true"的字段进行Base64加密
                  * }
                if (TjsonClientDataSet(cdsDelta).EncryptFieldNames.IndexOf
                    (MyField.FieldName) < 0) then
                begin
                  sRow := sRow + '&' + cdsName + '[' + IntToStr(j)
                    + '].' + MyField.FieldName + '=' + GetXMLFmtFieldValue
                    (MyField);
                end
                else
                begin
                  // 进行Base64加密转义
                  sRow := sRow + '&' + cdsName + '[' + IntToStr(j)
                    + '].' + MyField.FieldName + '=' + Base64Encode
                    (MyField.AsString);
                end;
              end;
            end;
          end
          else
          begin
            // 不检查则只有一行，取原记录的主键
            // sRow := '{"RowState":8';
            sRow := cdsName + '[' + IntToStr(j) + '].';
            for i := 0 to cdsDelta.Fields.Count - 1 do
            begin
              MyField := cdsDelta.Fields.Fields[i];
//              if (pfInKey in MyField.ProviderFlags) then
              if MyField.FieldName<>'opertype' then
              begin
                // 解决转义符问题，将标志encrypt="true"的字段进行Base64加密
                if (TjsonClientDataSet(cdsDelta).EncryptFieldNames.IndexOf
                    (MyField.FieldName) < 0) then
                begin
                  sRow := sRow + MyField.FieldName + '=' + GetXMLFmtFieldValue
                    (MyField);
                  row_dt.AddOrSetValue(cdsName + '[' + IntToStr(j) + '].' + MyField.FieldName,GetXMLFmtFieldValue(MyField));
                end
                else
                begin
                  // 进行Base64加密转义
                  sRow := sRow + MyField.FieldName + '=' + Base64Encode
                    (MyField.AsString);
                  row_dt.AddOrSetValue(cdsName + '[' + IntToStr(j) + '].' + MyField.FieldName,Base64Encode(MyField.AsString));
                end;
              end;
            end;
          end;
        end;
      usModified:
        begin
          sChangeFields := cdsName + '[' + IntToStr(j) + '].opertype=8';
          if (bCheckChange) then
          begin
            // 检查是否修改过，则分开2行(修改后)
            // sRow := '{"RowState":8';
            for i := 0 to cdsDelta.Fields.Count - 1 do
            begin
              MyField := cdsDelta.Fields.Fields[i];
              { * Modify By HBin(黄斌) 2006-09-19
                解决字段的更新问题（即没有修改过的值也要传到后台）即判断pfInUpdate为真时传到后台
                * }
              if ( (MyField.FieldName<>'opertype') and  (pfInUpdate in MyField.ProviderFlags)
              and    (not VarIsEmpty(MyField.NewValue))
              or     (pfInUpdate in MyField.ProviderFlags)
              ) then
              begin
                if (pfInKey in MyField.ProviderFlags) then
                begin
                  sRow := sRow + MyField.FieldName + '=' + GetXMLFmtFieldValue
                    (MyField) + ''
                end;
                { *Modify By HBin(黄斌) 2006-09-19
                  解决转义符问题，将标志encrypt="true"的字段进行Base64加密
                  * }
                // 先注释掉 del by lck
                if (TjsonClientDataSet(cdsDelta).EncryptFieldNames.IndexOf
                    (MyField.FieldName) < 0) then
                  sRow := sRow + MyField.FieldName + '=' + GetXMLFmtFieldValue
                    (MyField)
                else
                  // 进行Base64加密转义
                  sRow := sRow + MyField.FieldName + '=' + Base64Encode
                    (MyField.AsString);
              end;
            end;
          end
          else
          begin
            // sChangeFields := '';
            for i := 0 to cdsDelta.Fields.Count - 1 do
            begin
              MyField := cdsDelta.Fields.Fields[i];
              // 现主键为不可修改字段，故不检查主键
              if (not(pfInKey in MyField.ProviderFlags)) and (MyField.FieldName<>'opertype') then
              begin
                if (not VarIsEmpty(MyField.NewValue)) and (pfInUpdate in MyField.ProviderFlags) then
                begin
                  if (TjsonClientDataSet(cdsDelta).EncryptFieldNames.IndexOf
                      (MyField.FieldName) < 0) then
                  begin
                    sChangeFields := sChangeFields + '&' + cdsName + '[' +
                      IntToStr(j) + '].' + MyField.FieldName + '=' +
                      GetXMLFmtFieldValue(MyField);
                    row_dt.AddOrSetValue(cdsName + '[' + IntToStr(j) + '].' + MyField.FieldName,GetXMLFmtFieldValue(MyField));
                  end
                  else
                  begin
                    // 进行Base64加密转义
                    sChangeFields := sChangeFields + '&' + cdsName + '[' +
                      IntToStr(j) + '].' + MyField.FieldName + '=' +
                      Base64Encode(MyField.AsString);
                    row_dt.AddOrSetValue(cdsName + '[' + IntToStr(j) + '].' + MyField.FieldName,Base64Encode(MyField.AsString));
                  end;
                end;
              end;
            end;
            sRow := cdsName + '[' + IntToStr(j) + '].opertype=8';
            for looppair in row_dt do
            begin
                sRow := sRow + '&' + looppair.Key+'='+looppair.Value;
            end;

            // 只保存修改过的内容与必须存到后台的字段
//            if (sChangeFields = '') then
//              sRow := ''
//            else
//              sRow := sRow + '&' + sChangeFields;
          end;
          j := j + 1;
        end;
      usDeleted:
        begin
          row_dt.Clear;
          sRow := cdsName + '[' + IntToStr(j) + '].opertype=2';
          for i := 0 to cdsDelta.Fields.Count - 1 do
          begin
            MyField := cdsDelta.Fields.Fields[i];
            if (pfInKey in MyField.ProviderFlags) and (MyField.FieldName<>'opertype') then
            begin
              if (TjsonClientDataSet(cdsDelta).EncryptFieldNames.IndexOf
                  (MyField.FieldName) < 0) then
                sRow := sRow + '&' + cdsName + '[' + IntToStr(j)
                  + '].' + MyField.FieldName + '=' + GetXMLFmtFieldValue
                  (MyField)
              else
                // 进行Base64加密转义
                sRow := sRow + '&' + cdsName + '[' + IntToStr(j)
                  + '].' + MyField.FieldName + '=' + Base64Encode
                  (MyField.AsString);
            end;
          end;
          inc(j);
        end;
    end;
    if ((bCheckChange or (usCurr <> usUnmodified)) and (sRow <> '')) then
    begin
      sAllRow := sAllRow + '&' + sRow;
    end;

    cdsDelta.Next();
  end;
  // XML尾，当没有要保存的数据时将sXML清空
  sXML := sAllRow;
  /// if (sAllRow = '') then
  /// /   sXML := ''
  // else
  // sXML := '&'+cdsSource.Name+'={"DataSet":' + sXML + sAllRow + ',"ProvideName":"'+ProviderName+'"}';
  vFieldsValue := Unassigned;
  // sXML := StringReplace(sXML, '"', '''', [rfReplaceAll]);
  Result := sXML;

end;

function TjsonConnection.GetJSONFileName(APath, AProviderName, ARequest: string)
  : string;
var
  sFileName: string;
  cdsRequest: TCustomClientDataSet;
begin
  sFileName := APath + AProviderName + ARequest;
  if ((not FileExists(sFileName)) and FileExists(APath + 'REQUEST_DEFINE')) then
  begin
    // 不存在对应的文件则从请求定义中取
    cdsRequest := TCustomClientDataSet.Create(nil);
    try
      cdsRequest.LoadFromFile(APath + 'REQUEST_DEFINE.txt');
      cdsRequest.Active := true;
      // 因Locate中的内容有单引号时会出错，故将单引号改为2个单引号
      if (cdsRequest.Locate('CONTENT', StringReplace(ARequest, '''', '''''',
            [rfReplaceAll]), [])) then
      begin
        sFileName := APath + AProviderName + '&=' + cdsRequest.FieldByName
          ('REQUEST_CODE').AsString;
      end;
    finally
      FreeAndNil(cdsRequest);
    end;
  end;
  Result := sFileName;

end;

function TjsonConnection.GetParamStr(CommandText: string;
  Params: OleVariant): string;
var
  MyParams: TParams;
  sParams: string;
  i: integer;
begin
  // 取出参数
  sParams := '';
  if ((not VarIsNull(Params)) and (not VarIsEmpty(Params))) then
  begin
    MyParams := TParams.Create(nil);
    try
      UnpackParams(Params, MyParams);
      for i := 0 to MyParams.Count - 1 do
      begin
        if (MyParams.Items[i].ParamType = ptInput) and (not varisnull(MyParams.Items[i].Value)) and (not VarIsEmpty(MyParams.Items[i].Value)) then
          sParams := sParams + '&' + MyParams.Items[i].Name + '=' + SetXMLFmtValue(MyParams.Items[i].AsString,ftString);
      end;
    finally
      FreeAndNil(MyParams);
    end;
  end;
  if (CommandText <> '') then
  begin
    sParams := sParams + '&param=' + CommandText;
  end;
  Result := sParams;

end;

function TjsonConnection.GetProvider(const ProviderName: string)
  : TCustomProvider;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to FProviders.Count - 1 do
    if AnsiCompareText(TCustomProvider(FProviders[i]).Name, ProviderName)
      = 0 then
    begin
      Result := TCustomProvider(FProviders[i]);
      if not Result.Exported then
        Result := nil;
      Exit;
    end;
  if not Assigned(Result) then
    raise Exception.CreateResFmt(@SProviderNotExported, [ProviderName]);

end;

function TjsonConnection.GetProviderCount: integer;
begin
  Result := FProviders.Count;
end;

function TjsonConnection.GetProvidersName: string;
var
  sProviderNames: string;
  i: integer;
  dsCurror: TDataSet;
begin
  // 根据对应的数据集生成文件名前缀
  sProviderNames := '';
  for i := 0 to Self.DataSetCount - 1 do
  begin
    dsCurror := Self.DataSets[i];
    if (dsCurror.InheritsFrom(TjsonClientDataSet)) then
    begin
      if (sProviderNames = '') then
        sProviderNames := (dsCurror as TjsonClientDataSet).ProviderName
      else
        sProviderNames := sProviderNames + '#' +
          (dsCurror as TjsonClientDataSet).ProviderName;
    end;
  end;
  Result := sProviderNames;

end;

function TjsonConnection.GetServer: IAppServer;
begin
  Result := FAppServer;
end;

procedure TjsonConnection.RefreshDataSets(AResultJSON: string);
var
  sDataJSON: string;
begin
  sDataJSON := AResultJSON;
  /// /

end;

procedure TjsonConnection.RegisterProvider(Prov: TCustomProvider);
begin
  FProviders.Add(Prov);
end;

procedure TjsonConnection.SaveJSONFile(AJSON, AFileName: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := AJSON;
    sl.SaveToFile(AFileName);
  finally
    FreeAndNil(sl);
  end;

end;

procedure TjsonConnection.SetDataSetsUpdatesOK;
var
  dsCurror: TDataSet;
  xcdsCurror: TjsonClientDataSet;
  i: integer;
begin
  if (FBatchUpdates) then
  begin
    // 将对应的数据集保存更新
    for i := 0 to Self.DataSetCount - 1 do
    begin
      dsCurror := Self.DataSets[i];
      if (dsCurror.InheritsFrom(TjsonClientDataSet)) then
      begin
        xcdsCurror := TjsonClientDataSet(dsCurror);
        if (xcdsCurror.Active and (xcdsCurror.ChangeCount > 0)) then
        begin
          xcdsCurror.MergeChangeLog();
          xcdsCurror.CancelUpdates();
        end;
      end;
    end;
  end;

end;

procedure TjsonConnection.SetParams(json: ISuperObject; var Params: OleVariant);
var
  MyParams: TParams;
  ParamsName: string;
  i,p: integer;

begin

  // 取出参数
  if ((not VarIsNull(Params)) and (not VarIsEmpty(Params))) then
  begin
    MyParams := TParams.Create(nil);
    try
      UnpackParams(Params, MyParams);
      for i := 0 to MyParams.Count - 1 do
      begin
        try
          if (MyParams.Items[i].ParamType = ptOutput) then
          begin
            ParamsName:=MyParams.Items[i].Name;
            p:=pos('.',ParamsName);
            if (p>0) then
            begin
              ParamsName:=copy(ParamsName,1,p-1);
              if json[ParamsName].AsObject<>nil then
              begin
                if json[MyParams.Items[i].Name]=nil then
                  raise Exception.Create('返回值中不存在“'+MyParams.Items[i].Name+'”参数');
                if (MyParams.Items[i].DataType = ftBCD) then
                  MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsDouble
                else if (MyParams.Items[i].DataType = ftString) then
                  MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsString
                else if (MyParams.Items[i].DataType = ftDateTime) then
                  MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsString
                else
                  MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsString
              end;
            end
            else
            begin
              if json[MyParams.Items[i].Name]=nil then
                raise Exception.Create('返回值中不存在“'+MyParams.Items[i].Name+'”参数');
              if (MyParams.Items[i].DataType = ftBCD) then
                MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsDouble
              else if (MyParams.Items[i].DataType = ftString) then
                MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsString
              else if (MyParams.Items[i].DataType = ftDateTime) then
                MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsString
              else
                MyParams.Items[i].Value := json[MyParams.Items[i].Name].AsString
            end;
          end;
        except
          on E: Exception do
          begin
            raise Exception.Create(e.Message);
          end;
        end;
      end;
    finally
      Params := PackageParams(MyParams);
      FreeAndNil(MyParams);
    end;
  end;

end;

procedure TjsonConnection.SetResultData(AResultJSON: string;
  cdsResult: TCustomClientDataSet; var AErrorCount: integer);
var
  json: ISuperObject;
  sDataXML, strXML: string;
  psData: TParams;
  ss: TStringStream;
  tmpCds: TCustomClientDataSet;
begin

  try
    ss := TStringStream.Create(AResultJSON);
    cdsResult.Active := false;
    cdsResult.LoadFromStream(ss);

    FcdsResult.Active := true;
    // 将接收到的数据直接返回
    AErrorCount := 0;
  finally
    if (Assigned(ss)) then
    begin
      FreeAndNil(ss);
    end;
  end;

  { psData := TParams.Create();
    tmpCds := TCustomClientDataSet.Create(nil);
    try
    GetXMLValue(AResultJSON, 'DATASET', 0, psData, sDataXML);

    if (sDataXML <> '') then
    begin
    // 有字段信息才取返回数据信息
    if ((Pos('<FIELDS>', sDataXML) > 0) and (Pos('<FIELDS></FIELDS>',
    sDataXML) = 0)) then
    begin
    strXML := '<?xml version="1.0" encoding="gb2312" standalone="yes"?> ' +
    ' <DATAPACKET Version="2.0">' + sDataXML + '</DATAPACKET>';
    ss := TStringStream.Create(strXML);

    cdsResult.Active := false;
    cdsResult.LoadFromStream(ss);
    end;
    end;
    AErrorCount := 0;
    finally
    FreeAndNil(psData);
    if (Assigned(ss)) then
    begin
    FreeAndNil(ss);
    end;

    tmpCds.Free;
    end;

    json := TSuperObject.ParseString(PWideChar(AResultJSON), false);
    TTableJSon.CDSFromJSon(cdsResult, json);
    }
end;

procedure TjsonConnection.SetURLHost(const Value: string);
begin
  FURLHost := Value;
  FConnectWeb := (UpperCase(copy(FURLHost, 1, 7)) = 'HTTP://');
end;

function TjsonConnection.TransformUrl(URL: string): string;
begin
  Result := URL;
  if Pos('.action', URL) = 0 then
  begin
    Result := URL + '.action';
  end
end;

procedure TjsonConnection.UnRegisterProvider(Prov: TCustomProvider);
begin
  FProviders.Remove(Prov);
end;

end.
