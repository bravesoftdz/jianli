unit NvDbgridEh;

{
  ExpType: TExpType  导出文件类型;
  ExpOpenType:TOpenType read  导出文件后是否打开
  ShowLineNo :boolean  是否显示行号
  SetIndicatorWidth: integer 显示行号区域的宽度
  AutoSetMultiSelect: Boolean 是否自动设置多行选择
  AutoSetCtrlKey:boolean   没什么用的
  AutoFocusKey:boolean 是否自动聚焦到输入行.(可以按数字键到行)
  PrintInfo:TPrintInfo 打印配置信息
  PrintOptions: 打印选项
  //pghOptimalColWidths 最佳宽度
  //pghColored 使用标题颜色
  //pghFitGridToPageWidth 调整宽度，默认为缩放整张表
  //pghFitingByColWidths  调整宽度
  PrintAutoNewLine :Boolean //是否自动换行
  DBConnect :TADOConnection 数据库连接
  AutoGridAdject :Boolean 是否自动调整列宽度，位置
  AutoGridSave   :boolean read 是否自动保存列宽度，位置
  AutoAPPPopuMenu  :boolean 是否自动弹出右键菜单
  GridUser  :Integer 当前表格用户
  ParentName :string 当前父类名字
  PaperSize :TPaperSize 纸张类型 Default;
  // = (poPortrait, poLandscape) 纸张方向
  PrinterOrientation:TPrinterOrientation  default poPortrait;
  PageWidth:extended 纸纸宽度;
  PageHeight:extended 高度 ;

  PrintOptions

  //标题文字  Title : string r
  //标题字体  TitleFont:Tfont          2008-11-26 修正
  //表头字体  GridHeadFont :TFont;     2008-11-26
  //是否在下方划线  TitleUpLine:boolean
  //标题后空几行 TitleNullLine:integer
  //在表格上方的文字 比如统计机构 GridTop:string
  //是否打印页脚 第 n 页 - 共 n 页 PrintPageFooter:boolean
  //是否在页脚打印日期PrintPrintFooterTime:boolean
  //是否打印 "公司报表字样" PageFooterRight:String
  //报表左上方打印字样PageTopLeft:string
  //报表右上方打印字样PageTopRight:string
  //报表打印人PrintName:string
  //打印页面参数PageSize :TPageParams

}
{ ************************************************************************
  功能说明 :对DgridEh进行一些功能整合及扩展
  整合打印，导出，列调整。
  扩展打印功能，添加表头字体和标题字体功能
  扩展调定打印纸张功能；A4 A3 自定义
  导出功能中Excel的多表头(修改在DbgridEh中导出部份)


  Auth:
  Date:
  ***********************************************************************
  Change History
  ***********************************************************************
  Date : Author: Description:
  -----------------------------------------------------------------------

  ********************************************************************** }

interface

uses
  Windows, Messages, DBClient, jsonClientDataSet, SysUtils, Classes, Graphics,
  Controls, StdCtrls, GridsEh, DBGrids, DBGridEh,Excel2000,
  ExtCtrls, PrViewEh, PrnDbgeh, DBGridEhImpExp, Dialogs, db,
  jsonConnection, NvPrnDbgeh, comobj, Variants,ComCtrls,
  forms, CheckLst, Buttons, shellapi, Menus, Printers, PrntsEh;

{
  &[Page]', '&[ShortDate]', '&[Date]',
  '&[LongDate]', '&[Time]', '&[Pages]'
  }
