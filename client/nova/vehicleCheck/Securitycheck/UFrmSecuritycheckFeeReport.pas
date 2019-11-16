unit UFrmSecuritycheckFeeReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, Services;

type
  TFrmSecuritycheckFeeReport = class(TSimpleCRUDForm)
    Label8: TLabel;
    Label9: TLabel;
    lbl1: TLabel;
    startdate: TDateTimePicker;
    enddate: TDateTimePicker;
    nvckbOrgid: TNovaCheckedComboBox;
    Label1: TLabel;
    nvhelpvehicleno: TNovaHelp;
    nvhelpunitname: TNovaHelp;
    Label4: TLabel;
    nvhelpcheckname: TNovaHelp;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSecuritycheckFeeReport: TFrmSecuritycheckFeeReport;

implementation
uses  PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmSecuritycheckFeeReport.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  startdate.Date := Now;
  enddate.Date := Now;
end;

procedure TFrmSecuritycheckFeeReport.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.Warning('请选择安检车站!');
    Exit;
  end;
  if startdate.Date > enddate.Date then
  begin
    SysDialogs.Warning('开始时间不能大于结束时间!');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_sec!orgid']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_GED_sec!checktime'] := formatdatetime('yyyy-mm-dd',startdate.DateTime)+' 00:00:00';
    Params.ParamValues['filter_LED_sec!checktime'] := formatdatetime('yyyy-mm-dd', enddate.DateTime)+' 23:59:59';
    if Trim(nvhelpunitname.Text) = '' then
      Params.ParamValues['filter_EQS_v!unitid'] := ''
    else
    Params.ParamValues['filter_EQS_v!unitid']:= nvhelpunitname.Id;
    if Trim(nvhelpvehicleno.Text) = '' then
      Params.ParamValues['filter_EQS_sec!vehicleid'] := ''
    else
    Params.ParamValues['filter_EQS_sec!vehicleid']:= nvhelpvehicleno.Id;
    if Trim(nvhelpcheckname.Text) = '' then
      Params.ParamValues['filter_EQS_sec!checkby'] := ''
    else
    Params.ParamValues['filter_EQS_sec!checkby']:= nvhelpcheckname.Id;
    Active := true;

  end;
end;

end.
