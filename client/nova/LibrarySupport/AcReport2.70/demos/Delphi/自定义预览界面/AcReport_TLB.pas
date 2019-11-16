unit AcReport_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2011-01-15 14:27:13 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\work\source\ACreport\COM\com\AcReport.dll (1)
// LIBID: {6D29DD74-860E-48A1-B552-8D5A7DD855EA}
// LCID: 0
// Helpfile: 
// HelpString: AcReportEngine Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AcReportMajorVersion = 1;
  AcReportMinorVersion = 0;

  LIBID_AcReport: TGUID = '{6D29DD74-860E-48A1-B552-8D5A7DD855EA}';

  IID_ICustDataBuilder: TGUID = '{A888B5E7-D62D-4C43-9452-DCD227E1CF86}';
  CLASS_CustDataBuilder: TGUID = '{6627DF35-535B-486B-9923-42582F6CC739}';
  IID_IAcRptEngine: TGUID = '{78DD38D7-B85E-4075-893E-6639C23EA85E}';
  DIID_IAcRptEngineEvent: TGUID = '{8DA3E9E6-EDDF-4476-B365-37AE086D86B2}';
  DIID_IAcRptEngineEventDispatch: TGUID = '{F3FCC57F-C4F1-4D79-ABBB-08F2221C21E0}';
  CLASS_AcRptEngine: TGUID = '{C84DF69C-0227-4846-919B-6B31168FE68A}';
  IID_IAcFunctionLib: TGUID = '{5FC54D86-74B9-46F4-B1DD-24C8127EC5E0}';
  IID_IAcCell: TGUID = '{6F6230E0-99A0-4585-A091-0490A3FCA98B}';
  IID_IAcLine: TGUID = '{B4FBA785-0ED1-49B1-8EEA-03990448ED41}';
  IID_IAcRptPage: TGUID = '{2CF7026D-4B4A-441F-86BA-07856E31371B}';
  IID_IAcModifyLogList: TGUID = '{27D6DF05-6FC9-4614-86E3-B9FC0B5B25E8}';
  IID_IAcNetStream: TGUID = '{DA567CA9-BD8E-44CB-B2BF-17EA6F6DBB34}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum AcPageType
type
  AcPageType = TOleEnum;
const
  aptReport = $00000000;
  aptDialog = $00000001;

// Constants for enum SeekOrg
type
  SeekOrg = TOleEnum;
const
  asoFromBeginning = $00000000;
  asoFromCurrent = $00000001;
  asoFromEnd = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICustDataBuilder = interface;
  ICustDataBuilderDisp = dispinterface;
  IAcRptEngine = interface;
  IAcRptEngineDisp = dispinterface;
  IAcRptEngineEvent = dispinterface;
  IAcRptEngineEventDispatch = dispinterface;
  IAcFunctionLib = interface;
  IAcFunctionLibDisp = dispinterface;
  IAcCell = interface;
  IAcCellDisp = dispinterface;
  IAcLine = interface;
  IAcLineDisp = dispinterface;
  IAcRptPage = interface;
  IAcRptPageDisp = dispinterface;
  IAcModifyLogList = interface;
  IAcModifyLogListDisp = dispinterface;
  IAcNetStream = interface;
  IAcNetStreamDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CustDataBuilder = ICustDataBuilder;
  AcRptEngine = IAcRptEngine;


// *********************************************************************//
// Interface: ICustDataBuilder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A888B5E7-D62D-4C43-9452-DCD227E1CF86}
// *********************************************************************//
  ICustDataBuilder = interface(IDispatch)
    ['{A888B5E7-D62D-4C43-9452-DCD227E1CF86}']
    procedure RemoveAllTables; safecall;
    procedure NewTable(const aTableName: WideString); safecall;
    procedure RemoveTable(const aTableName: WideString); safecall;
    procedure OpenTable(const aTableName: WideString); safecall;
    procedure CloseTable(const aTableName: WideString); safecall;
    procedure AddStringField(const aTableName: WideString; const aFieldName: WideString; 
                             aLength: Integer); safecall;
    procedure AddIntegerField(const aTableName: WideString; const aFieldName: WideString); safecall;
    procedure AddFloatField(const aTableName: WideString; const aFieldName: WideString); safecall;
    procedure AddDateTimeField(const aTableName: WideString; const aFieldName: WideString); safecall;
    procedure AppendRow(const aTableName: WideString; FieldValues: OleVariant); safecall;
    procedure SetCurrentRowValues(const aTableName: WideString; FieldValues: OleVariant); safecall;
    procedure AppendEmptyRow(const aTableName: WideString); safecall;
    procedure DeleteRow(const aTableName: WideString); safecall;
    procedure MoveFirst(const aTableName: WideString); safecall;
    procedure MoveLast(const aTableName: WideString); safecall;
    procedure MoveNext(const aTableName: WideString); safecall;
    procedure MovePrior(const aTableName: WideString); safecall;
    function SetFieldValue(aTableId: OleVariant; aFieldId: OleVariant; Value: OleVariant): HResult; safecall;
    function GetFieldValue(aTableId: OleVariant; aFieldId: OleVariant): OleVariant; safecall;
    function GetTableName(aIndex: Integer): WideString; safecall;
    function GetTableCount: Integer; safecall;
    function GetRecordCount(const aTableName: WideString): Integer; safecall;
    function IsBOF(const aTableName: WideString): WordBool; safecall;
    function IsEOF(const aTableName: WideString): WordBool; safecall;
    procedure SetStringFieldValue(const aTableName: WideString; const aFieldName: WideString; 
                                  const Value: WideString); safecall;
    function TableExist(const TableName: WideString): WordBool; safecall;
    procedure SetBlobField(const aTableName: WideString; const aFieldName: WideString; 
                           const aStream: IAcNetStream); safecall;
    procedure GetblobField(const aTableName: WideString; const aFieldName: WideString; 
                           const aStream: IAcNetStream); safecall;
    procedure AddBlobField(const aTableName: WideString; const aFieldName: WideString); safecall;
    function SetCurrentTable(const TableName: WideString): Integer; safecall;
    function GetTableIndex(const TableName: WideString): Integer; safecall;
    procedure AddVariantField(const aTableName: WideString; const aFieldName: WideString); safecall;
    procedure SetFieldAsString(aTableId: OleVariant; aFieldId: OleVariant; const Value: WideString); safecall;
    procedure AddBooleanField(const aTableName: WideString; const aFieldName: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  ICustDataBuilderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A888B5E7-D62D-4C43-9452-DCD227E1CF86}
// *********************************************************************//
  ICustDataBuilderDisp = dispinterface
    ['{A888B5E7-D62D-4C43-9452-DCD227E1CF86}']
    procedure RemoveAllTables; dispid 201;
    procedure NewTable(const aTableName: WideString); dispid 202;
    procedure RemoveTable(const aTableName: WideString); dispid 203;
    procedure OpenTable(const aTableName: WideString); dispid 204;
    procedure CloseTable(const aTableName: WideString); dispid 205;
    procedure AddStringField(const aTableName: WideString; const aFieldName: WideString; 
                             aLength: Integer); dispid 206;
    procedure AddIntegerField(const aTableName: WideString; const aFieldName: WideString); dispid 207;
    procedure AddFloatField(const aTableName: WideString; const aFieldName: WideString); dispid 208;
    procedure AddDateTimeField(const aTableName: WideString; const aFieldName: WideString); dispid 209;
    procedure AppendRow(const aTableName: WideString; FieldValues: OleVariant); dispid 210;
    procedure SetCurrentRowValues(const aTableName: WideString; FieldValues: OleVariant); dispid 211;
    procedure AppendEmptyRow(const aTableName: WideString); dispid 212;
    procedure DeleteRow(const aTableName: WideString); dispid 213;
    procedure MoveFirst(const aTableName: WideString); dispid 214;
    procedure MoveLast(const aTableName: WideString); dispid 215;
    procedure MoveNext(const aTableName: WideString); dispid 216;
    procedure MovePrior(const aTableName: WideString); dispid 217;
    function SetFieldValue(aTableId: OleVariant; aFieldId: OleVariant; Value: OleVariant): HResult; dispid 218;
    function GetFieldValue(aTableId: OleVariant; aFieldId: OleVariant): OleVariant; dispid 219;
    function GetTableName(aIndex: Integer): WideString; dispid 220;
    function GetTableCount: Integer; dispid 221;
    function GetRecordCount(const aTableName: WideString): Integer; dispid 222;
    function IsBOF(const aTableName: WideString): WordBool; dispid 223;
    function IsEOF(const aTableName: WideString): WordBool; dispid 225;
    procedure SetStringFieldValue(const aTableName: WideString; const aFieldName: WideString; 
                                  const Value: WideString); dispid 224;
    function TableExist(const TableName: WideString): WordBool; dispid 226;
    procedure SetBlobField(const aTableName: WideString; const aFieldName: WideString; 
                           const aStream: IAcNetStream); dispid 227;
    procedure GetblobField(const aTableName: WideString; const aFieldName: WideString; 
                           const aStream: IAcNetStream); dispid 228;
    procedure AddBlobField(const aTableName: WideString; const aFieldName: WideString); dispid 229;
    function SetCurrentTable(const TableName: WideString): Integer; dispid 230;
    function GetTableIndex(const TableName: WideString): Integer; dispid 231;
    procedure AddVariantField(const aTableName: WideString; const aFieldName: WideString); dispid 232;
    procedure SetFieldAsString(aTableId: OleVariant; aFieldId: OleVariant; const Value: WideString); dispid 233;
    procedure AddBooleanField(const aTableName: WideString; const aFieldName: WideString); dispid 234;
  end;