type
  TCrackNvDbgridEh = class(TdbgridEh);
  TCrackWinControl = class(TWinControl);
    TPrintColumn = Class(Tobject)ColumnName: string;
    ColumnIdx: integer;
    IsPrint: Boolean;
  end;

  TColumninfo = record
    isactive: boolean;
    width, field_index: integer;
    FieldName: string;
    Caption: string;
    footer_Value:String;
    footer_Valuetype:TFooterValueType;
    ISAppend:Boolean;
  end;

  TColumnArr = Record
    FColumnEh: TColumnEh;
    ISAppend: Boolean;
  end;

  /// /////////////////////////////////////////////
  TGridAdjust = Class(Tobject)
  private
    SourceDBGrid: TDBGrid;
    SourceDBGrid1: TDBGridEH;
    form: Tform;
    checklistbox: Tchecklistbox;
    FDBConnect: TjsonConnection;
    procedure CheckListBoxKeyDown(Sender: Tobject; var Key: Word;
      Shift: TShiftState);
    procedure CheckListBoxPress(Sender: Tobject; var Key: Char);
    procedure CheckListBoxDragOver(Sender, Source: Tobject; X, Y: integer;
      State: TDragState; var Accept: Boolean);
    procedure CheckListBoxDragDrop(Sender, Source: Tobject; X, Y: integer);
    procedure CheckListBoxMouseDown(Sender: Tobject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure myFormDeactivate(Sender: Tobject);
    procedure SetDBConnect(const Value: TjsonConnection);
  public
    // 栏目调整函数
    procedure GridAdjust(Sender: Tobject; DBGrid: Tobject);
    // DBGRID显示方式保存函数
    procedure SaveToTable(jcsdSave: TJsonClientDataSet;
      userid, width, field_index: integer; FROMNAME, FieldName: string;
      visible: Boolean);
    procedure GridLoad2(Columns: TDBGridColumnsEh; User_id: integer;
      Grid_name: string);
    property DBConnect: TjsonConnection read FDBConnect write SetDBConnect;

  end;

  /// ////////////////////////////////////////////////////////////////
type
  TExpType = (ExpCSV, ExpHTML, ExpRTF, ExpText, ExpXLS);
  TTitleAlign = (taLeftJustify, taRightJustify, taCenter, taNone);
  TPaperSize = (Default, A3, A4, Custom);

  // TPrinterOrientation = (poPortrait, poLandscape);
  // TPrinterOrientation = (poPortrait, poLandscape);
const
  PaperSizeMetrics: array [Default .. Custom, 0 .. 1] of extended = ((0, 0),
    { Default }
    (297.0, 420.0), { A3 DMPAPER_A3_ROTATED }
    (210.0, 297.0), { A4 }
    (100.0, 100.0) { Custom }
  );

type
  TOpenType = (AutoOpen, None, UserChoice);

type
  TPrintInfo = class(TPersistent)
  private

    FControl: TComponent;
    FTitle: String;
    FTitleFont: Tfont;
    FTitleUpLine: Boolean;
    FTitleNullLine: integer;
    FGridTop: string;
    FPrintPageFooter: Boolean;
    FPrintPrintFooterTime: Boolean;
    FPageFooterRight: String;
    FPageTopRight: string;
    FPageTopLeft: string;
    FTitleList: Tstrings;
    FPrintName: string;
    FPageSize: TPageParams;
    FPaperSize: TPaperSize;
    FPrinterOrientation: TPrinterOrientation;
    FPageHeight: extended;
    FPageWidth: extended;
    FGridHeadFont: Tfont;

    procedure SetTitle(const Value: String);
    procedure SetTitleFont(const Value: Tfont);
    procedure SetTitleUpLine(const Value: Boolean);
    procedure SetTitleNullLine(const Value: integer);
    procedure SetGridTop(const Value: string);
    procedure SetPrintPageFooter(const Value: Boolean);
    procedure SetPrintPrintFooterTime(const Value: Boolean);
    procedure SetPageFooterRight(const Value: String);
    procedure SetPageTopLeft(const Value: string);
    procedure SetPageTopRight(const Value: string);
    Function GPageFooterRight: string;
    procedure SetPrintName(const Value: string);
    procedure TitleFontChanged(Sender: Tobject);
    procedure SetPageSize(const Value: TPageParams);
    procedure SetPaperSize(const Value: TPaperSize);
    procedure SetPrinterOrientation(const Value: TPrinterOrientation);
    procedure SetPageHeight(const Value: extended);
    procedure SetPageWidth(const Value: extended);
    procedure SetGridHeadFont(const Value: Tfont);
  public
    constructor Create(AOwner: TComponent); overload; // virtual;
    destructor Destroy; override;
    function GetTitle: Tstrings;
    Function GetPageWidth: integer;
    Function GetPageHeight: integer;
  published
    // 标题文字
    // Property TitleList :Tstrings read GetTitle write SetTitleList;
    property Title: string read FTitle write SetTitle;
    // 标题字体
    ProperTy TitleFont: Tfont read FTitleFont write SetTitleFont;
    // 表头字体
    ProperTy GridHeadFont: Tfont read FGridHeadFont write SetGridHeadFont;
    // 是否在下方划线
    Property TitleUpLine
      : Boolean read FTitleUpLine write SetTitleUpLine default True;
    // 标题后空几行
    Property TitleNullLine
      : integer read FTitleNullLine write
      SetTitleNullLine default 3;
    // 在表格上方的文字 比如统计机构 //己经不用，被 PageTopRight 和 PageTopLeft替代
    Property GridTop: string read FGridTop write SetGridTop;
    // 是否打印页脚 第 n 页 - 共 n 页
    Property PrintPageFooter: Boolean read FPrintPageFooter write
      SetPrintPageFooter;
    // 是否在页脚打印日期
    Property PrintPrintFooterTime: Boolean read FPrintPrintFooterTime write
      SetPrintPrintFooterTime;
    // 是否打印 "南凌科技"
    Property PageFooterRight
      : String read GPageFooterRight write SetPageFooterRight;
    // 报表左上方打印字样
    Property PageTopLeft: string read FPageTopLeft write SetPageTopLeft;
    // 报表右上方打印字样
    Property PageTopRight: string read FPageTopRight write SetPageTopRight;
    // 报表打印人
    Property PrintName: string read FPrintName write SetPrintName;
    // 打印页面参数
    property PageSize: TPageParams read FPageSize write SetPageSize;
    // = (Default,A3,A4,Custom);
    property PaperSize
      : TPaperSize read FPaperSize write SetPaperSize default Default;
    // = (poPortrait, poLandscape) 纸张方向
    Property PrinterOrientation
      : TPrinterOrientation read FPrinterOrientation write
      SetPrinterOrientation default poPortrait;
    property PageWidth: extended read FPageWidth write SetPageWidth;
    Property PageHeight: extended read FPageHeight write SetPageHeight;

  end;

type
  TNvDbgridEh = class(TDBGridEH)
    PrintDBGridEh: TNvPrintDBGridEh; // TPrintDBGridEh
    // DBGridEhExport: TDBGridEhExport;
    SaveDialog: TSaveDialog;
    Timer: TTimer;
    TimerMenu: TTimer;
  private
    jsoncsdSave: TJsonClientDataSet;
    FExpType: TExpType;
    FShowLineNo: Boolean;
    FsetIndicatorWidth: integer;
    GotoLineNo: integer;
    FAutoSetMultiSelect: Boolean;
    FAutoSetCtrlKey: Boolean;
    FAutoFocusKey: Boolean;
    FAutoFocusKeyInterval:Cardinal;
    FPrintInfo: TPrintInfo;
    FPrintColumn: Tstrings;
    FExpOpenType: TOpenType;
    FOptions: TPrintDBGridEhOptions;
    FPrintAutoNewLine: Boolean;
    GridAdjust: TGridAdjust;
    FJSONConnection: TjsonConnection;
    FAutoGridSave: Boolean;
    FAutoGridAdject: Boolean;
    FParentName: string;
    FGridUser: integer;
    FAutoAPPPopuMenu: Boolean;
    FFIsMenuIni: Boolean;
    FOnMenuPopup: TNotifyEvent;
    FTitleAlign: TTitleAlign;
    popumenuCreatebyself: Boolean;
    procedure SetExpType(const Value: TExpType);
    procedure SortDBGridEh(Sender: Tobject; ACol: integer; Column: TColumnEh);
    procedure SetsetIndicatorWidth(const Value: integer);
    procedure SetShowLineNo(const Value: Boolean);
    Procedure TimerTimer(Sender: Tobject);
    Procedure TimerTimerMenu(Sender: Tobject);
    Function CanUse: Boolean;
    procedure SetAutoSetMultiSelect(const Value: Boolean);
    procedure SetAutoSetCtrlKey(const Value: Boolean);
    procedure SetAutoFocusKey(const Value: Boolean);
    procedure SetAutoFocusKeyInterval(Const value:Cardinal);
    procedure SetPrintInfo(const Value: TPrintInfo);
    Procedure InitPrintInfo;
    Procedure PrintUseColumnSet;
    Procedure BackColumnSet;
    procedure SetExpOpenType(const Value: TOpenType);
    procedure SetOptions(const Value: TPrintDBGridEhOptions);
    procedure SetPrintAutoNewLine(const Value: Boolean);
    procedure SetJSONConnection(const Value: TjsonConnection);
    procedure SetAutoGridAdject(const Value: Boolean);
    procedure SetAutoGridSave(const Value: Boolean);
    procedure SetParentName(const Value: string);
    Procedure ExpGrid(Sender: Tobject);
    procedure PrintGrid(Sender: Tobject);
    procedure SetGridadjuct(Sender: Tobject);
    procedure SetGridUser(const Value: integer);
    procedure SetAutoAPPPopuMenu(const Value: Boolean);
    procedure toexcel(dbgrideh1: TDBGridEH; xlsFilename: string);
    procedure GridAdjectLoad;
    procedure SetFIsMenuIni(const Value: Boolean);
    Procedure OnMenuPopup(Sender: Tobject);
    procedure SetTitleAlign(const Value: TTitleAlign);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure Print;
    Procedure PrintPreview;
    procedure ApplySettings_xy(Printer: TPrinter; X, Y: integer);
    Procedure PrintColumnSet;
    Procedure ExpDbgrid;
    procedure GridSave;
    Procedure GridAdject;
    procedure setPrintPaper;

  protected
    // procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
    // Column: TColumnEh; State: TGridDrawState); override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: integer;
      Column: TColumnEh; State: TGridDrawState); virtual;
    Procedure DoTitleClick(ACol: Longint; AColumn: TColumnEh); override;
    procedure SetColumnAttributes; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
  published
    property ExpType: TExpType read FExpType write SetExpType default ExpXLS;
    Property ExpOpenType: TOpenType read FExpOpenType write SetExpOpenType;
    Property ShowLineNo
      : Boolean read FShowLineNo write SetShowLineNo default True;
    property SetIndicatorWidth: integer read FsetIndicatorWidth write
      SetsetIndicatorWidth default 32; //
    property AutoSetMultiSelect: Boolean read FAutoSetMultiSelect write
      SetAutoSetMultiSelect;
    Property AutoSetCtrlKey
      : Boolean read FAutoSetCtrlKey write SetAutoSetCtrlKey;
    Property AutoFocusKey
      : Boolean read FAutoFocusKey write SetAutoFocusKey default
      false;
    Property AutoFocusKeyInterval:Cardinal read FAutoFocusKeyInterval write SetAutoFocusKeyInterval default 300;
    Property PrintInfo: TPrintInfo read FPrintInfo write SetPrintInfo;
    property PrintOptions: TPrintDBGridEhOptions read FOptions write SetOptions;
    property PrintAutoNewLine: Boolean read FPrintAutoNewLine write
      SetPrintAutoNewLine default True; // 是否自动换行
    property jsonConnection: TjsonConnection read FJSONConnection write
      SetJSONConnection;
    property AutoGridAdject
      : Boolean read FAutoGridAdject write SetAutoGridAdject default false;
    property AutoGridSave
      : Boolean read FAutoGridSave write SetAutoGridSave default
      false;
    property AutoAPPPopuMenu: Boolean read FAutoAPPPopuMenu write
      SetAutoAPPPopuMenu default false;
    property GridUser: integer read FGridUser write SetGridUser default 0;
    property ParentName: string read FParentName write SetParentName;
    property FIsMenuIni
      : Boolean read FFIsMenuIni write SetFIsMenuIni default false;
    Property TitleAlign: TTitleAlign read FTitleAlign write SetTitleAlign;
  end;

  TDBGridEhToExcel = class(TComponent)
  private
    FProgressForm: TForm;                                  {进度窗体}
    FtempGauge: TProgressBar;                           {进度条}
    FShowProgress: Boolean;                                {是否显示进度窗体}
    FShowOpenExcel:Boolean;                                {是否导出后打开Excel文件}
    FDBGridEh: TNvDbgridEh;
    procedure SetShowProgress(const Value: Boolean);       {是否显示进度条}
    procedure SetShowOpenExcel(const Value: Boolean);      {是否打开生成的Excel文件}
    procedure SetDBGridEh(const Value: TNvDbgridEh);
    procedure CreateProcessForm(AOwner: TComponent);       {生成进度窗体}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExportToExcel; {输出Excel文件}
  published
    property DBGridEh: TNvDbgridEh read FDBGridEh write SetDBGridEh;
    property ShowProgress: Boolean read FShowProgress write SetShowProgress;    //是否显示进度条
    property ShowOpenExcel: Boolean read FShowOpenExcel write SetShowOpenExcel; //是否打开Excel
  end;
procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nova', [TNvDbgridEh]);
end;

constructor TNvDbgridEh.Create(AOwner: TComponent);
begin
  popumenuCreatebyself := false;
  ExpType := ExpXLS;
  FGridUser := 0;
  FAutoFocusKeyInterval:=300;
  imeMode := imClose;
  PrintOptions := [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]; //
  inherited Create(AOwner);
  PrintDBGridEh := TNvPrintDBGridEh.Create(self);
  PrintDBGridEh.DBGridEh := self;
  PrintDBGridEh.Units := MM;
  PrintDBGridEh.Options:=PrintOptions;
  // PrintDBGridEh.PageHeader

  /// DBGridEhExport := TDBGridEhExportAsCSV.Create;
  SaveDialog := TSaveDialog.Create(self);
  SaveDialog.Filter :=
    'Text File(.txt)|*.Txt|CSV File (*.csv)|*.csv|Html File(*.html)|*.html|RTF File(*.RTF)|*.RTF|Excel File (*.XLS)|*.XLS';
  SaveDialog.FilterIndex := 0;
  SaveDialog.Options := [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing];
  if not ColumnDefValues.Title.TitleButton then
    ColumnDefValues.Title.TitleButton := True;
  SetIndicatorWidth := 32;
  ShowLineNo := True;
  Timer := TTimer.Create(self);
  Timer.Enabled := false;
  Timer.Interval := FAutoFocusKeyInterval;
  Timer.OnTimer := TimerTimer;
  TimerMenu := TTimer.Create(self);
  TimerMenu.Enabled := false;
  TimerMenu.Interval := 100;
  TimerMenu.OnTimer := TimerTimerMenu;

  AutoFocusKey := false;
  FPrintInfo := TPrintInfo.Create(self);
  // FPrintInfo.TitleFont.Assign(Font);
  FPrintColumn := Tstringlist.Create;

  GridAdjust := TGridAdjust.Create;
  GridAdjust.SourceDBGrid1:=Self;

  TimerMenu.Enabled := True;
end;

destructor TNvDbgridEh.Destroy;
begin
  try
    if assigned(Timer) then
      Timer.Enabled := false;
    if assigned(TimerMenu) then
      TimerMenu.Enabled := false;
    if AutoGridSave then
    begin
      if jsonConnection <> nil then
      begin
        GridSave
      end;
    end;
    if popumenuCreatebyself then
      if not((Win32Platform <> VER_PLATFORM_WIN32_WINDOWS) or
          (Win32MajorVersion > 4)) then //
        PopupMenu.Free;
    inherited;
    // FPrintColumn.Free;
    // GridAdjust.free;
  finally
  end;
  // SaveDialog.free;
  // Timer.free;
  // PrintDBGridEh.free;
end;

procedure TNvDbgridEh.DrawColumnCell(const Rect: TRect; DataCol: integer;
  Column: TColumnEh; State: TGridDrawState);
var
  Cr: Tcolor;
begin

  if assigned(OnDrawColumnCell) then
    OnDrawColumnCell(self, Rect, DataCol, Column, State);
  if ShowLineNo then
  begin
    if DataSource.DataSet.active then
    begin
      Cr := canvas.Font.Color;
      canvas.Font.Color := $006929E0;
      SetBkMode(canvas.Handle, TRANSPARENT);
      canvas.Pen.Color := Cr;
      canvas.TextOut(5, Rect.top, inttostr(DataSource.DataSet.RecNo));
      // 处理添加行数功能
      canvas.Font.Color := Cr;
    end;
  end;

  inherited;
