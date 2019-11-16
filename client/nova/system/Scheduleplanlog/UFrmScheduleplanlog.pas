unit UFrmScheduleplanlog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, USimpleCRUDForm, ImgList, ComCtrls, ToolWin, ExtCtrls,
  Buttons,
  GridsEh, DBGridEh, PrnDbgeh, DBGridEhGrouping, DB, DBClient, UFrmInfo,
  jsonClientDataSet, jsonConnection, UDMPublic, StdCtrls, NvPrnDbgeh,
  NvDbgridEh,
  NovaCheckedComboBox, NovaComboBox, NovaEdit, NovaHelp;

type
  TFrmScheduleplanlog = class(TBaseForm)
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
    Label1: TLabel;
    jsonCDSInitOrg: TjsonClientDataSet;
    nvckbOrg: TNovaCheckedComboBox;
    lblBegintimes: TLabel;
    dtpBegindate: TDateTimePicker;
    dtpBegintime: TDateTimePicker;
    lblEndtimes: TLabel;
    dtpEnddate: TDateTimePicker;
    dtpEndtime: TDateTimePicker;
    lblType: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtresult: TNovaEdit;
    NvDbgridEh1: TNvDbgridEh;
    novaotype: TNovaComboBox;
    novastype: TNovaComboBox;
    NvHpendroute: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
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
  FrmScheduleplanlog: TFrmScheduleplanlog;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmScheduleplanlog.FormCreate(Sender: TObject);
var
  DateTime: TDateTime;
  i: string;
begin
  inherited;
  // self.jcdsResult.RemoteServer:=UDMPublic.DMPublic.jcon;
  dtpBegindate.Date := Now;
  dtpEnddate.Date := Now;
  nvckbOrg.Active := False;
  nvckbOrg.Active := True;
  novaotype.Active := False;
  novaotype.Active := True;
  novastype.Active := False;
  novastype.Active := True;

end;

procedure TFrmScheduleplanlog.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  SysMainForm.CloseForm(Self);
end;

procedure TFrmScheduleplanlog.tbtnExcelClick(Sender: TObject);
begin
  inherited;
  dbgrdhResult.ExpDbgrid;
end;

procedure TFrmScheduleplanlog.tbtnInfoClick(Sender: TObject);
begin
  inherited;
  FrmInfo := TFrmInfo.Create(Self);
  with FrmInfo do
  begin
    Caption := Self.Caption + '模块功能说明';
    jscdQryFunInfo.RemoteServer := UDMPublic.DMPublic.jcon;
    key := GuidtoString(Self.FfunctionItem.key);
    ShowModal;
  end;
end;

procedure TFrmScheduleplanlog.tbtnPrinterClick(Sender: TObject);
begin
  inherited;
  dbgrdhResult.PrintPreview;
end;

procedure TFrmScheduleplanlog.tbtnFilterClick(Sender: TObject);
var
  endtime, begintime: String;
  orgid: Integer;
begin
  inherited;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamByName('filter_INS_o!id').Value := nvckbOrg.GetSelectID;
    Params.ParamByName('filter_GED_sl!createtime').Value :=
    formatdatetime('c',dtpBegindate.Date)+' '+ formatdatetime('tt',dtpBegintime.Time);
    Params.ParamByName('filter_LED_sl!createtime').Value :=
    formatdatetime('c',dtpEnddate.Date)+' '+formatdatetime('tt',dtpEndtime.Time);
    if novaotype.GetSelectID > 0 then
    begin
      Params.ParamByName('filter_EQS_sl!operationtype').Value := novaotype.GetSelectCode;
    end
    else
    begin
      Params.ParamByName('filter_EQS_sl!operationtype').Value := 'C';
    end;
    if novastype.GetSelectID > 0 then
    begin
      Params.ParamByName('type').Value := novastype.GetSelectCode;
    end
    else
    begin
       Params.ParamByName('type').Value := '0';
    end;
    Params.ParamValues['filter_EQS_t!name']:=trim(NvHpendroute.Text);
    Params.ParamValues['filter_LIKES_sl!result']:=trim(edtresult.Text);

    Active := True;
  end;
end;

end.