// *********************************************************************//
// Interface: IAcRptEngine
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {78DD38D7-B85E-4075-893E-6639C23EA85E}
// *********************************************************************//
  IAcRptEngine = interface(IDispatch)
    ['{78DD38D7-B85E-4075-893E-6639C23EA85E}']
    procedure Init; safecall;
    procedure AddDataset(const DatasetName: WideString; AdoRecord: OleVariant); safecall;
    procedure AddVariable(const VarName: WideString; Value: OleVariant); safecall;
    procedure AddGlobalVariable(const VarName: WideString; Value: OleVariant); safecall;
    procedure SetReportFile(const AptFileName: WideString); safecall;
    function AddDatasetRelation(const MasterName: WideString; const DetailName: WideString; 
                                const Relation: WideString): Integer; safecall;
    function PrepareReport: HResult; safecall;
    procedure Print; safecall;
    procedure PrintReport; safecall;
    procedure PrintPrepared(BeginPage: Integer; EndPage: Integer; Copies: Integer); safecall;
    procedure Preview; safecall;
    procedure ShowDesigner; safecall;
    procedure ExportToXls(const aFileName: WideString); safecall;
    function Calac(const aExpr: WideString): OleVariant; safecall;
    function CalacOPZ(const aExpr: WideString): OleVariant; safecall;
    function Get_PreparedPagesCount: Integer; safecall;
    function Get_CustDataBuilder: ICustDataBuilder; safecall;
    function Get_GlobalCustDataBuilder: ICustDataBuilder; safecall;
    procedure ExportToACR(const aFileName: WideString); safecall;
    procedure ExportToHTML(const aFileName: WideString); safecall;
    procedure AddFunctionLib(const aFuncLib: IAcFunctionLib; aGroupID: Integer); safecall;
    procedure RemoveFuncionLib(const aFuncLib: IAcFunctionLib); safecall;
    procedure RemoveFuncLibGroup(aGroup: Integer); safecall;
    procedure AddFunctionName(aFuncKind: Integer; const aFuncName: WideString; 
                              const aParamDesc: WideString; const aFuncDesc: WideString); safecall;
    function Get_LinesCount: Integer; safecall;
    function GetLineX(aIndex: Integer): IAcLine; safecall;
    function GetCellX(Row: Integer; Col: Integer): IAcCell; safecall;
    function Get_SubPageCount: Integer; safecall;
    function GetSubPage(aIndex: Integer): IAcRptPage; safecall;
    function LoadFromFile(const aFileName: WideString): HResult; safecall;
    function SaveToFile(const aFileName: WideString): HResult; safecall;
    function LoadFromBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString; 
                               const RepTitle: WideString): HResult; safecall;
    function SaveToBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString): HResult; safecall;
    function LoadFromStream(const aStream: IUnknown): HResult; safecall;
    function SaveToStream(const aStream: IUnknown): HResult; safecall;
    procedure GetLastError(var ErrorCode: Integer; var ErrorMsg: WideString); safecall;
    function LoadFromURL(const URL: WideString): HResult; safecall;
    function ClearDataRelations: HResult; safecall;
    procedure SetAppConnectionString(const ConnString: WideString); safecall;
    procedure SetRegisterInfo(const RegCode: WideString; const UserName: WideString; 
                              const AttachCode: WideString; const Addr: WideString; 
                              const EMail: WideString; const Phone: WideString; 
                              const Fax: WideString; var ErrCode: Integer; var ErrMsg: WideString); safecall;
    function SetDataFieldAliasName(const DatasetName: WideString; const FieldNames: WideString; 
                                   const FieldAliasNames: WideString): HResult; safecall;
    function Get_DisableSaveToFile: WordBool; safecall;
    procedure Set_DisableSaveToFile(Value: WordBool); safecall;
    function ClearContents: HResult; safecall;
    function Get_ShowPreviewOnPrepare: WordBool; safecall;
    procedure Set_ShowPreviewOnPrepare(Value: WordBool); safecall;
    function ExportToAcrStream(const aStream: IAcNetStream): HResult; safecall;
    function Get_ShowProgress: WordBool; safecall;
    procedure Set_ShowProgress(Value: WordBool); safecall;
    property PreparedPagesCount: Integer read Get_PreparedPagesCount;
    property CustDataBuilder: ICustDataBuilder read Get_CustDataBuilder;
    property GlobalCustDataBuilder: ICustDataBuilder read Get_GlobalCustDataBuilder;
    property LinesCount: Integer read Get_LinesCount;
    property SubPageCount: Integer read Get_SubPageCount;
    property DisableSaveToFile: WordBool read Get_DisableSaveToFile write Set_DisableSaveToFile;
    property ShowPreviewOnPrepare: WordBool read Get_ShowPreviewOnPrepare write Set_ShowPreviewOnPrepare;
    property ShowProgress: WordBool read Get_ShowProgress write Set_ShowProgress;
  end;

// *********************************************************************//
// DispIntf:  IAcRptEngineDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {78DD38D7-B85E-4075-893E-6639C23EA85E}
// *********************************************************************//
  IAcRptEngineDisp = dispinterface
    ['{78DD38D7-B85E-4075-893E-6639C23EA85E}']
    procedure Init; dispid 201;
    procedure AddDataset(const DatasetName: WideString; AdoRecord: OleVariant); dispid 202;
    procedure AddVariable(const VarName: WideString; Value: OleVariant); dispid 203;
    procedure AddGlobalVariable(const VarName: WideString; Value: OleVariant); dispid 204;
    procedure SetReportFile(const AptFileName: WideString); dispid 205;
    function AddDatasetRelation(const MasterName: WideString; const DetailName: WideString; 
                                const Relation: WideString): Integer; dispid 206;
    function PrepareReport: HResult; dispid 207;
    procedure Print; dispid 208;
    procedure PrintReport; dispid 209;
    procedure PrintPrepared(BeginPage: Integer; EndPage: Integer; Copies: Integer); dispid 210;
    procedure Preview; dispid 211;
    procedure ShowDesigner; dispid 212;
    procedure ExportToXls(const aFileName: WideString); dispid 213;
    function Calac(const aExpr: WideString): OleVariant; dispid 214;
    function CalacOPZ(const aExpr: WideString): OleVariant; dispid 215;
    property PreparedPagesCount: Integer readonly dispid 217;
    property CustDataBuilder: ICustDataBuilder readonly dispid 216;
    property GlobalCustDataBuilder: ICustDataBuilder readonly dispid 218;
    procedure ExportToACR(const aFileName: WideString); dispid 219;
    procedure ExportToHTML(const aFileName: WideString); dispid 220;
    procedure AddFunctionLib(const aFuncLib: IAcFunctionLib; aGroupID: Integer); dispid 221;
    procedure RemoveFuncionLib(const aFuncLib: IAcFunctionLib); dispid 222;
    procedure RemoveFuncLibGroup(aGroup: Integer); dispid 223;
    procedure AddFunctionName(aFuncKind: Integer; const aFuncName: WideString; 
                              const aParamDesc: WideString; const aFuncDesc: WideString); dispid 224;
    property LinesCount: Integer readonly dispid 225;
    function GetLineX(aIndex: Integer): IAcLine; dispid 226;
    function GetCellX(Row: Integer; Col: Integer): IAcCell; dispid 227;
    property SubPageCount: Integer readonly dispid 228;
    function GetSubPage(aIndex: Integer): IAcRptPage; dispid 229;
    function LoadFromFile(const aFileName: WideString): HResult; dispid 230;
    function SaveToFile(const aFileName: WideString): HResult; dispid 231;
    function LoadFromBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString; 
                               const RepTitle: WideString): HResult; dispid 232;
    function SaveToBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString): HResult; dispid 233;
    function LoadFromStream(const aStream: IUnknown): HResult; dispid 234;
    function SaveToStream(const aStream: IUnknown): HResult; dispid 235;
    procedure GetLastError(var ErrorCode: Integer; var ErrorMsg: WideString); dispid 236;
    function LoadFromURL(const URL: WideString): HResult; dispid 237;
    function ClearDataRelations: HResult; dispid 238;
    procedure SetAppConnectionString(const ConnString: WideString); dispid 239;
    procedure SetRegisterInfo(const RegCode: WideString; const UserName: WideString; 
                              const AttachCode: WideString; const Addr: WideString; 
                              const EMail: WideString; const Phone: WideString; 
                              const Fax: WideString; var ErrCode: Integer; var ErrMsg: WideString); dispid 240;
    function SetDataFieldAliasName(const DatasetName: WideString; const FieldNames: WideString; 
                                   const FieldAliasNames: WideString): HResult; dispid 241;
    property DisableSaveToFile: WordBool dispid 242;
    function ClearContents: HResult; dispid 243;
    property ShowPreviewOnPrepare: WordBool dispid 244;
    function ExportToAcrStream(const aStream: IAcNetStream): HResult; dispid 245;
    property ShowProgress: WordBool dispid 246;
  end;

