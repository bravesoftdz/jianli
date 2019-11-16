unit UfrmQueryChangeCancelTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TfrmQueryChangeCancelTicket = class(TSimpleCRUDForm)
    lbl4: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhelpUserid: TNovaHelp;
    Label9: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    GroupBox3: TGroupBox;
    NvDbgridEh2: TNvDbgridEh;
    Panel2: TPanel;
    jcdsticketcancel: TjsonClientDataSet;
    DataSource1: TDataSource;
    jcdsticketchange: TjsonClientDataSet;
    DataSource2: TDataSource;
    Splitter1: TSplitter;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    procedure refreshTicketDetail();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryChangeCancelTicket: TfrmQueryChangeCancelTicket;

implementation
uses UDMPublic,Services;
{$R *.dfm}

procedure TfrmQueryChangeCancelTicket.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
end;

procedure TfrmQueryChangeCancelTicket.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsticketcancel.Close;
    jcdsticketchange.Close;
    Exit;
  end;
  refreshTicketDetail();
end;

procedure TfrmQueryChangeCancelTicket.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('售票开始日期不能大于售票结束日期！');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['dtpstartdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['dtpenddate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then // 打单员
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;
    Params.ParamValues['sign'] := '0';
   Active := True;
  end;
end;

procedure TfrmQueryChangeCancelTicket.refreshTicketDetail;
begin
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jcdsticketcancel do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['dtpstartdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['dtpenddate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    Params.ParamValues['filter_EQL_u!id'] := jcdsResult.fieldbyname('id').AsString;
    Params.ParamValues['sign'] := '1';
    Active := true;
  end;

  with jcdsticketchange do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['dtpstartdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['dtpenddate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    Params.ParamValues['filter_EQL_u!id'] := jcdsResult.fieldbyname('id').AsString;
    Params.ParamValues['sign'] := '2';
    Active := true;
  end;
end;

end.
