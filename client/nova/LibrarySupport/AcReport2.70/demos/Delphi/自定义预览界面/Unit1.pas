unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  ImgList, OleCtrls, AcWebClient_TLB, AcReport_TLB, ACRptUtils, DB, ADODB;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
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
    ToolButton3: TToolButton;
    CloseBtn: TToolButton;
    AcWebClientView1: TAcWebClientView;
    Button1: TButton;
    Button2: TButton;
    CBShowDefaultToolBar: TCheckBox;
    Button3: TButton;
    MainConn: TADOConnection;
    qryEmp: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField1: TDateTimeField;
    BooleanField1: TBooleanField;
    StringField6: TStringField;
    DateTimeField2: TDateTimeField;
    IntegerField1: TIntegerField;
    DateTimeField3: TDateTimeField;
    StringField7: TStringField;
    DateTimeField4: TDateTimeField;
    StringField8: TStringField;
    qryEmpXueLi: TStringField;
    qryEmpXueLiN: TStringField;
    qryEmpG_email: TStringField;
    Label1: TLabel;
    EdLeftMg: TEdit;
    EdTopMg: TEdit;
    Label2: TLabel;
    Button4: TButton;
    GotoEd: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CBShowDefaultToolBarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
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
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    FRptEngineObj: TAcRptEngine;
    FRptEngineInt: IAcRptEngine;
    procedure ConnToDb;
    procedure InitAC;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rpt_path: string;
  
implementation

{$R *.dfm}
{$R XpStyle.RES}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FRptEngineObj := TAcRptEngine.Create(Self);
 // FRptEngineInt := AcWebclientView1.ReportEngine;  //直接取得ClientView自带的AcRptEngine对象接口。也可以用 FRptEngine := TAcRptEngine.Create(Self)来创建一个对象;
  AcWebClientView1.ToolBarVisible := false;  //设置默认工具栏为不可见
  CBShowDefaultToolBar.Checked := false;
  rpt_path := ExtractFilePath(ParamStr(0)) + '..\..\reports\';
  ConnToDb;
  InitAC;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close
end;

procedure TForm1.CBShowDefaultToolBarClick(Sender: TObject);
begin
  AcWebClientView1.ToolBarVisible := CBShowDefaultToolBar.Checked;
  ToolBar1.Visible := not AcWebClientView1.ToolBarVisible;
end;

procedure TForm1.ConnToDb;
begin        
  mainConn.connected := false;
  mainConn.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=admin;'+
    'Data Source= ' + ExtractFilePath(ParamStr(0)) + '..\..\data\ReportDemo.mdb'+';'+
    'Mode=Share Deny None;Extended Properties="";'+
    'Persist Security Info=False;Jet OLEDB:System database="";'+
    'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;'+
    'Jet OLEDB:Database Locking Mode=0;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
    'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False; Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
 mainConn.Connected := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ANetStream: TAcNetStream;
  st: TStream;
  n: integer;
  ws: WideString;
begin
  FRptEngineObj.PrepareReport;
 // st := TMemoryStream.Create;
 // ANetStream := TAcNetStream.Create(st);
  try
                                                   
   { //通过流交换数据的方式
    //不建议这种方式，通过接口访问流的速度很慢，当页数很多时，与直接访问文件对比非常明显
    if FRptEngineObj.ExportToAcrStream(ANetStream) <> 0 then
    begin
      FRptEngine.GetLastError(n, ws);
      ShowMessage(inttostr(n) + ws);
      Exit;
    end;
    st.Position := 0;
    AcWebClientView1.OpenRepFromStream(ANetStream, false);
   }

   //通过文件交换数据的方式
    FRptEngineObj.ExportToAcr('d:\tmp1.acr');
    AcWebClientView1.OpenRepFromFile('d:\tmp1.acr', false);

    EdLeftMg.Text := inttostr(AcWebClientView1.LeftMargin);
    EdTopMg.Text := inttostr(AcWebClientView1.TopMargin);
  finally
  //  ANetStream.Free;
  //  st.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FRptEngineObj.ShowDesigner;
end;

procedure TForm1.InitAC;
begin
  qryEmp.Open;
  FRptEngineObj.Init;
  FRptEngineObj.AddDataset('zlemployee', qryEmp.Recordset);
  FRptEngineObj.SetReportFile(rpt_path+'list.apt');
  FRptEngineObj.AddVariable('变量1', '天方工作室'); 
end;

procedure TForm1.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.OpenCmdClick(Sender: TObject);
begin
  AcWebClientView1.ShowOpenDlg;
end;

procedure TForm1.SaveCmdClick(Sender: TObject);
begin
  AcWebClientView1.ShowSaveDlg;
end;

procedure TForm1.PgSetupBtnClick(Sender: TObject);
begin
  AcWebClientView1.ShowPageSetDlg;
end;

procedure TForm1.ExpExcelCmdClick(Sender: TObject);
begin
  AcWebClientView1.ShowExportToExcelDlg;
end;

procedure TForm1.PrintBtnClick(Sender: TObject);
begin
  AcWebClientView1.ShowPrintDlg;
end;

procedure TForm1.PageSizeCmdClick(Sender: TObject);
begin
  AcWebClientView1.SetToPageSize;
end;

procedure TForm1.ZoomInCmdClick(Sender: TObject);
begin
  AcWebClientView1.ZoomIn;
end;

procedure TForm1.ZoomOutCmdClick(Sender: TObject);
begin
  AcWebClientView1.ZoomOut;
end;

procedure TForm1.But1Click(Sender: TObject);
begin
  AcWebClientView1.GotoFirstPage;
  GotoEd.Text := '1';
end;

procedure TForm1.PrevPageBtnClick(Sender: TObject);
begin
  AcWebClientView1.GotoPriorPage;
  GotoEd.Text := inttostr(AcWebClientView1.GetCurPageIndex);
end;

procedure TForm1.NextPageBtnClick(Sender: TObject);
begin
  AcWebClientView1.GotoNextPage;
  GotoEd.Text := inttostr(AcWebClientView1.GetCurPageIndex);
end;

procedure TForm1.But2Click(Sender: TObject);
begin
  AcWebClientView1.GotoLastPage;
  GotoEd.Text := inttostr(AcWebClientView1.GetCurPageIndex);
end;

procedure TForm1.GotoEdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    AcWebClientView1.GotoPage(strtoint(GotoEd.Text)) 
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  AcWebClientView1.LeftMargin := strtoint(EdLeftMg.Text);
  AcWebClientView1.TopMargin := strtoint(EdTopMg.Text);
end;

end.
 