// *********************************************************************//
// DispIntf:  IAcRptEngineEvent
// Flags:     (4096) Dispatchable
// GUID:      {8DA3E9E6-EDDF-4476-B365-37AE086D86B2}
// *********************************************************************//
  IAcRptEngineEvent = dispinterface
    ['{8DA3E9E6-EDDF-4476-B365-37AE086D86B2}']
    procedure OnFunction(const RptEngine: IAcRptEngine; const FuncName: WideString; P1: OleVariant; 
                         P2: OleVariant; P3: OleVariant; var Value: OleVariant); dispid 201;
    procedure OnGetValue(const VarName: WideString; var Value: OleVariant); dispid 202;
    procedure AfterPrint(const aRptEngine: IAcRptEngine); dispid 203;
    procedure BeforePrint(const aRptEngine: IAcRptEngine); dispid 204;
    procedure BeforeDesign(const aRptEngine: IAcRptEngine); dispid 205;
    procedure AfterDesign(const aRptEngine: IAcRptEngine); dispid 206;
    procedure BeforePrepare(const aRptEngine: IAcRptEngine); dispid 207;
    procedure AfterPrepare(const aRptEngine: IAcRptEngine); dispid 208;
    procedure BeforePreview(const aRptEngine: IAcRptEngine); dispid 209;
    procedure OnCellModify(const aRptEngine: IAcRptEngine; aRow: Integer; aCol: Integer; 
                           const aOldText: WideString; const aNewText: WideString); dispid 210;
    procedure OnGetCellModifyLog(const aRptEgine: IAcRptEngine; aRow: Integer; aCol: Integer; 
                                 const aLogList: IAcModifyLogList); dispid 211;
    procedure OnMeasureCellModifyLog(const aRptEngine: IAcRptEngine; aRow: Integer; aCol: Integer; 
                                     var IfModiLogExist: WordBool); dispid 212;
  end;

// *********************************************************************//
// DispIntf:  IAcRptEngineEventDispatch
// Flags:     (4096) Dispatchable
// GUID:      {F3FCC57F-C4F1-4D79-ABBB-08F2221C21E0}
// *********************************************************************//
  IAcRptEngineEventDispatch = dispinterface
    ['{F3FCC57F-C4F1-4D79-ABBB-08F2221C21E0}']
    procedure OnFunction(const FuncName: WideString; P1: OleVariant; P2: OleVariant; 
                         P3: OleVariant; var Value: OleVariant); dispid 201;
  end;

// *********************************************************************//
// Interface: IAcFunctionLib
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5FC54D86-74B9-46F4-B1DD-24C8127EC5E0}
// *********************************************************************//
  IAcFunctionLib = interface(IDispatch)
    ['{5FC54D86-74B9-46F4-B1DD-24C8127EC5E0}']
    function GetFuncCount: Integer; safecall;
    procedure GetFuncInfo(aFuncID: Integer; var aFuncKind: Integer; var aFuncName: WideString; 
                          var aParamDesc: WideString; var aFuncDesc: WideString); safecall;
    function DoFunction(const aRptEgine: IAcRptEngine; aFuncID: Integer; 
                        const aFuncName: WideString; aParam1: OleVariant; aParam2: OleVariant; 
                        aParam3: OleVariant): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  IAcFunctionLibDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5FC54D86-74B9-46F4-B1DD-24C8127EC5E0}
// *********************************************************************//
  IAcFunctionLibDisp = dispinterface
    ['{5FC54D86-74B9-46F4-B1DD-24C8127EC5E0}']
    function GetFuncCount: Integer; dispid 201;
    procedure GetFuncInfo(aFuncID: Integer; var aFuncKind: Integer; var aFuncName: WideString; 
                          var aParamDesc: WideString; var aFuncDesc: WideString); dispid 202;
    function DoFunction(const aRptEgine: IAcRptEngine; aFuncID: Integer; 
                        const aFuncName: WideString; aParam1: OleVariant; aParam2: OleVariant; 
                        aParam3: OleVariant): OleVariant; dispid 203;
  end;

// *********************************************************************//
// Interface: IAcCell
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6F6230E0-99A0-4585-A091-0490A3FCA98B}
// *********************************************************************//
  IAcCell = interface(IDispatch)
    ['{6F6230E0-99A0-4585-A091-0490A3FCA98B}']
    function Get_TextColor: Integer; safecall;
    procedure Set_TextColor(Value: Integer); safecall;
    function Get_BkColor: Integer; safecall;
    procedure Set_BkColor(Value: Integer); safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(Value: OleVariant); safecall;
    function Get_AsString: WideString; safecall;
    procedure Set_AsString(const Value: WideString); safecall;
    function Get_CellText: WideString; safecall;
    procedure Set_CellText(const Value: WideString); safecall;
    function Get_AsNumeric: Single; safecall;
    procedure Set_AsNumeric(Value: Single); safecall;
    function Get_AsInteger: Integer; safecall;
    procedure Set_AsInteger(Value: Integer); safecall;
    function Get_AutoMerge: WordBool; safecall;
    procedure Set_AutoMerge(Value: WordBool); safecall;
    function Get_OwnedCellCount: Integer; safecall;
    procedure CalcCellValue; safecall;
    function Get_TextSize: SYSINT; safecall;
    procedure Set_TextSize(Value: SYSINT); safecall;
    function Get_TextFontName: WideString; safecall;
    procedure Set_TextFontName(const Value: WideString); safecall;
    function Get_TextStyleBold: WordBool; safecall;
    procedure Set_TextStyleBold(Value: WordBool); safecall;
    function Get_TextStyleItalic: WordBool; safecall;
    procedure Set_TextStyleItalic(Value: WordBool); safecall;
    function Get_TextStyleUnderline: WordBool; safecall;
    procedure Set_TextStyleUnderline(Value: WordBool); safecall;
    function Get_TextStyleStrikeout: WordBool; safecall;
    procedure Set_TextStyleStrikeout(Value: WordBool); safecall;
    property TextColor: Integer read Get_TextColor write Set_TextColor;
    property BkColor: Integer read Get_BkColor write Set_BkColor;
    property Value: OleVariant read Get_Value write Set_Value;
    property AsString: WideString read Get_AsString write Set_AsString;
    property CellText: WideString read Get_CellText write Set_CellText;
    property AsNumeric: Single read Get_AsNumeric write Set_AsNumeric;
    property AsInteger: Integer read Get_AsInteger write Set_AsInteger;
    property AutoMerge: WordBool read Get_AutoMerge write Set_AutoMerge;
    property OwnedCellCount: Integer read Get_OwnedCellCount;
    property TextSize: SYSINT read Get_TextSize write Set_TextSize;
    property TextFontName: WideString read Get_TextFontName write Set_TextFontName;
    property TextStyleBold: WordBool read Get_TextStyleBold write Set_TextStyleBold;
    property TextStyleItalic: WordBool read Get_TextStyleItalic write Set_TextStyleItalic;
    property TextStyleUnderline: WordBool read Get_TextStyleUnderline write Set_TextStyleUnderline;
    property TextStyleStrikeout: WordBool read Get_TextStyleStrikeout write Set_TextStyleStrikeout;
  end;

