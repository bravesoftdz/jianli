unit UFrmQryDepartSchedules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, NovaHComboBox,UDMPublic;

type
  TFrmQryDepartSchedules = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl11: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    lbl4: TLabel;
    lbl2: TLabel;
    Label9: TLabel;
    lbl7: TLabel;
    dtpBdepartdate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    nvhelpUnit: TNovaHelp;
    nvhelpVehicle: TNovaHelp;
    nvhelpUserid: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    chkIsovertime: TCheckBox;
    chkIsnotovertime: TCheckBox;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    Label2: TLabel;
    cbbdepart: TNovaCheckedComboBox;
    nvckbOrgid: TNovaCheckedComboBox;
    lblRun: TLabel;
    nvcbbType: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryDepartSchedules: TFrmQryDepartSchedules;

implementation
   uses Services,PubFn;
{$R *.dfm}

procedure TFrmQryDepartSchedules.FormCreate(Sender: TObject);
begin
  inherited;

   nvckbOrgid.Active:=false;
   nvckbOrgid.Active:=true;
   nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
   cbbdepart.Active := False;
   cbbdepart.Active := True;
   cbbdepart.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQryDepartSchedules.FormShow(Sender: TObject);
begin
  inherited;
  nvcbbType.Active:=false;
  nvcbbType.Active:=true;
  self.dtpBdepartdate.Date:=now;
  self.dtpEdepartdate.Date:=now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmQryDepartSchedules.tbtnFilterClick(Sender: TObject);
var stationservicefee, computefee,coolairfee,additionfee,waterfee,
				insurefee,otherfee,fueladditionfee,agentfee,allfee : Int64;
    log:string;
begin
  inherited;
   if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if Trim(cbbdepart.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择开运量单位！');
    Exit;
  end;
    if Trim(nvcbbType.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择所属区域！');
    nvcbbType.SetFocus;
    Exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_ds!departinvoicesno'] := nvedtTicketno.Text;
    // 发车日期
    Params.ParamValues['startdate'] := formatdatetime
      ('yyyy-mm-dd', dtpBdepartdate.Date);

    Params.ParamValues['enddate'] := formatdatetime
      ('yyyy-mm-dd', dtpEdepartdate.Date);

    if (not(Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id > 0) then // 单位
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := nvhelpUnit.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := '';
    end;

    if (not(Trim(nvhlpschedule.Text) = '')) and (nvhlpschedule.Id > 0) then
    // 班次号     //班次
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;

    if (not(Trim(nvhlproute.Text) = '')) and (nvhlproute.Id > 0) then // 线路
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

    if (not(Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id > 0) then
    // 车辆
    begin
      Params.ParamValues['filter_EQL_v!id'] := nvhelpVehicle.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end;

    if not chkIsnotovertime.Checked  and chkIsovertime.Checked  then     //是否加班班次
    begin
     Params.ParamValues['filter_EQB_s!isovertime']:='true';
     //log := log+'加班,';
    end
    else if not chkIsovertime.Checked  and chkIsnotovertime.Checked then
    begin
      Params.ParamValues['filter_EQB_s!isovertime']:='false';
      //log := log+'正班,';
    end;

    if nvcbbType.GetSelectID='' then
        Params.ParamValues['filter_INS_ddc!orderno']:=null
    else
        Params.ParamValues['filter_INS_ddc!orderno'] := nvcbbType.GetSelectID;


    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then // 打单员
    begin
      Params.ParamValues['filter_EQL_ds!printby'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_ds!printby'] := null;
    end;
    if Trim(cbbdepart.Text) <> '' then                              //开运量单位
      Params.ParamValues['filter_INS_ds!printorgid'] := cbbdepart.GetSelectID
    else
      Params.ParamValues['filter_INS_ds!printorgid'] := null;



    Active := true;
    log := '查询条件有：[发车日期]从'+formatdatetime('yyyy-mm-dd', dtpBdepartdate.Date)
          +'到'+formatdatetime('yyyy-mm-dd', dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID)<>'' then
      log := log+',[班次机构]：'+nvckbOrgid.Text;
    if Trim(cbbdepart.GetSelectID) <> '' then
      log := log +',[开运量单位]：'+cbbdepart.Text ;
    if  nvhlproute.Id <> 0 then
      log := log +',[线路]：'+nvhlproute.Text ;
    if nvhlpschedule.Id <> 0 then
      log := log +',]班次号]：'+nvhlpschedule.Text ;
    if nvhelpUnit.Id <> 0 then
      log := log +',[营运单位]:'+nvhelpUnit.Text ;
    if nvhelpVehicle.Id <> 0 then
      log := log +',[营运车辆]:'+ nvhelpVehicle.Text;
    if nvhelpUserid.Id <> 0 then
      log := log +',[打单员]:'+ nvhelpUserid.Text;
    if Trim(nvedtTicketno.Text) <> '' then
      log := log +',[结算单号]:'+ nvedtTicketno.Text;
    if chkIsnotovertime.Checked then
      log := log +',[正班]';
    if chkIsovertime.Checked then
      log :=log+',[加班]';

     log := log+',[所属区域]：'+nvcbbType.Text
     +' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->运量单运量台账','查询',log);

  end;
end;
end.
