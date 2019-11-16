unit UFrmQryTicketUseDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaComboBox;

type
  TFrmQryTicketUseDetail = class(TSimpleCRUDForm)
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    nvcbtickettype: TNovaComboBox;
    nvcbticketusetype: TNovaComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryTicketUseDetail: TFrmQryTicketUseDetail;

implementation
 uses Services,UDMPublic;
{$R *.dfm}

procedure TFrmQryTicketUseDetail.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
end;

procedure TFrmQryTicketUseDetail.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvckbOrgid.SetFocus;
    exit;
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
    Params.ParamValues['departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['enddate'] := formatdatetime
      ('yyyy-mm-dd', dtpenddate.Date);
    Params.ParamValues['tickettype'] := IntToStr(nvcbtickettype.ItemIndex);
    Params.ParamValues['ticketusetype'] := IntToStr(nvcbticketusetype.ItemIndex);

   Active := True;
  end;
end;

end.
