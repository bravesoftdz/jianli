unit UFrmSalerdayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,Services;

type
  TFrmSalerdayReport = class(TSimpleCRUDForm)
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    chkByselldate: TCheckBox;
    chkByseller: TCheckBox;
    lbl1: TLabel;
    Label2: TLabel;
    nvcbbOrgid: TNovaCheckedComboBox;
    NovachkPorg: TNovaCheckedComboBox;
    salebylist: TNovaCheckedComboBox;
    Nvtaketicketplace: TNovaCheckedComboBox;
    Label3: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure chkBysellerClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSalerdayReport: TFrmSalerdayReport;

implementation
uses   PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmSalerdayReport.chkBysellerClick(Sender: TObject);
begin
  inherited;
  if not chkByseller.Checked then   begin
    //chkByseller.Checked := false;
    salebylist.Visible := false;
  end;
  if chkByseller.Checked then begin
    salebylist.Visible := true;
  end;

end;

procedure TFrmSalerdayReport.FormCreate(Sender: TObject);
begin
  inherited;
  dbgrdhResult.OddRowColor:=clMoneyGreen; //奇数行颜色
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  salebylist.Visible := false;
  salebylist.active := false;
  salebylist.Active := true;
  Nvtaketicketplace.Active := false;
  Nvtaketicketplace.Active := true;

end;

procedure TFrmSalerdayReport.FormShow(Sender: TObject);
var
  moreprice:string;
begin
  inherited;
  moreprice:=  getParametervalue('5001', Sysinfo.LoginUserInfo.OrgID);
  if moreprice='1' then
      dbgrdhResult.Columns[26].Visible:=true
  else
      dbgrdhResult.Columns[26].Visible:=false;
  //nvckbOrgid.Active := False;
  //nvckbOrgid.Active := True;
 // nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmSalerdayReport.jcdsResultAfterOpen(DataSet: TDataSet);
begin
   if DataSet.RecordCount>0 then
  begin
    //只有按售票日期统计的时候，才会显示“当日当班售票收入”25
    if chkByselldate.Checked then
    begin
       dbgrdhResult.Columns[1].Visible := True;
       dbgrdhResult.Columns[25].Visible := True
    end
    else
    begin
       dbgrdhResult.Columns[1].Visible := False;
       dbgrdhResult.Columns[25].Visible := False;
    end;
    if chkByseller.Checked then
    begin
       dbgrdhResult.Columns[2].Visible := True ;
       dbgrdhResult.Columns[3].Visible := True
    end
    else
    begin
       dbgrdhResult.Columns[2].Visible := False;
       dbgrdhResult.Columns[3].Visible := False;
    end;

  end;

end;

procedure TFrmSalerdayReport.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);
  end;
end;

procedure TFrmSalerdayReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  if nvcbbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if chkByselldate.Checked and chkByseller.Checked and
    (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvcbbOrgid.GetSelectID;
    Params.ParamValues['sellerids'] := salebylist.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Params.ParamValues['ticketoutletid'] := Nvtaketicketplace.GetSelectID;

      //是否按日期排序
    if chkByselldate.Checked then
      Params.ParamValues['isbyselldate']:= 'true'
    else
      Params.ParamValues['isbyselldate']:= 'false';

      //是否按售票员
    if chkByseller.Checked then
      Params.ParamValues['isbyseller']:= 'true'
    else
      Params.ParamValues['isbyseller']:= 'false';

    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
        +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '查询条件有：[售票日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvcbbOrgid.GetSelectID) <>'' then
      log := log +',[机构]：'+nvcbbOrgid.Text;
    if chkByselldate.Checked then
      log:= log+',['+chkByselldate.Caption+']';
    if chkByseller.Checked then
      log := log +',['+chkByseller.Caption+']';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->售票员售票情况日报表','查询',log);

  end
end;


end.
