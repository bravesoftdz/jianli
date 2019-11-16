unit UFrmStationBalanceReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit, NovaHelp, NovaCheckedComboBox, DBGridEhGrouping, Menus;

type
  TFrmStationBalanceReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbbBalanceObject: TComboBox;
    NHelpRoute: TNovaHelp;
    NovaHelpSchedule: TNovaHelp;
    NovaHelpVehiclenoHelp: TNovaHelp;
    cbbOvertime: TComboBox;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NovaChkPrintOrg: TNovaCheckedComboBox;
    Label9: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    NovaChkSaleOrg: TNovaCheckedComboBox;
    ChkIsShowZero: TCheckBox;
    NovaHelpUnit: TNovaCheckedComboBox;
    NovachBalanceUnit: TNovaCheckedComboBox;
    lblworkways: TLabel;
    nvcbbworkways: TNovaCheckedComboBox;
    Label12: TLabel;
    cbbbalancetype: TComboBox;
    lbl2: TLabel;
    cbbAgenttype: TComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStationBalanceReport: TFrmStationBalanceReport;

implementation
 uses PubFn, Services;
{$R *.dfm}

procedure TFrmStationBalanceReport.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := true;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);

  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  NovaChkSaleOrg.Active := False;
  NovaChkSaleOrg.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  NovaChkSaleOrg.Active := True;
  NovaChkSaleOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);

  NovaChkPrintOrg.Active := False;
  NovaChkPrintOrg.Active := true;
  NovaChkPrintOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  cbbBalanceObject.ItemIndex:=0;


  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;

  //dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;


  NovaHelpUnit.Active := False;
  NovaHelpUnit.Active := true;
  NovaHelpUnit.CheckAll(false);


  NovachBalanceUnit.Active := False;
  NovachBalanceUnit.Active := true;
  NovachBalanceUnit.CheckAll(false);

  nvcbbworkways.Active:=false;
  nvcbbworkways.Active:=true;

  nvcbbworkways.SelectAll;

 { dbgrdhResult.Columns[0].Visible:=true;
  dbgrdhResult.Columns[1].Visible:=true;
  dbgrdhResult.Columns[2].Visible:=true; }

end;

procedure TFrmStationBalanceReport.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    NovaChkSaleOrg.Active := False;
    NovaChkSaleOrg.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    NovaChkSaleOrg.Active := True;
    NovaChkSaleOrg.CheckAll(true);
  end;
end;

procedure TFrmStationBalanceReport.tbtnFilterClick(Sender: TObject);
var
  peopledistance,allpeopledistance:int64;
begin
  inherited;
//车属单位\结算单位\班次\车辆\线路
  dbgrdhResult.FieldColumns['name'].Visible:=false;
  dbgrdhResult.FieldColumns['endstation'].Visible:=false;
  dbgrdhResult.FieldColumns['vehicleno'].Visible:=false;
  dbgrdhResult.FooterRowCount:=1;
  if cbbBalanceObject.ItemIndex=0 then
  begin
    dbgrdhResult.FieldColumns['name'].Visible:=true;
   // dbgrdhResult.FieldColumns['name'].Title.Caption:='车属单位';
  end
  else if cbbBalanceObject.ItemIndex=1 then
  begin
    dbgrdhResult.FieldColumns['name'].Visible:=true;
   // dbgrdhResult.FieldColumns['name'].Title.Caption:='结算单位';
  end
  else if cbbBalanceObject.ItemIndex=2 then
  begin
    dbgrdhResult.FieldColumns['name'].Visible:=true;
   // dbgrdhResult.FieldColumns['name'].Title.Caption:= '班次号';
  end
  else if cbbBalanceObject.ItemIndex=3 then
  begin
    dbgrdhResult.FieldColumns['vehicleno'].Visible:=true;
    dbgrdhResult.FieldColumns['endstation'].Visible:=true;
    dbgrdhResult.FieldColumns['name'].Visible:=true;
    //dbgrdhResult.FieldColumns['endstation'].Title.Caption:='营运线路';
   // dbgrdhResult.FieldColumns['name'].Title.Caption:='结算单位';
     dbgrdhResult.FooterRowCount:=0;
  end
  else
  begin
     dbgrdhResult.FieldColumns['name'].Visible:=true;
    // dbgrdhResult.FieldColumns['name'].Title.Caption:='营运线路';
  end;
 
  if nvckbOrgid.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择班次机构！');
    exit;
  end;
  if NovaChkSaleOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    exit;
  end;

  if NovaChkPrintOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择打单机构！');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
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

  if nvcbbworkways.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择营运方式！');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['rp.orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['rp.saleorgids'] := NovaChkSaleOrg.GetSelectID;
    Params.ParamValues['rp.printorgids'] := NovaChkPrintOrg.GetSelectID;
    Params.ParamValues['rp.schtype'] := cbbOvertime.ItemIndex;
    Params.ParamValues['rp.agentcaltype'] := cbbAgenttype.ItemIndex;
    if NovachBalanceUnit.GetSelectID='' then
     Params.ParamValues['rp.balanceunitids'] := null
    else
      Params.ParamValues['rp.balanceunitids'] := NovachBalanceUnit.GetSelectID;

    if NovaHelpUnit.GetSelectID='' then
     Params.ParamValues['rp.unitids'] := null
    else
      Params.ParamValues['rp.unitids'] := NovaHelpUnit.GetSelectID;
    Params.ParamValues['rp.routeid'] := NHelpRoute.Id;
    Params.ParamValues['rp.scheduleid'] := NovaHelpSchedule.Id;
    Params.ParamValues['rp.workways'] :=nvcbbworkways.GetSelectID;
    Params.ParamValues['rp.balancetype'] := cbbBalanceObject.ItemIndex;
    Params.ParamValues['rp.vehicleid'] := NovaHelpVehiclenoHelp.Id;
    Params.ParamValues['rp.handflag'] := cbbbalancetype.ItemIndex;
    Params.ParamValues['rp.startdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['rp.enddate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.Date);
    if ChkIsShowZero.Checked then
       Params.ParamValues['rp.isshowzerotickets'] := true
    else
       Params.ParamValues['rp.isshowzerotickets'] := false;


     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName
     +' 售票机构：'+NovaChkSaleOrg.Text;


    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := true;

      dbgrdhResult.Columns[13].Footer.value:='';
     if recordcount>0 then
     begin
       peopledistance:= StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['peopledistance']));
       allpeopledistance:=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['allpeopledistance']));
       if allpeopledistance>0 then
       begin

         dbgrdhResult.Columns[13].Footer.value:= CurrToStr(roundEx(peopledistance*100/allpeopledistance,2))+'%';
       end;
     end;
  end;
end;

end.
