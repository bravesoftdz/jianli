unit AcWebClient_TLB;

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
// File generated on 2011-01-11 23:11:16 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\controls\ACreport\COM\ActiveForm_web\AcWebClient.ocx (1)
// LIBID: {CAB717DC-437A-4FED-8B04-CC6A040AC354}
// LCID: 0
// Helpfile: 
// HelpString: AcWebClient Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v1.0 AcReport, (E:\controls\ACreport\COM\com\AcReport.dll)
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

uses Windows, AcReport_TLB, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, 
Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AcWebClientMajorVersion = 1;
  AcWebClientMinorVersion = 0;

  LIBID_AcWebClient: TGUID = '{CAB717DC-437A-4FED-8B04-CC6A040AC354}';

  IID_IAcWebClientView: TGUID = '{4B3333D2-DD4C-4BD9-8517-7C4E93E9DA98}';
  DIID_IAcWebClientViewEvents: TGUID = '{4921FFA7-E66D-45FF-AC1B-3D540B57AA6B}';
  CLASS_AcWebClientView: TGUID = '{62E6B2C0-43AF-4FEA-A0E5-0B496DA5A681}';
  IID_IAcReportViewX: TGUID = '{7C4EF436-9303-4653-86B1-7D6BEF0728DC}';
  DIID_IAcReportViewXEvents: TGUID = '{11146C04-CB45-42E8-B2BC-22BB62C6ED3C}';
  CLASS_AcReportViewX: TGUID = '{D86C06C7-68E1-4040-AB74-28AD4C7C3263}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TxActiveFormBorderStyle
type
  TxActiveFormBorderStyle = TOleEnum;
const
  afbNone = $00000000;
  afbSingle = $00000001;
  afbSunken = $00000002;
  afbRaised = $00000003;

// Constants for enum TxPrintScale
type
  TxPrintScale = TOleEnum;
const
  poNone = $00000000;
  poProportional = $00000001;
  poPrintToFit = $00000002;

// Constants for enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

// Constants for enum TxCellSide
type
  TxCellSide = TOleEnum;
const
  bcLeft = $00000000;
  bcTop = $00000001;
  bcRight = $00000002;
  bcBottom = $00000003;

// Constants for enum TxAlignment
type
  TxAlignment = TOleEnum;
const
  taLeftJustify = $00000000;
  taRightJustify = $00000001;
  taCenter = $00000002;

// Constants for enum TxBevelCut
type
  TxBevelCut = TOleEnum;
const
  bvNone = $00000000;
  bvLowered = $00000001;
  bvRaised = $00000002;
  bvSpace = $00000003;

// Constants for enum TxBorderStyle
type
  TxBorderStyle = TOleEnum;
const
  bsNone = $00000000;
  bsSingle = $00000001;

// Constants for enum TxDragMode
type
  TxDragMode = TOleEnum;
const
  dmManual = $00000000;
  dmAutomatic = $00000001;

// Constants for enum TxBevelKind
type
  TxBevelKind = TOleEnum;
const
  bkNone = $00000000;
  bkTile = $00000001;
  bkSoft = $00000002;
  bkFlat = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAcWebClientView = interface;
  IAcWebClientViewDisp = dispinterface;
  IAcWebClientViewEvents = dispinterface;
  IAcReportViewX = interface;
  IAcReportViewXDisp = dispinterface;
  IAcReportViewXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AcWebClientView = IAcWebClientView;
  AcReportViewX = IAcReportViewX;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}


