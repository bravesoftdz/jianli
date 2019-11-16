unit UFrmSellerTaskReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaEdit, NovaHelp;

type
  TFrmSellerTaskReport = class(TSimpleCRUDForm)
    lbl6: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl1: TLabel;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    nvhelpUserid: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSellerTaskReport: TFrmSellerTaskReport;

implementation

uses Services;
{$R *.dfm}

procedure TFrmSellerTaskReport.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := Sysinfo.LoginUserInfo.OrgIDs;
    Active := True;
    NovaHCbbOrg.SetItemIndexByField('id', Sysinfo.LoginUserInfo.StationID);
  end;
end;

procedure TFrmSellerTaskReport.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if dtpstartdate.Date>dtpenddate.Date then
  begin
    SysDialogs.Warning('起始日期不能大于结束日期！');
  end;

  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_ts!orgid'] := NovaHCbbOrg.HelpFieldValue['orgid'];

    Params.ParamValues['filter_GTD_ts!selltime'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LTD_ts!selltime'] := formatdatetime
      ('yyyy-mm-dd', dtpenddate.Date+1);
    if Trim(nvhelpUserid.text) = '' then
      begin
        params.ParamValues['filter_EQL_ts!sellby'] := null;
      end
      else
      begin
        params.ParamValues['filter_EQL_ts!sellby'] := nvhelpUserid.Id;
      end;
    Active := True;
  end;
end;

end.
