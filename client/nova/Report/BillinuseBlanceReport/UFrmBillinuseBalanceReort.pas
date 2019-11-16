unit UFrmBillinuseBalanceReort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmBillinuseBalanceReort = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvhlpsaler: TNovaHelp;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBillinuseBalanceReort: TFrmBillinuseBalanceReort;

implementation
uses Services,PubFn;

{$R *.dfm}

procedure TFrmBillinuseBalanceReort.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Trunc(Now);
  dtpenddate.Date := Trunc(Now);
end;

procedure TFrmBillinuseBalanceReort.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvckbOrgid.SetFocus;
    exit;
  end;
  if Trunc(dtpstartdate.Date) >Trunc(dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    dtpstartdate.SetFocus;
    exit;
  end;
   if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := DateToStr(dtpstartdate.Date);
    Params.ParamValues['enddate'] := DateToStr(dtpenddate.Date);
    Params.ParamValues['salerid'] := nvhlpsaler.Id;
    Params.ParamValues['check'] := CheckBox1.Checked;
    Active := True;
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='统计售票日期：'+ DateToStr(dtpstartdate.Date)+' 至 '+DateToStr(dtpenddate.Date);
    dbgrdhResult.PrintInfo.PrintName:=SysInfo.LoginUserInfo.UserName;

     log := '[售票日期]：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+nvckbOrgid.Text;
    if nvhlpsaler.Id <> 0 then
      log := log +',[售票员]：'+nvhlpsaler.Text;
    if CheckBox1.Checked then
      log := log +',[消耗票证]';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->售票员票据销存统计表','查询',log);

  end
end;

end.