end;

var
  ASC: Boolean = True;

  // 是否升序排列
procedure TNvDbgridEh.SortDBGridEh(Sender: Tobject; ACol: integer;
  Column: TColumnEh);
var
  FieldName, SortStr: string;
  OldIndex: string;
  opts: TIndexOptions;
  IdxName: string;
  DataSet: TjsonClientDataSet;
begin
  try
    if (Sender is TDBGridEH) and
      ((Sender as TDBGridEH).DataSource.DataSet <> nil) then
    begin
      if not((Sender as TDBGridEH).DataSource.DataSet is TCustomClientDataSet)
        then
        Exit;
      if not(Sender as TDBGridEH).DataSource.DataSet.active then
        Exit;
      FieldName := Column.FieldName;
      if (Sender as TDBGridEH).DataSource.DataSet.FindField(FieldName)
        .IsBlob then
        Exit;
      if (Sender as TDBGridEH).DataSource.DataSet.FieldByName(FieldName)
        .FieldKind = fkData then
        SortStr := FieldName
      else if (Sender as TDBGridEH).DataSource.DataSet.FieldByName(FieldName)
        .FieldKind = fkLookup then
        FieldName := (Sender as TDBGridEH).DataSource.DataSet.FieldByName
          (FieldName).KeyFields
      else
        FieldName := '';
      if (FieldName = '') or (Pos(';', FieldName) > 0) then
        Exit;
      DataSet := (Sender as TDBGridEH).DataSource.DataSet as TjsonClientDataSet;

      if Column.Title.SortMarker = smNoneEh then
        Column.Title.SortMarker := smUpEh
      else if Column.Title.SortMarker = smUpEh then
        Column.Title.SortMarker := smDownEh
      else
        Column.Title.SortMarker := smNoneEh;

      if Column.Title.SortMarker = smDownEh then
        opts := [ixDescending, ixCaseInsensitive];
      opts := opts + [ixCaseInsensitive];

      DataSet.IndexName := '';
      // IdxName := DataSet.Name + 'SortIdx';
      IdxName := FieldName; // + ' DESC';
      // IdxName := FieldName;
      DataSet.IndexDefs.Clear;
      DataSet.IndexDefs.Update;
      if DataSet.IndexDefs.IndexOf(IdxName) <> -1 then
        DataSet.DeleteIndex(IdxName);

      DataSet.AddIndex(IdxName, FieldName, opts); //Column.Field.FieldName
      DataSet.IndexName := IdxName;
      DataSet.IndexDefs.Clear;
      DataSet.IndexDefs.Update;
    end;
  finally

  end;
end;

procedure TNvDbgridEh.DoTitleClick(ACol: integer; AColumn: TColumnEh);
begin
  inherited;
  if assigned(OnTitleClick) then
    OnTitleClick := nil;

  if CanUse then
    SortDBGridEh(self, ACol, AColumn);
end;

procedure TNvDbgridEh.ExpDbgrid;
var
  File_name: string;
  //DBGridEhExportClass:TDBGridEhExportClass;
  dataSetNotifyEvent:TDataSetNotifyEvent;
  DBGridEhExportAsXLS:TDBGridEhExportAsXLS;
begin
  if not CanUse then
    Exit;
  with TDBGridEhToExcel.Create(Application) do
  begin
    DBGridEh:=Self;
    ExportToExcel;
    Free;
  end;
//  File_name := '';
//  case FExpType of
//    ExpText:
//      SaveDialog.FilterIndex := 1;
//    ExpCSV:
//      SaveDialog.FilterIndex := 2;
//    ExpHTML:
//      SaveDialog.FilterIndex := 3;
//    ExpRTF:
//      SaveDialog.FilterIndex := 4;
//    ExpXLS:
//      SaveDialog.FilterIndex := 5;
//  end;
//  SaveDialog.Title := '请选择导出文件保存路径!';
//  if SaveDialog.Execute then
//  begin
//    File_name := SaveDialog.FileName;
//    if ExtractFileExt(File_name) = '' then
//    begin
//      Case SaveDialog.FilterIndex of
//        1:
//          File_name := File_name + '.txt';
//        2:
//          File_name := File_name + '.CSV';
//        3:
//          File_name := File_name + '.HTML';
//        4:
//          File_name := File_name + '.RTF';
//        5:
//          File_name := File_name + '.XLS';
//      else
//        File_name := File_name + '.txt';
//      end;
//    end;
//    if SaveDialog.FilterIndex > 0 then
//    begin
//      Case SaveDialog.FilterIndex of
//        1:
//          FExpType := ExpText;
//        2:
//          FExpType := ExpCSV;
//        3:
//          FExpType := ExpHTML;
//        4:
//          FExpType := ExpRTF;
//        5:
//          FExpType := ExpXLS;
//      else
//        FExpType := ExpText;
//      end;
//    end
//    else
//    begin
//      if Pos('.', File_name) > 0 then
//      begin
//        File_name := File_name + '.txt';
//      end;
//    end;
//    if FileExists(File_name) then
//    begin
//      if MessageDlg('文件己经存在，是否覆盖?', mtConfirmation, [mbYes, mbNo], 0)
//        = mrNo then
//      begin
//        Exit;
//      end;
//    end;
//    try
//      dataSetNotifyEvent:= self.DataSource.DataSet.AfterScroll;
//      self.DataSource.DataSet.AfterScroll:=nil;
//      PrintUseColumnSet;
//      // PrintColumnSet;
//      case FExpType of
//        ExpText:
//          SaveDBGridEhToExportFile(TDBGridEhExportAsText, self, File_name,
//            True);
//        ExpCSV:
//
//          SaveDBGridEhToExportFile(TDBGridEhExportAsCSV, self, File_name, True);
//        ExpHTML:
//
//          SaveDBGridEhToExportFile(TDBGridEhExportAsHTML, self, File_name,
//            True);
//        ExpRTF:
//          SaveDBGridEhToExportFile(TDBGridEhExportAsRTF, self, File_name, True);
//        ExpXLS:
//          begin
//            SaveDBGridEhToExportFile(TDBGridEhExportAsXLS, self, File_name, True);
//           { DBGridEhExportAsXLS:=TDBGridEhExportAsXLS.Create;
//            DBGridEhExportAsXLS.DBGridEh:=self;
//            DBGridEhExportAsXLS.ExportToFile(File_name, True); }
//           // toexcel(self, File_name);
//
//          end
//        else
//          SaveDBGridEhToExportFile(TDBGridEhExportAsText, self, File_name,
//            True);
//      end;
//      BackColumnSet;
//      case FExpOpenType of
//        AutoOpen:
//          ShellExecute(Handle, 'open', pchar(File_name), nil, nil, SW_SHOW);
//        UserChoice:
//          begin
//            if MessageDlg('是否打开?', mtConfirmation, [mbYes, mbNo], 0)
//              = mrYes then
//            begin
//              ShellExecute(Handle, 'open', pchar(File_name), nil, nil, SW_SHOW)
//            end;
//          end;
//      end;
//    self.DataSource.DataSet.AfterScroll:=dataSetNotifyEvent;
//    except
//      on E: Exception do
//      begin
//        ShowMessage('导出失败!' + E.Message);
//      end;
//    end;
//  end;

end;

procedure TNvDbgridEh.Print;

begin
  try
    InitPrintInfo;
    PrintUseColumnSet;
    setPrintPaper;
    // ApplySettings_xy(PrinterPreview.Printer,2100,2970);
    PrintDBGridEh.Print;
  finally
    BackColumnSet;
  end;
end;

procedure TNvDbgridEh.PrintPreview;

begin
  // Print;
  // exit;
  try
    InitPrintInfo;
    PrintUseColumnSet;
    setPrintPaper;
    VirtualPrinter.Orientation := PrintInfo.PrinterOrientation;
    // VirtualPrinter.usrPageHeight:=PrintInfo.GetPageHeight;
    // VirtualPrinter.usrPageWidth :=PrintInfo.GetPageWidth;
    PrintDBGridEh.Preview;
  finally
    BackColumnSet;
  end;
end;

/// ////////////////////////////////////////////////////////
/// ////////添加对于自定义类型的纸张设定 20070609
procedure TNvDbgridEh.ApplySettings_xy(Printer: TPrinter; X, Y: integer);
var
  Device: array [0 .. 255] of Char;
  Driver: array [0 .. 255] of Char;
  Port: array [0 .. 255] of Char;
  hDMode: THandle;
  PDMode: PDEVMODE;
begin
  Printer.PrinterIndex := Printer.PrinterIndex;
  Printer.GetPrinter(Device, Driver, Port, hDMode);
  if hDMode <> 0 then
  begin
    PDMode := GlobalLock(hDMode);
    if PDMode <> nil then
    begin
      if (X = 0) or (Y = 0) then
      begin
        PDMode^.dmFields := PDMode^.dmFields or dm_PaperSize;
        PDMode^.dmPaperSize := DMPAPER_FANFOLD_US;
      end
      else
      begin
        { Set to legal }
        // pDMode^.dmFields := pDMode^.dmFields or dm_PaperSize;
        // pDMode^.dmPaperSize := DMPAPER_LEGAL;

        { Set to custom size }
        // 自定义纸张大小
        PDMode^.dmFields :=
          PDMode^.dmFields or dm_PaperSize or DM_PAPERWIDTH or DM_PAPERLENGTH;
        // 9 A4   DMPAPER_USER
        // 8 A3
        PDMode^.dmPaperSize := DMPAPER_USER;
        // showmessage(inttostr(pdmode^.dmorientation));
        { 一定要加入这样的判断，根据纸张的方向设置选择长、
          宽（x,y)的使用情况。可以使用上面释掉的这一句测试一下
          dmorient_landscape值为2；dmorient_portrait值为1
          }
        // 这里删除打印机打印方向操作。
        // 按设定的大小打印
        // if pdmode^.dmOrientation=dmorient_landscape then
        // begin
        // pDMode^.dmPaperWidth :=y;
        // pDMode^.dmPaperLength :=x;
        // end
        // else
        // if PDMode^.dmOrientation=dmorient_portrait then
        // begin
        PDMode^.dmPaperWidth := X;
        PDMode^.dmPaperLength := Y;
        // end
        // else
        // begin
        // pdmode^.dmPaperWidth:=x;{SomeValueInTenthsOfAMillimeter}
        // pdmode^.dmPaperLength:=y; {SomeValueInTenthsOfAMillimeter}
        // end;
      end;
      { Set the bin to use }
      PDMode^.dmFields := PDMode^.dmFields or DMBIN_MANUAL;
      PDMode^.dmDefaultSource := DMBIN_MANUAL;
      ResetDC(Printer.Handle, PDMode^);
      GlobalUnlock(hDMode);
    end;
  end;
  Printer.PrinterIndex := Printer.PrinterIndex;
