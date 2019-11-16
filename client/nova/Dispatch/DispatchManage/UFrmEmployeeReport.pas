unit UFrmEmployeeReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet;

type
  TFrmEmployeeReport = class(TSimpleEditForm)
    lbl6: TLabel;
    lbl7: TLabel;
    nvhlpdriver1: TNovaHelp;
    nvhlpdriver2: TNovaHelp;
    jsonDriverShowValidate: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    routedistance,eid1,eid2,employees: integer;
  end;

var
  FrmEmployeeReport: TFrmEmployeeReport;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmEmployeeReport.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: String;
  controdistance: Int64;
begin
  inherited;
  if employees=2 then
  begin
    if (nvhlpdriver1.Id <= 0) or (trim(nvhlpdriver1.Text) = '') then
    begin
      SysDialogs.Warning('�������ʻԱ��Ϣ��');
      nvhlpdriver1.SetFocus;
      exit;
    end;
    if (nvhlpdriver2.Id <= 0) or (trim(nvhlpdriver2.Text) = '') then
    begin
      SysDialogs.Warning('�������ʻԱ��Ϣ��');
      nvhlpdriver2.SetFocus;
      exit;
    end;
  end
  else
  begin
    if (nvhlpdriver1.Id <= 0) and (trim(nvhlpdriver1.Text) = '') then
    begin
      SysDialogs.Warning('�������ʻԱ��Ϣ��');
      nvhlpdriver1.SetFocus;
      exit;
    end;
    // 2023:����˾������·��̶���
    controdistance := strtoint(getParametervalue('2023',
        Sysinfo.LoginUserInfo.OrgID));
    if routedistance >= controdistance then
    begin
      if ((nvhlpdriver1.Id <= 0) or (nvhlpdriver2.Id <= 0)) then
      begin
        SysDialogs.Warning('����·��������˾��ͬʱ������');
        exit;
      end;

    end;

  end;

  if (nvhlpdriver1.Id = nvhlpdriver2.Id) then
  begin
    SysDialogs.Warning('2����ʻԱ��Ϣ����һ����');
    nvhlpdriver2.SetFocus;
    exit;
  end;


  // �����ʻԱ�����룬�������֤֤����Ч�ڣ�������ʾ������ʾ�����ڲ��ܱ�

  with jsonDriverShowValidate do
  begin
    Close;
    Params.ParamValues['driverid'] := nvhlpdriver1.Id;
    Params.ParamValues['driver1id'] := nvhlpdriver2.Id;
    Params.ParamValues['driver2id'] := 0;
    Params.ParamValues['driver3id'] := 0;
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.OrgID;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    if nResult = 0 then
    begin
      SysDialogs.Warning(sResult);
    end;
    if nResult < 0 then
    begin
      SysDialogs.Warning(sResult);
      exit;
    end;

  end;
  eid1:=nvhlpdriver1.Id;
  eid2:=nvhlpdriver2.Id;
  ModalResult := mrok;

end;

end.
