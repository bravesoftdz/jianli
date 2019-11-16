unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, StdCtrls, ExtCtrls, ComCtrls, ToolWin, OleCtrls,
  AcWebClient_TLB;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N7: TMenuItem;
    NRecent: TMenuItem;
    N8: TMenuItem;
    N19: TMenuItem;
    N9: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
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
    But1: TToolButton;
    PrevPageBtn: TToolButton;
    NextPageBtn: TToolButton;
    But2: TToolButton;
    Panel5: TPanel;
    GotoEd: TEdit;
    ToolButton3: TToolButton;
    CloseBtn: TToolButton;
    ImageList1: TImageList;
    AcWebClientView1: TAcWebClientView;
    procedure OpenCmdClick(Sender: TObject);
    procedure SaveCmdClick(Sender: TObject);
    procedure PgSetupBtnClick(Sender: TObject);
    procedure ExpExcelCmdClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure PageSizeCmdClick(Sender: TObject);
    procedure ZoomInCmdClick(Sender: TObject);
    procedure ZoomOutCmdClick(Sender: TObject);
    procedure But1Click(Sender: TObject);
    procedure PrevPageBtnClick(Sender: TObject);
    procedure NextPageBtnClick(Sender: TObject);
    procedure But2Click(Sender: TObject);
    procedure GotoEdKeyPress(Sender: TObject; var Key: Char);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    procedure OpenFile(AFileName: string);
    procedure SetTitle(sFile: string);
    procedure ClearRecent;
    procedure ReadRecent;
    procedure SetRecent(sFile: string);
    procedure SetDocRelation;
    procedure OnRecentMenuClick(Sender: TObject);
    procedure OnClearRecentClick(Sender: TObject);
    procedure SetRegisterInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses Registry, ShlObj, rv_about;

{$R *.dfm}
{$R XpStyle.RES}

procedure TMainForm.OpenFile(AFileName: string);
begin
  AcWebClientView1.OpenRepFromFile(AFileName, false);
  GotoEd.Text := '1';
  SetTitle(AFileName);
  SetRecent(AFileName);
end;

procedure TMainForm.SetTitle(sFile: string);
var
 s: string;
begin
 s := 'AC Report 报表查看器';
 if sFile <> '' then
   s := s + '-[' + sFile + ']';
 Caption := s;
end;

procedure TMainForm.SetRecent(sFile: string);
var
  r: TRegistry;
  sKey, sValue: string;
  st: TStrings;
begin
 try
   r := TRegistry.Create;
   st := TStringList.Create;
   r.RootKey := HKEY_LOCAL_MACHINE;
   sKey := '\Software\anycell\recent';
   r.OpenKey(sKey, true);
   r.GetValueNames(st);
   if not r.ValueExists(sFile) then
   begin
     if st.Count > 7 then
       r.DeleteValue(st[0]);
     r.WriteString(sFile, '');
   end;
 finally
   r.CloseKey;
   r.Free;
   st.Free;
 end;
end;

procedure TMainForm.ReadRecent;
var
  r: TRegistry;
  sKey, sValue: string;
  st: TStrings;
  aMenu: TMenuItem;
  i: integer;
begin
 try
   r := TRegistry.Create;
   st := TStringList.Create;
   r.RootKey := HKEY_LOCAL_MACHINE;
   sKey := '\Software\anycell\recent';
   r.OpenKey(sKey, true);
   r.GetValueNames(st);
   if st.Count >0 then
   begin
     NRecent.Clear;
     for i := st.Count -1 downto 0 do
     begin
       aMenu := TMenuItem.Create(self);
       NRecent.Add(aMenu);
       aMenu.Caption := st[i];
       aMenu.OnClick := OnRecentMenuClick;
     end;
     aMenu := TMenuItem.Create(self);
     aMenu.Caption := '-';
     NRecent.Add(aMenu);
     aMenu := TMenuItem.Create(self);
     aMenu.Caption := '清除最近打开文件记录';
     aMenu.OnClick := OnClearRecentClick;
     NRecent.Add(aMenu);
   end;  
 finally
   r.CloseKey;
   r.Free;
   st.Free;
 end;
end;

procedure TMainForm.ClearRecent;
var
  r: TRegistry;
  sKey, sValue: string;
  st: TStrings;
  aMenu: TMenuItem;
  i: integer;
begin
 try
   r := TRegistry.Create;
   st := TStringList.Create;
   r.RootKey := HKEY_LOCAL_MACHINE;
   sKey := '\Software\anycell\recent';
   r.OpenKey(sKey, true);
   r.GetValueNames(st);
   for i := 0 to st.Count -1 do
     r.DeleteValue(st[i]);
   NRecent.Clear;
 finally
   r.CloseKey;
   r.Free;
   st.Free;
 end;
end;

procedure TMainForm.SetDocRelation;
var
  lphKey: HKEY;
  sKeyName: string;
  sKeyValue: string;
  sApp:string;
