unit UFrmInsuretypedistanceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet, NovaHComboBox;

type
  TFrmInsuretypedistanceEdt = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHInsuranceType: TNovaHelp;
    NovaEdtFromDistance: TNovaEdit;
    NovaEdtEndDistance: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    jscdSaveinsuretypedistance: TjsonClientDataSet;
    lbl5: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblorg: TLabel;
    lbl3: TLabel;
    nvHcbborgid: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaHInsuranceTypeChange(Sender: TObject);
    procedure nvHcbborgidChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    createtime:String;
    id,createby,orgid:int64;
  end;

var
  FrmInsuretypedistanceEdt: TFrmInsuretypedistanceEdt;

implementation
 uses Services, UDMPublic, PubFn;
{$R *.dfm}

procedure TFrmInsuretypedistanceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (Trim(nvHcbborgid.Text) = '') then
  begin
    SysDialogs.Warning('请填写所属车站!');
    nvHcbborgid.SetFocus;
    exit;
  end;
  if (trim(NovaHInsuranceType.Text)='') or (NovaHInsuranceType.Id=0) then
  begin
    SysDialogs.Warning('请选择保险类型！');
    NovaHInsuranceType.SetFocus;
    exit;
  end;

  if (trim(NovaEdtFromDistance.Text)='')then
  begin
    SysDialogs.Warning('请输入起始里程！');
    NovaEdtFromDistance.SetFocus;
    exit;
  end;
   if (trim(NovaEdtEndDistance.Text)='')then
  begin
    SysDialogs.Warning('请输入截止里程！');
    NovaEdtEndDistance.SetFocus;
    exit;
  end;
  if StrToInt(NovaEdtFromDistance.Text) > StrToInt(NovaEdtEndDistance.Text) then
  begin
     SysDialogs.Warning('起始里程不能大于截止里程！');
     NovaEdtFromDistance.SetFocus;
     Exit;
  end;

  if nvHcbborgid.ItemIndex>=0 then
  begin
    orgid := nvHcbborgid.HelpFieldValue['id'];
  end;

  with jscdSaveinsuretypedistance do
  begin
    Close;
    Params.ParamByName('insuretypedistance.id').Value :=id ;
    Params.ParamByName('insuretypedistance.orgid').Value :=orgid;
    Params.ParamByName('insuretypedistance.insuretypeid').Value := NovaHInsuranceType.id;
    Params.ParamByName('insuretypedistance.fromdistance').Value := NovaEdtFromDistance.Text;
    Params.ParamByName('insuretypedistance.enddistance').Value := NovaEdtEndDistance.Text;
    Params.ParamByName('insuretypedistance.createby').Value := createby;
    if createtime<>'' then
      Params.ParamByName('insuretypedistance.createtime').Value :=createtime;
    Params.ParamByName('insuretypedistance.updateby').Value :=Sysinfo.LoginUserInfo.UserID;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHInsuranceType.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保险类型里程相关信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmInsuretypedistanceEdt.FormCreate(Sender: TObject);
begin
  inherited;
  if id <= 0 then
  begin
    nvHcbborgid.Active := False;
    nvHcbborgid.Active := True;
    nvHcbborgid.SetItemIndexByField('id',Sysinfo.LoginUserInfo.OrgID);
  end;

end;

procedure TFrmInsuretypedistanceEdt.NovaHInsuranceTypeChange(Sender: TObject);
begin
  inherited;
  if Trim(NovaHInsuranceType.Text)<>'' then
  NovaHInsuranceType.Params.ParamValues['filter_EQL_o!id'] := nvHcbborgid.HelpFieldValue['id'];
end;

procedure TFrmInsuretypedistanceEdt.nvHcbborgidChange(Sender: TObject);
begin
  inherited;
  NovaHInsuranceType.Text:='';
end;

end.
