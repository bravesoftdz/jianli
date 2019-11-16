unit UFrmVehicleStationDepartinvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmVehicleStationDepartinvoice = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    Label2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    lblendstationname: TLabel;
    lblroute: TLabel;
    nvhlpendstation: TNovaHelp;
    nvhlpRoute: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleStationDepartinvoice: TFrmVehicleStationDepartinvoice;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmVehicleStationDepartinvoice.FormCreate(Sender: TObject);
begin
  inherited;
    dtpstartdate.DateTime := Now();
    dtpenddate.DateTime := Now();
    cbborg.Active := False;
    cbborg.Active := True;
    cbborg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmVehicleStationDepartinvoice.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
   if (cbborg.GetCount = 0) or (cbborg.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
  if nvhelpvehicleno.Id = 0 then
  begin
    SysDialogs.ShowMessage('������д������Ϣ��');
    Exit;
  end  ;
  if (FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) )then
  begin
    SysDialogs.ShowMessage('������ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['orgid'] := cbborg.GetSelectID;
    Params.ParamValues['vehicleid'] := nvhelpvehicleno.Id;

    if nvhlproute.Id > 0 then
      params.ParamValues['routeid'] := nvhlproute.HelpFieldValue['id']
    else
      params.ParamValues['routeid'] := '';

    if (Trim(nvhlpendstation.Text)<>'') then
    begin
      Params.ParamValues['stationid']:= nvhlpendstation.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['stationid']:= '';
    end;

    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd', (dtpstartdate.Date));
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd', (dtpenddate.Date));
    Active:= true;
    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbborg.Text) <>'' then
      log := log +',[��������]��'+cbborg.Text;
    if nvhlpRoute.Id <> 0 then
      log  := log +',[��·]:'+nvhlpRoute.Text;
    if nvhelpvehicleno.Id <> 0 then
      log := log +'[����]��'+nvhelpvehicleno.Text;
    if nvhlpendstation.Id <> 0 then
      log := log +',[����վ]:'+ nvhlpendstation.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->����ͣ��վ������������ܱ�','��ѯ',log);
  end;
end;

end.
