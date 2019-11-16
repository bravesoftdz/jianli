unit UFrmBalanceDivideEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, NovaHComboBox, DB, DBClient, jsonClientDataSet;

type
  TFrmBalanceDivideEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label8: TLabel;
    NovaHelpVehicle: TNovaHelp;
    Label9: TLabel;
    NHelpRoute: TNovaHelp;
    Label2: TLabel;
    NovaHDivideVehicle: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    jscdsaveBalancedivide: TjsonClientDataSet;
    Label19: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    NovaEdtDivide: TNovaEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHelpVehicleIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,createby:int64;
    createtime:string;
  end;

var
  FrmBalanceDivideEdt: TFrmBalanceDivideEdt;

implementation
uses PubFn,Services,UDMPublic;
{$R *.dfm}

procedure TFrmBalanceDivideEdt.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult,log: string;
begin
  inherited;

  if (NHelpRoute.Id=0) or (NHelpRoute.Text='') then
  begin
    NHelpRoute.SetFocus;
    SysDialogs.ShowMessage('��ѡ��ֳ���·��');
    exit;
  end;
  if (NovaHelpVehicle.Id=0) or (NovaHelpVehicle.Text='') then
  begin
    NovaHelpVehicle.SetFocus;
    SysDialogs.ShowMessage('��ѡ��Ӫ�˳�����');
    exit;
  end;
  if (NovaHelpUnit.Id=0) or (NovaHelpUnit.Text='') then
  begin
    NovaHelpUnit.SetFocus;
    SysDialogs.ShowMessage('��ѡ����㵥λ��');
    exit;
  end;
  if (NovaHDivideVehicle.Id=0) or (NovaHDivideVehicle.Text='') then
  begin
    NovaHDivideVehicle.SetFocus;
    SysDialogs.ShowMessage('��ѡ��ֳɶ���');
    exit;
  end;
  if (NovaEdtDivide.Text='')then
  begin
    NovaEdtDivide.SetFocus;
    SysDialogs.ShowMessage('������ֳɱ�����');
    exit;
  end;
  if (NovaEdtDivide.Text='0') or (NovaEdtDivide.Text='1') then
  begin
    NovaEdtDivide.SetFocus;
    SysDialogs.ShowMessage('�ֳɱ���������Ϊ0����1');
    exit;
  end;
  if (strtofloat(NovaEdtDivide.Text)>1) or (strtofloat(NovaEdtDivide.Text)<=0) then
  begin
    NovaEdtDivide.SetFocus;
    SysDialogs.ShowMessage('�ֳɱ���ֻ����0-1֮�䣡');
    exit;
  end;

  with jscdsaveBalancedivide do
  begin
    close;
    Params.ParamByName('balancedivide.id').Value := id;
    Params.ParamByName('balancedivide.routeid').Value := NHelpRoute.Id ;
    Params.ParamByName('balancedivide.vehicleid').Value := NovaHelpVehicle.Id;
    Params.ParamByName('balancedivide.dividevehicleid').Value := NovaHDivideVehicle.Id;
    Params.ParamByName('balancedivide.divide').Value := NovaEdtDivide.Text;
    Params.ParamByName('balancedivide.orgid').Value :=NovaHCbbOrg.HelpFieldValue['id'];;
    if createtime <> '' then
      Params.ParamByName('balancedivide.createtime').Value := createtime;
    Params.ParamByName('balancedivide.createby').Value := createby;
    try
      Execute;
      log := '���ý���ֳ�Э����Ϣ��Ӫ����·='+NHelpRoute.Text+
      ',Ӫ�˳���='+NovaHelpVehicle.Text+',���㵥λ='+
      NovaHelpUnit.Text+',�ֳɵ�λ='+
      NovaHDivideVehicle.Text+ ',�ֳɱ���='+
      NovaEdtDivide.Text;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult >0) then
      begin
        if (Tedittype.add=edittype) then
          SysLog.WriteLog('�������->����ֳ�Э��','���',log)
        else
          SysLog.WriteLog('�������->����ֳ�Э��','�޸�',log);
        id := Params.ParamByName('balancedivideid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�������ֳ�Э��ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmBalanceDivideEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active:=false;
  NovaHCbbOrg.Active:=true;
end;

procedure TFrmBalanceDivideEdt.FormShow(Sender: TObject);
begin
  inherited;
  NHelpRoute.SetFocus;
end;

procedure TFrmBalanceDivideEdt.NovaHelpVehicleIdChange(Sender: TObject);
begin
  inherited;
  if (NovaHelpVehicle.Text<>'') and (NovaHelpVehicle.Id>0)
   and NovaHelpVehicle.isactive then
  begin
    NovaHelpUnit.Text:=NovaHelpVehicle.HelpFieldValue['balancename'];
    NovaHelpUnit.id:=NovaHelpVehicle.HelpFieldValue['balanceunitid'];
  end;
end;

end.