begin
  sApp := Application.ExeName;

  sKeyName := 'acr.FileType';
  sKeyValue := 'Anycell Report 报表文档';
  RegCreateKey(HKEY_CLASSES_ROOT, PChar(sKeyName), lphKey);
  RegSetValue(lphKey, '', REG_SZ, PChar(sKeyValue), 0);

  sKeyName := '.acr';
  sKeyValue := 'acr.FileType';
  RegCreateKey(HKEY_CLASSES_ROOT, PChar(sKeyName), lphKey);
  RegSetValue(lphKey, '', REG_SZ, PChar(sKeyValue), 0);

  sKeyName := 'acr.FileType';
  sKeyValue := '"'+sApp+'"'+' "%1"';
  RegCreateKey(HKEY_CLASSES_ROOT, PChar(sKeyName), lphKey);
  RegSetValue(lphKey, 'Shell\Open\Command', REG_SZ, PChar(sKeyValue), MAX_PATH);

  sKeyName := 'acr.FileType';
  sKeyValue := sApp+',0';
  RegCreateKey(HKEY_CLASSES_ROOT,PChar(sKeyName), lphKey);
  RegSetValue(lphKey, 'DefaultIcon', REG_SZ, PChar(sKeyValue), MAX_PATH);
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TMainForm.SetRegisterInfo;
var
  ErrCode: integer;
  ErrMsg: WideString;
begin
  AcWebClientView1.ReportEngine.SetRegisterInfo('280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D' +
       '3D7DCD1DDCDD6D78680D8AD0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D',

                '天方工作室(acreport@sina.com qq:1655373859)', '23bd', '', '', '', '', ErrCode, ErrMsg);

 if ErrCode <> 0 then
   ShowMessage(ErrMsg)
 else
   AcWebClientView1.RefreshRegInfo;  

 //注册信息整个应用中只需要设置一次，针对任何一个AcReportEngine对象设置即可，其它的对象实例不需要再调用此方法
end;

procedure TMainForm.OnRecentMenuClick(Sender: TObject);
begin
  OpenFile(TMenuItem(Sender).Caption);
end;

procedure TMainForm.OnClearRecentClick(Sender: TObject);
begin
 if Application.MessageBox('确定要清除最近打开文件记录吗？', '提示', MB_YESNO) = ID_YES then
   ClearRecent;
end;

procedure TMainForm.OpenCmdClick(Sender: TObject);
begin
  AcWebClientView1.ShowOpenDlg;
end;

procedure TMainForm.SaveCmdClick(Sender: TObject);
begin
  AcWebClientView1.ShowSaveDlg;
end;

procedure TMainForm.PgSetupBtnClick(Sender: TObject);
begin
  AcWebClientView1.ShowPageSetDlg;
end;

procedure TMainForm.ExpExcelCmdClick(Sender: TObject);
begin
  AcWebClientView1.ShowExportToExcelDlg;
end;

procedure TMainForm.PrintBtnClick(Sender: TObject);
begin
  AcWebClientView1.ShowPrintDlg;
end;

procedure TMainForm.PageSizeCmdClick(Sender: TObject);
begin
  AcWebClientView1.SetToPageSize;
end;

procedure TMainForm.ZoomInCmdClick(Sender: TObject);
begin
  AcWebClientView1.ZoomIn;
end;

procedure TMainForm.ZoomOutCmdClick(Sender: TObject);
begin
  AcWebClientView1.ZoomOut;
end;

procedure TMainForm.But1Click(Sender: TObject);
begin
  AcWebClientView1.GotoFirstPage;
  GotoEd.Text := '1';
end;

procedure TMainForm.PrevPageBtnClick(Sender: TObject);
begin
  AcWebClientView1.GotoPriorPage;
  GotoEd.Text := inttostr(AcWebClientView1.GetCurPageIndex);
end;

procedure TMainForm.NextPageBtnClick(Sender: TObject);
begin
  AcWebClientView1.GotoNextPage;
  GotoEd.Text := inttostr(AcWebClientView1.GetCurPageIndex);
end;

procedure TMainForm.But2Click(Sender: TObject);
begin
  AcWebClientView1.GotoLastPage;
  GotoEd.Text := inttostr(AcWebClientView1.GetCurPageIndex);
end;

procedure TMainForm.GotoEdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    AcWebClientView1.GotoPage(strtoint(GotoEd.Text)) 
end;

procedure TMainForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    AcWebClientView1.ToolBarVisible := false;
    SetRegisterInfo;
  // if ParamStr(1) = '' then
      SetDocRelation;
      
    if ParamStr(1) <> '' then
    begin
      OpenFile(ParamStr(1));
      SetTitle(ParamStr(1));
    end
    else
      SetTitle('');
    ReadRecent;
end;


procedure TMainForm.N7Click(Sender: TObject);
begin
  OpenCmdClick(nil);
end;

procedure TMainForm.N8Click(Sender: TObject);
begin
  SaveCmdClick(nil);
end;

procedure TMainForm.N9Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.N6Click(Sender: TObject);
begin
  with TfrmRv_about.Create(nil) do
  begin
    ShowModal;
    Free;
  end;
end;

end.
