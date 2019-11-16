unit UFrmSecuritycheckReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaCheckedComboBox;

type
  TFrmSecuritycheckReport = class(TSimpleCRUDForm)
    Label8: TLabel;
    Label9: TLabel;
    startdate: TDateTimePicker;
    enddate: TDateTimePicker;
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSecuritycheckReport: TFrmSecuritycheckReport;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSecuritycheckReport.FormShow(Sender: TObject);
begin
  inherited;
  startdate.Date := Now;
  enddate.Date := Now;
  with nvckbOrgid do
  begin
    Active := false;
    Active := true;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  end;
end;

procedure TFrmSecuritycheckReport.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(enddate.Date-startdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid']:= nvckbOrgid.GetSelectID;
      Params.ParamValues['filter_GED_s!checktime'] := formatdatetime('yyyy-mm-dd',startdate.DateTime)+' 00:00:00';
      Params.ParamValues['filter_LED_s!checktime'] := formatdatetime('yyyy-mm-dd', enddate.DateTime)+' 23:59:59';
    Active := true;
  end;
end;

end.
