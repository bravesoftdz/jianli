unit UFrmVehicleDistanceActive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, NvPrnDbgeh, NvDbgridEh,
   NovaCheckedComboBox,UDMPublic, Services, PubFn;

type
  TFrmVehicleDistanceActive = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    lblUserId: TLabel;
    jcdsSave: TjsonClientDataSet;
    nvhlpUserid: TNovaHelp;
    nvhlpvehicleno: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vehicleid : Integer;
  end;

var
  FrmVehicleDistanceActive: TFrmVehicleDistanceActive;

implementation

uses UFrmVehicleDistanceActiveHistory;
{$R *.dfm}

procedure TFrmVehicleDistanceActive.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  //�Ƿ�����������ά����Ч��
  if getParametervalue('6006', Sysinfo.LoginUserInfo.OrgID) = '0' then
  begin
     dbgrdhResult.Columns[3].Visible := False;
  end
  else
  begin
    dbgrdhResult.Columns[3].Visible := True;
  end;
end;

//��ѯ���һ�μ����¼
procedure TFrmVehicleDistanceActive.tbtnFilterClick(Sender: TObject);
begin
 inherited;
 //�Ƿ��������������
  if getParametervalue('0143', Sysinfo.LoginUserInfo.OrgID) = '0' then
  begin
    SysDialogs.ShowMessage('����0143δ��������������ƵĹ��ܣ�');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  with jcdsResult do
  begin
    Active := false;
      Params.ParamByName('startdate').Value
      := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime);
    Params.ParamByName('enddate').Value
      := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime)+' 23:59:59' ;
     if Trim(nvhlpvehicleno.Text) = '' then
    begin
      Params.ParamValues['vehicleid'] := '';
    end else
    begin
      Params.ParamValues['vehicleid'] := nvhlpvehicleno.Id
    end;
    if (not (Trim(nvhlpUserid.Text) = '')) and (nvhlpUserid.Id>0) then //�û���
    begin
      Params.ParamValues['userid']:= nvhlpUserid.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['userid']:= '';
    end;

    Active := True;
  end;
end;

//��ѯ��ʷ�����¼
procedure TFrmVehicleDistanceActive.tbtnEditClick(Sender: TObject);
begin
  try
    frmVehicleDistanceActiveHistory := TfrmVehicleDistanceActiveHistory.Create(self);
    with frmVehicleDistanceActiveHistory do
    begin
      Caption := '����������Ƽ�����ʷ��¼';
      dtpstartdate.Date:= Now;
      dtpenddate.Date := Now;
      if  (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
     begin
      nvhlpvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
      vehicleno :=  jcdsResult.FieldByName('vehicleno').AsString;
      vehicleid := jcdsResult.FieldByName('vehicleid').AsInteger;
      with jcdsVehicledistancehistory do
      begin
        Active:=False;
        Params.ParamByName('filter_GTD_vd!createtime').Value
              := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime);
        Params.ParamByName('filter_LED_vd!createtime').Value
              := FormatDateTime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime) ;
        Params.ParamByName('filter_EQL_v!id').Value := jcdsResult.FieldByName('vehicleid').AsString;
        Active := True;
      end;
     end;
      ShowModal;
    end;
  finally
    FreeAndNil(frmVehicleDistanceActiveHistory);
  end;

end;

 //�����
procedure TFrmVehicleDistanceActive.tbtnInsertClick(Sender: TObject);
var  msg,sResult: String;
  nResult: integer;
begin
  if not jcdsResult.active then
    exit;

  if jcdsResult.RecordCount = 0 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫ�����:'
          +jcdsResult.FieldByName('vehicleno').AsString+'��?') then
    exit;

  with jcdsSave do
  begin
   try
    close;
     Params.ParamByName('vehicledistance.vehicleid').Value
                      :=jcdsResult.FieldByName('vehicleid').AsString;
     Params.ParamByName('vehicledistance.lastactivetime').Value
                      :=jcdsResult.FieldByName('createtime').AsString;
     Params.ParamByName('vehicledistance.departdistance').Value
                      :=jcdsResult.FieldByName('departdistance').AsString;
     Params.ParamByName('vehicledistance.limitdistance').Value
                      :=jcdsResult.FieldByName('distancelimit').AsString;
     Execute;
     nResult := Params.ParamByName('flag').Value;
     sResult := Params.ParamByName('msg').Value;
     SysDialogs.ShowMessage(sResult);
     if (nResult > 0) then
     begin
       SysLog.WriteLog('������ʻ��̹���', '��������',
       '���ƺţ�'+jcdsResult.FieldByName('vehicleno').AsString +','
       +'����ʱ�ѷ�����̣�'+jcdsResult.FieldByName('departdistance').AsString);
      vehicleid := Params.ParamByName('vehicleid').Value;

     end;
       tbtnFilterClick(Sender);
      jcdsResult.Locate('vehicleid',vehicleid,[] );

   except
      on E: Exception do
      begin
        SysLog.WriteErr('����ʧ�ܣ�' + E.Message);
      end;
    end;

  end;
end;
end.
