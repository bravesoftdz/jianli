unit UFrmRouteSaleTicketReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp,NovaComboBox;

type
  TFrmRouteSaleTicketReport = class(TSimpleCRUDForm)
    Label2: TLabel;
    NovaChkSaleOrg: TNovaCheckedComboBox;
    Label4: TLabel;
    Label6: TLabel;
    startDate: TDateTimePicker;
    endDate: TDateTimePicker;
    lbldistricttype: TLabel;
    nvhlpSellby: TNovaHelp;
    lbl6: TLabel;
    cbbGroupType: TNovaCheckedComboBox;
    lbl1: TLabel;
    NvCbbdistricttype: TNovaCheckedComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure cbbGroupTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRouteSaleTicketReport: TFrmRouteSaleTicketReport;

implementation

uses PubFn, Services ,SystemInstance,SysInfoIntf;
{$R *.dfm}

procedure TFrmRouteSaleTicketReport.cbbGroupTypeChange(Sender: TObject);
var selectIDs : String;
begin
  inherited;
  selectIDs := cbbGroupType.GetSelectID;
  if Pos('3', selectIDs) = 0 then
  begin
     nvhlpSellby.Enabled := False;
//     nvhlpSellby.Id := 0;
     nvhlpSellby.Text := '';
  end
  else
  begin
     nvhlpSellby.Enabled := True;
  end;
  ;

end;

procedure TFrmRouteSaleTicketReport.FormShow(Sender: TObject);
begin
  inherited;
  cbbGroupType.Active := False;
  cbbGroupType.Active := True;
  NvCbbdistricttype.Active := False;
  NvCbbdistricttype.Active := True;
  NovaChkSaleOrg.Active := False;

  NovaChkSaleOrg.Active := True;
  NovaChkSaleOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  cbbGroupType.Active := False;
  cbbGroupType.Active := True;
  startDate.Date:= NOW;
  endDate.Date:= NOW;
end;

procedure TFrmRouteSaleTicketReport.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
    NovaChkSaleOrg.Active := False;
    NovaChkSaleOrg.Active := True;
    NovaChkSaleOrg.CheckAll(true);
end;

procedure TFrmRouteSaleTicketReport.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
      if NovaChkSaleOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
  if FormatDateTime('yyyymmdd', startDate.Date) > FormatDateTime
    ('yyyymmdd', endDate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (endDate.Date - startDate.Date) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := NovaChkSaleOrg.GetSelectID;
    Params.ParamValues['districttype']:=NvCbbdistricttype.GetSelectID;
    Params.ParamValues['seller']:=nvhlpSellby.id;
    Params.ParamValues['grouptypes']:=cbbGroupType.GetSelectID;

    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd', startDate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd', endDate.Date);

    Active := True;
    log := '��ѯ�����У�'+'[��Ʊ����]�� '+ formatdatetime('yyyy-mm-dd',startDate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',endDate.Date);
    if Trim(NovaChkSaleOrg.Text) <>'' then
      log := log +',[��Ʊ����]��'+NovaChkSaleOrg.Text;
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��·ͣ������Ʊͳ�Ʊ�','��ѯ',log);

  end;
end;

end.