// *********************************************************************//
// Interface: IAcWebClientView
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4B3333D2-DD4C-4BD9-8517-7C4E93E9DA98}
// *********************************************************************//
  IAcWebClientView = interface(IDispatch)
    ['{4B3333D2-DD4C-4BD9-8517-7C4E93E9DA98}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_AutoScroll: WordBool; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    function Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function Get_KeyPreview: WordBool; safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    function Get_PixelsPerInch: Integer; safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    function Get_Scaled: WordBool; safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    function Get_Active: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    function Get_HelpFile: WideString; safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    function Get_ScreenSnap: WordBool; safecall;
    procedure Set_ScreenSnap(Value: WordBool); safecall;
    function Get_SnapBuffer: Integer; safecall;
    procedure Set_SnapBuffer(Value: Integer); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_RepFileName: WideString; safecall;
    procedure Set_RepFileName(const Value: WideString); safecall;
    procedure OpenRepFromFile(const AFileName: WideString; AIfCompressed: WordBool); safecall;
    procedure OpenRepFromURL(const AURL: WideString; AIfCompressed: WordBool); safecall;
    function Get_URL: WideString; safecall;
    procedure Set_URL(const Value: WideString); safecall;
    procedure ShowDesigner; safecall;
    function Get_ReportEngine: IAcRptEngine; safecall;
    function Get_ToolBarVisible: WordBool; safecall;
    procedure Set_ToolBarVisible(Value: WordBool); safecall;
    procedure ShowOpenDlg; safecall;
    procedure ShowSaveDlg; safecall;
    procedure ShowPageSetDlg; safecall;
    procedure EditCurPage; safecall;
    procedure ShowExportToExcelDlg; safecall;
    procedure ShowPrintDlg; safecall;
    procedure PrintReport; safecall;
    procedure PrintCurPage; safecall;
    procedure StopPrepare; safecall;
    procedure SetToPageSize; safecall;
    procedure ZoomIn; safecall;
    procedure ZoomOut; safecall;
    procedure GotoPage(PageIndex: Integer); safecall;
    procedure GotoNextPage; safecall;
    procedure GotoPriorPage; safecall;
    procedure GotoFirstPage; safecall;
    procedure GotoLastPage; safecall;
    function GetPagesCount: Integer; safecall;
    function GetCurPageIndex: Integer; safecall;
    function Get_LeftMargin: Integer; safecall;
    procedure Set_LeftMargin(Value: Integer); safecall;
    function Get_TopMargin: Integer; safecall;
    procedure Set_TopMargin(Value: Integer); safecall;
    function Get_RightMargin: Integer; safecall;
    procedure Set_RightMargin(Value: Integer); safecall;
    function Get_BottomMargin: Integer; safecall;
    procedure Set_BottomMargin(Value: Integer); safecall;
    function Get_ScaleRate: Integer; safecall;
    procedure Set_ScaleRate(Value: Integer); safecall;
    function OpenRepFromStream(const aStream: IAcNetStream; IfCompressed: WordBool): HResult; safecall;
    procedure RefreshRegInfo; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AutoScroll: WordBool read Get_AutoScroll write Set_AutoScroll;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property AxBorderStyle: TxActiveFormBorderStyle read Get_AxBorderStyle write Set_AxBorderStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Font: IFontDisp read Get_Font write Set_Font;
    property KeyPreview: WordBool read Get_KeyPreview write Set_KeyPreview;
    property PixelsPerInch: Integer read Get_PixelsPerInch write Set_PixelsPerInch;
    property PrintScale: TxPrintScale read Get_PrintScale write Set_PrintScale;
    property Scaled: WordBool read Get_Scaled write Set_Scaled;
    property Active: WordBool read Get_Active;
    property DropTarget: WordBool read Get_DropTarget write Set_DropTarget;
    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;
    property ScreenSnap: WordBool read Get_ScreenSnap write Set_ScreenSnap;
    property SnapBuffer: Integer read Get_SnapBuffer write Set_SnapBuffer;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property RepFileName: WideString read Get_RepFileName write Set_RepFileName;
    property URL: WideString read Get_URL write Set_URL;
    property ReportEngine: IAcRptEngine read Get_ReportEngine;
    property ToolBarVisible: WordBool read Get_ToolBarVisible write Set_ToolBarVisible;
    property LeftMargin: Integer read Get_LeftMargin write Set_LeftMargin;
    property TopMargin: Integer read Get_TopMargin write Set_TopMargin;
    property RightMargin: Integer read Get_RightMargin write Set_RightMargin;
    property BottomMargin: Integer read Get_BottomMargin write Set_BottomMargin;
    property ScaleRate: Integer read Get_ScaleRate write Set_ScaleRate;
  end;

// *********************************************************************//
// DispIntf:  IAcWebClientViewDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4B3333D2-DD4C-4BD9-8517-7C4E93E9DA98}
// *********************************************************************//
  IAcWebClientViewDisp = dispinterface
    ['{4B3333D2-DD4C-4BD9-8517-7C4E93E9DA98}']
    property Visible: WordBool dispid 201;
    property AutoScroll: WordBool dispid 202;
    property AutoSize: WordBool dispid 203;
    property AxBorderStyle: TxActiveFormBorderStyle dispid 204;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Font: IFontDisp dispid -512;
    property KeyPreview: WordBool dispid 205;
    property PixelsPerInch: Integer dispid 206;
    property PrintScale: TxPrintScale dispid 207;
    property Scaled: WordBool dispid 208;
    property Active: WordBool readonly dispid 209;
    property DropTarget: WordBool dispid 210;
    property HelpFile: WideString dispid 211;
    property ScreenSnap: WordBool dispid 212;
    property SnapBuffer: Integer dispid 213;
    property DoubleBuffered: WordBool dispid 214;
    property AlignDisabled: WordBool readonly dispid 215;
    property VisibleDockClientCount: Integer readonly dispid 216;
    property Enabled: WordBool dispid -514;
    property RepFileName: WideString dispid 217;
    procedure OpenRepFromFile(const AFileName: WideString; AIfCompressed: WordBool); dispid 218;
    procedure OpenRepFromURL(const AURL: WideString; AIfCompressed: WordBool); dispid 219;
    property URL: WideString dispid 220;
    procedure ShowDesigner; dispid 222;
    property ReportEngine: IAcRptEngine readonly dispid 221;
    property ToolBarVisible: WordBool dispid 223;
    procedure ShowOpenDlg; dispid 224;
    procedure ShowSaveDlg; dispid 225;
    procedure ShowPageSetDlg; dispid 226;
    procedure EditCurPage; dispid 227;
    procedure ShowExportToExcelDlg; dispid 228;
    procedure ShowPrintDlg; dispid 229;
    procedure PrintReport; dispid 230;
    procedure PrintCurPage; dispid 231;
    procedure StopPrepare; dispid 232;
    procedure SetToPageSize; dispid 233;
    procedure ZoomIn; dispid 234;
    procedure ZoomOut; dispid 235;
    procedure GotoPage(PageIndex: Integer); dispid 236;
    procedure GotoNextPage; dispid 237;
    procedure GotoPriorPage; dispid 238;
    procedure GotoFirstPage; dispid 239;
    procedure GotoLastPage; dispid 240;
    function GetPagesCount: Integer; dispid 241;
    function GetCurPageIndex: Integer; dispid 242;
    property LeftMargin: Integer dispid 243;
    property TopMargin: Integer dispid 244;
    property RightMargin: Integer dispid 245;
    property BottomMargin: Integer dispid 246;
    property ScaleRate: Integer dispid 247;
    function OpenRepFromStream(const aStream: IAcNetStream; IfCompressed: WordBool): HResult; dispid 248;
    procedure RefreshRegInfo; dispid 249;
  end;

// *********************************************************************//
// DispIntf:  IAcWebClientViewEvents
// Flags:     (4096) Dispatchable
// GUID:      {4921FFA7-E66D-45FF-AC1B-3D540B57AA6B}
// *********************************************************************//
  IAcWebClientViewEvents = dispinterface
    ['{4921FFA7-E66D-45FF-AC1B-3D540B57AA6B}']
    procedure OnActivate; dispid 201;
    procedure OnClick; dispid 202;
    procedure OnCreate; dispid 203;
    procedure OnDblClick; dispid 204;
    procedure OnDestroy; dispid 205;
    procedure OnDeactivate; dispid 206;
    procedure OnKeyPress(var Key: Smallint); dispid 207;
    procedure OnPaint; dispid 208;
  end;

// *********************************************************************//
// Interface: IAcReportViewX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7C4EF436-9303-4653-86B1-7D6BEF0728DC}
// *********************************************************************//
  IAcReportViewX = interface(IDispatch)
    ['{7C4EF436-9303-4653-86B1-7D6BEF0728DC}']
    function Get_ReadOnly: WordBool; safecall;
    procedure Set_ReadOnly(Value: WordBool); safecall;
    function Get_AutoScroll: WordBool; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    function Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function Get_BevelInner: TxBevelCut; safecall;
    procedure Set_BevelInner(Value: TxBevelCut); safecall;
    function Get_BevelOuter: TxBevelCut; safecall;
    procedure Set_BevelOuter(Value: TxBevelCut); safecall;
    function Get_BevelKind: TxBevelKind; safecall;
    procedure Set_BevelKind(Value: TxBevelKind); safecall;
    function Get_BorderStyle: TxBorderStyle; safecall;
    procedure Set_BorderStyle(Value: TxBorderStyle); safecall;
    function Get_DockSite: WordBool; safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    function Get_DragCursor: Smallint; safecall;
    procedure Set_DragCursor(Value: Smallint); safecall;
    function Get_DragMode: TxDragMode; safecall;
    procedure Set_DragMode(Value: TxDragMode); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Ctl3D: WordBool; safecall;
    procedure Set_Ctl3D(Value: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function Get_ParentBackground: WordBool; safecall;
    procedure Set_ParentBackground(Value: WordBool); safecall;
    function Get_ParentColor: WordBool; safecall;
    procedure Set_ParentColor(Value: WordBool); safecall;
    function Get_ParentCtl3D: WordBool; safecall;
    procedure Set_ParentCtl3D(Value: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure DisableAutoRange; safecall;
    procedure EnableAutoRange; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    procedure InitiateAction; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    function Get_ReportEngine: IAcRptEngine; safecall;
    procedure ShowDesigner; safecall;
    property ReadOnly: WordBool read Get_ReadOnly write Set_ReadOnly;
    property AutoScroll: WordBool read Get_AutoScroll write Set_AutoScroll;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BevelInner: TxBevelCut read Get_BevelInner write Set_BevelInner;
    property BevelOuter: TxBevelCut read Get_BevelOuter write Set_BevelOuter;
    property BevelKind: TxBevelKind read Get_BevelKind write Set_BevelKind;
    property BorderStyle: TxBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property DockSite: WordBool read Get_DockSite write Set_DockSite;
    property DragCursor: Smallint read Get_DragCursor write Set_DragCursor;
    property DragMode: TxDragMode read Get_DragMode write Set_DragMode;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Ctl3D: WordBool read Get_Ctl3D write Set_Ctl3D;
    property Font: IFontDisp read Get_Font write Set_Font;
    property ParentBackground: WordBool read Get_ParentBackground write Set_ParentBackground;
    property ParentColor: WordBool read Get_ParentColor write Set_ParentColor;
    property ParentCtl3D: WordBool read Get_ParentCtl3D write Set_ParentCtl3D;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property ReportEngine: IAcRptEngine read Get_ReportEngine;
  end;

// *********************************************************************//
// DispIntf:  IAcReportViewXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7C4EF436-9303-4653-86B1-7D6BEF0728DC}
// *********************************************************************//
  IAcReportViewXDisp = dispinterface
    ['{7C4EF436-9303-4653-86B1-7D6BEF0728DC}']
    property ReadOnly: WordBool dispid 201;
    property AutoScroll: WordBool dispid 202;
    property AutoSize: WordBool dispid 203;
    property BevelInner: TxBevelCut dispid 204;
    property BevelOuter: TxBevelCut dispid 205;
    property BevelKind: TxBevelKind dispid 206;
    property BorderStyle: TxBorderStyle dispid 207;
    property DockSite: WordBool dispid 208;
    property DragCursor: Smallint dispid 209;
    property DragMode: TxDragMode dispid 210;
    property Enabled: WordBool dispid -514;
    property Color: OLE_COLOR dispid -501;
    property Ctl3D: WordBool dispid 211;
    property Font: IFontDisp dispid -512;
    property ParentBackground: WordBool dispid 212;
    property ParentColor: WordBool dispid 213;
    property ParentCtl3D: WordBool dispid 214;
    property Visible: WordBool dispid 215;
    procedure DisableAutoRange; dispid 216;
    procedure EnableAutoRange; dispid 217;
    property DoubleBuffered: WordBool dispid 218;
    property AlignDisabled: WordBool readonly dispid 219;
    property VisibleDockClientCount: Integer readonly dispid 220;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; dispid 221;
    procedure InitiateAction; dispid 222;
    function IsRightToLeft: WordBool; dispid 223;
    function UseRightToLeftReading: WordBool; dispid 224;
    function UseRightToLeftScrollBar: WordBool; dispid 225;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 226;
    property ReportEngine: IAcRptEngine readonly dispid 227;
    procedure ShowDesigner; dispid 228;
  end;

// *********************************************************************//
// DispIntf:  IAcReportViewXEvents
// Flags:     (4096) Dispatchable
// GUID:      {11146C04-CB45-42E8-B2BC-22BB62C6ED3C}
// *********************************************************************//
  IAcReportViewXEvents = dispinterface
    ['{11146C04-CB45-42E8-B2BC-22BB62C6ED3C}']
    procedure OnCanResize(var NewWidth: Integer; var NewHeight: Integer; var Resize: WordBool); dispid 201;
    procedure OnClick; dispid 202;
    procedure OnConstrainedResize(var MinWidth: Integer; var MinHeight: Integer; 
                                  var MaxWidth: Integer; var MaxHeight: Integer); dispid 203;
    procedure OnDblClick; dispid 204;
    procedure OnResize; dispid 205;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAcWebClientView
// Help String      : AcWebClientView Control
// Default Interface: IAcWebClientView
// Def. Intf. DISP? : No
// Event   Interface: IAcWebClientViewEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TAcWebClientViewOnKeyPress = procedure(ASender: TObject; var Key: Smallint) of object;

  TAcWebClientView = class(TOleControl)
  private
    FOnActivate: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnCreate: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnKeyPress: TAcWebClientViewOnKeyPress;
    FOnPaint: TNotifyEvent;
    FIntf: IAcWebClientView;
    function  GetControlInterface: IAcWebClientView;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ReportEngine: IAcRptEngine;
  public
    procedure OpenRepFromFile(const AFileName: WideString; AIfCompressed: WordBool);
    procedure OpenRepFromURL(const AURL: WideString; AIfCompressed: WordBool);
    procedure ShowDesigner;
    procedure ShowOpenDlg;
    procedure ShowSaveDlg;
    procedure ShowPageSetDlg;
    procedure EditCurPage;
    procedure ShowExportToExcelDlg;
    procedure ShowPrintDlg;
    procedure PrintReport;
    procedure PrintCurPage;
    procedure StopPrepare;
    procedure SetToPageSize;
    procedure ZoomIn;
    procedure ZoomOut;
    procedure GotoPage(PageIndex: Integer);
    procedure GotoNextPage;
    procedure GotoPriorPage;
    procedure GotoFirstPage;
    procedure GotoLastPage;
    function GetPagesCount: Integer;
    function GetCurPageIndex: Integer;
    function OpenRepFromStream(const aStream: IAcNetStream; IfCompressed: WordBool): HResult;
    procedure RefreshRegInfo;
    property  ControlInterface: IAcWebClientView read GetControlInterface;
    property  DefaultInterface: IAcWebClientView read GetControlInterface;
    property Visible: WordBool index 201 read GetWordBoolProp write SetWordBoolProp;
    property Active: WordBool index 209 read GetWordBoolProp;
    property DropTarget: WordBool index 210 read GetWordBoolProp write SetWordBoolProp;
    property HelpFile: WideString index 211 read GetWideStringProp write SetWideStringProp;
    property ScreenSnap: WordBool index 212 read GetWordBoolProp write SetWordBoolProp;
    property SnapBuffer: Integer index 213 read GetIntegerProp write SetIntegerProp;
    property DoubleBuffered: WordBool index 214 read GetWordBoolProp write SetWordBoolProp;
    property AlignDisabled: WordBool index 215 read GetWordBoolProp;
    property VisibleDockClientCount: Integer index 216 read GetIntegerProp;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp;
    property ReportEngine: IAcRptEngine read Get_ReportEngine;
  published
    property Anchors;
    property  ParentColor;
    property  ParentFont;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property AutoScroll: WordBool index 202 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoSize: WordBool index 203 read GetWordBoolProp write SetWordBoolProp stored False;
    property AxBorderStyle: TOleEnum index 204 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Caption: WideString index -518 read GetWideStringProp write SetWideStringProp stored False;
    property Color: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property KeyPreview: WordBool index 205 read GetWordBoolProp write SetWordBoolProp stored False;
    property PixelsPerInch: Integer index 206 read GetIntegerProp write SetIntegerProp stored False;
    property PrintScale: TOleEnum index 207 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Scaled: WordBool index 208 read GetWordBoolProp write SetWordBoolProp stored False;
    property RepFileName: WideString index 217 read GetWideStringProp write SetWideStringProp stored False;
    property URL: WideString index 220 read GetWideStringProp write SetWideStringProp stored False;
    property ToolBarVisible: WordBool index 223 read GetWordBoolProp write SetWordBoolProp stored False;
    property LeftMargin: Integer index 243 read GetIntegerProp write SetIntegerProp stored False;
    property TopMargin: Integer index 244 read GetIntegerProp write SetIntegerProp stored False;
    property RightMargin: Integer index 245 read GetIntegerProp write SetIntegerProp stored False;
    property BottomMargin: Integer index 246 read GetIntegerProp write SetIntegerProp stored False;
    property ScaleRate: Integer index 247 read GetIntegerProp write SetIntegerProp stored False;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnKeyPress: TAcWebClientViewOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAcReportViewX
// Help String      : AcReportViewX Control
// Default Interface: IAcReportViewX
// Def. Intf. DISP? : No
// Event   Interface: IAcReportViewXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TAcReportViewXOnCanResize = procedure(ASender: TObject; var NewWidth: Integer; 
                                                          var NewHeight: Integer; 
                                                          var Resize: WordBool) of object;
  TAcReportViewXOnConstrainedResize = procedure(ASender: TObject; var MinWidth: Integer; 
                                                                  var MinHeight: Integer; 
                                                                  var MaxWidth: Integer; 
                                                                  var MaxHeight: Integer) of object;

  TAcReportViewX = class(TOleControl)
  private
    FOnCanResize: TAcReportViewXOnCanResize;
    FOnClick: TNotifyEvent;
    FOnConstrainedResize: TAcReportViewXOnConstrainedResize;
    FOnDblClick: TNotifyEvent;
    FOnResize: TNotifyEvent;
    FIntf: IAcReportViewX;
    function  GetControlInterface: IAcReportViewX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ReportEngine: IAcRptEngine;
  public
    procedure DisableAutoRange;
    procedure EnableAutoRange;
    function DrawTextBiDiModeFlagsReadingOnly: Integer;
    procedure InitiateAction;
    function IsRightToLeft: WordBool;
    function UseRightToLeftReading: WordBool;
    function UseRightToLeftScrollBar: WordBool;
    procedure SetSubComponent(IsSubComponent: WordBool);
    procedure ShowDesigner;
    property  ControlInterface: IAcReportViewX read GetControlInterface;
    property  DefaultInterface: IAcReportViewX read GetControlInterface;
    property DoubleBuffered: WordBool index 218 read GetWordBoolProp write SetWordBoolProp;
    property AlignDisabled: WordBool index 219 read GetWordBoolProp;
    property VisibleDockClientCount: Integer index 220 read GetIntegerProp;
    property ReportEngine: IAcRptEngine read Get_ReportEngine;
  published
    property Anchors;
    property  ParentFont;
    property  Align;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property ReadOnly: WordBool index 201 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoScroll: WordBool index 202 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoSize: WordBool index 203 read GetWordBoolProp write SetWordBoolProp stored False;
    property BevelInner: TOleEnum index 204 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BevelOuter: TOleEnum index 205 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BevelKind: TOleEnum index 206 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index 207 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property DockSite: WordBool index 208 read GetWordBoolProp write SetWordBoolProp stored False;
    property DragCursor: Smallint index 209 read GetSmallintProp write SetSmallintProp stored False;
    property DragMode: TOleEnum index 210 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property Color: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Ctl3D: WordBool index 211 read GetWordBoolProp write SetWordBoolProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property ParentBackground: WordBool index 212 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentColor: WordBool index 213 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentCtl3D: WordBool index 214 read GetWordBoolProp write SetWordBoolProp stored False;
    property Visible: WordBool index 215 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnCanResize: TAcReportViewXOnCanResize read FOnCanResize write FOnCanResize;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnConstrainedResize: TAcReportViewXOnConstrainedResize read FOnConstrainedResize write FOnConstrainedResize;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TAcWebClientView.InitControlData;
const
  CEventDispIDs: array [0..7] of DWORD = (
    $000000C9, $000000CA, $000000CB, $000000CC, $000000CD, $000000CE,
    $000000CF, $000000D0);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{62E6B2C0-43AF-4FEA-A0E5-0B496DA5A681}';
    EventIID: '{4921FFA7-E66D-45FF-AC1B-3D540B57AA6B}';
    EventCount: 8;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $0000001D;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnActivate) - Cardinal(Self);
end;

procedure TAcWebClientView.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IAcWebClientView;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAcWebClientView.GetControlInterface: IAcWebClientView;
begin
  CreateControl;
  Result := FIntf;
end;

function TAcWebClientView.Get_ReportEngine: IAcRptEngine;
begin
    Result := DefaultInterface.ReportEngine;
end;

procedure TAcWebClientView.OpenRepFromFile(const AFileName: WideString; AIfCompressed: WordBool);
begin
  DefaultInterface.OpenRepFromFile(AFileName, AIfCompressed);
end;

procedure TAcWebClientView.OpenRepFromURL(const AURL: WideString; AIfCompressed: WordBool);
begin
  DefaultInterface.OpenRepFromURL(AURL, AIfCompressed);
end;

procedure TAcWebClientView.ShowDesigner;
begin
  DefaultInterface.ShowDesigner;
end;

procedure TAcWebClientView.ShowOpenDlg;
begin
  DefaultInterface.ShowOpenDlg;
end;

procedure TAcWebClientView.ShowSaveDlg;
begin
  DefaultInterface.ShowSaveDlg;
end;

procedure TAcWebClientView.ShowPageSetDlg;
begin
  DefaultInterface.ShowPageSetDlg;
end;

procedure TAcWebClientView.EditCurPage;
begin
  DefaultInterface.EditCurPage;
end;

procedure TAcWebClientView.ShowExportToExcelDlg;
begin
  DefaultInterface.ShowExportToExcelDlg;
end;

procedure TAcWebClientView.ShowPrintDlg;
begin
  DefaultInterface.ShowPrintDlg;
end;

procedure TAcWebClientView.PrintReport;
begin
  DefaultInterface.PrintReport;
end;

procedure TAcWebClientView.PrintCurPage;
begin
  DefaultInterface.PrintCurPage;
end;

procedure TAcWebClientView.StopPrepare;
begin
  DefaultInterface.StopPrepare;
end;

procedure TAcWebClientView.SetToPageSize;
begin
  DefaultInterface.SetToPageSize;
end;

procedure TAcWebClientView.ZoomIn;
begin
  DefaultInterface.ZoomIn;
end;

procedure TAcWebClientView.ZoomOut;
begin
  DefaultInterface.ZoomOut;
end;

procedure TAcWebClientView.GotoPage(PageIndex: Integer);
begin
  DefaultInterface.GotoPage(PageIndex);
end;

procedure TAcWebClientView.GotoNextPage;
begin
  DefaultInterface.GotoNextPage;
end;

procedure TAcWebClientView.GotoPriorPage;
begin
  DefaultInterface.GotoPriorPage;
end;

procedure TAcWebClientView.GotoFirstPage;
begin
  DefaultInterface.GotoFirstPage;
end;

procedure TAcWebClientView.GotoLastPage;
begin
  DefaultInterface.GotoLastPage;
end;

function TAcWebClientView.GetPagesCount: Integer;
begin
  Result := DefaultInterface.GetPagesCount;
end;

function TAcWebClientView.GetCurPageIndex: Integer;
begin
  Result := DefaultInterface.GetCurPageIndex;
end;

function TAcWebClientView.OpenRepFromStream(const aStream: IAcNetStream; IfCompressed: WordBool): HResult;
begin
  Result := DefaultInterface.OpenRepFromStream(aStream, IfCompressed);
end;

procedure TAcWebClientView.RefreshRegInfo;
begin
  DefaultInterface.RefreshRegInfo;
end;

procedure TAcReportViewX.InitControlData;
const
  CEventDispIDs: array [0..4] of DWORD = (
    $000000C9, $000000CA, $000000CB, $000000CC, $000000CD);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{D86C06C7-68E1-4040-AB74-28AD4C7C3263}';
    EventIID: '{11146C04-CB45-42E8-B2BC-22BB62C6ED3C}';
    EventCount: 5;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $0000000D;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnCanResize) - Cardinal(Self);
