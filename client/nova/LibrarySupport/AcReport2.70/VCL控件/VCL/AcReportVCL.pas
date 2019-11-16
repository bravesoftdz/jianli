unit AcReportVCL;

interface

uses Windows, Classes, Variants, SysUtils, AcReport_TLB_Int, ACRptUtilsInt, AC_DataListEx,
     DB, ADODB, CustAdoInt, AC_VarEx, ADOInt_AC;

type
  TAcReportVCL = class;

  TAcVclOnFunction = procedure (Sender: TAcReportVCL; const FuncName: string; P1, P2, P3: variant; var Value: variant) of object;
  TAcVclEvent = procedure (Sender: TAcReportVCL) of object;
  TAcVclOnCellModify = procedure (Sender: TAcReportVCL; ARow, ACol: integer; const AOldText, ANewText: string) of object;
  TAcVclOnGetCellModifyLog = procedure (Sender: TAcReportVCL; ARow, ACol: integer; RetLogList: IAcModifyLogList) of object;
  TAcVclOnMeasureCellModifyLog = procedure (Sender: TAcReportVCL; ARow, ACol: integer; var IfModiLogExist: boolean) of object;
  
  TAcReportVCL = class(TComponent)
  private
    FEngine: TAcRptEngine;
    FDatasets: TAcDataListEx;
    FVariants: TAcVariantsEx;
    FAutoSetFieldsAlias: boolean;
    FCustCopyDataset: boolean;
    FAppConnString: string;
    FOnFunction: TAcVclOnFunction;
    FAfterDesign: TAcVclEvent;
    FBeforePrint: TAcVclEvent;
    FAfterPrepare: TAcVclEvent;
    FBeforePrepare: TAcVclEvent;
    FAfterPrint: TAcVclEvent;
    FBeforeDesign: TAcVclEvent;
    FBeforePreview: TAcVclEvent;
    FOnCellModify: TAcVclOnCellModify;
    FOnGetCellModifyLog: TAcVclOnGetCellModifyLog;
    FOnMeasureCellModifyLog: TAcVclOnMeasureCellModifyLog;
    procedure CheckLastErrAndRaise;
    procedure FillPrintInfos;
    procedure FillVariants;
    function GetPreparedPagsCount: integer;
    procedure SetAppConnString(const Value: string);

    procedure DoOnFunc(ASender: TObject; const RptEngine: IAcRptEngine; 
                                                       const FuncName: WideString; P1: OleVariant;
                                                       P2: OleVariant; P3: OleVariant; 
                                                       var Value: OleVariant);
    procedure DoAfterPrint(ASender: TObject; const aRptEngine: IAcRptEngine);
    procedure DoBeforePrint(ASender: TObject; const aRptEngine: IAcRptEngine);
    procedure DoAfterDesign(ASender: TObject; const aRptEngine: IAcRptEngine);
    procedure DoBeforeDesign(ASender: TObject; const aRptEngine: IAcRptEngine);
    procedure DoAfterPrepare(ASender: TObject; const aRptEngine: IAcRptEngine);
    procedure DoBeforePrepare(ASender: TObject; const aRptEngine: IAcRptEngine);
    procedure DoBeforePreview(ASender: TObject; const aRptEngine: IAcRptEngine);

    procedure DoOnCellModify(ASender: TObject; const aRptEngine: IAcRptEngine; 
                                                         aRow: Integer; aCol: Integer; 
                                                         const aOldText: WideString;
                                                         const aNewText: WideString);
                                                         
    procedure DoOnGetCellModifyLog(ASender: TObject; const aRptEgine: IAcRptEngine;
                                                               aRow: Integer; aCol: Integer; 
                                                               const aLogList: IAcModifyLogList);
     procedure DoOnMeasureCellModifyLog(ASender: TObject; const aRptEngine: IAcRptEngine; aRow: Integer; aCol: Integer;
                                     var IfModiLogExist: WordBool);
    function GetShowProgress: boolean;
    procedure SetShowProgress(const Value: boolean);
  protected
    procedure Notification(AComponent: TComponent;
         Operation: TOperation); override;
    procedure Loaded; override;     
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Preview;
    procedure Print;
    procedure ShowDesigner;
    
    procedure CopyDatasetsToEngine;
    procedure FillDatasetsToEngine;
    procedure LoadFromFile(AFileName: string);
    procedure SaveToFile(AFileName: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromBlobField(ABlobField: TField;
       const ATitle: string = ''; const AIfDisableSaveToFile: boolean = true);
    procedure SaveToBlobField(ABlobField: TField);
    procedure PrepareReport;
    procedure PrintPrepared(ABeginPage, AEndPage, ACopies: integer);
    procedure AddVariant(VarName: string; Value: variant);
    procedure AddGlobalVariant(VarName: string; Value: variant);
    procedure ExportToACRFile(AFileName: string);
    procedure ExportToACRStream(AStream: TStream);
    procedure ExportToXlsField(AFileName: string);
    function Calac(AExpr: string): variant;
    procedure SetReportFile(FileName: string);

    property PreparedPagesCount: integer read GetPreparedPagsCount;
    property Engine: TAcRptEngine read FEngine;
  published
    property Datasets: TAcDataListEx read FDatasets write FDatasets;
    property Variants: TAcVariantsEx read FVariants write FVariants;
    property AutoSetFieldsAlias: boolean read FAutoSetFieldsAlias write FAutoSetFieldsAlias;
    property AppConnString: string read FAppConnString write SetAppConnString;
    property ShowProgress: boolean read GetShowProgress write SetShowProgress;
    property CustCopyDataset: boolean read FCustCopyDataset write FCustCopyDataset;
    property OnFunction: TAcVclOnFunction read FOnFunction write FOnFunction;
    property AfterPrint: TAcVclEvent read FAfterPrint write FAfterPrint;
    property BeforePrint: TAcVclEvent read FBeforePrint write FBeforePrint;
    property AfterDesign: TAcVclEvent read FAfterDesign write FAfterDesign;
    property BeforeDesign: TAcVclEvent read FBeforeDesign write FBeforeDesign;
    property BeforePreview: TAcVclEvent read FBeforePreview write FBeforePreview;
    property AfterPrepare: TAcVclEvent read FAfterPrepare write FAfterPrepare;
    property BeforePrepare: TAcVclEvent read FBeforePrepare write FBeforePrepare;
    property OnCellModify: TAcVclOnCellModify read FOnCellModify write FOnCellModify;
    property OnGetCellModifyLog: TAcVclOnGetCellModifyLog read FOnGetCellModifyLog write FOnGetCellModifyLog;
    property OnMeasureCellModifyLog: TAcVclOnMeasureCellModifyLog read FOnMeasureCellModifyLog write FOnMeasureCellModifyLog;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AcReportVCL', [TAcReportVCL]);
end;

type
  TRegProc = function (): integer;

function RegisterDll(FileName: string; var SErr: string): boolean;
var
   LibHandle: THandle;
   DllRegisterServer: TRegProc;
begin
    Result := False;
    if not FileExists(FileName) then
    begin
      SErr := '文件不存在! ' + FileName;
      Exit;
    end;
    LibHandle := LoadLibrary(PChar(FileName));
    try
      DllRegisterServer := GetProcAddress(LibHandle, 'DllRegisterServer');
      if @DllRegisterServer = nil then
        SErr := Format('无法在 "%s" 中找到 DllRegisterServer 函数', [FileName]);
      if DllRegisterServer <> S_OK then
        SErr := Format('无法从 "%s" 中调用 DllRegisterServer 函数', [FileName]);
      Result := True;
    finally
      FreeLibrary(LibHandle);
    end;
end;

{ TAcReportVCL }

procedure TAcReportVCL.AddGlobalVariant(VarName: string; Value: variant);
begin
  FEngine.AddGlobalVariable(VarName, Value)
end;

procedure TAcReportVCL.AddVariant(VarName: string; Value: variant);
begin
   FVariants.SetVariant(VarName, Value)
end;

function TAcReportVCL.Calac(AExpr: string): variant;
begin
  Result := FEngine.Calac(AExpr); 
end;

procedure TAcReportVCL.CheckLastErrAndRaise;
var
  ErrCode: integer;
  ErrMsg: WideString;
begin
  FEngine.GetLastError(ErrCode, ErrMsg);
  if ErrCode <> 0 then
    raise Exception.Create(ErrMsg); 
end;

procedure TAcReportVCL.Clear;
begin
  FEngine.ClearContents
end;

constructor TAcReportVCL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEngine := TAcRptEngine.Create(nil);
  FDatasets := TAcDataListEx.Create(Self);
  FVariants := TAcVariantsEx.Create(Self); 
  FAutoSetFieldsAlias := true;
  FCustCopyDataset := false;
  FEngine.OnFunction := DoOnFunc;
  FEngine.OnAfterPrint := DoAfterPrint;
  FEngine.OnBeforePrint := DoBeforePrint;
  FEngine.OnAfterDesign := DoAfterDesign;
  FEngine.OnBeforeDesign := DoBeforeDesign;
  FEngine.OnBeforePreview := DoBeforePreview;
  FEngine.OnAfterPrepare := DoAfterPrepare;
  FEngine.OnBeforePrepare := DoBeforePrepare;
  FEngine.OnCellModify := DoOnCellModify;
  FEngine.OnGetCellModifyLog := DoOnGetCellModifyLog;
  FEngine.OnMeasureCellModifyLog := DoOnMeasureCellModifyLog;
end;

destructor TAcReportVCL.Destroy;
begin
  FEngine.Init;
  FDatasets.Free;
  FVariants.Free;
  FEngine.Free;
  inherited;
end;

procedure TAcReportVCL.DoAfterDesign(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FAfterDesign) then
    FAfterDesign(Self);
end;

procedure TAcReportVCL.DoAfterPrepare(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FAfterPrepare) then
    FAfterPrepare(Self);
end;

procedure TAcReportVCL.DoAfterPrint(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FAfterPrint) then
    FAfterPrint(Self);
end;

procedure TAcReportVCL.DoBeforeDesign(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FBeforeDesign) then
    FBeforeDesign(Self);
end;

procedure TAcReportVCL.DoBeforePrepare(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FBeforePrepare) then
    FBeforePrepare(Self);
end;

procedure TAcReportVCL.DoBeforePreview(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FBeforePreview) then
    FBeforePreview(Self);
end;

procedure TAcReportVCL.DoBeforePrint(ASender: TObject;
  const aRptEngine: IAcRptEngine);
begin
  if Assigned(FBeforePrint) then
    FBeforePrint(Self);
end;

procedure TAcReportVCL.DoOnCellModify(ASender: TObject;
  const aRptEngine: IAcRptEngine; aRow, aCol: Integer; const aOldText,
  aNewText: WideString);
begin
  if Assigned(FOnCellModify) then
    FOnCellModify(Self, ARow, ACol, AOldText, ANewText);
end;

procedure TAcReportVCL.DoOnFunc(ASender: TObject;
  const RptEngine: IAcRptEngine; const FuncName: WideString; P1, P2,
  P3: OleVariant; var Value: OleVariant);
var
  V: Variant;
begin
  if Assigned(FOnFunction) then
  begin
    V := Value;
    FOnFunction(Self, FuncName, P1, P2, P3, V);
    Value := V;
  end;
end;

procedure TAcReportVCL.DoOnGetCellModifyLog(ASender: TObject;
  const aRptEgine: IAcRptEngine; aRow, aCol: Integer;
  const aLogList: IAcModifyLogList);
begin
  if Assigned(FOnGetCellModifyLog) then
    FOnGetCellModifyLog(Self, ARow, ACol, ALogList);
end;

procedure TAcReportVCL.DoOnMeasureCellModifyLog(ASender: TObject;
  const aRptEngine: IAcRptEngine; aRow, aCol: Integer;
  var IfModiLogExist: WordBool);
var
  b: boolean;
begin
  if Assigned(FOnMeasureCellModifyLog) then
  begin
    b := IfModiLogExist;
    FOnMeasureCellModifyLog(Self, ARow, ACol, b);
    IfModiLogExist := b;
  end;
end;

procedure TAcReportVCL.ExportToACRFile(AFileName: string);
begin
  if FEngine.PreparedPagesCount <= 0 then
    raise Exception.Create('尚未生成报表文档,请先调用PrepareReport'); 
  FEngine.ExportToACR(AFileName);
end;

procedure TAcReportVCL.ExportToACRStream(AStream: TStream);
begin
  if FEngine.PreparedPagesCount <= 0 then
    raise Exception.Create('尚未生成报表文档,请先调用PrepareReport'); 
end;

procedure TAcReportVCL.ExportToXlsField(AFileName: string);
begin
  if FEngine.PreparedPagesCount <= 0 then
    raise Exception.Create('尚未生成报表文档,请先调用PrepareReport');
  FEngine.ExportToXls(AFileName);   
end;

procedure TAcReportVCL.CopyDatasetsToEngine;
begin
  FCustCopyDataset := true;
  FillDatasetsToEngine;
end;

procedure TAcReportVCL.FillDatasetsToEngine;
var
  i: integer;
  
  procedure _SetFieldsAlias(ADataItem: TAcDataItemEx);
  var
    ii: integer;
    sFields, sAlias: string;
  begin
    if ADataItem.DataSet.FieldCount <= 0 then
      Exit;
    sFields := ''; sAlias := '';  
    for ii := 0 to ADataItem.DataSet.FieldCount - 1 do
    begin
      sFields := sFields + ',' + ADataItem.DataSet.Fields[ii].FieldName;
      sAlias := sAlias + ',' + ADataItem.DataSet.Fields[ii].DisplayLabel;
    end;
    Delete(sFields, 1, 1);
    Delete(sAlias, 1, 1);
    FEngine.SetDataFieldAliasName(ADataItem.DispName, sFields, sAlias); 
  end;

begin
  if not FCustCopyDataset then
    Exit;

  FEngine.Init;
  FillVariants;

  for i := 0 to Datasets.Count - 1 do
  begin
    if Datasets[i].DataSet = nil then
      Continue;
    if ((Datasets[i].DataSet is TADODataset) or (Datasets[i].DataSet is TADOTable) or
      (Datasets[i].DataSet is TADOQuery)) and Datasets[i].UseADOInterface then
    begin
      FEngine.AddDataset(Datasets[i].DispName, TADODataset(Datasets[i].DataSet).Recordset);
      if Self.FAutoSetFieldsAlias then
        _SetFieldsAlias(Datasets[i]);
    end
    else
    begin
      AddCommonDatasetToAcReport(Datasets[i].DataSet, FEngine, Datasets[i].DispName, FAutoSetFieldsAlias, false);
    end;     
  end;
end;

procedure TAcReportVCL.FillPrintInfos;
var
  i: integer;
  
  procedure _SetFieldsAlias(ADataItem: TAcDataItemEx);
  var
    ii: integer;
    sFields, sAlias: string;
  begin
    if ADataItem.DataSet.FieldCount <= 0 then
      Exit;
    sFields := ''; sAlias := '';  
    for ii := 0 to ADataItem.DataSet.FieldCount - 1 do
    begin
      sFields := sFields + ',' + ADataItem.DataSet.Fields[ii].FieldName;
      sAlias := sAlias + ',' + ADataItem.DataSet.Fields[ii].DisplayLabel;
    end;
    Delete(sFields, 1, 1);
    Delete(sAlias, 1, 1);
    FEngine.SetDataFieldAliasName(ADataItem.DispName, sFields, sAlias); 
  end;

begin
  
  if FCustCopyDataset then
    Exit;

  FEngine.Init;
  FillVariants;

  for i := 0 to Datasets.Count - 1 do
  begin
    if Datasets[i].DataSet = nil then
      Continue;
    if ((Datasets[i].DataSet is TADODataset) or (Datasets[i].DataSet is TADOTable) or
      (Datasets[i].DataSet is TADOQuery)) and Datasets[i].UseADOInterface then
    begin
      Datasets[i].DataSet.Open;
      FEngine.AddDataset(Datasets[i].DispName, TADODataset(Datasets[i].DataSet).Recordset);
      if Self.FAutoSetFieldsAlias then
        _SetFieldsAlias(Datasets[i]);
    end
    else
    begin
     // AddCommonDatasetToAcReport(Datasets[i].DataSet, FEngine, Datasets[i].DispName, FAutoSetFieldsAlias, false);
      if Datasets[i].FProxDataset <> nil then
      begin
        Datasets[i].FProxDataset.Free;
        Datasets[i].FProxDataset := nil;
      end;
      Datasets[i].DataSet.Open;
      Datasets[i].FProxDataset := TAcProxDataset.Create(Datasets[i].DataSet);
      FEngine.AddDataset(Datasets[i].DispName, _RecordSet(Datasets[i].FProxDataset));
      if Self.FAutoSetFieldsAlias then
        _SetFieldsAlias(Datasets[i]);
    end;     
  end;
end;


function TAcReportVCL.GetPreparedPagsCount: integer;
begin
  Result := FEngine.PreparedPagesCount;
end;

function TAcReportVCL.GetShowProgress: boolean;
begin
  Result := FEngine.ShowProgress;
end;

procedure TAcReportVCL.Loaded;
begin
  inherited;
  FEngine.SetAppConnectionString(FAppConnString); 
end;

procedure TAcReportVCL.LoadFromBlobField(ABlobField: TField;
  const ATitle: string = ''; const AIfDisableSaveToFile: boolean = true);
begin
  AcRptUtilsInt.LoadAcFromCommonBlobField(FEngine, ABlobField, ATitle, AIfDisableSaveToFile);
end;

procedure TAcReportVCL.LoadFromFile(AFileName: string);
begin
  if FEngine.LoadFromFile(AFileName) <> 0 then
    CheckLastErrAndRaise;
end;

procedure TAcReportVCL.LoadFromStream(AStream: TStream);
begin
  AcRptUtilsInt.LoadAcFromStream(FEngine, AStream);
end;

procedure TAcReportVCL.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I :integer;
begin
  if (Operation = opRemove) then
  if (AComponent is TDataSet) then
  begin
    for I :=0 to FDataSets.Count -1 do
      if (AComponent = FDataSets[I].DataSet) then
       begin
         FDataSets[I].DataSet := nil;
       end;
   end;
   
 inherited Notification(AComponent, Operation);
end;

procedure TAcReportVCL.PrepareReport;
begin
  FillPrintInfos;
  FEngine.PrintReport;
end;

procedure TAcReportVCL.Preview;
begin
  FillPrintInfos;
  FEngine.Preview;
end;

procedure TAcReportVCL.Print;
begin
  FillPrintInfos;
  FEngine.Print;
end;

procedure TAcReportVCL.PrintPrepared(ABeginPage, AEndPage,
  ACopies: integer);
begin
  if FEngine.PreparedPagesCount <= 0 then
    raise Exception.Create('尚未生成报表文档,请先调用PrepareReport');
  FEngine.PrintPrepared(ABeginPage, AEndPage, ACopies);   
end;

procedure TAcReportVCL.SaveToBlobField(ABlobField: TField);
begin
  AcRptUtilsInt.SaveAcToCommonBlobField(FEngine, ABlobField);
end;

procedure TAcReportVCL.SaveToFile(AFileName: string);
begin
  if FEngine.SaveToFile(AFileName) <> 0 then
    CheckLastErrAndRaise;
end;

procedure TAcReportVCL.SaveToStream(AStream: TStream);
begin
  AcRptUtilsInt.SaveAcToStream(FEngine, AStream);
end;

procedure TAcReportVCL.SetAppConnString(const Value: string);
begin
  FAppConnString := Value;
  FEngine.SetAppConnectionString(Value);
end;

procedure TAcReportVCL.SetReportFile(FileName: string);
begin
  FEngine.SetReportFile(FileName) 
end;

procedure TAcReportVCL.SetShowProgress(const Value: boolean);
begin
  FEngine.ShowProgress := Value;
end;

procedure TAcReportVCL.ShowDesigner;
begin
  FillPrintInfos;
  FEngine.ShowDesigner;
end;

procedure TAcReportVCL.FillVariants;
var
  i: integer;
begin
  for i := 0 to FVariants.Count - 1 do
  begin
    FEngine.AddVariable(FVariants.Items[i].Name, FVariants.Items[i].Value)
  end;
end;

var
  s: string;

initialization

  RegisterDll(ExtractFilePath(ParamStr(0)) + 'AcReport.dll', s);

end.
