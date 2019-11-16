unit UFrmFuelfeegradeEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHComboBox;

type
  TFrmFuelfeegradeEdt = class(TSimpleEditForm)
    Label11: TLabel;
    NovaHCobOrg: TNovaHComboBox;
    Label1: TLabel;
    CobGrade: TComboBox;
    Label2: TLabel;
    NovaEdtFrom: TNovaEdit;
    Label3: TLabel;
    NovaEdtTo: TNovaEdit;
    jscdsaveFuelfeegrade: TjsonClientDataSet;
    Label4: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,orgid,createby:int64;
    createtime:string;
  end;

var
  FrmFuelfeegradeEdt: TFrmFuelfeegradeEdt;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmFuelfeegradeEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
  if CobGrade.Text='' then
  begin
    SysDialogs.Warning('��ѡ������뵵�Σ�');
    CobGrade.SetFocus;
    exit;
  end;
  if NovaEdtFrom.Text='' then
  begin
    SysDialogs.Warning('�������ͼۿ�ʼ�۸�');
    NovaEdtFrom.SetFocus;
    exit;
  end;
  if NovaEdtTo.Text='' then
  begin
    SysDialogs.Warning('�������ͼ۽����۸�');
    NovaEdtTo.SetFocus;
    exit;
  end;
  if strtofloat(NovaEdtTo.Text)<=strtofloat(NovaEdtFrom.Text) then
  begin
    SysDialogs.Warning('�ͼۿ�ʼ�۸��ܴ��ڽ����۸�');
    NovaEdtFrom.SetFocus;
    exit;
  end;
  try
    with jscdsaveFuelfeegrade do
    begin
      active := false;
      Params.ParamValues['fuelfeegrade.id'] := id;
      Params.ParamValues['fuelfeegrade.grade'] :=CobGrade.Text;
      Params.ParamValues['fuelfeegrade.fromprice'] :=NovaEdtFrom.Text;
      Params.ParamValues['fuelfeegrade.toprice'] := NovaEdtTo.Text;
      Params.ParamValues['fuelfeegrade.orgid'] := NovaHCobOrg.HelpFieldValue['id'];
      Params.ParamValues['fuelfeegrade.createby'] := createby;
      Params.ParamValues['fuelfeegrade.updateby'] := sysinfo.LoginUserInfo.UserID;
      if createtime<>'' then
        Params.ParamValues['fuelfeegrade.createtime'] := createtime;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          optype := '�޸�'
        else
          optype := '���';
        log := optype +'ȼ�͸��ӷ��ͼ�������Ϣ������='+NovaHCobOrg.Text+'�ͼ۵���='
        +CobGrade.Text+',��ʼ�۸�='+NovaEdtFrom.Text+
        ',�����۸�='+NovaEdtTo.Text;
        SysLog.WriteLog('Ʊ�۹���->ȼ�͸��ӷ�����',optype,log);
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        CobGrade.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('����ȼ�͸��ӷ��ͼ��������ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmFuelfeegradeEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCobOrg.Active := false;
  NovaHCobOrg.Active := true;
  NovaHCobOrg.SetItemIndexByField('id',sysinfo.LoginUserInfo.OrgID);
end;

end.