end;

procedure TNvDbgridEh.SetExpType(const Value: TExpType);
begin
  FExpType := Value;
end;

procedure TNvDbgridEh.SetsetIndicatorWidth(const Value: integer);
begin
  FsetIndicatorWidth := Value;
end;

procedure TNvDbgridEh.SetShowLineNo(const Value: Boolean);
begin
  FShowLineNo := Value;
end;

procedure TNvDbgridEh.SetColumnAttributes;
begin
  inherited;
  if (DBGridEh.dgIndicator in Options) then
    ColWidths[0] := FsetIndicatorWidth; // IndicatorWidth;
end;

procedure TNvDbgridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  tmpStr: string;
  form: TCustomForm;
begin
  inherited;
  if FAutoFocusKey then
  begin
    if (Key in [ord('0') .. ord('9'), 96 .. 105]) and (CanUse) then
    begin
      if Key >= 96 then
      begin
        Key := Key - 48;
      end;
      Timer.Enabled := false;
      Timer.Enabled := True;
      tmpStr := (inttostr(GotoLineNo) + chr(Key));
      GotoLineNo := strtoint(tmpStr);
    end;
  end;
end;

procedure TNvDbgridEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
begin
  // if not( ssctrl in shift ) then
  // Shift :=  shift + [ssctrl]  ;
  inherited; // MouseDown( Button, Shift, x, y );
end;

procedure TNvDbgridEh.TimerTimer(Sender: Tobject);
begin
  (Sender as TTimer).Enabled:=false;
  if (CanUse) and (GotoLineNo>0) and (GotoLineNo<=self.DataSource.DataSet.RecordCount) then
    DataSource.DataSet.RecNo := GotoLineNo;
  GotoLineNo := 0;
end;

function TNvDbgridEh.CanUse: Boolean;
begin
  result := false;
  if self.DataSource <> nil then
    if self.DataSource.DataSet <> nil then
      if self.DataSource.DataSet.active then
        result := True;
end;

procedure TNvDbgridEh.SetAutoSetMultiSelect(const Value: Boolean);
begin
  FAutoSetMultiSelect := Value;
  if Value then
  begin
    if not(dgMultiSelect in Options) then
    begin
      Options := Options + [dgMultiSelect];
    end;
  end
  else
  begin
    if (dgMultiSelect in Options) then
    begin
      Options := Options - [dgMultiSelect];
    end;
  end;
end;

procedure TNvDbgridEh.SetAutoSetCtrlKey(const Value: Boolean);
begin
  FAutoSetCtrlKey := Value;
  if Value then
  begin
    if dghClearSelection in OptionsEh then
    begin
      OptionsEh := OptionsEh - [dghClearSelection];
    end;
  end
  else
  begin
    if not(dghClearSelection in OptionsEh) then
    begin
      OptionsEh := OptionsEh + [dghClearSelection];
    end;
  end;
end;

procedure TNvDbgridEh.SetAutoFocusKey(const Value: Boolean);
begin
  FAutoFocusKey := Value;
end;

procedure TNvDbgridEh.SetAutoFocusKeyInterval(const value: Cardinal);
begin
  if assigned(Timer) then
    Timer.Interval:=value;
end;

procedure TNvDbgridEh.SetPrintInfo(const Value: TPrintInfo);
begin
  FPrintInfo.AssignTo(Value);
end;

{ TPrintInfo }

constructor TPrintInfo.Create(AOwner: TComponent);
begin
  //
  FControl := AOwner;
  FPageFooterRight := '南凌科技';
  FPrintPageFooter := True;
  FTitleUpLine := True;
  FPrintPrintFooterTime := True;

  inherited Create();
  FTitleList := Tstringlist.Create;
  FTitleFont := Tfont.Create;
  FGridHeadFont := Tfont.Create;
  FPageSize := TPageParams.Create;
  FTitleFont.Name := '宋体'; // Screen.Forms[0].Font.name;
  FTitleFont.Size := 16;
  // FTitleFont.Charset = GB2312_CHARSET
  // FTitleFont.Color = clWindowText
  // FTitleFont.Height = -19
  // FTitleFont.Name = '宋体'
  // FTitleFont.Style = []
  FTitleFont.PixelsPerInch := Screen.forms[0].Font.PixelsPerInch;
  FTitleFont.Charset := Screen.forms[0].Font.Charset;
  FTitleFont.Color := Screen.forms[0].Font.Color;
  FTitleFont.Height := -19;
  FTitleFont.Pitch := Screen.forms[0].Font.Pitch;
  // FTitleFont.Size := Screen.Forms[0].Font.Size;
  FTitleFont.Style := Screen.forms[0].Font.Style;
  // FTitleFont.Assign(Screen.Forms[0].Font);
  FTitleFont.OnChange := TitleFontChanged;

end;

destructor TPrintInfo.Destroy;
begin
  FTitleFont.Free;
  FTitleList.Free;
  FPageSize.Free;
  inherited Destroy;
end;

function TPrintInfo.GetPageHeight: integer;
begin
  if PaperSize = Default then
    result := 0
  else if PaperSize = Custom then
  begin
    result := round(PageHeight * 10);
  end
  else
  begin
    result := round(PaperSizeMetrics[PaperSize, 1] * 10);
  end;
end;

function TPrintInfo.GetPageWidth: integer;
begin
  if PaperSize = Default then
    result := 0
  else if PaperSize = Custom then
  begin
    result := round(PageWidth * 10);
  end
  else
  begin
    result := round(PaperSizeMetrics[PaperSize, 0] * 10);
  end;
end;

function TPrintInfo.GetTitle: Tstrings;
var
  i: integer;
begin
  // 标题后空行数
  FTitleList.Clear;
  for i := 0 to FTitleNullLine - 1 do
  begin
    FTitleList.Add(' ');
  end;
  result := FTitleList;
end;

function TPrintInfo.GPageFooterRight: string;
begin
  result := FPageFooterRight;
end;

procedure TPrintInfo.SetGridHeadFont(const Value: Tfont);
begin
  FGridHeadFont.Assign(Value);
end;

procedure TPrintInfo.SetGridTop(const Value: string);
begin
  FGridTop := Value;
end;

procedure TPrintInfo.SetPageFooterRight(const Value: String);
begin
  FPageFooterRight := (Value);
end;

procedure TPrintInfo.SetPageHeight(const Value: extended);
begin
  FPageHeight := Value;
end;

procedure TPrintInfo.SetPageSize(const Value: TPageParams);
begin
  FPageSize.BottomMargin := Value.BottomMargin;
  FPageSize.LeftMargin := Value.LeftMargin;
  FPageSize.RightMargin := Value.RightMargin;
  FPageSize.TopMargin := Value.TopMargin;
end;

procedure TPrintInfo.SetPageTopLeft(const Value: string);
begin
  FPageTopLeft := Value;
end;

procedure TPrintInfo.SetPageTopRight(const Value: string);
begin
  FPageTopRight := Value;
end;

procedure TPrintInfo.SetPageWidth(const Value: extended);
begin
  FPageWidth := Value;
end;

procedure TPrintInfo.SetPaperSize(const Value: TPaperSize);
begin
  FPaperSize := Value;
  if Value <> Custom then
  begin
    FPageWidth := PaperSizeMetrics[Value, 0];
    FPageHeight := PaperSizeMetrics[Value, 1];
//    if Value <> Default then
//    begin
//      if not(pghFitingByColWidths in TNvDbgridEh(FControl).PrintOptions) then
//        TNvDbgridEh(FControl).PrintOptions := TNvDbgridEh(FControl)
//          .PrintOptions + [pghFitingByColWidths];
//      if not(pghFitGridToPageWidth in TNvDbgridEh(FControl).PrintOptions) then
//        TNvDbgridEh(FControl).PrintOptions := TNvDbgridEh(FControl)
//          .PrintOptions + [pghFitGridToPageWidth];
//    end;
  end;
end;

procedure TPrintInfo.SetPrinterOrientation(const Value: TPrinterOrientation);
begin
  FPrinterOrientation := Value;
end;

procedure TPrintInfo.SetPrintName(const Value: string);
begin
  FPrintName := Value;
end;

procedure TPrintInfo.SetPrintPageFooter(const Value: Boolean);
begin
  FPrintPageFooter := Value;
end;

procedure TPrintInfo.SetPrintPrintFooterTime(const Value: Boolean);
begin
  FPrintPrintFooterTime := Value;
end;

procedure TPrintInfo.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