// *********************************************************************//
// DispIntf:  IAcCellDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6F6230E0-99A0-4585-A091-0490A3FCA98B}
// *********************************************************************//
  IAcCellDisp = dispinterface
    ['{6F6230E0-99A0-4585-A091-0490A3FCA98B}']
    property TextColor: Integer dispid 201;
    property BkColor: Integer dispid 202;
    property Value: OleVariant dispid 203;
    property AsString: WideString dispid 204;
    property CellText: WideString dispid 205;
    property AsNumeric: Single dispid 206;
    property AsInteger: Integer dispid 207;
    property AutoMerge: WordBool dispid 209;
    property OwnedCellCount: Integer readonly dispid 210;
    procedure CalcCellValue; dispid 211;
    property TextSize: SYSINT dispid 212;
    property TextFontName: WideString dispid 213;
    property TextStyleBold: WordBool dispid 214;
    property TextStyleItalic: WordBool dispid 215;
    property TextStyleUnderline: WordBool dispid 216;
    property TextStyleStrikeout: WordBool dispid 217;
  end;

// *********************************************************************//
// Interface: IAcLine
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4FBA785-0ED1-49B1-8EEA-03990448ED41}
// *********************************************************************//
  IAcLine = interface(IDispatch)
    ['{B4FBA785-0ED1-49B1-8EEA-03990448ED41}']
    function Get_CellsCount: Integer; safecall;
    function GetCell(aIndex: Integer): IAcCell; safecall;
    procedure CalcLineCellValues; safecall;
    function Get_Index: Integer; safecall;
    property CellsCount: Integer read Get_CellsCount;
    property Index: Integer read Get_Index;
  end;

// *********************************************************************//
// DispIntf:  IAcLineDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4FBA785-0ED1-49B1-8EEA-03990448ED41}
// *********************************************************************//
  IAcLineDisp = dispinterface
    ['{B4FBA785-0ED1-49B1-8EEA-03990448ED41}']
    property CellsCount: Integer readonly dispid 201;
    function GetCell(aIndex: Integer): IAcCell; dispid 202;
    procedure CalcLineCellValues; dispid 203;
    property Index: Integer readonly dispid 204;
  end;

// *********************************************************************//
// Interface: IAcRptPage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2CF7026D-4B4A-441F-86BA-07856E31371B}
// *********************************************************************//
  IAcRptPage = interface(IDispatch)
    ['{2CF7026D-4B4A-441F-86BA-07856E31371B}']
    function GetLineX(aIndex: Integer): IAcLine; safecall;
    function GetCellX(Row: Integer; Col: Integer): IAcCell; safecall;
    function Get_LineCount: Integer; safecall;
    function Get_PageType: AcPageType; safecall;
    property LineCount: Integer read Get_LineCount;
    property PageType: AcPageType read Get_PageType;
  end;

// *********************************************************************//
// DispIntf:  IAcRptPageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2CF7026D-4B4A-441F-86BA-07856E31371B}
// *********************************************************************//
  IAcRptPageDisp = dispinterface
    ['{2CF7026D-4B4A-441F-86BA-07856E31371B}']
    function GetLineX(aIndex: Integer): IAcLine; dispid 201;
    function GetCellX(Row: Integer; Col: Integer): IAcCell; dispid 202;
    property LineCount: Integer readonly dispid 203;
    property PageType: AcPageType readonly dispid 204;
  end;

// *********************************************************************//
// Interface: IAcModifyLogList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {27D6DF05-6FC9-4614-86E3-B9FC0B5B25E8}
// *********************************************************************//
  IAcModifyLogList = interface(IDispatch)
    ['{27D6DF05-6FC9-4614-86E3-B9FC0B5B25E8}']
    function Get_Count: Integer; safecall;
    procedure AddLogItem(aRow: Integer; aCol: Integer; const aOldText: WideString; 
                         const aNewText: WideString; const aModifiedBy: WideString; 
                         aDateTime: TDateTime); safecall;
    procedure ClearItems; safecall;
    procedure RemoveLogItem(aIndex: Integer); safecall;
    procedure GetLogItem(aIndex: Integer; var aRow: Integer; var aCol: Integer; 
                         var aOldText: WideString; var aNewText: WideString; 
                         var aModifiedBy: WideString; var aDateTime: TDateTime); safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IAcModifyLogListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {27D6DF05-6FC9-4614-86E3-B9FC0B5B25E8}
// *********************************************************************//
  IAcModifyLogListDisp = dispinterface
    ['{27D6DF05-6FC9-4614-86E3-B9FC0B5B25E8}']
    property Count: Integer readonly dispid 201;
    procedure AddLogItem(aRow: Integer; aCol: Integer; const aOldText: WideString; 
                         const aNewText: WideString; const aModifiedBy: WideString; 
                         aDateTime: TDateTime); dispid 202;
    procedure ClearItems; dispid 203;
    procedure RemoveLogItem(aIndex: Integer); dispid 204;
    procedure GetLogItem(aIndex: Integer; var aRow: Integer; var aCol: Integer; 
                         var aOldText: WideString; var aNewText: WideString; 
                         var aModifiedBy: WideString; var aDateTime: TDateTime); dispid 205;
  end;

// *********************************************************************//
// Interface: IAcNetStream
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA567CA9-BD8E-44CB-B2BF-17EA6F6DBB34}
// *********************************************************************//
  IAcNetStream = interface(IDispatch)
    ['{DA567CA9-BD8E-44CB-B2BF-17EA6F6DBB34}']
    function Read(var Buffer: WideString; Count: Integer): Integer; safecall;
    function Write(const Buffer: WideString; Count: Integer): Integer; safecall;
    function Seek(Offset: Integer; Origin: SeekOrg): Integer; safecall;
    function GetSize: Integer; safecall;
    procedure SetSize(NewSize: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IAcNetStreamDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA567CA9-BD8E-44CB-B2BF-17EA6F6DBB34}
// *********************************************************************//
  IAcNetStreamDisp = dispinterface
    ['{DA567CA9-BD8E-44CB-B2BF-17EA6F6DBB34}']
    function Read(var Buffer: WideString; Count: Integer): Integer; dispid 201;
    function Write(const Buffer: WideString; Count: Integer): Integer; dispid 202;
    function Seek(Offset: Integer; Origin: SeekOrg): Integer; dispid 205;
    function GetSize: Integer; dispid 203;
    procedure SetSize(NewSize: Integer); dispid 204;
  end;

// *********************************************************************//
// The Class CoCustDataBuilder provides a Create and CreateRemote method to          
// create instances of the default interface ICustDataBuilder exposed by              
// the CoClass CustDataBuilder. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCustDataBuilder = class
    class function Create: ICustDataBuilder;
    class function CreateRemote(const MachineName: string): ICustDataBuilder;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCustDataBuilder
