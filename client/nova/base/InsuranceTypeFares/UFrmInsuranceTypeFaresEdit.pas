unit UFrmInsuranceTypeFaresEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHelp, NovaHComboBox, Services,UDMPublic;

type
  TFrmInsuranceTypeFaresEdit = class(TSimpleEditForm)
    lblorg: TLabel;
    nvHcbborgid: TNovaHComboBox;
    lbl3: TLabel;
    Label1: TLabel;
    NovaHInsuranceType: TNovaHelp;
    lbl5: TLabel;
    Label2: TLabel;
    NovaEdtFromFares: TNovaEdit;
    NovaEdtEndFares: TNovaEdit;
    Label3: TLabel;
    jscdSaveinsuretypeFares: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sResult: String;
     ss: String;
    createtime: String;
    id, createby, orgid: int64;
  end;

var
  FrmInsuranceTypeFaresEdit: TFrmInsuranceTypeFaresEdit;

implementation

{$R *.dfm}

procedure TFrmInsuranceTypeFaresEdit.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if (Trim(nvHcbborgid.Text) = '') then
  begin
    SysDialogs.Warning('请填写所属车站!');
    nvHcbborgid.SetFocus;
    exit;
  end;
  if (Trim(NovaHInsuranceType.Text) = '') or (NovaHInsuranceType.id = 0) then
  begin
    SysDialogs.Warning('请填写保险类型！');
    NovaHInsuranceType.SetFocus;
    exit;
  end;

  if (Trim(NovaEdtFromFares.Text) = '') then
  begin
    SysDialogs.Warning('请输入起始票价！');
    NovaEdtFromFares.SetFocus;
    exit;
  end;
  if (Trim(NovaEdtEndFares.Text) = '') then
  begin
    SysDialogs.Warning('请输入截止票价！');
    NovaEdtEndFares.SetFocus;
    exit;
  end;
  if StrToInt(NovaEdtFromFares.Text) > StrToInt(NovaEdtEndFares.Text) then
  begin
    SysDialogs.Warning('起始票价不能大于截止票价！');
    NovaEdtFromFares.SetFocus;
    exit;
  end;
  if nvHcbborgid.ItemIndex >= 0 then
  begin
    orgid := nvHcbborgid.HelpFieldValue['id'];
  end;
  with jscdSaveinsuretypeFares do
  begin
    Close;   //修改传ID
    if (self.edittype = Tedittype.update) then
      Params.ParamByName('insurancetypefares.id').Value := id;
    

//     Params.ParamByName('insuranceTypeFares.id').Value := nvHcbborgid.HelpFieldValue['id'];
//     ss :=nvHcbborgid.HelpFieldValue['id']  ;
    Params.ParamByName('insurancetypefares.orgid').Value := orgid;
    Params.ParamByName('insurancetypefares.insuretypeid').Value :=
      NovaHInsuranceType.id;
    Params.ParamByName('insurancetypefares.fromprice').Value :=
      NovaEdtFromFares.Text;
    Params.ParamByName('insurancetypefares.endprice').Value :=
      NovaEdtEndFares.Text;
    Execute;
     sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
     if Params.ParamByName('flag').Value>0 then
        ModalResult := mrok
     else
        NovaEdtFromFares.SetFocus;

 //    id :=  strtoint(Params.ParamByName('flag').Value);
  end;
end;

procedure TFrmInsuranceTypeFaresEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvHcbborgid.Active := true;
end;

end.
