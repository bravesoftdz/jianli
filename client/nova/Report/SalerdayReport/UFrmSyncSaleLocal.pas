unit UFrmSyncSaleLocal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox;

type
  TFrmSyncSaleLocal = class(TSimpleCRUDForm)
    Label2: TLabel;
    NovaSchOrgs: TNovaCheckedComboBox;
    Label3: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    nvckbOrgid: TNovaCheckedComboBox;
    ChkAllOrg: TCheckBox;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    Label1: TLabel;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    cbbdatetype: TComboBox;
    CheckBox1: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure ChkAllOrgClick(Sender: TObject);
    procedure cbbdatetypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSyncSaleLocal: TFrmSyncSaleLocal;

implementation
 uses   PubFn,Services;
{$R *.dfm}

procedure TFrmSyncSaleLocal.cbbdatetypeChange(Sender: TObject);
begin
  inherited;
 if cbbdatetype.ItemIndex=0 then
  begin
     dbgrdhResult.Columns[2].Title.caption:='售票日期';
  end
  else
  begin
     dbgrdhResult.Columns[2].title.caption:='发车日期';
  end;
end;

procedure TFrmSyncSaleLocal.ChkAllOrgClick(Sender: TObject);
begin
  inherited;
  if ChkAllOrg.Checked then
  begin
    nvckbOrgid.CheckAll(true);
  end
  else
  begin
    nvckbOrgid.CheckAll(false);
  end;
end;

procedure TFrmSyncSaleLocal.FormShow(Sender: TObject);
begin
  inherited;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;

    nvckbOrgid.Active := False;
    nvckbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvckbOrgid.Active := True;
    //nvckbOrgid.CheckAll(true);
  NovaSchOrgs.Active:=false;
  NovaSchOrgs.Active:=true;
  NovaSchOrgs.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  cbbdatetype.ItemIndex:=0;
  //dbgrdhResult.Columns[2].Visible:=True;
  //dbgrdhResult.Columns[3].Visible:=False;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmSyncSaleLocal.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvckbOrgid.Active := False;
    nvckbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvckbOrgid.Active := True;
    nvckbOrgid.CheckAll(true);
  end;
end;

procedure TFrmSyncSaleLocal.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    nvckbOrgid.SetFocus;
    exit;
  end;
  if NovaSchOrgs.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择班次机构！');
    NovaSchOrgs.SetFocus;
    exit;
  end;
  if (cbbdatetype.ItemIndex=-1) or (trim(cbbdatetype.Text)='') then
  begin
     SysDialogs.ShowMessage('请先选择日期类型！');
     Exit;
  end;
//  SysDialogs.ShowMessage(IntToStr(cbbdatetype.ItemIndex));
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
  if (cbbdatetype.ItemIndex=0) and (CheckBox1.Checked) then
  begin
     SysDialogs.ShowMessage('请选择发车日期！');
     Exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := NovaSchOrgs.GetSelectID;
    params.ParamValues['datetype']:= cbbdatetype.ItemIndex;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['saleorgids'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['isolddate'] := CheckBox1.Checked;


    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '查询条件有：[售票日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[班次机构]：'+nvckbOrgid.Text;
    if NovachkPorg.GetSelectID <>'' then
      log  := log +',[分公司]：'+NovachkPorg.Text;
    if nvckbOrgid.GetSelectID <> '' then
      log  := log +'[售票机构]:'+nvckbOrgid.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';

    SysLog.WriteLog('报表统计->异站售本站汇总表','查询',log);
  end
end;

end.
