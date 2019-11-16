unit UFrmVehicleviolationProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, NovaComboBox, ComCtrls, DB, DBClient, jsonClientDataSet;

type
  TFrmVehicleviolationProcess = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    NHelpRoute: TNovaHelp;
    cbbhandleret: TNovaComboBox;
    lbl3: TLabel;
    edtbreachfee: TNovaEdit;
    lbl4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dtpdepartdate: TDateTimePicker;
    edtdeparttime: TDateTimePicker;
    jcdsVehProcess: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure cbbhandleretChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtbreachfeeExit(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    flag : Boolean;
    id : Int64;
  end;

var
  FrmVehicleviolationProcess: TFrmVehicleviolationProcess;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmVehicleviolationProcess.bbtnSaveClick(Sender: TObject);
var nResult : Int64;
    sResult : String;
begin
  inherited;
  if Trim(cbbhandleret.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ��������');
    Exit;
  end;
  if Trim(edtbreachfee.Text) = '' then
  begin
    SysDialogs.ShowMessage('�����뽻ΥԼ��Ľ�');
    Exit;
  end;
  with jcdsVehProcess do
  begin
    Close;
    params.ParamValues['vehicleviolation.id'] := id;
    Params.ParamValues['vehicleviolation.handleret'] := TCommInfo(cbbhandleret.Items.Objects[cbbhandleret.ItemIndex]).Value;;
    params.ParamValues['vehicleviolation.breachfee'] := edtbreachfee.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);

      log := '���Ӫ�˳���Υ�洦�����ƺ���='+nvhelpvehicleno.Text;
      if Trim(NHelpRoute.Text) <> '' then
      begin
        log := log + ',Ӫ����·='+NHelpRoute.Text;
      end;
      log := log + ',��������='+DateTimeToStr(dtpdepartdate.DateTime)+',����ʱ��='+
      DateTimeToStr(edtdeparttime.Time)+',������='+cbbhandleret.Text;
      if cbbhandleret.ItemIndex = 1 then
      begin
        log := log + ',��ΥԼ��='+edtbreachfee.Text;
      end;
      SysLog.WriteLog('���������>Ӫ�˳���Υ�洦��','���',log);
      id := Params.ParamByName('id').Value;
      ModalResult := mrok;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ӫ�˳���Υ�洦��ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehicleviolationProcess.cbbhandleretChange(Sender: TObject);
begin
  inherited;
  if cbbhandleret.ItemIndex = 0 then
  begin
    edtbreachfee.Enabled := False;
    edtbreachfee.Text := '0';
  end else
    edtbreachfee.Enabled := True;
end;

procedure TFrmVehicleviolationProcess.edtbreachfeeExit(Sender: TObject);
begin
  inherited;
  if cbbhandleret.ItemIndex = 0 then
    edtbreachfee.Text := '0'
  else
    edtbreachfee.Text := formatfloat('0.00', StrToFloat(edtbreachfee.Text));
  if Length(Trim(edtbreachfee.Text)) > 9 then
  begin
    SysDialogs.ShowMessage('�Բ�����ֻ������6λ���������������룡');
    edtbreachfee.SetFocus;
    Exit;
  end;
end;

procedure TFrmVehicleviolationProcess.FormCreate(Sender: TObject);
begin
  inherited;
  cbbhandleret.Active := False;
  cbbhandleret.Active := True;
end;

end.
