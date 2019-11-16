{*******************************************************}
{                                                       }
{                        EhLib v5.2                     }
{                                                       }
{                  TDBGridEh component                  }
{               with support of IMemTableEh             }
{                      Build 5.2.80                     }
{                                                       }
{   Copyright (c) 1998-2010 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEh;

//{$R-}

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  WinUtils,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Graphics, GridsEh, DBCtrls, Db, Menus, Registry, DBSumLst, DBCtrlsEh,
  IniFiles, ToolCtrlsEh, ImgList, StdActns, PropFilerEh, ActnList
  ,DBGridEhGrouping
 //The PropStorage
  {,dbugintf};

type

  TDBGridColumnsState = (csDefault, csCustomized);
  TDrawDataCellEvent = procedure (Sender: TObject; const Rect: TRect; Field: TField;
    State: TGridDrawState) of object;
  TDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect,
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect);
  TDBGridOptions = set of TDBGridOption;

  TColumnEhValue = (cvColor, cvWidth, cvFont, cvAlignment, cvReadOnly, cvTitleColor,
    cvTitleCaption, cvTitleAlignment, cvTitleFont, cvTitleButton, cvTitleEndEllipsis,
    cvTitleToolTips, cvTitleOrientation, cvImeMode, cvImeName, cvWordWrap,
    cvLookupDisplayFields, cvCheckboxes, cvAlwaysShowEditButton, cvEndEllipsis,
    cvAutoDropDown, cvDblClickNextVal, cvToolTips, cvDropDownSizing,
    cvDropDownShowTitles, cvLayout, cvHighlightRequired, cvBiDiMode, cvTextEditing);
  TColumnEhValues = set of TColumnEhValue;

  TColumnFooterEhValue = (cvFooterAlignment, cvFooterFont, cvFooterColor, cvFooterToolTips);
  TColumnFooterValues = set of TColumnFooterEhValue;

  TColumnEhRestoreParam = (crpColIndexEh, crpColWidthsEh, crpSortMarkerEh, crpColVisibleEh,
    crpDropDownRowsEh, crpDropDownWidthEh, crpRowPanelColPlacementEh);
  TColumnEhRestoreParams = set of TColumnEhRestoreParam;

  TDBGridEhRestoreParam = (grpColIndexEh, grpColWidthsEh, grpSortMarkerEh, grpColVisibleEh,
    grpRowHeightEh, grpDropDownRowsEh, grpDropDownWidthEh, grpRowPanelColPlacementEh);
  TDBGridEhRestoreParams = set of TDBGridEhRestoreParam;

const
  cm_DeferLayout = WM_USER + 100;
  IndicatorWidth = 11;

  ColumnEhTitleValues = [cvTitleColor..cvTitleOrientation];
  ColumnEhFooterValues = [cvFooterAlignment..cvFooterColor];
(*  cm_DeferLayout = WM_USER + 100; *)

{ TColumnEh defines internal storage for column attributes.  If IsStored is
  True, values assigned to properties are stored in this object, the grid-
  or field-based default sources are not modified.  Values read from
  properties are the previously assigned value, if any, or the grid- or
  field-based default values if nothing has been assigned to that property.
  This class also publishes the column attribute properties for persistent
  storage.

  If IsStored is True, the column does not maintain local storage of
  property values.  Assignments to column properties are passed through to
  the underlying grid- or field-based default sources.  }

type
  TColumnEh = class;
  TCustomDBGridEh = class;
  TColumnDropDownBoxEh = class;
  TDBGridEhStyle = class;
  TDBGridEhCenter = class;

{    for lookup drop-down grid    }

  TDBLookupGridEhOption = (dlgColumnResizeEh, dlgColLinesEh, dlgRowLinesEh,
    dlgAutoSortMarkingEh, dlgMultiSortMarkingEh);
  TDBLookupGridEhOptions = set of TDBLookupGridEhOption;

  TCheckTitleEhBtnEvent = procedure(Sender: TObject; ACol: Longint;
    Column: TColumnEh; var Enabled: Boolean) of object;
  TDrawColumnEhCellEvent = procedure(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumnEh; State: TGridDrawState) of object;
  TGetCellEhParamsEvent = procedure(Sender: TObject; Column: TColumnEh;
    AFont: TFont; var Background: TColor; State: TGridDrawState) of object;
  TTitleEhClickEvent = procedure(Sender: TObject; ACol: Longint;
    Column: TColumnEh) of object;
  TOnColumnCheckDrawRequiredStateEventEh = procedure(Sender: TObject;
    Text: String; var DrawState: Boolean) of object;
  TGridMoveRecordsEventEh = function(Sender: TObject; BookmarkList: TBMListEh;
    ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean of object;
  TDBGridEhBuildIndicatorTitleMenu = procedure (Grid: TCustomDBGridEh;
    var PopupMenu: TPopupMenu) of object;

{ ILookupGridOwner interface }

  ILookupGridOwner = interface
    ['{2A1F4552-15C3-4359-ADAB-F2F6719FAA97}']
    procedure SetListSource(AListSource: TDataSource);
    function GetLookupGrid: TCustomDBGridEh;
    function GetOptions: TDBLookupGridEhOptions;
    procedure SetOptions(Value: TDBLookupGridEhOptions);
    property Options: TDBLookupGridEhOptions read GetOptions write SetOptions;
  end;

  TSortMarkerEh = (smNoneEh, smDownEh, smUpEh);
  TTextOrientationEh = (tohHorizontal, tohVertical);

{ TColumnTitleEh }

  TColumnTitleEh = class(TPersistent)
  private
    FAlignment: TAlignment;
    FCaption: string;
    FColor: TColor;
    FColumn: TColumnEh;
    FEndEllipsis: Boolean;
    FFont: TFont;
    FHint: string;
    FImageIndex: Integer;
    FOrientation: TTextOrientationEh;
    FSortIndex: Integer;
    FToolTips: Boolean;
    function GetAlignment: TAlignment;
    function GetCaption: string;
    function GetColor: TColor;
    function GetEndEllipsis: Boolean;
    function GetFont: TFont;
    function GetOrientation: TTextOrientationEh;
    function GetTitleButton: Boolean;
    function GetToolTips: Boolean;
    function IsAlignmentStored: Boolean;
    function IsCaptionStored: Boolean;
    function IsColorStored: Boolean;
    function IsEndEllipsisStored: Boolean;
    function IsFontStored: Boolean;
    function IsOrientationStored: Boolean;
    function IsTitleButtonStored: Boolean;
    function IsToolTipsStored: Boolean;
    procedure FontChanged(Sender: TObject);
    procedure SetAlignment(Value: TAlignment);
    procedure SetCaption(const Value: string); virtual;
    procedure SetColor(Value: TColor);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetImageIndex(const Value: Integer);
    procedure SetOrientation(const Value: TTextOrientationEh);
    procedure SetSortIndex(Value: Integer);
    procedure SetToolTips(const Value: Boolean);
  protected
    FSortMarker: TSortMarkerEh;
    FTitleButton: Boolean;
    procedure RefreshDefaultFont;
    procedure SetSortMarker(Value: TSortMarkerEh);
    procedure SetTitleButton(Value: Boolean);
  public
    constructor Create(Column: TColumnEh);
    destructor Destroy; override;
    function DefaultAlignment: TAlignment;
    function DefaultCaption: string;
    function DefaultColor: TColor;
    function DefaultEndEllipsis: Boolean;
    function DefaultFont: TFont;
    function DefaultOrientation: TTextOrientationEh;
    function DefaultTitleButton: Boolean;
    function DefaultToolTips: Boolean;
    function GetSortMarkingWidth: Integer;
    function GetFilterButtonAreaWidth: Integer;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
    procedure SetNextSortMarkerValue(KeepMulti: Boolean);
    property Column: TColumnEh read FColumn;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property EndEllipsis: Boolean read GetEndEllipsis write SetEndEllipsis stored IsEndEllipsisStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property Hint: string read FHint write FHint;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Orientation: TTextOrientationEh read GetOrientation write SetOrientation stored IsOrientationStored;
    property SortIndex: Integer read FSortIndex write SetSortIndex default 0;
    property SortMarker: TSortMarkerEh read FSortMarker write SetSortMarker default smNoneEh;
    property TitleButton: Boolean read GetTitleButton write SetTitleButton stored IsTitleButtonStored;
    property ToolTips: Boolean read GetToolTips write SetToolTips stored IsToolTipsStored;
  end;


{ TColumnFooterEh }

  TFooterValueType = (fvtNon, fvtSum, fvtAvg, fvtCount, fvtFieldValue, fvtStaticText);

  TColumnFooterEh = class(TCollectionItem)
  private
    FAlignment: TAlignment;
    FAssignedValues: TColumnFooterValues;
    FColor: TColor;
    FColumn: TColumnEh;
    FDisplayFormat: String;
    FEndEllipsis: Boolean;
    FFieldName: string;
    FFont: TFont;
    FToolTips: Boolean;
    FValue: String;
    FValueType: TFooterValueType;
    FWordWrap: Boolean;
    function GetAlignment: TAlignment;
    function GetColor: TColor;
    function GetFont: TFont;
    function GetSumValue: Variant;
    function GetToolTips: Boolean;
    function IsAlignmentStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsToolTipsStored: Boolean;
    procedure FontChanged(Sender: TObject);
    procedure SetAlignment(Value: TAlignment);
    procedure SetColor(Value: TColor);
    procedure SetDisplayFormat(const Value: String);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetFieldName(const Value: String);
    procedure SetFont(Value: TFont);
    procedure SetToolTips(const Value: Boolean);
    procedure SetValue(const Value: String);
    procedure SetValueType(const Value: TFooterValueType);
    procedure SetWordWrap(const Value: Boolean);
  protected
    FDBSum: TDBSum;
    procedure RefreshDefaultFont;
  public
    constructor Create(Collection: TCollection); override;
    constructor CreateApart(Column: TColumnEh);
    destructor Destroy; override;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultToolTips: Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure EnsureSumValue;
    procedure RestoreDefaults; virtual;
    property AssignedValues: TColumnFooterValues read FAssignedValues;
    property Column: TColumnEh read FColumn;
    property SumValue: Variant read GetSumValue;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property DisplayFormat: String read FDisplayFormat write SetDisplayFormat;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property FieldName: String read FFieldName write SetFieldName;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property ToolTips: Boolean read GetToolTips write SetToolTips stored IsToolTipsStored;
    property Value: String read FValue write SetValue;
    property ValueType: TFooterValueType read FValueType write SetValueType default fvtNon;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  end;

  TColumnFooterEhClass = class of TColumnFooterEh;

 { TColumnFootersEh }

  TColumnFootersEh = class(TCollection)
  private
    FColumn: TColumnEh;
    function GetFooter(Index: Integer): TColumnFooterEh;
    procedure SetFooter(Index: Integer; Value: TColumnFooterEh);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Column: TColumnEh; FooterClass: TColumnFooterEhClass);
    function Add: TColumnFooterEh;
    property Column: TColumnEh read FColumn;
    property Items[Index: Integer]: TColumnFooterEh read GetFooter write SetFooter; default;
  end;

  TColumnEhType = (ctCommon, ctPickList, ctLookupField, ctKeyPickList, ctKeyImageList,
    ctCheckboxes, ctGraphicData);
  TColumnButtonStyleEh = (cbsAuto, cbsEllipsis, cbsNone, cbsUpDown, cbsDropDown,
    cbsAltUpDown, cbsAltDropDown);

{ TColumnTitleDefValuesEh }

  TColumnDefValuesEh = class;

  TColumnTitleDefValuesEhValue = (cvdpTitleColorEh, cvdpTitleAlignmentEh);
  TColumnTitleDefValuesEhValues = set of TColumnTitleDefValuesEhValue;

  TColumnTitleDefValuesEh = class(TPersistent)
  private
    FAlignment: TAlignment;
    FAssignedValues: TColumnTitleDefValuesEhValues;
    FColor: TColor;
    FColumnDefValues: TColumnDefValuesEh;
    FEndEllipsis: Boolean;
    FOrientation: TTextOrientationEh;
    FTitleButton: Boolean;
    FToolTips: Boolean;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function GetAlignment: TAlignment;
    function GetColor: TColor;
    function IsAlignmentStored: Boolean;
    function IsColorStored: Boolean;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetColor(const Value: TColor);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetOrientation(const Value: TTextOrientationEh);
  public
    procedure Assign(Source: TPersistent); override;
    property AssignedValues: TColumnTitleDefValuesEhValues read FAssignedValues;
  published
    constructor Create(ColumnDefValues: TColumnDefValuesEh);
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property Orientation: TTextOrientationEh read FOrientation write SetOrientation default tohHorizontal;
    property TitleButton: Boolean read FTitleButton write FTitleButton default False;
    property ToolTips: Boolean read FToolTips write FToolTips default False;
  end;

{ TColumnFooterDefValuesEh }

  TColumnFooterDefValuesEh = class(TPersistent)
  private
    FToolTips: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ToolTips: Boolean read FToolTips write FToolTips default False;
  end;

{ TColumnDefValuesEh }

  TColumnDefValuesEh = class(TPersistent)
  private
    FAlwaysShowEditButton: Boolean;
    FAutoDropDown: Boolean;
    FDblClickNextVal: Boolean;
    FDropDownShowTitles: Boolean;
    FDropDownSizing: Boolean;
    FEndEllipsis: Boolean;
    FLayout: TTextLayout;
    FHighlightRequired: Boolean;
    FGrid: TCustomDBGridEh;
    FTitle: TColumnTitleDefValuesEh;
    FFooter: TColumnFooterDefValuesEh;
    FToolTips: Boolean;
    procedure SetAlwaysShowEditButton(const Value: Boolean);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetFooter(const Value: TColumnFooterDefValuesEh);
    procedure SetHighlightRequired(Value: Boolean);
    procedure SetLayout(Value: TTextLayout);
    procedure SetTitle(const Value: TColumnTitleDefValuesEh);
  public
    procedure Assign(Source: TPersistent); override;
  public
    constructor Create(Grid: TCustomDBGridEh);
    destructor Destroy; override;
    property AlwaysShowEditButton: Boolean read FAlwaysShowEditButton write SetAlwaysShowEditButton default False;
    property AutoDropDown: Boolean read FAutoDropDown write FAutoDropDown default False;
    property DblClickNextVal: Boolean read FDblClickNextVal write FDblClickNextVal default False;
    property DropDownShowTitles: Boolean read FDropDownShowTitles write FDropDownShowTitles default False;
    property DropDownSizing: Boolean read FDropDownSizing write FDropDownSizing default False;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property Footer: TColumnFooterDefValuesEh read FFooter write SetFooter;
    property HighlightRequired: Boolean read FHighlightRequired write SetHighlightRequired default False;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Title: TColumnTitleDefValuesEh read FTitle write SetTitle;
    property ToolTips: Boolean read FToolTips write FToolTips default False;
  end;

  TDBGridEhColumnDefValuesEh = class(TColumnDefValuesEh)
  published
    property AlwaysShowEditButton;
    property AutoDropDown;
    property DblClickNextVal;
    property DropDownShowTitles;
    property DropDownSizing;
    property EndEllipsis;
    property Footer;
    property HighlightRequired;
    property Layout;
    property Title;
    property ToolTips;
  end;

{ TSTColumnFilterEh }

  TSTFilterDefaultOperatorEh = (
    fdoAuto, fdoEqual, fdoNotEqual,
    fdoGreaterThan, fdoLessThan, fdoGreaterOrEqual, fdoLessOrEqual,
    fdoLike, fdoNotLike,
    fdoIn, fdoNotIn,
    fdoBeginsWith, fdoDoesntBeginWith,
    fdoEndsWith, fdoDoesntEndWith,
    fdoContains, fdoDoesntContain);

  TSTFilterOperatorEh = (
    foNon, foEqual, foNotEqual,
    foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual,
    foLike, foNotLike,
    foIn, foNotIn,
    foNull, foNotNull,
    foAND, foOR,
    foValue);

  TSTOperandTypeEh = (botNon, botString, botNumber, botDateTime, botBoolean);

  TSTFilterExpressionEh = record
    ExpressionType: TSTOperandTypeEh;
    Operator1: TSTFilterOperatorEh;
    Operand1: Variant;
    Relation: TSTFilterOperatorEh; // foAND, foOR, foNon
    Operator2: TSTFilterOperatorEh;
    Operand2: Variant;
  end;

  TSTColumnFilterEh = class(TPersistent)
  private
    FColumn: TColumnEh;
    FDataField: String;
    FKeyCommaText: String;
    FKeyField: String;
    FKeys: TStrings;
    FKeyValues: Variant;
    FList: TStrings;
    FListField: String;
    FListLink: TFieldDataLink;
    FVisible: Boolean;
    FDropDownListWidth: Integer;
    FDropDownListRows: Integer;
    FPopupListboxItemData: TObject;
    FPopupListboxDownIndex: Integer;
    FPopupFilterItems: TStrings;
    function GetExpression: TSTFilterExpressionEh;
    function GetGrid: TCustomDBGridEh;
    function GetListSource: TDataSource;
    function ParseExpression(Exp: String): String;
    procedure ListLinkActiveChange(Sender: TObject);
    procedure SetExpression(const Value: TSTFilterExpressionEh);
    procedure SetExpressionStr(const Value: String);
    procedure SetListSource(const Value: TDataSource);
    procedure SetVisible(const Value: Boolean);
  protected
    FExpression: TSTFilterExpressionEh;
    FExpressionStr: String;
    FListValuesCheckingState: array of Boolean;
    FInFilterListBox: Boolean;
    FEnterNotClearData: Boolean;
    function GetExpressionAsString: String; virtual;
    function DropDownButtonVisible: Boolean; virtual;
    procedure InternalSetExpressionStr(const Value: String); virtual;
    procedure CheckRecodeKeyList(var FExpression: TSTFilterExpressionEh); virtual;
    procedure UpdateFilterFromValuesCheckingState(ss: TStrings);
    procedure UpdateValuesCheckingStateFromFilter(ss: TStrings);
  public
    constructor Create(AColumn: TColumnEh);
    destructor Destroy; override;
    function GetFieldValueList: IMemTableDataFieldValueListEh;
    function GetFilterFieldName: String; virtual;
    function GetOperand1: Variant; virtual;
    function GetOperand2: Variant; virtual;
    function CurrentKeyField: String;
    function CurrentDataField: String;
    function CurrentListDataSet: TDataSet;
    function CurrentListField: String;
    function GetOperandAsString(Operator: TSTFilterOperatorEh; v: Variant): String;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure SetKeyListValues(AText: String; KeyVals: Variant);
    procedure SetKeysFromListValues(ss: TStrings);
    property DropDownListWidth: Integer read FDropDownListWidth write FDropDownListWidth default 0;
    property DropDownListRows: Integer read FDropDownListRows write FDropDownListRows default 0;
    property Column: TColumnEh read FColumn;
    property Expression: TSTFilterExpressionEh read GetExpression write SetExpression;
    property ExpressionStr: String read FExpressionStr write SetExpressionStr;
    property Grid: TCustomDBGridEh read GetGrid;
    property KeyCommaText: String read FKeyCommaText write FKeyCommaText;
  published
    property DataField: String read FDataField write FDataField;
    property KeyField: String read FKeyField write FKeyField;
    property ListField: String read FListField write FListField;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

{ TColumnEh }

  TColCellParamsEh = class(TObject)
  protected
    FAlignment: TAlignment;
    FBlankCell: Boolean;
    FBackground: TColor;
    FSuppressActiveCellColor: Boolean;
    FCheckboxState: TCheckBoxState;
    FCol: Longint;
    FFont: TFont;
    FImageIndex: Integer;
    FReadOnly: Boolean;
    FRow: Longint;
    FState: TGridDrawState;
    FText: String;
    FTextEditing: Boolean;
    FCellRect: TRect;
  public
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Background: TColor read FBackground write FBackground;
    property BlankCell: Boolean read FBlankCell write FBlankCell;
    property SuppressActiveCellColor: Boolean read FSuppressActiveCellColor write FSuppressActiveCellColor;
    property CheckboxState: TCheckBoxState read FCheckboxState write FCheckboxState;
    property Col: Longint read FCol write FCol;
    property CellRect: TRect read FCellRect;
    property Font: TFont read FFont write FFont;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property Row: Longint read FRow write FRow;
    property State: TGridDrawState read FState write FState;
    property Text: String read FText write FText;
    property TextEditing: Boolean read FTextEditing write FTextEditing;
  end;

  TDBGridEhDataHintParams = record
    HintPos: TPoint;
    HintMaxWidth: Integer;
    HintColor: TColor;
    HintFont: TFont;
    CursorRect: TRect;
    ReshowTimeout: Integer;
    HideTimeout: Integer;
    HintStr: string;
  end;

  TGetColCellParamsEventEh = procedure(Sender: TObject; EditMode: Boolean;
    Params: TColCellParamsEh) of object;
  TColCellUpdateDataEventEh = procedure(Sender: TObject; var Text: String;
    var Value: Variant; var UseText: Boolean; var Handled: Boolean) of object;

  TDBGridEhHintShowPauseEvent = procedure(Sender: TCustomDBGridEh;
    CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
    Column: TColumnEh; var HintPause: Integer;
    var Processed: Boolean) of object;

  TDBGridEhDataHintShowEvent = procedure(Sender: TCustomDBGridEh;
    CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
    Column: TColumnEh; var Params: TDBGridEhDataHintParams;
    var Processed: Boolean) of object;

  TDBGridEhAdvDrawColumnDataEvent = procedure(Sender: TCustomDBGridEh;
    Cell, AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
    var Params: TColCellParamsEh; var Processed: Boolean) of object;

  TColumnEhInRowPanelPlacement = record
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    DataCellLeft: Integer;
    DataCellWidth: Integer;
  end;

  TDBGridEhFillSTFilterListValuesEvent = procedure(Sender: TCustomDBGridEh;
    Column: TColumnEh; Items: TStrings; var Processed: Boolean) of object;

  TDBGridEhColumnGroupGetKeyValueEvent = procedure(Sender: TCustomDBGridEh;
    Column: TColumnEh; var KeyValue: Variant) of object;

  TDBGridEhDataGroupGetKeyValueAsTextEvent = procedure(Sender: TCustomDBGridEh;
    GroupDataTreeNode: TGroupDataTreeNodeEh; const KeyValue: Variant; var KeyValueAsText: String) of object;

  TColumnEh = class(TCollectionItem, ILookupGridOwner {$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FAlignment: TAlignment;
    FAssignedValues: TColumnEhValues;
    FBiDiMode: TBiDiMode;
    FButtonStyle: TColumnButtonStyleEh;
    FCheckboxes: Boolean;
    FCheckedDuplicates: array of Boolean;
    FColor: TColor;
    FDblClickNextVal: Boolean;
    FDisplayFormat: string;
    FDropDownBox: TColumnDropDownBoxEh;
    FDropDownRows: Cardinal;
    FDropDownShowTitles: Boolean;
    FDropDownSizing: Boolean;
    FDropDownSpecRow: TSpecRowEh;
    FEditButtons: TEditButtonsEh;
    FEditMask: string;
    FField: TField;
    FFieldName: string;
    FFont: TFont;
    FFooter: TColumnFooterEh;
    FFooters: TColumnFootersEh;
    FHideDuplicates: Boolean;
    FHighlightRequired: Boolean;
    FImageList: TCustomImageList;
    FImageChangeLink: TChangeLink;
    FImeMode: TImeMode;
    FImeName: TImeName;
    FIncrement: Extended;
    FLayout: TTextLayout;
    FKeyList: TStrings;
    FMaxWidth: Integer;
    FMinWidth: Integer;
    FMRUList: TMRUListEh;
    FNotInKeyListIndex: Integer;
    FNotInWidthRange: Boolean;
    FOnButtonClick: TButtonClickEventEh;
    FOnButtonDown: TButtonDownEventEh;
    FOnGetCellParams: TGetColCellParamsEventEh;
//    FOnGetItemImageIndex: TListGetImageIndexEventEh;
    FOnNotInList: TNotInListEventEh;
    FPickList: TStrings;
    FPopupMenu: TPopupMenu;
    FReadonly: Boolean;
    FStored: Boolean;
    FShowImageAndText: Boolean;
    FTag: Longint;
    FTextEditing: Boolean;
    FTitle: TColumnTitleEh;
    FToolTips: Boolean;
    FUpdateData: TColCellUpdateDataEventEh;
    FVisible: Boolean;
    FWidth: Integer;
    FSTFilter: TSTColumnFilterEh;
    FFieldValueList: IMemTableDataFieldValueListEh;
    FOnAdvDrawDataCell: TDBGridEhAdvDrawColumnDataEvent;
    FOnCheckDrawRequiredState: TOnColumnCheckDrawRequiredStateEventEh;
    FOnHintShowPause: TDBGridEhHintShowPauseEvent;
    FOnDataHintShow: TDBGridEhDataHintShowEvent;
    FOnFillSTFilterListValues: TDBGridEhFillSTFilterListValuesEvent;

    FRowLine: Integer;
    FHeight: Integer;
    FInRowTabIndex: Integer;
    FOnGroupGetKeyValue: TDBGridEhColumnGroupGetKeyValueEvent;
    FOnGroupGetKeyValueAsText: TDBGridEhDataGroupGetKeyValueAsTextEvent;

    function DefaultCheckboxes: Boolean;
    function GetAlignment: TAlignment;
    function GetAlwaysShowEditButton: Boolean;
    function GetAutoDropDown: Boolean;
    function GetBiDiMode: TBiDiMode;
    function GetCheckboxes: Boolean;
    function GetCheckboxState: TCheckBoxState;
    function GetColor: TColor;
    function GetDataList: TCustomDBGridEh;
    function GetDblClickNextVal: Boolean;
    function GetDropDownShowTitles: Boolean;
    function GetDropDownSizing: Boolean;
    function GetEndEllipsis: Boolean;
    function GetField: TField;
    function GetFont: TFont;
    function GetHighlightRequired: Boolean;
    function GetImeMode: TImeMode;
    function GetImeName: TImeName;
    function GetKeykList: TStrings;
    function GetLayout: TTextLayout;
    function GetName: String;
    function GetOnDropDownBoxCheckButton: TCheckTitleEhBtnEvent;
    function GetOnDropDownBoxDrawColumnCell: TDrawColumnEhCellEvent;
    function GetOnDropDownBoxGetCellParams: TGetCellEhParamsEvent;
    function GetOnDropDownBoxSortMarkingChanged: TNotifyEvent;
    function GetOnDropDownBoxTitleBtnClick: TTitleEhClickEvent;
    function GetPickList: TStrings;
    function GetReadOnly: Boolean;
    function GetShowImageAndText: Boolean;
    function GetTextEditing: Boolean;
    function GetToolTips: Boolean;
    function GetWidth: Integer;
    function IsAlignmentStored: Boolean;
    function IsAlwaysShowEditButtonStored: Boolean;
    function IsAutoDropDownStored: Boolean;
    function IsBiDiModeStored: Boolean;
    function IsCheckboxesStored: Boolean;
    function IsColorStored: Boolean;
    function IsDblClickNextValStored: Boolean;
    function IsDropDownShowTitlesStored: Boolean;
    function IsDropDownSizingStored: Boolean;
    function IsEndEllipsisStored: Boolean;
    function IsFontStored: Boolean;
    function IsImeModeStored: Boolean;
    function IsImeNameStored: Boolean;
    function IsIncrementStored: Boolean;
    function IsReadOnlyStored: Boolean;
    function IsTextEditingStored: Boolean;
    function IsToolTipsStored: Boolean;
    function IsWidthStored: Boolean;
    procedure EditButtonChanged(Sender: TObject);
    procedure ImageListChange(Sender: TObject);
    procedure FontChanged(Sender: TObject);
    procedure SetBiDiMode(Value: TBiDiMode);
    procedure SetButtonStyle(Value: TColumnButtonStyleEh);
    procedure SetCheckboxes(const Value: Boolean);
    procedure SetCheckboxState(const Value: TCheckBoxState);
    procedure SetColor(Value: TColor);
    procedure SetDblClickNextVal(const Value: Boolean);
    procedure SetDisplayFormat(const Value: string);
    procedure SetDropDownBox(const Value: TColumnDropDownBoxEh);
    procedure SetDropDownShowTitles(const Value: Boolean);
    procedure SetDropDownSizing(const Value: Boolean);
    procedure SetDropDownSpecRow(const Value: TSpecRowEh);
    procedure SetEditButtons(const Value: TEditButtonsEh);
    procedure SetEditMask(const Value: string);
    procedure SetFieldName(const Value: String);
    procedure SetFont(Value: TFont);
    procedure SetFooter(const Value: TColumnFooterEh);
    procedure SetFooters(const Value: TColumnFootersEh);
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetKeykList(const Value: TStrings);
    procedure SetLayout(Value: TTextLayout);
    procedure SetMaxWidth(const Value: Integer);
    procedure SetMinWidth(const Value: Integer);
    procedure SetMRUList(const Value: TMRUListEh);
    procedure SetNotInKeyListIndex(const Value: Integer);
    procedure SetOnDropDownBoxCheckButton(const Value: TCheckTitleEhBtnEvent);
    procedure SetOnDropDownBoxDrawColumnCell(const Value: TDrawColumnEhCellEvent);
    procedure SetOnDropDownBoxGetCellParams(const Value: TGetCellEhParamsEvent);
    procedure SetOnDropDownBoxSortMarkingChanged(const Value: TNotifyEvent);
    procedure SetOnDropDownBoxTitleBtnClick(const Value: TTitleEhClickEvent);
    procedure SetOnGetCellParams(const Value: TGetColCellParamsEventEh);
    procedure SetPickList(Value: TStrings);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetShowImageAndText(const Value: Boolean);
    procedure SetSTFilter(const Value: TSTColumnFilterEh);
    procedure SetTextEditing(const Value: Boolean);
    procedure SetTitle(Value: TColumnTitleEh);
    procedure SetToolTips(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);

    function GetInRowLinePos: Integer;
    procedure SetInRowLinePos(const Value: Integer);
    function GetInRowLineHeight: Integer;
    procedure SetInRowLineHeight(const Value: Integer);

  protected
    FAlwaysShowEditButton: Boolean;
    FAutoDropDown: Boolean;
    FAutoFitColWidth: Boolean;
    FDataList: TCustomDBGridEh;
    FDropDownWidth: Integer;
    FDTListSource: TDataSource;
    FEndEllipsis: Boolean;
    FInitWidth: Integer;
    FLookupDisplayFields: String;
    FWordWrap: Boolean;
    FRowPlacement: TColumnEhInRowPanelPlacement;
    function AllowableWidth(TryWidth: Integer): Integer;
    function CanEditShow: Boolean;
    function CreateEditButtons: TEditButtonsEh; virtual;
    function CreateFooter: TColumnFooterEh; virtual;
    function CreateFooters: TColumnFootersEh; virtual;
    function CreateSTFilter: TSTColumnFilterEh; virtual;
    function CreateTitle: TColumnTitleEh; virtual;
    function DefaultAlwaysShowEditButton: Boolean;
    function DefaultAutoDropDown: Boolean;
    function DefaultDblClickNextVal: Boolean;
    function DefaultDropDownShowTitles: Boolean;
    function DefaultDropDownSizing: Boolean;
    function DefaultEndEllipsis: Boolean;
    function DefaultHighlightRequired: Boolean;
    function DefaultLayout: TTextLayout;
    function DefaultLookupDisplayFields: String;
    function DefaultTextEditing: Boolean;
    function DefaultToolTips: Boolean;
    function DefaultWordWrap: Boolean;
    function GetAutoFitColWidth: Boolean;
    function GetDisplayName: string; override;
    function GetEditText: String;
    function GetEditMask: string;
    function GetGrid: TCustomDBGridEh;
    function GetLookupDisplayFields: String;
    function GetWordWrap: Boolean;
    function IsHighlightRequiredStored: Boolean;
    function IsLayoutStored: Boolean;
    function IsLookupDisplayFieldsStored: Boolean;
    function IsTabStop: Boolean;
    function IsWordWrapStored: Boolean;
    function SeenPassthrough: Boolean; virtual;
    function UsedLookupDataSet: TDataSet;
    procedure Changed(AllItems: Boolean);
    function FullListDataSet: TDataSet;
    procedure EnsureSumValue;
    procedure RefreshDefaultFont;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetAlwaysShowEditButton(Value: Boolean);
    procedure SetAutoDropDown(Value: Boolean);
    procedure SetAutoFitColWidth(Value: Boolean); virtual;
    procedure SetDropDownWidth(Value: Integer);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetEditText(const Value: string);
    procedure SetField(Value: TField); virtual;
    procedure SetHideDuplicates(Value: Boolean); virtual;
    procedure SetHighlightRequired(Value: Boolean); virtual;
    procedure SetImeMode(Value: TImeMode); virtual;
    procedure SetImeName(Value: TImeName); virtual;
    procedure SetIndex(Value: Integer); override;
    procedure SetLookupDisplayFields(Value: String); virtual;
    procedure SetNextFieldValue(Increment: Extended);
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetWidth(Value: Integer); virtual;
    procedure SetWordWrap(Value: Boolean); virtual;
    procedure SpecRowChanged(Sender: TObject); virtual;
    procedure UpdateDataValues(Text: String; Value: Variant; UseText: Boolean);

    procedure ReadInRowLinePos(Reader: TReader);
    procedure ReadInRowLineHeight(Reader: TReader);
    procedure WriteInRowLinePos(Writer: TWriter);
    procedure WriteInRowLineHeight(Writer: TWriter);
    function IsInRowLinePosStored: Boolean;
    function IsInRowLineHeightStored: Boolean;

    property IsStored: Boolean read FStored write FStored default True;
    property FieldValueList: IMemTableDataFieldValueListEh read FFieldValueList write FFieldValueList;
  protected
    { ILookupGridOwner }
    procedure SetDropDownBoxListSource(AListSource: TDataSource);
    procedure ILookupGridOwner.SetListSource = SetDropDownBoxListSource;
    function GetLookupGrid: TCustomDBGridEh;
    function GetOptions: TDBLookupGridEhOptions;
    procedure SetOptions(Value: TDBLookupGridEhOptions);
{$IFNDEF CIL}
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF}
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function CanEditAcceptKey(Key: Char): Boolean;
    function CanModify(TryEdit: Boolean): Boolean;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultImeMode: TImeMode;
    function DefaultImeName: TImeName;
    function DefaultReadOnly: Boolean;
    function DefaultWidth: Integer;
    function DisplayText: String;
    function DrawTextBiDiModeFlagsReadingOnly: Longint;
    function EditText: String;
    function FullWidth: Integer;
    function GetAcceptableEditText(InputEditText: String): String;
    function UseRightToLeftAlignment: Boolean; virtual;
    function UseRightToLeftReading: Boolean;
    function UseRightToLeftScrollBar: Boolean;
    function EditButtonsWidth: Integer;
    function GetColumnType: TColumnEhType;
    function GetImageIndex: Integer;
    function UsedFooter(Index: Integer): TColumnFooterEh;
    function CalcRowHeight: Integer;

    function CurLineWordWrap(RowHeight: Integer): Boolean;
    function GetCellHeight(Row: Integer): Integer;
    function GetCurrentFieldValueList: IMemTableDataFieldValueListEh;

    procedure Assign(Source: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DropDown;
    procedure FillColCellParams(ColCellParamsEh: TColCellParamsEh);
    procedure GetColCellParams(EditMode: Boolean; ColCellParamsEh: TColCellParamsEh); virtual;
    procedure OptimizeWidth; virtual;
    procedure RestoreDefaults; virtual;
    property AssignedValues: TColumnEhValues read FAssignedValues;
    property CheckboxState: TCheckBoxState read GetCheckboxState write SetCheckboxState;
    property DataList: TCustomDBGridEh read GetDataList;
    property Field: TField read GetField write SetField;
    property Grid: TCustomDBGridEh read GetGrid;
    property RowPlacement: TColumnEhInRowPanelPlacement read FRowPlacement;
  public
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property AlwaysShowEditButton: Boolean read GetAlwaysShowEditButton write SetAlwaysShowEditButton stored IsAlwaysShowEditButtonStored;
    property AutoDropDown: Boolean read GetAutoDropDown write SetAutoDropDown stored IsAutoDropDownStored;
    property AutoFitColWidth: Boolean read GetAutoFitColWidth write SetAutoFitColWidth default True;
    property ButtonStyle: TColumnButtonStyleEh read FButtonStyle write SetButtonStyle default cbsAuto;
    property Checkboxes: Boolean read GetCheckboxes write SetCheckboxes stored IsCheckboxesStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property BiDiMode: TBiDiMode read GetBiDiMode write SetBiDiMode stored IsBiDiModeStored;
    property DblClickNextVal: Boolean read GetDblClickNextVal write SetDblClickNextVal stored IsDblClickNextValStored;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property DropDownBox: TColumnDropDownBoxEh read FDropDownBox write SetDropDownBox;
    property DropDownRows: Cardinal read FDropDownRows write FDropDownRows default 7; // obsolete
    property DropDownShowTitles: Boolean read GetDropDownShowTitles write SetDropDownShowTitles stored IsDropDownShowTitlesStored;
    property DropDownSizing: Boolean read GetDropDownSizing write SetDropDownSizing stored IsDropDownSizingStored;
    property DropDownSpecRow: TSpecRowEh read FDropDownSpecRow write SetDropDownSpecRow;
    property DropDownWidth: Integer read FDropDownWidth write SetDropDownWidth default 0;
    property EditButtons: TEditButtonsEh read FEditButtons write SetEditButtons;
    property EditMask: string read FEditMask write SetEditMask;
    property EndEllipsis: Boolean read GetEndEllipsis write SetEndEllipsis stored IsEndEllipsisStored;
    property FieldName: String read FFieldName write SetFieldName;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property Footer: TColumnFooterEh read FFooter write SetFooter;
    property Footers: TColumnFootersEh read FFooters write SetFooters;
    property HideDuplicates: Boolean read FHideDuplicates write SetHideDuplicates default False;
    property HighlightRequired: Boolean read GetHighlightRequired write SetHighlightRequired stored IsHighlightRequiredStored;
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property ImeMode: TImeMode read GetImeMode write SetImeMode stored IsImeModeStored;
    property ImeName: TImeName read GetImeName write SetImeName stored IsImeNameStored;
    property Increment: Extended read FIncrement write FIncrement stored IsIncrementStored;
    property KeyList: TStrings read GetKeykList write SetKeykList;
    property LookupDisplayFields: String read GetLookupDisplayFields write SetLookupDisplayFields stored IsLookupDisplayFieldsStored;
    property Layout: TTextLayout read GetLayout write SetLayout stored IsLayoutStored;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 0;
    property MinWidth: Integer read FMinWidth write SetMinWidth default 0;
    property MRUList: TMRUListEh read FMRUList write SetMRUList;
    property Name: String read GetName;
    property NotInKeyListIndex: Integer read FNotInKeyListIndex write SetNotInKeyListIndex default -1;
    property PickList: TStrings read GetPickList write SetPickList;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored IsReadOnlyStored;
    property STFilter: TSTColumnFilterEh read FSTFilter write SetSTFilter;
    property ShowImageAndText: Boolean read GetShowImageAndText write SetShowImageAndText default False;
    property Tag: Longint read FTag write FTag default 0;
    property TextEditing: Boolean read GetTextEditing write SetTextEditing stored IsTextEditingStored;
    property Title: TColumnTitleEh read FTitle write SetTitle;
    property ToolTips: Boolean read GetToolTips write SetToolTips stored IsToolTipsStored;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap stored IsWordWrapStored;
    property OnCheckDrawRequiredState: TOnColumnCheckDrawRequiredStateEventEh read FOnCheckDrawRequiredState write FOnCheckDrawRequiredState;
    property OnDropDownBoxCheckButton: TCheckTitleEhBtnEvent
      read GetOnDropDownBoxCheckButton write SetOnDropDownBoxCheckButton;
    property OnDropDownBoxDrawColumnCell: TDrawColumnEhCellEvent
      read GetOnDropDownBoxDrawColumnCell write SetOnDropDownBoxDrawColumnCell;
    property OnDropDownBoxGetCellParams: TGetCellEhParamsEvent
      read GetOnDropDownBoxGetCellParams write SetOnDropDownBoxGetCellParams;
    property OnDropDownBoxSortMarkingChanged: TNotifyEvent
      read GetOnDropDownBoxSortMarkingChanged write SetOnDropDownBoxSortMarkingChanged;
    property OnDropDownBoxTitleBtnClick: TTitleEhClickEvent
      read GetOnDropDownBoxTitleBtnClick write SetOnDropDownBoxTitleBtnClick;
    property OnEditButtonClick: TButtonClickEventEh read FOnButtonClick write FOnButtonClick;
    property OnEditButtonDown: TButtonDownEventEh read FOnButtonDown write FOnButtonDown;
    property OnGetCellParams: TGetColCellParamsEventEh read FOnGetCellParams write SetOnGetCellParams;
//    property OnGetItemImageIndex: TListGetImageIndexEventEh read FOnGetItemImageIndex write FOnGetItemImageIndex;
    property OnNotInList: TNotInListEventEh read FOnNotInList write FOnNotInList;
    property OnUpdateData: TColCellUpdateDataEventEh read FUpdateData write FUpdateData;
    property OnHintShowPause: TDBGridEhHintShowPauseEvent read FOnHintShowPause write FOnHintShowPause;
    property OnDataHintShow: TDBGridEhDataHintShowEvent read FOnDataHintShow write FOnDataHintShow;
    property OnAdvDrawDataCell: TDBGridEhAdvDrawColumnDataEvent read FOnAdvDrawDataCell write FOnAdvDrawDataCell;
    property OnFillSTFilterListValues: TDBGridEhFillSTFilterListValuesEvent read FOnFillSTFilterListValues write FOnFillSTFilterListValues;
    property OnGroupGetKeyValue: TDBGridEhColumnGroupGetKeyValueEvent read FOnGroupGetKeyValue write FOnGroupGetKeyValue;
    property OnGroupGetKeyValueAsText: TDBGridEhDataGroupGetKeyValueAsTextEvent read FOnGroupGetKeyValueAsText write FOnGroupGetKeyValueAsText;

    property InRowLinePos: Integer read GetInRowLinePos write SetInRowLinePos;
    property InRowLineHeight: Integer read GetInRowLineHeight write SetInRowLineHeight;
    property InRowTabIndex: Integer read FInRowTabIndex;
  end;

  TColumnEhClass = class of TColumnEh;

  TDBGridColumnEh = class(TColumnEh)
  published
    property Alignment;
    property AlwaysShowEditButton;
    property AutoDropDown;
    property AutoFitColWidth;
    property BiDiMode;
    property ButtonStyle;
    property Checkboxes;
    property Color;
    property DblClickNextVal;
    property DisplayFormat;
    property DropDownBox;
    property DropDownRows;
    property DropDownShowTitles;
    property DropDownSizing;
    property DropDownSpecRow;
    property DropDownWidth;
    property EditButtons;
    property EditMask;
    property EndEllipsis;
    property FieldName;
    property Font;
    property Footer;
    property Footers;
    property HideDuplicates;
    property HighlightRequired;
    property ImageList;
    property ImeMode;
    property ImeName;
    property Increment;
    property KeyList;
    property Layout;
    property LookupDisplayFields;
    property MaxWidth;
    property MinWidth;
    property MRUList;
    property NotInKeyListIndex;
    property PickList;
    property PopupMenu;
    property ReadOnly;
    property ShowImageAndText;
    property STFilter;
    property Tag;
    property TextEditing;
    property Title;
    property ToolTips;
    property Visible;
    property Width;
    property WordWrap;
    property OnCheckDrawRequiredState;
    property OnDataHintShow;
    property OnAdvDrawDataCell;
    property OnDropDownBoxCheckButton;
    property OnDropDownBoxDrawColumnCell;
    property OnDropDownBoxGetCellParams;
    property OnDropDownBoxSortMarkingChanged;
    property OnDropDownBoxTitleBtnClick;
    property OnEditButtonClick;
    property OnEditButtonDown;
    property OnFillSTFilterListValues;
    property OnGetCellParams;
    property OnGroupGetKeyValue;
    property OnGroupGetKeyValueAsText;
//    property OnGetItemImageIndex;
    property OnNotInList;
    property OnHintShowPause;
    property OnUpdateData;
  end;

{ TDBGridColumnsEh }

  TDBGridColumnsEh = class(TCollection)
  private
    FGrid: TCustomDBGridEh;
    FUpDownBaseColumn: TColumnEh;
    function GetColumn(Index: Integer): TColumnEh;
    function GetState: TDBGridColumnsState;
    function InternalAdd: TColumnEh;
    procedure SetColumn(Index: Integer; Value: TColumnEh);
    procedure SetState(NewState: TDBGridColumnsState);
  protected
    function GetUpdateCount: Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    property UpdateCount: Integer read GetUpdateCount;
  public
    constructor Create(Grid: TCustomDBGridEh; ColumnClass: TColumnEhClass);
    function Add: TColumnEh;
    function ExistFooterValueType(AFooterValueType: TFooterValueType): Boolean;
    function FindColumnByName(ColumnName: String): TColumnEh;
    function GetNextTabColumn(ForColumn: TColumnEh; GoForward: Boolean): TColumnEh;
    function GetNextHorzColumn(ForColumn: TColumnEh; GoForward, TillTheLastCol, CheckTabStop: Boolean): TColumnEh;
    function GetNextVertColumn(ForColumn: TColumnEh; GoForward: Boolean): TColumnEh;
    function GetTopColumn(ForColumn: TColumnEh): TColumnEh;
    function GetBottomColumn(ForColumn: TColumnEh): TColumnEh;
    function GetFirstTabColumn: TColumnEh;
    function GetLastTabColumn: TColumnEh;
    procedure AddAllColumns(DeleteExisting: Boolean);
    procedure ActiveChanged;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RebuildColumns;
    procedure RestoreDefaults;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    procedure GetColumnNames(List: TStrings);
    property Grid: TCustomDBGridEh read FGrid;
    property Items[Index: Integer]: TColumnEh read GetColumn write SetColumn; default;
    property State: TDBGridColumnsState read GetState write SetState;

    procedure RelayoutCellsInRowPanel;
    procedure ScaleWidths(Divisor, Denominator: Integer);
  end;

{ TColumnsEhList }

  TColumnsEhList = class(TObjectList)
  private
    function GetColumn(Index: Integer): TColumnEh;
    procedure SetColumn(Index: Integer; const Value: TColumnEh);
  public
    constructor Create; overload;
    property Items[Index: Integer]: TColumnEh read GetColumn write SetColumn; default;
  end;

{ TGridDataLinkEh }

  TGridDataLinkEh = class(TDataLink)
  private
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FFieldMapSize: Integer;
    FGrid: TCustomDBGridEh;
    FInUpdateData: Boolean;
    FModified: Boolean;
    FSparseMap: Boolean;
    function GetDefaultFields: Boolean;
    function GetFields(I: Integer): TField;
  protected
    FLastBookmark: TUniBookmarkEh;
    function GetMappedIndex(ColIndex: Integer): Integer;
    function MoveBy(Distance: Integer): Integer; override;
    procedure ActiveChanged; override;
{$IFDEF CIL}
    procedure DataEvent(Event: TDataEvent; Info: TObject); override;
{$ELSE}
    procedure DataEvent(Event: TDataEvent; Info: Integer); override;
{$ENDIF}
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure EditingChanged; override;
{$IFDEF CIL}
    procedure FocusControl(const Field: TField); override;
{$ELSE}
    procedure FocusControl(Field: TFieldRef); override;
{$ENDIF}
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create(AGrid: TCustomDBGridEh);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property DefaultFields: Boolean read GetDefaultFields;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property SparseMap: Boolean read FSparseMap write FSparseMap;
  end;

{ TBookmarkListEh }

  TBookmarkListEh = class(TBMListEh)
  private
    FGrid: TCustomDBGridEh;
  protected
    function GetDataSet: TDataSet; override;
    procedure Invalidate; override;
    procedure SetCurrentRowSelected(Value: Boolean); override;
    procedure UpdateState; override;
    procedure DataChanged(Sender: TObject); override;
  public
    constructor Create(AGrid: TCustomDBGridEh);
    function SelectionToGridRect: TGridRect;
    procedure Clear; override;
  end;

{ THeadTreeNode }

  THeadTreeNode = class;
  TDBGridEh = class;

  LeafCol = record
    FLeaf: THeadTreeNode;
    FColumn: TColumnEh;
  end;

  PLeafCol = ^LeafCol;
  TLeafCol = array[0..MaxListSize - 1] of LeafCol;
//  PTLeafCol = ^TLeafCol;
  PTLeafCol = array of LeafCol;

  THeadTreeProc = procedure(node: THeadTreeNode) of object;

  THeadTreeNode = class(TObject)
  public
    Child: THeadTreeNode;
    Column: TColumnEh;
    Drawed: Boolean;
    Height: Integer;
    HeightPrn: Integer;
    Host: THeadTreeNode;
    Next: THeadTreeNode;
    Text: String;
    VLineWidth: Integer;
    Width: Integer;
    WidthPrn: Integer;
    WIndent: Integer;
    constructor Create;
    constructor CreateText(AText: String; AHeight, AWidth: Integer);
    destructor Destroy; override;
    function Add(AAfter: THeadTreeNode; AText: String; AHeight, AWidth: Integer): THeadTreeNode;
    function AddChild(ANode: THeadTreeNode; AText: String; AHeight, AWidth: Integer): THeadTreeNode;
    function Find(ANode: THeadTreeNode): Boolean;
    function GetLevel: Integer;
    procedure CreateFieldTree(AGrid: TCustomDBGridEh);
    procedure DoForAllNode(proc: THeadTreeProc);
    procedure FreeAllChild;
    procedure Union(AFrom, ATo: THeadTreeNode; AText: String; AHeight: Integer);

  end;

{ TDBGridEhSumList }

  TDBGridEhSumList = class(TDBSumListProducer)
  private
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
  protected
    procedure ReturnEvents; override;
  public
    constructor Create(AOwner: TComponent);
    procedure SetDataSetEvents; override;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property ExternalRecalc default False;
    property OnRecalcAll;
    property OnAfterRecalcAll;
    property SumListChanged;
    property VirtualRecords default False;
  end;

  {TDBGridEhScrollBar}

  TScrollBarVisibleModeEh = (sbAlwaysShowEh, sbNeverShowEh, sbAutoShowEh);

  TDBGridEhScrollBar = class(TPersistent)
  private
    FDBGridEh: TCustomDBGridEh;
    FExtScrollBar: TScrollBar;
    FKind: TScrollBarKind;
    FTracking: Boolean;
    FVisibleMode: TScrollBarVisibleModeEh;
    FSmoothStep: Boolean;
    function GetVisible: Boolean;
    function GetSmoothStep: Boolean;
    procedure ExtScrollWindowProc(var Message: TMessage);
    procedure SetExtScrollBar(const Value: TScrollBar);
    procedure SetVisible(Value: Boolean);
    procedure SetVisibleMode(const Value: TScrollBarVisibleModeEh);
    procedure SetSmoothStep(Value: Boolean);
  protected
    procedure SmoothStepChanged; virtual;
  public
    constructor Create(AGrid: TCustomDBGridEh; AKind: TScrollBarKind);
    destructor Destroy; override;
    function GetScrollInfo(var ScrollInfo: TScrollInfo): Boolean;
    function IsScrollBarVisible: Boolean;
    function IsScrollBarShowing: Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure UpdateExtScrollBar;
    property Kind: TScrollBarKind read FKind;
    property VisibleMode: TScrollBarVisibleModeEh read FVisibleMode write SetVisibleMode default sbAutoShowEh;
    property SmoothStep: Boolean read GetSmoothStep write SetSmoothStep default False;
  published
    property ExtScrollBar: TScrollBar read FExtScrollBar write SetExtScrollBar;
    property Tracking: Boolean read FTracking write FTracking default True;
    property Visible: Boolean read GetVisible write SetVisible default True;
  end;

  THorzDBGridEhScrollBar = class(TDBGridEhScrollBar)
  public
    constructor Create(AGrid: TCustomDBGridEh; AKind: TScrollBarKind);
  protected
    procedure SmoothStepChanged; override;
  published
    property SmoothStep default True;
  end;

  TVertDBGridEhScrollBar = class(TDBGridEhScrollBar)
  protected
    procedure SmoothStepChanged; override;
  published
    property SmoothStep;
    property Visible stored False;
    property VisibleMode;
  end;

  TDBGridEhSelectionType = (gstRecordBookmarks, gstRectangle, gstColumns, gstAll, gstNon);
  TDBGridEhAllowedSelection = gstRecordBookmarks..gstAll;
  TDBGridEhAllowedSelections = set of TDBGridEhAllowedSelection;

  TDBCell = record
    Col: Longint;
    Row: TUniBookmarkEh;
  end;

{ TDBGridEhIndicatorTitle }

  TDBGridEhIndicatorTitle = class(TPersistent)
  private
    FDown: Boolean;
    FDropdownMenu: TPopupMenu;
    FShowDropDownSign: Boolean;
    FTitleButton: Boolean;
    FUseGlobalMenu: Boolean;
    FGrid: TCustomDBGridEh;
    procedure SetShowDropDownSign(const Value: Boolean);
  public
    property Down: Boolean read FDown;
    constructor Create(AGrid: TCustomDBGridEh);
  published
    property DropdownMenu: TPopupMenu read FDropdownMenu write FDropdownMenu;
    property ShowDropDownSign: Boolean read FShowDropDownSign write SetShowDropDownSign default False;
    property TitleButton: Boolean read FTitleButton write FTitleButton default False;
    property UseGlobalMenu: Boolean read FUseGlobalMenu write FUseGlobalMenu default True;
  end;

{ TDBGridEhSelectionRect }

  TDBGridEhSelectionRect = class(TObject)
  private
    FAnchor: TDBCell;
    FGrid: TCustomDBGridEh;
    FShiftCell: TDBCell;
    function BoxRect(ALeft: Longint; ATop: TUniBookmarkEh; ARight: Longint; ABottom: TUniBookmarkEh): TRect;
    function CheckState: Boolean;
    function GetBottomRow: TUniBookmarkEh;
    function GetLeftCol: Longint;
    function GetRightCol: Longint;
    function GetTopRow: TUniBookmarkEh;
  public
    constructor Create(AGrid: TCustomDBGridEh);
    function DataCellSelected(DataCol: Longint; DataRow: TUniBookmarkEh): Boolean;
    function SelectionToGridRect: TGridRect;
    procedure Clear;
    procedure Select(ACol: Longint; ARow: TUniBookmarkEh; AddSel: Boolean);
    property BottomRow: TUniBookmarkEh read GetBottomRow;
    property LeftCol: Longint read GetLeftCol;
    property RightCol: Longint read GetRightCol;
    property TopRow: TUniBookmarkEh read GetTopRow;
  end;

{ TDBGridEhSelectionCols }

  TDBGridEhSelectionCols = class(TColumnsEhList)
  private
    FAnchor: TColumnEh;
    FGrid: TCustomDBGridEh;
    FShiftCol: TColumnEh;
    FShiftSelectedCols: TColumnsEhList;
    procedure Add(ACol: TColumnEh);
  public
    constructor Create(AGrid: TCustomDBGridEh);
    destructor Destroy; override;
    function SelectionToGridRect: TGridRect;
    procedure Clear; override;
    procedure InvertSelect(ACol: TColumnEh);
    procedure Refresh;
    procedure Select(ACol: TColumnEh; AddSel: Boolean);
    procedure SelectShift(ACol: TColumnEh {; Clear:Boolean});
  end;

{ TDBGridEhSelection }

  TDBGridEhSelection = class
  private
    FColumns: TDBGridEhSelectionCols;
    FGrid: TCustomDBGridEh;
    FRect: TDBGridEhSelectionRect;
    FSelectionType: TDBGridEhSelectionType;
    function GetRows: TBookmarkListEh;
    procedure LinkActive(Value: Boolean);
    procedure SetSelectionType(ASelType: TDBGridEhSelectionType);
  protected
    procedure SelectionChanged; virtual;
  public
    constructor Create(AGrid: TCustomDBGridEh);
    destructor Destroy; override;
    function DataCellSelected(DataCol: Longint; DataRow: TUniBookmarkEh): Boolean;
    function SelectionToGridRect: TGridRect;
    procedure Clear;
    procedure Refresh;
    procedure SelectAll;
    procedure UpdateState;
    property Columns: TDBGridEhSelectionCols read FColumns;
    property Rect: TDBGridEhSelectionRect read FRect;
    property Rows: TBookmarkListEh read GetRows;
    property SelectionType: TDBGridEhSelectionType read FSelectionType;
  end;

  TSTFilterLocationEh = (stflUnderTitleFilterEh, stflInTitleFilterEh);

{ TSTDBGridEhFilter }

  TSTDBGridEhFilter = class(TPersistent)
  private
    FGrid: TCustomDBGridEh;
    FLocal: Boolean;
    FUpateCount: Integer;
    FVisible: Boolean;
    FIsInstantApplyStored: Boolean;
    FInstantApply: Boolean;
    FLocation: TSTFilterLocationEh;
    function GetInstantApply: Boolean;
    function IsInstantApplyStored: Boolean;
    procedure SetInstantApply(const Value: Boolean);
    procedure SetLocal(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetLocation(const Value: TSTFilterLocationEh);
  public
    constructor Create(AGrid: TCustomDBGridEh);
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property UpdateCount: Integer read FUpateCount;
  published
//  property AutoEncloseByWildcards: Boolean
//  property OneClickApply: Boolean
//  property OnTypingApply: Boolean
    property InstantApply: Boolean read GetInstantApply write SetInstantApply stored IsInstantApplyStored;
    property Local: Boolean read FLocal write SetLocal default False;
    property Location: TSTFilterLocationEh read FLocation write SetLocation default stflUnderTitleFilterEh;
    property Visible: Boolean read FVisible write SetVisible default False;
//    property ParsingType: TSTFilterParsingType //TwoOperationExpression //LikeExpression
  end;

  TDBGridEhFillSTFilterListEvent = procedure(Grid: TCustomDBGridEh;
    Column: TColumnEh; List: TStrings; var Processed: Boolean) of object;

{ TRowDetailPanelEh }

  TRowDetailPanelEh = class(TPersistent)
  private
    FGrid: TCustomDBGridEh;
    FActive: Boolean;
    FVisible: Boolean;
    FWidth: Integer;
    FHeight: Integer;
    FActiveControl: TWinControl;
    FBevelEdges: TBevelEdges;
    FBevelInner: TBevelCut;
    FBevelOuter: TBevelCut;
    FBevelKind: TBevelKind;
    FBevelWidth: TBevelWidth;
    FBorderStyle: TBorderStyle;
    FColor: TColor;
    FParentColor: Boolean;
    function IsColorStored: Boolean;
    function GetColor: TColor;
    procedure SetActive(const Value: Boolean);
    procedure SetActiveControl(Control: TWinControl);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetBevelEdges(const Value: TBevelEdges);
    procedure SetBevelKind(const Value: TBevelKind);
    procedure SetBevelWidth(const Value: TBevelWidth);
    procedure SetBevelInner(const Value: TBevelCut);
    procedure SetBevelOuter(const Value: TBevelCut);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetColor(const Value: TColor);
    procedure SetParentColor(Value: Boolean);
  public
    constructor Create(AGrid: TCustomDBGridEh);
    procedure Assign(Source: TPersistent); override;
    property Visible: Boolean read FVisible write SetVisible;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Width: Integer read FWidth write SetWidth default 0;
    property Height: Integer read FHeight write SetHeight default 120;
    property ActiveControl: TWinControl read FActiveControl write SetActiveControl;

    property BevelEdges: TBevelEdges read FBevelEdges write SetBevelEdges default [beLeft, beTop, beRight, beBottom];
    property BevelInner: TBevelCut read FBevelInner write SetBevelInner default bvRaised;
    property BevelOuter: TBevelCut read FBevelOuter write SetBevelOuter default bvLowered;
    property BevelKind: TBevelKind read FBevelKind write SetBevelKind default bkNone;
    property BevelWidth: TBevelWidth read FBevelWidth write SetBevelWidth default 1;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property ParentColor: Boolean read FParentColor write SetParentColor default False;
//    property Ctl3D: Boolean read FCtl3D write SetCtl3D stored IsCtl3DStored;
//    property ParentBackground: Boolean read GetParentBackground write SetParentBackground;
//    property ParentCtl3D: Boolean read GetParentCtl3D write SetParentCtl3D default True;
  end;

{ TRowDetailPanelControlEh }

  TRowDetailPanelControlEh = class(TScrollingWinControl)
  private
    FBorderStyle: TBorderStyle;
    procedure CMChildKey(var Message: TCMChildKey); message CM_CHILDKEY;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure WMNCHitTest(var Message: TMessage); message WM_NCHITTEST;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
  published
    property Left stored False;
    property Top stored False;
    property Width stored False;
    property Height stored False;
  end;


  TGridRowPanelTabNavigationTypeEh = (rpntUpToDownPriorityEh, rpntLeftToRightPriorityEh);
  TGridRowPanelNavKeysNavigationTypeEh = (rpntRowToRowEh, rpntCellToCellEh);

{ TGridRowPanelEh }

  TGridRowPanelEh = class(TPersistent)
  private
    FActive: Boolean;
    FGrid: TCustomDBGridEh;
    FNavKeysNavigationType: TGridRowPanelNavKeysNavigationTypeEh;
    FTabNavigationType: TGridRowPanelTabNavigationTypeEh;
    procedure SetActive(const Value: Boolean);
  public
    constructor Create(AGrid: TCustomDBGridEh);
    procedure Assign(Source: TPersistent); override;
  published
    property Active: Boolean read FActive write SetActive default False;
    property NavKeysNavigationType: TGridRowPanelNavKeysNavigationTypeEh read FNavKeysNavigationType write FNavKeysNavigationType default rpntRowToRowEh;
    property TabNavigationType: TGridRowPanelTabNavigationTypeEh read FTabNavigationType write FTabNavigationType default rpntUpToDownPriorityEh;
  end;

  { TDBGridEhDataGroupLevelEh }
  TDBGridEhDataGroupLevelEh = class;

  TDBGridEhDataGroupGetKeyValueEvent = procedure(Sender: TCustomDBGridEh;
    GroupLevel: TDBGridEhDataGroupLevelEh; var KeyValue: Variant) of object;

  TDBGridEhDataGroupGetGroupRowTextEvent = procedure(Sender: TCustomDBGridEh;
    GroupDataTreeNode: TGroupDataTreeNodeEh; var GroupRowText: String) of object;

  TDBGridEhDataGroupLevelEh = class(TGridDataGroupLevelEh)
  private
    FLoadingColumnName: String;
    FOnGetKeyValue: TDBGridEhDataGroupGetKeyValueEvent;
    FOnGetGroupRowText: TDBGridEhDataGroupGetGroupRowTextEvent;
    FOnGetKeyValueAsText: TDBGridEhDataGroupGetKeyValueAsTextEvent;
    function GetColumn: TColumnEh;
    function GetColumnName: String;
    procedure SetColumn(const Value: TColumnEh);
    procedure SetColumnName(const Value: String);
  protected
    procedure DrawFormatChanged; override;
  public
    function GetKeyValue: Variant; override;
    function GetKeyValueAsText(GroupDataTreeNode: TGroupDataTreeNodeEh): String;
    function GetGroupRowText(GroupDataTreeNode: TGroupDataTreeNodeEh): String; override;
    property Column: TColumnEh read GetColumn write SetColumn;
  published
    property Color;
    property ColumnName: String read GetColumnName write SetColumnName;
    property Font;
    property ParentColor;
    property ParentFont;
    property SortOrder;

    property OnGetKeyValue: TDBGridEhDataGroupGetKeyValueEvent read FOnGetKeyValue write FOnGetKeyValue;
    property OnGetKeyValueAsText: TDBGridEhDataGroupGetKeyValueAsTextEvent read FOnGetKeyValueAsText write FOnGetKeyValueAsText;
    property OnGetGroupRowText: TDBGridEhDataGroupGetGroupRowTextEvent read FOnGetGroupRowText write FOnGetGroupRowText;
  end;

{ TDBGridEhDataGroupsEh }

  TDBGridEhDataGroupsEh = class(TGridDataGroupsEh)
  private
    function GetGrid: TCustomDBGridEh;
  protected
    FHotTrackEditButton: Integer;
    FHotTrackGroupLevelIdx: Integer;
    function CreateGroupLevels: TGridDataGroupLevelsEh; override;
    procedure ActiveChanged; override;
    procedure ActiveGroupingStructChanged; override;
    procedure ResetGroupLevelNames;
    procedure RebuildActiveGroupLevels; override;
    procedure ResortActiveLevel(LevelIndex: Integer; SortOrder: TSortOrderEh); override;
    procedure DrawFormatChanged; override;
  public
    constructor Create(AGrid: TCustomDBGridEh);
    function IsGroupingWorks: Boolean; override;
    property Grid: TCustomDBGridEh read GetGrid;
  end;


{ TCustomDBGridEh }

  TDBGridEhRowIndicatorTypeEh =
   (giNormalArrowEh, giSelectedArrowEh, giEditEh, giInsertEh, giInplaceSearch);

  THorzCellAreaTypeEh = (hctIndicatorEh, hctDataEh);
//  THorzCellAreaTypeEh = (hctIndicatorEh, hctFrozenEh, hctDataEh, hctContraEh);
  TVertCellAreaTypeEh = (vctTitleEh, vctSubTitleEh, vctDataEh, vctAboveFooterEh, vctFooterEh);
  TCellAreaTypeEh = record
    HorzType: THorzCellAreaTypeEh;
    VertType: TVertCellAreaTypeEh;
  end;

  TDBGirdDrawTitleStateEh = record
    Down: Boolean;
    MultyTitle: Boolean;
    WordWrap: Boolean;
    FilterButtonDown: Boolean;
    Highlight: Boolean;
    Orientation: TTextOrientationEh;
    The3DRect: Boolean;
    DrawByThemes: Boolean;
    Caption: String;
    BackColor: TColor;
    DrawFilterButton: Boolean;
    CellMultiSelected: Boolean;
    SortMarker: TSortMarkerEh;
    DrawSortIndex: Boolean;
    FontCharset: TFontCharset;
    FontColor: TColor;
    FontSize: Integer;
    FontName: TFontName;
    FontStyle: TFontStyles;
  end;

  TDBGridEhOption = (dghFixed3D, dghFrozen3D, dghFooter3D, dghData3D,
    dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection,
    dghFitRowHeightToText, dghAutoSortMarking, dghMultiSortMarking,
    dghEnterAsTab, dghTraceColSizing, dghIncSearch,dghPreferIncSearch,
    dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghRecordMoving,
    dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight,
    dghHotTrack, dghExtendVertLines);
  TDBGridEhOptions = set of TDBGridEhOption;

  TDBGridEhState = (dgsNormal, dgsRowSelecting, dgsColSelecting, dgsRectSelecting,
    dgsPosTracing, dgsTitleDown, dgsColSizing, dgsRowMoving,
    dgsTitleFilterButtonDown, dgsGroupPanelTitleMoving, dgsGroupPanelTitleDown);

  TDBGridEhAllowedOperation = (alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh);
  TDBGridEhAllowedOperations = set of TDBGridEhAllowedOperation;

  TDBGridEhEditAction = (geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh);
  TDBGridEhEditActions = set of TDBGridEhEditAction;

  TEditButtonsShowOptionEh = (sebShowOnlyForCurCellEh,
    sebShowOnlyForCurRowEh, sebShowOnlyWhenGridActiveEh, sebShowOnlyWhenDataEditingEh);
  TEditButtonsShowOptionsEh = set of TEditButtonsShowOptionEh;

//  TInpsDirectionEh = (inpsFromFirstEh, inpsToNextEh, inpsToPriorEh);

  { The DBGridEh's DrawDataCell virtual method and OnDrawDataCell event are only
    called when the grid's Columns.State is csDefault.  This is for compatibility
    with existing code. These routines don't provide sufficient information to
    determine which column is being drawn, so the column attributes aren't
    easily accessible in these routines.  Column attributes also introduce the
    possibility that a column's field may be nil, which would break existing
    DrawDataCell code.   DrawDataCell, OnDrawDataCell, and DefaultDrawDataCell
    are obsolete, retained for compatibility purposes. }
(*  TDrawDataCellEvent = procedure (Sender: TObject; const Rect: TRect; Field: TField;
    State: TGridDrawState) of object; *)

  { The DBGridEh's DrawColumnCell virtual method and OnDrawColumnCell event are
    always called, when the grid has defined column attributes as well as when
    it is in default mode.  These new routines provide the additional
    information needed to access the column attributes for the cell being
    drawn, and must support nil fields.  }

  TDBGridEhClickEvent = procedure(Column: TColumnEh) of object;
  TDrawFooterCellEvent = procedure(Sender: TObject; DataCol, Row: Longint;
    Column: TColumnEh; Rect: TRect; State: TGridDrawState) of object;
  TGetFooterParamsEvent = procedure(Sender: TObject; DataCol, Row: Longint;
    Column: TColumnEh; AFont: TFont; var Background: TColor;
    var Alignment: TAlignment; State: TGridDrawState; var Text: String) of object;

  TGetBtnEhParamsEvent = procedure(Sender: TObject; Column: TColumnEh;
    AFont: TFont; var Background: TColor; var SortMarker: TSortMarkerEh;
    IsDown: Boolean) of object;

  TGetDBGridEhRowHeightEvent = procedure(Sender: TObject;
    var RowHeight: Integer) of object;

  TDBGridEhRowDetailPanelHideEvent = procedure(Sender: TCustomDBGridEh; var CanHide: Boolean) of object;
  TDBGridEhRowDetailPanelShowEvent = procedure(Sender: TCustomDBGridEh; var CanShow: Boolean) of object;
  TDBGridEhCheckRowHaveDetailPanelEvent = procedure(Sender: TCustomDBGridEh; var RowHaveDetailPanel: Boolean) of object;
  TDBGridEhNotifyEvent = procedure(Sender: TCustomDBGridEh) of object;

  TCustomDBGridEh = class(TCustomGridEh, IMTEventReceiverEh,
    IInplaceEditHolderEh {$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FAllowedOperations: TDBGridEhAllowedOperations;
    FAllowedSelections: TDBGridEhAllowedSelections;
    FAutoDrag, FSelectedCellPressed: Boolean;
    FBookmarks: TBookmarkListEh;
    FCanvasHandleAllocated: Boolean;
    FCenter: TDBGridEhCenter;
    FColumnDefValues: TColumnDefValuesEh;
    FColumns: TDBGridColumnsEh;
    FCompleteKeyPress: String;
    FDataLink: TGridDataLinkEh;
    FDefaultDrawing: Boolean;
    FEditActions: TDBGridEhEditActions;
    FEditKeyValue: Variant; // For lookup fields and KeyList based column
    FEditText: string;
//gridseh    FFlat: Boolean;
    FFooterColor: TColor;
    FFooterFont: TFont;
    FHintFont: TFont;
    FHorzScrollBar: TDBGridEhScrollBar;
    FInColExit: Boolean;
    FIndicatorTitle: TDBGridEhIndicatorTitle;
    FInterlinear: Integer;
    FLayoutFromDataset: Boolean;
    FLayoutLock: Byte;
    FOnAdvDrawDataCell: TDBGridEhAdvDrawColumnDataEvent;
    FOnBuildIndicatorTitleMenu: TDBGridEhBuildIndicatorTitleMenu;
    FOnCellClick: TDBGridEhClickEvent;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnColumnMoved: TMovedEvent;
    FOnColWidthsChanged: TNotifyEvent;
    FOnDataGroupGetRowText: TDBGridEhDataGroupGetGroupRowTextEvent;
    FOnDataHintShow: TDBGridEhDataHintShowEvent;
    FOnDrawColumnCell: TDrawColumnEhCellEvent;
    FOnDrawDataCell: TDrawDataCellEvent;
    FOnEditButtonClick: TNotifyEvent;
    FOnGetCellParams: TGetCellEhParamsEvent;
    FOnGetFooterParams: TGetFooterParamsEvent;
    FOnHintShowPause: TDBGridEhHintShowPauseEvent;
    FOnIndicatorTitleMouseDown: TGridEhCellMouseEvent;
    FOnSelectionChanged: TNotifyEvent;
    FOnSortMarkingChanged: TNotifyEvent;
    FOnSumListAfterRecalcAll: TNotifyEvent;
    FOnSumListRecalcAll: TNotifyEvent;
    FOnTitleClick: TDBGridEhClickEvent;
    FOptions: TDBGridOptions;
    FOptionsEh: TDBGridEhOptions;
    FOriginalImeMode: TImeMode;
    FOriginalImeName: TImeName;
    FReadOnly: Boolean;
    FSelecting: Boolean;
    FSelection: TDBGridEhSelection;
    FSelectionAnchor: TUniBookmarkEh;
//    FCurrentRecordBookmark: TUniBookmarkEh;
    FSelfChangingFooterFont: Boolean;
    FSelfChangingTitleFont: Boolean;
    FSelRow: Integer;
    FSortLocal: Boolean;
    FSortMarking: Boolean;
    FStyle: TDBGridEhStyle;
    FSumListRecalcing: Boolean;
    FThumbTracked: Boolean;
    FTitleFont: TFont;
    FTitleImages: TCustomImageList;
    FTitleImageChangeLink: TChangeLink;
    FTitleOffset: Byte;
    FIndicatorOffset: Byte;
//    FTopDataOffset: Byte;
    FTopLeftVisible: Boolean;
    FUpdateLock: Byte;
    FUserChange: Boolean;
    FVertScrollBar: TDBGridEhScrollBar;

    FOldActiveRecord: Integer;
    FLockAutoShowCurCell: Boolean;
    FFetchingRecords: Boolean;
    FTryUseMemTableInt: Boolean;

    FSTFilter: TSTDBGridEhFilter;
    FFilterCol: Integer;
    FFilterEditMode: Boolean;
    FFilterEdit: TCustomDBEditEh;
    FOnApplyFilter: TNotifyEvent;
    FDownMouseMessageTime: LongInt;
    FBufferedPaint: Boolean;
    FSizeChanged: Boolean;
    FEvenRowColorStored: Boolean;
    FOddRowColorStored: Boolean;
    FEvenRowColor: TColor;
    FOddRowColor: TColor;
    FContraColCount: Integer;
    FDummiFont: TFont;
    FRecNoTextWidth: Integer;
    FOnGetRowHeight: TGetDBGridEhRowHeightEvent;
    FEditButtonsShowOptions: TEditButtonsShowOptionsEh;

//    FRowPanel: Boolean;
    FGridRowPanel: TGridRowPanelEh;
    FInRowPanelCol: Integer;
    FDSMouseCapture: Boolean;

    FRowDetailPanel: TRowDetailPanelEh;
    FOnRowDetailPanelHide: TDBGridEhRowDetailPanelHideEvent;
    FOnRowDetailPanelShow: TDBGridEhRowDetailPanelShowEvent;
    FOnCheckRowHaveDetailPanel: TDBGridEhCheckRowHaveDetailPanelEvent;
    FOnFillSTFilterListValues: TDBGridEhFillSTFilterListValuesEvent;

    FDataGrouping: TDBGridEhDataGroupsEh;
    FDrawGroupDataNode: TGroupDataTreeNodeEh;
    FDrawnGroupList: TList;
    FCurGroupDataNode: TGroupDataTreeNodeEh;
    FOnActiveGroupingStructChanged: TDBGridEhNotifyEvent;

    procedure CheckIMemTable;
    procedure MTUpdateRowCount;
    procedure MTScroll(Distance: Integer);
    function IsCurrentRow(DataRowNum: Integer): Boolean;
    procedure FetchRecordsInView;
    procedure InstantReadRecordEnter(DataRowNum: Integer);
    procedure InstantReadRecordLeave;
    function InstantReadRecordCount: Integer;
    procedure MTUpdateVertScrollBar;
    procedure MTUpdateTopRow;
    procedure MTWMVScroll(var Message: TWMVScroll);

    function GetCol: Longint;
    function GetContraColCount: Longint;
    function GetDataSource: TDataSource;
    function GetEvenRowColor: TColor;
    function GetFieldColumns(const FieldName: String): TColumnEh;
    function GetFieldCount: Integer;
    function GetFields(FieldIndex: Integer): TField;
    function GetOddRowColor: TColor;
//    function GetRowHeights(Index: Longint): Integer;
    function GetSelectedField: TField;
    function GetSelectedIndex: Integer;
    function GetTopDataOffset: Byte;
//    function IsActiveControl: Boolean;
    function IsEvenRowColorStored: Boolean;
    function IsOddRowColorStored: Boolean;
//      procedure CalcDrawInfoXYEh(var DrawInfo: TGridDrawInfoEh; UseWidth, UseHeight: Integer);
    procedure ChangeGridOrientation(RightToLeftOrientation: Boolean);
    procedure ClearSelection;
    procedure CheckClearSelection;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure CMChanged(var Msg: TCMChanged); message CM_CHANGED;
    procedure CMDeferLayout(var Message: TMessage); message cm_DeferLayout;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMHintsShowPause(var Message: TCMHintShowPause); message CM_HINTSHOWPAUSE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Message: TCMParentFontChanged); message CM_PARENTFONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure DoSelection(Select: Boolean; Direction: Integer; MaxDirection, RowOnly: Boolean);
    procedure DrawEdgeEh(ACanvas: TCanvas; qrc: TRect; IsDown, IsSelected: Boolean; NeedLeft, NeedRight: Boolean);
    procedure EditingChanged;
    procedure FooterFontChanged(Sender: TObject);
    procedure InternalLayout;
    procedure MoveCol(DataCol, Direction: Integer; Select: Boolean);
    procedure ReadColumns(Reader: TReader);
    procedure RecordChanged(Field: TField);
    procedure SetAllowedSelections(const Value: TDBGridEhAllowedSelections);
    procedure SetCenter(const Value: TDBGridEhCenter);
    procedure SetCol(Value: Longint);
    procedure SetColumnDefValues(const Value: TColumnDefValuesEh);
    procedure SetColumns(Value: TDBGridColumnsEh);
    procedure SetContraColCount(const Value: Longint);
    procedure SetDataGrouping(Value: TDBGridEhDataGroupsEh);
    procedure SetDataSource(Value: TDataSource);
    procedure SetDrawGraphicData(const Value: Boolean);
    procedure SetDrawMemoText(const Value: Boolean);
    procedure SetEvenRowColor(const Value: TColor);
    procedure SetFilterEditMode(const Value: Boolean);
//gridseh    procedure SetFlat(const Value: Boolean);
    procedure SetFooterColor(Value: TColor);
    procedure SetFooterFont(Value: TFont);
    procedure SetHorzScrollBar(const Value: TDBGridEhScrollBar);
    procedure SetIme;
    procedure SetOddRowColor(const Value: TColor);
    procedure SetOptions(Value: TDBGridOptions);
    procedure SetOptionsEh(const Value: TDBGridEhOptions);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetSelectedField(Value: TField);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetEditButtonsShowOptions(Value: TEditButtonsShowOptionsEh);
    procedure SetSTFilter(const Value: TSTDBGridEhFilter);
    procedure SetStyle(const Value: TDBGridEhStyle);
    procedure SetSumList(const Value: TDBGridEhSumList);
    procedure SetTitleFont(Value: TFont);
    procedure SetTitleImages(const Value: TCustomImageList);
    procedure SetVertScrollBar(const Value: TDBGridEhScrollBar);
    procedure TitleFontChanged(Sender: TObject);
    procedure TitleImageListChange(Sender: TObject);
    procedure UpdateIme;
    procedure UpdateColumnResizeOptions(NewOptions: TDBGridOptions; NewOptionsEh: TDBGridEhOptions);
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KillFocus;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WriteColumns(Writer: TWriter);
    procedure PaintInplaceButton(Column: TColumnEh; Canvas: TCanvas;
      ButtonStyle: TEditButtonStyleEh; Rect, ClipRect: TRect;
      DownButton: Integer; Active, Flat, Enabled: Boolean;
      ParentColor: TColor; Bitmap: TBitmap; TransparencyPercent: Byte);

//    procedure SetRowPanel(const Value: Boolean);
    procedure SetRowPanel(const Value: TGridRowPanelEh);

    function GetOriginCol(): Integer;
    procedure SetOriginCol(const Value: Integer);
    procedure ResetTabIndexedColumns;

    procedure SetRowDetailPanel(const Value: TRowDetailPanelEh);

  protected
    { IInplaceEditHolderEh }
    function InplaceEditCanModify(Control: TWinControl): Boolean;
    procedure GetMouseDownInfo(var Pos: TPoint; var Time: LongInt);
    procedure InplaceEditKeyDown(Control: TWinControl; var Key: Word; Shift: TShiftState);
    procedure InplaceEditKeyPress(Control: TWinControl; var Key: Char);
    procedure InplaceEditKeyUp(Control: TWinControl; var Key: Word; Shift: TShiftState);
    procedure InplaceEditWndProc(Control: TWinControl; var Message: TMessage);

  protected
    { IMTEventReceiverEh }
    procedure MTViewDataEvent(RowNum: Integer;
      Event: TMTViewEventTypeEh; OldRowNum: Integer);

  protected
//    FSortMarkerImages: TImageList;
    FGridMasterCellHeight: Integer;
    FGridMasterCellWidth: Integer;
    FAcquireFocus: Boolean;
    FAllowWordWrap: Boolean; // True if RowHeight + 3 > TextHeight
    FAntiSelection: Boolean;
    FAutoFitColWidths: Boolean;
    FBorderWidth: Integer;
    FColCellParamsEh: TColCellParamsEh;
    FDataTracking: Boolean;
    FDBGridEhState: TDBGridEhState;
    FDefaultRowChanged: Boolean;
    FDownMousePos: TPoint;
    FDrawMemoText: Boolean;
    FDrawGraphicData: Boolean;
    FFooterRowCount: Integer;
    FFrozenCols: Integer;
    FHeadTree: THeadTreeNode;
    FHTitleMargin: Integer;
    FIndicatorPressed: Boolean;
    FInplaceEditorButtonHeight: Integer;
    FInplaceEditorButtonWidth: Integer;
    FInplaceSearching: Boolean;
    FInplaceSearchingInProcess: Boolean;
    FInplaceSearchText: String;
    FInplaceSearchTimeOut: Integer;
    FInplaceSearchTimerActive: Boolean;
    FIntMemTable: IMemTableEh;
    FLeafFieldArr: PTLeafCol;
    FLockedBookmark: TUniBookmarkEh;
//    FLockPaint: Boolean;
    FLookedOffset: Integer;
    FMinAutoFitWidth: Integer;
    FMouseShift: TShiftState;
    FMoveMousePos: TPoint;
    FNewRowHeight: Integer;
    FOnCheckButton: TCheckTitleEhBtnEvent;
    FOnDrawFooterCell: TDrawFooterCellEvent;
    FOnGetBtnParams: TGetBtnEhParamsEvent;
    FOnMoveRecords: TGridMoveRecordsEventEh;
    FOnTitleBtnClick: TTitleEhClickEvent;
    FOnTopLeftChanged: TNotifyEvent;
    FPressed: Boolean;
    FPressedCell: TGridCoord;
    FPressedCol: Longint;
    FPressedDataCol: Longint;
    FPressedDataGroupLevelIdx: Integer;
    FTrackingStateRect: TRect;
    FToMoveColumnIndex: Integer;
    FToMoveInRowLinePos: Integer;
    FDragCellRect: TRect;
    FTopLeftCellOffset: TPoint;
    FRowLines: Integer;
    FRowSizingAllowed: Boolean;
    FSelectionActive: Boolean;
    FSelectionAnchorSelected: Boolean;
//    FSelectionAnchorState: TSelectionAnchorStateEh;
    FSortMarkedColumns: TColumnsEhList;
    FSumList: TDBGridEhSumList;
    FSwapButtons: Boolean;
    FTimerActive: Boolean;
    FTimerInterval: Integer;
    FTitleHeight: Integer;
    FTitleHeightFull: Integer;
    FTitleLines: Integer;
    FTracking: Boolean;
    FUpdateFields: Boolean;
    FUseMultiTitle: Boolean;
    FVertScrollBarVisibleMode: TScrollBarVisibleModeEh;
    FVisibleColumns: TColumnsEhList;
    FVTitleMargin: Integer;
    FMoveRowSour: Integer;  //Index
    FMoveBookmarkSour: TUniBookmarkEh;
    FMoveRowDest: Integer;     //Pos
    FMoveRowSourLevel: Integer;
    FMoveRowDestLevel: Integer;
    FMoveRowLeftBounds: Integer;
    FDataRowMoveLeftBoundary: Integer;
    FDataRowMoveRightBoundary: Integer;
    FDataRowMoveVisible: Boolean;
    FOldTopLeft: TGridCoord;
    FTitleRowHeight: Integer;
    FStdDefaultRowHeight: Integer;
    FColWidthsChanged: Boolean;
    FInplaceColInRowPanel, FInplaceRow: Longint;
    FStartShiftState: TShiftState;
    FNoDesigntControler: Boolean;
    FRowDetailControl: TRowDetailPanelControlEh;
    FDesignInfoCollection: TCollection;
    FHotTrackEditButton: Integer;
    FHotTrackMultiTitleOver: Boolean;
    FInTitleFilterListbox: TPopupListboxEh;
    FInTitleFilterListboxColumn: TColumnEh;
    FInTitleFilterListboxGroupLevel: TGridDataGroupLevelEh;
    FInTitleFilterListboxVisible: Boolean;
    FExtraFirstColumnWidth: Integer;
    FInternalUpdatingDatasetPos: Boolean;
    FGroupDataMovingIndex: Integer;
    FLastVisibleCol: Integer;

    function AcquireFocus: Boolean; virtual;
    function EffectiveGridOptions: TGridOptions;
    function AcquireLayoutLock: Boolean;
    function AllowedOperationUpdate: Boolean;
    function BeginDataRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function BoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
    function CalcHeightForGroupNode(ADrawGroupDataNode: TGroupDataTreeNodeEh): Integer;
    function CalcLeftMoveLine(ARow: Integer; const MousePt: TPoint; var TreeLevel: Integer): Integer; virtual;
    function CalcRectForGroupCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint): TRect;
    function CalcRowDataRowHeight(DataRowNum: Integer): Integer; virtual;
    function CalcRowForCurRecordHeight: Integer; virtual;
    function CanDrawFocusRowRect: Boolean; virtual;
    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function CanEditModifyColumn(Index: Integer): Boolean;
    function CanEditModifyText: Boolean;
    function CanEditorMode: Boolean; virtual;
    function CanEditShow: Boolean; override;
    function CanFilterCol(DCol: Longint): Boolean;
    function CanFilterEditShow: Boolean; virtual;
    function CanMouseTrackMode: Boolean;
    function CanHotTackCell(X, Y: Integer): Boolean; override;
    function CanSelectType(const Value: TDBGridEhSelectionType): Boolean;
    function CellHave3DRect(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState): Boolean; virtual;
    function CellWidthToColWidth(Column: TColumnEh; AWidth: Integer): Integer;
    function CellIsMultiSelected(ACol, ARow: Integer; DataCol: Integer; DataRowBkmrk: TUniBookmarkEh): Boolean; virtual;
    function CellTreeElementMouseDown(MouseX, MouseY: Integer; CheckInOnly: Boolean): Boolean; virtual;
    function CheckBeginRowMoving(MouseX, MouseY: Integer; CheckInOnly: Boolean): Boolean; virtual;
    function CheckCellFilter(ACol, ARow: Integer; P: TPoint): Boolean;
    function CheckForDesigntTimeColMoving(X, Y: Integer): Boolean;
    function CheckTitleCellFilterButtonPos(MousePos: TPoint; CellRect: TRect; Column: TColumnEh; var StateRect: TRect): Boolean;
    function ColWidthToCellWidth(Column: TColumnEh; AWidth: Integer): Integer;
    function CreateColumnDefValues: TColumnDefValuesEh; virtual;
    function CreateColumns: TDBGridColumnsEh; virtual;
    function CreateEditor: TInplaceEdit; override;
    function CreateFilterEditor: TCustomDBEditEh; virtual;
    function CreateScrollBar(AKind: TScrollBarKind): TDBGridEhScrollBar; virtual;
    function DataGroupsMoveBy(Distance: Integer): Integer;
    function DataToRawColumn(ADataCol: Integer): Integer;
    function DataCellSelected(DataCol: Longint; DataRow: TUniBookmarkEh): Boolean;
    function DeletePrompt: Boolean; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DrawTitleByThemes: Boolean;
    function EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; override;
    function ExtendedScrolling: Boolean;
    function IsDrawCellByThemes(ACol, ARow: Longint; AreaCol, AreaRow: Longint; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh; Cell3D: Boolean): Boolean; virtual;
    function FrozenSizing(X, Y: Integer): Boolean;
    function GetCellAreaType(ACol, ARow: Integer; var AreaCol, AreaRow: Integer): TCellAreaTypeEh;
    function GetColField(DataCol: Integer): TField;
    function GetColWidths(Index: Longint): Integer;
    function GetEditLimit: Integer; override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    function GetFieldValue(ACol: Integer): string;
    function GetFilterValue(DCol: Longint): String;
    function GetFooterRowCount: Integer;
    function GetInTitleFilterListbox: TPopupListboxEh;
    function GetEditButtonIndexAt(ACol, ARow: Longint; Column: TColumnEh; InCellX, InCellY: Integer): Integer;
    function GetRowHeight: Integer;
    function GetRowLines: Integer;
    function GetSubTitleRowHeights(ASubTitleRow: Integer): Integer;
    function GetSubTitleRows: Integer; virtual;
    function GetTitleRows: Integer; virtual;
    function HaveHideDuplicates: Boolean;
    function HighlightNoDataCellColor(ACol, ARow: Integer; DataCol, DataRow: Integer;
      CellType: TCellAreaTypeEh; AState: TGridDrawState; InMultiSelect: Boolean; var AColor: TColor;
      AFont: TFont): Boolean; virtual;
    function InplaceEditorVisible: Boolean;
    function IndicatorColVisible: Boolean; virtual;
    function IsSelectionActive: Boolean; virtual;
    function IsSmoothHorzScroll: Boolean; override;
    function IsSmoothVertScroll: Boolean; override;
    function MemTableSupport: Boolean;
    function MoveDataRows(BookmarkList: TBMListEh; ToIndex: Longint;
      TreeLevel: Integer; CheckOnly: Boolean): Boolean; virtual;
    function MoveSelectedDataRows(ToIndex: Longint; TreeLevel: Integer;
      CheckOnly: Boolean): Boolean; virtual;
    function NeedBufferedPaint: Boolean; virtual;
    function ViewScroll: Boolean;
    function RawToDataColumn(ACol: Integer): Integer;
    function ReadTitleHeight: Integer;
    function ReadTitleLines: Integer;
    function SetChildTreeHeight(ANode: THeadTreeNode): Integer;
    function CalcStdDefaultRowHeight: Integer;
    function StoreColumns: Boolean;
    function VisibleDataRowCount: Integer;
    procedure BeginLayout;
    procedure BeginUpdate;
    procedure BuildIndicatorTitleMenu(var PopupMenu: TPopupMenu);
//    procedure CalcDrawInfoEh(var DrawInfo: TGridDrawInfoEh);
//    procedure CalcFixedInfoEh(var DrawInfo: TGridDrawInfoEh);
    procedure CalcFrozenSizingState(X, Y: Integer; var State: TDBGridEhState;
      var Index: Longint; var SizingPos, SizingOfs: Integer);
    procedure CalcSizingState(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfoEh); override;
    procedure CalcSizingStateForRowPanel(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfoEh);
    procedure CancelLayout;
    procedure CancelMode; override;
    procedure CellClick(Column: TColumnEh); virtual;
    procedure ChangeScale(M, D: Integer); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure ClampInViewRowPanelCell(DataCol: Integer);
    procedure CheckTitleButton(ACol: Longint; var Enabled: Boolean); virtual;
    procedure CheckSetCurGroupDataNode(ACurGroupDataNode: TGroupDataTreeNodeEh; ShowInView: Boolean);
    procedure ClearPainted(node: THeadTreeNode);
    procedure ColEnter; virtual;
    procedure ColExit; virtual;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure ColWidthsChanged; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DataGroupsGotoRecordViewNo(RecViewNo: Integer; IsExpandToView: Boolean);
    procedure DataChanged; virtual;
    procedure DeferLayout;
    procedure DefineFieldMap; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoExit; override;
    procedure DoAfterSizeChanged; virtual;
    procedure DoSortMarkingChanged; virtual;
    procedure DoTitleClick(ACol: Longint; AColumn: TColumnEh); virtual;
    procedure DrawBorder; virtual;

    procedure DragGroupPanelTitleMovingMode(Shift: TShiftState; X, Y: Integer);
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawTitleCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawTitleCellOld(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawTitleCellState(Column: TColumnEh; ARect: TRect; AState: TGridDrawState; var ATitleState: TDBGirdDrawTitleStateEh); virtual;
    procedure DrawIndicatorCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawDataCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawFooterCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure FillCellRect(DrawByThemes: Boolean; ARect: TRect; IsDown, IsSelected: Boolean; ClipRect: TRect; Cell3D: Boolean; Focused: Boolean = False);
    procedure DrawFocusRect(Canvas: TCanvas; ARect: TRect);
    procedure DrawGroupDataCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawGroupDataArea(DataCol, DataRow: Integer; NodeLevel: Integer; AState: TGridDrawState; ARect: TRect; Draw3DRect: Boolean); virtual;

    procedure DrawCellTreeArea(DataCol, DataRow: Integer; AState: TGridDrawState; ARect: TRect; Draw3DRect: Boolean); virtual;
    procedure DrawDataRowMove(LeftBoundary, RightBoundary: Integer);
    procedure DrawTreeArea(Canvas: TCanvas; ARect: TRect; IsDrawEdge: Boolean; IsSubTreeArea: Boolean);
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumnEh; State: TGridDrawState); virtual;
    procedure OldDrawDataCell(const Rect: TRect; Field: TField; State: TGridDrawState); virtual; { obsolete }
    procedure DrawTopOutBoundaryData(ARect: TRect); override;
    procedure DrawTopOutBoundaryGroupCaption(ARect: TRect; GroupLevel: TGridDataGroupLevelEh); virtual;

    procedure DataGroupsVisibleChanged; virtual;
    procedure DrawSubTitleCell(ACol, ARow: Longint; DataCol, DataRow: Integer;
      CellType: TCellAreaTypeEh; ARect: TRect; AState: TGridDrawState; var Highlighted: Boolean); virtual;
    procedure DrawSizingLineEx(HorzGridBoundary, VertGridBoundary: Integer);
    procedure DrawRowIndicator(ACol, ARow: Longint; ARect: TRect; XOffset, YOffset: Integer; IndicatorType: TDBGridEhRowIndicatorTypeEh); virtual;
    procedure DrawIndicatorDropDownSign(ACol, ARow: Longint; ARect: TRect; Selected: Boolean); virtual;
    procedure DrawFilterSign(ARect: TRect; Selected: Boolean); virtual;
    procedure DrawGraphicCell(Column: TColumnEh; ARect: TRect; Background: TColor); virtual;
    procedure EditButtonClick; virtual;
    procedure EndLayout;
    procedure EndRowMoving(MouseX, MouseY: Integer; Accept: Boolean); virtual;
    procedure EndUpdate;
    procedure ExecuteFindDialog(Text, FieldName: String; Modal: Boolean);
    procedure ExpandCellWidthForEmptySpace(ColumnIndex: Integer);
    procedure FilterButtonClick(Sender: TObject; var Handled: Boolean);
    procedure FilterExit(Sender: TObject);
    procedure FlatChanged; override;
    procedure FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean); override;
    procedure GetCellParams(Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState); virtual;
    procedure GetGroupMoveLineInfo(X, Y: Integer; var GroupMoveLinePos: TPoint; var GroupMoveLineSize: Integer; var InDataGroupIndex: Integer);

    procedure AncestorNotFound(Reader: TReader; const ComponentName: string; ComponentClass: TPersistentClass; var Component: TComponent);
    procedure CreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
    procedure ReadState(Reader: TReader); override;

    procedure GetDatasetFieldList(FieldList: TList); virtual;
    procedure GetFooterParams(DataCol, Row: Longint; Column: TColumnEh; AFont: TFont; var Background: TColor; var Alignment: TAlignment; State: TGridDrawState; var Text: String); virtual;
    procedure GetDrawSizingLineBound(const DrawInfo: TGridDrawInfoEh; var StartPos, FinishPos: Integer); override;
    procedure GroupPanelVisibleChanged;
    procedure GroupPanelTitleUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HideEditor; override;
    procedure HideFilterEdit;
    procedure HideDataRowMove;
    procedure IndicatorTitleMouseDown(Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure InvalidateCol(ACol: Longint);
    procedure InvalidateRow(ARow: Longint);
    procedure InvalidateCell(ACol, ARow: Longint);
    procedure InvalidateEditor;
    procedure InvalidateGridRect(ARect: TGridRect);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyDownInGroupDataNode(var Key: Word; Shift: TShiftState);
    procedure KeyProperyModified;
    procedure LayoutChanged; virtual;
    procedure LinkActive(Value: Boolean); virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDownInDataRowPanel(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseDownInTitleRowPanel(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseDownInDataCell(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Cell: TGridCoord; Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer);
    procedure MouseDownInTitleCell(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Cell: TGridCoord; Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer);
    procedure MouseDownInGroupDataCell(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; ADrawGroupDataNode: TGroupDataTreeNodeEh); virtual;
    procedure MouseDownInOutBoundary(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUpInTitleCell(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Cell: TGridCoord; Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer);
    procedure MouseUpInDataCell(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Cell: TGridCoord; Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer);
    procedure MouseUpInTitleRowPanel(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUpInDataRowPanel(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MoveDataRowAndScroll(Mouse, CellHit: Integer; var DrawInfo: TGridDrawInfoEh; var Axis: TGridAxisDrawInfoEh; ScrollBar: Integer; const MousePt: TPoint); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OnFilterChange(Sender: TObject);
    procedure OnFilterCloseUp(Sender: TObject; Accept: Boolean);
    procedure OnFilterClosingUp(Sender: TObject; var Accept: Boolean);
    procedure OnFilterEditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure OnFilterGetItemsList(Sender: TObject);
    procedure LoadInplaceFilterValues(ASTFilter: TSTColumnFilterEh; Items: TStrings; PopupListbox: TPopupListboxEh; var NewWidth: Integer);
    procedure OnFilterKeyPress(Sender: TObject; var Key: Char);
    procedure OptimizeColsWidth(ColumnsList: TColumnsEhList);
    procedure OptimizeSelectedColsWidth(WithColumn: TColumnEh);
    procedure OverlaySelectionByTheme(Cell, AreaCell: TGridCoord; Column: TColumnEh; AreaRect: TRect; var Params: TColCellParamsEh);
    procedure Paint; override;
    procedure PaintButtonControl(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
      Style: TDrawButtonControlStyleEh; DownButton: Integer;
      Flat, Active, Enabled: Boolean; State: TCheckBoxState);
//    procedure RecreateInplaceSearchIndicator;
//    procedure RangeToBookmarks(FromBookmark, ToBookmark: TUniBookmarkEh; AntiSelect: Boolean);
    procedure RegetDefaultStyle;
    procedure ResetTimer(Interval: Integer);
    procedure ResetGroupPanel;
    procedure RestoreColumnsLayoutProducer(ARegIni: TObject; Section: String;
      RestoreParams: TColumnEhRestoreParams);
    procedure RestoreGridLayoutProducer(ARegIni: TObject; Section: String;
      RestoreParams: TDBGridEhRestoreParams);
    procedure RowHeightsChanged; override;
    procedure SaveColumnsLayoutProducer(ARegIni: TObject; Section: String; DeleteSection: Boolean);
    procedure SaveGridLayoutProducer(ARegIni: TObject; Section: String; DeleteSection: Boolean);
    procedure Scroll(Distance: Integer); virtual;
    procedure ScrollData(DX, DY: Integer); override;
    procedure SelectionActiveChanged; virtual;
    procedure SetColumnAttributes; virtual;
    procedure SetColWidths(Index: Longint; Value: Integer);
    procedure SetCurGroupDataNode(ACurGroupDataNode: TGroupDataTreeNodeEh; ShowInView: Boolean);
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure SetExtraFirstColumnWidth;
    procedure SetDataFilter;
    procedure SetFilterValue(DCol: Longint); virtual;
    procedure SetFooterRowCount(Value: Integer);
    procedure SetFrozenCols(Value: Integer);
    procedure SetRowCount(NewRowCount: Longint);
    procedure SetRowHeight(Value: Integer);
    procedure SetRowLines(Value: Integer);
    procedure SetRowSizingAllowed(Value: Boolean);
    procedure ShowEditor; override;
    procedure ShowFilterEditorChar(Ch: Char);
    procedure StartEditFilter(DCol: Longint);
    procedure StartInplaceSearchTimer;
    procedure StartRowPanelTitleCellDrag(Shift: TShiftState; X, Y, ColumnIndex: Integer); virtual;
    procedure StartRowPanelTitleCellDragBox(Shift: TShiftState; X, Y, ColumnIndex: Integer; TitleRect: TRect); virtual;
    procedure StartGroupPanelTitleMovingMode(Shift: TShiftState; X, Y: Integer); virtual;
    procedure GoRowPanelTitleCellDrag(Shift: TShiftState; X, Y: Integer); virtual;
    procedure StopRowPanelTitleCellDrag(Shift: TShiftState; X, Y: Integer; IsAccept: Boolean); virtual;
    procedure DrawMoveLineOrTitleCell(IsDrawLine: Boolean);
    procedure StopEditFilter;
    procedure StopGroupPanelTitleMovingMode(Shift: TShiftState; X, Y: Integer; IsAccept: Boolean);
    procedure StopInplaceSearchTimer;
    procedure StopTimer;
    procedure StopTracking;
    procedure StyleEhChanged;
    procedure SumListAfterRecalcAll(Sender: TObject);
    procedure SumListChanged(Sender: TObject);
    procedure SumListRecalcAll(Sender: TObject);
    procedure TimedScroll(Direction: TGridScrollDirection); override;
    procedure TimerScroll; virtual;
    procedure TitleClick(Column: TColumnEh); virtual;
    procedure TopLeftChanged; override;
    procedure TrackButton(X, Y: Integer);
    procedure UpdateActive; virtual;
    procedure UpdateEdit; override;
    procedure UpdateText; override;
    procedure UpdateEditorMode;
    procedure UpdateFilterEdit(UpdateData: Boolean);
    procedure UpdateFilterEditProps(DataCol: Longint); virtual;
    procedure UpdateHorzExtScrollBar; virtual;
    procedure UpdateRowCount; virtual;
    procedure UpdateScrollBar; virtual;
    procedure UpdateDataRowHeight(DataRowNum: Integer); virtual;
    procedure UpdateDatasetPosFromRowPos;
    procedure UpdateDatasetPosFromGroupNode(GroupNode: TGroupDataTreeNodeEh);
    procedure UpdateHotTackInfo(X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure WriteAutoFitColWidths(Value: Boolean);
    procedure WriteCellText(Column: TColumnEh; ACanvas: TCanvas; ARect: TRect;
      FillRect: Boolean; DX, DY: Integer; Text: string; Alignment: TAlignment;
      Layout: TTextLayout; MultyL: Boolean;
      EndEllipsis: Boolean; LeftMarg, RightMarg: Integer);
    procedure WriteHTitleMargin(Value: Integer);
    procedure WriteMinAutoFitWidth(Value: Integer);
    procedure WriteTitleHeight(th: Integer);
    procedure WriteTitleLines(tl: Integer);
    procedure WriteUseMultiTitle(Value: Boolean);
    procedure WriteVTitleMargin(Value: Integer);

    property ColCount;
    property Color;
    property ColWidths;
    property DataLink: TGridDataLinkEh read FDataLink;
    property DefaultColWidth;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property FilterEdit: TCustomDBEditEh read FFilterEdit;
    property FilterEditMode: Boolean read FFilterEditMode write SetFilterEditMode;
    property FooterColor: TColor read FFooterColor write SetFooterColor;
    property FooterFont: TFont read FFooterFont write SetFooterFont;
    property ImeMode;
    property ImeName;
    property LayoutLock: Byte read FLayoutLock;
    property OnApplyFilter: TNotifyEvent read FOnApplyFilter write FOnApplyFilter;
    property OnCellClick: TDBGridEhClickEvent read FOnCellClick write FOnCellClick;
    property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
    property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnDrawColumnCell: TDrawColumnEhCellEvent read FOnDrawColumnCell write FOnDrawColumnCell;
    property OnDrawDataCell: TDrawDataCellEvent read FOnDrawDataCell write FOnDrawDataCell; { obsolete }
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
    property OnTitleClick: TDBGridEhClickEvent read FOnTitleClick write FOnTitleClick;
    property ParentColor default False;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property RowCount;
    property RowHeights;
    property SelectedRows: TBookmarkListEh read FBookmarks;
    property TopRow;
    property UpdateLock: Byte read FUpdateLock;
    property ContraColCount: Longint read GetContraColCount write SetContraColCount default 0;

    procedure DrawTitleAsRowPanel(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawDataAsRowPanel(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure DrawFooterAsRowPanel(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState; CellAreaType: TCellAreaTypeEh); virtual;
    procedure SetColInRowPanel(DataCol: Integer);
    function DrawDetailPanelSign(DataCol, DataRow: Integer; AState: TGridDrawState; ARect: TRect; Draw3DRect: Boolean): Integer; virtual;
    procedure UpdateRowDetailPanel;
    function CheckMouseDownInRowDetailSign(Button: TMouseButton; Shift: TShiftState; MouseX, MouseY: Integer): Boolean; virtual;
    function CheckDataCellMouseDownInRowDetailSign(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Cell: TGridCoord; Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer): Boolean; virtual;
    function CellEditRect(ACol, ARow: Longint): TRect; override;
    function GetMouseHitCellState(Cell: TGridCoord; MousePos: TPoint; CellRect: TRect; Column: TColumnEh; var StateRect: TRect): TDBGridEhState;

    procedure InTitleFilterListboxDropDown(Column: TColumnEh);
    procedure InTitleFilterListboxDropDownForRect(Column: TColumnEh; ForRect: TRect);
    procedure InTitleFilterListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure InTitleFilterListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InTitleFilterListKeyPress(Sender: TObject; var Key: Char);
    procedure InTitleFilterListboxCloseUp(Accept: Boolean);

    procedure ReadDesignInfoCollection(Reader: TReader);
    procedure WriteDesignInfoCollection(Writer: TWriter);

  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); virtual;
    destructor Destroy; override;
    function CalcIndicatorColWidth: Integer;
    function CellRect(ACol, ARow: Longint): TRect;
    function CheckCopyAction: Boolean;
    function CheckCutAction: Boolean;
    function CheckDeleteAction: Boolean;
    function CheckFillDataCell(Cell, AreaCell: TGridCoord; Column: TColumnEh; AreaRect: TRect; var Params: TColCellParamsEh): Boolean;
    function CheckPasteAction: Boolean;
    function CheckSelectAllAction: Boolean;
    function DataBox: TGridRect;
    function DataRect: TRect;
    function DataRowCount: Integer;
    function DataRowToRecNo(DataRow: Integer): Integer;
    function DefaultMoveDataRows(BookmarkList: TBMListEh; ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean; virtual;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function FindFieldColumn(const FieldName: String): TColumnEh;
    function GetCellTreeElmentsAreaWidth: Integer;
    function GetColumnInRowPanelAtPos(InCellPos: TPoint; IsTitleTypeCell: Boolean): TColumnEh;
    function GetCellRectInRowPanelAtPos(InCellPos: TPoint; var ACellRect: TRect; IncludeLines: Boolean): TColumnEh;
    function GetCompleteKeyPress: String;
    function GetFooterValue(Row: Integer; Column: TColumnEh): String; virtual;
    function HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean; virtual;
    function HighlightGroupDataCellColor(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean; virtual;
    function InRowPanelLineHeight: Integer; virtual;
    function IsFindDialogShowAsModal: Boolean; virtual;
    function IsMouseInRect(ARect: TRect): Boolean;
    function IsUseMultiTitle: Boolean; virtual;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String; Options: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean; virtual;
    function MoveBy(Distance: Integer): Integer;
    function SafeMoveTop(ATop: Integer; CheckOnly: Boolean = False): Integer;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function ValidFieldIndex(FieldIndex: Integer): Boolean;

    procedure ApplyFilter;
    procedure ClearFilter;
    procedure DataInsert;
    procedure DataAppend;
    procedure DefaultApplyFilter; virtual;
    procedure DefaultApplySorting; virtual;
    procedure DefaultBuildIndicatorTitleMenu(var PopupMenu: TPopupMenu); virtual;
    procedure DefaultCellMouseClick(Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DefaultDrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DefaultDrawColumnDataCell(Cell, AreaCell: TGridCoord; Column: TColumnEh; AreaRect: TRect; var Params: TColCellParamsEh);
    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField; State: TGridDrawState); { obsolete }
    procedure DefaultDrawFooterCell(const Rect: TRect; DataCol, Row: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DefaultFillDataHintShowInfo(CursorPos: TPoint; Cell: TGridCoord; Column: TColumnEh; var Params: TDBGridEhDataHintParams);
    procedure DefaultFillSTFilterListValues(Column: TColumnEh; Items: TStrings);
    procedure DefaultFillSTFilterListCommandValues(Column: TColumnEh; Items: TStrings);
    procedure DefaultFillSTFilterListDataValues(Column: TColumnEh; Items: TStrings);
    procedure DefaultHandler(var Message); override;
    procedure DefaultIndicatorTitleMouseDown(Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure InvalidateFooter;
    procedure InvalidateTitle;
    procedure RestoreBookmark;
    procedure RestoreColumnsLayout(ACustIni: TCustomIniFile; Section: String; RestoreParams: TColumnEhRestoreParams); overload;
    procedure RestoreColumnsLayout(ARegIni: TRegIniFile; RestoreParams: TColumnEhRestoreParams); overload;
    procedure RestoreColumnsLayoutIni(IniFileName: String; Section: String; RestoreParams: TColumnEhRestoreParams);
    procedure RestoreGridLayout(ARegIni: TCustomIniFile; Section: String; RestoreParams: TDBGridEhRestoreParams); overload;
    procedure RestoreGridLayout(ARegIni: TRegIniFile; RestoreParams: TDBGridEhRestoreParams); overload;
    procedure RestoreGridLayoutIni(IniFileName: String; Section: String; RestoreParams: TDBGridEhRestoreParams);
    procedure SaveBookmark;
    procedure SaveColumnsLayout(ACustIni: TCustomIniFile; Section: String); overload;
    procedure SaveColumnsLayout(ARegIni: TRegIniFile); overload;
    procedure SaveColumnsLayoutIni(IniFileName: String; Section: String; DeleteSection: Boolean);
    procedure SaveGridLayout(ACustIni: TCustomIniFile; Section: String); overload;
    procedure SaveGridLayout(ARegIni: TRegIniFile); overload;
    procedure SaveGridLayoutIni(IniFileName: String; Section: String; DeleteSection: Boolean);
    procedure SetSortMarkedColumns;
    procedure SetValueFromPrevRecord;
    procedure StartInplaceSearch(ss: String; TimeOut: Integer; InpsDirection: TLocateTextDirectionEh);
    procedure StopInplaceSearch;
    procedure UpdateAllGridDataRowHeights(); virtual;
    procedure UpdateAllDataRowHeights; virtual;
    procedure UpdateData;

    property AllowedOperations: TDBGridEhAllowedOperations read FAllowedOperations write FAllowedOperations default [alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh];
    property AllowedSelections: TDBGridEhAllowedSelections read FAllowedSelections write SetAllowedSelections default [gstRecordBookmarks..gstAll];
    property AutoFitColWidths: Boolean read FAutoFitColWidths write WriteAutoFitColWidths default False;
    property BufferedPaint: Boolean read FBufferedPaint write FBufferedPaint;
    property Canvas;
    property Center: TDBGridEhCenter read FCenter write SetCenter;
    property Col read GetCol write SetCol;
    property ColumnDefValues: TColumnDefValuesEh read FColumnDefValues write SetColumnDefValues;
    property Columns: TDBGridColumnsEh read FColumns write SetColumns;
    property Ctl3D;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DrawGraphicData: Boolean read FDrawGraphicData write SetDrawGraphicData default false;
    property DrawMemoText: Boolean read FDrawMemoText write SetDrawMemoText default false;
    property EditActions: TDBGridEhEditActions read FEditActions write FEditActions default [];
    property EditButtonsShowOptions: TEditButtonsShowOptionsEh read FEditButtonsShowOptions write SetEditButtonsShowOptions default [];
    property EditorMode;
    property EvenRowColor: TColor read GetEvenRowColor write SetEvenRowColor stored IsEvenRowColorStored;
    property FieldColumns[const FieldName: String]: TColumnEh read GetFieldColumns; default;
    property FieldCount: Integer read GetFieldCount;
    property Fields[FieldIndex: Integer]: TField read GetFields;
    property FixedColor;
    property Font;
    property FooterRowCount: Integer read GetFooterRowCount write SetFooterRowCount default 0;
    property FrozenCols: Integer read FFrozenCols write SetFrozenCols default 0;
    property GridLineColors;
    property HeadTree: THeadTreeNode read FHeadTree;
    property HorzScrollBar: TDBGridEhScrollBar read FHorzScrollBar write SetHorzScrollBar;
    property IndicatorOffset: Byte read FIndicatorOffset;
    property IndicatorTitle: TDBGridEhIndicatorTitle read FIndicatorTitle write FIndicatorTitle;
    property InplaceEditor;
    property InplaceSearching: Boolean read FInplaceSearching;
    property LeafFieldArr: PTLeafCol read FLeafFieldArr;
    property LeftCol;
    property MinAutoFitWidth: Integer read FMinAutoFitWidth write WriteMinAutoFitWidth default 0;
    property OddRowColor: TColor read GetOddRowColor write SetOddRowColor stored IsOddRowColorStored;
    property Options: TDBGridOptions read FOptions write SetOptions default [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
    property OptionsEh: TDBGridEhOptions read FOptionsEh write SetOptionsEh default [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines];
    property OriginCol: Integer read GetOriginCol write SetOriginCol;
    property Row;
    property RowDetailPanel: TRowDetailPanelEh read FRowDetailPanel write SetRowDetailPanel;
    property RowDetailPanelControl: TRowDetailPanelControlEh read FRowDetailControl;
    property RowHeight: Integer read GetRowHeight write SetRowHeight default 0;
    property RowLines: Integer read GetRowLines write SetRowLines default 0;

    property DataGrouping: TDBGridEhDataGroupsEh read FDataGrouping write SetDataGrouping;


//    property RowPanel: Boolean read FRowPanel write SetRowPanel default False;
    property RowPanel: TGridRowPanelEh read FGridRowPanel write SetRowPanel;

    property RowSizingAllowed: Boolean read FRowSizingAllowed write SetRowSizingAllowed default False;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
    property Selection: TDBGridEhSelection read FSelection;
    property SortLocal: Boolean read FSortLocal write FSortLocal default False;
    property SortMarkedColumns: TColumnsEhList read FSortMarkedColumns write FSortMarkedColumns;
    property STFilter: TSTDBGridEhFilter read FSTFilter write SetSTFilter;
    property Style: TDBGridEhStyle read FStyle write SetStyle;
    property SumList: TDBGridEhSumList read FSumList write SetSumList;
    property TimerActive: Boolean read FTimerActive;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property TitleHeight: Integer read ReadTitleHeight write WriteTitleHeight default 0;
    property TitleImages: TCustomImageList read FTitleImages write SetTitleImages;
    property TitleLines: Integer read ReadTitleLines write WriteTitleLines default 0;
    property TitleOffset: Byte read FTitleOffset;
    property TopDataOffset: Byte read GetTopDataOffset;
    property TryUseMemTableInt: Boolean read FTryUseMemTableInt write FTryUseMemTableInt;
    property UseMultiTitle: Boolean read FUseMultiTitle write WriteUseMultiTitle default False;
    property VertScrollBar: TDBGridEhScrollBar read FVertScrollBar write SetVertScrollBar;
    property VisibleColCount;
    property VisibleColumns: TColumnsEhList read FVisibleColumns write FVisibleColumns;
    property VisibleRowCount;
    property VTitleMargin: Integer read FVTitleMargin write WriteVTitleMargin default 10;

    property OnAdvDrawDataCell: TDBGridEhAdvDrawColumnDataEvent read FOnAdvDrawDataCell write FOnAdvDrawDataCell;
    property OnBuildIndicatorTitleMenu: TDBGridEhBuildIndicatorTitleMenu read FOnBuildIndicatorTitleMenu write FOnBuildIndicatorTitleMenu;
    property OnCheckButton: TCheckTitleEhBtnEvent read FOnCheckButton write FOnCheckButton;
    property OnCheckRowHaveDetailPanel: TDBGridEhCheckRowHaveDetailPanelEvent read FOnCheckRowHaveDetailPanel write FOnCheckRowHaveDetailPanel;
    property OnColWidthsChanged: TNotifyEvent read FOnColWidthsChanged write FOnColWidthsChanged;
    property OnDataGroupGetRowText: TDBGridEhDataGroupGetGroupRowTextEvent read FOnDataGroupGetRowText write FOnDataGroupGetRowText;
    property OnActiveGroupingStructChanged: TDBGridEhNotifyEvent read FOnActiveGroupingStructChanged write FOnActiveGroupingStructChanged;

    property OnDataHintShow: TDBGridEhDataHintShowEvent read FOnDataHintShow write FOnDataHintShow;
    property OnDrawFooterCell: TDrawFooterCellEvent read FOnDrawFooterCell write FOnDrawFooterCell;
    property OnFillSTFilterListValues: TDBGridEhFillSTFilterListValuesEvent read FOnFillSTFilterListValues write FOnFillSTFilterListValues;
    property OnGetBtnParams: TGetBtnEhParamsEvent read FOnGetBtnParams write FOnGetBtnParams;
    property OnGetCellParams: TGetCellEhParamsEvent read FOnGetCellParams write FOnGetCellParams;
    property OnGetFooterParams: TGetFooterParamsEvent read FOnGetFooterParams write FOnGetFooterParams;
    property OnGetRowHeight: TGetDBGridEhRowHeightEvent read FOnGetRowHeight write FOnGetRowHeight;
    property OnHintShowPause: TDBGridEhHintShowPauseEvent read FOnHintShowPause write FOnHintShowPause;
    property OnIndicatorTitleMouseDown: TGridEhCellMouseEvent read FOnIndicatorTitleMouseDown write FOnIndicatorTitleMouseDown;
    property OnMoveRecords: TGridMoveRecordsEventEh read FOnMoveRecords write FOnMoveRecords;
    property OnRowDetailPanelHide: TDBGridEhRowDetailPanelHideEvent read FOnRowDetailPanelHide write FOnRowDetailPanelHide;
    property OnRowDetailPanelShow: TDBGridEhRowDetailPanelShowEvent read FOnRowDetailPanelShow write FOnRowDetailPanelShow;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnSortMarkingChanged: TNotifyEvent read FOnSortMarkingChanged write FOnSortMarkingChanged;
    property OnSumListAfterRecalcAll: TNotifyEvent read FOnSumListAfterRecalcAll write FOnSumListAfterRecalcAll;
    property OnSumListRecalcAll: TNotifyEvent read FOnSumListRecalcAll write FOnSumListRecalcAll;
    property OnTitleBtnClick: TTitleEhClickEvent read FOnTitleBtnClick write FOnTitleBtnClick;
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;

//    property HTitleMargin: Integer read FHTitleMargin write WritEhTitleMargin default 0;
  end;

{ TDBGridEh }

  TDBGridEh = class(TCustomDBGridEh)
  public
    property Canvas;
    property GridHeight;
    property RowCount;
    property SelectedRows;
    property TopRow;
  published
    property OnActiveGroupingStructChanged;
    property Align;
    property AllowedOperations;
    property AllowedSelections;
    property Anchors;
    property AutoFitColWidths;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property ColumnDefValues;
    property Columns stored False; //StoreColumns;
    property Constraints;
    property ContraColCount;
    property Ctl3D;
    property DataGrouping;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DrawGraphicData;
    property DrawMemoText;
    property EditActions;
    property Enabled;
    property EvenRowColor;
    property FixedColor;
    property Flat;
    property Font;
    property FooterColor;
    property FooterFont;
    property FooterRowCount;
    property FrozenCols;
    property HorzScrollBar;
    property ImeMode;
    property ImeName;
    property IndicatorTitle;
    property MinAutoFitWidth;
    property OddRowColor;
    property Options;
    property OptionsEh;
    property ParentBiDiMode;
    property ParentCtl3D;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RowDetailPanel;
    property RowHeight;
    property RowLines;
    property RowSizingAllowed;
    property RowPanel;
    property ShowHint;
    property EditButtonsShowOptions;
    property SortLocal;
    property STFilter;
    property SumList;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property TitleHeight;
    property TitleImages;
    property TitleLines;
    property UseMultiTitle;
    property VertScrollBar;
    property Visible;
    property VTitleMargin;
//    property HTitleMargin;
    property OnAdvDrawDataCell;
    property OnApplyFilter;
    property OnBuildIndicatorTitleMenu;
    property OnCellClick;
    property OnCellMouseClick;
    property OnCheckButton;
    property OnCheckRowHaveDetailPanel;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnColWidthsChanged;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDataGroupGetRowText;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawColumnCell;
    property OnDrawDataCell; { obsolete }
    property OnDrawFooterCell;
    property OnDataHintShow;
    property OnEditButtonClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFillSTFilterListValues;
    property OnGetBtnParams;
    property OnGetCellParams;
    property OnGetFooterParams;
    property OnGetRowHeight;
    property OnIndicatorTitleMouseDown;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMoveRecords;
    property OnSelectionChanged;
    property OnHintShowPause;
    property OnRowDetailPanelHide;
    property OnRowDetailPanelShow;
    property OnSortMarkingChanged;
    property OnStartDock;
    property OnStartDrag;
    property OnSumListAfterRecalcAll;
    property OnSumListRecalcAll;
    property OnTitleBtnClick;
    property OnTitleClick;
  end;

{ TColumnDropDownBoxEh }

  TColumnDropDownBoxEh = class(TPersistent)
  private
    FAlign: TDropDownAlign;
    FAutoDrop: Boolean;
    FAutoFitColWidths: Boolean;
    FListSource: TDataSource;
    FOwner: TPersistent;
    FRows: Integer;
    FShowTitles: Boolean;
    FSizable: Boolean;
    FSpecRow: TSpecRowEh;
    FUseMultiTitle: Boolean;
    FWidth: Integer;
    function GetAutoFitColWidths: Boolean;
    function GetColumnDefValues: TColumnDefValuesEh;
    function GetColumns: TDBGridColumnsEh;
    function GetListSource: TDataSource;
    function GetOptions: TDBLookupGridEhOptions;
    function GetSortLocal: Boolean;
    function StoreColumns: Boolean;
    procedure SetAutoFitColWidths(const Value: Boolean);
    procedure SetColumnDefValues(const Value: TColumnDefValuesEh);
    procedure SetColumns(const Value: TDBGridColumnsEh);
    procedure SetListSource(const Value: TDataSource);
    procedure SetOptions(const Value: TDBLookupGridEhOptions);
    procedure SetSpecRow(const Value: TSpecRowEh);
    procedure SetSortLocal(const Value: Boolean);
  protected
    property Align: TDropDownAlign read FAlign write FAlign default daLeft;
    property AutoDrop: Boolean read FAutoDrop write FAutoDrop default False;
    property Rows: Integer read FRows write FRows default 7;
    property ShowTitles: Boolean read FShowTitles write FShowTitles default False;
    property Sizable: Boolean read FSizable write FSizable default False;
    property SpecRow: TSpecRowEh read FSpecRow write SetSpecRow;
    property Width: Integer read FWidth write FWidth default 0;
  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;
    function GetOwner: TPersistent; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoFitColWidths: Boolean read GetAutoFitColWidths write SetAutoFitColWidths default True;
    property ColumnDefValues: TColumnDefValuesEh read GetColumnDefValues write SetColumnDefValues;
    property Columns: TDBGridColumnsEh read GetColumns write SetColumns stored StoreColumns;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property Options: TDBLookupGridEhOptions read GetOptions write SetOptions default [dlgColLinesEh];
    property SortLocal: Boolean read GetSortLocal write SetSortLocal default False;
    property UseMultiTitle: Boolean read FUseMultiTitle write FUseMultiTitle default False;
  end;

  TDBGridEhStyleIndicatorTitleMenuEh = (itmVisibleColumnsEh, itmCut, itmCopy, itmPaste, itmDelete, itmSelectAll{, itmPreview});
  TDBGridEhStyleIndicatorTitleMenusEh =   set of TDBGridEhStyleIndicatorTitleMenuEh;

  TColumnEhMenuItem = class(TMenuItem)
  public
    ColumnEh: TColumnEh;
  end;

  TDBGridEhMenuItem = class(TMenuItem)
  public
    Grid: TCustomDBGridEh;
    TitleMenu: TDBGridEhStyleIndicatorTitleMenuEh;
  end;

  TDBGridEhStyle = class(TPersistent)
  private
    FGrids: TObjectList;
    FLuminateSelection: Boolean;
    FWindowHandle: HWND;
//    FFilterEditCloseUpApplyFilter: Boolean;
    FIsDrawFocusRect: Boolean;
    FInTitleFitlerButtonStyle: TEditButtonStyleEh;
    procedure SetLuminateSelection(const Value: Boolean);
  protected
    function HighlightDataCellColor(AGrid: TCustomDBGridEh; ACol, ARow: Integer;
      DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState;
      InMultiSelect: Boolean; var AColor: TColor; AFont: TFont): Boolean; virtual;
    function HighlightNoDataCellColor(AGrid: TCustomDBGridEh; ACol, ARow: Integer;
      DataCol, DataRow: Integer; CellType: TCellAreaTypeEh; AState: TGridDrawState;
      InMultiSelect: Boolean; var AColor: TColor; AFont: TFont): Boolean; virtual;
    procedure RemoveAllChangeNotification;
    procedure StyleWndProc(var Msg: TMessage); virtual;
    procedure SysColorChanged; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function GridInChangeNotification(Grid: TCustomDBGridEh): Boolean;
    function LightenColor(AColor: TColor; GlassColor: TColor; Ungray: Boolean): TColor;
    procedure AddChangeNotification(Grid: TCustomDBGridEh);

    procedure Changed;
    procedure RemoveChangeNotification(Grid: TCustomDBGridEh);
    property LuminateSelection: Boolean read FLuminateSelection write SetLuminateSelection default True;
//    property FilterEditCloseUpApplyFilter: Boolean
//      read FFilterEditCloseUpApplyFilter write FFilterEditCloseUpApplyFilter default False;
    property IsDrawFocusRect: Boolean read FIsDrawFocusRect write FIsDrawFocusRect default True;
    property InTitleFitlerButtonStyle: TEditButtonStyleEh read FInTitleFitlerButtonStyle write FInTitleFitlerButtonStyle;
  end;

{ TDBGridEhCenter }

  TDBGridEhCenter = class(TPersistent)
  private
    FFilterEditCloseUpApplyFilter: Boolean;
    FGrids: TObjectList;
    FIndicatorTitleMenus: TDBGridEhStyleIndicatorTitleMenusEh;
    FOnApplyFilter: TNotifyEvent;
    FOnApplySorting: TNotifyEvent;
    FOnBuildIndicatorTitleMenu: TDBGridEhBuildIndicatorTitleMenu;
    FOnCellMouseClick: TGridEhCellMouseEvent;
    FOnIndicatorTitleMouseDown: TGridEhCellMouseEvent;
    FOnLocateText: TLocateTextEventEh;
    FOnFillSTFilterListValues: TDBGridEhFillSTFilterListValuesEvent;
    FPreferEditFormatForNumberFields: Boolean;
    FSTFilterDefaultStringOperator: TSTFilterDefaultOperatorEh;
    FSTFilterDefaultNumberOperator: TSTFilterDefaultOperatorEh;
    FSTFilterDefaultBooleanOperator: TSTFilterDefaultOperatorEh;
    FSTFilterDefaultDateTimeOperator: TSTFilterDefaultOperatorEh;
    FUseExtendedScrollingForMemTable: Boolean;
  protected
    function DefaultLocateText(AGrid: TCustomDBGridEh; const FieldName: string;
      const Text: String; Options: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
      Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean; virtual;
    function DefaultMoveRecords(AGrid: TCustomDBGridEh; BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean; virtual;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string;
      const Text: String; Options: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
      Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean; virtual;
    function MoveRecords(AGrid: TCustomDBGridEh; BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean; virtual;
    procedure ApplyFilter(AGrid: TCustomDBGridEh); virtual;
    procedure ApplySorting(AGrid: TCustomDBGridEh); virtual;
    procedure ExecuteFindDialog(AGrid: TCustomDBGridEh; Text, FieldName: String; Modal: Boolean); virtual;
    procedure MenuEditClick(Sender: TObject);
    procedure MenuVisibleColumnClick(Sender: TObject);
    procedure RemoveAllChangeNotification;
  public
    constructor Create;
    destructor Destroy; override;
    function GridInChangeNotification(Grid: TCustomDBGridEh): Boolean;
    function GetSTFilterDefaultOperator(Grid: TCustomDBGridEh; Column: TColumnEh; var FExpression: TSTFilterExpressionEh): TSTFilterDefaultOperatorEh; virtual;
    procedure AddChangeNotification(Grid: TCustomDBGridEh);
    procedure BuildIndicatorTitleMenu(Grid: TCustomDBGridEh; var PopupMenu: TPopupMenu);
    procedure CellMouseClick(Grid: TCustomDBGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IndicatorTitleMouseDown(Grid: TCustomDBGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DefaultFillSTFilterListCommandValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); virtual;
    procedure DefaultFillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); virtual;
    procedure StandardFillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); virtual;

    procedure Changed;
    procedure DefaultApplyFilter(AGrid: TCustomDBGridEh); virtual;
    procedure DefaultApplySorting(AGrid: TCustomDBGridEh); virtual;
    procedure DefaultBuildIndicatorTitleMenu(Grid: TCustomDBGridEh; var PopupMenu: TPopupMenu); virtual;
    procedure DefaultCellMouseClick(Grid: TCustomDBGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DefaultIndicatorTitleMouseDown(Grid: TCustomDBGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DefaultFillSTFilterListValues(Grid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
    procedure RemoveChangeNotification(Grid: TCustomDBGridEh);
    property FilterEditCloseUpApplyFilter: Boolean read FFilterEditCloseUpApplyFilter write FFilterEditCloseUpApplyFilter default False;
    property IndicatorTitleMenus: TDBGridEhStyleIndicatorTitleMenusEh read FIndicatorTitleMenus write FIndicatorTitleMenus;
    property PreferEditFormatForNumberFields: Boolean read FPreferEditFormatForNumberFields write FPreferEditFormatForNumberFields default False;
    property UseExtendedScrollingForMemTable: Boolean read FUseExtendedScrollingForMemTable write FUseExtendedScrollingForMemTable default True;

    property STFilterDefaultStringOperator: TSTFilterDefaultOperatorEh read FSTFilterDefaultStringOperator write FSTFilterDefaultStringOperator;
    property STFilterDefaultNumberOperator: TSTFilterDefaultOperatorEh read FSTFilterDefaultNumberOperator write FSTFilterDefaultNumberOperator;
    property STFilterDefaultDateTimeOperator: TSTFilterDefaultOperatorEh read FSTFilterDefaultDateTimeOperator write FSTFilterDefaultDateTimeOperator;
    property STFilterDefaultBooleanOperator: TSTFilterDefaultOperatorEh read FSTFilterDefaultBooleanOperator write FSTFilterDefaultBooleanOperator;

    property OnApplyFilter: TNotifyEvent read FOnApplyFilter write FOnApplyFilter;
    property OnApplySorting: TNotifyEvent read FOnApplySorting write FOnApplySorting;
    property OnBuildIndicatorTitleMenu: TDBGridEhBuildIndicatorTitleMenu read FOnBuildIndicatorTitleMenu write FOnBuildIndicatorTitleMenu;
    property OnCellMouseClick: TGridEhCellMouseEvent read FOnCellMouseClick write FOnCellMouseClick;
    property OnIndicatorTitleMouseDown: TGridEhCellMouseEvent read FOnIndicatorTitleMouseDown write FOnIndicatorTitleMouseDown;
    property OnLocateText: TLocateTextEventEh read FOnLocateText write FOnLocateText;
    property OnFillSTFilterListValues: TDBGridEhFillSTFilterListValuesEvent read FOnFillSTFilterListValues write FOnFillSTFilterListValues;
  end;

function SetDBGridEhDefaultStyle(NewGridDefaultStyle: TDBGridEhStyle): TDBGridEhStyle;
function DBGridEhDefaultStyle: TDBGridEhStyle;

function SetDBGridEhCenter(NewGridCenter: TDBGridEhCenter): TDBGridEhCenter;
function DBGridEhCenter: TDBGridEhCenter;

{ TDBGridFilterPopupListboxItemEh }

type
  TDBGridFilterPopupListboxItemEh = class(TPopupListboxItemEh)
  protected
    function GetColumn(Listbox: TPopupListboxEh): TColumnEh;
    function GetGroupLevel(Listbox: TPopupListboxEh): TGridDataGroupLevelEh;
  end;

{ TPopupListboxItemEhSort }

  TPopupListboxItemEhSort = class(TDBGridFilterPopupListboxItemEh)
  protected
    FSortState: TSortMarkerEh;
    function CanFocus(Sender: TPopupListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TPopupListboxEh; ItemIndex: Integer; ARect: TRect; State: TOwnerDrawState); override;
  public
    constructor Create(ASortState: TSortMarkerEh);
    procedure Execute(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TPopupListboxItemEhLine }

  TPopupListboxItemEhLine = class(TDBGridFilterPopupListboxItemEh)
  protected
//    function CanCloseMouseUp(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState): Boolean; override;
    function CanFocus(Sender: TPopupListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TPopupListboxEh; ItemIndex: Integer; ARect: TRect; State: TOwnerDrawState); override;
    procedure MouseUp(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState; var IsCloseListbox: Boolean); override;
  public
    function CloseOnExecute(Sender: TPopupListboxEh; ItemIndex: Integer): Boolean; override;
  end;

{ TPopupListboxItemEhSpec }

  TPopupListboxItemEhSpecType = (ptFilterSpecItemClearFilter, ptFilterSpecItemAll,
    ptFilterSpecItemEmpties, ptFilterSpecItemNotEmties, ptFilterSpecItemDialog,
    ptFilterApply);

  TPopupListboxItemEhSpec = class(TDBGridFilterPopupListboxItemEh)
  protected
    FType: TPopupListboxItemEhSpecType;
    function CanFocus(Sender: TPopupListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TPopupListboxEh; ItemIndex: Integer; ARect: TRect; State: TOwnerDrawState); override;
  public
    constructor Create(AType: TPopupListboxItemEhSpecType);
    procedure Execute(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TPopupListboxItemEhData }

  TPopupListboxItemEhData = class(TDBGridFilterPopupListboxItemEh)
  protected
//    FColumnFilter: TSTColumnFilterEh;
    function CanFocus(Sender: TPopupListboxEh; ItemIndex: Integer): Boolean; override;
//    function CanCloseMouseUp(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState): Boolean; override;
    procedure DrawItem(Sender: TPopupListboxEh; ItemIndex: Integer; ARect: TRect; State: TOwnerDrawState); override;
    procedure MouseDown(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseMove(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
    procedure MouseUp(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState; var IsCloseListbox: Boolean); override;
    procedure KeyPress(Sender: TPopupListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); override;
  public
    function CloseOnExecute(Sender: TPopupListboxEh; ItemIndex: Integer): Boolean; override;
    procedure Execute(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
//    constructor Create(AColumnFilter: TSTColumnFilterEh);
  end;

{const
  IndicatorWidth = 11;}
var
  SortMarkerFont: TFont;
  DBGridEhIndicators: TImageList;
  DBGridEhSortMarkerImages: TImageList;

  DBGridEhInplaceSearchKey: TShortCut;
  DBGridEhInplaceSearchNextKey: TShortCut;
  DBGridEhInplaceSearchPriorKey: TShortCut;
  DBGridEhInplaceSearchTimeOut: Integer; // in millisecond
  DBGridEhInplaceSearchColor: TColor;
  DBGridEhInplaceSearchTextColor: TColor;
  DBGridEhSetValueFromPrevRecordKey: TShortCut;
  DBGridEhFindDialogKey: TShortCut;
  DBGridEhShowInTitleFilterBox: TShortCut;


  DBGridEhDebugDraw: Boolean;

  DBGridEhIndicatorTitlePopupMenu: TPopupMenu;
  DBGridEhVisibleColumnsIndicatorMenuItem: TDBGridEhMenuItem;
  DBGridEhCutIndicatorMenuItem: TDBGridEhMenuItem;
  DBGridEhCopyIndicatorMenuItem: TDBGridEhMenuItem;
  DBGridEhPasteIndicatorMenuItem: TDBGridEhMenuItem;
  DBGridEhDeleteIndicatorMenuItem: TDBGridEhMenuItem;
  DBGridEhSelectAllIndicatorMenuItem: TDBGridEhMenuItem;

  DBGridEhDesigntControler: TDesignControlerEh;

  FScreenNumColors: Integer;

  PopupListboxItemEhSortAsc: TPopupListboxItemEhSort;
  PopupListboxItemEhSortDes: TPopupListboxItemEhSort;
  PopupListboxItemEhLine: TPopupListboxItemEhLine;

  PopupListboxItemEhClearFilter: TPopupListboxItemEhSpec;
  PopupListboxItemEhAll: TPopupListboxItemEhSpec;
  PopupListboxItemEhEmpties: TPopupListboxItemEhSpec;
  PopupListboxItemEhNotEmties: TPopupListboxItemEhSpec;
  PopupListboxItemEhDialog: TPopupListboxItemEhSpec;
  PopupListboxItemEhApplyFilter: TPopupListboxItemEhSpec;

  PopupListboxItemEhData: TPopupListboxItemEhData;


const
  ColSelectionAreaHeight: Integer = 7;

procedure RecreateInplaceSearchIndicator;

procedure WriteTextEh(ACanvas: TCanvas;      // Canvas
                      ARect: TRect;          // Draw rect and ClippingRect
                      FillRect:Boolean;      // Fill rect Canvas.Brash.Color
                      DX, DY: Integer;       // InflateRect(Rect, -DX, -DY) for text
                      Text: string;          // Draw text
                      Alignment: TAlignment; // Text alignment
                      Layout: TTextLayout;   // Text layout
                      MultyL: Boolean;       // Word break
                      EndEllipsis: Boolean;  // Truncate long text by ellipsis
                      LeftMarg,              // Left margin
                      RightMarg: Integer;    // Right margin
                      RightToLeftReading: Boolean);

function WriteTextVerticalEh(ACanvas:TCanvas;
                          ARect: TRect;          // Draw rect and ClippingRect
                          FillRect:Boolean;      // Fill rect Canvas.Brash.Color
                          DX, DY: Integer;       // InflateRect(Rect, -DX, -DY) for text
                          Text: string;          // Draw text
                          Alignment: TAlignment; // Text alignment
                          Layout: TTextLayout;   // Text layout
                          EndEllipsis:Boolean;   // Truncate long text by ellipsis
                          CalcTextExtent:Boolean   //
                          ):Integer;

function ApproximateColor(FromColor, ToColor: TColor; Quota: Double): TColor;

implementation

uses DBConsts, Dialogs, Comctrls, CommCtrl, DBGridEhImpExp, Clipbrd, ExtCtrls,
{$IFDEF EH_LIB_6} MaskUtils, {$ELSE} Mask, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
  EhLibConsts, DBLookupGridsEh, CalculatorEh, DBGridEhFindDlgs, DBUtilsEh,
  DBLookupEh, Consts, DBGridEhSimpleFilterDlg;

{$R DBGRIDEH.RES}

const
  bmArrow = 'DBGARROWEH';
  bmEdit = 'DBEDITEH';
  bmInsert = 'DBINSERTEH';
  bmMultiDot = 'DBMULTIDOTEH';
  bmMultiArrow = 'DBMULTIARROWEH';

  bmSmDown = 'DBSMDOWNEH';
  bmSmUp = 'DBSMUPEH';
  bmSmDown1 = 'DBSMDOWNEH_1';
  bmSmUp1 = 'DBSMUPEH_1';

  bmEditWhite = 'DBGARROWEHW';
  bmDropDown = 'DROPDOWNEH';
  MaxMapSize = (MaxInt div 2) div SizeOf(Integer); { 250 million }

{$IFDEF EH_LIB_10}
  MemoTypes = [ftMemo, ftWideMemo, ftOraClob];
{$ELSE}
  MemoTypes = [ftMemo, ftOraClob];
{$ENDIF}

var
  hcrDownCurEh: HCursor = 0;
  hcrRightCurEh: HCursor = 0;
  hcrLeftCurEh: HCursor = 0;

  VarColCellParamsEh: TColCellParamsEh;
//  FGIndicatorTitlePopupMenu: TPopupMenu;
type
  TFontDataEh = record
    Height: Integer;
    Pitch: TFontPitch;
    Style: TFontStyles;
    Charset: TFontCharset;
    Name: TFontName;
    Color: TColor;
  end;

procedure GetFontData(Font: TFont; var FontData: TFontDataEh);
begin
  FontData.Height := Font.Height;
  FontData.Pitch := Font.Pitch;
  FontData.Style := Font.Style;
  FontData.Charset := Font.Charset;
  FontData.Name := Font.Name;
  FontData.Color := Font.Color;
end;

procedure SetFontData(var FontData: TFontDataEh; Font: TFont);
begin
  if Font.Height <> FontData.Height then
    Font.Height := FontData.Height;
  if Font.Pitch <> FontData.Pitch then
    Font.Pitch := FontData.Pitch;
  if Font.Style <> FontData.Style then
    Font.Style := FontData.Style;
  if Font.Charset <> FontData.Charset then
    Font.Charset := FontData.Charset;
  if Font.Name <> FontData.Name then
    Font.Name := FontData.Name;
  if Font.Color <> FontData.Color then
    Font.Color := FontData.Color;
end;

procedure ChangeCanvasDrawOrientation(Canvas: TCanvas;
  RightToLeftOrientation: Boolean; Width, Height: Integer);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(Width, 0);
    Ext := Point(-1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, Width, Height, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * Width, Ext.Y * Height, nil);
  end else
  begin
    Org := Point(0, 0);
    Ext := Point(1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, Width, Height, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * Width, Ext.Y * Height, nil);
  end;
end;

function SafeGetFieldAsInteger(Field: TField; ValueOnError: Integer): Integer;
begin
  Result := ValueOnError;
  if (Field.DataType in [ftSmallint, ftInteger, ftWord]) then
    Result := Field.AsInteger
  else if (Field is TLargeintField) and
          (TLargeintField(Field).AsLargeInt >= Low(Integer)) and
          (TLargeintField(Field).AsLargeInt <= MAXINT) then
    Result := TLargeintField(Field).AsLargeInt
  else if (Field.DataType in [ftFloat]) and
          (Field.AsFloat >= Low(Integer)) and
          (Field.AsFloat <= MAXINT) then
    Result := Field.AsInteger
  else if (Field.DataType in [ftCurrency]) and
          (Field.AsCurrency >= Low(Integer)) and
          (Field.AsCurrency <= MAXINT) then
    Result := Field.AsInteger
  else if (Field.DataType in [ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}]) and
          not VarIsNull(Field.AsVariant) and
          (Field.AsVariant >= Low(Integer)) and
          (Field.AsVariant <= MAXINT) then
    Result := Field.AsInteger;
end;

function FieldsCanModify(Fields: TObjectList): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Fields.Count - 1 do
    if not TField(Fields[i]).CanModify then
    begin
      Result := False;
      Exit;
    end;
end;

function GridRect(ALeft, ATop, ARight, ABottom: Integer): TGridRect;
begin
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Bottom := ABottom;
  Result.Right := ARight;
end;

function Max(A, B: Longint): Longint;
begin
  if A > B
    then Result := A
    else Result := B;
end;

function Min(A, B: Longint): Longint;
begin
  if A < B
    then Result := A
    else Result := B;
end;

function ApproximateColor(FromColor, ToColor: TColor; Quota: Double): TColor;
var
  r, g, b: Integer;
  r1, g1, b1: Integer;
  rgb, rgb1: Longint;
begin
  rgb := ColorToRGB(FromColor);
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;

  rgb1 := ColorToRGB(ToColor);
  r1 := (rgb1 shr 16) and $FF;
  g1 := (rgb1 shr 8) and $FF;
  b1 := rgb1 and $FF;

  r := Max(0, Min(255, r + Trunc((r1 - r) / 255 * Quota)));
  g := Max(0, Min(255, g + Trunc((g1 - g) / 255 * Quota)));
  b := Max(0, Min(255, b + Trunc((b1 - b) / 255* Quota)));
  Result := TColor((r shl 16) or (g shl 8) or b);
end;

{ Error reporting }

procedure RaiseGridError(const S: string);
begin
  raise EInvalidGridOperationEh.Create(S);
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

type
  TCharSet = Set of AnsiChar;

function ExtractWord(N: Integer; const S: string; WordDelims: TCharSet): string; forward;

function GetDefaultSection(Component: TComponent): string;
var
//  F: TCustomForm;
  Owner: TComponent;
begin
  if Component <> nil then
  begin
    if Component is TCustomForm then
      Result := Component.ClassName
    else
    begin
      Result := Component.Name;
      Owner := Component.Owner;
      while (Owner <> nil) and not (Owner is  TCustomForm) do
      begin
        Result := Owner.Name + '.' + Result;
        Owner := Owner.Owner;
      end;
      if Owner <> nil then
        Result := Owner.ClassName + Result;
{      if Component is TControl then
      begin
        F := GetParentForm(TControl(Component));
        if F <> nil then Result := F.ClassName + Result
        else
        begin
          if TControl(Component).Parent <> nil then
            Result := TControl(Component).Parent.Name + Result;
        end;
      end
      else
      begin
        Owner := Component.Owner;
        if Owner is TForm then
          Result := Format('%s.%s', [Owner.ClassName, Result]);
      end;}
    end;
  end else
    Result := '';
end;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

var
  WaitCount: Integer = 0;
  SaveCursor: TCursor = crDefault;
const
  WaitCursor: TCursor = crHourGlass;

procedure StartWait;
begin
  if WaitCount = 0 then
  begin
    SaveCursor := Screen.Cursor;
    Screen.Cursor := WaitCursor;
  end;
  Inc(WaitCount);
end;

procedure StopWait;
begin
  if WaitCount > 0 then
  begin
    Dec(WaitCount);
    if WaitCount = 0 then
      Screen.Cursor := SaveCursor;
  end;
end;

procedure GridInvalidateRow(Grid: TCustomDBGridEh; Row: Longint);
var
  I: Longint;
begin
  for I := 0 to Grid.FullColCount - 1 do Grid.InvalidateCell(I, Row);
end;

procedure OverturnUpRect(var ARect: TRect);
var Bottom: Integer;
begin
  Bottom := ARect.Bottom;
  ARect.Bottom := ARect.Top + (ARect.Right - ARect.Left);
  ARect.Right := ARect.Left + (Bottom - ARect.Top);
end;

function CheckHintTextRect(DrawTextBiDiModeFlagsReadingOnly: Longint;
  Canvas: TCanvas; RightIndent, FInterlinear: Integer; ws: String; ARect: TRect;
  WordWrap: Boolean; var TextWidth, TextHeight: Integer): Boolean;
var
  NewRect: TRect;
  uFormat: Integer;
begin
  Result := False;
  uFormat := DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly;
  if WordWrap
    then uFormat := uFormat or DT_WORDBREAK
    else uFormat := uFormat or DT_SINGLELINE;

  NewRect := Rect(0, 0, ARect.Right - ARect.Left - 2 - RightIndent, 0);
  if NewRect.Right <= 0 then NewRect.Right := 1;
  DrawTextEh(Canvas.Handle, ws, Length(ws), NewRect, uFormat);
  TextWidth := NewRect.Right - NewRect.Left;
  TextHeight := NewRect.Bottom - NewRect.Top;
  if (NewRect.Right - NewRect.Left > ARect.Right - ARect.Left - 2 - RightIndent) or
    (NewRect.Bottom - NewRect.Top > ARect.Bottom - ARect.Top - FInterlinear + 1) then
    Result := True;
end;

{function DefineCursor(Identifier: PChar): TCursor;
var Handle:HCursor;
begin
  Handle := LoadCursor(hInstance, Identifier);
  if Handle = 0 then raise EOutOfResources.Create('Cannot load cursor resource');
  for Result := 1 to High(TCursor) do
    if Screen.Cursors[Result] = Screen.Cursors[crArrow]  then
    begin
      Screen.Cursors[Result] := Handle;
      Exit;
    end;
  raise EOutOfResources.Create('Too many user-defined cursors');
end;}

function GetTextWidth(Canvas: TCanvas; Text: String): Integer;
var ARect: TRect;
  uFormat: Integer;
begin
  uFormat := DT_CALCRECT or DT_LEFT or DT_NOPREFIX;
  ARect := Rect(0, 0, 1, 0);
  DrawTextEh(Canvas.Handle, Text, Length(Text), ARect, uFormat);
  Result := ARect.Right - ARect.Left;
end;

function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;

function ReadOnlyField(Field: TField): Boolean;
var
  MasterFields: TObjectList;
  i: Integer;
begin
  Result := Field.ReadOnly;
  if not Result and (Field.FieldKind = fkLookup) and (Field.KeyFields <> '') then
  begin
    Result := True;
    if Field.DataSet = nil then Exit;
    MasterFields := TObjectList.Create(False);
    try
      Field.Dataset.GetFieldList(MasterFields, Field.KeyFields);
      //MasterField := Field.Dataset.FindField(Field.KeyFields);
      //if MasterField = nil then Exit;
      for i := 0 to MasterFields.Count - 1 do
        Result := Result and TField(MasterFields[i]).ReadOnly;
    finally
      MasterFields.Free;
    end;
  end;
end;

var
  FDBGridEhDefaultStyle: TDBGridEhStyle = nil;

function SetDBGridEhDefaultStyle(NewGridDefaultStyle: TDBGridEhStyle): TDBGridEhStyle;
begin
  Result := FDBGridEhDefaultStyle;
  FDBGridEhDefaultStyle := NewGridDefaultStyle;
  FDBGridEhDefaultStyle.Changed;
end;

function DBGridEhDefaultStyle: TDBGridEhStyle;
begin
  Result := FDBGridEhDefaultStyle;
end;

{ TDBGridEhStyle }

constructor TDBGridEhStyle.Create;
begin
  inherited Create;
  FGrids := TObjectList.Create(False);
{$IFDEF CIL}
  FWindowHandle := WinUtils.AllocateHWnd(StyleWndProc);
{$ELSE}
  FWindowHandle := {$IFDEF EH_LIB_6}Classes.{$ENDIF}AllocateHWnd(StyleWndProc);
{$ENDIF}
  FLuminateSelection := True;
  FIsDrawFocusRect := True;
  SysColorChanged;
  FInTitleFitlerButtonStyle := ebsDropDownEh;
end;

destructor TDBGridEhStyle.Destroy;
var
  i: Integer;
begin
{$IFDEF CIL}
  WinUtils.DeallocateHWnd(FWindowHandle);
{$ELSE}
  {$IFDEF EH_LIB_6}Classes.{$ENDIF}DeallocateHWnd(FWindowHandle);
{$ENDIF}
  if FDBGridEhDefaultStyle = Self then
    FDBGridEhDefaultStyle := nil;
  for i := FGrids.Count-1 downto 0 do
    TCustomDBGridEh(FGrids[i]).Style := nil;
  FreeAndNil(FGrids);
  inherited Destroy;
end;

procedure TDBGridEhStyle.Changed;
var
  i: Integer;
begin
  for i := 0 to FGrids.Count-1 do
    TCustomDBGridEh(FGrids[i]).StyleEhChanged;
end;

procedure TDBGridEhStyle.AddChangeNotification(Grid: TCustomDBGridEh);
begin
  if not GridInChangeNotification(Grid) then
    FGrids.Add(Grid);
end;

function TDBGridEhStyle.GridInChangeNotification(Grid: TCustomDBGridEh): Boolean;
begin
  Result := (FGrids.IndexOf(Grid) >= 0);
end;

procedure TDBGridEhStyle.RemoveChangeNotification(Grid: TCustomDBGridEh);
begin
  FGrids.Remove(Grid);
end;

procedure TDBGridEhStyle.RemoveAllChangeNotification;
var
  i: Integer;
begin
  for i := 0 to FGrids.Count-1 do
    FGrids.Delete(i);
end;

function TDBGridEhStyle.HighlightDataCellColor(AGrid: TCustomDBGridEh;
  ACol, ARow, DataCol, DataRow: Integer; const Value: string;
  AState: TGridDrawState; InMultiSelect: Boolean; var AColor: TColor; AFont: TFont): Boolean;
var
  AFocused: Boolean;
  SrcColor: TColor;
begin
//  Exit;//tmp
  SrcColor := AColor;
  Result := False;
  AFocused := False;
  if {(dgMultiSelect in AGrid.Options) and} AGrid.Datalink.Active then
    Result := (AGrid.Selection.SelectionType <> gstNon) and
      AGrid.DataCellSelected(DataCol, AGrid.Datalink.Datasource.Dataset.Bookmark);
  if not Result then
  begin
    AFocused := AGrid.Focused and (dghHighlightFocus in AGrid.OptionsEh);
    if (dghRowHighlight in AGrid.OptionsEh) and (DataRow + AGrid.TopDataOffset = AGrid.Row) and
      (AGrid.Selection.SelectionType = gstNon) and not (DataCol = AGrid.SelectedIndex)
      and ((dgAlwaysShowSelection in AGrid.Options) or AFocused) then
    begin
      AFocused := True;
      AState := AState + [gdSelected];
    end;
    Result := ((gdSelected in AState) {ddd//} or ((ARow) = AGrid.Row) and (dgRowSelect in AGrid.Options))
      and ((dgAlwaysShowSelection in AGrid.Options) or (AFocused {ddd//}))
        { updatelock eliminates flicker when tabbing between rows }
    and ((AGrid.UpdateLock = 0) or (dgRowSelect in AGrid.Options));
  end;
  if Result then
  begin
    if AGrid.IsSelectionActive then
    begin
      if (ARow = AGrid.Row) and ((DataCol = AGrid.SelectedIndex) or (dgRowSelect in AGrid.Options)) then
      begin
{        if (FScreenNumColors = -1) and ThemeServices.ThemesEnabled then
        begin
          AColor := ApproximateColor(clHighlight, AColor, 128);
//          AFont.Color := clHighlightText;
        end else}
        begin
          AColor := clHighlight;
          AFont.Color := clHighlightText;
        end;
      end else if LuminateSelection and (FScreenNumColors = -1) then
      begin
        if not ((ARow = AGrid.Row) and ((DataCol = AGrid.SelectedIndex) or (dgRowSelect in AGrid.Options)))
        then
        begin
          AColor := GetNearestColor(AGrid.Canvas.Handle, LightenColor(AColor, clHighlight, True));
          if dghHotTrack in AGrid.OptionsEh then
            if (dghRowHighlight in AGrid.OptionsEh) and
               (  ( (ACol = AGrid.FHotTrackCell.X) and (ACol <> AGrid.Col) ) or
                    (dgRowSelect in AGrid.Options)
               ) and
               (ARow = AGrid.FHotTrackCell.Y)
            then
              AColor := ApproximateColor(AColor, clHighlight, 256/3)
        end else if (ARow = AGrid.FHotTrackCell.Y) and AGrid.CanHotTackCell(ACol, ARow) then
        begin
          AColor := GetNearestColor(AGrid.Canvas.Handle, LightenColor(AColor, clHighlight, True));
//          AColor := LightenColor(AColor,
        end;
      end;
    end else if (ARow = AGrid.Row) and
                ((ACol = AGrid.Col) or (dgRowSelect in AGrid.Options)) and
                ((dgAlwaysShowSelection in AGrid.Options) or AFocused) then
    begin
      AColor := clBtnShadow;
      AFont.Color := clHighlightText;
      if dghHotTrack in AGrid.OptionsEh then
        if (ARow = AGrid.FHotTrackCell.Y) and
           ((ACol = AGrid.FHotTrackCell.X) or (dgRowSelect in AGrid.Options)) then
              AColor := ApproximateColor(AColor, LightenColor(AColor, clHighlight, True), 256/3*2);
    end else if (FScreenNumColors = -1) then
    begin
      AColor := GetNearestColor(AGrid.Canvas.Handle, LightenColor(AColor, clBtnShadow, False));
      if dghHotTrack in AGrid.OptionsEh then
        if (ARow = AGrid.FHotTrackCell.Y) and
           ((ACol = AGrid.FHotTrackCell.X) or (dgRowSelect in AGrid.Options)) then
              AColor := ApproximateColor(AColor, LightenColor(AColor, clHighlight, True), 256/3*2);
    end else
      AColor := clBtnFace;
  end else
  begin
    if FScreenNumColors = -1 then
      if dghHotTrack in AGrid.OptionsEh then
        if (ARow = AGrid.FHotTrackCell.Y) and AGrid.CanHotTackCell(ACol, ARow) and
          (AGrid.FHotTrackCell.X >= AGrid.IndicatorOffset) then
        begin
          if (dghRowHighlight in AGrid.OptionsEh) or (dgRowSelect in AGrid.Options) then
          begin
            AColor := GetNearestColor(AGrid.Canvas.Handle, LightenColor(AColor, clHighlight, True));
            if (ACol <> AGrid.FHotTrackCell.X) or (dgRowSelect in AGrid.Options) then
              AColor := ApproximateColor(AColor, SrcColor, 256/3*2);
          end else if ACol = AGrid.FHotTrackCell.X then
          begin
            AColor := GetNearestColor(AGrid.Canvas.Handle, LightenColor(AColor, clHighlight, True));
//          AColor := ApproximateColor(AColor, SrcColor, 128);
          end;
      end;
  end;
end;

function TDBGridEhStyle.HighlightNoDataCellColor(AGrid: TCustomDBGridEh;
  ACol, ARow, DataCol, DataRow: Integer; CellType: TCellAreaTypeEh;
  AState: TGridDrawState; InMultiSelect: Boolean; var AColor: TColor;
  AFont: TFont): Boolean;
begin
  Result := False;
  if InMultiSelect then
  begin
    if ((CellType.HorzType = hctIndicatorEh) and
        (CellType.VertType <> vctAboveFooterEh))
      or
       ((CellType.HorzType <> hctIndicatorEh) and
        (CellType.VertType in [vctTitleEh, vctSubTitleEh]))
      or
       ((CellType.HorzType <> hctIndicatorEh) and
        (CellType.VertType = vctFooterEh) and
        (AGrid.FooterColor = AGrid.FixedColor)) then
    begin
      AColor := RGB(64, 64, 64);
      AFont.Color := clWhite;
    end else if AGrid.IsSelectionActive then
    begin
      if LuminateSelection and (FScreenNumColors = -1) then
//        AColor := FLuminateSelectionColor
        AColor := LightenColor(AColor, clHighlight, True)
      else
      begin
        AColor := clHighlight;
        AFont.Color := clHighlightText;
      end;
    end else if (FScreenNumColors = -1) then
      AColor := LightenColor(AColor, clBtnShadow, False)
    else
      AColor := clBtnFace;
    Result := True;
  end;
end;

procedure TDBGridEhStyle.SetLuminateSelection(const Value: Boolean);
begin
  if FLuminateSelection = Value then Exit;
  FLuminateSelection := Value;
  Changed;
end;

procedure TDBGridEhStyle.StyleWndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_SYSCOLORCHANGE then
      try
        SysColorChanged;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

function TDBGridEhStyle.LightenColor(AColor: TColor; GlassColor: TColor; Ungray: Boolean): TColor;
var
  r, g, b: Double;
  rgb: Longint;
  r_c, g_c, b_c: Double;
  rgb_c: Longint;
begin
  rgb := ColorToRGB(AColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  rgb_c := ColorToRGB(GlassColor);
  r_c := rgb_c and $FF;
  g_c := (rgb_c shr 8) and $FF;
  b_c := (rgb_c shr 16) and $FF;

  r := r + (r_c - r) * 0.5;
  g := g + (g_c - g) * 0.5;
  b := b + (b_c - b) * 0.5;

  r := r + (225 - r) * 0.6;
  g := g + (225 - g) * 0.6;
  b := b + (225 - b) * 0.6;

  if Ungray then
  begin
    r := r - (integer(122) - r) * 0.25;
    g := g - (integer(122) - g) * 0.25;
    b := b - (integer(122) - b) * 0.25;
  end;

  Result := TColor((Max(Min(Round(b), 255),0) shl 16)
                or (Max(Min(Round(g), 255),0) shl 8)
                or Max(Min(Round(r), 255),0));
end;

procedure TDBGridEhStyle.SysColorChanged;
var
  DC: HDC;
begin
  DC := GetDC(0);
  FScreenNumColors := GetDeviceCaps(DC, NUMCOLORS); // -1 if more then 256
  ReleaseDC(0, DC);
end;

{ TDBGridEhCenter }

var
  FDBGridEhCenter: TDBGridEhCenter = nil;

function SetDBGridEhCenter(NewGridCenter: TDBGridEhCenter): TDBGridEhCenter;
begin
  Result := FDBGridEhCenter;
  FDBGridEhCenter := NewGridCenter;
  FDBGridEhCenter.Changed;
end;

function DBGridEhCenter: TDBGridEhCenter;
begin
  Result := FDBGridEhCenter;
end;

constructor TDBGridEhCenter.Create;
begin
  inherited Create;
  FGrids := TObjectList.Create(False);
  FIndicatorTitleMenus := [itmVisibleColumnsEh, itmCut, itmCopy, itmPaste, itmDelete, itmSelectAll];
  STFilterDefaultStringOperator := fdoAuto;
  STFilterDefaultNumberOperator := fdoAuto;
  STFilterDefaultDateTimeOperator := fdoAuto;
  STFilterDefaultBooleanOperator := fdoAuto;
  FUseExtendedScrollingForMemTable := True;
end;

destructor TDBGridEhCenter.Destroy;
var
  i: Integer;
begin
  if FDBGridEhCenter = Self then
    FDBGridEhCenter := nil;
  for i := FGrids.Count-1 downto 0 do
    TCustomDBGridEh(FGrids[i]).Center := nil;
  FreeAndNil(FGrids);
  inherited Destroy;
end;

procedure TDBGridEhCenter.RemoveAllChangeNotification;
var
  i: Integer;
begin
  for i := 0 to FGrids.Count-1 do
    FGrids.Delete(i);
end;

procedure TDBGridEhCenter.MenuVisibleColumnClick(Sender: TObject);
var
  Column: TColumnEh;
begin
  if Sender is TColumnEhMenuItem then
  begin
    Column := TColumnEhMenuItem(Sender).ColumnEh;
    if Column.Visible and (Column.Grid.VisibleColumns.Count <= 1) then
//  do nothing
    else
      Column.Visible := not Column.Visible;
//    with TPopupMenu(TColumnEhMenuItem(Sender).Owner) do
//    begin
//      Popup(PopupPoint.X,PopupPoint.Y);
//    end;
  end;
end;

procedure TDBGridEhCenter.MenuEditClick(Sender: TObject);
begin
  if Sender is TDBGridEhMenuItem then
    with (Sender as TDBGridEhMenuItem) do
    begin
      case TitleMenu of
        itmVisibleColumnsEh: ;
        itmCut: DBGridEh_DoCutAction(Grid,False);
        itmCopy: DBGridEh_DoCopyAction(Grid,False);
        itmPaste: DBGridEh_DoPasteAction(Grid,False);
        itmDelete: DBGridEh_DoDeleteAction(Grid,False);
        itmSelectAll: Grid.Selection.SelectAll;
//        itmPreview: ;
      end;
    end;
end;

function TDBGridEhCenter.GridInChangeNotification(Grid: TCustomDBGridEh): Boolean;
begin
  Result := (FGrids.IndexOf(Grid) >= 0);
end;

procedure TDBGridEhCenter.AddChangeNotification(Grid: TCustomDBGridEh);
begin
  if not GridInChangeNotification(Grid) then
    FGrids.Add(Grid);
end;

procedure TDBGridEhCenter.RemoveChangeNotification(Grid: TCustomDBGridEh);
begin
  FGrids.Remove(Grid);
end;

procedure TDBGridEhCenter.BuildIndicatorTitleMenu(Grid: TCustomDBGridEh; var PopupMenu: TPopupMenu);
begin
  if Assigned(OnBuildIndicatorTitleMenu)
    then OnBuildIndicatorTitleMenu(Grid, PopupMenu)
    else DefaultBuildIndicatorTitleMenu(Grid, PopupMenu);
end;

procedure TDBGridEhCenter.CellMouseClick(Grid: TCustomDBGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnCellMouseClick)
    then OnCellMouseClick(Grid, Cell, Button, Shift, X, Y)
    else DefaultCellMouseClick(Grid, Cell, Button, Shift, X, Y);
end;

procedure TDBGridEhCenter.IndicatorTitleMouseDown(Grid: TCustomDBGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnIndicatorTitleMouseDown)
    then OnIndicatorTitleMouseDown(Grid, Cell, Button, Shift, X, Y)
    else DefaultIndicatorTitleMouseDown(Grid, Cell, Button, Shift, X, Y);
end;

procedure TDBGridEhCenter.Changed;
begin

end;

procedure TDBGridEhCenter.DefaultBuildIndicatorTitleMenu(Grid: TCustomDBGridEh; var PopupMenu: TPopupMenu);
var
  I: Integer;
  mi: TMenuItem;
  cmi: TColumnEhMenuItem;
//  gmi: TDBGridEhMenuItem;
begin
  if DBGridEhIndicatorTitlePopupMenu = nil then
  begin
    DBGridEhIndicatorTitlePopupMenu := TPopupMenu.Create(Screen);
    DBGridEhIndicatorTitlePopupMenu.Name := 'DBGridEhIndicatorTitlePopupMenu';
  end;
  while DBGridEhIndicatorTitlePopupMenu.Items.Count > 0 do
  begin
    mi := DBGridEhIndicatorTitlePopupMenu.Items[0];
    DBGridEhIndicatorTitlePopupMenu.Items.Delete(0);
    if mi.Owner = DBGridEhIndicatorTitlePopupMenu then
      mi.Free;
  end;

  PopupMenu := DBGridEhIndicatorTitlePopupMenu;

  if Grid.IndicatorTitle.UseGlobalMenu and (itmVisibleColumnsEh in IndicatorTitleMenus) then
  begin
    if DBGridEhVisibleColumnsIndicatorMenuItem = nil then
      DBGridEhVisibleColumnsIndicatorMenuItem := TDBGridEhMenuItem.Create(Screen);
    DBGridEhVisibleColumnsIndicatorMenuItem.Clear;
    DBGridEhVisibleColumnsIndicatorMenuItem.Caption := SVisibleColumnsEh;
    PopupMenu.Items.Add(DBGridEhVisibleColumnsIndicatorMenuItem);

    for I := 0 to Grid.Columns.Count - 1 do
    begin
      if Grid.Columns[i].Title.Caption <> '' then
      begin
//        mi := PopupMenu.CreateMenuItem;
        cmi := TColumnEhMenuItem.Create(PopupMenu);
        cmi.ColumnEh := Grid.Columns[i];
        cmi.Caption := Grid.Columns[i].Title.Caption;
        cmi.Checked := Grid.Columns[i].Visible;
        cmi.OnClick := MenuVisibleColumnClick;
        DBGridEhVisibleColumnsIndicatorMenuItem.Add(cmi);
      end;
    end;
  end;

// itmCut  
  if Grid.IndicatorTitle.UseGlobalMenu and (itmCut in IndicatorTitleMenus) then
  begin
    if DBGridEhCutIndicatorMenuItem = nil then
      DBGridEhCutIndicatorMenuItem := TDBGridEhMenuItem.Create(Screen);
//    DBGridEhCutIndicatorMenuItem := TDBGridEhMenuItem.Create(PopupMenu);
    DBGridEhCutIndicatorMenuItem.Caption := SCutEh;
    DBGridEhCutIndicatorMenuItem.OnClick := MenuEditClick;
    DBGridEhCutIndicatorMenuItem.Enabled := Grid.CheckCutAction and (geaCutEh in Grid.EditActions);
    DBGridEhCutIndicatorMenuItem.TitleMenu := itmCut;
    DBGridEhCutIndicatorMenuItem.Grid := Grid;
    PopupMenu.Items.Add(DBGridEhCutIndicatorMenuItem);
  end;

// itmCopy
  if Grid.IndicatorTitle.UseGlobalMenu and (itmCopy in IndicatorTitleMenus) then
  begin
    if DBGridEhCopyIndicatorMenuItem = nil then
      DBGridEhCopyIndicatorMenuItem := TDBGridEhMenuItem.Create(Screen);
//    gmi := TDBGridEhMenuItem.Create(PopupMenu);
    DBGridEhCopyIndicatorMenuItem.Caption := SCopyEh;
    DBGridEhCopyIndicatorMenuItem.OnClick := MenuEditClick;
    DBGridEhCopyIndicatorMenuItem.Enabled := Grid.CheckCopyAction and (geaCopyEh in Grid.EditActions);
    DBGridEhCopyIndicatorMenuItem.TitleMenu := itmCopy;
    DBGridEhCopyIndicatorMenuItem.Grid := Grid;
    PopupMenu.Items.Add(DBGridEhCopyIndicatorMenuItem);
  end;

// itmPaste
  if Grid.IndicatorTitle.UseGlobalMenu and (itmPaste in IndicatorTitleMenus) then
  begin
    if DBGridEhPasteIndicatorMenuItem = nil then
      DBGridEhPasteIndicatorMenuItem := TDBGridEhMenuItem.Create(Screen);
//    gmi := TDBGridEhMenuItem.Create(PopupMenu);
    DBGridEhPasteIndicatorMenuItem.Caption := SPasteEh;
    DBGridEhPasteIndicatorMenuItem.OnClick := MenuEditClick;
    DBGridEhPasteIndicatorMenuItem.Enabled := Grid.CheckPasteAction and (geaPasteEh in Grid.EditActions);
    DBGridEhPasteIndicatorMenuItem.TitleMenu := itmPaste;
    DBGridEhPasteIndicatorMenuItem.Grid := Grid;
    PopupMenu.Items.Add(DBGridEhPasteIndicatorMenuItem);
  end;

// itmDelete
  if Grid.IndicatorTitle.UseGlobalMenu and (itmDelete in IndicatorTitleMenus) then
  begin
    if DBGridEhDeleteIndicatorMenuItem = nil then
      DBGridEhDeleteIndicatorMenuItem := TDBGridEhMenuItem.Create(Screen);
//    gmi := TDBGridEhMenuItem.Create(PopupMenu);
    DBGridEhDeleteIndicatorMenuItem.Caption := SDeleteEh;
    DBGridEhDeleteIndicatorMenuItem.OnClick := MenuEditClick;
    DBGridEhDeleteIndicatorMenuItem.Enabled := Grid.CheckDeleteAction and (geaDeleteEh in Grid.EditActions);
    DBGridEhDeleteIndicatorMenuItem.TitleMenu := itmDelete;
    DBGridEhDeleteIndicatorMenuItem.Grid := Grid;
    PopupMenu.Items.Add(DBGridEhDeleteIndicatorMenuItem);
  end;

//itmSelectAll
  if Grid.IndicatorTitle.UseGlobalMenu and (itmSelectAll in IndicatorTitleMenus) then
  begin
    if DBGridEhSelectAllIndicatorMenuItem = nil then
      DBGridEhSelectAllIndicatorMenuItem := TDBGridEhMenuItem.Create(Screen);
//    gmi := TDBGridEhMenuItem.Create(PopupMenu);
    DBGridEhSelectAllIndicatorMenuItem.Caption := SSelectAllEh;
    DBGridEhSelectAllIndicatorMenuItem.OnClick := MenuEditClick;
    DBGridEhSelectAllIndicatorMenuItem.Enabled := Grid.CheckSelectAllAction and (geaSelectAllEh in Grid.EditActions);
    DBGridEhSelectAllIndicatorMenuItem.TitleMenu := itmSelectAll;
    DBGridEhSelectAllIndicatorMenuItem.Grid := Grid;
    PopupMenu.Items.Add(DBGridEhSelectAllIndicatorMenuItem);
  end;

{
//  itmPreview
  if itmPreview in IndicatorTitleMenus then
  begin
    gmi := TDBGridEhMenuItem.Create(PopupMenu);
    gmi.Caption := SPreviewEh;
    gmi.OnClick := MenuEditClick;
    gmi.Enabled := True;
    gmi.TitleMenu := itmPreview;
    gmi.Grid := Grid;
    PopupMenu.Items.Add(gmi);
  end;
}

// Grid.IndicatorTitle.DropdownMenu
  if Grid.IndicatorTitle.DropdownMenu <> nil then
  begin
    if PopupMenu.Items.Count > 0 then
    begin
      mi := TMenuItem.Create(PopupMenu);
      mi.Caption := cLineCaption;
      PopupMenu.Items.Add(mi);
    end;
//    PopupMenu.Assign(Grid.IndicatorTitle.DropdownMenu);
    for I := 0 to Grid.IndicatorTitle.DropdownMenu.Items.Count - 1 do
    begin
      mi := TMenuItem.Create(PopupMenu);
//      mi := TMenuItem.Create(Application);
      mi.Action := Grid.IndicatorTitle.DropdownMenu.Items[I].Action;
{$IFDEF EH_LIB_6}
      mi.AutoCheck := Grid.IndicatorTitle.DropdownMenu.Items[I].AutoCheck;
{$ENDIF}
      mi.AutoHotkeys := Grid.IndicatorTitle.DropdownMenu.Items[I].AutoHotkeys;
      mi.AutoLineReduction := Grid.IndicatorTitle.DropdownMenu.Items[I].AutoLineReduction;
      mi.Bitmap := Grid.IndicatorTitle.DropdownMenu.Items[I].Bitmap;
      mi.Break := Grid.IndicatorTitle.DropdownMenu.Items[I].Break;
      mi.Caption := Grid.IndicatorTitle.DropdownMenu.Items[I].Caption;
      mi.Checked := Grid.IndicatorTitle.DropdownMenu.Items[I].Checked;
      mi.SubMenuImages := Grid.IndicatorTitle.DropdownMenu.Items[I].SubMenuImages;
      mi.Default := Grid.IndicatorTitle.DropdownMenu.Items[I].Default;
      mi.Enabled := Grid.IndicatorTitle.DropdownMenu.Items[I].Enabled;
      mi.GroupIndex := Grid.IndicatorTitle.DropdownMenu.Items[I].GroupIndex;
      mi.HelpContext := Grid.IndicatorTitle.DropdownMenu.Items[I].HelpContext;
      mi.Hint := Grid.IndicatorTitle.DropdownMenu.Items[I].Hint;
      mi.ImageIndex := Grid.IndicatorTitle.DropdownMenu.Items[I].ImageIndex;
      mi.RadioItem := Grid.IndicatorTitle.DropdownMenu.Items[I].RadioItem;
      mi.ShortCut := Grid.IndicatorTitle.DropdownMenu.Items[I].ShortCut;
      mi.Visible := Grid.IndicatorTitle.DropdownMenu.Items[I].Visible;
      mi.OnClick := Grid.IndicatorTitle.DropdownMenu.Items[I].OnClick;
      mi.OnDrawItem := Grid.IndicatorTitle.DropdownMenu.Items[I].OnDrawItem;
      mi.OnAdvancedDrawItem := Grid.IndicatorTitle.DropdownMenu.Items[I].OnAdvancedDrawItem;
      mi.OnMeasureItem := Grid.IndicatorTitle.DropdownMenu.Items[I].OnMeasureItem;
      PopupMenu.Items.Add(mi);
    end;

//   Grid.IndicatorTitle.DropdownMenu := nil;
//    PopupMenu := Grid.IndicatorTitle.DropdownMenu;
  end;
end;

procedure TDBGridEhCenter.DefaultCellMouseClick(Grid: TCustomDBGridEh;
  Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TDBGridEhCenter.DefaultIndicatorTitleMouseDown(Grid: TCustomDBGridEh;
  Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Grid.IndicatorTitleMouseDown(Cell, Button, Shift, X, Y);
end;

procedure TDBGridEhCenter.ApplyFilter(AGrid: TCustomDBGridEh);
begin
  if Assigned(FOnApplyFilter)
    then FOnApplyFilter(AGrid)
    else DefaultApplyFilter(AGrid);
end;

procedure TDBGridEhCenter.DefaultApplyFilter(AGrid: TCustomDBGridEh);
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      DatasetFeatures.ApplyFilter(AGrid, AGrid.DataSource.DataSet, AGrid.DataSource.DataSet.Active);
  end;
end;

procedure TDBGridEhCenter.ApplySorting(AGrid: TCustomDBGridEh);
begin
  if Assigned(FOnApplySorting)
    then FOnApplySorting(AGrid)
    else DefaultApplySorting(AGrid);
end;

procedure TDBGridEhCenter.DefaultApplySorting(AGrid: TCustomDBGridEh);
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      DatasetFeatures.ApplySorting(AGrid, AGrid.DataSource.DataSet, AGrid.DataSource.DataSet.Active);
  end;
end;

function TDBGridEhCenter.MoveRecords(AGrid: TCustomDBGridEh;
  BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean;
begin
  Result := DefaultMoveRecords(AGrid, BookmarkList, ToRecNo, CheckOnly);
end;

function TDBGridEhCenter.DefaultMoveRecords(AGrid: TCustomDBGridEh;
  BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean;
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  Result := False;
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      Result := DatasetFeatures.MoveRecords(AGrid, BookmarkList, ToRecNo, CheckOnly);
  end;
end;

function TDBGridEhCenter.LocateText(AGrid: TCustomDBGridEh; const FieldName: string;
  const Text: String; Options: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
  Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
begin
  if Assigned(OnLocateText) then
    Result := OnLocateText(AGrid, FieldName, Text, Options, Direction, Matching, TreeFindRange)
  else
    Result := DefaultLocateText(AGrid, FieldName, Text, Options, Direction, Matching, TreeFindRange);
end;

function TDBGridEhCenter.DefaultLocateText(AGrid: TCustomDBGridEh; const FieldName: string;
  const Text: String; Options: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
  Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      Result := DatasetFeatures.LocateText(AGrid, FieldName, Text, Options, Direction, Matching, TreeFindRange)
    else
      Result := LocateDatasetTextEh(AGrid, FieldName, Text, Options, Direction, Matching, TreeFindRange);
  end else
    Result := LocateDatasetTextEh(AGrid, FieldName, Text, Options, Direction, Matching, TreeFindRange);
end;

procedure TDBGridEhCenter.ExecuteFindDialog(AGrid: TCustomDBGridEh; Text, FieldName: String; Modal: Boolean);
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      DatasetFeatures.ExecuteFindDialog(AGrid, Text, FieldName, Modal)
    else
      ExecuteDBGridEhFindDialogProc(AGrid, Text, '', nil, Modal);
  end else
    ExecuteDBGridEhFindDialogProc(AGrid, Text, '', nil, Modal);
end;

procedure TDBGridEhCenter.DefaultFillSTFilterListValues(Grid: TCustomDBGridEh;
  Column: TColumnEh; Items: TStrings);
begin
  Grid.DefaultFillSTFilterListValues(Column, Items);
end;

function TDBGridEhCenter.GetSTFilterDefaultOperator(Grid: TCustomDBGridEh;
  Column: TColumnEh; var FExpression: TSTFilterExpressionEh): TSTFilterDefaultOperatorEh;
begin
  case FExpression.ExpressionType of
    botNon      : Result := STFilterDefaultStringOperator;
    botString   : Result := STFilterDefaultStringOperator;
    botNumber   : Result := STFilterDefaultNumberOperator;
    botDateTime : Result := STFilterDefaultDateTimeOperator;
    botBoolean  : Result := STFilterDefaultBooleanOperator;
  else
    Result := STFilterDefaultStringOperator;
  end;
end;

procedure TDBGridEhCenter.DefaultFillSTFilterListCommandValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
var
  ASTFilter: TSTColumnFilterEh;
begin
  ASTFilter := Column.STFilter;
  Items.BeginUpdate;
  try
    if (dghAutoSortMarking in AGrid.OptionsEh) and ASTFilter.Column.Title.TitleButton then
    begin
      Items.AddObject(SSTFilterListItem_SortingByAscend, PopupListboxItemEhSortDes);
      Items.AddObject(SSTFilterListItem_SortingByDescend, PopupListboxItemEhSortAsc);
      Items.AddObject('-', PopupListboxItemEhLine);
    end;
    Items.AddObject(SSTFilterListItem_ClearFilter, PopupListboxItemEhClearFilter);
    if not AGrid.STFilter.InstantApply then
      Items.AddObject(SSTFilterListItem_ApplyFilter, PopupListboxItemEhApplyFilter);
    Items.AddObject(SSTFilterListItem_CustomFilter, PopupListboxItemEhDialog);
    Items.AddObject(SSTFilterListItem_All, PopupListboxItemEhAll);
    Items.AddObject(SSTFilterListItem_NotEmpties, PopupListboxItemEhNotEmties);
    Items.AddObject(SSTFilterListItem_Empties, PopupListboxItemEhEmpties);
  finally
    Items.EndUpdate;
  end;
end;

procedure TDBGridEhCenter.DefaultFillSTFilterListDataValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      DatasetFeatures.FillSTFilterListDataValues(AGrid, Column, Items)
    else
      StandardFillSTFilterListDataValues(AGrid, Column, Items);
  end else
    StandardFillSTFilterListDataValues(AGrid, Column, Items);
end;

procedure TDBGridEhCenter.StandardFillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
var
  ASTFilter: TSTColumnFilterEh;
  TmpExpression: TSTFilterExpressionEh;
  Filter: String;
  i, k: Integer;
  AGetValues: TStrings;
begin

  ASTFilter := Column.STFilter;
  if Column.FieldValueList = nil then
    if ASTFilter.ListSource <> nil then
      Column.FieldValueList := ASTFilter.GetFieldValueList
    else if AGrid.FIntMemTable <> nil then
    begin
      Column.FieldValueList := AGrid.FIntMemTable.GetFieldValueList(Column.FieldName);
    end;

  Items.BeginUpdate;
  try
    if Column.FieldValueList <> nil then
    begin
      TmpExpression := ASTFilter.Expression;
      ASTFilter.FExpression.Operator1 := foNon;
      ASTFilter.FExpression.Relation := foNon;
      try
        Filter := GetExpressionAsFilterString(AGrid,
          GetOneExpressionAsLocalFilterString, nil, False, True);
      finally
        ASTFilter.FExpression.Operator1 := TmpExpression.Operator1;
        ASTFilter.FExpression.Relation := TmpExpression.Relation;
      end;
      Column.FieldValueList.SetFilter(Filter);

      AGetValues := Column.FieldValueList.GetValues;
      for i := 0 to AGetValues.Count - 1 do
        Items.AddObject(AGetValues[i], PopupListboxItemEhData);
    end;

    if (Column.KeyList.Count > 0) and (Column.PickList.Count > 0) then
    begin
      for i := 0 to Items.Count - 1 do
      begin
        k := Column.KeyList.IndexOf(Items[i]);
        if k >= 0 then
          Items[i] := Column.PickList[k];
      end;
    end;

  finally
    Items.EndUpdate;
  end;
end;

{ TDBGridInplaceEdit }

{ TDBGridInplaceEdit adds support for a button on the in-place editor,
  which can be used to drop down a table-based lookup list, a stringlist-based
  pick list, or (if button style is esEllipsis) fire the grid event
  OnEditButtonClick.  }

//const
//  InitRepeatPause:Integer = 500;  { pause before repeat timer (ms) }
//  RepeatPause:Integer     = 100;  { pause before hint window displays (ms)}

type

{ TInplaceFilterEditEh }

  TInplaceFilterEditEh = class(TDBComboBoxEh)
  private
    FColumn: TColumnEh;
    FGrid: TCustomDBGridEh;
  protected
    procedure CalcEditRect(var ARect: TRect); override;
    procedure SetKeyDisplayText(AValue: Variant; AText: String);
    procedure InternalSetValue(AValue: Variant); override;
    procedure InternalUpdatePostData; override;
    procedure SetVariantValue(const VariantValue: Variant); override;
  public
    procedure CloseUp(Accept: Boolean); override;
    procedure SelectAll;
    property Column: TColumnEh read FColumn;
    property Grid: TCustomDBGridEh read FGrid;
    property PopupListbox;
  end;

  TEditStyle = (esSimple, esEllipsis, esPickList, esDataList, esDateCalendar,
    esUpDown, esDropDown, esAltUpDown, esAltDropDown, esAltCalendar);
//  TPopupListbox = class;

  TDBGridInplaceEdit = class(TInplaceEdit, IComboEditEh {$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FCanvas: TCanvas;
    FActiveList: TWinControl;
    FButtonHeight: Integer;
    FButtonsWidth: Integer;
    FCharKeyStr: String;
    FDataList: TPopupDataGridEh;
    FDroppedDown: Boolean;
    FEditButtonControlList: TEditButtonControlList;
    FEditStyle: TEditStyle;
    FListColumnMothed: Boolean;
    FListVisible: Boolean;
    FLockCloseList: Boolean;
    FLookupSource: TDatasource;
    FMRUList: TMRUListEh;
    FMRUListControl: TWinControl;
    FNoClickCloseUp: Boolean;
    FPickList: TPopupListboxEh;
    FPopupCalculator: TWinControl;
    FPopupMonthCalendar: TPopupMonthCalendarEh;
    FReadOnlyStored: Boolean;
    FUserTextChanged: Boolean;
    FWordWrap: Boolean;
    FImageIndex: Integer;
    function DeleteSeletedText: String;
    function GetColumn: TColumnEh;
    function GetEditButtonByShortCut(ShortCut: TShortCut): TEditButtonEh;
    function GetGrid: TCustomDBGridEh;
    function GetMRUListControl: TWinControl;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure DoDBCSKeyPress(var Key: Char);
    procedure ListColumnMoved(Sender: TObject; FromIndex, ToIndex: Longint);
    procedure ListMouseCloseUp(Sender: TObject; Accept: Boolean);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LocateListText;
    procedure PopupListboxGetImageIndex(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer);
    procedure SetEditStyle(Value: TEditStyle);
    procedure SetWordWrap(const Value: Boolean);
    procedure UpdateImageIndex; virtual;
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    function CanDropCalculator: Boolean;
    function CreateEditButtonControl: TEditButtonControlEh; virtual;
    function CreateMRUListControl: TWinControl; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetPopupCalculator: TWinControl; virtual;
    function TraceMouseMoveForPopupListbox(Sender: TObject; Shift: TShiftState; X, Y: Integer): Boolean;
    procedure BoundsChanged; override;
    procedure ButtonDown(IsDownButton: Boolean); virtual;
    procedure CalcEditRect(var ARect: TRect); virtual;
    procedure CloseUp(Accept: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DBCSKeyPress(var Key: String); virtual;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DrawEditImage(DC: HDC);
    procedure DropDown;
    procedure EditButtonClick(Sender: TObject); virtual;
    procedure EditButtonDown(Sender: TObject; TopButton: Boolean;
      var AutoRepeat: Boolean; var Handled: Boolean); virtual;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure EditButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure FilterMRUItem(AText: String; var Accept: Boolean); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MRUListCloseUp(Sender: TObject; Accept: Boolean);
    procedure MRUListControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MRUListControlResized(Sender: TObject); virtual;
    procedure MRUListDropDown(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintRequiredState(ACanvas: TCanvas); virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure UpdateContents; override;
    procedure UpdateEditButtonControlList;
    procedure UpdateEditButtonControlsState;
    procedure UserChange; virtual;
    procedure WndProc(var Message: TMessage); override;
    property ActiveList: TWinControl read FActiveList write FActiveList;
    property Column: TColumnEh read GetColumn;
    property DataList: TPopupDataGridEh read FDataList;
    property EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property Grid: TCustomDBGridEh read GetGrid;
    property MRUList: TMRUListEh read FMRUList write FMRUList;
    property MRUListControl: TWinControl read GetMRUListControl;
    property PickList: TPopupListboxEh read FPickList;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property ReadOnly;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    procedure Invalidate; override;
  end;

{ TDBGridInplaceEdit }

constructor TDBGridInplaceEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FEditStyle := esSimple;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
end;

destructor TDBGridInplaceEdit.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

function TDBGridInplaceEdit.DeleteSeletedText: String;
begin
  Result := Text;
  Delete(Result, SelStart + 1, SelLength);
end;

function GetTextHeight(Canvas: TCanvas; Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  if Canvas = nil
    then DC := GetDC(0)
    else DC := Canvas.Handle;
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  if Canvas = nil then
    ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure TDBGridInplaceEdit.CalcEditRect(var ARect: TRect);
begin
  if Grid.Flat
    then SetRect(ARect, 2, 1, Width - 2, Height - 1)
    else SetRect(ARect, 2, 2, Width - 2, Height);
  if ((ARect.Bottom - ARect.Top) < GetTextHeight(nil, Font)) and (ARect.Bottom < Height) then
    Inc(ARect.Bottom);
  if FButtonsWidth > 0 then
    if Column.UseRightToLeftAlignment
      then Inc(ARect.Left, FButtonsWidth)
      else Dec(ARect.Right, FButtonsWidth);
  if (Column <> nil) and (Column.ImageList <> nil) and Column.ShowImageAndText then
    if Column.UseRightToLeftAlignment
      then Dec(ARect.Right, Column.ImageList.Width + 5)
      else Inc(ARect.Left, Column.ImageList.Width + 5);
  if (Grid.FIntMemTable <> nil) and (Column = Grid.VisibleColumns[0]) and Grid.FIntMemTable.MemTableIsTreeList then
    if Column.UseRightToLeftAlignment
      then Dec(ARect.Right, Grid.GetCellTreeElmentsAreaWidth+1)
      else Inc(ARect.Left, Grid.GetCellTreeElmentsAreaWidth+1);
end;

procedure TDBGridInplaceEdit.BoundsChanged;
var
  R: TRect;
  Msg: TMsg;
begin
  PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_REMOVE);
  UpdateEditButtonControlList;
  UpdateEditButtonControlsState;
  CalcEditRect(R);
//  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendStructMessage(Handle, EM_SETRECTNP, 0, R);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast
    then SetImeCompositionWindow(Font, R.Left, R.Top);
  if Height > Round(FButtonsWidth * 3 / 2)
    then FButtonHeight := FButtonsWidth
    else FButtonHeight := Height;
end;

procedure TDBGridInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if WordWrap then
    Params.Style := Params.Style and (not ES_AUTOHSCROLL) or ES_MULTILINE or ES_LEFT;
  if Grid.Flat then
    FButtonsWidth := FlatButtonWidth + 1
  else
    FButtonsWidth := GetSystemMetrics(SM_CXVSCROLL);
end;

procedure TDBGridInplaceEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
var
  CurColumn: TColumnEh;
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) and not (FActiveList = FPopupCalculator) then
      begin
        CurColumn := Grid.Columns[Grid.SelectedIndex];
        if (FActiveList = FDataList) and  // Lookup
           (Key = VK_RETURN) and
            Assigned(CurColumn.OnNotInlist) and
            not CurColumn.UsedLookupDataSet.Locate(
              CurColumn.Field.LookupResultField, Self.Text, [loCaseInsensitive])
        then
          CloseUp(False)
        else
          CloseUp(Key = VK_RETURN);
        Key := 0;
      end
      else if not FListVisible and (Key = VK_RETURN) and ([ssCtrl] = Shift) then
      begin
        DropDown;
        Key := 0;
      end;
  end;
end;

procedure TDBGridInplaceEdit.DropDown;
var
  P: TPoint;
  I, J, Y: Integer;
  Column: TColumnEh;
  {WorkArea, }R: TRect;
  FLookupDataSet: TDataSet;
  PopupCalculatorIntf: IPopupCalculatorEh;
  ADropDownAlign: TDropDownAlign;
//  RowCount: Integer;
begin
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with Grid do
      Column := Columns[SelectedIndex];
//    RowCount := Column.DropDownRows;
    if FActiveList = FDataList then //DataList
      with Column.Field do
      begin
      //for delete FDataList.FSizeGrip.Visible := Column.DropDownSizing;
        FLookupDataSet := Column.UsedLookupDataSet;
        if not Assigned(FLookupDataSet) then Exit;
        FDataList.Color := Color;
        FDataList.Font := Font;
//      FDataList.RowCount := Column.DropDownRows;
        FDataList.SpecRow := Column.DropDownSpecRow;
        if FLookupDataSet.IsSequenced and
          (FLookupDataSet.RecordCount > 0) and
          (Integer(Column.DropDownRows) > FLookupDataSet.RecordCount)
        then
//          RowCount := FLookupDataSet.RecordCount;

          FDataList.RowCount := FLookupDataSet.RecordCount
        else
          FDataList.RowCount := Column.DropDownRows;
        FDataList.ShowTitles := Column.DropDownShowTitles;
        FLookupSource.DataSet := FLookupDataSet;
        FDataList.KeyField := LookupKeyFields;
//ddd      FDataList.ListField := {ddd LookupResultField}Column.LookupDisplayFields;
        FDataList.ListFieldIndex := 0;
        FDataList.ListField := Column.LookupDisplayFields; // Assignment ListField must be after ListFieldIndex
        FDataList.AutoFitColWidths := False; // To avoid fit columns width to editbox width for Column.DropDownWidth = -1
        FDataList.UseMultiTitle := Column.DropDownBox.UseMultiTitle;
        FDataList.ListSource := FLookupSource;
        if (Column.DropDownWidth = -1) then
          FDataList.ClientWidth := FDataList.GetColumnsWidthToFit
        else if Column.DropDownWidth > 0 then
          FDataList.Width := Column.DropDownWidth
        else
          FDataList.Width := Self.Width;
        if (FDataList.Width < Width) then
          FDataList.Width := Self.Width;
        FDataList.KeyValue := Grid.FEditKeyValue {DataSet.FieldByName(KeyFields).Value ddd};
        FListColumnMothed := False;
        FDataList.OnColumnMoved := ListColumnMoved;
        FDataList.AutoFitColWidths := Column.DropDownBox.AutoFitColWidths;
{      J := Column.DefaultWidth;
      if J > FDataList.ClientWidth then
        FDataList.ClientWidth := J;
      }end
    else if (FActiveList = FPopupMonthCalendar) then
    begin
        FPopupMonthCalendar.Color := Color;
        FPopupMonthCalendar.Font := Font;
      {try
        FPopupMonthCalendar.Date := StrToDate(Text);
      except
        FPopupMonthCalendar.Date := Grid.Columns[CurColumn.Field.AsDateTime;
      end;}
        try
          if Text = '' then
            FPopupMonthCalendar.Date := TDate(Date)
          else
//            FPopupMonthCalendar.Date := TDate(StrToDate(Text));
            FPopupMonthCalendar.Date := TDate(StrToDateTime(Text));
        except
          if Column.Field.AsDateTime = 0 then
            FPopupMonthCalendar.Date := TDate(Date)
          else
            FPopupMonthCalendar.Date := TDate(Column.Field.AsDateTime);
        end;
        MonthCal_GetMinReqRect(FPopupMonthCalendar.Handle, R);
        FPopupMonthCalendar.Width := R.Right - R.Left;
        FPopupMonthCalendar.Height := R.Bottom - R.Top;
    end else if (FActiveList = FPopupCalculator) then
    begin
      if Supports(FPopupCalculator, IPopupCalculatorEh, PopupCalculatorIntf) then
      begin
        if Text = ''
          then PopupCalculatorIntf.Value := 0
          else PopupCalculatorIntf.Value := StrToFloat(Text);
        PopupCalculatorIntf.Flat := Grid.Flat;
      end;
      HideCaret(Handle);
      SelLength := 0;
    end else
    begin
      //for delete FPickList.FSizeGripResized := False;
      //for delete FPickList.FSizeGrip.Visible := Column.DropDownSizing;
        FPickList.Color := Color;
        FPickList.Font := Font;
        if Assigned(Column.KeyList) and (Column.KeyList.Count > 0) then
        begin
          FPickList.Items.BeginUpdate;
          FPickList.Items.Clear;
          for i := 0 to Min(Column.KeyList.Count, Column.Picklist.Count) - 1 do
            FPickList.Items.AddObject(Column.Picklist.Strings[i], Column.Picklist.Objects[i]);
          FPickList.Items.EndUpdate;
        end else
          FPickList.Items := Column.Picklist;
        if FPickList.Items.Count >= Integer(Column.DropDownRows) then
          FPickList.Height := Integer(Column.DropDownRows) * FPickList.ItemHeight + 4
        else
          FPickList.Height := FPickList.Items.Count * FPickList.ItemHeight + 4;
        if Column.Field.IsNull then
          FPickList.ItemIndex := -1
        else if Assigned(Column.KeyList) and (Column.KeyList.Count > 0)
          then FPickList.ItemIndex := Column.PickList.IndexOf(Text)
        else FPickList.ItemIndex := FPickList.Items.IndexOf({dddColumn.Field.Value} Text);
        J := FPickList.ClientWidth;
        for I := 0 to FPickList.Items.Count - 1 do
        begin
          Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
          if Y > J then J := Y;
        end;
        FPickList.ClientWidth := J + 4;
    end;

    if MRUList.DroppedDown then
      MRUListCloseUp(MRUList, False);

    if BiDiMode = bdRightToLeft
      then ADropDownAlign := daRight
      else ADropDownAlign := daLeft;

    P := AlignDropDownWindow(Self, FActiveList, ADropDownAlign);

    //To avoid overlapping IME windows need to use HWND_NOTOPMOST instead of HWND_TOP
    SetWindowPos(FActiveList.Handle, {HWND_NOTOPMOST} HWND_TOP, P.X, P.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    if FActiveList = FDataList then
    begin
      FDataList.Visible := True; //???
      FDataList.SizeGrip.Visible := Column.DropDownSizing;
//      FDataList.RowCount := FDataList.RowCount;
//      FDataList.RowCount := RowCount; //To update row count for horz scroll bar
    end
    else if FActiveList = FPickList then
      FPickList.SizeGrip.Visible := Column.DropDownSizing
    else if FActiveList = FPopupCalculator then
      FPopupCalculator.Visible := True; //???
      
    if FActiveList = FDataList then
      FDataList.SizeGripResized := False
    else if FActiveList = FPickList then
      FPickList.SizeGripResized := False;
    //FActiveList.Visible := True;
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
    FEditButtonControlList[0].EditButtonControl.AlwaysDown := True;
    FDroppedDown := True;
  end;
end;

procedure TDBGridInplaceEdit.CloseUp(Accept: Boolean);
var
  MasterFields: TObjectList;
  ListValue: Variant;
  CurColumn: TColumnEh;
  CanChange: Boolean;
  PopupCalculatorIntf: IPopupCalculatorEh;
  VarDateTime, OldDateTime: TDateTime;
begin
  ListValue := Null;
  CurColumn := Grid.Columns[Grid.SelectedIndex];
  if (FActiveList <> nil) and (FActiveList.HandleAllocated) and
    ((GetFocus = FActiveList.Handle) or
    (GetParent(GetFocus) = FActiveList.Handle)) then
    SetFocus;
  if FListVisible then
  begin
    with FEditButtonControlList[0].EditButtonControl do
      AlwaysDown := False;
    if FLockCloseList then Exit;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList then
    begin
      ListValue := FDataList.KeyValue;
      if FDataList.SizeGripResized then
      begin
        CurColumn.DropDownRows := FDataList.RowCount;
        CurColumn.FDropDownWidth := FDataList.Width; //Assign to FValue to avoid nil FActiveList when Tab
      end;
      if FListColumnMothed then
        CurColumn.DropDownSpecRow.CellsText := FDataList.SpecRow.CellsText;
    end else if FActiveList = FPopupMonthCalendar then
    begin //MonthCalendar
    end else if FPickList = FActiveList then
    begin
      if FPickList.ItemIndex <> -1 then
      begin
        if Assigned(CurColumn.KeyList) and (CurColumn.KeyList.Count > 0)
          then ListValue := CurColumn.KeyList.Strings[FPicklist.ItemIndex]
          else ListValue := FPickList.Items[FPicklist.ItemIndex];
      end;
      if PickList.SizeGripResized then
      begin
        CurColumn.DropDownRows := PickList.ClientHeight div FPickList.ItemHeight;
        CurColumn.FDropDownWidth := PickList.Width; //Assign to FValue to avoid nil FActiveList when Tab
      end;
    end;
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FActiveList.Visible := False;
    FDroppedDown := False;
    FListVisible := False;
    if Assigned(FDataList) then
    begin
      FDataList.AutoFitColWidths := False;
      FDataList.ListSource := nil;
    end;
    FLookupSource.Dataset := nil;
    Invalidate;
    ShowCaret(Handle);
    if Accept then
    begin
      if FActiveList = FDataList then // Lookup
        with Grid, Columns[SelectedIndex].Field do
        begin
          MasterFields := TObjectList.Create(False);
{          if not Assigned(CurColumn.OnNotInlist) or
             ( Assigned(CurColumn.OnNotInlist) and
             CurColumn.UsedLookupDataSet.Locate(
              CurColumn.Field.LookupResultField, Self.Text, [loCaseInsensitive]))
          then}
            try
              Dataset.GetFieldList(MasterFields, KeyFields);
              if FieldsCanModify(MasterFields) and Grid.CanEditModifyText and
                 CurColumn.CanModify(True) then
              begin
                DataSet.Edit;
                try
                  CanChange := Grid.Datalink.Editing;
                  if CanChange then
                  begin
                    Grid.Datalink.Modified;
                    //Dataset.FieldValues[KeyFields] := ListValue;
                    Grid.FEditKeyValue := ListValue;
                    Grid.FEditText := FDataList.SelectedItem;
                    //MasterField.Value := ListValue;
                  end;
                except
                  on Exception do
                  begin
                    Self.Text := CurColumn.Field.Text + ' '; //May be delphi bag. But without ' ' don't assign
                    raise;
                  end;
                end;
                Self.Text := FDataList.SelectedItem;
                SelectAll;
              end;
            finally
              MasterFields.Free;
            end;
        end
      else if (FActiveList = FPopupMonthCalendar) then
      begin
        with Grid, CurColumn.Field do
          if CurColumn.CanModify(True) and CanEditModifyText then
          begin
            DataSet.Edit;
            try
              OldDateTime := StrToDateTime(Text);
            except
              OldDateTime := 0;
            end;
            VarDateTime := Trunc(FPopupMonthCalendar.Date) + Frac(OldDateTime);
            CurColumn.UpdateDataValues(DateToStr(Trunc(FPopupMonthCalendar.Date)), Variant(VarDateTime) , False);
            //AsDateTime := FPopupMonthCalendar.Date;
          end;
      end
      else if (FActiveList = FPopupCalculator) then
      begin
        if CurColumn.CanModify(True) and Grid.CanEditModifyText then
        begin
          if Supports(FPopupCalculator, IPopupCalculatorEh, PopupCalculatorIntf) then
            if VarType(PopupCalculatorIntf.Value) in
                 [varDouble, varSmallint, varInteger, varSingle, varCurrency]
            then
            begin
              Text := FloatToStr(PopupCalculatorIntf.Value);
              Grid.FEditText := Text;
              SelectAll;
            end;
        end;
      end
      else if (not VarIsNull(ListValue)) and Grid.CanEditModifyText then
        with Grid, CurColumn.Field do
          if Assigned(CurColumn) and Assigned(CurColumn.KeyList) and (CurColumn.KeyList.Count > 0) then
          begin
            if (FPicklist.ItemIndex >= 0) then
            begin
              Self.Text := FPickList.Items[FPicklist.ItemIndex];
              Grid.FEditText := Self.Text;
              UpdateImageIndex;
            end
          end else
          begin
            Self.Text := ListValue;
            Grid.FEditText := ListValue;
            UpdateImageIndex;
          end;
    end else if FActiveList = FDataList then
      Text := Grid.FEditText
    else if FActiveList = FPickList then
      if CurColumn.GetColumnType = ctKeyPickList then
      begin
        Text := Grid.FEditText;
      end else
        Text := Grid.FEditText;
  end;
  Parent.SetFocus;
end;

function StringsLocate(StrList: TStrings; Str: String; Options: TLocateOptions): Integer;
  function Compare(S1, S2: String): Integer;
  begin
    if loCaseInsensitive in Options
      then Result := NlsCompareText(S1, S2)
    else Result := NlsCompareStr(S1, S2);
  end;
var i: Integer;
  S: String;
begin
  Result := -1;
  for i := 0 to StrList.Count - 1 do
  begin
    if loPartialKey in Options
      then S := Copy(StrList.Strings[i], 1, Length(Str))
      else S := StrList.Strings[i];
    if NlsCompareText(S, Str) = 0 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TDBGridInplaceEdit.LocateListText;
var AColumn: TColumnEh;
begin
  with Grid do AColumn := Columns[SelectedIndex];
  if not AColumn.CanModify(True) then Exit;
  if (EditStyle = esDataList) then
  begin
    Grid.FEditText := Text;
    if (AColumn.UsedLookupDataSet <> nil) and
       AColumn.UsedLookupDataSet.Locate(AColumn.Field.LookupResultField, Text, [loCaseInsensitive]) then
      Grid.FEditKeyValue :=
        AColumn.UsedLookupDataSet.FieldValues[AColumn.Field.LookupKeyFields]
    else
      Grid.FEditKeyValue := Null;
  end else
    Grid.FEditText := Text;
end;

type
  TWinControlCracker = class(TWinControl) end;

procedure TDBGridInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  MasterFields: TObjectList;
  Field: TField;
  Y: Integer;
  S: String;
  eb: TEditButtonEh;
  AutoRepeat: Boolean;

  procedure SendToParent;
  begin
    Grid.KeyDown(Key, Shift);
    Key := 0;
  end;

begin
  if (EditStyle in [esEllipsis, esDropDown]) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    KillMessage(Handle, WM_CHAR);
    Grid.EditButtonClick;
  end else
    if (Key = VK_DELETE) and (Shift = []) and (Column.GetColumnType in [ctLookupField, ctKeyPickList])
    {(EditStyle in [esDataList,esPickList])}
    and Column.CanModify(False) then
    begin
      if (SelStart = 0) and (SelLength = Length(Text)) and Column.CanModify(True) then // All text seleted
      begin
        if EditStyle = esDataList then //lookup
        begin
          Field := Column.Field;
          MasterFields := TObjectList.Create(False);
          try
            Field.Dataset.GetFieldList(MasterFields, Field.KeyFields);
            if FieldsCanModify(MasterFields) then
            begin
              Field.DataSet.Edit;
            //for i := 0 to MasterFields.Count-1 do TField(MasterFields[i]).Clear;
            //MasterField.Clear;
              Grid.Datalink.Modified;
              Grid.FEditKeyValue := Null;
              Grid.FEditText := '';
              Text := '';
              if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;
            //Field.Clear;
            end;
          finally
            MasterFields.Free;
          end;
        end
        else if (EditStyle = esPickList) and
          (Column.GetColumnType = ctKeyPickList) then
        begin // keypicklist
          Text := '';
          Grid.FEditText := Text;
        end
      end else if Assigned(Column.OnNotInlist) then
      begin
        S := DeleteSeletedText;
        Y := SelStart;
        if Column.CanModify(True) then
        begin
          Text := S;
          SelStart := Y;
          LocateListText;
          if Assigned(FDataList) then
            FDataList.KeyValue := Grid.FEditKeyValue
          else if Assigned(FPickList) then
            FPickList.ItemIndex :=
              StringsLocate(FPickList.Items, Grid.FEditText, [loCaseInsensitive]);
        end;
      end else
        Key := 0;
    end
    else if (Key = VK_BACK) and
      (Column.GetColumnType in [ctLookupField, ctKeyPickList]) then
    begin
      if not Assigned(Column.OnNotInlist) then
      begin
        Key := VK_LEFT;
        inherited KeyDown(Key, Shift);
      end else
      begin
        S := DeleteSeletedText;
        Y := SelStart;
        if Column.CanModify(True) then
        begin
          Field := Column.Field;
          Field.DataSet.Edit;
          Delete(S, Y, 1);
          Text := S;
          SelStart := Y - 1;
          LocateListText;
          if Assigned(FDataList) then
            FDataList.KeyValue := Grid.FEditKeyValue
          else if Assigned(FPickList) then
            FPickList.ItemIndex :=
              StringsLocate(FPickList.Items, Grid.FEditText, [loCaseInsensitive]);
        end;
      end;
    end
    else if WordWrap and (Key in [VK_UP, VK_DOWN]) then
    begin
      if not (dgAlwaysShowEditor in Grid.Options) then Exit;
      Y := Perform(EM_LINEFROMCHAR, SelStart, 0);
      if (Y = 0) and (Key = VK_UP) then
        inherited KeyDown(Key, Shift)
      else if (Y + 1 = Perform(EM_GETLINECOUNT, 0, 0)) and (Key = VK_DOWN) then
        inherited KeyDown(Key, Shift)
      else if SelLength = Length(Text) then
        inherited KeyDown(Key, Shift);
    end
    else if (Key = VK_RETURN) and not ((MRUList <> nil) and MRUList.DroppedDown) and (dghEnterAsTab in Grid.OptionsEh) then
      SendToParent
    else if (ShortCut(Key, Shift) = DBGridEhSetValueFromPrevRecordKey) then
      SendToParent
    else if (ShortCut(Key, Shift) = DBGridEhInplaceSearchKey) and (dghIncSearch in Grid.OptionsEh) then
      if Grid.InplaceSearching and (dghDialogFind in Grid.OptionsEh) and (DBGridEhFindDialogKey = DBGridEhInplaceSearchKey) then
      begin
        Grid.StopInplaceSearch;
        Grid.ExecuteFindDialog(SelText, '', Grid.IsFindDialogShowAsModal);
//        ExecuteDBGridEhFindDialogProc(Grid, SelText, '', nil, Grid.IsFindDialogShowAsModal);
      end else
        Grid.StartInplaceSearch('', -1, ltdAllEh)
    else if (ShortCut(Key, Shift) = DBGridEhFindDialogKey) and (dghDialogFind in Grid.OptionsEh) then
        Grid.ExecuteFindDialog(SelText, '', Grid.IsFindDialogShowAsModal)
//      ExecuteDBGridEhFindDialogProc(Grid, SelText, '', nil, Grid.IsFindDialogShowAsModal)
    else if Column.DropDownSpecRow.Visible and (EditStyle = esDataList) and
      (ShortCut(Key, Shift) = Column.DropDownSpecRow.ShortCut) and Column.CanModify(False) then
    begin
      if Column.CanModify(True) then
      begin
        Text := Column.DropDownSpecRow.CellText[0];
        Grid.FEditText := Text;
        Grid.FEditKeyValue := Column.DropDownSpecRow.Value;
        FDataList.KeyValue := Grid.FEditKeyValue;
        SelectAll;
      end;
    end
    else if GetEditButtonByShortCut(ShortCut(Key, Shift)) <> nil then
    begin
      eb := GetEditButtonByShortCut(ShortCut(Key, Shift));
      FEditButtonControlList[eb.Index + 1].EditButtonControl.EditButtonDown(False, AutoRepeat);
      FEditButtonControlList[eb.Index + 1].EditButtonControl.Click; //DropDown;
      Key := 0;
    end else
      inherited KeyDown(Key, Shift);
end;

procedure TDBGridInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if (FEditStyle = esDataList) and (FDataList <> nil) and FListVisible and (Key = VK_CONTROL) then
    FDataList.KeyUp(Key, Shift);
end;

procedure TDBGridInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TDBGridInplaceEdit.ListMouseCloseUp(Sender: TObject; Accept: Boolean);
begin
  CloseUp(Accept);
end;

procedure TDBGridInplaceEdit.PopupListboxGetImageIndex(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer);
begin
//  if Assigned(Column) and Assigned(Column.OnGetItemImageIndex) then
//    Column.OnGetItemImageIndex(Column, ItemIndex, ImageIndex);
end;

procedure TDBGridInplaceEdit.UpDownClick(Sender: TObject; Button: TUDBtnType);
var Col: TColumnEh;
  Znak: Integer;
begin
  Col := Grid.Columns[Grid.SelectedIndex];
  if not Col.CanModify(True) then Exit;
  Znak := 1;
  if (Col.GetEditText <> Text) then
  begin
    Col.SetEditText(Text);
    Col.Grid.UpdateData;
  end;
  if Button = btNext then
  begin
    if Col.GetColumnType <> ctCommon then Znak := -1;
    Col.SetNextFieldValue(Col.Increment * Znak);
  end else
  begin
    if Col.GetColumnType <> ctCommon then Znak := -1;
    Col.SetNextFieldValue(-Col.Increment * Znak);
  end;
end;

procedure TDBGridInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Grid.FIntMemTable <> nil) and (Column = Grid.VisibleColumns[0]) and Grid.FIntMemTable.MemTableIsTreeList then
    if Grid.UseRightToLeftAlignment then
    begin
      if (ClientWidth >= X ) and (X > ClientWidth - Grid.GetCellTreeElmentsAreaWidth) then
        if (ClientWidth - (Grid.GetCellTreeElmentsAreaWidth - 18) >= X ) then
          Grid.FIntMemTable.SetTreeNodeExpanded(Grid.Row - Grid.TopDataOffset, not Grid.FIntMemTable.GetTreeNodeExpanded);
    end else
    if (0 <= X ) and (X < Grid.GetCellTreeElmentsAreaWidth) then
    begin
      if (Grid.GetCellTreeElmentsAreaWidth - 18 <= X ) then
        Grid.FIntMemTable.SetTreeNodeExpanded(Grid.Row - Grid.TopDataOffset, not Grid.FIntMemTable.GetTreeNodeExpanded);
    end;
  inherited MouseDown(Button, Shift, X, Y);
  if Column.DblClickNextVal and (ssDouble in Shift) then
    if (ssShift in Shift)
      then Column.SetNextFieldValue(-1)
    else Column.SetNextFieldValue(1);
end;

procedure TDBGridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.PaintWindow(DC: HDC);
begin
  FCanvas.Lock;
  try
    FCanvas.Handle := DC;
    try
      TControlCanvas(FCanvas).UpdateTextFlags;
      if (Grid.FIntMemTable <> nil) and (Column = Grid.VisibleColumns[0]) and Grid.FIntMemTable.MemTableIsTreeList then
      begin
        if Grid.UseRightToLeftAlignment then
          ChangeCanvasDrawOrientation(FCanvas, True, ClientWidth, ClientHeight);
        Grid.DrawTreeArea(FCanvas, Rect(0, 0, Width, Height), False, False);
        if Grid.UseRightToLeftAlignment then
          ChangeCanvasDrawOrientation(FCanvas, False, ClientWidth, ClientHeight);
      end;
      PaintRequiredState(FCanvas);
    finally
      FCanvas.Handle := 0;
    end;
  finally
    FCanvas.Unlock;
  end;
  if (Column <> nil) and (Column.ImageList <> nil) and Column.ShowImageAndText then
    DrawEditImage(DC);
  inherited PaintWindow(DC);
end;

procedure TDBGridInplaceEdit.PaintRequiredState(ACanvas: TCanvas);
var
  r: TRect;
  DrawState: Boolean;
begin
  DrawState := Column.HighlightRequired and Grid.FDataLink.Active and
    (Grid.FDataLink.DataSet.State in [dsInsert, dsEdit]) and (Column.Field <> nil) and
    Column.Field.Required and Column.Field.IsNull;
  if Assigned(Column.FOnCheckDrawRequiredState) then
    Column.FOnCheckDrawRequiredState(Self, Text, DrawState);
  if DrawState then
  begin
    ACanvas.Pen.Color := clRed;
    ACanvas.Pen.Style := psDot;
    CalcEditRect(r);
    ACanvas.MoveTo(r.Left+2, ClientHeight-1);
    ACanvas.LineTo(r.Right-3, ClientHeight-1);
  end;
end;

procedure TDBGridInplaceEdit.SetEditStyle(Value: TEditStyle);
begin
//  if Value <> FEditStyle then
//  begin
    FEditStyle := Value;
    case Value of
      esPickList:
        begin
          if FPickList = nil then
          begin
            FPickList := TPopupListboxEh.Create(Self);
            FPickList.Visible := False;
            FPickList.Parent := Self;
            FPickList.OnMouseUp := ListMouseUp;
            FPickList.OnGetImageIndex := PopupListboxGetImageIndex;
//            FPickList.IntegralHeight := True;
            FPickList.ItemHeight := FPickList.GetTextHeight;
            FPickList.Ctl3D := True;
          end;
          if Assigned(Column) and Assigned(Column.ImageList)
            then FPickList.ImageList := Column.ImageList
            else FPickList.ImageList := nil;
          FActiveList := FPickList;
        end;
      esDataList:
        begin
          if (FDataList = nil) or (FDataList <> Column.DataList) then
          begin
            FDataList := TPopupDataGridEh(Column.DataList); // TPopupDataGridEh.Create(Self);
            FDataList.Visible := False;
            FDataList.Ctl3D := True;
            FDataList.ParentCtl3D := False;
            FDataList.Parent := Self;
            //FDataList.OnMouseUp := ListMouseCloseUp;
            FDataList.OnMouseCloseUp := ListMouseCloseUp;
            //FDataList.OnMouseMove := ListMouseMove;
            //FDataList.OnMouseDown := ListMouseDown;
            FDataList.FreeNotification(Self);
          end;
          FActiveList := FDataList;
        end;
      esDateCalendar, esAltCalendar:
        begin
          if FPopupMonthCalendar = nil then
          begin
            FPopupMonthCalendar := TPopupMonthCalendarEh.Create(Self);
            FPopupMonthCalendar.Visible := False;
            FPopupMonthCalendar.Parent := Self;
          end;
          FActiveList := FPopupMonthCalendar;
        end;
      esUpDown:
        FActiveList := nil;
      esDropDown, esAltDropDown:
        begin
          if Assigned(Column) and Assigned(Column.Field) and (Column.Field is TNumericField) then
          begin
            FActiveList := GetPopupCalculator;
          end else
            FActiveList := nil;
        end;
    else { cbsNone, cbsEllipsis, or read only field }
      FActiveList := nil;
    end;
//  end;
  if Column <> nil then
    ReadOnly := Column.ReadOnly;
  Repaint;
end;

function GetColumnEditStile(Column: TColumnEh): TEditStyle;
var
  MasterFields: TObjectList;
  ACanModify: Boolean;
begin
  Result := esSimple;
  case Column.ButtonStyle of
    cbsEllipsis: Result := esEllipsis;
    cbsDropDown: Result := esDropDown;
    cbsAltDropDown:
      if Assigned(Column.Field) and
        (Column.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}])
        then Result := esAltCalendar
        else Result := esAltDropDown;
    cbsUpDown: Result := esUpDown;
    cbsAltUpDown: Result := esAltUpDown;
    cbsAuto:
      if Assigned(Column.Field) then
        with Column.Field do
        begin
        { Show the dropdown button only if the field is editable }
          if Dataset.Active and (FieldKind = fkLookup) then
          begin
          //MasterField := Dataset.FieldByName(KeyFields);
            MasterFields := TObjectList.Create(False);
            try
              Dataset.GetFieldList(MasterFields, KeyFields);
            { Column.DefaultReadonly will always be True for a lookup field.
              Test if Column.ReadOnly has been assigned a value of True }
              ACanModify := FieldsCanModify(MasterFields) or (Assigned(Column.Grid) and (csDesigning in Column.Grid.ComponentState));
              if (MasterFields.Count > 0) and ACanModify and
                not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
                with Column.Grid do
                  if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
                    Result := esDataList;
            finally
              MasterFields.Free;
            end;
          end
          else
            if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
              not Column.Readonly {and not Assigned(Column.ImageList)}
              then Result := esPickList
            else if (DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}]) and not Column.Readonly
              then Result := esDateCalendar;
        end;
  end;
end;

procedure TDBGridInplaceEdit.UpdateContents;
var
  Column: TColumnEh;
  NewStyle: TEditStyle;
  MasterFields: TObjectList;

  function MasterFieldsCanModify: Boolean;
  var i: Integer;
  begin
    Result := True;
    for i := 0 to MasterFields.Count - 1 do
      if not TField(MasterFields[i]).CanModify then
      begin
        Result := False;
        Exit;
      end;
  end;

begin
  with Grid do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
    cbsEllipsis: NewStyle := esEllipsis;
    cbsDropDown: NewStyle := esDropDown;
    cbsAltDropDown:
      if Assigned(Column.Field) and
        (Column.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}])
        then NewStyle := esAltCalendar
        else NewStyle := esAltDropDown;
    cbsAuto:
      if Assigned(Column.Field) then
        with Column.Field do
        begin
        { Show the dropdown button only if the field is editable }
          if FieldKind = fkLookup then
          begin
            MasterFields := TObjectList.Create(False);
            try
              Dataset.GetFieldList(MasterFields, KeyFields);
            { Column.DefaultReadonly will always be True for a lookup field.
              Test if Column.ReadOnly has been assigned a value of True }
              if (MasterFields.Count > 0) and MasterFieldsCanModify and
                not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
                with Grid do
                  if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
                    NewStyle := esDataList;
            finally
              MasterFields.Free;
            end;
          end
          else
            if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
              not Column.Readonly then
              NewStyle := esPickList
            else if (DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}]) and not Column.Readonly then
              NewStyle := esDateCalendar;
        end;
    cbsUpDown: NewStyle := esUpDown;
    cbsAltUpDown: NewStyle := esAltUpDown;
  end;
  EditStyle := NewStyle;
  Self.Font.Assign(Column.Font);
  Column.FillColCellParams(Grid.FColCellParamsEh);
  with Grid.FColCellParamsEh do
  begin
    FBackground := Column.Color;
    FFont := Self.Font;
    FState := [gdFocused];
    FText := Column.GetEditText;
    FReadOnly := not Column.CanModify(False);
    Grid.GetCellParams(Column, FFont, FBackground, FState);
    if not (csLoading in Grid.ComponentState) then
      Column.GetColCellParams(True, Grid.FColCellParamsEh);
    Self.Color := FBackground;
    Self.FImageIndex := FImageIndex;
    if not Column.CanModify(False) <> FReadOnly then
    begin
      FReadOnlyStored := True;
      Self.ReadOnly := FReadOnly;
    end else
      FReadOnlyStored := False;
  end;
  if Grid.RowPanel.Active
    then WordWrap := Column.WordWrap and (Column.InRowLineHeight > 1)
    else WordWrap := Column.WordWrap and Column.CurLineWordWrap(Column.GetCellHeight(Grid.Row));
//  inherited UpdateContents;
  Text := '';
  EditMask := Column.GetEditMask;
  Text := Grid.FColCellParamsEh.FText;
  MaxLength := Grid.GetEditLimit;
  MRUList := Column.MRUList;
end;

procedure TDBGridInplaceEdit.CMCancelMode(var Message: TCMCancelMode);

  function CheckActiveListChilds(Control: TWinControl): Boolean;
  var i: Integer;
  begin
    Result := False;
    if Control <> nil then
      for i := 0 to Control.ControlCount - 1 do
        if Control.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  inherited;
  if (Message.Sender <> Self) and  not ContainsControl(Message.Sender) then
  begin
    if (Message.Sender <> FActiveList) and not CheckActiveListChilds(FActiveList) then
      CloseUp(False);
    if (FMRUListControl <> nil) and (Message.Sender <> FMRUListControl)
      and  not CheckActiveListChilds(FMRUListControl) then
      MRUListCloseUp(MRUList, False);
  end;
end;

procedure TDBGridInplaceEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
{    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
}
    inherited;
{   This code switches layout to default language. This code is incorrect.
    if HWND(Message.FocusedWnd) <> Grid.Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
}      
  end;
  if FListVisible and not
    ((Message.FocusedWnd = FActiveList.Handle) or
    (GetParent(Message.FocusedWnd) = FActiveList.Handle)
    ) then
    CloseUp(False)
  else if MRUList.DroppedDown and not (Message.FocusedWnd = MRUListControl.Handle) then
    MRUListCloseUp(MRUList, False);
//  if (Message.FocusedWnd <> Grid.Handle) then
//    Grid.ControlLeaveFocus;
  if Grid.FSelectionActive <> Grid.IsSelectionActive then
    Grid.SelectionActiveChanged;
  if (Message.FocusedWnd <> Grid.Handle) and Grid.FInTitleFilterListboxVisible then
    Grid.InTitleFilterListboxCloseUp(False);
end;

procedure TDBGridInplaceEdit.WMSetFocus(var Message: TWMSetFocus);
begin
//  if (Message.FocusedWnd <> Grid.Handle) then
//    Grid.ControlGetFocus;
  if Grid.FSelectionActive <> Grid.IsSelectionActive then
    Grid.SelectionActiveChanged;
  inherited;
end;

procedure TDBGridInplaceEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
end;

procedure TDBGridInplaceEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TDBGridInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
  {ButtonRect, }R: TRect;
begin
  GetCursorPos(P);
{  if Grid.UseRightToLeftAlignment
    then ButtonRect := Rect(0, 0, FButtonsWidth, Height)
    else ButtonRect := Rect(Width - FButtonsWidth, 0, Width, Height);
  if (FButtonsWidth > 0) and
    PtInRect(ButtonRect, ScreenToClient(P))
    then Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;}

  SendStructMessage(Handle, EM_GETRECT, 0, R);
  if PtInRect(Rect(R.Left, 0, R.Right, Height), ScreenToClient(P))
    then inherited
    else Windows.SetCursor(LoadCursor(0, idc_Arrow));
end;

procedure TDBGridInplaceEdit.WndProc(var Message: TMessage);
var
  AColumn: TColumnEh;
  ShiftState: TShiftState;
  ACharCode: Word;
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      begin
        if (EditStyle in [esPickList, esDataList, esDateCalendar, esAltCalendar]) or CanDropCalculator then
{$IFDEF CIL}
          with TWMKey.Create(Message) do
{$ELSE}
          with TWMKey(Message) do
{$ENDIF}
          begin
            ACharCode := CharCode;
            ShiftState := KeyDataToShiftState(KeyData);
            DoDropDownKeys(ACharCode, ShiftState);
            CharCode := ACharCode;
            AColumn := Grid.Columns[Grid.SelectedIndex];
            if (CharCode <> 0) and (Message.Msg = wm_Char) and
               (Char(CharCode) >= #32) and not FListVisible
              and AColumn.AutoDropDown then
            begin
            //AColumn.CanModify(True);
              DropDown;
            end;
            if (CharCode <> 0) and FListVisible then
            begin
              if (FActiveList = FPopupCalculator) and
                 ((CharCode in [8, 13, 27]) or ((CharCode >= 32) and (CharCode < 127))) then
              begin
                SendMessage(FActiveList.Handle, Msg, Message.WParam, Message.LParam);
                Exit;
              end else
                with TMessage(Message) do
                begin
                  if ((CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) and not (ssShift in ShiftState)) or
                    ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in ShiftState)) or
                    ((CharCode in [VK_LEFT, VK_RIGHT]) and (EditStyle in [esDateCalendar, esAltCalendar])) then
                  begin
                    SendMessage(FActiveList.Handle, Msg, WParam, LParam);
                    if (FEditStyle = esDataList) and (FDataList <> nil) then
                      Text := FDataList.SelectedItem
                    else if (FEditStyle = esPickList) then
                      if (FPickList.ItemIndex <> -1) and (Text <> FPickList.Items[FPickList.ItemIndex]) then
                        Text := FPickList.Items[FPickList.ItemIndex];
                    Exit;
                  end;
                end;
            end;
          end;

          if (MRUList <> nil) and MRUList.DroppedDown then
          begin
{$IFDEF CIL}
            with TWMKey.Create(Message) do
{$ELSE}
            with TWMKey(Message) do
{$ENDIF}
            begin
              if (Message.Msg = WM_KEYDOWN) and
                ((CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) and not (ssAlt in ShiftState))
                  or ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in ShiftState))
              then
              begin
                SendMessage(MRUListControl.Handle, Msg, Message.WParam, Message.LParam);
                Exit;
              end;
              if (Message.Msg = wm_Char) and (CharCode in [VK_RETURN, VK_ESCAPE]) then
              begin
                MRUListCloseUp(MRUList, CharCode = VK_RETURN);
                Exit;
              end;
            end;
          end;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TDBGridInplaceEdit.DefaultHandler(var Message);
var
  BlankText: String;
  Accept: Boolean;
  R: TRect;
  WinTMessage: TMessage;
begin
  WinTMessage := UnwrapMessageEh(Message);
  case WinTMessage.Msg of
    WM_LBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONUP,
      WM_MBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONUP,
      WM_RBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP:
    begin
{$IFDEF CIL}
      with TWMMouse.Create(WinTMessage) do
{$ELSE}
      with TWMMouse(Message) do
{$ENDIF}
        begin
          SendStructMessage(Handle, EM_GETRECT, 0, R);
          if {(FEditStyle <> esSimple) and}
            not PtInRect(Rect(R.Left, 0, R.Right, Height), Point(XPos, YPos)) and
            not MouseCapture
            then Exit;
        end;
    end;
  end;  
  inherited DefaultHandler(Message);

  if FUserTextChanged then
  begin
    Accept := False;
    FUserTextChanged := False;
    if IsMasked
      then BlankText := FormatMaskText(EditMask, '')
      else BlankText := '';
    if MRUList.DroppedDown and (Text = BlankText)then
      MRUListCloseUp(MRUList, Accept)
    else if MRUList.Active and Showing and not FDroppedDown and (Text <> BlankText) then
      MRUListDropDown(MRUList);
  end;
end;

procedure TDBGridInplaceEdit.DoDBCSKeyPress(var Key: Char);
var CharMsg: TMsg;
  DBC: Boolean;
begin
  FCharKeyStr := Key;
  DBC := False;
  if  CharInSetEh(Key, LeadBytes) then
    if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_NOREMOVE) then
      if CharMsg.Message <> WM_Quit then
      begin
        FCharKeyStr := FCharKeyStr + Char(CharMsg.wParam);
        DBC := True;
      end;
  DBCSKeyPress(FCharKeyStr);
  if (FCharKeyStr = '') then Key := #0;
  if DBC and (FCharKeyStr = '') then
    PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TDBGridInplaceEdit.DBCSKeyPress(var Key: String);
var
  AColumn: TColumnEh;
  CurPosition, Idx: Integer;
  FSearchText, AText: String;
  CanChange: Boolean;
  EditKeyValue: Variant;

  function IsSpecKey(Key: String): Boolean;
  begin
    Result := (Length(Key) = 1) and
     not ( (Key[1] = #8) or (Key[1] >= #32));
  end;

begin
  if IsSpecKey(Key) then Exit;
  with Grid do AColumn := Columns[SelectedIndex];
  if (EditStyle = esDataList) and Grid.CanEditModifyText and
    Grid.AllowedOperationUpdate and (AColumn.UsedLookupDataSet <> nil) then // lookup
  begin
    if Key = #8 then
    begin
      Key := '';
      Exit;
    end;
    CurPosition := SelStart;
    FSearchText := Copy(Text, 1, CurPosition) + Key;
    if AColumn.UsedLookupDataSet.Locate(AColumn.Field.LookupResultField, FSearchText,
      [loCaseInsensitive, loPartialKey]) then
    begin
      Key := '';
      AText := AColumn.UsedLookupDataSet.FieldByName(AColumn.Field.LookupResultField).Text;
      EditKeyValue := AColumn.UsedLookupDataSet.FieldValues[AColumn.Field.LookupKeyFields];
      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then
      begin
        Grid.Datalink.Modified;
        Text := AText;
        SelStart := Length(Text);
        SelLength := Length(FSearchText) - SelStart;

        Grid.FEditKeyValue := EditKeyValue;
        Grid.FEditText := Text;
        if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;
      end;
    end else if Assigned(AColumn.OnNotInList) then
    begin
      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then
      begin
        Grid.Datalink.Modified;
        Text := FSearchText;
        SelStart := Length(Text);
        SelLength := 0;

        Grid.FEditKeyValue := Null;
        Grid.FEditText := Text;
        if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;
      end;
    end;
    Key := '';
  end
  else if ((Column.GetColumnType = ctKeyPickList) or
    (EditStyle = esPickList)) and Grid.CanEditModifyText then // picklist or keypicklist
  begin
    if (Key = #8) and (Column.GetColumnType = ctKeyPickList) then
    begin
      Key := '';
      Exit;
    end;
    CurPosition := SelStart;
    FSearchText := Copy(Text, 1, CurPosition) + Key;
    AColumn := Grid.Columns[Grid.SelectedIndex];
    Idx := StringsLocate(AColumn.PickList, FSearchText, [loCaseInsensitive, loPartialKey]);
    if (Idx <> -1) then
    begin
      Key := '';
      AText := AColumn.PickList[Idx];

      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then Grid.Datalink.Modified;
      Text := AText;
      SelStart := Length(AText);
      SelLength := Length(FSearchText) - SelStart;

      Grid.FEditText := Text;
      if Assigned(FPickList) then FPickList.ItemIndex := Idx;
    end else if Assigned(AColumn.OnNotInList) and (Column.GetColumnType = ctKeyPickList) then
    begin
      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then
      begin
        Grid.Datalink.Modified;
        Text := FSearchText;
        SelStart := Length(Text);
        SelLength := 0;

        Grid.FEditKeyValue := Null;
        Grid.FEditText := Text;
        if Assigned(FPickList) then FPickList.ItemIndex := -1;
        //Key := '';
      end;
    end;
    if Column.GetColumnType = ctKeyPickList then Key := '';
  end;
end;

procedure TDBGridInplaceEdit.KeyPress(var Key: Char);
begin
  if Assigned(Column.Field) and (Column.Field is TNumericField) then
    if CharInSetEh(Key, ['.', ',']) then
      Key := Copy(DecimalSeparator, 1, 1)[1];
  DoDBCSKeyPress(Key);
  if (Key = #10) and not WordWrap and (GetShiftState = [ssCtrl])
    then Key := #0;
  inherited;
  if (Integer(Key) = VK_BACK) and MRUList.Active and Showing and
   not FDroppedDown and (Text = '')
  then
    MRUListDropDown(MRUList);
end;

procedure TDBGridInplaceEdit.WMPaste(var Message: TMessage);
var
  ClipboardText: String;
  AColumn: TColumnEh;
  Idx: Integer;
  FSearchText, AText: String;
  CanChange, TextLocated, CanTryEdit: Boolean;
  EditKeyValue: Variant;
  NewSelStart: Integer;
begin
  if Grid.AllowedOperationUpdate and Column.CanModify(False) then
    if ((EditStyle = esDataList) or (Column.GetColumnType = ctKeyPickList)) then
    begin
      if Clipboard.HasFormat(CF_TEXT)
        then ClipboardText := Clipboard.AsText
        else Exit;
      with Grid do AColumn := Columns[SelectedIndex];
      FSearchText := Copy(Text, 1, SelStart) + ClipboardText + Copy(Text, SelStart + SelLength + 1, MAXINT);
      CanTryEdit := False;
      TextLocated := False;
      AText := FSearchText;
      if (EditStyle = esDataList) and (AColumn.UsedLookupDataSet <> nil) then //lookup
      begin
        EditKeyValue := Null;
        if AColumn.UsedLookupDataSet.Locate(AColumn.Field.LookupResultField, FSearchText,
          [loCaseInsensitive, loPartialKey]) then
        begin
          AText := AColumn.UsedLookupDataSet.FieldByName(AColumn.Field.LookupResultField).Text;
          EditKeyValue := AColumn.UsedLookupDataSet.FieldValues[AColumn.Field.LookupKeyFields];
          TextLocated := True;
          CanTryEdit := True;
        end
        else if Assigned(AColumn.OnNotInList) then
          CanTryEdit := True;

        if CanTryEdit then
        begin
          Grid.DataLink.Edit;
          CanChange := Grid.Datalink.Editing;
          if CanChange then
          begin
            Grid.Datalink.Modified;
            Text := AText;
            SelStart := Length(Text);
            if TextLocated
              then SelLength := Length(FSearchText) - SelStart
              else SelLength := 0;
            Grid.FEditKeyValue := EditKeyValue;
            Grid.FEditText := Text;
            if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;
          end;
        end;
      end else //keypicklist
      begin
        Idx := StringsLocate(AColumn.PickList, FSearchText, [loCaseInsensitive, loPartialKey]);
        if (Idx <> -1) and Grid.CanEditModifyText then
        begin
          AText := AColumn.PickList[Idx];
          TextLocated := True;
          CanTryEdit := True;
        end
        else if Assigned(AColumn.OnNotInList) then
          CanTryEdit := True;

        if CanTryEdit then
        begin
          SelStart := Length(AText);
          if TextLocated
            then SelLength := Length(FSearchText) - SelStart
            else SelLength := 0;

          Grid.DataLink.Edit;
          CanChange := Grid.Datalink.Editing;
          if CanChange then Grid.Datalink.Modified;
          Text := AText;

          Grid.FEditText := Text;
          if Assigned(FPickList) then FPickList.ItemIndex := Idx;
        end;
      end;
    end else
    begin
      if EditCanModify and
          ( Clipboard.HasFormat(CF_TEXT) or
            Clipboard.HasFormat(CF_OEMTEXT) or
            Clipboard.HasFormat(CF_UNICODETEXT)
          )  then
      begin
        with Grid do AColumn := Columns[SelectedIndex];
        ClipboardText := Clipboard.AsText;
        AText := AColumn.GetAcceptableEditText(ClipboardText);
        FSearchText := Copy(Text, 1, SelStart) + AText + Copy(Text, SelStart + SelLength + 1, MAXINT);
        NewSelStart := Length(Copy(Text, 1, SelStart) + AText);
        Grid.DataLink.Edit;
        if Grid.Datalink.Editing then
        begin
          Grid.Datalink.Modified;
          Text := FSearchText;
          SelStart := NewSelStart;
          Grid.FEditText := Text;
          SendMessage(Handle, EM_SCROLLCARET, 0,0);
        end;
      end else
        inherited;
    end;
end;

procedure TDBGridInplaceEdit.SetWordWrap(const Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

function TDBGridInplaceEdit.GetGrid: TCustomDBGridEh;
begin
  Result := TCustomDBGridEh(inherited Grid);
end;

function TDBGridInplaceEdit.GetColumn: TColumnEh;
begin
  if (Grid <> nil) and (Grid.Columns <> nil) and
   (Grid.Columns.Count > 0) and (Grid.SelectedIndex < Grid.Columns.Count)
    then Result := Grid.Columns[Grid.SelectedIndex]
    else Result := nil;
end;

procedure TDBGridInplaceEdit.UpdateEditButtonControlList;
var NewEditButtonControlsCount, OldEditButtonControlsCount: Integer;
  i, Indent, MinButtonHeight, AButtonHeight: Integer;

  procedure ResetEditButtonControl(ControlRec: TEditButtonControlLineRec;
    Button: TEditButtonEh; Intex: Integer);
  begin
    ControlRec.EditButtonControl.Visible := Button.Visible;
    ControlRec.EditButtonControl.Enabled := Button.Enabled;
    ControlRec.EditButtonControl.Style := Button.Style;
    ControlRec.EditButtonControl.Glyph := Button.Glyph;
{$IFDEF EH_LIB_5}
    ControlRec.EditButtonControl.Glyph.FreeImage;
{$ENDIF}
    ControlRec.EditButtonControl.NumGlyphs := Button.NumGlyphs;
    ControlRec.EditButtonControl.Hint := Button.Hint;
    ControlRec.EditButtonControl.Flat := Grid.Flat;
    if not Button.Visible then
      ControlRec.EditButtonControl.Width := 0
    else if Button.Width > 0 then
      ControlRec.EditButtonControl.Width := Button.Width
    else if Grid.Flat then
      ControlRec.EditButtonControl.Width := FlatButtonWidth
    else
      ControlRec.EditButtonControl.Width := GetSystemMetrics(SM_CXVSCROLL);

    if Button.Visible then
    begin
      if ClientHeight > Round(ControlRec.EditButtonControl.Width * 3 / 2)
        then AButtonHeight := DefaultEditButtonHeight(ControlRec.EditButtonControl.Width, Grid.Flat)
        else AButtonHeight := ClientHeight;

      if AButtonHeight < MinButtonHeight then
        MinButtonHeight := AButtonHeight;
    end;

    ControlRec.ButtonLine.Visible := Grid.Flat and Button.Visible and not ThemesEnabled;
    if Grid.Flat and Button.Visible and not ThemesEnabled
      then ControlRec.ButtonLine.Width := 1
      else ControlRec.ButtonLine.Width := 0;

    ControlRec.EditButtonControl.OnDown := EditButtonDown;
    ControlRec.EditButtonControl.OnClick := EditButtonClick;
    ControlRec.EditButtonControl.OnMouseMove := EditButtonMouseMove;
    ControlRec.EditButtonControl.OnMouseUp := EditButtonMouseUp;
    ControlRec.EditButtonControl.Tag := Intex;
  end;

begin
  NewEditButtonControlsCount := Column.EditButtons.Count + 1;
  MinButtonHeight := MAXINT;
  if NewEditButtonControlsCount < Length(FEditButtonControlList) then
  begin
    for i := NewEditButtonControlsCount to Length(FEditButtonControlList) - 1 do
    begin
      FEditButtonControlList[i].EditButtonControl.Visible := False;
      FEditButtonControlList[i].ButtonLine.Visible := False;
    end;
    SetLength(FEditButtonControlList, NewEditButtonControlsCount);
  end else
  begin
    OldEditButtonControlsCount := Length(FEditButtonControlList);
    SetLength(FEditButtonControlList, NewEditButtonControlsCount);
    for i := OldEditButtonControlsCount to NewEditButtonControlsCount - 1 do
    begin
      FEditButtonControlList[i].EditButtonControl := CreateEditButtonControl;
      FEditButtonControlList[i].EditButtonControl.Parent := Self;
      FEditButtonControlList[i].ButtonLine := TShape.Create(Self);
      FEditButtonControlList[i].ButtonLine.Parent := Self;
    end;
  end;

  //tmpResetEditButtonControl(FEditButtonControlList[0], EditButton);
  with FEditButtonControlList[0] do
  begin
    if EditStyle = esSimple then
      EditButtonControl.Visible := False
    else
    begin
      EditButtonControl.Visible := True;
      case EditStyle of
        esEllipsis: EditButtonControl.Style := ebsEllipsisEh;
        esPickList, esDataList, esDateCalendar, esDropDown:
          EditButtonControl.Style := ebsDropDownEh;
        esUpDown: EditButtonControl.Style := ebsUpDownEh;
        esAltDropDown: EditButtonControl.Style := ebsAltDropDownEh;
        esAltUpDown: EditButtonControl.Style := ebsAltUpDownEh;
        esAltCalendar: EditButtonControl.Style := ebsAltDropDownEh;
      end;
      EditButtonControl.Glyph := nil;
      EditButtonControl.Hint := '';
      EditButtonControl.Flat := Grid.Flat;
    end;

    if not EditButtonControl.Visible then
      EditButtonControl.Width := 0
    else if Grid.Flat then
      EditButtonControl.Width := FlatButtonWidth
    else
      EditButtonControl.Width := GetSystemMetrics(SM_CXVSCROLL);

    if EditButtonControl.Visible then
    begin
      if ClientHeight > Round(EditButtonControl.Width * 3 / 2)
        then AButtonHeight := DefaultEditButtonHeight(EditButtonControl.Width, Grid.Flat)
        else AButtonHeight := ClientHeight;

      if AButtonHeight < MinButtonHeight then
        MinButtonHeight := AButtonHeight;
    end;

    ButtonLine.Visible := Grid.Flat and EditButtonControl.Visible and not ThemesEnabled;

    if Grid.Flat and ButtonLine.Visible and not ThemesEnabled
      then ButtonLine.Width := 1
      else ButtonLine.Width := 0;

    EditButtonControl.OnDown := EditButtonDown;
    EditButtonControl.OnClick := EditButtonClick;
    EditButtonControl.OnMouseMove := EditButtonMouseMove;
    EditButtonControl.OnMouseUp := EditButtonMouseUp;
    EditButtonControl.Tag := 0;

  end;

  for i := 1 to Column.EditButtons.Count do
    ResetEditButtonControl(FEditButtonControlList[i], Column.EditButtons[i - 1], 0);

  if Column.UseRightToLeftAlignment
    then Indent := 0
    else Indent := {Client} Width;


  for i := Column.EditButtons.Count downto 0 do
    with FEditButtonControlList[i] do
    begin
      if Column.UseRightToLeftAlignment then
      begin
        EditButtonControl.SetBounds(Indent, 0,
          EditButtonControl.Width, MinButtonHeight);
        Inc(Indent, EditButtonControl.Width);
        ButtonLine.SetBounds(Indent, 0, ButtonLine.Width, MinButtonHeight);
        Inc(Indent, ButtonLine.Width);
      end else
      begin
        EditButtonControl.SetBounds(Indent - EditButtonControl.Width, 0,
          EditButtonControl.Width, MinButtonHeight);
        Dec(Indent, EditButtonControl.Width);
        ButtonLine.SetBounds(Indent - ButtonLine.Width, 0, ButtonLine.Width, MinButtonHeight);
        Dec(Indent, ButtonLine.Width);
      end;
    end;

  if Column.UseRightToLeftAlignment
    then FButtonsWidth := Indent
    else FButtonsWidth := ClientWidth - Indent;
end;

procedure TDBGridInplaceEdit.UpdateEditButtonControlsState;
var
  i: Integer;
begin
  if Length(FEditButtonControlList) = 0 then Exit;
  FEditButtonControlList[0].EditButtonControl.Enabled := True;
  FEditButtonControlList[0].EditButtonControl.Active := True;
  FEditButtonControlList[0].ButtonLine.Pen.Color := clBtnFace;

  for i := 1 to Length(FEditButtonControlList) - 1 {EditButtons.Count} do
    with FEditButtonControlList[i] do
    begin
      EditButtonControl.Enabled := True;
      EditButtonControl.Active := True;
      ButtonLine.Pen.Color := clBtnFace;
    end;
end;

function TDBGridInplaceEdit.CreateEditButtonControl: TEditButtonControlEh;
begin
  Result := TEditButtonControlEh.Create(Self);
  with Result do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := 10;
    Height := 17;
    Visible := True;
    Transparent := False;
    Parent := Self;
  end;
end;

procedure TDBGridInplaceEdit.EditButtonClick(Sender: TObject);
var
  Handled: Boolean;
  i: Integer;
begin
  Handled := False;
  if (FEditStyle in [esEllipsis, esDropDown, esAltDropDown]) and
    (Sender = FEditButtonControlList[0].EditButtonControl)
    then Grid.EditButtonClick;
  if (Sender = FEditButtonControlList[0].EditButtonControl) and
    Assigned(Column.OnEditButtonClick)
    then Column.OnEditButtonClick(Sender, Handled)
  else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(FEditButtonControlList) - 1 do
      if (Sender = FEditButtonControlList[i].EditButtonControl) then
      begin
        Column.EditButtons[i - 1].Click(Sender, Handled);
//        Column.EditButtons[i - 1].OnClick(Sender, Handled);
      end;
  if not Handled and FDroppedDown and not FNoClickCloseUp and
    (Sender = FEditButtonControlList[0].EditButtonControl)
    then CloseUp(False);
  FNoClickCloseUp := False;
end;

procedure TDBGridInplaceEdit.EditButtonDown(Sender: TObject;
  TopButton: Boolean; var AutoRepeat, Handled: Boolean);
var
  i: Integer;
  p: TPoint;
begin
  SetFocus;
  Handled := False;
{  if PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_NOREMOVE) then
//    if Msg.wParam = Integer(Sender) then
    if Msg.wParam = Integer(TEditButtonControlEh(Sender).Tag) then
    begin
      PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_REMOVE);
      Exit;
    end;}
  if (Sender = FEditButtonControlList[0].EditButtonControl) then
  begin
    if Assigned(Column.OnEditButtonDown) then
      Column.OnEditButtonDown(Sender, TopButton, AutoRepeat, Handled);
    if not Handled then
      ButtonDown(not TopButton);
  end
  else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(FEditButtonControlList) - 1 do
      if (Sender = FEditButtonControlList[i].EditButtonControl) then
      begin
        if Assigned(Column.EditButtons[i - 1].OnDown) then
          Column.EditButtons[i - 1].OnDown(Sender, TopButton, AutoRepeat, Handled);
        if not Handled then
          if Assigned(Column.EditButtons[i - 1].DropdownMenu) then
          begin
            P := TControl(Sender).ClientToScreen(Point(0, TControl(Sender).Height));
            if Column.EditButtons[i - 1].DropdownMenu.Alignment = paRight then
              Inc(P.X, TControl(Sender).Width);
            Column.EditButtons[i - 1].DropdownMenu.Popup(p.X, p.y);
//            PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(Sender), 0);
//            PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(TEditButtonControlEh(Sender).Tag), 0);
            KillMouseUp(TControl(Sender));
            TControl(Sender).Perform(WM_LBUTTONUP, 0, 0);
          end;
      end;
end;

procedure TDBGridInplaceEdit.EditButtonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender = FEditButtonControlList[0].EditButtonControl then
    TraceMouseMoveForPopupListbox(Sender, Shift, X, Y);
end;

function TDBGridInplaceEdit.TraceMouseMoveForPopupListbox(Sender: TObject;
  Shift: TShiftState; X, Y: Integer): Boolean;
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
  IsPtInRect: Boolean;
begin
  Result := False;
  if FListVisible and (GetCaptureControl = Sender) then
  begin
    ListPos := FActiveList.ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y)));
    if FActiveList = FDataList
      then IsPtInRect := PtInRect(FDataList.DataRect, ListPos)
      else IsPtInRect := PtInRect(FActiveList.ClientRect, ListPos);
    if IsPtInRect then
    begin
      TControl(Sender).Perform(WM_CANCELMODE, 0, 0);
      MousePos := PointToSmallPoint(ListPos);
      SendStructMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, MousePos);
      Result := True;
    end;
  end;
end;

procedure TDBGridInplaceEdit.EditButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  DoClick := (X >= 0) and (X < TControl(Sender).ClientWidth) and
    (Y >= 0) and (Y <= TControl(Sender).ClientHeight);
  if not DoClick then
    FNoClickCloseUp := False;
end;

procedure TDBGridInplaceEdit.ButtonDown(IsDownButton: Boolean);
begin
  if EditStyle in [esUpDown, esAltUpDown]  then
    if IsDownButton
      then UpDownClick(nil, btPrev)
      else UpDownClick(nil, btNext)
  else
  begin
    if not FDroppedDown then
    begin
      DropDown;
      FNoClickCloseUp := True;
    end;
  end;
end;

function TDBGridInplaceEdit.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if FListVisible
    then Result := True
    else Result := inherited DoMouseWheelDown(Shift, MousePos);
end;

function TDBGridInplaceEdit.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if FListVisible
    then Result := True
    else Result := inherited DoMouseWheelUp(Shift, MousePos);
end;

procedure TDBGridInplaceEdit.ListColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  FListColumnMothed := True;
end;

function TDBGridInplaceEdit.GetEditButtonByShortCut(ShortCut: TShortCut): TEditButtonEh;
var
  i: Integer;
begin
  Result := nil;
  if Column <> nil then
    for i := 0 to Column.EditButtons.Count - 1 do
      if (ShortCut = Column.EditButtons[i].ShortCut) then
      begin
        Result := Column.EditButtons[i];
        Exit;
      end;
end;

function TDBGridInplaceEdit.CreateMRUListControl: TWinControl;
begin
  Result := TMRUListboxEh.Create(Self);
  Result.Visible := False;
  TMRUListboxEh(Result).Ctl3D := False;
  TMRUListboxEh(Result).ParentCtl3D := False;
  TMRUListboxEh(Result).Sorted := True;
  Result.Parent := Self; // Already set parent in TPopupListboxEh.CreateWnd
  TMRUListboxEh(Result).OnMouseUp := MRUListControlMouseUp;
end;

procedure TDBGridInplaceEdit.FilterMRUItem(AText: String; var Accept: Boolean);
begin
  if MRUList.CaseSensitive
    then Accept := (NlsCompareStr(Copy(AText, 1, Length(Text)), Text) = 0)
    else Accept := (NlsCompareText(Copy(AText, 1, Length(Text)), Text) = 0);
  if Assigned(MRUList.OnFilterItem) then
    MRUList.OnFilterItem(Column, Accept);
end;

function TDBGridInplaceEdit.GetMRUListControl: TWinControl;
begin
  if not Assigned(FMRUListControl) then
    FMRUListControl := CreateMRUListControl;
  Result := FMRUListControl;
end;

procedure TDBGridInplaceEdit.MRUListCloseUp(Sender: TObject; Accept: Boolean);
begin
  if MRUList.DroppedDown then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(MRUListControl.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    MRUListControl.Visible := False;
{    if TPopupListboxEh(MRUListControl).SizeGripResized then
    begin
      MRUList.Rows := TPopupListboxEh(MRUListControl).RowCount;
      MRUList.Width := TPopupListboxEh(MRUListControl).Width;
    end;}
    if (GetFocus = MRUListControl.Handle) then
      SetFocus;
    MRUList.DroppedDown := False;
    if Accept and not ReadOnly and Grid.DataLink.Edit then
    begin
      with TPopupListboxEh(MRUListControl) do
       if ItemIndex >= 0 then
       begin
         Self.Text := Items[ItemIndex];
         Grid.FEditText := Self.Text;
       end;
      if Focused then SelectAll;
      //////Modified := True;
    end;
  end;
end;

procedure TDBGridInplaceEdit.MRUListControlResized(Sender: TObject);
begin
  if MRUList.DroppedDown then
  begin
    MRUList.Rows := TPopupListboxEh(MRUListControl).RowCount;
    MRUList.Width := TPopupListboxEh(MRUListControl).Width;
  end;
end;

procedure TDBGridInplaceEdit.MRUListControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    MRUListCloseUp(MRUList, PtInRect(MRUListControl.ClientRect, Point(X, Y)));
end;

procedure TDBGridInplaceEdit.MRUListDropDown(Sender: TObject);
{  procedure FilterMRUItems(ss: TStrings; ds: TStrings);
  var
    i: Integer;
    Accept: Boolean;
  begin
    ds.BeginUpdate;
    try
      ds.Clear;
      for i := 0 to ss.Count-1 do
      begin
        Accept := False;
        FilterMRUItem(ss[i], Accept);
        if Accept then ds.Add(ss[i]);
      end;
    finally
      ds.EndUpdate;
    end;
  end;
}
var
  P: TPoint;
  OldSizeGripResized: Boolean;
  EditRect: TRect;
  Accept: Boolean;
begin
  with TPopupListboxEh(MRUListControl) do
  begin
    OldSizeGripResized := TPopupListboxEh(MRUListControl).SizeGripResized;
//    FilterMRUItems(MRUList.Items, Items);
    if not MRUList.FilterItemsTo(Items, Text) then
      MRUList.CloseUp(False);
    if Items.Count < MRUList.Rows
      then RowCount := Items.Count
      else RowCount := MRUList.Rows;
    if MRUList.DroppedDown then
    begin
      SendStructMessage(Self.Handle, EM_GETRECT, 0, EditRect);
      EditRect.TopLeft := Self.ClientToScreen(EditRect.TopLeft);
      EditRect.BottomRight := Self.ClientToScreen(EditRect.BottomRight);
      P := AlignDropDownWindowRect(EditRect, MRUListControl, daLeft);
      SetWindowPos(MRUListControl.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      TPopupListboxEh(MRUListControl).SizeGripResized := OldSizeGripResized;
    end;
    if (Items.Count <= 0) and MRUList.DroppedDown then
    begin
      Accept := False;
      MRUListCloseUp(MRUList, Accept);
    end
    else if not MRUList.DroppedDown and (Items.Count > 0) then
    begin
      Color := Self.Color;
      Font := Self.Font;
      ItemHeight := GetTextHeight;
      ItemIndex := -1;
      //if (Width < Self.Width) then Width := Self.Width;
      if Items.Count < RowCount then RowCount := Items.Count;
      SendStructMessage(Self.Handle, EM_GETRECT, 0, EditRect);
      EditRect.TopLeft := Self.ClientToScreen(EditRect.TopLeft);
      EditRect.BottomRight := Self.ClientToScreen(EditRect.BottomRight);
      if (MRUList.Width > 0) and (MRUList.Width > EditRect.Right-EditRect.Left)
        then Width := MRUList.Width
        else Width := EditRect.Right-EditRect.Left;
      P := AlignDropDownWindowRect(EditRect, MRUListControl, daLeft);
      SetWindowPos(MRUListControl.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      MRUListControl.Visible := True; //commment for Tab key
      TPopupListboxEh(MRUListControl).SizeGrip.Visible := True;
      TMRUListboxEh(MRUListControl).ScrollBar.Visible := True;
      MRUList.DroppedDown := True;
      TPopupListboxEh(MRUListControl).SizeGripResized := False;
      TPopupListboxEh(MRUListControl).SizeGrip.OnParentResized := MRUListControlResized;
    end;
  end;
end;

procedure TDBGridInplaceEdit.UserChange;
begin
  FUserTextChanged := True;
  UpdateImageIndex;
end;

procedure TDBGridInplaceEdit.UpdateImageIndex;
var
  NewImageIndex: Integer;
begin
  NewImageIndex := FImageIndex;
  if Assigned(Column) and Assigned(Column.ImageList) then
  begin
    if Column.PickList.Count > 0 then
      NewImageIndex := Column.PickList.IndexOf(EditText)
    else if Assigned(Column.Field) and IsFieldTypeNumeric(Column.Field.DataType) then
      NewImageIndex := SafeGetFieldAsInteger(Column.Field, -1);
    if NewImageIndex = -1 then
      NewImageIndex := Column.NotInKeyListIndex;
  end;
  if NewImageIndex <> FImageIndex then
  begin
    FImageIndex := NewImageIndex;
    Invalidate;
  end;
end;

function TDBGridInplaceEdit.GetPopupCalculator: TWinControl;
begin
  if FPopupCalculator = nil then
  begin
    FPopupCalculator := TPopupCalculatorEh.Create(Self);
    FPopupCalculator.Visible := False;
    FPopupCalculator.Parent := Self;
    if HandleAllocated then
      FPopupCalculator.HandleNeeded;
//    TPopupCalculatorEh(FDropDownCalculator). := False;
  end;
  Result := FPopupCalculator;
end;

function TDBGridInplaceEdit.CanDropCalculator: Boolean;
begin
  Result := (EditStyle in [esDropDown, esAltDropDown] ) and Assigned(Column)
    and Assigned(Column.Field) and (Column.Field is TNumericField);
end;

procedure TDBGridInplaceEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDataList) then
  begin
    FDataList := nil;
    if not (csDestroying in ComponentState) then
      EditStyle := esSimple;
  end;
end;

procedure TDBGridInplaceEdit.DrawEditImage(DC: HDC);

  function ImageRect: TRect;
  begin
    if (Grid.FIntMemTable <> nil) and (Column = Grid.VisibleColumns[0]) and
      Grid.FIntMemTable.MemTableIsTreeList
    then
      Result := Rect(Grid.GetCellTreeElmentsAreaWidth+2, 0,
        Grid.GetCellTreeElmentsAreaWidth+Column.ImageList.Width+2, Height)
    else
      Result := Rect(2, 0, Column.ImageList.Width+2, Height)
  end;

var
  ImRect: TRect;
begin
  with Column.ImageList do
  begin
    if not Visible or (Column.ImageList = nil) or (FImageIndex < 0) then Exit;
    ImRect := ImageRect;
//    InflateRect(ImRect, -2, -1);
    DrawImage(DC, ImRect, Column.ImageList, FImageIndex, False);
  end;
end;

procedure TDBGridInplaceEdit.Invalidate;
begin
  if Grid.RowPanel.Active
    then  Perform(CM_INVALIDATE, 0, 0)
    else  inherited Invalidate;
end;

{ TGridDataLinkEh }

type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

constructor TGridDataLinkEh.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

destructor TGridDataLinkEh.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TGridDataLinkEh.GetDefaultFields: Boolean;
var
  I: Integer;
begin
  Result := True;
  if DataSet <> nil then Result := DataSet.DefaultFields;
  if Result and SparseMap then
    for I := 0 to FFieldCount - 1 do
      if FFieldMap[I] < 0 then
      begin
        Result := False;
        Exit;
      end;
end;

function TGridDataLinkEh.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (FFieldMap[I] >= 0)
    then Result := DataSet.Fields[FFieldMap[I]]
    else Result := nil;
end;

function TGridDataLinkEh.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  if FFieldCount >= MaxMapSize then RaiseGridError(STooManyColumns);
  if SparseMap
    then Field := DataSet.FindField(FieldName)
    else Field := DataSet.FieldByName(FieldName);

  if FFieldCount = FFieldMapSize then
  begin
    NewSize := FFieldMapSize;
    if NewSize = 0
      then NewSize := 8
      else Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    SetLength(FFieldMap, NewSize);
    FFieldMapSize := NewSize;
  end;
  if Assigned(Field) then
  begin
    FFieldMap[FFieldCount] := Field.Index;
{ TODO : Here is code because of which raise list out of bounds in RemoveNotification }
    Field.FreeNotification(FGrid);
  end else
    FFieldMap[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TGridDataLinkEh.ActiveChanged;
begin
  FGrid.LinkActive(Active);
  FModified := False;
  if Active then FLastBookmark := DataSet.Bookmark;
end;

{$IFDEF CIL}
procedure TGridDataLinkEh.DataEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
procedure TGridDataLinkEh.DataEvent(Event: TDataEvent; Info: Integer);
{$ENDIF}
begin
  inherited;
{$IFDEF EH_LIB_7}
  if Event = deDisabledStateChange then
    FGrid.Columns.ActiveChanged;
{$ENDIF}
end;

procedure TGridDataLinkEh.ClearMapping;
begin
  FFieldMap := nil;
  FFieldMapSize := 0;
  FFieldCount := 0;
end;

procedure TGridDataLinkEh.Modified;
begin
  FModified := True;
end;

procedure TGridDataLinkEh.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := False;
  if Active then FLastBookmark := DataSet.Bookmark;
end;

procedure TGridDataLinkEh.DataSetScrolled(Distance: Integer);
begin
  FGrid.Scroll(Distance);
  if Active then FLastBookmark := DataSet.Bookmark;
end;

procedure TGridDataLinkEh.LayoutChanged;
var
  SaveState: Boolean;
begin
  { FLayoutFromDataset determines whether default column width is forced to
    be at least wide enough for the column title.  }
  SaveState := FGrid.FLayoutFromDataset;
  FGrid.FLayoutFromDataset := True;
  try
    FGrid.LayoutChanged;
  finally
    FGrid.FLayoutFromDataset := SaveState;
  end;
  inherited LayoutChanged;
end;

{$IFDEF CIL}
procedure TGridDataLinkEh.FocusControl(const Field: TField);
begin
  if Assigned(Field) and Assigned(Field) then
  begin
    FGrid.SelectedField := Field;
    if (FGrid.SelectedField = Field) and FGrid.AcquireFocus then
    begin
      FGrid.ShowEditor;
    end;
  end;
end;
{$ELSE}
procedure TGridDataLinkEh.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
      FGrid.ShowEditor;
    end;
  end;
end;
{$ENDIF}

procedure TGridDataLinkEh.EditingChanged;
begin
  FGrid.EditingChanged;
end;

procedure TGridDataLinkEh.RecordChanged(Field: TField);
begin
  FGrid.RecordChanged(Field);
  FModified := False;
end;

procedure TGridDataLinkEh.UpdateData;
begin
  if FInUpdateData then Exit;
  FInUpdateData := True;
  try
    if FModified then FGrid.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

function TGridDataLinkEh.GetMappedIndex(ColIndex: Integer): Integer;
begin
  if (0 <= ColIndex) and (ColIndex < FFieldCount)
    then Result := FFieldMap[ColIndex]
    else Result := -1;
end;

procedure TGridDataLinkEh.Reset;
begin
  if FModified then RecordChanged(nil) else Dataset.Cancel;
end;

function TGridDataLinkEh.MoveBy(Distance: Integer): Integer;
begin
{  if Active and
    FGrid.ViewScroll and
    (Abs(Distance) > 1) and
    (Dataset.State = dsBrowse) and
    (Dataset.RecNo + Distance >= 1) and
    (Dataset.RecNo + Distance <= Dataset.RecordCount)
  then
  begin
    // DataSet.XxxScroll event does not raise here
    Dataset.RecNo := Dataset.RecNo + Distance;
    Result := Distance;
  end else}
    Result := inherited MoveBy(Distance);
end;

{ TColumnTitleEh }
constructor TColumnTitleEh.Create(Column: TColumnEh);
begin
  inherited Create;
  FColumn := Column;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FTitleButton := False;
  SortMarker := smNoneEh;
  ImageIndex := -1;
end;

destructor TColumnTitleEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TColumnTitleEh.Assign(Source: TPersistent);
begin
  if Source is TColumnTitleEh then
  begin
    if cvTitleAlignment in TColumnTitleEh(Source).FColumn.FAssignedValues then
      Alignment := TColumnTitleEh(Source).Alignment;
    if cvTitleColor in TColumnTitleEh(Source).FColumn.FAssignedValues then
      Color := TColumnTitleEh(Source).Color;
    if cvTitleCaption in TColumnTitleEh(Source).FColumn.FAssignedValues then
      Caption := TColumnTitleEh(Source).Caption;
    if cvTitleFont in TColumnTitleEh(Source).FColumn.FAssignedValues then
      Font := TColumnTitleEh(Source).Font;
    Hint := TColumnTitleEh(Source).Hint;
    ImageIndex := TColumnTitleEh(Source).ImageIndex;
    Orientation := TColumnTitleEh(Source).Orientation;
    SortIndex := TColumnTitleEh(Source).SortIndex;
    SortMarker := TColumnTitleEh(Source).SortMarker;
    TitleButton := TColumnTitleEh(Source).TitleButton;
    EndEllipsis := TColumnTitleEh(Source).EndEllipsis;
    ToolTips := TColumnTitleEh(Source).ToolTips;
  end else
    inherited Assign(Source);
end;

function TColumnTitleEh.DefaultAlignment: TAlignment;
begin
  if FColumn.GetGrid <> nil
    then Result := FColumn.GetGrid.ColumnDefValues.Title.Alignment
    else Result := taLeftJustify;
end;

function TColumnTitleEh.DefaultColor: TColor;
var
  Grid: TCustomDBGridEh;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid)
    then Result := Grid.ColumnDefValues.Title.Color
    else Result := clBtnFace;
end;

function TColumnTitleEh.DefaultFont: TFont;
var
  Grid: TCustomDBGridEh;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid)
    then Result := Grid.TitleFont
    else Result := FColumn.Font;
end;

function TColumnTitleEh.DefaultCaption: string;
var
  Field: TField;
begin
  Field := FColumn.Field;
  if Assigned(Field)
    then Result := Field.DisplayName
    else Result := FColumn.FieldName;
end;

procedure TColumnTitleEh.FontChanged(Sender: TObject);
begin
  Include(FColumn.FAssignedValues, cvTitleFont);
  FColumn.Changed(True);
end;

function TColumnTitleEh.GetAlignment: TAlignment;
begin
  if cvTitleAlignment in FColumn.FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TColumnTitleEh.GetColor: TColor;
begin
  if cvTitleColor in FColumn.FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TColumnTitleEh.GetCaption: string;
begin
  if cvTitleCaption in FColumn.FAssignedValues
    then Result := FCaption
    else Result := DefaultCaption;
end;

function TColumnTitleEh.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvTitleFont in FColumn.FAssignedValues) then
  begin
    Def := DefaultFont;
    if (FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color) then
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TColumnTitleEh.IsAlignmentStored: Boolean;
begin
  Result := (cvTitleAlignment in FColumn.FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TColumnTitleEh.IsColorStored: Boolean;
begin
  Result := (cvTitleColor in FColumn.FAssignedValues) and (FColor <> DefaultColor);
end;

function TColumnTitleEh.IsFontStored: Boolean;
begin
  Result := (cvTitleFont in FColumn.FAssignedValues);
end;

function TColumnTitleEh.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in FColumn.FAssignedValues) and (FCaption <> DefaultCaption);
end;

procedure TColumnTitleEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvTitleFont in FColumn.FAssignedValues) then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnTitleEh.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvTitleFont in FColumn.FAssignedValues;
  FColumn.FAssignedValues := FColumn.FAssignedValues - ColumnEhTitleValues;
  FCaption := '';
  RefreshDefaultFont;
  { If font was assigned, changing it back to default may affect grid title
    height, and title height changes require layout and redraw of the grid. }
  FColumn.Changed(FontAssigned);
end;

procedure TColumnTitleEh.SetAlignment(Value: TAlignment);
begin
  if (cvTitleAlignment in FColumn.FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FColumn.FAssignedValues, cvTitleAlignment);
  FColumn.Changed(False);
end;

procedure TColumnTitleEh.SetColor(Value: TColor);
begin
  if (cvTitleColor in FColumn.FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FColumn.FAssignedValues, cvTitleColor);
  FColumn.Changed(False);
end;

procedure TColumnTitleEh.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TColumnTitleEh.SetCaption(const Value: string);
var
  Grid: TCustomDBGridEh;
begin
  if not Column.SeenPassthrough then
  begin
    if (cvTitleCaption in FColumn.FAssignedValues) and (Value = FCaption) then Exit;
    FCaption := Value;
    Include(Column.FAssignedValues, cvTitleCaption);
    Column.Changed(False);
  end else
  begin
    Grid := Column.GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Column.Field) then
      Column.Field.DisplayLabel := Value;
  end;
end;


procedure TColumnTitleEh.SetTitleButton(Value: Boolean);
begin
  if (cvTitleButton in FColumn.FAssignedValues) and (Value = FTitleButton) then Exit;
  FTitleButton := Value;
  Include(FColumn.FAssignedValues, cvTitleButton);
  FColumn.Changed(False);
end;

procedure TColumnTitleEh.SetEndEllipsis(const Value: Boolean);
begin
  if (cvTitleEndEllipsis in FColumn.FAssignedValues) and (Value = FEndEllipsis) then Exit;
  FEndEllipsis := Value;
  Include(FColumn.FAssignedValues, cvTitleEndEllipsis);
  FColumn.Changed(False);
end;

procedure TColumnTitleEh.SetSortMarker(Value: TSortMarkerEh);
var AColumns: TDBGridColumnsEh;
  i, ASortIndex: Integer;
  Grid: TCustomDBGridEh;
begin
  if (Value = FSortMarker) then Exit;
  FSortMarker := Value;
  Grid := FColumn.GetGrid;
//  if Assigned(Grid) and (csLoading in Grid.ComponentState) then Exit;
  if (Column.Collection <> nil) and (TDBGridColumnsEh(Column.Collection).UpdateCount > 0) then Exit;
  AColumns := TDBGridColumnsEh(FColumn.Collection);
  if not (dghMultiSortMarking in Grid.OptionsEh) then
  begin
    if FSortMarker = smNoneEh then
    begin
      FSortIndex := 0;
      Grid.FSortMarkedColumns.Clear;
    end else
    begin
      for i := 0 to AColumns.Count - 1 do
        if (AColumns[i].Title.SortMarker <> smNoneEh) and (AColumns[i] <> FColumn)
          then AColumns[i].Title.SortMarker := smNoneEh;
      FSortIndex := 1;
      Grid.FSortMarkedColumns.Clear;
      Grid.FSortMarkedColumns.Add(FColumn);
    end;
  end else if (FSortMarker <> smNoneEh) and (SortIndex = 0) then
  begin
    ASortIndex := 1;
    for i := 0 to AColumns.Count - 1 do
      if AColumns[i].Title.SortIndex <> 0 then Inc(ASortIndex);
    FSortIndex := ASortIndex;
    Grid.FSortMarkedColumns.Add(FColumn);
  end else if (FSortMarker = smNoneEh) and (SortIndex <> 0) then
  begin
    for i := 0 to AColumns.Count - 1 do
      if AColumns[i].Title.SortIndex > SortIndex then Dec(AColumns[i].Title.FSortIndex);
    Grid.FSortMarkedColumns.Remove(FColumn);
    FSortIndex := 0;
  end;
  FColumn.Changed(False);
end;

procedure TColumnTitleEh.SetSortIndex(Value: Integer);
var AColumns: TDBGridColumnsEh;
  i: Integer;
begin
  if (Value < 0) then Value := 0;
  if Value = FSortIndex then Exit;
//  if (FColumn.GetGrid <> nil) and (csLoading in FColumn.GetGrid.ComponentState) then
  if (FColumn.Collection <> nil) and (TDBGridColumnsEh(FColumn.Collection).UpdateCount > 0) then
  begin
    FSortIndex := Value;
    Exit;
  end;
  if SortMarker = smNoneEh then Exit;
  AColumns := TDBGridColumnsEh(FColumn.Collection);
  for i := 0 to AColumns.Count - 1 do
  begin
    if (AColumns[i].Title.SortIndex <> 0) and
      (AColumns[i].Title.SortIndex = Value) and (AColumns[i] <> FColumn) then
    begin
      AColumns[i].Title.FSortIndex := FSortIndex;
      FSortIndex := Value;
      with FColumn.GetGrid.FSortMarkedColumns do
        Exchange(IndexOf(AColumns[i]), IndexOf(FColumn));
      FColumn.Changed(False);
      Exit;
    end;
  end;
end;

procedure TColumnTitleEh.SetNextSortMarkerValue(KeepMulti: Boolean);
var
  Grid: TCustomDBGridEh;
  i: Integer;
begin
  if not KeepMulti then
  begin
    Grid := FColumn.GetGrid;
    for i := 0 to Grid.Columns.Count - 1 do
      if (Grid.Columns[i].Title.SortMarker <> smNoneEh) and (Grid.Columns[i] <> FColumn)
        then Grid.Columns[i].Title.SortMarker := smNoneEh;
  end;
  case SortMarker of
    smNoneEh: SortMarker := smDownEh;
    smDownEh: SortMarker := smUpEh;
    smUpEh: if KeepMulti then SortMarker := smNoneEh else SortMarker := smDownEh;
  end;
end;

procedure TColumnTitleEh.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if FColumn.GetGrid <> nil then
    FColumn.GetGrid.LayoutChanged;
end;

function TColumnTitleEh.GetToolTips: Boolean;
begin
  if cvTitleToolTips in FColumn.FAssignedValues
    then Result := FToolTips
    else Result := DefaultToolTips;
end;

procedure TColumnTitleEh.SetToolTips(const Value: Boolean);
begin
  if (cvTitleToolTips in FColumn.FAssignedValues) and (Value = FToolTips) then Exit;
  FToolTips := Value;
  Include(FColumn.FAssignedValues, cvTitleToolTips);
end;

function TColumnTitleEh.GetSortMarkingWidth: Integer;
var
  SMTMarg: Integer;
  Canvas: TCanvas;
begin
  Result := 0;
  if SortIndex <> 0 then
  begin
    Inc(Result, 16);
    Canvas := FColumn.GetGrid.Canvas;
    if (FColumn.GetGrid.SortMarkedColumns.Count > 1) then
    begin
      Canvas.Font := SortMarkerFont;
      SMTMarg := Canvas.TextWidth(IntToStr(SortIndex));
      Inc(Result, SMTMarg);
    end else
      SMTMarg := 0;
    if FColumn.Width - 4 < Result then
      Dec(Result, 14);
    if FColumn.Width - 4 < Result then
      Dec(Result, 2 + SMTMarg);
  end;
end;

function TColumnTitleEh.GetFilterButtonAreaWidth: Integer;
begin
  Result := 0;
  if FColumn.GetGrid.STFilter.Visible and
    (FColumn.GetGrid.STFilter.Location = stflInTitleFilterEh) then
  begin
    if FColumn.GetGrid.Flat then
    begin
      Result := FlatButtonWidth;
      if not ThemesEnabled then
        Inc(Result);
    end else
      Result := GetSystemMetrics(SM_CXVSCROLL);
  end;
end;

procedure TColumnTitleEh.SetOrientation(const Value: TTextOrientationEh);
begin
  if (cvTitleOrientation in FColumn.FAssignedValues) and (Value = FOrientation) then Exit;
  FOrientation := Value;
  Include(FColumn.FAssignedValues, cvTitleOrientation);
  FColumn.Changed(False);
end;

function TColumnTitleEh.GetTitleButton: Boolean;
begin
  if cvTitleButton in FColumn.FAssignedValues
    then Result := FTitleButton
    else Result := DefaultTitleButton;
end;

function TColumnTitleEh.IsTitleButtonStored: Boolean;
begin
  Result := (cvTitleButton in FColumn.FAssignedValues) and (FTitleButton <> DefaultTitleButton);
end;

function TColumnTitleEh.DefaultTitleButton: Boolean;
begin
  if FColumn.GetGrid <> nil
    then Result := FColumn.GetGrid.ColumnDefValues.Title.TitleButton
    else Result := False;
end;

function TColumnTitleEh.GetEndEllipsis: Boolean;
begin
  if cvTitleEndEllipsis in FColumn.FAssignedValues
    then Result := FEndEllipsis
    else Result := DefaultEndEllipsis;
end;

function TColumnTitleEh.IsEndEllipsisStored: Boolean;
begin
  Result := (cvTitleEndEllipsis in FColumn.FAssignedValues) and (FEndEllipsis <> DefaultEndEllipsis);
end;

function TColumnTitleEh.DefaultEndEllipsis: Boolean;
begin
  if FColumn.GetGrid <> nil
    then Result := FColumn.GetGrid.ColumnDefValues.Title.EndEllipsis
    else Result := False;
end;

function TColumnTitleEh.DefaultToolTips: Boolean;
begin
  if FColumn.GetGrid <> nil
    then Result := FColumn.GetGrid.ColumnDefValues.Title.ToolTips
    else Result := False;
end;

function TColumnTitleEh.IsToolTipsStored: Boolean;
begin
  Result := (cvTitleToolTips in FColumn.FAssignedValues) and (FToolTips <> DefaultToolTips);
end;

function TColumnTitleEh.DefaultOrientation: TTextOrientationEh;
begin
  if FColumn.GetGrid <> nil
    then Result := FColumn.GetGrid.ColumnDefValues.Title.Orientation
    else Result := tohHorizontal;
end;

function TColumnTitleEh.GetOrientation: TTextOrientationEh;
begin
  if cvTitleOrientation in FColumn.FAssignedValues
    then Result := FOrientation
    else Result := DefaultOrientation;
end;

function TColumnTitleEh.IsOrientationStored: Boolean;
begin
  Result := (cvTitleOrientation in FColumn.FAssignedValues) and (FOrientation <> DefaultOrientation);
end;

{ TColumnEh }

constructor TColumnEh.Create(Collection: TCollection);
var
  Grid: TCustomDBGridEh;
begin
  Grid := nil;
  if Assigned(Collection) and (Collection is TDBGridColumnsEh) then
    Grid := TDBGridColumnsEh(Collection).Grid;
  if Assigned(Grid) then
    Grid.BeginLayout;
  try
    inherited Create(Collection);
    FDropDownRows := 7;
    FButtonStyle := cbsAuto;
    FFont := TFont.Create;
    FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
    FImeMode := imDontCare;
    FImeName := Screen.DefaultIme;
    FTitle := CreateTitle;
    FFooter := CreateFooter;
    FFooters := CreateFooters;
    FAutoFitColWidth := True;
    FInitWidth := Width;
    FVisible := True;
    FNotInKeyListIndex := -1;
    FIncrement := 1.0;
    FStored := True;
    FEditButtons := CreateEditButtons;
    FEditButtons.OnChanged := EditButtonChanged;
    FDropDownSpecRow := TSpecRowEh.Create(Self);
    FDropDownSpecRow.OnChanged := SpecRowChanged;
    FDropDownBox := TColumnDropDownBoxEh.Create(Self);
    FMRUList := TMRUListEh.Create(Self);
    FSTFilter := CreateSTFilter;
    FImageChangeLink := TChangeLink.Create;
    FImageChangeLink.OnChange := ImageListChange;
    FShowImageAndText := False;
  finally
    if Assigned(Grid) then
      Grid.EndLayout;
  end;
end;

destructor TColumnEh.Destroy;
var
//  Designer: IDesignerNotify;
  Form: TCustomForm;
  AGrid: TCustomDBGridEh;
begin
  if (Grid <> nil) then
    Grid.SortMarkedColumns.Remove(Self);
  if Assigned(Collection) and
     (Collection is TDBGridColumnsEh) and
     (TDBGridColumnsEh(Collection).FUpDownBaseColumn = Self)
  then
    TDBGridColumnsEh(Collection).FUpDownBaseColumn := nil;
  if (Grid <> nil) and Grid.FilterEditMode and
     (TInplaceFilterEditEh(Grid.FilterEdit).Column = Self)
  then
    Grid.StopEditFilter;

  AGrid := Grid;
  Collection := nil;
  FreeAndNil(FDropDownSpecRow);
  FreeAndNil(FTitle);
  FreeAndNil(FFont);
  FreeAndNil(FPickList);
  FreeAndNil(FFooter);
{  Designer := FindRootDesigner(Self);
  if Designer <> nil then Designer.Notification(FFooters,opRemove);}
  Form := nil;
  if AGrid <> nil then
    Form := GetParentForm(AGrid);
  if (Form <> nil) and (Form.Designer <> nil)
    then Form.Designer.Notification(TPersistent(FFooters), opRemove);

  FreeAndNil(FFooters);
  FreeAndNil(FKeyList);
  FreeAndNil(FEditButtons);
  FreeAndNil(FDataList);
  FreeAndNil(FDropDownBox);
  FreeAndNil(FDTListSource);
  FreeAndNil(FMRUList);
  FreeAndNil(FSTFilter);
  FreeAndNil(FImageChangeLink);
  inherited Destroy;
end;

procedure TColumnEh.Assign(Source: TPersistent);
begin
  if Source is TColumnEh then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := TColumnEh(Source).FieldName;
      if cvColor in TColumnEh(Source).AssignedValues then
        Color := TColumnEh(Source).Color;
      if cvWidth in TColumnEh(Source).AssignedValues then
        Width := TColumnEh(Source).Width;
      if cvFont in TColumnEh(Source).AssignedValues then
        Font := TColumnEh(Source).Font;
      if cvImeMode in TColumnEh(Source).AssignedValues then
        ImeMode := TColumnEh(Source).ImeMode;
      if cvImeName in TColumnEh(Source).AssignedValues then
        ImeName := TColumnEh(Source).ImeName;
      if cvAlignment in TColumnEh(Source).AssignedValues then
        Alignment := TColumnEh(Source).Alignment;
      if cvReadOnly in TColumnEh(Source).AssignedValues then
        ReadOnly := TColumnEh(Source).ReadOnly;
      Title := TColumnEh(Source).Title;
      DropDownRows := TColumnEh(Source).DropDownRows;
      ButtonStyle := TColumnEh(Source).ButtonStyle;
      PickList := TColumnEh(Source).PickList;
      PopupMenu := TColumnEh(Source).PopupMenu;
      FInitWidth := TColumnEh(Source).FInitWidth;
      AutoFitColWidth := TColumnEh(Source).AutoFitColWidth;
      if cvWordWrap in TColumnEh(Source).AssignedValues then
        WordWrap := TColumnEh(Source).WordWrap;
      EndEllipsis := TColumnEh(Source).EndEllipsis;
      DropDownWidth := TColumnEh(Source).DropDownWidth;
      if cvLookupDisplayFields in TColumnEh(Source).AssignedValues then
        LookupDisplayFields := TColumnEh(Source).LookupDisplayFields;
      AutoDropDown := TColumnEh(Source).AutoDropDown;
      AlwaysShowEditButton := TColumnEh(Source).AlwaysShowEditButton;
      WordWrap := TColumnEh(Source).WordWrap;
      Footer := TColumnEh(Source).Footer;
      KeyList := TColumnEh(Source).KeyList;
      if cvCheckboxes in TColumnEh(Source).AssignedValues then
        Checkboxes := TColumnEh(Source).Checkboxes;
      Increment := TColumnEh(Source).Increment;
      ToolTips := TColumnEh(Source).ToolTips;
      Footers := TColumnEh(Source).Footers;
      Tag := TColumnEh(Source).Tag;
      Visible := TColumnEh(Source).Visible;
      ImageList := TColumnEh(Source).ImageList;
      NotInKeyListIndex := TColumnEh(Source).NotInKeyListIndex;
      MinWidth := TColumnEh(Source).MinWidth;
      MaxWidth := TColumnEh(Source).MaxWidth;
      DblClickNextVal := TColumnEh(Source).DblClickNextVal;
      DropDownSizing := TColumnEh(Source).DropDownSizing;
      DropDownShowTitles := TColumnEh(Source).DropDownShowTitles;
      OnGetCellParams := TColumnEh(Source).OnGetCellParams;
      OnNotInList := TColumnEh(Source).OnNotInList;
      OnUpdateData := TColumnEh(Source).OnUpdateData;
      OnEditButtonClick := TColumnEh(Source).OnEditButtonClick;
      OnEditButtonDown := TColumnEh(Source).OnEditButtonDown;
      EditButtons := TColumnEh(Source).EditButtons;
      DropDownBox := TColumnEh(Source).DropDownBox;
      MRUList := TColumnEh(Source).MRUList;
      DisplayFormat := TColumnEh(Source).DisplayFormat;
      EditMask := TColumnEh(Source).EditMask;
      ShowImageAndText := TColumnEh(Source).ShowImageAndText;
      HideDuplicates := TColumnEh(Source).HideDuplicates;
      Layout := TColumnEh(Source).Layout;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else
    inherited Assign(Source);
end;

function TColumnEh.CreateTitle: TColumnTitleEh;
begin
  Result := TColumnTitleEh.Create(Self);
end;

function TColumnEh.DefaultAlignment: TAlignment;
begin
  if Assigned(Field)
    then Result := FField.Alignment
    else Result := taLeftJustify;
end;

function TColumnEh.DefaultColor: TColor;
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.Color
    else Result := clWindow;
end;

function TColumnEh.DefaultFont: TFont;
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.Font
    else Result := FFont;
end;

function TColumnEh.DefaultImeMode: TImeMode;
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.ImeMode
    else Result := FImeMode;
end;

function TColumnEh.DefaultImeName: TImeName;
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.ImeName
    else Result := FImeName;
end;

function TColumnEh.DefaultReadOnly: Boolean;
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetGrid;
  Result := (Assigned(Grid) and Grid.ReadOnly) or (Assigned(FField) and FField.ReadOnly);
end;

function TColumnEh.DefaultWidth: Integer;
var
  RestoreCanvas: Boolean;
  TM: TTextMetric;
begin
  if GetGrid = nil then
  begin
    Result := 64;
    Exit;
  end;
  with GetGrid do
  begin
    if Assigned(Field) then
    begin
      RestoreCanvas := not HandleAllocated and not FCanvasHandleAllocated; //not Canvas.HandleAllocated;
      if RestoreCanvas then
      begin
        Canvas.Handle := GetDC(0);
        FCanvasHandleAllocated := True;
      end;
      try
        Canvas.Font := Self.Font;
        GetTextMetrics(Canvas.Handle, TM);
        Result := Field.DisplayWidth * (Canvas.TextWidth('0') - TM.tmOverhang) + TM.tmOverhang + 4;
        {if dgTitles in Options then  //ddd
        begin
          Canvas.Font := Title.Font;
          W := Canvas.TextWidth(Title.Caption) + 4;
          if Result < W then
            Result := W;
        end;}//\\\
      finally
        if RestoreCanvas then
        begin
          ReleaseDC(0, Canvas.Handle);
          Canvas.Handle := 0;
          FCanvasHandleAllocated := False;
        end;
      end;
    end else
      Result := DefaultColWidth;
  end;
end;

procedure TColumnEh.FontChanged;
begin
  Include(FAssignedValues, cvFont);
  Title.RefreshDefaultFont;
  Changed(False);
end;

function TColumnEh.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TColumnEh.GetColor: TColor;
begin
  if cvColor in FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TColumnEh.GetField: TField;
var
  Grid: TCustomDBGridEh;
begin { Returns Nil if FieldName can't be found in dataset }
  Grid := GetGrid;
  if (FField = nil) and (Length(FFieldName) > 0) and Assigned(Grid) and
    Assigned(Grid.DataLink.DataSet) then
    with Grid.Datalink.Dataset do
      if Active or (not DefaultFields) then
      begin
      // SetField(FindField(FieldName));
        if FField <> FindField(FieldName) then
        begin
          FField := FindField(FieldName);
          if Assigned(FindField(FieldName))
            then FFieldName := FindField(FieldName).FieldName;
          EnsureSumValue;
        end;
        if Assigned(FField) and (GetGrid <> nil) and
          (csDesigning in GetGrid.ComponentState) then
        begin
          if FDTListSource = nil then
            FDTListSource := TDataSource.Create(nil);
          FDTListSource.DataSet := FField.LookupDataSet;
          DataList.DataSource := FDTListSource;
          TDBLookupGridEh(DataList).KeyField := FField.LookupKeyFields;
          TDBLookupGridEh(DataList).ListField := LookupDisplayFields;
        end;
      end;
  Result := FField;
end;

function TColumnEh.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if not (cvFont in FAssignedValues) and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TColumnEh.GetGrid: TCustomDBGridEh;
begin
  if Assigned(Collection) {and (Collection is TDBGridColumnsEh)}
    then Result := TDBGridColumnsEh(Collection).Grid
    else Result := nil;
end;

function TColumnEh.GetDisplayName: string;
begin
  Result := FFieldName;
  if Result = ''
    then Result := inherited GetDisplayName;
end;

function TColumnEh.GetImeMode: TImeMode;
begin
  if cvImeMode in FAssignedValues
    then Result := FImeMode
    else Result := DefaultImeMode;
end;

function TColumnEh.GetImeName: TImeName;
begin
  if cvImeName in FAssignedValues
    then Result := FImeName
    else Result := DefaultImeName;
end;

function TColumnEh.GetPickList: TStrings;
begin
  if FPickList = nil then
    FPickList := TStringList.Create;
  Result := FPickList;
end;

function TColumnEh.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues
    then Result := FReadOnly
    else Result := DefaultReadOnly;
end;

function TColumnEh.GetWidth: Integer;
begin
  if cvWidth in FAssignedValues
    then Result := FWidth
    else Result := DefaultWidth;
(*  //ddd
  if Assigned(Grid) and (Grid.AutoFitColWidths = True) and
    (csWriting in Grid.ComponentState) {and (AutoFitColWidth = True)} then begin
    Result := FInitWidth;
   //\\\
  end;*)
end;

function TColumnEh.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TColumnEh.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TColumnEh.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

function TColumnEh.IsImeModeStored: Boolean;
begin
  Result := (cvImeMode in FAssignedValues) and (FImeMode <> DefaultImeMode);
end;

function TColumnEh.IsImeNameStored: Boolean;
begin
  Result := (cvImeName in FAssignedValues) and (FImeName <> DefaultImeName);
end;

function TColumnEh.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

function TColumnEh.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TColumnEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnEh.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFont in FAssignedValues;
  FTitle.RestoreDefaults;
  FAssignedValues := [];
  RefreshDefaultFont;
  FreeAndNil(FPickList);
//  FPickList := nil;
  ButtonStyle := cbsAuto;
  Changed(FontAssigned);
//  FInitWidth := Width;
  FreeAndNil(FKeyList);
//  FKeyList := nil;
end;

procedure TColumnEh.SetAlignment(Value: TAlignment);
var
  Grid: TCustomDBGridEh;
begin
  if not SeenPassthrough then
  begin
    if (cvAlignment in FAssignedValues) and (Value = FAlignment) then Exit;
    FAlignment := Value;
    Include(FAssignedValues, cvAlignment);
    Changed(False);
  end
  else
  begin
    Grid := GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Field)
      then Field.Alignment := Value;
  end;
end;

procedure TColumnEh.SetButtonStyle(Value: TColumnButtonStyleEh);
begin
  if Value = FButtonStyle then Exit;
  FButtonStyle := Value;
  Changed(False);
end;

procedure TColumnEh.SetColor(Value: TColor);
begin
  if (cvColor in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
end;

procedure TColumnEh.SetField(Value: TField);
begin
  if FField = Value then Exit;
  FField := Value;
  if Assigned(Value) then
    FFieldName := Value.FieldName;
  if SeenPassthrough then
  begin
    if Value = nil then FFieldName := '';
    RestoreDefaults;
    FInitWidth := Width;
  end;
  if Assigned(Value) and (GetGrid <> nil) and
    (csDesigning in GetGrid.ComponentState) then
  begin
    if FDTListSource = nil then
      FDTListSource := TDataSource.Create(nil);
    FDTListSource.DataSet := Value.LookupDataSet;
    DataList.DataSource := FDTListSource;
    TDBLookupGridEh(DataList).KeyField := FField.LookupKeyFields;
    TDBLookupGridEh(DataList).ListField := LookupDisplayFields;
  end;
  EnsureSumValue;
  Changed(False);
end;

procedure TColumnEh.SetFieldName(const Value: String);
var
  AField: TField;
  Grid: TCustomDBGridEh;
begin
  AField := nil;
  Grid := GetGrid;
  if Assigned(Grid) and Assigned(Grid.DataLink.DataSet) and
    not (csLoading in Grid.ComponentState) and (Length(Value) > 0)
    then AField := Grid.DataLink.DataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  SetField(AField);
  FInitWidth := Width;
  Changed(False);
end;

procedure TColumnEh.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(False);
end;

procedure TColumnEh.SetImeMode(Value: TImeMode);
begin
  if (cvImeMode in FAssignedValues) or (Value <> DefaultImeMode) then
  begin
    FImeMode := Value;
    Include(FAssignedValues, cvImeMode);
  end;
  Changed(False);
end;

procedure TColumnEh.SetImeName(Value: TImeName);
begin
  if (cvImeName in FAssignedValues) or (Value <> DefaultImeName) then
  begin
    FImeName := Value;
    Include(FAssignedValues, cvImeName);
  end;
  Changed(False);
end;

procedure TColumnEh.SetIndex(Value: Integer);
var
  Grid: TCustomDBGridEh;
  Fld: TField;
begin
  if SeenPassthrough then
  begin
    Grid := GetGrid;
    if Assigned(Grid) and Grid.Datalink.Active then
    begin
      Fld := Grid.Datalink.Fields[Value];
      if Assigned(Fld) then
        Field.Index := Fld.Index;
    end;
  end;
  inherited SetIndex(Value);
end;

procedure TColumnEh.SetPickList(Value: TStrings);
begin
  if Value = nil then
  begin
    FreeAndNil(FPickList);
//    FPickList := nil;
    Exit;
  end;
  PickList.Assign(Value);
end;

procedure TColumnEh.SetPopupMenu(Value: TPopupMenu);
begin
  FPopupMenu := Value;
  if Value <> nil then Value.FreeNotification(GetGrid);
end;

procedure TColumnEh.SetReadOnly(Value: Boolean);
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetGrid;
  if SeenPassthrough and Assigned(Grid) and Grid.Datalink.Active and Assigned(Field)
    then Field.ReadOnly := Value
  else
  begin
    if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
    FReadOnly := Value;
    Include(FAssignedValues, cvReadOnly);
    Changed(False);
  end;
end;

procedure TColumnEh.SetTitle(Value: TColumnTitleEh);
begin
  FTitle.Assign(Value);
end;

procedure TColumnEh.SetWidth(Value: Integer);
var
  Grid: TCustomDBGridEh;
  TM: TTextMetric;
  DoSetWidth: Boolean;
begin
  DoSetWidth := not SeenPassthrough;
  if not DoSetWidth then
  begin
    Grid := GetGrid;
    if Assigned(Grid) then
    begin
      if Grid.HandleAllocated and Assigned(Field) and Grid.FUpdateFields then
        with Grid do
        begin
          Canvas.Font := Self.Font;
          GetTextMetrics(Canvas.Handle, TM);
          Field.DisplayWidth := (Value + (TM.tmAveCharWidth div 2) - TM.tmOverhang - 3)
            div {VCL BUG TM.tmAveCharWidth}  Canvas.TextWidth('0');
        end;
      if (not Grid.FLayoutFromDataset) or (cvWidth in FAssignedValues) then
        DoSetWidth := True;
    end
    else
      DoSetWidth := True;
  end;
  if DoSetWidth then
  begin
    if ((cvWidth in FAssignedValues) or (Value <> DefaultWidth))
      and (Value <> -1) then
    begin
      FWidth := Value;
      Include(FAssignedValues, cvWidth);
      if (MaxWidth > 0) and (FWidth > MaxWidth) then FWidth := MaxWidth;
      if (FWidth < MinWidth) then FWidth := MinWidth;
    end;
//  if (AutoFitColWidth = False) then FInitWidth := Width;
    if GetGrid.RowPanel.Active
      then Changed(True)
      else Changed(False);
  end;
end;

function TColumnEh.GetAutoFitColWidth: Boolean;
begin
  Result := FAutoFitColWidth;
end;

procedure TColumnEh.SetAutoFitColWidth(Value: Boolean);
begin
  if FAutoFitColWidth <> Value then
  begin
    FAutoFitColWidth := Value;
    if Assigned(Grid) and (Grid.AutoFitColWidths = True) and
      not (csLoading in Grid.ComponentState) and not (csDesigning in Grid.ComponentState)
      then Width := FInitWidth;
    Changed(False);
  end;
end;

procedure TColumnEh.SetAlwaysShowEditButton(Value: Boolean);
begin
  if (cvAlwaysShowEditButton in FAssignedValues) and (Value = FAlwaysShowEditButton)
    then Exit;
  FAlwaysShowEditButton := Value;
  Include(FAssignedValues, cvAlwaysShowEditButton);
  Changed(False);
end;

procedure TColumnEh.SetWordWrap(Value: Boolean);
begin
  if (cvWordWrap in FAssignedValues) or (Value <> DefaultWordWrap) or
    (Assigned(Grid) and (csLoading in Grid.ComponentState)) then
  begin
    FWordWrap := Value;
    Include(FAssignedValues, cvWordWrap);
  end;
  Changed(False);
end;

function TColumnEh.GetWordWrap: Boolean;
begin
  if cvWordWrap in FAssignedValues
    then Result := FWordWrap
    else Result := DefaultWordWrap;
end;

function TColumnEh.IsWordWrapStored: Boolean;
begin
  Result := (cvWordWrap in FAssignedValues) and (FWordWrap <> DefaultWordWrap);
end;

function TColumnEh.DefaultWordWrap: Boolean;
begin
  if GetGrid = nil then
  begin
    Result := False;
    Exit;
  end;
  with GetGrid do
  begin
    if Assigned(Field) then
    begin
      case Field.DataType of
        ftString, ftMemo, ftFmtMemo, ftWideString, ftOraClob
          {$IFDEF EH_LIB_10} ,ftWideMemo {$ENDIF}: Result := True;
      else
        Result := False;
      end;
    end
    else Result := False;
  end;
end;

procedure TColumnEh.SetEndEllipsis(const Value: Boolean);
begin
  if (cvEndEllipsis in FAssignedValues) and (Value = FEndEllipsis) then Exit;
  FEndEllipsis := Value;
  Include(FAssignedValues, cvEndEllipsis);
  Changed(False);
end;

procedure TColumnEh.SetDropDownWidth(Value: Integer);
begin
  if (Value = FDropDownWidth) then Exit;
  FDropDownWidth := Value;
  Changed(False);
end;

function TColumnEh.DefaultLookupDisplayFields: String;
begin
  if Assigned(Field)
    then Result := FField.LookupResultField
    else Result := '';
end;

function TColumnEh.GetLookupDisplayFields: String;
begin
  if cvLookupDisplayFields in FAssignedValues
    then Result := FLookupDisplayFields
    else Result := DefaultLookupDisplayFields;
end;

procedure TColumnEh.SetLookupDisplayFields(Value: String);
begin
  if (cvLookupDisplayFields in FAssignedValues) or (Value <> DefaultLookupDisplayFields) then
  begin
    FLookupDisplayFields := Value;
    TDBLookupGridEh(DataList).ListField := FLookupDisplayFields;
    Include(FAssignedValues, cvLookupDisplayFields);
  end;
  Changed(False);
end;

function TColumnEh.IsLookupDisplayFieldsStored: Boolean;
begin
  Result := (cvLookupDisplayFields in FAssignedValues) and
    (FLookupDisplayFields <> DefaultLookupDisplayFields);
end;

procedure TColumnEh.SetAutoDropDown(Value: Boolean);
begin
  if (cvAutoDropDown in FAssignedValues) and (Value = FAutoDropDown) then Exit;
  FAutoDropDown := Value;
  Include(FAssignedValues, cvAutoDropDown);
//  Changed(False);
end;

function TColumnEh.CreateFooter: TColumnFooterEh;
begin
  Result := TColumnFooterEh.CreateApart(Self);
end;

procedure TColumnEh.SetFooter(const Value: TColumnFooterEh);
begin
  FFooter.Assign(Value);
end;

procedure TColumnEh.SetVisible(const Value: Boolean);
begin
  if (Value = FVisible) then Exit;
  FVisible := Value;
  Changed(True);
end;

function TColumnEh.GetKeykList: TStrings;
begin
  if FKeyList = nil then
    FKeyList := TStringList.Create;
  Result := FKeyList;
end;

procedure TColumnEh.SetKeykList(const Value: TStrings);
begin
  if Value = nil then
  begin
    FreeAndNil(FKeyList);
//    FKeyList := nil;
    Exit;
  end;
  KeyList.Assign(Value);
  if GetGrid <> nil then GetGrid.Invalidate;
end;

function TColumnEh.GetColumnType: TColumnEhType;
begin
// ctCommon, ctPickList, ctLookupField, ctKeyPickList, ctKeyImageList
  Result := ctCommon;
  if Checkboxes
    then Result := ctCheckboxes
  else if Assigned(Field) and Field.IsBlob and (Field is TBlobField) and
          (TBlobField(Field).BlobType = ftGraphic) and Grid.DrawGraphicData
    then Result := ctGraphicData
  else if Assigned(Field) and (Field.FieldKind = fkLookup)
    then Result := ctLookupField
  else if Assigned(FPickList) and (FPickList.Count > 0) and not (Assigned(FKeyList) and (FKeyList.Count > 0))
    then Result := ctPickList
  else if Assigned(ImageList) and not ShowImageAndText then
    Result := ctKeyImageList
  else if Assigned(FKeyList) and (FKeyList.Count > 0) and Assigned(FPickList) and (FPickList.Count > 0) then
      Result := ctKeyPickList;
end;

procedure TColumnEh.SetNotInKeyListIndex(const Value: Integer);
begin
  if (FNotInKeyListIndex = Value) then Exit;
  FNotInKeyListIndex := Value;
  if GetGrid <> nil then
    GetGrid.Invalidate;
end;

procedure TColumnEh.SetImageList(const Value: TCustomImageList);
begin
  if FImageList <> nil then FImageList.UnRegisterChanges(FImageChangeLink);
  FImageList := Value;
  if FImageList <> nil then
  begin
    FImageList.RegisterChanges(FImageChangeLink);
    if GetGrid <> nil then
      FImageList.FreeNotification(GetGrid);
  end;
  if GetGrid <> nil then
    GetGrid.Invalidate;
end;

procedure TColumnEh.ImageListChange(Sender: TObject);
begin
  if Sender = ImageList then
    GetGrid.Invalidate;
end;

procedure TColumnEh.SetNextFieldValue(Increment: Extended);
var CanEdit: Boolean;
  ki: Integer;
  AColType: TColumnEhType;
  AField: TField;
  AFields: TObjectList;
  AValue: Variant;
  Text: String;
//  Column: TColumnEh;
begin
  CanEdit := True;
  AField := nil;
  if Assigned(Grid) then
    CanEdit := CanEdit and not Grid.ReadOnly
      and Grid.FDatalink.Active and not Grid.FDatalink.ReadOnly;
  CanEdit := CanEdit and not ReadOnly;
  if Assigned(Field) then
    if (Field.FieldKind = fkLookUp) then
    begin
      CanEdit := CanEdit and (Field.KeyFields <> '');
      AFields := TObjectList.Create(False);
      try
        Field.Dataset.GetFieldList(AFields, Field.KeyFields);
        AField := TField(AFields[0]);
        CanEdit := CanEdit and FieldsCanModify(AFields);
      finally
        AFields.Free;
      end;
      //AField := Field.DataSet.FieldByName(Field.KeyFields);
    end else AField := Field
  else CanEdit := False;

  if CanEdit then
    CanEdit := CanEdit and AField.CanModify
      and (not AField.IsBlob or Assigned(AField.OnSetText))
      and Grid.AllowedOperationUpdate;
  if CanEdit then
    with Grid.FColCellParamsEh do 
    begin
//      Column := Grid.Columns[Grid.SelectedIndex];
      FReadOnly := not CanModify(False);
      GetColCellParams(True, Grid.FColCellParamsEh);
      CanEdit := not FReadOnly;
    end;
  if CanEdit and Assigned(Grid) then
  begin
    Grid.FDatalink.Edit;
    CanEdit := Grid.FDatalink.Editing;
    if CanEdit then Grid.FDatalink.Modified;
  end;

  if not CanEdit then Exit;

  AColType := GetColumnType;
  if Grid.InplaceEditorVisible
    then Text := Grid.InplaceEditor.Text
  else Text := Field.Text;
  if (AColType = ctCheckboxes) then
    if CheckboxState = cbChecked
      then CheckboxState := cbUnchecked
      else CheckboxState := cbChecked
  else if (AColType in [ctKeyPickList, ctKeyImageList]) then
  begin
    ki := KeyList.IndexOf(Field.Text);
    if ((ki = -1) or (ki = KeyList.Count - 1)) and (Increment = 1) then
      //Field.Text := KeyList.Strings[0]
      UpdateDataValues(Text, KeyList.Strings[0], False)
    else if ((ki = -1) or (ki = 0)) and not (Increment = 1) then
      //Field.Text := KeyList.Strings[KeyList.Count-1]
      UpdateDataValues(Text, KeyList.Strings[KeyList.Count - 1], False)
    else if (Increment = 1) then
      //Field.Text := KeyList.Strings[ki+1]
      UpdateDataValues(Text, KeyList.Strings[ki + 1], False)
    else
     //Field.Text := KeyList.Strings[ki-1];
      UpdateDataValues(Text, KeyList.Strings[ki - 1], False)
  end else if AColType = ctPickList then
  begin
    ki := PickList.IndexOf(Field.Text);
    if ((ki = -1) or (ki = PickList.Count - 1)) and (Increment = 1)
      then Field.Text := PickList.Strings[0]
    else if ((ki = -1) or (ki = 0)) and not (Increment = 1)
      then Field.Text := PickList.Strings[PickList.Count - 1]
    else if (Increment = 1) then
      //Field.Text := PickList.Strings[ki+1]
      UpdateDataValues(PickList.Strings[ki + 1], PickList.Strings[ki + 1], True)
    else
      //Field.Text := PickList.Strings[ki-1];
      UpdateDataValues(PickList.Strings[ki - 1], PickList.Strings[ki - 1], True)
  end else if (AColType = ctLookupField) and (UsedLookupDataSet <> nil) then
  begin
    if AField.IsNull or
      not UsedLookupDataSet.Locate(Field.LookUpKeyFields, Field.DataSet.FieldValues[Field. {LookUp} KeyFields], [])
      then UsedLookupDataSet.First
    else if (Increment = 1) then
    begin //Go Forward
      if not UsedLookupDataSet.EOF then
      begin
        UsedLookupDataSet.Next;
        if UsedLookupDataSet.EOF then UsedLookupDataSet.First;
      end else
        UsedLookupDataSet.First;
    end else
    begin //Go Backward
      if not UsedLookupDataSet.BOF then
      begin
        UsedLookupDataSet.Prior;
        if UsedLookupDataSet.BOF then UsedLookupDataSet.Last;
      end else
        UsedLookupDataSet.Last;
    end;
    //Field.DataSet.FieldValues[Field.KeyFields] := Field.UsedLookupDataSet.FieldValues[Field.LookUpKeyFields];
    UpdateDataValues(Text, UsedLookupDataSet.FieldValues[Field.LookUpKeyFields], False);
    Field.Text := UsedLookupDataSet.FieldByName(Field.LookUpResultField).Text;
  end else if Field.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}] then
  begin
    if Field.IsNull
      then AValue := -Increment
      else AValue := Field.Value;
    try
      //Field.Value := AValue + Increment;
      UpdateDataValues(Text, AValue + Increment, False);
    except
      on EDatabaseError do ; //Noshow RangeError
    else
      raise;
    end;
  end;
{    if Field.IsNull
     then Field.Value := 0
     else Field.Value := Field.Value + Increment;}
{     else if (Increment = 1) then Field.Value := Field.Value + 1
     else Field.Value := Field.Value - 1;}
//  if Assigned(Grid) and Assigned(Grid.InplaceEditor) and  Grid.InplaceEditor.Visible then
//   GetGrid.InplaceEditor.SelectAll;
end;

procedure TColumnEh.SetMaxWidth(const Value: Integer);
begin
  FMaxWidth := Value;
  if (FMaxWidth > 0) and (Width > FMaxWidth) then
    Width := FMaxWidth;
end;

procedure TColumnEh.SetMinWidth(const Value: Integer);
begin
  FMinWidth := Value;
  if (FMinWidth > 0) and (Width < FMinWidth) then
    Width := FMinWidth;
end;

function TColumnEh.CanEditAcceptKey(Key: Char): Boolean;
begin
  if Assigned(Field) then
  begin
    if Assigned(FKeyList) and (FKeyList.Count > 0)
      then Result := True
      else Result := Field.IsValidChar(Key)
  end
  else if Assigned(FUpdateData) then
    Result := True
  else
    Result := False;
end;

function TColumnEh.GetAcceptableEditText(InputEditText: String): String;
var
  OutText: String;
  i,k: Integer;
begin
  OutText := InputEditText;
  k := 1;
  for i := 1 to Length(InputEditText) do
    if CanEditAcceptKey(InputEditText[i]) then
    begin
      OutText[k] := InputEditText[i];
      Inc(k);
    end;
  Result := Copy(OutText, 1, k-1);    
end;

function TColumnEh.CanModify(TryEdit: Boolean): Boolean;
var
  AField: TField;
  AFields: TObjectList;
begin
  Result := True;
  AField := nil;
  if Assigned(Grid) then
    Result := Result and not Grid.ReadOnly
      and Grid.FDatalink.Active and not Grid.FDatalink.ReadOnly;
  Result := Result and not ReadOnly;
  if Assigned(Field) then
    if (Field.FieldKind = fkLookUp) then
    begin
      Result := Result and (Field.KeyFields <> '');
      AFields := TObjectList.Create(False);
      try
        Field.Dataset.GetFieldList(AFields, Field.KeyFields);
        AField := TField(AFields[0]);
        Result := Result and FieldsCanModify(AFields);
      finally
        AFields.Free;
      end;
      //AField := Field.DataSet.FieldByName(Field.KeyFields);
    end else
      AField := Field
  else
    Result := False;

  if Result then
    Result := Result and AField.CanModify and
      ((not AField.IsBlob or Assigned(AField.OnSetText)) or
      ((Grid.DrawMemoText = True) and (AField.DataType in MemoTypes))) and
      Grid.AllowedOperationUpdate;

  if Result then
    with Grid.FColCellParamsEh do
    begin
      FReadOnly := Self.ReadOnly;
      GetColCellParams(True, Grid.FColCellParamsEh);
      Result := not FReadOnly;
    end;

  if TryEdit and Result and Assigned(Grid) then
  begin
    Grid.FDatalink.Edit;
    Result := Grid.FDatalink.Editing;
    if Result then Grid.FDatalink.Modified;
  end;
end;

function TColumnEh.AllowableWidth(TryWidth: Integer): Integer;
begin
  Result := TryWidth;
  if (MaxWidth > 0) and (TryWidth > MaxWidth) then Result := MaxWidth;
  if (MinWidth > 0) and (TryWidth < MinWidth) then Result := MinWidth;
end;

function FormatFieldDisplayValue(Field: TField; DisplayFormat: String): String;
begin
  if DisplayFormat = '' then
    Result := Field.DisplayText
  else if Field.IsNull then
    Result := ''
  else if Field is TNumericField then
    Result := FormatFloat(DisplayFormat, Field.AsFloat)
  else if Field is TDateTimeField then
    DateTimeToString(Result, DisplayFormat, Field.AsDateTime)
{$IFDEF EH_LIB_6}
  else if Field is TSQLTImeStampField then
    DateTimeToString(Result, DisplayFormat, Field.AsDateTime)
{$ENDIF}
  else if (Field is TAggregateField) and (TAggregateField(Field).ResultType in [ftFloat, ftCurrency]) then
     Result := FormatFloat(DisplayFormat, Field.Value)
  else if (Field is TAggregateField) and (TAggregateField(Field).ResultType in [ftDate, ftTime, ftDatetime]) then
    DateTimeToString(Result, DisplayFormat, Field.Value)
  else
    Result := '';
end;

function TColumnEh.DisplayText: String;
var KeyIndex: Integer;
  function LocateKey(Field: TField): Boolean;
  begin
    Result := False;
    if (Field.LookupDataSet <> nil) and Field.LookupDataSet.Active then
    begin
      //Result := Field.LookupDataSet.Locate(Field.LookupKeyFields,
      //  Field.DataSet.FieldValues[Field.KeyFields],[loCaseInsensitive]);
      Result := Field.Value <> Null;
    end;
  end;
begin
  Result := '';
  if not Assigned(Field) then Exit;
  if GetColumnType = ctKeyImageList then Exit;
  if Assigned(KeyList) and (KeyList.Count > 0) then
  begin
    KeyIndex := KeyList.IndexOf(Field.Text);
    if (KeyIndex > -1) and (KeyIndex < PickList.Count) then
      Result := PickList.Strings[KeyIndex]
    else if (NotInKeylistIndex >= 0) and (NotInKeylistIndex < PickList.Count) then
      Result := PickList.Strings[NotInKeylistIndex];
  end
  else if Assigned(Grid) and (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes)
    then Result := Field.AsString
  else if (GetColumnType = ctLookupField) and
    DropDownSpecRow.Visible and
    (VarEquals(Field.DataSet.FieldValues[Field.KeyFields], DropDownSpecRow.Value)
    or
    (DropDownSpecRow.ShowIfNotInKeyList and not LocateKey(Field))
    ) then
    Result := DropDownSpecRow.CellText[0]
  else
    Result := FormatFieldDisplayValue(Field, DisplayFormat);
end;

function TColumnEh.EditText: String;
begin
  Result := '';
  if not Assigned(Field) then Exit;
  if GetColumnType = ctKeyImageList then Exit;
  if Assigned(KeyList) and (KeyList.Count > 0) then
    Result := DisplayText
  else if Assigned(Grid) and (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes)
    then Result := Field.AsString
  else if GetColumnType = ctLookupField then
    Result := DisplayText
  else
    Result := Field.Text;
end;

procedure TColumnEh.EnsureSumValue;
var i: Integer;
begin
  Footer.EnsureSumValue;
  for i := 0 to Footers.Count - 1 do
    Footers[i].EnsureSumValue;
end;

function TColumnEh.GetCheckboxes: Boolean;
begin
  if cvCheckboxes in FAssignedValues
    then Result := FCheckboxes
    else Result := DefaultCheckboxes;
end;

procedure TColumnEh.SetCheckboxes(const Value: Boolean);
begin
  if (cvCheckboxes in FAssignedValues) and (Value = FCheckboxes) then Exit;
  FCheckboxes := Value;
  Include(FAssignedValues, cvCheckboxes);
  Changed(False);
end;

function TColumnEh.DefaultCheckboxes: Boolean;
begin
  if Assigned(Field) and (Field.DataType = ftBoolean)
    then Result := True
    else Result := False;
end;

function TColumnEh.GetCheckboxState: TCheckBoxState;
var
  Text: string;

  function ValueMatch(const ValueList, Value: string): Boolean;
  var
    Pos: Integer;
  begin
    Result := False;
    if (ValueList = '') and (Value = '') then
    begin
      Result := True;
      Exit;
    end;
    Pos := 1;
    while Pos <= Length(ValueList) do
      if NlsCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
      begin
        Result := True;
        Break;
      end;
    if not Result and ((Pos > 1)
                   and (Pos = Length(ValueList) + 1)
                   and (ValueList[Pos-1] = ';'))
    then
      Result := (Value = '');
  end;

begin
  Result := cbGrayed;
  if Field <> nil then
  begin
    if (Field.DataType = ftBoolean) and (KeyList.Count = 0) then
    begin
      if Field.IsNull then
        Result := cbGrayed
      else if Field.DataType = ftBoolean then
        if Field.AsBoolean
          then Result := cbChecked
          else Result := cbUnchecked
    end else if (Field.DataType in
      [ftInteger, ftSmallint, ftFloat, ftBCD, ftCurrency {$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF} ])
      and (KeyList.Count = 0) then
    begin
      if Field.IsNull then
        Result := cbGrayed
      else if Field.AsFloat = 1
        then Result := cbChecked
        else Result := cbUnchecked
    end else
    begin
      Result := cbGrayed;
      Text := Field.Text;
      if (KeyList.Count > 0) and ValueMatch(KeyList[0], Text) then
        Result := cbChecked
      else if (KeyList.Count > 1) and ValueMatch(KeyList[1], Text) then
        Result := cbUnchecked;
    end;
  end else
    Result := cbUnchecked;
end;

procedure TColumnEh.SetCheckboxState(const Value: TCheckBoxState);
var S: String;
  Pos: Integer;
begin
  if not Assigned(Field) then Exit;
  if Value = cbGrayed then
    //Field.Clear
    UpdateDataValues('', Null, False)
  else
    if (Field.DataType = ftBoolean) then
      if Value = cbChecked
        then UpdateDataValues('', True, False)
        else UpdateDataValues('', False, False)
    else if Field.DataType in
      [ftInteger, ftSmallint, ftFloat, ftBCD, ftCurrency {$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF} ] then
      if Value = cbChecked
        then UpdateDataValues('', 1, False)
        else UpdateDataValues('', 0, False)
    else
    begin
      if Value = cbChecked then
        if KeyList.Count > 0 then S := KeyList[0] else S := ''
      else
        if KeyList.Count > 1 then S := KeyList[1] else S := '';
      Pos := 1;
      //Field.Text := ExtractFieldName(S, Pos);
      S := ExtractFieldName(S, Pos);
      UpdateDataValues(S, S, True);
    end;
end;

function TColumnEh.IsCheckboxesStored: Boolean;
begin
  Result := (cvCheckboxes in FAssignedValues);
end;

function TColumnEh.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TColumnEh.GetToolTips: Boolean;
begin
  if cvToolTips in FAssignedValues
    then Result := FToolTips
    else Result := DefaultToolTips;
end;

procedure TColumnEh.SetToolTips(const Value: Boolean);
begin
  if (cvToolTips in FAssignedValues) and (Value = FToolTips) then Exit;
  FToolTips := Value;
  Include(FAssignedValues, cvToolTips);
//  Changed(False);
end;

procedure TColumnEh.SetFooters(const Value: TColumnFootersEh);
begin
  FFooters.Assign(Value);
end;

function TColumnEh.CreateFooters: TColumnFootersEh;
begin
  Result := TColumnFootersEh.Create(Self, TColumnFooterEh);
end;

function TColumnEh.UsedFooter(Index: Integer): TColumnFooterEh;
begin
  if Index < Footers.Count
    then Result := Footers[Index]
    else Result := Footer;
end;

function TColumnEh.GetAlwaysShowEditButton: Boolean;
begin
  if cvAlwaysShowEditButton in FAssignedValues
    then Result := FAlwaysShowEditButton
    else Result := DefaultAlwaysShowEditButton;
end;

function TColumnEh.IsAlwaysShowEditButtonStored: Boolean;
begin
  Result := (cvAlwaysShowEditButton in FAssignedValues) and
    (FAlwaysShowEditButton <> DefaultAlwaysShowEditButton);
end;

function TColumnEh.DefaultAlwaysShowEditButton: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.AlwaysShowEditButton
    else Result := False;
end;

function TColumnEh.GetEditMask: string;
begin
  Result := '';
  if Grid.Datalink.Active then
    if EditMask <> '' then
      Result := EditMask
    else if Assigned(Field) and not (Assigned(KeyList) and (KeyList.Count > 0)) then
      Result := Field.EditMask;
end;

function TColumnEh.GetEditText: String;
var
  KeyIndex: Integer;
  ColCellParamsEh: TColCellParamsEh;

  function LocateKey(Column: TColumnEh): Boolean;
  begin
    Result := False;
    if (Column.Field <> nil) and (Column.UsedLookupDataSet <> nil) and
       Column.UsedLookupDataSet.Active then
    begin
      Result := Column.FullListDataSet{UsedLookupDataSet}.Locate(Column.Field.LookupKeyFields,
        Column.Field.DataSet.FieldValues[Column.Field.KeyFields], [loCaseInsensitive]);
    end;
  end;

begin
  Result := '';
  if Grid.Datalink.Active then
  begin
    if Assigned(Field) then
    begin
      if Assigned(KeyList) and (KeyList.Count > 0) then
      begin
        KeyIndex := KeyList.IndexOf(Field.Text);
        if (KeyIndex > -1) and (KeyIndex < PickList.Count) then
          Result := PickList.Strings[KeyIndex];
      end
      else if (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes) then
        Result := AdjustLineBreaks(Field.AsString)
      else
        Result := Field.Text;
      if (Field.FieldKind = fkLookup) and (Field.KeyFields <> '') then
      begin
        if DropDownSpecRow.Visible and
          (VarEquals(Field.DataSet.FieldValues[Field.KeyFields], DropDownSpecRow.Value)
          or
          (DropDownSpecRow.ShowIfNotInKeyList and not LocateKey(Self))
          )
          then
        begin
          Grid.FEditKeyValue := DropDownSpecRow.Value;
          Result := DropDownSpecRow.CellText[0];
        end else
          Grid.FEditKeyValue := Field.DataSet.FieldValues[Field.KeyFields];
      end
      else Grid.FEditKeyValue := Null;
    end;

    ColCellParamsEh := TColCellParamsEh.Create;
    ColCellParamsEh.FText := Result;
    ColCellParamsEh.FFont := Grid.Canvas.Font;
    GetColCellParams(True, ColCellParamsEh);
    Result := ColCellParamsEh.FText;
    ColCellParamsEh.Free;
  end;
  Grid.FEditText := Result;
end;

procedure TColumnEh.SetEditText(const Value: string);
begin
  Grid.FEditText := Value;
end;

function TColumnEh.GetEndEllipsis: Boolean;
begin
  if cvEndEllipsis in FAssignedValues
    then Result := FEndEllipsis
    else Result := DefaultEndEllipsis;
end;

function TColumnEh.IsEndEllipsisStored: Boolean;
begin
  Result := (cvEndEllipsis in FAssignedValues) and (FEndEllipsis <> DefaultEndEllipsis);
end;

function TColumnEh.DefaultEndEllipsis: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.EndEllipsis
    else Result := False;
end;

function TColumnEh.GetAutoDropDown: Boolean;
begin
  if cvAutoDropDown in FAssignedValues
    then Result := FAutoDropDown
    else Result := DefaultAutoDropDown;
end;

function TColumnEh.IsAutoDropDownStored: Boolean;
begin
  Result := (cvAutoDropDown in FAssignedValues) and (FAutoDropDown <> DefaultAutoDropDown);
end;

function TColumnEh.DefaultAutoDropDown: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.AutoDropDown
    else Result := False;
end;

function TColumnEh.GetDblClickNextVal: Boolean;
begin
  if cvDblClickNextVal in FAssignedValues
    then Result := FDblClickNextVal
    else Result := DefaultDblClickNextVal;
end;

function TColumnEh.IsDblClickNextValStored: Boolean;
begin
  Result := (cvDblClickNextVal in FAssignedValues) and (FDblClickNextVal <> DefaultDblClickNextVal);
end;

procedure TColumnEh.SetDblClickNextVal(const Value: Boolean);
begin
  if (cvDblClickNextVal in FAssignedValues) and (Value = FDblClickNextVal) then Exit;
  FDblClickNextVal := Value;
  Include(FAssignedValues, cvDblClickNextVal);
//  Changed(False);
end;

function TColumnEh.DefaultDblClickNextVal: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.DblClickNextVal
    else Result := False;
end;

function TColumnEh.IsToolTipsStored: Boolean;
begin
  Result := (cvToolTips in FAssignedValues) and (FToolTips <> DefaultToolTips);
end;

function TColumnEh.DefaultToolTips: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.ToolTips
    else Result := False;
end;

function TColumnEh.GetDropDownSizing: Boolean;
begin
  if cvDropDownSizing in FAssignedValues
    then Result := FDropDownSizing
    else Result := DefaultDropDownSizing;
end;

function TColumnEh.IsDropDownSizingStored: Boolean;
begin
  Result := (cvDropDownSizing in FAssignedValues) and (FDropDownSizing <> DefaultDropDownSizing);
end;

procedure TColumnEh.SetDropDownSizing(const Value: Boolean);
begin
  if (cvDropDownSizing in FAssignedValues) and (Value = FDropDownSizing) then Exit;
  FDropDownSizing := Value;
  Include(FAssignedValues, cvDropDownSizing);
//  Changed(False);
end;

function TColumnEh.DefaultDropDownSizing: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.DropDownSizing
    else Result := False;
end;

function TColumnEh.GetDropDownShowTitles: Boolean;
begin
  if cvDropDownShowTitles in FAssignedValues
    then Result := FDropDownShowTitles
    else Result := DefaultDropDownShowTitles;
end;

function TColumnEh.IsDropDownShowTitlesStored: Boolean;
begin
  Result := (cvDropDownShowTitles in FAssignedValues) and (FDropDownShowTitles <> DefaultDropDownShowTitles);
end;

procedure TColumnEh.SetDropDownShowTitles(const Value: Boolean);
begin
  if (cvDropDownShowTitles in FAssignedValues) and (Value = FDropDownShowTitles) then Exit;
  FDropDownShowTitles := Value;
  Include(FAssignedValues, cvDropDownShowTitles);
//  Changed(False);
end;

function TColumnEh.DefaultDropDownShowTitles: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.DropDownShowTitles
    else Result := False;
end;

procedure TColumnEh.SetOnGetCellParams(const Value: TGetColCellParamsEventEh);
begin
  if @FOnGetCellParams <> @Value then
  begin
    FOnGetCellParams := Value;
    if GetGrid <> nil then GetGrid.Invalidate;
  end;
end;

procedure TColumnEh.GetColCellParams(EditMode: Boolean; ColCellParamsEh: TColCellParamsEh);
begin
  if Assigned(OnGetCellParams) then
    OnGetCellParams(Self, EditMode, ColCellParamsEh);
end;

procedure TColumnEh.FillColCellParams(ColCellParamsEh: TColCellParamsEh);
begin
  with ColCellParamsEh do
  begin
    FRow := -1;
    FCol := -1;
    FState := [];
    FFont := Grid.FDummiFont;
    Background := Self.Color;
    Alignment := Self.Alignment;
    ImageIndex := Self.GetImageIndex;
    Text := Self.DisplayText;
    CheckboxState := Self.CheckboxState;
    FReadOnly := Self.ReadOnly;
    FTextEditing := Self.TextEditing;
    FBlankCell := False;
  end;
end;

function TColumnEh.GetImageIndex: Integer;
begin
  Result := -1;
  if Assigned(Field) then
  begin
    if KeyList.Count > 0 then
      Result := KeyList.IndexOf(Field.Text)
    else if PickList.Count > 0 then
      Result := PickList.IndexOf(Field.Text)
    else if IsFieldTypeNumeric(Field.DataType) then
      Result := SafeGetFieldAsInteger(Field, -1);
    if Result = -1 then
      Result := NotInKeyListIndex;
  end;
end;

procedure TColumnEh.UpdateDataValues(Text: String; Value: Variant; UseText: Boolean);
var Processed: Boolean;
begin
  if Grid <> nil then
  begin
    Processed := False;
    if Assigned(FUpdateData) then FUpdateData(Self, Text, Value, UseText, Processed);
    if Processed then Exit;
    if Field = nil then Exit;
    if not UseText then
    begin
      if (Field.FieldKind = fkLookup) and (Field.KeyFields <> '')
        then DataSetSetFieldValues(Field.DataSet, Field.KeyFields, Value)
        else Field.Value := Value;
    end else if (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes)
      then Field.AsString := Text
    else
      Field.Text := Text;
    if MRUList.AutoAdd and MRUList.Active and
       Grid.InplaceEditorVisible and Grid.InplaceEditor.Showing
    then
      MRUList.Add(Text);
  end;
end;

procedure TColumnEh.DropDown;
begin
  if Assigned(Grid) and Grid.InplaceEditorVisible and
    (Grid.InplaceEditor is TDBGridInplaceEdit)
  then
    TDBGridInplaceEdit(Grid.InplaceEditor).DropDown;
end;

procedure TColumnEh.SetEditButtons(const Value: TEditButtonsEh);
begin
  FEditButtons.Assign(Value);
end;

function TColumnEh.CreateEditButtons: TEditButtonsEh;
begin
  Result := TEditButtonsEh.Create(Self, TVisibleEditButtonEh);
end;

procedure TColumnEh.EditButtonChanged(Sender: TObject);
begin
  Changed(False);
end;

function TColumnEh.EditButtonsWidth: Integer;
var i: Integer;
  Flat: Boolean;
begin
  Result := 0;
  if (Grid <> nil) and (Grid.Flat)
    then Flat := True
    else Flat := False;
  if GetColumnEditStile(Self) <> esSimple then
  begin
    if Flat then
    begin
      Inc(Result, FlatButtonWidth);
      if not ThemesEnabled then
        Inc(Result);
    end else
      Inc(Result, GetSystemMetrics(SM_CXVSCROLL));
  end;
  for i := 0 to EditButtons.Count - 1 do
    if EditButtons[i].Visible then
    begin
      if EditButtons[i].Width = 0 then
        if Flat
          then Inc(Result, FlatButtonWidth)
          else Inc(Result, GetSystemMetrics(SM_CXVSCROLL))
      else
        Inc(Result, EditButtons[i].Width);
      if Flat and not ThemesEnabled then Inc(Result, 1);
    end;
end;

procedure TColumnEh.SetDropDownSpecRow(const Value: TSpecRowEh);
begin
  FDropDownSpecRow.Assign(Value);
end;

procedure TColumnEh.SpecRowChanged(Sender: TObject);
begin
  Changed(False);
  if Assigned(FDataList) then
    TPopupDataGridEh(FDataList).SpecRow := DropDownSpecRow;
end;

function TColumnEh.SeenPassthrough: Boolean;
begin
  Result := not IsStored;
end;

function TColumnEh.GetDataList: TCustomDBGridEh;
begin
  if FDataList = nil then
  begin
    FDataList := TPopupDataGridEh.Create(nil);
    FDataList.Name := 'DataList'; 
  end;
  Result := FDataList;
end;

{$IFNDEF CIL}
function TColumnEh.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj)
    then Result := 0
    else Result := E_NOINTERFACE;
end;

function TColumnEh._AddRef: Integer;
begin
  Result := -1;
end;

function TColumnEh._Release: Integer;
begin
  Result := -1;
end;
{$ENDIF}

procedure TColumnEh.SetDropDownBoxListSource(AListSource: TDataSource);
begin
  if AListSource <> nil then AListSource.FreeNotification(GetGrid);
end;

function TColumnEh.GetLookupGrid: TCustomDBGridEh;
begin
  Result := DataList;
end;

function TColumnEh.GetOptions: TDBLookupGridEhOptions;
begin
  Result := TDBLookupGridEh(DataList).Options;
end;

procedure TColumnEh.SetOptions(Value: TDBLookupGridEhOptions);
begin
  TDBLookupGridEh(DataList).Options := Value;
end;

procedure TColumnEh.SetDropDownBox(const Value: TColumnDropDownBoxEh);
begin
  FDropDownBox.Assign(Value);
end;

function TColumnEh.GetOnDropDownBoxCheckButton: TCheckTitleEhBtnEvent;
begin
  Result := DataList.OnCheckButton;
end;

function TColumnEh.GetOnDropDownBoxDrawColumnCell: TDrawColumnEhCellEvent;
begin
  Result := DataList.OnDrawColumnCell;
end;

function TColumnEh.GetOnDropDownBoxGetCellParams: TGetCellEhParamsEvent;
begin
  Result := DataList.OnGetCellParams;
end;

function TColumnEh.GetOnDropDownBoxSortMarkingChanged: TNotifyEvent;
begin
  Result := DataList.OnSortMarkingChanged;
end;

function TColumnEh.GetOnDropDownBoxTitleBtnClick: TTitleEhClickEvent;
begin
  Result := DataList.OnTitleBtnClick;
end;

procedure TColumnEh.SetOnDropDownBoxCheckButton(const Value: TCheckTitleEhBtnEvent);
begin
  DataList.OnCheckButton := Value;
end;

procedure TColumnEh.SetOnDropDownBoxDrawColumnCell(const Value: TDrawColumnEhCellEvent);
begin
  DataList.OnDrawColumnCell := Value;
end;

procedure TColumnEh.SetOnDropDownBoxGetCellParams(const Value: TGetCellEhParamsEvent);
begin
  DataList.OnGetCellParams := Value;
end;

procedure TColumnEh.SetOnDropDownBoxSortMarkingChanged(const Value: TNotifyEvent);
begin
  DataList.OnSortMarkingChanged := Value;
end;

procedure TColumnEh.SetOnDropDownBoxTitleBtnClick(const Value: TTitleEhClickEvent);
begin
  DataList.OnTitleBtnClick := Value;
end;

procedure TColumnEh.SetMRUList(const Value: TMRUListEh);
begin
  FMRUList.Assign(Value);
end;

function TColumnEh.UsedLookupDataSet: TDataSet;
begin
  if Assigned(DropDownBox.ListSource) and Assigned(DropDownBox.ListSource.DataSet) then
    Result := DropDownBox.ListSource.DataSet
  else if Assigned(Field) then
    Result := Field.LookupDataSet
  else
    Result := nil;
end;

function TColumnEh.FullListDataSet: TDataSet;
begin
  Result := nil;
  if Field <> nil then
    Result := Field.LookupDataSet;
end;

procedure TColumnEh.SetDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    Changed(False);
  end;
end;

procedure TColumnEh.SetEditMask(const Value: string);
begin
  if FEditMask <> Value then
  begin
    FEditMask := Value;
    Changed(False);
  end;
end;

procedure TColumnEh.SetSTFilter(const Value: TSTColumnFilterEh);
begin
  FSTFilter.Assign(Value);
end;

function TColumnEh.CreateSTFilter: TSTColumnFilterEh;
begin
  Result := TSTColumnFilterEh.Create(Self);
end;

procedure TColumnEh.OptimizeWidth;
var
  List: TColumnsEhList;
begin
  if Assigned(Grid) then
  begin
    List := TColumnsEhList.Create;
    try
      List.Add(Self);
      Grid.OptimizeColsWidth(List);
    finally
      List.Free;
    end;
  end;
end;

function TColumnEh.GetShowImageAndText: Boolean;
begin
  Result := FShowImageAndText;
end;

procedure TColumnEh.SetShowImageAndText(const Value: Boolean);
begin
  if FShowImageAndText <> Value then
  begin
    FShowImageAndText := Value;
    Changed(False);
  end;
end;

procedure TColumnEh.Changed(AllItems: Boolean);
begin
  inherited Changed(AllItems);
end;

procedure TColumnEh.SetHideDuplicates(Value: Boolean);
begin
  if Value <> FHideDuplicates then
  begin
    FHideDuplicates := Value;
    Changed(False);
  end;
end;

function TColumnEh.GetLayout: TTextLayout;
begin
  if cvLayout in FAssignedValues
    then Result := FLayout
    else Result := DefaultLayout;
end;

procedure TColumnEh.SetLayout(Value: TTextLayout);
begin
  if (cvLayout in FAssignedValues) and (Value = FLayout) then Exit;
  FLayout := Value;
  Include(FAssignedValues, cvLayout);
  Changed(False);
end;

function TColumnEh.IsLayoutStored: Boolean;
begin
  Result := (cvLayout in FAssignedValues) and (FLayout <> DefaultLayout);
end;

function TColumnEh.DefaultLayout: TTextLayout;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.Layout
    else Result := tlTop;
end;

function TColumnEh.IsHighlightRequiredStored: Boolean;
begin
  Result := (cvHighlightRequired in FAssignedValues) and (FHighlightRequired <> DefaultHighlightRequired);
end;

function TColumnEh.GetHighlightRequired: Boolean;
begin
  if cvHighlightRequired in FAssignedValues
    then Result := FHighlightRequired
    else Result := DefaultHighlightRequired;
end;

procedure TColumnEh.SetHighlightRequired(Value: Boolean);
begin
  if (cvHighlightRequired in FAssignedValues) and (Value = FHighlightRequired) then Exit;
  FHighlightRequired := Value;
  Include(FAssignedValues, cvHighlightRequired);
  Changed(False);
end;

function TColumnEh.DefaultHighlightRequired: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.ColumnDefValues.HighlightRequired
    else Result := False;
end;

function TColumnEh.GetBiDiMode: TBiDiMode;
begin
  if (cvBiDiMode in FAssignedValues) or (Grid = nil)
    then Result := FBiDiMode
    else Result := Grid.BiDiMode;
end;

procedure TColumnEh.SetBiDiMode(Value: TBiDiMode);
begin
  if (cvBiDiMode in FAssignedValues) and (Value = FBiDiMode) then Exit;
  FBiDiMode := Value;
  Include(FAssignedValues, cvBiDiMode);
  Changed(False);
end;

function TColumnEh.IsBiDiModeStored: Boolean;
begin
  Result := cvBiDiMode in FAssignedValues;
end;

function TColumnEh.DrawTextBiDiModeFlagsReadingOnly: Longint;
begin
  if UseRightToLeftReading
    then Result := DT_RTLREADING
    else Result := 0;
end;

function TColumnEh.UseRightToLeftReading: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode <> bdLeftToRight);
end;

function TColumnEh.UseRightToLeftAlignment: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode = bdRightToLeft);
  if Assigned(Field) then
    Result := Result and OkToChangeFieldAlignment(Field, Alignment);
end;

function TColumnEh.UseRightToLeftScrollBar: Boolean;
begin
  Result := SysLocale.MiddleEast and
    (BiDiMode in [bdRightToLeft, bdRightToLeftNoAlign]);
end;

function TColumnEh.CalcRowHeight: Integer;
var
  K, Std: Integer;
  uFormat: Integer;
  Rec: Trect;
  FontData: TFontDataEh;
  NoDataWidth: Integer;
  IsTreeMode: Boolean;
  DrawPict: TPicture;
begin
  IsTreeMode := Grid.MemTableSupport and Grid.FIntMemTable.MemTableIsTreeList;
//  Std := Grid.CalcStdDefaultRowHeight;
  Std := Grid.FStdDefaultRowHeight; //Future optimization
  if (dghAutoFitRowHeight in Grid.OptionsEh) and not IsTreeMode then
  begin
    if not Grid.HandleAllocated then
      Grid.Canvas.Handle := GetDC(0);
    try
      if (GetColumnType = ctGraphicData) and Grid.DrawGraphicData then
      begin
        DrawPict := TPicture.Create;
        try
          if Assigned(Field) and Field.IsBlob then
            DrawPict.Assign(Field);
          Result := DrawPict.Height;
          if DrawPict.Width > Width then
            Result := Round(Result / (DrawPict.Width / Width));
        finally
          DrawPict.Free;
        end;
      end else
      begin
        GetFontData(Grid.Canvas.Font, FontData);
        Grid.Canvas.Font := Font;
        NoDataWidth := 4;
        if AlwaysShowEditButton then
          Inc(NoDataWidth, EditButtonsWidth);
        if (Grid.VisibleColumns.Count > 0) and (Self = Grid.VisibleColumns[0]) then
          Inc(NoDataWidth, Grid.GetCellTreeElmentsAreaWidth);
        if ShowImageAndText and Assigned(ImageList) then
          Inc(NoDataWidth, ImageList.Width + 4);
        Rec := Rect(0, 0, Width - NoDataWidth, Std);
        uFormat := DT_CALCRECT;
        if WordWrap then
          uFormat := uFormat + DT_WORDBREAK;
        K := DrawTextEh(Grid.Canvas.Handle, DisplayText, Length(DisplayText), Rec,
              uFormat);
        if K > Std then
        begin
          if Grid.Flat
            then K := K + 1
            else K := K + 3;
          if dgRowLines in Grid.Options then
            Inc(K, Grid.GridLineWidth);
        end else
          K := Std;
        Result := K;
      end;
    finally
      if not Grid.HandleAllocated then
      begin
        ReleaseDC(0, Grid.Canvas.Handle);
        Grid.Canvas.Handle := 0;
      end else
        SetFontData(FontData, Grid.Canvas.Font);
    end;
  end else
    Result := Std;
end;

function TColumnEh.CurLineWordWrap(RowHeight: Integer): Boolean;
var
  tm: TTextMetric;
  MinHeight: Integer;
  FontData: TFontDataEh;
  FontChanged: Boolean;
//  IsTreeMode: Boolean;
begin
//  IsTreeMode := Grid.MemTableSupport and Grid.FIntMemTable.MemTableIsTreeList;
//  if (dghAutoFitRowHeight in Grid.OptionsEh) and Grid.HandleAllocated and
//    not IsTreeMode then
//  begin
//Exit;//tmp
    FontChanged := False;
    if Grid.Canvas.Font.Handle <> Font.Handle then
    begin
      GetFontData(Grid.Canvas.Font, FontData);
      Grid.Canvas.Font := Font;
      FontChanged := True;
    end;
    GetTextMetrics(Grid.Canvas.Handle, tm);
    MinHeight := tm.tmExternalLeading + tm.tmHeight + tm.tmInternalLeading +
      Grid.FInterlinear;
    if (MinHeight < RowHeight)
      then Result := True
      else Result := False;
    if FontChanged then
      SetFontData(FontData, Grid.Canvas.Font);
//  end else
//    Result := Grid.FAllowWordWrap;
end;

function TColumnEh.GetCellHeight(Row: Integer): Integer;
begin
  Result := Grid.RowHeights[Row];
end;

function TColumnEh.GetTextEditing: Boolean;
begin
  if cvTextEditing in FAssignedValues
    then Result := FTextEditing
    else Result := DefaultTextEditing;
end;

procedure TColumnEh.SetTextEditing(const Value: Boolean);
begin
  if (cvTextEditing in FAssignedValues) or (Value <> DefaultTextEditing) or
    (Assigned(Grid) and (csLoading in Grid.ComponentState)) then
  begin
    FTextEditing := Value;
    Include(FAssignedValues, cvTextEditing);
  end;
  Changed(False);
end;

function TColumnEh.IsTextEditingStored: Boolean;
begin
  Result := (cvTextEditing in FAssignedValues) and (FTextEditing <> DefaultTextEditing);
end;

function TColumnEh.DefaultTextEditing: Boolean;
begin
  Result := not (GetColumnType in [ctKeyImageList..ctCheckboxes]);
end;

function TColumnEh.CanEditShow: Boolean;
begin
  FillColCellParams(VarColCellParamsEh);
  if not (csLoading in Grid.ComponentState) then
    GetColCellParams(False, VarColCellParamsEh);
  Result := VarColCellParamsEh.TextEditing; 
end;

function TColumnEh.IsTabStop: Boolean;
begin
  Result := Visible and not ReadOnly and Grid.DataLink.Active and
    Assigned(Field) and not (Field.FieldKind = fkCalculated) and
    not ReadOnlyField(Field);
end;

procedure TColumnEh.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('InRowLinePos', ReadInRowLinePos, WriteInRowLinePos, IsInRowLinePosStored);
  Filer.DefineProperty('InRowLineHeight', ReadInRowLineHeight, WriteInRowLineHeight, IsInRowLineHeightStored);
end;

procedure TColumnEh.ReadInRowLinePos(Reader: TReader);
begin
  InRowLinePos := Reader.ReadInteger;
end;

procedure TColumnEh.ReadInRowLineHeight(Reader: TReader);
begin
  InRowLineHeight := Reader.ReadInteger;
end;

procedure TColumnEh.WriteInRowLinePos(Writer: TWriter);
begin
  Writer.WriteInteger(InRowLinePos);
end;

procedure TColumnEh.WriteInRowLineHeight(Writer: TWriter);
begin
  Writer.WriteInteger(InRowLineHeight);
end;

function TColumnEh.IsInRowLinePosStored: Boolean;
begin
  Result := InRowLinePos <> 0;
end;

function TColumnEh.IsInRowLineHeightStored: Boolean;
begin
  Result := InRowLineHeight <> 1;
end;

function TColumnEh.GetCurrentFieldValueList: IMemTableDataFieldValueListEh;
begin
  if FieldValueList = nil then
    if STFilter.ListSource <> nil then
      FieldValueList := STFilter.GetFieldValueList
    else if Grid.FIntMemTable <> nil then
      FieldValueList := Grid.FIntMemTable.GetFieldValueList(STFilter.Column.FieldName);
  Result := FieldValueList;
end;

function TColumnEh.GetName: String;
begin
  Result := 'Column_' + IntToStr(Index) + '_' + FieldName;
end;

function TColumnEh.FullWidth: Integer;
begin
  Result := Width;
  if (Grid <> nil) and
     (Grid.VisibleColumns.Count > 0) and
     (Grid.VisibleColumns[0] = Self)
  then
    Inc(Result, Grid.FExtraFirstColumnWidth);
end;

{ TDBGridColumnsEh }

constructor TDBGridColumnsEh.Create(Grid: TCustomDBGridEh; ColumnClass: TColumnEhClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TDBGridColumnsEh.Add: TColumnEh;
begin
  Result := TColumnEh(inherited Add);
end;

function TDBGridColumnsEh.GetColumn(Index: Integer): TColumnEh;
begin
  Result := TColumnEh(inherited Items[Index]);
end;

function TDBGridColumnsEh.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

function TDBGridColumnsEh.GetState: TDBGridColumnsState;
begin
  Result := TDBGridColumnsState((Count > 0) and Items[0].IsStored);
end;

procedure TDBGridColumnsEh.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FColumns: TDBGridColumnsEh;
  published
    property Columns: TDBGridColumnsEh read FColumns write FColumns;
  end;

procedure TDBGridColumnsEh.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := FGrid.CreateColumns;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Columns);
  finally
    Wrapper.Columns.Free;
    Wrapper.Free;
  end;
end;

procedure TDBGridColumnsEh.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TDBGridColumnsEh.RebuildColumns;
begin
  AddAllColumns(True);
end;

procedure TDBGridColumnsEh.AddAllColumns(DeleteExisting: Boolean);
var
  I: Integer;
  FieldList: TObjectList;
begin
  FieldList := nil;
  if Assigned(FGrid) and Assigned(FGrid.DataSource) and
    Assigned(FGrid.Datasource.Dataset) then
  begin
    FGrid.BeginLayout;
    try
      if DeleteExisting then Clear;
      FieldList := TObjectList.Create(False);
      FGrid.GetDatasetFieldList(FieldList);
      for I := 0 to FieldList.Count - 1 do
        Add.FieldName := TField(FieldList[I]).FieldName
    finally
      FieldList.Free;
      FGrid.EndLayout;
    end
  end
  else
    if DeleteExisting then Clear;
end;

procedure TDBGridColumnsEh.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TDBGridColumnsEh.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TDBGridColumnsEh.SetColumn(Index: Integer; Value: TColumnEh);
begin
  Items[Index].Assign(Value);
end;

procedure TDBGridColumnsEh.SetState(NewState: TDBGridColumnsState);
begin
  if NewState = State then Exit;
  if NewState = csDefault
    then Clear
    else RebuildColumns;
end;

procedure TDBGridColumnsEh.Update(Item: TCollectionItem);
var
  Raw: Integer;
  OldWidth: Integer;
  ItemColumn: TColumnEh;
  FullWidth, NewWidth: Integer;
begin
  ItemColumn := TColumnEh(Item);
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if (Item = nil) then
  begin
    FGrid.SetSortMarkedColumns;
    FGrid.LayoutChanged;
  end else
  begin
    Raw := FGrid.DataToRawColumn(Item.Index);
    FGrid.InvalidateCol(Raw);
    if (FGrid.AutoFitColWidths = False) or (csDesigning in FGrid.ComponentState) then
    begin
      FullWidth := ItemColumn.FullWidth;
      if (FGrid.ColWidths[Raw] <> FullWidth) and
       not Grid.RowPanel.Active then
      begin
        if TColumnEh(Item).Visible
          then  NewWidth := TColumnEh(Item).Width
          else  NewWidth := iif(dgColLines in FGrid.Options, -1, 0);
        if (Grid.VisibleColumns.Count > 0) and (ItemColumn = Grid.VisibleColumns[0])
          then NewWidth := NewWidth + Grid.FExtraFirstColumnWidth;
        FGrid.ColWidths[Raw] := NewWidth;
      end else if FGrid.UseMultiTitle = True then
        FGrid.LayoutChanged;
    end else if FGrid.ColWidths[Raw] <> -1 then
    begin
      OldWidth := TColumnEh(Item).FInitWidth;
      TColumnEh(Item).FInitWidth :=
        MulDiv(TColumnEh(Item).FInitWidth,
                TColumnEh(Item).Width,
                FGrid.CellWidthToColWidth(TColumnEh(Item), FGrid.ColWidths[Raw]));
      if (Raw <> FGrid.ColCount - 1) then
      begin
        Inc(FGrid.Columns[Raw - FGrid.FIndicatorOffset + 1].FInitWidth,
          OldWIdth - FGrid.FColumns[Raw - FGrid.FIndicatorOffset].FInitWidth);
        if (FGrid.Columns[Raw - FGrid.FIndicatorOffset + 1].FInitWidth < 0)
          then FGrid.Columns[Raw - FGrid.FIndicatorOffset + 1].FInitWidth := 0;
      end;
      FGrid.LayoutChanged;
    end;
  end;
  if (FGrid.SelectedIndex >= Count) or
     ((Count > 0) and (FGrid.VisibleColumns.Count > 0) and (Items[FGrid.SelectedIndex].Visible = False))
  then
    FGrid.SelectedIndex := FGrid.VisibleColumns[0].Index;
  if FGrid.LayoutLock = 0 then
    FGrid.InvalidateEditor; //Need to comment to avoid FInplaceCol = -1 in set AlwoseShowEditor;
// To frequently calls Grid.UpdateAllDataRowHeights;
// Users will call UpdateAllDataRowHeights manually;
end;

function TDBGridColumnsEh.InternalAdd: TColumnEh;
begin
  Result := Add;
  Result.IsStored := False;
end;

function TDBGridColumnsEh.ExistFooterValueType(AFooterValueType: TFooterValueType): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
  begin
    if (Items[i].Footer.ValueType = AFooterValueType) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TDBGridColumnsEh.GetUpdateCount: Integer;
begin
  Result := inherited UpdateCount;
end;

procedure TDBGridColumnsEh.ActiveChanged;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].FieldValueList := nil;
    Items[i].FField := nil;
  end;
end;

procedure TDBGridColumnsEh.Assign(Source: TPersistent);
begin
  if Assigned(Grid) then
    Grid.BeginLayout;
  try
    inherited Assign(Source);
  finally
    if Assigned(Grid) then
      Grid.EndLayout;
  end;
end;

function TDBGridColumnsEh.GetNextTabColumn(
  ForColumn: TColumnEh; GoForward: Boolean): TColumnEh;
var
  ACol, Original: Integer;
begin
  Result := ForColumn;
  ACol := ForColumn.Index;
  Original := ACol;
  if Grid.RowPanel.Active and (Grid.RowPanel.TabNavigationType = rpntLeftToRightPriorityEh) then
    Result := GetNextHorzColumn(ForColumn, GoForward, True, True)
  else
    while True do
    begin
      if GoForward then
        Inc(ACol) else
        Dec(ACol);
      if ACol >= Count then
        Exit
      else if ACol < 0 then
        Exit;
      if ACol = Original then Exit;
      if Items[ACol].IsTabStop then
      begin
        Result := Items[ACol];
        Exit;
      end;
    end;
end;

function TDBGridColumnsEh.GetNextHorzColumn(
  ForColumn: TColumnEh; GoForward, TillTheLastCol, CheckTabStop: Boolean): TColumnEh;
var
  i, j: Integer;
  Column, MinColumn: TColumnEh;
  IsTabStop: Boolean;
begin
  MinColumn := nil;
  for i := 0 to Count-1 do
  begin
    Column := Items[i];
    if CheckTabStop
      then IsTabStop := Column.IsTabStop
      else IsTabStop := True;
    if not Column.Visible or not IsTabStop then Continue;
    if (Column.FRowPlacement.Top = ForColumn.FRowPlacement.Top) then
      if GoForward then
      begin
        if (Column.FRowPlacement.DataCellLeft > ForColumn.FRowPlacement.DataCellLeft) and
        ((MinColumn = nil) or (MinColumn.FRowPlacement.Left > Column.FRowPlacement.Left)) then
          MinColumn := Column
      end else
        if (Column.FRowPlacement.Left < ForColumn.FRowPlacement.Left) and
        ((MinColumn = nil) or (MinColumn.FRowPlacement.Left < Column.FRowPlacement.Left)) then
          MinColumn := Column;
  end;
  if MinColumn <> nil then
  begin
    Result := MinColumn;
    Exit;
  end;
  if not TillTheLastCol then
  begin
    Result := ForColumn;
    Exit;
  end;
  for j := 0 to Count-1 do
  begin
    if CheckTabStop
      then IsTabStop := Items[j].IsTabStop
      else IsTabStop := True;
    if not Items[j].Visible or not IsTabStop then Continue;
    if GoForward then
    begin
      if (Items[j].FRowPlacement.Top > ForColumn.FRowPlacement.Top) and
         ( (MinColumn = nil) or
          ((Items[j].FRowPlacement.Top <= MinColumn.FRowPlacement.Top) and
           (Items[j].FRowPlacement.Left <= MinColumn.FRowPlacement.Left)))
      then
        MinColumn := Items[j];
    end else
      if (Items[j].FRowPlacement.Top < ForColumn.FRowPlacement.Top) and
         ((MinColumn = nil) or
          ((Items[j].FRowPlacement.Top >= MinColumn.FRowPlacement.Top) and
           (Items[j].FRowPlacement.Left >= MinColumn.FRowPlacement.Left)))
      then
        MinColumn := Items[j];
  end;
  if MinColumn <> nil
    then Result := MinColumn
    else Result := ForColumn;
end;

function TDBGridColumnsEh.GetNextVertColumn(ForColumn: TColumnEh;
  GoForward: Boolean): TColumnEh;
var
  i: Integer;
  Column, MinColumn, AUpDownBaseColumn: TColumnEh;

  function SegmentsIntersect(S1A, S1B, S2A, S2B: Integer): Boolean;
  begin
    Result := ((S1A >= S2A) and (S1A <= S2B)) or
              ((S1A <= S2A) and (S1B >= S2A));
  end;

begin
  Result := ForColumn;
  MinColumn := nil;
  if FUpDownBaseColumn = nil
    then AUpDownBaseColumn := ForColumn
    else AUpDownBaseColumn := FUpDownBaseColumn;
  for i := 0 to Count-1 do
  begin
    Column := Items[i];
    if not Column.Visible {or not Column.IsTabStop} then Continue;
    if GoForward then
    begin
      if (Column.FRowPlacement.Top > ForColumn.FRowPlacement.Top + ForColumn.FRowPlacement.Height) and
        SegmentsIntersect(AUpDownBaseColumn.FRowPlacement.Left, AUpDownBaseColumn.FRowPlacement.Left + AUpDownBaseColumn.FRowPlacement.Width,
                          Column.FRowPlacement.Left, Column.FRowPlacement.Left + Column.FRowPlacement.Width) then
        if MinColumn = nil then
          MinColumn := Column
        else if Column.FRowPlacement.Top < MinColumn.FRowPlacement.Top then
          MinColumn := Column
        else if (Column.FRowPlacement.Top = MinColumn.FRowPlacement.Top)
          and (Column.FRowPlacement.Left < MinColumn.FRowPlacement.Left)
        then
          MinColumn := Column
    end else
      if (Column.FRowPlacement.Top < ForColumn.FRowPlacement.Top) and
        SegmentsIntersect(AUpDownBaseColumn.FRowPlacement.Left, AUpDownBaseColumn.FRowPlacement.Left + AUpDownBaseColumn.FRowPlacement.Width,
                          Column.FRowPlacement.Left, Column.FRowPlacement.Left + Column.FRowPlacement.Width) then
        if MinColumn = nil then
          MinColumn := Column
        else if Column.FRowPlacement.Top > MinColumn.FRowPlacement.Top then
          MinColumn := Column
        else if (Column.FRowPlacement.Top = MinColumn.FRowPlacement.Top)
          and (Column.FRowPlacement.Left < MinColumn.FRowPlacement.Left)
        then
          MinColumn := Column;
  end;
  if MinColumn <> nil then
    Result := MinColumn;
end;

function TDBGridColumnsEh.GetTopColumn(ForColumn: TColumnEh): TColumnEh;
begin
  Result := GetNextVertColumn(ForColumn, False);
  while Result <> ForColumn do
  begin
    ForColumn := Result;
    Result := GetNextVertColumn(ForColumn, False);
  end;
end;

function TDBGridColumnsEh.GetBottomColumn(ForColumn: TColumnEh): TColumnEh;
begin
  Result := GetNextVertColumn(ForColumn, True);
  while Result <> ForColumn do
  begin
    ForColumn := Result;
    Result := GetNextVertColumn(ForColumn, True);
  end;
end;

function TDBGridColumnsEh.GetFirstTabColumn: TColumnEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if not Items[i].Visible or not Items[i].IsTabStop then Continue;
    Result := Items[i];
    Exit;
  end;
end;

function TDBGridColumnsEh.GetLastTabColumn: TColumnEh;
var
  i: Integer;
  Column: TColumnEh;
begin
  Result := nil;
  if Grid.RowPanel.Active and (Grid.RowPanel.TabNavigationType = rpntLeftToRightPriorityEh) then
  begin
    for i := 0 to Count-1 do
    begin
      Column := Items[i];
      if not Column.Visible or not Column.IsTabStop then Continue;
      if Result = nil then
        Result := Column
      else if Column.FRowPlacement.Top > Result.FRowPlacement.Top then
        Result := Column
      else if (Column.FRowPlacement.Top = Result.FRowPlacement.Top) and
              (Column.FRowPlacement.Left > Result.FRowPlacement.Left) then
        Result := Column;
    end;

  end else
  begin
    for i := Count-1 downto 0 do
    begin
      if not Items[i].Visible or not Items[i].IsTabStop then Continue;
      Result := Items[i];
      Exit;
    end;
  end;
end;

function TDBGridColumnsEh.FindColumnByName(ColumnName: String): TColumnEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if Items[i].Name = ColumnName then
    begin
      Result := Items[i];
      Exit;
    end;
  end;
end;

procedure TDBGridColumnsEh.GetColumnNames(List: TStrings);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    List.Add(Items[i].Name);
end;

{ TBookmarkListEh }

constructor TBookmarkListEh.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

procedure TBookmarkListEh.Clear;
begin
  inherited;
  FGrid.Selection.SelectionChanged;
end;

procedure TBookmarkListEh.SetCurrentRowSelected(Value: Boolean);
begin
  if Value and FGrid.DataSource.DataSet.IsEmpty then Exit;
  inherited SetCurrentRowSelected(Value);
  GridInvalidateRow(FGrid, FGrid.Row); // FGrid.InvalidateRow(FGrid.Row); vcl bug??
  //ddd
  if (FGrid.Selection.FSelectionType <> gstRecordBookmarks) and (Count > 0) then
  begin
    FGrid.Selection.Clear;
    FGrid.Selection.FSelectionType := gstRecordBookmarks;
  end;
  //\\\
end;

procedure TBookmarkListEh.DataChanged(Sender: TObject);
begin
  inherited DataChanged(Sender);
  FGrid.Selection.UpdateState;
  FGrid.Selection.SelectionChanged;
end;

procedure TBookmarkListEh.UpdateState;
begin
  FGrid.Selection.UpdateState;
end;

procedure TBookmarkListEh.Invalidate;
begin
  FGrid.Invalidate;
end;

function TBookmarkListEh.GetDataSet: TDataSet;
begin
  Result := FGrid.DataSource.DataSet;
end;

function TBookmarkListEh.SelectionToGridRect: TGridRect;
var
  TopRow, BottomRow: Integer;
  i, OldActive, ViewRowCount: Integer;
begin
  TopRow := -1;
  BottomRow := -1;
  if FGrid.DataLink.Active then
  begin
    if FGrid.ViewScroll then
    begin
      OldActive := FGrid.TopRow - FGrid.TopDataOffset;
      ViewRowCount := Min(OldActive + FGrid.VisibleDataRowCount, FGrid.RowCount-FGrid.TopDataOffset-1);
      for i := OldActive to ViewRowCount do
      begin
        FGrid.InstantReadRecordEnter(i);
        if IndexOf(FGrid.DataLink.DataSet.Bookmark) >= 0 then
        begin
          if TopRow = -1 then TopRow := i;
          if i > BottomRow then BottomRow := i;
        end;
        FGrid.InstantReadRecordLeave;
      end;
    end else
    begin
      OldActive := FGrid.DataLink.ActiveRecord;
      for i := 0 to FGrid.DataLink.RecordCount-1 do
      begin
        FGrid.DataLink.ActiveRecord := i;
        if IndexOf(FGrid.DataLink.DataSet.Bookmark) >= 0 then
        begin
          if TopRow = -1 then TopRow := i;
          if i > BottomRow then BottomRow := i;
        end;
      end;
      FGrid.DataLink.ActiveRecord := OldActive;
    end;
  end;
  if TopRow > -1
    then Result := GridRect(0, FGrid.TopDataOffset + TopRow, FGrid.ColCount-1, FGrid.TopDataOffset + BottomRow)
    else Result := GridRect(-1, -1, -1, -1);
end;

{ TToolTipsWindow }

type
  TToolTipsWindow = class(THintWindow)
  public
{$IFDEF CIL}
//    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TObject): TRect; override;
{$ELSE}
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
{$ENDIF}
  end;

{$IFDEF CIL}
//function TToolTipsWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TObject): TRect; override;
{$ELSE}
function TToolTipsWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  if AData <> nil then
    Canvas.Font.Assign(TFont(AData));
  Canvas.Font.Color := clWindowText;
  Result := inherited CalcHintRect(MaxWidth, AHint, AData);
end;
{$ENDIF}

{ TInplaceFilterEditEh }

procedure TInplaceFilterEditEh.CalcEditRect(var ARect: TRect);
begin
  inherited CalcEditRect(ARect);
  Inc(ARect.Top);
end;

procedure TInplaceFilterEditEh.InternalSetValue(AValue: Variant);
begin
  inherited;
end;

procedure TInplaceFilterEditEh.InternalUpdatePostData;
begin
  inherited;
end;

procedure TInplaceFilterEditEh.SelectAll;
begin
  SendMessage(Handle, EM_SETSEL, 0, -1);
end;

procedure TInplaceFilterEditEh.SetKeyDisplayText(AValue: Variant; AText: String);
begin
  Value := AValue;
  EditText := AText;
end;

procedure TInplaceFilterEditEh.SetVariantValue(const VariantValue: Variant);
begin
  inherited;
end;

procedure TInplaceFilterEditEh.CloseUp(Accept: Boolean);
begin
  if (Column <> nil) and Column.STFilter.FInFilterListBox
    then Exit
    else inherited CloseUp(Accept);
end;

function TDBGridFilterPopupListboxItemEh.GetColumn(Listbox: TPopupListboxEh): TColumnEh;
begin
  if Listbox.Owner is TCustomDBGridEh then
    Result := TCustomDBGridEh(Listbox.Owner).FInTitleFilterListboxColumn
  else
    Result := TInplaceFilterEditEh(Listbox.Owner).Column;
end;

function TDBGridFilterPopupListboxItemEh.GetGroupLevel(
  Listbox: TPopupListboxEh): TGridDataGroupLevelEh;
begin
  if Listbox.Owner is TCustomDBGridEh then
    Result := TCustomDBGridEh(Listbox.Owner).FInTitleFilterListboxGroupLevel
  else
    Result := nil;
end;

procedure TPopupListboxItemEhLine.DrawItem(Sender: TPopupListboxEh; ItemIndex:
  Integer; ARect: TRect; State: TOwnerDrawState);
begin
  Sender.Canvas.Pen.Color := clSilver;
  Sender.Canvas.Polyline([Point(ARect.Left, (ARect.Bottom+ARect.Top) div 2),
                          Point(ARect.Right,(ARect.Bottom+ARect.Top) div 2)]);
end;

function TPopupListboxItemEhLine.CanFocus(Sender: TPopupListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

{function TPopupListboxItemEhLine.CanCloseMouseUp(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button:
  TMouseButton; Shift: TShiftState): Boolean;
begin
  Result := False;
end;}

function TPopupListboxItemEhLine.CloseOnExecute(Sender: TPopupListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TPopupListboxItemEhLine.MouseUp(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState; var IsCloseListbox: Boolean);
begin
  inherited;
//  IsCloseListbox := False;
end;

constructor TPopupListboxItemEhSort.Create(ASortState: TSortMarkerEh);
begin
  inherited Create;
  FSortState := ASortState;
end;

procedure TPopupListboxItemEhSort.DrawItem(Sender: TPopupListboxEh; ItemIndex:
  Integer; ARect: TRect; State: TOwnerDrawState);
var
  SortMarkerIdx: Integer;
  SortMarkerPos: TPoint;
begin
  case FSortState of
    smDownEh: SortMarkerIdx := 0;
    smUpEh: SortMarkerIdx := 1;
  else SortMarkerIdx := -1;
  end;
  if (SortMarkerIdx >= 0) {and (ColorToRGB(Sender.Color) = ColorToRGB(clWindow))} then
    SortMarkerIdx := SortMarkerIdx + 3;
  if SortMarkerIdx <> -1 then
  begin
    SortMarkerPos := Point(
      (ARect.Left  + (ARect.Left + DefaultCheckBoxWidth + 2) - DBGridEhSortMarkerImages.Width) div 2,
      (ARect.Bottom + ARect.Top - DBGridEhSortMarkerImages.Height) div 2);
    if Sender.UseRightToLeftAlignment then
      SortMarkerPos.X := Sender.ClientWidth - SortMarkerPos.X - DBGridEhSortMarkerImages.Width;
    DBGridEhSortMarkerImages.Draw(Sender.Canvas,
      SortMarkerPos.X, SortMarkerPos.Y,SortMarkerIdx);
  end;
  if Sender.UseRightToLeftAlignment
    then ARect.Right := ARect.Right - DefaultCheckBoxWidth - 2
    else ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

function TPopupListboxItemEhSort.CanFocus(Sender: TPopupListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TPopupListboxItemEhSort.Execute(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
const
  SortMarkers: array[TSortOrderEh] of TSortMarkerEh = (smDownEh, smUpEh);
begin
  if GetGroupLevel(Sender) <> nil then
  begin
    if FSortState = smDownEh then
      GetGroupLevel(Sender).SortOrder := soAscEh
    else if FSortState = smUpEh then
      GetGroupLevel(Sender).SortOrder := soDescEh;
  end else
  begin
    GetColumn(Sender).Title.SortMarker := FSortState;
    GetColumn(Sender).Grid.DoSortMarkingChanged;
  end
end;

constructor TPopupListboxItemEhSpec.Create(AType: TPopupListboxItemEhSpecType);
begin
  inherited Create;
  FType := AType;
end;

procedure TPopupListboxItemEhSpec.DrawItem(Sender: TPopupListboxEh; ItemIndex:
  Integer; ARect: TRect; State: TOwnerDrawState);
var
  OldColor: TColor;
begin
  OldColor := Sender.Canvas.Brush.Color;
  Sender.Canvas.Brush.Color := Sender.Color;
  Sender.Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth + 2, ARect.Bottom));
  Sender.Canvas.Brush.Color := OldColor;
  ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

function TPopupListboxItemEhSpec.CanFocus(Sender: TPopupListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TPopupListboxItemEhSpec.Execute(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  Grid: TCustomDBGridEh;
begin
  Grid := GetColumn(Sender).Grid;
  case FType of
    ptFilterSpecItemClearFilter:
      GetColumn(Sender).Grid.ClearFilter;
    ptFilterSpecItemAll:
      GetColumn(Sender).STFilter.ExpressionStr := '';
    ptFilterSpecItemEmpties:
//      TInplaceFilterEditEh(GetColumn(Sender).Grid.FilterEdit).Text := '=Null';
      GetColumn(Sender).STFilter.ExpressionStr := '=Null';
    ptFilterSpecItemNotEmties:
      GetColumn(Sender).STFilter.ExpressionStr := '<>Null';
    ptFilterSpecItemDialog:
      begin
        if (GetColumn(Sender).Grid.FFilterCol <> -1) and
            (GetColumn(Sender).Grid.FilterEdit <> nil) and
            GetColumn(Sender).Grid.FilterEdit.Visible
        then
          GetColumn(Sender).Grid.SetFilterValue(GetColumn(Sender).Grid.FFilterCol);
        if StartDBGridEhColumnFilterDialog(GetColumn(Sender)) then
        begin
          if GetColumn(Sender).Grid.STFilter.InstantApply then
            GetColumn(Sender).Grid.SetDataFilter;
        end;
        Exit;
      end;
    ptFilterApply:
      GetColumn(Sender).Grid.SetDataFilter;
  end;
  if Grid <> nil then
    if (FType = ptFilterSpecItemClearFilter) or
       Grid.Center.FilterEditCloseUpApplyFilter or
       Grid.STFilter.InstantApply
    then
      Grid.SetDataFilter;
end;

{constructor TPopupListboxItemEhData.Create(AColumnFilter: TSTColumnFilterEh);
begin
  inherited Create;
//  FColumnFilter := AColumnFilter;
//  FColumnFilter.FPopupListboxDownIndex := -1;
end;}

procedure TPopupListboxItemEhData.DrawItem(Sender: TPopupListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TOwnerDrawState);
var
  CBRect: TRect;
  MouseIndex: Integer;
  IsDown, OldRigth: Integer;
  CBState: TCheckBoxState;
  IsActive: Boolean;
begin
  MouseIndex := Sender.ItemAtPos(Sender.ScreenToClient(Mouse.CursorPos), True);
  if GetColumn(Sender).STFilter.FPopupListboxDownIndex = ItemIndex
    then IsDown := -1
    else IsDown := 0;
  if GetColumn(Sender).STFilter.FListValuesCheckingState[ItemIndex] = True
    then CBState := cbChecked
    else CBState := cbUnchecked;
  IsActive := (MouseIndex >= 0) and (MouseIndex = ItemIndex) and (Mouse.Capture = 0);
  CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);
  if Sender.UseRightToLeftAlignment then
  begin
    OldRigth := CBRect.Right;
    CBRect.Right := Sender.ClientWidth - CBRect.Left;
    CBRect.Left := Sender.ClientWidth - OldRigth;
  end;
  PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Color,
    bcsCheckboxEh, IsDown, True, IsActive {odFocused in State}, True, CBState);

  if Sender.UseRightToLeftAlignment
    then ARect.Right := ARect.Right - DefaultCheckBoxWidth - 2
    else ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

function TPopupListboxItemEhData.CanFocus(Sender: TPopupListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

{function TPopupListboxItemEhData.CanCloseMouseUp(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button:
  TMouseButton; Shift: TShiftState): Boolean;
begin
  Result := False;
end;}

procedure TPopupListboxItemEhData.MouseDown(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  GetColumn(Sender).STFilter.FPopupListboxDownIndex := ItemIndex;
  Sender.InvalidateIndex(ItemIndex);
end;

procedure TPopupListboxItemEhData.MouseMove(Sender: TPopupListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
  if (GetColumn(Sender).STFilter.FPopupListboxDownIndex >= 0) and
     (GetColumn(Sender).STFilter.FPopupListboxDownIndex <> ItemIndex) then
  begin
    Sender.InvalidateIndex(GetColumn(Sender).STFilter.FPopupListboxDownIndex);
    GetColumn(Sender).STFilter.FPopupListboxDownIndex := -1;
  end;
end;

procedure TPopupListboxItemEhData.MouseUp(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState; var IsCloseListbox: Boolean);
var
  MousePos: TPoint;
  Index: Integer;
begin
  if GetColumn(Sender).STFilter.FPopupListboxDownIndex = ItemIndex then
  begin
    GetColumn(Sender).STFilter.FEnterNotClearData := True;
    Execute(Sender, ItemIndex, InItemPos, Shift);
    MousePos := Sender.ScreenToClient(Mouse.CursorPos);
    Index := Sender.ItemAtPos(MousePos, True);
    if Index < Sender.Items.Count then Sender.ItemIndex := Index;
  end;
  GetColumn(Sender).STFilter.FPopupListboxDownIndex := -1;
  Sender.InvalidateIndex(ItemIndex);
  IsCloseListbox := False;
end;

function TPopupListboxItemEhData.CloseOnExecute(Sender: TPopupListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TPopupListboxItemEhData.Execute(Sender: TPopupListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  i: Integer;
begin
  GetColumn(Sender).STFilter.FInFilterListBox := True;
  try
    if not GetColumn(Sender).STFilter.FEnterNotClearData then
      for i := 0 to Length(GetColumn(Sender).STFilter.FListValuesCheckingState)-1 do
      begin
        GetColumn(Sender).STFilter.FListValuesCheckingState[i] := False;
      end;
    GetColumn(Sender).STFilter.FListValuesCheckingState[ItemIndex] :=
      not GetColumn(Sender).STFilter.FListValuesCheckingState[ItemIndex];
    GetColumn(Sender).STFilter.UpdateFilterFromValuesCheckingState(Sender.Items);
//      TWinControlCracker(Sender).MouseMove(Shift, MousePos.X, MousePos.Y);
  finally
    GetColumn(Sender).STFilter.FInFilterListBox := False;
  end;
  Sender.InvalidateIndex(ItemIndex);
end;

procedure TPopupListboxItemEhData.KeyPress(Sender: TPopupListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean);
begin

end;

{ TCustomDBGridEh }

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then FreeAndNil(DrawBitmap);
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  B, R: TRect;
  Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin { Use ExtTextOut for solid colors }
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    WindowsExtTextOut(ACanvas.Handle, Left, ARect.Top + DY, ETO_OPAQUE or
      ETO_CLIPPED, ARect, Text, Length(Text));
  end else
  begin { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        DrawTextEh(Handle, Text, Length(Text), R, AlignFlags[Alignment]);
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

function MinimizeText(const Text: string; Canvas: TCanvas; MaxWidth: Integer): string;
var
  I: Integer;
begin
  Result := Text;
  I := 1;
  while (I <= Length(Text)) and (Canvas.TextWidth(Result) > MaxWidth) do
  begin
    Inc(I);
    Result := Copy(Text, 1, Max(0, Length(Text) - I)) + '...';
  end;
end;

{new WriteTextEh}{}
procedure WriteTextEh(ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer;
  Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; RightToLeftReading: Boolean);
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array[Boolean] of Integer = (0, DT_RTLREADING);
var
  txth, DrawFlag, Left, TextWidth, TextHeight, Top: Integer;
  lpDTP: TDrawTextParams;
  B: TRect;
//  TM: TTextMetric;
  I: TColorRef;
  BrushStyle: TBrushStyle;
  BrushColor: TColor;

  function RestrictClipRegionAlignment(Canvas: TCanvas; Rect: TRect): TRCRRec;
  var
    RectRgn: HRGN;
  begin
    {if UseRightToLeftAlignment then
    begin
      Rect.Left := ClientWidth - Rect.Left;
      Rect.Right := ClientWidth - Rect.Right;
    end;}
    Result.RectRgn := CreateRectRgn(0, 0, 0, 0);
    Result.Result := GetClipRgn(Canvas.Handle, Result.RectRgn);
    RectRgn := CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    ExtSelectClipRgn(Canvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);
  end;

  procedure RestoreClipRegion(Canvas: TCanvas; RCR: TRCRRec);
  begin
    if RCR.Result = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, RCR.RectRgn);
    DeleteObject(RCR.RectRgn);
  end;

  procedure DrawTextOnCanvas(ACanvas: TCanvas);
  var
    rect1, rect2: TRect;
    RCR: TRCRRec;
  begin
    DrawFlag := 0;
    if (MultyL = True) then DrawFlag := DrawFlag or DT_WORDBREAK;
    if (EndEllipsis = True) then DrawFlag := DrawFlag or DT_END_ELLIPSIS;
    DrawFlag := DrawFlag or AlignFlags[Alignment] or RTL[RightToLeftReading];

    rect1 := B; {}

    lpDTP.cbSize := SizeOf(lpDTP);
    lpDTP.uiLengthDrawn := Length(Text);
    lpDTP.iLeftMargin := LeftMarg;
    lpDTP.iRightMargin := RightMarg;

    InflateRect(rect1, -DX, -DY);

    if (Layout <> tlTop) {and (MultyL = True)} then
      txth := WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), {}
        rect1, DrawFlag or DT_CALCRECT, lpDTP) // Get rectangle.
    else txth := 0;
    rect1 := B; {}
    InflateRect(rect1, -DX, -DY);
    rect2 := rect1;

    case Layout of
      tlTop: ;
      tlBottom: rect1.top := rect1.Bottom - txth;
      tlCenter: rect1.top := rect1.top + ((rect1.Bottom - rect1.top) div 2) - (txth div 2);
    end;

    if DX > 0 then rect1.Bottom := rect1.Bottom + 1;
    if rect1.Top < rect2.Top then
      RCR := RestrictClipRegionAlignment(ACanvas, rect2);

    WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), rect1, DrawFlag, lpDTP);

    if rect1.Top < rect2.Top then
      RestoreClipRegion(ACanvas, RCR);
 end;

begin

//  Exit; //tmp
  I := ColorToRGB(ACanvas.Brush.Color);
  if (GetNearestColor(ACanvas.Handle, I) = I) then
  begin { Use ExtTextOut for solid colors and single-line text}
    if MultyL or (LeftMarg <> 0) or (RightMarg <> 0) then
    begin
      B := ARect;
      BrushStyle := ACanvas.Brush.Style;
      BrushColor := ACanvas.Brush.Color;
      if FillRect
        then ACanvas.FillRect(B)
        else ACanvas.Brush.Style := bsClear;
      DrawTextOnCanvas(ACanvas);
      if not FillRect then
      begin
        ACanvas.Brush.Style := BrushStyle;
        ACanvas.Brush.Color := BrushColor;
      end;
    end else
    begin
      if EndEllipsis then Text := MinimizeText(Text, ACanvas, ARect.Right - ARect.Left - DX);
      if (Alignment <> taLeftJustify) and (ACanvas.Font.Style * [fsBold, fsItalic] <> []) then
      begin
        TextWidth := GetTextWidth(ACanvas, Text)
      end else
        TextWidth := ACanvas.TextWidth(Text);

      case Alignment of
        taLeftJustify:
          Left := ARect.Left + DX;
        taRightJustify:
          Left := ARect.Right - TextWidth - 3;
      else { taCenter }
        if (ARect.Right > ARect.Left) then // PVA
          Left := ARect.Left + (ARect.Right - ARect.Left) shr 1 - (TextWidth shr 1)
        else
          Left := 0;
   //      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1 - (TextWidth shr 1);
      end;

      Top := ARect.Top;
      if Layout <> tlTop then
      begin
        TextHeight := ACanvas.TextHeight(Text);
        if ARect.Bottom - ARect.Top - DY > TextHeight then
        case Layout of
          tlCenter: Top := (ARect.Bottom + ARect.Top - TextHeight) div 2  - DY;
          tlBottom: Top := ARect.Bottom - TextHeight - DY;
        end;
      end;

      BrushColor := ACanvas.Brush.Color;
      BrushStyle := ACanvas.Brush.Style;
      if not FillRect then
        ACanvas.Brush.Style := bsClear;
      ACanvas.TextRect(ARect, Left, Top + DY, Text);
      if not FillRect then
      begin
        ACanvas.Brush.Style := BrushStyle;
        ACanvas.Brush.Color := BrushColor;
      end;
    end;
  end
  else begin
    DrawBitmap.Canvas.Lock;
    try
      DrawBitmap.Width := Max(DrawBitmap.Width, ARect.Right - ARect.Left);
      DrawBitmap.Height := Max(DrawBitmap.Height, ARect.Bottom - ARect.Top);
      B := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      DrawBitmap.Canvas.Font := ACanvas.Font;
      DrawBitmap.Canvas.Font.Color := ACanvas.Font.Color;
      DrawBitmap.Canvas.Brush := ACanvas.Brush;
      DrawBitmap.Canvas.Brush.Style := bsSolid;

      SetBkMode(DrawBitmap.Canvas.Handle, TRANSPARENT);

      {if (FillRect = True) then } DrawBitmap.Canvas.FillRect(B);

      DrawTextOnCanvas(DrawBitmap.Canvas);

      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

function CreateVerticalFont(Font: TFont): HFont;
var
  LogFont: TLogFont;
begin
  with LogFont do
  begin
    lfEscapement := 900;
    lfOrientation := 900;

    lfHeight := Font.Height;
    lfWidth := 0; { have font mapper choose }
    if fsBold in Font.Style
      then lfWeight := FW_BOLD
      else lfWeight := FW_NORMAL;
    lfItalic := Byte(fsItalic in Font.Style);
    lfUnderline := Byte(fsUnderline in Font.Style);
    lfStrikeOut := Byte(fsStrikeOut in Font.Style);
    lfCharSet := Byte(Font.Charset);
{$IFDEF CIL}
    if NlsCompareText(Font.Name, 'Default') = 0 // do not localize
      then lfFaceName := DefFontData.Name
      else lfFaceName := Font.Name;
{$ELSE}
{$IFDEF EH_LIB_12}
    if NlsCompareText(Font.Name, 'Default') = 0 // do not localize
      then StrPLCopy(lfFaceName, String(DefFontData.Name), Length(DefFontData.Name))
      else StrPLCopy(lfFaceName, String(Font.Name), Length(Font.Name));
{$ELSE}
    if NlsCompareText(Font.Name, 'Default') = 0 // do not localize
      then StrPCopy(lfFaceName, DefFontData.Name)
      else StrPCopy(lfFaceName, Font.Name);
{$ENDIF}
{$ENDIF}
    lfQuality := DEFAULT_QUALITY;
    { Everything else as default }
    lfOutPrecision := OUT_TT_ONLY_PRECIS; //OUT_DEFAULT_PRECIS;
    lfClipPrecision := CLIP_DEFAULT_PRECIS;
    case Font.Pitch of
      fpVariable: lfPitchAndFamily := VARIABLE_PITCH;
      fpFixed: lfPitchAndFamily := FIXED_PITCH;
    else
      lfPitchAndFamily := DEFAULT_PITCH;
    end;
  end;

  Result := CreateFontIndirect(LogFont);
end;

procedure Swap(var a, b: Integer);
var c: Integer;
begin
  c := a;
  a := b;
  b := c;
end;

function WriteTextVerticalEh(ACanvas:TCanvas;
                          ARect: TRect;          // Draw rect and ClippingRect
                          FillRect:Boolean;      // Fill rect Canvas.Brash.Color
                          DX, DY: Integer;       // InflateRect(Rect, -DX, -DY) for text
                          Text: string;          // Draw text
                          Alignment: TAlignment; // Text alignment
                          Layout: TTextLayout;   // Text layout
                          EndEllipsis:Boolean;   // Truncate long text by ellipsis
                          CalcTextExtent:Boolean   //
                          ):Integer;
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  B, R: TRect;
  Left, Top, TextWidth: Integer;
  I: TColorRef;
  tm: TTextMetric;
  otm: TOutlineTextMetric;
  Overhang: Integer;
  BrushStyle: TBrushStyle;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  Swap(ARect.Top, ARect.Bottom);

  ACanvas.Font.Handle := CreateVerticalFont(ACanvas.Font);
  try
    GetTextMetrics(ACanvas.Handle, tm);
    Overhang := tm.tmOverhang;
    if (tm.tmPitchAndFamily and TMPF_TRUETYPE <> 0) and
      (ACanvas.Font.Style * [fsItalic] <> []) then
    begin
      otm.otmSize := SizeOf(otm);
      WindowsGetOutlineTextMetrics(ACanvas.Handle, otm.otmSize, otm);
      Overhang := (tm.tmHeight - tm.tmInternalLeading) * otm.otmsCharSlopeRun div otm.otmsCharSlopeRise;
    end;

    TextWidth := ACanvas.TextWidth(Text);
    Result := TextWidth + Overhang;
    if CalcTextExtent then Exit;

    if (not FillRect) or (GetNearestColor(ACanvas.Handle, I) = I) then
    begin { Use ExtTextOut for solid colors }
      case Alignment of
        taLeftJustify:
          Left := ARect.Left + DX;
        taRightJustify:
          Left := ARect.Right - ACanvas.TextHeight(Text);
      else { taCenter }
        Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
          - ((ACanvas.TextHeight(Text) + tm.tmOverhang) shr 1);
      end;
      case Layout of
        tlTop: Top := ARect.Bottom + TextWidth + Overhang; // + 3;
        tlBottom: Top := ARect.Top - DY;
      else
        Top := ARect.Top - (ARect.Top - ARect.Bottom) shr 1
          + ((TextWidth + Overhang) shr 1);
      end;
      BrushStyle := ACanvas.Brush.Style;
      if not FillRect then
        ACanvas.Brush.Style := bsClear;
      ACanvas.TextRect(ARect, Left, Top, Text);
      if not FillRect then
        ACanvas.Brush.Style := BrushStyle;
    end else
    begin { Use FillRect and Drawtext for dithered colors }
      DrawBitmap.Canvas.Lock;
      try
        with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
        begin { brush origin tics in painting / scrolling.    }
          Width := Max(Width, Right - Left);
          Height := Max(Height, Top - Bottom);
          R := Rect(DX, Top - Bottom - 1, Right - Left - 1, DY);
          B := Rect(0, 0, Right - Left, Top - Bottom);
        end;
        with DrawBitmap.Canvas do
        begin
          Font := ACanvas.Font;
          Font.Color := ACanvas.Font.Color;
          Brush := ACanvas.Brush;
          Brush.Style := bsSolid;
          FillRect(B);
          SetBkMode(Handle, TRANSPARENT);
          DrawTextEh(Handle, Text, Length(Text), R,
            AlignFlags[Alignment]);
        end;
        ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
      finally
        DrawBitmap.Canvas.Unlock;
      end;
    end;
  finally
    ACanvas.Font.Height := ACanvas.Font.Height;
  end;
end;

procedure DrawClipped(imList: TCustomImageList; Bitmap: TBitmap;
  ACanvas: TCanvas; ARect: TRect; Index,
  ALeftMarg: Integer; Align: TAlignment);
var CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;
  bmWidth, bmHeight: Integer;
begin
  if Assigned(imList) then
  begin
    bmWidth := imList.Width;
    bmHeight := imList.Height;
  end else
  begin
    bmWidth := Bitmap.Width;
    bmHeight := Bitmap.Height;
  end;
  case Align of
    taLeftJustify: x := ARect.Left + ALeftMarg;
    taRightJustify: x := ARect.Right - bmWidth + ALeftMarg;
  else
    x := (ARect.Right + ARect.Left - bmWidth) div 2 + ALeftMarg;
  end;
  y := (ARect.Bottom + ARect.Top - bmHeight) div 2;
  CheckedRect := Rect(X, Y, X + bmWidth, Y + bmHeight);
  UnionRect(AUnionRect, CheckedRect, ARect);
  if EqualRect(AUnionRect, ARect) then // ARect containt image
    if Assigned(imList)
      then imList.Draw(ACanvas, X, Y, Index)
      else ACanvas.Draw(X, Y, Bitmap)
  else
  begin // Need clip
    OldRectRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(ACanvas.Handle, OldRectRgn);
    RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    //SelectClipRgn(ACanvas.Handle, RectRgn);
    ExtSelectClipRgn(ACanvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);

    if Assigned(imList)
      then imList.Draw(ACanvas, X, Y, Index)
      else ACanvas.Draw(X, Y, Bitmap);

    if r = 0
      then SelectClipRgn(ACanvas.Handle, 0)
      else SelectClipRgn(ACanvas.Handle, OldRectRgn);
    DeleteObject(OldRectRgn);
  end;
end;

constructor TCustomDBGridEh.Create(AOwner: TComponent);

{$ifdef eval}
{$INCLUDE eval}
{$else}
begin
{$endif}

  inherited Create(AOwner);
//  TNastyComponentEh(Self).FComponentState := TNastyComponentEh(Self).FComponentState + [csDesigning];
  RegetDefaultStyle;
  FCenter := DBGridEhCenter;
  inherited DefaultDrawing := False;
  FAcquireFocus := True;
//  FTitleOffset := 0;
//  FTopDataOffset := GetTopDataOffset;
  FGridRowPanel := TGridRowPanelEh.Create(Self);
  FIndicatorOffset := 1;
  FUpdateFields := True;
  FOptions := [dgEditing, dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
  DesignOptionsBoost := [goColSizing];
  VirtualView := True;
  UsesBitmap;
  ScrollBars := ssHorizontal;
  inherited Options := [goFixedHorzLine, goFixedVertLine, goHorzLine,
    goVertLine, goColSizing, goColMoving, goTabs, goEditing, goExtendVertLines];
  FColumnDefValues := CreateColumnDefValues;
  FColumns := CreateColumns;
  FVisibleColumns := TColumnsEhList.Create;
  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := TGridDataLinkEh.Create(Self);
  Color := clWindow;
  FooterColor := clWindow;
  ParentColor := False;
  FTitleFont := TFont.Create;
  FTitleFont.OnChange := TitleFontChanged;
  FSaveCellExtents := False;
  FUserChange := True;
  FDefaultDrawing := True;
  FBookmarks := TBookmarkListEh.Create(Self);
  HideEditor;

  FTitleHeight := 0;
  FTitleHeightFull := 0;
  FTitleLines := 0;
  SetLength(FLeafFieldArr, 0);
  FHeadTree := THeadTreeNode.CreateText('Root', 10, 0);
  FVTitleMargin := 10;
  FHTitleMargin := 0;
  FUseMultiTitle := False;
  FRowSizingAllowed := False;
  FDefaultRowChanged := False;
  FSumList := TDBGridEhSumList.Create(Self);
  FSumList.SumListChanged := SumListChanged;
  FSumList.OnRecalcAll := SumListRecalcAll;
  FSumList.OnAfterRecalcAll := SumListAfterRecalcAll;
  FHorzScrollBar := CreateScrollBar(sbHorizontal);
  FVertScrollBar := CreateScrollBar(sbVertical);
  FOptionsEh := [dghFixed3D, dghHighlightFocus, dghClearSelection,
    dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines];
  FSortMarkedColumns := TColumnsEhList.Create;
  FPressedCol := -1;
  FPressedDataCol := -1;
  FTopLeftVisible := True;
  FSelection := TDBGridEhSelection.Create(Self);
  FAllowedOperations := [alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh];
  FFooterFont := TFont.Create;
  FFooterFont.OnChange := FooterFontChanged;
  FInterlinear := 4;
  FAllowedSelections := [gstRecordBookmarks..gstAll];
  FColCellParamsEh := TColCellParamsEh.Create;
  FTryUseMemTableInt := True;
  FSTFilter := TSTDBGridEhFilter.Create(Self);
  FTitleImageChangeLink := TChangeLink.Create;
  FTitleImageChangeLink.OnChange := TitleImageListChange;
  FEvenRowColorStored := False;
  FOddRowColorStored := False;
  FOldActiveRecord := -1;
  FIndicatorTitle := TDBGridEhIndicatorTitle.Create(Self);
  FDummiFont := TFont.Create;
  FRecNoTextWidth := CalcIndicatorColWidth;
  FOldTopLeft.X := LeftCol;
  FOldTopLeft.Y := TopRow;
  FStdDefaultRowHeight := CalcStdDefaultRowHeight;
  FDataGrouping := TDBGridEhDataGroupsEh.Create(Self);
  FDrawnGroupList := TList.Create;
  FRowDetailPanel := TRowDetailPanelEh.Create(Self);
  FRowDetailControl := TRowDetailPanelControlEh.Create(Self);
  with FRowDetailControl do
  begin
    Name := 'RowDetailData';
    Visible := False;
    Parent := Self;
    SetBounds(0,0,0,0);
  end;
  if (FNoDesigntControler = False) and Assigned(DBGridEhDesigntControler) and (csDesigning in ComponentState) then
  begin
    DBGridEhDesigntControler.RegisterChangeSelectedNotification(Self);
    FDesignInfoCollection := TCollection.Create(DBGridEhDesigntControler.GetDesignInfoItemClass);
  end;
  UpdateGridDataWidth;
  UpdateGridDataHeight;
end;

constructor TCustomDBGridEh.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  FNoDesigntControler := True;
  Create(AOwner);
end;

destructor TCustomDBGridEh.Destroy;
begin
  Destroying;
  if (FNoDesigntControler = False) and Assigned(DBGridEhDesigntControler) and (csDesigning in ComponentState) then
  begin
    DBGridEhDesigntControler.UnregisterChangeSelectedNotification(Self);
    FreeAndNil(FDesignInfoCollection);
  end;
  DataSource := nil;
  FreeAndNil(FIndicatorTitle);
  FIntMemTable := nil;
  if FStyle <> nil then
    FStyle.RemoveChangeNotification(Self);
  if FCenter <> nil then
    FCenter.RemoveChangeNotification(Self);
  FreeAndNil(FColCellParamsEh);
  if Assigned(Selection) then
    Selection.Clear;
  FreeAndNil(FDataGrouping);
  FreeAndNil(FDrawnGroupList);
  FreeAndNil(FColumns);
  FreeAndNil(FColumnDefValues);
  FreeAndNil(FVisibleColumns);
  FreeAndNil(FSortMarkedColumns);
  FreeAndNil(FDataLink);
  FreeAndNil(FHorzScrollBar);
  FreeAndNil(FVertScrollBar);
//  FIndicators.Free; FIndicators := nil;
  FreeAndNil(FTitleFont);
  FreeAndNil(FBookmarks);
  FreeAndNil(FTitleImageChangeLink);
  inherited Destroy;
  ReleaseBitmap;
//  FSortMarkerImages.Free;
  SetLength(FLeafFieldArr, 0);
  FreeAndNil(FHeadTree);
  FreeAndNil(FSumList);
  FreeAndNil(FSelection);
  FreeAndNil(FFooterFont);
  FreeAndNil(FSTFilter);
  if FHintFont <> nil then FreeAndNil(FHintFont);
  FreeAndNil(FDummiFont);
  FreeAndNil(FRowDetailPanel);
  FreeAndNil(FGridRowPanel);
end;

function TCustomDBGridEh.AcquireFocus: Boolean;
begin
  Result := True;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
    // VCL Bug is fixed
    if not Result and (Screen.ActiveForm <> nil) and
      (Screen.ActiveForm.FormStyle = fsMDIForm) then
    begin
      Windows.SetFocus(Handle);
      Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
    end;
    // VCL Bug is fixed\\
  end;
  if not Result and (FFilterEdit <> nil) and FilterEdit.Focused then
    Result := True;
end;

function TCustomDBGridEh.RawToDataColumn(ACol: Integer): Integer;
begin
  Result := ACol - FIndicatorOffset;
end;

function TCustomDBGridEh.DataToRawColumn(ADataCol: Integer): Integer;
begin
  if RowPanel.Active
    then Result := FIndicatorOffset
    else Result := ADataCol + FIndicatorOffset;
end;

function TCustomDBGridEh.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TCustomDBGridEh.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then Columns.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TCustomDBGridEh.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TCustomDBGridEh.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      Columns.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

procedure TCustomDBGridEh.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
        if FLayoutLock = 1 then
          FColumns.EndUpdate;
      end;
    finally
      if FLayoutLock > 0 then
        Dec(FLayoutLock);
      EndUpdate;
    end;
  end;
end;

procedure TCustomDBGridEh.EndUpdate;
begin
  if FUpdateLock > 0
    then Dec(FUpdateLock);
end;

function TCustomDBGridEh.CanEditAcceptKey(Key: Char): Boolean;
begin
  with Columns[SelectedIndex] do
    if FDatalink.Active and Assigned(Field) then
    begin
      if TDBGridInplaceEdit(InplaceEditor).FReadOnlyStored
        then Result := not TDBGridInplaceEdit(InplaceEditor).ReadOnly
        else Result := True;
      if Assigned(KeyList) and (KeyList.Count > 0)
        then Result := Result
        else Result := Result and Field.IsValidChar(Key);
    end else
    begin
      if TDBGridInplaceEdit(InplaceEditor).FReadOnlyStored
        then Result := not TDBGridInplaceEdit(InplaceEditor).ReadOnly
        else Result := False;
    end;
end;

function TCustomDBGridEh.CanEditModifyColumn(Index: Integer): Boolean;
begin
  Result := Columns[Index].CanModify(False) and (dgEditing in Options);
end;

function TCustomDBGridEh.CanEditModifyText: Boolean;
  function FieldCanModify(Field: TField): Boolean;
  var
    AFields: TObjectList;
  begin
    if (Field.FieldKind = fkLookUp) then
    begin
      Result := (Field.KeyFields <> '');
      AFields := TObjectList.Create(False);
      try
        Field.Dataset.GetFieldList(AFields, Field.KeyFields);
        Result := Result and FieldsCanModify(AFields);
      finally
        AFields.Free;
      end;
    end else
      Result := Field.CanModify;
  end;
begin
  Result := False;
  if TDBGridInplaceEdit(InplaceEditor).FReadOnlyStored then
  begin
    Result := not TDBGridInplaceEdit(InplaceEditor).ReadOnly;
    if Result then
    begin
      FDatalink.Edit;
      FDatalink.Modified;
    end else
      Exit;
  end;
  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly then
    with Columns[SelectedIndex] do
      if (not ReadOnly) and Assigned(Field) and FieldCanModify(Field)
        and (not Field.IsBlob or Assigned(Field.OnSetText)
            {d/}or ((DrawMemoText = True) and (Field.DataType in MemoTypes)) {d\})
        and CanModify(False) then
      begin
        FDatalink.Edit;
        Result := FDatalink.Editing;
        if Result then FDatalink.Modified;
      end;
end;

function TCustomDBGridEh.CanEditModify: Boolean;
begin
  {Result := False;
  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly then
  with Columns[SelectedIndex] do
    if (not ReadOnly) and Assigned(Field) and Field.CanModify
      and (not Field.IsBlob or Assigned(Field.OnSetText)) then
    begin
      FDatalink.Edit;
      Result := FDatalink.Editing;
      if Result then FDatalink.Modified;
    end;}
  Result := not (Columns[SelectedIndex].GetColumnType in [{ctKeyPickList,} ctCheckboxes]) and
    not FInplaceSearching and CanEditModifyText;
end;

function TCustomDBGridEh.CanEditShow: Boolean;
begin
  Result := (LayoutLock = 0) and inherited CanEditShow;
  if Result then
  begin
    Result := Result and (SelectedIndex < Columns.Count);
    Result := Result and Columns[SelectedIndex].CanEditShow;
    Result := Result and ((Selection.SelectionType = gstNon) or
      not (dghClearSelection in OptionsEh) or
      not (gstRectangle in AllowedSelections)
      );
    Result := Result and not FInplaceSearching;
    if not Result then
      HideEditor;
  end;
end;

function TCustomDBGridEh.CanEditorMode: Boolean;
begin
  Result := (dgAlwaysShowEditor in Options) and not FilterEditMode;
end;

procedure TCustomDBGridEh.CellClick(Column: TColumnEh);
begin
  if Assigned(FOnCellClick) then FOnCellClick(Column);
end;

procedure TCustomDBGridEh.ColEnter;
begin
  UpdateIme;
  if Assigned(FOnColEnter) then FOnColEnter(Self);
end;

procedure TCustomDBGridEh.ColExit;
begin
  if Assigned(FOnColExit) then FOnColExit(Self);
end;

procedure TCustomDBGridEh.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  STFilter.BeginUpdate;
  try
    FromIndex := RawToDataColumn(FromIndex);
    ToIndex := RawToDataColumn(ToIndex);
    Columns[FromIndex].Index := ToIndex;
    if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
  finally
    STFilter.EndUpdate;
  end;
  FFilterCol := SelectedIndex;
  UpdateFilterEdit(False);
end;

procedure TCustomDBGridEh.ColWidthsChanged;
var
  I, J, vi: Integer;
  OldWidth: Integer;
  Column: TColumnEh;

  procedure RecalcAutoFitRightCols(ForColumn: Integer);
  var
    i, RightWidth, Delta: Integer;
    ForColumnRef: TColumnEh;
  begin
    ForColumnRef := FColumns[ForColumn];
    RightWidth := 0;
    Delta := CellWidthToColWidth(ForColumnRef, ColWidths[ForColumn + FIndicatorOffset]) -
      ForColumnRef.Width;
    if (ForColumnRef.AutoFitColWidth) then
      ForColumnRef.FInitWidth :=
        MulDiv(ColWidths[ForColumn + FIndicatorOffset],
                ForColumnRef.FInitWidth,
                ForColumnRef.Width)
    else
      ForColumnRef.Width := CellWidthToColWidth(ForColumnRef, ColWidths[ForColumn + FIndicatorOffset]);
    for i := ForColumn + 1 to Columns.Count - 1 do
      if FColumns[i].Visible and FColumns[i].AutoFitColWidth
        then Inc(RightWidth, FColumns[i].Width);

    for i := ForColumn + 1 to Columns.Count - 1 do
      if FColumns[i].Visible and FColumns[i].AutoFitColWidth then
      begin
        FColumns[i].FInitWidth :=
          MulDiv(RightWidth - Delta, FColumns[i].FInitWidth, RightWidth);
        if (FColumns[i].FInitWidth <= 0) then FColumns[i].FInitWidth := 1;
      end;
  end;
begin
  STFilter.BeginUpdate;
  if (FDatalink.Active or (FColumns.State = csCustomized)) and AcquireLayoutLock then
  try
    inherited ColWidthsChanged;

    for I := FIndicatorOffset to FullColCount - 1 do
    begin
      Column := Columns[I - FIndicatorOffset];
      ColWidths[I] := ColWidthToCellWidth(Column,
        Column.AllowableWidth(CellWidthToColWidth(Column, ColWidths[I])));
    end;
    for I := FIndicatorOffset to FullColCount - 1 do
    begin
      Column := Columns[I - FIndicatorOffset];
      // FColumns[I - FIndicatorOffset].Width := ColWidths[I];
      if not Column.Visible then Continue;
      if (AutoFitColWidths = False) or (csDesigning in ComponentState) then
        Column.Width := CellWidthToColWidth(Column, ColWidths[I])
      else
        if (Column.Width <> CellWidthToColWidth(Column, ColWidths[I])) then
        begin
          if (dghResizeWholeRightPart in OptionsEh) then
          begin
            RecalcAutoFitRightCols(I - FIndicatorOffset);
          end else
          begin
            vi := -1;
            for j := 0 to VisibleColumns.Count - 1 do
              if (VisibleColumns[j] = FColumns[I - FIndicatorOffset]) then
              begin
                vi := j; Break;
              end;
            if vi <> -1 then
            begin
              if VisibleColumns[vi].AutoFitColWidth then
              begin
                OldWidth := VisibleColumns[vi].FInitWidth;
                VisibleColumns[vi].FInitWidth :=
                  MulDiv(VisibleColumns[vi].FInitWidth,
                         CellWidthToColWidth(VisibleColumns[vi], ColWidths[I]),
                         VisibleColumns[vi].Width);
                if (vi <> VisibleColumns.Count - 1) then
                begin
                  Inc(VisibleColumns[vi + 1].FInitWidth,
                       OldWIdth - VisibleColumns[vi].FInitWidth);
                  if (VisibleColumns[vi + 1].FInitWidth < 0) then
                    VisibleColumns[vi + 1].FInitWidth := 0;
                end;
              end
              else
                Column.Width := CellWidthToColWidth(Column, ColWidths[I]);
            end;
          end;
        end;
    end;
  finally
    EndLayout;
  end else
    inherited ColWidthsChanged;
  InvalidateEditor;
  if FDataLink.Active and MemTableSupport and AcquireLayoutLock then
    try
      UpdateAllDataRowHeights();
    finally
      EndLayout
    end
  else
    FColWidthsChanged := True;
  if Assigned(FOnColWidthsChanged) then FOnColWidthsChanged(Self);
  UpdateHorzExtScrollBar;

  STFilter.EndUpdate;
  UpdateFilterEdit(False);
end;

function TCustomDBGridEh.CreateColumns: TDBGridColumnsEh;
begin
  Result := TDBGridColumnsEh.Create(Self, TDBGridColumnEh);
end;

function TCustomDBGridEh.CreateColumnDefValues: TColumnDefValuesEh;
begin
  Result := TDBGridEhColumnDefValuesEh.Create(Self);
end;

function TCustomDBGridEh.CreateEditor: TInplaceEdit;
begin
  Result := TDBGridInplaceEdit.Create(Self);
end;

procedure TCustomDBGridEh.CreateWnd;
begin
  BeginUpdate; { prevent updates in WMSize message that follows WMCreate }
  try
    inherited CreateWnd;
  finally
    EndUpdate;
  end;
  if Flat
    then FInplaceEditorButtonWidth := FlatButtonWidth// + 1
    else FInplaceEditorButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  if FStdDefaultRowHeight > Round(FInplaceEditorButtonWidth * 3 / 2)
    then FInplaceEditorButtonHeight := DefaultEditButtonHeight(FInplaceEditorButtonWidth,  Flat)
    else FInplaceEditorButtonHeight := FStdDefaultRowHeight;
  if AutoFitColWidths or RowPanel.Active then
    LayoutChanged
  else if (LayoutLock = 0) and not (csLoading in ComponentState) then
  begin
    SetColumnAttributes;
    UpdateRowCount;
    UpdateActive;
  end;
  UpdateScrollBar;
  GroupPanelVisibleChanged;
  FOriginalImeName := ImeName;
  FOriginalImeMode := ImeMode;
  KeyProperyModified;
end;

procedure TCustomDBGridEh.DataChanged;
var
  VertSBVis: Boolean;
  ARecNoTextWidth: Integer;
begin
  if not HandleAllocated or FSumListRecalcing then Exit;
  if RowDetailPanel.Visible and FDataLink.Active and
     (DataSetCompareBookmarks(FDataLink.DataSet, FDataLink.FLastBookmark, FDataLink.DataSet.Bookmark) <> 0)
  then
    RowDetailPanel.Visible := False;
    
{  if DataGrouping.Active and
     FDataLink.Active and
     (FDataLink.DataSet.State = dsInsert)
   then
     DataGrouping.GroupDataTree.SetDataSetkeyValue;}

  if (csDesigning in ComponentState) and SumList.Active then
  begin
    FSumListRecalcing := True;
    try
      SumList.RecalcAll;
    finally
      FSumListRecalcing := False;
    end;
  end;
  ARecNoTextWidth := CalcIndicatorColWidth;
  if ARecNoTextWidth <> FRecNoTextWidth then
  begin
    FRecNoTextWidth := ARecNoTextWidth;
    FSizeChanged := True;
    LayoutChanged;
  end else
    UpdateRowCount;
  VertSBVis := VertScrollBar.IsScrollBarVisible;
  UpdateScrollBar;
  if (VertSBVis <> VertScrollBar.IsScrollBarVisible) then
  begin
    if (FAutoFitColWidths = True) {and (UpdateLock = 0)} and
      not (csDesigning in ComponentState)
      then DeferLayout;
    //Update;
    //LayoutChanged;
  end;
  UpdateActive;
  InvalidateEditor;
  UpdateRowDetailPanel;
  ValidateRect(Handle, nil);
  Invalidate;
end;

procedure TCustomDBGridEh.DefaultHandler(var Message);
var
  P: TPopupMenu;
  Cell: TGridCoord;
  WinMessage: TMessage;
begin
  inherited DefaultHandler(Message);
  WinMessage := UnwrapMessageEh(Message);
  if TMessage(WinMessage).Msg = wm_RButtonUp then
{$IFDEF CIL}
    with TWMRButtonUp.Create(WinMessage) do
{$ELSE}
    with TWMRButtonUp(Message) do
{$ENDIF}
    begin
      Cell := MouseCoord(XPos, YPos);
      if (Cell.X < FIndicatorOffset) or (Cell.Y < 0) then Exit;
      P := Columns[RawToDataColumn(Cell.X)].PopupMenu;
      if (P <> nil) and P.AutoPopup then
      begin
        SendCancelMode(nil);
        P.PopupComponent := Self;
        with ClientToScreen(SmallPointToPoint(Pos)) do
          P.Popup(X, Y);
        Result := 1;
      end;
    end;
end;

procedure TCustomDBGridEh.DeferLayout;
var
  M: TMsg;
begin
  if HandleAllocated and
    not PeekMessage(M, Handle, cm_DeferLayout, cm_DeferLayout, pm_NoRemove) then
    PostMessage(Handle, cm_DeferLayout, 0, 0);
  CancelLayout;
  EndUpdate;
end;

procedure TCustomDBGridEh.DefineFieldMap;
var
  I: Integer;
begin
  if FColumns.State = csCustomized then
  begin { Build the column/field map from the column attributes }
    DataLink.SparseMap := True;
    for I := 0 to FColumns.Count - 1 do
      FDataLink.AddMapping(FColumns[I].FieldName);
  end else { Build the column/field map from the field list order }
  begin
    FDataLink.SparseMap := False;
    with Datalink.Dataset do
      for I := 0 to FieldCount - 1 do
        with Fields[I] do if Visible then Datalink.AddMapping(FieldName);
  end;
end;

procedure TCustomDBGridEh.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
var
  Alignment: TAlignment;
  Value: string;
begin
  Alignment := taLeftJustify;
  Value := '';
  if Assigned(Field) then
  begin
    Alignment := Field.Alignment;
    Value := Field.DisplayText;
  end;
  WriteText(Canvas, Rect, 2, 2, Value, Alignment);
end;

procedure TCustomDBGridEh.DefaultDrawColumnCell(const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  Value: string;
  ARect, ARect1: TRect;
  XFrameOffs, YFrameOffs, KeyIndex: Integer;
  RowHeight: Integer;
begin
  ARect := Rect;
  if (dghFooter3D in OptionsEh) then
  begin
    XFrameOffs := 1;
    InflateRect(ARect, -1, -1);
  end else XFrameOffs := 2;
  YFrameOffs := XFrameOffs;
  if Flat then Dec(YFrameOffs);
  Value := Column.DisplayText;

{  if (Column.ImageList <> nil) and Column.ShowImageAndText then
  begin
    ARect1 := ARect;
    ARect1.Right := ARect1.Left + Column.ImageList.Width + 4;
    Canvas.Brush.Color := Column.Color;
    Canvas.FillRect(ARect);                            //FColCellParamsEh????
    DrawClipped(Column.ImageList, nil, Canvas, ARect1, FColCellParamsEh.FImageIndex, 0, taCenter);
    Canvas.Brush.Color := FColCellParamsEh.FBackground;
    ARect.Left := ARect1.Right + 1;
  end;}
  if FDataLink.Active and MemTableSupport
    then RowHeight := RowHeights[FIntMemTable.InstantReadCurRowNum + TopDataOffset]
    else RowHeight := FStdDefaultRowHeight;
  if Column.GetColumnType in [ctCommon..ctKeyPickList] then
    WriteTextEh(Canvas, ARect, True, XFrameOffs, YFrameOffs, Value,
      Column.Alignment, Column.Layout, Column.WordWrap and Column.CurLineWordWrap(RowHeight),
      Column.EndEllipsis, 0, 0, Column.UseRightToLeftReading)
  else if Column.GetColumnType = ctKeyImageList then
  begin
    Canvas.FillRect(ARect);
    if Column.Field = nil
      then KeyIndex := FColCellParamsEh.FImageIndex
      else KeyIndex := Column.KeyList.IndexOf(Column.Field.Text);
    if KeyIndex = -1
      then KeyIndex := Column.NotInKeyListIndex;
    DrawClipped(Column.ImageList, nil, Canvas, ARect, KeyIndex, 0, taCenter);
  end else if Column.GetColumnType = ctCheckboxes then
  begin
    Canvas.FillRect(ARect);
    ARect1.Left := ARect.Left + iif(ARect.Right - ARect.Left < DefaultCheckBoxWidth, 0,
      (ARect.Right - ARect.Left) shr 1 - DefaultCheckBoxWidth shr 1);
    ARect1.Right := iif(ARect.Right - ARect.Left < DefaultCheckBoxWidth, ARect.Right,
      ARect1.Left + DefaultCheckBoxWidth);
    ARect1.Top := ARect.Top + iif(ARect.Bottom - ARect.Top < DefaultCheckBoxHeight, 0,
      (ARect.Bottom - ARect.Top) shr 1 - DefaultCheckBoxHeight shr 1);
    ARect1.Bottom := iif(ARect.Bottom - ARect.Top < DefaultCheckBoxHeight, ARect.Bottom,
      ARect1.Top + DefaultCheckBoxHeight);

    //DrawCheck(Canvas.Handle,ARect1,Column.CheckboxState,True,Flat);
    PaintButtonControl {Eh}(Canvas, ARect1, Canvas.Brush.Color, bcsCheckboxEh,
      0, Flat, False, True, Column.CheckboxState);
  end else if Column.GetColumnType = ctGraphicData then
    DrawGraphicCell(Column, ARect, Canvas.Brush.Color);

end;

procedure TCustomDBGridEh.ReadDesignInfoCollection(Reader: TReader);
begin
  if FDesignInfoCollection <> nil then
  begin
    FDesignInfoCollection.Clear;
    Reader.ReadValue;
    Reader.ReadCollection(FDesignInfoCollection);
  end 
{$IFDEF EH_LIB_6}
    else Reader.SkipValue;
{$ELSE}
    ;
{$ENDIF}
end;

procedure TCustomDBGridEh.WriteDesignInfoCollection(Writer: TWriter);
begin
  Writer.WriteCollection(FDesignInfoCollection);
end;


procedure TCustomDBGridEh.ReadColumns(Reader: TReader);
begin
  Columns.Clear;
  Reader.ReadValue;
  Reader.ReadCollection(Columns);
end;

procedure TCustomDBGridEh.WriteColumns(Writer: TWriter);
begin
  Writer.WriteCollection(Columns);
end;

procedure TCustomDBGridEh.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('Columns', ReadColumns, WriteColumns,
    ((Columns.State = csCustomized) and (Filer.Ancestor = nil)) or
    ((Filer.Ancestor <> nil) and
    ((Columns.State <> TCustomDBGridEh(Filer.Ancestor).Columns.State) or
{$IFDEF EH_LIB_6}
    (not CollectionsEqual(Columns, TCustomDBGridEh(Filer.Ancestor).Columns, Self, TCustomDBGridEh(Filer.Ancestor)))
{$ELSE}
    (not CollectionsEqual(Columns, TCustomDBGridEh(Filer.Ancestor).Columns))
{$ENDIF}
    )));

  Filer.DefineProperty('DesignInfoCollection', ReadDesignInfoCollection, WriteDesignInfoCollection,
    (FDesignInfoCollection <> nil) and (FDesignInfoCollection.Count > 0));
//  Filer.DefineProperty('RowPanel', nil, nil, False);
end;

function TCustomDBGridEh.DeletePrompt: Boolean;
var
  Msg: string;
  Handle: THandle;
begin
  if (FBookmarks.Count > 1)
    then Msg := SDeleteMultipleRecordsQuestion
    else Msg := SDeleteRecordQuestion;
  Handle := GetFocus;
  Result := not (dgConfirmDelete in Options) or
    (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  if GetFocus <> Handle then
    Windows.SetFocus(Handle);
end;

var
  InplaceBitmap: TBitmap;

function GetInplaceBitmap(Width, Height: Integer): TBitmap;
begin
  if InplaceBitmap = nil then
    InplaceBitmap := TBitmap.Create;
  if InplaceBitmap.Width < Width then
    InplaceBitmap.Width := Width;
  if InplaceBitmap.Height < Height then
    InplaceBitmap.Height := Height;
  Result := InplaceBitmap;
end;

procedure TCustomDBGridEh.PaintInplaceButton(Column: TColumnEh; Canvas: TCanvas;
  ButtonStyle: TEditButtonStyleEh; Rect, ClipRect: TRect;
  DownButton: Integer; Active, Flat, Enabled: Boolean; ParentColor: TColor;
  Bitmap: TBitmap; TransparencyPercent: Byte);
const
  ButtonStyleFlags: array[TEditButtonStyleEh] of TDrawButtonControlStyleEh =
  (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh, bcsUpDownEh, bcsPlusEh, bcsMinusEh,
   bcsAltDropDownEh, bcsAltUpDownEh);
var
  LineRect: TRect;
  Brush: HBRUSH;
  IsClipRgn: Boolean;
  Rgn, SaveRgn: HRgn;
  r: Integer;
  NewBM: TBitmap;
  bf : BLENDFUNCTION;
  DestCanvas: TCanvas;
  IntersectedRect: TRect;
begin
  NewBM := nil;
  IntersectedRect := EmptyRect;
  DestCanvas := Canvas;
  if TransparencyPercent > 0 then
  begin
    NewBM := GetInplaceBitmap(Column.Grid.Width, Column.Grid.Height);
    DestCanvas := NewBM.Canvas;
    IntersectRect(IntersectedRect, Rect, ClipRect);
    Canvas.Brush.Color := ParentColor;
    Canvas.FillRect(IntersectedRect);
  end;

  IsClipRgn := (Rect.Left < ClipRect.Left) or (Rect.Right > ClipRect.Right) or
    (Rect.Bottom > ClipRect.Bottom) or (Rect.Top < ClipRect.Top);
  r := 0; SaveRgn := 0;
  if IsClipRgn then
  begin
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(DestCanvas.Handle, SaveRgn);
    with ClipRect do
      Rgn := CreateRectRgn(Left, Top, Right, Bottom);
    SelectClipRgn(DestCanvas.Handle, Rgn);
    DeleteObject(Rgn);
  end;

  if Flat and not ThemesEnabled then // Draw left button line
  begin
    LineRect := Rect;
    if Column.UseRightToLeftAlignment then
    begin
      LineRect.Right := LineRect.Left;
      LineRect.Left := LineRect.Left + 1;
    end else
      LineRect.Right := LineRect.Left + 1;
    Inc(Rect.Left, 1);
    if Active then
      FrameRect(DestCanvas.Handle, LineRect, GetSysColorBrush(COLOR_BTNFACE))
    else
    begin
      Brush := CreateSolidBrush(ColorToRGB(ParentColor));
      FrameRect(DestCanvas.Handle, LineRect, Brush);
      DeleteObject(Brush);
    end;
  end;
  if Self.UseRightToLeftAlignment and (DestCanvas = Canvas) then
  begin
    WindowsLPtoDP(DestCanvas.Handle, Rect);
    Swap(Rect.Left, Rect.Right);
    ChangeGridOrientation(False);
  end;

  if ButtonStyle = ebsGlyphEh then
  begin
    if Flat and not ThemesEnabled then
    begin
      Brush := CreateSolidBrush(ColorToRGB(ParentColor));
      FrameRect(DestCanvas.Handle, Rect, Brush);
      DeleteObject(Brush);
      InflateRect(Rect, -1, -1);
      FillRect(DestCanvas.Handle, Rect, GetSysColorBrush(COLOR_BTNFACE));
    end else
    begin
      DrawEdge(DestCanvas.Handle, Rect, EDGE_RAISED, BF_RECT or BF_MIDDLE);
      InflateRect(Rect, -2, -2);
    end;
    DrawClipped(nil, Bitmap, DestCanvas, Rect, 0, 0, taCenter);
    //DestCanvas.Draw(Rect.Left,Rect.Top,Bitmap)
  end
  else
    PaintButtonControlEh(DestCanvas, Rect, ParentColor, ButtonStyleFlags[ButtonStyle],
      DownButton, Flat, Active, Enabled, cbUnchecked);

  if Self.UseRightToLeftAlignment and (DestCanvas = Canvas) then
    ChangeGridOrientation(True);

  if IsClipRgn then
  begin
    if r = 0
      then SelectClipRgn(DestCanvas.Handle, 0)
      else SelectClipRgn(DestCanvas.Handle, SaveRgn);
    DeleteObject(SaveRgn);
  end;

  if TransparencyPercent > 0 then
  begin
    bf.BlendOp := AC_SRC_OVER;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := Trunc(255/100*(100-TransparencyPercent));
    bf.AlphaFormat := 0;
    Windows.AlphaBlend(Canvas.Handle,
      IntersectedRect.Left, IntersectedRect.Top,
      IntersectedRect.Right-IntersectedRect.Left, IntersectedRect.Bottom-IntersectedRect.Top,
      NewBM.Canvas.Handle,
      IntersectedRect.Left, IntersectedRect.Top,
      IntersectedRect.Right-IntersectedRect.Left, IntersectedRect.Bottom-IntersectedRect.Top,
      bf);
//    FreeAndNil(NewBM);
  end;
end;

function TCustomDBGridEh.DrawTitleByThemes: Boolean;
begin
{$IFDEF EH_LIB_7}
  Result := not Flat and ThemeServices.ThemesEnabled
    and (dghFixed3D in OptionsEh);
//    and (([dgColLines, dgRowLines] * Options) = [dgColLines, dgRowLines]);
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TCustomDBGridEh.IsDrawCellByThemes(ACol, ARow: Longint; AreaCol, AreaRow: Longint;
  AState: TGridDrawState; CellAreaType: TCellAreaTypeEh; Cell3D: Boolean): Boolean;
begin
  if ThemesEnabled and not Flat and Cell3D
    then Result := True
    else Result := False;
end;

{new DrawCell}
procedure TCustomDBGridEh.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
const
  CheckBoxFlags: array[TCheckBoxState] of Integer =
  (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
  EditToButtonStyle: array[TEditStyle] of TEditButtonStyleEh =
  (ebsDropDownEh, ebsEllipsisEh, ebsDropDownEh, ebsDropDownEh,
   ebsDropDownEh, ebsUpDownEh, ebsDropDownEh, ebsDropDownEh, ebsDropDownEh, ebsAltDropDownEh);
var
  CellAreaType: TCellAreaTypeEh;
  AreaCol, AreaRow: Integer;
  NewHeight: Integer;
  PanelRect: TRect;

begin
//  if FLockPaint then Exit;
  CellAreaType := GetCellAreaType(ACol, ARow, AreaCol, AreaRow);
  if RowDetailPanel.Visible and (Row = ARow) then
  begin
    NewHeight := CalcRowDataRowHeight(ARow-TopDataOffset);
    if ARect.Bottom - ARect.Top > NewHeight then
    begin
      PanelRect := ARect;
      ARect.Bottom := ARect.Top + NewHeight;
      PanelRect.Top := ARect.Top + NewHeight;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(PanelRect);
      if (FIntMemTable <> nil) and FIntMemTable.MemTableIsTreeList then
        if ACol = FixedCols - FrozenCols then
          DrawTreeArea(Canvas, PanelRect, True, True);
      if DataGrouping.IsGroupingWorks and
        (CellAreaType.HorzType = hctDataEh) and
        (AreaCol = VisibleColumns[0].Index)
      then
        DrawGroupDataArea(AreaCol, AreaRow, DataGrouping.ActiveGroupLevelsCount+1, AState, PanelRect, True);
    end;
  end;

  if RowPanel.Active then
  begin
    if CellAreaType.HorzType = hctIndicatorEh then
      DrawIndicatorCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType)
    else if CellAreaType.VertType = vctFooterEh then
      DrawFooterAsRowPanel(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType)
    else if CellAreaType.VertType = vctDataEh then
      DrawDataAsRowPanel(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType)
    else
      DrawTitleAsRowPanel(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType);
  end else
  begin
    if CellAreaType.HorzType = hctIndicatorEh then
      DrawIndicatorCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType)
    else if CellAreaType.VertType = vctFooterEh then
      DrawFooterCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType)
    else if CellAreaType.VertType = vctDataEh then
      DrawDataCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType)
    else
      DrawTitleCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType);
  end;
end;

procedure TCustomDBGridEh.DrawIndicatorCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  MultiSelected: Boolean;
  BackColor: TColor;
  Highlight: Boolean;
  Down: Boolean;
  LeftMarg: Integer;
  IndicatorType: TDBGridEhRowIndicatorTypeEh;
  The3DRect: Boolean;
  AFillRect, IndicatorRect, TextRect: TRect;
  ARecNo: Integer;
  SRecNo: String;
  AIndicatorWidth, AIndicatorOffset: Integer;
  ADrawByThemes: Boolean;
  ADrawGroupDataNode: TGroupDataTreeNodeEh;

  function RowIsMultiSelected: Boolean;
  begin
    if DataGrouping.IsGroupingWorks and (FDrawGroupDataNode.NodeType = dntDataGroupEh) then
      Result := (dgMultiSelect in Options) and Datalink.Active and (Selection.SelectionType in [gstAll])
    else
      Result := (dgMultiSelect in Options) and Datalink.Active and
        (Selection.SelectionType in [gstAll, gstRecordBookmarks]) and
        DataCellSelected(AreaCol, Datalink.Datasource.Dataset.Bookmark);
  end;

begin
  Canvas.Brush.Color := FixedColor;
  ADrawGroupDataNode := nil;
  The3DRect := CellHave3DRect(ACol, ARow, ARect, AState);
  ADrawByThemes := IsDrawCellByThemes(ACol, ARow, AreaCol, AreaRow, AState,
    CellAreaType, The3DRect);
  Down := False;
  Highlight := False;

  AFillRect := ARect;
  if The3DRect then
    if ADrawByThemes then
    begin
      InflateRect(AFillRect, 1, 1);
    end else if Flat then
    begin
      Inc(AFillRect.Left, 1);
      Inc(AFillRect.Top, 1);
    end else
    begin
      InflateRect(AFillRect, -1, -1);
    end;

  if dgIndicator in Options
    then AIndicatorWidth := IndicatorWidth
    else AIndicatorWidth := 0;
  if dghShowRecNo in OptionsEh then
  begin
    if AIndicatorWidth <> 0 then
      AIndicatorWidth := AIndicatorWidth - 2;
    AIndicatorOffset := 0;
  end else
    AIndicatorOffset := 1;

  MultiSelected := (Selection.SelectionType = gstAll);
  if CellAreaType.VertType = vctTitleEh then
  begin
    if MultiSelected then
    begin
      BackColor := Canvas.Brush.Color;
      Highlight := HighlightNoDataCellColor(ACol, ARow,
        AreaCol, AreaRow, CellAreaType, AState, MultiSelected, BackColor,
        Canvas.Font);
      Canvas.Brush.Color := BackColor;
    end;

    Down := IndicatorTitle.Down and FPressed;
    if Down
      then LeftMarg := 2
      else LeftMarg := 0;
    FillCellRect(ADrawByThemes, AFillRect, MultiSelected, False, EmptyRect, The3DRect);
    if IndicatorTitle.ShowDropDownSign then
    begin
      DrawIndicatorDropDownSign(ACol, ARow,
        Rect(ARect.Right-12+LeftMarg, ARect.Top+LeftMarg, ARect.Right, ARect.Bottom),
        Highlight);
    end;
  end else if (CellAreaType.VertType = vctDataEh) and
               Assigned(DataLink) and DataLink.Active then
  begin
    ARecNo := 0;
    if (AreaRow >= 0) and (AreaRow < InstantReadRecordCount) then // Indicator
    begin
      InstantReadRecordEnter(AreaRow);
      try
        MultiSelected := RowIsMultiselected;
        ARecNo := DataSource.DataSet.RecNo;
        ADrawGroupDataNode := FDrawGroupDataNode;
      finally
        InstantReadRecordLeave;
      end;
    end;
    Canvas.Font := Font;
    if IsCurrentRow(AreaRow) and ThemesEnabled then
      Canvas.Brush.Color := ApproachToColorEh(Canvas.Brush.Color, clBlack, 10);
    if MultiSelected then
    begin
      BackColor := Canvas.Brush.Color;
      Highlight := HighlightNoDataCellColor(ACol, ARow,
        AreaCol, AreaRow, CellAreaType, AState, MultiSelected, BackColor, Canvas.Font);
      Canvas.Brush.Color := BackColor;
    end;
    FillCellRect(ADrawByThemes, AFillRect, MultiSelected, False, EmptyRect, The3DRect);

    if (dgIndicator in Options) and IsCurrentRow(AreaRow) then
    begin
      IndicatorType := giNormalArrowEh;
      //FIndicators.BkColor := FixedColor; //??? to avoid ImageListChange event
      if FDataLink.DataSet <> nil then
        case FDataLink.DataSet.State of
          dsEdit: IndicatorType := giEditEh;
          dsInsert: IndicatorType := giInsertEh;
          dsBrowse:
            if IsCurrentRow(AreaRow) then
              if MultiSelected then
                IndicatorType := giSelectedArrowEh
              else if FInplaceSearching then
                IndicatorType := giInplaceSearch
              else
                IndicatorType := giNormalArrowEh;
        else IndicatorType := giNormalArrowEh; // multiselected and current row
        end;
      IndicatorRect := ARect;
      IndicatorRect.Left := IndicatorRect.Right - AIndicatorWidth;
      DrawRowIndicator(ACol, ARow, IndicatorRect, AIndicatorOffset, 0, IndicatorType);
      if ARow = FDatalink.ActiveRecord then
        FSelRow := ARow + TopDataOffset;
    end;
    if dghShowRecNo in OptionsEh then
    begin
      TextRect := ARect;
      Dec(TextRect.Right, AIndicatorWidth);
      Canvas.Font.Size := Canvas.Font.Size - 1;

      if (ARecNo <= 0) or
         ((DataLink.DataSet.State = dsInsert) and IsCurrentRow(AreaRow)) or
         (DataGrouping.IsGroupingWorks and (ADrawGroupDataNode.NodeType = dntDataGroupEh))
        then SRecNo := ''
        else SRecNo := IntToStr(ARecNo);

//      WriteTextEh(Canvas, TextRect, False, 0, 0, SRecNo, taCenter, tlCenter,
//        True, False, 0, 0, UseRightToLeftReading);
      WriteCellText(nil, Canvas, TextRect, False, 0, 0, SRecNo, taCenter, tlCenter,
        True, False, 0, 0);
    end;
  end else
  begin
    if MultiSelected then
    begin
      BackColor := Canvas.Brush.Color;
      Highlight := HighlightNoDataCellColor(ACol, ARow,
        AreaCol, AreaRow, CellAreaType, AState, MultiSelected, BackColor,
        Canvas.Font);
      Canvas.Brush.Color := BackColor;
    end;

    FillCellRect(ADrawByThemes, AFillRect, MultiSelected, False, EmptyRect, The3DRect);

    if (dghShowRecNo in OptionsEh) and
       (CellAreaType.VertType = vctFooterEh) and
       (AreaRow = 0) then
    begin
      TextRect := ARect;
      Dec(TextRect.Right, AIndicatorWidth);
      Canvas.Font := Font;
      Canvas.Font.Size := Canvas.Font.Size - 1;

      ARecNo := 0;
      if Assigned(DataLink) and DataLink.Active then
        ARecNo := DataLink.DataSet.RecordCount;
      if (ARecNo <= 0) or
         ((DataLink.DataSet.State = dsInsert) and IsCurrentRow(AreaRow))
        then SRecNo := ''
        else SRecNo := IntToStr(ARecNo);

//      WriteTextEh(Canvas, TextRect, False, 0, 0, SRecNo, taCenter, tlCenter,
//        True, False, 0, 0, UseRightToLeftReading);
      WriteCellText(nil, Canvas, TextRect, False, 0, 0, SRecNo, taCenter, tlCenter,
        True, False, 0, 0);
    end;

  end;

  if The3DRect then
  begin
//    InflateRect(ARect, 1, 1);
    if not ADrawByThemes then
      DrawEdgeEh(Canvas, ARect, Down, Highlight, True, not (Flat and ThemesEnabled));
  end;

end;

procedure TCustomDBGridEh.DrawTitleCellState(Column: TColumnEh;
ARect: TRect; AState: TGridDrawState; var ATitleState: TDBGirdDrawTitleStateEh);
var
  Title: TColumnTitleEh;
  BackColor: TColor;
  ImageWidth: Integer;
  AFillRect, ATextRect, ARect1: TRect;
  XFrameOffs, YFrameOffs: Integer;
  FilterButtonWidth: Integer;
  FilterButtonRect, FilterButtonFillRect, FilterSignRect, FilterButtonClipRect: TRect;
  TitleText: String;
  LeftMarg, RightMarg: Integer;
  SortMarkerIdx: Integer;
  SMTMarg: Integer;
  SMImageFit: Boolean;
  FillTextRect: Boolean;
  Layout: TTextLayout;
  BrushStyle: TBrushStyle;
  ADownButton: Integer;
  ButtonActive: Boolean;
  EditButtonTransparency: Integer;
begin
  Title := Column.Title;

  Canvas.Font := Title.Font;
  Canvas.Brush.Color := ATitleState.BackColor;
  ImageWidth := 0;

  AFillRect := ARect;
  ATextRect := AFillRect;

  if ATitleState.The3DRect then
  begin
    XFrameOffs := 1;
    if ATitleState.DrawByThemes then
    begin
      InflateRect(AFillRect, 1, 1);
      InflateRect(ATextRect, -1, -1);
    end else if Flat then
    begin
      Inc(AFillRect.Left, 1);
      Inc(AFillRect.Top, 1);
      InflateRect(ATextRect, -1, -1);
    end else
    begin
      InflateRect(AFillRect, -1, -1);
      InflateRect(ATextRect, -1, -1);
    end;
  end else
    XFrameOffs := 2;
  YFrameOffs := XFrameOffs;
  if Flat then Dec(YFrameOffs);

  if ATitleState.DrawFilterButton then
  begin
    if Flat then
    begin
      FilterButtonWidth := FlatButtonWidth;
      if not ThemesEnabled then
        Inc(FilterButtonWidth);
    end else
      FilterButtonWidth := GetSystemMetrics(SM_CXVSCROLL);

    if (ATextRect.Right - ATextRect.Left) div 2 < FilterButtonWidth then
      FilterButtonWidth := (ATextRect.Right - ATextRect.Left) div 2;

    FilterButtonRect := ATextRect;
    FilterButtonRect.Right := ATextRect.Right;
    FilterButtonRect.Left := FilterButtonRect.Right - FilterButtonWidth;
    FilterButtonFillRect := FilterButtonRect;
    if FilterButtonRect.Bottom - FilterButtonRect.Top > FInplaceEditorButtonHeight then
    begin
      FilterButtonRect.Top := (FilterButtonRect.Bottom + FilterButtonRect.Top -
        FInplaceEditorButtonHeight) div 2;
      FilterButtonRect.Bottom := FilterButtonRect.Top + FInplaceEditorButtonHeight;
    end;

    Dec(ATextRect.Right, FilterButtonWidth);
    FilterSignRect.Top := ATextRect.Top;
    FilterSignRect.Left := ATextRect.Right - 6;
    FilterSignRect.Right := ATextRect.Right;
    FilterSignRect.Bottom := FilterSignRect.Top + 6;
  end;

  if (TitleImages <> nil) and (Title.ImageIndex <> -1) then
  begin
    TitleText := '';
    ImageWidth := TitleImages.Width;
  end else
    TitleText := ATitleState.Caption;

  ARect1 := ATextRect;

  if ATitleState.Down then
  begin
    if (IsUseMultiTitle = True) or (TitleHeight <> 0) or (TitleLines <> 0) then
    begin
      LeftMarg := 2; RightMarg := -2; Inc(ARect1.Top, 2);
    end else
    begin
      LeftMarg := 1; RightMarg := -1; Inc(ARect1.Top, 1);
    end;
  end else
  begin
    LeftMarg := 0;
    RightMarg := 0;
  end;
  case ATitleState.SortMarker of
    smDownEh: SortMarkerIdx := 0;
    smUpEh: SortMarkerIdx := 1;
    else SortMarkerIdx := -1;
  end;

  SMTMarg := 0; SMImageFit := True;
  if SortMarkerIdx <> -1 then
  begin
    Dec(ARect1.Right, 16);
    if ATitleState.DrawSortIndex and (SortMarkedColumns.Count > 1) then
    begin
      Canvas.Font := SortMarkerFont;
      SMTMarg := Canvas.TextWidth(IntToStr(Title.SortIndex));
    end else
      SMTMarg := 0;
    if ARect1.Right < ARect1.Left + ImageWidth then
    begin
      ARect1.Right := ARect1.Right + 14 - SMTMarg;
      SMImageFit := False;
    end;
    if ARect1.Right < ARect1.Left + ImageWidth then
    begin
      ARect1.Right := ARect1.Right + 2 + SMTMarg;
      SMTMarg := 0;
    end;
  end;
  Canvas.Font.Charset := ATitleState.FontCharset;
  Canvas.Font.Color := ATitleState.FontColor;
  Canvas.Font.Size := ATitleState.FontSize;
  Canvas.Font.Name := ATitleState.FontName;
  Canvas.Font.Style := ATitleState.FontStyle;

  if ATitleState.DrawByThemes then
  begin
    FillCellRect(ATitleState.DrawByThemes, AFillRect, ATitleState.Down, ATitleState.CellMultiSelected, EmptyRect, ATitleState.The3DRect);
    FillTextRect := False;
  end else if Flat and ThemesEnabled then
  begin
    FillCellRect(ATitleState.DrawByThemes, AFillRect, ATitleState.Down, ATitleState.CellMultiSelected, EmptyRect, ATitleState.The3DRect);
    FillTextRect := False;
  end else
  begin
    Canvas.FillRect(Rect(ARect1.Right, AFillRect.Top, AFillRect.Right, AFillRect.Bottom));
    Canvas.FillRect(Rect(ARect1.Left, AFillRect.Top, ARect1.Right, ARect1.Top));
    FillTextRect := True;
  end;

  if ATitleState.WordWrap
    then Layout := tlCenter
    else Layout := tlTop;
  if ATitleState.Orientation = tohVertical then
    WriteTextVerticalEh(Canvas, ARect1, FillTextRect, XFrameOffs, YFrameOffs + 2,
      TitleText, taCenter{Title.Alignment}, tlBottom, Title.EndEllipsis, False)
  else
    WriteCellText(Column, Canvas, ARect1,
      FillTextRect, XFrameOffs, YFrameOffs, TitleText,
      Title.Alignment, Layout, ATitleState.WordWrap, Title.EndEllipsis, LeftMarg, RightMarg);

  if (TitleImages <> nil) and (Title.ImageIndex <> -1) then
  begin
    with TitleImages do
    begin
      if UseMultiTitle
        then DrawClipped(TitleImages, nil, Canvas, ARect1, Title.ImageIndex, LeftMarg, taCenter)
        else DrawClipped(TitleImages, nil, Canvas, ARect1, Title.ImageIndex, LeftMarg, Title.Alignment);
    end;
  end;
  if SortMarkerIdx <> -1 then
  begin
    if SMImageFit <> False then
    begin
    //FSortMarkerImages.BkColor := Canvas.Brush.Color; //??? to avoid ImageListChange event
      DBGridEhSortMarkerImages.Draw(Canvas, ATextRect.Right - DBGridEhSortMarkerImages.Width - 2 - SMTMarg + LeftMarg,
        (ATextRect.Bottom + ATextRect.Top - DBGridEhSortMarkerImages.Height) div 2 + LeftMarg, SortMarkerIdx);
    end;
    if SMTMarg <> 0 then
    begin
      Canvas.Font := SortMarkerFont;
      if ATitleState.Highlight = True
        then Canvas.Font.Color := clWhite;
      BrushStyle := Canvas.Brush.Style;
      BackColor := Canvas.Brush.Color;
      Canvas.Brush.Style := bsClear;
      Canvas.TextOut(ATextRect.Right - SMTMarg - 2 + LeftMarg,
        (ATextRect.Bottom + ATextRect.Top - DBGridEhSortMarkerImages.Height) div 2 + LeftMarg - 1,
        IntToStr(Title.SortIndex));
      Canvas.Brush.Style := BrushStyle;
      Canvas.Brush.Color := BackColor;
      Canvas.Font := TitleFont;
      if ATitleState.Highlight = True
        then Canvas.Font.Color := clWhite;
    end;
  end;

  if ATitleState.DrawFilterButton then
  begin
    if FillTextRect then
    begin
//        Canvas.Brush.Color
      Canvas.FillRect(FilterButtonFillRect);
    end;
    FilterButtonClipRect := FilterButtonRect;
    if ATitleState.Down then
      OffsetRect(FilterButtonRect, LeftMarg, LeftMarg);
    if FInTitleFilterListboxVisible and (FInTitleFilterListboxColumn = Column)
      then ADownButton := 1
      else ADownButton := 0;

    ButtonActive := False;
    if csDesigning in ComponentState then
      EditButtonTransparency := 30
    else if (IsMouseInRect(FilterButtonRect) and CanMouseTrackMode)
      or (FInTitleFilterListboxVisible and (FInTitleFilterListboxColumn = Column))
    then
    begin
      EditButtonTransparency := 0;
      ButtonActive := True;
    end else if (gdHotTrack in AState) and not FHotTrackMultiTitleOver and CanMouseTrackMode then
      EditButtonTransparency := 30
    else
      EditButtonTransparency := 80;

    PaintInplaceButton(Column, Canvas, Style.InTitleFitlerButtonStyle,
      FilterButtonRect,  FilterButtonFillRect,
      ADownButton, ButtonActive, Flat, DataLink.Active, Canvas.Brush.Color, nil,
      EditButtonTransparency);

    if Column.STFilter.ExpressionStr <> '' then
    begin
      if ATitleState.Down then
        OffsetRect(FilterSignRect, LeftMarg, LeftMarg);
      DrawFilterSign(FilterSignRect, ATitleState.CellMultiSelected);
    end;
  end;

  if ATitleState.The3DRect then
  begin
//    InflateRect(ARect, 1, 1);
    Canvas.Brush.Color := ATitleState.BackColor;
    if not ATitleState.DrawByThemes then
      DrawEdgeEh(Canvas, ARect, ATitleState.Down, ATitleState.Highlight,
        True, not (Flat and ThemesEnabled));
  end;

end;

procedure TCustomDBGridEh.DrawTitleCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
//  The3DRect: Boolean;
  AFillRect: TRect;
  ASubtRect: TRect;
  DrawColumn: TColumnEh;
  YFrameOffs: Byte;
  Title: TColumnTitleEh;
  ATitleState: TDBGirdDrawTitleStateEh;

  procedure DrawHost(ALeaf: THeadTreeNode; DHRect: TRect; AEndEllipsis: Boolean);
  var
    curLeaf: THeadTreeNode;
    curW: Integer;
    leftM, RightM: Integer;
    drawRec, drawRec1, DrawRecTheme, AFillRect: TRect;
    OldColor: TColor;
  begin
    DHRect.Bottom := DHRect.Top;
    if dgRowLines in Options then Dec(DHRect.Bottom);

    Dec(DHRect.Top, ALeaf.Host.Height);

    curLeaf := ALeaf.Host.Child;
    curW := 0;
    while curLeaf <> ALeaf do
    begin
      Inc(curW, curLeaf.Width);
      if dgColLines in Options then Inc(curW, 1);
      curLeaf := curLeaf.Next;
    end;
    Dec(DHRect.Left, curW); DHRect.Right := DHRect.Left + ALeaf.Host.Width;

    LeftM := DHRect.Left - ARect.Left; RightM := ARect.Right - DHRect.Right;

    drawRec := DHRect;
    drawRec.Left := ARect.Left; drawRec.Right := ARect.Right;

    if (RightM <> 0) then
    begin
      if ACol = (FixedCols - 1) then
      begin
        if (LeftCol = FixedCols) then
        begin
          Inc(RightM);
          Inc(drawRec.Right);
        end;
      end else
      begin
        Inc(RightM);
        Inc(drawRec.Right);
      end;
    end;

    AFillRect := drawRec;
    if (gdFixed in AState) and (dghFixed3D in OptionsEh) then
    begin
      InflateRect(drawRec, 0, -1);
      if ATitleState.DrawByThemes then
      begin
        InflateRect(AFillRect, 1, 1);
        if leftM <> 0 then
        Inc(AFillRect.Left);
      end else if Flat then
      begin
        if leftM = 0 then
        begin
          Inc(AFillRect.Left, 1);
          Inc(AFillRect.Top, 1);
        end;
      end else
        InflateRect(AFillRect, -1, -1);
    end;

    drawRec1 := drawRec;
    if (leftM = 0) then
    begin
      Canvas.FillRect(Rect(drawRec1.Left, drawRec1.Top, drawRec1.Left + 2, drawRec1.Bottom));
      Inc(drawRec1.Left, 2);
    end
    else Inc(LeftM, 2);

    if (RightM = 0) then
    begin
      Canvas.FillRect(Rect(drawRec1.Right - 2, drawRec1.Top, drawRec1.Right, drawRec1.Bottom));
      Dec(drawRec1.Right, 2);
    end
    else Inc(RightM, 2);

    if ATitleState.DrawByThemes then
    begin
      DrawRecTheme := Rect(drawRec1.Left, drawRec1.Top, drawRec1.Right, drawRec1.Bottom);
      FillCellRect(ATitleState.DrawByThemes, Rect(AFillRect.Left+leftM, AFillRect.Top,
                          AFillRect.Right-RightM, AFillRect.Bottom),
                     False, ATitleState.Highlight, AFillRect, ATitleState.The3DRect);
      WriteCellText(DrawColumn, Canvas, drawRec1, not ATitleState.DrawByThemes, 0,
        YFrameOffs, ALeaf.Host.Text, taCenter, tlCenter, True, AEndEllipsis, leftM, RightM);
    end else if Flat and ThemesEnabled and ATitleState.The3DRect then
    begin
      FillGradientEh(Canvas, AFillRect, clBtnHighlight, Canvas.Brush.Color);
      WriteCellText(DrawColumn, Canvas, drawRec1, False, 0,
        YFrameOffs, ALeaf.Host.Text, taCenter, tlCenter, True, AEndEllipsis, leftM, RightM);
    end else
      WriteCellText(DrawColumn, Canvas, drawRec1, not ATitleState.DrawByThemes, 0,
        YFrameOffs, ALeaf.Host.Text, taCenter, tlCenter, True, AEndEllipsis, leftM, RightM);

    ALeaf.Host.Drawed := True;

    if (gdFixed in AState) and (dghFixed3D in OptionsEh) and not ATitleState.DrawByThemes then
    begin
      InflateRect(drawRec, 0, 1);
      DrawEdgeEh(Canvas, drawRec, False, ATitleState.Highlight, leftM = 0, (RightM = 0) and not Flat);
    end;

    if (dgRowLines in Options) and not ATitleState.DrawByThemes then
    begin
      OldColor := Canvas.Pen.Color;
      Canvas.Pen.Color := GridLineColors.GetFixedHorzColor;
      Canvas.MoveTo(drawRec.Left, drawRec.Bottom);
      Canvas.LineTo(drawRec.Right, drawRec.Bottom);
      Canvas.Pen.Color := OldColor;
    end;

    if (dgColLines in Options) and not ATitleState.DrawByThemes then
    begin
      Canvas.Pen.Color := GridLineColors.GetFixedHorzColor;
      DrawPolyline([Point(drawRec.Right, drawRec.Top),
                     Point(drawRec.Right, drawRec.Bottom+1)]);
    end;

    if (ALeaf.Host.Host <> nil) and (ALeaf.Host.Host <> FHeadTree) then
    begin
      DrawHost(ALeaf.Host, DHRect, AEndEllipsis);
      ALeaf.Host.Host.Drawed := True;
    end;
  end;

begin

  ATitleState.The3DRect := CellHave3DRect(ACol, ARow, ARect, AState);
  ATitleState.DrawByThemes := IsDrawCellByThemes(ACol, ARow, AreaCol, AreaRow, AState,
    CellAreaType, ATitleState.The3DRect);
  ATitleState.Highlight := False;
  ATitleState.Down := False;

  DrawColumn := Columns[AreaCol];
  Title := DrawColumn.Title;

  ATitleState.BackColor := Title.Color;

  if ATitleState.The3DRect
    then YFrameOffs := 1
    else YFrameOffs := 2;

  if CellAreaType.VertType = vctTitleEh then
  begin
    ATitleState.Down := (FPressedDataCol = AreaCol) and FPressed and (FDBGridEhState = dgsNormal);
    if (IsUseMultiTitle = True) and (dgColLines in Options) then
    begin
      Dec(ARect.Right);
      Canvas.Pen.Color := GridLineColors.GetFixedHorzColor;
      DrawPolyline([Point(ARect.Right, ARect.Bottom-1),
                     Point(ARect.Right,ARect.Bottom-FLeafFieldArr[AreaCol].FLeaf.Height)]);
    end;
    ASubtRect := ARect;
    if IsUseMultiTitle = True then
    begin
      ASubtRect.Top := ARect.Bottom - FLeafFieldArr[AreaCol].FLeaf.Height + 1;// + 3;
      ATitleState.Caption := FLeafFieldArr[AreaCol].FLeaf.Text;
    end else
      ATitleState.Caption := Title.Caption;

    ATitleState.DrawFilterButton := False;
    ATitleState.SortMarker := Title.SortMarker;
    ATitleState.DrawSortIndex := True;

    if STFilter.Visible and (STFilter.Location = stflInTitleFilterEh) then
      ATitleState.DrawFilterButton := True;

    if (TitleImages <> nil) and (Title.ImageIndex <> -1) then
      ATitleState.Caption := '';

    if (DrawColumn.Field <> nil) and Assigned(FOnGetBtnParams) then
      FOnGetBtnParams(Self, DrawColumn, Canvas.Font,
        ATitleState.BackColor, ATitleState.SortMarker, ATitleState.Down);

    Canvas.Font := Title.Font;
    if (DrawColumn.Field <> nil) and Assigned(FOnGetBtnParams) then // To restore changed in FOnGetBtnParams font
      FOnGetBtnParams(Self, DrawColumn, Canvas.Font, ATitleState.BackColor,
        ATitleState.SortMarker, ATitleState.Down);

    ATitleState.CellMultiSelected := CellIsMultiSelected(ACol, ARow, AreaCol, NilBookmarkEh);
    ATitleState.Highlight := HighlightNoDataCellColor(ACol, ARow, AreaCol, AreaRow,
      CellAreaType, AState, ATitleState.CellMultiSelected, ATitleState.BackColor, Canvas.Font);
    if (SelectedIndex = AreaCol) and ThemesEnabled and RowPanel.Active then
      ATitleState.BackColor := ApproachToColorEh(ATitleState.BackColor, clBlack, 10);

    ATitleState.FontCharset := Canvas.Font.Charset;
    ATitleState.FontColor := Canvas.Font.Color;
    ATitleState.FontSize := Canvas.Font.Size;
    ATitleState.FontName := Canvas.Font.Name;
    ATitleState.FontStyle := Canvas.Font.Style;
    ATitleState.WordWrap := (UseMultiTitle = True) or (TitleHeight <> 0) or (TitleLines <> 0);
    ATitleState.Orientation := Title.Orientation;

    DrawTitleCellState(DrawColumn, ASubtRect, AState, ATitleState);
  end else // VertType = vctSubTitleEh
  begin
    AFillRect := ARect;
    ATitleState.CellMultiSelected := CellIsMultiSelected(ACol, ARow, AreaCol, NilBookmarkEh);
    if ATitleState.The3DRect and ATitleState.DrawByThemes then
      FillCellRect(ATitleState.DrawByThemes, AFillRect, False, ATitleState.CellMultiSelected, EmptyRect, ATitleState.The3DRect);
    DrawSubTitleCell(ACol, ARow, AreaCol, AreaRow, CellAreaType, AFillRect, AState, ATitleState.Highlight);

    if ATitleState.The3DRect then
    begin
  //    InflateRect(ARect, 1, 1);
      Canvas.Brush.Color := ATitleState.BackColor;
      if not ATitleState.DrawByThemes then
        DrawEdgeEh(Canvas, ASubtRect, False, ATitleState.Highlight, True, not (Flat and ThemesEnabled));
    end;
  end;

  if (CellAreaType.VertType = vctTitleEh) and (IsUseMultiTitle = True) then
    with DrawColumn.Title do
    begin // Draw mastertitle
      Canvas.Font := TitleFont;
      if ATitleState.Highlight then
      begin
        ATitleState.Highlight := HighlightNoDataCellColor(ACol, ARow, AreaCol, AreaRow,
          CellAreaType, AState, ATitleState.CellMultiSelected, ATitleState.BackColor, Canvas.Font);
        Canvas.Brush.Color := ATitleState.BackColor;
      end else
        Canvas.Brush.Color := ATitleState.BackColor;
      if (FLeafFieldArr[AreaCol].FLeaf.Host <> nil) and (FLeafFieldArr[AreaCol].FLeaf.Host <> FHeadTree) then
      begin
        DrawHost(FLeafFieldArr[AreaCol].FLeaf, ASubtRect, EndEllipsis);
      end;
    end;
{$IFDEF EH_LIB_6}
  if (csDesigning in ComponentState) and
      Assigned(DBGridEhDesigntControler) and
      (FNoDesigntControler = False) and
     DBGridEhDesigntControler.ControlIsObjInspSelected(DrawColumn) and
     (CellAreaType.VertType = vctTitleEh)
  then
  begin
    if DBGridEhDesigntControler.GetSelectComponentCornerImage <> nil then
    begin
      Canvas.StretchDraw(Rect(ARect.Left, ARect.Top, ARect.Left+8, ARect.Top+8), DBGridEhDesigntControler.GetSelectComponentCornerImage);
      Canvas.StretchDraw(Rect(ARect.Right-7, ARect.Top, ARect.Right+1, ARect.Top+8), DBGridEhDesigntControler.GetSelectComponentCornerImage);
      Canvas.StretchDraw(Rect(ARect.Right-7, ARect.Bottom-7, ARect.Right+1, ARect.Bottom+1), DBGridEhDesigntControler.GetSelectComponentCornerImage);
      Canvas.StretchDraw(Rect(ARect.Left, ARect.Bottom-7, ARect.Left+8, ARect.Bottom+1), DBGridEhDesigntControler.GetSelectComponentCornerImage);
    end else
    begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left+4, ARect.Top+4));
      Canvas.FillRect(Rect(ARect.Right, ARect.Top, ARect.Right-4, ARect.Top+4));
      Canvas.FillRect(Rect(ARect.Right, ARect.Bottom, ARect.Right-4, ARect.Bottom-4));
      Canvas.FillRect(Rect(ARect.Left, ARect.Bottom, ARect.Left+4, ARect.Bottom-4));
    end;
  end;
{$ENDIF}
end;

procedure TCustomDBGridEh.DrawTitleCellOld(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  ImageWidth: Integer;
  BackColor: TColor;
  Highlight: Boolean;
  Down: Boolean;
  LeftMarg, RightMarg: Integer;
  The3DRect: Boolean;
  AFillRect: TRect;
  ASubtRect: TRect;
  ATextRect: TRect;
  DrawColumn: TColumnEh;
  TitleText: String;
  ARect1: TRect;
  ASortMarker: TSortMarkerEh;
  SortMarkerIdx, SMTMarg: Integer;
  SMImageFit: Boolean;
  CellMultiSelected: Boolean;
  FillTextRect: Boolean;
  XFrameOffs, YFrameOffs: Byte;
  BrushStyle: TBrushStyle;
  Title: TColumnTitleEh;
  ADrawByThemes: Boolean;
  WordWrap: Boolean;
  Layout: TTextLayout;
  FilterButtonWidth: Integer;
  IsDrawFilterButton: Boolean;
  FilterButtonRect, FilterButtonFillRect, FilterButtonClipRect: TRect;
  ADownButton: Integer;
  FilterSignRect: TRect;
  EditButtonTransparency: Byte;
  ButtonActive: Boolean;

  procedure DrawHost(ALeaf: THeadTreeNode; DHRect: TRect; AEndEllipsis: Boolean);
  var
    curLeaf: THeadTreeNode;
    curW: Integer;
    leftM, RightM: Integer;
    drawRec, drawRec1, DrawRecTheme, AFillRect: TRect;
    OldColor: TColor;
  begin
    DHRect.Bottom := DHRect.Top;
    if dgRowLines in Options then Dec(DHRect.Bottom);

    Dec(DHRect.Top, ALeaf.Host.Height);

    curLeaf := ALeaf.Host.Child;
    curW := 0;
    while curLeaf <> ALeaf do
    begin
      Inc(curW, curLeaf.Width);
      if dgColLines in Options then Inc(curW, 1);
      curLeaf := curLeaf.Next;
    end;
    Dec(DHRect.Left, curW); DHRect.Right := DHRect.Left + ALeaf.Host.Width;

    LeftM := DHRect.Left - ARect.Left; RightM := ARect.Right - DHRect.Right;

    drawRec := DHRect;
    drawRec.Left := ARect.Left; drawRec.Right := ARect.Right;

    if (RightM <> 0) then
    begin
      if ACol = (FixedCols - 1) then
      begin
        if (LeftCol = FixedCols) then
        begin
          Inc(RightM);
          Inc(drawRec.Right);
        end;
      end else
      begin
        Inc(RightM);
        Inc(drawRec.Right);
      end;
    end;

    AFillRect := drawRec;
    if (gdFixed in AState) and (dghFixed3D in OptionsEh) then
    begin
      InflateRect(drawRec, 0, -1);
      if ADrawByThemes then
      begin
        InflateRect(AFillRect, 1, 1);
        if leftM <> 0 then
        Inc(AFillRect.Left);
      end else if Flat then
      begin
        if leftM = 0 then
        begin
          Inc(AFillRect.Left, 1);
          Inc(AFillRect.Top, 1);
        end;
      end else
        InflateRect(AFillRect, -1, -1);
    end;

    drawRec1 := drawRec;
    if (leftM = 0) then
    begin
      Canvas.FillRect(Rect(drawRec1.Left, drawRec1.Top, drawRec1.Left + 2, drawRec1.Bottom));
      Inc(drawRec1.Left, 2);
    end
    else Inc(LeftM, 2);

    if (RightM = 0) then
    begin
      Canvas.FillRect(Rect(drawRec1.Right - 2, drawRec1.Top, drawRec1.Right, drawRec1.Bottom));
      Dec(drawRec1.Right, 2);
    end
    else Inc(RightM, 2);

    if ADrawByThemes then
    begin
      DrawRecTheme := Rect(drawRec1.Left, drawRec1.Top, drawRec1.Right, drawRec1.Bottom);
      FillCellRect(ADrawByThemes, Rect(AFillRect.Left+leftM, AFillRect.Top,
                          AFillRect.Right-RightM, AFillRect.Bottom),
                     False, Highlight, AFillRect, The3DRect);
      WriteCellText(DrawColumn, Canvas, drawRec1, not ADrawByThemes, 0,
        YFrameOffs, ALeaf.Host.Text, taCenter, tlCenter, True, AEndEllipsis, leftM, RightM);
    end else if Flat and ThemesEnabled and The3DRect then
    begin
      FillGradientEh(Canvas, AFillRect, clBtnHighlight, Canvas.Brush.Color);
      WriteCellText(DrawColumn, Canvas, drawRec1, False, 0,
        YFrameOffs, ALeaf.Host.Text, taCenter, tlCenter, True, AEndEllipsis, leftM, RightM);
    end else
      WriteCellText(DrawColumn, Canvas, drawRec1, not ADrawByThemes, 0,
        YFrameOffs, ALeaf.Host.Text, taCenter, tlCenter, True, AEndEllipsis, leftM, RightM);

    ALeaf.Host.Drawed := True;

    if (gdFixed in AState) and (dghFixed3D in OptionsEh) and not ADrawByThemes then
    begin
      InflateRect(drawRec, 0, 1);
      DrawEdgeEh(Canvas, drawRec, False, Highlight, leftM = 0, (RightM = 0) and not Flat);
    end;

    if (dgRowLines in Options) and not ADrawByThemes then
    begin
      OldColor := Canvas.Pen.Color;
      Canvas.Pen.Color := GridLineColors.GetFixedHorzColor;
      Canvas.MoveTo(drawRec.Left, drawRec.Bottom);
      Canvas.LineTo(drawRec.Right, drawRec.Bottom);
      Canvas.Pen.Color := OldColor;
    end;

    if (dgColLines in Options) and not ADrawByThemes then
    begin
      Canvas.Pen.Color := GridLineColors.GetFixedHorzColor;
      DrawPolyline([Point(drawRec.Right, drawRec.Top),
                     Point(drawRec.Right, drawRec.Bottom+1)]);
    end;

    if (ALeaf.Host.Host <> nil) and (ALeaf.Host.Host <> FHeadTree) then
    begin
      DrawHost(ALeaf.Host, DHRect, AEndEllipsis);
      ALeaf.Host.Host.Drawed := True;
    end;
  end;

begin

  The3DRect := CellHave3DRect(ACol, ARow, ARect, AState);
  ADrawByThemes := IsDrawCellByThemes(ACol, ARow, AreaCol, AreaRow, AState,
    CellAreaType, The3DRect);
  Highlight := False;
  Down := False;

  DrawColumn := Columns[AreaCol];
  Title := DrawColumn.Title;

  Canvas.Font := Title.Font;
  Canvas.Brush.Color := Title.Color;
  BackColor := Title.Color;

  if CellAreaType.VertType = vctTitleEh then
  begin
    Down := (FPressedDataCol = AreaCol) and FPressed and (FDBGridEhState = dgsNormal);
    ImageWidth := 0;
    if (IsUseMultiTitle = True) and (dgColLines in Options) then
    begin
      Dec(ARect.Right);
      Canvas.Pen.Color := GridLineColors.GetFixedHorzColor;
      DrawPolyline([Point(ARect.Right, ARect.Bottom-1),
                     Point(ARect.Right,ARect.Bottom-FLeafFieldArr[AreaCol].FLeaf.Height)]);
    end;
    ASubtRect := ARect;
    if IsUseMultiTitle = True then
    begin
      ASubtRect.Top := ARect.Bottom - FLeafFieldArr[AreaCol].FLeaf.Height + 1;// + 3;
      TitleText := FLeafFieldArr[AreaCol].FLeaf.Text;
    end else
      TitleText := Title.Caption;

    AFillRect := ASubtRect;
    ATextRect := AFillRect;

    if The3DRect then
    begin
      XFrameOffs := 1;
      if ADrawByThemes then
      begin
        InflateRect(AFillRect, 1, 1);
        InflateRect(ATextRect, -1, -1);
      end else if Flat then
      begin
        Inc(AFillRect.Left, 1);
        Inc(AFillRect.Top, 1);
        InflateRect(ATextRect, -1, -1);
      end else
      begin
        InflateRect(AFillRect, -1, -1);
        InflateRect(ATextRect, -1, -1);
      end;
    end else
      XFrameOffs := 2;
    YFrameOffs := XFrameOffs;
    if Flat then Dec(YFrameOffs);

    IsDrawFilterButton := False;
    if STFilter.Visible and (STFilter.Location = stflInTitleFilterEh) then
    begin
      IsDrawFilterButton := True;
      if Flat then
      begin
        FilterButtonWidth := FlatButtonWidth;
        if not ThemesEnabled then
          Inc(FilterButtonWidth);
      end else
        FilterButtonWidth := GetSystemMetrics(SM_CXVSCROLL);

      if (ATextRect.Right - ATextRect.Left) div 2 < FilterButtonWidth then
        FilterButtonWidth := (ATextRect.Right - ATextRect.Left) div 2;

      FilterButtonRect := ATextRect;
      FilterButtonRect.Right := ATextRect.Right;
      FilterButtonRect.Left := FilterButtonRect.Right - FilterButtonWidth;
      FilterButtonFillRect := FilterButtonRect;
      if FilterButtonRect.Bottom - FilterButtonRect.Top > FInplaceEditorButtonHeight then
      begin
        FilterButtonRect.Top := (FilterButtonRect.Bottom + FilterButtonRect.Top -
          FInplaceEditorButtonHeight) div 2;
        FilterButtonRect.Bottom := FilterButtonRect.Top + FInplaceEditorButtonHeight;
      end;

      Dec(ATextRect.Right, FilterButtonWidth);
      FilterSignRect.Top := ATextRect.Top;
      FilterSignRect.Left := ATextRect.Right - 6;
      FilterSignRect.Right := ATextRect.Right;
      FilterSignRect.Bottom := FilterSignRect.Top + 6;
    end;

    if (TitleImages <> nil) and (Title.ImageIndex <> -1) then
    begin
      TitleText := '';
      ImageWidth := TitleImages.Width;
    end;
    ARect1 := ATextRect;
    ASortMarker := Title.SortMarker;
//    if ACol = Col then
//      Canvas.Brush.Color := ApproachToColorEh(Canvas.Brush.Color, clBlack, 10);
    if (DrawColumn.Field <> nil) and Assigned(FOnGetBtnParams) then
    begin
      BackColor := Canvas.Brush.Color;
      FOnGetBtnParams(Self, DrawColumn, Canvas.Font, BackColor, ASortMarker, Down);
      Canvas.Brush.Color := BackColor;
    end;

    if Down then
    begin
      if (IsUseMultiTitle = True) or (TitleHeight <> 0) or (TitleLines <> 0) then
      begin
        LeftMarg := 2; RightMarg := -2; Inc(ARect1.Top, 2);
      end else
      begin
        LeftMarg := 1; RightMarg := -1; Inc(ARect1.Top, 1);
      end;
    end else
    begin
      LeftMarg := 0;
      RightMarg := 0;
    end;
    case ASortMarker of
      smDownEh: SortMarkerIdx := 0;
      smUpEh: SortMarkerIdx := 1;
      else SortMarkerIdx := -1;
    end;

    SMTMarg := 0; SMImageFit := True;
    if SortMarkerIdx <> -1 then
    begin
      Dec(ARect1.Right, 16);
      if (SortMarkedColumns.Count > 1) then
      begin
        Canvas.Font := SortMarkerFont;
        SMTMarg := Canvas.TextWidth(IntToStr(Title.SortIndex));
      end else
        SMTMarg := 0;
      if ARect1.Right < ARect1.Left + ImageWidth then
      begin
        ARect1.Right := ARect1.Right + 14 - SMTMarg;
        SMImageFit := False;
      end;
      if ARect1.Right < ARect1.Left + ImageWidth then
      begin
        ARect1.Right := ARect1.Right + 2 + SMTMarg;
        SMTMarg := 0;
      end;
    end;
    Canvas.Font := Title.Font;
    if (DrawColumn.Field <> nil) and Assigned(FOnGetBtnParams) then // To restore changed in FOnGetBtnParams font
      FOnGetBtnParams(Self, DrawColumn, Canvas.Font, BackColor, ASortMarker, Down);

    CellMultiSelected := CellIsMultiSelected(ACol, ARow, AreaCol, NilBookmarkEh);
    BackColor := Canvas.Brush.Color;
    Highlight := HighlightNoDataCellColor(ACol, ARow, AreaCol, AreaRow,
      CellAreaType, AState, CellMultiSelected, BackColor, Canvas.Font);
    Canvas.Brush.Color := BackColor;
    if (SelectedIndex = AreaCol) and ThemesEnabled and RowPanel.Active then
      Canvas.Brush.Color := ApproachToColorEh(Canvas.Brush.Color, clBlack, 10);

    if ADrawByThemes then
    begin
      FillCellRect(ADrawByThemes, AFillRect, Down, CellMultiSelected, EmptyRect, The3DRect);
      FillTextRect := False;
    end else if Flat and ThemesEnabled then
    begin
      FillCellRect(ADrawByThemes, AFillRect, Down, CellMultiSelected, EmptyRect, The3DRect);
      FillTextRect := False;
    end else
    begin
      Canvas.FillRect(Rect(ARect1.Right, AFillRect.Top, AFillRect.Right, AFillRect.Bottom));
      FillTextRect := True;
    end;

    WordWrap := (UseMultiTitle = True) or (TitleHeight <> 0) or (TitleLines <> 0);
    if WordWrap
      then Layout := tlCenter
      else Layout := tlTop;
    if Title.Orientation = tohVertical then
      WriteTextVerticalEh(Canvas, ARect1, FillTextRect, XFrameOffs, YFrameOffs + 2,
        TitleText, taCenter{Title.Alignment}, tlBottom, Title.EndEllipsis, False)
    else
      WriteCellText(DrawColumn, Canvas, ARect1,
        FillTextRect, XFrameOffs, YFrameOffs, TitleText,
        Title.Alignment, Layout, WordWrap, Title.EndEllipsis, LeftMarg, RightMarg);

    if (TitleImages <> nil) and (Title.ImageIndex <> -1) then
    begin
      with TitleImages do
      begin
        if UseMultiTitle
          then DrawClipped(TitleImages, nil, Canvas, ARect1, Title.ImageIndex, LeftMarg, taCenter)
          else DrawClipped(TitleImages, nil, Canvas, ARect1, Title.ImageIndex, LeftMarg, Title.Alignment);
      end;
    end;
    if SortMarkerIdx <> -1 then
    begin
      if SMImageFit <> False then
      begin
      //FSortMarkerImages.BkColor := Canvas.Brush.Color; //??? to avoid ImageListChange event
        DBGridEhSortMarkerImages.Draw(Canvas, ATextRect.Right - DBGridEhSortMarkerImages.Width - 2 - SMTMarg + LeftMarg,
          (ATextRect.Bottom + ATextRect.Top - DBGridEhSortMarkerImages.Height) div 2 + LeftMarg, SortMarkerIdx);
      end;
      if SMTMarg <> 0 then
      begin
        Canvas.Font := SortMarkerFont;
        if Highlight = True
          then Canvas.Font.Color := clWhite;
        BrushStyle := Canvas.Brush.Style;
        BackColor := Canvas.Brush.Color;
        Canvas.Brush.Style := bsClear;
        Canvas.TextOut(ATextRect.Right - SMTMarg - 2 + LeftMarg,
          (ATextRect.Bottom + ATextRect.Top - DBGridEhSortMarkerImages.Height) div 2 + LeftMarg - 1,
          IntToStr(Title.SortIndex));
        Canvas.Brush.Style := BrushStyle;
        Canvas.Brush.Color := BackColor;
        Canvas.Font := TitleFont;
        if Highlight = True
          then Canvas.Font.Color := clWhite;
      end;
    end;

    if IsDrawFilterButton then
    begin
      if FillTextRect then
      begin
//        Canvas.Brush.Color
        Canvas.FillRect(FilterButtonFillRect);
      end;
      FilterButtonClipRect := FilterButtonRect;
      if Down then
        OffsetRect(FilterButtonRect, LeftMarg, LeftMarg);
      if FInTitleFilterListboxVisible and (FInTitleFilterListboxColumn = DrawColumn)
        then ADownButton := 1
        else ADownButton := 0;

      ButtonActive := False;
      if csDesigning in ComponentState then
        EditButtonTransparency := 30
      else if IsMouseInRect(FilterButtonRect)
        or (FInTitleFilterListboxVisible and (FInTitleFilterListboxColumn = DrawColumn))
      then
      begin
        EditButtonTransparency := 0;
        ButtonActive := True;
      end else if (gdHotTrack in AState) and not FHotTrackMultiTitleOver then
        EditButtonTransparency := 30
      else
        EditButtonTransparency := 80;

      PaintInplaceButton(DrawColumn, Canvas, Style.InTitleFitlerButtonStyle,
        FilterButtonRect,  FilterButtonFillRect,
        ADownButton, ButtonActive, Flat, DataLink.Active, Canvas.Brush.Color, nil, EditButtonTransparency);

      if DrawColumn.STFilter.ExpressionStr <> '' then
      begin
        if Down then
          OffsetRect(FilterSignRect, LeftMarg, LeftMarg);
        DrawFilterSign(FilterSignRect, CellMultiSelected);
      end;
    end;
  end else // VertType = vctSubTitleEh
  begin
    AFillRect := ARect;
    CellMultiSelected := CellIsMultiSelected(ACol, ARow, AreaCol, NilBookmarkEh);
    if The3DRect and ADrawByThemes then
      FillCellRect(ADrawByThemes, AFillRect, False, CellMultiSelected, EmptyRect, The3DRect);
    DrawSubTitleCell(ACol, ARow, AreaCol, AreaRow, CellAreaType, AFillRect, AState, Highlight);
  end;

  if The3DRect then
  begin
//    InflateRect(ARect, 1, 1);
    Canvas.Brush.Color := BackColor;
    if not ADrawByThemes then
      DrawEdgeEh(Canvas, ASubtRect, Down, Highlight, True, not (Flat and ThemesEnabled));
  end;

  if (CellAreaType.VertType = vctTitleEh) and (IsUseMultiTitle = True) then
    with DrawColumn.Title do
    begin // Draw mastertitle
      Canvas.Font := TitleFont;
      if Highlight then
      begin
        BackColor := Canvas.Brush.Color;
        Highlight := HighlightNoDataCellColor(ACol, ARow, AreaCol, AreaRow,
          CellAreaType, AState, CellMultiSelected, BackColor, Canvas.Font);
        Canvas.Brush.Color := BackColor;
      end else
        Canvas.Brush.Color := FixedColor;
      if (FLeafFieldArr[AreaCol].FLeaf.Host <> nil) and (FLeafFieldArr[AreaCol].FLeaf.Host <> FHeadTree) then
      begin
        DrawHost(FLeafFieldArr[AreaCol].FLeaf, ASubtRect, EndEllipsis);
      end;
    end;
{$IFDEF EH_LIB_6}
  if (csDesigning in ComponentState) and
      Assigned(DBGridEhDesigntControler) and
      (FNoDesigntControler = False) and
     DBGridEhDesigntControler.ControlIsObjInspSelected(DrawColumn) and
     (CellAreaType.VertType = vctTitleEh)
  then
  begin
    if DBGridEhDesigntControler.GetSelectComponentCornerImage <> nil then
    begin
      Canvas.StretchDraw(Rect(ARect.Left, ARect.Top, ARect.Left+8, ARect.Top+8), DBGridEhDesigntControler.GetSelectComponentCornerImage);
      Canvas.StretchDraw(Rect(ARect.Right-7, ARect.Top, ARect.Right+1, ARect.Top+8), DBGridEhDesigntControler.GetSelectComponentCornerImage);
      Canvas.StretchDraw(Rect(ARect.Right-7, ARect.Bottom-7, ARect.Right+1, ARect.Bottom+1), DBGridEhDesigntControler.GetSelectComponentCornerImage);
      Canvas.StretchDraw(Rect(ARect.Left, ARect.Bottom-7, ARect.Left+8, ARect.Bottom+1), DBGridEhDesigntControler.GetSelectComponentCornerImage);
    end else
    begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left+4, ARect.Top+4));
      Canvas.FillRect(Rect(ARect.Right, ARect.Top, ARect.Right-4, ARect.Top+4));
      Canvas.FillRect(Rect(ARect.Right, ARect.Bottom, ARect.Right-4, ARect.Bottom-4));
      Canvas.FillRect(Rect(ARect.Left, ARect.Bottom, ARect.Left+4, ARect.Bottom-4));
    end;
  end;
{$ENDIF}
end;

procedure TCustomDBGridEh.DrawDataCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  Value: string;
  DrawColumn: TColumnEh;
  Processed: Boolean;
  Cell, AreaCell: TGridCoord;
  The3DRect: Boolean;
  RowDetailPanelAvailable: Boolean;
begin
  DrawColumn := Columns[AreaCol];

  Canvas.Font := DrawColumn.Font;
  Canvas.Brush.Color := DrawColumn.Color;
  Value := '';

  if (DataLink = nil) or not DataLink.Active or
   (AreaRow < 0) or ((AreaRow >= InstantReadRecordCount) and not DataLink.DataSet.IsEmpty)  then
  begin
    Canvas.FillRect(ARect);
    Exit;
  end;

  InstantReadRecordEnter(AreaRow);
  try

  Value := DrawColumn.DisplayText;
  The3DRect := CellHave3DRect(ACol, ARow, ARect, AState);

  if DataGrouping.IsGroupingWorks and (DataGrouping.GroupDataTree.FlatVisibleCount > 0) then
  begin
    if FDrawGroupDataNode.NodeType = dntDataGroupEh then
    begin
      DrawGroupDataCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType);
      Exit;
    end else if (DrawColumn = VisibleColumns[0]) and not RowPanel.Active then
    begin
      DrawGroupDataArea(AreaCol, AreaRow, FDrawGroupDataNode.Level, AState, ARect, The3DRect);
      ARect.Left := ARect.Left + FExtraFirstColumnWidth;
      ARect.Bottom := ARect.Bottom - 1;
    end;
  end;

  // Tree model elements
  if DrawColumn.Color = Self.Color then
  begin
    if (OddRowColor <> EvenRowColor) and
       DataLink.Active and
       (DataLink.DataSet.IsSequenced or
        (SumList.Active and SumList.VirtualRecords)) then
        if SumList.RecNo mod 2 = 1
          then Canvas.Brush.Color := OddRowColor
          else Canvas.Brush.Color := EvenRowColor
    else
      Canvas.Brush.Color := DrawColumn.Color;
  end;

  FColCellParamsEh.FState := AState;
  FColCellParamsEh.FFont := Canvas.Font;
  FColCellParamsEh.FAlignment := DrawColumn.Alignment;
  FColCellParamsEh.FBackground := Canvas.Brush.Color;
  FColCellParamsEh.SuppressActiveCellColor := False;
  FColCellParamsEh.FText := Value;
  FColCellParamsEh.FImageIndex := DrawColumn.GetImageIndex;
  FColCellParamsEh.FCheckboxState := DrawColumn.CheckboxState;
  FColCellParamsEh.FBlankCell := False;
  FColCellParamsEh.FReadOnly := not DrawColumn.CanModify(False);
  FColCellParamsEh.FCol := ACol;
  FColCellParamsEh.FCellRect := ARect;
  FColCellParamsEh.FRow := ARow;
  FColCellParamsEh.FTextEditing := DrawColumn.TextEditing;

  RowDetailPanelAvailable := RowDetailPanel.Active;
  Cell.X := ACol;
  Cell.Y := ARow;
  AreaCell.X := AreaCol;
  AreaCell.Y := AreaRow;

  GetCellParams(DrawColumn, Canvas.Font, FColCellParamsEh.FBackground, AState);
  DrawColumn.GetColCellParams(False, FColCellParamsEh);
  if Assigned(OnCheckRowHaveDetailPanel) then
    OnCheckRowHaveDetailPanel(Self, RowDetailPanelAvailable);

  if (FIntMemTable <> nil) and (DrawColumn = VisibleColumns[0]) and FIntMemTable.MemTableIsTreeList then
  begin
    DrawCellTreeArea(AreaCell.X, AreaCell.Y, AState, ARect, The3DRect);
    ARect.Left := ARect.Left + GetCellTreeElmentsAreaWidth;
//    if The3DRect then
//      ARect.Left := ARect.Left - 1;
  end;

  if RowDetailPanel.Active and (DrawColumn = VisibleColumns[0]) then
  begin
    if RowDetailPanelAvailable then
      ARect.Left := ARect.Left +
        DrawDetailPanelSign(AreaCell.X, AreaCell.Y, AState, ARect, The3DRect)
    else
    begin
      Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left + 18, ARect.Bottom));
      ARect.Left := ARect.Left + 18;
    end;
  end;

  Processed := False;
  if Assigned(OnAdvDrawDataCell) then
    OnAdvDrawDataCell(Self, Cell, AreaCell, DrawColumn, ARect,
      FColCellParamsEh, Processed);

  if not Processed and Assigned(DrawColumn.OnAdvDrawDataCell) then
    DrawColumn.OnAdvDrawDataCell(Self, Cell, AreaCell, DrawColumn, ARect,
      FColCellParamsEh, Processed);

  if not Processed then
    DefaultDrawColumnDataCell(Cell, AreaCell, DrawColumn, ARect, FColCellParamsEh);

  if DefaultDrawing and (gdFocused in FColCellParamsEh.State)
    and ({(dgAlwaysShowSelection in Options) or }Focused)
    and not (csDesigning in ComponentState)
    and not (dgRowSelect in Options)
    and (UpdateLock = 0)
    and (ValidParentForm(Self).ActiveControl = Self)
    and Style.IsDrawFocusRect
  then
    DrawFocusRect(Canvas, ARect);

  finally
    InstantReadRecordLeave;
  end;
end;

procedure TCustomDBGridEh.DrawFocusRect(Canvas: TCanvas; ARect: TRect);
//var
//  FrameColor: TColor;
begin
{  if (FScreenNumColors = -1) and ThemeServices.ThemesEnabled then
  begin
//    InflateRect(ARect, -1,-1);
    FrameColor := clHighlight;
    Canvas.Pen.Color := FrameColor;
    InflateRect(ARect, 1, 1);
//    Canvas.FrameRect(ARect);
    Canvas.Polyline([Point(ARect.Left+2, ARect.Top), Point(ARect.Right-2, ARect.Top)]);
    Canvas.Polyline([Point(ARect.Right-1, ARect.Top+2), Point(ARect.Right-1, ARect.Bottom-2)]);
    Canvas.Polyline([Point(ARect.Left+2, ARect.Bottom-1), Point(ARect.Right-2, ARect.Bottom-1)]);
    Canvas.Polyline([Point(ARect.Left, ARect.Top+2), Point(ARect.Left, ARect.Bottom-2)]);

    InflateRect(ARect, -1,-1);
    Canvas.Brush.Color := ApproximateColor(FrameColor, clWindow, 256 div 4*3);
    Canvas.FrameRect(ARect);

    Canvas.Pen.Color := ApproximateColor(FrameColor, clWindow, 256 div 2);

    Canvas.Polyline([Point(ARect.Left, ARect.Top-1), Point(ARect.Left, ARect.Top), Point(ARect.Left-2, ARect.Top+1)]);
    Canvas.Polyline([Point(ARect.Right-1, ARect.Top-1), Point(ARect.Right-1, ARect.Top), Point(ARect.Right+1, ARect.Top+1)]);
    Canvas.Polyline([Point(ARect.Right, ARect.Bottom-1), Point(ARect.Right-1, ARect.Bottom-1), Point(ARect.Right-1, ARect.Bottom+1)]);
    Canvas.Polyline([Point(ARect.Left-1, ARect.Bottom-1), Point(ARect.Left, ARect.Bottom-1), Point(ARect.Left, ARect.Bottom+1)]);
    Canvas.Brush.Color := clWindow;
//    Canvas.FillRect(Rect(ARect.Left-1, ARect.Top-1, ARect.Left, ARect.Top));
  end else}
    Windows.DrawFocusRect(Canvas.Handle, ARect);
end;

procedure TCustomDBGridEh.DefaultDrawColumnDataCell(Cell, AreaCell: TGridCoord;
  Column: TColumnEh; AreaRect: TRect; var Params: TColCellParamsEh);
const
  CheckBoxFlags: array[TCheckBoxState] of Integer =
  (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
  EditToButtonStyle: array[TEditStyle] of TEditButtonStyleEh =
  (ebsDropDownEh, ebsEllipsisEh, ebsDropDownEh, ebsDropDownEh, ebsDropDownEh,
   ebsUpDownEh, ebsDropDownEh, ebsAltUpDownEh, ebsAltDropDownEh, ebsAltDropDownEh);
var
  The3DRect: Boolean;
  ClearOnLine: Boolean;
  ClearSubLine: Boolean;
  IsFillTextCell: Boolean;
  ADrawByThemes: Boolean;
  CellAreaType: TCellAreaTypeEh;
//  ACol, ARow, AreaCol, AreaRow: Integer;
  AFrameRect, ARect1, ACellRect: TRect;
  XFrameOffs, YFrameOffs: Byte;
  LeftMarg, RightMarg: Integer;
  AEditStyle: TEditStyle;
  AEditLineWidth, AButtonWidth, AButtonsWidth: Integer;
  Highlight: Boolean;
  i: Integer;
  IsWordWrap: Boolean;
  EditButtonTransparency: Byte;

  procedure DrawInplaceSearchText;
  const
    AlignFlags: array[TAlignment] of Integer =
    (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
    RTL: array[Boolean] of Integer = (0, DT_RTLREADING);
  var
    rect1: TRect;
    DrawFlag: Integer;
    lpDTP: TDrawTextParams;
    Alignment: TAlignment;
  begin
    Canvas.Brush.Color := DBGridEhInplaceSearchColor;
    Canvas.Font.Color := DBGridEhInplaceSearchTextColor;
    Alignment := Column.Alignment;

    if Self.UseRightToLeftAlignment then
    begin
      WindowsLPtoDP(Canvas.Handle, AreaRect);
      Swap(AreaRect.Left, AreaRect.Right);
      ChangeGridOrientation(False);

      if Alignment = taLeftJustify then
        Alignment := taRightJustify
      else if Alignment = taRightJustify then
        Alignment := taLeftJustify;
      Swap(LeftMarg, RightMarg);
    end;

    DrawFlag := AlignFlags[Alignment];
    IsWordWrap := Column.WordWrap and Column.CurLineWordWrap(AreaRect.Bottom-AreaRect.Top);
    if IsWordWrap then
      DrawFlag := DrawFlag or DT_WORDBREAK or RTL[UseRightToLeftReading];

    rect1 := AreaRect;

    lpDTP.cbSize := SizeOf(lpDTP);
    lpDTP.uiLengthDrawn := Length(FInplaceSearchText);
    lpDTP.iLeftMargin := 0;
    lpDTP.iRightMargin := 0;

    InflateRect(rect1, -XFrameOffs, -YFrameOffs);

    if XFrameOffs > 0 then rect1.Bottom := rect1.Bottom + 1;
    if Alignment <> taLeftJustify then
      lpDTP.iRightMargin :=
        Canvas.TextWidth(Copy(FColCellParamsEh.Text, Length(FInplaceSearchText) + 1, Length(FColCellParamsEh.Text)));

    WindowsDrawTextEx(Canvas.Handle, FInplaceSearchText,
      Length(FInplaceSearchText), rect1, DrawFlag, lpDTP);

    if Self.UseRightToLeftAlignment then
      ChangeGridOrientation(True);
  end;

  function CheckColumnDuplicateValues(Column: TColumnEh; var s: String; CheckPrevRow: Boolean): Boolean;
  var
    OldActive: Integer;

    function CheckColumnValue: Boolean;
    begin
      Result := False;
      Column.FillColCellParams(VarColCellParamsEh);
      with VarColCellParamsEh do
      begin
        FCol := Column.Index + IndicatorOffset;
         FRow := TopRow - 1 + TopDataOffset;
        GetCellParams(Column, FFont, FBackground, FState);
        Column.GetColCellParams(False, VarColCellParamsEh);
      end;

      if s = VarColCellParamsEh.FText then
        Result := True;
    end;

  begin
    Result := False;
    if CheckPrevRow then
    begin
      if ViewScroll and (AreaCell.Y > TopRow - TopDataOffset) then
      begin
        InstantReadRecordEnter(AreaCell.Y-1);
        try
          Result := CheckColumnValue;
        finally
          InstantReadRecordLeave;
        end;
      end else
      begin
        OldActive := FDataLink.ActiveRecord;
        if OldActive > 0 then
        begin
          FDataLink.ActiveRecord := OldActive-1;
          try
            Result := CheckColumnValue;
          finally
            FDataLink.ActiveRecord := OldActive;
          end;
        end;
      end;
    end else
    begin
      if ViewScroll and (AreaCell.Y < FIntMemTable.InstantReadRowCount-1) then
      begin
        InstantReadRecordEnter(AreaCell.Y+1);
        try
          Result := CheckColumnValue;
        finally
          InstantReadRecordLeave;
        end;
      end else
      begin
        OldActive := FDataLink.ActiveRecord;
        if OldActive < FDataLink.RecordCount-1 then
        begin
          FDataLink.ActiveRecord := OldActive+1;
          try
            Result := CheckColumnValue;
          finally
            FDataLink.ActiveRecord := OldActive;
          end;
        end;
      end;
    end;
  end;

  procedure PaintRequiredState(Column: TColumnEh; Text: String; DataRect: TRect);
  var
    OldPenColor: TColor;
    OldPenStyle: TPenStyle;
    DrawState: Boolean;
  begin
    DrawState := Column.HighlightRequired and IsCurrentRow(FOldActiveRecord) and
      (DataLink.DataSet.State in [dsInsert, dsEdit]) and (Column.Field <> nil) and
      Column.Field.Required and Column.Field.IsNull;
    if Assigned(Column.FOnCheckDrawRequiredState) then
      Column.FOnCheckDrawRequiredState(Self, Text, DrawState);
    if DrawState then
    begin
      OldPenColor := Canvas.Pen.Color;
      OldPenStyle := Canvas.Pen.Style;
      Canvas.Pen.Color := clRed;
      Canvas.Pen.Style := psDot;
      Canvas.MoveTo(DataRect.Left+2, DataRect.Bottom-1);
      Canvas.LineTo(DataRect.Right-3, DataRect.Bottom-1);
      Canvas.Pen.Color := OldPenColor;
      Canvas.Pen.Style := OldPenStyle;
    end;
  end;

  function IsDrawEditButton: Boolean;
  var
    IsCurCol, IsCurRow, IsEdit: Boolean;
  begin
    Result := False;
    IsCurCol := (SelectedIndex = AreaCell.X);
    IsCurRow := (Row = Cell.Y);
    IsEdit := FDataLink.Active and (FDataLink.DataSet.State in [dsEdit, dsInsert]);

    if Column.AlwaysShowEditButton then
      Result := True;
    if Result and (sebShowOnlyForCurCellEh in EditButtonsShowOptions) then
      if IsCurCol and IsCurRow
        then Result := True
        else Result := False;
    if Result and (sebShowOnlyForCurRowEh in EditButtonsShowOptions) then
      if IsCurRow
        then Result := True
        else Result := False;
    if Result and (sebShowOnlyWhenGridActiveEh in EditButtonsShowOptions) then
      if IsSelectionActive
        then Result := True
        else Result := False;
    if Result and (sebShowOnlyWhenDataEditingEh in EditButtonsShowOptions) then
      if IsEdit
        then Result := True
        else Result := False;
  end;

begin
//  CellAreaType := GetCellAreaType(Cell.X, Cell.Y, AreaCell.X, AreaCell.Y);
  CellAreaType.HorzType := hctDataEh;
  CellAreaType.VertType := vctDataEh;
  The3DRect := CellHave3DRect(Cell.X, Cell.Y, AreaRect, Params.State);

  if FColCellParamsEh.BlankCell then
    if not The3DRect then
      The3DRect := (dghFixed3D in OptionsEh);

  ADrawByThemes := IsDrawCellByThemes(Cell.X, Cell.Y, AreaCell.X, AreaCell.Y,
    Params.State, CellAreaType, The3DRect);

  AFrameRect := AreaRect;
  if The3DRect then
  begin
    XFrameOffs := 1;
    if ADrawByThemes then
    begin
      InflateRect(AreaRect, 1, 1);
    end else if Flat then
    begin
      Inc(AreaRect.Left, 1);
      Inc(AreaRect.Top, 1);
//      InflateRect(ATextRect, -1, -1);
    end else
    begin
      InflateRect(AreaRect, -1, -1);
//      InflateRect(ATextRect, -1, -1);
    end;
  end else
    XFrameOffs := 2;
  YFrameOffs := XFrameOffs;
  if Flat then Dec(YFrameOffs);

  AEditStyle := esSimple;
  if Flat and not ThemesEnabled
    then AEditLineWidth := 1
    else AEditLineWidth := 0;
  AButtonsWidth := 0;
  ACellRect := AreaRect;

  if IsDrawEditButton and not FColCellParamsEh.BlankCell then // Draw edit button
  begin
    AEditStyle := GetColumnEditStile(Column);
    AButtonsWidth := Column.EditButtonsWidth;
    AreaRect.Right := AreaRect.Right - AButtonsWidth;
  end;

  if not FColCellParamsEh.SuppressActiveCellColor and FColCellParamsEh.BlankCell then
    FColCellParamsEh.FBackground := FixedColor;
  if FColCellParamsEh.SuppressActiveCellColor and
   ((Cell.Y = Row) and ((Cell.X = Col) or (dgRowSelect in Options)))
   then Highlight := False
   else Highlight := HighlightDataCellColor(AreaCell.X, AreaCell.Y,
            FColCellParamsEh.Text, FColCellParamsEh.State, FColCellParamsEh.FBackground, Canvas.Font);
  if Highlight then
    FColCellParamsEh.State := FColCellParamsEh.State + [gdSelected];
  Canvas.Brush.Color := FColCellParamsEh.FBackground;

  ClearOnLine := False;
  ClearSubLine := False;
  if Column.HideDuplicates and not FColCellParamsEh.BlankCell then
  begin
    if (AreaCell.Y < InstantReadRecordCount) and
       (Column.FCheckedDuplicates[AreaCell.Y-TopRow+TopDataOffset+1] = False)
    then
      if CheckColumnDuplicateValues(Column, FColCellParamsEh.FText, False)
      then
        ClearSubLine := True;

    if CheckColumnDuplicateValues(Column, FColCellParamsEh.FText, True) then
    begin
      FColCellParamsEh.FText := '';
      FColCellParamsEh.FImageIndex := -1;
      if Column.FCheckedDuplicates[AreaCell.Y-TopRow+TopDataOffset] = False then
      begin
        ClearOnLine := True;
        Column.FCheckedDuplicates[AreaCell.Y-TopRow+TopDataOffset] := True;
      end;
    end;
  end;

  if not FColCellParamsEh.BlankCell and DefaultDrawing and (AreaRect.Right > AreaRect.Left) then
  begin
    IsFillTextCell := CheckFillDataCell(Cell, AreaCell, Column, AreaRect, Params);
    if (Column.ImageList <> nil) and Column.ShowImageAndText then
    begin
      ARect1 := AreaRect;
      ARect1.Right := ARect1.Left + Column.ImageList.Width + 4;
      Canvas.Brush.Color := Column.Color;
      if not IsFillTextCell then
        Canvas.FillRect(AreaRect);
      DrawClipped(Column.ImageList, nil, Canvas, ARect1, FColCellParamsEh.FImageIndex, 0, taCenter);
      Canvas.Brush.Color := FColCellParamsEh.FBackground;
      AreaRect.Left := ARect1.Right + 1;
    end;
    if Column.GetColumnType in [ctCommon..ctKeyPickList] then
    begin
      if ADrawByThemes
        then ARect1 := AFrameRect
        else ARect1 := AreaRect;
      IsWordWrap := Column.WordWrap and Column.CurLineWordWrap(AreaRect.Bottom-AreaRect.Top);
      with FColCellParamsEh do
        WriteCellText {WriteTextEh}(Column, Canvas, ARect1, not IsFillTextCell,
          XFrameOffs, YFrameOffs, FText, FAlignment, Column.Layout,
          IsWordWrap, Column.EndEllipsis, 0, 0)
    end else if Column.GetColumnType = ctKeyImageList then
    begin
      if not IsFillTextCell then
        Canvas.FillRect(AreaRect);
      DrawClipped(Column.ImageList, nil, Canvas, AreaRect, FColCellParamsEh.FImageIndex, 0, taCenter);
    end else if Column.GetColumnType = ctCheckboxes then
    begin
      if not IsFillTextCell then
        Canvas.FillRect(AreaRect);
      ARect1.Left := AreaRect.Left + iif(AreaRect.Right - AreaRect.Left < DefaultCheckBoxWidth, 0,
        (AreaRect.Right - AreaRect.Left) shr 1 - DefaultCheckBoxWidth shr 1);
      ARect1.Right := iif(AreaRect.Right - AreaRect.Left < DefaultCheckBoxWidth, AreaRect.Right,
        ARect1.Left + DefaultCheckBoxWidth);
      ARect1.Top := AreaRect.Top + iif(AreaRect.Bottom - AreaRect.Top < DefaultCheckBoxHeight, 0,
        (AreaRect.Bottom - AreaRect.Top) shr 1 - DefaultCheckBoxHeight shr 1);
      ARect1.Bottom := iif(AreaRect.Bottom - AreaRect.Top < DefaultCheckBoxHeight, AreaRect.Bottom,
        ARect1.Top + DefaultCheckBoxHeight);
      PaintButtonControl {Eh}(Canvas, ARect1, Canvas.Brush.Color, bcsCheckboxEh,
        0, Flat, False, True, FColCellParamsEh.FCheckboxState);
    end else if Column.GetColumnType = ctGraphicData then
      DrawGraphicCell(Column, AreaRect, Canvas.Brush.Color);
  end;
  if not FColCellParamsEh.BlankCell and IsDrawEditButton then // Draw edit button
  begin
    if csDesigning in ComponentState then
      EditButtonTransparency := 30
    else if  not FilterEditMode and
         (
          (gdFocused in FColCellParamsEh.State) or
          ((dghRowHighlight in OptionsEh) and (Cell.Y = Row))
         )
    then
      EditButtonTransparency := 0
    else if gdHotTrack in FColCellParamsEh.State then
      EditButtonTransparency := 30
    else {if not ThemeServices.ThemesEnabled and not Flat then
        EditButtonTransparency := 60
      else}
      EditButtonTransparency := 80;
    SetRect(ARect1, AreaRect.Right, AreaRect.Top,
      AreaRect.Right + FInplaceEditorButtonWidth + AEditLineWidth, AreaRect.Top + FInplaceEditorButtonHeight);
    if ARect1.Bottom > ACellRect.Bottom then ARect1.Bottom := ACellRect.Bottom;
    if (AEditStyle <> esSimple) then
    begin
      if The3DRect then OffsetRect(ARect1, 1, -1); // InflateRect(ARect1, -1, -1);
    {if AEditStyle = esUpDown then
      Canvas.Draw(ARect1.Left,ARect1.Top,UpDownBitmap)
    else}
      PaintInplaceButton(Column, Canvas, EditToButtonStyle[AEditStyle], ARect1, ACellRect,
        0, IsMouseInRect(ARect1), Flat, DataLink.Active,
        {ApproximateColor(Canvas.Brush.Color, clBlack, 10)} Canvas.Brush.Color
        , nil, EditButtonTransparency);
      if Flat and The3DRect and not ThemesEnabled then
        Canvas.FillRect(Rect(ARect1.Left - 1, ARect1.Top, ARect1.Left, AreaRect.Bottom));

      Inc(ARect1.Left, FInplaceEditorButtonWidth + AEditLineWidth);
    end;
    for i := 0 to Column.EditButtons.Count - 1 do
      if Column.EditButtons[i].Visible then
      begin
        if Column.EditButtons[i].Width > 0
          then AButtonWidth := Column.EditButtons[i].Width + AEditLineWidth
          else AButtonWidth := FInplaceEditorButtonWidth;
        ARect1.Right := ARect1.Left + AButtonWidth + AEditLineWidth;
        PaintInplaceButton(Column, Canvas, Column.EditButtons[i].Style,
          ARect1, ACellRect, 0, IsMouseInRect(ARect1), Flat, DataLink.Active,
          Canvas.Brush.Color,
//        ApproximateColor(Canvas.Brush.Color, clBlack, 10),
          Column.EditButtons[i].Glyph, EditButtonTransparency);
        if Flat and The3DRect and not ThemesEnabled then
          Canvas.FillRect(Rect(ARect1.Left - 1, ARect1.Top, ARect1.Left, AreaRect.Bottom));
        Inc(ARect1.Left, AButtonWidth + AEditLineWidth);
      end;

//    if FInplaceEditorButtonHeight < FStdDefaultRowHeight then
    if FInplaceEditorButtonHeight < (AreaRect.Bottom - AreaRect.Top) then
      Canvas.FillRect(Rect(AreaRect.Right, ARect1.Bottom, AreaRect.Right + AButtonsWidth, AreaRect.Bottom));
  end;
  if not FColCellParamsEh.BlankCell then
    PaintRequiredState(Column, FColCellParamsEh.Text, AreaRect);
  if Columns.State = csDefault then
    OldDrawDataCell(AreaRect, Column.Field, FColCellParamsEh.State);
  DrawColumnCell(AreaRect, AreaCell.X, Column, FColCellParamsEh.State);
  if not FColCellParamsEh.BlankCell
    and FInplaceSearching
//    and (gdSelected in AState) KMV #12
    and (gdFocused in FColCellParamsEh.State)
    and IsCurrentRow(FOldActiveRecord)
    and (Cell.X = Col)
    and ((dgAlwaysShowSelection in Options) or Focused)
    and not (csDesigning in ComponentState)
    and (UpdateLock = 0)
    and (ValidParentForm(Self).ActiveControl = Self)
    then DrawInplaceSearchText;

  if ClearOnLine and (dgRowLines in Options) then
  begin
    Canvas.Pen.Color := Column.Color;
    DrawPolyline([Point(AFrameRect.Left, AFrameRect.Top-1),
                     Point(AFrameRect.Right,AFrameRect.Top-1)]);
  end;
  if ClearSubLine and (dgRowLines in Options) then
  begin
    Canvas.Pen.Color := Column.Color;
    DrawPolyline([Point(AFrameRect.Left, AFrameRect.Bottom),
                     Point(AFrameRect.Right,AFrameRect.Bottom)]);
  end;

  AreaRect := ACellRect;
  if not FColCellParamsEh.BlankCell and
    (FIntMemTable <> nil) and
    (AreaCell.X = 0) and
    FIntMemTable.MemTableIsTreeList
  then
    AreaRect.Left := AreaRect.Left + 1;

  if not FColCellParamsEh.BlankCell and
         IsDrawEditButton and
         (AEditStyle <> esSimple) and
         Flat
  then AreaRect.Right := AreaRect.Right + AButtonsWidth;

  if FColCellParamsEh.BlankCell then
    FillCellRect(ADrawByThemes, AreaRect, False, Highlight, EmptyRect, The3DRect);

  if The3DRect then
  begin
    if not ADrawByThemes then
      DrawEdgeEh(Canvas, AFrameRect, False, Highlight, True, not (Flat and ThemesEnabled));
  end;

end;

function TCustomDBGridEh.CheckFillDataCell(Cell, AreaCell: TGridCoord;
  Column: TColumnEh; AreaRect: TRect; var Params: TColCellParamsEh): Boolean;
var
  The3DRect, ADrawByThemes: Boolean;
  CellAreaType: TCellAreaTypeEh;
  Highlight: Boolean;
  DefaultFillCellRect: Boolean;
begin
//  Exit;//tmp
  CellAreaType.HorzType := hctDataEh;
  CellAreaType.VertType := vctDataEh;
  The3DRect := CellHave3DRect(Cell.X, Cell.Y, AreaRect, Params.State);
  Highlight := gdSelected in FColCellParamsEh.State;
  ADrawByThemes := IsDrawCellByThemes(Cell.X, Cell.Y, AreaCell.X, AreaCell.Y,
    Params.State, CellAreaType, The3DRect);

  DefaultFillCellRect := False;

  if CanFillSelectionByTheme and
     ((dgAlwaysShowSelection in Options) or IsSelectionActive) and
     (
       ( (dghRowHighlight in OptionsEh) and (Cell.Y = Row) ) or
       (gdSelected in FColCellParamsEh.State)
     )
  then
    Result := True
  else if ThemesEnabled and (dghRowHighlight in OptionsEh) and
                       (Cell.Y = Row) and
                   not (gdCurrent in FColCellParamsEh.State) then
    Result := True
  else if ThemesEnabled and (gdHotTrack in FColCellParamsEh.State) then
    Result := True
  else if ThemesEnabled and
          (dghRowHighlight in OptionsEh) and
          (Cell.Y = FHotTrackCell.Y) then
    Result := True
  else
  begin
    Result := The3DRect and not (gdSelected in FColCellParamsEh.State) and
      (ADrawByThemes or (Flat and ThemesEnabled));
    DefaultFillCellRect := True;
  end;
  if Result and DefaultFillCellRect then
    FillCellRect(ADrawByThemes, AreaRect, False, Highlight, EmptyRect, The3DRect, gdFocused in FColCellParamsEh.State)
  else if Result then
  begin
    if (gdFocused in FColCellParamsEh.State)
    then
    begin
      Canvas.FillRect(AreaRect);
//      FillGradientEh(Canvas, AreaRect, Canvas.Brush.Color, Canvas.Brush.Color)
    end else
      FillGradientEh(Canvas, AreaRect,
      ApproximateColor(Canvas.Brush.Color, clBtnHighlight, 256 div 3),
//      Canvas.Brush.Color,
      Canvas.Brush.Color);
  end;
  if Result and CanFillSelectionByTheme then
    OverlaySelectionByTheme(Cell, AreaCell, Column, AreaRect, Params);
end;

procedure TCustomDBGridEh.DrawFooterCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  Footer: TColumnFooterEh;
  Highlight: Boolean;
  Value: string;
  DrawColumn: TColumnEh;
  XFrameOffs, YFrameOffs: Byte;
  The3DRect: Boolean;
  NewAlignment: TAlignment;
  CellMultiSelected: Boolean;
  IsFillTextCell: Boolean;
  AFillRect: TRect;
  ADrawByThemes: Boolean;
begin
  DrawColumn := Columns[AreaCol];

  Footer := DrawColumn.UsedFooter(AreaRow);
  Canvas.Font := Footer.Font;
  Canvas.Brush.Color := Footer.Color;

  The3DRect := CellHave3DRect(ACol, ARow, ARect, AState);
  ADrawByThemes := IsDrawCellByThemes(ACol, ARow, AreaCol, AreaRow, AState,
    CellAreaType, The3DRect);

  AFillRect := ARect;
  if The3DRect then
  begin
    XFrameOffs := 1;
    if ADrawByThemes then
    begin
      InflateRect(AFillRect, 1, 1);
      XFrameOffs := 3;
    end else if Flat then
    begin
      Inc(AFillRect.Left, 1);
      Inc(AFillRect.Top, 1);
    end else
    begin
      InflateRect(AFillRect, -1, -1);
    end
  end else
    XFrameOffs := 2;

  YFrameOffs := XFrameOffs;
  if Flat then Dec(YFrameOffs);

  FColCellParamsEh.FBackground := Canvas.Brush.Color;
  NewAlignment := Footer.Alignment;
  Value := GetFooterValue(AreaRow, DrawColumn);

  GetFooterParams(AreaCol, AreaRow, DrawColumn, Canvas.Font,
    FColCellParamsEh.FBackground, NewAlignment, AState, Value);

  CellMultiSelected := CellIsMultiSelected(ACol, ARow, AreaCol, NilBookmarkEh);
  Highlight := HighlightNoDataCellColor(ACol, ARow,
    AreaCol, AreaRow, CellAreaType, AState, CellMultiSelected,
    FColCellParamsEh.FBackground, Canvas.Font);

  Canvas.Brush.Color := FColCellParamsEh.FBackground;

  if FDefaultDrawing then
  begin
    IsFillTextCell := The3DRect and (ADrawByThemes or (Flat and ThemesEnabled));
    if IsFillTextCell then
        FillCellRect(ADrawByThemes, AFillRect, False, Highlight, EmptyRect, The3DRect);
//    IsFillTextCell := (Brush.Color <> clBtnFace) or not (The3DRect and ADrawByThemes);
    WriteCellText(DrawColumn, Canvas, AFillRect,
      not IsFillTextCell, XFrameOffs, YFrameOffs, Value,
      NewAlignment, DrawColumn.Layout,
      Footer.WordWrap and FAllowWordWrap, Footer.EndEllipsis, 0, 0);
  end;

  if The3DRect then
  begin
    if not ADrawByThemes then
      DrawEdgeEh(Canvas, ARect, False, Highlight, True,
        not (Flat and ThemesEnabled));
  end;

  if Assigned(OnDrawFooterCell) then
    OnDrawFooterCell(Self, AreaCol, AreaRow, DrawColumn, ARect, AState);
end;

procedure TCustomDBGridEh.FillCellRect(DrawByThemes: Boolean; ARect: TRect;
  IsDown, IsSelected: Boolean; ClipRect: TRect; Cell3D: Boolean; Focused: Boolean = False);
{$IFDEF EH_LIB_7}
var
  Details: TThemedElementDetails;
begin
//  Exit; //Tmp
  if DrawByThemes and Cell3D then
  begin
    if Flat then
    begin
      FillGradientEh(Canvas, ARect,
        ApproachToColorEh(clBtnFace, clWhite, 10),
        ApproachToColorEh(clBtnFace, clBlack, 5));
      Canvas.Brush.Style := bsClear;
    end else
    begin
      if IsSelected or IsDown
        then Details := ThemeServices.GetElementDetails(ttbSplitButtonPressed)
        else Details := ThemeServices.GetElementDetails(ttbSplitButtonHot);
//        then Details := ThemeServices.GetElementDetails(thHeaderItemPressed)
//        else Details := ThemeServices.GetElementDetails(thHeaderItemNormal);

      if IsRectEmpty(ClipRect) then
      begin
        Canvas.FillRect(ARect);
        ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
      end else
      begin
        Canvas.FillRect(ClipRect);
{$IFDEF CIL}
        ThemeServices.DrawElement(Canvas.Handle, Details, ARect, ClipRect);
{$ELSE}
        ThemeServices.DrawElement(Canvas.Handle, Details, ARect, @ClipRect);
{$ENDIF}
      end
    end
  end else if Flat and ThemeServices.ThemesEnabled and Cell3D then
    FillGradientEh(Canvas, ARect, clBtnHighlight, Canvas.Brush.Color)
  else
{$ELSE}
begin
{$ENDIF}
    Canvas.FillRect(ARect);
end;

{procedure TCustomDBGridEh.RangeToBookmarks(FromBookmark, ToBookmark: TUniBookmarkEh; AntiSelect: Boolean);
var
  TmpBookmark: TUniBookmarkEh;
  BookmarkCmp: Integer;
begin
  BookmarkCmp := DataSetCompareBookmarks(FDataLink.DataSet, FromBookmark, ToBookmark);
  if BookmarkCmp > 0 then
  begin
    TmpBookmark := FromBookmark;
    FromBookmark := ToBookmark;
    ToBookmark := TmpBookmark;
  end;
  FDataLink.DataSet.DisableControls;
  try
    SaveBookmark;
    FDataLink.DataSet.Bookmark := FromBookmark;
    repeat
      BookmarkCmp := DataSetCompareBookmarks(FDataLink.DataSet,
        FDataLink.DataSet.Bookmark, ToBookmark);
      FBookmarks.CurrentRowSelected := not AntiSelect;
      FDataLink.DataSet.Next;
    until BookmarkCmp = 0;
  finally
    RestoreBookmark;
    FDataLink.DataSet.EnableControls;
  end;
end;
}

function TCustomDBGridEh.DataCellSelected(DataCol: Longint; DataRow: TUniBookmarkEh): Boolean;
begin
  Result := Selection.DataCellSelected(DataCol, DataRow);
end;

procedure TCustomDBGridEh.OldDrawDataCell(const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  if Assigned(FOnDrawDataCell) then FOnDrawDataCell(Self, Rect, Field, State);
end;

procedure TCustomDBGridEh.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumnEh; State: TGridDrawState);
begin
  if Assigned(OnDrawColumnCell)
    then OnDrawColumnCell(Self, Rect, DataCol, Column, State);
end;

function TCustomDBGridEh.CanMouseTrackMode: Boolean;
begin
  Result := (FGridState = gsNormal) and (FDBGridEhState = dgsNormal);
end;

function TCustomDBGridEh.CanHotTackCell(X, Y: Integer): Boolean;
begin
  if dghHotTrack in OptionsEh then
    if (X >= 0) and (Y >= 0)
      then Result := True
      else Result := False
  else if (STFilter.Location = stflInTitleFilterEh) and
          (Y = GetTopDataOffset-1)
    then
      Result := True
  else
    Result := inherited CanHotTackCell(X, Y);
end;

procedure TCustomDBGridEh.UpdateHotTackInfo(X, Y: Integer);
var
  AHotTrackCell: TGridCoord;
  NewHotTrackCell: TGridCoord;
  NewHotTrackEditButton: Integer;
  Column: TColumnEh;
  Cell: TGridCoord;
  ARect: TRect;
  LowertTitleHight: Integer;
  OutBRect: TRect;
  k: Integer;
  AHotTrackGroupLevelIdx: Integer;
  GroupRect, StateRect: TRect;
  ADataBox: TGridRect;
  IsDataCell: Boolean;
//  EditButtonArea: Integer;
begin
  AHotTrackCell := FHotTrackCell;
  Cell := MouseCoord(X, Y);
  if RowPanel.Active and (Cell.X >= FIndicatorOffset) then
  begin
    ARect := CellRect(Cell.X, Cell.Y);
    ADataBox := DataBox;
    if (DataBox.Left <= Cell.X) and (DataBox.Right >= Cell.X) and
       (DataBox.Top <= Cell.Y) and (DataBox.Bottom >= Cell.X)
      then IsDataCell := True
      else IsDataCell := False;

    Column := GetColumnInRowPanelAtPos(
      Point(X-ARect.Left+FDataOffset.cx,
            Y-ARect.Top), IsDataCell);
    NewHotTrackCell := FHotTrackCell;
    if Column = nil
      then NewHotTrackCell.X := -1
      else NewHotTrackCell.X := Column.Index + IndicatorOffset;
    NewHotTrackCell.Y := Cell.Y;

    if (AHotTrackCell.X <> NewHotTrackCell.X) or (AHotTrackCell.Y <> NewHotTrackCell.Y) then
    begin
      InvalidateCell(Cell.X, FHotTrackCell.Y);
      FHotTrackCell := NewHotTrackCell;
      InvalidateCell(Cell.X, FHotTrackCell.Y);
    end;

  end else
    inherited UpdateHotTackInfo(X, Y);

  if (AHotTrackCell.X = FHotTrackCell.X) and
     (AHotTrackCell.Y = FHotTrackCell.Y) and
     (Cell.X >= FIndicatorOffset) then
  begin
    ARect := CellRect(Cell.X, Cell.Y);
    Column := Columns[RawToDataColumn(Cell.X)];
    if (IsUseMultiTitle = True) and (Cell.Y = GetTitleRows-1) then
    begin
      LowertTitleHight :=
        ARect.Top - ARect.Bottom - FLeafFieldArr[RawToDataColumn(Cell.X)].FLeaf.Height + 1;// + 3;
      if LowertTitleHight < FHotTrackInCellPos.Y then
      begin
        if FHotTrackMultiTitleOver then
          InvalidateCell(Cell.X, Cell.Y);
        FHotTrackMultiTitleOver := False;
      end else if LowertTitleHight >= FHotTrackInCellPos.Y then
      begin
        if not FHotTrackMultiTitleOver then
          InvalidateCell(Cell.X, Cell.Y);
        FHotTrackMultiTitleOver := True;
      end;
    end;
//      EditButtonArea := Column.EditButtonsWidth;
    NewHotTrackEditButton := GetEditButtonIndexAt(Cell.X, Cell.Y, Column, X-ARect.Left, Y-ARect.Top);
    if (FHotTrackEditButton <> NewHotTrackEditButton) and (GetCursor = Screen.Cursors[crDefault]) then
    begin
      InvalidateCell(Cell.X, FHotTrackCell.Y);
      FHotTrackEditButton := NewHotTrackEditButton;
    end;
  end else
    FHotTrackEditButton := -1;

  if dghHotTrack in OptionsEh then
    if ( (AHotTrackCell.Y <> FHotTrackCell.Y) or
         ((AHotTrackCell.X >= IndicatorOffset) and (FHotTrackCell.X < IndicatorOffset)) or
         ((AHotTrackCell.X < IndicatorOffset) and (FHotTrackCell.X >= IndicatorOffset))
       ) and
       ((dghRowHighlight in OptionsEh) or (dgRowSelect in Options)) then
    begin
      if FHotTrackCell.Y >= 0 then
        GridInvalidateRow(Self, FHotTrackCell.Y);
      if AHotTrackCell.Y >= 0 then
        GridInvalidateRow(Self, AHotTrackCell.Y);
    end;

  AHotTrackGroupLevelIdx := -1;
  NewHotTrackEditButton := -1;
  if OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtTopEh) and PtInRect(OutBRect, Point(X,Y)) then
  begin
    for k := 0 to DataGrouping.ActiveGroupLevelsCount-1 do
    begin
      if DataGrouping.ActiveGroupLevels[k].Column <> nil then
      begin
        GroupRect := DataGrouping.ActiveGroupLevels[k].GroupPanelRect;
        InflateRect(GroupRect,-1,-1);
        if PtInRect(GroupRect, Point(X, Y)) then
        begin
          AHotTrackGroupLevelIdx := k;
          Column := TColumnEh(DataGrouping.ActiveGroupLevels[k].Column);
          if STFilter.Visible and (STFilter.Location = stflInTitleFilterEh) and
             CheckTitleCellFilterButtonPos(Point(X, Y), GroupRect, Column, StateRect)
          then
            NewHotTrackEditButton := 0;
        end;
      end;
    end;
  end;
  if (AHotTrackGroupLevelIdx <> DataGrouping.FHotTrackGroupLevelIdx) or
     ((DataGrouping.FHotTrackGroupLevelIdx >= 0) and
      (NewHotTrackEditButton <> DataGrouping.FHotTrackEditButton)) then
  begin
    if DataGrouping.FHotTrackGroupLevelIdx >= 0 then
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[DataGrouping.FHotTrackGroupLevelIdx].GroupPanelRect;
      WindowsInvalidateRect(Handle, GroupRect, False);
    end;
    DataGrouping.FHotTrackGroupLevelIdx := AHotTrackGroupLevelIdx;
    DataGrouping.FHotTrackEditButton := NewHotTrackEditButton;
    if DataGrouping.FHotTrackGroupLevelIdx >= 0 then
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[DataGrouping.FHotTrackGroupLevelIdx].GroupPanelRect;
      WindowsInvalidateRect(Handle, GroupRect, False);
    end;
  end;
end;

function TCustomDBGridEh.GetEditButtonIndexAt(ACol, ARow: Longint;
  Column: TColumnEh; InCellX, InCellY: Integer): Integer;
var
  ACellRect, ARect1: TRect;
  AEditLineWidth: Integer;
  i: Integer;
  AButtonWidth: Integer;
  Cell: TGridCoord;
  StateRect: TRect;
begin
  Result := -1;
  ACellRect := CellRect(ACol, ARow);
  if ARow < GetTitleRows then
  begin
    Cell.X := ACol;
    Cell.Y := ARow;
    if GetMouseHitCellState(Cell, Point(ACellRect.Left + InCellX, ACellRect.Top + InCellY),
         ACellRect, Column, StateRect) = dgsTitleFilterButtonDown
      then  Result := 0;
  end else
  begin
  // DataRows
    if Flat
      then AEditLineWidth := 1
      else AEditLineWidth := 0;

    SetRect(ARect1, ACellRect.Right - Column.EditButtonsWidth,
                    ACellRect.Top,
                    ACellRect.Right,
                    ACellRect.Top + FInplaceEditorButtonHeight);
    if (ACellRect.Top + InCellY > ARect1.Bottom) or (ACellRect.Left + InCellX < ARect1.Left) then
      Exit;

    if (GetColumnEditStile(Column) <> esSimple) then
    begin
      Inc(ARect1.Left, FInplaceEditorButtonWidth + AEditLineWidth);
      if ARect1.Left > ACellRect.Left + InCellX then
      begin
        Result := 0;
        Exit;
      end;
    end;
    for i := 0 to Column.EditButtons.Count - 1 do
    begin
      if Column.EditButtons[i].Visible then
      begin
        if Column.EditButtons[i].Width > 0
          then AButtonWidth := Column.EditButtons[i].Width + AEditLineWidth
          else AButtonWidth := FInplaceEditorButtonWidth;
        ARect1.Right := ARect1.Left + AButtonWidth + AEditLineWidth;
        Inc(ARect1.Left, AButtonWidth + AEditLineWidth);
        if ARect1.Left > ACellRect.Left + InCellX then
        begin
          Result := i+1;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TCustomDBGridEh.EditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then FOnEditButtonClick(Self);
end;

procedure TCustomDBGridEh.EditingChanged;
begin
  if dgIndicator in Options then InvalidateCell(0, FSelRow);
end;

function TCustomDBGridEh.GetColField(DataCol: Integer): TField;
begin
  Result := nil;
  if (DataCol >= 0) and FDatalink.Active and (DataCol < Columns.Count)
    then Result := Columns[DataCol].Field;
end;

function TCustomDBGridEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomDBGridEh.GetEditLimit: Integer;
begin
  Result := 0;
  if {not}(Assigned(Columns[SelectedIndex].KeyList) and (Columns[SelectedIndex].KeyList.Count > 0)) {ddd\\\} then
  else
    if Assigned(SelectedField) and (SelectedField.DataType = ftString) then
      Result := SelectedField.Size;
end;

function TCustomDBGridEh.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := Columns[RawToDataColumn(ACol)].GetEditMask;
end;

function TCustomDBGridEh.GetEditText(ACol, ARow: Longint): string;
var
  Col: TColumnEh;
begin
  Result := '';
  if FDatalink.Active then
  begin
    Col := Columns[RawToDataColumn(ACol)];
    Result := Col.GetEditText;
  end;
end;

function TCustomDBGridEh.GetFieldCount: Integer;
begin
  Result := FDatalink.FieldCount;
end;

function TCustomDBGridEh.GetFields(FieldIndex: Integer): TField;
begin
  Result := FDatalink.Fields[FieldIndex];
end;

function TCustomDBGridEh.GetFieldValue(ACol: Integer): string;
var
  Field: TField;
begin
  Result := '';
  Field := GetColField(ACol);
  if Field <> nil then Result := Field.DisplayText;
end;

function TCustomDBGridEh.GetSelectedField: TField;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index <> -1
    then Result := Columns[Index].Field
    else Result := nil;
end;

function TCustomDBGridEh.GetSelectedIndex: Integer;
begin
  if RowPanel.Active
   then Result := FInRowPanelCol
   else Result := RawToDataColumn(Col);
end;

procedure TCustomDBGridEh.SetSelectedIndex(Value: Integer);
begin
  MoveCol(Value, 0, False);
end;

function TCustomDBGridEh.HighlightNoDataCellColor(ACol, ARow: Integer; DataCol, DataRow: Integer;
      CellType: TCellAreaTypeEh; AState: TGridDrawState; InMultiSelect: Boolean; var AColor: TColor;
      AFont: TFont): Boolean;
begin
  if Assigned(Style) then
    Result := Style.HighlightNoDataCellColor(Self, ACol, ARow, DataCol, DataRow,
      CellType, AState, InMultiSelect, AColor, AFont)
  else
  begin
    Result := False;
    if InMultiSelect then
    begin
      if ((CellType.HorzType = hctIndicatorEh) and (CellType.VertType <> vctAboveFooterEh)) or
         ((CellType.HorzType <> hctIndicatorEh) and (CellType.VertType in [vctTitleEh, vctSubTitleEh])) then
      begin
        AColor := RGB(64, 64, 64);
        AFont.Color := clWhite;
      end else if IsSelectionActive then
      begin
        AColor := clHighlight;
        AFont.Color := clHighlightText;
      end else
        AColor := clBtnFace;
      Result := True;
    end;
  end;
end;

function TCustomDBGridEh.HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string;
   AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean;
var
  Multiselected, AFocused: Boolean;
begin
  Multiselected := False;
  if {(dgMultiSelect in Options) and }Datalink.Active then
      Multiselected := (Selection.SelectionType <> gstNon) and
        Selection.DataCellSelected(DataCol, Datalink.Datasource.Dataset.Bookmark);
  if CanFillSelectionByTheme then
    Result := False
  else if Assigned(Style) then
    Result := Style.HighlightDataCellColor(Self, DataCol + IndicatorOffset, DataRow + TopDataOffset,
      DataCol, DataRow, Value, AState, Multiselected, AColor, AFont)
  else
  begin
    Result := Multiselected;
    AFocused := False;
    if not Result then
    begin
      AFocused := Focused and (dghHighlightFocus in OptionsEh);
      if (dghRowHighlight in OptionsEh) and (DataRow + TopDataOffset = Row) and
        (Selection.SelectionType = gstNon) and not (DataCol + FIndicatorOffset = Col) then
      begin
        AFocused := True;
        AState := AState + [gdSelected];
      end;
      Result := ((gdSelected in AState) {ddd//} or ((DataRow + TopDataOffset) = Row) and (dgRowSelect in Options))
        and ((dgAlwaysShowSelection in Options) or (AFocused {ddd//}))
          { updatelock eliminates flicker when tabbing between rows }
      and ((UpdateLock = 0) or (dgRowSelect in Options));
    end;
    if Result then
      if IsSelectionActive then
      begin
        AColor := clHighlight;
        AFont.Color := clHighlightText;
      end else if (DataRow + TopDataOffset = Row) and
                  ((DataCol + FIndicatorOffset = Col) or (dgRowSelect in Options)) and
                  ((dgAlwaysShowSelection in Options) or AFocused) then
      begin
        AColor := clBtnShadow;
        AFont.Color := clHighlightText;
      end else
        AColor := clBtnFace;
  end;
end;

procedure TCustomDBGridEh.ClearSelection;
begin
  if dgMultiSelect in Options then
  begin
    FBookmarks.Clear;
    FSelecting := False;
  end
  else FSelecting := False;
  if Selection.SelectionType <> gstNon then
  begin
    Selection.Clear;
    Invalidate;
    InvalidateEditor;
  end;
end;

procedure TCustomDBGridEh.CheckClearSelection;
begin
  if (dghClearSelection in OptionsEh) then
    ClearSelection;
  FSelecting := False;
end;

procedure TCustomDBGridEh.DoSelection(Select: Boolean; Direction: Integer;
  MaxDirection, RowOnly: Boolean);
var
  AddAfter: Boolean;
  DisabledControls: Boolean;
begin
  if RowOnly or (dgRowSelect in Options) then
  begin
    AddAfter := False;
    Select := Select and CanSelectType(gstRecordBookmarks);
    begin
      DisabledControls := False;
      BeginUpdate;
      try
        if ((Abs(Direction) >= FDataLink.RecordCount) or MaxDirection) and
          (((Direction > 0) and not DataSource.DataSet.EOF) or
          ((Direction < 0) and not DataSource.DataSet.BOF)) then
        begin
          //DisabledControls := True;
          //DataSource.DataSet.DisableControls;
        end;
        try
          while (Direction <> 0) {or (MaxDirection and not FDatalink.EOF and not FDatalink.BOF)} do
          begin
            if (dgMultiSelect in Options) and FDatalink.Active then
              if Select {ddd and (ssShift in Shift)} then
              begin
                if not FSelecting then
                begin
                  FSelectionAnchor := FBookmarks.CurrentRow;
                  {ddd//}
                  FSelectionAnchorSelected := FBookmarks.CurrentRowSelected;
                  if FAntiSelection then
                    FBookmarks.CurrentRowSelected := not FSelectionAnchorSelected
                  else
                  {ddd\\\}
                    FBookmarks.CurrentRowSelected := True;
                  FSelecting := True;
                  AddAfter := True;
                end
                else
                  with FBookmarks do
                  begin
                    AddAfter := Compare(CurrentRow, FSelectionAnchor) <> -(Direction div Abs(Direction));
                    if not AddAfter then
                      if FAntiSelection
                        then CurrentRowSelected := FSelectionAnchorSelected
                        else CurrentRowSelected := False;
                  end
              end
              else
                CheckClearSelection;
            if MoveBy(Direction div Abs(Direction)) = 0 then Exit;
  ////ddd      if AddAfter then FBookmarks.CurrentRowSelected := True;
            if AddAfter then
              if FAntiSelection
                then FBookmarks.CurrentRowSelected := not FSelectionAnchorSelected
                else FBookmarks.CurrentRowSelected := True;
            if not MaxDirection then
              if (Direction > 0) then Dec(Direction) else Inc(Direction);
//            FCurrentRecordBookmark := FBookmarks.CurrentRow;
          end;
  ////ddd\\\
        finally
          if DisabledControls then DataSource.DataSet.EnableControls;
        end;
      finally
        EndUpdate;
        if (FUpdateLock = 0) and FSizeChanged then
          DoAfterSizeChanged;
      end
    end;
  end else //Rectangle select
  begin
    Select := Select and CanSelectType(gstRectangle);
    if not Select then
      MoveBy(Direction)
    else
    begin
      BeginUpdate;
      try
        if Selection.FSelectionType <> gstRectangle then
        begin
          Selection.Rect.Clear;
          Selection.Rect.Select(RawToDataColumn(Col), Datalink.Datasource.Dataset.Bookmark, True);
        end;
        if MaxDirection then
          if Direction = 1
            then FDatalink.Dataset.Last
            else FDatalink.Dataset.First
        else
          MoveBy(Direction);
        Selection.Rect.Select(RawToDataColumn(Col), Datalink.Datasource.Dataset.Bookmark, True);
      finally
        EndUpdate;
        if (FUpdateLock = 0) and FSizeChanged then
          DoAfterSizeChanged;
      end;
    end;
  end;
  if UpdateLock = 0 then Update;
end;


procedure TCustomDBGridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;
  RowDetailPanelAvailable: Boolean;
  NextColumn, AUpDownBaseColumn: TColumnEh;

  procedure NextRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
        if EOF then Exit else Cancel
      else if ssShift in Shift then
        DoSelection(Select, 1, False, not (gstRectangle in AllowedSelections))
      else
        DoSelection(False, 1, False, True);
      if EOF and CanModify and (not ReadOnly) and
        (dgEditing in Options) and (alopAppendEh in AllowedOperations)
        then Append;
    end;
  end;

  procedure PriorRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
      if (State = dsInsert) and not Modified and EOF and
        not FDatalink.FModified then
        Cancel
      else if ssShift in Shift then
        DoSelection(Select, -1, False, not (gstRectangle in AllowedSelections))
      else
        DoSelection(False, -1, False, True);
  end;

  procedure Tab(GoForward: Boolean);
  var
//    ACol, Original: Integer;
    NextCol: TColumnEh;
  begin
//    ACol := SelectedIndex;
//    Original := ACol;
    CheckClearSelection;
    BeginUpdate; { Prevent highlight flicker on tab to next/prior row }
    try
      NextCol := Columns.GetNextTabColumn(Columns[SelectedIndex], GoForward);
      if NextCol = Columns[SelectedIndex] then
      begin
        if GoForward then
        begin
          NextRow(False);
          NextCol := Columns.GetFirstTabColumn;
        end else
        begin
          PriorRow(False);
          NextCol := Columns.GetLastTabColumn;
        end;
        if NextCol <> nil then
          SelectedIndex := NextCol.Index;
      end else if NextCol <> nil then
        SelectedIndex := NextCol.Index;
(*      while True do
      begin
        if GoForward then
          Inc(ACol) else
          Dec(ACol);
        if ACol >= Columns.Count then
        begin
          NextRow(False);
          ACol := 0; //FirstVisibleColumn;
        end
        else if ACol < IndicatorOffset then
        begin
          PriorRow(False);
          ACol := Columns.Count-1;
        end;
        if ACol = Original then Exit;
        if Columns[ACol].IsTabStop then
        begin
          SelectedIndex := ACol;
          Exit;
        end;
      end;*)
    finally
      EndUpdate;
    end;
  end;

  function CheckIsFilterKey: Boolean;
  var
    LastFilterCol: Integer;
  begin
    Result := False;
    if (Key = VK_UP) and
        STFilter.Visible and
        (STFilter.Location = stflUnderTitleFilterEh) and
        DataLink.Active and
        (DataLink.Bof or (ssCtrl in Shift)) then
    begin
      if (dgRowSelect in Options) then
      begin
        LastFilterCol := FFilterCol; //DataToRawColumn(SelectedIndex);
        while (LastFilterCol < Columns.Count) and not CanFilterCol(LastFilterCol) do
          Inc(LastFilterCol);
        if ((LastFilterCol >= FixedCols) and (LastFilterCol < LeftCol))
          or (LastFilterCol >= LeftCol + VisibleColCount) or (LastFilterCol < IndicatorOffset) then
        begin
          FFilterCol := RawToDataColumn(LeftCol);
          while (FFilterCol < Columns.Count) and not CanFilterCol(FFilterCol) do
            Inc(FFilterCol);
          StartEditFilter(FFilterCol);
        end
        else
          StartEditFilter(LastFilterCol);
      end
      else
        StartEditFilter(SelectedIndex);
      Key := 0;
      Result := True;
    end;
  end;

  procedure FocusToDetailPanel;
  var
    List: TList;
    Control: TWinControl;
    i: Integer;
  begin
    if not (csLoading in ComponentState) and
      not (csDesigning in ComponentState) and
      (RowDetailPanel.ActiveControl <> nil) then
    begin
      RowDetailPanel.ActiveControl.SetFocus;
      Exit;
    end;
    List := TList.Create;
    try
      FRowDetailControl.GetTabOrderList(List);
      if List.Count > 0 then
        for i := 0 to List.Count-1 do
        begin
          Control := TWinControl(List[i]);
          if Control.CanFocus and Control.TabStop then
          begin
            Control.SetFocus;
            Exit;
          end;
        end;
    finally
      List.Free;
    end;
  end;

const
  RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END];

begin
  KeyDownEvent := OnKeyDown;
  {ddd//} FAntiSelection := (ssCtrl in Shift) or not (dghClearSelection in OptionsEh);
  if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
  CheckIsFilterKey;
  if Self.UseRightToLeftAlignment then
    if Key = VK_LEFT then
      Key := VK_RIGHT
    else if Key = VK_RIGHT then
      Key := VK_LEFT;
  if not FDatalink.Active or not CanGridAcceptKey(Key, Shift)
    then Exit;
  if DataGrouping.IsGroupingWorks and (FCurGroupDataNode.NodeType = dntDataGroupEh) then
  begin
    KeyDownInGroupDataNode(Key, Shift);
    Exit;
  end;
  if STFilter.Visible and
    (SelectedIndex >= 0) and
    (STFilter.Location = stflInTitleFilterEh) and
    Columns[SelectedIndex].STFilter.Visible and
    (ShortCut(Key, Shift) = DBGridEhShowInTitleFilterBox)
  then
    InTitleFilterListboxDropDown(Columns[SelectedIndex])
  else if (ShortCut(Key, Shift) = DBGridEhSetValueFromPrevRecordKey) then
    SetValueFromPrevRecord
  else if (ShortCut(Key, Shift) = DBGridEhInplaceSearchKey) and (dghIncSearch in OptionsEh) then
    if InplaceSearching and (dghDialogFind in OptionsEh) and (DBGridEhFindDialogKey = DBGridEhInplaceSearchKey) then
    begin
      StopInplaceSearch;
      ExecuteFindDialog('', '', IsFindDialogShowAsModal);
//      ExecuteDBGridEhFindDialogProc(Self, '', '', nil, IsFindDialogShowAsModal);
    end else
      StartInplaceSearch('', -1, ltdAllEh)
  else if (ShortCut(Key, Shift) = DBGridEhFindDialogKey) and (dghDialogFind in OptionsEh) then
    ExecuteFindDialog('', '', IsFindDialogShowAsModal)
//    ExecuteDBGridEhFindDialogProc(Self, '', '', nil, IsFindDialogShowAsModal)
  else if FInplaceSearching then
    if (Key in [VK_ESCAPE, VK_RETURN, VK_F2]) and (Shift = [])
      then StopInplaceSearch
    else if (Key = VK_BACK) and (Shift = []) then
    begin
{$IFNDEF CIL}
      if ByteType(FInplaceSearchText, Length(FInplaceSearchText)) = mbTrailByte then
        FInplaceSearchText := Copy(FInplaceSearchText, 1, Length(FInplaceSearchText) - 2)
      else
{$ENDIF}
        FInplaceSearchText := Copy(FInplaceSearchText, 1, Length(FInplaceSearchText) - 1);
      GridInvalidateRow(Self, Row);
      StartInplaceSearchTimer;
    end else if ShortCut(Key, Shift) = DBGridEhInplaceSearchNextKey
      then StartInplaceSearch('', FInplaceSearchTimeOut, ltdDownEh)
    else if ShortCut(Key, Shift) = DBGridEhInplaceSearchPriorKey
      then StartInplaceSearch('', FInplaceSearchTimeOut, ltdUpEh);
  with FDatalink.DataSet do
    if ssCtrl in Shift then
    begin
      if (Key in RowMovementKeys) and not (ssShift in Shift) then CheckClearSelection;
      case Key of
        VK_UP, VK_PRIOR:
          if (ssShift in Shift) and (dgMultiSelect in Options)
            then DoSelection(True, -FDatalink.ActiveRecord, False, False)
            else Self.MoveBy(-FDatalink.ActiveRecord);
        VK_NEXT:
          if (ssShift in Shift) and (dgMultiSelect in Options)
            then DoSelection(True, FDatalink.BufferCount - FDatalink.ActiveRecord - 1, False, False)
            else Self.MoveBy(FDatalink.BufferCount - FDatalink.ActiveRecord - 1);
        VK_DOWN:
          if RowDetailPanel.Active then
          begin
            RowDetailPanelAvailable := RowDetailPanel.Active;
            if Assigned(OnCheckRowHaveDetailPanel) then
              OnCheckRowHaveDetailPanel(Self, RowDetailPanelAvailable);
            if RowDetailPanelAvailable then
            begin
              RowDetailPanel.Visible := True;
              FocusToDetailPanel;
            end;
          end else
          begin
            if (ssShift in Shift) and (dgMultiSelect in Options)
              then DoSelection(True, FDatalink.BufferCount - FDatalink.ActiveRecord - 1, False, False)
              else Self.MoveBy(FDatalink.BufferCount - FDatalink.ActiveRecord - 1);
          end;
//ddd        VK_LEFT: MoveCol(FIndicatorOffset);
        VK_LEFT: MoveCol(0, 1, False);
        VK_RIGHT: MoveCol(Columns.Count - 1, -1, False);
        VK_HOME: {d/} if (ssShift in Shift) and (dgMultiSelect in Options)
          then DoSelection(True, -1, True, False)
          else {d\}  First;
        VK_END: {d/} if (ssShift in Shift) and (dgMultiSelect in Options)
          then DoSelection(True, 1, True, False)
          else {d\}  Last;
        VK_DELETE:
          if (geaDeleteEh in EditActions) and (Selection.SelectionType <> gstNon) then
          begin
            if CheckDeleteAction then
              DBGridEh_DoDeleteAction(Self, False);
          end
          else if (not Self.ReadOnly) and (not ReadOnly) and not IsEmpty
            and CanModify and (alopDeleteEh in AllowedOperations) and DeletePrompt then
            if FBookmarks.Count > 0
              then FBookmarks.Delete
              else Delete;
        VK_INSERT, Word('C'):
          if CheckCopyAction and (geaCopyEh in EditActions) then
            DBGridEh_DoCopyAction(Self, False);
        Word('X'):
          if CheckCutAction and (geaCutEh in EditActions) then
            DBGridEh_DoCutAction(Self, False);
        Word('V'):
          if FInplaceSearching then
            StartInplaceSearch(ClipBoard.AsText, FInplaceSearchTimeOut, ltdAllEh)
          else if CheckPasteAction and (geaPasteEh in EditActions) then
            DBGridEh_DoPasteAction(Self, False);
        Word('A'):
          if CheckSelectAllAction and (geaSelectAllEh in EditActions) then
            Selection.SelectAll;
      end
    end
    else
      case Key of
        VK_UP:
          if RowPanel.Active and (RowPanel.NavKeysNavigationType = rpntCellToCellEh) then
          begin
            if Columns.FUpDownBaseColumn = nil
              then AUpDownBaseColumn := Columns[SelectedIndex]
              else AUpDownBaseColumn := Columns.FUpDownBaseColumn;
            NextColumn := Columns.GetNextVertColumn(Columns[SelectedIndex], False);
            if (NextColumn = Columns[SelectedIndex]) and not FDataLink.BOF then
            begin
              SelectedIndex := Columns.GetBottomColumn(NextColumn).Index;
              PriorRow(True);
              if FDataLink.BOF then
                SelectedIndex := NextColumn.Index;
            end else
              SelectedIndex := NextColumn.Index;
            Columns.FUpDownBaseColumn := AUpDownBaseColumn;
          end else
            PriorRow(True);
        VK_DOWN:
          if RowDetailPanel.Visible then
            FocusToDetailPanel
          else if RowPanel.Active and (RowPanel.NavKeysNavigationType = rpntCellToCellEh) then
          begin
            if Columns.FUpDownBaseColumn = nil
              then AUpDownBaseColumn := Columns[SelectedIndex]
              else AUpDownBaseColumn := Columns.FUpDownBaseColumn;
            NextColumn := Columns.GetNextVertColumn(Columns[SelectedIndex], True);
            if NextColumn = Columns[SelectedIndex] then
            begin
              if not FDataLink.EOF then
              begin
                SelectedIndex := Columns.GetTopColumn(NextColumn).Index;
                FLockAutoShowCurCell := True;
                try
                  NextRow(True);
                finally
                  FLockAutoShowCurCell := False;
                end;
                if FDataLink.EOF then
                  SelectedIndex := NextColumn.Index;
              end;
            end  else
              SelectedIndex := NextColumn.Index;
            Columns.FUpDownBaseColumn := AUpDownBaseColumn;
          end else
            NextRow(True);
        VK_LEFT:
          if dgRowSelect in Options then
          begin
//            if (LeftCol > {//dddIndicatorOffset} FixedCols {\\\}) then
//              LeftCol := LeftCol - 1
            inherited KeyDown(Key, Shift);
          end
          {PriorRow(False)}else if (dgMultiSelect in Options) and (ssShift in Shift) then
            MoveCol(SelectedIndex - 1, -1, True)
          else
          begin
            CheckClearSelection;
            if RowPanel.Active and (RowPanel.NavKeysNavigationType = rpntCellToCellEh)
              then SelectedIndex := Columns.GetNextHorzColumn(Columns[SelectedIndex], False, False, False).Index
              else MoveCol(SelectedIndex - 1, -1, False);
          end;
        VK_RIGHT:
          if dgRowSelect in Options then
          begin
//            if (VisibleColCount + LeftCol < ColCount) then
//              LeftCol := LeftCol + 1; {new}
            inherited KeyDown(Key, Shift);
          end else if (dgMultiSelect in Options) and (ssShift in Shift)
            then MoveCol(SelectedIndex + 1, 1, True)
          else
          begin
            CheckClearSelection;
            if RowPanel.Active and (RowPanel.NavKeysNavigationType = rpntCellToCellEh)
              then SelectedIndex := Columns.GetNextHorzColumn(Columns[SelectedIndex], True, False, False).Index
              else MoveCol(SelectedIndex + 1, 1, False);
          end;
        VK_HOME:
          if (ColCount = FIndicatorOffset + 1) or (dgRowSelect in Options) then
          begin
            if (ssShift in Shift) and (dgMultiSelect in Options)
              then DoSelection(True, -1, True, False)
            else
            begin
              CheckClearSelection;
              First;
            end;
          end else if (dgMultiSelect in Options) and (ssShift in Shift) then
            MoveCol(0, 1, True)
          else
            MoveCol(0, 1, False);
        VK_END:
          if (ColCount = FIndicatorOffset + 1)
            or (dgRowSelect in Options) then
          begin
            if (ssShift in Shift) and (dgMultiSelect in Options) then
              DoSelection(True, 1, True, False)
            else
            begin
              CheckClearSelection;
              Last;
            end;
          end else if (dgMultiSelect in Options) and (ssShift in Shift) then
            MoveCol(Columns.Count - 1, -1, True)
          else
            MoveCol(Columns.Count - 1, -1, False);
        VK_NEXT:
          begin
            if (ssShift in Shift) and (dgMultiSelect in Options) then
              DoSelection(True, VisibleDataRowCount, False, not (gstRectangle in AllowedSelections))
            else
            begin
              CheckClearSelection;
              if MemTableSupport and (RowCount - TopRow - VisibleRowCount < VisibleRowCount) then
                FIntMemTable.FetchRecords(VisibleRowCount - (RowCount - TopRow - VisibleRowCount));
              Self.MoveBy({ddd//VisibleRowCount} VisibleDataRowCount {ddd\\});
            end;
          end;
        VK_PRIOR:
          begin
            //ddd
            if (ssShift in Shift) and (dgMultiSelect in Options) then
              DoSelection(True, -VisibleDataRowCount, False, not (gstRectangle in AllowedSelections))
            else begin
              CheckClearSelection;
              Self.MoveBy({ddd//VisibleRowCount}-VisibleDataRowCount {ddd\\});
            end;
            //\\\
          end;
        VK_INSERT:
          if (ssShift in Shift) then
          begin
            if FInplaceSearching then
              StartInplaceSearch(ClipBoard.AsText, FInplaceSearchTimeOut, ltdAllEh)
            else if CheckPasteAction and (geaPasteEh in EditActions) then
              DBGridEh_DoPasteAction(Self, False)
          end
          else if CanModify and (not ReadOnly) and (dgEditing in Options) then
          begin
            CheckClearSelection;
            if alopInsertEh in AllowedOperations then DataInsert
            else if alopAppendEh in AllowedOperations then DataAppend;
          end;
        VK_TAB: if not (ssAlt in Shift) then Tab(not (ssShift in Shift));
        VK_RETURN: if dghEnterAsTab in OptionsEh then Tab(not (ssShift in Shift));
        VK_ESCAPE:
          begin
            FDatalink.Reset;
            ClearSelection;
            if not (dgAlwaysShowEditor in Options) then HideEditor;
            if (FGridState in [gsColMoving, gsRowSizing, gsColSizing]) or
              (FDBGridEhState in [dgsColSizing, dgsRowMoving, dgsGroupPanelTitleMoving] )
              then Perform(WM_CANCELMODE, 0, 0);
          end;
        VK_F2: EditorMode := True;
        VK_DELETE:
          if (ssShift in Shift) and CheckCutAction and (geaCutEh in EditActions) then
            DBGridEh_DoCutAction(Self, False);
        VK_ADD, VK_SUBTRACT, VK_MULTIPLY:
          if ViewScroll and FIntMemTable.MemTableIsTreeList then
            case Key of
              VK_ADD: FIntMemTable.SetTreeNodeExpanded(Row - TopDataOffset, True);
              VK_SUBTRACT: FIntMemTable.SetTreeNodeExpanded(Row - TopDataOffset, False);
              VK_MULTIPLY: FIntMemTable.SetTreeNodeExpanded(Row - TopDataOffset, not FIntMemTable.GetTreeNodeExpanded);
            end
          else if RowDetailPanel.Active then
          begin
            RowDetailPanelAvailable := RowDetailPanel.Active;
            if Assigned(OnCheckRowHaveDetailPanel) then
            OnCheckRowHaveDetailPanel(Self, RowDetailPanelAvailable);
            if RowDetailPanelAvailable then
              case Key of
                VK_ADD: RowDetailPanel.Visible := True;
                VK_SUBTRACT: RowDetailPanel.Visible := False;
                VK_MULTIPLY: RowDetailPanel.Visible := not RowDetailPanel.Visible;
              end
          end;
      end;
  if (Columns[SelectedIndex].GetColumnType in [ctKeyImageList..ctCheckboxes]) and
    ((Key = VK_DELETE) and not (ssCtrl in Shift)) and not (dgRowSelect in Options) then
    if Assigned(Columns[SelectedIndex].Field) and
      not Columns[SelectedIndex].Field.Required and
      Columns[SelectedIndex].CanModify(True) then
         //Columns[SelectedIndex].Field.Clear;
      Columns[SelectedIndex].UpdateDataValues('', Null, False);
end;

procedure TCustomDBGridEh.KeyPress(var Key: Char);
begin
  if (dghEnterAsTab in OptionsEh) and (Integer(Key) = VK_RETURN) then Key := #9;
  if not (dgAlwaysShowEditor in Options) and (Key = #13) then
    FDatalink.UpdateData;
  inherited KeyPress(Key);
  if (  FInplaceSearching or
//       ((dghIncSearch in OptionsEh) and not CanEditModifyColumn(SelectedIndex)) or
       ((dghPreferIncSearch in OptionsEh) and not (dgAlwaysShowEditor in Options) and not InplaceEditorVisible)
     ) and (Key >= #32) and FDatalink.Active and not (FDatalink.DataSet.State in dsEditModes)
    then
  begin
    if FInplaceSearching
      then StartInplaceSearch(GetCompleteKeyPress, FInplaceSearchTimeOut, ltdAllEh)
      else StartInplaceSearch(GetCompleteKeyPress, DBGridEhInplaceSearchTimeOut, ltdAllEh);
    Key := #0;
  end;
end;

function TCustomDBGridEh.GetCompleteKeyPress: String;
begin
  Result := FCompleteKeyPress;
end;

procedure TCustomDBGridEh.ShowFilterEditorChar(Ch: Char);
begin
  UpdateFilterEdit(True);
  if (FilterEdit <> nil) and (FilterEdit.Visible) then
    PostMessage(FilterEdit.Handle, WM_CHAR, Word(Ch), 0);
end;

procedure TCustomDBGridEh.WMChar(var Message: TWMChar);
var CharMsg: TMsg;
  DBC: Boolean;
begin
  FCompleteKeyPress := Char(Message.CharCode);
  try
    DBC := False;
    if FilterEditMode and (
      (Char(Message.CharCode) = ^H) or (Char(Message.CharCode) >= #32) ) then
      ShowFilterEditorChar(Char(Message.CharCode))
    else if CharInSetEh(Char(Message.CharCode), LeadBytes) then
      if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_NOREMOVE) then
        if CharMsg.Message <> WM_Quit then
        begin
          FCompleteKeyPress := FCompleteKeyPress + Char(CharMsg.wParam);
          DBC := True;
        end;

    {Don't use KeyPress because KeyPress is invoked only after
    first showing of inplace editor}
    if (Columns[SelectedIndex].GetColumnType in [ctKeyImageList..ctCheckboxes]) and
      ((Char(Message.CharCode) = ' ') and not (dgRowSelect in Options)) then
    begin
      DoKeyPress(Message);
      if Char(Message.CharCode) = ' ' then
        if ssShift in KeyDataToShiftState(Message.KeyData)
          then Columns[SelectedIndex].SetNextFieldValue(-1)
          else Columns[SelectedIndex].SetNextFieldValue(1);
    end
    else if ( FInplaceSearching
            or
             ((dghIncSearch in OptionsEh) and
             not CanEditModifyColumn(SelectedIndex))
            or
             ((dghPreferIncSearch in OptionsEh) and not (dgAlwaysShowEditor in Options) and not InplaceEditorVisible)
            ) and
            ((Char(Message.CharCode) >= #32) or (Char(Message.CharCode) = #8)) and
             FDatalink.Active and not (FDatalink.DataSet.State in dsEditModes)
            or
            ( ((ViewScroll and FIntMemTable.MemTableIsTreeList) or RowDetailPanel.Active)
              and
                CharInSetEh(Char(Message.CharCode), ['+', '-', '*']) )
      then
    begin
      DoKeyPress(Message);
    end else
      inherited;

    if DBC and (Char(Message.CharCode) = #0) then
      PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
  finally
    FCompleteKeyPress := '';
  end;
end;

function TCustomDBGridEh.IndicatorColVisible: Boolean;
begin
  Result := (dgIndicator in Options) or (dghShowRecNo in OptionsEh);
end;

{ InternalLayout is called with layout locks and column locks in effect }
procedure TCustomDBGridEh.InternalLayout;
var
  I, J, K, OldLeftCol: Integer;
  Fld: TField;
  Column: TColumnEh;
  SeenPassthrough: Boolean;
  RestoreCanvas: Boolean;

  tm: TTEXTMETRIC;
  CW, CountedWidth, FirstInvisibleColumns, ColWidth: Integer;
  AFont: TFont;
  NotInWidthRange: Boolean;
  NewScrollStyle: TScrollStyle;
  AFixedCols: Integer;
  LColorRef: TColorRef;
//  RowHeights0: Integer;

  function FieldIsMapped(F: TField): Boolean;
  var
    X: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for X := 0 to FDatalink.FieldCount - 1 do
      if FDatalink.Fields[X] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

begin
  if (csLoading in ComponentState) or
     (csDestroying in ComponentState)
  then
    Exit;

  FColWidthsChanged := False;
  if HandleAllocated then KillMessage(Handle, cm_DeferLayout);

  try
    LockPaint;

  { Check for Columns.State flip-flop }
  SeenPassthrough := False;
  for I := 0 to FColumns.Count - 1 do
  begin
    if not FColumns[I].IsStored then
      SeenPassthrough := True
    else
      if SeenPassthrough then
      begin { We have both custom and passthrough columns. Kill the latter }
        for J := FColumns.Count - 1 downto 0 do
        begin
          Column := FColumns[J];
          if not Column.IsStored then
            Column.Free;
        end;
        Break;
      end;
  end;

  FIndicatorOffset := 0;
  if IndicatorColVisible then
    Inc(FIndicatorOffset);
  FDatalink.ClearMapping;
  if FDatalink.Active then DefineFieldMap;
  if FColumns.State = csDefault then
  begin
     { Destroy columns whose fields have been destroyed or are no longer
       in field map }
    if (not FDataLink.Active) and (FDatalink.DefaultFields) then
      FColumns.Clear
    else
      for J := FColumns.Count - 1 downto 0 do
        with FColumns[J] do
          if not Assigned(Field)
            or not FieldIsMapped(Field) then Free;
    I := FDataLink.FieldCount;
    if (I = 0) and (FColumns.Count = 0) then Inc(I);
    for J := 0 to I - 1 do
    begin
      Fld := FDatalink.Fields[J];
      if Assigned(Fld) then
      begin
        K := J;
         { Pointer compare is valid here because the grid sets matching
           column.field properties to nil in response to field object
           free notifications.  Closing a dataset that has only default
           field objects will destroy all the fields and set associated
           column.field props to nil. }
        while (K < FColumns.Count) and (FColumns[K].Field <> Fld) do
          Inc(K);
        if K < FColumns.Count then
          Column := FColumns[K]
        else
        begin
          Column := FColumns.InternalAdd;
          Column.Field := Fld;
        end;
      end
      else
        Column := FColumns.InternalAdd;
      Column.Index := J;
    end;
  end else
  begin
    { Force columns to reaquire fields (in case dataset has changed) }
    for I := 0 to FColumns.Count - 1 do
      FColumns[I].Field := nil;
  end;
  FVisibleColumns.Clear;

  FirstInvisibleColumns := 0;
  for I := 0 to FColumns.Count - 1 do
    if FColumns[I].Visible = True then
    begin
      FVisibleColumns.Add(FColumns[I]);
    end
    else if (FrozenCols + FirstInvisibleColumns > I)
      then Inc(FirstInvisibleColumns);

  for I := FrozenCols + FirstInvisibleColumns to FColumns.Count - 1 do
    if (FColumns[I].Visible = False)
      then Inc(FirstInvisibleColumns)
      else Break;

  if VisibleColumns.Count = 0 then Dec(FirstInvisibleColumns);

  if HandleAllocated then
  begin
    Columns.RelayoutCellsInRowPanel;
    ResetTabIndexedColumns;
    ResetGroupPanel;
  end;

  AFixedCols := FIndicatorOffset + FrozenCols;
  if not (FrozenCols < VisibleColumns.Count) then
    AFixedCols := FIndicatorOffset + VisibleColumns.Count - 1;

  if not FDataLink.Active and (Columns.State = csDefault) then
  begin
    ColCount := FColumns.Count + FIndicatorOffset;
    inherited ContraColCount := 0;
  end else
  begin
    if ContraColCount >= VisibleColumns.Count - AFixedCols
      then inherited ContraColCount := VisibleColumns.Count - AFixedCols
      else inherited ContraColCount := ContraColCount;
    ColCount := FColumns.Count + FIndicatorOffset - inherited ContraColCount;
  end;

//  inherited FixedCols := FIndicatorOffset + FrozenCols + FirstInvisibleColumns;
  if not FDataLink.Active and (Columns.State = csDefault)
    then inherited FixedCols := FIndicatorOffset + FirstInvisibleColumns
    else inherited FixedCols := AFixedCols;
  if not FDataLink.Active and (Columns.State = csDefault)
    then FrozenColCount := 0
    else FrozenColCount := FixedCols - FIndicatorOffset;

  RestoreCanvas := not HandleAllocated and not FCanvasHandleAllocated; //not Canvas.HandleAllocated;
  if RestoreCanvas then
  begin
    Canvas.Handle := GetDC(0);
    FCanvasHandleAllocated := True;
  end;
  try
    Canvas.Font := Font;
    if Flat
      then J := 1
      else J := 3;
    if dgRowLines in Options then
      Inc(J, GridLineWidth);
    K := Canvas.TextHeight('Wg');
    // DefaultRowHeight := K;
//    RowHeights0 := RowHeights[0];
    GetTextMetrics(Canvas.Handle, tm);
    if (FNewRowHeight > 0) or (FRowLines > 0)
      then FStdDefaultRowHeight := FNewRowHeight + (tm.tmExternalLeading + tm.tmHeight) * FRowLines
      else FStdDefaultRowHeight := K + J;

    if (dghFitRowHeightToText in OptionsEh) then
    begin
      I := (FStdDefaultRowHeight - J) mod K;
      if (I > K div 2) or ((FStdDefaultRowHeight - J) div K = 0)
        then FStdDefaultRowHeight := ((FStdDefaultRowHeight - J) div K + 1) * K + J
        else FStdDefaultRowHeight := (FStdDefaultRowHeight - J) div K * K + J;
      FRowLines := (FStdDefaultRowHeight - J) div K;
      FNewRowHeight := J;
    end;
//    RowHeights[0] := RowHeights0;
    if RowPanel.Active then
    begin
      if FGridMasterCellHeight > 0 then
        FStdDefaultRowHeight := FGridMasterCellHeight;
      FColWidthsChanged := True;
    end;

    if FStdDefaultRowHeight > Round(FInplaceEditorButtonWidth * 3 / 2)
      then FInplaceEditorButtonHeight := DefaultEditButtonHeight(FInplaceEditorButtonWidth,  Flat)
      else FInplaceEditorButtonHeight := FStdDefaultRowHeight;

    if (tm.tmExternalLeading + tm.tmHeight + tm.tmInternalLeading + FInterlinear < FStdDefaultRowHeight)
      then FAllowWordWrap := True
      else FAllowWordWrap := False;

    if (dgTitles in Options) and not (IsUseMultiTitle = True) then
    begin
      K := 0;
      for I := 0 to FColumns.Count - 1 do
      begin
        Canvas.Font := FColumns[I].Title.Font;
        J := Canvas.TextHeight('Wg') + FInterlinear;
        if J > K then K := J;
      end;
      if K = 0 then
      begin
        Canvas.Font := FTitleFont;
        K := Canvas.TextHeight('Wg') + FInterlinear;
      end;
      FTitleRowHeight := K;
    end;
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
      FCanvasHandleAllocated := False;
    end;
  end;

   // ScrollBars
  if (not AutoFitColWidths or (csDesigning in ComponentState)) and
    HorzScrollBar.Visible and (HorzScrollBar.ExtScrollBar = nil)
  then NewScrollStyle := ssHorizontal
  else NewScrollStyle := ssNone;

  if VertScrollBar.Visible and (VertScrollBar.VisibleMode <> sbNeverShowEh) and
     ExtendedScrolling and VertScrollBar.SmoothStep
  then
    if NewScrollStyle = ssNone
      then NewScrollStyle := ssVertical
      else NewScrollStyle := ssBoth;

  if (ScrollBars <> NewScrollStyle) and HandleAllocated then
  begin
    ScrollBars := NewScrollStyle;
    HandleNeeded;
    UpdateScrollBar;
  end else if ScrollBars <> NewScrollStyle then
    ScrollBars := NewScrollStyle;

  // AutoFitColWidths
  SetColumnAttributes;
  if (FAutoFitColWidths = True) and not (csDesigning in ComponentState) and HandleAllocated then
  begin
    UpdateScrollBar;
    if RowPanel.Active then
    begin
      CW := ClientWidth;
      if IndicatorColVisible then Dec(CW, ColWidths[0]);
      if (dgColLines in Options) then Dec(CW, 1);
      Columns.ScaleWidths(FGridMasterCellWidth + GridLineWidth, CW)
    end else
    begin

      for i := 0 to VisibleColumns.Count - 1
        do VisibleColumns[i].FNotInWidthRange := False;

      CountedWidth := 0;
      CW := 0;

      for j := 0 to VisibleColumns.Count - 1 do
      begin
        CW := 0;
        K := 0;

        for i := 0 to VisibleColumns.Count - 1 do
        begin
          if (VisibleColumns[i].AutoFitColWidth = False) or (VisibleColumns[i].FNotInWidthRange = True)
            then Inc(CW, VisibleColumns[i].Width)
            else Inc(K, VisibleColumns[i].FInitWidth);
        end;

        if (ClientWidth > FMinAutoFitWidth)
          then CW := ClientWidth - CW
          else CW := FMinAutoFitWidth - CW;
        if (CW < 0) then CW := 0;
        if IndicatorColVisible then Dec(CW, ColWidths[0]);
        if (dgColLines in Options) then Dec(CW, VisibleColumns.Count);
        if IndicatorColVisible and (dgColLines in Options) then Dec(CW, 1);
        Dec(CW, FExtraFirstColumnWidth);

        CountedWidth := 0;
        NotInWidthRange := False;

        for i := 0 to VisibleColumns.Count - 1 do
        begin
          if (VisibleColumns[i].AutoFitColWidth = True) and (VisibleColumns[i].FNotInWidthRange = False) then
          begin
            ColWidth := MulDiv(VisibleColumns[i].FInitWidth, CW, K);
            VisibleColumns[i].Width := ColWidth;
            if (ColWidth <> VisibleColumns[i].Width) then
            begin
              NotInWidthRange := True;
              VisibleColumns[i].FNotInWidthRange := True;
            end;
//           if (VisibleColumns[i].Width < 0) then VisibleColumns[i].Width := 0;
            Inc(CountedWidth, VisibleColumns[i].Width);
          end;
        end;

        if (NotInWidthRange = False) then Break;
      end;

      if (CountedWidth <> CW) then // Correct last AutoFitColWidth column
      begin
        for i := VisibleColumns.Count - 1 downto 0 do
          if (VisibleColumns[i].AutoFitColWidth = True) and (VisibleColumns[i].FNotInWidthRange = False) then
          begin
            VisibleColumns[i].Width := VisibleColumns[i].Width + CW - CountedWidth;
            if (VisibleColumns[i].Width < 0)
              then VisibleColumns[i].Width := 0;
            Break;
          end;
      end;
    end;
  end;
  //else //if (Parent <> nil) and Parent.HandleAllocated then
  //  HandleNeeded;

  // Title and MultyTitle
  if (dgTitles in Options) then
  begin
    RestoreCanvas := not HandleAllocated and not FCanvasHandleAllocated; //not Canvas.HandleAllocated;
    if RestoreCanvas then
    begin
      Canvas.Handle := GetDC(0);
      FCanvasHandleAllocated := True;
    end;
    try
      if (TitleHeight <> 0) or (TitleLines <> 0) then
      begin
        K := 0;
        for I := 0 to Columns.Count - 1 do
        begin
          Canvas.Font := Columns[I].Title.Font;
          J := Canvas.TextHeight('Wg') + FInterlinear;
          if J > K then
          begin
            K := J;
            GetTextMetrics(Canvas.Handle, tm);
          end;
        end;
        if K = 0 then
        begin
          Canvas.Font := TitleFont;
          GetTextMetrics(Canvas.Handle, tm);
        end;

        FTitleHeightFull := tm.tmExternalLeading + tm.tmHeight * FTitleLines + 2 +
          FTitleHeight;

        if dgRowLines in Options
          then FTitleHeightFull := FTitleHeightFull + 1;

        FTitleRowHeight := FTitleHeightFull;
      end;

      if (IsUseMultiTitle = True) {and HandleAllocated} then
      begin
        SetLength(FLeafFieldArr, Columns.Count);
        AFont := Canvas.Font;
        Canvas.Font := TitleFont;
        for i := 0 to Columns.Count - 1 do
          FLeafFieldArr[i].FColumn := Columns[i];
        FHeadTree.CreateFieldTree(Self);
        FTitleRowHeight := SetChildTreeHeight(FHeadTree) - iif(dghFixed3D in OptionsEh, 1, 3); // +2;
        Canvas.Font := AFont;
      end;

      if RowPanel.Active then
        FTitleRowHeight := FGridMasterCellHeight;
    finally
      if RestoreCanvas then
      begin
        ReleaseDC(0, Canvas.Handle);
        Canvas.Handle := 0;
        FCanvasHandleAllocated := False;
      end;
    end;
  end;

  SetColumnAttributes;
  if dgRowSelect in Options then
  begin
    OldLeftCol := LeftCol;
    try
      UpdateRowCount;
    finally
      LeftCol := OldLeftCol;
    end;
  end else
    UpdateRowCount;
  if RowDetailPanel.Active then
    UpdateRowDetailPanel;
  UpdateActive;
  Invalidate;
  if Selection.SelectionType = gstColumns
    then Selection.Columns.Refresh;

  UpdateFilterEdit(True);


{$IFDEF EH_LIB_7}
  if CanFillSelectionByTheme then
  begin
    GetThemeColor(ThemeServices.Theme[teHeader], HP_HEADERITEM, HIS_NORMAL,
      TMT_EDGEFILLCOLOR, LColorRef);
    GridLineColors.DarkColor := LColorRef;
  end else
{$ENDIF}
  if Flat then
    GridLineColors.DarkColor := clGray
  else if DrawTitleByThemes then
    GridLineColors.DarkColor := clBtnShadow
  else if ThemesEnabled then
    GridLineColors.DarkColor := cl3DDkShadow
  else
    GridLineColors.DarkColor := {cl3DDkShadow;//}clBlack;

  if (dghFooter3D in OptionsEh) or (FooterColor <> clWindow) then
    GridLineColors.VertAreaContraVertColor := GridLineColors.GetDarkColor
  else
    GridLineColors.VertAreaContraVertColor := GridLineColors.GetBrightColor;
  finally
    UnlockPaint;
  end;
end;

procedure TCustomDBGridEh.LayoutChanged;
begin
  if AcquireLayoutLock
    then EndLayout;
end;

procedure TCustomDBGridEh.LinkActive(Value: Boolean);
begin
  if not Value and RowDetailPanel.Visible then RowDetailPanel.Visible := False;
  CheckIMemTable;
  if not Value then HideEditor;
  //new FBookmarks.LinkActive(Value);
  Selection.LinkActive(Value);
  if (Assigned(DataSource))
    then SumList.DataSet := DataSource.DataSet
    else SumList.DataSet := nil;
  if ViewScroll then // Optimization
  begin
    if DataGrouping.IsGroupingWorks then
      DoSortMarkingChanged;
    MTViewDataEvent(-1, mtViewDataChangedEh, -1);
    UpdateRowCount;
  end;
  if csDestroying in ComponentState then
    Exit;
  LayoutChanged;
  if Value and CanEditorMode then
    ShowEditor;
  UpdateScrollBar;
  CheckIMemTable;
  Columns.ActiveChanged;
  KeyProperyModified;
end;

procedure TCustomDBGridEh.Loaded;
var i: Integer;
begin
  inherited Loaded;
  UpdateColumnResizeOptions(Options, OptionsEh);
  if FColumns.Count > 0 then
  begin
    ColCount := FColumns.Count;
    if (FAutoFitColWidths = True) and not (csDesigning in ComponentState) then
    begin
      Columns.BeginUpdate;
      for i := 0 to Columns.Count - 1 do
      begin
        Columns[i].FInitWidth := Columns[i].Width;
      end;
      Columns.EndUpdate;
      ScrollBars := ssNone;
    end;
    SetSortMarkedColumns;
//???    if SortMarkedColumns.Count > 0 then DoSortMarkingChanged;
  end;
  if Assigned(DataSource) then
//    FSumList.DataSet := DataSource.DataSet;
    FSumList.Loaded;
  LayoutChanged;
  DeferLayout;
  if (FNoDesigntControler = False) and
      Assigned(DBGridEhDesigntControler) and
      (csDesigning in ComponentState)
  then
  begin
    DBGridEhDesigntControler.KeyProperyModified(Self);
  end;
  if RowDetailPanel.Active and (csDesigning in ComponentState) then
  begin
    RowDetailPanel.Visible := True;
  end;
  DataGrouping.ResetGroupLevelNames;
end;

procedure TCustomDBGridEh.ChangeScale(M, D: Integer);
var
  Flags: TScalingFlags;
  i, j: Integer;
  WidthInc, WidthIncScaled, OldWidthIncScaled: Integer;
begin
  if M <> D then
  begin
    if csLoading in ComponentState
      then Flags := ScalingFlags
      else Flags := [sfFont];
    if not ParentFont and (sfFont in Flags) then
    begin
      TitleFont.Size := MulDiv(Font.Size, M, D);
      FooterFont.Size := MulDiv(FooterFont.Size, M, D);
    end;
    if sfFont in Flags then
    try
      WidthInc := 0;
      OldWidthIncScaled := 0;
      Columns.BeginUpdate;
      for i := 0 to Columns.Count - 1 do
        with Columns[i] do
        begin
          if cvFont in AssignedValues
            then Font.Size := MulDiv(Font.Size, M, D);
          if cvTitleFont in AssignedValues
            then Title.Font.Size := MulDiv(Title.Font.Size, M, D);
          if cvFooterFont in Footer.AssignedValues
            then Footer.Font.Size := MulDiv(Footer.Font.Size, M, D);
          for j := 0 to Footers.Count - 1 do
            if cvFooterFont in Footers[j].AssignedValues
              then Footers[j].Font.Size := MulDiv(Footers[j].Font.Size, M, D);
          Inc(WidthInc, Width);
          WidthIncScaled := MulDiv(WidthInc, M, D);
          Width := WidthIncScaled - OldWidthIncScaled;
          OldWidthIncScaled := WidthIncScaled;
        end;
    finally
      Columns.EndUpdate;
    end;
  end;
  inherited ChangeScale(M, D);
end;

function PointInRect(const P: TPoint; const R: TRect): Boolean;
begin
  with R do
    Result := (Left <= P.X) and (Top <= P.Y) and
      (Right >= P.X) and (Bottom >= P.Y);
end;

procedure TCustomDBGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  OldCol, OldRow, Xm, Ym: Integer;
  EnableClick: Boolean;
  ARect, ButtonRect: TRect;
  Flag: Boolean;
  MouseDownEvent: TMouseEvent;
//  AEditStyle: TEditStyle;
  APointInRect: Boolean;
  TargetWC: TWinControl;
  OldBM: TUniBookmarkEh;
  DrawInfo: TGridDrawInfoEh;
  EditButtonsWidth: Integer;
  AGridState: TGridState;
  ASizingIndex, ASizingPos, ASizingOfs: Integer;
  ADBGridEhState: TDBGridEhState;
  CellAreaType: TCellAreaTypeEh;
  AreaCol, AreaRow: Integer;
  StateRect: TRect;
  MouseDownInRowDetailSign: Boolean;
  Column: TColumnEh;
  ADrawGroupDataNode: TGroupDataTreeNodeEh;
  OutBRect: TRect;
//  DropdownMenu: TPopupMenu;
//  P: TPoint;
begin
  if Assigned(DBGridEhDesigntControler) and
    DBGridEhDesigntControler.IsDesignHitTest(Self, X, Y, Shift)
  then
    DBGridEhDesigntControler.DesignMouseDown(Self, X, Y, Shift);
  if Button = mbRight then MouseCapture := True;
  if csDesigning in ComponentState then
    FDSMouseCapture := True;
  FGroupDataMovingIndex := -1;  
  FStartShiftState := Shift;
  Xm := X; Ym := Y;
  FPressedCell.X := -1; FPressedCell.Y := -1;
  FPressedDataCol := -1;
  FDownMousePos := Point(X, Y);
  MouseDownInRowDetailSign := False;
  if not AcquireFocus then Exit;
  Cell := MouseCoord(X, Y);
  FPressedCell := Cell;
  if (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
    CellAreaType := GetCellAreaType(Cell.X, Cell.Y, AreaCol, AreaRow);
    if RowPanel.Active and
       (CellAreaType.HorzType = hctDataEh) and
       (CellAreaType.VertType in [vctTitleEh{, vctSubTitleEh, vctDataEh, vctFooterEh}]) then
    begin
      MouseDownInTitleRowPanel(Button, Shift, Xm, Ym);
      Exit;
    end else if DataGrouping.IsGroupingWorks and
       (DataGrouping.GroupDataTree.FlatVisibleCount > 0) and
       (CellAreaType.HorzType = hctDataEh) and
       (CellAreaType.VertType in [vctDataEh]) then
    begin
      InstantReadRecordEnter(AreaRow);
      ADrawGroupDataNode := FDrawGroupDataNode;
      InstantReadRecordLeave;
      if ADrawGroupDataNode.NodeType = dntDataGroupEh then
      begin
        MouseDownInGroupDataCell(Button, Shift, Xm, Ym, ADrawGroupDataNode);
        Exit;
      end;
    end
  end;
  if OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtTopEh) and PtInRect(OutBRect, FDownMousePos) then
    MouseDownInOutBoundary(Button, Shift, X, Y)
  else if OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtLeftEh) and PtInRect(OutBRect, FDownMousePos) then
    MouseDownInOutBoundary(Button, Shift, X, Y)
  else if OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtBottomEh) and PtInRect(OutBRect, FDownMousePos) then
    MouseDownInOutBoundary(Button, Shift, X, Y)
  else if OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtRightEh) and PtInRect(OutBRect, FDownMousePos) then
    MouseDownInOutBoundary(Button, Shift, X, Y);

  if PtInRect(DataRect, Point(X, Y)) and FilterEditMode then
    StopEditFilter;
  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    Cell := MouseCoord(X, Y);
    CalcDrawInfo(DrawInfo);
    CalcSizingState(X, Y, AGridState, ASizingIndex, ASizingPos, ASizingOfs, DrawInfo);
    if (AGridState <> gsColSizing) then
    begin
      CalcFrozenSizingState(X, Y, ADBGridEhState, ASizingIndex, ASizingPos, ASizingOfs);
      if ADBGridEhState = dgsColSizing then
        AGridState := gsColSizing;
    end;
    if (AGridState = gsColSizing) and (dghDblClickOptimizeColWidth in OptionsEh) then
      OptimizeSelectedColsWidth(Columns[ASizingIndex - IndicatorOffset])
    else if (Cell.X > IndicatorOffset - 1) and (Cell.Y > TopDataOffset - 1) and
      (Cell.Y < RowCount {iif(FooterRowCount > 0, RowCount - FooterRowCount - 1, MaxInt)}) and
      (Columns[Cell.X - IndicatorOffset].GetColumnType in [ctKeyImageList..ctCheckboxes]) then
    begin
      if Columns[Cell.X - IndicatorOffset].DblClickNextVal and (ssDouble in Shift)
        then
        if (ssShift in Shift)
          then Columns[Cell.X - IndicatorOffset].SetNextFieldValue(-1)
          else Columns[Cell.X - IndicatorOffset].SetNextFieldValue(1);
    end;

    if not ((AGridState = gsColSizing) and (dghDblClickOptimizeColWidth in OptionsEh)) then
      DblClick;

    MouseDownEvent := OnMouseDown;
    if Assigned(MouseDownEvent)
      then MouseDownEvent(Self, Button, Shift, X, Y);
    Exit;
  end
  else if (Button = mbLeft) then
  begin
    {CalcFrozenSizingState(X, Y, FDBGridEhState, FSizingIndex, FSizingPos, FSizingOfs);
    if FDBGridEhState <> dgsNormal then
    begin
      if not (dghTraceColSizing in OptionsEh) then
        DrawSizingLine(GridWidth, GridHeight);
      Exit;
    end;}
  end;
  if Sizing(X, Y) then
  begin
    FDatalink.UpdateData;

    if (dghTraceColSizing in OptionsEh) and (Button = mbLeft) then
    begin
      CalcDrawInfo(DrawInfo);
      { Check grid sizing }
      CalcSizingState(X, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs, DrawInfo);
      if FGridState = gsColSizing then
      begin
        if Self.UseRightToLeftAlignment then
          FSizingPos := ClientWidth - FSizingPos;
        //DrawSizingLine(GridWidth, GridHeight);
        Exit;
      end
      else
        inherited MouseDown(Button, Shift, X, Y);
    end else
      inherited MouseDown(Button, Shift, X, Y)
  end else
  begin
    Cell := MouseCoord(X, Y);
    ARect := CellRect(Cell.X, Cell.Y);

    if (IsUseMultiTitle = True) and (dgTitles in Options) then
    begin
      if (Cell.X > IndicatorOffset - 1) and
        (PtInRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom - FLeafFieldArr[Cell.X - IndicatorOffset].FLeaf.Height + 1),
        Point(X, Y)))
        then Flag := False
        else Flag := True;
    end
    else Flag := True;
    if GetCursor = hcrDownCurEh then //columns selection
    begin
      InvalidateCol(Cell.X);
      FDBGridEhState := dgsColSelecting;
      ResetTimer(60);
      //tmpSetTimer(Handle, 1, 60, nil);
      if ssShift in Shift
        then Selection.Columns.SelectShift(Columns[Cell.X - IndicatorOffset] {,False})
      else if ssCtrl in Shift
        then Selection.Columns.InvertSelect(Columns[Cell.X - IndicatorOffset])
      else
      begin
        Invalidate;
        Selection.Columns.Select(Columns[Cell.X - IndicatorOffset], False);
      end;
      Exit;
    end
    else
      if {(Datalink <> nil) and Datalink.Active and}
        (Cell.Y < TopDataOffset) and (Cell.X >= IndicatorOffset) and
        not (csDesigning in ComponentState) and Flag then
      begin
        Column := Columns[Cell.X - IndicatorOffset];
        if GetMouseHitCellState(Cell, FDownMousePos, ARect, Column, StateRect) = dgsTitleFilterButtonDown then
        begin
{          FDBGridEhState := dgsTitleFilterButtonDown;
          FPressedDataCol := Cell.X - IndicatorOffset;
          FPressedCol := Cell.X;
          FTracking := True;
          TrackButton(X, Y);}
          FTrackingStateRect := StateRect;
          if FInTitleFilterListboxVisible
            then InTitleFilterListboxCloseUp(False)
            else InTitleFilterListboxDropDown(Columns[Cell.X - IndicatorOffset]);
          InvalidateTitle;
          Exit;
        end else
        if (dghColumnMove in OptionsEh) and (Button = mbRight) then
        begin
          Button := mbLeft;
          FSwapButtons := True;
        //MouseCapture := True;
        end
        else if Button = mbLeft then
        begin
          EnableClick := Columns[Cell.X - IndicatorOffset].Title.TitleButton;
          CheckTitleButton(Cell.X - IndicatorOffset, EnableClick);
          if EnableClick then
          begin
          //MouseCapture := True;
            if not MouseCapture then Exit;
            FTracking := True;
            FPressedCol := Cell.X;
            FPressedDataCol := Cell.X - IndicatorOffset;
            TrackButton(X, Y);
            Exit;
          end;
        end;
      end;

    if {((csDesigning in ComponentState) or (dghColumnMove in OptionsEh)) and} (Cell.Y < TopDataOffset) then
    begin
      //d top-left cell
      if (Cell.X < FIndicatorOffset) and (Cell.Y  = 0)  then
      begin
        {if FBookmarks.Count > 0 then begin
          FBookmarks.Clear;
          FSelecting := False;
        end else
          FBookmarks.SelectAll;}

        ARect := CellRect(Cell.X, Cell.Y);
        Center.IndicatorTitleMouseDown(Self, Cell, Button, Shift, Xm - ARect.Left, Ym - ARect.Top);
//        if IndicatorTitle.UseGlobalMenu or (IndicatorTitle.DropdownMenu <> nil) then
        InvalidateEditor;
      end;
      FDataLink.UpdateData;
      Canvas.Pen.Color := clSilver; // Column move line fixup when no dgColLines
      inherited MouseDown(Button, Shift, X, Y)
    end
    else if Cell.Y < RowCount {iif(FooterRowCount > 0, RowCount - FooterRowCount - 1, MaxInt)} then
    begin
      if FDatalink.Active then
        with Cell do
        begin
          if CheckBeginRowMoving(Xm, Ym, False) then
            Exit;
          if CellTreeElementMouseDown(Xm, Ym, False) then
            Exit;
          BeginUpdate; { eliminates highlight flicker when selection moves }
          try
            if RowPanel.Active then
              MouseDownInDataRowPanel(Button, Shift, Xm, Ym)
            else
            begin
            FDatalink.UpdateData; // validate before moving
            HideEditor;
            OldCol := Col;
            OldRow := Row;
            OldBM := DataSource.DataSet.Bookmark;

            FLockAutoShowCurCell := True;
            if RowDetailPanel.Active and CheckMouseDownInRowDetailSign(Button, Shift, Xm, Ym) then
              MouseDownInRowDetailSign := True;
            if (Y >= TopDataOffset) and (Y - Row <> 0) then
              if not ((ssShift in Shift) and (dgMultiSelect in Options)
                and ((dgRowSelect in Options) or (X < FIndicatorOffset)))
              then
                MoveBy(Y - Row);
            FLockAutoShowCurCell := False;
            if MouseDownInRowDetailSign then
            begin
              RowDetailPanel.Visible := not RowDetailPanel.Visible;
              Exit;
            end;
            if X >= FIndicatorOffset then
              MoveCol(RawToDataColumn(X), 0, False);
            if not MouseCapture then Exit;
            if FAutoDrag and not (ssShift in Shift) and (Button = mbLeft) and (X >= FIndicatorOffset) and
              Selection.DataCellSelected(Cell.X - IndicatorOffset, DataSource.DataSet.Bookmark) then
            begin
              FSelectedCellPressed := True;
              Exit;
            end;
            if PtInRect(DataRect, Point(Xm, Ym)) and
              (not (dgMultiSelect in Options) or
              ((dgMultiSelect in Options) and not (dgRowSelect in Options))) then
            begin
//              MouseCapture := True;
              if not MouseCapture then Exit;
              FTracking := True;
              FDataTracking := True;
              if not (ssCtrl in Shift) and not (ssShift in Shift) and (dghClearSelection in OptionsEh) and
                ((Button = mbLeft) or (not Selection.DataCellSelected(Cell.X - IndicatorOffset, DataSource.DataSet.Bookmark))) then {FBookmarks.Clear}
                CheckClearSelection;
              if (X >= FIndicatorOffset) and CanSelectType(gstRectangle) {(dgMultiSelect in Options)} and
                (Button = mbLeft) and not (DataSource.DataSet.Eof and DataSource.DataSet.Bof) then
              begin
                if ssShift in Shift then
                  if Selection.SelectionType = gstRectangle then
                    Selection.Rect.Select(Cell.X - IndicatorOffset, DataSource.DataSet.Bookmark, True)
                  else
                  begin
                    Selection.Rect.Select(OldCol - IndicatorOffset, OldBM, False);
                    Selection.Rect.Select(Cell.X - IndicatorOffset, DataSource.DataSet.Bookmark, True);
                  end
                else
                  Selection.Rect.Select(Cell.X - IndicatorOffset, DataSource.DataSet.Bookmark, False);
                FDBGridEhState := dgsRectSelecting;
              end;
            end;
            if CanSelectType(gstRecordBookmarks)
              and ((dgRowSelect in Options) or (X < FIndicatorOffset) or not CanSelectType(gstRectangle)) then
              with FBookmarks do
              begin
                FSelecting := False;
                if {(ssAlt in Shift) and}(ssShift in Shift) and (Y - Row <> 0) then
                begin
                  FSelecting := True;
                  FAntiSelection := True;
{                  if FSelectionAnchorState = sasNonEh then
                  begin
                    FSelectionAnchorState := sasAltMouseEh;
                    FSelectionAnchor := FBookmarks.CurrentRow;
                    FSelectionAnchorSelected := not CurrentRowSelected;
                  end;
}
                  DoSelection(True, Y - Row, False, True);
                end
                else if ((ssCtrl in Shift) or not (dghClearSelection in OptionsEh)) and (Button = mbLeft)
                  then CurrentRowSelected := not CurrentRowSelected
                else
                begin
                  if (Button = mbLeft) { and (FSelectionAnchorState = sasNonEh)} then
                  begin
                    if dghClearSelection in OptionsEh then CheckClearSelection; //newClear;
                    CurrentRowSelected := True;
                  end;
                end;
                if (dgRowSelect in Options) or not CanSelectType(gstRectangle) or
                  ((X < FIndicatorOffset) and not (dgRowSelect in Options)) then
                begin
                  FIndicatorPressed := True;
//                  MouseCapture := True;
                  if not MouseCapture then Exit;
                  FTracking := True;
                  FSelecting := True;
                  FSelectionAnchorSelected := not CurrentRowSelected;
                  FSelectionAnchor := FBookmarks.CurrentRow;
{                  FCurrentRecordBookmark := FBookmarks.CurrentRow;
                  if FSelectionAnchorState = sasNonEh then
                  begin
                    FSelectionAnchorState := sasOnlyMouseEh;
                    FSelectionAnchor := FBookmarks.CurrentRow;
                    FSelectionAnchorSelected := not CurrentRowSelected;
                  end;}
                  FAntiSelection := (ssCtrl in Shift) or not (dghClearSelection in OptionsEh);
                  FDBGridEhState := dgsRowSelecting;
                end;
              end;

            if (Button = mbLeft) and CanEditorMode and
              (((X = OldCol) and (Y = OldRow)) or (dgAlwaysShowEditor in Options)) then
              ShowEditor; { put grid in edit mode }

            if (Button = mbLeft) and (Cell.X > IndicatorOffset - 1) then
            begin

              EditButtonsWidth := Columns[Cell.X - IndicatorOffset].EditButtonsWidth;
              if Columns[Cell.X - IndicatorOffset].UseRightToLeftAlignment
                then ButtonRect := Rect(ARect.Left, ARect.Top, ARect.Left + EditButtonsWidth, ARect.Bottom)
                else ButtonRect := Rect(ARect.Right - EditButtonsWidth, ARect.Top, ARect.Right, ARect.Bottom);
              APointInRect := PointInRect(Point(Xm, Ym), ButtonRect);
              if (dgAlwaysShowEditor in Options) or ((EditButtonsWidth > 0) and APointInRect) or
                ((X = OldCol) and (Y = OldRow))
                then ShowEditor;

              if (InplaceEditor <> nil) and InplaceEditor.Visible and
                APointInRect and (Y >= TopDataOffset) and (X >= FIndicatorOffset) then
              begin
                if (Cell.X > IndicatorOffset - 1) and (EditButtonsWidth > 0) {(GetColumnEditStile(Columns[Cell.X - IndicatorOffset]) <> esSimple)} then
                begin
                  StopTracking;
                  TargetWC := FindVCLWindow(ClientToScreen(Point(Xm, Ym)));
                  if (TargetWC <> nil) and (TargetWC <> Self) then
                    TargetWC.Perform(WM_LBUTTONDOWN, MK_LBUTTON,
                      SmallPointToInteger(PointToSmallPoint(TargetWC.ScreenToClient(ClientToScreen(Point(Xm, Ym))))));
                end;
              end;


              if (Cell.X > IndicatorOffset - 1) and
                (Columns[Cell.X - IndicatorOffset].GetColumnType in [ctKeyImageList..ctCheckboxes])
                then FPressedCell := Cell;

{                if ((dgAlwaysShowEditor in Options) and (InplaceEditor <> nil) and (InplaceEditor.Visible)) then
                   InplaceEditor.Perform(WM_LBUTTONDOWN,MK_LBUTTON,
                     Longint(PointToSmallPoint(InplaceEditor.ScreenToClient(ClientToScreen(Point(Xm,Ym))))));}
            end else
              InvalidateEditor; { draw editor, if needed }
            end;
          finally
            EndUpdate;
          end;
        end;
      MouseDownEvent := OnMouseDown;
      if Assigned(MouseDownEvent) then MouseDownEvent(Self, Button, Shift, X, Y);
    end else
    begin
      MouseDownEvent := OnMouseDown;
      if Assigned(MouseDownEvent) then
        MouseDownEvent(Self, Button, Shift, X, Y);
    end;
  end;
end;

procedure TCustomDBGridEh.MouseDownInDataRowPanel(Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  ARect: TRect;
  i, OldRigth: Integer;
  Column: TColumnEh;
  ACellRect: TRect;
begin
  Cell := MouseCoord(X, Y);
  if (Cell.X < 0) or (Cell.Y < 0) then Exit;
  ARect := CellRect(Cell.X, Cell.Y);

  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    ACellRect := Rect(Column.FRowPlacement.DataCellLeft, Column.FRowPlacement.Top,
      Column.FRowPlacement.DataCellLeft + Column.FRowPlacement.Width,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    if Self.UseRightToLeftAlignment then
    begin
      OldRigth := ACellRect.Right;
      ACellRect.Right := ARect.Right - ACellRect.Left;
      ACellRect.Left := ARect.Right - OldRigth;
      OffsetRect(ACellRect, FDataOffset.cx, 0);
      OffsetRect(ACellRect, 0, ARect.Top);
    end else
    begin
      OffsetRect(ACellRect, -FDataOffset.cx, 0);
      OffsetRect(ACellRect, ARect.Left, ARect.Top);
    end;

    if PointInRect(Point(X, Y), ACellRect) then
    begin
      MouseDownInDataCell(Button, Shift, X, Y, Cell, Column,
        ACellRect, X-ACellRect.Left, Y-ACellRect.Top);
      Exit;
    end;
  end;
end;

procedure TCustomDBGridEh.MouseDownInDataCell(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer; Cell: TGridCoord; Column: TColumnEh;
  ACellRect: TRect; InCellX, InCellY: Integer);
var
  OldCol, OldRow: Integer;
  ColIndex: Integer;
  EditButtonsWidth: Integer;
  ButtonRect: TRect;
  APointInRect: Boolean;
  TargetWC: TWinControl;
begin
  FDatalink.UpdateData; // validate before moving
  HideEditor;
  ColIndex := Column.Index;
  FPressedDataCol := ColIndex;
  OldCol := SelectedIndex;
  OldRow := Row;
  if (Cell.Y >= FTitleOffset) and (Cell.Y - Row <> 0) then
  begin
    FLockAutoShowCurCell := True;
    try
      MoveBy(Cell.Y - Row);
    finally
      FLockAutoShowCurCell := False;
    end;
  end;
  if ColIndex >= 0 then
    MoveCol(ColIndex, 0, False);
  ColIndex := SelectedIndex;
  if (Button = mbLeft) and
     (dgMultiSelect in Options) and
     (dgRowSelect in Options) and
     FDatalink.Active then
    with FBookmarks do
    begin
      FSelecting := False;
      if ssCtrl in Shift then
        CurrentRowSelected := not CurrentRowSelected
      else
      begin
        Clear;
        CurrentRowSelected := True;
      end;
    end;

  if (Button = mbLeft) and
      CheckDataCellMouseDownInRowDetailSign(Button, Shift, X, Y,
      Cell, Column, ACellRect, InCellX, InCellY) then
  begin
    RowDetailPanel.Visible := not RowDetailPanel.Visible;
    Exit;
  end;

  if (Button = mbLeft) and
    (((ColIndex = OldCol) and (Cell.Y = OldRow)) or (dgAlwaysShowEditor in Options)) then
    ShowEditor         { put grid in edit mode }
  else
    InvalidateEditor;  { draw editor, if needed }

  if Button = mbLeft then
  begin

    EditButtonsWidth := Column.EditButtonsWidth;
    if Column.UseRightToLeftAlignment
      then ButtonRect := Rect(ACellRect.Left, ACellRect.Top,
                              ACellRect.Left + EditButtonsWidth, ACellRect.Bottom)
      else ButtonRect := Rect(ACellRect.Right - EditButtonsWidth,
                              ACellRect.Top, ACellRect.Right, ACellRect.Bottom);
    APointInRect := PointInRect(Point(X, Y), ButtonRect);
    if (dgAlwaysShowEditor in Options) or ((EditButtonsWidth > 0) and APointInRect) or
      ((ColIndex = OldCol) and (Cell.Y = OldRow))
      then ShowEditor;

    if (InplaceEditor <> nil) and InplaceEditor.Visible and APointInRect then
    begin
      if EditButtonsWidth > 0 then
      begin
        StopTracking;
        TargetWC := FindVCLWindow(ClientToScreen(Point(X, Y)));
        if (TargetWC <> nil) and (TargetWC <> Self) then
          TargetWC.Perform(WM_LBUTTONDOWN, MK_LBUTTON,
            SmallPointToInteger(PointToSmallPoint(TargetWC.ScreenToClient(ClientToScreen(Point(X, Y))))));
      end;
    end;


    if (Cell.X > IndicatorOffset - 1) and
      (Columns[Cell.X - IndicatorOffset].GetColumnType in [ctKeyImageList..ctCheckboxes])
      then FPressedCell := Cell;
  end;
end;

procedure TCustomDBGridEh.ExpandCellWidthForEmptySpace(ColumnIndex: Integer);
var
  i, k: Integer;
  Column: TColumnEh;
//  ACellRect: TRect;
  ATargetRight: Integer;
  MaxLeft: Integer;
  TargetColumn: TColumnEh;
begin
  TargetColumn := Columns[ColumnIndex];
  ATargetRight := TargetColumn.FRowPlacement.Left + TargetColumn.FRowPlacement.Width;
  if dgColLines in Options then Inc(ATargetRight, GridLineWidth);
  MaxLeft := FGridMasterCellWidth;

  for k := TargetColumn.InRowLinePos
    to TargetColumn.InRowLinePos + TargetColumn.InRowLineHeight - 1 do
  begin
    for i := 0 to Columns.Count-1 do
    begin
      Column := Columns[i];
      if (Column.InRowLinePos <= k) and
         (Column.InRowLinePos + Column.InRowLineHeight - 1 >= k) and
         (Column.FRowPlacement.Left >= ATargetRight) and
         (Column.FRowPlacement.Left < MaxLeft)
      then
        MaxLeft := Column.FRowPlacement.Left;
    end;
  end;
  if MaxLeft > ATargetRight then
  begin
    if MaxLeft = FGridMasterCellWidth
      then TargetColumn.Width := TargetColumn.Width + (MaxLeft - ATargetRight) + 1
      else TargetColumn.Width := TargetColumn.Width + (MaxLeft - ATargetRight)
  end;
end;

procedure TCustomDBGridEh.MouseDownInTitleRowPanel(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  ARect: TRect;
//  i: Integer;
  Column: TColumnEh;
  ACellRect: TRect;
  AState: TGridState;
  AIndex: Longint;
  ASizingPos, ASizingOfs: Integer;
  ADrawInfo: TGridDrawInfoEh;
  InCellPos: TPoint;
begin
  if Sizing(X,Y) then
  begin
    if ssDouble in Shift then
    begin
      CalcDrawInfo(ADrawInfo);
      CalcSizingStateForRowPanel(X, Y, AState, AIndex, ASizingPos, ASizingOfs, ADrawInfo);
      if AState = gsColSizing then
        ExpandCellWidthForEmptySpace(AIndex);
    end else
      inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;
  Cell := MouseCoord(X, Y);
  ARect := CellRect(Cell.X, Cell.Y);
  if (Cell.Y < TopDataOffset) and (Cell.X >= IndicatorOffset) then
  begin
    if (dghColumnMove in OptionsEh) and (Button = mbRight) then
    begin
//      Button := mbLeft;
      FSwapButtons := True;
    end
    else if Button = mbLeft then
    begin
      InCellPos := Point(X - ARect.Left + FDataOffset.cx, Y - ARect.Top);
      if UseRightToLeftAlignment then
        InCellPos.X := FGridMasterCellWidth - (ARect.Right - X) - FDataOffset.cx;
      Column := GetColumnInRowPanelAtPos(InCellPos, True);
      if Column <> nil then
        MouseDownInTitleCell(Button, Shift, X, Y, Cell, Column,
            ACellRect, X-ACellRect.Left, Y-ACellRect.Top);
    end;
  end;
end;

procedure TCustomDBGridEh.MouseDownInTitleCell(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Cell: TGridCoord;
  Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer);
var
  EnableClick: Boolean;
  StateRect: TRect;
  MasterCellRect: TRect;
begin
  FPressedDataCol := Column.Index;
  EnableClick := Column.Title.TitleButton;
  MasterCellRect := CellRect(Cell.X, Cell.Y);
  if (GetMouseHitCellState(Cell, FDownMousePos, MasterCellRect, Column, StateRect) = dgsTitleFilterButtonDown)
    and not (csDesigning in ComponentState) then
  begin
    FTrackingStateRect := StateRect;
    if FInTitleFilterListboxVisible
      then InTitleFilterListboxCloseUp(False)
      else InTitleFilterListboxDropDown(Column);
     InvalidateTitle;
  end else
  begin
    CheckTitleButton(Cell.X - IndicatorOffset, EnableClick);
  if EnableClick and not (csDesigning in ComponentState) then
  begin
      if not MouseCapture then Exit;
      FTracking := True;
      FPressedCol := Cell.X;
      TrackButton(X, Y);
      Exit;
    end;
  end;
end;

function TCustomDBGridEh.CalcRectForGroupCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint): TRect;
var
  i: Integer;
  ARect1: TRect;
begin
  ARect1 := CellRect(ACol, ARow);
  for i := ACol - 1 downto FixedCols do
  begin
    Dec(ARect1.Left, ColWidths[i] + GridLineWidth);
  end;

  Dec(ARect1.Right, FDataOffset.cx);
  Dec(ARect1.Left, FDataOffset.cx);
  for i := ACol to LeftCol + VisibleColCount do
  begin
    Inc(ARect1.Right, ColWidths[i] + GridLineWidth);
  end;

  Result := ARect1;
end;

procedure TCustomDBGridEh.MouseDownInGroupDataCell(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; ADrawGroupDataNode: TGroupDataTreeNodeEh);
var
  CellAreaType: TCellAreaTypeEh;
  AreaCol, AreaRow: Integer;
  Cell: TGridCoord;
  GroupRect: TRect;
begin
  Cell := MouseCoord(X, Y);
  CellAreaType := GetCellAreaType(Cell.X, Cell.Y, AreaCol, AreaRow);
  GroupRect := CalcRectForGroupCell(Cell.X, Cell.Y, AreaCol, AreaRow);
  if ADrawGroupDataNode.Level > 1 then
    GroupRect.Left := GroupRect.Left + (ADrawGroupDataNode.Level-1)*18;
  if (GroupRect.Left <= X) and (GroupRect.Left + 18 >= X) then
  begin
    if ssCtrl in Shift then
      if ADrawGroupDataNode.Expanded
        then ADrawGroupDataNode.DataGroup.CollapseNodes
        else ADrawGroupDataNode.DataGroup.ExtractNodes
      else ADrawGroupDataNode.Expanded := not ADrawGroupDataNode.Expanded;
    CheckSetCurGroupDataNode(FCurGroupDataNode, False);
  end else if X > GroupRect.Left + 18 then
    MoveBy(Cell.Y - Row);
end;

procedure TCustomDBGridEh.StartRowPanelTitleCellDragBox(Shift: TShiftState;
  X, Y, ColumnIndex: Integer; TitleRect: TRect);
var
  ACellRect: TRect;
  DragBoxTopLeft: TPoint;
  OldRigth: Integer;
  ADownMousePos, AMoveMousePos: TPoint;
//  FormDragCellRect: TRect;
begin
  ACellRect := CellRect(IndicatorOffset, 0);
  ADownMousePos := FDownMousePos;
  AMoveMousePos := FMoveMousePos;
  if Self.UseRightToLeftAlignment then
  begin
    OldRigth := ACellRect.Right;
    ACellRect.Right := ClientWidth - ACellRect.Left;
    ACellRect.Left := ClientWidth - OldRigth;
    ADownMousePos.X := ClientWidth - ADownMousePos.X;
    AMoveMousePos.X := ClientWidth - AMoveMousePos.X;
  end;
  if FTracking and (FPressedCol <> -1) then
  begin
    StopTracking;
    Update;
    MouseCapture := True;
    FPressedDataCol := ColumnIndex;
//    FMoveIndex := DataToRawColumn(FPressedDataCol);
  end;
  FGridState := gsColMoving;
  FToMoveColumnIndex := ColumnIndex;
  FToMoveInRowLinePos := Columns[ColumnIndex].InRowLinePos;
  FTopLeftCellOffset :=
    Point(TitleRect.Left - ADownMousePos.X + ACellRect.Left - FDataOffset.cx,
          TitleRect.Top - ADownMousePos.Y + ACellRect.Top);
  DrawMoveLineOrTitleCell(True);

  FDragCellRect.Left := AMoveMousePos.X + FTopLeftCellOffset.X;
  FDragCellRect.Top := AMoveMousePos.Y + FTopLeftCellOffset.Y;
  FDragCellRect.Right := FDragCellRect.Left + TitleRect.Right - TitleRect.Left;
  FDragCellRect.Bottom := FDragCellRect.Top + TitleRect.Bottom - TitleRect.Top;

  DragBoxTopLeft := FDragCellRect.TopLeft;
  if Self.UseRightToLeftAlignment then
    DragBoxTopLeft.X := ClientWidth - DragBoxTopLeft.X - TitleRect.Right - TitleRect.Left;

  GetDragBoxEh.StartShow(Self, DragBoxTopLeft,
    TitleRect.Right - TitleRect.Left,
    TitleRect.Bottom - TitleRect.Top);
end;

procedure TCustomDBGridEh.StartRowPanelTitleCellDrag(Shift: TShiftState;
  X, Y, ColumnIndex: Integer);
var
  TitleRect: TRect;
begin
  TitleRect.Left := Columns[ColumnIndex].FRowPlacement.Left;
  TitleRect.Top := Columns[ColumnIndex].FRowPlacement.Top;
  TitleRect.Right := TitleRect.Left + Columns[ColumnIndex].FRowPlacement.Width;
  TitleRect.Bottom := TitleRect.Top + Columns[ColumnIndex].FRowPlacement.Height;
  StartRowPanelTitleCellDragBox(Shift, X, Y, ColumnIndex, TitleRect);
end;

procedure TCustomDBGridEh.GoRowPanelTitleCellDrag(Shift: TShiftState; X, Y: Integer);
var
  NewToMoveColumnIndex: Integer;
  NewToMoveInRowLinePos: Integer;
//  Cell: TGridCoord;
  ARect: TRect;
  i: Integer;
  Column: TColumnEh;
  ACellRect: TRect;
  MinRight: Integer;
  NewDragCellRect: TRect;
  OldColDataOffset: Integer;
  DragBoxTopLeft: TPoint;
  OldRigth: Integer;
  ADownMousePos, AMoveMousePos: TPoint;
  OutBRect: TRect;
  YTop: Integer;

  procedure DragAndMove;
  var
    P: TPoint;
  begin
    FDragCellRect := NewDragCellRect;
    OldColDataOffset := FDataOffset.cx;
    if AMoveMousePos.X > ADownMousePos.X
      then SafeSmoothScrollData(GetHorzScrollStep div 2, 0)
      else SafeSmoothScrollData(- GetHorzScrollStep div 2, 0);
    if OldColDataOffset <> FDataOffset.cx then
    begin
      Update;
      NewDragCellRect.Left := AMoveMousePos.X + FTopLeftCellOffset.X;
      P := Point(NewDragCellRect.Left, 0);
      ClientToScreen(P);
      NewDragCellRect.Left := P.X;
      NewDragCellRect.Right := NewDragCellRect.Left +
                               Columns[FPressedDataCol].FRowPlacement.Width;
      ResetTimer(60);
      DrawMoveLineOrTitleCell(True);
    end;
    DragBoxTopLeft := Point(FDragCellRect.Left, FDragCellRect.Top);
    if Self.UseRightToLeftAlignment then
      DragBoxTopLeft.X := ClientWidth - DragBoxTopLeft.X -
                          Columns[FPressedDataCol].FRowPlacement.Width;
    GetDragBoxEh.MoveToFor(Self, DragBoxTopLeft);
  end;
begin

  YTop := Y + FTopLeftCellOffset.Y;
  if YTop < 0 then
    YTop := 0;
  ARect := CellRect(IndicatorOffset, 0);
  ADownMousePos := FDownMousePos;
  AMoveMousePos := FMoveMousePos;

  if Self.UseRightToLeftAlignment then
  begin
    OldRigth := ARect.Right;
    ARect.Right := ClientWidth - ARect.Left;
    ARect.Left := ClientWidth - OldRigth;
    ADownMousePos.X := ClientWidth - ADownMousePos.X;
    AMoveMousePos.X := ClientWidth - AMoveMousePos.X;
    X := ClientWidth - X;
  end;

  if OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtTopEh) then
  begin
    if PtInRect(OutBRect, Point(X,Y)) then
    begin
      StartGroupPanelTitleMovingMode(Shift, X, Y);
      Exit;
    end;
  end;

  NewToMoveColumnIndex := -1;
  NewToMoveInRowLinePos := (YTop - ARect.Top) div InRowPanelLineHeight;
  if NewToMoveInRowLinePos > FGridMasterCellHeight div InRowPanelLineHeight then
    NewToMoveInRowLinePos := FGridMasterCellHeight  div InRowPanelLineHeight;
  MinRight := 0;
  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    ACellRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
      Column.FRowPlacement.Left + Column.FRowPlacement.Width,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    OffsetRect(ACellRect, ARect.Left, ARect.Top);
    OffsetRect(ACellRect, -FDataOffset.cx, 0);

    if (YTop >= ACellRect.Top) and (YTop <= ACellRect.Bottom) and
       (ACellRect.Right < X) and (ACellRect.Right > MinRight) then
    begin
      MinRight := ACellRect.Right;
      NewToMoveColumnIndex := i;
      NewToMoveInRowLinePos := (YTop - ARect.Top) div InRowPanelLineHeight;
      if NewToMoveInRowLinePos > FGridMasterCellHeight div InRowPanelLineHeight then
        NewToMoveInRowLinePos := FGridMasterCellHeight div InRowPanelLineHeight;
    end;
  end;

  NewDragCellRect.Left := AMoveMousePos.X + FTopLeftCellOffset.X;
  NewDragCellRect.Top := AMoveMousePos.Y + FTopLeftCellOffset.Y;
  NewDragCellRect.Right := NewDragCellRect.Left + Columns[FPressedDataCol].FRowPlacement.Width;
  NewDragCellRect.Bottom := NewDragCellRect.Top + Columns[FPressedDataCol].FRowPlacement.Height;

  if (FDragCellRect.Left <> NewDragCellRect.Left) or
     (FDragCellRect.Top <> NewDragCellRect.Top) then
  begin
    if (NewDragCellRect.Left < 0) and (AMoveMousePos.X < ADownMousePos.X) then
    begin
      DragAndMove;
    end else if (NewDragCellRect.Right > ClientWidth) and
      (AMoveMousePos.X > ADownMousePos.X)  then
    begin
      DragAndMove;
    end else
    begin
      StopTimer;
      FDragCellRect := NewDragCellRect;

      DragBoxTopLeft := Point(FDragCellRect.Left, FDragCellRect.Top);
      if Self.UseRightToLeftAlignment then
        DragBoxTopLeft.X := ClientWidth - DragBoxTopLeft.X -
                            Columns[FPressedDataCol].FRowPlacement.Width;
      GetDragBoxEh.MoveToFor(Self, DragBoxTopLeft);
    end;
  end else if TimerActive then
  begin
    DragAndMove;
  end;

  if ((NewToMoveColumnIndex <> FToMoveColumnIndex) or (NewToMoveInRowLinePos <> FToMoveInRowLinePos))
    and (NewToMoveColumnIndex <> FPressedDataCol) then
  begin
    DrawMoveLineOrTitleCell(True);
    FToMoveColumnIndex := NewToMoveColumnIndex;
    FToMoveInRowLinePos := NewToMoveInRowLinePos;

    DrawMoveLineOrTitleCell(True);
  end;
end;

procedure TCustomDBGridEh.StopRowPanelTitleCellDrag(Shift: TShiftState; X, Y: Integer; IsAccept: Boolean);
var
  Column: TColumnEh;

  function GeLastIndexFor(AIndex: Integer): Integer;
  var
    i: Integer;
    LastRight: Integer;
  begin
    Result := AIndex;
    if Result < 0 then Exit;
    LastRight := Columns[AIndex].FRowPlacement.Left + Columns[AIndex].FRowPlacement.Width;
    for i := 0 to Columns.Count-1 do
    begin
      if (i <> AIndex) and
         (Columns[i].FRowPlacement.Left + Columns[i].FRowPlacement.Width <= LastRight) and
         (i > Result)
      then
        Result := i;
    end;
  end;
begin
//  DrawMoveLineOrTitleCell(True);
//  DrawMoveLineOrTitleCell(False);
  GetMoveLineEh.Hide;
  GetDragBoxEh.Hide;
  FGridState := gsNormal;
  if IsAccept and (FToMoveColumnIndex <> FPressedDataCol) then
  begin
    Columns.BeginUpdate;
    try
      Column := Columns[FPressedDataCol];
      Column.InRowLinePos := FToMoveInRowLinePos;
      FToMoveColumnIndex := GeLastIndexFor(FToMoveColumnIndex);
      if (FToMoveColumnIndex <= FPressedDataCol) and (FToMoveColumnIndex < Columns.Count-1)
        then Column.Index := FToMoveColumnIndex + 1
        else Column.Index := FToMoveColumnIndex;
      if FGroupDataMovingIndex >= 0 then
      begin
        Column.Visible := True;
        DataGrouping.ActiveGroupLevels[FGroupDataMovingIndex].Destroy;
      end;
    finally
      Columns.EndUpdate;
    end;
  end;
end;

procedure TCustomDBGridEh.DrawMoveLineOrTitleCell(IsDrawLine: Boolean);
var
  OldPen: TPen;
  Pos: Integer;
  ACellRect: TRect;
  StartPos, FinishPos: Integer;
  OneLineHeight: Integer;
  DragBoxTopLeft: TPoint;
  OldRigth: Integer;
begin
  ACellRect := CellRect(IndicatorOffset, 0);
  if Self.UseRightToLeftAlignment then
  begin
    OldRigth := ACellRect.Right;
    ACellRect.Right := ClientWidth - ACellRect.Left;
    ACellRect.Left := ClientWidth - OldRigth;
  end;

  OneLineHeight := InRowPanelLineHeight;
  if dgColLines in Options then Inc(OneLineHeight, GridLineWidth);
  StartPos := OneLineHeight * FToMoveInRowLinePos;
  FinishPos := StartPos + Columns[FPressedDataCol].FRowPlacement.Height;

  if FToMoveColumnIndex = -1 then
    Pos := ACellRect.Left-1
  else
  begin
    Pos := Columns[FToMoveColumnIndex].FRowPlacement.Left +
           Columns[FToMoveColumnIndex].FRowPlacement.Width;
    Inc(Pos, ACellRect.Left);
    Inc(Pos, -FDataOffset.cx);
  end;

  Inc(StartPos, ACellRect.Top);
  Inc(FinishPos, ACellRect.Top);

  OldPen := TPen.Create;
  try
    with Canvas do
    begin
      OldPen.Assign(Pen);
      try
        Pen.Style := psDot;
        Pen.Mode := pmXor;
        Pen.Color := clGray;
        Brush.Color := clGray;
        if IsDrawLine then
        begin
{          if Flat
            then Pen.Width := 3
            else Pen.Width := 5;}
//          Pen.Color := clWhite;
          // gsColMoving
          begin
//            R := CellRect(FMovePos, 0);
//            MoveTo(Pos, StartPos);
//            LineTo(Pos, FinishPos);
//             Pos := Pos - Pen.Width div 2;
            DragBoxTopLeft := Point(Pos, StartPos);
            if Self.UseRightToLeftAlignment then
              DragBoxTopLeft.X := ClientWidth - DragBoxTopLeft.X;
            if GetMoveLineEh.Visible then
              GetMoveLineEh.MoveToFor(Self, DragBoxTopLeft)
            else
              GetMoveLineEh.StartShow(Self, DragBoxTopLeft, True, FinishPos-StartPos);
          end;
        end else
        begin
          Pen.Width := 1;
          Pen.Style := psSolid;
//          for i := FDragCellRect.Left to FDragCellRect.Right do
          begin
//            FillRect(FDragCellRect);
            Rectangle(FDragCellRect);
//            MoveTo(i, FDragCellRect.Top);
//            LineTo(i, FDragCellRect.Bottom);
          end;
        end;
      finally
        Canvas.Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomDBGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
  X1, Y1: Integer;
  WithSeleting: Boolean;
  OldMoveMousePos: TPoint;
  AddSel: Boolean;
  DrawInfo: TGridDrawInfoEh;
  NewSize: Integer;
  CellHit: TGridCoord;
  OutBRect: TRect;

  function ResizeLine(const AxisInfo: TGridAxisDrawInfoEh): Integer;
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      if FSizingIndex >= GridCellCount then
      begin
        Result := ContraExtent - EffectiveLineWidth;
        for I := GridCellCount to FSizingIndex do
          Inc(Result, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        Result := Result - FSizingPos;
      end else
      begin
        if FSizingIndex < FixedCols then
        begin
          Result := 0;
          for I := 0 to FSizingIndex - 1 do
            Inc(Result, GetExtent(I) + EffectiveLineWidth);
          Result := FSizingPos - Result;
        end else
        begin
          Result := FixedBoundary - DataOffset;
          for I := FirstGridCell to FSizingIndex - 1 do
            Inc(Result, GetExtent(I) + EffectiveLineWidth);
          Result := FSizingPos - Result;
        end;
      end;
    end;
  end;

  function CanStartRowPanelTitleCellDrag: Boolean;
  begin
    if csDesigning in ComponentState then
    begin
      Result :=
        RowPanel.Active and FDSMouseCapture and (FPressedDataCol >= 0) and (FPressedCell.Y = 0)
        and (GetTitleRows > 0) and (FGridState = gsNormal) and (FDBGridEhState = dgsNormal)
        and ((Abs(FDownMousePos.Y - Y) > 3) or (Abs(FDownMousePos.X - X) > 3));
//      if FDSMouseCapture and (FPressedDataCol >= 0) then
//        ShowMessage('MosueMove'+BoolToStr(Result));
    end else
      Result :=
        RowPanel.Active and MouseCapture and (FPressedDataCol >= 0) and (FPressedCell.Y = 0)
        and (GetTitleRows > 0) and (dghColumnMove in OptionsEh) and (FGridState = gsNormal)
        and (FDBGridEhState = dgsNormal)
        and ((Abs(FDownMousePos.Y - Y) > 3) or (Abs(FDownMousePos.X - X) > 3));
  end;

  function CanTraceColSizing: Boolean;
  begin
    Result := (dghTraceColSizing in OptionsEh) and not RowPanel.Active;
  end;

begin
  X1 := X; Y1 := Y;
  OldMoveMousePos := FMoveMousePos;
  FMoveMousePos := Point(X, Y);
  Cell := MouseCoord(X1, Y1);
  if FSelectedCellPressed = True then
  begin
    FSelectedCellPressed := False;
    BeginDrag(Mouse.DragImmediate, Mouse.DragThreshold);
    BeginDrag(True);
    Exit;
  end;
  if CanStartRowPanelTitleCellDrag then
  begin
    StartRowPanelTitleCellDrag(Shift, X, Y, FPressedDataCol);
    Exit;
  end else if RowPanel.Active and MouseCapture and (FGridState = gsColMoving) then
  begin
    GoRowPanelTitleCellDrag(Shift, X, Y);
    Exit;
  end;

  if (FTracking) and (FPressedCol <> -1) then
  begin
    TrackButton(X, Y);
    if FDBGridEhState in [dgsTitleDown, dgsTitleFilterButtonDown] then
//    Nothing to do
    else if ((Abs(FDownMousePos.X - X) > 3) or (Abs(FDownMousePos.Y - Y) > 3))
        and (dghColumnMove in OptionsEh) then
    begin
      StopTracking;
 //     Perform(WM_LBUTTONDOWN,MK_LBUTTON,MakeWord(FMousePos.X,FMousePos.Y));
      if csCaptureMouse in ControlStyle then MouseCapture := True;
//      if csClickEvents in ControlStyle then Include(ControlState, csClicked);
      Canvas.Pen.Color := clSilver; // Column move line fixup when no dgColLines
      inherited MouseDown(mbLeft, Shift, FDownMousePos.X, FDownMousePos.Y);
    end;
  end;
  if (FIndicatorPressed or FDataTracking or (FDBGridEhState = dgsRectSelecting))
    {and not (FDBGridEhState = ghsRectSelecting)}then
  begin
//    X1 := X; Y1 := Y;
    if UseRightToLeftAlignment then
    begin
      if X1 >= ClientWidth then
        X1 := ClientWidth-1;
      if (X1 < ClientWidth - GridWidth) then
        X1 := ClientWidth - GridWidth + 1;
    end else
    begin
      if X1 < 0 then X1 := 0;
      if X1 >= GridWidth then X1 := GridWidth - 1;
    end;
    if Y1 < 0 then Y1 := 0;
    if Y1 >= GridHeight then Y1 := GridHeight - 1;
    Cell := MouseCoord(X1, Y1);
    AddSel := (OldMoveMousePos.X <> FMoveMousePos.X) or (OldMoveMousePos.Y <> FMoveMousePos.Y);
    if (Y > DataRect.Top) and (Y < DataRect.Bottom) then
    begin
      WithSeleting := ssLeft in Shift;
      if (Cell.Y < Row)
        then DoSelection(WithSeleting and AddSel, Cell.Y - Row, False, not (FDBGridEhState = dgsRectSelecting))
      else if (Cell.Y > Row)
        then DoSelection(WithSeleting and AddSel, Cell.Y - Row, False, not (FDBGridEhState = dgsRectSelecting));
    end;
    if FDataTracking and (X > DataRect.Left) and (X < DataRect.Right) and (Cell.X <> Col) then
    begin
      if Cell.X > Col
        then MoveCol(RawToDataColumn(Cell.X), 1, False)
        else MoveCol(RawToDataColumn(Cell.X), -1, False);
      if (FDBGridEhState = dgsRectSelecting) then
        Selection.Rect.Select(RawToDataColumn(Cell.X), DataSource.DataSet.Bookmark, AddSel)
    end;
    FDownMousePos := Point(X, Y);
    FMouseShift := Shift;
    TimerScroll;
  end;
  if FDBGridEhState = dgsColSelecting then
  begin
    Cell := MouseCoord(X, Y);
    if (X > DataRect.Left) and (X < DataRect.Right) and (Cell.X <> -1) then
      if (ssCtrl in Shift) {and (Selection.Columns.IndexOf(Columns[RawToDataColumn(Cell.X)]) = -1)}
        then Selection.Columns.SelectShift(Columns[RawToDataColumn(Cell.X)] {,True})
      else Selection.Columns.SelectShift(Columns[RawToDataColumn(Cell.X)] {,False})
    else
      TimerScroll;
  end
  else if FDBGridEhState = dgsColSizing then //Frozen cols
  begin
    if CanTraceColSizing then
    begin
      FSizingPos := X + FSizingOfs;
      if Self.UseRightToLeftAlignment then
        FSizingPos := ClientWidth - FSizingPos;
      CalcDrawInfo(DrawInfo);
      NewSize := ResizeLine(DrawInfo.Horz);
      if NewSize < 1 then NewSize := 1;
      if not AutoFitColWidths or (csDesigning in ComponentState) or (AutoFitColWidths and
        (FSizingPos < DrawInfo.Horz.GridBoundary - (Columns.Count - FSizingIndex) -
        DrawInfo.Horz.EffectiveLineWidth * (Columns.Count - FSizingIndex)))
        then ColWidths[FSizingIndex] := NewSize;
      UpdateDesigner;
    end else
    begin
      DrawSizingLineEx(GridWidth, GridHeight); { XOR it out }
      FSizingPos := X + FSizingOfs;
      DrawSizingLineEx(GridWidth, GridHeight); { XOR it back in }
    end;
  end
  else if CanTraceColSizing and (FGridState = gsColSizing) then
  begin
    FSizingPos := X + FSizingOfs;
    if Self.UseRightToLeftAlignment then
      FSizingPos := ClientWidth - FSizingPos;
    CalcDrawInfo(DrawInfo);
    NewSize := ResizeLine(DrawInfo.Horz);
    if NewSize < 1 then NewSize := 1;
    if not AutoFitColWidths or (csDesigning in ComponentState) or (AutoFitColWidths and
      (FSizingPos < DrawInfo.Horz.FullGridBoundary - (Columns.Count - FSizingIndex) -
      DrawInfo.Horz.EffectiveLineWidth * (Columns.Count - FSizingIndex)))
      then ColWidths[FSizingIndex] := NewSize;
    UpdateDesigner;
    Exit;
  end
  else if FDBGridEhState = dgsRowMoving then
  begin
    CellHit := MouseCoord(X, Y);
    if (CellHit.Y >= FixedRows) and
      (CellHit.Y <= DrawInfo.Vert.LastFullVisibleCell+1) then
    begin
      CalcDrawInfo(DrawInfo);
      MoveDataRowAndScroll(Y, CellHit.Y, DrawInfo, DrawInfo.Vert, SB_VERT, Point(X,Y));
    end;
  end else if (FGridState = gsColMoving) and OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtTopEh) then
  begin
    if PtInRect(OutBRect, Point(X,Y)) then
      StartGroupPanelTitleMovingMode(Shift, X, Y);
  end else if FDBGridEhState = dgsGroupPanelTitleMoving then
  begin
    DragGroupPanelTitleMovingMode(Shift, X, Y);
  end else if FDBGridEhState = dgsGroupPanelTitleDown then
  begin
    TrackButton(X, Y);
    if (Abs(FDownMousePos.X - X) > 3) or (Abs(FDownMousePos.Y - Y) > 3) then
    begin
      StopTracking;
      if csCaptureMouse in ControlStyle then MouseCapture := True;
      FGroupDataMovingIndex := FPressedDataGroupLevelIdx;
      StartGroupPanelTitleMovingMode(Shift, X, Y);
    end;
  end;

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomDBGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  SaveState: TGridState;
  DoClick: Boolean;
  ACol: Longint;
  ARect: TRect;
  ADBGridEhState: TDBGridEhState;
  I, NewSize: Integer;
  CellAreaType: TCellAreaTypeEh;
  AreaCol, AreaRow: Integer;
begin
  FDSMouseCapture := False;
  Cell := MouseCoord(X, Y);
  CellAreaType := GetCellAreaType(Cell.X, Cell.Y, AreaCol, AreaRow);
  if RowPanel.Active and (FGridState in [gsColSizing, gsRowSizing]) then
  begin
    MouseUpInTitleRowPanel(Button, Shift, X, Y);
    Exit;
  end else if RowPanel.Active and (FGridState = gsColMoving) then
  begin
    StopRowPanelTitleCellDrag(Shift, X, Y, True);
    Exit;
  end else if (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
    if RowPanel.Active and
       (CellAreaType.HorzType = hctDataEh) and
       (CellAreaType.VertType in [vctTitleEh{, vctSubTitleEh, vctDataEh, vctFooterEh}]) then
    begin
      MouseUpInTitleRowPanel(Button, Shift, X, Y);
      Exit;
    end;
  end;

  if (FDBGridEhState = dgsColSizing) and not (dghTraceColSizing in OptionsEh) then
  begin
    DrawSizingLineEx(GridWidth, GridHeight);
    NewSize := 0;
    {for I := 0 to IndicatorOffset-1 do
    begin
      Inc(NewSize, ColWidths[I]);
      Inc(NewSize, GridLineWidth);
    end;}
    for I := 0 to FSizingIndex - 1 do
      Inc(NewSize, ColWidths[I] + GridLineWidth);
    NewSize := FSizingPos - NewSize;
    if NewSize > 1 then
    begin
      ColWidths[FSizingIndex] := NewSize;
      UpdateDesigner;
    end;
  end
  else if FDBGridEhState = dgsRowMoving then
    EndRowMoving(X, Y, True)
  else if FDBGridEhState = dgsGroupPanelTitleMoving then
    StopGroupPanelTitleMovingMode(Shift, X, Y, True);
  if FSelectedCellPressed = True then
  begin
    FSelectedCellPressed := False;
    if (ssCtrl in Shift) and (dgRowSelect in Options)
      then FBookmarks.CurrentRowSelected := not FBookmarks.CurrentRowSelected
    else if (dghClearSelection in OptionsEh)
      then CheckClearSelection;
  end
  else if (dghTraceColSizing in OptionsEh) and (FGridState = gsColSizing) then
  begin
    FGridState := gsNormal;
    Exit;
  end;
  ADBGridEhState := FDBGridEhState; //in any exception new state ghsNormal
  FDBGridEhState := dgsNormal;
  SaveState := FGridState;
  //FIndicatorPressed := False;
  FSelecting := False;
  if (GetCursor = Screen.Cursors[crVSplit])
    then FDefaultRowChanged := True; // Released after line resized

  if FTracking and (FPressedCol >= 0) then
  begin
    Cell := MouseCoord(X, Y);
    DoClick := PtInRect(Rect(0, 0, ClientWidth, ClientHeight), Point(X, Y))
      and (Cell.Y = 0) and (Cell.X = FPressedCol);
    if (IsUseMultiTitle = True) and DoClick and (Cell.X - IndicatorOffset >= 0) then
    begin
      ARect := CellRect(Cell.X, Cell.Y);
      DoClick := not (PtInRect(Rect(ARect.Left, ARect.Top,
        ARect.Right, ARect.Bottom - FLeafFieldArr[Cell.X - IndicatorOffset].FLeaf.Height + 1),
        Point(X, Y)));
    end;
    StopTracking;
    if DoClick then
    begin
      ACol := Cell.X;
      if IndicatorColVisible then Dec(ACol);
      if {(DataLink <> nil) and DataLink.Active and}(ACol >= 0) and
        (ACol < Columns.Count) then
      begin
        DoTitleClick(ACol, Columns[ACol]);
        FSortMarking := ssCtrl in Shift;
        if (dghAutoSortMarking in OptionsEh)
          then Columns[ACol].Title.SetNextSortMarkerValue(FSortMarking);
        if not FSortMarking
          then DoSortMarkingChanged;
      end;
    end;
  end
  else if FSwapButtons then
  begin
    FSwapButtons := False;
    MouseCapture := False;
    if Button = mbRight then Button := mbLeft;
  end  else if ADBGridEhState = dgsGroupPanelTitleDown then
  begin
    GroupPanelTitleUp(Button, Shift, X, Y);
  end;


{  if FSelectionAnchorState = sasOnlyMouseEh then
    RangeToBookmarks(FSelectionAnchor, FCurrentRecordBookmark, FSelectionAnchorSelected);
}
  if FIndicatorPressed or FDataTracking then StopTracking;
  if (ADBGridEhState <> dgsNormal) then StopTimer;

  inherited MouseUp(Button, Shift, X, Y);
  if (SaveState = gsRowSizing) or (SaveState = gsColSizing) or
    ((InplaceEditor <> nil) and (InplaceEditor.Visible) and
    (PtInRect(InplaceEditor.BoundsRect, Point(X, Y))))
    then Exit;
  Cell := MouseCoord(X, Y);
  if (Button = mbLeft) and (Cell.X >= FIndicatorOffset) and (Cell.Y >= 0) then
    if Cell.Y < TopDataOffset
      then TitleClick(Columns[RawToDataColumn(Cell.X)])
    else if (Cell.Y < {Visible}DataRowCount + TopDataOffset) then
      if CellTreeElementMouseDown(X, Y, True) then
        Exit
      else
        CellClick(Columns[RawToDataColumn(Cell.X)]);

  FDefaultRowChanged := False;
  if not RowPanel.Active and
    (FPressedCell.X = Cell.X) and
    (FPressedCell.Y = Cell.Y) and
    (CellAreaType.HorzType = hctDataEh) and
    (CellAreaType.VertType = vctDataEh) and
    (Columns[Cell.X - IndicatorOffset].GetColumnType in [ctKeyImageList..ctCheckboxes])
  then
  begin
    if RowDetailPanel.Active and CheckMouseDownInRowDetailSign(Button, Shift, X, Y) then
      Exit;
    if not Columns[Cell.X - IndicatorOffset].DblClickNextVal and
      not (ssDouble in Shift) and Columns[Cell.X - IndicatorOffset].CanModify(True)
    then if (ssShift in Shift)
        then Columns[Cell.X - IndicatorOffset].SetNextFieldValue(-1)
        else Columns[Cell.X - IndicatorOffset].SetNextFieldValue(1)
  end else if RowPanel.Active and
     (CellAreaType.HorzType = hctDataEh) and
     (CellAreaType.VertType in [{vctTitleEh, vctSubTitleEh,} vctDataEh{, vctFooterEh}]) then
  begin
    MouseUpInDataRowPanel(Button, Shift, X, Y);
  end;
end;

procedure TCustomDBGridEh.MouseUpInTitleRowPanel(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  ARect: TRect;
  Column: TColumnEh;
  ACellRect: TRect;
begin
  Cell := MouseCoord(X, Y);
  ARect := CellRect(Cell.X, Cell.Y);
  if FGridState in [gsColSizing, gsRowSizing]
    then Column := Columns[FSizingIndex]
    else Column := GetColumnInRowPanelAtPos(
           Point(X-ARect.Left+FDataOffset.cx, Y-ARect.Top), True);
  if Column <> nil then
    MouseUpInTitleCell(Button, Shift, X, Y, Cell, Column,
        ACellRect, X-ARect.Left, Y-ARect.Top);
end;

procedure TCustomDBGridEh.MouseUpInDataRowPanel(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  ARect: TRect;
  Column: TColumnEh;
  ACellRect: TRect;
begin
  Cell := MouseCoord(X, Y);
  ARect := CellRect(Cell.X, Cell.Y);
  if FGridState in [gsColSizing, gsRowSizing]
    then Column := Columns[FSizingIndex]
    else Column := GetColumnInRowPanelAtPos(
            Point(X-ARect.Left+FDataOffset.cx, Y-ARect.Top), False);
  if Column <> nil then
    MouseUpInDataCell(Button, Shift, X, Y, Cell, Column,
        ACellRect, X-ARect.Left, Y-ARect.Top);
end;

procedure TCustomDBGridEh.MouseUpInTitleCell(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Cell: TGridCoord;
  Column: TColumnEh; ACellRect: TRect; InCellX, InCellY: Integer);
var
  ColumnIndex: Integer;
  DoClick: Boolean;
  DrawInfo: TGridDrawInfoEh;
  NewSize, NewSize1: Integer;
  InRowHeight: Integer;
  i: Integer;

  function TryFixSizeToNearestColumn(NewSize: Integer): Integer;
  var
    i: Integer;
    Column: TColumnEh;
    ACellInCellRect: TRect;
    AbsPost: Integer;
    ARect:TRect;
  begin
    Result := NewSize;
    if ssCtrl in Shift then Exit;
    ARect := CellRect(Cell.X, Cell.Y);
    for i := 0 to Columns.Count-1 do
    begin
      Column := Columns[i];
      if Column = Columns[FSizingIndex] then Continue;
      ACellInCellRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
        Column.FRowPlacement.Left + Column.FRowPlacement.Width - 1,
        Column.FRowPlacement.Top + Column.FRowPlacement.Height - 1);
      if dgColLines in Options then Inc(ACellInCellRect.Right, GridLineWidth);
      if dgRowLines in Options then Inc(ACellInCellRect.Bottom, GridLineWidth);
      AbsPost := ARect.Left + ACellInCellRect.Right - FSizingOfs - FDataOffset.cx;
      if (Abs(AbsPost - X) < 4) then
      begin
        Result := Result + AbsPost - X;
        Exit;
      end;
    end;
  end;
begin
  ColumnIndex := Column.Index;

  if FGridState = gsRowSizing then
  begin
    CalcDrawInfo(DrawInfo);
    DrawSizingLine(DrawInfo);
    InRowHeight := InRowPanelLineHeight;
    NewSize :=
      Columns[FSizingIndex].InRowLineHeight * InRowHeight + (Y - FDownMousePos.Y);
    NewSize :=  Round(NewSize / InRowHeight);
    if NewSize >= 1 then
    begin
      Columns.BeginUpdate;
      try
      if not (ssShift in Shift) then
        for i := 0 to Columns.Count-1 do
        begin
          if (Columns[i] <> Columns[FSizingIndex]) and
             (Columns[i].InRowLinePos + Columns[i].InRowLineHeight =
              Columns[FSizingIndex].InRowLinePos + Columns[FSizingIndex].InRowLineHeight)
          then
          begin
            NewSize1 := Columns[i].InRowLineHeight + NewSize - Columns[FSizingIndex].InRowLineHeight;
            if NewSize1 >= 1 then
              Columns[i].InRowLineHeight := NewSize1;
          end;
        end;
      Columns[FSizingIndex].InRowLineHeight := NewSize;
      finally
      Columns.EndUpdate;
      end;
      if MemTableSupport then
        UpdateAllDataRowHeights;
      UpdateDesigner;
    end;
    FGridState := gsNormal;
  end else if FGridState = gsColSizing then
  begin
    CalcDrawInfo(DrawInfo);
    DrawSizingLineEx(GridWidth, GridHeight);
    if (FGridState = gsColSizing) and Self.UseRightToLeftAlignment then
    begin
      FSizingOfs := ClientWidth - FSizingOfs;
      NewSize := Columns[FSizingIndex].Width + (FDownMousePos.X - X);
    end else
      NewSize := Columns[FSizingIndex].Width + (X - FDownMousePos.X);
    NewSize :=  TryFixSizeToNearestColumn(NewSize);
    if NewSize > 1 then
    begin
      Columns.BeginUpdate;
      try
      if not (ssShift in Shift) then
        for i := 0 to Columns.Count-1 do
        begin
          if (Columns[i] <> Columns[FSizingIndex]) and
             (Columns[i].FRowPlacement.Left + Columns[i].FRowPlacement.Width =
              Columns[FSizingIndex].FRowPlacement.Left + Columns[FSizingIndex].FRowPlacement.Width)
          then
          begin
            NewSize1 := Columns[i].Width + NewSize - Columns[FSizingIndex].Width;
            if NewSize1 > 1 then
              Columns[i].Width := NewSize1;
          end;
        end;
      Columns[FSizingIndex].Width := NewSize;
      finally
      Columns.EndUpdate;
      end;
      UpdateDesigner;
    end;
    FGridState := gsNormal;
  end else if FTracking and (FPressedDataCol >= 0) then
  begin
    DoClick := (Cell.Y = 0) and (ColumnIndex = FPressedDataCol);
    StopTracking;
    if DoClick then
    begin
      DoTitleClick(ColumnIndex, Column);
      FSortMarking := ssCtrl in Shift;
      if (dghAutoSortMarking in OptionsEh)
        then Column.Title.SetNextSortMarkerValue(FSortMarking);
      if not FSortMarking
        then DoSortMarkingChanged;
    end;
  end;
end;

procedure TCustomDBGridEh.MouseUpInDataCell(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Cell: TGridCoord; Column: TColumnEh;
  ACellRect: TRect; InCellX, InCellY: Integer);
begin
  if CheckDataCellMouseDownInRowDetailSign(Button, Shift, X, Y,
      Cell, Column, ACellRect, InCellX, InCellY) then
    Exit;  
  if (FPressedDataCol = Column.Index) and
    (FPressedCell.Y = Cell.Y) and
    (Column.GetColumnType in [ctKeyImageList..ctCheckboxes]) and
     not Column.DblClickNextVal and
     not (ssDouble in Shift) and
     Column.CanModify(True)
  then if (ssShift in Shift)
    then Column.SetNextFieldValue(-1)
    else Column.SetNextFieldValue(1);
end;

procedure TCustomDBGridEh.DefaultCellMouseClick(Cell: TGridCoord; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Center.CellMouseClick(Self, Cell, Button, Shift, X, Y);
end;

procedure TCustomDBGridEh.MoveCol(DataCol, Direction: Integer; Select: Boolean);
var
  OldCol: Integer;
begin
  if Select and not (dgRowSelect in Options) and CanSelectType(gstRectangle) then
    if Selection.FSelectionType <> gstRectangle then
    begin
      Selection.Rect.Clear;
      Selection.Rect.Select(RawToDataColumn(Col), Datalink.Datasource.Dataset.Bookmark, True);
    end;
  FDatalink.UpdateData;
  if DataCol >= Columns.Count then
    DataCol := Columns.Count - 1;
  if DataCol < 0 then
    DataCol := 0;
  if Direction <> 0 then
  begin
    while (DataCol < Columns.Count - ContraColCount) and (DataCol >= 0) and
        (not Columns[DataCol].Visible) do
      Inc(DataCol, Direction);
    if (DataCol >= Columns.Count - ContraColCount) or (DataCol < 0)
      then Exit;
  end;
  OldCol := SelectedIndex;
  if DataCol <> OldCol then
  begin
    if not FInColExit then
    begin
      FInColExit := True;
      try
        ColExit;
      finally
        FInColExit := False;
      end;
      if SelectedIndex <> OldCol then Exit;
    end;
    if not (dgAlwaysShowEditor in Options) then HideEditor;
    {}//Col := RawCol;
    if RowPanel.Active then
    begin
      SetColInRowPanel(DataCol);
      if ThemesEnabled then InvalidateTitle;
    end else
      if not (dgRowSelect in Options) then Col := DataToRawColumn(DataCol);
    if not (Columns[SelectedIndex].GetColumnType in [ctKeyImageList..ctCheckboxes])
      and (dgAlwaysShowEditor in Options) and not FilterEditMode
    then
      ShowEditor;
    ColEnter;
  end;
  if Select and not (dgRowSelect in Options) and CanSelectType(gstRectangle)
    then Selection.Rect.Select(RawToDataColumn(Col), Datalink.Datasource.Dataset.Bookmark, True);
  StopInplaceSearch;
  if Columns.Count > 0 then
    FColumns.FUpDownBaseColumn := Columns[SelectedIndex];
end;

procedure TCustomDBGridEh.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  NeedLayout: Boolean;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TPopupMenu) then
    begin
      for I := 0 to Columns.Count - 1 do
        if Columns[I].PopupMenu = AComponent
          then Columns[I].PopupMenu := nil;
    end
    else if (AComponent is TCustomImageList) then
    begin
      if TitleImages = AComponent then TitleImages := nil;
      for I := 0 to Columns.Count - 1 do
        if Columns[I].ImageList = AComponent then
          Columns[I].ImageList := nil;
    end else if (AComponent is TScrollBar) then
    begin
      if VertScrollBar.ExtScrollBar = AComponent then
        VertScrollBar.ExtScrollBar := nil
      else if HorzScrollBar.ExtScrollBar = AComponent then
        HorzScrollBar.ExtScrollBar := nil
    end else if (AComponent is TDataSource) then
    begin
      for I := 0 to Columns.Count - 1 do
        if Columns[I].DropDownBox.ListSource = AComponent then
          Columns[I].DropDownBox.ListSource := nil;
      if (FDataLink <> nil) and (AComponent = DataSource) then
        DataSource := nil;
    end
    else if (FDataLink <> nil) then
      if (AComponent is TField) then
      begin
        NeedLayout := False;
        BeginLayout;
        try
          for I := 0 to Columns.Count - 1 do
            with Columns[I] do
              if Field = AComponent then
              begin
                Field := nil;
                NeedLayout := True;
              end;
        finally
          if NeedLayout and Assigned(FDatalink.Dataset)
            and not FDatalink.Dataset.ControlsDisabled then
            EndLayout
          else
            DeferLayout;
        end;
      end
    else if (AComponent is TDataSet) then
    begin
      CheckIMemTable;
      if ViewScroll then
      begin
        UpdateRowCount;
        MTViewDataEvent(-1, mtViewDataChangedEh, -1);
      end;
      LayoutChanged;
    end;
  end;
end;

procedure TCustomDBGridEh.RecordChanged(Field: TField);
var
  I: Integer;
  CField: TField;
  NeedInvalidateEditor: Boolean;
begin
  if not HandleAllocated then Exit;
  if Field = nil then
    Invalidate
  else
  begin
    for I := 0 to Columns.Count - 1 do
      if Columns[I].Field = Field then
        //InvalidateCol(DataToRawColumn(I));
      begin
      //  InvalidateCol(DataToRawColumn(I));
      //  InvalidateRow(Row);
        GridInvalidateRow(Self, Row);
      end;
  end;
  CField := SelectedField;
  NeedInvalidateEditor := False;
  if ((Field = nil) or (CField = Field)) and
    Assigned(CField) then
    if (DrawMemoText = True) and (CField.DataType in MemoTypes) then
      NeedInvalidateEditor := (AdjustLineBreaks(CField.AsString) <> FEditText)
    else if Columns[SelectedIndex].GetColumnType = ctKeyPickList then
      NeedInvalidateEditor := (Columns[SelectedIndex].DisplayText <> FEditText)
    else
      NeedInvalidateEditor := (CField.Text <> FEditText);
  if NeedInvalidateEditor then
  begin
    InvalidateEditor;
    if InplaceEditor <> nil then
      InplaceEditor.Deselect;
  end;
end;

procedure TCustomDBGridEh.InvalidateEditor;
begin
  FInplaceColInRowPanel := -1;
  FInplaceRow := -1;
  if (InplaceEditor <> nil) and TDBGridInplaceEdit(InplaceEditor).FListVisible then
    with TDBGridInplaceEdit(InplaceEditor) do
    begin
      FLockCloseList := True;
      try
        inherited InvalidateEditor;
      finally
        FLockCloseList := False;
      end;
    end
  else
    inherited InvalidateEditor;
  if FilterEditMode then
    UpdateFilterEdit(True);  
end;

function TCustomDBGridEh.HaveHideDuplicates: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Columns.Count-1 do
    if Columns[i].HideDuplicates then
    begin
      Result := True;
      Break;
    end;
end;

procedure TCustomDBGridEh.Scroll(Distance: Integer);
var
  OldRect, NewRect{, ClipRegion}: TRect;
  RowHeight: Integer;
  VertSBVis: Boolean;
  MousePos: TPoint;
begin
  if RowDetailPanel.Visible then RowDetailPanel.Visible := False;
  if ViewScroll then
  begin
    MTScroll(Distance);
    Exit;
  end;
  if not HandleAllocated then Exit;
  OldRect := BoxRect(0, Row, ColCount - 1, Row);
  OldRect.Right := ClientWidth;
  if (FDataLink.ActiveRecord >= RowCount - TopDataOffset) then
    UpdateRowCount;
  VertSBVis := VertScrollBar.IsScrollBarVisible;
  UpdateScrollBar;
  if (VertSBVis <> VertScrollBar.IsScrollBarVisible) then
  begin
    if (FAutoFitColWidths = True) {and (UpdateLock = 0)} and not (csDesigning in ComponentState)
      then DeferLayout;
  end;
  //UpdateScrollBar;
  UpdateActive;
  NewRect := BoxRect(0, Row, ColCount - 1, Row);
  NewRect.Right := ClientWidth;
  WindowsValidateRect(Handle, OldRect);
  WindowsInvalidateRect(Handle, OldRect, False);
  WindowsInvalidateRect(Handle, NewRect, False);
  if Distance <> 0 then
  begin
    HideEditor;
    try
      if Abs(Distance) > {dddVisibleRowCount} VisibleDataRowCount then
      begin
        Invalidate;
        Exit;
      end else
      begin
        RowHeight := FStdDefaultRowHeight;
        if dgRowLines in Options then Inc(RowHeight, GridLineWidth);
        if IndicatorColVisible then
        begin
          if FSelRow >= TopDataOffset then
          begin
            OldRect := BoxRect(0, FSelRow, ColCount - 1, FSelRow);
            OldRect.Right := ClientWidth;
            WindowsInvalidateRect(Handle, OldRect, False);
          end;  
        end;
        NewRect := BoxRect(0, TopDataOffset, ColCount - 1, RowCount-1);
        NewRect.Right := ClientWidth;
        (*if (FooterRowCount > 0) then
        begin
          ClipRegion := BoxRect(0, TopDataOffset, ColCount - 1, RowCount - FooterRowCount - 2);
          ClipRegion.Right := ClientWidth;
          WindowsScrollWindowEx(Handle, 0, -RowHeight * Distance, NewRect, ClipRegion,
            0, {nil,} SW_Invalidate);
        end else*)
          WindowsScrollWindowEx(Handle, 0, -RowHeight * Distance, NewRect, NewRect,
            0, {nil,} SW_Invalidate);
        if IndicatorColVisible then
        begin
          NewRect := BoxRect(0, Row, ColCount - 1, Row);
          NewRect.Right := ClientWidth;
          WindowsInvalidateRect(Handle, NewRect, False);
        end;
        if dghHotTrack in OptionsEh then
        begin
          FHotTrackCell.Y := FHotTrackCell.Y - Distance;
          MousePos := ScreenToClient(Mouse.CursorPos);
          UpdateHotTackInfo(MousePos.X, MousePos.Y);
        end;
      end;
    finally
      if dgAlwaysShowEditor in Options then ShowEditor;
    end;
    if HaveHideDuplicates then
      GridInvalidateRow(Self, TopDataOffset);
  end;
  //ddd
  {if Columns.ExistFooterValueType(fvtFieldValue) then } InvalidateFooter;
  //\\\
  if UpdateLock = 0 then Update;
end;

procedure TCustomDBGridEh.SetColumns(Value: TDBGridColumnsEh);
begin
  Columns.Assign(Value);
end;

procedure TCustomDBGridEh.SetColumnAttributes;
var
  I: Integer;
  NewWidth: Integer;
begin
  SetExtraFirstColumnWidth;
  if RowPanel.Active then
  begin
    ColWidths[FIndicatorOffset] := FGridMasterCellWidth;
    for I := 1 to FColumns.Count - 1 do
      ColWidths[I + FIndicatorOffset] := iif(dgColLines in Options, -1, 0);
  end else
    for I := 0 to FColumns.Count - 1 do
      with FColumns[I] do
      begin
        TabStops[I + FIndicatorOffset] := IsTabStop;
        NewWidth := ColWidthToCellWidth(FColumns[I],
                      iif(Visible, Width, iif(dgColLines in Options, -1, 0)));
        if NewWidth <> ColWidths[I + FIndicatorOffset] then
          ColWidths[I + FIndicatorOffset] := NewWidth;
      end;
  if IndicatorColVisible and HandleAllocated then
    ColWidths[0] := CalcIndicatorColWidth;

  for I := ColCount-1 downto 0 do
  begin
    if ColWidths[i] > 0 then
    begin
      FLastVisibleCol := I;
      Break;
    end;
  end;

end;

procedure TCustomDBGridEh.SetDataSource(Value: TDataSource);
//  Form: TCustomForm;
begin
  if Value = FDatalink.Datasource then Exit;
  ClearSelection;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  LinkActive(FDataLink.Active);

  if (Assigned(DataSource))
    then SumList.DataSet := DataSource.DataSet
    else SumList.DataSet := nil;

  KeyProperyModified;
{  if not (csLoading in ComponentState) and (DataSource <> nil) then
  begin
    Datasource.DesignInfo := MakeLong(Word(-10), Word(-10));

    if csDesigning in ComponentState then
    begin
      Form := GetParentForm(Self);
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
    end;

  end;}
end;

procedure TCustomDBGridEh.KeyProperyModified;
var
  Msg: TCMChanged;
begin
  if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
  begin
    Msg.Msg := CM_CHANGED;
{$IFDEF CIL}
{$ELSE}
    Msg.Unused := 0;
    Msg.Child := Self;
{$ENDIF}
    Msg.Result := 0;
    Broadcast(Msg);
  end;
end;

procedure TCustomDBGridEh.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  FEditText := Value;
end;

procedure TCustomDBGridEh.SetOptions(Value: TDBGridOptions);
const
  LayoutOptions = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TDBGridOptions;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [];
    if (RowSizingAllowed = True)
      then NewGridOptions := NewGridOptions + [goRowSizing];
    if (dghExtendVertLines in OptionsEh) then
      NewGridOptions := NewGridOptions + [goExtendVertLines];
    if dgColLines in Value then
    begin
      NewGridOptions := NewGridOptions + [goFixedVertLine, goVertLine];
//      NewGridOptions := NewGridOptions + [goVertLine];
//      if (IsUseMultiTitle = False) then
//        NewGridOptions := NewGridOptions + [goFixedVertLine];
    end;
    if dgRowLines in Value
      then NewGridOptions := NewGridOptions + [goFixedHorzLine, goHorzLine];
    if dgTabs in Value
      then Include(NewGridOptions, goTabs);
    if dgRowSelect in Value then
    begin
      Include(NewGridOptions, goRowSelect);
      Exclude(Value, dgAlwaysShowEditor);
      Exclude(Value, dgEditing);
    end;
    if dgEditing in Value then Include(NewGridOptions, goEditing);
    if dgAlwaysShowEditor in Value
      then Include(NewGridOptions, goAlwaysShowEditor);
    inherited Options := NewGridOptions;
    if dgMultiSelect in (FOptions - Value) then ClearSelection;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    if not (csLoading in ComponentState) then
      UpdateColumnResizeOptions(Value, FOptionsEh);
    FOptions := Value;
    if ChangedOptions * LayoutOptions <> [] then LayoutChanged;
    if EditorMode then InvalidateEditor;
  end;
end;

procedure TCustomDBGridEh.SetOptionsEh(const Value: TDBGridEhOptions);
var
  I: Integer;
  OldPotionsEh: TDBGridEhOptions;
begin
  if (OptionsEh = Value) then Exit;
  if (dghMultiSortMarking in (FOptionsEh - Value)) then
    for i := FSortMarkedColumns.Count - 1 downto 1 do
      FSortMarkedColumns[i].Title.SortMarker := smNoneEh;
  if not (csLoading in ComponentState) then
    UpdateColumnResizeOptions(FOptions, Value);
  OldPotionsEh := FOptionsEh;
  if (dghExtendVertLines in Value) and not (goExtendVertLines in inherited Options) then
    inherited Options := inherited Options + [goExtendVertLines]
  else if not (dghExtendVertLines in Value) then
    inherited Options := inherited Options - [goExtendVertLines];

  FOptionsEh := Value;
  if (     (dghAutoFitRowHeight in OldPotionsEh) and
       not (dghAutoFitRowHeight in FOptionsEh) )
     or
     ( not (dghAutoFitRowHeight in OldPotionsEh) and
              (dghAutoFitRowHeight in FOptionsEh) )
  then
    UpdateAllDataRowHeights();
  LayoutChanged;
end;

procedure TCustomDBGridEh.UpdateColumnResizeOptions(NewOptions: TDBGridOptions;
  NewOptionsEh: TDBGridEhOptions);
begin
  if (dgColumnResize in NewOptions) and not (dgColumnResize in FOptions) then
    FOptionsEh := FOptionsEh + [dghColumnResize, dghColumnMove]
  else if not (dgColumnResize in NewOptions) and (dgColumnResize in FOptions) then
    FOptionsEh := FOptionsEh - [dghColumnResize, dghColumnMove]

  else if ([dghColumnResize, dghColumnMove] * NewOptionsEh = [dghColumnResize, dghColumnMove])
   and ([dghColumnResize, dghColumnMove] * FOptionsEh <> [dghColumnResize, dghColumnMove]) then
    FOptions := FOptions + [dgColumnResize]
  else if ([dghColumnResize, dghColumnMove] * NewOptionsEh <> [dghColumnResize, dghColumnMove])
   and ([dghColumnResize, dghColumnMove] * FOptionsEh = [dghColumnResize, dghColumnMove]) then
    FOptions := FOptions - [dgColumnResize];

  if (FOptions = NewOptions) and (dgColumnResize in FOptions) and (FOptionsEh = NewOptionsEh) then
  begin
    FOptionsEh := FOptionsEh + [dghColumnResize, dghColumnMove];
    NewOptionsEh := NewOptionsEh + [dghColumnResize, dghColumnMove];
  end;

//  if dghColumnResize in FOptionsEh
  if dghColumnResize in NewOptionsEh
    then inherited Options := inherited Options + [goColSizing]
    else inherited Options := inherited Options - [goColSizing];

//  if dghColumnMove in FOptionsEh
  if dghColumnMove in NewOptionsEh
    then inherited Options := inherited Options + [goColMoving]
    else inherited Options := inherited Options - [goColMoving];

{  if dgColumnResize in FOptions then
    FOptionsEh := FOptionsEh + [dghColumnResize, dghColumnMove];
  if (dghColumnResize in FOptionsEh) and (dghColumnMove in FOptionsEh) then
    FOptions := FOptions + [dgColumnResize];
}
end;

procedure TCustomDBGridEh.SetSelectedField(Value: TField);
var
  I: Integer;
begin
  if Value = nil then Exit;
  for I := 0 to Columns.Count - 1 do
    if Columns[I].Field = Value then
      MoveCol(I, 0, False);
end;

procedure TCustomDBGridEh.SetTitleFont(Value: TFont);
begin
  FTitleFont.Assign(Value);
  if dgTitles in Options then LayoutChanged;
end;

function TCustomDBGridEh.StoreColumns: Boolean;
begin
  Result := Columns.State = csCustomized;
end;

procedure TCustomDBGridEh.TimedScroll(Direction: TGridScrollDirection);
begin
  if FDatalink.Active then
  begin
    with FDatalink do
    begin
      if sdUp in Direction then
      begin
        MoveBy(-ActiveRecord - 1);
        Exclude(Direction, sdUp);
      end;
      if sdDown in Direction then
      begin
        MoveBy(RecordCount - ActiveRecord);
        Exclude(Direction, sdDown);
      end;
    end;
    if Direction <> [] then inherited TimedScroll(Direction);
  end;
end;

procedure TCustomDBGridEh.TitleClick(Column: TColumnEh);
begin
  if Assigned(FOnTitleClick) then FOnTitleClick(Column);
end;

procedure TCustomDBGridEh.TitleFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  if dgTitles in Options then LayoutChanged;
end;

procedure TCustomDBGridEh.UpdateActive;
var
  NewRow: Integer;
  Field: TField;
//  I: Integer;
begin
  if not FInplaceSearchingInProcess then
    StopInplaceSearch;
  if ViewScroll then
    MTScroll(0)
  else if FDatalink.Active and HandleAllocated and not (csLoading in ComponentState) then
  begin
    NewRow := FDatalink.ActiveRecord + TopDataOffset;
    if Row <> NewRow then
    begin
      if not (dgAlwaysShowEditor in Options) then HideEditor;
      MoveColRow(Col, NewRow, False, False, False);
      InvalidateEditor;
    end;
//    Columns[SelectedIndex].Field := nil; //Some time AV BUG
    Field := SelectedField;
{    if csDestroying in Field.ComponentState then
      for I := 0 to FColumns.Count - 1 do
        FColumns[I].Field := nil;
    if Assigned(Field) and not (csDestroying in Field.ComponentState) and
      (Field.Text <> FEditText)}
    if Assigned(Field) and DataLink.Active and (Field.Text <> FEditText) then
      InvalidateEditor;
  end;
end;

procedure TCustomDBGridEh.UpdateData;
var
  Field: TField;
  KeyIndex: Integer;
  MasterFields: TObjectList;
  RecheckInList: Boolean;
  Column: TColumnEh;
begin
  Field := SelectedField;
  Column := Columns[SelectedIndex];
  if not Assigned(Field) then
    Column.UpdateDataValues(FEditText, FEditText, True)
  else
  begin
    if (Column.GetColumnType = ctPickList) then //PickList
    begin
      if Assigned(Column.OnNotInList) and
        (StringsLocate(Column.PickList, FEditText, [loCaseInsensitive]) = -1) then
      begin
        RecheckInList := False;
        Column.OnNotinList(Column, FEditText, RecheckInList);
      end;
      //Field.Text := FEditText;
      Column.UpdateDataValues(FEditText, FEditText, True);
    end
    else if (Column.GetColumnType = ctKeyPickList) then //KeyPickList
    begin
      KeyIndex := Column.PickList.IndexOf(FEditText);
      if (KeyIndex > -1) and (KeyIndex < Column.KeyList.Count) then
        FEditKeyValue := Column.KeyList.Strings[KeyIndex]
      else if (KeyIndex = -1) then
        if Assigned(Column.OnNotInList) and (FEditText <> '') then
        begin
          RecheckInList := False;
          Column.OnNotinList(Column, FEditText, RecheckInList);
          if RecheckInList then
          begin
            KeyIndex := Column.PickList.IndexOf(FEditText);
            if (KeyIndex > -1) and (KeyIndex < Column.KeyList.Count)
              then FEditKeyValue := Column.KeyList.Strings[KeyIndex]
              else FEditKeyValue := Null;
          end else
            FEditKeyValue := Null;
        end else if (FEditText = '')
          then FEditKeyValue := Null;
      Column.UpdateDataValues(FEditText, FEditKeyValue, False);
    end
    else if (Field.FieldKind = fkLookup) and (Field.KeyFields <> '') then //LookUp
    begin
      MasterFields := TObjectList.Create(False);
      if VarEquals(FEditKeyValue, Null) and (FEditText <> '') and
        Assigned(Column.OnNotInList) and
        not Column.UsedLookupDataSet.Locate(Field.LookupResultField, FEditText, [loCaseInsensitive]) then
      begin
        RecheckInList := False;
        Column.OnNotinList(Column, FEditText, RecheckInList);
        if RecheckInList and Column.UsedLookupDataSet.Locate(Field.LookupResultField, FEditText, [loCaseInsensitive]) then
        begin
          FEditKeyValue := Column.UsedLookupDataSet.FieldValues[Field.LookupKeyFields];
        end;
      end;
      try
        Field.Dataset.GetFieldList(MasterFields, Field.KeyFields);
        //MasterField := Field.DataSet.FieldByName(Field.KeyFields);
        if FieldsCanModify(MasterFields) then
        begin
          Field.DataSet.Edit;
          Column.UpdateDataValues(FEditText, FEditKeyValue, False);
          //DataSetSetFieldValues(Field.DataSet,Field.KeyFields,FEditKeyValue);
          //Field.DataSet.FieldValues[Field.KeyFields] := FEditKeyValue; //MasterField.Value := FEditKeyValue;
        end;
      finally
        MasterFields.Free;
      end;
      if (DrawMemoText = True) and (Field.DataType in MemoTypes)
        then Field.AsString := FEditText
        else Field.Text := FEditText;
    end
    else if (DrawMemoText = True) and (Field.DataType in MemoTypes) then //Memo
      //  Field.AsString := FEditText
      Column.UpdateDataValues(FEditText, FEditText, True)
    else
      //Field.Text := FEditText;
      Column.UpdateDataValues(FEditText, FEditText, True);
  end;
end;

function TCustomDBGridEh.GetSubTitleRowHeights(ASubTitleRow: Integer): Integer;
begin
  Result := FStdDefaultRowHeight;
end;

function TCustomDBGridEh.CalcIndicatorColWidth: Integer;
var
  ARecordCount, i: Integer;
  WidthText: String;
begin
  Result := 0;

  if dgIndicator in Options then
    Inc(Result, IndicatorWidth);

  if (dghShowRecNo in OptionsEh) and
//      FDataLink.Active and
      Assigned(FDataLink.DataSet) {and
      FDataLink.DataSet.IsSequenced} then
  begin
    if FDataLink.Active
      then ARecordCount := FDataLink.DataSet.RecordCount
      else ARecordCount := 0;
    ARecordCount := ARecordCount div 10;
    WidthText := '0';
    for i := 0 to 100 do
    begin
      if ARecordCount = 0 then Break;
      ARecordCount := ARecordCount div 10;
      WidthText := WidthText + '0';
    end;
//    if HandleAllocated then
//    begin
      Canvas.Font := Font;
      Canvas.Font.Size := Canvas.Font.Size - 1;
      if Result = 0 then Inc(Result, 2);
      Result := Result + Canvas.TextWidth(WidthText) + 2;
      if Result < IndicatorWidth then Result := IndicatorWidth;
//    end;
  end;
end;

procedure TCustomDBGridEh.SetRowCount(NewRowCount: Longint);
begin
  if NewRowCount <= Row then
    MoveColRow(Col, NewRowCount - 1, False, False, False);
  RowCount := NewRowCount;
end;

procedure TCustomDBGridEh.UpdateRowCount;
var
  {BetweenRowHeight,} t: Integer;
  OldRowCount, OccupiedHeight, VisibleDataRowCount, NewRowCount: Integer;

  function LineHeight: Integer;
  begin
    if dgRowLines in Options
      then Result := GridLineWidth
      else Result := 0;
  end;

  function DefaultLineRowHeight: Integer;
  begin
    Result := FStdDefaultRowHeight + LineHeight;
  end;

  procedure SetSubTitleRowHeights;//ddd
  var I: Integer;
  begin
    for I := GetTitleRows to TopDataOffset - 1 do
      Inc(OccupiedHeight, DefaultLineRowHeight);
  end;

  procedure CalcFooterHeight;
  var I: Integer;
  begin
    for I := 0 to FooterRowCount - 1 do
      Inc(OccupiedHeight, DefaultLineRowHeight);
    if (FooterRowCount > 0) then
      Inc(OccupiedHeight, LineHeight);
  end;

begin
  if not Assigned(FDataLink) then Exit;

  if ViewScroll then
  begin
    MTUpdateRowCount;
    Exit;
  end;

//  FTopDataOffset := GetTopDataOffset;
  OldRowCount := RowCount;
  if RowCount <= TopDataOffset then
    SetRowCount(TopDataOffset + 1);
  FixedRows := TopDataOffset;
  FOldTopLeft.X := LeftCol;
  FOldTopLeft.Y := TopRow;
  OccupiedHeight := 0;
  if dgTitles in Options then
  begin
    RowHeights[0] := FTitleRowHeight;
    Inc(OccupiedHeight, RowHeights[0] + LineHeight);
  end;
  SetSubTitleRowHeights;
  CalcFooterHeight;

  t := RowHeights[0];
  DefaultRowHeight := FStdDefaultRowHeight;
  if dgTitles in Options then RowHeights[0] := t;

  TopRow := FixedRows;
  
  with FDataLink do
    if not Active or (RecordCount = 0) or not HandleAllocated then
    begin
      //MoveColRow(Col, TitleOffset, False, False);

      SetRowCount(1 + TopDataOffset);
      ContraRowCount := FooterRowCount;

(*      SetRowCount(1 + TopDataOffset);
      Inc(OccupiedHeight, DefaultLineRowHeight);
      if HandleAllocated then
      begin
        if (FooterRowCount > 0) then
        begin
          SetRowCount(RowCount + FooterRowCount + 1);
          BetweenRowHeight := ClientHeight - OccupiedHeight {- LineHeight};
          if BetweenRowHeight < 0 then BetweenRowHeight := 0;
          RowHeights[TopDataOffset + 1] := BetweenRowHeight;
        end;
      end;*)
    end else
    begin
      VisibleDataRowCount := (ClientHeight - OccupiedHeight {- LineHeight}) div DefaultLineRowHeight;
      if VisibleDataRowCount <= 0 then VisibleDataRowCount := 1;

      FDataLink.BufferCount := VisibleDataRowCount;
      VisibleDataRowCount := FDataLink.RecordCount;
      Inc(OccupiedHeight, DefaultLineRowHeight * VisibleDataRowCount);
      NewRowCount := VisibleDataRowCount + TopDataOffset;

      if FooterRowCount > 0 then
      begin
        SetRowCount(NewRowCount);
        ContraRowCount := FooterRowCount;
        (*NewRowCount := NewRowCount + FooterRowCount + 1;
        SetRowCount(NewRowCount);
        BetweenRowHeight := ClientHeight - OccupiedHeight {- LineHeight};
        if BetweenRowHeight < 0 then BetweenRowHeight := 0;
        RowHeights[TopDataOffset + VisibleDataRowCount] := BetweenRowHeight;*)
      end else
      begin
        SetRowCount(NewRowCount);
        ContraRowCount := 0;
      end;

      UpdateActive;
    end;
  if OldRowCount <> RowCount then Invalidate;
end;

procedure TCustomDBGridEh.UpdateScrollBar;
var
  SIOld, SINew: TScrollInfo;
  SINewMax: Integer;
begin
  if (FDatalink = nil) or not HandleAllocated then Exit;
  if ExtendedScrolling then
  begin
    MTUpdateVertScrollBar;
    Exit;
  end;
  SIOld.cbSize := sizeof(SIOld);
  SIOld.fMask := SIF_ALL;
  if VertScrollBar.VisibleMode = sbAlwaysShowEh then
    SIOld.fMask := SIOld.fMask or SIF_DISABLENOSCROLL;
  VertScrollBar.GetScrollInfo(SIOld);
  SINew := SIOld;
  SINew.nMin := 0;
  SINew.nPage := 2;
  SINew.nMax := 1;
  SINew.nPos := 0;
  SINewMax := 1;

  if FDatalink.Active then
    with FDatalink.DataSet do
    begin
      if {dddIsSequenced}  SumList.IsSequenced then
      begin
        SINew.nMin := 1;
        SINew.nPage := {//dddSelf.VisibleRowCount} VisibleDataRowCount;
        SINew.nMax := Integer(DWORD({dddRecordCount} SumList.RecordCount) + SINew.nPage - 1);
        if State in [dsInactive, dsBrowse, dsEdit]
          then SINew.nPos := {dddRecNo} SumList.RecNo // else keep old pos
          else SINew.nPos := SIOld.nPos;
      end
      else
      begin
        SINew.nMin := 0;
        SINew.nPage := 0;
        SINew.nMax := 4;
        if BOF then SINew.nPos := 0
        else if EOF then SINew.nPos := 4
        else SINew.nPos := 2;
      end;
    end;

  if not VertScrollBar.Visible or (VertScrollBar.ExtScrollBar <> nil) then
  begin
    SINewMax := SINew.nMax;
    SINew.nMax := SINew.nMin;
  end;

  if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
    (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) or
    (FVertScrollBarVisibleMode <> VertScrollBar.VisibleMode)
    then
  begin
    if (VertScrollBar.VisibleMode = sbAlwaysShowEh) and (VertScrollBar.ExtScrollBar = nil) then
    begin
      if (SINew.nMax <= SINew.nMin) or (UINT(SINew.nMax - SINew.nMin) <= SINew.nPage) then
      begin
        EnableScrollBar(Handle, SB_VERT, ESB_DISABLE_BOTH);
      end;
      ShowScrollBar(Handle, SB_VERT, True);
    end else if FVertScrollBarVisibleMode <> VertScrollBar.VisibleMode then
    //if not (VertScrollBar.VisibleMode = sbAlwaysShowEh) then
    begin
      FVertScrollBarVisibleMode := VertScrollBar.VisibleMode;
      if (SINew.nMax <= SINew.nMin) or (UINT(SINew.nMax - SINew.nMin) <= SINew.nPage) then
      begin
        EnableScrollBar(Handle, SB_VERT, ESB_ENABLE_BOTH);
        ShowScrollBar(Handle, SB_VERT, False);
      end;
    end;
    SetScrollInfo(Self.Handle, SB_VERT, SINew, True);
    FVertScrollBarVisibleMode := VertScrollBar.VisibleMode;
  end;

  if VertScrollBar.ExtScrollBar <> nil then
    with VertScrollBar.ExtScrollBar do
    begin
      PageSize := 0;
      if SINewMax < SINew.nMin then
        SINew.nMin := SINewMax;
      SetParams(SINew.nPos, SINew.nMin, SINewMax);
      PageSize := SINew.nPage;
    end;
end;

function CalcMaxTopLeft(const Coord: TGridCoord; const DrawInfo: TGridDrawInfoEh): TGridCoord;

  function CalcMaxCell(const Axis: TGridAxisDrawInfoEh; Start: Integer): Integer;
  var
    Line: Integer;
    I, Extent: Longint;
  begin
    Result := Start;
    with Axis do
    begin
      Line := GridExtent + EffectiveLineWidth;
      for I := Start downto FixedCellCount do
      begin
        Extent := GetExtent(I);
        if Extent > 0 then
        begin
          Dec(Line, Extent);
          Dec(Line, EffectiveLineWidth);
          if Line < FixedBoundary then
          begin
            if (Result = Start) and (GetExtent(Start) <= 0) then
              Result := I;
            Break;
          end;
          Result := I;
        end;
      end;
    end;
  end;

begin
  Result.X := CalcMaxCell(DrawInfo.Horz, Coord.X);
  Result.Y := CalcMaxCell(DrawInfo.Vert, Coord.Y);
end;

procedure TCustomDBGridEh.UpdateHorzExtScrollBar;
var
  SIOld, SINew: TScrollInfo;
  DrawInfo: TGridDrawInfoEh;
  MaxTopLeft: TGridCoord;
begin
  if (HorzScrollBar.ExtScrollBar <> nil) then
  begin
    SIOld.cbSize := sizeof(SIOld);
    SIOld.fMask := SIF_ALL;
    HorzScrollBar.GetScrollInfo(SIOld);
    SINew := SIOld;
    SINew.nMin := 0;
    SINew.nPage := VisibleColCount;
    if VisibleColCount + FixedCols = ColCount
      then SINew.nMax := 0
      else SINew.nMax := MaxShortIntEh;
    CalcDrawInfo(DrawInfo);
    MaxTopLeft.X := ColCount - 1;
    MaxTopLeft.Y := RowCount - 1;
    MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
    SINew.nPos := MulDiv(LeftCol - FixedCols, MaxShortIntEh, MaxTopLeft.X - FixedCols);
    if SINew.nMax < SINew.nMin then
      SINew.nMin := SINew.nMax;
    if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
      (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    begin
      HorzScrollBar.ExtScrollBar.PageSize := 0;
      HorzScrollBar.ExtScrollBar.SetParams(SINew.nPos, SINew.nMin, SINew.nMax);
//      HorzScrollBar.ExtScrollBar.PageSize := SINew.nPage;
    end;
  end;
end;

function TCustomDBGridEh.ValidFieldIndex(FieldIndex: Integer): Boolean;
begin
  Result := DataLink.GetMappedIndex(FieldIndex) >= 0;
end;

procedure TCustomDBGridEh.SetIme;
var
  Column: TColumnEh;
begin
  if not SysLocale.FarEast then Exit;
  if Columns.Count = 0 then Exit;

  ImeName := FOriginalImeName;
  ImeMode := FOriginalImeMode;
  if SelectedIndex >= 0 then
  begin
    Column := Columns[SelectedIndex];
    if Column.IsImeNameStored then ImeName := Column.ImeName;
    if Column.IsImeModeStored then ImeMode := Column.ImeMode;
  end;

  if InplaceEditor <> nil then
  begin
{$IFDEF CIL}
//    TDBGridInplaceEdit(InplaceEditor).ImeName := ImeName;
//    TDBGridInplaceEdit(InplaceEditor).ImeMode := ImeMode;
{$ELSE}
    TDBGridInplaceEdit(InplaceEditor).ImeName := ImeName;
    TDBGridInplaceEdit(InplaceEditor).ImeMode := ImeMode;
{$ENDIF}
  end;
end;

procedure TCustomDBGridEh.UpdateIme;
begin
  if not SysLocale.FarEast then Exit;
  SetIme;
  SetImeName(ImeName);
  SetImeMode(Handle, ImeMode);
end;

function TCustomDBGridEh.GetFooterRowCount: Integer;
begin
  Result := FFooterRowCount;
{  if ViewScroll
    then Result := 0
    else Result := FFooterRowCount;}
end;

procedure TCustomDBGridEh.SetFooterRowCount(Value: Integer);
begin
  if (Value <> FFooterRowCount) and (Value >= 0) then
  begin
    FFooterRowCount := Value;
    CheckIMemTable;
    LayoutChanged;
  end;
end;

function TCustomDBGridEh.ReadTitleHeight: Integer;
begin
  Result := FTitleHeight;
end;

procedure TCustomDBGridEh.WriteTitleHeight(th: Integer);
begin
  FTitleHeight := th;
  LayoutChanged;
end;

function TCustomDBGridEh.ReadTitleLines: Integer;
begin
  Result := FTitleLines;
end;

procedure TCustomDBGridEh.WriteTitleLines(tl: Integer);
begin
  FTitleLines := tl;
  LayoutChanged;
end;

procedure TCustomDBGridEh.Paint;
var
  I: Integer;
  VVisibleDataRowCount: Integer;
  J: Integer;
begin
  FDrawnGroupList.Clear;
  if HaveHideDuplicates then
  begin
    VVisibleDataRowCount := VisibleDataRowCount+2;
    for I := 0 to Columns.Count - 1 do
    begin
{$IFNDEF CIL} //????
      SetLength(Columns[I].FCheckedDuplicates, VVisibleDataRowCount);
      for J := 0 to VVisibleDataRowCount - 1 do
        Columns[I].FCheckedDuplicates[J] := False;
{$ENDIF}
    end;
  end;
  inherited;
end;

procedure TCustomDBGridEh.ClearPainted(node: THeadTreeNode);
begin
  node.Drawed := false;
end;

procedure TCustomDBGridEh.WriteVTitleMargin(Value: Integer);
begin
  FVTitleMargin := Value;
  LayoutChanged;
end;

procedure TCustomDBGridEh.WritEhTitleMargin(Value: Integer);
begin
  FHTitleMargin := Value;
  LayoutChanged;
end;

procedure TCustomDBGridEh.WriteUseMultiTitle(Value: Boolean);
begin
  if (FUseMultiTitle <> Value) then
    FUseMultiTitle := Value;
  LayoutChanged;
end;

function TCustomDBGridEh.IsUseMultiTitle: Boolean;
begin
  Result := UseMultiTitle and not RowPanel.Active;
end;

function TCustomDBGridEh.IsMouseInRect(ARect: TRect): Boolean;
var
  Point: TPoint;
begin
   GetCursorPos(Point);
   Point := ScreenToClient(Point);
   Result := PtInRect(ARect, Point);
end;

procedure TCustomDBGridEh.SetRowSizingAllowed(Value: Boolean);
begin
  if Value <> FRowSizingAllowed then
  begin
    FRowSizingAllowed := Value;
    if FRowSizingAllowed
      then inherited Options := inherited Options + [goRowSizing]
      else inherited Options := inherited Options - [goRowSizing];
  end;
end;

function TCustomDBGridEh.GetRowHeight: Integer;
begin
  Result := FNewRowHeight;
end;

procedure TCustomDBGridEh.SetRowHeight(Value: Integer);
begin
  if Value <> FNewRowHeight then
  begin
    FNewRowHeight := iif(Value < 0, 0, Value);
    LayoutChanged;
    UpdateAllDataRowHeights;
  end;
end;

function TCustomDBGridEh.GetRowLines: Integer;
begin
  Result := FRowLines;
end;

procedure TCustomDBGridEh.SetRowLines(Value: Integer);
begin
  if Value <> FRowLines then
  begin
    FRowLines := iif(Value < 0, 0, Value);
    LayoutChanged;
    UpdateAllDataRowHeights;
  end;
end;


procedure TCustomDBGridEh.RowHeightsChanged;
var
  I, ThisHasChanged, Def: Integer;
begin
  if not (dghAutoFitRowHeight in OptionsEh) and not Assigned(OnGetRowHeight) then
  if (FDefaultRowChanged = True) then
  begin
    FDefaultRowChanged := False;
    ThisHasChanged := -1;
    Def := FStdDefaultRowHeight;
    for I := Ord(dgTitles in Options) to RowCount-1 {- iif(FooterRowCount > 0, FooterRowCount + 1, 0)} do
      if RowHeights[I] <> Def then
      begin
        ThisHasChanged := I;
        Break;
      end;
    if ThisHasChanged <> -1 then
    begin
      FRowLines := 0;
      SetRowHeight(RowHeights[ThisHasChanged]);
      UpdateScrollBar;
    end;
  end;
  inherited;
end;

function TCustomDBGridEh.CalcStdDefaultRowHeight: Integer;
var K: Integer;
begin
  if not HandleAllocated then
    Canvas.Handle := GetDC(0);
  try
    Canvas.Font := Font;
    K := Canvas.TextHeight('Wg');
    if Flat
      then K := K + 1
      else K := K + 3;
    if dgRowLines in Options then
      Inc(K, GridLineWidth);
    Result := K;
  finally
    if not HandleAllocated then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;

procedure TCustomDBGridEh.StopTracking;
begin
  if FTracking then
  begin
    if FDBGridEhState = dgsRowMoving then
      EndRowMoving(-1, -1, False);
    StopTimer;
    FIndicatorPressed := False;
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
    FPressedCol := -1;
    FPressedDataCol := -1;
    FDataTracking := False;
    FDBGridEhState := dgsNormal;
{    if FSelectionAnchorState <> sasAltMouseEh then
      FSelectionAnchorState := sasNonEh;
}
    IndicatorTitle.FDown := False;
  end;
end;

procedure TCustomDBGridEh.TrackButton(X, Y: Integer);
var
  Cell: TGridCoord;
  NewPressed: Boolean;
  ARect: TRect;
  Column: TColumnEh;
  AStateRect, GroupRect: TRect;
  k: Integer;
begin
  Cell := MouseCoord(X, Y);
  Column := nil;
  if (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
    ARect := CellRect(Cell.X, Cell.Y);
    if Cell.X >= IndicatorOffset then
      if RowPanel.Active then
        Column := GetColumnInRowPanelAtPos(
          Point(X-ARect.Left+FDataOffset.cx, Y-ARect.Top), False)
      else
        Column := Columns[Cell.X-IndicatorOffset];
  end;
  if FDBGridEhState = dgsGroupPanelTitleDown then
  begin
    GroupRect := EmptyRect;
    NewPressed := False;
    for k := 0 to DataGrouping.ActiveGroupLevelsCount-1 do
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[k].GroupPanelRect;
      if PtInRect(GroupRect, Point(X, Y)) then
      begin
        if k = FPressedDataGroupLevelIdx then
        begin
          NewPressed := True;
          Break;
        end;
      end;
    end;
    if FPressed <> NewPressed then
    begin
      FPressed := NewPressed;
      WindowsInvalidateRect(Handle, GroupRect, False);
    end;
  end else if FDBGridEhState = dgsTitleFilterButtonDown then
  begin
    ARect := CellRect(Cell.X, Cell.Y);
    if (GetMouseHitCellState(Cell, Point(X,Y), ARect, Column, AStateRect) = dgsTitleFilterButtonDown) and
      (FPressedCol = Cell.X)
      then NewPressed := True
      else NewPressed := False;
  end
  else if RowPanel.Active and (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
    NewPressed := PtInRect(Rect(0, 0, ClientWidth, ClientHeight), Point(X, Y))
      and (FPressedCol = Cell.X) and (Cell.Y = 0);
    if Assigned(Column) and NewPressed and (Column.Index = FPressedDataCol)
      then NewPressed := True
      else NewPressed := False;
  end else
  begin
    NewPressed := PtInRect(Rect(0, 0, ClientWidth, ClientHeight), Point(X, Y))
      and (FPressedCol = Cell.X) and (Cell.Y = 0);
    if (IsUseMultiTitle = True) and NewPressed then
    begin
      ARect := CellRect(Cell.X, Cell.Y);
      if Cell.X - IndicatorOffset >= 0 then
        NewPressed := not (PtInRect(Rect(ARect.Left, ARect.Top,
          ARect.Right, ARect.Bottom - FLeafFieldArr[Cell.X - IndicatorOffset].FLeaf.Height + 1),
          Point(X, Y)));
    end;
  end;
  if FPressed <> NewPressed then
  begin
    FPressed := NewPressed;
    GridInvalidateRow(Self, 0);
  end;
end;

procedure TCustomDBGridEh.DoTitleClick(ACol: Longint; AColumn: TColumnEh);
begin
  if Assigned(FOnTitleBtnClick) then FOnTitleBtnClick(Self, ACol, AColumn);
end;

procedure TCustomDBGridEh.CheckTitleButton(ACol: Longint; var Enabled: Boolean);
begin
  if (ACol >= 0) and (ACol < Columns.Count) then
  begin
    if Assigned(FOnCheckButton) then FOnCheckButton(Self, ACol, Columns[ACol], Enabled);
  end
  else Enabled := False;
end;

procedure TCustomDBGridEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  AreaCol, AreaRow: Integer;
  CellAreaType: TCellAreaTypeEh;
begin
  CellAreaType := GetCellAreaType(ACol, ARow, AreaCol, AreaRow);
  if (ARow < GetTitleRows) and (ACol >= IndicatorOffset) and UseMultiTitle and
    (BorderType in [cbtLeftEh, cbtRightEh])
  then
    IsDraw := False
  else if (CellAreaType.HorzType = hctDataEh) and
          (CellAreaType.VertType = vctDataEh) and
          DataGrouping.IsGroupingWorks and
          (DataGrouping.GroupDataTree.FlatVisibleCount > 0) and
          FDataLink.Active
  then
  begin
    if BorderType in [cbtLeftEh, cbtRightEh, cbtBottomEh] then
    begin
      InstantReadRecordEnter(AreaRow);
      if (FDrawGroupDataNode.NodeType = dntDataGroupEh) and
         (BorderType in [cbtLeftEh, cbtRightEh])
      then
        if (BorderType = cbtRightEh) and (ACol = FLastVisibleCol)
          then IsDraw := True
          else IsDraw := False
      else if (FDrawGroupDataNode.NodeType = dntDataGroupEh) and
              (BorderType in [cbtBottomEh]) {and
              (Columns[AreaCol] = VisibleColumns[0])}
      then
        IsDraw := False
      else if (FDrawGroupDataNode.NodeType = dntDataSetRecordEh) and
              (BorderType in [cbtBottomEh]) and
              (Columns[AreaCol] = VisibleColumns[0])
      then
        IsDraw := False
      else
        inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);
      InstantReadRecordLeave;
    end;
  end else
    inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);
end;

function TCustomDBGridEh.SetChildTreeHeight(ANode: THeadTreeNode): Integer;
var htLast: THeadTreeNode;
  newh, maxh, th: Integer;
  rec: TRect;
  DefRowHeight: Integer;
  s: String;
  RestoreCanvas: Boolean;
begin
  RestoreCanvas := not HandleAllocated and not FCanvasHandleAllocated; //not Canvas.HandleAllocated;
  if RestoreCanvas then
  begin
    Canvas.Handle := GetDC(0);
    FCanvasHandleAllocated := True;
  end;
  try
    DefRowHeight := 0;
    Result := 0;
    if (ANode.Child = nil) then Exit;
    htLast := ANode.Child;
    maxh := 0;
    if (htLast.Child <> nil) then
      maxh := SetChildTreEheight(htLast);
    if htLast.Column <> nil
      then Canvas.Font := htLast.Column.Title.Font
      else Canvas.Font := TitleFont;

    rec := Rect(0, 0, htLast.Width - 4 - htLast.WIndent, DefRowHeight);
    if (rec.Left >= rec.Right) then rec.Right := rec.Left + 1; //?????
    s := htLast.Text;
    if s = '' then s := ' ';
    if (htLast.Column <> nil) and (htLast.Column.Title.Orientation = tohVertical) then
      th := iif(htLast.Width > 0,
        WriteTextVerticalEh(Canvas, rec, False, 0, 0, s, taLeftJustify, tlBottom, False, True) + 6
        , 0)
    else
      th := iif(htLast.Width > 0,
        DrawTextEh(Canvas.Handle, s,
        Length(s), rec, DT_WORDBREAK or DT_CALCRECT), 0) + FVTitleMargin;

    if (th > DefRowHeight) then maxh := maxh + th
    else maxh := maxh + DefRowHeight;

    while True do
    begin
      if (ANode.Child = htLast.Next) then begin break; end;
      htLast := htLast.Next;
      newh := 0;
      if (htLast.Child <> nil) then
        newh := SetChildTreEheight(htLast);
      rec := Rect(0, 0, htLast.Width - 4 - htLast.WIndent, DefRowHeight);
      if (rec.Left >= rec.Right)
        then rec.Right := rec.Left + 1; //?????
      s := htLast.Text;
      if s = '' then s := ' ';
      if htLast.Column <> nil then
        Canvas.Font := htLast.Column.Title.Font;
      if (htLast.Column <> nil) and (htLast.Column.Title.Orientation = tohVertical) then
        th := iif(htLast.Width > 0,
          WriteTextVerticalEh(Canvas, rec, False, 0, 0, s, taLeftJustify, tlBottom, False, True) + 6
          , 0)
      else
        th := iif(htLast.Width > 0,
          DrawTextEh(Canvas.Handle, s,
          Length(s), rec, DT_WORDBREAK or DT_CALCRECT), 0) + FVTitleMargin;
      if (th > DefRowHeight)
        then newh := newh + th
        else newh := newh + DefRowHeight;
      if (maxh < newh)
        then maxh := newh;
    end;

    htLast := ANode.Child;
    while ANode.Child <> htLast.Next do
    begin
      if (htLast.Child = nil)
        then htLast.Height := maxh
        else htLast.Height := maxh - htLast.Height;
      htLast := htLast.Next;
    end;
    if (htLast.Child = nil)
      then htLast.Height := maxh
      else htLast.Height := maxh - htLast.Height;

    ANode.Height := maxh; //save ChildTree height in Host
    Result := maxh;
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
      FCanvasHandleAllocated := False;
    end;
  end
end;


function TCustomDBGridEh.GetColWidths(Index: Longint): Integer;
begin
  Result := inherited ColWidths[Index];
end;

procedure TCustomDBGridEh.SetColWidths(Index: Longint; Value: Integer);
begin
  inherited ColWidths[Index] := Value;
  LayoutChanged;
end;


procedure TCustomDBGridEh.WriteAutoFitColWidths(Value: Boolean);
var i: Integer;
begin
  if (FAutoFitColWidths = Value) then Exit;
  FAutoFitColWidths := Value;
  if (csDesigning in ComponentState) then Exit;
  if (FAutoFitColWidths = True) then
  begin
    if not (csLoading in ComponentState) then
      for i := 0 to Columns.Count - 1 do Columns[i].FInitWidth := Columns[i].Width;
    ScrollBars := ssNone;
  end else
  begin
    Columns.BeginUpdate;
    try
      for i := 0 to Columns.Count - 1 do
        Columns[i].Width := Columns[i].FInitWidth;
    finally
      Columns.EndUpdate;
    end;
    ScrollBars := ssHorizontal;
  end;
  if FAutoFitColWidths then
    LeftCol := FixedCols;
  LayoutChanged;
end;

procedure TCustomDBGridEh.WriteMinAutoFitWidth(Value: Integer);
begin
  FMinAutoFitWidth := Value;
  LayoutChanged;
end;

procedure TCustomDBGridEh.SaveColumnsLayoutProducer(ARegIni: TObject; Section:
  String; DeleteSection: Boolean);
var
  I: Integer;
  S: String;
begin
  if (ARegIni is TRegIniFile) then
    TRegIniFile(ARegIni).EraseSection(Section)
  else if DeleteSection then
    TCustomIniFile(ARegIni).EraseSection(Section);

  with Columns do
  begin
    for I := 0 to Count - 1 do
    begin
      if ARegIni is TRegIniFile then
        TRegIniFile(ARegIni).WriteString(Section, Format('%s.%s', [Name, Items[I].FieldName]),
          Format('%d,%d,%d,%d,%d,%d,%d,%d,%d', [Items[I].Index,
            Items[I].Width,
            Integer(Items[I].Title.SortMarker),
            Integer(Items[I].Visible),
            Items[I].Title.SortIndex,
            Items[I].DropDownRows,
            Items[I].DropDownWidth,
            Items[I].InRowLinePos,
            Items[I].InRowLineHeight
            ]))
      else
      begin
        S := Format('%d,%d,%d,%d,%d,%d,%d,%d,%d', [Items[I].Index,
                Items[I].Width,
                Integer(Items[I].Title.SortMarker),
                Integer(Items[I].Visible),
                Items[I].Title.SortIndex,
                Items[I].DropDownRows,
                Items[I].DropDownWidth,
                Items[I].InRowLinePos,
                Items[I].InRowLineHeight
                ]);
        if S <> '' then
        begin
          if ((S[1] = '"') and (S[Length(S)] = '"')) or
          ((S[1] = '''') and (S[Length(S)] = '''')) then
            S := '"' + S + '"';
        end;
      end;
      if ARegIni is TCustomIniFile
        then TCustomIniFile(ARegIni).WriteString(Section, Format('%s.%s', [Name, Items[I].FieldName]), S);
    end;
  end;
end;

procedure TCustomDBGridEh.RestoreColumnsLayoutProducer(ARegIni: TObject;
  Section: String; RestoreParams: TColumnEhRestoreParams);
type
  TColumnInfo = record
    Column: TColumnEh;
    EndIndex: Integer;
    SortMarker: TSortMarkerEh;
    SortIndex: Integer;
  end;
  PColumnArray = ^TColumnArray;
  TColumnArray = array[0..0] of TColumnInfo;
const
  Delims = [' ', ','];
var
  I, J: Integer;
  S: string;
  ColumnArray: array of TColumnInfo;
  AAutoFitColWidth: Boolean;
begin
  AAutoFitColWidth := False;
  BeginUpdate;
  try
    if (AutoFitColWidths) then
    begin
      AutoFitColWidths := False;
      AAutoFitColWidth := True;
    end;
    with Columns do
    begin
      SetLength(ColumnArray, Count);
      try
        for I := 0 to Count - 1 do
        begin
          if (ARegIni is TRegIniFile)
            then S := TRegIniFile(ARegIni).ReadString(Section, Format('%s.%s', [Name, Items[I].FieldName]), '')
            else S := TCustomIniFile(ARegIni).ReadString(Section, Format('%s.%s', [Name, Items[I].FieldName]), '');
          ColumnArray[I].Column := Items[I];
          ColumnArray[I].EndIndex := Items[I].Index;
          if S <> '' then
          begin
            ColumnArray[I].EndIndex := StrToIntDef(ExtractWord(1, S, Delims),
              ColumnArray[I].EndIndex);
            if (crpColWidthsEh in RestoreParams) then
              Items[I].Width := StrToIntDef(ExtractWord(2, S, Delims),
                Items[I].Width);
            if (crpSortMarkerEh in RestoreParams) then
              Items[I].Title.SortMarker := TSortMarkerEh(StrToIntDef(ExtractWord(3, S, Delims),
                Integer(Items[I].Title.SortMarker)));
            if (crpColVisibleEh in RestoreParams) then
              Items[I].Visible := Boolean(StrToIntDef(ExtractWord(4, S, Delims), Integer(Items[I].Visible)));
            if (crpSortMarkerEh in RestoreParams) then
              ColumnArray[I].SortIndex := StrToIntDef(ExtractWord(5, S, Delims), 0);
            if (crpDropDownRowsEh in RestoreParams) then
              Items[I].DropDownRows := StrToIntDef(ExtractWord(6, S, Delims), Items[I].DropDownRows);
            if (crpDropDownWidthEh in RestoreParams) then
              Items[I].DropDownWidth := StrToIntDef(ExtractWord(7, S, Delims), Items[I].DropDownWidth);
            if (crpRowPanelColPlacementEh in RestoreParams) then
            begin
              Items[I].InRowLinePos := StrToIntDef(ExtractWord(8, S, Delims), Items[I].InRowLinePos);
              Items[I].InRowLineHeight := StrToIntDef(ExtractWord(9, S, Delims), Items[I].InRowLineHeight);
            end;
          end;
        end;
        if (crpSortMarkerEh in RestoreParams) then
          for I := 0 to Count - 1 do
            Items[I].Title.SortIndex := ColumnArray[I].SortIndex;
        if (crpColIndexEh in RestoreParams) then
          for I := 0 to Count - 1 do
            for J := 0 to Count - 1 do
              if ColumnArray[J].EndIndex = I then
              begin
                ColumnArray[J].Column.Index := ColumnArray[J].EndIndex;
                Break;
              end;

      finally
        //FreeMem(Pointer(ColumnArray));
        SetLength(ColumnArray, 0);
      end;
    end;
  finally
    EndUpdate;
    if (AAutoFitColWidth = True)
      then AutoFitColWidths := True
      else LayoutChanged;
  end;
end;

procedure TCustomDBGridEh.SaveColumnsLayoutIni(IniFileName: String;
  Section: String; DeleteSection: Boolean);
var IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(IniFileName);
  try
    SaveColumnsLayoutProducer(IniFile, Section, DeleteSection);
  finally
    IniFile.Free;
  end;
end;

procedure TCustomDBGridEh.RestoreColumnsLayoutIni(IniFileName: String;
  Section: String; RestoreParams: TColumnEhRestoreParams);
var IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(IniFileName);
  try
    RestoreColumnsLayoutProducer(IniFile, Section, RestoreParams);
  finally
    IniFile.Free;
  end;
end;

procedure TCustomDBGridEh.SaveColumnsLayout(ARegIni: TRegIniFile);
var
  Section: String;
begin
  Section := GetDefaultSection(Self);
  SaveColumnsLayoutProducer(ARegIni, Section, True);
end;

procedure TCustomDBGridEh.SaveColumnsLayout(ACustIni: TCustomIniFile; Section: String);
begin
  SaveColumnsLayoutProducer(ACustIni, Section, False);
end;

procedure TCustomDBGridEh.RestoreColumnsLayout(ARegIni: TRegIniFile; RestoreParams: TColumnEhRestoreParams);
var
  Section: String;
begin
  Section := GetDefaultSection(Self);
  RestoreColumnsLayoutProducer(ARegIni, Section, RestoreParams);
end;

procedure TCustomDBGridEh.RestoreColumnsLayout(ACustIni: TCustomIniFile;
  Section: String; RestoreParams: TColumnEhRestoreParams);
begin
  RestoreColumnsLayoutProducer(ACustIni, Section, RestoreParams);
end;

procedure TCustomDBGridEh.SaveGridLayoutProducer(ARegIni: TObject;
  Section: String; DeleteSection: Boolean);
begin
  SaveColumnsLayoutProducer(ARegIni, Section, DeleteSection);
  if ARegIni is TRegIniFile then
    TRegIniFile(ARegIni).WriteString(Section, '', Format('%d,%d', [RowHeight, RowLines]))
  else if ARegIni is TCustomIniFile then
    TCustomIniFile(ARegIni).WriteString(Section, '(Default)', Format('%d,%d', [RowHeight, RowLines]));
end;

procedure TCustomDBGridEh.RestoreGridLayoutProducer(ARegIni: TObject; Section: String; RestoreParams: TDBGridEhRestoreParams);
const
  Delims = [' ', ','];
var ColRestParams: TColumnEhRestoreParams;
  S: String;
begin
  ColRestParams := [];
  if grpColIndexEh in RestoreParams then Include(ColRestParams, crpColIndexEh);
  if grpColWidthsEh in RestoreParams then Include(ColRestParams, crpColWidthsEh);
  if grpSortMarkerEh in RestoreParams then Include(ColRestParams, crpSortMarkerEh);
  if grpColVisibleEh in RestoreParams then Include(ColRestParams, crpColVisibleEh);
  if grpDropDownRowsEh in RestoreParams then Include(ColRestParams, crpDropDownRowsEh);
  if grpDropDownWidthEh in RestoreParams then Include(ColRestParams, crpDropDownWidthEh);
  if grpRowPanelColPlacementEh in RestoreParams then Include(ColRestParams, crpRowPanelColPlacementEh);

  RestoreColumnsLayoutProducer(ARegIni, Section, ColRestParams);

  if (ARegIni is TRegIniFile)
    then S := TRegIniFile(ARegIni).ReadString(Section, '', '')
    else S := TCustomIniFile(ARegIni).ReadString(Section, '(Default)', '');

  if (grpRowHeightEh in RestoreParams) then
  begin
    RowHeight := StrToIntDef(ExtractWord(1, S, Delims), 0);
    RowLines := StrToIntDef(ExtractWord(2, S, Delims), 0);
  end;
end;

procedure TCustomDBGridEh.SaveGridLayout(ARegIni: TRegIniFile);
var
  Section: String;
begin
  Section := GetDefaultSection(Self);
  SaveGridLayoutProducer(ARegIni, Section, True);
end;

procedure TCustomDBGridEh.SaveGridLayout(ACustIni: TCustomIniFile; Section: String);
begin
  SaveGridLayoutProducer(ACustIni, Section, False);
end;

procedure TCustomDBGridEh.RestoreGridLayout(ARegIni: TRegIniFile;
  RestoreParams: TDBGridEhRestoreParams);
var
  Section: String;
begin
  Section := GetDefaultSection(Self);
  RestoreGridLayoutProducer(ARegIni, Section, RestoreParams);
end;

procedure TCustomDBGridEh.RestoreGridLayout(ARegIni: TCustomIniFile;
  Section: String; RestoreParams: TDBGridEhRestoreParams);
begin
  RestoreGridLayoutProducer(ARegIni, Section, RestoreParams);
end;

procedure TCustomDBGridEh.SaveGridLayoutIni(IniFileName: String;
  Section: String; DeleteSection: Boolean);
var IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(IniFileName);
  try
    SaveGridLayoutProducer(IniFile, Section, DeleteSection);
  finally
    IniFile.Free;
  end;
end;

procedure TCustomDBGridEh.RestoreGridLayoutIni(IniFileName: String;
  Section: String; RestoreParams: TDBGridEhRestoreParams);
var IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(IniFileName);
  try
    RestoreGridLayoutProducer(IniFile, Section, RestoreParams);
  finally
    IniFile.Free;
  end;
end;


procedure TCustomDBGridEh.SetFrozenCols(Value: Integer);
begin
  if (Value = FFrozenCols) or (Value < 0) then Exit;
  FFrozenCols := Value;
  LayoutChanged;
end;

procedure TCustomDBGridEh.SetFooterFont(Value: TFont);
begin
  FFooterFont.Assign(Value);
  if FooterRowCount > 0 then LayoutChanged;
end;

procedure TCustomDBGridEh.FooterFontChanged(Sender: TObject);
begin
  if (not FSelfChangingFooterFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  if FooterRowCount > 0 then LayoutChanged;
end;

procedure TCustomDBGridEh.SetFooterColor(Value: TColor);
begin
  if not (csLoading in ComponentState) then
    ParentColor := False;
  FFooterColor := Value;
  if FooterRowCount > 0 then Invalidate;
end;

{function TCustomDBGridEh.IsActiveControl: Boolean;
var
  H: Hwnd;
  ParentForm: TCustomForm;
begin
  Result := False;
  ParentForm := GetParentForm(Self);
  if Assigned(ParentForm) then
  begin
    if (ParentForm.ActiveControl = Self) then
      Result := True
  end
  else
  begin
    H := GetFocus;
    while IsWindow(H) and (Result = False) do
    begin
      if H = WindowHandle
        then Result := True
        else H := GetParent(H);
    end;
  end;
end;
}

procedure TCustomDBGridEh.ChangeGridOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth, 0);
    Ext := Point(-1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * ClientWidth, Ext.Y * ClientHeight, nil);
  end else
  begin
    Org := Point(0, 0);
    Ext := Point(1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * ClientWidth, Ext.Y * ClientHeight, nil);
  end;
end;

procedure TCustomDBGridEh.WriteCellText(Column: TColumnEh;
  ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer;
  Text: string; Alignment: TAlignment; Layout: TTextLayout;
  MultyL, EndEllipsis: Boolean; LeftMarg, RightMarg: Integer);
var
  IsUseRightToLeftAlignment: Boolean;
begin
  if Column <> nil
    then IsUseRightToLeftAlignment := Column.UseRightToLeftAlignment
    else IsUseRightToLeftAlignment := UseRightToLeftAlignment;
  if Self.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, ARect);
    Swap(ARect.Left, ARect.Right);
    ChangeGridOrientation(False);
//    if IsRightToLeft then
//      Result := OkToChangeFieldAlignment(AField, Alignment);

    if IsUseRightToLeftAlignment then
      if Alignment = taLeftJustify then
        Alignment := taRightJustify
      else if Alignment = taRightJustify then
        Alignment := taLeftJustify;
    Swap(LeftMarg, RightMarg);
  end;
  WriteTextEh(Canvas, ARect, FillRect, DX, DY, Text, Alignment, Layout,
    MultyL, EndEllipsis, LeftMarg, RightMarg, IsUseRightToLeftAlignment);
  if Self.UseRightToLeftAlignment then
    ChangeGridOrientation(True);
end;

procedure TCustomDBGridEh.PaintButtonControl(Canvas: TCanvas; ARect: TRect;
  ParentColor: TColor; Style: TDrawButtonControlStyleEh;
  DownButton: Integer; Flat, Active, Enabled: Boolean;
  State: TCheckBoxState);
begin
  if Self.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, ARect);
    Swap(ARect.Left, ARect.Right);
    ChangeGridOrientation(False);
  end;
  PaintButtonControlEh(Canvas, ARect, ParentColor, Style, DownButton, Flat, Active, Enabled, State);
  if Self.UseRightToLeftAlignment then
    ChangeGridOrientation(True);
end;

function TCustomDBGridEh.FindFieldColumn(const FieldName: String): TColumnEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Columns.Count - 1 do
    if NlsCompareText(Columns[i].FieldName, FieldName) = 0 then
    begin
      Result := Columns[i];
      Break;
    end;
end;

function TCustomDBGridEh.GetFieldColumns(const FieldName: String): TColumnEh;
begin
  Result := FindFieldColumn(FieldName);
  if Result = nil then
    RaiseGridError(Format(SFieldNameNotFoundEh, [FieldName]));
end;

function TCustomDBGridEh.CanDrawFocusRowRect: Boolean;
begin
  Result := not (csDesigning in ComponentState) and
    (dgRowSelect in Options) and DefaultDrawing and Focused;
end;

procedure TCustomDBGridEh.DrawBorder;
var
  DC, OldDC: HDC;
  R, R1: TRect;
begin
  if Flat and (BorderStyle = bsSingle) and (Ctl3D = True) then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      //DrawEdge(DC, R,BDR_SUNKENOUTER, BF_TOPLEFT);
      //DrawEdge(DC, R,BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
      DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
      if HorzScrollBar.IsScrollBarShowing and (HorzScrollBar.ExtScrollBar = nil) and
         VertScrollBar.IsScrollBarShowing and (HorzScrollBar.ExtScrollBar = nil)
      then
      begin
        R1 := R;
        R1.Left := R1.Right;
        R1.Top := R1.Bottom;
        R1.Left := R1.Left - GetSystemMetrics(SM_CXVSCROLL);
        R1.Top := R1.Top - GetSystemMetrics(SM_CYHSCROLL);
        OffsetRect(R1,-1,-1);
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
        Canvas.Pen.Color := clBtnFace;
        DrawPolyline([Point(R1.Left, R1.Bottom-1),
                      Point(R1.Left, R1.Top),
                      Point(R1.Right, R1.Top)]);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TCustomDBGridEh.OverlaySelectionByTheme(Cell, AreaCell: TGridCoord;
  Column: TColumnEh; AreaRect: TRect; var Params: TColCellParamsEh);
{$IFDEF EH_LIB_11}
var
  LRect: TRect;
  LTheme: HTHEME;
  iStateId, iPartId: Integer;
//  LColor: TColorRef;
{$ENDIF}
begin
{$IFDEF EH_LIB_11}
  if CanFillSelectionByTheme then
  begin
//    Canvas.Brush.Style := bsSolid;
//    Canvas.FillRect(ARect);
//    Image already must be filled
    LTheme := ThemeServices.Theme[teMenu];
//    LTheme := ThemeServices.Theme[teListView];
    LRect := AreaRect;
{    if (gdRowSelected in Params.AState) then
    begin
      if (ACol >= FixedCols + 1) and (ACol < ColCount - 1) then
        InflateRect(LRect, 4, 0)
      else if ACol = FixedCols then
        Inc(LRect.Right, 4)
      else if ACol = (ColCount - 1) then
        Dec(LRect.Left, 4);
    end;}
    if IsSelectionActive
      then iStateId := MPI_HOT
//      else iStateId := MPI_DISABLEDHOT;
      else iStateId := MPI_NORMAL;
//      else iStateId := MPI_DISABLED;

//    iStateId := LISS_DISABLED;
//    iStateId := LISS_HOT;
//    iStateId := LISS_NORMAL;
//    iStateId := LISS_SELECTED;
//    iStateId := LIS_SELECTED;
//    iStateId := LIS_SELECTED;
//    iStateId := LISS_SELECTEDNOTFOCUS;
//    iStateId := LISS_HOTSELECTED;

//    iPartId := LVP_LISTITEM;
    iPartId := MENU_POPUPITEM;

//    if IsThemeBackgroundPartiallyTransparent(LTheme, iPartId, iStateId) then
//      DrawThemeParentBackground(Handle, Canvas.Handle, @LRect);

    DrawThemeBackground(LTheme, Canvas.Handle, iPartId, iStateId,
      LRect, {$IFNDEF CLR}@{$ENDIF}AreaRect);
//    GetThemeColor(LTheme, MENU_POPUPITEM, MPI_HOT, TMT_TEXTCOLOR, LColor);
//    Canvas.Font.Color := LColor;
//    Canvas.Brush.Style := bsClear;
  end
{$ENDIF}
end;

procedure TCustomDBGridEh.DrawSubTitleCell(ACol, ARow: Integer;
  DataCol, DataRow: Integer; CellType: TCellAreaTypeEh; ARect: TRect;
  AState: TGridDrawState; var Highlighted: Boolean);
var
  ABackground: TColor;
  CellMultiSelected: Boolean;
  FilterRect: TRect;
  Column: TColumnEh;
  FlatLineWidth: Integer;
  FInplaceEditorButtonWidth: Integer;
  EditButtonTransparency: Byte;
begin

  if (DataCol >= 0) and (DataCol < Columns.Count)
    then Column := Columns[DataCol]
    else Column := nil;
  if STFilter.Visible
    and (STFilter.Location = stflUnderTitleFilterEh)
    and (ARow = TopDataOffset-1)
    and ((not IndicatorColVisible) or (ACol > 0))
    and CanFilterCol(DataCol)
    and Column.STFilter.Visible then
  begin
    Canvas.Pen.Color := clBlack;
    FilterRect := ARect;

    FlatLineWidth := 0;
    if Flat then
    begin
      if (Column <> nil) and Column.STFilter.DropDownButtonVisible then
        Inc(FlatLineWidth);
    end;

    if Flat
      then FInplaceEditorButtonWidth := FlatButtonWidth
      else FInplaceEditorButtonWidth := GetSystemMetrics(SM_CXVSCROLL);

    if (Column <> nil) and Column.STFilter.DropDownButtonVisible then
      Dec(FilterRect.Right, FInplaceEditorButtonWidth + FlatLineWidth);

    Canvas.Font := Font;
    Canvas.Font.Color := clBlue;
    Canvas.Brush.Color := ApproximateColor(clWindow, FixedColor, 8); //FixedColor;

    ABackground := Canvas.Brush.Color;
    CellMultiSelected := CellIsMultiSelected(ACol, ARow , DataCol, NilBookmarkEh);
    Highlighted := HighlightNoDataCellColor(ACol, ARow, DataCol, DataRow, CellType, AState,
      CellMultiSelected, ABackground, Canvas.Font);
    Canvas.Brush.Color := ABackground;

    if FilterRect.Right > FilterRect.Left then
      WriteTextEh(Canvas, FilterRect, True, 1, 1, GetFilterValue(DataCol),
        taLeftJustify, Column.Layout, False, False, 0, 0, False);

    FilterRect := Rect(FilterRect.Left, FilterRect.Top, FilterRect.Right, FilterRect.Bottom);

    Canvas.Pen.Color := Canvas.Brush.Color;

    if (Column <> nil) and Column.STFilter.DropDownButtonVisible then
    begin
      if csDesigning in ComponentState then
        EditButtonTransparency := 30
      else if FilterEditMode then
        EditButtonTransparency := 0
      else if gdHotTrack in AState then
        EditButtonTransparency := 30
      else
        EditButtonTransparency := 80;

      if FlatLineWidth > 0 then
      begin
        if FilterRect.Right > FilterRect.Left then
          Canvas.Rectangle(FilterRect.Right, FilterRect.Top, FilterRect.Right + 1, FilterRect.Bottom);
        Inc(FilterRect.Right);
      end;
      FilterRect := Rect(FilterRect.Right, FilterRect.Top, FilterRect.Right
        + FInplaceEditorButtonWidth, FilterRect.Top + FInplaceEditorButtonHeight);
      if Flat then
        Dec(FilterRect.Left);
      PaintInplaceButton(Column, Canvas, ebsDropDownEh, FilterRect,  ARect,
        0, False, Flat, DataLink.Active, Canvas.Brush.Color, nil, EditButtonTransparency);
      if FilterRect.Bottom < ARect.Bottom then
        Canvas.FillRect(Rect(FilterRect.Left, FilterRect.Bottom, FilterRect.Right, ARect.Bottom ));
//      PaintButtonControlEh(Canvas.Handle, FilterRect, Canvas.Brush.Color,
//        bcsDropDownEh, 0, Flat, False, True, cbUnchecked);
    end;
  end else
  begin
    if CellType.HorzType = hctIndicatorEh
      then ABackground := FixedColor
      else ABackground := Columns[DataCol].Title.Color;
    CellMultiSelected := CellIsMultiSelected(ACol, ARow , DataCol, NilBookmarkEh);
    Highlighted := HighlightNoDataCellColor(ACol, ARow, DataCol, DataRow, CellType, AState,
      CellMultiSelected, ABackground, Canvas.Font);
    Canvas.Brush.Color := ABackground;
    if not DrawTitleByThemes then
      Canvas.FillRect(ARect);
  end;
end;

function TCustomDBGridEh.CellHave3DRect(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState): Boolean;
var
  Column: TColumnEh;
begin
  Dec(ARow, TopDataOffset);
  Dec(ACol, IndicatorOffset);

  Result := (gdFixed in AState) and (dghFixed3D in OptionsEh) and
    ((ACol < 0) or (ARow < 0));
  if not Result then
    Result := Result or ((dghFooter3D in OptionsEh) and
      (FooterRowCount > 0) and (ARow > RowCount - TopDataOffset - 1));
  if not Result then
    Result := Result or ((dghData3D in OptionsEh) and not (gdFixed in AState)
      and not ((FooterRowCount > 0) and (ARow > RowCount - TopDataOffset - 1)));
  if not Result then
//    Result := Result or ((dghFrozen3D in OptionsEh) and (gdFixed in AState) and (ACol >= 0) and (ARow >= 0));
    Result := Result or ((dghFrozen3D in OptionsEh)
      and (ACol >= 0) and (ARow >= 0) and (ACol < FrozenCols) and (ARow < RowCount));

  if (ACol >= 0) and (ACol < Columns.Count)
    then Column := Columns[ACol]
    else Column := nil;
  if STFilter.Visible and CanFilterCol(ACol) and (STFilter.Location = stflUnderTitleFilterEh) and 
     Column.STFilter.Visible and
     (ARow = -1)
  then
    Result := False;
end;

procedure TCustomDBGridEh.DrawRowIndicator(ACol, ARow: Longint; ARect: TRect;
  XOffset, YOffset: Integer; IndicatorType: TDBGridEhRowIndicatorTypeEh);
const
  RowIndicatorIndex: array[TDBGridEhRowIndicatorTypeEh] of Integer =
    (0, 5, 1, 2, 6);
var
  IndicatorIndex: Integer;
  FromColor, ToColor: TColor;
begin
  if ThemesEnabled then
  begin
    case IndicatorType of
      giNormalArrowEh, giSelectedArrowEh, giInplaceSearch:
        begin
          if IndicatorType = giNormalArrowEh then
          begin
            FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
            ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
          end else if IndicatorType = giSelectedArrowEh then
          begin
            FromColor := ApproachToColorEh(clWhite, clBlack, 7);
            ToColor := ApproachToColorEh(clWhite, clWhite, 0);
          end else
          begin
            FromColor := ApproachToColorEh(DBGridEhInplaceSearchColor, clBlack, 0);
            ToColor := ApproachToColorEh(DBGridEhInplaceSearchColor, clWhite, 0);
          end;
          FillGradientEh(Canvas,
            Point((ARect.Right + ARect.Left - DBGridEhIndicators.Width) div 2 + XOffset,
            (ARect.Top + ARect.Bottom - DBGridEhIndicators.Height) div 2 + YOffset),
            [Point(0,0), Point(1,0),
             Point(0,1), Point(2,1),
             Point(0,2), Point(3,2),
             Point(0,3), Point(4,3),
             Point(0,4), Point(5,4),
             Point(0,5), Point(6,5),
             Point(0,6), Point(5,6),
             Point(0,7), Point(4,7),
             Point(0,8), Point(3,8),
             Point(0,9), Point(2,9),
             Point(0,10), Point(0,11)
            ],
            FromColor, ToColor);
        end;
      giEditEh:
        begin
          IndicatorIndex := RowIndicatorIndex[IndicatorType];
          DBGridEhIndicators.Draw(Canvas,
            (ARect.Right + ARect.Left - DBGridEhIndicators.Width) shr 1 + XOffset,
            (ARect.Top + ARect.Bottom - DBGridEhIndicators.Height) shr 1 + YOffset, IndicatorIndex);
        end;
      giInsertEh:
        begin
          IndicatorIndex := RowIndicatorIndex[IndicatorType];
          DBGridEhIndicators.Draw(Canvas,
            (ARect.Right + ARect.Left - DBGridEhIndicators.Width) shr 1 + XOffset,
            (ARect.Top + ARect.Bottom - DBGridEhIndicators.Height) shr 1 + YOffset, IndicatorIndex);
        end;
    end
  end else
  begin
    IndicatorIndex := RowIndicatorIndex[IndicatorType];
    DBGridEhIndicators.Draw(Canvas,
      (ARect.Right + ARect.Left - DBGridEhIndicators.Width) shr 1 + XOffset,
      (ARect.Top + ARect.Bottom - DBGridEhIndicators.Height) shr 1 + YOffset, IndicatorIndex);
  end;
end;

procedure TCustomDBGridEh.DrawIndicatorDropDownSign(ACol, ARow: Longint;
  ARect: TRect; Selected: Boolean);
var
  FromColor, ToColor: TColor;
begin
  if ThemesEnabled then
  begin
    if not Selected then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clWhite, clBlack, 7);
      ToColor := ApproachToColorEh(clWhite, clWhite, 0);
    end;
    FillGradientEh(Canvas,
      Point((ARect.Right + ARect.Left - 7) shr 1 + 1,
      (ARect.Top + ARect.Bottom - 7) shr 1),
      [Point(0,0), Point(7,0),
       Point(1,1), Point(6,1),
       Point(2,2), Point(5,2),
       Point(3,3), Point(4,3)
      ],
      FromColor, ToColor);
  end else
  begin
    DBGridEhSortMarkerImages.Draw(Canvas,
      (ARect.Left + ARect.Right - DBGridEhSortMarkerImages.Width) shr 1,
      (ARect.Top + ARect.Bottom - DBGridEhSortMarkerImages.Height) shr 1, 2);
  end;
end;

procedure TCustomDBGridEh.DrawFilterSign(ARect: TRect; Selected: Boolean);
var
  FromColor, ToColor: TColor;
begin
  begin
    if not Selected then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clWhite, clBlack, 7);
      ToColor := ApproachToColorEh(clWhite, clWhite, 0);
    end;
    FillGradientEh(Canvas,
      Point((ARect.Right + ARect.Left - 6) div 2 + 1,
      (ARect.Top + ARect.Bottom - 6) div 2),
      [Point(0,0), Point(5,0),
       Point(1,1), Point(4,1),
       Point(2,2), Point(3,2),
       Point(2,3), Point(3,3),
       Point(2,4), Point(3,4),
       Point(3,5), Point(3,5)
      ],
      FromColor, ToColor);
  end;
end;

procedure TCustomDBGridEh.DrawGraphicCell(Column: TColumnEh; ARect: TRect;
  Background: TColor);
var
  Size: TSize;
  R: TRect;
  S: string;
  DrawPict: TPicture;
  Pal: HPalette;
  Stretch: Boolean;
  Center: Boolean;
  XRatio, YRatio: Double;
//  InsideRect: TRect;
//  RectRgn: HRGN;
begin
  with Canvas do
  begin
    if DrawGraphicData then
    begin
      DrawPict := TPicture.Create;
      Pal := 0;
      try
        if Assigned(Column.Field) and Column.Field.IsBlob then
        begin
          DrawPict.Assign(Column.Field);
          if DrawPict.Graphic is TBitmap then
            DrawPict.Bitmap.IgnorePalette := True;
        end;
        Stretch := (DrawPict.Width > (ARect.Right-Arect.Left))
          or (DrawPict.Height > (ARect.Bottom-Arect.Top));
        Center := True;
        if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
          FillRect(ARect)
        else if Stretch then
        begin
          XRatio := DrawPict.Width / (ARect.Right-Arect.Left);
          YRatio := DrawPict.Height / (ARect.Bottom-Arect.Top);
          R := ARect;
          if XRatio > YRatio then
          begin
//            InsideRect.Right := ARect.Right;
            R.Bottom := Arect.Top + Round(DrawPict.Height / XRatio);
          end else
          begin
            R.Right := ARect.Left + Round(DrawPict.Width / YRatio);
//            InsideRect.Bottom := Arect.Bottom;
          end;
//          StretchDraw(InsideRect, DrawPict.Graphic);
        end else
        begin
          SetRect(R, ARect.Left, Arect.Top,
            ARect.Left + DrawPict.Width, Arect.Top + DrawPict.Height);
        end;

        if Center then OffsetRect(R,
          (ARect.Right - Arect.Left - (R.Right-R.Left)) div 2,
          (ARect.Bottom - Arect.Top - (R.Bottom-R.Top)) div 2);
        FillRect(ARect);
        StretchDraw(R, DrawPict.Graphic);
//        RectRgn := ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
//        SelectClipRgn(Handle, 0);
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;
    end else
    begin
      Font := Self.Font;
      if Column.Field <> nil
        then S := Column.Field.DisplayText
        else S := '';
      Size := TextExtent(S);
      R := ARect;
      TextRect(R, (R.Left + R.Right - Size.cx) div 2,
        (R.Top + R.Bottom - Size.cy) div 2, S);
    end;
  end;
end;

procedure TCustomDBGridEh.GetDatasetFieldList(FieldList: TList);
var i: Integer;
begin
  if Assigned(DataSource) and Assigned(Datasource.Dataset) then
    for i := 0 to Datasource.Dataset.FieldCount - 1 do
      FieldList.Add(Datasource.Dataset.Fields[i]);
end;

function TCustomDBGridEh.CreateScrollBar(AKind: TScrollBarKind): TDBGridEhScrollBar;
begin
  if AKind = sbVertical
    then Result := TVertDBGridEhScrollBar.Create(Self, AKind)
    else Result := THorzDBGridEhScrollBar.Create(Self, AKind);
end;

function TCustomDBGridEh.GetTopDataOffset: Byte;
begin
  Result := GetTitleRows + GetSubTitleRows;
end;

function TCustomDBGridEh.GetTitleRows: Integer;
begin
  if dgTitles in Options
    then Result := 1
    else Result := 0;
end;

function TCustomDBGridEh.GetSubTitleRows: Integer;
begin
  Result := 0;
  if (STFilter <> nil) and STFilter.Visible and (STFilter.Location = stflUnderTitleFilterEh) then
    Inc(Result); 
end;

procedure TCustomDBGridEh.InvalidateGridRect(ARect: TGridRect);
var
  InvalidRect: TRect;
begin
  if not HandleAllocated then Exit;
  InvalidRect := BoxRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  WindowsInvalidateRect(Handle, InvalidRect, False);
end;

function TCustomDBGridEh.IsSelectionActive: Boolean;
var
  FocusedWin: THandle;
begin
  FocusedWin := GetFocus;
  Result := (HandleAllocated and (Handle = FocusedWin))
         or ((InplaceEditor <> nil) and (InplaceEditor.Handle = FocusedWin));
end;

procedure TCustomDBGridEh.SelectionActiveChanged;
begin
  if Selection.SelectionType <> gstNon then
  begin
    if Selection.SelectionType = gstAll
      then Invalidate
      else InvalidateGridRect(Selection.SelectionToGridRect);
  end;
  GridInvalidateRow(Self, Row);
  FSelectionActive := IsSelectionActive;
end;

procedure TCustomDBGridEh.SetStyle(const Value: TDBGridEhStyle);
begin
  if FStyle = Value then Exit;
  if FStyle <> nil then
    FStyle.RemoveChangeNotification(Self);
  FStyle := Value;
  if Value <> nil
    then FStyle.AddChangeNotification(Self)
    else RegetDefaultStyle;
end;

procedure TCustomDBGridEh.SetCenter(const Value: TDBGridEhCenter);
begin
  if FCenter = Value then Exit;
  if FCenter <> nil then
    FCenter.RemoveChangeNotification(Self);
  FCenter := Value;
  if Value <> nil then
    FCenter.AddChangeNotification(Self);
end;

procedure TCustomDBGridEh.StyleEhChanged;
begin
  LayoutChanged;
end;

procedure TCustomDBGridEh.RegetDefaultStyle;
begin
  if FStyle = DBGridEhDefaultStyle then Exit;
  FStyle := DBGridEhDefaultStyle;
  if FStyle <> nil
    then FStyle.AddChangeNotification(Self)
    else StyleEhChanged;
end;

function TCustomDBGridEh.CellIsMultiSelected(ACol, ARow: Integer;
  DataCol: Integer; DataRowBkmrk: TUniBookmarkEh): Boolean;
var
  ADataRect: TGridRect;
begin
  if (Selection.SelectionType = gstAll) then
    Result := True
  else
  begin
    Result := False;
    ADataRect := DataBox;
    if ACol < ADataRect.Left then
    begin // Indicator
      if (ARow >= ADataRect.Top) and (ARow <= ADataRect.Bottom)
        then Result := (Selection.SelectionType =  gstRecordBookmarks) and
                       (Selection.Rows.IndexOf(DataRowBkmrk) >= 0);
    end else if (ARow >= ADataRect.Top) and (ARow <= ADataRect.Bottom) then // Data
      Result := Selection.DataCellSelected(DataCol, DataRowBkmrk)
    else  // Title or footer
      Result := (Selection.SelectionType = gstColumns) and
                (Selection.Columns.IndexOf(Columns[DataCol]) >= 0);
  end;
end;

function TCustomDBGridEh.GetCellAreaType(ACol, ARow: Integer;
  var AreaCol, AreaRow: Integer): TCellAreaTypeEh;
var
  ADataRect: TGridRect;
begin
  ADataRect := DataBox;
  AreaCol := ACol;
  AreaRow := ARow;
  if ACol < ADataRect.Left then
    Result.HorzType := hctIndicatorEh
  else
  begin
    Dec(AreaCol, IndicatorOffset);
    Result.HorzType := hctDataEh;
  end;

  if (ARow < GetTitleRows) then
    Result.VertType := vctTitleEh
  else if (ARow < GetTitleRows + GetSubTitleRows) then
  begin
    Result.VertType := vctSubTitleEh;
    Dec(AreaRow, GetTitleRows);
  end else if (ARow >= ADataRect.Top) and (ARow <= ADataRect.Bottom) then
  begin
    Result.VertType := vctDataEh;
    Dec(AreaRow, TopDataOffset);
  end else if (ARow = ADataRect.Bottom + 1) then // We have footer row, it above footer row
  begin
    Result.VertType := vctFooterEh;//vctAboveFooterEh;
    AreaRow := 0;
  end else if (ARow > ADataRect.Bottom + 1) then // We have footer row, footer row
  begin
    Result.VertType := vctFooterEh;
    Dec(AreaRow, ADataRect.Bottom + 1);
  end else
    raise Exception.Create('Algorithm error in TCustomDBGridEh.GetCellType');
end;

procedure TCustomDBGridEh.DefaultApplySorting;
begin
  Center.ApplySorting(Self);
end;

procedure TCustomDBGridEh.DoExit;
begin
  try
    if FDatalink.Active then
      with FDatalink.Dataset do
        if (dgCancelOnExit in Options) and (State = dsInsert) and
          not Modified and not FDatalink.FModified then
          Cancel else
          FDataLink.UpdateData;
  except
    SetFocus;
    raise;
  end;
  inherited DoExit;
end;

// MemTable Supporting

function TCustomDBGridEh.MemTableSupport: Boolean;
begin
  Result := (FIntMemTable <> nil);
end;

function TCustomDBGridEh.ViewScroll: Boolean;
begin
  Result := MemTableSupport {and (FooterRowCount = 0)};
end;

function TCustomDBGridEh.ExtendedScrolling: Boolean;
begin
  Result := MemTableSupport and
            Assigned(Center) and
            Center.UseExtendedScrollingForMemTable;
end;


procedure TCustomDBGridEh.CheckIMemTable;
var
  OldIntMemTable: IMemTableEh;
begin
  OldIntMemTable := FIntMemTable;
  if FTryUseMemTableInt and (FDataLink <> nil) and FDataLink.Active and
    (FDataLink.DataSet <> nil) and not (csDestroying in FDataLink.DataSet.ComponentState) {and (FooterRowCount = 0)}
    then Supports(FDataLink.DataSet, IMemTableEh, FIntMemTable)
    else FIntMemTable := nil;
  if OldIntMemTable <> FIntMemTable then
  begin
{ TODO : Here is code because of which raise list out of bounds in RemoveNotification in Delphi 5}
//    if (FIntMemTable <> nil) and (FDataLink.DataSet <> nil) then
//      FDataLink.DataSet.FreeNotification(Self);

    if FIntMemTable <> nil then
      FIntMemTable.RegisterEventReceiver(Self);
    if OldIntMemTable <> nil then
      OldIntMemTable.UnregisterEventReceiver(Self);
//    LayoutChanged;
  end;
end;

procedure TCustomDBGridEh.MTUpdateRowCount;

  procedure ResetFixedRows;
  var
    i: Integer;
  begin
    if FixedRows > TopDataOffset then
    begin
      for i := TopDataOffset to FixedRows-1  do
        DeleteRow(i);
    end else if FixedRows < TopDataOffset then
    begin
      for i := FixedRows to TopDataOffset-1 do
      begin
        RowCount := RowCount + 1;
        MoveRow(RowCount-1, i);
      end;
    end;
    FixedRows := TopDataOffset;
  end;

  procedure SetRowCount(NewRowCount: Longint);
  begin
    if NewRowCount <= Row then
      MoveColRow(Col, NewRowCount - 1, False, False, False);
    RowCount := NewRowCount;
  end;

  procedure UpdateFooterRowHeights;
  var
    i: Integer;
  begin
    for i := 0 to FooterRowCount - 1 do
      RowHeights[RowCount+i] := FStdDefaultRowHeight;
  end;

var
 NewRowCount: Integer;
 NewCol, NewRow: Integer;
 t: Integer;
 ShowCol: Boolean;
begin
  if FDataLink = nil then Exit;

  if RowCount <= TopDataOffset then
    SetRowCount(TopDataOffset + 1);
  ResetFixedRows;
  FOldTopLeft.X := LeftCol;
  FOldTopLeft.Y := TopRow;
  if dgTitles in Options then
    RowHeights[0] := FTitleRowHeight;
  if GetSubTitleRows > 0 then
    RowHeights[GetTitleRows] := FStdDefaultRowHeight;

  ContraRowCount := FooterRowCount;
  if FooterRowCount > 0 then
    UpdateFooterRowHeights;

{ TODO : Check this comment }
  if MemTableSupport and FIntMemTable.MemTableIsTreeList then
  begin
    t := RowHeights[0];
    DefaultRowHeight := FStdDefaultRowHeight;
    if dgTitles in Options then RowHeights[0] := t;

{ Do it in MTViewDataEvent }

    if (FIntMemTable <> nil) and FDataLink.Active
      then NewRowCount := FIntMemTable.InstantReadRowCount
      else NewRowCount := 0;
    if NewRowCount <= 0 then NewRowCount := 1;
    SetRowCount(NewRowCount + TopDataOffset);
  end;

  if not HandleAllocated then Exit;
  MTUpdateTopRow;
  if (FColWidthsChanged = True) and (FIntMemTable <> nil) and
    FDataLink.Active and (DataRowCount = InstantReadRecordCount) then
  begin
    UpdateAllDataRowHeights();
    FColWidthsChanged := False;
  end;

  if  (FIntMemTable <> nil) and
       DataLink.Active and
       not DataGrouping.IsGroupingWorks and
      (Row - TopDataOffset <> FIntMemTable.InstantReadCurRowNum) then
  begin
    GridInvalidateRow(Self, Row);

    if FIntMemTable.InstantReadCurRowNum = -1
      then NewRow := FixedRows
      else NewRow := FIntMemTable.InstantReadCurRowNum + TopDataOffset;
    if NewRow >= RowCount then
      NewRow := FixedRows;

    ShowCol := not FLockAutoShowCurCell and not RowPanel.Active;
    if Col < FixedCols then
    begin
      NewCol := Col;
      MoveColRow(FixedCols, NewRow, False, ShowCol, True);
      MoveColRow(NewCol, NewRow, False, False, False);
    end else
      MoveColRow(Col, NewRow, False, ShowCol, True);
    if RowPanel.Active then
      ClampInViewRowPanelCell(SelectedIndex);

    GridInvalidateRow(Self, Row);
  end;

  FetchRecordsInView;

  Invalidate;
end;

procedure TCustomDBGridEh.MTScroll(Distance: Integer);
var
  NewRow, NewCol, OldTopRow, OldRecRow: Integer;
  Field: TField;
  ShowCol: Boolean;
begin
  if not FInplaceSearchingInProcess then
    StopInplaceSearch;
  if FDataLink = nil then Exit;

  if FDataLink.Active and DataGrouping.IsGroupingWorks then
  begin
    if Distance <> 0 then
    begin
      NewRow := DataGrouping.GroupDataTree.IndexOfVisibleRecordViewNo(FIntMemTable.InstantReadCurRowNum);
      if NewRow > -1 then
        InvalidateRow(NewRow + TopDataOffset);
      OldRecRow := DataGrouping.GroupDataTree.IndexOfVisibleRecordViewNo(FIntMemTable.InstantReadCurRowNum-Distance);
      if OldRecRow > -1 then
        InvalidateRow(OldRecRow + TopDataOffset);
    end;
    if FInternalUpdatingDatasetPos then Exit;
    FInternalUpdatingDatasetPos := True;
    try
      DataGroupsGotoRecordViewNo(FIntMemTable.InstantReadCurRowNum, False);
    finally
      FInternalUpdatingDatasetPos := False;
    end;
  end else if (FIntMemTable <> nil) and FDataLink.Active then
  begin
    GridInvalidateRow(Self, Row);
    if FDatalink.Active and HandleAllocated and not (csLoading in ComponentState) then
    begin
      OldTopRow := TopRow;
      NewRow := FIntMemTable.InstantReadCurRowNum + TopDataOffset;
      if NewRow >= RowCount then
        NewRow := FixedRows;
      if Row <> NewRow then
      begin
        if not (dgAlwaysShowEditor in Options) then HideEditor;
        ShowCol := not FLockAutoShowCurCell and not RowPanel.Active;
        if (not FLockAutoShowCurCell) and (Col < FixedCols) then
        begin
          NewCol := Col;
          MoveColRow(FixedCols, NewRow, False, ShowCol, True);
          MoveColRow(NewCol, NewRow, False, False, False);
        end else
          MoveColRow(Col, NewRow, False, ShowCol, True);
        if RowPanel.Active then
          ClampInViewRowPanelCell(SelectedIndex);
        InvalidateEditor;
        GridInvalidateRow(Self, NewRow);
      end;
//      Columns[SelectedIndex].Field := nil; //Some time AV BUG
      if InplaceEditorVisible then
      begin
        Field := SelectedField;
        if Assigned(Field) and (Field.Text <> FEditText) then
          InvalidateEditor;
      end;
      if HaveHideDuplicates and (OldTopRow <> TopRow) then
      begin
        GridInvalidateRow(Self, TopRow);
        GridInvalidateRow(Self, OldTopRow);
      end;
    end;
  end;
  InvalidateFooter;
  UpdateScrollBar;
end;

procedure TCustomDBGridEh.FetchRecordsInView;
var
 DrawInfo: TGridDrawInfoEh;
begin
  if FFetchingRecords or not HandleAllocated then Exit;
  FFetchingRecords := True;
  try
    if FIntMemTable <> nil then
    begin
      CalcDrawInfo(DrawInfo);
      with DrawInfo.Vert do
        if GridBoundary < GridExtent then
          FIntMemTable.FetchRecords((GridExtent - GridBoundary) div FStdDefaultRowHeight + 1)
        else if (GridBoundary >= GridExtent) and (LastFullVisibleCell + 1 = RowCount) then
          FIntMemTable.FetchRecords(1);
    end;
  finally
    FFetchingRecords := False;
  end;
end;

procedure TCustomDBGridEh.InstantReadRecordEnter(DataRowNum: Integer);
begin
  if ViewScroll then
  begin
    if DataGrouping.IsGroupingWorks and (DataGrouping.GroupDataTree.FlatVisibleCount > 0) then
    begin
      FDrawGroupDataNode := DataGrouping.GroupDataTree.FlatVisibleItem[DataRowNum];
      if FDrawGroupDataNode.NodeType = dntDataSetRecordEh then
      begin
        FOldActiveRecord := FIntMemTable.InstantReadCurRowNum;
        FIntMemTable.InstantReadEnter(FDrawGroupDataNode.DataSetRecordViewNo);
      end;
    end else
    begin
      FOldActiveRecord := FIntMemTable.InstantReadCurRowNum;
      FIntMemTable.InstantReadEnter(DataRowNum);
    end;
  end else
  begin
    FOldActiveRecord := DataLink.ActiveRecord;
    DataLink.ActiveRecord := DataRowNum;
  end;
end;

procedure TCustomDBGridEh.InstantReadRecordLeave;
begin
  if ViewScroll then
  begin
    if DataGrouping.IsGroupingWorks and (DataGrouping.GroupDataTree.FlatVisibleCount > 0) then
    begin
      if FDrawGroupDataNode.NodeType = dntDataSetRecordEh then
        FIntMemTable.InstantReadLeave;
      FDrawGroupDataNode := nil;
    end else
      FIntMemTable.InstantReadLeave;
  end else
    DataLink.ActiveRecord := FOldActiveRecord;
  FOldActiveRecord := -1;
end;

function TCustomDBGridEh.InstantReadRecordCount: Integer;
begin
  if MemTableSupport then
    if DataGrouping.IsGroupingWorks
      then Result := DataGrouping.GroupDataTree.FlatVisibleCount
      else Result := FIntMemTable.InstantReadRowCount
  else
    Result := DataLink.RecordCount;
end;

function TCustomDBGridEh.IsCurrentRow(DataRowNum: Integer): Boolean;
var
  ADrawGroupDataNode: TGroupDataTreeNodeEh;
begin
  if ViewScroll then
    if DataGrouping.IsGroupingWorks and (DataGrouping.GroupDataTree.FlatVisibleCount > 0) then
    begin
      ADrawGroupDataNode := DataGrouping.GroupDataTree.FlatVisibleItem[DataRowNum];
      Result := (ADrawGroupDataNode.NodeType = dntDataSetRecordEh) and
                (ADrawGroupDataNode.DataSetRecordViewNo = FIntMemTable.InstantReadCurRowNum);
    end else
      Result := FIntMemTable.InstantReadCurRowNum = DataRowNum
  else
    Result := DataLink.ActiveRecord = DataRowNum;
end;

procedure TCustomDBGridEh.MTUpdateVertScrollBar;
var
  DrawInfo: TGridDrawInfoEh;
  SIOld, SINew: TScrollInfo;
  MaxTopLeft: TGridCoord; 
  SINewMax: Integer;
begin
  if VertScrollBar.SmoothStep then
    Exit; // Inherited methods will do all need.
  CalcDrawInfo(DrawInfo);
  SIOld.cbSize := sizeof(SIOld);
  SIOld.fMask := SIF_ALL;
  if VertScrollBar.VisibleMode = sbAlwaysShowEh then
    SIOld.fMask := SIOld.fMask or SIF_DISABLENOSCROLL;
  GetScrollInfo(Self.Handle, SB_VERT, SIOld);
  SINew := SIOld;
  SINew.nMin := 1;
  SINewMax := 1;
  if dghAutoFitRowHeight in OptionsEh then
  begin
    SINew.nPage := 0;
    MaxTopLeft.X := ColCount - 1;
    MaxTopLeft.Y := RowCount - 1;
    MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
    SINew.nMax := RowCount - FixedRows - (RowCount - MaxTopLeft.Y - 1);
  end else
  begin
    SINew.nPage := DrawInfo.Vert.LastFullVisibleCell - TopRow + 1;
    SINew.nMax := RowCount - FixedRows;
  end;

  SINew.nPos := TopRow - FixedRows + 1;

  if not VertScrollBar.Visible or (VertScrollBar.ExtScrollBar <> nil) then
  begin
    SINewMax := SINew.nMax;
    SINew.nMax := SINew.nMin;
  end;

  if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
    (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) or
    (FVertScrollBarVisibleMode <> VertScrollBar.VisibleMode)
  then
  begin
    if (VertScrollBar.VisibleMode = sbAlwaysShowEh) and (VertScrollBar.ExtScrollBar = nil) then
    begin
      if (SINew.nMax <= SINew.nMin) or (UINT(SINew.nMax - SINew.nMin) <= SINew.nPage) then
      begin
        EnableScrollBar(Handle, SB_VERT, ESB_DISABLE_BOTH);
      end;
      ShowScrollBar(Handle, SB_VERT, True);
    end else if FVertScrollBarVisibleMode <> VertScrollBar.VisibleMode then
    //if not (VertScrollBar.VisibleMode = sbAlwaysShowEh) then
    begin
      FVertScrollBarVisibleMode := VertScrollBar.VisibleMode;
      if (SINew.nMax <= SINew.nMin) or (UINT(SINew.nMax - SINew.nMin) <= SINew.nPage) then
      begin
        EnableScrollBar(Handle, SB_VERT, ESB_ENABLE_BOTH);
        ShowScrollBar(Handle, SB_VERT, False);
      end;
    end;
    SetScrollInfo(Self.Handle, SB_VERT, SINew, True);
    FVertScrollBarVisibleMode := VertScrollBar.VisibleMode;
  end;

  if VertScrollBar.ExtScrollBar <> nil then
    with VertScrollBar.ExtScrollBar do
    begin
      PageSize := 0;
      if SINewMax < SINew.nMin then
        SINew.nMin := SINewMax;
      SetParams(SINew.nPos, SINew.nMin, SINewMax);
      PageSize := SINew.nPage;
    end;

{  if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
    (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    SetScrollInfo(Self.Handle, SB_VERT, SINew, True);}
end;

function TCustomDBGridEh.SafeMoveTop(ATop: Integer; CheckOnly: Boolean = False): Integer;
var
  MaxTopLeft: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
  OldTopRow: Integer;
begin
  CalcDrawInfo(DrawInfo);
  Result := ATop;
  if Result < FixedRows then Result := FixedRows
  else if Result > RowCount-1 then Result := RowCount-1;

  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);

  if MaxTopLeft.Y < Result then
  Result := MaxTopLeft.Y;

  OldTopRow := TopRow;
  if not CheckOnly and (TopRow <> Result) then
  begin
    TopRow := Result;
    MTUpdateVertScrollBar;
    if HaveHideDuplicates then
    begin
      GridInvalidateRow(Self, TopRow);
      GridInvalidateRow(Self, OldTopRow);
    end;
  end;
end;

procedure TCustomDBGridEh.MTWMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
  DrawInfo: TGridDrawInfoEh;

  function PageUp: Longint;
  var
    MaxTopLeft, TopLeft: TGridCoord;
  begin
    TopLeft.X := LeftCol;
    TopLeft.Y := TopRow;
    MaxTopLeft := CalcMaxTopLeft(TopLeft, DrawInfo);
      Result := TopRow - MaxTopLeft.Y;
    if Result < 1 then Result := 1;
  end;

  function PageDown: Longint;
  begin
    with DrawInfo do
      Result := Vert.LastFullVisibleCell - TopRow;
    if Result < 1 then Result := 1;
  end;

begin
  CalcDrawInfo(DrawInfo);
  if FDatalink.Active then
    with Message, FDataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: SafeMoveTop(TopRow - 1);
        SB_LINEDOWN: SafeMoveTop(TopRow + 1);
        SB_PAGEUP: SafeMoveTop(TopRow - PageUp);
        SB_PAGEDOWN: SafeMoveTop(TopRow + PageDown);
        SB_THUMBPOSITION ,SB_THUMBTRACK:
          if VertScrollBar.Tracking or (ScrollCode = SB_THUMBPOSITION) then
          begin
            SI.cbSize := sizeof(SI);
            SI.fMask := SIF_ALL;
            VertScrollBar.GetScrollInfo(SI);
            SafeMoveTop(SI.nTrackPos + FixedRows - 1);
          end;
        SB_BOTTOM: SafeMoveTop(RowCount);
        SB_TOP: SafeMoveTop(FixedRows);
      end;
  MTUpdateVertScrollBar;
end;

procedure TCustomDBGridEh.MTUpdateTopRow;
var
  MaxTopLeft, TopLeft: TGridCoord;
  DrawInfo: TGridDrawInfoEh;
begin
  CalcDrawInfo(DrawInfo);
  TopLeft.X := ColCount-1;
  TopLeft.Y := RowCount-1;
  MaxTopLeft := CalcMaxTopLeft(TopLeft, DrawInfo);
  if TopRow > MaxTopLeft.Y then
    TopRow := MaxTopLeft.Y;
end;

//\\ MemTable Supporting

{ Subtitle filter }

function TCustomDBGridEh.CreateFilterEditor: TCustomDBEditEh;
begin
  Result := TInplaceFilterEditEh.Create(Self);
end;

procedure TCustomDBGridEh.SetSTFilter(const Value: TSTDBGridEhFilter);
begin
  FSTFilter.Assign(Value);
end;

function TCustomDBGridEh.CanFilterCol(DCol: Longint): Boolean;
var
  Column: TColumnEh;
//  DCol: Integer;
begin
//  DCol := RawToDataColumn(ACol);
  if (DCol >= 0) and (DCol < Columns.Count) then
    Column := Columns[DCol]
  else
    Column := nil;
  Result := (Column <> nil) and Column.Visible and
    Column.STFilter.Visible and (STFilter.Location = stflUnderTitleFilterEh);
end;

function TCustomDBGridEh.GetFilterValue(DCol: Longint): String;
begin
  Result := '';
  if (DCol < 0) or (DCol >= Columns.Count) then
    Exit;
  if Columns[DCol].FieldName <> '' then
    Result := Columns[DCol].STFilter.ExpressionStr
end;

procedure TCustomDBGridEh.SetFilterEditMode(const Value: Boolean);
begin
  if Value
    then StartEditFilter(RawToDataColumn(Col))
    else StopEditFilter;
end;

type
  TCustomDBEditEhCracker = class(TCustomDBEditEh);

procedure TCustomDBGridEh.StartEditFilter(DCol: Longint);
var
  AOldEditCol: Integer;
  DrawInfo: TGridDrawInfoEh{Eh};
  Coord: TGridCoord;
  ACol{, AOldFilterCol}: Longint;
begin
  if not STFilter.Visible or not CanFilterCol(DCol) or (STFilter.Location <> stflUnderTitleFilterEh) then
    Exit;
  if FDataLink.Active then
    FDataLink.DataSet.CheckBrowseMode;
  if not Assigned(FilterEdit) then
  begin
    FFilterEdit := CreateFilterEditor; // TInplaceFilterEditEh.Create(Self);
    with FFilterEdit do
    begin
//    FilterEdit.FGrid := Self;
      Visible := False;
      Parent := {Parent;//} Self;
      IInplaceEditEh(FFilterEdit).SetInplaceEditHolder(Self);
      IInplaceEditEh(FFilterEdit).SetBorderStyle(bsNone);
      IInplaceEditEh(FFilterEdit).SetFont(Self.Font);
      IInplaceEditEh(FFilterEdit).GetFont.Color := clBlue;
      IInplaceEditEh(FFilterEdit).SetColor(ApproximateColor(clWindow, FixedColor, 8)); //FixedColor;
      IInplaceEditEh(FFilterEdit).SetOnKeyPress(OnFilterKeyPress);
      IInplaceEditEh(FFilterEdit).SetOnExit(FilterExit);
      Flat := Self.Flat;
      TPopupListboxEh(TInplaceFilterEditEh(FilterEdit).PopupListbox).UseItemObjects := True;
    end;
  end;

//  AOldFilterCol := -1;
  if (FFilterCol <> -1) and FilterEdit.Visible then
  begin
    //FOldEditCol := FFilterCol{ - IndicatorOffset};
//    AOldFilterCol := FFilterCol + IndicatorOffset;
    HideFilterEdit;
  end;

  FFilterCol := DCol;
  FFilterEditMode := True;
  HideEditor;

  BeginUpdate; { Prevent highlight flicker on tab to next/prior row }
  LockPaint;
  try
    if Columns[DCol].STFilter.Visible then
    begin
      AOldEditCol := FFilterCol;
//      StopEditFilter;
      ACol := DataToRawColumn(DCol);
      if (dgRowSelect in Options) then
      begin
        if (VisibleColCount + LeftCol <= ACol ) then
        begin
          CalcDrawInfo(DrawInfo);
          Coord.X := ACol;
          Coord.Y := Row;
          with DrawInfo, Coord do
          begin
            if (X > Horz.LastFullVisibleCell) or
              (Y > Vert.LastFullVisibleCell) or (X < LeftCol) or (Y < TopRow)
            then
              LeftCol := CalcMaxTopLeft(Coord, DrawInfo).X;
          end;
        end
        else if (ACol >= FixedCols) and (LeftCol > ACol) then
          LeftCol := ACol;
      end
      else
        //Col := ACol;
        MoveCol(DCol, 0, False);
      FFilterCol := AOldEditCol;
      InvalidateCell(FFilterCol+IndicatorOffset, TopDataOffset-1);
    end;
//    if AOldFilterCol > -1 then
//      InvalidateCell(AOldFilterCol, TopDataOffset-1);
    GridInvalidateRow(Self, TopDataOffset-1);
  finally
    UnlockPaint;
    EndUpdate;
  end;
  UpdateFilterEdit(True);
end;

procedure TCustomDBGridEh.OnFilterClosingUp(Sender: TObject; var Accept: Boolean);
var
  Listbox: TPopupListboxEh;
  ItemIndex{, i}: Integer;
  Item: TPopupListboxItemEh;
begin
  Columns[FFilterCol].STFilter.FPopupListboxDownIndex := -1;
  if (FFilterCol <> -1) and (FilterEdit <> nil) and FilterEdit.Visible then
  begin
    Columns[FFilterCol].STFilter.DropDownListWidth := TInplaceFilterEditEh(FilterEdit).DropDownBox.Width;
    Columns[FFilterCol].STFilter.DropDownListRows := TInplaceFilterEditEh(FilterEdit).DropDownBox.Rows;
  end;
  if not Accept then Exit;
  Listbox := TPopupListboxEh(TInplaceFilterEditEh(FilterEdit).PopupListbox);
  ItemIndex := Listbox.ItemIndex;
  Item := nil;
  if Listbox.ItemIndex >= 0 then
{$IFDEF EH_LIB_6}
    Item := TPopupListboxItemEh(Listbox.ExtItems.Objects[Listbox.ItemIndex]);
{$ELSE}
    Item := TPopupListboxItemEh(Listbox.Items.Objects[Listbox.ItemIndex]);
{$ENDIF}
  if Item <> nil then
  begin
    Item.Execute(Listbox, ItemIndex, Point(-1,-1), []);
    Accept := False;
  end;
  Columns[FFilterCol].STFilter.FEnterNotClearData := False;
end;

procedure TCustomDBGridEh.OnFilterCloseUp(Sender: TObject; Accept: Boolean);
begin
  if Center.FilterEditCloseUpApplyFilter and Accept then
    SetDataFilter;
end;

procedure TCustomDBGridEh.LoadInplaceFilterValues(ASTFilter: TSTColumnFilterEh;
  Items: TStrings; PopupListbox: TPopupListboxEh; var NewWidth: Integer);
var
  i, tw, mtw: Integer;
  Processed: Boolean;
begin

  if Assigned(FOnFillSTFilterListValues) then
    OnFillSTFilterListValues(Self, ASTFilter.Column, Items, Processed);
  if Assigned(ASTFilter.Column.FOnFillSTFilterListValues) then
    ASTFilter.Column.OnFillSTFilterListValues(Self, ASTFilter.Column, Items, Processed);
  if Assigned(Center.FOnFillSTFilterListValues) then
    Center.OnFillSTFilterListValues(Self, ASTFilter.Column, Items, Processed);
  if not Processed then
    DefaultFillSTFilterListValues(ASTFilter.Column, Items);

  mtw := NewWidth;
  for i := 0 to Items.Count - 1 do
  begin
    if (Items.Objects[i] <> nil) and
      not (Items.Objects[i] is TPopupListboxItemEhData) then
    begin
      PopupListbox.Canvas.Font := PopupListbox.Font;
      tw := PopupListbox.Canvas.TextWidth(Items[i]) +
        + DefaultCheckBoxWidth + 2 + GetSystemMetrics(SM_CXVSCROLL) + TPopupListboxEh(PopupListbox).BorderWidth*2 + 2;
      if mtw < tw then mtw := tw;
    end;
  end;
//    mtw := mtw + DefaultCheckBoxWidth + 2 + GetSystemMetrics(SM_CXVSCROLL) +
//      TPopupListboxEh(PopupListbox).BorderWidth*2 + 2;
  if mtw > NewWidth then
    NewWidth := mtw;

  ASTFilter.FPopupListboxDownIndex := -1;
  Items.BeginUpdate;
  try
    for i := 0 to Items.Count - 1 do
      if Items.Objects[i] = nil then
        Items.Objects[i] := PopupListboxItemEhData;
  finally
    Items.EndUpdate;
  end;

  SetLength(ASTFilter.FListValuesCheckingState, 0);
  SetLength(ASTFilter.FListValuesCheckingState, Items.Count);
end;

procedure TCustomDBGridEh.DefaultFillSTFilterListDataValues(Column: TColumnEh;
  Items: TStrings);
begin
  if Assigned(Center) then
    Center.DefaultFillSTFilterListDataValues(Self, Column, Items);
end;

procedure TCustomDBGridEh.DefaultFillSTFilterListCommandValues(Column: TColumnEh;
  Items: TStrings);
begin
  if Assigned(Center) then
    Center.DefaultFillSTFilterListCommandValues(Self, Column, Items);
end;

procedure TCustomDBGridEh.DefaultFillSTFilterListValues(Column: TColumnEh;
  Items: TStrings);
{var
  ASTFilter: TSTColumnFilterEh;
  TmpExpression: TSTFilterExpressionEh;
  Filter: String;
  i, k: Integer;}
begin
  DefaultFillSTFilterListCommandValues(Column, Items);
  DefaultFillSTFilterListDataValues(Column, Items);
{  Exit;

  ASTFilter := Column.STFilter;
  if Column.FieldValueList = nil then
    if ASTFilter.ListSource <> nil then
      Column.FieldValueList := ASTFilter.GetFieldValueList
    else if FIntMemTable <> nil then
    begin
      Column.FieldValueList := FIntMemTable.GetFieldValueList(Column.FieldName);
    end;

  Items.BeginUpdate;
  try
    if Column.FieldValueList <> nil then
    begin
      TmpExpression := ASTFilter.Expression;
      ASTFilter.FExpression.Operator1 := foNon;
      ASTFilter.FExpression.Relation := foNon;
      try
        Filter := GetExpressionAsFilterString(Self,
          GetOneExpressionAsLocalFilterString, nil, False, True);
      finally
        ASTFilter.FExpression.Operator1 := TmpExpression.Operator1;
        ASTFilter.FExpression.Relation := TmpExpression.Relation;
      end;
      Column.FieldValueList.SetFilter(Filter);

      Items.Assign(Column.FieldValueList.GetValues);
    end;

    if (Column.KeyList.Count > 0) and (Column.PickList.Count > 0) then
    begin
      for i := 0 to Items.Count - 1 do
      begin
        k := Column.KeyList.IndexOf(Items[i]);
        if k >= 0 then
          Items[i] := Column.PickList[k];
      end;
    end;

    Items.InsertObject(0, SSTFilterListItem_Empties, PopupListboxItemEhEmpties);
    Items.InsertObject(0, SSTFilterListItem_NotEmpties, PopupListboxItemEhNotEmties);
    Items.InsertObject(0, SSTFilterListItem_All, PopupListboxItemEhAll);
    Items.InsertObject(0, SSTFilterListItem_CustomFilter, PopupListboxItemEhDialog);
    if not STFilter.InstantApply then
      Items.InsertObject(0, SSTFilterListItem_ApplyFilter, PopupListboxItemEhApplyFilter);
    Items.InsertObject(0, SSTFilterListItem_ClearFilter, PopupListboxItemEhClearFilter);
    if (dghAutoSortMarking in OptionsEh) and ASTFilter.Column.Title.TitleButton then
    begin
      Items.InsertObject(0, '-', PopupListboxItemEhLine);
      Items.InsertObject(0, SSTFilterListItem_SortingByDescend, PopupListboxItemEhSortAsc);
      Items.InsertObject(0, SSTFilterListItem_SortingByAscend, PopupListboxItemEhSortDes);
    end;
  finally
    Items.EndUpdate;
  end;}
end;

procedure TCustomDBGridEh.OnFilterGetItemsList(Sender: TObject);
var
  InplaceFilterEdit: TInplaceFilterEditEh;
  DropDownBoxWidth: Integer;
begin
  InplaceFilterEdit := TInplaceFilterEditEh(FilterEdit);
  if (FFilterCol >= 0) and (FFilterCol < Columns.Count) then
  begin
    DropDownBoxWidth := InplaceFilterEdit.DropDownBox.Width;
    LoadInplaceFilterValues(Columns[FFilterCol].STFilter,
      InplaceFilterEdit.Items, TPopupListboxEh(InplaceFilterEdit.PopupListbox), DropDownBoxWidth);
    InplaceFilterEdit.DropDownBox.Width := DropDownBoxWidth;
    Columns[FFilterCol].STFilter.UpdateValuesCheckingStateFromFilter(InplaceFilterEdit.Items);
  end;
end;

procedure TCustomDBGridEh.InTitleFilterListboxDropDownForRect(Column: TColumnEh; ForRect: TRect);
var
  List: TPopupListboxEh;
  NewWidth: Integer;
  P: TPoint;
begin
  List := GetInTitleFilterListbox;
  NewWidth := Column.STFilter.DropDownListWidth;
  Column.STFilter.FEnterNotClearData := False;
  List.Items.Clear;
  LoadInplaceFilterValues(Column.STFilter, List.Items, List, NewWidth);
  if NewWidth > Column.Width
    then List.Width := NewWidth
    else List.Width := Column.Width;
  Column.STFilter.UpdateValuesCheckingStateFromFilter(List.Items);
  FInTitleFilterListboxColumn := Column;
  List.Color := Self.Color;
  List.Font := Self.Font;
//  ImageList := Self.Images;
  List.ItemHeight := List.GetTextHeight;
//  if (Images <> nil) and (EditImage.UseImageHeight) and (ItemHeight < Images.Height + 1) then
//    ItemHeight := Images.Height;
{$IFDEF EH_LIB_6}
//  List.ExtItems := Self.Items;
//  List.Count := List.ExtItems.Count;
{$ELSE}
//  Items := Self.Items;
{$ENDIF}
//  ItemIndex := Self.ItemIndex;
  List.RowCount := Column.STFilter.FDropDownListRows;
  ForRect.TopLeft := Self.ClientToScreen(ForRect.TopLeft);
  ForRect.BottomRight := Self.ClientToScreen(ForRect.BottomRight);
  P := AlignDropDownWindowRect(ForRect, List, daLeft);
//  P := ClientToScreen(P);
  SetWindowPos(List.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
    SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  List.Visible := True; //commment for Tab key
  List.SizeGrip.Visible := True;
  FInTitleFilterListboxVisible := True;
  List.SizeGripResized := False;
end;

procedure TCustomDBGridEh.InTitleFilterListboxDropDown(Column: TColumnEh);
var
  MasterAbsRect: TRect;
begin
  if FInTitleFilterListboxVisible then
    InTitleFilterListboxCloseUp(False);

  MasterAbsRect := CellRect(DataToRawColumn(Column.Index), 0);
  if RowPanel.Active then
  begin
    MasterAbsRect.Left := MasterAbsRect.Left + Column.FRowPlacement.Left;
    MasterAbsRect.Top := MasterAbsRect.Top + Column.FRowPlacement.Top;
    MasterAbsRect.Right := MasterAbsRect.Left + Column.FRowPlacement.Width;
    MasterAbsRect.Bottom := MasterAbsRect.Top + Column.FRowPlacement.Height;
    if dgColLines in Options then Inc(MasterAbsRect.Right, GridLineWidth);
    if dgRowLines in Options then Inc(MasterAbsRect.Bottom, GridLineWidth);
  end;
  InTitleFilterListboxDropDownForRect(Column, MasterAbsRect);
  InvalidateTitle;
end;

procedure TCustomDBGridEh.InTitleFilterListboxCloseUp(Accept: Boolean);
var
  List: TPopupListboxEh;
  Item: TPopupListboxItemEh;
begin
//    FInTitleFilterListboxColumnIndex: Integer;
  if FInTitleFilterListboxColumn.STFilter.FInFilterListBox then Exit;
  if FInTitleFilterListboxVisible then
  begin
    List := FInTitleFilterListbox;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(List.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    List.Visible := False;
    if List.SizeGripResized then
    begin
      FInTitleFilterListboxColumn.STFilter.FDropDownListRows := List.RowCount;
      FInTitleFilterListboxColumn.STFilter.FDropDownListWidth := List.Width;
    end;
    if (GetFocus = List.Handle) then
      SetFocus;
    FInTitleFilterListboxVisible := False;
    FTrackingStateRect := EmptyRect;
    InvalidateTitle;
    OutBoundaryData.InvalidateOutBoundary(cbtTopEh);
    if not Accept then Exit;

    Item := nil;
    if List.ItemIndex >= 0 then
      Item := TPopupListboxItemEh(List.Items.Objects[List.ItemIndex]);
    if Item <> nil then
      Item.Execute(List, List.ItemIndex, Point(-1,-1), []);
  end;
  FInTitleFilterListboxGroupLevel := nil;
end;

procedure TCustomDBGridEh.StopEditFilter;
begin
  if STFilter.UpdateCount > 0 then
    Exit;
  HideFilterEdit;
  if FFilterEditMode <> False then
  begin
    FFilterEditMode := False;
    GridInvalidateRow(Self, TopDataOffset-1);
  end;
  UpdateEditorMode;
end;

procedure TCustomDBGridEh.HideFilterEdit;
begin
  if Assigned(FilterEdit) and FilterEdit.Visible then
  begin
    if Visible and CanFocus and FilterEdit.Focused then
      Windows.SetFocus(Handle);
    FilterEdit.Visible := False;
    TInplaceFilterEditEh(FilterEdit).FColumn := nil;
    if FFilterCol <> -1 then
    begin
      SetFilterValue(FFilterCol);
      InvalidateCell(FFilterCol+IndicatorOffset, TopDataOffset-1);
    end;
  end;
end;

function TCustomDBGridEh.CanFilterEditShow: Boolean;
begin
  Result := FFilterEditMode and (Selection.SelectionType = gstNon);
end;

procedure TCustomDBGridEh.OnFilterKeyPress(Sender: TObject; var Key: Char);
var
  ItemIndex: Integer;
  Item: TPopupListboxItemEh;
begin
  if Key = #13 then
  begin
    Key := #0;
    SetDataFilter;
  end;

  if (Key = ' ') and (GetShiftState = [ssCtrl]) then
  begin
    ItemIndex := TPopupListboxEh(TInplaceFilterEditEh(Sender).PopupListbox).ItemIndex;
    if (ItemIndex >= 0) and TInplaceFilterEditEh(Sender).ListVisible and
       (TInplaceFilterEditEh(Sender).Items.Objects[ItemIndex] is TPopupListboxItemEh)
    then
    begin
      Item := TPopupListboxItemEh(TInplaceFilterEditEh(Sender).Items.Objects[ItemIndex]);
//      if Item.CanCloseMouseUp(TPopupListboxEh(TInplaceFilterEditEh(Sender).PopupListbox),
//        ItemIndex, Point(-1,-1), mbLeft, GetShiftState)
      if Item.CloseOnExecute(TPopupListboxEh(TInplaceFilterEditEh(Sender).PopupListbox), ItemIndex)
      then
        InTitleFilterListboxCloseUp(True)
      else
        Item.Execute(TPopupListboxEh(TInplaceFilterEditEh(Sender).PopupListbox),
          ItemIndex, Point(-1,-1), GetShiftState);
      TInplaceFilterEditEh(Sender).Column.STFilter.FEnterNotClearData := True;
      TPopupListboxEh(TInplaceFilterEditEh(Sender).PopupListbox).ItemIndex := ItemIndex;
      Key := #0;
    end;
  end;
end;

procedure TCustomDBGridEh.OnFilterEditButtonClick(Sender: TObject; var Handled: Boolean);
begin

end;

procedure TCustomDBGridEh.FilterExit(Sender: TObject);
begin

end;

procedure TCustomDBGridEh.FilterButtonClick(Sender: TObject; var Handled: Boolean);
begin
  TInplaceFilterEditEh(TControl(Sender).Parent).Clear;
  TInplaceFilterEditEh(TControl(Sender).Parent).Text := '';
end;

procedure TCustomDBGridEh.SetFilterValue(DCol: Integer);
var
  Column: TColumnEh;
begin
  if (DCol < 0) or (DCol >= Columns.Count) then
    Exit;
  Column := Columns[DCol];
  if Column.FieldName <> '' then
    Column.STFilter.InternalSetExpressionStr(FilterEdit.Text);
//    if Column.STFilter.KeyField <> ''
//      then Column.STFilter.SetKeyListValues(FilterEdit.Text, FilterEdit.Value)
//      else Column.STFilter.InternalSetExpressionStr(FilterEdit.Text);
end;

procedure TCustomDBGridEh.UpdateFilterEdit(UpdateData: Boolean);
var
  DCol: Integer;
  FilterRect: TRect;
  ACellRect: TRect;
  Column: TColumnEh;
begin
  if STFilter.UpdateCount > 0 then
    Exit;
  if not STFilter.Visible or (STFilter.Location <> stflUnderTitleFilterEh) or
    not CanFilterCol(FFilterCol) or not FilterEditMode then
  begin
    FilterEditMode := False;
    Exit;
  end;
  DCol := FFilterCol;
  Column := Columns[FFilterCol];

  if RowPanel.Active then
  begin
    ACellRect := CellRect(IndicatorOffset, TopDataOffset-1);
    FilterRect := Rect(Column.FRowPlacement.Left,
                       Column.FRowPlacement.Top,
                       Column.FRowPlacement.Left + Column.FRowPlacement.Width,
                       Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    OffsetRect(FilterRect, ACellRect.Left, ACellRect.Top);
    OffsetRect(FilterRect, -FDataOffset.cx, 0);
  end else
    FilterRect := CellRect(DataToRawColumn(FFilterCol), TopDataOffset-1);

  if Column.STFilter.FInFilterListBox then
  begin
    FilterEdit.Move(FilterRect);
    Exit;
  end;

  FilterRect.Left := FilterRect.Left + 1;
//  FOldEditCol := DCol;
  FFilterCol := DCol;

  if not CanFilterEditShow then
  begin
    HideFilterEdit;
    Exit;
  end;

  if UpdateData then
    FilterEdit.Move(Rect(0,0,0,0)); // Hide but safe focuse
  FilterEdit.SetFocus;
  if UpdateData and ((FFilterCol >= 0) and (FFilterCol < Columns.Count)) then
  begin
    UpdateFilterEditProps(DCol);
    FilterEdit.SelectAll;
  end;
  FilterEdit.Move(FilterRect);
  SendMessage(FilterEdit.Handle, EM_SCROLLCARET, 0, 0); //Sometime need
end;

procedure TCustomDBGridEh.UpdateFilterEditProps(DataCol: Longint);
var
  Column: TColumnEh;
  InplaceFilterEdit: TInplaceFilterEditEh;
begin
    Column := Columns[DataCol];
    InplaceFilterEdit := TInplaceFilterEditEh(FilterEdit);
    InplaceFilterEdit.FColumn := Column;
    InplaceFilterEdit.Items.Clear;
    if True{(Column.STFilter.ListSource <> nil) or MemTableSupport} then
    begin
      InplaceFilterEdit.OnCloseUp := OnFilterCloseUp;
      InplaceFilterEdit.OnClosingUp := OnFilterClosingUp;
      InplaceFilterEdit.OnGetItemsList := OnFilterGetItemsList;
      InplaceFilterEdit.Clear; //Value := Null;
      InplaceFilterEdit.Value := Null;
      InplaceFilterEdit.OnButtonClick := nil;

      InplaceFilterEdit.EditButton.Visible := True;
      InplaceFilterEdit.DropDownBox.Sizable := True;
      if Column.STFilter.CurrentKeyField <> ''
        then InplaceFilterEdit.SetKeyDisplayText(Column.STFilter.FKeyValues, Column.STFilter.ExpressionStr)
        else InplaceFilterEdit.Text := Column.STFilter.ExpressionStr;
      if Column.STFilter.DropDownListWidth > 0
        then InplaceFilterEdit.DropDownBox.Width := Column.STFilter.DropDownListWidth
        else InplaceFilterEdit.DropDownBox.Width := 100;
      if Column.STFilter.DropDownListRows > 0
        then InplaceFilterEdit.DropDownBox.Rows := Column.STFilter.DropDownListRows
        else InplaceFilterEdit.DropDownBox.Rows := 17;
    end
    else
    begin
      InplaceFilterEdit.Value := Null;

      InplaceFilterEdit.OnGetItemsList := nil;
      InplaceFilterEdit.EditButton.Visible := False;
      InplaceFilterEdit.Text := GetFilterValue(DataCol);
    end;
end;

function TCustomDBGridEh.GetInTitleFilterListbox: TPopupListboxEh;
begin
  if FInTitleFilterListbox = nil then
  begin
    FInTitleFilterListbox := TPopupListboxEh.Create(Self);
    FInTitleFilterListbox.UseItemObjects := True;
    FInTitleFilterListbox.Visible := False;
    FInTitleFilterListbox.Ctl3D := True;
    FInTitleFilterListbox.Parent := Self; // Already set parent in TPopupListboxEh.CreateWnd
    ShowWindow(FInTitleFilterListbox.Handle, SW_HIDE); //For Delphi 5 design time
    FInTitleFilterListbox.OnMouseUp := InTitleFilterListMouseUp;
    FInTitleFilterListbox.OnKeyDown := InTitleFilterListKeyDown;
    FInTitleFilterListbox.OnKeyPress := InTitleFilterListKeyPress;
//    FInTitleFilterListbox.OnDoCloseUp := InTitleFilterListDoCloseUp;
//    FInTitleFilterListbox.OnKeyPess :=
//    FInTitleFilterListbox.OnGetImageIndex := PopupListboxGetImageIndex;
  end;
  Result := FInTitleFilterListbox;
end;

procedure TCustomDBGridEh.InTitleFilterListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
//    if TPopupListboxEh(Sender).CanCloseMouseUp(Point(X, Y), Button, Shift) then
    if TPopupListboxEh(Sender).IsMouseUpCloseListbox then
      InTitleFilterListboxCloseUp(PtInRect(TPopupListboxEh(Sender).ClientRect, Point(X, Y)));
  end;
end;

procedure TCustomDBGridEh.InTitleFilterListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    InTitleFilterListboxCloseUp(False);
end;

procedure TCustomDBGridEh.InTitleFilterListKeyPress(Sender: TObject; var Key: Char);
var
  ItemIndex: Integer;
  Item: TPopupListboxItemEh;
begin
  if Key = #13 then
    InTitleFilterListboxCloseUp(True);
  if Key = ' ' then
  begin
    ItemIndex := TPopupListboxEh(Sender).ItemIndex;
    if (ItemIndex >= 0) and
       (TPopupListboxEh(Sender).Items.Objects[ItemIndex] is TPopupListboxItemEh)
    then
    begin
      FInTitleFilterListboxColumn.STFilter.FEnterNotClearData := True;
      Item := TPopupListboxItemEh(TPopupListboxEh(Sender).Items.Objects[ItemIndex]);
//      if Item.CanCloseMouseUp(TPopupListboxEh(Sender), ItemIndex, Point(-1,-1), mbLeft, Shift) then
      if Item.CloseOnExecute(TPopupListboxEh(Sender), ItemIndex) then
        InTitleFilterListboxCloseUp(True)
      else
        Item.Execute(TPopupListboxEh(Sender), ItemIndex, Point(-1,-1), GetShiftState);
    end;
    Key := #0;
  end;
end;

procedure TCustomDBGridEh.ShowEditor;
begin
  if FilterEditMode then
    StopEditFilter;
  if RowPanel.Active then
    ClampInViewRowPanelCell(SelectedIndex);
  inherited ShowEditor;
end;

procedure TCustomDBGridEh.HideEditor;
begin
  inherited HideEditor;
  if RowPanel.Active then
  begin
    InvalidateCell(Col, Row);
    FInplaceColInRowPanel := -1;
    FInplaceRow := -1;
  end;
{  if RowPanel.Active then
  begin
    if InplaceEditor <> nil then
      try
        if (FInplaceColInRowPanel <> -1) and (FInplaceRow <> -1) then
          SetEditText(FInplaceColInRowPanel, FInplaceRow, InplaceEditor.Text);
//        UpdateText;
      finally
        FInplaceColInRowPanel := -1;
        FInplaceRow := -1;
      end;
  end;}
end;

procedure TCustomDBGridEh.UpdateEditorMode;
begin
  if (dgAlwaysShowEditor in Options) and not FilterEditMode
    then ShowEditor
    else HideEditor;
end;

procedure TCustomDBGridEh.UpdateEdit;

  procedure UpdateEditorInRowPanel;
  begin
    FInplaceColInRowPanel := FInRowPanelCol;
    FInplaceRow := Row;
    TDBGridInplaceEdit(InplaceEditor).UpdateContents;
//    if InplaceEditor.MaxLength = -1
//      then FCanEditModify := False
//      else FCanEditModify := True;
    InplaceEditor.SelectAll;
  end;

var
  Column: TColumnEh;
  AEditRect, ACellRect: TRect;
begin
  if RowPanel.Active then
  begin
    if CanEditShow then
    begin
      if EnsureInplaceEditCreated then
        UpdateEditorInRowPanel
      else
      begin
        if (FInRowPanelCol <> FInplaceColInRowPanel) or (Row <> FInplaceRow) then
        begin
          HideEdit;
          UpdateEditorInRowPanel;
        end;
      end;
      Column := Columns[FInRowPanelCol];
      ACellRect := CellRect(Col, Row);
      AEditRect := Rect(Column.FRowPlacement.DataCellLeft,
                        Column.FRowPlacement.Top,
                        Column.FRowPlacement.DataCellLeft + Column.FRowPlacement.DataCellWidth,
                        Column.FRowPlacement.Top + Column.FRowPlacement.Height);
      OffsetRect(AEditRect, ACellRect.Left, ACellRect.Top);
      OffsetRect(AEditRect, -FDataOffset.cx, 0);
      if RowDetailPanel.Active and (Column = VisibleColumns[0]) then
        if AEditRect.Left + 18 < AEditRect.Right then
          if UseRightToLeftAlignment
            then AEditRect.Right := AEditRect.Right - 18
            else AEditRect.Left := AEditRect.Left + 18;
      if CanEditShow then InplaceEditor.Move(AEditRect);
    end;
  end else
    inherited UpdateEdit;
end;

procedure TCustomDBGridEh.UpdateText;
begin
  if RowPanel.Active then
  begin
    if (FInRowPanelCol <> -1) and (FInplaceRow <> -1) then
      SetEditText(FInRowPanelCol, FInplaceRow, InplaceEditor.Text);
  end else
    inherited UpdateText;
end;

procedure TCustomDBGridEh.SetDataFilter;
var
  OldLeftCol: Integer;
begin
  if (FFilterCol <> -1) and (FilterEdit <> nil) and FilterEdit.Visible then
    SetFilterValue(FFilterCol);
  OldLeftCol := LeftCol;
  try
    try
      if Assigned(FOnApplyFilter)
        then FOnApplyFilter(Self)
        else DefaultApplyFilter;
    except
//ddd      ReleaseDataFilter;
      raise;
    end;
  finally
    if OldLeftCol < ColCount then
      LeftCol := OldLeftCol;
    UpdateFilterEdit(True);
    if SumList.Active then
      SumList.RecalcAll;
    Invalidate;
  end;
end;

procedure TCustomDBGridEh.DefaultApplyFilter;
begin
  LockPaint;
  try
    Center.ApplyFilter(Self);
  finally
    UnlockPaint;
  end;
end;

procedure TCustomDBGridEh.OnFilterChange(Sender: TObject);
begin
  if FFilterCol <> -1 then
    SetFilterValue(FFilterCol);
end;

{ IInplaceEditHolderEh }

procedure TCustomDBGridEh.GetMouseDownInfo(var Pos: TPoint; var Time: Integer);
begin
  Pos := ClientToScreen(FDownMousePos);
  Time := FDownMouseMessageTime;
  FDownMouseMessageTime := 0;
end;

function TCustomDBGridEh.InplaceEditCanModify(Control: TWinControl): Boolean;
begin
  Result := True;
end;

procedure TCustomDBGridEh.InplaceEditKeyDown(Control: TWinControl;
  var Key: Word; Shift: TShiftState);

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

  procedure Tab(GoForward: Boolean; Side: Boolean);
  var
    ACol, Original: Integer;
  begin
    Key := 0;
    if Side then
    begin
      if GoForward then
        ACol := Columns.Count-1
      else
        ACol := 0;
      GoForward := not GoForward;
    end
    else
      ACol := FFilterCol;
    Original := ACol;
    if GoForward
      then Inc(ACol)
      else Dec(ACol);
    if ACol >= Columns.Count then
      ACol := 0
    else if ACol < 0 then
      ACol := Columns.Count-1;
    if ACol = Original then
      Exit;
    while not CanFilterCol(ACol) do
    begin
      if GoForward
        then Inc(ACol)
        else Dec(ACol);
      if (ACol < 0) or (ACol >= Columns.Count) then
        Exit;
    end;
    StartEditFilter(ACol);
  end;

  function Selection: TSelection;
  begin
//    SendMessage(Control.Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
    MessageSendGetSel(Control.Handle, Result.StartPos, Result.EndPos);
  end;

  function CaretPos: Integer;
  var
    P: TPoint;
  begin
    Windows.GetCaretPos(P);
    Result := SendMessage(Control.Handle, EM_CHARFROMPOS, 0, MakeLong(Word(P.X), Word(P.Y)));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := ((CaretPos = Control.GetTextLen) and
        ((StartPos = 0) or (EndPos = StartPos)) and (EndPos = Control.GetTextLen));
  end;

  function LeftSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = -1) or
        ((CaretPos = 0) and (StartPos = 0) and
        ((EndPos = 0) or (EndPos = GetTextLen))
        );
  end;

  procedure Deselect;
  begin
    SendMessage(Control.Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

begin
  { TODO : May be replace to CMWontSpecialKey? }
  if UseRightToLeftAlignment then
    if Key = VK_LEFT then
      Key := VK_RIGHT
    else if Key = VK_RIGHT then
      Key := VK_LEFT;
  if (Control is TInplaceFilterEditEh) and
     TInplaceFilterEditEh(Control).ListVisible
  then
    Exit;
  case Key of
    VK_LEFT: if Ctrl or LeftSide then
        Tab(False, Ctrl);
    VK_RIGHT: if Ctrl or RightSide then
        Tab(True, Ctrl);
    VK_HOME: if Ctrl or LeftSide then
        Tab(False, True);
    VK_END: if Ctrl or RightSide then
        Tab(True, True);
    VK_TAB: if dgTabs in Options then
        Tab(not (ssShift in Shift), False);
    VK_DOWN:
      if ((Shift = []) or (Shift = [ssCtrl])) and DataLink.Active then
      begin
        SelectedIndex := FFilterCol;
        if Shift = [] then MoveBy(-DataLink.ActiveRecord);
        StopEditFilter;
        Key := 0;
      end;
    VK_UP: if (Shift = []) then
        Key := 0;
    VK_F2:
      begin
        Deselect;
        Key := 0;
      end;
    VK_RETURN:
      if Shift = [ssAlt] then
      begin
//        ShowFilterDialog;
//        Key := 0;
      end;
  end;
end;

procedure TCustomDBGridEh.InplaceEditKeyPress(Control: TWinControl; var Key: Char);
begin
  if (Control is TInplaceFilterEditEh) then
  case Key of
    #9{, #27}: Key := #0;
  end;
end;

procedure TCustomDBGridEh.InplaceEditKeyUp(Control: TWinControl;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure TCustomDBGridEh.InplaceEditWndProc(Control: TWinControl; var Message: TMessage);
begin

end;

function TCustomDBGridEh.CheckCellFilter(ACol, ARow: Integer; P: TPoint): Boolean;
begin
  Result := False;
  if ARow = TopDataOffset - 1 then
    Result := True;
end;

procedure TCustomDBGridEh.ApplyFilter;
begin
  SetDataFilter;
end;

procedure TCustomDBGridEh.ClearFilter;
var
  i: Integer;
begin
  StopEditFilter;
  for i := 0 to Columns.Count - 1 do
    Columns[i].STFilter.Clear;
  Invalidate;
end;

procedure TCustomDBGridEh.SetValueFromPrevRecord;
var
  Col: TColumnEh;
  v: Variant;
  Text: String;
  CurDataRow: Integer;
begin
  if ViewScroll
    then CurDataRow := FIntMemTable.InstantReadCurRowNum
    else CurDataRow := DataLink.ActiveRecord;

  if DataLink.Active and (CurDataRow > 0) and
    Columns[SelectedIndex].CanModify(True) then
  begin
    Col := Columns[SelectedIndex];
    InstantReadRecordEnter(CurDataRow-1);
//    DataLink.ActiveRecord := DataLink.ActiveRecord - 1;
    try
      if Col.Field.Lookup
        then v := Col.Field.DataSet.FieldValues[Col.Field.KeyFields]
        else v := Col.Field.Value;
      Text := VarToStr(Col.Field.Value);
    finally
      InstantReadRecordLeave;
//      DataLink.ActiveRecord := DataLink.ActiveRecord + 1;
    end;
    Selection.Clear;
    {if Col.Field.Lookup
      then Col.Field.DataSet.FieldValues[Col.Field.KeyFields] := v
      else Col.Field.Value := v;}
    Col.UpdateDataValues(Text, v, False);
    ShowEditor;
    if InplaceEditorVisible then
      InplaceEditor.SelectAll;
  end;
end;

procedure TCustomDBGridEh.OptimizeSelectedColsWidth(WithColumn: TColumnEh);
var
  I: Integer;
  WithColumnOptimized: Boolean;
  ColumnsList: TColumnsEhList;
begin
  ColumnsList := TColumnsEhList.Create;
  try
    WithColumnOptimized := False;
    if Selection.SelectionType = gstColumns then
      for I := 0 to Selection.Columns.Count-1 do
      begin
        ColumnsList.Add(Selection.Columns[I]);
        if WithColumn = Selection.Columns[I] then
          WithColumnOptimized := True;
      end
    else if Selection.SelectionType = gstAll then
      for I := 0 to Columns.Count-1 do
      begin
        ColumnsList.Add(Columns[I]);
        if WithColumn = Columns[I] then
          WithColumnOptimized := True;
      end;
    if not WithColumnOptimized then
      ColumnsList.Add(WithColumn);

     OptimizeColsWidth(ColumnsList);
  finally
    ColumnsList.Free;
  end;
end;

procedure TCustomDBGridEh.OptimizeColsWidth(ColumnsList: TColumnsEhList);

  procedure CalcTitleWidth(Column: TColumnEh; var MaxColWidth: Integer);
  var
    ExtraWidth, RightIndent, MaxTextHeight: Integer;
    S: String;
    ARect: TRect;
    WordWrap: Boolean;
  begin
    ExtraWidth := 4;
    if Column.Title.GetSortMarkingWidth > 2 then
      Inc(ExtraWidth, Column.Title.GetSortMarkingWidth - 2);
    if (TitleImages <> nil) and (Column.Title.ImageIndex <> -1) then
      MaxColWidth := TitleImages.Width + ExtraWidth
    else
    begin
      ARect := CellRect(Column.Index + IndicatorOffset, 0);
      Dec(ARect.Right, ExtraWidth);
      if IsUseMultiTitle = True then
      begin
        S := FLeafFieldArr[Column.Index].FLeaf.Text;
        ARect.Top := ARect.Bottom - FLeafFieldArr[Column.Index].FLeaf.Height + 1;
      end else
        S := Column.Title.Caption;
      WordWrap := (IsUseMultiTitle = True) or (TitleHeight <> 0) or (TitleLines <> 0);
      Canvas.Font.Assign(Column.Title.Font);
      if Column.Title.Orientation = tohVertical then
      begin
        WordWrap := False;
        OverturnUpRect(ARect);
      end;
      if WordWrap then RightIndent := 2 else RightIndent := 0;
      CheckHintTextRect(Self.DrawTextBiDiModeFlagsReadingOnly, Self.Canvas,
        RightIndent, 0, S, ARect, WordWrap, MaxColWidth, MaxTextHeight);
      if Column.Title.Orientation = tohVertical
        then MaxColWidth := MaxTextHeight + ExtraWidth
        else MaxColWidth := MaxColWidth + ExtraWidth;
    end;
  end;

  procedure CalcDataWidth(Column: TColumnEh; var MaxColWidth: Integer);
  var
    ExtraWidth, CurColWidth, MaxTextHeight: Integer;
    S: String;
    ARect: TRect;
    WordWrap: Boolean;
  begin

    ExtraWidth := 4;
    if Column.AlwaysShowEditButton then
      Inc(ExtraWidth, Column.EditButtonsWidth);
    if Column = VisibleColumns[0] then
      Inc(ExtraWidth, GetCellTreeElmentsAreaWidth);
    if Column.ShowImageAndText and Assigned(Column.ImageList) then
      Inc(ExtraWidth, Column.ImageList.Width + 4);

    if Column.GetColumnType = ctKeyImageList then
      CurColWidth := Column.ImageList.Width + ExtraWidth
    else if Column.GetColumnType = ctCheckboxes then
      CurColWidth := DefaultCheckBoxWidth + ExtraWidth
    else
    begin
      ARect := Rect(0,0,0,FStdDefaultRowHeight);
      S := Column.DisplayText;
//      WordWrap := Column.WordWrap and Column.CurLineWordWrap(RowHeights[ARow]);
      WordWrap := False;
      Canvas.Font.Assign(Column.Font);

      Column.FillColCellParams(FColCellParamsEh);
      with FColCellParamsEh do
      begin
        FBackground := Canvas.Brush.Color;
        FFont := Canvas.Font;
        FState := [];
        FAlignment := Column.Alignment;
        FText := S;
        FCol := Column.Index + IndicatorOffset;
        FRow := 0;
        GetCellParams(Column, FFont, FBackground, FState);
        Column.GetColCellParams(False, FColCellParamsEh);
        S := FText;
      end;

      CheckHintTextRect(Self.DrawTextBiDiModeFlagsReadingOnly, Self.Canvas,
        0, 0, S, ARect, WordWrap, CurColWidth, MaxTextHeight);

      CurColWidth := CurColWidth + ExtraWidth;
    end;
    if CurColWidth > MaxColWidth then
      MaxColWidth := CurColWidth;
  end;

  procedure CalcFooterWidth(Column: TColumnEh; var MaxColWidth: Integer);
  var
    ExtraWidth, CurColWidth, MaxTextHeight, I: Integer;
    S: String;
    ARect: TRect;
    Footer: TColumnFooterEh;
  begin
    ExtraWidth := 5;
    for I := 0 to FooterRowCount-1 do
    begin
      Footer := Column.UsedFooter(I);
      Canvas.Font := Footer.Font;
      Brush.Color := Footer.Color;

      FColCellParamsEh.FBackground := Footer.Color;
      FColCellParamsEh.Alignment := Footer.Alignment;
      S := GetFooterValue(I, Column);

      GetFooterParams(Column.Index, I, Column, Canvas.Font,
        FColCellParamsEh.FBackground, FColCellParamsEh.FAlignment, [], S);

      ARect := Rect(0,0,0,FStdDefaultRowHeight);
      CheckHintTextRect(Self.DrawTextBiDiModeFlagsReadingOnly, Self.Canvas,
        0, 0, S, ARect, Footer.WordWrap and FAllowWordWrap,
        CurColWidth, MaxTextHeight);
      CurColWidth := CurColWidth + ExtraWidth;

      if CurColWidth > MaxColWidth then
        MaxColWidth := CurColWidth;
    end;
  end;

var
  I, Rn, RCount: Integer;
  ColWidths: array of Integer;
begin
  SetLength(ColWidths, ColumnsList.Count);

  for I := 0 to ColumnsList.Count-1 do
    CalcTitleWidth(ColumnsList[i], ColWidths[i]);

  if not DataLink.Active then Exit;
  with DataSource.DataSet do
  begin
    DisableControls;
    try
    SaveBookmark;
    First;
    Rn := RecNo;
    RCount := RecordCount;
    try
      while not Eof do
      begin
        for I := 0 to ColumnsList.Count-1 do
          CalcDataWidth(ColumnsList[i], ColWidths[i]);
        Next;
        if IsSequenced and (Rn >= RCount) then
          Break;
        Rn := RecNo;
      end;
    finally
      RestoreBookmark;
    end;
    finally
      EnableControls;
    end;
  end;

  if not AutoFitColWidths then BeginLayout;
  try
    for I := 0 to ColumnsList.Count-1 do
    begin
      CalcFooterWidth(ColumnsList[i], ColWidths[i]);
      ColumnsList[i].Width := ColWidths[i];
    end;
  finally
    if not AutoFitColWidths then EndLayout;
  end;
end;

function TCustomDBGridEh.IsFindDialogShowAsModal: Boolean;
begin
  Result := True;
end;

//var
//  MemBitmap: HBITMAP;

procedure TCustomDBGridEh.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  ClipRgn: HRGN;
  MemDCLi: Longint;
begin
  if PaintLocked then Exit;
  if NeedBufferedPaint and not DBGridEhDebugDraw then
    BufferedPaint := True;
  if not FBufferedPaint or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientWidth, ClientHeight);
//    MemBitmap := CreateCompatibleBitmap(DC, PS.rcPaint.Right-PS.rcPaint.Left, PS.rcPaint.Bottom-PS.rcPaint.Top);
//    if MemBitmap = 0 then
//      MemBitmap := CreateCompatibleBitmap(DC, 1000, 1000);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      ClipRgn := CreateRectRgn(PS.rcPaint.Left, PS.rcPaint.Top, PS.rcPaint.Right, PS.rcPaint.Bottom);
      MemDCLi := ExplicitLongwordToLongInt(MemDC);
      Perform(WM_ERASEBKGND, MemDCLi, MemDCLi);
      SelectClipRgn(MemDC, ClipRgn);
      DeleteObject(ClipRgn);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
//      BitBlt(DC, PS.rcPaint.Left, PS.rcPaint.Top, PS.rcPaint.Right, PS.rcPaint.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

function TCustomDBGridEh.GetCellTreeElmentsAreaWidth: Integer;
begin
  Result := 0;
  if (FIntMemTable <> nil) and FIntMemTable.MemTableIsTreeList then
    Result := FIntMemTable.GetTreeNodeLevel * 18;
  if Result < 0 then
    Result := 0;
end;

procedure TCustomDBGridEh.DrawTreeArea(Canvas: TCanvas; ARect: TRect;
  IsDrawEdge: Boolean; IsSubTreeArea: Boolean);
var
  ARect1: TRect;
  i: Integer;
  OneAdd: Integer;
  Element: TTreeElementEh;

  procedure DrawOneTreeElement(Canvas: TCanvas; ARect: TRect; TreeElement: TTreeElementEh);
  var
    ARectE: TRect;
  begin
    ARectE := ARect;
    Inc(ARectE.Bottom, OneAdd);
    Canvas.FillRect(ARectE);
    DrawTreeElement(Canvas, ARectE, TreeElement, //False);
      (FStdDefaultRowHeight mod 2 = 1) and (TopRow mod 2 = 1), 1, 1, UseRightToLeftAlignment);
  end;

begin
  OneAdd := 0;
  ARect1 := ARect;
  ARect1.Right := ARect1.Left + 18;
  if (dgRowLines in Options) and IsDrawEdge{and
    (FIntMemTable.GetNextVisibleTreeNodeLevel < 0) or
    (FIntMemTable.GetNextVisibleTreeNodeLevel >= FIntMemTable.GetTreeNodeLevel)}
  then
  begin
    Canvas.Pen.Color := Canvas.Brush.Color;
    DrawPolyline([Point(ARect1.Left, ARect1.Bottom),
                     Point(ARect1.Right, ARect1.Bottom)]);
    OneAdd := 1;
  end;
  for i := 1 to FIntMemTable.GetTreeNodeLevel-1 do
  begin
    if FIntMemTable.ParentHasNextSibling(i)
      then DrawOneTreeElement(Canvas, ARect1, tehVLine)
      else Canvas.FillRect(ARect1);
    ARect1.Left := ARect1.Left + 18;
    ARect1.Right := ARect1.Left + 18;
    if (dgRowLines in Options) and IsDrawEdge and
    ((FIntMemTable.GetNextVisibleTreeNodeLevel < 0) or
     (FIntMemTable.GetNextVisibleTreeNodeLevel > i))
    then
    begin
      Canvas.Pen.Color := Canvas.Brush.Color;
      DrawPolyline([Point(ARect1.Left, ARect1.Bottom),
                       Point(ARect1.Right,ARect1.Bottom)]);
      OneAdd := 1;
    end else
      OneAdd := 0;
  end;
  if FIntMemTable.GetTreeNodeHasChields then
    if FIntMemTable.ParentHasNextSibling(FIntMemTable.GetTreeNodeLevel)
    then
      if FIntMemTable.GetTreeNodeExpanded
        then Element := tehMinusUpDown
        else Element := tehPlusUpDown
    else
      if FIntMemTable.GetTreeNodeExpanded
        then Element := tehMinusUp
        else Element := tehPlusUp
  else
    if FIntMemTable.ParentHasNextSibling(FIntMemTable.GetTreeNodeLevel)
      then Element := tehCrossUpDown
      else Element := tehCrossUp;
  if IsSubTreeArea then
  begin
    if Element in [tehMinusUpDown, tehPlusUpDown, tehCrossUpDown] then
    begin
      Element := tehVLine;
      DrawOneTreeElement(Canvas, ARect1, Element);
    end
  end else
    DrawOneTreeElement(Canvas, ARect1, Element);
  if (dgRowLines in Options) and IsDrawEdge then
  begin
    Canvas.Pen.Color := clSilver;
    DrawPolyline([Point(ARect1.Right-1, ARect1.Bottom),
                     Point(ARect1.Right-1, ARect1.Top-2)]);
  end;
  ARect.Left := ARect1.Right;
end;

procedure TCustomDBGridEh.DrawCellTreeArea(DataCol, DataRow: Integer;
  AState: TGridDrawState; ARect: TRect; Draw3DRect: Boolean);
var
  Multiselected: Boolean;
  AColor, OldColor: TColor;
begin
  if (FIntMemTable <> nil) and FIntMemTable.MemTableIsTreeList then
  begin
//    AColor := Columns[DataCol].Color;
    AColor := Color;
    Multiselected := DataCellSelected(DataCol, Datalink.Datasource.Dataset.Bookmark);
    if Multiselected and Assigned(Style) then
      Style.HighlightDataCellColor(Self, DataCol + IndicatorOffset, DataRow + TopDataOffset,
        DataCol, DataRow, '', AState, Multiselected, AColor, Canvas.Font);
    OldColor := Canvas.Brush.Color;
    Canvas.Brush.Color := AColor;

{    if Draw3DRect then
    begin
      Dec(ARect.Top);
      Dec(ARect.Left);
      Inc(ARect.Bottom);
    end;}
    DrawTreeArea(Canvas, ARect, True, False);
    Canvas.Brush.Color := OldColor;
  end;
end;

function TCustomDBGridEh.CellTreeElementMouseDown(MouseX, MouseY: Integer;
  CheckInOnly: Boolean): Boolean;
var
  Cell: TGridCoord;
  ARect: TRect;
  RowOffset, OldTopRow, FirstVisibleParentRecNo, TreeAreaWidth: Integer;
  TreeNodeExpanded: Boolean;
//  OldBookmark: TUniBookmarkEh;
  Rec: TObject;
begin
  Result := False;
  FirstVisibleParentRecNo := -1;
  if not ((FIntMemTable <> nil) and FIntMemTable.MemTableIsTreeList) then Exit;
  Cell := MouseCoord(MouseX, MouseY);
  ARect := CellRect(Cell.X, Cell.Y);
  if (Cell.Y >= TopDataOffset) and (Cell.X >= IndicatorOffset) then
  begin
    if Columns[RawToDataColumn(Cell.X)] <> VisibleColumns[0] then
      Exit;
    RowOffset := Cell.Y - Row;
    OldTopRow := TopRow;
//    OldBookmark := DataSource.DataSet.Bookmark;
    Rec := FIntMemTable.GetRecObject;
    try
      if RowOffset <> 0 then
        FIntMemTable.InstantReadEnter(DataSource.DataSet.RecNo - 1 + RowOffset);
      TreeAreaWidth := GetCellTreeElmentsAreaWidth;
      TreeNodeExpanded := FIntMemTable.GetTreeNodeExpanded;
    finally
      if RowOffset <> 0 then
        FIntMemTable.InstantReadLeave;
    end;
    if Self.UseRightToLeftAlignment then
      MouseX := ARect.Right + ARect.Left - MouseX;
    if (ARect.Left <= MouseX ) and (MouseX < ARect.Left + TreeAreaWidth) then
    begin
      Result := True;
      if CheckInOnly then Exit;
      DataSource.DataSet.DisableControls;
      if (ARect.Left + TreeAreaWidth - 18 <= MouseX ) then
        FirstVisibleParentRecNo := FIntMemTable.SetTreeNodeExpanded(DataSource.DataSet.RecNo - 1 + RowOffset, not TreeNodeExpanded);

      LockPaint;
      FLockAutoShowCurCell := True;
      try
        if (FirstVisibleParentRecNo > 0) and (FirstVisibleParentRecNo <> DataSource.DataSet.RecNo) then
          DataSource.DataSet.RecNo := FirstVisibleParentRecNo
//        else if DataSetBookmarkValid(DataSource.DataSet, OldBookmark) then
//          DataSource.DataSet.Bookmark := OldBookmark;
        else
          FIntMemTable.SetToRec(Rec);
        DataSource.DataSet.EnableControls;
        SafeMoveTop(OldTopRow);
      finally
        UnlockPaint;
        FLockAutoShowCurCell := False;
      end;
      Invalidate;
      UpdateScrollBar;
    end;
  end;
end;

function TCustomDBGridEh.BoxRect(ALeft, ATop, ARight,
  ABottom: Integer): TRect;
begin
  Result := inherited BoxRect(ALeft, ATop, ARight, ABottom);
end;

function TCustomDBGridEh.CheckBeginRowMoving(MouseX, MouseY: Integer; CheckInOnly: Boolean): Boolean;
var
  Cell: TGridCoord;
  ARect: TRect;
  Bookmark: TUniBookmarkEh;
  DataRow: Integer;
//  TreeLevel: Integer;
  DrawInfo: TGridDrawInfoEh;
begin
  Result := False;
  if not DataLink.Active or not (dghRecordMoving in OptionsEh) then Exit;
  Cell := MouseCoord(MouseX, MouseY);
  Result := (Cell.X >= 0) and (Cell.X < FIndicatorOffset) and (Cell.Y > TopDataOffset - 1) and
    FDatalink.Active and not (DataSource.DataSet.Eof and DataSource.DataSet.Bof);
  if Result then
  begin
    DataRow := Cell.Y - TopDataOffset;
    InstantReadRecordEnter(DataRow);
    try
      Bookmark := FDatalink.DataSet.Bookmark;
      FMoveRowSourLevel := -1;
      if MemTableSupport then
        FMoveRowSourLevel := FIntMemTable.GetTreeNodeLevel;
      if CanSelectType(gstRecordBookmarks) then
        Result := FBookmarks.CurrentRowSelected and (GetShiftState * [ssShift, ssAlt, ssCtrl] = []);
    finally
      InstantReadRecordLeave;
    end;
    if not Result then Exit;
    ARect := CellRect(Cell.X, Cell.Y);
    Result := True;
    if CheckInOnly then Exit;
    FMoveRowSour := DataRow  + TopDataOffset;
    FMoveRowDest := FMoveRowSour;
    FMoveBookmarkSour := Bookmark;
    if BeginDataRowDrag(FMoveRowSour, FMoveRowDest, Point(MouseX, MouseY)) then
    begin
      FDBGridEhState := dgsRowMoving;
      Update;
      CalcDrawInfo(DrawInfo);
      FMoveRowLeftBounds := CalcLeftMoveLine(Cell.Y, Point(MouseX, MouseY), FMoveRowDestLevel);
      DrawDataRowMove(FMoveRowLeftBounds, DrawInfo.Horz.FullVisBoundary);
//      MoveDrawn := True;
      SetTimer(Handle, 1, 60, nil);
      FTracking := True;
    end;
  end;
end;

procedure TCustomDBGridEh.EndRowMoving(MouseX, MouseY: Integer; Accept: Boolean);
begin
  KillTimer(Handle, 1);
//  DrawDataRowMove(FMoveRowLeftBounds, ClientWidth);
  HideDataRowMove;
  FDBGridEhState := dgsNormal;
  if not Accept then Exit;
  if EndRowDrag(FMoveRowSour, FMoveRowDest, Point(MouseX, MouseY)) and
   ((FMoveRowSour <> FMoveRowDest) or (FMoveRowDestLevel <> FMoveRowSourLevel))
  then
    MoveSelectedDataRows(FMoveRowDest - TopDataOffset, FMoveRowDestLevel, False);
// UpdateEdit;
end;

function TCustomDBGridEh.EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := inherited EndColumnDrag(Origin, Destination, MousePt);
  if FGroupDataMovingIndex >= 0 then
  begin
    TColumnEh(DataGrouping.ActiveGroupLevels[FGroupDataMovingIndex].Column).Visible := True;
    DataGrouping.ActiveGroupLevels[FGroupDataMovingIndex].Destroy;
//    DataGrouping.Active := False;
//    DataGrouping.Active := True;
  end;
end;

function TCustomDBGridEh.MoveSelectedDataRows(ToIndex: Longint;
  TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  BookmarkList: TBMListEh;
begin
  if SelectedRows.Count = 0 then
  begin
    BookmarkList := TBMListEh.Create;
    BookmarkList.AppendItem(FMoveBookmarkSour);
    Result := MoveDataRows(BookmarkList, ToIndex, TreeLevel, CheckOnly);
    BookmarkList.Free;
  end else
    Result := MoveDataRows(SelectedRows, ToIndex, TreeLevel, CheckOnly);
end;

function TCustomDBGridEh.BeginDataRowDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

procedure TCustomDBGridEh.DrawDataRowMove(LeftBoundary, RightBoundary: Integer);
var
  OldPen: TPen;
  Pos: Integer;
  R: TRect;
begin
//  if FDataRowMoveVisible then
//    HideDataRowMove;
  OldPen := TPen.Create;
  try
    with Canvas do
    begin
      OldPen.Assign(Pen);
      try
        Pen.Style := psDot;
        Pen.Mode := pmXor;
//        Pen.Width := 5;
        Pen.Color := clSilver;
        if FDBGridEhState = dgsRowMoving then
        begin
          R := CellRect(0, FMoveRowDest);
          if FMoveRowDest = FMoveRowSour then
            if FMoveRowSourLevel > FMoveRowDestLevel
              then Pos := R.Bottom
              else Pos := R.Top
          else if FMoveRowDest > FMoveRowSour then
            Pos := R.Bottom
          else
            Pos := R.Top;
{          MoveTo(LeftBoundary, Pos);
          LineTo(RightBoundary, Pos);
          MoveTo(LeftBoundary, Pos - 5);
          LineTo(LeftBoundary, Pos + 5); }
          if GetMoveLineEh.Visible
           then GetMoveLineEh.MoveToFor(Self, Point(LeftBoundary, Pos))
           else GetMoveLineEh.StartShow(Self, Point(LeftBoundary, Pos), False, RightBoundary-LeftBoundary);

          FDataRowMoveLeftBoundary := LeftBoundary;
          FDataRowMoveRightBoundary := RightBoundary;
          FDataRowMoveVisible := not FDataRowMoveVisible;
        end;
      finally
        Canvas.Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomDBGridEh.HideDataRowMove;
begin
//  if FDataRowMoveVisible then
//    DrawDataRowMove(FDataRowMoveLeftBoundary, FDataRowMoveRightBoundary);
  GetMoveLineEh.Hide;
  FDataRowMoveVisible := False;
end;

procedure TCustomDBGridEh.MoveDataRowAndScroll(Mouse, CellHit: Integer;
  var DrawInfo: TGridDrawInfoEh; var Axis: TGridAxisDrawInfoEh;
  ScrollBar: Integer; const MousePt: TPoint);
var
  TreeLevel, LeftBounds: Integer;
//  DragLineHidden: Boolean;
begin
  if Self.UseRightToLeftAlignment and (ScrollBar = SB_HORZ) then
    Mouse := ClientWidth - Mouse;
  LeftBounds := CalcLeftMoveLine(CellHit, MousePt, TreeLevel);
  if MemTableSupport then
  begin
    if (FMoveRowLeftBounds <> LeftBounds) or
      ((CellHit <> FMoveRowDest) and
        not((FMoveRowDest = Axis.FixedCellCount) and (Mouse < Axis.FixedBoundary)) and
        not((FMoveRowDest = Axis.GridCellCount-1) and (Mouse > Axis.GridBoundary))) then
    begin
//      DragLineHidden := False;
      if (Mouse < Axis.FixedBoundary) then
      begin
        if (FMoveRowDest > Axis.FixedCellCount) and (SafeMoveTop(TopRow-1, True) <> TopRow) then
        begin
//          HideDataRowMove; // DrawDataRowMove(FMoveRowLeftBounds, ClientWidth);   // hide the drag line
//          DragLineHidden := True;
          SafeMoveTop(TopRow-1);
  ///////////        ModifyScrollbar(ScrollBar, SB_LINEUP, 0, False);
          Update;
          CalcDrawInfo(DrawInfo);    // this changes contents of Axis var
        end;
        CellHit := Axis.FirstGridCell;
      end
      else if (Mouse >= Axis.FullVisBoundary) then
      begin
        if (SafeMoveTop(TopRow+1, True) <> TopRow) then
//          (CellHit >= Axis.LastFullVisibleCell) and
//          (CellHit < Axis.GridCellCount -1) then
        begin
  /////////        ModifyScrollBar(Scrollbar, SB_LINEDOWN, 0, False);
//          HideDataRowMove; //DrawDataRowMove(FMoveRowLeftBounds, ClientWidth);   // hide the drag line
//          DragLineHidden := True;
          SafeMoveTop(TopRow+1);
          Update;
          CalcDrawInfo(DrawInfo);    // this changes contents of Axis var
        end;
        CellHit := Axis.LastFullVisibleCell;
      end
      else if CellHit < 0 then
        CellHit := FMoveRowDest;
  //    if ((FGridState = gsColMoving) and CheckColumnDrag(FMoveDataRowIndex, CellHit, MousePt))
  //      or ((FGridState = gsRowMoving) and CheckRowDrag(FMoveDataRowIndex, CellHit, MousePt)) then
      if MoveSelectedDataRows(CellHit - TopDataOffset, TreeLevel, True) then
      begin
//        if not  DragLineHidden then
//        HideDataRowMove; //DrawDataRowMove(FMoveRowLeftBounds, ClientWidth);   // hide the drag line
        FMoveRowDest := CellHit;
        FMoveRowDestLevel := TreeLevel;
        DrawDataRowMove(LeftBounds, DrawInfo.Horz.FullVisBoundary);
        FMoveRowLeftBounds := LeftBounds;
      end;
    end
  end else if (CellHit <> FMoveRowDest) or
      (Mouse < Axis.FixedBoundary) or (Mouse > Axis.GridBoundary) then
    begin
      if (CellHit >= TopDataOffset + DataRowCount) or (Mouse > Axis.GridBoundary) then
      begin
        DrawDataRowMove(FMoveRowLeftBounds, DrawInfo.Horz.FullVisBoundary);   // hide the drag line
        MoveBy(FDataLink.RecordCount - FDataLink.ActiveRecord);
        MoveBy(1);
        DrawDataRowMove(FMoveRowLeftBounds, DrawInfo.Horz.FullVisBoundary);   // show the drag line
        CellHit := TopDataOffset + DataRowCount - 1;
        Update;
      end else if (CellHit < TopDataOffset) then
      begin
        DrawDataRowMove(FMoveRowLeftBounds, DrawInfo.Horz.FullVisBoundary);   // hide the drag line
        MoveBy(-FDataLink.ActiveRecord);
        MoveBy(-1);
        DrawDataRowMove(FMoveRowLeftBounds, DrawInfo.Horz.FullVisBoundary);   // show the drag line
        CellHit := TopDataOffset;
        Update;
      end;

      if MoveSelectedDataRows(CellHit - TopDataOffset, TreeLevel, True) then
      begin
        DrawDataRowMove(FMoveRowLeftBounds, DrawInfo.Horz.FullVisBoundary);   // hide the drag line
        FMoveRowDest := CellHit;
        FMoveRowDestLevel := TreeLevel;
        DrawDataRowMove(LeftBounds, DrawInfo.Horz.FullVisBoundary);
        FMoveRowLeftBounds := LeftBounds;
      end;
    end;
end;

function TCustomDBGridEh.DefaultMoveDataRows(BookmarkList: TBMListEh;
  ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  ActiveRecord, LookedOffset, LockedRecNo: Integer;
begin
  Result := False;
  if MemTableSupport then
    Result := FIntMemTable.MoveRecords(BookmarkList, ToRecNo, TreeLevel, CheckOnly)
  else if (DataSource <> nil) and (DataSource.DataSet <> nil) then
  begin
    LookedOffset := DataLink.ActiveRecord - (DataLink.RecordCount div 2) +
      ((DataLink.RecordCount + 1) mod 2) { - 1};
    ActiveRecord := DataLink.ActiveRecord;
    try
      DataLink.ActiveRecord := ActiveRecord - FLookedOffset;
      LockedRecNo := DataLink.DataSet.RecNo;
    finally
      DataLink.ActiveRecord := ActiveRecord;
    end;

    Result := Center.MoveRecords(Self, BookmarkList, ToRecNo, CheckOnly);
    if not CheckOnly then
    begin
      DataLink.DataSet.RecNo := LockedRecNo;
      MoveBy(LookedOffset);
    end;
  end;
end;

function TCustomDBGridEh.MoveDataRows(BookmarkList: TBMListEh;
  ToIndex: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  RecNo: Integer;
begin
  RecNo := DataRowToRecNo(ToIndex);
  if Assigned(OnMoveRecords)
    then Result := OnMoveRecords(Self, BookmarkList, RecNo, TreeLevel, CheckOnly)
    else Result := DefaultMoveDataRows(BookmarkList, RecNo, TreeLevel, CheckOnly);
end;

function TCustomDBGridEh.CalcLeftMoveLine(ARow: Integer; const MousePt: TPoint;
  var TreeLevel: Integer): Integer;
var
  ARect: TRect;
  PrevLevel, NextLevel, {PrevPos,} NextPos, CheckPos: Integer;
  FromDataRow, ToDataRow: Integer;
begin
  Result := 0;
  TreeLevel := -1;
  if not MemTableSupport or not FIntMemTable.MemTableIsTreeList then Exit;
  ARect := CellRect(IndicatorOffset, 0);
  FromDataRow := FMoveRowSour - TopDataOffset;
  ToDataRow := ARow - TopDataOffset;
  if (ToDataRow < 0) then ToDataRow := 0;
  if (ToDataRow >= DataRowCount) then ToDataRow := DataRowCount - 1;
  InstantReadRecordEnter(ToDataRow);
  try
    TreeLevel := FIntMemTable.GetTreeNodeLevel;
    PrevLevel := FIntMemTable.GetPrevVisibleTreeNodeLevel;
//    PrevPos := ARect.Left + PrevLevel * 18;
    NextLevel := FIntMemTable.GetNextVisibleTreeNodeLevel;
    if NextLevel <= 0 then NextLevel := 1;
    NextPos := ARect.Left + NextLevel * 18;
    Result := ARect.Left + TreeLevel * 18;
    if FromDataRow <= ToDataRow then
    begin
      if FromDataRow < ToDataRow then
      begin
        PrevLevel := TreeLevel;
        Result := NextPos;
        TreeLevel := NextLevel;
      end;
      CheckPos := NextPos;
    end else
      CheckPos := Result;
    if MousePt.X > CheckPos then
    begin
      TreeLevel := (MousePt.X - ARect.Left) div 18;
      if TreeLevel > PrevLevel + 1 then
        TreeLevel := PrevLevel + 1;
      Result := ARect.Left + TreeLevel * 18;
    end
  finally
    InstantReadRecordLeave;
  end;
end;

function TCustomDBGridEh.NeedBufferedPaint: Boolean;
begin
{ TODO : Return back }
//  Result := True;
  Result := DrawTitleByThemes or
            ( MemTableSupport and
              FIntMemTable.MemTableIsTreeList
              and (dgRowLines in Options)) or
            RowPanel.Active or
            UseMultiTitle;
end;

procedure TCustomDBGridEh.ExecuteFindDialog(Text, FieldName: String; Modal: Boolean);
begin
  if Center <> nil then
    Center.ExecuteFindDialog(Self, Text, FieldName, Modal)
  else
    ExecuteDBGridEhFindDialogProc(Self, Text, '', nil, Modal);
end;

procedure TCustomDBGridEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
//  if FRowDetailControl.ControlCount > 0 then
    Proc(FRowDetailControl);
end;

procedure TCustomDBGridEh.AncestorNotFound(Reader: TReader;
  const ComponentName: string; ComponentClass: TPersistentClass;
  var Component: TComponent);
begin
  if (ComponentName = 'RowDetailData') and (Reader.Root <> nil) then
    Component := FRowDetailControl;
end;

procedure TCustomDBGridEh.CreateComponent(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
begin
  if ComponentClass.InheritsFrom(TRowDetailPanelControlEh) then
//  if ComponentClass = TRowDetailPanelControlEh then
    Component := FRowDetailControl;
end;

procedure TCustomDBGridEh.ReadState(Reader: TReader);
var
  OldOnCreateComponent: TCreateComponentEvent;
  OldOnAncestorNotFound: TAncestorNotFoundEvent;
begin

  OldOnCreateComponent := Reader.OnCreateComponent;
  OldOnAncestorNotFound := Reader.OnAncestorNotFound;
  Reader.OnCreateComponent := CreateComponent;
  Reader.OnAncestorNotFound := AncestorNotFound;

  try
    inherited ReadState(Reader);
  finally
    Reader.OnCreateComponent := OldOnCreateComponent;
    Reader.OnAncestorNotFound := OldOnAncestorNotFound;
  end;
end;


{ THeadTreeNode }

function ExtractWordPos(N: Integer; const S: String; WordDelims: TCharSet;
  var Pos: Integer): String; forward;

constructor THeadTreeNode.Create;
begin
  inherited Create;
  Child := Nil; Next := Self; Host := nil; WIndent := 0;
end;

constructor THeadTreeNode.CreateText(AText: String; AHeight, AWidth: Integer);
begin
  Create;
  Text := AText; Height := AHeight; Width := AWidth;
end;

destructor THeadTreeNode.Destroy;
begin
  inherited;
  if (Host = nil) then
  begin
    FreeAllChild;
  end;
end;

function THeadTreeNode.Add(AAfter: THeadTreeNode; AText: String; AHeight, AWidth: Integer): THeadTreeNode;
var htLast, {htSelf,} th: THeadTreeNode;
begin
  if (Find(AAfter) = false)
    then raise Exception.Create('Node not in Tree');
  htLast := AAfter.Next;
//    while AAfter <> htLast.Next do htLast := htLast.Next; // find Last
  th := THeadTreeNode.CreateText(AText, AHeight, AWidth);
  th.Host := AAfter.Host;
  AAfter.Next := th;
  th.Next := htLast;
  Result := th;
end;

function THeadTreeNode.AddChild(ANode: THeadTreeNode; AText: String; AHeight, AWidth: Integer): THeadTreeNode;
var htLast, th: THeadTreeNode;
begin
  if (Find(ANode) = false) then raise Exception.Create('Node not in Tree');

  if (ANode.Child = nil) then
  begin
    th := THeadTreeNode.CreateText(AText, AHeight, AWidth);
    th.Host := ANode;
    ANode.Child := th;
  end else
  begin
    htLast := ANode.Child;
    while ANode.Child <> htLast.Next
      do htLast := htLast.Next;
    th := THeadTreeNode.CreateText(AText, AHeight, AWidth);
    th.Host := ANode;
    htLast.Next := th;
    th.Next := ANode.Child;
  end;
  Result := th;
end;

procedure THeadTreeNode.FreeAllChild;
var htLast, htm: THeadTreeNode;
begin
  if (Child = nil) then Exit;
  htLast := Child;

  while true do
  begin
    htLast.FreeAllChild;
    if (Child = htLast.Next)
      then begin htLast.Free; break; end;
    htm := htLast;
    htLast := htLast.Next;
    htm.Free;
  end;
  Child := nil;
end;

function THeadTreeNode.Find(ANode: THeadTreeNode): Boolean;
var
  htLast: THeadTreeNode;
begin
  Result := false;
//  if(Child  = nil) then Exit;
  htLast := Self;
  while True do
  begin
    if (htLast = ANode)
      then begin Result := true; break; end;
    if (htLast.Child <> nil) and (htLast.Child.Find(ANode) = true)
      then begin Result := true; break; end;
    if (Self = htLast.Next)
      then begin Result := false; break; end;
    htLast := htLast.Next;
  end;
end;

function THeadTreeNode.GetLevel: Integer;
var
  Node: THeadTreeNode;
begin
  Result := 0;
  Node := Self;
  while (Node.Host <> nil) do
  begin
    Node := Node.Host;
    Inc(Result);
  end;
end;

procedure THeadTreeNode.Union(AFrom, ATo: THeadTreeNode; AText: String; AHeight: Integer);
var
  th, tUn, TBeforFrom: THeadTreeNode;
  toFinded: Boolean;
  wid: Integer;
begin
  if (Find(AFrom) = false)
    then raise Exception.Create('Node not in Tree');
  toFinded := True;
  if (AFrom <> ATo) then //new
  begin
    th := AFrom; toFinded := false;
    while AFrom.HOst.Child <> th.Next do
    begin
      if (th.Next = ATo)
        then begin toFinded := true; break; end;
      th := th.Next;
    end;
  end;

  if (toFinded = false)
    then raise Exception.Create('ATo not in level');

  tUn := ATo.Add(ATo, AText, AHeight, 0);
  tUn.VLineWidth := ATo.VLineWidth;
  TBeforFrom := AFrom.Host.Child;
  while TBeforFrom.Next <> AFrom
    do TBeforFrom := TBeforFrom.Next;

  TBeforFrom.Next := tUn;

  th := AFrom; tUn.Child := AFrom;
  if (th = AFrom.Host.Child)
    then AFrom.Host.Child := tUn;
  Wid := 0;
  while th <> ATo.Next do
  begin
    Inc(Wid, th.Width);
    Inc(Wid, tUn.VLineWidth);
    Dec(th.Height, AHeight);
    th.Host := TUn;
    th := th.Next;
  end;
  if (tUn.VLineWidth > 0) then Dec(Wid, tUn.VLineWidth);
  ATo.Next := AFrom;
  tUn.Width := Wid;
end;

procedure THeadTreeNode.CreateFieldTree(AGrid: TCustomDBGridEh);
var
  i, apos, j: Integer;
  node, nodeFrom, nodeTo: THeadTreeNode;
  ss, ss1: String;
  sameWord, GroupDid: Boolean;
begin
  FreeAllChild;

  for i := 0 to AGrid.Columns.Count - 1 do
  begin
    node := AddChild(Self, AGrid.Columns[i].Title.Caption,
      AGrid.RowHeights[0],
      iif(AGrid.Columns[i].Visible, AGrid.Columns[i].FullWidth, iif(dgColLines in AGrid.Options, -1, 0)));
    node.Column := AGrid.Columns[i];
    if (AGrid.Columns[i].Title.SortMarker <> smNoneEh) then node.WIndent := 16;
    if (dgColLines in AGrid.Options)
      then node.VLineWidth := 1
      else node.VLineWidth := 0;
    AGrid.FLeafFieldArr[i].FLeaf := node;
  end;

  nodeTo := nil;
  // Group
  while True do //for k := 0 to ListNodeField.Count - 1 do begin
  begin
    GroupDid := false;
    for i := 0 to AGrid.Columns.Count - 1 do
    begin
      ss1 := ExtractWordPos(2, AGrid.FLeafFieldArr[i].FLeaf.Text, ['|'], apos);
     //napos := Pos('|',AGrid.FLeafFieldArr[i].FLeaf.Text);
      if {napos <> 0}  ss1 <> '' then
      begin
       //nInc(apos);
        ss1 := ExtractWord(1, AGrid.FLeafFieldArr[i].FLeaf.Text, ['|']);
        nodeFrom := AGrid.FLeafFieldArr[i].FLeaf;
                           //      sameWord := false;
        sameWord := True;
        for j := i to AGrid.Columns.Count - 1 do
        begin
          if (AGrid.Columns.Count - 1 > j) and
            (ExtractWord(1, AGrid.FLeafFieldArr[j + 1].FLeaf.Text, ['|']) = ss1) then
          begin
            ss := AGrid.FLeafFieldArr[j].FLeaf.Text;
            Delete(ss, 1, apos - 1);
            AGrid.FLeafFieldArr[j].FLeaf.Text := ss;
            sameWord := true;
            GroupDid := true;
          end else
          begin
            if (sameWord = true) then
            begin
              ss := AGrid.FLeafFieldArr[j].FLeaf.Text;
              Delete(ss, 1, apos - 1);
 //            TLeafField(ListNodeField.Items[j]).Field.DisplayLabel := ss;
              AGrid.FLeafFieldArr[j].FLeaf.Text := ss;
              nodeTo := AGrid.FLeafFieldArr[j].FLeaf;
              GroupDid := true;
            end;
            Break;
          end;
        end;
        if (sameWord = true) and (nodeFrom.GetLevel = nodeTo.GetLevel) then
        begin
          Union(nodeFrom, nodeTo, ss1, 20);
          Break;
        end;
      end; //if
    end; //i
    if (GroupDid = false) then break;
  end; //k
end;

procedure THeadTreeNode.DoForAllNode(proc: THeadTreeProc);
var htLast: THeadTreeNode;
begin
  if (Child = nil) then Exit;
  htLast := Child;
  while True do
  begin
    proc(htLast);
    if (htLast.Child <> nil)
      then htLast.DoForAllNode(proc);
    if (Child = htLast.Next)
      then begin break; end;
    htLast := htLast.Next;
  end;
end;

function WordPosition(const N: Integer; const S: string; WordDelims: TCharSet): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do
  begin
    { skip over delimiters }
//  while (I <= Length(S)) and (S[I] in WordDelims) do Inc(I);
    while (I <= Length(S)) and (
{$IFNDEF CIL}
      (ByteType(S, I) = mbSingleByte) and
{$ENDIF}
      CharInSetEh(S[I], WordDelims)) do Inc(I);
    { if we're not beyond end of S, we're at the start of a word }
    if I <= Length(S) then Inc(Count);
    { if not finished, find the end of the current word }
    if Count <> N then
//    while (I <= Length(S)) and not (S[I] in WordDelims) do Inc(I)
      while (I <= Length(S)) and not (
{$IFNDEF CIL}
        (ByteType(S, I) = mbSingleByte) and
{$ENDIF}
        CharInSetEh(S[I], WordDelims)) do Inc(I)
    else Result := I;
  end;
end;

function ExtractWord(N: Integer; const S: string; WordDelims: TCharSet): string;
var
  I: Word;
  Len: Integer;
begin
  Result := '';
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  if I <> 0 then
    { find the end of the current word }
//  while (I <= Length(S)) and not(S[I] in WordDelims) do begin
    while (I <= Length(S)) and not (
{$IFNDEF CIL}
      (ByteType(S, I) = mbSingleByte) and
{$ENDIF}
      CharInSetEh(S[I], WordDelims)) do
    begin
      { add the I'th character to result }
      Inc(Len);
//      SetLength(Result, Len);
//      Result[Len] := S[I];
      Result := Result + S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

function ExtractWordPos(N: Integer; const S: string; WordDelims: TCharSet; var Pos: Integer): string;
var
  I, Len: Integer;
begin
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  Pos := I;
  Result := '';
  if I <> 0 then
    { find the end of the current word }
//  while (I <= Length(S)) and not(S[I] in WordDelims) do begin
    while (I <= Length(S)) and not (
{$IFNDEF CIL}
    (ByteType(S, I) = mbSingleByte) and
{$ENDIF}
    CharInSetEh(S[I], WordDelims)) do
    begin
      { add the I'th character to result }
      Inc(Len);
//      SetLength(Result, Len);
//      Result[Len] := S[I];
      Result := Result + S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

procedure TCustomDBGridEh.SetDrawMemoText(const Value: Boolean);
begin
  FDrawMemoText := Value;
  Invalidate;
end;

procedure TCustomDBGridEh.SetDrawGraphicData(const Value: Boolean);
begin
  FDrawGraphicData := Value;
  Invalidate;
end;

procedure TCustomDBGridEh.GetCellParams(Column: TColumnEh; AFont: TFont;
  var Background: TColor; State: TGridDrawState);
begin
  if Assigned(FOnGetCellParams) then
    FOnGetCellParams(Self, Column, AFont, Background, State);
end;

procedure TCustomDBGridEh.InvalidateFooter;
var i: Integer;
begin
  for i := 0 to FooterRowCount - 1 do begin
    GridInvalidateRow(Self, FullRowCount - i - 1);
  end;
end;

procedure TCustomDBGridEh.InvalidateTitle;
var
  i: Integer;
begin
  for i := 0 to TopDataOffset - 1 do GridInvalidateRow(Self, i);
end;

procedure TCustomDBGridEh.SetSumList(const Value: TDBGridEhSumList);
begin
  FSumList.Assign(Value);
end;

procedure TCustomDBGridEh.SumListChanged(Sender: TObject);
begin
  InvalidateFooter;
end;

function TCustomDBGridEh.CellRect(ACol, ARow: Integer): TRect;
begin
  Result := inherited CellRect(ACol, ARow);
end;

procedure TCustomDBGridEh.GetFooterParams(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Assigned(FOnGetFooterParams) then
    FOnGetFooterParams(Self, DataCol, Row, Column, AFont, Background, Alignment, State, Text);
end;

procedure TCustomDBGridEh.DefaultDrawFooterCell(const Rect: TRect; DataCol,
  Row: Integer; Column: TColumnEh; State: TGridDrawState);
var
  Value: string;
  NewBackgrnd: TColor;
  NewAlignment: TAlignment;
  XFrameOffs, YFrameOffs: Integer;
  ARect: TRect;
begin
  ARect := Rect;
  if (dghFooter3D in OptionsEh) then
  begin
    XFrameOffs := 1;
    InflateRect(ARect, -1, -1);
  end
  else XFrameOffs := 2;
  YFrameOffs := XFrameOffs;
  if Flat then Dec(YFrameOffs);
  Value := GetFooterValue(Row, Column);
  NewBackgrnd := Canvas.Brush.Color;
  NewAlignment := Column.Footer.Alignment;
//  Value := GetFooterValue(Row, Column);

  GetFooterParams(DataCol, Row, Column, Font,
    NewBackgrnd, NewAlignment, State, Value);

  Canvas.Brush.Color := NewBackgrnd;

  WriteTextEh(Canvas, ARect, True, XFrameOffs, YFrameOffs, Value,
    Column.Footer.Alignment, Column.Layout, Column.Footer.WordWrap and FAllowWordWrap,
    Column.Footer.EndEllipsis, 0, 0, Column.UseRightToLeftReading);
end;

function TCustomDBGridEh.GetFooterValue(Row: Integer; Column: TColumnEh): String;
const
  SumListArray: array[TFooterValueType] of TGroupOperation =
  (goSum, goSum, goAvg, goCount, goSum, goSum);
var
  FmtStr: string;
  Format: TFloatFormat;
  Digits: Integer;
  v: Variant;
  Field: TField;
  Footer: TColumnFooterEh;
begin
  Result := '';
  Field := nil;
  Footer := Column.UsedFooter(Row);
  case Footer.ValueType of
    //fgoNon: FillRect(ARect);
    fvtSum, fvtAvg:
      begin
        Result := '0';
        if Assigned(DataSource) and Assigned(DataSource.DataSet)
          then if Footer.FieldName <> ''
          then Field := DataSource.DataSet.FindField(Footer.FieldName)
          else Field := DataSource.DataSet.FindField(Column.FieldName);
        if Field = nil then Exit;
        with Field do
        begin
          v := SumList.SumCollection.GetSumByOpAndFName(SumListArray[Footer.ValueType], FieldName).SumValue;
          case DataType of
            ftSmallint, ftInteger, ftAutoInc, ftWord, ftLargeInt:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else with Field as TNumericField do
              begin
                FmtStr := DisplayFormat;
                if FmtStr = ''
                  then Result := IntToStr(Integer(v))
                  else Result := FormatFloat(FmtStr, v);
              end;
            ftBCD:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              with Field as TBCDField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := CurrencyDecimals;
                  end
                  else begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
{$IFDEF EH_LIB_6}
            ftFMTBcd:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              with Field as TFMTBCDField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := CurrencyDecimals;
                  end
                  else begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
{$ENDIF}
            ftFloat, ftCurrency:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              with Field as TFloatField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := CurrencyDecimals;
                  end
                  else begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := FloatToStrF(v, Format, Precision, Digits);
                end else
                  Result := FormatFloat(FmtStr, v);
              end;
{ SumList does not support TDateTime as SumValue is Currency }
{              ftDate, ftTime, ftDateTime:
              begin
                if Footer.DisplayFormat <> '' then
                  FmtStr := Footer.DisplayFormat
                else
                  case DataType of
                    ftDate: FmtStr := ShortDateFormat;
                    ftTime: FmtStr := LongTimeFormat;
                  end;
                DateTimeToString(Result, FmtStr, TDateTime(v));
              end;}
          end;
        end;
        {Result := FloatToStr(SumList.SumCollection.GetSumByOpAndFName(goSum,Column.FieldName).SumValue);}
      end;
    fvtCount:
      if Footer.DisplayFormat <> '' then
        Result := FormatFloat(Footer.DisplayFormat, SumList.SumCollection.GetSumByOpAndFName(goCount, '').SumValue)
      else
        Result := FloatToStr(SumList.SumCollection.GetSumByOpAndFName(goCount, '').SumValue);
    fvtFieldValue:
      if Assigned(DataSource) and Assigned(DataSource.DataSet) and
        DataSource.DataSet.Active and (Footer.FieldName <> '')
      then
        Result := FormatFieldDisplayValue(DataSource.DataSet.FieldByName(Footer.FieldName), Footer.DisplayFormat);
    fvtStaticText: Result := Footer.Value;
  end;
end;

procedure TCustomDBGridEh.SumListRecalcAll(Sender: TObject);
begin
  if Assigned(FOnSumListRecalcAll) then
    FOnSumListRecalcAll(SumList);
end;

procedure TCustomDBGridEh.SumListAfterRecalcAll(Sender: TObject);
begin
  if Assigned(FOnSumListAfterRecalcAll) then
    FOnSumListAfterRecalcAll(SumList);
end;
procedure TCustomDBGridEh.SetHorzScrollBar(const Value: TDBGridEhScrollBar);
begin
  FHorzScrollBar.Assign(Value);
end;

procedure TCustomDBGridEh.SetVertScrollBar(const Value: TDBGridEhScrollBar);
begin
  FVertScrollBar.Assign(Value);
end;

function TCustomDBGridEh.VisibleDataRowCount: Integer;
begin
  Result := VisibleRowCount;
  if FooterRowCount <= 0 then Exit;
//  Result := Result - FooterRowCount - 1;
//  if Result < 1 then Result := 1;
end;

function TCustomDBGridEh.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.ExecuteAction(Action);
  if not Result and Focused then
  begin
    if (Action is TEditCopy) and (geaCopyEh in EditActions) and
      CheckCopyAction then
    begin
      DBGridEh_DoCopyAction(Self, False);
      Result := True;
    end
    else if (Action is TEditPaste) and (geaPasteEh in EditActions) and
      CheckPasteAction then
    begin
      DBGridEh_DoPasteAction(Self, False);
      Result := True;
    end
    else if (Action is TEditCut) and (geaCutEh in EditActions) and
      CheckCutAction then
    begin
      DBGridEh_DoCutAction(Self, False);
      Result := True;
    end
{$IFDEF EH_LIB_5}
    else if (Action is TEditSelectAll) and (geaSelectAllEh in EditActions) and
      CheckSelectAllAction then
    begin
      Selection.SelectAll;
      Result := True;
    end
    else if (Action is TEditDelete) and (geaDeleteEh in EditActions) and
      CheckDeleteAction then
    begin
      DBGridEh_DoDeleteAction(Self, False);
      Result := True;
    end;
{$ENDIF}
  end;
end;

function TCustomDBGridEh.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.UpdateAction(Action);
  if not Result and Focused then
  begin
    if (Action is TEditCopy) and (geaCopyEh in EditActions) then
    begin
      TEditCopy(Action).Enabled := CheckCopyAction;
      Result := True;
    end
    else if (Action is TEditPaste) and (geaPasteEh in EditActions) then
    begin
      TEditPaste(Action).Enabled := CheckPasteAction;
      Result := True;
    end
    else if (Action is TEditCut) and (geaCutEh in EditActions) then
    begin
      TEditCut(Action).Enabled := CheckCutAction;
      Result := True;
    end
{$IFDEF EH_LIB_5}
    else if (Action is TEditSelectAll) and (geaSelectAllEh in EditActions) then
    begin
      TEditSelectAll(Action).Enabled := CheckSelectAllAction;
      Result := True;
    end
    else if (Action is TEditDelete) and (geaDeleteEh in EditActions) then
    begin
      TEditDelete(Action).Enabled := CheckDeleteAction;
      Result := True;
    end;
{$ENDIF}
  end;
end;

function TCustomDBGridEh.CheckCopyAction: Boolean;
begin
  Result := FDatalink.Active {and (Selection.SelectionType <> gstNon)};
end;

function TCustomDBGridEh.CheckPasteAction: Boolean;
begin
  Result := FDatalink.Active and not ReadOnly and
    FDatalink.DataSet.CanModify and (
    Clipboard.HasFormat(CF_VCLDBIF) or
    Clipboard.HasFormat(CF_TEXT));
  if Result then
    if (FDatalink.DataSet.State <> dsInsert) and
      not (alopUpdateEh in AllowedOperations) then
      Result := False;
end;

function TCustomDBGridEh.CheckCutAction: Boolean;
begin
  Result := CheckCopyAction and CheckDeleteAction;
end;

function TCustomDBGridEh.CheckSelectAllAction: Boolean;
begin
  Result := FDatalink.Active and not FDatalink.DataSet.IsEmpty and (gstAll in AllowedSelections);
end;

function TCustomDBGridEh.CheckDeleteAction: Boolean;
begin
  Result := FDatalink.Active and not ReadOnly and not FDatalink.DataSet.IsEmpty and
    FDatalink.DataSet.CanModify and
    (
    ((Selection.SelectionType in [gstRecordBookmarks, gstAll]) and
    (alopDeleteEh in AllowedOperations))
    or
    ((Selection.SelectionType in [gstRectangle, gstColumns]) and
    (alopUpdateEh in AllowedOperations))
    );
end;

procedure TCustomDBGridEh.TimerScroll;
var
  Delta, Distance, Interval, DeltaX, DistanceX: Integer;
  ADataRect: Trect;
  WithSeleting: Boolean;
  Point: TPoint;
begin
  if FDBGridEhState = dgsColSelecting then
  begin
    GetCursorPos(Point);
    Point := ScreenToClient(Point);
//    Point := FMousePos;
    ADataRect := DataRect;
    if Point.X > ADataRect.Right then
    begin
      (*if Selection.Columns.FShiftCol.Index+1 < Columns.Count then
        if Selection.Columns.IndexOf(Columns[RawToDataColumn(LeftCol + VisibleColCount-1)]) = -1 then
          Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol + VisibleColCount-1)],True);
      if Selection.Columns.FShiftCol.Index+1 < Columns.Count then
         Selection.Columns.SelectShift(Columns[Selection.Columns.FShiftCol.Index+1],True);

      while RawToDataColumn(LeftCol + VisibleColCount) < Selection.Columns.FShiftCol.Index+1 do LeftCol := LeftCol + 1;*)
      if LeftCol + VisibleColCount {+ FixedCols - 1} < ColCount then
      begin
        LeftCol := LeftCol + 1;
        if LeftCol + VisibleColCount + FixedCols < ColCount
          then Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol + VisibleColCount + FixedCols)] {,True})
          else Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol + VisibleColCount - 1)] {,True});
      end
      else
        Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol + VisibleColCount - 1)] {,True});
      Interval := 200 - (Point.X - ADataRect.Right) * 10;
      if Interval < 0 then Interval := 0;
      ResetTimer(Interval);
    end
    else if Point.X < ADataRect.Left then
    begin
      (*if Selection.Columns.FShiftCol.Index > 0 then
        if Selection.Columns.IndexOf(Columns[RawToDataColumn(LeftCol)]) = -1 then
          Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol)],True);
      if Selection.Columns.FShiftCol.Index - 1 >= 0 then
         Selection.Columns.SelectShift(Columns[Selection.Columns.FShiftCol.Index-1],True);

      while RawToDataColumn(LeftCol) > Selection.Columns.FShiftCol.Index do LeftCol := LeftCol - 1;*)
      if LeftCol > FixedCols then
      begin
        LeftCol := LeftCol - 1;
        if LeftCol > FixedCols
          then Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol - 1)] {,True})
          else Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol)] {,True});
      end
      else
        Selection.Columns.SelectShift(Columns[RawToDataColumn(LeftCol)] {,True});

      Interval := 200 - (ADataRect.Left - Point.X) * 10;
      if Interval < 0 then Interval := 0;
      ResetTimer(Interval);
    end
  end else
  begin
    Delta := 0;
    Distance := 0;
    ADataRect := DataRect;
    if FDownMousePos.Y < ADataRect.Top then
    begin
      Delta := -1;
      Distance := ADataRect.Top - FDownMousePos.Y;
    end;
    if FDownMousePos.Y >= ADataRect.Bottom then
    begin
      Delta := 1;
      Distance := FDownMousePos.Y - ADataRect.Bottom + 1;
    end;

    DeltaX := 0;
    DistanceX := 0;
    if not UseRightToLeftAlignment and (FDownMousePos.X < ADataRect.Left) or
           UseRightToLeftAlignment and (FDownMousePos.X >= ADataRect.Right) then
    begin
      DeltaX := -1;
      DistanceX := ADataRect.Left - FDownMousePos.X;
    end;
    if not UseRightToLeftAlignment and (FDownMousePos.X >= ADataRect.Right) or
           UseRightToLeftAlignment and (FDownMousePos.X < ADataRect.Left) then
    begin
      DeltaX := 1;
      DistanceX := FDownMousePos.X - ADataRect.Right;
    end;
    Distance := Max(Distance, DistanceX);
    WithSeleting := ssLeft in FMouseShift;

    if (Delta = 0) and (DeltaX = 0)
      then StopTimer
    else
    begin
      BeginUpdate;
      try
        if (Delta <> 0) and not (FDBGridEhState = dgsRectSelecting) then
        begin
           {if (dgMultiSelect in Options) then}
          DoSelection(WithSeleting, iif(Distance div 6 > 8, 8, Distance div 6) * Delta, False, True);
        end;
        if (DeltaX <> 0) and FDataTracking then
  //        if dgRowSelect in Options then begin
          if (DeltaX < 0) and (LeftCol > FixedCols) then
            LeftCol := LeftCol + DeltaX
          else if (DeltaX > 0) and (VisibleColCount + LeftCol < ColCount) then
            LeftCol := LeftCol + DeltaX;
  //        end else
        if FDBGridEhState <> dgsRowSelecting then
          if DeltaX > 0
            then MoveCol(RawToDataColumn(Col + DeltaX), 1, False)
            else MoveCol(RawToDataColumn(Col + DeltaX), -1, False);
        if (FDBGridEhState = dgsRectSelecting) then
        begin
          MoveBy(iif(Distance div 6 > 8, 8, Distance div 6) * Delta);
          if (DeltaX < 0) and (LeftCol = FixedCols)
            then Selection.Rect.Select(RawToDataColumn(IndicatorOffset), DataSource.DataSet.Bookmark, True)
            else Selection.Rect.Select(RawToDataColumn(Col), DataSource.DataSet.Bookmark, True)
        end;
      finally
        EndUpdate;
      end;
      if UpdateLock = 0 then Update;
      Interval := 200 - Distance * 15;
      if Interval < 0 then Interval := 0;
////    KillTimer(Handle, 1);//??????
////    SetTimer(Handle, 1, Interval, nil);
      ResetTimer(Interval);
////    FTimerActive := True;
    end;
  end;
end;

procedure TCustomDBGridEh.StopTimer;
begin
  if FTimerActive then
  begin
    KillTimer(Handle, 1);
    FTimerActive := False;
    FTimerInterval := -1;
  end;
end;

procedure TCustomDBGridEh.ResetTimer(Interval: Integer);
begin
  if FTimerActive = False then
    SetTimer(Handle, 1, Interval, nil)
  else if Interval <> FTimerInterval then
  begin
    StopTimer;
    SetTimer(Handle, 1, Interval, nil);
    FTimerInterval := Interval;
  end;
  FTimerActive := True;
end;

function TCustomDBGridEh.DataRect: TRect;
begin
  Result := BoxRect(IndicatorOffset, TopDataOffset, FullColCount - 1, RowCount-1);
//    iif(FooterRowCount > 0, RowCount - FooterRowCount - 2, RowCount));
end;

function TCustomDBGridEh.DataBox: TGridRect;
begin
  Result.Left := IndicatorOffset;
  Result.Top := TopDataOffset;
  Result.Right := FullColCount - 1;
//  Result.Bottom := iif(FooterRowCount > 0, RowCount - FooterRowCount - 2, RowCount);
  Result.Bottom := RowCount-1;
end;

procedure TCustomDBGridEh.DoSortMarkingChanged;
begin
  if (dghAutoSortMarking in OptionsEh) then
    if Assigned(FOnSortMarkingChanged)
      then FOnSortMarkingChanged(Self)
      else DefaultApplySorting;
end;

procedure TCustomDBGridEh.SetSortMarkedColumns;
var i: Integer;
begin
  SortMarkedColumns.Clear;
  for i := 0 to Columns.Count - 1 do
    if Columns[i].Title.SortIndex > 0 then
    begin
      if SortMarkedColumns.Count < Columns[i].Title.SortIndex then
        SortMarkedColumns.Count := Columns[i].Title.SortIndex;
      SortMarkedColumns[Columns[i].Title.SortIndex - 1] := Columns[i];
    end;
end;

procedure TCustomDBGridEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if FSortMarking and (Key = 17) then
  begin
    FSortMarking := False;
    DoSortMarkingChanged;
  end;
{  if (Key = VK_SHIFT) and (FSelectionAnchorState = sasAltMouseEh) then
  begin
    RangeToBookmarks(FSelectionAnchor, FCurrentRecordBookmark, FSelectionAnchorSelected);
    FSelectionAnchorState := sasNonEh;
  end;
}
  inherited KeyUp(Key, Shift);
end;

procedure TCustomDBGridEh.TopLeftChanged;

  procedure InvalidateTitle;
  var i: Integer;
  begin
    for i := 0 to TopDataOffset - 1 do GridInvalidateRow(Self, i);
  end;

  function LastVisibleCellFor(ForTop: Integer): Integer;
  var
    DrawInfo: TGridDrawInfoEh;
    i: Integer;
    RowsHeight, DataHeight: Integer;
  begin
    CalcDrawInfo(DrawInfo);
    DataHeight := DrawInfo.Vert.GridExtent - DrawInfo.Vert.FixedBoundary;
    RowsHeight := 0;
    Result := 0;
    for i := ForTop to DrawInfo.Vert.GridCellCount - 1 do
    begin
      Inc(RowsHeight, DrawInfo.Vert.GetExtent(I) +
                        DrawInfo.Vert.EffectiveLineWidth);
      if RowsHeight > DataHeight then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
var
  RowToInvalidate: Integer;
begin
  if FTopLeftVisible then
  begin
    if (LeftCol <> FixedCols) then
    begin
      InvalidateTitle;
      FTopLeftVisible := False;
    end;
  end
  else
    if (LeftCol = FixedCols) then
    begin
      InvalidateTitle;
      FTopLeftVisible := True;
    end;
  inherited TopLeftChanged;
  UpdateHorzExtScrollBar;
  if ViewScroll then
    FetchRecordsInView;
  UpdateFilterEdit(False);
  if (FIntMemTable <> nil) and FIntMemTable.MemTableIsTreeList and
    (TopRow > FOldTopLeft.Y) then
  begin
    RowToInvalidate := LastVisibleCellFor(FOldTopLeft.Y);
    GridInvalidateRow(Self, RowToInvalidate);
  end;

  if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
  if RowDetailPanel.Visible then
    UpdateRowDetailPanel;
  FOldTopLeft.X := LeftCol;
  FOldTopLeft.Y := TopRow;
end;

{CM messages processing}

procedure TCustomDBGridEh.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if Assigned(FDataLink.DataSet) and
     FDataLink.DataSet.Modified and
     (Msg.CharCode = VK_ESCAPE) then Msg.Result := 1;
end;

procedure TCustomDBGridEh.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  ClearButtonsBitmapCache;
end;

procedure TCustomDBGridEh.CMParentFontChanged(var Message: TCMParentFontChanged);
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      TitleFont := Font;
    finally
      FSelfChangingTitleFont := False;
    end;
    FSelfChangingFooterFont := True;
    try
      FooterFont := Font;
    finally
      FSelfChangingFooterFont := False;
    end;
    LayoutChanged;
  end;
end;

procedure TCustomDBGridEh.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  if ParentColor then
  begin
    FFooterColor := Color;
    Invalidate;
  end;
end;

procedure TCustomDBGridEh.CMMouseWheel(var Message: TCMMouseWheel);
var
{$IFDEF CIL}
  Temp: TMessage;
{$ENDIF}
  WheelControl: TControl;
begin
{$IFDEF CIL}
  // { TODO : TWinControlCracker().DoMouseWheel }
{$ELSE}
  if InplaceEditorVisible and TDBGridInplaceEdit(InplaceEditor).FListVisible then
    with Message do
//      if TDBGridInplaceEdit(InplaceEditor).FActiveList.Perform(CM_MOUSEWHEEL, WParam, LParam) <> 0 then
      if TWinControlCracker(TDBGridInplaceEdit(InplaceEditor).FActiveList).
        DoMouseWheel(ShiftState, WheelDelta, SmallPointToPoint(Pos)) then
      begin
        Result := 1;
        Exit;
      end;
{$ENDIF}

  if FilterEditMode then
    WheelControl := FilterEdit
  else if FInTitleFilterListboxVisible then
    WheelControl := FInTitleFilterListbox
  else
    WheelControl := nil;

{$IFDEF CIL}
  Temp := UnwrapMessage(Message);
  if WheelControl <> nil
    then WheelControl.WindowProc(Temp)
{$ELSE}
  if WheelControl <> nil
    then WheelControl.WindowProc(TMessage(Message))
{$ENDIF}
  else
    inherited;
end;

procedure TCustomDBGridEh.CMMouseLeave(var Message: TMessage);
var
  AHotTrackCell: TGridCoord;
begin
  inherited;
  if dghHotTrack in OptionsEh then
    if FHotTrackCell.Y > 0 then
    begin
      AHotTrackCell := FHotTrackCell;
      FHotTrackCell.Y := -1;
      FHotTrackCell.X := -1;
      GridInvalidateRow(Self, AHotTrackCell.Y);
    end;
end;

procedure TCustomDBGridEh.CMHintsShowPause(var Message: TCMHintShowPause);
var
  Cell: TGridCoord;
  Column: TColumnEh;
  ACellRect: TRect;
  PauseLoc: Integer;
  Processed: Boolean;
  InCellCursorPos: TPoint;
begin
  with Message do
  begin
    Cell := MouseCoord(HitTest.X, HitTest.Y);
    if (Cell.X < IndicatorOffset) or (Cell.Y < 0) then Exit;
    Column := Columns[RawToDataColumn(Cell.X)];
    ACellRect := CellRect(Cell.X, Cell.Y);
    InCellCursorPos :=
      Point(HitTest.X-ACellRect.TopLeft.X, HitTest.Y-ACellRect.TopLeft.Y);
    Processed := False;
    PauseLoc := Application.HintPause;
    if Assigned(FOnHintShowPause) then
      OnHintShowPause(Self, HitTest, Cell, InCellCursorPos, Column, PauseLoc, Processed);
    if not Processed and Assigned(Column) and Assigned(Column.FOnHintShowPause) then
      Column.OnHintShowPause(Self, HitTest, Cell, InCellCursorPos, Column, PauseLoc, Processed);
    if not Processed  then
      if ((Cell.Y > RowCount - 1) and (FooterRowCount > 0) and Column.UsedFooter(Cell.Y - RowCount).ToolTips ) or
        ((Cell.Y >= TopDataOffset) and (Cell.Y < DataRowCount + TopDataOffset) and DataLink.Active and Column.ToolTips) or
        ((Cell.Y = GetTitleRows - 1) and Column.Title.ToolTips and (Column.Title.Hint = ''))
        then PauseLoc := 0
        else PauseLoc := Application.HintPause;

{$IFDEF CIL}
    Pause := PauseLoc;
{$ELSE}
    Pause^ := PauseLoc;
{$ENDIF}
  end;
end;

procedure TCustomDBGridEh.DefaultFillDataHintShowInfo(CursorPos: TPoint;
  Cell: TGridCoord; Column: TColumnEh; var Params: TDBGridEhDataHintParams);

var
  TextWidth, DataRight, RightIndent, HitTestX1, EmptyVar: Integer;
  ARect: TRect;
  s: String;
  AAlignment: TAlignment;
  WordWrap: Boolean;
  IsDoShowHint: Boolean;
  TopIndent: Integer;
  ACellRect: TRect;
//  DataRect: TRect;

  function GetToolTipsColumnText(Column: TColumnEh): String;
  var KeyIndex: Integer;
  begin
    Result := '';
    if Column.GetColumnType in [ctKeyImageList, ctCheckboxes] then
    begin
      if Column.GetColumnType = ctKeyImageList
        then KeyIndex := Column.KeyList.IndexOf(Column.Field.Text)
      else KeyIndex := Integer(Column.CheckboxState);
      if (KeyIndex > -1) and (KeyIndex < Column.PickList.Count)
        then Result := Column.PickList.Strings[KeyIndex];
    end
    else if Column.Field <> nil
      then Result := Column.DisplayText;
  end;

begin
  HitTestX1 := HitTest.X;
  s := GetToolTipsColumnText(Column);
  ARect := Params.CursorRect;
  ACellRect := ARect;
{  ACellRect := CellRect(Cell.X, Cell.Y);
  if RowPanel.Active then
  begin
    DataRect := Rect(Column.FRowPlacement.DataCellLeft, Column.FRowPlacement.Top,
      Column.FRowPlacement.DataCellLeft+Column.FRowPlacement.DataCellWidth,
      Column.FRowPlacement.Top+Column.FRowPlacement.Height);
    OffsetRect(DataRect, ACellRect.Left, ACellRect.Top);
    OffsetRect(DataRect, -FDataOffset.cx, 0);
    ACellRect := DataRect;
  end;}

  if Column.AlwaysShowEditButton then
  begin
    DataRight := ACellRect.Left + Column.Width - Column.EditButtonsWidth;
//    DataRight := ARect.Rigth - Column.EditButtonsWidth;
    if DataRight < ARect.Right then
      ARect.Right := DataRight;
    if HitTestX1 > ARect.Right then s := '';
  end else
    DataRight := ACellRect.Left + Column.Width;

  if Column = VisibleColumns[0] then
  begin
    Inc(ARect.Left, GetCellTreeElmentsAreaWidth);
    if RowDetailPanel.Active then
      Inc(ARect.Left, 18);
  end;
  if (Column.ImageList <> nil) and Column.ShowImageAndText then
    Inc(ARect.Left, Column.ImageList.Width + 5);
(*{$IFDEF CIL}
  if Message.HintInfo.CursorPos.X < ARect.Left then
    s := '';
{$ELSE}
  if Message.HintInfo^.CursorPos.X < ARect.Left then
    s := '';
{$ENDIF}*)

  AAlignment := Column.Alignment;
  if Column.GetColumnType in [ctKeyImageList, ctCheckboxes] then
    AAlignment := taLeftJustify;
  WordWrap := Column.WordWrap and Column.CurLineWordWrap(ACellRect.Bottom-ACellRect.Top);
  if FHintFont = nil then
    FHintFont := TFont.Create;

  FHintFont.Assign(Column.Font);
  //NoBackgrnd := Canvas.Brush.Color;
  //State := [];

  Column.FillColCellParams(FColCellParamsEh);
  with FColCellParamsEh do
  begin
    FBackground := Canvas.Brush.Color;
    FFont := FHintFont;
    FState := [];
    FAlignment := AAlignment;
    FText := s;
    FCol := Cell.X;
    FRow := Cell.Y;
    GetCellParams(Column, FFont, FBackground, FState);
    Column.GetColCellParams(False, FColCellParamsEh);
    s := FText;
    AAlignment := FAlignment;
  end;

  Canvas.Font.Assign(FHintFont);

  if WordWrap then RightIndent := 2 else RightIndent := 0;
  if Column.GetColumnType in [ctKeyImageList, ctCheckboxes]
    then IsDoShowHint := True
    else IsDoShowHint := CheckHintTextRect(Self.DrawTextBiDiModeFlagsReadingOnly,
                        Self.Canvas, RightIndent, FInterlinear,
                        s, ARect, WordWrap, TextWidth, EmptyVar);

  if Flat then TopIndent := 2 else TopIndent := 1;

  if IsDoShowHint or ((AAlignment = taRightJustify) and (DataRight - 2 > ARect.Right)) then
  begin
    Params.HintStr := s;
    Params.CursorRect := ARect;
    case AAlignment of
      taLeftJustify:
        Params.HintPos := Point(ARect.Left - 1, ARect.Top - TopIndent);
      taRightJustify:
        Params.HintPos := Point(DataRight + 1 - TextWidth - 7, ARect.Top - TopIndent);
      taCenter:
        Params.HintPos := Point(DataRight + 1 - TextWidth - 6 +
          TextWidth div 2 - (DataRight - ARect.Left - 4) div 2, ARect.Top - TopIndent);
    end;
    if Column.UseRightToLeftAlignment then
      Params.HintPos.X := ClientWidth - Params.HintPos.X;
//    Params.HintPos := ClientToScreen(Params.HintPos);
//    HintWindowClass := TToolTipsWindow;
//    HintData := FHintFont;
    if WordWrap then
      Params.HintMaxWidth := ARect.Right - ARect.Left - 4;
  end
  else
    Params.HintStr := '';

end;

procedure TCustomDBGridEh.CMHintShow(var Message: TCMHintShow);
var
  Cell: TGridCoord;
  Column: TColumnEh;
  TextWidth, DataRight, RightIndent, EmptyVar: Integer;
//  HitTestX1: Integer;
  s: String;
  ARect: TRect;
  WordWrap: Boolean;
  TextWider: Boolean;
  AAlignment: TAlignment;
  TopIndent: Integer;
  IsDataToolTips: Boolean;
  Footer: TColumnFooterEh;
{$IFDEF CIL}
  AHintInfo: THintInfo;
{$ENDIF}
  Params: TDBGridEhDataHintParams;
  Processed: Boolean;
  InCellCursorPos: TPoint;
  DataRect: TRect;
  FBackground: TColor;
  IsTitleTypeCell: Boolean;
  NewHeight: Integer;

  function GetToolTipsColumnText(Column: TColumnEh): String;
  var KeyIndex: Integer;
  begin
    Result := '';
    if Column.GetColumnType in [ctKeyImageList, ctCheckboxes] then
    begin
      if Column.GetColumnType = ctKeyImageList
        then KeyIndex := Column.KeyList.IndexOf(Column.Field.Text)
      else KeyIndex := Integer(Column.CheckboxState);
      if (KeyIndex > -1) and (KeyIndex < Column.PickList.Count)
        then Result := Column.PickList.Strings[KeyIndex];
    end
    else if Column.Field <> nil
      then Result := Column.DisplayText;
  end;

begin
  inherited;
  Processed := False;
  if Message.Result = 0 then
  begin
{$IFDEF CIL}
    if Message.OriginalMessage.LParam = 0 then Exit;
    AHintInfo := Message.HintInfo;
{$ENDIF}
    IsDataToolTips := False;
    Cell := MouseCoord(HitTest.X, HitTest.Y);
    if (Cell.X < IndicatorOffset) or (Cell.Y < 0) then Exit;
    Column := Columns[RawToDataColumn(Cell.X)];

    if (Cell.Y = GetTitleRows - 1) and (Column.Title.Hint <> '') then
    begin // Title hint

{$IFDEF CIL}
      AHintInfo.HintStr := GetShortHint(Columns[RawToDataColumn(Cell.X)].Title.Hint);
      AHintInfo.CursorRect := CellRect(Cell.X, Cell.Y);
      Message.HintInfo := AHintInfo;
{$ELSE}
      Message.HintInfo^.HintStr := GetShortHint(Columns[RawToDataColumn(Cell.X)].Title.Hint);
      Message.HintInfo^.CursorRect := CellRect(Cell.X, Cell.Y);
{$ENDIF}
    end
    else if (Mouse.Capture = 0) and (GetKeyState(VK_CONTROL) >= 0) then
    begin
      ARect := CellRect(Cell.X, Cell.Y);
      if RowPanel.Active then
      begin
        if Cell.Y = GetTitleRows - 1
          then IsTitleTypeCell := True
          else IsTitleTypeCell := False;
        Column := GetColumnInRowPanelAtPos(
          Point(HitTest.X-ARect.Left+FDataOffset.cx,
                HitTest.Y-ARect.Top), IsTitleTypeCell);
        if Column = nil then Exit;
        if IsTitleTypeCell then
          DataRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
            Column.FRowPlacement.Left+Column.FRowPlacement.Width,
            Column.FRowPlacement.Top+Column.FRowPlacement.Height)
        else
          DataRect := Rect(Column.FRowPlacement.DataCellLeft, Column.FRowPlacement.Top,
            Column.FRowPlacement.DataCellLeft+Column.FRowPlacement.DataCellWidth,
            Column.FRowPlacement.Top+Column.FRowPlacement.Height);
        OffsetRect(DataRect, ARect.Left, ARect.Top);
        OffsetRect(DataRect, -FDataOffset.cx, 0);
        ARect := DataRect;
      end;
      InCellCursorPos := Point(HitTest.X-ARect.TopLeft.X, HitTest.Y-ARect.TopLeft.Y);
//      HitTestX1 := HitTest.X;
      WordWrap := False;
      AAlignment := taLeftJustify;
      if FHintFont = nil then
        FHintFont := TFont.Create;
      if Column.UseRightToLeftAlignment then
      begin
        OffsetRect(ARect, ClientWidth - ARect.Right - ARect.Left, 0);
//        HitTestX1 := ClientWidth - HitTest.X;
      end;
      DataRight := ARect.Left + Column.Width;
      if (Cell.Y = GetTitleRows - 1) and Column.Title.ToolTips then
      begin  // Title tooltips
        if Column.Title.GetSortMarkingWidth > 2 then
        begin
          Dec(ARect.Right, Column.Title.GetSortMarkingWidth - 2);
          Dec(DataRight, Column.Title.GetSortMarkingWidth - 2);
        end;
        if IsUseMultiTitle = True then
        begin
          s := FLeafFieldArr[RawToDataColumn(Cell.X)].FLeaf.Text;
          ARect.Top := ARect.Bottom - FLeafFieldArr[Cell.X - IndicatorOffset].FLeaf.Height + 1;
          if HitTest.Y < ARect.Top then Exit;
        end
        else
          s := Column.Title.Caption;
        WordWrap := (IsUseMultiTitle = True) or (TitleHeight <> 0) or (TitleLines <> 0);
        AAlignment := Column.Title.Alignment;
        FHintFont.Assign(Column.Title.Font);
        Canvas.Font.Assign(FHintFont);
        if Column.Title.Orientation = tohVertical then
        begin
          WordWrap := False;
          OverturnUpRect(ARect);
        end;
      end else if (Cell.Y >= TopDataOffset) and
        (Cell.Y < DataRowCount + TopDataOffset) and
        DataLink.Active then
      begin // Data tooltips

        IsDataToolTips := True;
        if RowDetailPanel.Visible and (Row = Cell.Y) then
        begin
          NewHeight := CalcRowDataRowHeight(Cell.Y-TopDataOffset);
          if ARect.Bottom - ARect.Top > NewHeight then
            ARect.Bottom := ARect.Top + NewHeight;
        end;

        InstantReadRecordEnter(Cell.Y - TopDataOffset);
        try

          if DataGrouping.IsGroupingWorks and
             (DataGrouping.GroupDataTree.FlatVisibleCount > 0) and
             (FDrawGroupDataNode.NodeType = dntDataGroupEh)
          then
            Exit;

          Processed := False;
    {$IFDEF CIL}
          with AHintInfo do
    {$ELSE}
          with PHintInfo(Message.HintInfo)^ do
    {$ENDIF}
          begin
            Params.HintPos := ScreenToClient(HintPos);
            Params.HintMaxWidth := HintMaxWidth;
            Params.HintColor := HintColor;
            Params.ReshowTimeout := ReshowTimeout;
            Params.HideTimeout := HideTimeout;
            Params.HintStr := '';
            Params.CursorRect := ARect;
            Params.HintFont := FHintFont;
            Params.HintFont.Assign(Screen.HintFont);
          end;

          if Assigned(FOnDataHintShow) then
            OnDataHintShow(Self, HitTest, Cell, InCellCursorPos, Column, Params, Processed);
          if not Processed and Assigned(Column) and Assigned(Column.FOnDataHintShow) then
            Column.OnDataHintShow(Self, HitTest, Cell, InCellCursorPos, Column, Params, Processed);

          if not Processed and Column.ToolTips then
            DefaultFillDataHintShowInfo(HitTest, Cell, Column, Params);

    {$IFDEF CIL}
          with AHintInfo do
    {$ELSE}
          with PHintInfo(Message.HintInfo)^ do
    {$ENDIF}
          begin
            CursorRect := Params.CursorRect;
            HintPos := ClientToScreen(Params.HintPos);
            HintMaxWidth := Params.HintMaxWidth;
            HintColor := Params.HintColor;
            ReshowTimeout := Params.ReshowTimeout;
            HideTimeout := Params.HideTimeout;
            HintStr := Params.HintStr;
            Processed := True;
          end;

        finally
          InstantReadRecordLeave;
        end;
      end
      else if (FooterRowCount > 0) and
              (Cell.Y > RowCount - 1) then
      begin
        Footer := Column.UsedFooter(Cell.Y - RowCount);
        if not Footer.ToolTips then Exit;
        FHintFont.Assign(Footer.Font);
        Canvas.Font.Assign(FHintFont);
        WordWrap := Footer.WordWrap;
        AAlignment := Footer.Alignment;
        S := GetFooterValue(Cell.Y - RowCount, Column);
        FBackground := Footer.Color;
        GetFooterParams(RawToDataColumn(Cell.X), Cell.Y - RowCount, Column,
          Canvas.Font, FBackground, AAlignment, [], S);
      end else
        Exit;

      //if UseRightToLeftAlignment then
      //  ChangeBiDiModeAlignment(AAlignment);
      if not Processed then
      begin

        if WordWrap then RightIndent := 2 else RightIndent := 0;
        if IsDataToolTips and (Column.GetColumnType in [ctKeyImageList, ctCheckboxes])
          then TextWider := True
          else TextWider := CheckHintTextRect(Self.DrawTextBiDiModeFlagsReadingOnly,
                              Self.Canvas, RightIndent, FInterlinear,
                              s, ARect, WordWrap, TextWidth, EmptyVar);

        if Flat then TopIndent := 2 else TopIndent := 1;

  {$IFDEF CIL}
        with AHintInfo do
  {$ELSE}
        with PHintInfo(Message.HintInfo)^ do
  {$ENDIF}
          if TextWider or ((AAlignment = taRightJustify) and (DataRight - 2 > ARect.Right)) then
          begin
            HintStr := s;
            CursorRect := ARect;
            case AAlignment of
              taLeftJustify:
                HintPos := Point(ARect.Left - 1, ARect.Top - TopIndent);
              taRightJustify:
                HintPos := Point(DataRight + 1 - TextWidth - 7, ARect.Top - TopIndent);
              taCenter:
                HintPos := Point(DataRight + 1 - TextWidth - 6 +
                  TextWidth div 2 - (DataRight - ARect.Left - 4) div 2, ARect.Top - TopIndent);
            end;
            if Column.UseRightToLeftAlignment then
              HintPos.X := ClientWidth - HintPos.X;
            HintPos := ClientToScreen(HintPos);
            if WordWrap then
              HintMaxWidth := ARect.Right - ARect.Left - 4;
          end
          else
            HintStr := '';
      end;
  {$IFDEF CIL}
      with AHintInfo do
  {$ELSE}
      with PHintInfo(Message.HintInfo)^ do
  {$ENDIF}
      begin
        HintWindowClass := TToolTipsWindow;
        HintData := FHintFont;
      end;
    end;
{$IFDEF CIL}
    Message.HintInfo := AHintInfo;
{$ENDIF}
  end;
end;

procedure TCustomDBGridEh.CMFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  BeginLayout;
  try
    for I := 0 to Columns.Count - 1 do
      Columns[I].RefreshDefaultFont;
    DataGrouping.RefreshDefaultFont;  
  finally
    EndLayout;
  end;
end;

procedure TCustomDBGridEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  OutBRect: TRect;
begin
//    if Msg.Result <> 1 then
//      ShowMessage('CMDesignHitTest='+IntToStr(Msg.Result));
  inherited;
  if Msg.Result = 0 then
    Msg.Result := Longint(BOOL(FrozenSizing(Msg.Pos.X, Msg.Pos.Y)));
  if (Msg.Result = 1) and ((FDataLink = nil) or
    ((Columns.State = csDefault) and
    (FDataLink.DefaultFields or (not FDataLink.Active)))) then
    Msg.Result := 0
  else if (Msg.Result = 0) and RowPanel.Active and (Columns.State = csCustomized) {and
    (ssLeft in KeysToShiftState(Msg.Keys))} then
  begin
    Msg.Result := Longint(BOOL(CheckForDesigntTimeColMoving(Msg.Pos.X, Msg.Pos.Y)));
  end;
  if (Msg.Result = 0) and Assigned(DBGridEhDesigntControler)
  then
    Msg.Result := Longint(BOOL(DBGridEhDesigntControler.IsDesignHitTest(Self,
      Msg.Pos.X, Msg.Pos.Y, KeysToShiftState(Msg.Keys))));
  if (Msg.Result = 0) and
      OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtTopEh) and
      PtInRect(OutBRect, Point(Msg.Pos.X, Msg.Pos.Y))
  then
    Msg.Result := Longint(BOOL(True));
end;

procedure TCustomDBGridEh.CMDeferLayout(var Message: TMessage);
begin
  if AcquireLayoutLock
    then EndLayout
    else DeferLayout;
end;

procedure TCustomDBGridEh.CMCancelMode(var Message: TCMCancelMode);
{$IFDEF CIL}
var
  Temp: TMessage;
{$ENDIF}

  function CheckDataListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if FInTitleFilterListbox <> nil then
      for i := 0 to FInTitleFilterListbox.ControlCount - 1 do
        if FInTitleFilterListbox.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;

begin
  inherited;

{$IFDEF CIL}
  Temp := UnwrapMessage(Message);
  if FilterEdit <> nil then
    IControl(FilterEdit).WndProc(Temp);
{$ELSE}
  if FilterEdit <> nil then
    TCustomDBEditEhCracker(FilterEdit).WndProc(TMessage(Message));
{$ENDIF}
  if FInTitleFilterListboxVisible then
    if (Message.Sender = Self) then
    begin
      if not PtInRect(FTrackingStateRect, ScreenToClient(Mouse.CursorPos)) then
        InTitleFilterListboxCloseUp(False);
    end else if (Message.Sender <> Self) and {not ContainsControl(Message.Sender) and}
      (Message.Sender <> FInTitleFilterListbox) and not CheckDataListChilds
    then
      InTitleFilterListboxCloseUp(False);
end;

procedure TCustomDBGridEh.CMChanged(var Msg: TCMChanged);
begin
{$IFDEF CIL}
{$ELSE}
  if (FNoDesigntControler = False) and
     Assigned(DBGridEhDesigntControler) and
    (csDesigning in ComponentState)
  then
    DBGridEhDesigntControler.KeyProperyModified(Msg.Child);
{$ENDIF}
end;

{WM messages processing}

procedure TCustomDBGridEh.WMRButtonDown(var Message: TWMRButtonDown);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(Message.XPos, Message.YPos);

  if not (csDesigning in ComponentState) then
  begin
    if STFilter.Visible and (STFilter.Location = stflUnderTitleFilterEh) then
    begin
      if CheckCellFilter(Coord.X, Coord.Y, Point(Message.XPos, Message.YPos))
        and ((not IndicatorColVisible) or (Coord.X > 0))
        and CanFilterCol(RawToDataColumn(Coord.X)) then
      begin
        CheckClearSelection;
        StartEditFilter(RawToDataColumn(Coord.X));
        //SendCancelMode(nil);
        FDownMouseMessageTime := GetMessageTime;
        FDownMousePos := Point(Message.XPos, Message.YPos);
        //ResentMouseEvent(Message, ClientToScreen(SmallPointToPoint(Message.Pos)));
        Exit;
      end;
    end;
  end;
  inherited;
end;

procedure TCustomDBGridEh.WMLButtonDown(var Message: TWMLButtonDown);
var
  Coord: TGridCoord;
  ARect: TRect;
  Column: TColumnEh;
  ColumnIndex: Integer;
begin
  Coord := MouseCoord(Message.XPos, Message.YPos);

  if not (csDesigning in ComponentState) then
  begin
    if STFilter.Visible and (STFilter.Location = stflUnderTitleFilterEh) then
    begin
      if CheckCellFilter(Coord.X, Coord.Y, Point(Message.XPos, Message.YPos))
        and ((not IndicatorColVisible) or (Coord.X > 0))
      then
      begin
        if RowPanel.Active then
        begin
          ARect := CellRect(Coord.X, Coord.Y);
          Column := GetColumnInRowPanelAtPos(Point(Message.XPos-ARect.Left+FDataOffset.cx,
            Message.YPos-ARect.Top), False);
          ColumnIndex := Column.Index;
        end else
          ColumnIndex := RawToDataColumn(Coord.X);

        if CanFilterCol(ColumnIndex) then
        begin
          CheckClearSelection;
          StartEditFilter(ColumnIndex);
          if FilterEdit.Visible then
            FilterEdit.Perform(WM_LBUTTONDOWN, Message.Keys,
              SmallPointToInteger(PointToSmallPoint(FilterEdit.ScreenToClient(ClientToScreen(SmallPointToPoint(Message.Pos))))));
            //SendCancelMode(nil);
          FDownMouseMessageTime := GetMessageTime;
          FDownMousePos := Point(Message.XPos, Message.YPos);
          //ResentMouseEvent(Message, ClientToScreen(SmallPointToPoint(Message.Pos)));
          Exit;
        end;
      end;  
    end;
  end;
  inherited;
end;

procedure TCustomDBGridEh.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
begin
  if not AcquireFocus then Exit;
  if ExtendedScrolling then
  begin
    if VertScrollBar.SmoothStep then
    begin
      if VertScrollBar.Tracking and (Message.ScrollCode = SB_THUMBTRACK) then
      begin
        if Message.Pos < 0 then Message.Pos := 0;
        Perform(Message.Msg, MakeLong(SB_THUMBPOSITION, Message.Pos), Message.ScrollBar)
      end else
        inherited;
    end else
      MTWMVScroll(Message);
  end else if FDatalink.Active then
    with Message, FDataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: Self.MoveBy(-FDatalink.ActiveRecord - 1);
        SB_LINEDOWN: Self.MoveBy(FDatalink.RecordCount - FDatalink.ActiveRecord);
        SB_PAGEUP: Self.MoveBy({ddd//-VisibleRowCount}-VisibleDataRowCount {ddd\\});
        SB_PAGEDOWN: Self.MoveBy({ddd//VisibleRowCount} VisibleDataRowCount {ddd\\});
        SB_THUMBTRACK:
          if VertScrollBar.Tracking then
          begin
            SI.cbSize := sizeof(SI);
            SI.fMask := SIF_TRACKPOS;
            VertScrollBar.GetScrollInfo(SI);
            Self.MoveBy(SI.nTrackPos - SumList.RecNo);
            FThumbTracked := True;
            Exit;
          end;
        SB_THUMBPOSITION {,SB_THUMBTRACK}:
          begin
            //ddd
            if FThumbTracked then begin
              FThumbTracked := False;
              Exit;
            end;
            if ScrollCode = SB_THUMBTRACK then
              if not VertScrollBar.Tracking then Exit;
            //\\\
            if {dddIsSequenced}  SumList.IsSequenced then
            begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              VertScrollBar.GetScrollInfo(SI);
              if SI.nTrackPos <= 1 then First
              else if SI.nTrackPos >= {dddRecordCount} SumList.RecordCount then Last
              else {dddRecNo}  SumList.RecNo := SI.nTrackPos;
            end
            else
              case Pos of
                0: First;
                1: Self.MoveBy({ddd//-VisibleRowCount}-VisibleDataRowCount {ddd\\});
                2: Exit;
                3: Self.MoveBy({ddd//-VisibleRowCount} VisibleDataRowCount {ddd\\});
                4: Last;
              end;
          end;
        SB_BOTTOM: Last;
        SB_TOP: First;
      end;
end;

procedure TCustomDBGridEh.WMTimer(var Message: TWMTimer);
var
  DrawInfo: TGridDrawInfoEh;
  Point: TPoint;
  CellHit: TGridCoord;
begin
  case Message.TimerID of
    1: if FIndicatorPressed or FDataTracking or
      (FDBGridEhState = dgsColSelecting)
        then TimerScroll
       else if FDBGridEhState = dgsRowMoving then
       begin
         GetCursorPos(Point);
         Point := ScreenToClient(Point);
         CalcDrawInfo(DrawInfo);
         CellHit := MouseCoord(Point.X, Point.Y);
         MoveDataRowAndScroll(Point.Y, CellHit.Y, DrawInfo, DrawInfo.Vert, SB_VERT, Point);
       end
       else if (FGridState = gsColMoving) and RowPanel.Active then
       begin
         GetCursorPos(Point);
         Point := ScreenToClient(Point);
         GoRowPanelTitleCellDrag(GetShiftState, Point.X, Point.Y);
       end else
        inherited;
    2: StopInplaceSearch;
    else
     inherited;
  end;
end;

procedure TCustomDBGridEh.WMSize(var Message: TWMSize);
begin
  inherited;

  if UpdateLock = 0 then
    if ((FAutoFitColWidths = True) {or (FooterRowCount > 0)}) and
      not (csDesigning in ComponentState) then
    begin
      LayoutChanged;
      InvalidateEditor;
    end else
    begin
      UpdateRowCount;
      UpdateScrollBar;
      UpdateFilterEdit(False);
    end
  else
    FSizeChanged := True;
  UpdateHorzExtScrollBar;
  if RowDetailPanel.Visible then UpdateRowDetailPanel;  

{  if FAutoFitColWidths = True and (UpdateLock = 0) and not (csDesigning in ComponentState) then
    LayoutChanged;
  if UpdateLock = 0 then
  begin
    UpdateRowCount;
    UpdateScrollBar;
  end;}

////  if UpdateLock = 0 then UpdateRowCount;
end;

procedure TCustomDBGridEh.DoAfterSizeChanged;
var
  ALayoutChanged: Boolean;
begin
  FSizeChanged := False;
  ALayoutChanged := (FAutoFitColWidths = True)
   or (IndicatorColVisible and (ColWidths[0] <> CalcIndicatorColWidth));

  if ALayoutChanged and not (csDesigning in ComponentState) then
  begin
    LayoutChanged;
    InvalidateEditor;
  end else
  begin
    UpdateRowCount;
    UpdateScrollBar;
    UpdateFilterEdit(False);
  end;
end;

procedure TCustomDBGridEh.WMSetCursor(var Msg: TWMSetCursor);
var
  Cell: TGridCoord;
  ARect, AStateRect: TRect;
  State: TDBGridEhState;
  Cur: HCURSOR;
  Index: Longint;
  Pos, Ofs: Integer;
  Column: TColumnEh;
begin
  Column := nil;
  if (csDesigning in ComponentState) and ((FDataLink = nil) or
    ((Columns.State = csDefault) and
    (FDataLink.DefaultFields or (not FDataLink.Active)))) then
  begin
    Windows.SetCursor(LoadCursor(0, IDC_ARROW));
    Exit;
  end;

  Cur := 0;
  if Msg.HitTest = HTCLIENT then
  begin
    if (FGridState = gsNormal) and (FDBGridEhState = dgsNormal) then
      CalcFrozenSizingState(HitTest.X, HitTest.Y, State, Index, Pos, Ofs)
    else State := FDBGridEhState;
    if State = dgsColSizing then
      Cur := Screen.Cursors[crHSplit];
  end;
  if Cur <> 0 then
  begin
    SetCursor(Cur);
    Exit;
  end;

//ddd  else inherited;
  if not (csDesigning in ComponentState) and FDataLink.Active and
    not Sizing(HitTest.X, HitTest.Y) and (dgMultiSelect in Options) and
    (Msg.HitTest = HTCLIENT) then
  begin
    Cell := MouseCoord(HitTest.X, HitTest.Y);
    if CheckBeginRowMoving(HitTest.X, HitTest.Y, True) then
      inherited
    else if (Cell.X >= 0) and (Cell.X < FIndicatorOffset) and (Cell.Y > TopDataOffset - 1) and
      FDatalink.Active and not (DataSource.DataSet.Eof and DataSource.DataSet.Bof) and
      (gstRecordBookmarks in AllowedSelections)
      then
      if Self.UseRightToLeftAlignment
        then Windows.SetCursor(hcrLeftCurEh)
        else Windows.SetCursor(hcrRightCurEh)
    else
      if (dgTitles in Options) and (Cell.Y = 0) and (Cell.X > IndicatorOffset - 1) and
        not (dgRowSelect in Options) then
      begin
        ARect := CellRect(Cell.X, Cell.Y);
        if Cell.X >= IndicatorOffset then
          Column := Columns[Cell.X-IndicatorOffset];

        if (HitTest.Y <= ARect.Bottom) and
           (gstColumns in AllowedSelections) and
           (HitTest.Y >= iif((ARect.Bottom - ARect.Top) < ColSelectionAreaHeight, ARect.Top, ARect.Bottom - ColSelectionAreaHeight)) and
           (GetMouseHitCellState(Cell, HitTest, ARect, Column, AStateRect) = dgsNormal)
        then
          Windows.SetCursor(hcrDownCurEh)
        else
          inherited;
      end
      else inherited;
  end
  else inherited;
end;

procedure TCustomDBGridEh.WMNCCalcSize(var Message: TWMNCCalcSize);
{$IFDEF CIL}
var
  r: TNCCalcSizeParams;
begin
  inherited;
  r := Message.CalcSize_Params;
  InflateRect(r.rgrc0, -FBorderWidth, -FBorderWidth);
  Message.CalcSize_Params := r;
end;
{$ELSE}
begin
  inherited;
  with Message.CalcSize_Params^ do
    InflateRect(rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

procedure TCustomDBGridEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

function DoControlMsg(ControlHandle: HWnd; var Message): Boolean;
var
  Control: TWinControl;
{$IFDEF CIL}
  Msg: TMessage;
{$ENDIF}
begin
  DoControlMsg := False;
  Control := FindControl(ControlHandle);
  if Control <> nil then
  begin
{$IFDEF CIL}
    Msg := UnwrapMessage(TObject(Message));
    with Msg do
{$ELSE}
    with TMessage(Message) do
{$ENDIF}
    begin
      Result := Control.Perform(Msg + CN_BASE, WParam, LParam);
      DoControlMsg := True;
    end;
  end;  
end;

procedure TCustomDBGridEh.WMCommand(var Message: TWMCommand);
begin
  inherited;
  if Message.NotifyCode = EN_CHANGE then
    with Message do
    begin
      if (InplaceEditor <> nil) and (Ctl = InplaceEditor.Handle) then
        TDBGridInplaceEdit(InplaceEditor).UserChange
      else
      begin
        if DoControlMsg(Message.Ctl, Message) then
          Exit;
        if (FilterEdit <> nil) and (Ctl = FilterEdit.Handle) and (FFilterCol <> -1) then
        begin
          if GetFilterValue(FFilterCol) <> FilterEdit.Text then
            OnFilterChange(Self);
        end;
      end;
    end;
end;

procedure TCustomDBGridEh.WMIMEStartComp(var Message: TMessage);
begin
  inherited;
  ShowEditor;
end;

procedure TCustomDBGridEh.WMSetFocus(var Message: TWMSetFocus);
var
  InvalidRect: TRect;
begin
  if not ((InplaceEditor <> nil) and
    (Message.FocusedWnd = InplaceEditor.Handle)) then SetIme;

  if HandleAllocated and (dgRowSelect in Options) then
  begin
    with inherited Selection do
      InvalidRect := BoxRect(Left - FrozenCols, Top, Right, Bottom);
    WindowsInvalidateRect(Handle, InvalidRect, False);
  end;

  inherited;

  if ((FilterEdit = nil) or (Message.FocusedWnd <> FilterEdit.Handle)) and FilterEditMode then
    FilterEdit.SetFocus;

//  if not IsMyInplaceControlHandle(Message.FocusedWnd) then
//    ControlGetFocus;
  if FSelectionActive <> IsSelectionActive then
  begin
    SelectionActiveChanged;
    if (sebShowOnlyWhenGridActiveEh in EditButtonsShowOptions) and not
      (sebShowOnlyForCurCellEh in EditButtonsShowOptions) and not
      (sebShowOnlyForCurRowEh in EditButtonsShowOptions) then
      Invalidate;
  end;  
end;

procedure TCustomDBGridEh.WMKillFocus(var Message: TWMKillFocus);
var
  InvalidRect: TRect;
begin
  if FSortMarking and
    not ((InplaceEditor <> nil) and (Message.FocusedWnd = InplaceEditor.Handle)) then
  begin
    FSortMarking := False;
    DoSortMarkingChanged;
  end;

  if HandleAllocated and (dgRowSelect in Options) then
  begin
    with inherited Selection do
      InvalidRect := BoxRect(Left - FrozenCols, Top, Right, Bottom);
    WindowsInvalidateRect(Handle, InvalidRect, False);
  end;

  if not SysLocale.FarEast
    then inherited
  else
  begin
{
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;}
    inherited;
{   This code switches layout to default language. This code is incorrect.
    if not ((InplaceEditor <> nil) and (Message.FocusedWnd = InplaceEditor.Handle))
      then ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);}
  end;

//  if not IsMyInplaceControlHandle(HWND(Message.WParam)) then
//    ControlLeaveFocus;
  if FSelectionActive <> IsSelectionActive then
  begin
    SelectionActiveChanged;
    if (sebShowOnlyWhenGridActiveEh in EditButtonsShowOptions) and not
      (sebShowOnlyForCurCellEh in EditButtonsShowOptions) and not
      (sebShowOnlyForCurRowEh in EditButtonsShowOptions) then
      Invalidate;
  end;

  if FInTitleFilterListboxVisible then
    InTitleFilterListboxCloseUp(False);
end;

procedure TCustomDBGridEh.WMHScroll(var Message: TWMHScroll);
begin
  if HorzScrollBar.Tracking and (Message.ScrollCode = SB_THUMBTRACK) then
    Perform(Message.Msg, MakeLong(SB_THUMBPOSITION, Message.Pos), Message.ScrollBar)
  else
    inherited;
  UpdateHorzExtScrollBar;
  //(Commented to avoid bug of changing text and press on scollbar) InvalidateEditor;
end;

procedure TCustomDBGridEh.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  if dghPreferIncSearch in OptionsEh then
    Msg.Result := Msg.Result or DLGC_WANTCHARS;
end;

procedure TCustomDBGridEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
//  inherited;
end;

procedure TCustomDBGridEh.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if FInTitleFilterListboxVisible then
    InTitleFilterListboxCloseUp(False);
end;

procedure TCustomDBGridEh.CancelMode;
begin
  if RowPanel.Active and (FGridState = gsColMoving) then
    StopRowPanelTitleCellDrag([], 0, 0, False);
  inherited CancelMode;

  FDSMouseCapture := False;
  StopTracking;
  if FDBGridEhState = dgsColSizing then
    DrawSizingLineEx(GridWidth, GridHeight)
  else if FDBGridEhState = dgsGroupPanelTitleMoving then
    StopGroupPanelTitleMovingMode([], 0, 0, False)
  else if FDBGridEhState <> dgsNormal then
    StopTimer;
  FDBGridEhState := dgsNormal;
end;


procedure TCustomDBGridEh.WndProc(var Message: TMessage);
var
  AMouseMessage: TWMMouse;
begin
  if (Message.Msg = WM_LBUTTONDOWN) and (csDesigning in ComponentState) and (FNoDesigntControler = False) and
     Assigned(DBGridEhDesigntControler) and not FTracking and (FGridState = gsNormal)  then
  begin
  {$IFDEF CIL}
    AMouseMessage := TWMMouse.Create(Message);
  {$ELSE}
    AMouseMessage := TWMMouse(Message);
  {$ENDIF}
    if DBGridEhDesigntControler.IsDesignHitTest(Self, AMouseMessage.XPos, AMouseMessage.YPos,
        [ssLeft]) then
    begin
      if not IsControlMouseMsg(AMouseMessage) then
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
        ControlState := ControlState - [csLButtonDown];
      end;
      Exit;
    end;
  end;

  if FInTitleFilterListboxVisible then
  begin
    case Message.Msg of
      wm_KeyDown, wm_SysKeyDown, wm_Char:
{$IFDEF CIL}
        with TWMKey.Create(Message) do
{$ELSE}
        with TWMKey(Message) do
{$ENDIF}
        begin
          SendMessage(FInTitleFilterListbox.Handle, Msg, Message.WParam, Message.LParam);
          Exit;
        end;
    end;
  end;

  if (DragMode = dmAutomatic) and {(dgMultiSelect in Options) and}
    not (csDesigning in ComponentState) and
    ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) then
  begin
    DragMode := dmManual;
    FAutoDrag := True;
    try
      inherited WndProc(Message);
    finally
      FAutoDrag := False;
      DragMode := dmAutomatic;
    end;
  end
  else
    inherited WndProc(Message);
end;

procedure TCustomDBGridEh.SaveBookmark;
begin
  if ViewScroll then
    FLockedBookmark := DataLink.DataSet.Bookmark
  else
  begin
    FLookedOffset := DataLink.ActiveRecord - (DataLink.RecordCount div 2) +
      ((DataLink.RecordCount + 1) mod 2) { - 1};
    MoveBy(-FLookedOffset);
    FLockedBookmark := DataLink.DataSet.Bookmark;
    MoveBy(FLookedOffset);
  end;
end;

procedure TCustomDBGridEh.RestoreBookmark;
begin
  if ViewScroll then
    DataLink.DataSet.Bookmark := FLockedBookmark
  else
  begin
    DataLink.DataSet.Bookmark := FLockedBookmark;
    MoveBy(FLookedOffset);
  end;
end;

procedure TCustomDBGridEh.SetTitleImages(const Value: TCustomImageList);
begin
  if FTitleImages <> nil then FTitleImages.UnRegisterChanges(FTitleImageChangeLink);
  FTitleImages := Value;
  if FTitleImages <> nil then
  begin
    FTitleImages.RegisterChanges(FTitleImageChangeLink);
    FTitleImages.FreeNotification(Self);
  end;
  LayoutChanged;
end;

procedure TCustomDBGridEh.TitleImageListChange(Sender: TObject);
begin
  if Sender = TitleImages then Invalidate;
end;

function TCustomDBGridEh.AllowedOperationUpdate: Boolean;
begin
  Result := False;
  if not FDatalink.Active then Exit;
  Result := (alopUpdateEh in AllowedOperations) or
   (  not (alopUpdateEh in AllowedOperations) and (FDatalink.DataSet.State = dsInsert)  );
  Result := Result and not (FDatalink.DataSet.IsEmpty and
    not (alopInsertEh in AllowedOperations) and not (alopAppendEh in AllowedOperations));
end;

function TCustomDBGridEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if ViewScroll and FDatalink.Active and ExtendedScrolling then
  begin
    Result := False;
    if Assigned(OnMouseWheelDown) then
      OnMouseWheelDown(Self, Shift, MousePos, Result);
    if not Result then
    begin
      if ssShift in Shift then
        if ssCtrl in Shift
          then MoveBy(VisibleRowCount)
          else FDatalink.DataSet.Next
      else if ssCtrl in Shift then
      begin
        if (RowCount - TopRow - VisibleRowCount < VisibleRowCount) then
          FIntMemTable.FetchRecords(VisibleRowCount - (RowCount - TopRow - VisibleRowCount));
        SafeMoveTop(TopRow + VisibleRowCount);
      end else if IsSmoothVertScroll then
        inherited DoMouseWheelDown(Shift, MousePos)
      else
        SafeMoveTop(TopRow + 1);
      Result := True;
    end;
  end else
  begin
    if FDatalink.Active then MoveBy(1 {Mouse.WheelScrollLines});
    Result := True;
  end;
end;

function TCustomDBGridEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if ViewScroll and FDatalink.Active and ExtendedScrolling then
  begin
    Result := False;
    if Assigned(OnMouseWheelDown) then
      OnMouseWheelUp(Self, Shift, MousePos, Result);
    if not Result then
    begin
      if ssShift in Shift then
        if ssCtrl in Shift
          then MoveBy(-VisibleRowCount)
          else FDatalink.DataSet.Prior
      else if ssCtrl in Shift then
        SafeMoveTop(TopRow - VisibleRowCount)
      else if IsSmoothVertScroll then
        inherited DoMouseWheelUp(Shift, MousePos)
      else
        SafeMoveTop(TopRow - 1);
      Result := True;
    end;
  end else
  begin
    if FDatalink.Active then MoveBy(-1 {Mouse.WheelScrollLines});
    Result := True;
  end;
end;

procedure TCustomDBGridEh.CalcSizingState(X, Y: Integer; var State: TGridState;
  var Index: Longint; var SizingPos, SizingOfs: Integer; var FixedInfo: TGridDrawInfoEh);
var
  I, IndicatorBoundary: Integer;
begin
  if ([goColSizing, goRowSizing] * EffectiveGridOptions <> [])
    and (X > FixedInfo.Horz.NoFrozenBoundary)
     and (Y <= FixedInfo.Vert.NoFrozenBoundary) and RowPanel.Active
  then
//    ShowMessage('TCustomDBGridEh.CalcSizingState');
    CalcSizingStateForRowPanel(X, Y, State, Index, SizingPos, SizingOfs, FixedInfo)
  else
  begin
    inherited CalcSizingState(X, Y, State, Index, SizingPos, SizingOfs, FixedInfo);
    if (State = gsColSizing) then
      with FixedInfo.Horz do
        if (Index >= FullGridCellCount) then
          Index := GridCellCount - 1
        else if (FirstGridCell = LastFullVisibleCell) and
          (ColWidths[FirstGridCell] + FixedBoundary > GridBoundary) and
          (Index > FirstGridCell) and (ContraCelCount = 0)
        then
          Index := FirstGridCell;
    if State = gsRowSizing then
    begin
      if RowPanel.Active then
        State := gsNormal
      else
      begin
        IndicatorBoundary := 0;
        for I := 0 to IndicatorOffset - 1 do
          Inc(IndicatorBoundary, ColWidths[I] + GridLineWidth);
        if X >= IndicatorBoundary then State := gsNormal;
      end;
    end;
  end;
end;

procedure TCustomDBGridEh.CalcSizingStateForRowPanel(X, Y: Integer; var State: TGridState;
  var Index: Longint; var SizingPos, SizingOfs: Integer; var FixedInfo: TGridDrawInfoEh);
var
  Cell: TGridCoord;
  ARect: TRect;
  i, OldRigth: Integer;
  Column: TColumnEh;
  ACellRect: TRect;
begin
  Cell := MouseCoord(X, Y);
  if (Cell.X < 0) or (Cell.Y <> 0) then Exit;
  ARect := CellRect(Cell.X, Cell.Y);
  if Self.UseRightToLeftAlignment then
  begin
    OldRigth := ARect.Right;
    ARect.Right := ClientWidth - ARect.Left;
    ARect.Left := ClientWidth - OldRigth;
    X := ClientWidth - X;
  end;

  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    ACellRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
      Column.FRowPlacement.Left + Column.FRowPlacement.Width,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    {if UseRightToLeftAlignment then
    begin
      OldRigth := ACellRect.Right;
      ACellRect.Right := ARect.Right - ACellRect.Left;
      ACellRect.Left := ARect.Right - OldRigth;
      OffsetRect(ACellRect, FDataOffset.cx, 0);
      OffsetRect(ACellRect, 0, ARect.Top);
    end else}
    begin
      OffsetRect(ACellRect, -FDataOffset.cx, 0);
      OffsetRect(ACellRect, ARect.Left, ARect.Top);
    end;

    if (goColSizing in EffectiveGridOptions) and
       (ACellRect.Top <= Y) and (ACellRect.Bottom >= Y) and
       (ACellRect.Right - 3 <= X) and (ACellRect.Right + 3 >= X) then
    begin
      State := gsColSizing;
      SizingPos := ACellRect.Right;
      SizingOfs := ACellRect.Right - X;
      Index := i;
      Exit;
    end else if (goRowSizing in EffectiveGridOptions) and
       (ACellRect.Left <= X) and (ACellRect.Right >= X) and
       (ACellRect.Bottom - 3 <= Y) and (ACellRect.Bottom + 3 >= Y) then
    begin
      State := gsRowSizing;
      SizingPos := ACellRect.Bottom;
      SizingOfs := ACellRect.Bottom - Y;
      Index := i;
      Exit;
    end;
  end;
end;

procedure TCustomDBGridEh.CalcFrozenSizingState(X, Y: Integer;
  var State: TDBGridEhState; var Index: Longint; var SizingPos, SizingOfs: Integer);
var I, Line, Back, Range, VertFixedBoundary, HorzGridBoundary: Integer;
  EffectiveOptions: TGridOptions;
begin
  State := dgsNormal;
  Index := -1;
  EffectiveOptions := inherited Options;
  if csDesigning in ComponentState then
    EffectiveOptions := EffectiveOptions + DesignOptionsBoost;
  if not (goColSizing in EffectiveOptions) then Exit;
  if Self.UseRightToLeftAlignment then
    X := ClientWidth - X;
  Line := 0;
  VertFixedBoundary := OutBoundaryData.TopIndent;
  HorzGridBoundary := GridWidth;
  for I := 0 to TopDataOffset - 1 do
  begin
    Inc(VertFixedBoundary, RowHeights[I] + GridLineWidth);
  end;
  if Y >= VertFixedBoundary then Exit;
  for I := 0 to IndicatorOffset - 1 do
  begin
    Inc(Line, ColWidths[I] + GridLineWidth);
  end;
  Range := GridLineWidth;
  Back := 0;
  if Range < 7 then
  begin
    Range := 7;
    Back := (Range - GridLineWidth) shr 1;
  end;
  for I := IndicatorOffset to FixedCols - 1 do
  begin
    Inc(Line, ColWidths[I]);
    if ColWidths[I] > 0 then
    begin
      if Line > HorzGridBoundary then
      begin
        Index := I;
        Break;
      end;
      if (X >= Line - Back) and (X <= Line - Back + Range) then
      begin
        State := dgsColSizing;
        SizingPos := Line;
        SizingOfs := Line - X;
        Index := I;
        Exit;
      end;
    end;
    Inc(Line, GridLineWidth);
  end;
  if (Line > HorzGridBoundary) and (HorzGridBoundary = ClientWidth) and
    (X >= ClientWidth - Back) and (X <= ClientWidth) then
  begin
    State := dgsColSizing;
    SizingPos := ClientWidth;
    SizingOfs := ClientWidth - X;
//    Index := LeftCol - VisibleColCount;
  end;
end;

function TCustomDBGridEh.FrozenSizing(X, Y: Integer): Boolean;
var
  State: TDBGridEhState;
  Index: Longint;
  Pos, Ofs: Integer;
begin
  State := FDBGridEhState;
  if State = dgsNormal then
  begin
    CalcFrozenSizingState(X, Y, State, Index, Pos, Ofs);
  end;
  Result := State <> dgsNormal;
end;

procedure TCustomDBGridEh.DrawSizingLineEx(HorzGridBoundary, VertGridBoundary: Integer);
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  try
    with Canvas do
    begin
      OldPen.Assign(Pen);
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Width := 1;
      try
        if FGridState = gsRowSizing then
        begin
          MoveTo(0, FSizingPos);
          LineTo(HorzGridBoundary, FSizingPos);
        end else
        begin
          MoveTo(FSizingPos, 0);
          LineTo(FSizingPos, VertGridBoundary);
        end;
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomDBGridEh.GetDrawSizingLineBound(const DrawInfo: TGridDrawInfoEh; var StartPos, FinishPos: Integer);
var
  ACellRect: TRect;
begin
  if RowPanel.Active and (FGridState = gsRowSizing) and (ssShift in FStartShiftState) then
  begin
    ACellRect := CellRect(IndicatorOffset, 0);
    StartPos := Columns[FSizingIndex].FRowPlacement.Left;
    FinishPos := Columns[FSizingIndex].FRowPlacement.Left +
                 Columns[FSizingIndex].FRowPlacement.Width;
    Inc(StartPos, ACellRect.Left);
    Inc(StartPos, -FDataOffset.cx);

    Inc(FinishPos, ACellRect.Left);
    Inc(FinishPos, -FDataOffset.cx);
  end else if RowPanel.Active and (FGridState = gsColSizing) and (ssShift in FStartShiftState) then
  begin
    ACellRect := CellRect(IndicatorOffset, 0);
    StartPos := Columns[FSizingIndex].FRowPlacement.Top;
    FinishPos := Columns[FSizingIndex].FRowPlacement.Top +
                 Columns[FSizingIndex].FRowPlacement.Height;
    Inc(StartPos, ACellRect.Top);
    Inc(FinishPos, ACellRect.Top);
  end else
    inherited GetDrawSizingLineBound(DrawInfo, StartPos, FinishPos);
end;

function TCustomDBGridEh.CheckForDesigntTimeColMoving(X, Y: Integer): Boolean;
var
  Cell: TGridCoord;
  AreaCol, AreaRow: Integer;
  CellAreaType: TCellAreaTypeEh;
begin
  Result := False;
  Cell := MouseCoord(X, Y);
  if (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
    CellAreaType := GetCellAreaType(Cell.X, Cell.Y, AreaCol, AreaRow);
    if RowPanel.Active and
       (CellAreaType.HorzType = hctDataEh) and
       (CellAreaType.VertType in [vctTitleEh{, vctSubTitleEh, vctDataEh, vctFooterEh}])
    then
      Result := True;
  end;
end;

function TCustomDBGridEh.GetCol: Longint;
begin
//  if RowPanel.Active
//    then Result := FInRowPanelCol
//    else
  Result := inherited Col;
end;

procedure TCustomDBGridEh.SetCol(Value: Longint);
begin
  if Value = Col then Exit;
//  if RowPanel.Active then
//    FocusInRowPanelCell(Value, Row, True);
  if (Value <= FixedCols - 1) and (Value >= IndicatorOffset) then
  begin
    MoveColRow(Value, Row, False, False, False);
  end else
  begin
    inherited Col := Value;
  end;
end;

function TCustomDBGridEh.DataRowCount: Integer;
begin
  if FooterRowCount > 0
    then Result := RowCount - TopDataOffset
    else Result := RowCount - TopDataOffset;
end;

procedure TCustomDBGridEh.FlatChanged;
begin
  if Flat
    then FInterlinear := 2
    else FInterlinear := 4;
  RecreateWnd();
  LayoutChanged();
end;

procedure TCustomDBGridEh.DrawEdgeEh(ACanvas: TCanvas; qrc: TRect;
  IsDown, IsSelected: Boolean; NeedLeft, NeedRight: Boolean);
var
  ThreeDLine: Integer;
  TopLeftFlag, BottomRightFlag: Integer;
begin
  TopLeftFlag := BF_TOPLEFT;
  BottomRightFlag := BF_BOTTOMRIGHT;
  if Self.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, qrc);
    Swap(qrc.Left, qrc.Right);
    ChangeGridOrientation(False);
    TopLeftFlag := BF_TOPRIGHT;
    BottomRightFlag := BF_BOTTOMLEFT;
  end;

  if Flat then
  begin
    if IsSelected or IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;

    Canvas.Pen.Color := Canvas.Brush.Color;
    if Self.UseRightToLeftAlignment then
    begin
      Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right, qrc.Bottom - 1)]);
      if NeedRight then
        DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_LEFT);
      DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
      if NeedLeft
        then Canvas.Polyline([Point(qrc.Right - 1, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Top - 1)]);
    end else
    begin
      if NeedRight
        then Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Top - 1)])
        else Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right, qrc.Bottom - 1)]);
      if NeedLeft
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, TopLeftFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
    end;
  end else
  begin
    if IsSelected or IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;
    if NeedLeft and NeedRight then
      DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_RECT)
    else
    begin
      if NeedLeft
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, TopLeftFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
      if NeedRight
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, BottomRightFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_BOTTOM);
    end;
  end;
  if Self.UseRightToLeftAlignment then ChangeGridOrientation(True);
end;

procedure TCustomDBGridEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if Flat and (Ctl3D = True) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
      if (BorderStyle = bsSingle) then
        FBorderWidth := 1 else FBorderWidth := 0;
    end else
      FBorderWidth := 0;
    Style := Style or WS_CLIPCHILDREN; //To avoid black box in Inplace editor When BufferedPaint.
  end;
end;

(*
procedure TCustomDBGridEh.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if Flat and (BorderStyle = bsSingle) and (Ctl3D = True) then
    InflateRect(Rect, -1, -1);
end;
*)

procedure TCustomDBGridEh.StartInplaceSearchTimer;
begin
  if FInplaceSearchTimerActive then StopTimer;
  if FInplaceSearchTimeOut > -1 then
  begin
    SetTimer(Handle, 2, FInplaceSearchTimeOut, nil);
    FInplaceSearchTimerActive := True;
  end;
end;

procedure TCustomDBGridEh.StopInplaceSearchTimer;
begin
  if FInplaceSearchTimerActive
    then KillTimer(Handle, 2);
  FInplaceSearchTimerActive := False;
end;

function TCustomDBGridEh.LocateText(AGrid: TCustomDBGridEh; const FieldName: string;
  const Text: String; Options: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
  Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
begin
  StartWait;
  try
    Result := Center.LocateText(Self, FieldName, Text,
      Options, Direction, Matching, TreeFindRange);
  finally
    StopWait;
  end;
end;

procedure TCustomDBGridEh.StartInplaceSearch(ss: String;
  TimeOut: Integer; InpsDirection: TLocateTextDirectionEh);
var
  NesSs, OldSs: String;
  RecordFounded: Boolean;
  LTOptions: TLocateTextOptionsEh;
  Field: TField;
  SText: String;
begin
  if not DataLink.Active then Exit;
  NesSs := FInplaceSearchText + ss;
  OldSs := FInplaceSearchText;
  RecordFounded := False;
  if NesSs <> '' then
  begin
    LockPaint;
    try
      Field := Columns[SelectedIndex].Field;
      if Assigned(Field) and
         (Field is TNumericField) and
         Center.PreferEditFormatForNumberFields
      then
        LTOptions := [ltoCaseInsensitiveEh, ltoStopOnEscape]
      else
        LTOptions := [ltoCaseInsensitiveEh, ltoMatchFormatEh, ltoStopOnEscape];
      RecordFounded := LocateText(Self, '', NesSs, LTOptions,
        InpsDirection, ltmFromBegingEh, lttInAllNodesEh);
      if RecordFounded then
      begin
        if ltoMatchFormatEh in LTOptions
          then SText := Columns[SelectedIndex].DisplayText
          else SText := Columns[SelectedIndex].EditText;
        NesSs := Copy(SText, 1, Length(NesSs));
        if ViewScroll then
          SafeMoveTop(Row - VisibleRowCount div 2);
      end;
    finally
      UnlockPaint;
    end;
  end;
  HideEditor;
  FInplaceSearching := True;
  if RecordFounded
    then FInplaceSearchText := NesSs
    else FInplaceSearchText := OldSs;
  GridInvalidateRow(Self, Row);
  FInplaceSearchTimeOut := TimeOut;
  StartInplaceSearchTimer;
end;

procedure TCustomDBGridEh.StopInplaceSearch;
begin
  if not FInplaceSearching then Exit;
  StopInplaceSearchTimer;
  FInplaceSearching := False;
  FInplaceSearchText := '';
  GridInvalidateRow(Self, Row);
  if (dgAlwaysShowEditor in Options) and CanEditorMode then ShowEditor;
end;

function TCustomDBGridEh.InplaceEditorVisible: Boolean;
begin
  Result := (InplaceEditor <> nil) and (InplaceEditor.Visible);
end;

procedure TCustomDBGridEh.SetReadOnly(const Value: Boolean);
begin
  if Value <> FReadOnly then
  begin
    FReadOnly := Value;
    Invalidate();
    if not (csReading in ComponentState) then
      SetColumnAttributes;
  end;
end;

procedure TCustomDBGridEh.SetAllowedSelections(const Value: TDBGridEhAllowedSelections);
begin
  if FAllowedSelections <> Value then
  begin
    FAllowedSelections := Value;
    if (Selection.SelectionType <> gstNon) and
      not (Selection.SelectionType in FAllowedSelections)
      then Selection.Clear;
  end;
end;

function TCustomDBGridEh.CanSelectType(const Value: TDBGridEhSelectionType): Boolean;
begin
  Result := (Value = gstNon) or
    ((dgMultiSelect in Options) and (Value in AllowedSelections)
    and
    (((Value in [gstRectangle, gstColumns]) and not (dgRowSelect in Options))
    or
    (Value in [gstRecordBookmarks, gstAll])
    ));
end;

procedure TCustomDBGridEh.SetColumnDefValues(const Value: TColumnDefValuesEh);
begin
  FColumnDefValues.Assign(Value);
end;

procedure TCustomDBGridEh.InvalidateCol(ACol: Integer);
begin
  inherited InvalidateCol(ACol);
end;

procedure TCustomDBGridEh.InvalidateRow(ARow: Integer);
begin
  inherited InvalidateRow(ARow);
end;

procedure TCustomDBGridEh.InvalidateCell(ACol, ARow: Longint);
begin
  inherited InvalidateCell(ACol, ARow);
end;

function TCustomDBGridEh.GetContraColCount: Longint;
begin
  Result := FContraColCount;
end;

procedure TCustomDBGridEh.SetContraColCount(const Value: Longint);
begin
  if FContraColCount <> Value then
  begin
    FContraColCount := Value;
    LayoutChanged;
  end;
end;

function TCustomDBGridEh.GetEvenRowColor: TColor;
begin
  if FEvenRowColorStored
    then Result := FEvenRowColor
    else Result := Color;
end;

function TCustomDBGridEh.GetOddRowColor: TColor;
begin
  if FOddRowColorStored
    then Result := FOddRowColor
    else Result := Color;
end;

function TCustomDBGridEh.IsEvenRowColorStored: Boolean;
begin
  Result := FEvenRowColorStored;
end;

function TCustomDBGridEh.IsOddRowColorStored: Boolean;
begin
  Result := FOddRowColorStored;
end;

procedure TCustomDBGridEh.SetEvenRowColor(const Value: TColor);
begin
  FEvenRowColorStored := True;
  if FEvenRowColor <> Value then
  begin
    FEvenRowColor := Value;
    Invalidate;
  end;
end;

procedure TCustomDBGridEh.SetOddRowColor(const Value: TColor);
begin
  FOddRowColorStored := True;
  if FOddRowColor <> Value then
  begin
    FOddRowColor := Value;
    Invalidate;
  end;
end;

function TCustomDBGridEh.DataRowToRecNo(DataRow: Integer): Integer;
var
  ActiveRecord: Integer;
begin
  Result := 0;
  if not FDataLink.Active then Exit;
  if ViewScroll then
    Result := DataRow + 1
  else
  begin
    ActiveRecord := DataLink.ActiveRecord;
    try
      DataLink.ActiveRecord := DataRow;
      Result := DataLink.DataSet.RecNo;
    finally
      DataLink.ActiveRecord := ActiveRecord;
    end;
  end;
end;

procedure TCustomDBGridEh.IndicatorTitleMouseDown(Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnIndicatorTitleMouseDown)
    then OnIndicatorTitleMouseDown(Self, Cell, Button, Shift, X, Y)
    else DefaultIndicatorTitleMouseDown(Cell, Button, Shift, X, Y);
end;

procedure TCustomDBGridEh.DefaultIndicatorTitleMouseDown(Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DropdownMenu: TPopupMenu;
  P: TPoint;
  ARect: TRect;
begin
  if IndicatorTitle.TitleButton then
  begin
    IndicatorTitle.FDown := True;
    FPressed := True;
    InvalidateCell(0,0);
    DropdownMenu := nil;
    BuildIndicatorTitleMenu(DropdownMenu);
    ARect := CellRect(0,0);
    P := ClientToScreen(Point(ARect.Left, ARect.Bottom));
    if (DropdownMenu <> nil) and (DropdownMenu.Items.Count > 0) then
    begin
      DropdownMenu.Popup(P.X, P.Y);
      if DropdownMenu.Owner = nil then
        DropdownMenu.Free;
      IndicatorTitle.FDown := False;
      FPressed := False;
      InvalidateCell(0,0);
      KillMouseUp(Self, ARect);
    end else
    begin
      if not MouseCapture then Exit;
//      MouseCapture := True;
      FDBGridEhState := dgsTitleDown;
      FTracking := True;
      FPressedCol := Cell.X;
      TrackButton(X, Y);
      Exit;
    end;
  end else if (dgMultiSelect in Options) and
    FDatalink.Active and (gstAll in AllowedSelections) then
  begin
    if Selection.SelectionType <> gstNon
      then Selection.Clear
      else Selection.SelectAll;
  end;
end;

procedure TCustomDBGridEh.BuildIndicatorTitleMenu(var PopupMenu: TPopupMenu);
begin
  if Assigned(OnBuildIndicatorTitleMenu)
    then OnBuildIndicatorTitleMenu(Self, PopupMenu)
    else DefaultBuildIndicatorTitleMenu(PopupMenu);
end;

procedure TCustomDBGridEh.DefaultBuildIndicatorTitleMenu(var PopupMenu: TPopupMenu);
begin
  Center.BuildIndicatorTitleMenu(Self, PopupMenu);
end;

procedure TCustomDBGridEh.MTViewDataEvent(RowNum: Integer;
      Event: TMTViewEventTypeEh; OldRowNum: Integer);
var
  NewRowCount: Integer;
begin
  if MemTableSupport and FIntMemTable.MemTableIsTreeList then
    Exit;
  case Event of
    mtRowInsertedEh:
      if DataGrouping.IsGroupingWorks then
      begin
        DataGrouping.GroupDataTree.RecordInserted(RowNum);
      end else begin
        if FIntMemTable.InstantReadRowCount > 1 then
          SetRowCount(RowCount + 1);
        MoveRow(RowCount-1, TopDataOffset + RowNum);
        UpdateDataRowHeight(RowNum);
      end;
    mtRowChangedEh:
      if DataGrouping.IsGroupingWorks then
      begin
        DataGrouping.GroupDataTree.RecordChanged(RowNum);
      end else
        UpdateDataRowHeight(RowNum);
    mtRowDeletedEh:
      begin
        if DataGrouping.IsGroupingWorks then
        begin
          DataGrouping.GroupDataTree.RecordDeleted(RowNum);
        end else if FIntMemTable.InstantReadRowCount > 0 then
          DeleteRow(TopDataOffset + RowNum);
      end;
    mtRowMovedEh:
      MoveRow(TopDataOffset + OldRowNum, TopDataOffset + RowNum);
    mtViewDataChangedEh:
      begin
        if DataGrouping.IsGroupingWorks then
        begin
//          DataGrouping.GroupDataTree.RebuildDataTree(FIntMemTable);
            DataGrouping.GroupDataTree.RebuildDataTreeEx(FIntMemTable);
          if FDataLink.Active then
          begin
            if FInternalUpdatingDatasetPos then Exit;
            FInternalUpdatingDatasetPos := True;
            try
              DataGroupsGotoRecordViewNo(FIntMemTable.InstantReadCurRowNum, False);
            finally
              FInternalUpdatingDatasetPos := False;
            end;
          end;
{          NewRowCount := TopDataOffset + DataGrouping.GroupDataTree.FlatVisibleCount;
          if FIntMemTable.InstantReadRowCount = 0 then
            Inc(NewRowCount);
          RowCount := NewRowCount;
          UpdateAllDataRowHeights;}
        end else
        begin
          if MemTableSupport then
          begin
            NewRowCount := TopDataOffset + FIntMemTable.InstantReadRowCount;
            if FIntMemTable.InstantReadRowCount = 0 then
              Inc(NewRowCount);
          end else
            NewRowCount := TopDataOffset + 1;
          RowCount := NewRowCount;
          UpdateAllDataRowHeights;
        end;
      end;
  end;
end;

procedure TCustomDBGridEh.UpdateDataRowHeight(DataRowNum: Integer);
var
  NewHeigth: Integer;
begin
  NewHeigth := CalcRowDataRowHeight(DataRowNum);
  if RowDetailPanel.Active and RowDetailPanel.Visible and (Row = DataRowNum + TopDataOffset) then
    NewHeigth := NewHeigth + RowDetailPanel.Height;
  RowHeights[DataRowNum + TopDataOffset] := NewHeigth;
end;

function TCustomDBGridEh.CalcRowForCurRecordHeight: Integer;
var
  i: Integer;
  ColHeight: Integer;
begin
  Result := 0;
  for i := 0 to Columns.Count-1 do
  begin
    if Columns[i].Visible then
    begin
       ColHeight := Columns[i].CalcRowHeight;
       if ColHeight > Result then
         Result := ColHeight;
    end;
  end;
  if Assigned(FOnGetRowHeight) then
    OnGetRowHeight(Self, Result);
end;

function TCustomDBGridEh.CalcRowDataRowHeight(DataRowNum: Integer): Integer;
var
//  i: Integer;
  NewHeigth{, ColHeight}: Integer;
begin
  if not FDataLink.Active then
  begin
    Result := FStdDefaultRowHeight;
    Exit;
  end;
  InstantReadRecordEnter(DataRowNum);
  try
//    NewHeigth := FStdDefaultRowHeight;
    if DataGrouping.IsGroupingWorks and (DataGrouping.GroupDataTree.FlatVisibleCount > 0)
      then NewHeigth := FDrawGroupDataNode.RowHeight
      else NewHeigth := CalcRowForCurRecordHeight;
{    if DataGrouping.Active and (FDrawGroupDataNode.NodeType = dntDataGroupEh) then
      NewHeigth := CalcHeightForGroupNode(FDrawGroupDataNode)
    else
      NewHeigth := CalcRowForCurRecordHeight;}
    Result := NewHeigth;
  finally
    InstantReadRecordLeave;
  end;
end;

procedure TCustomDBGridEh.UpdateAllGridDataRowHeights();
var
  i: Integer;
  IsTreeMode: Boolean;
begin
  IsTreeMode := MemTableSupport and FIntMemTable.MemTableIsTreeList;
  if FDataLink.Active and MemTableSupport and not IsTreeMode then
    try
      LockPaint;
      for i := 0 to InstantReadRecordCount-1 do
        UpdateDataRowHeight(i);
    finally
      UnlockPaint;
    end
  else
    RowHeights[TopDataOffset] := FStdDefaultRowHeight;
end;

procedure TCustomDBGridEh.UpdateAllDataRowHeights();
begin
  if csLoading in ComponentState then Exit;
  if DataGrouping.IsGroupingWorks then
    DataGrouping.GroupDataTree.UpdateAllDataRowHeights;
  UpdateAllGridDataRowHeights();
end;

procedure TCustomDBGridEh.ScrollData(DX, DY: Integer);
begin
  inherited ScrollData(DX, DY);
end;

procedure TCustomDBGridEh.SetEditButtonsShowOptions(Value: TEditButtonsShowOptionsEh);
begin
  if Value <> FEditButtonsShowOptions then
  begin
    FEditButtonsShowOptions := Value;
    Invalidate;
  end;
end;

procedure TCustomDBGridEh.DataGroupsVisibleChanged;
var
  NewRowCount: Integer;
begin
  NewRowCount := TopDataOffset + DataGrouping.GroupDataTree.FlatVisibleCount;
  if FIntMemTable.InstantReadRowCount = 0 then
    Inc(NewRowCount);
  RowCount := NewRowCount;
  UpdateAllGridDataRowHeights;
  UpdateScrollRange;
  Invalidate;
end;

function TCustomDBGridEh.ColWidthToCellWidth(Column: TColumnEh; AWidth: Integer): Integer;
begin
  Result := AWidth;
  if (VisibleColumns.Count > 0) and (Column = VisibleColumns[0]) then
    Inc(Result, FExtraFirstColumnWidth);
end;

function TCustomDBGridEh.CellWidthToColWidth(Column: TColumnEh; AWidth: Integer): Integer;
begin
  Result := AWidth;
  if (VisibleColumns.Count > 0) and (Column = VisibleColumns[0]) then
    Dec(Result, FExtraFirstColumnWidth);
end;

procedure TCustomDBGridEh.SetExtraFirstColumnWidth;
begin
  if DataGrouping.IsGroupingWorks
    then FExtraFirstColumnWidth := DataGrouping.ActiveGroupLevelsCount * 18
    else FExtraFirstColumnWidth := 0;
end;

procedure TCustomDBGridEh.DrawGroupDataCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  Value: string;
  DrawInfo: TGridDrawInfoEh;
  i: Integer;
  DrawRect, ARect1, FocusRect: TRect;
  TreeElement: TTreeElementEh;
  NextLevel: Integer;
  Focused: Boolean;
  AColor: TColor;
  LeftMarg, RightMarg: Integer;
  YFrameOffs, XFrameOffs: Integer;
begin
  if FDrawnGroupList.IndexOf(FDrawGroupDataNode) >= 0 then
    Exit;
  Value := FDrawGroupDataNode.DataGroup.GetGroupRowText(FDrawGroupDataNode);

  Focused := IsActiveControl;
  if Focused and (ARow = Row) then
    Include(AState, gdFocused);

//  if AreaCol = 0 then
  begin
    CalcDrawInfo(DrawInfo);
    ARect1 := ARect;

    for i := ACol - 1 downto FixedCols do
      Dec(ARect1.Left, ColWidths[i] + GridLineWidth);

    Canvas.Pen.Color := GridLineColors.GetBrightColor;
    DrawRect := ARect1;
    if FDrawGroupDataNode.Level > 1 then
    begin
      ARect1.Right := ARect1.Left + (FDrawGroupDataNode.Level-1) * 18;
//      Canvas.FillRect(ARect1);
      if DataGrouping.GroupDataTree.FlatVisibleCount - 1 > AreaRow
        then NextLevel := DataGrouping.GroupDataTree.FlatVisibleItem[AreaRow+1].Level
        else NextLevel := 0;
      for i := 0 to FDrawGroupDataNode.Level - 2 do
      begin
        Canvas.Brush.Color := DataGrouping.ActiveGroupLevels[FDrawGroupDataNode.Level-2-i].Color;
        Canvas.FillRect(Rect(ARect1.Right-i*18-18, ARect1.Top, ARect1.Right-i*18, ARect1.Bottom));
        DrawPolyline([Point(ARect1.Right-1-i*18, ARect1.Top),
                      Point(ARect1.Right-1-i*18, ARect1.Bottom)]);
        if NextLevel + i < FDrawGroupDataNode.Level then
        begin
          DrawPolyline([Point(ARect1.Right-1-i*18, ARect1.Bottom-1),
                        Point(ARect1.Right-1-i*18-18, ARect1.Bottom-1)]);
        end;
      end;
      ARect1.Left := ARect1.Right;
    end;

    Canvas.Font := FDrawGroupDataNode.DataGroup.Font;
    Canvas.Brush.Color := FDrawGroupDataNode.DataGroup.Color;
    AColor := Canvas.Brush.Color;

    HighlightGroupDataCellColor(AreaCol, AreaRow, Value, AState, AColor, Canvas.Font);

    Canvas.Brush.Color := AColor;

{    if gdFocused in AState then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end;}

    ARect1.Bottom := ARect1.Bottom - 1;
    ARect1.Right := ARect1.Left + 18;
    DrawRect.Left := ARect1.Right;
    DrawRect.Bottom := DrawRect.Bottom - 1;
    Canvas.FillRect(ARect1);
    if FDrawGroupDataNode.Expanded
      then TreeElement := tehMinus
      else TreeElement := tehPlus;

    DrawTreeElement(Canvas, ARect1, TreeElement, True, 1, 1, UseRightToLeftAlignment);
    if FDrawGroupDataNode.Expanded
      then Canvas.Pen.Color := FDrawGroupDataNode.DataGroup.Color
      else Canvas.Pen.Color := GridLineColors.GetBrightColor;
    DrawPolyline([Point(ARect1.Left, ARect1.Bottom),
                  Point(ARect1.Right, ARect1.Bottom)]);

    for i := ACol+1 to FixedCols-1 do
      Inc(DrawRect.Right, ColWidths[i] + GridLineWidth);
//    Dec(DrawRect.Right, FDataOffset.cx);
    for i := ACol+1 to LeftCol + VisibleColCount do
    begin
      if i < ColCount then
        if (i = FLastVisibleCol)
          then Inc(DrawRect.Right, ColWidths[i])
          else Inc(DrawRect.Right, ColWidths[i] + GridLineWidth);
    end;
    FocusRect := DrawRect;
    FocusRect.Left := ARect1.Left;

    if False{The3DRect}
      then XFrameOffs := 1
      else XFrameOffs := 2;
    YFrameOffs := XFrameOffs;
    if Flat then Dec(YFrameOffs);
    LeftMarg := 0;
    RightMarg := 0;
    if DrawRect.Left < DrawInfo.Horz.FixedBoundary then
    begin
      LeftMarg := DrawRect.Left - DrawInfo.Horz.FixedBoundary;
      DrawRect.Left := DrawInfo.Horz.FixedBoundary;
      Inc(LeftMarg, XFrameOffs);
      XFrameOffs := 0;
    end;

    WriteCellText(nil, Canvas, DrawRect, True,
      XFrameOffs, YFrameOffs, Value, taLeftJustify, tlTop,
      False, False, LeftMarg, RightMarg);
//    Canvas.TextRect(DrawRect, DrawRect.Left, DrawRect.Top, Value);
    Canvas.Pen.Color := GridLineColors.GetBrightColor;
    DrawPolyline([Point(DrawRect.Left-1, DrawRect.Bottom),
                  Point(DrawRect.Right, DrawRect.Bottom)]);

    if (gdFocused in AState)
      and ({(dgAlwaysShowSelection in Options) or }Focused)
      and not (csDesigning in ComponentState)
      and not (dgRowSelect in Options)
      and (UpdateLock = 0)
      and (ValidParentForm(Self).ActiveControl = Self)
      and Style.IsDrawFocusRect
    then
      DrawFocusRect(Canvas, FocusRect);

  end;
  FDrawnGroupList.Add(FDrawGroupDataNode);
end;

procedure TCustomDBGridEh.DrawGroupDataArea(DataCol, DataRow: Integer;
  NodeLevel: Integer; AState: TGridDrawState; ARect: TRect; Draw3DRect: Boolean);
var
  NextLevel: Integer;
  i: Integer;
begin
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect(ARect.Left, ARect.Top,
                       ARect.Left + FExtraFirstColumnWidth,
                       ARect.Bottom));
  Canvas.Pen.Color := GridLineColors.GetBrightColor;
//      DrawPolyline([Point(ARect.Left+FExtraFirstColumnWidth-1, ARect.Top),
//                    Point(ARect.Left+FExtraFirstColumnWidth-1, ARect.Bottom)]);
  DrawPolyline([Point(ARect.Left+FExtraFirstColumnWidth-1, ARect.Bottom-1),
                Point(ARect.Right, ARect.Bottom-1)]);

  if DataGrouping.GroupDataTree.FlatVisibleCount - 1 > DataRow
    then NextLevel := DataGrouping.GroupDataTree.FlatVisibleItem[DataRow+1].Level
    else NextLevel := 0;
  for i := 0 to NodeLevel - 2 do
  begin
    Canvas.Brush.Color := DataGrouping.ActiveGroupLevels[NodeLevel-2-i].Color;
    Canvas.FillRect(Rect(ARect.Left+FExtraFirstColumnWidth-i*18-18, ARect.Top,
                         ARect.Left+FExtraFirstColumnWidth-i*18, ARect.Bottom));
    DrawPolyline([Point(ARect.Left+FExtraFirstColumnWidth-1-i*18, ARect.Top),
                  Point(ARect.Left+FExtraFirstColumnWidth-1-i*18, ARect.Bottom)]);
    if NextLevel + i < NodeLevel then
      DrawPolyline([Point(ARect.Left+FExtraFirstColumnWidth-1-i*18, ARect.Bottom-1),
                    Point(ARect.Left+FExtraFirstColumnWidth-1-i*18-18, ARect.Bottom-1)]);
  end;
end;

procedure TCustomDBGridEh.DataGroupsGotoRecordViewNo(RecViewNo: Integer; IsExpandToView: Boolean);
var
  GroupNode: TGroupDataTreeNodeEh;
begin
  GroupNode := TGroupDataTreeNodeEh(DataGrouping.GroupDataTree.GetFirstVisible);
  while GroupNode <> nil do
  begin
    if (GroupNode.NodeType = dntDataSetRecordEh) and
       (GroupNode.DataSetRecordViewNo = RecViewNo) then
    begin
      if IsExpandToView
        then SetCurGroupDataNode(GroupNode, True)
        else CheckSetCurGroupDataNode(GroupNode, True);
      Break;
    end;
    GroupNode := TGroupDataTreeNodeEh(DataGrouping.GroupDataTree.GetNextVisible(GroupNode, False));
  end;
end;

function TCustomDBGridEh.DataGroupsMoveBy(Distance: Integer): Integer;
var
  GDTree: TGridGroupDataTreeEh;
  CurPos: Integer;

{  function CheckRecordChanging(RowPos: Integer): Integer;
  begin
    if RowPos < 0 then RowPos := 0;
    if RowPos > GDTree.FlatVisibleCount-1 then RowPos := GDTree.FlatVisibleCount-1;
    if GDTree.FlatVisibleItem[CurPos + Result]
  end;}

begin
  Result := Distance;
  GDTree := DataGrouping.GroupDataTree;
  CurPos := GDTree.IndexOfVisibleNode(FCurGroupDataNode);
  FDatalink.UpdateData;
  if (Result <> 0) and
     FDataLink.Active and
     (FDataLink.DataSet.State in dsEditModes)
//     and CheckRecordChanging(CurPos + Result)
     then
    if FDataLink.DataSet.Modified
      then FDataLink.DataSet.Post
      else FDataLink.DataSet.Cancel;
  if Result > 0 then
  begin
    if CurPos + Result >= GDTree.FlatVisibleCount then
      Result := GDTree.FlatVisibleCount - CurPos - 1;
    SetCurGroupDataNode(GDTree.FlatVisibleItem[CurPos + Result], True);
  end else
  begin
    if CurPos + Result < 0 then
      Result := -CurPos;
    SetCurGroupDataNode(GDTree.FlatVisibleItem[CurPos + Result], True);
  end;
  UpdateDatasetPosFromRowPos;
end;

procedure TCustomDBGridEh.UpdateDatasetPosFromRowPos;
var
  OldRecNo, NewRecNo: Integer;
  ADrawGroupDataNode: TGroupDataTreeNodeEh;
begin
  if not FDataLink.Active then Exit;
  if FInternalUpdatingDatasetPos then Exit;
  OldRecNo := FDataLink.DataSet.RecNo;
  if DataGrouping.IsGroupingWorks then
  begin
    ADrawGroupDataNode := FCurGroupDataNode;
    while not (ADrawGroupDataNode.NodeType = dntDataSetRecordEh) do
    begin
      ADrawGroupDataNode := ADrawGroupDataNode.Items[0];
    end;
    NewRecNo := ADrawGroupDataNode.DataSetRecordViewNo + 1;
    FInternalUpdatingDatasetPos := True;
    try
      if OldRecNo > 0
        then FDataLink.DataSet.MoveBy(NewRecNo-OldRecNo)
        else FDataLink.DataSet.RecNo := NewRecNo;
    finally
      FInternalUpdatingDatasetPos := False;
    end;
  end;
end;

procedure TCustomDBGridEh.UpdateDatasetPosFromGroupNode(GroupNode: TGroupDataTreeNodeEh);
begin
//  if GroupNode.NodeType = dntDataSetRecordEh then
end;

procedure TCustomDBGridEh.CheckSetCurGroupDataNode(
  ACurGroupDataNode: TGroupDataTreeNodeEh; ShowInView: Boolean);
var
  VisibleNode: TGroupDataTreeNodeEh;
begin
  VisibleNode := ACurGroupDataNode;
  while (VisibleNode.Parent <> DataGrouping.GroupDataTree.Root) and
     not DataGrouping.GroupDataTree.GetPathVisible(VisibleNode, True) do
  begin
    VisibleNode := TGroupDataTreeNodeEh(VisibleNode.Parent);
  end;
  SetCurGroupDataNode(VisibleNode, ShowInView);
end;

procedure TCustomDBGridEh.SetCurGroupDataNode(
  ACurGroupDataNode: TGroupDataTreeNodeEh; ShowInView: Boolean);
var
  GroupNode, ParentNode: TGroupDataTreeNodeEh;
  DataRowNo: Integer;
  OldTopRow, NewRow{, NewCol}: Integer;
  ShowCol: Boolean;
  Field: TField;
begin
//  if ACurGroupDataNode <> FCurGroupDataNode then
  begin
    GroupNode := TGroupDataTreeNodeEh(DataGrouping.GroupDataTree.GetFirstVisible);
    while GroupNode <> nil do
    begin
      if GroupNode = ACurGroupDataNode then
      begin
        FCurGroupDataNode := GroupNode;
        ParentNode := GroupNode;
        while ParentNode.Parent <> DataGrouping.GroupDataTree.Root do
        begin
          ParentNode := TGroupDataTreeNodeEh(ParentNode.Parent);
          ParentNode.Expanded := True;
        end;
        Break;
      end;
      GroupNode := TGroupDataTreeNodeEh(DataGrouping.GroupDataTree.GetNextVisible(GroupNode, False));
    end;

    DataRowNo := DataGrouping.GroupDataTree.IndexOfVisibleNode(FCurGroupDataNode);

    OldTopRow := TopRow;
    NewRow := DataRowNo + TopDataOffset;
    if NewRow >= RowCount then
      NewRow := FixedRows;
    if Row <> NewRow then
    begin
      GridInvalidateRow(Self, Row);
      if not (dgAlwaysShowEditor in Options) then HideEditor;
      ShowCol := not FLockAutoShowCurCell and
                 not RowPanel.Active and
                 (ACurGroupDataNode.NodeType = dntDataSetRecordEh) and
                 ShowInView;
//      if FCurGroupDataNode.NodeType = dntDataGroupEh
//        then NewCol := IndicatorOffset
//        else NewCol := IndicatorOffset + SelectedIndex
//      MoveColRow(Col, NewRow, False, ShowCol, True);
      MoveColRow(Col, NewRow, False, ShowCol, ShowInView);
      if RowPanel.Active then
        ClampInViewRowPanelCell(SelectedIndex);
      InvalidateEditor;
      GridInvalidateRow(Self, NewRow);
      UpdateDatasetPosFromRowPos;      
    end;
  //      Columns[SelectedIndex].Field := nil; //Some time AV BUG
    if InplaceEditorVisible then
    begin
      Field := SelectedField;
      if Assigned(Field) and (Field.Text <> FEditText) then
        InvalidateEditor;
    end;
    if HaveHideDuplicates and (OldTopRow <> TopRow) then
    begin
      GridInvalidateRow(Self, TopRow);
      GridInvalidateRow(Self, OldTopRow);
    end;
  end;
end;

function TCustomDBGridEh.CalcHeightForGroupNode(
  ADrawGroupDataNode: TGroupDataTreeNodeEh): Integer;
var
  DataGroup: TGridDataGroupLevelEh;
begin
  Result := 0;
  DataGroup := ADrawGroupDataNode.DataGroup;
  if not HandleAllocated or
    ((DataGroup.RowHeight = 0) and
     (DataGroup.RowLines = 0)) then
  begin
//    Result := CalcStdDefaultRowHeight;
    Canvas.Font := DataGroup.Font;
    Result := Canvas.TextHeight('Wg');
    if Flat
      then Result := Result + 1
      else Result := Result + 3;
    if dgRowLines in Options then
      Inc(Result, GridLineWidth);
    Exit;
  end;
  if HandleAllocated and (DataGroup.RowLines > 0) then
  begin
    Canvas.Font := DataGroup.Font;
    Result := Canvas.TextHeight('Wg') * DataGroup.RowLines;
  end;
  Result := Result + DataGroup.RowHeight;
end;

function TCustomDBGridEh.HighlightGroupDataCellColor(DataCol, DataRow: Integer;
  const Value: string; AState: TGridDrawState; var AColor: TColor;
  AFont: TFont): Boolean;
var
  AFocused: Boolean;
begin
//  Result := False;
//  AFocused := False;
//  if not Result then
  begin
    AFocused := Focused and (dghHighlightFocus in OptionsEh);
    if DataRow + TopDataOffset = Row then
    begin
      AFocused := True;
      AState := AState + [gdSelected];
    end;
    Result := ( (gdSelected in AState) or (DataRow + TopDataOffset = Row) ) and
              ( (dgAlwaysShowSelection in Options) or (AFocused) )
        { updatelock eliminates flicker when tabbing between rows }
            and (UpdateLock = 0);
  end;
  if Result then
    if IsSelectionActive then
    begin
      AColor := clHighlight;
      AFont.Color := clHighlightText;
    end else if (DataRow + TopDataOffset = Row) and
                ( (dgAlwaysShowSelection in Options) or AFocused ) then
    begin
      AColor := clBtnShadow;
      AFont.Color := clHighlightText;
    end else
      AColor := clBtnFace;
end;

procedure TCustomDBGridEh.KeyDownInGroupDataNode(var Key: Word; Shift: TShiftState);
begin
  if (Shift * [ssShift, ssAlt, ssCtrl]) = [] then
    case Key of
      VK_UP: MoveBy(-1);
      VK_DOWN: MoveBy(1);
      VK_LEFT: if FCurGroupDataNode.Expanded = True
                then FCurGroupDataNode.Expanded := False
                else SafeSmoothScrollData(-GetHorzScrollStep, 0);
      VK_SUBTRACT: FCurGroupDataNode.Expanded := False;
      VK_RIGHT: if FCurGroupDataNode.Expanded = False
                  then FCurGroupDataNode.Expanded := True
                  else SafeSmoothScrollData(GetHorzScrollStep, 0);
      VK_ADD: FCurGroupDataNode.Expanded := True;
      VK_HOME: ;
      VK_END: ;
      VK_NEXT: MoveBy(VisibleDataRowCount);
      VK_PRIOR: MoveBy(-VisibleDataRowCount);
      VK_INSERT: ;
      VK_TAB: ;
      VK_RETURN: ;
      VK_ESCAPE: 
          begin
            FDatalink.Reset;
            ClearSelection;
            if not (dgAlwaysShowEditor in Options) then HideEditor;
            if (FGridState in [gsColMoving, gsRowSizing, gsColSizing]) or
              (FDBGridEhState in [dgsColSizing, dgsRowMoving, dgsGroupPanelTitleMoving] )
              then Perform(WM_CANCELMODE, 0, 0);
          end;    
      VK_F2: ;
      VK_DELETE: ;
      VK_MULTIPLY: FCurGroupDataNode.Expanded := not FCurGroupDataNode.Expanded;
    end;
end;

procedure TCustomDBGridEh.DataInsert;
begin
  if DataGrouping.IsGroupingWorks then
  begin
    DataGrouping.SetInsertingKeyValue(DataGrouping.GetKeyValueForViewRecNo(FIntMemTable.InstantReadCurRowNum));
  end;
  FDataLink.DataSet.Insert;
end;

procedure TCustomDBGridEh.DataAppend;
begin
  FDataLink.DataSet.Append;
end;

procedure TCustomDBGridEh.GroupPanelVisibleChanged;
var
  LastGroup: TGridDataGroupLevelEh;
begin
  if DataGrouping.GroupPanelVisible then
  begin
    ResetGroupPanel;
    if DataGrouping.ActiveGroupLevelsCount > 0
      then LastGroup := DataGrouping.ActiveGroupLevels[DataGrouping.ActiveGroupLevelsCount-1]
      else LastGroup := nil;
    if LastGroup <> nil then
      OutBoundaryData.TopIndent := LastGroup.GroupPanelRect.Bottom + 5
    else
      OutBoundaryData.TopIndent := 30;
  end else
    OutBoundaryData.TopIndent := 0;
  LayoutChanged;
end;

procedure TCustomDBGridEh.DrawTopOutBoundaryGroupCaption(
  ARect: TRect; GroupLevel: TGridDataGroupLevelEh);
const
  SortMarkers: array[TSortOrderEh] of TSortMarkerEh = (smDownEh, smUpEh);
var
  Column: TcolumnEh;
  CaptionText: String;
  GroupRect, AFillRect: TRect;
  The3DRect: Boolean;
  ADrawByThemes: Boolean;
  ATitleState: TDBGirdDrawTitleStateEh;
  AState: TGridDrawState;
begin
  The3DRect := dghFixed3D in OptionsEh;
  ADrawByThemes := ThemesEnabled and not Flat and The3DRect;

  Column := TColumnEh(GroupLevel.Column);
  CaptionText := Column.Title.Caption;
  GroupRect := ARect;

  Canvas.Brush.Color := GridLineColors.GetDarkColor;
  Canvas.FrameRect(GroupRect);
  Canvas.Brush.Color := Color;

  AFillRect := GroupRect;
  InflateRect(AFillRect, -1, -1);

  ATitleState.Down := (FDBGridEhState = dgsGroupPanelTitleDown) and
                      (FPressedDataGroupLevelIdx = GroupLevel.Index) and
                       FPressed;
  ATitleState.MultyTitle := False;
  ATitleState.WordWrap := False;
  ATitleState.FilterButtonDown := False;
  ATitleState.Highlight := False;
  ATitleState.Orientation := tohHorizontal;
  ATitleState.The3DRect := The3DRect;
  ATitleState.DrawByThemes := ADrawByThemes;
  ATitleState.Caption := Column.Title.Caption;
  ATitleState.BackColor := Column.Title.Color;
  ATitleState.DrawFilterButton := STFilter.Visible and (STFilter.Location = stflInTitleFilterEh);
  ATitleState.CellMultiSelected := False;
//  ATitleState.SortMarker := Column.Title.SortMarker;
  ATitleState.SortMarker := SortMarkers[GroupLevel.SortOrder];
  ATitleState.DrawSortIndex := False;
  ATitleState.FontCharset := Column.Title.Font.Charset;
  ATitleState.FontColor := Column.Title.Font.Color;
  ATitleState.FontSize := Column.Title.Font.Size;
  ATitleState.FontName := Column.Title.Font.Name;
  ATitleState.FontStyle := Column.Title.Font.Style;
  AState := [gdFixed];
  if IsMouseInRect(AFillRect) then
    Include(AState, gdHotTrack);

  DrawTitleCellState(Column, AFillRect, AState, ATitleState);
end;

procedure TCustomDBGridEh.DrawTopOutBoundaryData(ARect: TRect);
var
  k: Integer;
  GroupRect: TRect;
  OSize: TSize;
begin
  Canvas.Brush.Color := ApproximateColor(FixedColor, GridLineColors.GetDarkColor, 85);
  Canvas.FillRect(ARect);
  Canvas.Pen.Color := GridLineColors.GetDarkColor;
  DrawPolyline([Point(ARect.Left, ARect.Bottom-1), Point(ARect.Right, ARect.Bottom-1)]);

  Canvas.Font := Self.Font;
  OSize.cx := Canvas.TextWidth('o');
  OSize.cy := OSize.cx * 2 div 3;
  GroupRect.Top := OSize.cy;
  GroupRect.Left := OSize.cx;

  if DataGrouping.ActiveGroupLevelsCount = 0 then
  begin
    Canvas.Font.Color := cl3DDkShadow;
    Canvas.TextOut(ARect.Bottom div 6, ARect.Bottom div 6, SGroupingPanelText);
    Exit;
  end;

  for k := 0 to DataGrouping.ActiveGroupLevelsCount-1 do
  begin
    if DataGrouping.ActiveGroupLevels[k].Column <> nil then
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[k].GroupPanelRect;

      DrawTopOutBoundaryGroupCaption(GroupRect, DataGrouping.ActiveGroupLevels[k]);
      if k <> DataGrouping.ActiveGroupLevelsCount-1 then
      begin
        Canvas.Pen.Color := GridLineColors.GetDarkColor;
        DrawPolyline([Point(GroupRect.Right - OSize.cx, GroupRect.Bottom),
                  Point(GroupRect.Right - OSize.cx, GroupRect.Bottom+OSize.cy),
                  Point(GroupRect.Right + OSize.cy, GroupRect.Bottom+OSize.cy)]);
      end;
      OffsetRect(GroupRect, GroupRect.Right - GroupRect.Left + OSize.cy, (GroupRect.Bottom - GroupRect.Top) div 2);
    end;
  end;
end;

procedure TCustomDBGridEh.MouseDownInOutBoundary(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  k: Integer;
  GroupRect, StateRect: TRect;
  Column: TColumnEh;
  EnableClick: Boolean;
begin
  if Button <> mbLeft then Exit;
  for k := 0 to DataGrouping.ActiveGroupLevelsCount-1 do
  begin
    if DataGrouping.ActiveGroupLevels[k].Column <> nil then
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[k].GroupPanelRect;
      InflateRect(GroupRect,-1,-1);
      if PtInRect(GroupRect, Point(X, Y)) then
      begin
        Column := TColumnEh(DataGrouping.ActiveGroupLevels[k].Column);
        if STFilter.Visible and (STFilter.Location = stflInTitleFilterEh) and
           CheckTitleCellFilterButtonPos(Point(X, Y), GroupRect, Column, StateRect) then
        begin
          FTrackingStateRect := StateRect;
          if FInTitleFilterListboxVisible then
            InTitleFilterListboxCloseUp(False)
          else
          begin
            FInTitleFilterListboxGroupLevel := DataGrouping.ActiveGroupLevels[k];
            InTitleFilterListboxDropDownForRect(Column, GroupRect);
          end;
          WindowsInvalidateRect(Handle, GroupRect, False);
        end else
        begin
          EnableClick := Column.Title.TitleButton;
          CheckTitleButton(Column.Index, EnableClick);
          if EnableClick and not (csDesigning in ComponentState)  then
          begin
            if not MouseCapture then Exit;
            FTracking := True;
            FPressedCol := -1;
            FPressedDataCol := Column.Index;
            FPressedDataGroupLevelIdx := k;
            FDBGridEhState := dgsGroupPanelTitleDown;
            TrackButton(X, Y);
          end else
          begin
            FGroupDataMovingIndex := k;
            StartGroupPanelTitleMovingMode(Shift, X, Y);
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TCustomDBGridEh.ResetGroupPanel;
var
  k: Integer;
  TitleWidth: Integer;
  CaptionText: String;
  GroupRect: TRect;
  Column: TcolumnEh;
  OSize: TSize;
  ExtraWidth: Integer;
begin

  Canvas.Font := Self.Font;
  OSize.cx := Canvas.TextWidth('o');
  OSize.cy := OSize.cx * 2 div 3;
  GroupRect.Top := OSize.cy;
  GroupRect.Left := OSize.cx;

  for k := 0 to DataGrouping.ActiveGroupLevelsCount-1 do
  begin
    if DataGrouping.ActiveGroupLevels[k].Column <> nil then
    begin
      Column := TColumnEh(DataGrouping.ActiveGroupLevels[k].Column);
      CaptionText := Column.Title.Caption;
      Canvas.Font := Self.Font;
      TitleWidth := Canvas.TextWidth(CaptionText);
      GroupRect.Bottom := GroupRect.Top + Canvas.TextHeight('Wg') + FInterlinear + 2 + 1;
      GroupRect.Right := GroupRect.Left  + TitleWidth + FInterlinear + 2 + 1;
      ExtraWidth := 16;
      if ExtraWidth <> 0 then
        GroupRect.Right := GroupRect.Right + {2 + }ExtraWidth;
      ExtraWidth := Column.Title.GetFilterButtonAreaWidth;
      if ExtraWidth <> 0 then
        GroupRect.Right := GroupRect.Right + {2 + }ExtraWidth;

      DataGrouping.ActiveGroupLevels[k].GroupPanelRect := GroupRect;

      OffsetRect(GroupRect, GroupRect.Right - GroupRect.Left + OSize.cy, (GroupRect.Bottom - GroupRect.Top) div 2);
    end;
  end;
end;

procedure TCustomDBGridEh.GetGroupMoveLineInfo(X, Y: Integer;
  var GroupMoveLinePos: TPoint; var GroupMoveLineSize: Integer; var InDataGroupIndex: Integer);
var
  k: Integer;
  GroupRect: TRect;
  HalfSize: Integer;
  OSize: TSize;
begin
  Canvas.Font := Self.Font;
  OSize.cx := Canvas.TextWidth('o');
  OSize.cy := OSize.cx * 2 div 3;

  GroupMoveLinePos.X := OSize.cx; GroupMoveLinePos.Y := OSize.cy;
  GroupMoveLinePos.X := GroupMoveLinePos.X - (OSize.cx div 2);
  GroupMoveLineSize := Canvas.TextHeight('Wg') + FInterlinear + 2 + 1;
  InDataGroupIndex := 0;

  for k := 0 to DataGrouping.ActiveGroupLevelsCount-1 do
  begin
    GroupRect := DataGrouping.ActiveGroupLevels[k].GroupPanelRect;
    HalfSize := (GroupRect.Right - GroupRect.Left) div 2;
    if GroupRect.Left + HalfSize > X then
      Exit;
    if k < DataGrouping.ActiveGroupLevelsCount-1 then
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[k+1].GroupPanelRect;
      GroupMoveLinePos := GroupRect.TopLeft;
      GroupMoveLinePos.X := GroupMoveLinePos.X - (OSize.cx div 2);
    end else
    begin
      GroupRect := DataGrouping.ActiveGroupLevels[k].GroupPanelRect;
      GroupMoveLinePos := GroupRect.TopLeft;
      GroupMoveLinePos.X := GroupRect.Right + (OSize.cx div 2);
    end;
    InDataGroupIndex := k+1;
  end;
end;

procedure TCustomDBGridEh.StartGroupPanelTitleMovingMode(Shift: TShiftState; X, Y: Integer);
var
  GroupMoveLineSize: Integer;
  GroupMoveLinePos: TPoint;
  InDataGroupIndex: Integer;
begin
  if FGridState = gsColMoving then
  begin
    CancelMode;
    GetGroupMoveLineInfo(X, Y, GroupMoveLinePos, GroupMoveLineSize, InDataGroupIndex);
    GetMoveLineEh.StartShow(Self, GroupMoveLinePos, True, GroupMoveLineSize);
    FDBGridEhState := dgsGroupPanelTitleMoving;
  end else
  begin
    CancelMode;
    GetGroupMoveLineInfo(X, Y, GroupMoveLinePos, GroupMoveLineSize, InDataGroupIndex);
    GetMoveLineEh.StartShow(Self, GroupMoveLinePos, True, GroupMoveLineSize);
    FDBGridEhState := dgsGroupPanelTitleMoving;
  end;
end;

procedure TCustomDBGridEh.DragGroupPanelTitleMovingMode(Shift: TShiftState; X, Y: Integer);
var
  GroupMoveLineSize: Integer;
  GroupMoveLinePos: TPoint;
  InDataGroupIndex: Integer;
  ADrawInfo: TGridDrawInfoEh;
  AMoveIndex: Integer;
  TitleRect: TRect;
  ACellRect: TRect;
begin
  if Y > OutBoundaryData.TopIndent then
  begin
    StopGroupPanelTitleMovingMode(Shift, X, Y, False);
    if RowPanel.Active then
    begin
      if FGroupDataMovingIndex >= 0 then
        FPressedDataCol := TColumnEh(DataGrouping.ActiveGroupLevels[FGroupDataMovingIndex].Column).Index;
//      FPressedDataCol := RawToDataColumn(AMoveIndex);
      FMoveIndex := FPressedDataCol;
      FDownMousePos := Point(X,Y);
      FMoveMousePos := Point(X,Y);
      ACellRect := CellRect(IndicatorOffset, 0);
      TitleRect.Left := X - Columns[FPressedDataCol].FRowPlacement.Width div 2 - ACellRect.Left;
      TitleRect.Top := Y - Columns[FPressedDataCol].FRowPlacement.Height div 2 - ACellRect.Top;
      TitleRect.Right := TitleRect.Left + Columns[FPressedDataCol].Width;
      TitleRect.Bottom := TitleRect.Top + Columns[FPressedDataCol].FRowPlacement.Height;
      StartRowPanelTitleCellDragBox(Shift, X, Y, FPressedDataCol, TitleRect);
    end else
    begin
      if FGroupDataMovingIndex >= 0 then
        AMoveIndex := DataToRawColumn(TColumnEh(DataGrouping.ActiveGroupLevels[FGroupDataMovingIndex].Column).Index)
      else
        AMoveIndex := FMoveIndex;
      CalcDrawInfo(ADrawInfo);
      StartColMoving(AMoveIndex, X, Y, ADrawInfo);
    end;
  end else
  begin
    GetGroupMoveLineInfo(X, Y, GroupMoveLinePos, GroupMoveLineSize, InDataGroupIndex);
    GetMoveLineEh.MoveToFor(Self, GroupMoveLinePos);
  end;
end;

procedure TCustomDBGridEh.StopGroupPanelTitleMovingMode(Shift: TShiftState; X, Y: Integer; IsAccept: Boolean);
var
  GroupMoveLineSize: Integer;
  GroupMoveLinePos: TPoint;
  InDataGroupIndex: Integer;
begin
  GetGroupMoveLineInfo(X, Y, GroupMoveLinePos, GroupMoveLineSize, InDataGroupIndex);
  GetMoveLineEh.Hide;
  FDBGridEhState := dgsNormal;
  if IsAccept then
  begin
    if FGroupDataMovingIndex >= 0 then
    begin
      if InDataGroupIndex > FGroupDataMovingIndex then
        Dec(InDataGroupIndex);
      if InDataGroupIndex <> FGroupDataMovingIndex then
      begin
        DataGrouping.ActiveGroupLevels[FGroupDataMovingIndex].Index := InDataGroupIndex;
//        DataGrouping.Active := False;
//        DataGrouping.Active := True;
      end;
    end else
      with DataGrouping.GroupLevels.Add do
      begin
        Index := InDataGroupIndex;
        if RowPanel.Active
          then Column := Columns[FPressedDataCol]
          else Column := Columns[RawToDataColumn(FMoveIndex)];
        TColumnEh(Column).Visible := False;
//        DataGrouping.Active := False;
//        DataGrouping.Active := True;
      end;
  end;
end;

procedure TCustomDBGridEh.SetDataGrouping(Value: TDBGridEhDataGroupsEh);
begin
  FDataGrouping.Assign(Value);
end;

procedure TCustomDBGridEh.GroupPanelTitleUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
  Column: TColumnEh;
  GroupLevel: TGridDataGroupLevelEh;
begin
  DoClick := FPressed;
  GroupLevel := DataGrouping.GroupLevels[FPressedDataGroupLevelIdx];
  Column := Columns[FPressedDataCol];
  StopTracking;
  if DoClick then
  begin
    DoTitleClick(Column.Index, Column);
    if GroupLevel.SortOrder = soAscEh
      then GroupLevel.SortOrder := soDescEh
      else GroupLevel.SortOrder := soAscEh;
    CheckSetCurGroupDataNode(FCurGroupDataNode, False);
  end;
end;

{ TColumnFooterEh }

constructor TColumnFooterEh.Create(Collection: TCollection);
var
  AFont: TFont;
begin
  inherited Create(Collection);
  if Assigned(Collection) and (Collection is TColumnFootersEh) then
    FColumn := TColumnFootersEh(Collection).Column;
  FFont := TFont.Create;
  AFont := DefaultFont;
  if Assigned(AFont) then
    FFont.Assign(AFont);
  FFont.OnChange := FontChanged;
  if Assigned(FColumn) and Assigned(FColumn.Grid) then
    FColumn.Grid.InvalidateFooter;
end;

constructor TColumnFooterEh.CreateApart(Column: TColumnEh);
begin
  inherited Create(nil);
  FColumn := Column;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
end;

destructor TColumnFooterEh.Destroy;
begin
  if Assigned(FColumn) and Assigned(FColumn.Grid) then
    FColumn.Grid.InvalidateFooter;
  FreeAndNil(FFont);
  if FDBSum <> nil then FreeAndNil(FDBSum);
  inherited Destroy;
end;

procedure TColumnFooterEh.Assign(Source: TPersistent);
begin
  if Source is TColumnFooterEh then
  begin
    if cvFooterAlignment in TColumnFooterEh(Source).FAssignedValues then
      Alignment := TColumnFooterEh(Source).Alignment;
    if cvFooterColor in TColumnFooterEh(Source).FAssignedValues then
      Color := TColumnFooterEh(Source).Color;
    if cvFooterFont in TColumnFooterEh(Source).FAssignedValues then
      Font := TColumnFooterEh(Source).Font;
    EndEllipsis := TColumnFooterEh(Source).EndEllipsis;
    ValueType := TColumnFooterEh(Source).ValueType;
    FieldName := TColumnFooterEh(Source).FieldName;
    Value := TColumnFooterEh(Source).Value;
    WordWrap := TColumnFooterEh(Source).WordWrap;
    DisplayFormat := TColumnFooterEh(Source).DisplayFormat;
    ToolTips := TColumnFooterEh(Source).ToolTips;
  end
  else
    inherited Assign(Source);
end;

function TColumnFooterEh.DefaultAlignment: TAlignment;
var
  Field: TField;
begin
  Field := FColumn.Field;
  if Assigned(Field)
    then Result := Field.Alignment
    else Result := taLeftJustify;
end;

function TColumnFooterEh.DefaultColor: TColor;
var
  Grid: TCustomDBGridEh;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid)
    then Result := Grid.FooterColor
    else Result := clWindow;
end;

function TColumnFooterEh.DefaultFont: TFont;
var
  Grid: TCustomDBGridEh;
begin
  Result := nil;
  if Assigned(FColumn) then
  begin
    Grid := FColumn.GetGrid;
    if Assigned(Grid)
      then Result := Grid.FooterFont
      else Result := FColumn.Font;
  end;
end;

procedure TColumnFooterEh.FontChanged(Sender: TObject);
begin
  Include(FAssignedValues, cvFooterFont);
  FColumn.Changed(True);
end;

function TColumnFooterEh.GetAlignment: TAlignment;
begin
  if cvFooterAlignment in FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TColumnFooterEh.GetColor: TColor;
begin
  if cvFooterColor in FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TColumnFooterEh.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvFooterFont in FAssignedValues) then
  begin
    Def := DefaultFont;
    if Assigned(Def) and
      ((FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color)) then
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TColumnFooterEh.IsAlignmentStored: Boolean;
begin
  Result := (cvFooterAlignment in FAssignedValues) and
    (FAlignment <> DefaultAlignment);
end;

function TColumnFooterEh.IsColorStored: Boolean;
begin
  Result := (cvFooterColor in FAssignedValues) and
    (FColor <> DefaultColor);
end;

function TColumnFooterEh.IsToolTipsStored: Boolean;
begin
  Result := (cvFooterToolTips in FAssignedValues) and
    (FToolTips <> False);
end;

function TColumnFooterEh.IsFontStored: Boolean;
begin
  Result := (cvFooterFont in FAssignedValues);
end;

procedure TColumnFooterEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvFooterFont in FAssignedValues) then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnFooterEh.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFooterFont in FAssignedValues;
  FAssignedValues := [];
  RefreshDefaultFont;
  { If font was assigned, changing it back to default may affect grid title
    height, and title height changes require layout and redraw of the grid. }
  FColumn.Changed(FontAssigned);
end;

procedure TColumnFooterEh.SetAlignment(Value: TAlignment);
begin
  if (cvFooterAlignment in FAssignedValues) and (Value = FAlignment)
    then Exit;
  FAlignment := Value;
  Include(FAssignedValues, cvFooterAlignment);
  FColumn.Changed(False);
end;

procedure TColumnFooterEh.SetColor(Value: TColor);
begin
  if (cvFooterColor in FAssignedValues) and (Value = FColor)
    then Exit;
  FColor := Value;
  Include(FAssignedValues, cvFooterColor);
  FColumn.Changed(False);
end;

procedure TColumnFooterEh.SetToolTips(const Value: Boolean);
begin
  if (cvFooterToolTips in FAssignedValues) and (Value = FToolTips)
    then Exit;
  FToolTips := Value;
  Include(FAssignedValues, cvFooterToolTips);
end;

function TColumnFooterEh.GetToolTips: Boolean;
begin
  if cvFooterToolTips in FAssignedValues
    then Result := FToolTips
    else Result := DefaultToolTips;
end;

function TColumnFooterEh.DefaultToolTips: Boolean;
var
  Grid: TCustomDBGridEh;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid)
    then Result := Grid.ColumnDefValues.Footer.ToolTips
    else Result := False;
end;

procedure TColumnFooterEh.SetEndEllipsis(const Value: Boolean);
begin
  FEndEllipsis := Value;
  FColumn.Changed(False);
end;

procedure TColumnFooterEh.SetFieldName(const Value: String);
begin
  FFieldName := Value;
  FColumn.EnsureSumValue;
  FColumn.Changed(False);
end;

procedure TColumnFooterEh.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TColumnFooterEh.SetValueType(const Value: TFooterValueType);
//var
//  Grid: TCustomDBGridEh;
begin
  if (ValueType = Value) then Exit;
  FValueType := Value;
  FColumn.EnsureSumValue;
///  Grid := FColumn.GetGrid;
//ddd  if Assigned(Grid) then
//ddd    Grid.EnsureFooterValueType(ValueType,FColumn.FieldName);
  FColumn.Changed(False);
end;

procedure TColumnFooterEh.SetValue(const Value: String);
begin
  FValue := Value;
  FColumn.Changed(False);
end;

procedure TColumnFooterEh.SetWordWrap(const Value: Boolean);
begin
  FWordWrap := Value;
  FColumn.Changed(False);
end;


procedure TColumnFooterEh.EnsureSumValue;
begin
  if not Assigned(FColumn) or not Assigned(FColumn.Grid) then
    Exit;
  if FDBSum = nil then
  begin
    if ValueType in [fvtSum..fvtCount] then
    begin
      FColumn.Grid.FSumList.SumCollection.BeginUpdate;
      FDBSum := (FColumn.Grid.FSumList.SumCollection.Add as TDBSum);
      case ValueType of
        fvtSum, fvtAvg:
          begin
            if ValueType = fvtSum
              then FDBSum.GroupOperation := goSum
              else FDBSum.GroupOperation := goAvg;
            if FieldName <> ''
              then FDBSum.FieldName := FieldName
              else FDBSum.FieldName := FColumn.FieldName;
          end;
        fvtCount: FDBSum.GroupOperation := goCount;
      end;
      FColumn.Grid.FSumList.SumCollection.EndUpdate;
    end;
  end else
  begin
    case ValueType of
      fvtSum, fvtAvg:
        begin
          if ValueType = fvtSum
            then FDBSum.GroupOperation := goSum
            else FDBSum.GroupOperation := goAvg;
          if FieldName <> ''
            then FDBSum.FieldName := FieldName
            else FDBSum.FieldName := FColumn.FieldName;
        end;
      fvtCount:
        begin
          FDBSum.GroupOperation := goCount;
          FDBSum.FieldName := '';
        end;
    else
      FreeAndNil(FDBSum);
//      FDBSum := nil;
    end;
  end;
end;

procedure TColumnFooterEh.SetDisplayFormat(const Value: String);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    FColumn.Changed(False);
  end;
end;

function TColumnFooterEh.GetSumValue: Variant;
begin
  Result := Null;
  if FDBSum <> nil then
    Result := FDBSum.SumValue;
end;

{ TColumnFootersEh }

constructor TColumnFootersEh.Create(Column: TColumnEh; FooterClass: TColumnFooterEhClass);
begin
  inherited Create(FooterClass);
  FColumn := Column;
end;

function TColumnFootersEh.Add: TColumnFooterEh;
begin
  Result := TColumnFooterEh(inherited Add);
end;

function TColumnFootersEh.GetFooter(Index: Integer): TColumnFooterEh;
begin
  Result := TColumnFooterEh(inherited Items[Index]);
end;

function TColumnFootersEh.GetOwner: TPersistent;
begin
  Result := FColumn;
end;

procedure TColumnFootersEh.SetFooter(Index: Integer; Value: TColumnFooterEh);
begin
  Items[Index].Assign(Value);
end;

procedure TColumnFootersEh.Update(Item: TCollectionItem);
begin
  inherited;
end;

{ TColumnTitleDefValuesEh }

procedure TColumnTitleDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TColumnTitleDefValuesEh then
  begin
    if cvdpTitleAlignmentEh in FAssignedValues then
      Alignment := TColumnTitleDefValuesEh(Source).Alignment;
    if cvdpTitleColorEh in FAssignedValues then
      Color := TColumnTitleDefValuesEh(Source).Color;
    EndEllipsis := TColumnTitleDefValuesEh(Source).EndEllipsis;
    TitleButton := TColumnTitleDefValuesEh(Source).TitleButton;
    ToolTips := TColumnTitleDefValuesEh(Source).ToolTips;
    Orientation := TColumnTitleDefValuesEh(Source).Orientation;
  end else
    inherited Assign(Source);
end;

constructor TColumnTitleDefValuesEh.Create(ColumnDefValues: TColumnDefValuesEh);
begin
  inherited Create;
  FColumnDefValues := ColumnDefValues;
end;

function TColumnTitleDefValuesEh.DefaultAlignment: TAlignment;
begin
  if FColumnDefValues.FGrid.UseMultiTitle
    then Result := taCenter
    else Result := taLeftJustify;
end;

function TColumnTitleDefValuesEh.DefaultColor: TColor;
begin
  Result := FColumnDefValues.FGrid.FixedColor;
end;

function TColumnTitleDefValuesEh.GetAlignment: TAlignment;
begin
  if cvdpTitleAlignmentEh in FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TColumnTitleDefValuesEh.GetColor: TColor;
begin
  if cvdpTitleColorEh in FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TColumnTitleDefValuesEh.IsAlignmentStored: Boolean;
begin
  Result := (cvdpTitleAlignmentEh in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TColumnTitleDefValuesEh.IsColorStored: Boolean;
begin
  Result := (cvdpTitleColorEh in FAssignedValues) and (FColor <> DefaultColor);
end;

procedure TColumnTitleDefValuesEh.SetAlignment(const Value: TAlignment);
begin
  if (cvdpTitleAlignmentEh in FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FAssignedValues, cvdpTitleAlignmentEh);
  FColumnDefValues.FGrid.LayoutChanged;
end;

procedure TColumnTitleDefValuesEh.SetColor(const Value: TColor);
begin
  if (cvdpTitleColorEh in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvdpTitleColorEh);
  FColumnDefValues.FGrid.Invalidate;
end;

procedure TColumnTitleDefValuesEh.SetEndEllipsis(const Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    FColumnDefValues.FGrid.Invalidate;
  end;
end;

procedure TColumnTitleDefValuesEh.SetOrientation(const Value: TTextOrientationEh);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    FColumnDefValues.FGrid.LayoutChanged;
  end;
end;

{ TColumnFooterDefValuesEh }

procedure TColumnFooterDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TColumnFooterDefValuesEh then
  begin
    ToolTips := TColumnFooterDefValuesEh(Source).ToolTips;
  end else
    inherited Assign(Source);
end;

{ TColumnDefValuesEh }

constructor TColumnDefValuesEh.Create(Grid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := Grid;
  FTitle := TColumnTitleDefValuesEh.Create(Self);
  FFooter := TColumnFooterDefValuesEh.Create;
  FLayout := tlTop;
end;

destructor TColumnDefValuesEh.Destroy;
begin
  FreeAndNil(FTitle);
  FreeAndNil(FFooter);
  inherited;
end;

procedure TColumnDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TColumnDefValuesEh then
  begin
    Title := TColumnDefValuesEh(Source).Title;
    AlwaysShowEditButton := TColumnDefValuesEh(Source).AlwaysShowEditButton;
    EndEllipsis := TColumnDefValuesEh(Source).EndEllipsis;
    AutoDropDown := TColumnDefValuesEh(Source).AutoDropDown;
    DblClickNextVal := TColumnDefValuesEh(Source).DblClickNextVal;
    ToolTips := TColumnDefValuesEh(Source).ToolTips;
    DropDownSizing := TColumnDefValuesEh(Source).DropDownSizing;
    DropDownShowTitles := TColumnDefValuesEh(Source).DropDownShowTitles;
  end else
    inherited Assign(Source);
end;

procedure TColumnDefValuesEh.SetAlwaysShowEditButton(const Value: Boolean);
begin
  if FAlwaysShowEditButton <> Value then
  begin
    FAlwaysShowEditButton := Value;
    FGrid.Invalidate;
  end;
end;

procedure TColumnDefValuesEh.SetEndEllipsis(const Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    FGrid.Invalidate;
  end;
end;

procedure TColumnDefValuesEh.SetTitle(const Value: TColumnTitleDefValuesEh);
begin
  FTitle.Assign(Value);
end;

procedure TColumnDefValuesEh.SetFooter(const Value: TColumnFooterDefValuesEh);
begin
  FFooter.Assign(Value);
end;

procedure TColumnDefValuesEh.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    FGrid.Invalidate;
  end;
end;

procedure TColumnDefValuesEh.SetHighlightRequired(Value: Boolean);
begin
  if FHighlightRequired <> Value then
  begin
    FHighlightRequired := Value;
    FGrid.Invalidate;
  end;
end;

{ TDBGridEhSumList }

constructor TDBGridEhSumList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesignTimeWork := True;
  Active := False;
end;

function TDBGridEhSumList.GetActive: Boolean;
begin
  Result := inherited Active;
end;

procedure TDBGridEhSumList.SetActive(const Value: Boolean);
begin
  inherited Active := Value;
end;

procedure TDBGridEhSumList.SetDataSetEvents;
begin
  if not (csDesigning in (FOwner as TCustomDBGridEh).ComponentState)
    then inherited SetDataSetEvents
    else FEventsOverloaded := True;
end;

procedure TDBGridEhSumList.ReturnEvents;
begin
  if not (csDesigning in (FOwner as TCustomDBGridEh).ComponentState)
    then inherited ReturnEvents
    else FEventsOverloaded := False;
end;

{ TColumnsEhList }

constructor TColumnsEhList.Create;
begin
  inherited Create;
  OwnsObjects := False;
end;

function TColumnsEhList.GetColumn(Index: Integer): TColumnEh;
begin
  Result := TColumnEh(Get(Index));
end;

procedure TColumnsEhList.SetColumn(Index: Integer; const Value: TColumnEh);
begin
  Put(Index, Value);
end;

{ TControlScrollBarEh }

constructor TDBGridEhScrollBar.Create(AGrid: TCustomDBGridEh;
  AKind: TScrollBarKind);
begin
  inherited Create;
  FDBGridEh := AGrid;
  FKind := AKind;
//  FVisible := True;
  FVisibleMode := sbAutoShowEh;
  FTracking := True;
end;

destructor TDBGridEhScrollBar.Destroy;
begin
  ExtScrollBar := nil;
  inherited Destroy;
end;

procedure TDBGridEhScrollBar.Assign(Source: TPersistent);
begin
  if Source is TDBGridEhScrollBar then
  begin
    Visible := TDBGridEhScrollBar(Source).Visible;
    Tracking := TDBGridEhScrollBar(Source).Tracking;
    ExtScrollBar := TDBGridEhScrollBar(Source).ExtScrollBar;
  end
  else inherited Assign(Source);
end;

procedure TDBGridEhScrollBar.SetVisible(Value: Boolean);
begin
  if Value
    then SetVisibleMode(sbAutoShowEh)
    else SetVisibleMode(sbNeverShowEh);
  UpdateExtScrollBar;
{  if (FVisible = Value) or FAlwaysShow then Exit;
  FVisible := Value;
  if Assigned(FDBGridEh) and (Kind = sbVertical) then FDBGridEh.UpdateScrollBar;
  if Assigned(FDBGridEh) then FDBGridEh.LayoutChanged;}
end;

function TDBGridEhScrollBar.GetVisible: Boolean;
begin
  if FVisibleMode = sbNeverShowEh
    then Result := False
    else Result := True;
end;

function TDBGridEhScrollBar.IsScrollBarVisible: Boolean;
var
  Style: Longint;
begin
  if Assigned(FExtScrollBar) then
    Result := FExtScrollBar.Visible
  else
  begin
    Style := WS_HSCROLL;
    if Kind = sbVertical then Style := WS_VSCROLL;
    Result := (Visible) and
      ((GetWindowLong(FDBGridEh.Handle, GWL_STYLE) and Style) <> 0);
  end;
end;

function TDBGridEhScrollBar.IsScrollBarShowing: Boolean;
var
  ScrollInfo: TScrollInfo;
begin
  if VisibleMode = sbAlwaysShowEh then
    Result := True
  else if VisibleMode = sbNeverShowEh then
    Result := False
  else //sbAutoShowEh
  begin
    ScrollInfo.cbSize := sizeof(ScrollInfo);
    ScrollInfo.fMask := SIF_ALL;
    GetScrollInfo(ScrollInfo);
    if (ScrollInfo.nMax <= ScrollInfo.nMin) or
       (UINT(ScrollInfo.nMax - ScrollInfo.nMin) <= ScrollInfo.nPage)
    then
      Result := False
    else
      Result := True;
  end;
end;

procedure TDBGridEhScrollBar.SetVisibleMode(const Value: TScrollBarVisibleModeEh);
begin
  if (FVisibleMode = Value) then Exit;
  FVisibleMode := Value;
  if Assigned(FDBGridEh) and (Kind = sbVertical) then FDBGridEh.UpdateScrollBar;
  if Assigned(FDBGridEh) then FDBGridEh.LayoutChanged;
end;

procedure TDBGridEhScrollBar.SetExtScrollBar(const Value: TScrollBar);
var
  WinControlWndProc: TWndMethod;
begin
  if FExtScrollBar <> Value then
  begin
    if (Value <> nil) and not (csDesigning in FDBGridEh.ComponentState) then
    begin
{ TODO : ExtScrollBar }
{$IFDEF CIL}
//      WinControlWndProc := IControl(Value).WndProc;
{$ELSE}
      WinControlWndProc := TWinControlCracker(Value).WndProc;
      if @Value.WindowProc <> @WinControlWndProc then
        raise Exception.Create('Possible ' + Value.Name + ' already attached to the other control.');
{$ENDIF}
    end;
    if (FExtScrollBar <> nil) and not (csDesigning in FDBGridEh.ComponentState) then
{$IFDEF CIL}
      IControl(FExtScrollBar).RestoreWndProc;
{$ELSE}
      FExtScrollBar.WindowProc := TWinControlCracker(FExtScrollBar).WndProc;
{$ENDIF}
    FExtScrollBar := Value;
    if (Value <> nil) then
    begin
      Value.FreeNotification(FDBGridEh);
      if not (csDesigning in FDBGridEh.ComponentState) then
        Value.WindowProc := ExtScrollWindowProc;
    end;
    UpdateExtScrollBar;
    if (csDestroying in FDBGridEh.ComponentState) then Exit;
    if FDBGridEh.HandleAllocated and (Kind = sbVertical) then
      FDBGridEh.UpdateScrollBar;
    if FDBGridEh.HandleAllocated then
      FDBGridEh.LayoutChanged;
  end;
end;

procedure TDBGridEhScrollBar.UpdateExtScrollBar;
begin
  if FExtScrollBar <> nil then
    FExtScrollBar.Visible := Visible;
end;

procedure TDBGridEhScrollBar.ExtScrollWindowProc(var Message: TMessage);
const ScrollKindMessages: array[TScrollBarKind] of Integer = (WM_HSCROLL, WM_VSCROLL);
begin
  if (Message.Msg = CN_HSCROLL) or (Message.Msg = CN_VSCROLL) then
    FDBGridEh.Perform(ScrollKindMessages[Kind], Message.WParam, Message.LParam);
{$IFDEF CIL}
  IControl(FExtScrollBar).WndProc(Message);
{$ELSE}
  TWinControlCracker(FExtScrollBar).WndProc(Message);
{$ENDIF}
end;

function TDBGridEhScrollBar.GetScrollInfo(var ScrollInfo: TScrollInfo): Boolean;
const ScrollKindWinConsts: array[TScrollBarKind] of Integer = (SB_HORZ, SB_VERT);
begin
  if ExtScrollBar <> nil then
    Result := Windows.GetScrollInfo(ExtScrollBar.Handle, SB_CTL, ScrollInfo)
  else
    Result := Windows.GetScrollInfo(FDBGridEh.Handle, ScrollKindWinConsts[Kind], ScrollInfo)
end;

function TDBGridEhScrollBar.GetSmoothStep: Boolean;
begin
  Result := FSmoothStep;
end;

procedure TDBGridEhScrollBar.SetSmoothStep(Value: Boolean);
begin
  if FSmoothStep <> Value then
  begin
    FSmoothStep := Value;
    SmoothStepChanged;
  end;
end;

procedure TDBGridEhScrollBar.SmoothStepChanged;
begin
end;

{ THorzDBGridEhScrollBar  }

constructor THorzDBGridEhScrollBar.Create(AGrid: TCustomDBGridEh; AKind: TScrollBarKind);
begin
  inherited Create(AGrid, AKind);
  SmoothStep := True;
end;

procedure THorzDBGridEhScrollBar.SmoothStepChanged;
begin
  FDBGridEh.UpdateGridDataWidth;
  FDBGridEh.UpdateScrollRange;
end;

{ TVertDBGridEhScrollBar  }

procedure TVertDBGridEhScrollBar.SmoothStepChanged;
begin
  FDBGridEh.UpdateGridDataHeight;
  FDBGridEh.UpdateScrollRange;
  if FDBGridEh.HandleAllocated then
    FDBGridEh.LayoutChanged;
end;

var Bmp: TBitmap;

{ TDBGridEhSelection }

function TDBGridEhSelection.DataCellSelected(DataCol: Longint; DataRow: TUniBookmarkEh): Boolean;
var
  Index: Integer;
begin
  Result := False;
  case SelectionType of
    gstAll:
      Result := True;
    gstRecordBookmarks:
      Result := Rows.Find(DataRow, Index);
    gstRectangle:
      if DataCol >= 0 then
        Result := Rect.DataCellSelected(DataCol, DataRow);
    gstColumns:
      if DataCol >= 0 then
        Result := (Columns.IndexOf(FGrid.Columns[DataCol]) <> -1);
  end;
end;

procedure TDBGridEhSelection.Clear;
begin
  try
    case SelectionType of
      gstRecordBookmarks:
        Rows.Clear;
      gstRectangle:
        FRect.Clear;
      gstColumns:
        Columns.Clear;
      gstAll:
        FGrid.Invalidate;
    end;
  finally
    FSelectionType := gstNon;
    if (dgAlwaysShowEditor in FGrid.Options) and FGrid.CanEditorMode then
      FGrid.ShowEditor;
  end;
end;

constructor TDBGridEhSelection.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FColumns := TDBGridEhSelectionCols.Create(AGrid);
  FRect := TDBGridEhSelectionRect.Create(AGrid);
end;

destructor TDBGridEhSelection.Destroy;
begin
  FreeAndNil(FColumns);
  FreeAndNil(FRect);
  inherited;
end;

function TDBGridEhSelection.GetRows: TBookmarkListEh;
begin
  Result := FGrid.SelectedRows;
end;

procedure TDBGridEhSelection.LinkActive(Value: Boolean);
begin
  FGrid.SelectedRows.LinkActive(Value);
  Clear;
end;

procedure TDBGridEhSelection.Refresh;
begin
  case SelectionType of
    gstRecordBookmarks:
      FGrid.SelectedRows.Refresh;
    gstRectangle:
      begin
//      FRect := BlankRect;
      end;
    gstColumns:
      if Columns.Count = 0 then begin
        FSelectionType := gstNon;
        FGrid.Invalidate;
      end;
  end;
end;

procedure TDBGridEhSelection.SelectAll;
begin
  if SelectionType = gstAll then Exit;
  if SelectionType <> gstNon then Clear;
  FSelectionType := gstAll;
  FGrid.Invalidate;
end;

procedure TDBGridEhSelection.SetSelectionType(ASelType: TDBGridEhSelectionType);
begin
  if FSelectionType = ASelType then Exit;
  FSelectionType := ASelType;
{  if (ASelType = gstNon) and (dgAlwaysShowEditor in FGrid.Options)
    then FGrid.ShowEditor
    else FGrid.HideEditor;}
  FGrid.InvalidateEditor;
end;

procedure TDBGridEhSelection.UpdateState;
begin
  case SelectionType of
    gstRecordBookmarks:
      if FGrid.SelectedRows.Count = 0 then
      begin
        FSelectionType := gstNon;
        FGrid.Invalidate;
      end;
    gstRectangle:
      begin
//      FRect := BlankRect;
      end;
    gstColumns:
      if Columns.Count = 0 then
      begin
        FSelectionType := gstNon;
        FGrid.Invalidate;
      end;
  end;
end;

function TDBGridEhSelection.SelectionToGridRect: TGridRect;


begin
  case SelectionType of
    gstRecordBookmarks:
      Result := Rows.SelectionToGridRect;
    gstRectangle:
      Result := Rect.SelectionToGridRect;
    gstColumns:
      Result := Columns.SelectionToGridRect;
    gstAll:
      Result := GridRect(0, 0, FGrid.RowCount, FGrid.ColCount);
    else
      Result := GridRect(-1, -1, -1, -1);
  end;
end;

procedure TDBGridEhSelection.SelectionChanged;
begin
  if not (csDestroying in FGrid.ComponentState) and
     Assigned(FGrid.OnSelectionChanged)
  then
    FGrid.OnSelectionChanged(FGrid);
end;

{ TDBGridEhSelectionCols }

procedure TDBGridEhSelectionCols.Add(ACol: TColumnEh);
var i: Integer;
begin
  for i := 0 to Count - 1 do
    if ACol.Index < Items[i].Index then
    begin
      Insert(i, ACol);
      Exit;
    end;
  inherited Add(ACol);
end;

procedure TDBGridEhSelectionCols.Clear;
var i: Integer;
begin
//  Refresh;
  for i := 0 to Count - 1 do
    FGrid.InvalidateCol(FGrid.DataToRawColumn(Items[i].Index));
  inherited Clear;
  FAnchor := nil;
  FGrid.Selection.SelectionChanged;
end;

constructor TDBGridEhSelectionCols.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FAnchor := nil;
  FGrid := AGrid;
  FShiftSelectedCols := TColumnsEhList.Create;
end;

destructor TDBGridEhSelectionCols.Destroy;
begin
  FreeAndNil(FShiftSelectedCols);
end;

{function TDBGridEhSelectionCols.Get(Index: Integer): TColumnEh;
begin
  Result := inherited Items[Index];
end;}

procedure TDBGridEhSelectionCols.InvertSelect(ACol: TColumnEh);
begin
  if FGrid.Selection.SelectionType <> gstColumns
    then FGrid.Selection.Clear;
  if IndexOf(ACol) = -1 then
  begin
    Add(ACol);
    FAnchor := ACol;
    FShiftCol := ACol;
  end
  else
  begin
    Remove(ACol);
    FAnchor := ACol;
    FShiftCol := ACol;
  end;
  if Count = 0
    then FGrid.Selection.SetSelectionType(gstNon)
    else FGrid.Selection.SetSelectionType(gstColumns);
  FShiftSelectedCols.Clear;
end;

{procedure TDBGridEhSelectionCols.Put(Index: Integer; const Value: TColumnEh);
begin
  inherited Items[Index] := Value;
end;}

function CompareColums(Item1, Item2: TObject): Integer;
begin
  if TColumnEh(Item1).Index > TColumnEh(Item2).Index then
    Result := 1
  else if TColumnEh(Item1).Index < TColumnEh(Item2).Index then
    Result := -1
  else
    Result := 0;
end;

procedure TDBGridEhSelectionCols.Refresh;
var i, j: Integer;
  Found: Boolean;
begin
  for i := Count - 1 downto 0 do
  begin
    Found := False;
    for j := 0 to FGrid.Columns.Count - 1 do
      if FGrid.Columns[j] = Items[i] then
      begin
        Found := True;
        Break;
      end;
    if not Found then Delete(i);
  end;

{$IFDEF CIL}
  Sort(CompareColums);
{$ELSE}
  Sort(@CompareColums);
{$ENDIF}
end;

procedure TDBGridEhSelectionCols.Select(ACol: TColumnEh; AddSel: Boolean);
begin
  if FGrid.Selection.SelectionType <> gstColumns then FGrid.Selection.Clear;
  if not AddSel then Clear;
  if IndexOf(ACol) = -1 then Add(ACol);
  FAnchor := ACol;
  FShiftCol := ACol;
  FGrid.Selection.SetSelectionType(gstColumns);
  FShiftSelectedCols.Clear;
end;

function TDBGridEhSelectionCols.SelectionToGridRect: TGridRect;
var
  LeftCol, RightCol: Integer;
  i: Integer;
begin
  LeftCol := -1;
  RightCol := -1;
  if Count > 0 then
  begin
    LeftCol := Items[0].Index;
    RightCol := Items[0].Index;
    for i := 1 to Count-1 do
    begin
      if Items[i].Index < LeftCol then
        LeftCol := Items[i].Index;
      if Items[i].Index > RightCol then
        RightCol := Items[i].Index;
    end;
  end;
  Result := GridRect(FGrid.DataToRawColumn(LeftCol), 0, FGrid.DataToRawColumn(RightCol), FGrid.RowCount);
end;

procedure TDBGridEhSelectionCols.SelectShift(ACol: TColumnEh {; Clear:Boolean});
var i: Integer;
  Step: Integer;
  FromIndex, ToIndex, RemoveIndex: Integer;
  NeedAdd: Boolean;
begin
//  FGrid.Invalidate; //
  if FGrid.Selection.SelectionType <> gstColumns then FGrid.Selection.Clear;
  RemoveIndex := -1;
  Step := 1;
  NeedAdd := True;
  FromIndex := ACol.Index; ToIndex := ACol.Index;
  if FAnchor = nil then
  begin
    Select(ACol, True);
    FAnchor := ACol;
  end else
  begin
    if (FAnchor.Index < FShiftCol.Index) then
    begin
      if (FShiftCol.Index < ACol.Index) then
      begin
        FromIndex := FShiftCol.Index;
        ToIndex := ACol.Index;
        NeedAdd := True;
      end else if (FShiftCol.Index > ACol.Index) then
      begin
        FromIndex := FShiftCol.Index;
        if FAnchor.Index > ACol.Index then
          RemoveIndex := FAnchor.Index;
        ToIndex := ACol.Index + iif(RemoveIndex <> -1, 0, 1);
        Step := -1;
        NeedAdd := False;
      end
    end
    else if (FAnchor.Index > FShiftCol.Index) then
    begin
      if (FShiftCol.Index > ACol.Index) then
      begin
        FromIndex := FShiftCol.Index;
        ToIndex := ACol.Index;
        Step := -1;
        NeedAdd := True;
      end else if (FShiftCol.Index < ACol.Index) then
      begin
        FromIndex := FShiftCol.Index;
        if FAnchor.Index < ACol.Index then
          RemoveIndex := FAnchor.Index;
        ToIndex := ACol.Index - iif(RemoveIndex <> -1, 0, 1);
        NeedAdd := False;
      end;
    end else
    begin
      FromIndex := FAnchor.Index;
      if FAnchor.Index > ACol.Index then
        Step := -1;
    end;
    i := FromIndex;
//    if Clear then Clear := IndexOf(FGrid.Columns[FAnchor.Index]) = -1;
    while True do
    begin
      if i = RemoveIndex then NeedAdd := not NeedAdd;
      {if NeedAdd and not Clear then begin
        if (IndexOf(FGrid.Columns[i]) = -1) and FGrid.Columns[i].Visible then begin
          Add(FGrid.Columns[i]);
          FGrid.InvalidateCol(FGrid.DataToRawColumn(FGrid.Columns[i].Index));
        end
      end else begin
        if (IndexOf(FGrid.Columns[i]) <> -1) and (i <> FAnchor.Index) then begin
          Remove(FGrid.Columns[i]);
          FGrid.InvalidateCol(FGrid.DataToRawColumn(FGrid.Columns[i].Index));
        end;
      end;}
      if NeedAdd then
      begin
        if IndexOf(FGrid.Columns[FAnchor.Index]) <> -1 then
        begin
          if (IndexOf(FGrid.Columns[i]) = -1) and FGrid.Columns[i].Visible then
          begin
            Add(FGrid.Columns[i]);
            FGrid.InvalidateCol(FGrid.DataToRawColumn(FGrid.Columns[i].Index));
            FShiftSelectedCols.Add(FGrid.Columns[i]);
            FGrid.Selection.SelectionChanged;
          end;
        end else
        begin
          if (IndexOf(FGrid.Columns[i]) <> -1) and (i <> FAnchor.Index) then
          begin
            Remove(FGrid.Columns[i]);
            FGrid.InvalidateCol(FGrid.DataToRawColumn(FGrid.Columns[i].Index));
            FShiftSelectedCols.Add(FGrid.Columns[i]);
            FGrid.Selection.SelectionChanged;
          end;
        end
      end else
      begin
        if IndexOf(FGrid.Columns[FAnchor.Index]) <> -1 then
        begin
          if (IndexOf(FGrid.Columns[i]) <> -1) and (i <> FAnchor.Index) then
          begin
            if FShiftSelectedCols.IndexOf(FGrid.Columns[i]) <> -1 then
            begin
              Remove(FGrid.Columns[i]);
              FShiftSelectedCols.Remove(FGrid.Columns[i]);
            end;
            FGrid.InvalidateCol(FGrid.DataToRawColumn(FGrid.Columns[i].Index));
            FGrid.Selection.SelectionChanged;
          end;
        end else
        begin
          if (IndexOf(FGrid.Columns[i]) = -1) and FGrid.Columns[i].Visible then
          begin
            if FShiftSelectedCols.IndexOf(FGrid.Columns[i]) <> -1 then
            begin
              Add(FGrid.Columns[i]);
              FShiftSelectedCols.Remove(FGrid.Columns[i]);
            end;
            FGrid.InvalidateCol(FGrid.DataToRawColumn(FGrid.Columns[i].Index));
            FGrid.Selection.SelectionChanged;
          end;
        end
      end;
      if i = ToIndex then Break;
      Inc(i, Step);
    end;
  end;
  FShiftCol := ACol;
  if Count = 0
    then FGrid.Selection.SetSelectionType(gstNon)
    else FGrid.Selection.SetSelectionType(gstColumns);
end;

{ TDBGridEhSelectionRect }

function TDBGridEhSelectionRect.BoxRect(ALeft: Integer; ATop: TUniBookmarkEh;
  ARight: Integer; ABottom: TUniBookmarkEh): TRect;
var
  OldRec: Integer;
  TopGridBM, BottomGridBM: TUniBookmarkEh;
  TopRow, BottomRow: Integer;
  SwapCol: Integer;
  SwapBM: TUniBookmarkEh;

  function FindRecNumByBookmark(BM: TUniBookmarkEh): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to FGrid.FDataLink.RecordCount - 1 do
    begin
      FGrid.FDataLink.ActiveRecord := i;
      with FGrid.DataSource.DataSet do
        if DataSetCompareBookmarks(FGrid.DataSource.DataSet, BM, Bookmark) = 0 then
        begin
          Result := i;
          Break;
        end;
    end;
  end;

begin
  if ALeft > ARight then
  begin
    SwapCol := ALeft;
    ALeft := ARight;
    ARight := SwapCol;
  end;
  if DataSetCompareBookmarks(FGrid.DataSource.DataSet, ATop, ABottom) > 0 then
  begin
    SwapBM := ATop;
    ATop := ABottom;
    ABottom := SwapBM;
  end;

  if FGrid.ViewScroll then
  begin
    TopRow := FGrid.FIntMemTable.InstantReadIndexOfBookmark(ATop) + FGrid.TopDataOffset;
    BottomRow := FGrid.FIntMemTable.InstantReadIndexOfBookmark(ABottom) + FGrid.TopDataOffset;
  end else
  begin
    OldRec := FGrid.FDataLink.ActiveRecord;
    try
      FGrid.FDataLink.ActiveRecord := 0;

      TopGridBM := FGrid.DataSource.DataSet.Bookmark;
      if DataSetCompareBookmarks(FGrid.DataSource.DataSet, ATop, TopGridBM) < 0 then
        TopRow := 0
      else begin
        TopRow := FindRecNumByBookmark(ATop);
      end;
      if TopRow = -1 then TopRow := FGrid.FDataLink.RecordCount;
      TopRow := TopRow + FGrid.TopDataOffset;

      if FGrid.FDataLink.RecordCount > 0 then 
        FGrid.FDataLink.ActiveRecord := FGrid.FDataLink.RecordCount - 1;
      BottomGridBM := FGrid.DataSource.DataSet.Bookmark;

      if DataSetCompareBookmarks(FGrid.DataSource.DataSet, ABottom, BottomGridBM) > 0 then
        BottomRow := FGrid.VisibleDataRowCount
      else begin
        BottomRow := FindRecNumByBookmark(ABottom);
      end;
      BottomRow := BottomRow + FGrid.TopDataOffset; // - 1;

    finally
      FGrid.FDataLink.ActiveRecord := OldRec;
    end;

  end;

  Result := FGrid.BoxRect(FGrid.DataToRawColumn(ALeft), TopRow,
    FGrid.DataToRawColumn(ARight), BottomRow);
//
end;

function TDBGridEhSelectionRect.DataCellSelected(DataCol: Integer; DataRow: TUniBookmarkEh): Boolean;
begin
  Result := False;
  if CheckState then
    Result := (DataSetCompareBookmarks(FGrid.DataSource.DataSet, TopRow,
        DataRow) <= 0) and
      (DataSetCompareBookmarks(FGrid.DataSource.DataSet, BottomRow,
        DataRow) >= 0) and
      (RightCol >= DataCol) and (LeftCol <= DataCol)
  else
    RaiseGridError('Error in function TDBGridEhSelectionRect.CellSelected');
end;

function TDBGridEhSelectionRect.CheckState: Boolean;
begin
  Result :=
    Assigned(FGrid.DataSource) and
    Assigned(FGrid.DataSource.DataSet) and
    FGrid.DataLink.Active {and
     {(FAnchor.Row <> '') and (FShiftCell.Row <> '') and
     (FShiftCell.Row <> '') and (FShiftCell.Row <> '') ???};
end;

procedure TDBGridEhSelectionRect.Clear;
begin
  FAnchor.Col := -1;
  FAnchor.Row := NilBookmarkEh;
  FShiftCell.Col := -1;
  FShiftCell.Row := NilBookmarkEh;
  FGrid.Invalidate;
  FGrid.Selection.SelectionChanged;
end;

constructor TDBGridEhSelectionRect.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FAnchor.Col := -1;
  FAnchor.Row := NilBookmarkEh;
  FShiftCell.Col := -1;
  FShiftCell.Row := NilBookmarkEh;
  FGrid := AGrid;
end;

function TDBGridEhSelectionRect.GetBottomRow: TUniBookmarkEh;
begin
  if CheckState then
    if DataSetCompareBookmarks(FGrid.DataSource.DataSet, FAnchor.Row,
      FShiftCell.Row) < 0
      then Result := FShiftCell.Row
      else Result := FAnchor.Row
  else
    RaiseGridError('Error in TDBGridEhSelectionRect.GetBottomRow');
end;

function TDBGridEhSelectionRect.GetLeftCol: Longint;
begin
  Result := -1;
  if CheckState then
    if FShiftCell.Col < FAnchor.Col
      then Result := FShiftCell.Col
      else Result := FAnchor.Col
  else
    RaiseGridError('Error in TDBGridEhSelectionRect.GetBottomRow');
end;

function TDBGridEhSelectionRect.GetRightCol: Longint;
begin
  Result := -1;
  if CheckState then
    if FShiftCell.Col > FAnchor.Col
      then Result := FShiftCell.Col
      else Result := FAnchor.Col
  else
    RaiseGridError('Error in TDBGridEhSelectionRect.GetBottomRow');
end;

function TDBGridEhSelectionRect.GetTopRow: TUniBookmarkEh;
begin
  if CheckState then
    if DataSetCompareBookmarks(FGrid.DataSource.DataSet, FAnchor.Row,
      FShiftCell.Row) > 0
      then Result := FShiftCell.Row
      else Result := FAnchor.Row
  else
    RaiseGridError('Error in TDBGridEhSelectionRect.GetBottomRow');
end;

// XorRects from Grids.pas
type
  TXorRects = array[0..3] of TRect;

procedure XorRects(const R1, R2: TRect; var XorRects: TXorRects);
var
  Intersect, Union: TRect;

  function PtInRect(X, Y: Integer; const Rect: TRect): Boolean;
  begin
    with Rect do Result := (X >= Left) and (X <= Right) and (Y >= Top) and
      (Y <= Bottom);
  end;

  function Includes(const P1: TPoint; P2: TPoint): Boolean;
  begin
    with P1 do
      Result := PtInRect(X, Y, R1) or PtInRect(X, Y, R2);
  end;

  function Build(var R: TRect; const P1, P2, P3: TPoint): Boolean;
  begin
    Build := True;
    with R do
      if Includes(P1, R.TopLeft) then
      begin
        Left := P1.X;
        Top := P1.Y;
        if Includes(P3, R.BottomRight) then
        begin
          Right := P3.X;
          Bottom := P3.Y;
        end else
        begin
          Right := P2.X;
          Bottom := P2.Y;
        end
      end
      else if Includes(P2, R.TopLeft) then
      begin
        Left := P2.X;
        Top := P2.Y;
        Bottom := P3.Y;
        Right := P3.X;
      end
      else
        Build := False;
  end;

begin
  XorRects[0] := EmptyRect;
  XorRects[1] := EmptyRect;
  XorRects[2] := EmptyRect;
  XorRects[3] := EmptyRect;
//  FillChar(XorRects, SizeOf(XorRects), 0);
  if not Bool(IntersectRect(Intersect, R1, R2)) then
  begin
    { Don't intersect so its simple }
    XorRects[0] := R1;
    XorRects[1] := R2;
  end
  else
  begin
    UnionRect(Union, R1, R2);
    if Build(XorRects[0],
      Point(Union.Left, Union.Top),
      Point(Union.Left, Intersect.Top),
      Point(Union.Left, Intersect.Bottom)) then
      XorRects[0].Right := Intersect.Left;
    if Build(XorRects[1],
      Point(Intersect.Left, Union.Top),
      Point(Intersect.Right, Union.Top),
      Point(Union.Right, Union.Top)) then
      XorRects[1].Bottom := Intersect.Top;
    if Build(XorRects[2],
      Point(Union.Right, Intersect.Top),
      Point(Union.Right, Intersect.Bottom),
      Point(Union.Right, Union.Bottom)) then
      XorRects[2].Left := Intersect.Right;
    if Build(XorRects[3],
      Point(Union.Left, Union.Bottom),
      Point(Intersect.Left, Union.Bottom),
      Point(Intersect.Right, Union.Bottom)) then
      XorRects[3].Top := Intersect.Bottom;
  end;
end;

procedure TDBGridEhSelectionRect.Select(ACol: Longint; ARow: TUniBookmarkEh; AddSel: Boolean);
var
  OldAnchor, OldShiftCell: TDBCell;
  OldRect, NewRect: TRect;
  AXorRects: TXorRects;
  I: Integer;
begin
  if FGrid.Selection.SelectionType <> gstRectangle then
    FGrid.Selection.Clear;
  OldAnchor := FAnchor;
  OldShiftCell := FShiftCell;
  if (FAnchor.Col = -1) or not AddSel then
  begin
    FAnchor.Col := ACol;
    FAnchor.Row := ARow;
    FShiftCell.Col := ACol;
    FShiftCell.Row := ARow;
  end else
  begin
    FShiftCell.Col := ACol;
    FShiftCell.Row := ARow;
  end;
  if (FAnchor.Col <> FShiftCell.Col) or
    (DataSetCompareBookmarks(FGrid.DataSource.DataSet, FAnchor.Row,
      FShiftCell.Row) <> 0)
  then
    FGrid.Selection.SetSelectionType(gstRectangle)
  else if FGrid.Selection.SelectionType = gstRectangle then
  begin
    FGrid.Selection.SetSelectionType(gstNon);
//    FAnchor.Col := -1;
  end;

  if (OldAnchor.Col = OldShiftCell.Col) and (OldAnchor.Row = OldShiftCell.Row)
    and (FAnchor.Row = FShiftCell.Row) and (FAnchor.Col <> FShiftCell.Col) then
  begin
    OldAnchor.Col := 0;
    OldShiftCell.Col := FGrid.ColCount;
  end else if (OldAnchor.Col <> OldShiftCell.Col) and (OldAnchor.Row = OldShiftCell.Row)
    and (FAnchor.Row = FShiftCell.Row) and (FAnchor.Col = FShiftCell.Col) then
  begin
    OldAnchor.Col := 0;
    OldShiftCell.Col := FGrid.ColCount;
  end;

  if not FGrid.HandleAllocated then Exit;
  OldRect := BoxRect(OldAnchor.Col, OldAnchor.Row, OldShiftCell.Col, OldShiftCell.Row);
  NewRect := BoxRect(FAnchor.Col, FAnchor.Row, FShiftCell.Col, FShiftCell.Row);
  XorRects(OldRect, NewRect, AXorRects);
  for I := Low(AXorRects) to High(AXorRects) do
    WindowsInvalidateRect(FGrid.Handle, AXorRects[I], False);
  FGrid.Selection.SelectionChanged;
//  FGrid.Invalidate;
end;

function TDBGridEhSelectionRect.SelectionToGridRect: TGridRect;
var
  TopRow, BottomRow: Integer;
  LeftCol, RightCol: Integer;
  i, OldActive: Integer;
begin
  Result := GridRect(-1,-1,-1,-1);
  LeftCol := FGrid.DataToRawColumn(Self.LeftCol);
  RightCol := FGrid.DataToRawColumn(Self.RightCol);
  if not FGrid.DataLink.Active then Exit;

  TopRow := -1;
  BottomRow := -1;

  if FGrid.ViewScroll then
  begin
{    OldActive := FGrid.TopRow - FGrid.TopDataOffset;
    for i := OldActive to Min(FGrid.RowCount-FGrid.TopDataOffset-1,OldActive + FGrid.VisibleDataRowCount) do
    begin
      FGrid.InstantReadRecordEnter(i);

      if TopRow = -1 then
        if FGrid.DataLink.DataSet.CompareBookmarks(Pointer(FGrid.DataLink.DataSet.Bookmark),
                                                   Pointer(Self.TopRow)) >= 0 then
          TopRow := i;
      if FGrid.DataLink.DataSet.CompareBookmarks(Pointer(FGrid.DataLink.DataSet.Bookmark),
                                                   Pointer(Self.BottomRow)) <= 0 then
        BottomRow := i;

      FGrid.InstantReadRecordLeave;
    end;}
    TopRow := FGrid.FIntMemTable.InstantReadIndexOfBookmark(Self.TopRow);
    BottomRow := FGrid.FIntMemTable.InstantReadIndexOfBookmark(Self.BottomRow);
  end else
  begin
    OldActive := FGrid.DataLink.ActiveRecord;
    for i := 0 to FGrid.DataLink.RecordCount-1 do
    begin
      FGrid.DataLink.ActiveRecord := i;
      if TopRow = -1 then
        if DataSetCompareBookmarks(FGrid.DataLink.DataSet,
          FGrid.DataLink.DataSet.Bookmark, Self.TopRow) >= 0
        then
          TopRow := i;
      if DataSetCompareBookmarks(FGrid.DataLink.DataSet,
        FGrid.DataLink.DataSet.Bookmark, Self.BottomRow) <= 0
      then
        BottomRow := i
    end;
    FGrid.DataLink.ActiveRecord := OldActive;
  end;

  if (TopRow >= 0) and (BottomRow >= 0) then
    Result := GridRect(LeftCol, TopRow + FGrid.TopDataOffset, RightCol, BottomRow + FGrid.TopDataOffset);
end;

{ TColumnDropDownBoxEh }

constructor TColumnDropDownBoxEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FSpecRow := TSpecRowEh.Create(Self);
  FAutoFitColWidths := True;
end;

destructor TColumnDropDownBoxEh.Destroy;
begin
  FreeAndNil(FSpecRow);
  inherited;
end;

procedure TColumnDropDownBoxEh.Assign(Source: TPersistent);
begin
  if Source is TColumnDropDownBoxEh then
  begin
    Align := TColumnDropDownBoxEh(Source).Align;
    AutoDrop := TColumnDropDownBoxEh(Source).AutoDrop;
    AutoFitColWidths := TColumnDropDownBoxEh(Source).AutoFitColWidths;
    ColumnDefValues := TColumnDropDownBoxEh(Source).ColumnDefValues;
    if TColumnDropDownBoxEh(Source).Columns.State = csCustomized // To avoid round asign
      then Columns := TColumnDropDownBoxEh(Source).Columns
    else Columns.Clear;
    Options := TColumnDropDownBoxEh(Source).Options;
    Rows := TColumnDropDownBoxEh(Source).Rows;
    Width := TColumnDropDownBoxEh(Source).Width;
    Sizable := TColumnDropDownBoxEh(Source).Sizable;
    ShowTitles := TColumnDropDownBoxEh(Source).ShowTitles;
    UseMultiTitle := TColumnDropDownBoxEh(Source).UseMultiTitle;
    ListSource := TColumnDropDownBoxEh(Source).ListSource;
  end else
    inherited Assign(Source);
end;

procedure TColumnDropDownBoxEh.SetSpecRow(const Value: TSpecRowEh);
begin
  FSpecRow.Assign(Value);
end;

function TColumnDropDownBoxEh.GetColumns: TDBGridColumnsEh;
var LookupGridOwner: ILookupGridOwner;
begin
  Result := nil;
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := LookupGridOwner.GetLookupGrid.Columns;
end;

procedure TColumnDropDownBoxEh.SetColumns(const Value: TDBGridColumnsEh);
var LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.GetLookupGrid.Columns.Assign(Value);
end;

function TColumnDropDownBoxEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TColumnDropDownBoxEh.StoreColumns: Boolean;
begin
  Result := Columns.State = csCustomized;
end;

function TColumnDropDownBoxEh.GetAutoFitColWidths: Boolean;
begin
  Result := FAutoFitColWidths;
end;

procedure TColumnDropDownBoxEh.SetAutoFitColWidths(const Value: Boolean);
begin
  FAutoFitColWidths := Value;
end;

function TColumnDropDownBoxEh.GetColumnDefValues: TColumnDefValuesEh;
var LookupGridOwner: ILookupGridOwner;
begin
  Result := nil;
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := LookupGridOwner.GetLookupGrid.ColumnDefValues;
end;

procedure TColumnDropDownBoxEh.SetColumnDefValues(const Value: TColumnDefValuesEh);
var LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.GetLookupGrid.ColumnDefValues.Assign(Value);
end;

function TColumnDropDownBoxEh.GetOptions: TDBLookupGridEhOptions;
var
  LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := LookupGridOwner.Options;
end;

procedure TColumnDropDownBoxEh.SetOptions(const Value: TDBLookupGridEhOptions);
var LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.Options := Value;
end;

function TColumnDropDownBoxEh.GetListSource: TDataSource;
begin
  Result := FListSource;
end;

procedure TColumnDropDownBoxEh.SetListSource(const Value: TDataSource);
var
  LookupGridOwner: ILookupGridOwner;
begin
  if FListSource <> Value then
  begin
    FListSource := Value;
    if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
      LookupGridOwner.SetListSource(Value);
  end;
end;

procedure TColumnDropDownBoxEh.SetSortLocal(const Value: Boolean);
var
  LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.GetLookupGrid.SortLocal := Value;
end;

function TColumnDropDownBoxEh.GetSortLocal: Boolean;
var
  LookupGridOwner: ILookupGridOwner;
begin
  Result := False;
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := LookupGridOwner.GetLookupGrid.SortLocal;
end;

procedure RecreateInplaceSearchIndicator;
var
  Bmp: TBitmap;
  il: TImageList;
begin
  il := nil;
  Bmp := TBitmap.Create;
  try
    BitmapLoadFromResourceName(Bmp, HInstance, bmEditWhite);
    il := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    il.BkColor := DBGridEhInplaceSearchColor;
    if il.BkColor = clTeal then il.BkColor := TColor(RGB(0, 127, 127));
    il.AddMasked(Bmp, clWhite);
    il.GetBitmap(0, Bmp);
    if DBGridEhIndicators.Count = 7 then DBGridEhIndicators.Delete(6);
    DBGridEhIndicators.AddMasked(Bmp, clTeal);
  finally
    il.Free;
    Bmp.Free;
  end;
end;

procedure CreateIndicators;
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    BitmapLoadFromResourceName(Bmp, HInstance, bmArrow);
    DBGridEhIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    DBGridEhIndicators.AddMasked(Bmp, clWhite);
    BitmapLoadFromResourceName(Bmp, HInstance, bmEdit);
    DBGridEhIndicators.AddMasked(Bmp, clWhite);
    BitmapLoadFromResourceName(Bmp, HInstance, bmInsert);
    DBGridEhIndicators.AddMasked(Bmp, clWhite);
    BitmapLoadFromResourceName(Bmp, HInstance, bmMultiDot);
    DBGridEhIndicators.AddMasked(Bmp, clWhite);
    BitmapLoadFromResourceName(Bmp, HInstance, bmMultiArrow);
    DBGridEhIndicators.AddMasked(Bmp, clWhite);
    BitmapLoadFromResourceName(Bmp, HInstance, bmEditWhite);
    DBGridEhIndicators.AddMasked(Bmp, clTeal);

    RecreateInplaceSearchIndicator;
    BitmapLoadFromResourceName(Bmp, HInstance, bmSmDown);
    DBGridEhSortMarkerImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    DBGridEhSortMarkerImages.AddMasked(Bmp, clFuchsia);
    BitmapLoadFromResourceName(Bmp, HInstance, bmSmUp);
    DBGridEhSortMarkerImages.AddMasked(Bmp, clFuchsia);

    BitmapLoadFromResourceName(Bmp, HInstance, bmDropDown);
    DBGridEhSortMarkerImages.AddMasked(Bmp, clWhite);

    BitmapLoadFromResourceName(Bmp, HInstance, bmSmDown1);
    DBGridEhSortMarkerImages.AddMasked(Bmp, clFuchsia);
    BitmapLoadFromResourceName(Bmp, HInstance, bmSmUp1);
    DBGridEhSortMarkerImages.AddMasked(Bmp, clFuchsia);
    
  finally
    Bmp.Free;
  end;
end;

//The PropStorage
type

  TColumnEhPropertyInterceptor = class(TStoragePropertyInterceptor)
  private
    procedure SetWidth(const Value: Integer);
  published
    property Width: Integer write SetWidth;
  end;

  TColumnsEhPropertyInterceptor = class(TStoragePropertyInterceptor)
  private
    FColumnsIndex: String;
    procedure SetColumnsIndex(const Value: String);
    function GetColumnsIndex: String;
  public
    procedure Readed; override;
  published
    property ColumnsIndex: String read GetColumnsIndex write SetColumnsIndex;
  end;

{ TColumnEhPropertyInterceptor }

procedure TColumnEhPropertyInterceptor.SetWidth(const Value: Integer);
begin
  if (TColumnEh(Target).Grid <> nil) and TColumnEh(Target).Grid.AutoFitColWidths
    then TColumnEh(Target).FInitWidth := Value
    else TColumnEh(Target).Width := Value;
end;

{ TColumnsEhPropertyInterceptor }

function TColumnsEhPropertyInterceptor.GetColumnsIndex: String;
var
  i: Integer;
begin
  Result := '';
  with TDBGridColumnsEh(Target) do
  begin
    for i := 0 to Count - 1 do
      Result := Result + '"' + Items[i].FieldName + '",';
  end;
  Delete(Result, Length(Result), 1);
end;

procedure TColumnsEhPropertyInterceptor.SetColumnsIndex(const Value: String);
var
  fl: TStringList;
  i: Integer;
  Col: TColumnEh;

  function GetFieldColumns(const FieldName: String): TColumnEh;
  var
    i: Integer;
  begin
    Result := nil;
    with TDBGridColumnsEh(Target) do
      for i := 0 to Count - 1 do
        if NlsCompareStr(Items[i].FieldName, FieldName) = 0 then
        begin
          Result := Items[i];
          Break;
        end;
  end;

begin
  FColumnsIndex := Value;
  fl := TStringList.Create;
  fl.CommaText := FColumnsIndex;
  TDBGridColumnsEh(Target).BeginUpdate;
  try
    for i := 0 to fl.Count - 1 do
    begin
      Col := GetFieldColumns(fl[i]);
      if Col <> nil then
        Col.Index := i;
    end;
  finally
    TDBGridColumnsEh(Target).EndUpdate;
    fl.Free;
  end;
end;

procedure TColumnsEhPropertyInterceptor.Readed;
begin
end;
//*)

function VarArrayToCommaText(va: Variant): String;
var
  i: Integer;
begin
  Result := '';
  if VarIsArray(va) then
  begin
    for i := VarArrayLowBound(va, 1) to VarArrayHighBound(va, 1) do
      Result := Result + '''' + VarToStr(va[i]) + ''',';
    Delete(Result, Length(Result), 1);
  end
  else
    Result := VarToStr(va);
end;

{ TSTColumnFilterEh }

constructor TSTColumnFilterEh.Create(AColumn: TColumnEh);
begin
  inherited Create;
  FColumn := AColumn;
  ClearSTFilterExpression(FExpression);
  FVisible := True;

  FList := TStringList.Create;
  FKeys := TStringList.Create;
  FListLink := TFieldDataLink.Create;
  FListLink.OnActiveChange := ListLinkActiveChange;
  FKeyValues := Null;
  FPopupFilterItems := TStringList.Create;
  FDropDownListRows := 15;
end;

destructor TSTColumnFilterEh.Destroy;
begin
  FreeAndNil(FList);
  FreeAndNil(FKeys);
  FreeAndNil(FListLink);
  FreeAndNil(FPopupListboxItemData);
  FreeAndNil(FPopupFilterItems);
  inherited Destroy;
end;

procedure TSTColumnFilterEh.Assign(Source: TPersistent);
begin
  if Source is TSTColumnFilterEh then
  begin
    DataField := TSTColumnFilterEh(Source).DataField;
    Visible := TSTColumnFilterEh(Source).Visible;
    KeyField := TSTColumnFilterEh(Source).KeyField;
    ListField := TSTColumnFilterEh(Source).ListField;
    ListSource := TSTColumnFilterEh(Source).ListSource;
  end else
    inherited Assign(Source);
end;

procedure TSTColumnFilterEh.Clear;
begin
  FKeyValues := Null;
  ExpressionStr := '';
end;

function TSTColumnFilterEh.GetExpression: TSTFilterExpressionEh;
begin
  Result := FExpression;
end;

function TSTColumnFilterEh.GetExpressionAsString: String;

  function VarValueAsText(v: Variant): String;
  begin
    if VarType(v) = varDouble then
      Result := FloatToStr(v)
    else if VarType(v) = varDate then
      Result := FormatDateTime(ShortDateFormat, v)
    else
      Result := '''' + VarToStr(v) + '''';
  end;

  function GetOneExpression(O: TSTFilterOperatorEh; v: Variant): String;
  var
    i: Integer;
  begin
    if O = foNull then
      Result := Result + '=' + STFilterOperatorsStrMapEh[O]
    else if O = foNotNull then
      Result := Result + '<>' + STFilterOperatorsStrMapEh[O]
    else
    begin
      Result := Result + STFilterOperatorsStrMapEh[O];
      if O in [foIn, foNotIn] then
      begin
        Result := Result + ' (';
        if VarIsArray(v) then
          for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
            Result := Result + VarValueAsText(v[i]) + ','
        else
          Result := Result + VarValueAsText(v) + ',';
        Delete(Result, Length(Result), 1);
        Result := Result + ')';
      end
      else
        Result := Result + ' ' + VarValueAsText(v);
    end;
  end;

begin
  Result := '';
  if (Expression.ExpressionType = botNon) or (Expression.Operator1 = foNon) then
    Exit;
  if ListSource <> nil then
    Result := VarArrayToCommaText(Expression.Operand1)
  else
  begin
    Result := GetOneExpression(Expression.Operator1, Expression.Operand1);
    if Expression.Relation <> foNon then
    begin
      Result := Result + ' ' + STFilterOperatorsStrMapEh[Expression.Relation] + ' ';
      Result := Result + GetOneExpression(Expression.Operator2, Expression.Operand2);
    end;
  end;  
end;

function TSTColumnFilterEh.GetGrid: TCustomDBGridEh;
begin
  Result := FColumn.Grid;
end;

function TSTColumnFilterEh.ParseExpression(Exp: String): String;
var
  DefaultOperator: TSTFilterDefaultOperatorEh;
begin
  if (Column.Field <> nil) then
    FExpression.ExpressionType := STFldTypeMapEh[Column.Field.DataType];
  if (Column.KeyList.Count > 0) and (Column.PickList.Count > 0) then
    FExpression.ExpressionType := botString;
  if (Column.Grid <> nil) and (Column.Grid.Center <> nil) then
    DefaultOperator := Column.Grid.Center.GetSTFilterDefaultOperator(
      Column.Grid, Column, FExpression)
  else
    DefaultOperator := fdoAuto;

  ParseSTFilterExpressionEh(Exp, FExpression, DefaultOperator);
  CheckRecodeKeyList(FExpression);
  Result := GetExpressionAsString;
end;

procedure TSTColumnFilterEh.SetExpression(const Value: TSTFilterExpressionEh);
begin
  FExpression := Value;
  FExpressionStr := GetExpressionAsString;
end;

procedure TSTColumnFilterEh.SetExpressionStr(const Value: String);
begin
  InternalSetExpressionStr(Value);
  if Assigned(Column.Grid) then
  begin
    Column.Grid.Invalidate;
    if (Column.Grid.FilterEdit <> nil) and Column.Grid.FilterEdit.Visible then
      Column.Grid.UpdateFilterEdit(True);
  end;
end;

procedure TSTColumnFilterEh.InternalSetExpressionStr(const Value: String);

  procedure SetLookupKeyValues(var v: Variant);
  var
    i: Integer;
  begin
    if VarIsArray(Expression.Operand1) then
      for i := VarArrayLowBound(Expression.Operand1, 1) to VarArrayHighBound(Expression.Operand1, 1) do
        v[i] := CurrentListDataSet.Lookup(CurrentListField, v[i], CurrentKeyField)
    else
      v := CurrentListDataSet.Lookup(CurrentListField, v, CurrentKeyField)
  end;

begin
  {if CurrentKeyField <> '' then
  begin
    ParseExpression(Value);
    if not (FExpression.Operator1 in [foNull, foNotNull]) then
    begin
      if Value = '' then
        FKeyValues := Null
      else if CurrentListDataSet <> nil then
        FKeyValues := CurrentListDataSet.Lookup(CurrentListField, Value, CurrentKeyField);
      ParseExpression('');
      if not VarIsNull(FKeyValues) then
      begin
        FExpression.ExpressionType := botString;
        FExpression.Operator1 := foIn;
        FExpression.Operand1 := Value;
  //      Expression := FExpression;
      end else
      begin
        FExpression.ExpressionType := botString;
        if Value = ''
          then FExpression.Operator1 := foNon
          else FExpression.Operator1 := foNull;
      end;
    end;
    FExpressionStr := Value;
  end else
  begin
    ParseExpression(Value);
    FExpressionStr := Value;
  end;}
  ParseExpression(Value);
  FExpressionStr := Value;
  if (CurrentKeyField <> '') and (CurrentListDataSet <> nil) and (CurrentListField <> '') then
  begin
    if FExpression.Operator1 <> foNon then
      SetLookupKeyValues(FExpression.Operand1);
    if FExpression.Operator2 <> foNon then
      SetLookupKeyValues(FExpression.Operand2);
  end;
end;

procedure TSTColumnFilterEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Column.Changed(False);
  end;
end;

function TSTColumnFilterEh.DropDownButtonVisible: Boolean;
begin
  Result := True;//(ListSource <> nil) or (Grid.MemTableSupport);
end;

function TSTColumnFilterEh.GetFilterFieldName: String;
begin
  Result := CurrentDataField;
//  if (ListSource <> nil) or (DataField <> '')
//    then Result := CurrentDataField
//    else Result := FColumn.FieldName;
end;

function TSTColumnFilterEh.GetOperand1: Variant;
begin
  if CurrentKeyField <> ''
    then Result := FKeyValues
    else Result := FExpression.Operand1;
end;

function TSTColumnFilterEh.GetOperand2: Variant;
begin
  Result := FExpression.Operand2;
end;

function TSTColumnFilterEh.GetListSource: TDataSource;
begin
  Result := FListLink.DataSource;
end;

procedure TSTColumnFilterEh.ListLinkActiveChange(Sender: TObject);
begin
  if FListLink.Active and (FListField <> '') and (FKeyField <> '') then
    with FListLink.DataSet do
    begin
      DisableControls;
      try
        First;
        while not Eof do
        begin
          FList.Add(VarToStr(FieldValues[FListField]));
          FKeys.Add(VarToStr(FieldValues[FKeyField]));
          Next;
        end;
        First;
      finally
        EnableControls;
      end;
    end;
  Column.FieldValueList := nil;
end;

procedure TSTColumnFilterEh.SetKeyListValues(AText: String; KeyVals: Variant);
begin
  ExpressionStr := '';
//  if not VarIsNull(KeyVals) and not (not VarIsArray(KeyVals) and (KeyVals = '')) then
  if not VarIsNull(KeyVals) then
  begin
    FExpression.ExpressionType := botString;
    FExpression.Operator1 := foIn;
    FExpression.Operand1 := AText;
    Expression := FExpression;
    FKeyValues := KeyVals;
  end
  else
    FKeyValues := Null;
end;

procedure TSTColumnFilterEh.SetKeysFromListValues(ss: TStrings);
var
  i: Integer;
  ks: TStrings;
  AKeyField: String;

  function StringsAsCommaText(ss: TStrings): String;
  var i: Integer;
  begin
    Result := '';
    for i := 0 to ss.Count-1  do
      Result := Result + '''' + ss[i] + ''',';
    Delete(Result, Length(Result), 1);
  end;

  function StringsAsVarArray(ss: TStrings): Variant;
  var i: Integer;
  begin
    Result := Null;
    if ss.Count = 0 then
      Exit;
    Result := VarArrayCreate([0, ss.Count - 1], varVariant);
    for i := 0 to ss.Count - 1 do
      Result[i] := ss[i];
  end;

begin
  if (not FListLink.Active) or (ListField = '') {or (DataField = '')} then
    Exit;
  if KeyField = ''
    then AKeyField := ListField
    else AKeyField := KeyField;
  ks := TStringList.Create;
  for i := 0 to ss.Count - 1 do
    ks.Add(VarToStr(FListLink.DataSet.Lookup(ListField, ss[i], AKeyField)));
  SetKeyListValues(StringsAsCommaText(ss), StringsAsVarArray(ks));
  ks.Free;
end;

procedure TSTColumnFilterEh.SetListSource(const Value: TDataSource);
begin
  FListLink.DataSource := Value;
end;

function TSTColumnFilterEh.CurrentKeyField: String;
var
  Field: TField;
begin
  Result := '';
  if KeyField <> '' then
    Result := KeyField
  else if Grid.DataLink.Active then
  begin
    Field := Grid.DataLink.DataSet.FindField(Column.FieldName);
    if (Field <> nil) and (Field.FieldKind = fkLookup) then
      Result := Field.LookupKeyFields;
  end;
end;

function TSTColumnFilterEh.CurrentDataField: String;
var
  Field: TField;
begin
  Result := Column.FieldName;
  if DataField <> ''  then
    Result := DataField
  else if Grid.DataLink.Active then
  begin
    Field := Grid.DataLink.DataSet.FindField(Column.FieldName);
    if (Field <> nil) and (Field.FieldKind = fkLookup) then
      Result := Field.KeyFields;
  end;
end;

function TSTColumnFilterEh.CurrentListDataSet: TDataSet;
var
  Field: TField;
begin
  Result := nil;
  if ListSource <> nil then
    Result := ListSource.DataSet
  else if Grid.DataLink.Active then
  begin
    Field := Grid.DataLink.DataSet.FindField(Column.FieldName);
    if (Field <> nil) and (Field.FieldKind = fkLookup) then
      Result := Field.LookupDataSet;
  end;
end;

function TSTColumnFilterEh.CurrentListField: String;
var
  Field: TField;
begin
  Result := '';
  if ListField <> '' then
    Result := ListField
  else if Grid.DataLink.Active then
  begin
    Field := Grid.DataLink.DataSet.FindField(Column.FieldName);
    if (Field <> nil) and (Field.FieldKind = fkLookup) then
      Result := Field.LookupResultField;
  end;
end;

function TSTColumnFilterEh.GetFieldValueList: IMemTableDataFieldValueListEh;
var
  dsfv:  TDatasetFieldValueListEh;
  Field: TField;
begin
  Result := nil;
  if not Grid.DataLink.Active or (ListSource = nil) or
    (ListSource.DataSet = nil) or not ListSource.DataSet.Active
  then
    Exit;
  if ListField <> ''
    then Field := ListSource.DataSet.FindField(ListField)
    else Field := ListSource.DataSet.FindField(Column.FieldName);
  if Field = nil then
    Exit;
  dsfv := TDatasetFieldValueListEh.Create;
  dsfv.FieldName := Field.FieldName;
  dsfv.DataSource := ListSource;
  Result := dsfv;
end;

procedure TSTColumnFilterEh.CheckRecodeKeyList(var FExpression: TSTFilterExpressionEh);

  procedure ConvertPickListToKeyList(var v: Variant);
  var
    i, k: Integer;
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
        begin
          k := Column.PickList.IndexOf(VarToStr(v[i]));
          if k >= 0 then
            v[i] := Column.KeyList[k];
        end
      else
      begin
        k := Column.PickList.IndexOf(VarToStr(v));
        if k >= 0 then
          v := Column.KeyList[k];
      end;
  end;

begin
  if (Column.KeyList.Count > 0) and (Column.PickList.Count > 0) then
  begin
    if FExpression.Operator1 in [foEqual..foNotIn] then
      ConvertPickListToKeyList(FExpression.Operand1);
    if FExpression.Operator2 in [foEqual..foNotIn] then
      ConvertPickListToKeyList(FExpression.Operand2);
  end;
end;

procedure TSTColumnFilterEh.UpdateFilterFromValuesCheckingState(ss: TStrings);
var
  FilterStr: String;
  i,k: Integer;
begin
  k := 0;
  for i := 0 to Length(FListValuesCheckingState)-1 do
  begin
    if ss.Objects[i] is TPopupListboxItemEhData then
      if FListValuesCheckingState[i] = True then
      begin
        if FilterStr <> '' then FilterStr := FilterStr + ',';
        FilterStr := FilterStr + '''' + StringReplace(ss[i], '''', '''''',[rfReplaceAll])
          + '''';
        Inc(k);
      end;
  end;
  if FilterStr <> '' then
    if k = 1
      then FilterStr := '=' + FilterStr
      else FilterStr := 'in (' + FilterStr + ')';
  InternalSetExpressionStr(FilterStr);
  if (Column.Grid.FilterEdit <> nil) and Column.Grid.FilterEdit.Visible then
     Column.Grid.FilterEdit.Text := FilterStr;
  if Column.Grid.STFilter.InstantApply then
    Column.Grid.SetDataFilter;
end;

procedure TSTColumnFilterEh.UpdateValuesCheckingStateFromFilter(ss: TStrings);
var
  i, si: Integer;
  v: Variant;
begin
  if Expression.Operator1 = foIn then
    if VarIsArray(Expression.Operand1) then
    begin
      v := VarArrayCreate([0, VarArrayHighBound(Expression.Operand1, 1)], varVariant);
      for i := VarArrayLowBound(Expression.Operand1, 1) to VarArrayHighBound(Expression.Operand1, 1) do
        v[i] := Expression.Operand1[i];
    end else
    begin
      v := VarArrayCreate([0, 0], varVariant);
      v[0] := Expression.Operand1;
    end
  else if Expression.Operator1 = foEqual then
  begin
    if (Expression.Relation = foOR) and (Expression.Operator2 = foEqual) then
    begin
      v := VarArrayCreate([0, 1], varVariant);
      v[1] := Expression.Operand2;
    end else
      v := VarArrayCreate([0, 0], varVariant);
    v[0] := Expression.Operand1;
  end;

  if not VarIsArray(v) then Exit;

  if (CurrentKeyField <> '') and (CurrentListDataSet <> nil) and (CurrentListField <> '') then
    for i := 0 to VarArrayHighBound(v, 1) do
      v[i] := CurrentListDataSet.Lookup(CurrentKeyField, v[i], CurrentListField);

  for i := 0 to VarArrayHighBound(v, 1) do
    for si := 0 to Length(FListValuesCheckingState)-1 do
    begin
      if ss.Objects[si] is TPopupListboxItemEhData then
        if (si < ss.Count) and (ss[si] = VarToStr(v[i])) then
          FListValuesCheckingState[si] := True
    end;
end;

function TSTColumnFilterEh.GetOperandAsString(Operator: TSTFilterOperatorEh;
  v: Variant): String;
var
  i: Integer;

  function OperandVarToStr(v1: Variant): String;
  var
    DoQuote: Boolean;
  begin
    Result := VarToStr(v1);
    DoQuote := False;
    if (Operator in [foIn, foNotIn]) and (AnsiPos(',', Result) > 0) then
      DoQuote := True;
    if (CharAtPos(Result,1) = ' ') or (CharAtPos(Result,1) = '''') then
      DoQuote := True;
    if CharAtPos(Result, Length(Result)) = ' ' then
      DoQuote := True;
    if UpperCase(Copy(Result, Length(Result)-2, 3)) = ' OR' then
      DoQuote := True;
    if UpperCase(Copy(Result, Length(Result)-3, 4)) = ' AND' then
      DoQuote := True;
    if (UpperCase(Result) = 'OR') or (UpperCase(Result) = 'AND') then
      DoQuote := True;
    if DoQuote = True then  
    begin
      Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
      Result := '''' + Result + '''';
    end;
  end;

  function VarToFilterString(v1: Variant): String;
  begin
    if (CurrentKeyField <> '') and
       (CurrentListDataSet <> nil) and
       (CurrentListField <> '')
     then
       v1 := CurrentListDataSet.Lookup(CurrentKeyField, v1, CurrentListField);
    Result := OperandVarToStr(v1);
  end;

begin
  Result := '';
  if VarIsArray(v) then
    for i := 0 to VarArrayHighBound(v, 1) do
    begin
      if Result <> '' then Result := Result + ',';
      Result := Result + VarToFilterString(v[i]);
    end
  else
    Result := VarToFilterString(v);
end;

{ TSTDBGridEhFilter }

constructor TSTDBGridEhFilter.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FUpateCount := 0;
end;

procedure TSTDBGridEhFilter.Assign(Source: TPersistent);
begin
  if Source is TSTDBGridEhFilter then
  begin
    Visible := TSTDBGridEhFilter(Source).Visible;
    Local := TSTDBGridEhFilter(Source).Local;
  end else
    inherited Assign(Source);
end;

procedure TSTDBGridEhFilter.BeginUpdate;
begin
  Inc(FUpateCount);
end;

procedure TSTDBGridEhFilter.EndUpdate;
begin
  Dec(FUpateCount);
end;

procedure TSTDBGridEhFilter.SetLocal(const Value: Boolean);
begin
  FLocal := Value;
end;

procedure TSTDBGridEhFilter.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if not Value then
      FGrid.StopEditFilter;
    FGrid.LayoutChanged;
    if FGrid.EditorMode then
      FGrid.InvalidateEditor;
  end;
end;

function  TSTDBGridEhFilter.GetInstantApply: Boolean;
begin
  if FIsInstantApplyStored
    then Result := FInstantApply
    else Result := Local;
end;

procedure TSTDBGridEhFilter.SetInstantApply(const Value: Boolean);
begin
  FInstantApply := Value;
  FIsInstantApplyStored := True;
end;

function  TSTDBGridEhFilter.IsInstantApplyStored: Boolean;
begin
  Result := FIsInstantApplyStored;
end;

procedure TSTDBGridEhFilter.SetLocation(const Value: TSTFilterLocationEh);
begin
  if FLocation <> Value then
  begin
    FLocation := Value;
    FGrid.LayoutChanged;
  end;
end;

{ TDBGridEhIndicatorTitle }

constructor TDBGridEhIndicatorTitle.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  UseGlobalMenu := True;
end;

procedure TDBGridEhIndicatorTitle.SetShowDropDownSign(const Value: Boolean);
begin
  if Value <> FShowDropDownSign then
  begin
    FShowDropDownSign := Value;
    FGrid.InvalidateCell(0,0);
  end;
end;

{ TRowDetailPanelEh }

constructor TRowDetailPanelEh.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FWidth := 0;
  FHeight := 120;

  FBevelEdges := [beLeft, beTop, beRight, beBottom];
  FBevelInner := bvRaised;
  FBevelOuter := bvLowered;
  FBevelKind := bkNone;
  FBevelWidth := 1;
  FBorderStyle := bsSingle;
  FColor := AGrid.FixedColor;
end;

procedure TRowDetailPanelEh.Assign(Source: TPersistent);
begin
  if Source is TRowDetailPanelEh then
  begin
    Active := TRowDetailPanelEh(Source).Active;
  end else
    inherited Assign(Source);
end;

procedure TRowDetailPanelEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then
    begin
      if (csDesigning in FGrid.ComponentState) and not (csLoading in FGrid.ComponentState) then
        Visible := True
    end else
      Visible := False;
    FGrid.UpdateRowDetailPanel;
    FGrid.LayoutChanged;
  end;
end;

procedure TRowDetailPanelEh.SetVisible(const Value: Boolean);
var
  CanProceed: Boolean;
  DrawInfo: TGridDrawInfoEh;
  MaxTopLeft: TGridCoord;
begin
  if FVisible <> Value then
  begin
    if Value
      then CanProceed := FGrid.DataLink.Active and not FGrid.DataLink.DataSet.IsEmpty
      else CanProceed := True;
    if not (csDestroying in FGrid.ComponentState) then
    begin
      if Value and Assigned(FGrid.OnRowDetailPanelShow) then
        FGrid.OnRowDetailPanelShow(FGrid, CanProceed);
      if not Value and Assigned(FGrid.OnRowDetailPanelHide) then
        FGrid.OnRowDetailPanelHide(FGrid, CanProceed);
    end;
    if not CanProceed then Exit;
    FVisible := Value;
    FGrid.UpdateRowDetailPanel;
    if Visible then
    begin
      FGrid.CalcDrawInfo(DrawInfo);
      MaxTopLeft.X := FGrid.Col;
      MaxTopLeft.Y := FGrid.Row;
      MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
      if MaxTopLeft.Y > FGrid.TopRow then
        FGrid.TopRow := MaxTopLeft.Y;
    end
    else if not (csDestroying in FGrid.ComponentState) then
      FGrid.MTUpdateTopRow;
  end;
end;

procedure TRowDetailPanelEh.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetActiveControl(Control: TWinControl);
begin
  if FActiveControl <> Control then
  begin
{    if not ((Control = nil) or
            (csLoading in FGrid.ComponentState) or
            (csDesigning in FGrid.ComponentState) or
            Control.CanFocus) then
      raise EInvalidOperation.Create(SCannotFocus);}
    FActiveControl := Control;
{    if not (csLoading in FGrid.ComponentState) and
       not (csDesigning in FGrid.ComponentState) then
    begin
      if FActive and (FActiveControl <> nil) then
        FActiveControl.SetFocus;
    end;}
  end;
end;

procedure TRowDetailPanelEh.SetBevelEdges(const Value: TBevelEdges);
begin
  if FBevelEdges <> Value then
  begin
    FBevelEdges := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetBevelKind(const Value: TBevelKind);
begin
  if FBevelKind <> Value then
  begin
    FBevelKind := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetBevelWidth(const Value: TBevelWidth);
begin
  if FBevelWidth <> Value then
  begin
    FBevelWidth := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetBevelInner(const Value: TBevelCut);
begin
  if FBevelInner <> Value then
  begin
    FBevelInner := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetBevelOuter(const Value: TBevelCut);
begin
  if FBevelOuter <> Value then
  begin
    FBevelOuter := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

procedure TRowDetailPanelEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FParentColor := False;
    FGrid.UpdateRowDetailPanel;
  end;
end;

function TRowDetailPanelEh.GetColor: TColor;
begin
  if ParentColor
    then Result := FGrid.Color
    else Result := FColor;
end;

function TRowDetailPanelEh.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

procedure TRowDetailPanelEh.SetParentColor(Value: Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    FGrid.UpdateRowDetailPanel;
  end;
end;

{ TRowDetailPanelControlEh }

constructor TRowDetailPanelControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, csReplicatable];
  Width := 185;
  Height := 41;
  FBorderStyle := bsSingle;
end;

procedure TRowDetailPanelControlEh.CMChildKey(var Message: TCMChildKey);
begin
  inherited;
  if (Message.Result <> 1) and
     (Message.CharCode = VK_UP) and
     not (csDesigning in ComponentState) and
     (GetShiftState = [ssCtrl]) then
  begin
    TCustomDBGridEh(Parent).SetFocus;
    Message.Result := 1;
  end;
end;

procedure TRowDetailPanelControlEh.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
{    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;}
  end;
end;

procedure TRowDetailPanelControlEh.SetBorderStyle(Value: TBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TRowDetailPanelControlEh.WMNCHitTest(var Message: TMessage);
begin
  DefaultHandler(Message);
end;

procedure TRowDetailPanelControlEh.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

{ TGridRowPanelEh }

constructor TGridRowPanelEh.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FActive := False;
end;

procedure TGridRowPanelEh.Assign(Source: TPersistent);
begin
  if Source is TGridRowPanelEh then
  begin
    Active := TGridRowPanelEh(Source).Active;
  end else
    inherited Assign(Source);
end;

procedure TGridRowPanelEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then
      FGrid.Col := FGrid.IndicatorOffset;
    FGrid.LayoutChanged;
  end;
end;

{New version 4.6}

function TColumnEh.GetInRowLinePos: Integer;
begin
  Result := FRowLine;
  if Result < 0 then Result := 0;
end;

procedure TColumnEh.SetInRowLinePos(const Value: Integer);
begin
  if FRowLine <> Value then
  begin
    FRowLine := Value;
    Changed(True);
  end;
end;

function TColumnEh.GetInRowLineHeight: Integer;
begin
  Result := FHeight;
  if Result <= 0 then Result := 1;
end;

procedure TColumnEh.SetInRowLineHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed(True);
  end;
end;

procedure TDBGridColumnsEh.RelayoutCellsInRowPanel;
var
  i, j: Integer;
  Col: TColumnEh;
  RowLinesExtend: array of Integer;
  InRowHeight: Integer;
  MinLeftPos: Integer;

  procedure EnsureRowLinesExtendSize(NewSize: Integer);
  begin
    if NewSize > Length(RowLinesExtend) then
      SetLength(RowLinesExtend, NewSize);
  end;

begin
  EnsureRowLinesExtendSize(1);
  InRowHeight := Grid.InRowPanelLineHeight;
  for i := 0 to Count-1 do
  begin
    Col := Items[i];
    EnsureRowLinesExtendSize(Col.InRowLinePos + Col.InRowLineHeight);
    MinLeftPos := 0;
    for j := Col.InRowLinePos  to Col.InRowLinePos + Col.InRowLineHeight - 1 do
      if RowLinesExtend[j] > MinLeftPos then
        MinLeftPos := RowLinesExtend[j];
    for j := Col.InRowLinePos  to Col.InRowLinePos + Col.InRowLineHeight - 1 do
    begin
      Col.FRowPlacement.Left := MinLeftPos;
      Col.FRowPlacement.Top := Col.InRowLinePos * (InRowHeight + Grid.GridLineWidth);
      if Col.Visible
        then Col.FRowPlacement.Width := Col.Width
        else Col.FRowPlacement.Width := 0;
      Col.FRowPlacement.Height := Col.InRowLineHeight * (InRowHeight + Grid.GridLineWidth) - 1;
      Col.FRowPlacement.DataCellLeft := Col.FRowPlacement.Left;
      Col.FRowPlacement.DataCellWidth := Col.FRowPlacement.Width;
      if Col.FRowPlacement.Left = 0 then
      begin
        Inc(Col.FRowPlacement.Width, Grid.FExtraFirstColumnWidth);
        Inc(Col.FRowPlacement.DataCellLeft, Grid.FExtraFirstColumnWidth);
      end;
      if Col.Visible
        then RowLinesExtend[j] := MinLeftPos + Col.FRowPlacement.Width + Grid.GridLineWidth
        else RowLinesExtend[j] := MinLeftPos;
    end;
  end;

  Grid.FGridMasterCellWidth := 0;
  Grid.FGridMasterCellHeight := InRowHeight;
  for i := 0 to Count-1 do
  begin
    if not Items[i].Visible then Continue;
    if Items[i].FRowPlacement.Left + Items[i].Width > Grid.FGridMasterCellWidth then
      Grid.FGridMasterCellWidth := Items[i].FRowPlacement.Left + Items[i].Width;
    if Items[i].FRowPlacement.Top + Items[i].FRowPlacement.Height > Grid.FGridMasterCellHeight then
      Grid.FGridMasterCellHeight := Items[i].FRowPlacement.Top + Items[i].FRowPlacement.Height;
  end;
end;

procedure TDBGridColumnsEh.ScaleWidths(Divisor, Denominator: Integer);
var
  i: Integer;
  Col: TColumnEh;
  NewLeft, NewRight: Integer;
//  OldRightReal, NewRightReal: Double;
//  OldLeftReal, NewLeftReal: Double;
begin
  for i := 0 to Count-1 do
  begin
    Col := Items[i];
    NewRight := Round((Col.FRowPlacement.Left + Col.Width + Grid.GridLineWidth) / Divisor * Denominator);
    NewLeft := Round(Col.FRowPlacement.Left / Divisor * Denominator);
    Col.Width := NewRight - NewLeft - Grid.GridLineWidth;
//    Col.Width := Round(Col.Width / Divisor * Denominator);
  end;
  RelayoutCellsInRowPanel;
end;


function TCustomDBGridEh.InRowPanelLineHeight: Integer;
begin
  Canvas.Font := TitleFont;
  Result := Canvas.TextHeight('Wg')+4;
  if not Flat then
    Inc(Result);
end;

procedure TCustomDBGridEh.SetRowPanel(const Value: TGridRowPanelEh);
begin
  if (Value = nil) and (csLoading in ComponentState) then
  begin
    // It is old style trying to assign RowPanel = True
    FGridRowPanel.Active := True;
    Exit;
  end;
  FGridRowPanel.Assign(Value);
end;

{procedure TCustomDBGridEh.SetRowPanel(const Value: Boolean);
begin
  if Value <> FRowPanel then
  begin
    FRowPanel := Value;
    if FRowPanel then
      Col := IndicatorOffset;
    LayoutChanged;
  end;
end;}

procedure TCustomDBGridEh.DrawTitleAsRowPanel(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  i: Integer;
  Col: TColumnEh;
  CellRect: TRect;
begin
  Canvas.Brush.Color := ColumnDefValues.Title.Color;
  Canvas.FillRect(ARect);
  for i := 0 to Columns.Count-1 do
  begin
    Col := Columns[i];
    if not Col.Visible then Continue;
    CellRect := Rect(Col.FRowPlacement.Left, Col.FRowPlacement.Top,
      Col.FRowPlacement.Left + Col.FRowPlacement.Width,
      Col.FRowPlacement.Top + Col.FRowPlacement.Height);
    Inc(CellRect.Left, ARect.Left);
    Inc(CellRect.Right, ARect.Left);
    Inc(CellRect.Top, ARect.Top);
    Inc(CellRect.Bottom, ARect.Top);
    if CellRect.Bottom < ARect.Bottom then
    begin
      Canvas.Pen.Color := GridLineColors.GetDarkColor;
      Canvas.Polyline([Point(CellRect.Left, CellRect.Bottom),
                       Point(CellRect.Right+1, CellRect.Bottom)]);
    end;
    if CellRect.Right < ARect.Right then
    begin
      Canvas.Pen.Color := GridLineColors.GetDarkColor;
      Canvas.Polyline([Point(CellRect.Right, CellRect.Top),
                       Point(CellRect.Right, CellRect.Bottom+1)]);
    end;
    Exclude(AState, gdFocused);
    Exclude(AState, gdSelected);
    Exclude(AState, gdHotTrack);
    if IsActiveControl and (ARow = Row) and ((SelectedIndex = i) or (dgRowSelect in Options))  then
      Include(AState, gdFocused);
    if (ARow = Row) and (SelectedIndex = i) then
      Include(AState, gdSelected);
    if (ARow = FHotTrackCell.Y) and (FHotTrackCell.X = i + FIndicatorOffset) then
      Include(AState, gdHotTrack);
    DrawTitleCell(ACol, ARow, i, AreaRow, CellRect, AState, CellAreaType);
  end;
end;

procedure TCustomDBGridEh.DrawDataAsRowPanel(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  i: Integer;
  Column: TColumnEh;
  CellRect: TRect;
  The3DRect: Boolean;
  FillRect: TRect;
begin

  FillRect := ARect;
  if DataGrouping.IsGroupingWorks and (DataGrouping.GroupDataTree.FlatVisibleCount > 0) then
  begin
    InstantReadRecordEnter(AreaRow);
    try
      The3DRect := CellHave3DRect(ACol, ARow, ARect, AState);
      if FDrawGroupDataNode.NodeType = dntDataGroupEh then
      begin
        DrawGroupDataCell(ACol, ARow, AreaCol, AreaRow, ARect, AState, CellAreaType);
        Exit;
      end else
      begin
        DrawGroupDataArea(AreaCol, AreaRow, FDrawGroupDataNode.Level, AState, ARect, The3DRect);
        ARect.Bottom := ARect.Bottom - 1;
        FillRect := ARect;
        FillRect.Left := ARect.Left + FExtraFirstColumnWidth;
      end;
    finally
      InstantReadRecordLeave;
    end;
  end;

  Canvas.Brush.Color := Color;
  Canvas.FillRect(FillRect);
  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    if not Column.Visible then Continue;
    CellRect := Rect(Column.FRowPlacement.DataCellLeft, Column.FRowPlacement.Top,
      Column.FRowPlacement.DataCellLeft + Column.FRowPlacement.DataCellWidth,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    Inc(CellRect.Left, ARect.Left);
    Inc(CellRect.Right, ARect.Left);
    Inc(CellRect.Top, ARect.Top);
    Inc(CellRect.Bottom, ARect.Top);
    if CellRect.Bottom < ARect.Bottom then
    begin
      if (Row = ARow) or (FGridMasterCellHeight div InRowPanelLineHeight <= 1)
        then Canvas.Pen.Color := GridLineColors.GetBrightColor
        else Canvas.Pen.Color := ApproachToColorEh(GridLineColors.GetBrightColor, clWindow, 66);
      Canvas.Polyline([Point(CellRect.Left, CellRect.Bottom),
                       Point(CellRect.Right+1, CellRect.Bottom)]);
    end;
    if CellRect.Right < ARect.Right then
    begin
      if (Row = ARow) or (FGridMasterCellHeight div InRowPanelLineHeight <= 1)
        then Canvas.Pen.Color := GridLineColors.GetBrightColor
        else Canvas.Pen.Color := ApproachToColorEh(GridLineColors.GetBrightColor, clWindow, 66);
      Canvas.Polyline([Point(CellRect.Right, CellRect.Top),
                       Point(CellRect.Right, CellRect.Bottom+1)]);
    end;
    Exclude(AState, gdFocused);
    Exclude(AState, gdSelected);
    Exclude(AState, gdHotTrack);
    if IsActiveControl and (ARow = Row) and ((SelectedIndex = i) or (dgRowSelect in Options))  then
      Include(AState, gdFocused);
    if (ARow = Row) and (SelectedIndex = i) then
      Include(AState, gdSelected);
    if (ARow = FHotTrackCell.Y) and (FHotTrackCell.X = i + FIndicatorOffset) then
      Include(AState, gdHotTrack);
    DrawDataCell(ACol, ARow, i, AreaRow, CellRect, AState, CellAreaType);
  end;
end;

procedure TCustomDBGridEh.DrawFooterAsRowPanel(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState;
  CellAreaType: TCellAreaTypeEh);
var
  i: Integer;
  Column: TColumnEh;
  CellRect: TRect;
begin
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ARect);
  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    if not Column.Visible then Continue;
    CellRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
      Column.FRowPlacement.Left + Column.FRowPlacement.Width,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    Inc(CellRect.Left, ARect.Left);
    Inc(CellRect.Right, ARect.Left);
    Inc(CellRect.Top, ARect.Top);
    Inc(CellRect.Bottom, ARect.Top);
    if CellRect.Bottom < ARect.Bottom then
    begin
      Canvas.Pen.Color := GridLineColors.GetBrightColor;
      Canvas.Polyline([Point(CellRect.Left, CellRect.Bottom),
                       Point(CellRect.Right+1, CellRect.Bottom)]);
    end;
    if CellRect.Right < ARect.Right then
    begin
      Canvas.Pen.Color := GridLineColors.GetBrightColor;
      Canvas.Polyline([Point(CellRect.Right, CellRect.Top),
                       Point(CellRect.Right, CellRect.Bottom+1)]);
    end;
    DrawFooterCell(ACol, ARow, i, AreaRow, CellRect, AState, CellAreaType);
  end;
end;

function TCustomDBGridEh.IsSmoothHorzScroll: Boolean;
begin
//  Result := inherited IsSmoothHorzScroll or RowPanel.Active;
  if Assigned(HorzScrollBar)
    then Result := HorzScrollBar.SmoothStep or RowPanel.Active
    else Result := inherited IsSmoothHorzScroll;
end;

function TCustomDBGridEh.IsSmoothVertScroll: Boolean;
begin
  if Assigned(VertScrollBar)
    then Result := VertScrollBar.SmoothStep
    else Result := inherited IsSmoothHorzScroll;
end;

function TCustomDBGridEh.GetOriginCol(): Integer;
begin
  Result := inherited Col;
end;

procedure TCustomDBGridEh.SetOriginCol(const Value: Integer);
begin
  inherited Col := Value;
end;

function TabSort(List: TStringList; Index1, Index2: Integer): Integer;
begin
  if TColumnEh(List.Objects[Index1]).FRowPlacement.Left =
     TColumnEh(List.Objects[Index2]).FRowPlacement.Left
  then
    if TColumnEh(List.Objects[Index1]).FRowPlacement.Top =
       TColumnEh(List.Objects[Index2]).FRowPlacement.Top
      then
        if not TColumnEh(List.Objects[Index1]).Visible and TColumnEh(List.Objects[Index2]).Visible then
          Result := -1
        else if TColumnEh(List.Objects[Index1]).Visible and not TColumnEh(List.Objects[Index2]).Visible then
          Result := 1
        else
          Result := 0
    else if TColumnEh(List.Objects[Index1]).FRowPlacement.Top <
            TColumnEh(List.Objects[Index2]).FRowPlacement.Top
      then
        Result := -1
      else
        Result := 1
   else if TColumnEh(List.Objects[Index1]).FRowPlacement.Left <
           TColumnEh(List.Objects[Index2]).FRowPlacement.Left
      then
        Result := -1
      else
        Result := 1;
end;

procedure TCustomDBGridEh.ResetTabIndexedColumns;
var
  FTabSortList: TStringList;
  i: Integer;
begin
  if not RowPanel.Active then Exit;
  FTabSortList := TStringList.Create;
  for i := 0 to Columns.Count-1 do
    FTabSortList.AddObject('',Columns.Items[i]);

  FTabSortList.CustomSort(TabSort);
  Columns.BeginUpdate;
  for i := 0 to FTabSortList.Count-1 do
    TColumnEh(FTabSortList.Objects[i]).Index := i;
  Columns.EndUpdate;
  FTabSortList.Free;
end;

procedure TCustomDBGridEh.FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
begin
  if RowPanel.Active then
  begin
    MoveColRow(ACol, ARow, MoveAnchor, False, True);
    ClampInViewRowPanelCell(SelectedIndex);
    UpdateEdit;
    Click;
  end else
    inherited FocusCell(ACol, ARow, MoveAnchor);
end;

procedure TCustomDBGridEh.ClampInViewRowPanelCell(DataCol: Integer);
var
  NewGridOffset: Integer;
begin
  if FSmoothPos.X + ClientWidth <
    Columns[DataCol].FRowPlacement.DataCellLeft + Columns[DataCol].FRowPlacement.DataCellWidth
  then
  begin
    NewGridOffset := Columns[DataCol].FRowPlacement.DataCellLeft +
                     Columns[DataCol].FRowPlacement.DataCellWidth -
                     FDataPageSize.cx;
    if dgColLines in Options then Inc(NewGridOffset, GridLineWidth);
    if Columns[DataCol].FRowPlacement.DataCellWidth > FDataPageSize.cx then
      NewGridOffset := Columns[DataCol].FRowPlacement.DataCellLeft;
    SafeSmoothScrollData(NewGridOffset-FSmoothPos.X, 0);
  end;

  if Columns[DataCol].FRowPlacement.DataCellLeft < FSmoothPos.X
  then
  begin
    NewGridOffset := Columns[DataCol].FRowPlacement.DataCellLeft;
    SafeSmoothScrollData(NewGridOffset-FSmoothPos.X, 0);
  end;

end;

procedure TCustomDBGridEh.SetColInRowPanel(DataCol: Integer);
begin
  if FInRowPanelCol <> DataCol then
  begin
    ClampInViewRowPanelCell(DataCol);
    FInRowPanelCol := DataCol;
    UpdateEdit;
    GridInvalidateRow(Self, Row);
  end;
end;

function TCustomDBGridEh.GetColumnInRowPanelAtPos(InCellPos: TPoint; IsTitleTypeCell: Boolean): TColumnEh;
var
  i: Integer;
  Column: TColumnEh;
  ACellRect: TRect;
begin
  Result := nil;
  if Self.UseRightToLeftAlignment then
    InCellPos.X := FGridMasterCellWidth - InCellPos.X;
  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    if IsTitleTypeCell then
      ACellRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
      Column.FRowPlacement.Left + Column.FRowPlacement.Width,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height)
    else
      ACellRect := Rect(Column.FRowPlacement.DataCellLeft, Column.FRowPlacement.Top,
      Column.FRowPlacement.DataCellLeft + Column.FRowPlacement.DataCellWidth,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    if dgColLines in Options then Inc(ACellRect.Right, GridLineWidth);
    if dgRowLines in Options then Inc(ACellRect.Bottom, GridLineWidth);

    if PointInRect(InCellPos, ACellRect) then
    begin
      Result := Column;
      Exit;
    end;
  end;
end;

function TCustomDBGridEh.GetCellRectInRowPanelAtPos(InCellPos: TPoint;
  var ACellRect: TRect; IncludeLines: Boolean): TColumnEh;
var
  i: Integer;
  Column: TColumnEh;
begin
  Result := nil;
  ACellRect := EmptyRect;
  for i := 0 to Columns.Count-1 do
  begin
    Column := Columns[i];
    ACellRect := Rect(Column.FRowPlacement.Left, Column.FRowPlacement.Top,
      Column.FRowPlacement.Left + Column.FRowPlacement.Width,
      Column.FRowPlacement.Top + Column.FRowPlacement.Height);
    if IncludeLines then
    begin
      if dgColLines in Options then Inc(ACellRect.Right, GridLineWidth);
      if dgRowLines in Options then Inc(ACellRect.Bottom, GridLineWidth);
    end;
    
    if PointInRect(InCellPos, ACellRect) then
    begin
      Result := Column;
      Exit;
    end;
  end;
end;

function TCustomDBGridEh.EffectiveGridOptions: TGridOptions;
begin
  Result := Result + inherited Options;
  if csDesigning in ComponentState then
  begin
    Result := [goColSizing];
    if (FColumns.State = csCustomized) then
    begin
      Result := Result + [goColMoving];
      if RowPanel.Active then
        Result := Result + [goRowSizing];
    end;
  end;
end;

procedure TCustomDBGridEh.SetRowDetailPanel(const Value: TRowDetailPanelEh);
begin
  FRowDetailPanel.Assign(Value);
end;

function TCustomDBGridEh.DrawDetailPanelSign(DataCol, DataRow: Integer;
  AState: TGridDrawState; ARect: TRect; Draw3DRect: Boolean): Integer;
var
  Multiselected: Boolean;
  AColor, OldColor: TColor;
  ARect1: TRect;
  TreeElement: TTreeElementEh;
begin
  Result := 0;
  if RowDetailPanel.Active then
  begin
    AColor := Color;
    Multiselected := DataCellSelected(DataCol, Datalink.Datasource.Dataset.Bookmark);
    if Multiselected and Assigned(Style) then
      Style.HighlightDataCellColor(Self, DataCol + IndicatorOffset, DataRow + TopDataOffset,
        DataCol, DataRow, '', AState, Multiselected, AColor, Canvas.Font);
    OldColor := Canvas.Brush.Color;
    Canvas.Brush.Color := AColor;

    ARect1 := ARect;
    ARect1.Right := ARect1.Left + 18;
    Result := 18;
    Canvas.FillRect(ARect1);
    if RowDetailPanel.Visible and (DataRow = Row - TopDataOffset)
      then TreeElement := tehMinus
      else TreeElement := tehPlus;

    DrawTreeElement(Canvas, ARect1, TreeElement,
      (FStdDefaultRowHeight mod 2 = 1) and (TopRow mod 2 = 1), 1, 1, UseRightToLeftAlignment);

//    DrawTreeArea(Canvas, ARect1, True);
    Canvas.Brush.Color := OldColor;
  end;
end;

procedure TCustomDBGridEh.UpdateRowDetailPanel;
var
  ARect: TRect;
  DrawInfo: TGridDrawInfoEh;
  NewLeft: Integer;
begin
  if not HandleAllocated then Exit;
  if FrozenCols > 0
    then ARect := CellRect(IndicatorOffset, Row)
    else ARect := CellRect(LeftCol, Row);
  ARect.Bottom := ARect.Top + CalcRowDataRowHeight(Row-TopDataOffset);
  if RowDetailPanel.Active and (RowDetailPanel.Visible or (csDesigning in ComponentState)) then
  begin
    if (TopRow > Row) or (TopRow + VisibleRowCount < Row) then
      FRowDetailControl.Visible := False
    else
    begin
      CalcDrawInfo(DrawInfo);
      FRowDetailControl.Top := ARect.Bottom;// + 1;
      if Self.UseRightToLeftAlignment
        then NewLeft := ClientWidth - ARect.Right + 18 + GetCellTreeElmentsAreaWidth + FExtraFirstColumnWidth
        else NewLeft := ARect.Left + 18 + GetCellTreeElmentsAreaWidth + FExtraFirstColumnWidth;
      if (RowDetailPanel.Width = 0) or (RowDetailPanel.Width > ClientWidth - NewLeft) then
        if RowDetailPanel.Width = 0
          then FRowDetailControl.Width := DrawInfo.Horz.FullGridBoundary - NewLeft - GridLineWidth
          else FRowDetailControl.Width := ClientWidth - NewLeft
      else
        FRowDetailControl.Width := RowDetailPanel.Width;

      if Self.UseRightToLeftAlignment
        then FRowDetailControl.Left := ClientWidth - (NewLeft + FRowDetailControl.Width)
        else FRowDetailControl.Left := NewLeft;

      if (RowDetailPanel.Height = 0) or (RowDetailPanel.Height > ClientHeight - FRowDetailControl.Top)
        then FRowDetailControl.Height := ClientHeight - FRowDetailControl.Top
        else FRowDetailControl.Height := RowDetailPanel.Height;
      FRowDetailControl.Visible := True;
{$IFDEF CIL}
{$ELSE}
      FRowDetailControl.BevelEdges := RowDetailPanel.BevelEdges;
      FRowDetailControl.BevelInner := RowDetailPanel.BevelInner;
      FRowDetailControl.BevelOuter := RowDetailPanel.BevelOuter;
      FRowDetailControl.BevelKind := RowDetailPanel.BevelKind;
      FRowDetailControl.BevelWidth := RowDetailPanel.BevelWidth;
      FRowDetailControl.BorderStyle := RowDetailPanel.BorderStyle;
      FRowDetailControl.Color := RowDetailPanel.Color;
      FRowDetailControl.ParentColor := RowDetailPanel.ParentColor;
{$ENDIF}

//      ClampInView()
    end;
  end else
    FRowDetailControl.Visible := False;

  if (csDesigning in ComponentState) and not RowDetailPanel.Active then
    FRowDetailControl.SetBounds(0,0,0,0);
  UpdateDataRowHeight(Row-TopDataOffset);
end;

function TCustomDBGridEh.CheckMouseDownInRowDetailSign(Button: TMouseButton;
  Shift: TShiftState; MouseX, MouseY: Integer): Boolean;
var
  Cell: TGridCoord;
  ARect: TRect;
  Column: TColumnEh;
begin
  Result := False;
  Cell := MouseCoord(MouseX, MouseY);
  ARect := CellRect(Cell.X, Cell.Y);
  if (Cell.Y >= TopDataOffset) and (Cell.X >= IndicatorOffset) then
  begin
    Column := Columns[RawToDataColumn(Cell.X)];
    if CheckDataCellMouseDownInRowDetailSign(Button, Shift, MouseX, MouseY,
        Cell, Column, ARect, MouseX-ARect.Left, MouseY-ARect.Top) then
//    if (ARect.Left <= MouseX ) and (MouseX < ARect.Left + TreeAreaWidth) then
    begin
      Result := True;
//      RowDetailPanel.Visible := not RowDetailPanel.Visible;
    end;
  end;
end;

function TCustomDBGridEh.CheckDataCellMouseDownInRowDetailSign(
  Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer; Cell: TGridCoord; Column: TColumnEh;
  ACellRect: TRect; InCellX, InCellY: Integer): Boolean;
var
  TreeAreaWidth, TreeViewWidth: Integer;
  RowDetailPanelAvailable: Boolean;
begin
  TreeAreaWidth := 18;
  TreeViewWidth := GetCellTreeElmentsAreaWidth;
  if not RowPanel.Active then
    TreeViewWidth := TreeViewWidth + FExtraFirstColumnWidth;
  Result := False;
  RowDetailPanelAvailable := RowDetailPanel.Active;
  if Assigned(OnCheckRowHaveDetailPanel) then
    OnCheckRowHaveDetailPanel(Self, RowDetailPanelAvailable);
  if not RowDetailPanelAvailable then Exit;
  if Column <> VisibleColumns[0] then
    Exit;

  if Column.UseRightToLeftAlignment then
    InCellX := (ACellRect.Right - ACellRect.Left) - InCellX;
  if (InCellX >= TreeViewWidth ) and (InCellX < TreeAreaWidth + TreeViewWidth) then
      Result := True;
end;

function TCustomDBGridEh.CellEditRect(ACol, ARow: Longint): TRect;
var
  NewHeight: Integer;
begin
  Result := inherited CellEditRect(ACol, ARow);
  if DataGrouping.IsGroupingWorks and (ACol = DataToRawColumn(VisibleColumns[0].Index)) then
  begin
    Result.Left := Result.Left + FExtraFirstColumnWidth;
  end;
  if RowDetailPanel.Active and (ACol = FIndicatorOffset) then
    if Result.Left + 18 < Result.Right then
      Result.Left := Result.Left + 18;
  if RowDetailPanel.Visible and (Row = ARow) then
  begin
    NewHeight := CalcRowDataRowHeight(ARow-TopDataOffset);
    if Result.Bottom - Result.Top > NewHeight then
    begin
      Result.Bottom := Result.Top + NewHeight;
    end;
  end;
end;

function TCustomDBGridEh.MoveBy(Distance: Integer): Integer;
begin
  Result := 0;
  if RowDetailPanel.Visible and FDataLink.Active then
    RowDetailPanel.Visible := False;
  if not RowDetailPanel.Visible then
    if FDataGrouping.IsGroupingWorks
      then Result := DataGroupsMoveBy(Distance)
      else Result := FDataLink.MoveBy(Distance);
end;

function TCustomDBGridEh.CheckTitleCellFilterButtonPos(MousePos: TPoint;
  CellRect: TRect; Column: TColumnEh; var StateRect: TRect): Boolean;
var
  FilterButtonWidth: Integer;
begin
  Result := False;
  if Flat then
  begin
    FilterButtonWidth := FlatButtonWidth;
    if not ThemesEnabled then
      Inc(FilterButtonWidth);
  end else
    FilterButtonWidth := GetSystemMetrics(SM_CXVSCROLL);

  if dghFixed3D in OptionsEh then
    InflateRect(CellRect, -1, -1);

  if (CellRect.Right - CellRect.Left) div 2 < FilterButtonWidth then
    FilterButtonWidth := (CellRect.Right - CellRect.Left) div 2;

  StateRect := CellRect;
  StateRect.Right := CellRect.Right;
  StateRect.Left := StateRect.Right - FilterButtonWidth;
  if StateRect.Bottom - StateRect.Top > FInplaceEditorButtonHeight then
  begin
    StateRect.Top := (StateRect.Bottom + StateRect.Top -
      FInplaceEditorButtonHeight) div 2;
    StateRect.Bottom := StateRect.Top + FInplaceEditorButtonHeight;
  end;

  if PtInRect(StateRect, MousePos) then
    Result := True;
end;

function TCustomDBGridEh.GetMouseHitCellState(Cell: TGridCoord; MousePos: TPoint;
  CellRect: TRect; Column: TColumnEh; var StateRect: TRect): TDBGridEhState;
var
  BaseCellRect: TRect;
begin
  Result := dgsNormal;
  if (dgTitles in Options) and (Cell.Y = 0) and (Cell.X >= FIndicatorOffset) and
    STFilter.Visible and (STFilter.Location = stflInTitleFilterEh) then
  begin
    if IsUseMultiTitle then
      CellRect := Rect(CellRect.Left,
                       CellRect.Bottom - FLeafFieldArr[Cell.X - IndicatorOffset].FLeaf.Height,
                       CellRect.Right,
                       CellRect.Bottom)
    else if RowPanel.Active then
    begin
      BaseCellRect := CellRect;
      Column := GetCellRectInRowPanelAtPos(
        Point(MousePos.X-CellRect.Left,MousePos.Y-CellRect.Top),
        CellRect, False);
      OffsetRect(CellRect, BaseCellRect.Left, BaseCellRect.Top);
      if Column = nil then Exit;
    end;

    if CheckTitleCellFilterButtonPos(MousePos,  CellRect, Column, StateRect)
    then
      Result := dgsTitleFilterButtonDown;
  end;
end;

{ TDBGridEhDataGroupLevelEh }

function TDBGridEhDataGroupLevelEh.GetColumn: TColumnEh;
begin
  Result := TColumnEh(inherited Column);
end;

function TDBGridEhDataGroupLevelEh.GetColumnName: String;
begin
  Result := '';
  if Column <> nil then
    Result := Column.Name;
end;

procedure TDBGridEhDataGroupLevelEh.SetColumnName(const Value: String);
var
  Grid: TCustomDBGridEh;
begin
  Grid := TCustomDBGridEh(TGridDataGroupLevelsEh(Collection).Grid);
  if csLoading in Grid.ComponentState
    then FLoadingColumnName := Value
    else Column := TCustomDBGridEh(TGridDataGroupLevelsEh(Collection).Grid).Columns.FindColumnByName(Value);
end;

procedure TDBGridEhDataGroupLevelEh.SetColumn(const Value: TColumnEh);
begin
  inherited Column := Value;
end;

function TDBGridEhDataGroupLevelEh.GetKeyValue: Variant;
begin
  Result := inherited GetKeyValue;
  if Assigned(Column) and Assigned(Column.OnGroupGetKeyValue) then
    Column.OnGroupGetKeyValue(Column.Grid, Column, Result);
  if Assigned(OnGetKeyValue) and Assigned(Column) then
    OnGetKeyValue(Column.Grid, Self, Result);
end;

function TDBGridEhDataGroupLevelEh.GetKeyValueAsText(GroupDataTreeNode: TGroupDataTreeNodeEh): String;
begin
  Result := VarToStr(GroupDataTreeNode.KeyValue);
  if Assigned(Column) and Assigned(Column.OnGroupGetKeyValueAsText) then
    Column.OnGroupGetKeyValueAsText(Column.Grid, GroupDataTreeNode, GroupDataTreeNode.KeyValue, Result);
  if Assigned(OnGetKeyValueAsText) and Assigned(Column) then
    OnGetKeyValueAsText(Column.Grid, GroupDataTreeNode, GroupDataTreeNode.KeyValue, Result);
end;

function TDBGridEhDataGroupLevelEh.GetGroupRowText(GroupDataTreeNode: TGroupDataTreeNodeEh): String;
begin
  if Assigned(GroupDataTreeNode.DataGroup.Column) then
    Result := TColumnEh(GroupDataTreeNode.DataGroup.Column).Title.Caption + ': ';
  Result := Result + GetKeyValueAsText(GroupDataTreeNode);
  Result := Result + ' ('+IntToStr(GroupDataTreeNode.Count)+')';
  if Assigned(Column) and Assigned(Column.Grid.OnDataGroupGetRowText) then
    Column.Grid.OnDataGroupGetRowText(Column.Grid, GroupDataTreeNode, Result);
  if Assigned(OnGetGroupRowText) and Assigned(Column) then
    OnGetGroupRowText(Column.Grid, GroupDataTreeNode, Result);
end;

procedure TDBGridEhDataGroupLevelEh.DrawFormatChanged;
begin
  if (Column <> nil) and (Column.Grid <> nil) then
  begin
    Column.Grid.Invalidate;
    Column.Grid.UpdateAllDataRowHeights;
  end;
end;

{ TDBGridEhDataGroupsEh }

procedure TDBGridEhDataGroupsEh.ActiveChanged;
begin
  if Active and
        (csDesigning in Grid.ComponentState) and
    not (csLoading in Grid.ComponentState) and
        Grid.FDataLink.Active and
    not Grid.MemTableSupport
  then
    ShowMessage('DataSet doesn''t support IMemTableEh interface. Groupoing won''t work.');
  Grid.LinkActive(TCustomDBGridEh(GetOwner).DataLink.Active);
  Grid.GroupPanelVisibleChanged;
  if Assigned(Grid.OnActiveGroupingStructChanged) then
    Grid.OnActiveGroupingStructChanged(Grid);
end;

procedure TDBGridEhDataGroupsEh.ActiveGroupingStructChanged;
begin
  TCustomDBGridEh(GetOwner).MTViewDataEvent(-1, mtViewDataChangedEh, -1);
  TCustomDBGridEh(GetOwner).GroupPanelVisibleChanged;
  if Assigned(Grid.OnActiveGroupingStructChanged) then
    Grid.OnActiveGroupingStructChanged(Grid);
end;

constructor TDBGridEhDataGroupsEh.Create(AGrid: TCustomDBGridEh);
begin
  inherited Create(AGrid);
  FHotTrackGroupLevelIdx := -1;
  FHotTrackEditButton := -1;
end;

function TDBGridEhDataGroupsEh.CreateGroupLevels: TGridDataGroupLevelsEh;
begin
  Result := TGridDataGroupLevelsEh.Create(Self, TDBGridEhDataGroupLevelEh);
end;

procedure TDBGridEhDataGroupsEh.ResetGroupLevelNames;
var
  i: Integer;
begin
  for i := 0 to GroupLevels.Count-1 do
  begin
    TDBGridEhDataGroupLevelEh(GroupLevels[i]).ColumnName := TDBGridEhDataGroupLevelEh(GroupLevels[i]).FLoadingColumnName;
  end;
end;

function TDBGridEhDataGroupsEh.IsGroupingWorks: Boolean;
begin
  Result := Active and
            TCustomDBGridEh(GetOwner).MemTableSupport and
            TCustomDBGridEh(GetOwner).FDataLink.Active and
            (ActiveGroupLevelsCount > 0);
end;

procedure TDBGridEhDataGroupsEh.RebuildActiveGroupLevels;
begin
  inherited RebuildActiveGroupLevels;
  FHotTrackGroupLevelIdx := -1;
  FHotTrackEditButton := -1;
  if Grid.FDataLink.Active then
    Grid.DoSortMarkingChanged;
end;

procedure TDBGridEhDataGroupsEh.ResortActiveLevel(LevelIndex: Integer;
  SortOrder: TSortOrderEh);
begin
  inherited ResortActiveLevel(LevelIndex, SortOrder);
  if Grid.FDataLink.Active then
    Grid.DoSortMarkingChanged;
end;

function TDBGridEhDataGroupsEh.GetGrid: TCustomDBGridEh;
begin
  Result := TCustomDBGridEh(GetOwner);
end;

procedure TDBGridEhDataGroupsEh.DrawFormatChanged;
begin
  Grid.Invalidate;
  Grid.UpdateAllDataRowHeights;
end;

initialization

  RegisterReadPropertyInterceptor(TColumnEh, TColumnEhPropertyInterceptor);
  RegisterReadPropertyInterceptor(TDBGridColumnsEh, TColumnsEhPropertyInterceptor);

  FDBGridEhDefaultStyle := TDBGridEhStyle.Create;
  FDBGridEhCenter := TDBGridEhCenter.Create;

  SortMarkerFont := TFont.Create;
  Bmp := TBitmap.Create;
  try
    BitmapLoadFromResourceName(Bmp, HInstance, bmSmDown);
    SortMarkerFont.Height := -Bmp.Height + 1;
    SortMarkerFont.Name := 'Arial';
  finally
    Bmp.Free;
  end;

  hcrDownCurEh := LoadCursor(hInstance, 'DOWNCUREH');
  if hcrDownCurEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');

  hcrRightCurEh := LoadCursor(hInstance, 'RIGHTCUREH');
  if hcrRightCurEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');

  hcrLeftCurEh := LoadCursor(hInstance, 'LEFTCUREH');
  if hcrLeftCurEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');

  DBGridEhInplaceSearchKey := ShortCut(Word('F'), [ssCtrl]);
  DBGridEhInplaceSearchNextKey := ShortCut(VK_RETURN, [ssCtrl]);
  DBGridEhInplaceSearchPriorKey := ShortCut(VK_RETURN, [ssCtrl, ssShift]);
  DBGridEhSetValueFromPrevRecordKey := ShortCut(Word(222), [ssCtrl]); //'single-quote/double-quote'
  DBGridEhFindDialogKey := ShortCut(Word('F'), [ssCtrl]);
  DBGridEhShowInTitleFilterBox := ShortCut(Word('T'), [ssCtrl]);

  DBGridEhInplaceSearchTimeOut := 1500; // 1.5 sec
  DBGridEhInplaceSearchColor := clYellow;
  DBGridEhInplaceSearchTextColor := clBlack;

  CreateIndicators;

  VarColCellParamsEh := TColCellParamsEh.Create;

  DBGridEhDebugDraw := False;

  RegisterClass(TRowDetailPanelControlEh);
  PopupListboxItemEhLine := TPopupListboxItemEhLine.Create;
  PopupListboxItemEhSortAsc := TPopupListboxItemEhSort.Create(smDownEh);
  PopupListboxItemEhSortDes := TPopupListboxItemEhSort.Create(smUpEh);

  PopupListboxItemEhClearFilter := TPopupListboxItemEhSpec.Create(ptFilterSpecItemClearFilter);
  PopupListboxItemEhAll := TPopupListboxItemEhSpec.Create(ptFilterSpecItemAll);
  PopupListboxItemEhEmpties  := TPopupListboxItemEhSpec.Create(ptFilterSpecItemEmpties);
  PopupListboxItemEhNotEmties  := TPopupListboxItemEhSpec.Create(ptFilterSpecItemNotEmties);
  PopupListboxItemEhDialog := TPopupListboxItemEhSpec.Create(ptFilterSpecItemDialog);
  PopupListboxItemEhApplyFilter := TPopupListboxItemEhSpec.Create(ptFilterApply);

  PopupListboxItemEhData := TPopupListboxItemEhData.Create;


{ crDownCurEh := DefineCursor('DOWNCUREH');
 crRightCurEh := DefineCursor('RIGHTCUREH');}
// SystemParametersInfo(SPI_GETKEYBOARDDELAY,0,@InitRepeatPause,0);
// SystemParametersInfo(SPI_GETKEYBOARDSPEED,0,@RepeatPause,0);
finalization
  //For memleak tools
  DestroyCursor(hcrDownCurEh);
  DestroyCursor(hcrRightCurEh);
  DestroyCursor(hcrLeftCurEh);

  FreeAndNil(DBGridEhIndicators);
  FreeAndNil(DBGridEhSortMarkerImages);
  FreeAndNil(SortMarkerFont);

  FreeAndNil(FDBGridEhDefaultStyle);
  FreeAndNil(FDBGridEhCenter);
  FreeAndNil(VarColCellParamsEh);

  FreeAndNil(DBGridEhVisibleColumnsIndicatorMenuItem);
  FreeAndNil(DBGridEhCutIndicatorMenuItem);
  FreeAndNil(DBGridEhCopyIndicatorMenuItem);
  FreeAndNil(DBGridEhPasteIndicatorMenuItem);
  FreeAndNil(DBGridEhDeleteIndicatorMenuItem);
  FreeAndNil(DBGridEhSelectAllIndicatorMenuItem);
  FreeAndNil(DBGridEhIndicatorTitlePopupMenu);
  FreeAndNil(InplaceBitmap);

  FreeAndNil(PopupListboxItemEhLine);
  FreeAndNil(PopupListboxItemEhSortAsc);
  FreeAndNil(PopupListboxItemEhSortDes);
  FreeAndNil(PopupListboxItemEhClearFilter);
  FreeAndNil(PopupListboxItemEhAll);
  FreeAndNil(PopupListboxItemEhEmpties);
  FreeAndNil(PopupListboxItemEhNotEmties);
  FreeAndNil(PopupListboxItemEhDialog);
  FreeAndNil(PopupListboxItemEhApplyFilter);
  FreeAndNil(PopupListboxItemEhData);
end.