end;

procedure TAcReportViewX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IAcReportViewX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAcReportViewX.GetControlInterface: IAcReportViewX;
begin
  CreateControl;
  Result := FIntf;
end;

function TAcReportViewX.Get_ReportEngine: IAcRptEngine;
begin
    Result := DefaultInterface.ReportEngine;
end;

procedure TAcReportViewX.DisableAutoRange;
begin
  DefaultInterface.DisableAutoRange;
end;

procedure TAcReportViewX.EnableAutoRange;
begin
  DefaultInterface.EnableAutoRange;
end;

function TAcReportViewX.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := DefaultInterface.DrawTextBiDiModeFlagsReadingOnly;
end;

procedure TAcReportViewX.InitiateAction;
begin
  DefaultInterface.InitiateAction;
end;

function TAcReportViewX.IsRightToLeft: WordBool;
begin
  Result := DefaultInterface.IsRightToLeft;
end;

function TAcReportViewX.UseRightToLeftReading: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftReading;
end;

function TAcReportViewX.UseRightToLeftScrollBar: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftScrollBar;
end;

procedure TAcReportViewX.SetSubComponent(IsSubComponent: WordBool);
begin
  DefaultInterface.SetSubComponent(IsSubComponent);
end;

procedure TAcReportViewX.ShowDesigner;
begin
  DefaultInterface.ShowDesigner;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TAcWebClientView, TAcReportViewX]);
end;

end.