// Help String      : 
// Default Interface: ICustDataBuilder
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCustDataBuilderProperties= class;
{$ENDIF}
  TCustDataBuilder = class(TOleServer)
  private
    FIntf:        ICustDataBuilder;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCustDataBuilderProperties;
    function      GetServerProperties: TCustDataBuilderProperties;
{$ENDIF}
    function      GetDefaultInterface: ICustDataBuilder;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ICustDataBuilder);
    procedure Disconnect; override;
    procedure RemoveAllTables;
    procedure NewTable(const aTableName: WideString);
    procedure RemoveTable(const aTableName: WideString);
    procedure OpenTable(const aTableName: WideString);
    procedure CloseTable(const aTableName: WideString);
    procedure AddStringField(const aTableName: WideString; const aFieldName: WideString; 
                             aLength: Integer);
    procedure AddIntegerField(const aTableName: WideString; const aFieldName: WideString);
    procedure AddFloatField(const aTableName: WideString; const aFieldName: WideString);
    procedure AddDateTimeField(const aTableName: WideString; const aFieldName: WideString);
    procedure AppendRow(const aTableName: WideString; FieldValues: OleVariant);
    procedure SetCurrentRowValues(const aTableName: WideString; FieldValues: OleVariant);
    procedure AppendEmptyRow(const aTableName: WideString);
    procedure DeleteRow(const aTableName: WideString);
    procedure MoveFirst(const aTableName: WideString);
    procedure MoveLast(const aTableName: WideString);
    procedure MoveNext(const aTableName: WideString);
    procedure MovePrior(const aTableName: WideString);
    function SetFieldValue(aTableId: OleVariant; aFieldId: OleVariant; Value: OleVariant): HResult;
    function GetFieldValue(aTableId: OleVariant; aFieldId: OleVariant): OleVariant;
    function GetTableName(aIndex: Integer): WideString;
    function GetTableCount: Integer;
    function GetRecordCount(const aTableName: WideString): Integer;
    function IsBOF(const aTableName: WideString): WordBool;
    function IsEOF(const aTableName: WideString): WordBool;
    procedure SetStringFieldValue(const aTableName: WideString; const aFieldName: WideString; 
                                  const Value: WideString);
    function TableExist(const TableName: WideString): WordBool;
    procedure SetBlobField(const aTableName: WideString; const aFieldName: WideString; 
                           const aStream: IAcNetStream);
    procedure GetblobField(const aTableName: WideString; const aFieldName: WideString; 
                           const aStream: IAcNetStream);
    procedure AddBlobField(const aTableName: WideString; const aFieldName: WideString);
    function SetCurrentTable(const TableName: WideString): Integer;
    function GetTableIndex(const TableName: WideString): Integer;
    procedure AddVariantField(const aTableName: WideString; const aFieldName: WideString);
    procedure SetFieldAsString(aTableId: OleVariant; aFieldId: OleVariant; const Value: WideString);
    procedure AddBooleanField(const aTableName: WideString; const aFieldName: WideString);
    property DefaultInterface: ICustDataBuilder read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCustDataBuilderProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCustDataBuilder
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCustDataBuilderProperties = class(TPersistent)
  private
    FServer:    TCustDataBuilder;
    function    GetDefaultInterface: ICustDataBuilder;
    constructor Create(AServer: TCustDataBuilder);
  protected
  public
    property DefaultInterface: ICustDataBuilder read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoAcRptEngine provides a Create and CreateRemote method to          
// create instances of the default interface IAcRptEngine exposed by              
// the CoClass AcRptEngine. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAcRptEngine = class
    class function Create: IAcRptEngine;
    class function CreateRemote(const MachineName: string): IAcRptEngine;
  end;

  TAcRptEngineOnFunction = procedure(ASender: TObject; const RptEngine: IAcRptEngine; 
                                                       const FuncName: WideString; P1: OleVariant; 
                                                       P2: OleVariant; P3: OleVariant; 
                                                       var Value: OleVariant) of object;
  TAcRptEngineOnGetValue = procedure(ASender: TObject; const VarName: WideString; 
                                                       var Value: OleVariant) of object;
  TAcRptEngineAfterPrint = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineBeforePrint = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineBeforeDesign = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineAfterDesign = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineBeforePrepare = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineAfterPrepare = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineBeforePreview = procedure(ASender: TObject; const aRptEngine: IAcRptEngine) of object;
  TAcRptEngineOnCellModify = procedure(ASender: TObject; const aRptEngine: IAcRptEngine; 
                                                         aRow: Integer; aCol: Integer; 
                                                         const aOldText: WideString; 
                                                         const aNewText: WideString) of object;
  TAcRptEngineOnGetCellModifyLog = procedure(ASender: TObject; const aRptEgine: IAcRptEngine; 
                                                               aRow: Integer; aCol: Integer; 
                                                               const aLogList: IAcModifyLogList) of object;
  TAcRptEngineOnMeasureCellModifyLog = procedure(ASender: TObject; const aRptEngine: IAcRptEngine; 
                                                                   aRow: Integer; aCol: Integer; 
                                                                   var IfModiLogExist: WordBool) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAcRptEngine
