unit UFrmPackIntegrateRuleEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaComboBox,
  NovaHComboBox, NovaEdit, Services, DB, DBClient, jsonClientDataSet;

type
  TFrmPackIntegrateRuleEdt = class(TSimpleEditForm)
    Label2: TLabel;
    ncbclienttype: TNovaComboBox;
    Label3: TLabel;
    ncbintrule: TNovaComboBox;
    lbldistricttype: TLabel;
    nvedtintegrate: TNovaEdit;
    lblgrade: TLabel;
    nvedtprice: TNovaEdit;
    Label1: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    jcdsSaveIntegrateRule: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    id: LargeInt;
    createby, createtime: string;
    { Public declarations }
  end;

var
  FrmPackIntegrateRuleEdt: TFrmPackIntegrateRuleEdt;

implementation

{$R *.dfm}

procedure TFrmPackIntegrateRuleEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, log: string;
begin
  inherited;
  if NovaCbbOrg.Text = '' then
  begin
    SysDialogs.ShowMessage('所属站点不能为空!');
    NovaCbbOrg.SetFocus;
    exit;
  end;

  if ncbclienttype.Text = '' then
  begin
    SysDialogs.ShowMessage('客户类型不能为空!');
    ncbclienttype.SetFocus;
    exit;
  end;
  if ncbintrule.Text = '' then
  begin
    SysDialogs.ShowMessage('积分规则不能为空!');
    ncbintrule.SetFocus;
    exit;
  end;

  if nvedtintegrate.Text = '' then
  begin
    SysDialogs.ShowMessage('积分不能为空!');
    nvedtintegrate.SetFocus;
    exit;
  end;
  if nvedtprice.Text = '' then
  begin
    SysDialogs.ShowMessage('金额不能为空!');
    nvedtprice.SetFocus;
    exit;
  end;
  with jcdsSaveIntegrateRule do
  begin
    Params.ParamValues['packIntegrateRule.clienttype'] :=
      ncbclienttype.GetSelectCode;
    Params.ParamValues['packIntegrateRule.type'] := ncbintrule.GetSelectCode;
    Params.ParamValues['packIntegrateRule.orgid'] := NovaCbbOrg.HelpFieldValue
      ['id'];
    Params.ParamValues['packIntegrateRule.price'] := nvedtprice.Text;
    Params.ParamValues['packIntegrateRule.integrate'] := nvedtintegrate.Text;
    if id > 0 then
    begin
      Params.ParamValues['packIntegrateRule.id'] := id;
      //Params.ParamValues['packIntegrateRule.createby'] := createby;
      //Params.ParamValues['packIntegrateRule.createtime'] := createtime;
    end
    else
    begin
      Params.ParamValues['packIntegrateRule.id'] := 0;
    end;

    bbtnSave.Enabled := false;
    Execute;
    bbtnSave.Enabled := true;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;

    if (nResult = 1) then
    begin
      log := '所属站点=' + NovaCbbOrg.Text + ',客户类型=' + ncbclienttype.Text +
        ',积分规则=' + ncbintrule.Text + ',积分=' + nvedtintegrate.Text + ',金额=' +
        nvedtprice.Text;
      SysLog.WriteLog('行包管理——>积分规则设置', '添加', log);
      SysDialogs.ShowMessage(sResult);
      ModalResult := mrok;
    end
    else
    begin
      SysDialogs.Warning(sResult);
    end;
  end;
end;

procedure TFrmPackIntegrateRuleEdt.FormCreate(Sender: TObject);
begin
  inherited;
  with NovaCbbOrg do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!id'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] := '(1,2)'; // 车站、配客点
    Active := true;
    { if Items.Count > 0 then
      begin
      ItemIndex := 0;
      end; }
  end;
  ncbclienttype.Active := false;
  ncbclienttype.Active := true;
  ncbintrule.Active := false;
  ncbintrule.Active := true;
end;

procedure TFrmPackIntegrateRuleEdt.FormShow(Sender: TObject);
begin
  inherited;
  { with NovaCbbOrg do
    begin
    Active := false;
    Params.ParamValues['filter_INS_t!id'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] := '(1,2)'; // 车站、配客点
    Active := true;
    if Items.Count > 0 then
    begin
    ItemIndex := 0;
    end;
    end;
    ncbclienttype.Active := false;
    ncbclienttype.Active := true;
    ncbintrule.Active := false;
    ncbintrule.Active := true;

    if id > 0 then
    begin
    with jcdsSaveIntegrateRule do
    begin
    Active := false;
    Params.ParamValues['filter_EQL_p!id'] := id;
    Active := true;
    if jcdsSaveIntegrateRule.FieldByName('clienttype').AsString <> '' then
    begin
    ncbclienttype.SetItemIndexByCode(jcdsSaveIntegrateRule.FieldByName
    ('clienttype').AsString);
    ncbintrule.SetItemIndexByCode(jcdsSaveIntegrateRule.FieldByName('type')
    .AsString);
    ncbclienttype.Enabled := false;
    ncbintrule.Enabled := false;
    nvedtprice.Text := jcdsSaveIntegrateRule.FieldByName('price').AsString;
    nvedtintegrate.Text := jcdsSaveIntegrateRule.FieldByName('integrate')
    .AsString;
    end;
    end;
    end;
    }
  if id > 0 then
  begin
    with jcdsSaveIntegrateRule do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_p!id'] := id;
      Active := true;
    end;
  end;
end;

end.