procedure TNvDbgridEh.InitPrintInfo;
begin
  // tmpTitleFont := Tfont.Create;
  // tmpTitleFont.Assign(TitleFont);
  // TitleFont.Assign(PrintInfo.TitleFont);

  PrintDBGridEh.Options := PrintOptions;
  PrintDBGridEh.PageHeader.CenterText.Clear;
  if PrintInfo.Title = '' then
  begin
    PrintInfo.Title := GetParentForm(self,false).Caption;
  end;

  PrintDBGridEh.PrintGridHeadFont.Assign(PrintInfo.FGridHeadFont);
  PrintDBGridEh.PageHeader.CenterFont.Assign(PrintInfo.TitleFont);

  PrintDBGridEh.PageHeader.CenterText.Assign(PrintInfo.GetTitle);
  PrintDBGridEh.PageHeader.CenterText.Insert(0, PrintInfo.Title);
  PrintDBGridEh.Page.BottomMargin := PrintInfo.PageSize.BottomMargin;
  PrintDBGridEh.Page.LeftMargin := PrintInfo.PageSize.LeftMargin;
  PrintDBGridEh.Page.RightMargin := PrintInfo.PageSize.RightMargin;
  PrintDBGridEh.Page.TopMargin := PrintInfo.PageSize.TopMargin;
  // PrintDBGridEh.VPrinter_Canvas.Font.Assign(PrintInfo.TitleFont);
  // PrintDBGridEh.PageHeader.Font.Assign(PrintInfo.TitleFont);
  PrintDBGridEh.PageHeader.LeftText.Clear;
  PrintDBGridEh.PageHeader.LeftText.Add(#13);
  PrintDBGridEh.PageHeader.LeftText.Add('');
  PrintDBGridEh.PageHeader.LeftText.Add(PrintInfo.PageTopLeft);
  PrintDBGridEh.PageHeader.RightText.Clear;
  PrintDBGridEh.PageHeader.RightText.Add(#13);
  PrintDBGridEh.PageHeader.RightText.Add('');
  PrintDBGridEh.PageHeader.RightText.Add(PrintInfo.PageTopRight + '   ');
  {if PrintInfo.TitleUpLine then
  begin
    PrintDBGridEh.PageHeader.LineType := pcltDoubleLine;
  end; }
  PrintDBGridEh.PageFooter.Font.Size:=20;
  if PrintInfo.PrintPageFooter then
  begin
    PrintDBGridEh.PageFooter.CenterText.Text := '第 &[Page] 页 - 共 &[Pages] 页';
  end;
  if PrintInfo.PrintName <> '' then
  begin
    PrintDBGridEh.PageFooter.CenterText.Text := trim
      (PrintDBGridEh.PageFooter.CenterText.Text)
      + '         制表人:' + PrintInfo.PrintName;
  end;
  if PrintInfo.PrintPrintFooterTime then
  begin
    PrintDBGridEh.PageFooter.LeftText.Text := '打印时间 &[Date] &[time]';
  end;
  PrintDBGridEh.PageFooter.RightText.Text := PrintInfo.PageFooterRight;
end;

procedure TPrintInfo.SetTitleFont(const Value: Tfont);
begin
  FTitleFont.Assign(Value);
end;

procedure TPrintInfo.SetTitleNullLine(const Value: integer);
begin
  FTitleNullLine := Value;
end;

procedure TPrintInfo.SetTitleUpLine(const Value: Boolean);
begin
  FTitleUpLine := Value;
end;

procedure TPrintInfo.TitleFontChanged(Sender: Tobject);
begin
  // if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
  // ParentFont := False;
  // if dgTitles in Options then LayoutChanged;
end;

// 设置打印项
procedure TNvDbgridEh.PrintColumnSet;
var
  i: integer;
  PrintColumn: TPrintColumn;
  SetForm: Tform;
  SetCheckList: Tchecklistbox;
  Bt_yes, Bt_no: TBitBtn;
begin
  if FPrintColumn.Count = 0 then
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      PrintColumn := TPrintColumn.Create;
      PrintColumn.ColumnName := Columns.Items[i].Title.Caption;
      PrintColumn.ColumnIdx := i;
      PrintColumn.IsPrint := True;
      FPrintColumn.AddObject(PrintColumn.ColumnName, PrintColumn);
    end;
  end;
  if FPrintColumn.Count > 0 then
  begin
    SetForm := Tform.Create(Parent);
    // SetForm.Align:=alCustom;
    SetForm.BorderStyle := bsDialog;
    SetForm.Caption := '打印条目选择';
    SetForm.Font.Size := 11;
    SetForm.width := 204; // trunc(screen.Width/5);
    SetForm.Left := trunc(Screen.width / 2 - Screen.width / 10);
    SetForm.Height := 256; // trunc(screen.Height/3);
    SetForm.top := trunc(Screen.Height / 2 - SetForm.Height / 2);

    // SetForm.AutoSize:=true;
    SetCheckList := Tchecklistbox.Create(SetForm);
    SetCheckList.Parent := SetForm;
    SetCheckList.width := SetForm.width - 10;
    SetCheckList.Height := SetForm.Height - 65;
    SetCheckList.Clear;

    for i := 0 to FPrintColumn.Count - 1 do
    begin
      SetCheckList.Items.Add(TPrintColumn(FPrintColumn.Objects[i]).ColumnName);
      SetCheckList.Checked[TPrintColumn(FPrintColumn.Objects[i]).ColumnIdx] :=
        TPrintColumn(FPrintColumn.Objects[i]).IsPrint;
    end;

    Bt_yes := TBitBtn.Create(SetForm);
    Bt_yes.Name := 'Bt_yes';
    Bt_yes.Kind := bkOK;
    Bt_yes.Caption := '打印';
    Bt_yes.Font.Style := [fsBold];
    Bt_yes.top := SetForm.Height - 60;
    Bt_yes.Height := 25;
    Bt_yes.width := 75;
    Bt_yes.Left := 10;
    Bt_yes.Parent := SetForm;
    Bt_no := TBitBtn.Create(SetForm);
    Bt_no.Name := 'Bt_no';
    Bt_no.Kind := bkNo;
    Bt_no.Caption := '取消';

    Bt_no.top := SetForm.Height - 60;
    Bt_no.Height := 25;
    Bt_no.width := 75;
    Bt_no.Left := SetForm.width - 75 - 20;
    Bt_no.Parent := SetForm;
    SetForm.ActiveControl := SetCheckList;

    if SetForm.ShowModal = mrOk then
    begin
      for i := 0 to SetCheckList.Count - 1 do
      begin
        TPrintColumn(FPrintColumn.Objects[i]).IsPrint := SetCheckList.Checked
          [i];
      end;
    end;
    SetForm.Parent := nil;
    SetCheckList.Free;
    Bt_yes.Free;
    Bt_no.Free;
    SetForm.Free;

  end;
end;

procedure TNvDbgridEh.PrintUseColumnSet;
var
  i: integer;
begin
  for i := 0 to FPrintColumn.Count - 1 do
  begin
    Columns[i].visible := TPrintColumn(FPrintColumn.Objects[i]).IsPrint;
  end;
end;

procedure TNvDbgridEh.BackColumnSet;
var
  i: integer;
begin
  // if tmpTitleFont<>nil then
  // TitleFont.Assign(tmpTitleFont);
  for i := 0 to FPrintColumn.Count - 1 do
  begin
    Columns[i].visible := True;
  end;
end;

procedure TNvDbgridEh.SetExpOpenType(const Value: TOpenType);
begin
  FExpOpenType := Value;
end;

procedure TNvDbgridEh.SetOptions(const Value: TPrintDBGridEhOptions);
begin
  FOptions := Value;
  if Assigned(PrintDBGridEh) then
    PrintDBGridEh.Options := Value;
//  if (pghOptimalColWidths in FOptions) then
//    FOptions := FOptions + [pghFitingByColWidths]
end;

procedure TNvDbgridEh.SetPrintAutoNewLine(const Value: Boolean);
begin
  FPrintAutoNewLine := Value;
//  if Value then
//  begin
//    if not(pghOptimalColWidths in FOptions) then
//      FOptions := FOptions + [pghFitingByColWidths]
//  end
//  else
//  begin
//    if (pghOptimalColWidths in FOptions) then
//      FOptions := FOptions - [pghFitingByColWidths]
//  end;
end;

procedure TNvDbgridEh.SetJSONConnection(const Value: TjsonConnection);
begin
  FJSONConnection := Value;
  GridAdjust.FDBConnect := Value;
end;

procedure TNvDbgridEh.SetAutoGridAdject(const Value: Boolean);
begin
  FAutoGridAdject := Value;
  FAutoGridSave := Value;
end;

procedure TNvDbgridEh.SetAutoGridSave(const Value: Boolean);
begin
  FAutoGridAdject := Value;
  FAutoGridSave := Value;
end;

{ TGridAdjust }

procedure TGridAdjust.CheckListBoxDragDrop(Sender, Source: Tobject;
  X, Y: integer);
var
  tmppoint: Tpoint;
  senderindex, sourceindex: integer;
begin
  tmppoint.X := X;
  tmppoint.Y := Y;
  sourceindex := (Source as Tchecklistbox).ItemIndex;
  senderindex := (Sender as Tchecklistbox).ItemAtPos(tmppoint, True);
  if senderindex = -1 then
    senderindex := (Sender as Tchecklistbox).Count - 1;
(Sender as Tchecklistbox)
  .Items.Move(sourceindex, senderindex);
end;

procedure TGridAdjust.CheckListBoxDragOver(Sender, Source: Tobject;
  X, Y: integer; State: TDragState; var Accept: Boolean);
begin
  if Source is Tchecklistbox then
    Accept := True;
end;

procedure TGridAdjust.CheckListBoxKeyDown(Sender: Tobject; var Key: Word;
  Shift: TShiftState);
var
  curitem: integer;
begin
  if (Shift = [ssCtrl]) and (Key = vk_down) then
  begin
    curitem := (Sender as Tchecklistbox).ItemIndex;
    if curitem = (Sender as Tchecklistbox).Count - 1 then
      Exit;
    if ((Sender as Tchecklistbox).Checked[curitem]) then
    begin (Sender as Tchecklistbox)
      .Items.Move(curitem, curitem + 1); (Sender as Tchecklistbox)
      .Selected[curitem] := True;
    end;
  end;
  if (Shift = [ssCtrl]) and (Key = vk_up) then
  begin
    curitem := (Sender as Tchecklistbox).ItemIndex;
    if curitem = 0 then
      Exit;
    if ((Sender as Tchecklistbox).Checked[curitem]) then
    begin (Sender as Tchecklistbox)
      .Items.Move(curitem, curitem - 1); (Sender as Tchecklistbox)
      .Selected[curitem] := True;
    end;
  end;

end;

procedure TGridAdjust.CheckListBoxMouseDown(Sender: Tobject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  tmppoint: Tpoint;
  curindex: integer;
begin
  tmppoint.X := X;
  tmppoint.Y := Y;
  if (Sender as Tchecklistbox).ItemAtPos(tmppoint, True) <> -1 then
  begin
    curindex := (Sender as Tchecklistbox).ItemAtPos(tmppoint, True);
    if (Sender as Tchecklistbox).Checked[curindex] then
  (Sender as Tchecklistbox)
      .BeginDrag(false);
  end;
end;

procedure TGridAdjust.CheckListBoxPress(Sender: Tobject; var Key: Char);
begin
  if Key = #27 then
  begin
    myFormDeactivate(nil);
  end;
end;

procedure TGridAdjust.GridAdjust(Sender, DBGrid: Tobject);
var
  i: integer;
begin
  if DBGrid is TDBGrid then
    SourceDBGrid := TDBGrid(DBGrid)
  else if DBGrid is TDBGridEH then
    SourceDBGrid1 := TDBGridEH(DBGrid)
  else if DBGrid is TNvDbgridEh then
    SourceDBGrid1 := TNvDbgridEh(DBGrid)
  else
  begin
    ShowMessage('参数错误！');
    Exit;
  end;
  form := Tform.Create(Application);
  with form do
  begin
    BorderStyle := bsNone; // bsDialog;
    Caption := '栏目调整';
    Height := 300;
    width := 200;
    Position := poScreenCenter;
    form.OnDeactivate := myFormDeactivate;
    checklistbox := Tchecklistbox.Create(form);
    with checklistbox do
    begin
      Parent := form;
      align := alclient;
      Color := clSkyBlue;
      onkeydown := CheckListBoxKeyDown;
      onkeypress := CheckListBoxPress;
      onDragOver := CheckListBoxDragOver;
      onDragDrop := CheckListBoxDragDrop;
      onMouseDown := CheckListBoxMouseDown;
      if assigned(SourceDBGrid) then
      begin
        for i := 0 to SourceDBGrid.Columns.Count - 1 do
        begin
          Items.Add(SourceDBGrid.Columns.Items[i].Title.Caption);
          Checked[i] := SourceDBGrid.Columns.Items[i].visible;
        end;
      end
      else
      begin
        for i := 0 to SourceDBGrid1.Columns.Count - 1 do
        begin
          Items.Add(SourceDBGrid1.Columns.Items[i].Title.Caption);
          Checked[i] := SourceDBGrid1.Columns.Items[i].visible;
        end;
      end;
    end;
    ActiveControl := checklistbox;
    checklistbox.Selected[0] := True;
    Show; // ShowModal;
  end;

end;

procedure TGridAdjust.myFormDeactivate(Sender: Tobject);
var
  i,j: integer;
begin
  if assigned(SourceDBGrid) then
  begin
//    for i := 0 to SourceDBGrid.Columns.Count - 1 do
//    begin
//      SourceDBGrid.Columns.Items[i].Index := checklistbox.Items.IndexOf(SourceDBGrid.Columns.Items[i].Title.Caption);
//      SourceDBGrid.Columns.Items[i].visible := checklistbox.Checked[checklistbox.Items.IndexOf(SourceDBGrid.Columns.Items[i].Title.Caption)];
//    end;
    for I := 0 to checklistbox.Items.Count - 1 do
    begin
      for j := 0 to SourceDBGrid.Columns.Count - 1 do
      begin
        if SourceDBGrid.Columns.Items[j].Title.Caption=checklistbox.Items.Strings[i] then
        begin
          SourceDBGrid.Columns.Items[j].Index := i;
          SourceDBGrid.Columns.Items[j].visible := checklistbox.Checked[i];
        end;
      end;
    end;
  end
  else
  begin
//    for i := 0 to SourceDBGrid1.Columns.Count - 1 do
//    begin
//      SourceDBGrid1.Columns.Items[i].Index := checklistbox.Items.IndexOf(SourceDBGrid1.Columns.Items[i].Title.Caption);
//      SourceDBGrid1.Columns.Items[i].visible := checklistbox.Checked[checklistbox.Items.IndexOf(SourceDBGrid1.Columns.Items[i].Title.Caption)];
//    end;
    TCrackNvDbgridEh(SourceDBGrid1).BeginLayout;
    for I := 0 to checklistbox.Items.Count - 1 do
    begin
      for j := 0 to SourceDBGrid1.Columns.Count - 1 do
      begin
        if SourceDBGrid1.Columns.Items[j].Title.Caption=checklistbox.Items.Strings[i] then
        begin
          SourceDBGrid1.Columns.Items[j].Index := i;
          SourceDBGrid1.Columns.Items[j].visible := checklistbox.Checked[i];
        end;
      end;
    end;
    TCrackNvDbgridEh(SourceDBGrid1).EndLayout;
  end;
  form.close;
  form.Free;
end;

procedure TGridAdjust.SaveToTable(jcsdSave: TJsonClientDataSet;
  userid, width, field_index: integer; FROMNAME, FieldName: string;
  visible: Boolean);
begin
  if FDBConnect = nil then
    Exit;
  if FDBConnect.Connected = false then
    Exit;

  with jcsdSave do
  begin
    try
      close;
      Params.ParamByName('gridfield.userid').Value := userid;
      Params.ParamByName('gridfield.componentname').Value := FROMNAME;
      Params.ParamByName('gridfield.fieldname').Value := FieldName;
      Params.ParamByName('gridfield.isvisible').Value := visible;
      Params.ParamByName('gridfield.width').Value := width;
      Params.ParamByName('gridfield.fieldno').Value := field_index;
      Execute;
    except
      on E: Exception do
      begin
        Exit;
      end;
    end;
  end;
end;

procedure TGridAdjust.SetDBConnect(const Value: TjsonConnection);
begin
  FDBConnect := Value;
end;

procedure TGridAdjust.GridLoad2(Columns: TDBGridColumnsEh; User_id: integer;
  Grid_name: string);
var
  i: integer;
  Columninfo: array of TColumninfo;
  Column_n: TColumnEh;
  LocalColumn: array of TColumnArr;
  tempFieldname: string;
begin
  try
    if self.DBConnect = nil then
      Exit;

//    SetLength(LocalColumn, Columns.Count);
//    for i := 0 to Columns.Count - 1 do
//    begin
//      LocalColumn[i].FColumnEh := TColumnEh.Create(nil);
//      LocalColumn[i].FColumnEh.Assign(Columns.Items[i]);
//      LocalColumn[i].ISAppend := false;
//    end;

    SetLength(Columninfo, Columns.Count);
    for i := 0 to Columns.Count - 1 do
    begin
      Columninfo[i].isactive := Columns.Items[i].Visible;
      Columninfo[i].width := Columns.Items[i].Width;
      Columninfo[i].field_index := Columns.Items[i].Index;
      Columninfo[i].FieldName := Columns.Items[i].FieldName;
      Columninfo[i].Caption := Columns.Items[i].Title.Caption;
      Columninfo[i].footer_Value := Columns.Items[i].Footer.Value;
      Columninfo[i].footer_Valuetype:=Columns.Items[i].Footer.ValueType;
      Columninfo[i].ISAppend := false;
    end;

    with TJsonClientDataSet.Create(nil) do
    begin
      RemoteServer := FDBConnect;
      QueryAddress := 'system/querygrid';
      DataSourceName := 'gridlist';
      Params.CreateParam(ftBCD, 'userid', ptInput);
      Params.CreateParam(ftString, 'componentname', ptInput);
      // 查找
      try
        close;
        Params.ParamByName('userid').Value := User_id;
        Params.ParamByName('componentname').Value := Grid_name;
        active := True;
        if RecordCount > 0 then
        begin
          TCrackNvDbgridEh(SourceDBGrid1).BeginLayout;
          Columns.Clear;
          // 查找当前列中的项目
          while not eof do
          // first;
          begin
            tempFieldname := trim(FieldValues['FIELDNAME']);
            for i := 0 to Length(Columninfo) - 1 do
            begin
              try
                if ((tempFieldname = trim(Columninfo[i].Caption)) and
                    (Columninfo[i].ISAppend = false)) then
                begin
                  // 添加入当前dbgrid 中
                  // 添加数据库中有的
                  Column_n := Columns.Add;
                  Column_n.FieldName:=Columninfo[i].FieldName;
                  Column_n.Title.Caption:=Columninfo[i].Caption;
                  Column_n.width := FieldValues['WIDTH'];
                  Column_n.Footer.Value := Columninfo[i].footer_Value;
                  Column_n.Footer.ValueType:=Columninfo[i].footer_Valuetype;
                  Column_n.visible := FieldByName('ISVISIBLE').AsBoolean;
                  Columninfo[i].ISAppend := True;
                  break;
                end;
              finally

              end;
            end;
            Next();
          end;
          // 添加数据库中没有的,新加的字段
          for i := 0 to Length(Columninfo) - 1 do
          begin
            if (Columninfo[i].ISAppend = false) then
            begin
              Column_n := Columns.Add;
              Column_n.FieldName:=Columninfo[i].FieldName;
              Column_n.Title.Caption:=Columninfo[i].Caption;
              Column_n.width := FieldValues['WIDTH'];
              Column_n.visible := FieldByName('ISVISIBLE').AsBoolean;
              Columninfo[i].ISAppend := True;
            end;
          end;
          TCrackNvDbgridEh(SourceDBGrid1).EndLayout;
        end;
      except
        on E: Exception do
        begin
          Free;
          Exit;
        end;
      end;
      close;
      Free;
    end;
  finally
  end;
end;

procedure TNvDbgridEh.GridSave;
var
  i: integer;
begin
  inherited;
  try
    if (jsonConnection <> nil) and (GridAdjust.FDBConnect = nil) then
    begin
      GridAdjust.FDBConnect := self.jsonConnection;
    end;
    jsoncsdSave := TJsonClientDataSet.Create(nil);
    with jsoncsdSave do
    begin
      RemoteServer := self.FJSONConnection;
      SaveAddress := 'system/savegrid';
      Params.CreateParam(ftBCD, 'gridfield.userid', ptInput);
      Params.CreateParam(ftString, 'gridfield.componentname', ptInput);
      Params.CreateParam(ftString, 'gridfield.fieldname', ptInput);
      Params.CreateParam(ftBoolean, 'gridfield.isvisible', ptInput);
      Params.CreateParam(ftBCD, 'gridfield.width', ptInput);
      Params.CreateParam(ftBCD, 'gridfield.fieldno', ptInput);
    end;

    for i := 0 to Columns.Count - 1 do
    begin
      GridAdjust.SaveToTable(jsoncsdSave, FGridUser, Columns.Items[i].width,
        Columns.Items[i].Index, ParentName + Name,
        Columns.Items[i].Title.Caption, Columns.Items[i].visible);
    end;
  finally
    jsoncsdSave.Free;
  end;
end;

procedure TNvDbgridEh.GridAdjectLoad;
begin
  try
//    if assigned(DataLink) then
//      if assigned(self.DataSource) then
//        if assigned(TJsonClientDataSet(DataSource.DataSet)) then
//          if DataSource.DataSet.classname = 'TJsonClientDataSet' then
//            if assigned(TJsonClientDataSet(DataSource.DataSet).RemoteServer)
//              then
//            begin
//               jsonConnection := TJsonClientDataSet(DataSource.DataSet).RemoteServer;
//            end;

    ParentName:=GetParentForm(Self,false).Name;
    if jsonConnection <> nil then
    begin
      GridAdjust.FDBConnect := jsonConnection;
      if AutoGridAdject then
        GridAdjust.GridLoad2(Columns, self.GridUser,
          ParentName + self.Name);
    end;
  finally
  end;
end;

procedure TNvDbgridEh.GridAdject;
begin
  GridAdjust.GridAdjust(self, self);
end;

procedure TNvDbgridEh.SetParentName(const Value: string);
begin
  FParentName := Value;
end;

Procedure TNvDbgridEh.OnMenuPopup(Sender: Tobject);
var
  MenuItem: TMenuItem;
  i: integer;
  b_exist: Boolean;
begin
  // 调用原过程
  if assigned(FOnMenuPopup) then
  begin
    try
      FOnMenuPopup(Sender);
    except
    end;
  end;
  if not Parent.visible then
    Exit;

  try

    for i := 0 to PopupMenu.Items.Count - 1 do
    begin
      if Pos('栏目设置', PopupMenu.Items.Items[i].Caption) > 0 then
      begin
        b_exist := True;
        break;
      end;
    end;
    if b_exist then
      Exit;
    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '-';
    self.PopupMenu.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '栏目设置';
    MenuItem.OnClick := SetGridadjuct;
    MenuItem.Name := self.Name + 'N_1';
    self.PopupMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '导出';
    MenuItem.OnClick := ExpGrid;
    MenuItem.Name := self.Name + 'N_2';
    self.PopupMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '打印';
    MenuItem.OnClick := PrintGrid;
    MenuItem.Name := self.Name + 'N_3';
    self.PopupMenu.Items.Add(MenuItem);

  finally
  end;
end;

procedure TNvDbgridEh.TimerTimerMenu(Sender: Tobject);
begin
//  GridAdjectLoad;
  TimerMenu.Enabled:=false;
  if not AutoAPPPopuMenu then
    Exit;
  if assigned(self.PopupMenu) then
  begin
    if assigned(self.PopupMenu.OnPopup) then
    begin
      FOnMenuPopup := PopupMenu.OnPopup;
    end;
  end
  else
  begin
    PopupMenu := TPopupMenu.Create(self.Parent);
    popumenuCreatebyself := True;
  end;
  PopupMenu.OnPopup := OnMenuPopup;
end;

procedure TNvDbgridEh.toexcel(dbgrideh1: TDBGridEH; xlsFilename: string);
var
  // s: string;
  eclApp, WorkBook: variant;
  a_filedNo, i, j: integer;
  fs: string;
  // p1: array [0 .. 300] of Char;
begin
  // application.ProcessMessages;
 // a_filedNo := dbgrideh1.FieldCount - 1;
  a_filedNo:=0;
  for I := 0 to dbgrideh1.Columns.Count - 1 do
  begin
    if dbgrideh1.Columns[i].Visible then
      a_filedNo:=a_filedNo+1;
  end;


  try
    eclApp := CreateOleObject('EXCEL.Application');
    WorkBook := CreateOleObject('Excel.Sheet');
  except
    Application.MessageBox('您的系统没有安装MicroSoft EXCEL软件，数据不能导出！', '错误提示 ',
      MB_OK + MB_SystemModal + MB_IconStop);
    Exit;
  end;

  try
    WorkBook := eclApp.workBooks.Add;
    for i := 1 to a_filedNo do // 转化字段名；
    begin
       if dbgrideh1.Columns[i].Visible then
         eclApp.cells.item(1, i) := dbgrideh1.Columns[i].Title.Caption;
   //   dbgrideh1.Fields[i].FieldName;
    end;
    // eclApp.cells.Columns[1].numberformatlocal := '@'; // 设置输出格式为文本而不是数字
    //eclApp.cells.Columns[30].numberformatlocal := '@'; // 设置输出格式为文本而不是数字
   // eclApp.cells.Columns[32].numberformatlocal := '@'; // 设置输出格式为文本而不是数字
   // eclApp.cells.Columns[42].numberformatlocal := '@'; // 设置输出格式为文本而不是数字
    dbgrideh1.DataSource.DataSet.First;
    for i := 1 to dbgrideh1.DataSource.DataSet.RecordCount do
    begin
      for j := 1 to a_filedNo do // 转化一个记录
      begin
     //   if dbgrideh1.Columns[j].Visible then
          eclApp.cells.item(i + 1, j) := dbgrideh1.Fields[j].AsString;
      end;
      dbgrideh1.DataSource.DataSet.Next;
    end;

    try
      fs := xlsFilename;
      if FileExists(fs) then
        DeleteFile(fs);
      WorkBook.saveas(fs);
      WorkBook.close;
    except
      Application.MessageBox('保存文件出现异常！', '错误提示 ',
        MB_OK + MB_SystemModal + MB_IconStop);
    end;
  except
    Application.MessageBox('不能正确操作EXECL文件，可能该文件已经被其他程序占用或系统错误！ ', '错误提示 ',
      MB_OK + MB_SystemModal + MB_IconStop);
    WorkBook.close;
    eclApp.quit;
    eclApp := Unassigned;
  end;

end;

procedure TNvDbgridEh.ExpGrid(Sender: Tobject);
begin
  ExpDbgrid;
end;

procedure TNvDbgridEh.PrintGrid(Sender: Tobject);
begin
  PrintPreview;
end;

procedure TNvDbgridEh.SetGridadjuct(Sender: Tobject);
begin
  GridAdject;
end;

procedure TNvDbgridEh.SetGridUser(const Value: integer);
begin
  FGridUser := Value;
  GridAdjectLoad;
end;

procedure TNvDbgridEh.SetAutoAPPPopuMenu(const Value: Boolean);
begin
  FAutoAPPPopuMenu := Value;
  if Value then
  begin
    FAutoGridAdject := Value;
    FAutoGridSave := Value;
  end;
end;

procedure TNvDbgridEh.SetFIsMenuIni(const Value: Boolean);
begin
  FFIsMenuIni := Value;
end;

procedure TNvDbgridEh.SetTitleAlign(const Value: TTitleAlign);
begin
  FTitleAlign := Value;
end;

procedure TNvDbgridEh.setPrintPaper;
begin

  PrinterPreview.Orientation := poPortrait;
  if PrintInfo.GetPageWidth > 0 then
    ApplySettings_xy(PrinterPreview.Printer, PrintInfo.GetPageWidth,
      PrintInfo.GetPageHeight);

  PrinterPreview.Orientation := PrintInfo.PrinterOrientation;

end;


constructor TDBGridEhToExcel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowProgress := True;
  FShowOpenExcel:= True;
end;

procedure TDBGridEhToExcel.SetShowProgress(const Value: Boolean);
begin
  FShowProgress := Value;
end;

procedure TDBGridEhToExcel.SetDBGridEh(const Value: TNvDbgridEh);
begin
  FDBGridEh := Value;
end;

function IsFileInUse(fName: string ): boolean;
var
  HFileRes: HFILE;
begin
  Result :=false;
  if not FileExists(fName) then exit;
  HFileRes :=CreateFile(pchar(fName), GENERIC_READ
               or GENERIC_WRITE,0, nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
  Result :=(HFileRes=INVALID_HANDLE_VALUE);
  if not Result then
      CloseHandle(HFileRes);
end;

procedure TDBGridEhToExcel.ExportToExcel;
var
XLApp: Variant;
Sheet: Variant;
s1, s2: string;
Caption,Msg: String;
//当前列、当前行、列标题开始行
Col, Row,ColumnTitleBeginRow: integer;
//数据开始行
ColumnDataBeginRow: Integer;
//列标题最大行数
MaxColumnTitleRowNum,tmpColumnTitleRowNum:Integer;
FBookMark: TBookmark;
FileName: String;
SaveDialog1: TSaveDialog;
exportColumns:TColumnsEhList;//TDBGridColumnsEh;
begin
    //如果数据集为空或没有打开则退出
    if not DBGridEh.DataSource.DataSet.Active then Exit;
    SaveDialog1 := TSaveDialog.Create(Nil);
    if Trim(DBGridEh.PrintInfo.Title)<>'' then
    begin
      SaveDialog1.FileName := DBGridEh.PrintInfo.Title; // + '_' + FormatDateTime('YYMMDDHHmmSS', now);
    end
    else
    begin
      SaveDialog1.FileName := GetParentForm(DBGridEh,False).Caption; // + '_' + FormatDateTime('YYMMDDHHmmSS', now);
    end;
    SaveDialog1.Filter := 'Excel文件|*.xls';
    if SaveDialog1.Execute then
        FileName := SaveDialog1.FileName;
    SaveDialog1.Free;
    if FileName = '' then Exit;
    while IsFileInUse(FileName) do
    begin
      if Application.MessageBox('目标文件使用中，请退出目标文件后点击确定继续！',
        '注意', MB_OKCANCEL + MB_ICONWARNING) = IDOK then
      begin
      end
      else
      begin
        Exit;
      end;
    end;
    if FileExists(FileName) then
    begin
      Msg := '已存在文件（' + FileName + '），是否覆盖？';
      if Application.MessageBox(PChar(Msg), '提示',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
      begin
        // 删除文件
        DeleteFile(pchar(FileName))
      end
      else
        Exit;
    end;
    if Trim(DBGridEh.PrintInfo.Title)='' then
    begin
      DBGridEh.PrintInfo.Title := ExtractFileName(FileName); // + '_' + FormatDateTime('YYMMDDHHmmSS', now);
    end;
    Application.ProcessMessages;
    Screen.Cursor := crHourGlass;
    // 显示进度窗体
    if ShowProgress then
      CreateProcessForm(nil);

    if not VarIsEmpty(XLApp) then
    begin
      XLApp.quit;
      VarClear(XLApp);
    end;
    // 通过ole创建Excel对象
    try
      XLApp := CreateOleObject('Excel.Application');
      XLApp.DisplayAlerts := false;
    except
      MessageDlg('创建Excel对象失败，请检查你的系统是否正确安装了Excel软件！', mtError, [mbOk], 0);
      Screen.Cursor := crDefault;
      Exit;
    end;
    exportColumns:=DBGridEh.VisibleColumns;//DBGridEh.Columns;
    // 生成工作页
    XLApp.workBooks.Add[XLWBatWorksheet];
    XLApp.workBooks[1].WorkSheets[1].Name := DBGridEh.PrintInfo.Title;
    Sheet := XLApp.workBooks[1].WorkSheets[DBGridEh.PrintInfo.Title];

    Col := 1;
    Row := 1;
    // 写标题
    Sheet.cells[Row, Col] := DBGridEh.PrintInfo.Title;
    Sheet.range[Sheet.cells[Row, Col], Sheet.cells[Row, exportColumns.Count]].Select; // 选择该列
    XLApp.selection.HorizontalAlignment := $FFFFEFF4; // 居中
    XLApp.selection.MergeCells := True; // 合并
    Sheet.Rows[Row].Font.Size:=DBGridEh.PrintInfo.TitleFont.Size;
//    Sheet.Rows[Row].Font.ColorIndex:=DBGridEh.PrintInfo.TitleFont.Color;
    Sheet.Rows[Row].Font.Bold:=true;

    //写pagetop
    if (Trim(DBGridEh.PrintInfo.PageTopLeft)<>'')
      or (Trim(DBGridEh.PrintInfo.PageTopRight)<>'') then
    begin
      Inc(Row);
      if (Trim(DBGridEh.PrintInfo.PageTopLeft)<>'') then
      begin
        Sheet.cells[Row, 1] := DBGridEh.PrintInfo.PageTopLeft;
//        Sheet.cells[Row, 1].horizontalalignment := $ffffefdd;//居左
        Sheet.range[Sheet.cells[Row, 1], Sheet.cells[Row, exportColumns.Count div 2]].Select; // 选择该列
        XLApp.selection.HorizontalAlignment := $ffffefdd;//居左 ; //$FFFFEFF4; // 居中
        XLApp.selection.MergeCells := True; // 合并
      end;
      if (Trim(DBGridEh.PrintInfo.PageTopRight)<>'') then
      begin
        Sheet.cells[Row, exportColumns.Count] := DBGridEh.PrintInfo.PageTopRight;
//        Sheet.cells[Row, exportColumns.Count].horizontalalignment := $ffffefc8;
        Sheet.range[Sheet.cells[Row, (exportColumns.Count div 2) +1],Sheet.cells[Row, exportColumns.Count]].Select; // 选择该列
        XLApp.selection.HorizontalAlignment := $ffffefc8;//居右 ; //$FFFFEFF4; // 居中
        XLApp.selection.MergeCells := True; // 合并
      end;
    end;
    // 写表头
    Col := 1;
    ColumnTitleBeginRow:=Row+1;
    MaxColumnTitleRowNum:=1;
    for Col := 1 to exportColumns.Count do
    begin
      tmpColumnTitleRowNum:=1;
      Row:=ColumnTitleBeginRow;
      Caption := exportColumns[Col-1].Title.Caption;
      while Pos('|', Caption) > 0 do
      begin
        s1 := Copy(Caption, 1, Pos('|', Caption) - 1);
        if s2 = s1 then
        begin
          Sheet.range[Sheet.cells[Row, Col - 1], Sheet.cells[Row, Col]].Select;
          XLApp.selection.HorizontalAlignment := $FFFFEFF4;
          XLApp.selection.MergeCells := True;
        end
        else
          Sheet.cells[Row, Col] := Copy(Caption, 1, Pos('|', Caption) - 1);
        Caption := Copy(Caption, Pos('|', Caption) + 1, Length(Caption));
        Inc(Row);
        Inc(tmpColumnTitleRowNum);
        s2 := s1;
      end;
      if tmpColumnTitleRowNum>MaxColumnTitleRowNum then
      begin
        MaxColumnTitleRowNum:=tmpColumnTitleRowNum;
      end;
      Sheet.cells[Row, Col] := Caption;
    end;
    ColumnDataBeginRow := ColumnTitleBeginRow+MaxColumnTitleRowNum;
    // 垂直合并表头并居中
    if ColumnDataBeginRow > ColumnTitleBeginRow+1 then //列标题不止一行
    begin
      for Col := 1 to exportColumns.Count do
      begin
        for tmpColumnTitleRowNum := ColumnTitleBeginRow+1 to ColumnDataBeginRow - 1 do
        begin
          if Sheet.cells[tmpColumnTitleRowNum, Col].Value = '' then
          begin
            Sheet.range[Sheet.cells[tmpColumnTitleRowNum-1, Col], Sheet.cells[tmpColumnTitleRowNum, Col]].Select;
            XLApp.selection.HorizontalAlignment := $FFFFEFF4;
            XLApp.selection.MergeCells := True;
          end
          else
          begin
            Sheet.cells[tmpColumnTitleRowNum, Col].Select;
            XLApp.selection.HorizontalAlignment := $FFFFEFF4;
          end;
        end;
      end;
    end;
    // 读取数据
    DBGridEh.DataSource.DataSet.DisableControls;
    FBookMark := DBGridEh.DataSource.DataSet.GetBookmark;
    DBGridEh.DataSource.DataSet.First;
    while not DBGridEh.DataSource.DataSet.eof do
    begin
      for Col := 1 to exportColumns.Count do
      begin
        // Sheet.cells[jCount, Col] :=exportColumns.Items[Col-1].Field.AsString;
        case DBGridEh.DataSource.DataSet.FieldByName
          (exportColumns.Items[Col - 1].FieldName).DataType of
          ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
            Sheet.cells[ColumnDataBeginRow, Col] := exportColumns.Items[Col - 1]
              .Field.AsInteger;
          ftFloat, ftCurrency, ftBCD:
            Sheet.cells[ColumnDataBeginRow, Col] := exportColumns.Items[Col - 1]
              .Field.AsFloat;
        else
          if DBGridEh.DataSource.DataSet.FieldByName
            (exportColumns.Items[Col - 1].FieldName) is TBlobfield then
          // 此类型的字段(图像等)暂无法读取显示
            Sheet.cells[ColumnDataBeginRow, Col] := exportColumns.Items[Col - 1]
              .Field.AsString
          else
            Sheet.cells[ColumnDataBeginRow, Col] := '' + exportColumns.Items
              [Col - 1].Field.AsString;
        end;

      end;
      Inc(ColumnDataBeginRow);
      // 显示进度条进度过程
      if ShowProgress then
      begin
        FtempGauge.Position := DBGridEh.DataSource.DataSet.RecNo;
        FtempGauge.Refresh;
      end;
      DBGridEh.DataSource.DataSet.Next;
    end;
    if DBGridEh.DataSource.DataSet.BookmarkValid(FBookMark) then
      DBGridEh.DataSource.DataSet.GotoBookmark(FBookMark);
    DBGridEh.DataSource.DataSet.EnableControls;
    // 读取表脚
    if DBGridEh.FooterRowCount > 0 then
    begin
      for Col := 1 to DBGridEh.FooterRowCount do
      begin
        for Row := 1 to exportColumns.Count do
          Sheet.cells[ColumnDataBeginRow, Row] := DBGridEh.GetFooterValue(Col-1,
            exportColumns[Row-1]);
        Inc(ColumnDataBeginRow);
      end;
    end;
    //页脚
    Sheet.pagesetup.leftFooter :='制表人：'+DBGridEh.PrintInfo.PrintName;
    Sheet.pagesetup.CenterFooter :='第'+'&P'+'页';
    Sheet.pagesetup.rightFooter :='打印时间：'+datetimetostr(now);
    Sheet.pagesetup.PrintGridlines := true;
    // 调整列宽
    for Col := 1 to exportColumns.Count do
    Sheet.Columns[Col].EntireColumn.AutoFit;

    Sheet.cells[1, 1].Select;
    XLApp.workBooks[1].saveas(FileName);
    XLApp.visible := True;
    XLApp := Unassigned;
    if ShowProgress then
      FreeAndNil(FProgressForm);
    Screen.Cursor := crDefault;

  end;

  destructor TDBGridEhToExcel.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TDBGridEhToExcel.CreateProcessForm(AOwner: TComponent);
  var
    Panel: TPanel;
  begin
    if assigned(FProgressForm) then
      Exit;
    FProgressForm := Tform.Create(AOwner);
    with FProgressForm do
    begin
      try
        Font.Name := '宋体'; { 设置字体 }
        Font.Size := 12;
        BorderStyle := bsNone;
        width := 300;
        Height := 30;
        BorderWidth := 1;
        Color := clred;
        Position := poScreenCenter;
        Panel := TPanel.Create(FProgressForm);
        with Panel do
        begin
          Parent := FProgressForm;
          align := alclient;
          Caption := '正在导出Excel，请稍候......';
          Panel.Font.Color:= clred;
        end;
        FtempGauge := TProgressBar.Create(Panel);
        with FtempGauge do
        begin
          Parent := Panel;
          align := alclient;
          Min := 0;
          Max := DBGridEh.DataSource.DataSet.RecordCount;
          Position := 0;
        end;
      except
      end;
    end;
    FProgressForm.Show;
    FProgressForm.Update;
  end;

  procedure TDBGridEhToExcel.SetShowOpenExcel(const Value: Boolean);
  begin
    FShowOpenExcel := Value;
  end;

  end.
