unit UFrmQueryBilldamaged;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryBilldamaged = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpStartRecordtime: TDateTimePicker;
    lbl5: TLabel;
    dtpEndRecordtime: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    nvhlpUser: TNovaHelp;
    jcdsStatusname: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl2: TLabel;
    edtIP: TNovaEdit;
    nvhlpTicketoutlets: TNovaHelp;
    nvHcbbOrgnovahcbbtype: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmQueryBilldamaged: TfrmQueryBilldamaged;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryBilldamaged.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpStartRecordtime.Date:=Now;
  dtpEndRecordtime.Date:=Now;
  nvHcbbOrgnovahcbbtype.Active:=false;
  nvHcbbOrgnovahcbbtype.Active:=true;
end;

procedure TfrmQueryBilldamaged.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpStartRecordtime.Date) > FormatDateTime('yyyymmdd',
    dtpEndRecordtime.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_o!id']:= nvckbOrgid.GetSelectID;
    log :=log +'[所属机构]:'+nvckbOrgid.Text;
     //登记时间
    Params.ParamValues['filter_GED_b!recordtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpStartRecordtime.DateTime);
    Params.ParamValues['filter_LED_b!recordtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEndRecordtime.DateTime);
    log := log +' [登记时间]从'+ DateToStr(dtpStartRecordtime.DateTime)+'到'+DateToStr(dtpEndRecordtime.DateTime);


    if  (not (Trim(nvhlpUser.Text) = '')) and  (nvhlpUser.Id>0) then         //登记人
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhlpUser.HelpFieldValue['id'];
        log := log +' ,[登记人]:'+ nvhlpUser.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

      if  (not (Trim(nvhlpTicketoutlets.Text) = '')) and  (nvhlpTicketoutlets.Id>0) then  //登记站点
      begin
        Params.ParamValues['filter_EQL_t!id']:= nvhlpTicketoutlets.HelpFieldValue['id'];
        log := log +' ,[登记站点]:'+nvhlpTicketoutlets.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_t!id']:= '';
      end;

    if not (edtIP.Text = '') then
      begin
        Params.ParamValues['filter_LIKES_b!recordip']:= edtIP.Text ;
        log := log +' ,[登记机器IP]'+edtIP.Text;
      end
    else
      begin
        Params.ParamValues['filter_LIKES_b!recordip']:= '';
      end;

   if (not (Trim(nvHcbbOrgnovahcbbtype.Text) = '')) and (nvHcbbOrgnovahcbbtype.ItemIndex>=0) then
    begin
      Params.ParamValues['filter_EQL_b!billtypeid']:= nvHcbbOrgnovahcbbtype.HelpFieldValue['id'];
      log := log +' ,[票据类型]'+nvHcbbOrgnovahcbbtype.Text;
    end
   else
    begin
      Params.ParamValues['filter_EQL_b!billtypeid']:= '';
    end;
    //保存操作日志
    SysLog.WriteLog( '综合查询->坏票登记情况','查询', '查询条件有;'+log);
    Active:=true;
    log := '';
        dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
      dbgrdhResult.PrintInfo.PageTopRight:='坏票登记日期：'+ formatdatetime('yyyy-mm-dd',dtpStartRecordtime.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEndRecordtime.Date);

  end
end;

end.

