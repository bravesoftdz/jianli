unit UFrmInsuretypepriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaHComboBox, NovaEdit, NovaHelp,
  ImgList, Buttons, ExtCtrls, DB, DBClient, jsonClientDataSet,Services;

type
  TFrmInsuretypepriceEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl5: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblorg: TLabel;
    lbl3: TLabel;
    NovaHInsuranceType: TNovaHelp;
    NovaEdtFromDistance: TNovaEdit;
    NovaEdtEndDistance: TNovaEdit;
    nvHcbborgid: TNovaHComboBox;
    jscdSaveinsuretypedistance: TjsonClientDataSet;
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
  FrmInsuretypepriceEdt: TFrmInsuretypepriceEdt;

implementation

{$R *.dfm}

procedure TFrmInsuretypepriceEdt.bbtnSaveClick(Sender: TObject);
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
    SysDialogs.Warning('请输入起始价！');
    NovaEdtFromDistance.SetFocus;
    exit;
  end;
   if (trim(NovaEdtEndDistance.Text)='')then
  begin
    SysDialogs.Warning('请输入截止价！');
    NovaEdtEndDistance.SetFocus;
    exit;
  end;
  if StrToInt(NovaEdtFromDistance.Text) > StrToInt(NovaEdtEndDistance.Text) then
  begin
     SysDialogs.Warning('起始价不能大于截止价！');
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
    Params.ParamByName('insuretypeticketprice.id').Value :=id ;
    Params.ParamByName('insuretypeticketprice.orgid').Value :=orgid;
    Params.ParamByName('insuretypeticketprice.insuretypeid').Value := NovaHInsuranceType.id;
    Params.ParamByName('insuretypeticketprice.fromprice').Value := NovaEdtFromDistance.Text;
    Params.ParamByName('insuretypeticketprice.endprice').Value := NovaEdtEndDistance.Text;
    Params.ParamByName('insuretypeticketprice.createby').Value := createby;
    if createtime<>'' then
      Params.ParamByName('insuretypeticketprice.createtime').Value :=createtime;
    Params.ParamByName('insuretypeticketprice.updateby').Value :=Sysinfo.LoginUserInfo.UserID;

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
        SysLog.WriteErr('保险类型票价相关信息添加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmInsuretypepriceEdt.FormCreate(Sender: TObject);
begin
  inherited;
  if id <= 0 then
  begin
    nvHcbborgid.Active := False;
    nvHcbborgid.Active := True;
    nvHcbborgid.SetItemIndexByField('id',Sysinfo.LoginUserInfo.OrgID);
  end;
end;

procedure TFrmInsuretypepriceEdt.NovaHInsuranceTypeChange(Sender: TObject);
begin
  inherited;
  if Trim(NovaHInsuranceType.Text)<>'' then
  NovaHInsuranceType.Params.ParamValues['filter_EQL_o!id'] := nvHcbborgid.HelpFieldValue['id'];
end;

procedure TFrmInsuretypepriceEdt.nvHcbborgidChange(Sender: TObject);
begin
  inherited;
   NovaHInsuranceType.Text:='';
end;

end.