// Help String      : 
// Default Interface: IAcRptEngine
// Def. Intf. DISP? : No
// Event   Interface: IAcRptEngineEvent
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAcRptEngineProperties= class;
{$ENDIF}
  TAcRptEngine = class(TOleServer)
  private
    FOnFunction: TAcRptEngineOnFunction;
    FOnGetValue: TAcRptEngineOnGetValue;
    FOnAfterPrint: TAcRptEngineAfterPrint;
    FOnBeforePrint: TAcRptEngineBeforePrint;
    FOnBeforeDesign: TAcRptEngineBeforeDesign;
    FOnAfterDesign: TAcRptEngineAfterDesign;
    FOnBeforePrepare: TAcRptEngineBeforePrepare;
    FOnAfterPrepare: TAcRptEngineAfterPrepare;
    FOnBeforePreview: TAcRptEngineBeforePreview;
    FOnCellModify: TAcRptEngineOnCellModify;
    FOnGetCellModifyLog: TAcRptEngineOnGetCellModifyLog;
    FOnMeasureCellModifyLog: TAcRptEngineOnMeasureCellModifyLog;
    FIntf:        IAcRptEngine;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAcRptEngineProperties;
    function      GetServerProperties: TAcRptEngineProperties;
{$ENDIF}
    function      GetDefaultInterface: IAcRptEngine;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_PreparedPagesCount: Integer;
    function Get_CustDataBuilder: ICustDataBuilder;
    function Get_GlobalCustDataBuilder: ICustDataBuilder;
    function Get_LinesCount: Integer;
    function Get_SubPageCount: Integer;
    function Get_DisableSaveToFile: WordBool;
    procedure Set_DisableSaveToFile(Value: WordBool);
    function Get_ShowPreviewOnPrepare: WordBool;
    procedure Set_ShowPreviewOnPrepare(Value: WordBool);
    function Get_ShowProgress: WordBool;
    procedure Set_ShowProgress(Value: WordBool);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAcRptEngine);
    procedure Disconnect; override;
    procedure Init;
    procedure AddDataset(const DatasetName: WideString; AdoRecord: OleVariant);
    procedure AddVariable(const VarName: WideString; Value: OleVariant);
    procedure AddGlobalVariable(const VarName: WideString; Value: OleVariant);
    procedure SetReportFile(const AptFileName: WideString);
    function AddDatasetRelation(const MasterName: WideString; const DetailName: WideString; 
                                const Relation: WideString): Integer;
    function PrepareReport: HResult;
    procedure Print;
    procedure PrintReport;
    procedure PrintPrepared(BeginPage: Integer; EndPage: Integer; Copies: Integer);
    procedure Preview;
    procedure ShowDesigner;
    procedure ExportToXls(const aFileName: WideString);
    function Calac(const aExpr: WideString): OleVariant;
    function CalacOPZ(const aExpr: WideString): OleVariant;
    procedure ExportToACR(const aFileName: WideString);
    procedure ExportToHTML(const aFileName: WideString);
    procedure AddFunctionLib(const aFuncLib: IAcFunctionLib; aGroupID: Integer);
    procedure RemoveFuncionLib(const aFuncLib: IAcFunctionLib);
    procedure RemoveFuncLibGroup(aGroup: Integer);
    procedure AddFunctionName(aFuncKind: Integer; const aFuncName: WideString; 
                              const aParamDesc: WideString; const aFuncDesc: WideString);
    function GetLineX(aIndex: Integer): IAcLine;
    function GetCellX(Row: Integer; Col: Integer): IAcCell;
    function GetSubPage(aIndex: Integer): IAcRptPage;
    function LoadFromFile(const aFileName: WideString): HResult;
    function SaveToFile(const aFileName: WideString): HResult;
    function LoadFromBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString; 
                               const RepTitle: WideString): HResult;
    function SaveToBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString): HResult;
    function LoadFromStream(const aStream: IUnknown): HResult;
    function SaveToStream(const aStream: IUnknown): HResult;
    procedure GetLastError(var ErrorCode: Integer; var ErrorMsg: WideString);
    function LoadFromURL(const URL: WideString): HResult;
    function ClearDataRelations: HResult;
    procedure SetAppConnectionString(const ConnString: WideString);
    procedure SetRegisterInfo(const RegCode: WideString; const UserName: WideString; 
                              const AttachCode: WideString; const Addr: WideString; 
                              const EMail: WideString; const Phone: WideString; 
                              const Fax: WideString; var ErrCode: Integer; var ErrMsg: WideString);
    function SetDataFieldAliasName(const DatasetName: WideString; const FieldNames: WideString; 
                                   const FieldAliasNames: WideString): HResult;
    function ClearContents: HResult;
    function ExportToAcrStream(const aStream: IAcNetStream): HResult;
    property DefaultInterface: IAcRptEngine read GetDefaultInterface;
    property PreparedPagesCount: Integer read Get_PreparedPagesCount;
    property CustDataBuilder: ICustDataBuilder read Get_CustDataBuilder;
    property GlobalCustDataBuilder: ICustDataBuilder read Get_GlobalCustDataBuilder;
    property LinesCount: Integer read Get_LinesCount;
    property SubPageCount: Integer read Get_SubPageCount;
    property DisableSaveToFile: WordBool read Get_DisableSaveToFile write Set_DisableSaveToFile;
    property ShowPreviewOnPrepare: WordBool read Get_ShowPreviewOnPrepare write Set_ShowPreviewOnPrepare;
    property ShowProgress: WordBool read Get_ShowProgress write Set_ShowProgress;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAcRptEngineProperties read GetServerProperties;
{$ENDIF}
    property OnFunction: TAcRptEngineOnFunction read FOnFunction write FOnFunction;
    property OnGetValue: TAcRptEngineOnGetValue read FOnGetValue write FOnGetValue;
    property OnAfterPrint: TAcRptEngineAfterPrint read FOnAfterPrint write FOnAfterPrint;
    property OnBeforePrint: TAcRptEngineBeforePrint read FOnBeforePrint write FOnBeforePrint;
    property OnBeforeDesign: TAcRptEngineBeforeDesign read FOnBeforeDesign write FOnBeforeDesign;
    property OnAfterDesign: TAcRptEngineAfterDesign read FOnAfterDesign write FOnAfterDesign;
    property OnBeforePrepare: TAcRptEngineBeforePrepare read FOnBeforePrepare write FOnBeforePrepare;
    property OnAfterPrepare: TAcRptEngineAfterPrepare read FOnAfterPrepare write FOnAfterPrepare;
    property OnBeforePreview: TAcRptEngineBeforePreview read FOnBeforePreview write FOnBeforePreview;
    property OnCellModify: TAcRptEngineOnCellModify read FOnCellModify write FOnCellModify;
    property OnGetCellModifyLog: TAcRptEngineOnGetCellModifyLog read FOnGetCellModifyLog write FOnGetCellModifyLog;
    property OnMeasureCellModifyLog: TAcRptEngineOnMeasureCellModifyLog read FOnMeasureCellModifyLog write FOnMeasureCellModifyLog;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAcRptEngine
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAcRptEngineProperties = class(TPersistent)
  private
    FServer:    TAcRptEngine;
    function    GetDefaultInterface: IAcRptEngine;
    constructor Create(AServer: TAcRptEngine);
  protected
    function Get_PreparedPagesCount: Integer;
    function Get_CustDataBuilder: ICustDataBuilder;
    function Get_GlobalCustDataBuilder: ICustDataBuilder;
    function Get_LinesCount: Integer;
    function Get_SubPageCount: Integer;
    function Get_DisableSaveToFile: WordBool;
    procedure Set_DisableSaveToFile(Value: WordBool);
    function Get_ShowPreviewOnPrepare: WordBool;
    procedure Set_ShowPreviewOnPrepare(Value: WordBool);
    function Get_ShowProgress: WordBool;
    procedure Set_ShowProgress(Value: WordBool);
  public
    property DefaultInterface: IAcRptEngine read GetDefaultInterface;
  published
    property DisableSaveToFile: WordBool read Get_DisableSaveToFile write Set_DisableSaveToFile;
    property ShowPreviewOnPrepare: WordBool read Get_ShowPreviewOnPrepare write Set_ShowPreviewOnPrepare;
    property ShowProgress: WordBool read Get_ShowProgress write Set_ShowProgress;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoCustDataBuilder.Create: ICustDataBuilder;
begin
  Result := CreateComObject(CLASS_CustDataBuilder) as ICustDataBuilder;
end;

class function CoCustDataBuilder.CreateRemote(const MachineName: string): ICustDataBuilder;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CustDataBuilder) as ICustDataBuilder;
end;

procedure TCustDataBuilder.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{6627DF35-535B-486B-9923-42582F6CC739}';
    IntfIID:   '{A888B5E7-D62D-4C43-9452-DCD227E1CF86}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCustDataBuilder.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ICustDataBuilder;
  end;
end;

procedure TCustDataBuilder.ConnectTo(svrIntf: ICustDataBuilder);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCustDataBuilder.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCustDataBuilder.GetDefaultInterface: ICustDataBuilder;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCustDataBuilder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCustDataBuilderProperties.Create(Self);
{$ENDIF}
end;

destructor TCustDataBuilder.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCustDataBuilder.GetServerProperties: TCustDataBuilderProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCustDataBuilder.RemoveAllTables;
begin
  DefaultInterface.RemoveAllTables;
end;

procedure TCustDataBuilder.NewTable(const aTableName: WideString);
begin
  DefaultInterface.NewTable(aTableName);
end;

procedure TCustDataBuilder.RemoveTable(const aTableName: WideString);
begin
  DefaultInterface.RemoveTable(aTableName);
end;

procedure TCustDataBuilder.OpenTable(const aTableName: WideString);
begin
  DefaultInterface.OpenTable(aTableName);
end;

procedure TCustDataBuilder.CloseTable(const aTableName: WideString);
begin
  DefaultInterface.CloseTable(aTableName);
end;

procedure TCustDataBuilder.AddStringField(const aTableName: WideString; 
                                          const aFieldName: WideString; aLength: Integer);
begin
  DefaultInterface.AddStringField(aTableName, aFieldName, aLength);
end;

procedure TCustDataBuilder.AddIntegerField(const aTableName: WideString; 
                                           const aFieldName: WideString);
begin
  DefaultInterface.AddIntegerField(aTableName, aFieldName);
end;

procedure TCustDataBuilder.AddFloatField(const aTableName: WideString; const aFieldName: WideString);
begin
  DefaultInterface.AddFloatField(aTableName, aFieldName);
end;

procedure TCustDataBuilder.AddDateTimeField(const aTableName: WideString; 
                                            const aFieldName: WideString);
begin
  DefaultInterface.AddDateTimeField(aTableName, aFieldName);
end;

procedure TCustDataBuilder.AppendRow(const aTableName: WideString; FieldValues: OleVariant);
begin
  DefaultInterface.AppendRow(aTableName, FieldValues);
end;

procedure TCustDataBuilder.SetCurrentRowValues(const aTableName: WideString; FieldValues: OleVariant);
begin
  DefaultInterface.SetCurrentRowValues(aTableName, FieldValues);
end;

procedure TCustDataBuilder.AppendEmptyRow(const aTableName: WideString);
begin
  DefaultInterface.AppendEmptyRow(aTableName);
end;

procedure TCustDataBuilder.DeleteRow(const aTableName: WideString);
begin
  DefaultInterface.DeleteRow(aTableName);
end;

procedure TCustDataBuilder.MoveFirst(const aTableName: WideString);
begin
  DefaultInterface.MoveFirst(aTableName);
end;

procedure TCustDataBuilder.MoveLast(const aTableName: WideString);
begin
  DefaultInterface.MoveLast(aTableName);
end;

procedure TCustDataBuilder.MoveNext(const aTableName: WideString);
begin
  DefaultInterface.MoveNext(aTableName);
end;

procedure TCustDataBuilder.MovePrior(const aTableName: WideString);
begin
  DefaultInterface.MovePrior(aTableName);
end;

function TCustDataBuilder.SetFieldValue(aTableId: OleVariant; aFieldId: OleVariant; 
                                        Value: OleVariant): HResult;
begin
  Result := DefaultInterface.SetFieldValue(aTableId, aFieldId, Value);
end;

