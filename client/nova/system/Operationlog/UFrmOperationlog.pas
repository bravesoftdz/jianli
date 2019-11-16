unit UFrmOperationlog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Mask, DBCtrlsEh, NovaEdit, NovaHelp, NvPrnDbgeh, NvDbgridEh,
  NovaCheckedComboBox,UFrmOperationlogDetail;

type
  TFrmOperationlog = class(TSimpleCRUDForm)
    lblUserIp: TLabel;
    lblUserId: TLabel;
    dtpBegindate: TDateTimePicker;
    lblBegintimes: TLabel;
    lblEndtimes: TLabel;
    dtpEnddate: TDateTimePicker;
    jsonCDSInitOrg: TjsonClientDataSet;
    dtpEndtime: TDateTimePicker;
    dtpBegintime: TDateTimePicker;
    lblTableName: TLabel;
    nvedtModule: TNovaEdit;
    nvedtIP: TNovaEdit;
    nvhelpUserid: TNovaHelp;
    edtContent: TNovaEdit;
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOperationlog: TFrmOperationlog;

implementation
uses UDMPublic,PubFn,Services;
{$R *.dfm}





procedure TFrmOperationlog.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBegindate.Date:=Now;
  dtpEnddate.Date :=Now;
end;

procedure TFrmOperationlog.tbtnFilterClick(Sender: TObject);
begin
  inherited;
    if FormatDateTime('yyyymmdd', dtpBegindate.Date) > FormatDateTime('yyyymmdd',
    dtpEnddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;

  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpEnddate.Date-dtpBegindate.Date))
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
    exit;
  end;


  with jcdsResult do
  begin
    Active:=False;
     if (not (Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id>0) then //用户名
    begin
      Params.ParamValues['filter_EQL_u!id']:= nvhelpUserid.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_u!id']:= '';
    end;
    Params.ParamValues['filter_LIKES_o!module']  := nvedtModule.Text;
    Params.ParamValues['filter_LIKES_o!content']  := edtContent.Text;
    Params.ParamValues['filter_LIKES_o!ip']  := nvedtIP.Text;
    Params.ParamValues['filter_GTD_o!operatetime'] :=
        formatdatetime('yyyy-mm-dd',dtpBegindate.Date)+' '+ formatdatetime('hh:mm:ss',dtpBegintime.Time);
    Params.ParamValues['filter_LED_o!operatetime'] :=
        formatdatetime('yyyy-mm-dd',dtpEnddate.Date)+' '+formatdatetime('hh:mm:ss',dtpEndtime.Time);
    Active:=true;
  end;
end;

procedure TFrmOperationlog.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  frmOperationlogDetail := TfrmOperationlogDetail.Create(self);
  with frmOperationlogDetail do
  begin
    Caption := '操作日志明细信息';
    edtMode.Text:= jcdsResult.FieldByName('module').AsString;
    edtIP.Text:= jcdsResult.FieldByName('ip').AsString;
    edtUsername.Text:= jcdsResult.FieldByName('username').AsString;
    edtTime.Text:= jcdsResult.FieldByName('operatetime').AsString;
    edtType.Text:= jcdsResult.FieldByName('operation').AsString;
    mmoContent.Text:= jcdsResult.FieldByName('content').AsString;
    ShowModal;

  end;
end;

end.


