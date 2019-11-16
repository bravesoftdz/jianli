unit USimpleCRUDForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,uBaseForm, ImgList, ComCtrls, ToolWin, ExtCtrls, Buttons,
  GridsEh, DBGridEh, PrnDbgeh, DBGridEhGrouping, DB, DBClient,UFrmInfo,
  jsonClientDataSet, jsonConnection,UDMPublic, StdCtrls, NvPrnDbgeh, NvDbgridEh;

type
  TSimpleCRUDForm = class(TBaseForm)
    ilToolBar: TImageList;
    ilToolBarDisable: TImageList;
    pnlQuery: TPanel;
    tlbShortCut: TToolBar;
    tbtnFilter: TToolButton;
    tbtn1: TToolButton;
    tbtnInsert: TToolButton;
    tbtnEdit: TToolButton;
    tbtnDelete: TToolButton;
    tbtn3: TToolButton;
    tbtnSave: TToolButton;
    tbtnCancel: TToolButton;
    tbtn4: TToolButton;
    tbtnInfo: TToolButton;
    tbtn5: TToolButton;
    tbtnExcel: TToolButton;
    tbtnPrinter: TToolButton;
    tbtn6: TToolButton;
    tbtnClose: TToolButton;
    jcdsResult: TjsonClientDataSet;
    dsResult: TDataSource;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    prntdbgrdhResult: TNvPrintDBGridEh;
    dbgrdhResult: TNvDbgridEh;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    procedure tbtnCloseClick(Sender: TObject);
    procedure tbtnExcelClick(Sender: TObject);
    procedure tbtnPrinterClick(Sender: TObject);
    procedure tbtnInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SimpleCRUDForm: TSimpleCRUDForm;

implementation

uses Services;

{$R *.dfm}

procedure TSimpleCRUDForm.FormCreate(Sender: TObject);
begin
  inherited;
  self.jcdsResult.RemoteServer:=UDMPublic.DMPublic.jcon;
end;

procedure TSimpleCRUDForm.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  SysMainForm.CloseForm(Self);
end;

procedure TSimpleCRUDForm.tbtnExcelClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active) and (jcdsResult.RecordCount>0) then
    dbgrdhResult.ExpDbgrid;
end;

procedure TSimpleCRUDForm.tbtnInfoClick(Sender: TObject);
begin
  inherited;
  FrmInfo := TFrmInfo.Create(self);
  with FrmInfo do
  begin
    Caption := self.Caption+ '模块功能说明';
    jscdQryFunInfo.RemoteServer:=UDMPublic.DMPublic.jcon;
    key:=GuidtoString(self.FfunctionItem.key);
    ShowModal;
  end;
end;

procedure TSimpleCRUDForm.tbtnPrinterClick(Sender: TObject);
begin
  inherited;
  dbgrdhResult.PrintPreview;
end;

end.