function TCustDataBuilder.GetFieldValue(aTableId: OleVariant; aFieldId: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetFieldValue(aTableId, aFieldId);
end;

function TCustDataBuilder.GetTableName(aIndex: Integer): WideString;
begin
  Result := DefaultInterface.GetTableName(aIndex);
end;

function TCustDataBuilder.GetTableCount: Integer;
begin
  Result := DefaultInterface.GetTableCount;
end;

function TCustDataBuilder.GetRecordCount(const aTableName: WideString): Integer;
begin
  Result := DefaultInterface.GetRecordCount(aTableName);
end;

function TCustDataBuilder.IsBOF(const aTableName: WideString): WordBool;
begin
  Result := DefaultInterface.IsBOF(aTableName);
end;

function TCustDataBuilder.IsEOF(const aTableName: WideString): WordBool;
begin
  Result := DefaultInterface.IsEOF(aTableName);
end;

procedure TCustDataBuilder.SetStringFieldValue(const aTableName: WideString; 
                                               const aFieldName: WideString; const Value: WideString);
begin
  DefaultInterface.SetStringFieldValue(aTableName, aFieldName, Value);
end;

function TCustDataBuilder.TableExist(const TableName: WideString): WordBool;
begin
  Result := DefaultInterface.TableExist(TableName);
end;

procedure TCustDataBuilder.SetBlobField(const aTableName: WideString; const aFieldName: WideString; 
                                        const aStream: IAcNetStream);
begin
  DefaultInterface.SetBlobField(aTableName, aFieldName, aStream);
end;

procedure TCustDataBuilder.GetblobField(const aTableName: WideString; const aFieldName: WideString; 
                                        const aStream: IAcNetStream);
begin
  DefaultInterface.GetblobField(aTableName, aFieldName, aStream);
end;

procedure TCustDataBuilder.AddBlobField(const aTableName: WideString; const aFieldName: WideString);
begin
  DefaultInterface.AddBlobField(aTableName, aFieldName);
end;

function TCustDataBuilder.SetCurrentTable(const TableName: WideString): Integer;
begin
  Result := DefaultInterface.SetCurrentTable(TableName);
end;

function TCustDataBuilder.GetTableIndex(const TableName: WideString): Integer;
begin
  Result := DefaultInterface.GetTableIndex(TableName);
end;

procedure TCustDataBuilder.AddVariantField(const aTableName: WideString; 
                                           const aFieldName: WideString);
begin
  DefaultInterface.AddVariantField(aTableName, aFieldName);
end;

procedure TCustDataBuilder.SetFieldAsString(aTableId: OleVariant; aFieldId: OleVariant; 
                                            const Value: WideString);
begin
  DefaultInterface.SetFieldAsString(aTableId, aFieldId, Value);
end;

procedure TCustDataBuilder.AddBooleanField(const aTableName: WideString; 
                                           const aFieldName: WideString);
begin
  DefaultInterface.AddBooleanField(aTableName, aFieldName);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCustDataBuilderProperties.Create(AServer: TCustDataBuilder);
begin
  inherited Create;
  FServer := AServer;
end;

function TCustDataBuilderProperties.GetDefaultInterface: ICustDataBuilder;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoAcRptEngine.Create: IAcRptEngine;
begin
  Result := CreateComObject(CLASS_AcRptEngine) as IAcRptEngine;
end;

class function CoAcRptEngine.CreateRemote(const MachineName: string): IAcRptEngine;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AcRptEngine) as IAcRptEngine;
end;

procedure TAcRptEngine.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C84DF69C-0227-4846-919B-6B31168FE68A}';
    IntfIID:   '{78DD38D7-B85E-4075-893E-6639C23EA85E}';
    EventIID:  '{8DA3E9E6-EDDF-4476-B365-37AE086D86B2}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAcRptEngine.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IAcRptEngine;
  end;
end;

procedure TAcRptEngine.ConnectTo(svrIntf: IAcRptEngine);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TAcRptEngine.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TAcRptEngine.GetDefaultInterface: IAcRptEngine;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAcRptEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAcRptEngineProperties.Create(Self);
{$ENDIF}
end;

