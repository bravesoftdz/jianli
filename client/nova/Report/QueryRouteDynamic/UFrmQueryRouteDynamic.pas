unit UFrmQueryRouteDynamic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TfrmQueryRouteDynamic = class(TSimpleCRUDForm)
    lbl1: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label2: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    NovaChkPrintOrg: TNovaCheckedComboBox;
    lbltype: TLabel;
    nvcbbChecktype: TNovaCheckedComboBox;
    lblRun: TLabel;
    nvcbbType: TNovaCheckedComboBox;
    lblworkways: TLabel;
    nvcbbworkways: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryRouteDynamic: TfrmQueryRouteDynamic;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryRouteDynamic.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  NovaChkPrintOrg.Active := False;
  NovaChkPrintOrg.Active := True;
  NovaChkPrintOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbChecktype.Active := False;
  nvcbbChecktype.Active := True;
end;

procedure TfrmQueryRouteDynamic.FormShow(Sender: TObject);
begin
  inherited;
  nvcbbType.Active:=false;
  nvcbbType.Active:=true;
  nvcbbworkways.Active:=false;
  nvcbbworkways.Active:=true;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryRouteDynamic.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  truetake: double;
  aa,log :string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
   if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvckbOrgid.SetFocus;
    exit;
  end;
  if Trim(NovaChkPrintOrg.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择开运量单位！');
    NovaChkPrintOrg.SetFocus;
    Exit;
  end;
    if Trim(nvcbbChecktype.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择营运类型！');
    nvcbbChecktype.SetFocus;
    Exit;
  end;
  if Trim(nvcbbType.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择运行区域！');
    nvcbbType.SetFocus;
    Exit;
  end;
  if Trim(nvcbbworkways.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择营运方式！');
    nvcbbworkways.SetFocus;
    Exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['departorgs'] := NovaChkPrintOrg.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);

//    if Trim(nvcbbChecktype.Text) = '' then
//      Params.ParamByName('vehicletype').Value := null
//    else
      Params.ParamByName('vehicletype').Value := nvcbbChecktype.GetSelectID;
      Params.ParamByName('districttype').Value := nvcbbType.GetSelectID;
      Params.ParamByName('workways').Value := nvcbbworkways.GetSelectID;

//    if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
//    Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id']
//    else
//       Params.ParamValues['filter_EQL_r!id']:= '';

    Active := True;
    if recordcount > 0 then
    begin

      alldistance :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['routedistance']));

      peplodistance :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['peopledistance']));
      allseatnum :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['seats']));
      checkticketnum :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['ticketnum']));

      if alldistance>0 then
      begin
      truetake:= roundEx((peplodistance * 100 / alldistance), 2)   ;
      dbgrdhResult.FieldColumns['rate'].Footer.Value :=floattostr(truetake)+'%';

      dbgrdhResult.FieldColumns['seatrate'].Footer.Value :=floattostr( roundEx
        (checkticketnum * 100 / allseatnum, 2))+'%';
      end
      else
      begin
        dbgrdhResult.FieldColumns['rate'].Footer.Value :='0';

        dbgrdhResult.FieldColumns['seatrate'].Footer.Value :='0';
      end;
      dbgrdhResult.FieldColumns['incomerate'].Footer.Value :='100%';
    end
    else
    begin
        dbgrdhResult.FieldColumns['rate'].Footer.Value :='0';
      dbgrdhResult.FieldColumns['incomerate'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['seatrate'].Footer.Value :='0';
    end;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[班次机构]：'+nvckbOrgid.Text;
    if Trim(NovaChkPrintOrg.GetSelectID) <>'' then
      log := log +',[开运量单位]:'+ NovaChkPrintOrg.Text;
    if Trim(nvcbbChecktype.Text) <>'' then
      log := log+',[营养类型]:'+nvcbbChecktype.Text;
    if Trim(nvcbbType.Text)<>'' then
      log := log +',[运行区域]：'+nvcbbType.Text;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->客运班线动态表','查询',log);

  end;

end;

end.
