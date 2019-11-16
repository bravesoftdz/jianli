unit UFrmQryScheduleDepartTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQryScheduleDepartTime  = class(TSimpleCRUDForm)
    jcdsReturnwayname: TjsonClientDataSet;
    lbl1: TLabel;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl3: TLabel;
    nvhelpRoute: TNovaHelp;
    intgrfldResultdistance: TIntegerField;
    fltfldResultruntime: TFloatField;
    wdstrngfldResultendstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultstarttime: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    nvHcbbOrgNovaCbbOrg: TNovaHComboBox;
    jcdsResultdepartdate: TDateField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQryScheduleDepartTime: TfrmQryScheduleDepartTime;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQryScheduleDepartTime.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBdepartdate.Date:=Now;
  nvHcbbOrgNovaCbbOrg.Active:= False;
  nvHcbbOrgNovaCbbOrg.Active := True;
  jcdsReturnwayname.Active := False;
  jcdsReturnwayname.Active := True;
end;

procedure TfrmQryScheduleDepartTime.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_s!orgid']:= nvHcbbOrgNovaCbbOrg.HelpFieldValue['id'];

    Params.ParamValues['filter_EQD_sts!departdate'] := formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);  //售票日期

    if (not (Trim(nvhelpRoute.Text) = '')) and (nvhelpRoute.Id>0) then  //线路
      begin
        Params.ParamValues['filter_EQL_s!routeid']:= nvhelpRoute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!routeid']:= '';
      end;
    Active:=true;
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+
      formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);

    log := '查询条件有：[发车日期] '+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    if Trim(nvHcbbOrgNovaCbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[所属机构]：'+nvHcbbOrgNovaCbbOrg.Text;
    if nvhelpRoute.Id <>0 then
      log  := log +',[线路]:'+nvhelpRoute.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->客运班线发车时刻表','查询',log);
  end
end;

end.

