unit NvDbgridEh;

{
  ExpType: TExpType  �����ļ�����;
  ExpOpenType:TOpenType read  �����ļ����Ƿ��
  ShowLineNo :boolean  �Ƿ���ʾ�к�
  SetIndicatorWidth: integer ��ʾ�к�����Ŀ���
  AutoSetMultiSelect: Boolean �Ƿ��Զ����ö���ѡ��
  AutoSetCtrlKey:boolean   ûʲô�õ�
  AutoFocusKey:boolean �Ƿ��Զ��۽���������.(���԰����ּ�����)
  PrintInfo:TPrintInfo ��ӡ������Ϣ
  PrintOptions: ��ӡѡ��
  //pghOptimalColWidths ��ѿ���
  //pghColored ʹ�ñ�����ɫ
  //pghFitGridToPageWidth �������ȣ�Ĭ��Ϊ�������ű�
  //pghFitingByColWidths  ��������
  PrintAutoNewLine :Boolean //�Ƿ��Զ�����
  DBConnect :TADOConnection ���ݿ�����
  AutoGridAdject :Boolean �Ƿ��Զ������п��ȣ�λ��
  AutoGridSave   :boolean read �Ƿ��Զ������п��ȣ�λ��
  AutoAPPPopuMenu  :boolean �Ƿ��Զ������Ҽ��˵�
  GridUser  :Integer ��ǰ�����û�
  ParentName :string ��ǰ��������
  PaperSize :TPaperSize ֽ������ Default;
  // = (poPortrait, poLandscape) ֽ�ŷ���
  PrinterOrientation:TPrinterOrientation  default poPortrait;
  PageWidth:extended ֽֽ����;
  PageHeight:extended �߶� ;

  PrintOptions

  //��������  Title : string r
  //��������  TitleFont:Tfont          2008-11-26 ����
  //��ͷ����  GridHeadFont :TFont;     2008-11-26
  //�Ƿ����·�����  TitleUpLine:boolean
  //�����ռ��� TitleNullLine:integer
  //�ڱ����Ϸ������� ����ͳ�ƻ��� GridTop:string
  //�Ƿ��ӡҳ�� �� n ҳ - �� n ҳ PrintPageFooter:boolean
  //�Ƿ���ҳ�Ŵ�ӡ����PrintPrintFooterTime:boolean
  //�Ƿ��ӡ "��˾��������" PageFooterRight:String
  //�������Ϸ���ӡ����PageTopLeft:string
  //�������Ϸ���ӡ����PageTopRight:string
  //������ӡ��PrintName:string
  //��ӡҳ�����PageSize :TPageParams

}
{ ************************************************************************
  ����˵�� :��DgridEh����һЩ�������ϼ���չ
  ���ϴ�ӡ���������е�����
  ��չ��ӡ���ܣ����ӱ�ͷ����ͱ������幦��
  ��չ������ӡֽ�Ź��ܣ�A4 A3 �Զ���
  ����������Excel�Ķ��ͷ(�޸���DbgridEh�е�������)


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
    // ��Ŀ��������
    procedure GridAdjust(Sender: Tobject; DBGrid: Tobject);
    // DBGRID��ʾ��ʽ���溯��
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
    // ��������
    // Property TitleList :Tstrings read GetTitle write SetTitleList;
    property Title: string read FTitle write SetTitle;
    // ��������
    ProperTy TitleFont: Tfont read FTitleFont write SetTitleFont;
    // ��ͷ����
    ProperTy GridHeadFont: Tfont read FGridHeadFont write SetGridHeadFont;
    // �Ƿ����·�����
    Property TitleUpLine
      : Boolean read FTitleUpLine write SetTitleUpLine default True;
    // �����ռ���
    Property TitleNullLine
      : integer read FTitleNullLine write
      SetTitleNullLine default 3;
    // �ڱ����Ϸ������� ����ͳ�ƻ��� //�������ã��� PageTopRight �� PageTopLeft���
    Property GridTop: string read FGridTop write SetGridTop;
    // �Ƿ��ӡҳ�� �� n ҳ - �� n ҳ
    Property PrintPageFooter: Boolean read FPrintPageFooter write
      SetPrintPageFooter;
    // �Ƿ���ҳ�Ŵ�ӡ����
    Property PrintPrintFooterTime: Boolean read FPrintPrintFooterTime write
      SetPrintPrintFooterTime;
    // �Ƿ��ӡ "����Ƽ�"
    Property PageFooterRight
      : String read GPageFooterRight write SetPageFooterRight;
    // �������Ϸ���ӡ����
    Property PageTopLeft: string read FPageTopLeft write SetPageTopLeft;
    // �������Ϸ���ӡ����
    Property PageTopRight: string read FPageTopRight write SetPageTopRight;
    // ������ӡ��
    Property PrintName: string read FPrintName write SetPrintName;
    // ��ӡҳ�����
    property PageSize: TPageParams read FPageSize write SetPageSize;
    // = (Default,A3,A4,Custom);
    property PaperSize
      : TPaperSize read FPaperSize write SetPaperSize default Default;
    // = (poPortrait, poLandscape) ֽ�ŷ���
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
      SetPrintAutoNewLine default True; // �Ƿ��Զ�����
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
    FProgressForm: TForm;                                  {���ȴ���}
    FtempGauge: TProgressBar;                           {������}
    FShowProgress: Boolean;                                {�Ƿ���ʾ���ȴ���}
    FShowOpenExcel:Boolean;                                {�Ƿ񵼳����Excel�ļ�}
    FDBGridEh: TNvDbgridEh;
    procedure SetShowProgress(const Value: Boolean);       {�Ƿ���ʾ������}
    procedure SetShowOpenExcel(const Value: Boolean);      {�Ƿ�����ɵ�Excel�ļ�}
    procedure SetDBGridEh(const Value: TNvDbgridEh);
    procedure CreateProcessForm(AOwner: TComponent);       {���ɽ��ȴ���}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExportToExcel; {���Excel�ļ�}
  published
    property DBGridEh: TNvDbgridEh read FDBGridEh write SetDBGridEh;
    property ShowProgress: Boolean read FShowProgress write SetShowProgress;    //�Ƿ���ʾ������
    property ShowOpenExcel: Boolean read FShowOpenExcel write SetShowOpenExcel; //�Ƿ��Excel
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
      // ����������������
      canvas.Font.Color := Cr;
    end;
  end;

  inherited;
end;

var
  ASC: Boolean = True;

  // �Ƿ���������
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
//  SaveDialog.Title := '��ѡ�񵼳��ļ�����·��!';
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
//      if MessageDlg('�ļ��������ڣ��Ƿ񸲸�?', mtConfirmation, [mbYes, mbNo], 0)
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
//            if MessageDlg('�Ƿ��?', mtConfirmation, [mbYes, mbNo], 0)
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
//        ShowMessage('����ʧ��!' + E.Message);
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
/// ////////���Ӷ����Զ������͵�ֽ���趨 20070609
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
        // �Զ���ֽ�Ŵ�С
        PDMode^.dmFields :=
          PDMode^.dmFields or dm_PaperSize or DM_PAPERWIDTH or DM_PAPERLENGTH;
        // 9 A4   DMPAPER_USER
        // 8 A3
        PDMode^.dmPaperSize := DMPAPER_USER;
        // showmessage(inttostr(pdmode^.dmorientation));
        { һ��Ҫ�����������жϣ�����ֽ�ŵķ�������ѡ�񳤡�
          ����x,y)��ʹ�����������ʹ�������͵�����һ�����һ��
          dmorient_landscapeֵΪ2��dmorient_portraitֵΪ1
          }
        // ����ɾ����ӡ����ӡ���������
        // ���趨�Ĵ�С��ӡ
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
  FPageFooterRight := '����Ƽ�';
  FPrintPageFooter := True;
  FTitleUpLine := True;
  FPrintPrintFooterTime := True;

  inherited Create();
  FTitleList := Tstringlist.Create;
  FTitleFont := Tfont.Create;
  FGridHeadFont := Tfont.Create;
  FPageSize := TPageParams.Create;
  FTitleFont.Name := '����'; // Screen.Forms[0].Font.name;
  FTitleFont.Size := 16;
  // FTitleFont.Charset = GB2312_CHARSET
  // FTitleFont.Color = clWindowText
  // FTitleFont.Height = -19
  // FTitleFont.Name = '����'
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
  // ����������
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
    PrintDBGridEh.PageFooter.CenterText.Text := '�� &[Page] ҳ - �� &[Pages] ҳ';
  end;
  if PrintInfo.PrintName <> '' then
  begin
    PrintDBGridEh.PageFooter.CenterText.Text := trim
      (PrintDBGridEh.PageFooter.CenterText.Text)
      + '         �Ʊ���:' + PrintInfo.PrintName;
  end;
  if PrintInfo.PrintPrintFooterTime then
  begin
    PrintDBGridEh.PageFooter.LeftText.Text := '��ӡʱ�� &[Date] &[time]';
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

