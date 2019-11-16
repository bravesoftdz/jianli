unit CustPreview;

interface

uses
 StdCtrls, ExtCtrls, Controls, Buttons, ACReportClass, Classes, Forms,
 Windows, ACStream, Sysutils, Dialogs, Printers, Menus,
 ComCtrls, AC_FlEdit, AC_Fonts, ToolWin, ImgList, Graphics, messages;

 type
  TPreviewForm = class(TForm)
    Panel4: TPanel;
    Bevel2: TBevel;
    PageLabel: TLabel;
    Bevel4: TBevel;
    RegInfoLabel: TLabel;
    prgBar: TProgressBar;
    ToolBar1: TToolBar;
    OpenCmd: TToolButton;
    SaveCmd: TToolButton;
    ToolButton6: TToolButton;
    PgSetupBtn: TToolButton;
    ToolButton8: TToolButton;
    ExpExcelCmd: TToolButton;
    PrintBtn: TToolButton;
    ToolButton12: TToolButton;
    PageSizeCmd: TToolButton;
    ZoomInCmd: TToolButton;
    ZoomOutCmd: TToolButton;
    ToolButton2: TToolButton;
    ToolButton16: TToolButton;
    But1: TToolButton;
    PrevPageBtn: TToolButton;
    NextPageBtn: TToolButton;
    But2: TToolButton;
    ToolButton24: TToolButton;
    Panel5: TPanel;
    GotoEd: TACFloatEdit;
    ToolButton3: TToolButton;
    CloseBtn: TToolButton;
    FView: TAcPreview;
    Panel1: TPanel;
    ScaleComboBox: TAcComboBox;
    ImageList1: TImageList;
    procedure ScaleComboBoxChange(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ZoomOutCmdClick(Sender: TObject);
    procedure ZoomInCmdClick(Sender: TObject);
    procedure SaveCmdClick(Sender: TObject);
    procedure OpenCmdClick(Sender: TObject);
    procedure ExpExcelCmdClick(Sender: TObject);
    procedure PgSetupBtnClick(Sender: TObject);
    procedure GotoEdKeyPress(Sender: TObject; var Key: Char);
    procedure GotoEdEnter(Sender: TObject);
    procedure GotoEdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure But1Click(Sender: TObject);
    procedure PrevPageBtnClick(Sender: TObject);
    procedure NextPageBtnClick(Sender: TObject);
    procedure But2Click(Sender: TObject);
    procedure PageSizeCmdClick(Sender: TObject);
    procedure OnShowReport(Sender: TObject);
    procedure OnPrepareEnd(Sender: TObject);
    procedure AfterPageChanged(Sender: TObject);
    procedure AfterZoomChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    //FReport :TACReport;
    procedure SetTitle;
  public
    { Public declarations }
    procedure ShowPreview(AReport :TACReport);
  end;

var
  PreviewForm: TPreviewForm;
  EE:Boolean= false;


implementation
uses AC_Utils, AC_const, AC_ExportExcel, AC_E_Xls, AC_info,
     AC_Printer;

{$R *.DFM}


procedure TPreviewForm.ShowPreview(AReport :TACReport);
var
  i: integer;
begin
   if (AReport = nil) then
     Exit;
//  FReport := AReport;
  FView.Report := AReport;

  for i := 0 to ToolBar1.ControlCount - 1 do
  if ToolBar1.Controls[i] is TToolButton then
  with TToolButton(ToolBar1.Controls[i]) do
    if Tag >= 0 then
      Visible := (TAcPreviewButton(Tag) in FView.Report.PreviewOptions.Buttons);

  if not Active then
  if FView.Report.PreviewOptions.Modal then
    ShowModal
  else
    Show;  
end;


procedure TPreviewForm.ScaleComboBoxChange(Sender: TObject);
var
  nScale: Integer;
  ts :string;
begin
  if (ScaleComboBox.Tag = 1) or
    (ScaleComboBox.Items.IndexOf(ScaleComboBox.Text) < 0) then
    Exit;

  ts := ScaleComboBox.Text;
  if Copy(ts, length(ts), 1) <>'%' then
    Exit;
  try
   nScale := strtoint(Copy(ts, 1, length(ts)-1));
  except
   nScale := 100;
  end;
  FView.Scale := nScale;
end;

procedure TPreviewForm.PrintBtnClick(Sender: TObject);
var
  PrintDlg: TPrintDialog;
  I: Integer;
  strFileDir: TFileName;
  AFromPage,AToPage, ACopies:integer;  
begin
  if Printer.Printers.Count <= 0 then
  begin
    Application.Messagebox('未安装打印机', '警告', MB_OK + MB_iconwarning);
    Exit;
  end;

  PrintDlg := TPrintDialog.Create(Self);
  PrintDlg.MinPage := 1;
  PrintDlg.MaxPage := FView.Report.PreparedPages.Count;
  PrintDlg.FromPage := 1;
  PrintDlg.ToPage := FView.Report.PreparedPages.Count;
  PrintDlg.Copies := 1;
  PrintDlg.Options := [poPageNums];

  if not PrintDlg.Execute then
  begin
    PrintDlg.Free;
    Exit;
  end;

  AFromPage:=PrintDlg.FromPage;
  AToPage:= PrintDlg.ToPage;
  ACopies := PrintDlg.Copies;

  CloseBtn.Enabled := false;

  FView.Report.PrintPrepared(AFromPage-1, AToPage-1, ACopies);
  CloseBtn.Enabled := true;
  PrintDlg.Free;
end;

procedure TPreviewForm.CloseBtnClick(Sender: TObject);
begin
  FView.Report.CancelPrepare;
  Close;
end;

procedure TPreviewForm.OnShowReport(Sender: TObject);
begin
  PageLabel.Caption := '第'+inttostr(FView.PageIndex)+'页/共'+inttostr(FView.PageCount)+'页';
  GotoEd.Value := 1;
  GotoEd.Max := FView.Report.PreparedPages.Count;
  if (FView.Report.PreparedPages.Count > 0) and
   not (FView.ReportCtrlView.Visible) then
  begin
    FView.PageIndex := 1;
    FView.ReportCtrlView.Visible := true;
  end;
end;

procedure TPreviewForm.OnPrepareEnd(Sender: TObject);
begin
  if FView.Report.PreparedPages.Count <= 0 then
    Close;
end;

procedure TPreviewForm.AfterPageChanged(Sender: TObject);
begin
  PageLabel.Caption := '第'+inttostr(FView.PageIndex)+'页/共'+inttostr(FView.PageCount)+'页';
  GotoEd.Value := FView.PageIndex;
  SetTitle;
end;

procedure TPreviewForm.AfterZoomChanged(Sender: TObject);
var
  s: string;
  i: integer;
begin
  s := inttostr(FView.Scale) +'%';
  i := ScaleComboBox.Items.IndexOf(s);
  if i <> -1 then
    SCaleComboBox.ItemIndex := i;
end;

procedure TPreviewForm.SetTitle;
begin
  Caption := FView.Report.PreviewOptions.PreviewFormTitle
end;

procedure TPreviewForm.FormCreate(Sender: TObject);
begin
{  FView := TAcPreview.Create(Self);
  FView.OnShowReport := OnShowReport;
  FView.OnPrepareEnd := OnPrepareEnd;
  FView.AfterZoomChanged := AfterZoomChanged;
  FView.AfterPageChanged := AfterPageChanged;
}
  FView.PrgBar := PrgBar;
  FView.Parent := Self;
  FView.Align := alClient;
  ScaleComboBox.ItemIndex := 2;  
  SetTitle;
end;

procedure TPreviewForm.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin   
    FView.VertScrollBar.Position  :=
       FView.VertScrollBar.Position + 24;
    Handled := true;
end;

procedure TPreviewForm.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
    FView.VertScrollBar.Position  :=
       FView.VertScrollBar.Position - 24;
    Handled := true;
end;

procedure TPreviewForm.ZoomOutCmdClick(Sender: TObject);
begin
   if ScaleComboBox.ItemIndex <  ScaleComboBox.Items.Count -1 then
   begin
    ScaleComboBox.Itemindex := ScaleComboBox.Itemindex +1;
    ScaleComboBoxChange(nil);
   end;
end;

procedure TPreviewForm.ZoomInCmdClick(Sender: TObject);
begin
   if ScaleComboBox.ItemIndex >0  then
   begin
    ScaleComboBox.Itemindex := ScaleComboBox.Itemindex -1;
    ScaleComboBoxChange(nil);
   end;
end;

procedure TPreviewForm.SaveCmdClick(Sender: TObject);
begin
  FView.SaveDlg;
end;

procedure TPreviewForm.OpenCmdClick(Sender: TObject);
begin
   FView.OpenDlg;
end;

procedure TPreviewForm.ExpExcelCmdClick(Sender: TObject);
begin
  FView.ExportExcel;
end;

procedure TPreviewForm.PgSetupBtnClick(Sender: TObject);
Begin
  FView.ShowPageSetup;
end;

procedure TPreviewForm.GotoEdKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
   if GotoEd.Value <= FView.Report.PreparedPages.Count then
   begin
     FView.PageIndex := (trunc(GotoEd.Value));
     GotoEd.SelectAll;
     Key := #0;
   end;
  end;
end;

procedure TPreviewForm.GotoEdEnter(Sender: TObject);
begin
  GotoEd.SelectAll;
end;

procedure TPreviewForm.GotoEdMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  GotoEd.SelectAll;
end;

procedure TPreviewForm.FormDestroy(Sender: TObject);
begin
  FView.Report.ClearPreparedPages;
  FView.Free;
end;

procedure TPreviewForm.But1Click(Sender: TObject);
begin
  FView.First;
end;

procedure TPreviewForm.PrevPageBtnClick(Sender: TObject);
begin
  FView.Prior;
end;

procedure TPreviewForm.NextPageBtnClick(Sender: TObject);
begin
  FView.Next;
end;

procedure TPreviewForm.But2Click(Sender: TObject);
begin
  FView.Last;
end;

procedure TPreviewForm.PageSizeCmdClick(Sender: TObject);
begin
  FView.SetToPageWidth;
end;

procedure TPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //如果本Form是动太创建需执行:
  //Action := caFree;
  //如果是全局的Form则执行：
  FView.Report.ClearPreparedPages;  //清除上一次的预览结果
  FView.ReportCtrlView.Visible := false;
end;

end.

