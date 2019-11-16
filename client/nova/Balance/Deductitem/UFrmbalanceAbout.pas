unit UFrmbalanceAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList;

type
  TFrmbalanceAbout = class(TSimpleEditForm)
    Label6: TLabel;
    NovaEdtName: TNovaEdit;
    LabFrom: TLabel;
    LabEnd: TLabel;
    Label8: TLabel;
    NovaEdtFrom: TNovaEdit;
    NovaEdtEnd: TNovaEdit;
    NovaEdtValue: TNovaEdit;
    RbAboutDistance: TRadioButton;
    RbAboutPrice: TRadioButton;
    jcsdSaveAboutDistance: TjsonClientDataSet;
    jcdsSaveAboutPrice: TjsonClientDataSet;
    procedure RbAboutDistanceClick(Sender: TObject);
    procedure RbAboutPriceClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure saveAboutDistance;
    procedure saveAboutPrice;
  public
    { Public declarations }
    balanceid,id,createby:int64;
    createtime:String;
  end;

var
  FrmbalanceAbout: TFrmbalanceAbout;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmbalanceAbout.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if RbAboutDistance.Checked then
     saveAboutDistance
  else
     saveAboutPrice;
end;

procedure TFrmbalanceAbout.RbAboutDistanceClick(Sender: TObject);
begin
  inherited;
  if RbAboutDistance.Checked then
  begin
    LabFrom.Caption := '��ʼ���';
    LabEnd.Caption := '��ֹ���';
  end;
end;

procedure TFrmbalanceAbout.RbAboutPriceClick(Sender: TObject);
begin
  inherited;
  if RbAboutPrice.Checked then
  begin
    LabFrom.Caption := '��ʼƱ��';
    LabEnd.Caption := '��ֹƱ��';
  end;
end;

procedure TFrmbalanceAbout.saveAboutDistance;
var
 nResult:integer;
 sResult:String;
begin
  inherited;
  if trim(NovaEdtFrom.Text) = '' then
  begin
    SysDialogs.Warning('��������ʼ��̣�');
    NovaEdtFrom.SetFocus;
    exit;
  end;
  if trim(NovaEdtEnd.Text) = '' then
  begin
    SysDialogs.Warning('�������ֹ��̣�');
    NovaEdtEnd.SetFocus;
    exit;
  end;
  if strtoint(trim(NovaEdtEnd.Text)) < strtoint(trim(NovaEdtFrom.Text)) then
  begin
    SysDialogs.Warning('��������ʼ��̲��ܴ��ڽ�ֹ��̣�');
    NovaEdtFrom.SetFocus;
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    SysDialogs.Warning('������۷ѽ�');
    NovaEdtValue.SetFocus;
    exit;
  end;
  try
    with jcsdSaveAboutDistance do
    begin
      active := false;
      Params.ParamValues['balancedeductitemdistance.id'] := id;
      Params.ParamValues['balancedeductitemdistance.createby'] := createby;
      Params.ParamValues['balancedeductitemdistance.createtime'] := createtime;
      Params.ParamValues['balancedeductitemdistance.value'] := trim(NovaEdtValue.Text);
      Params.ParamValues['balancedeductitemdistance.fromdistance'] := trim(NovaEdtFrom.Text);
      Params.ParamValues['balancedeductitemdistance.enddistance'] := trim(NovaEdtEnd.Text);
      Params.ParamValues['balancedeductitemdistance.balancedeductitem.id'] := balanceid;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        id:=Params.ParamByName('curid').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�������۷���������Ŀ����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmbalanceAbout.saveAboutPrice;
var
 nResult:integer;
 sResult:String;
begin
  inherited;
  if trim(NovaEdtFrom.Text) = '' then
  begin
    SysDialogs.Warning('��������ʼƱ�ۣ�');
    NovaEdtFrom.SetFocus;
    exit;
  end;
  if trim(NovaEdtEnd.Text) = '' then
  begin
    SysDialogs.Warning('�������ֹƱ�ۣ�');
    NovaEdtEnd.SetFocus;
    exit;
  end;
  if strtofloat(trim(NovaEdtEnd.Text)) < strtofloat(trim(NovaEdtFrom.Text)) then
  begin
    SysDialogs.Warning('��������ʼƱ�۲��ܴ��ڽ�ֹƱ�ۣ�');
    NovaEdtFrom.SetFocus;
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    SysDialogs.Warning('������۷ѽ�');
    NovaEdtValue.SetFocus;
    exit;
  end;
  try
    with jcdsSaveAboutPrice do
    begin
      active := false;
      Params.ParamValues['balancedeductitemprice.id'] := id;
      Params.ParamValues['balancedeductitemprice.createby'] := Sysinfo.LoginUserInfo.UserID;
      Params.ParamValues['balancedeductitemprice.createtime'] := createtime;
      Params.ParamValues['balancedeductitemprice.value'] := trim(NovaEdtValue.Text);
      Params.ParamValues['balancedeductitemprice.fromprice'] := trim(NovaEdtFrom.Text);
      Params.ParamValues['balancedeductitemprice.endprice'] := trim(NovaEdtEnd.Text);
      Params.ParamValues['balancedeductitemprice.balancedeductitem.id'] := balanceid;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        id:=Params.ParamByName('curid').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�������Ʊ����ؿ۷���Ŀ����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

end.