// ���ô�ӡ��
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
    SetForm.Caption := '��ӡ��Ŀѡ��';
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
    Bt_yes.Caption := '��ӡ';
    Bt_yes.Font.Style := [fsBold];
    Bt_yes.top := SetForm.Height - 60;
    Bt_yes.Height := 25;
    Bt_yes.width := 75;
    Bt_yes.Left := 10;
    Bt_yes.Parent := SetForm;
    Bt_no := TBitBtn.Create(SetForm);
    Bt_no.Name := 'Bt_no';
    Bt_no.Kind := bkNo;
    Bt_no.Caption := 'ȡ��';

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
    ShowMessage('��������');
    Exit;
  end;
  form := Tform.Create(Application);
  with form do
  begin
    BorderStyle := bsNone; // bsDialog;
    Caption := '��Ŀ����';
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
      // ����
      try
        close;
        Params.ParamByName('userid').Value := User_id;
        Params.ParamByName('componentname').Value := Grid_name;
        active := True;
        if RecordCount > 0 then
        begin
          TCrackNvDbgridEh(SourceDBGrid1).BeginLayout;
          Columns.Clear;
          // ���ҵ�ǰ���е���Ŀ
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
                  // �����뵱ǰdbgrid ��
                  // �������ݿ����е�
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
          // �������ݿ���û�е�,�¼ӵ��ֶ�
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
  // ����ԭ����
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
      if Pos('��Ŀ����', PopupMenu.Items.Items[i].Caption) > 0 then
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
    MenuItem.Caption := '��Ŀ����';
    MenuItem.OnClick := SetGridadjuct;
    MenuItem.Name := self.Name + 'N_1';
    self.PopupMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '����';
    MenuItem.OnClick := ExpGrid;
    MenuItem.Name := self.Name + 'N_2';
    self.PopupMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '��ӡ';
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
    Application.MessageBox('����ϵͳû�а�װMicroSoft EXCEL���������ݲ��ܵ�����', '������ʾ ',
      MB_OK + MB_SystemModal + MB_IconStop);
    Exit;
  end;

  try
    WorkBook := eclApp.workBooks.Add;
    for i := 1 to a_filedNo do // ת���ֶ�����
    begin
       if dbgrideh1.Columns[i].Visible then
         eclApp.cells.item(1, i) := dbgrideh1.Columns[i].Title.Caption;
   //   dbgrideh1.Fields[i].FieldName;
    end;
    // eclApp.cells.Columns[1].numberformatlocal := '@'; // ���������ʽΪ�ı�����������
    //eclApp.cells.Columns[30].numberformatlocal := '@'; // ���������ʽΪ�ı�����������
   // eclApp.cells.Columns[32].numberformatlocal := '@'; // ���������ʽΪ�ı�����������
   // eclApp.cells.Columns[42].numberformatlocal := '@'; // ���������ʽΪ�ı�����������
    dbgrideh1.DataSource.DataSet.First;
    for i := 1 to dbgrideh1.DataSource.DataSet.RecordCount do
    begin
      for j := 1 to a_filedNo do // ת��һ����¼
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
      Application.MessageBox('�����ļ������쳣��', '������ʾ ',
        MB_OK + MB_SystemModal + MB_IconStop);
    end;
  except
    Application.MessageBox('������ȷ����EXECL�ļ������ܸ��ļ��Ѿ�����������ռ�û�ϵͳ���� ', '������ʾ ',
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
//��ǰ�С���ǰ�С��б��⿪ʼ��
Col, Row,ColumnTitleBeginRow: integer;
//���ݿ�ʼ��
ColumnDataBeginRow: Integer;
//�б����������
MaxColumnTitleRowNum,tmpColumnTitleRowNum:Integer;
FBookMark: TBookmark;
FileName: String;
SaveDialog1: TSaveDialog;
exportColumns:TColumnsEhList;//TDBGridColumnsEh;
begin
    //������ݼ�Ϊ�ջ�û�д����˳�
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
    SaveDialog1.Filter := 'Excel�ļ�|*.xls';
    if SaveDialog1.Execute then
        FileName := SaveDialog1.FileName;
    SaveDialog1.Free;
    if FileName = '' then Exit;
    while IsFileInUse(FileName) do
    begin
      if Application.MessageBox('Ŀ���ļ�ʹ���У����˳�Ŀ���ļ�����ȷ��������',
        'ע��', MB_OKCANCEL + MB_ICONWARNING) = IDOK then
      begin
      end
      else
      begin
        Exit;
      end;
    end;
    if FileExists(FileName) then
    begin
      Msg := '�Ѵ����ļ���' + FileName + '�����Ƿ񸲸ǣ�';
      if Application.MessageBox(PChar(Msg), '��ʾ',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
      begin
        // ɾ���ļ�
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
    // ��ʾ���ȴ���
    if ShowProgress then
      CreateProcessForm(nil);

    if not VarIsEmpty(XLApp) then
    begin
      XLApp.quit;
      VarClear(XLApp);
    end;
    // ͨ��ole����Excel����
    try
      XLApp := CreateOleObject('Excel.Application');
      XLApp.DisplayAlerts := false;
    except
      MessageDlg('����Excel����ʧ�ܣ��������ϵͳ�Ƿ���ȷ��װ��Excel������', mtError, [mbOk], 0);
      Screen.Cursor := crDefault;
      Exit;
    end;
    exportColumns:=DBGridEh.VisibleColumns;//DBGridEh.Columns;
    // ���ɹ���ҳ
    XLApp.workBooks.Add[XLWBatWorksheet];
    XLApp.workBooks[1].WorkSheets[1].Name := DBGridEh.PrintInfo.Title;
    Sheet := XLApp.workBooks[1].WorkSheets[DBGridEh.PrintInfo.Title];

    Col := 1;
    Row := 1;
    // д����
    Sheet.cells[Row, Col] := DBGridEh.PrintInfo.Title;
    Sheet.range[Sheet.cells[Row, Col], Sheet.cells[Row, exportColumns.Count]].Select; // ѡ�����
    XLApp.selection.HorizontalAlignment := $FFFFEFF4; // ����
    XLApp.selection.MergeCells := True; // �ϲ�
    Sheet.Rows[Row].Font.Size:=DBGridEh.PrintInfo.TitleFont.Size;
//    Sheet.Rows[Row].Font.ColorIndex:=DBGridEh.PrintInfo.TitleFont.Color;
    Sheet.Rows[Row].Font.Bold:=true;

    //дpagetop
    if (Trim(DBGridEh.PrintInfo.PageTopLeft)<>'')
      or (Trim(DBGridEh.PrintInfo.PageTopRight)<>'') then
    begin
      Inc(Row);
      if (Trim(DBGridEh.PrintInfo.PageTopLeft)<>'') then
      begin
        Sheet.cells[Row, 1] := DBGridEh.PrintInfo.PageTopLeft;
//        Sheet.cells[Row, 1].horizontalalignment := $ffffefdd;//����
        Sheet.range[Sheet.cells[Row, 1], Sheet.cells[Row, exportColumns.Count div 2]].Select; // ѡ�����
        XLApp.selection.HorizontalAlignment := $ffffefdd;//���� ; //$FFFFEFF4; // ����
        XLApp.selection.MergeCells := True; // �ϲ�
      end;
      if (Trim(DBGridEh.PrintInfo.PageTopRight)<>'') then
      begin
        Sheet.cells[Row, exportColumns.Count] := DBGridEh.PrintInfo.PageTopRight;
//        Sheet.cells[Row, exportColumns.Count].horizontalalignment := $ffffefc8;
        Sheet.range[Sheet.cells[Row, (exportColumns.Count div 2) +1],Sheet.cells[Row, exportColumns.Count]].Select; // ѡ�����
        XLApp.selection.HorizontalAlignment := $ffffefc8;//���� ; //$FFFFEFF4; // ����
        XLApp.selection.MergeCells := True; // �ϲ�
      end;
    end;
    // д��ͷ
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
    // ��ֱ�ϲ���ͷ������
    if ColumnDataBeginRow > ColumnTitleBeginRow+1 then //�б��ⲻֹһ��
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
    // ��ȡ����
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
          // �����͵��ֶ�(ͼ���)���޷���ȡ��ʾ
            Sheet.cells[ColumnDataBeginRow, Col] := exportColumns.Items[Col - 1]
              .Field.AsString
          else
            Sheet.cells[ColumnDataBeginRow, Col] := '' + exportColumns.Items
              [Col - 1].Field.AsString;
        end;

      end;
      Inc(ColumnDataBeginRow);
      // ��ʾ���������ȹ���
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
    // ��ȡ����
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
    //ҳ��
    Sheet.pagesetup.leftFooter :='�Ʊ��ˣ�'+DBGridEh.PrintInfo.PrintName;
    Sheet.pagesetup.CenterFooter :='��'+'&P'+'ҳ';
    Sheet.pagesetup.rightFooter :='��ӡʱ�䣺'+datetimetostr(now);
    Sheet.pagesetup.PrintGridlines := true;
    // �����п�
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
        Font.Name := '����'; { �������� }
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
          Caption := '���ڵ���Excel�����Ժ�......';
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