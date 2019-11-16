unit UFrmFuelfeegradeDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet;

type
  TFrmFuelfeegradeDetail = class(TSimpleEditForm)
    Label1: TLabel;
    NovaEdtFromdistance: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaEdttodistance: TNovaEdit;
    NovaEdtFee: TNovaEdit;
    Label5: TLabel;
    jscdsaveFuelfeegradedetail: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,fuelfeegradeid,createby:int64;
    createtime:string;
  end;

var
  FrmFuelfeegradeDetail: TFrmFuelfeegradeDetail;

implementation
uses  PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmFuelfeegradeDetail.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
  if NovaEdtFromdistance.Text='' then
  begin
    SysDialogs.Warning('������Ӫ�˿�ʼ��̣�');
    NovaEdtFromdistance.SetFocus;
    exit;
  end;
  if NovaEdttodistance.Text='' then
  begin
    SysDialogs.Warning('������Ӫ�˽�����̣�');
    NovaEdttodistance.SetFocus;
    exit;
  end;
  if strtoint(NovaEdttodistance.Text)<=strtofloat(NovaEdtFromdistance.Text) then
  begin
    SysDialogs.Warning('Ӫ�˿�ʼ��̲��ܴ��ڽ�����̣�');
    NovaEdttodistance.SetFocus;
    exit;
  end;
  if NovaEdtFee.Text='' then
  begin
    SysDialogs.Warning('������ȼ�͸��ӷѣ�');
    NovaEdtFee.SetFocus;
    exit;
  end;
  if StrToFloat(NovaEdtFee.Text)>=999.99 then
  begin
    SysDialogs.Warning('����Ԥ��ֵ�������벻����999.99�ķ��ã�');
    NovaEdtFee.SetFocus;
    exit;
  end;

  try
    with jscdsaveFuelfeegradedetail do
    begin
      active := false;
      Params.ParamValues['fuelfeegradedetail.id'] := id;
      Params.ParamValues['fuelfeegradedetail.fuelfeegradeid'] :=fuelfeegradeid;
      Params.ParamValues['fuelfeegradedetail.fromdistance'] :=NovaEdtFromdistance.Text;
      Params.ParamValues['fuelfeegradedetail.todistance'] := NovaEdttodistance.Text;
      Params.ParamValues['fuelfeegradedetail.fee'] := NovaEdtFee.Text;
      Params.ParamValues['fuelfeegradedetail.createby'] := createby;
      Params.ParamValues['fuelfeegradedetail.updateby'] := sysinfo.LoginUserInfo.UserID;
      if createtime<>'' then
        Params.ParamValues['fuelfeegradedetail.createtime'] := createtime;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          optype := '�޸�'
        else
          optype := '���';
        log := optype +'ȼ�͸��ӷ�Ӫ�����������Ϣ��Ӫ�˿�ʼ���='
        +NovaEdtFromdistance.Text+',�������='+NovaEdttodistance.Text+
        ',ȼ�͸��ӷ�='+NovaEdtFee.Text;
        SysLog.WriteLog('Ʊ�۹���->ȼ�͸��ӷ�����',optype,log);
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtFromdistance.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('����ȼ�͸��ӷ�Ӫ�����������Ϣ����ʧ�ܣ�' + E.Message);
    end;
  end;

end;

end.