destructor TAcRptEngine.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAcRptEngine.GetServerProperties: TAcRptEngineProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TAcRptEngine.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    201: if Assigned(FOnFunction) then
         FOnFunction(Self,
                     IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine},
                     Params[1] {const WideString},
                     Params[2] {OleVariant},
                     Params[3] {OleVariant},
                     Params[4] {OleVariant},
                     OleVariant((TVarData(Params[5]).VPointer)^) {var OleVariant});
    202: if Assigned(FOnGetValue) then
         FOnGetValue(Self,
                     Params[0] {const WideString},
                     OleVariant((TVarData(Params[1]).VPointer)^) {var OleVariant});
    203: if Assigned(FOnAfterPrint) then
         FOnAfterPrint(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    204: if Assigned(FOnBeforePrint) then
         FOnBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    205: if Assigned(FOnBeforeDesign) then
         FOnBeforeDesign(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    206: if Assigned(FOnAfterDesign) then
         FOnAfterDesign(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    207: if Assigned(FOnBeforePrepare) then
         FOnBeforePrepare(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    208: if Assigned(FOnAfterPrepare) then
         FOnAfterPrepare(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    209: if Assigned(FOnBeforePreview) then
         FOnBeforePreview(Self, IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine});
    210: if Assigned(FOnCellModify) then
         FOnCellModify(Self,
                       IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine},
                       Params[1] {Integer},
                       Params[2] {Integer},
                       Params[3] {const WideString},
                       Params[4] {const WideString});
    211: if Assigned(FOnGetCellModifyLog) then
         FOnGetCellModifyLog(Self,
                             IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine},
                             Params[1] {Integer},
                             Params[2] {Integer},
                             IUnknown(TVarData(Params[3]).VPointer) as IAcModifyLogList {const IAcModifyLogList});
    212: if Assigned(FOnMeasureCellModifyLog) then
         FOnMeasureCellModifyLog(Self,
                                 IUnknown(TVarData(Params[0]).VPointer) as IAcRptEngine {const IAcRptEngine},
                                 Params[1] {Integer},
                                 Params[2] {Integer},
                                 WordBool((TVarData(Params[3]).VPointer)^) {var WordBool});
  end; {case DispID}
end;

function TAcRptEngine.Get_PreparedPagesCount: Integer;
begin
    Result := DefaultInterface.PreparedPagesCount;
end;

function TAcRptEngine.Get_CustDataBuilder: ICustDataBuilder;
begin
    Result := DefaultInterface.CustDataBuilder;
end;

function TAcRptEngine.Get_GlobalCustDataBuilder: ICustDataBuilder;
begin
    Result := DefaultInterface.GlobalCustDataBuilder;
end;

function TAcRptEngine.Get_LinesCount: Integer;
begin
    Result := DefaultInterface.LinesCount;
end;

function TAcRptEngine.Get_SubPageCount: Integer;
begin
    Result := DefaultInterface.SubPageCount;
end;

function TAcRptEngine.Get_DisableSaveToFile: WordBool;
begin
    Result := DefaultInterface.DisableSaveToFile;
end;

procedure TAcRptEngine.Set_DisableSaveToFile(Value: WordBool);
begin
  DefaultInterface.Set_DisableSaveToFile(Value);
end;

function TAcRptEngine.Get_ShowPreviewOnPrepare: WordBool;
begin
    Result := DefaultInterface.ShowPreviewOnPrepare;
end;

procedure TAcRptEngine.Set_ShowPreviewOnPrepare(Value: WordBool);
begin
  DefaultInterface.Set_ShowPreviewOnPrepare(Value);
end;

function TAcRptEngine.Get_ShowProgress: WordBool;
begin
    Result := DefaultInterface.ShowProgress;
end;

procedure TAcRptEngine.Set_ShowProgress(Value: WordBool);
begin
  DefaultInterface.Set_ShowProgress(Value);
end;

procedure TAcRptEngine.Init;
begin
  DefaultInterface.Init;
end;

procedure TAcRptEngine.AddDataset(const DatasetName: WideString; AdoRecord: OleVariant);
begin
  DefaultInterface.AddDataset(DatasetName, AdoRecord);
end;

procedure TAcRptEngine.AddVariable(const VarName: WideString; Value: OleVariant);
begin
  DefaultInterface.AddVariable(VarName, Value);
end;

procedure TAcRptEngine.AddGlobalVariable(const VarName: WideString; Value: OleVariant);
begin
  DefaultInterface.AddGlobalVariable(VarName, Value);
end;

procedure TAcRptEngine.SetReportFile(const AptFileName: WideString);
begin
  DefaultInterface.SetReportFile(AptFileName);
end;

function TAcRptEngine.AddDatasetRelation(const MasterName: WideString; 
                                         const DetailName: WideString; const Relation: WideString): Integer;
begin
  Result := DefaultInterface.AddDatasetRelation(MasterName, DetailName, Relation);
end;

function TAcRptEngine.PrepareReport: HResult;
begin
  Result := DefaultInterface.PrepareReport;
end;

procedure TAcRptEngine.Print;
begin
  DefaultInterface.Print;
end;

procedure TAcRptEngine.PrintReport;
begin
  DefaultInterface.PrintReport;
end;

procedure TAcRptEngine.PrintPrepared(BeginPage: Integer; EndPage: Integer; Copies: Integer);
begin
  DefaultInterface.PrintPrepared(BeginPage, EndPage, Copies);
end;

procedure TAcRptEngine.Preview;
begin
  DefaultInterface.Preview;
end;

procedure TAcRptEngine.ShowDesigner;
begin
  DefaultInterface.ShowDesigner;
end;

procedure TAcRptEngine.ExportToXls(const aFileName: WideString);
begin
  DefaultInterface.ExportToXls(aFileName);
end;

function TAcRptEngine.Calac(const aExpr: WideString): OleVariant;
begin
  Result := DefaultInterface.Calac(aExpr);
end;

function TAcRptEngine.CalacOPZ(const aExpr: WideString): OleVariant;
begin
  Result := DefaultInterface.CalacOPZ(aExpr);
end;

procedure TAcRptEngine.ExportToACR(const aFileName: WideString);
begin
  DefaultInterface.ExportToACR(aFileName);
end;

procedure TAcRptEngine.ExportToHTML(const aFileName: WideString);
begin
  DefaultInterface.ExportToHTML(aFileName);
end;

procedure TAcRptEngine.AddFunctionLib(const aFuncLib: IAcFunctionLib; aGroupID: Integer);
begin
  DefaultInterface.AddFunctionLib(aFuncLib, aGroupID);
end;

procedure TAcRptEngine.RemoveFuncionLib(const aFuncLib: IAcFunctionLib);
begin
  DefaultInterface.RemoveFuncionLib(aFuncLib);
end;

procedure TAcRptEngine.RemoveFuncLibGroup(aGroup: Integer);
begin
  DefaultInterface.RemoveFuncLibGroup(aGroup);
end;

procedure TAcRptEngine.AddFunctionName(aFuncKind: Integer; const aFuncName: WideString; 
                                       const aParamDesc: WideString; const aFuncDesc: WideString);
begin
  DefaultInterface.AddFunctionName(aFuncKind, aFuncName, aParamDesc, aFuncDesc);
end;

function TAcRptEngine.GetLineX(aIndex: Integer): IAcLine;
begin
  Result := DefaultInterface.GetLineX(aIndex);
end;

function TAcRptEngine.GetCellX(Row: Integer; Col: Integer): IAcCell;
begin
  Result := DefaultInterface.GetCellX(Row, Col);
end;

function TAcRptEngine.GetSubPage(aIndex: Integer): IAcRptPage;
begin
  Result := DefaultInterface.GetSubPage(aIndex);
end;

function TAcRptEngine.LoadFromFile(const aFileName: WideString): HResult;
begin
  Result := DefaultInterface.LoadFromFile(aFileName);
end;

function TAcRptEngine.SaveToFile(const aFileName: WideString): HResult;
begin
  Result := DefaultInterface.SaveToFile(aFileName);
end;

function TAcRptEngine.LoadFromBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString; 
                                        const RepTitle: WideString): HResult;
begin
  Result := DefaultInterface.LoadFromBlobField(AdoRecord, BlobFieldName, RepTitle);
end;

function TAcRptEngine.SaveToBlobField(AdoRecord: OleVariant; const BlobFieldName: WideString): HResult;
begin
  Result := DefaultInterface.SaveToBlobField(AdoRecord, BlobFieldName);
end;

function TAcRptEngine.LoadFromStream(const aStream: IUnknown): HResult;
begin
  Result := DefaultInterface.LoadFromStream(aStream);
end;

function TAcRptEngine.SaveToStream(const aStream: IUnknown): HResult;
begin
  Result := DefaultInterface.SaveToStream(aStream);
end;

procedure TAcRptEngine.GetLastError(var ErrorCode: Integer; var ErrorMsg: WideString);
begin
  DefaultInterface.GetLastError(ErrorCode, ErrorMsg);
end;

function TAcRptEngine.LoadFromURL(const URL: WideString): HResult;
begin
  Result := DefaultInterface.LoadFromURL(URL);
end;

function TAcRptEngine.ClearDataRelations: HResult;
begin
  Result := DefaultInterface.ClearDataRelations;
end;

procedure TAcRptEngine.SetAppConnectionString(const ConnString: WideString);
begin
  DefaultInterface.SetAppConnectionString(ConnString);
end;

procedure TAcRptEngine.SetRegisterInfo(const RegCode: WideString; const UserName: WideString; 
                                       const AttachCode: WideString; const Addr: WideString; 
                                       const EMail: WideString; const Phone: WideString; 
                                       const Fax: WideString; var ErrCode: Integer; 
                                       var ErrMsg: WideString);
begin
  DefaultInterface.SetRegisterInfo(RegCode, UserName, AttachCode, Addr, EMail, Phone, Fax, ErrCode, 
                                   ErrMsg);
end;

function TAcRptEngine.SetDataFieldAliasName(const DatasetName: WideString; 
                                            const FieldNames: WideString; 
                                            const FieldAliasNames: WideString): HResult;
begin
  Result := DefaultInterface.SetDataFieldAliasName(DatasetName, FieldNames, FieldAliasNames);
end;

function TAcRptEngine.ClearContents: HResult;
begin
  Result := DefaultInterface.ClearContents;
end;

function TAcRptEngine.ExportToAcrStream(const aStream: IAcNetStream): HResult;
begin
  Result := DefaultInterface.ExportToAcrStream(aStream);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAcRptEngineProperties.Create(AServer: TAcRptEngine);
begin
  inherited Create;
  FServer := AServer;
end;

function TAcRptEngineProperties.GetDefaultInterface: IAcRptEngine;
begin
  Result := FServer.DefaultInterface;
end;

function TAcRptEngineProperties.Get_PreparedPagesCount: Integer;
begin
    Result := DefaultInterface.PreparedPagesCount;
end;

function TAcRptEngineProperties.Get_CustDataBuilder: ICustDataBuilder;
begin
    Result := DefaultInterface.CustDataBuilder;
end;

function TAcRptEngineProperties.Get_GlobalCustDataBuilder: ICustDataBuilder;
begin
    Result := DefaultInterface.GlobalCustDataBuilder;
end;

function TAcRptEngineProperties.Get_LinesCount: Integer;
begin
    Result := DefaultInterface.LinesCount;
end;

function TAcRptEngineProperties.Get_SubPageCount: Integer;
begin
    Result := DefaultInterface.SubPageCount;
end;

function TAcRptEngineProperties.Get_DisableSaveToFile: WordBool;
begin
    Result := DefaultInterface.DisableSaveToFile;
end;

procedure TAcRptEngineProperties.Set_DisableSaveToFile(Value: WordBool);
begin
  DefaultInterface.Set_DisableSaveToFile(Value);
end;

function TAcRptEngineProperties.Get_ShowPreviewOnPrepare: WordBool;
begin
    Result := DefaultInterface.ShowPreviewOnPrepare;
end;

procedure TAcRptEngineProperties.Set_ShowPreviewOnPrepare(Value: WordBool);
begin
  DefaultInterface.Set_ShowPreviewOnPrepare(Value);
end;

function TAcRptEngineProperties.Get_ShowProgress: WordBool;
begin
    Result := DefaultInterface.ShowProgress;
end;

procedure TAcRptEngineProperties.Set_ShowProgress(Value: WordBool);
begin
  DefaultInterface.Set_ShowProgress(Value);
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TCustDataBuilder, TAcRptEngine]);
end;

end.
