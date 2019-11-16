unit UFrmPackIntegrateRule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh,
  DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, NovaComboBox;

type
  TFrmPackIntegrateRule = class(TSimpleCRUDForm)
    jcdsResultid: TLargeintField;
    jcdsResultclienttype: TWideStringField;
    jcdsResultprice: TFloatField;
    jcdsResultorgid: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    Label1: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    Label2: TLabel;
    Label3: TLabel;
    ncbclienttype: TNovaComboBox;
    ncbintrule: TNovaComboBox;
    jcdsResulttype: TIntegerField;
    jcdsResultintegrate: TLargeintField;
    jcdsDelPackIntegrateRule: TjsonClientDataSet;
    jcdsClientType: TjsonClientDataSet;
    jcdsResulttypevalue: TWideStringField;
    jcdsResultclienttypevalue: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsType: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPackIntegrateRule: TFrmPackIntegrateRule;

implementation

uses UFrmPackIntegrateRuleEdt, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmPackIntegrateRule.FormCreate(Sender: TObject);
begin
  inherited;
  // tbtnSave.Visible:=false;
  // tbtnCancel.Visible:=false;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  ncbclienttype.Active := false;
  ncbclienttype.Active := true;
  ncbintrule.Active := false;
  ncbintrule.Active := true;
  jcdsType.Active := False;
  jcdsType.Active := True;
  jcdsClientType.Active := False;
  jcdsClientType.Active := True;
end;

procedure TFrmPackIntegrateRule.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult, log: string;
begin
  inherited;
  if SysDialogs.Confirm('删除操作', '确认要删除积分规则信息吗？') then
    with jcdsDelPackIntegrateRule do
    begin
      Active := false;
      Params.ParamValues['packIntegrateRule.id'] := jcdsResult.FieldByName('id')
        .AsLargeInt;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        // log := '删除积分规则：所属站点=' + jcdsResult.FieldByName('routename')
        // .AsString + ',班次号=' + jcdsResult.FieldByName('code').AsString;
        SysLog.WriteLog('行包管理——>积分规则设置', '删除', log);
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);
    end;

end;

procedure TFrmPackIntegrateRule.tbtnEditClick(Sender: TObject);
begin
  inherited;
  FrmPackIntegrateRuleEdt := TFrmPackIntegrateRuleEdt.Create(self);
  try
    with FrmPackIntegrateRuleEdt do
    begin
      Caption := '修改积分规则';
      id := jcdsResult.FieldByName('id').AsLargeInt;
      ncbclienttype.SetItemIndexByCode(jcdsResult.FieldByName('clienttype')
          .AsString);
      ncbintrule.SetItemIndexByCode(jcdsResult.FieldByName('type').AsString);
      ncbclienttype.Enabled := false;
      ncbintrule.Enabled := false;
      nvedtprice.Text := jcdsResult.FieldByName('price').AsString;
      nvedtintegrate.Text := jcdsResult.FieldByName('integrate')
        .AsString;
      NovaCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
      NovaCbbOrg.Enabled:=false;
      createby:= jcdsResult.FieldByName('createby').AsString;
      createtime:= jcdsResult.FieldByName('createtime').AsString;
      if SysMainForm.showFormModal(FrmPackIntegrateRuleEdt, false) = mrok then
      begin
        tbtnFilterClick(Sender);
        // jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmPackIntegrateRuleEdt);
  end;
end;

procedure TFrmPackIntegrateRule.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_p!orgid'] := NovaCkbOrg.GetSelectID;
    if ncbclienttype.GetSelectID < 0 then
      Params.ParamValues['filter_EQS_p!clienttype'] := null
    else
      Params.ParamValues['filter_EQS_p!clienttype'] :=
        ncbclienttype.GetSelectCode;
    if ncbintrule.GetSelectID < 0 then
      Params.ParamValues['filter_EQI_p!type'] := null
    else
      Params.ParamValues['filter_EQI_p!type'] := ncbintrule.GetSelectCode;
    Active := true;
  end;
end;

procedure TFrmPackIntegrateRule.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmPackIntegrateRuleEdt := TFrmPackIntegrateRuleEdt.Create(self);
  try
    with FrmPackIntegrateRuleEdt do
    begin
      Caption := '添加积分规则';
      // createby := SysInfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(FrmPackIntegrateRuleEdt, false) = mrok then
      begin
        tbtnFilterClick(Sender);
        // jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmPackIntegrateRuleEdt);
  end;

end;

procedure TFrmPackIntegrateRule.tbtnSaveClick(Sender: TObject);
var
  sResult, log: string;
  nResult: integer;
begin
  inherited;
  {with jcdsResult do
  begin
    ApplyUpdates(-1);
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
     log := '所属站点=' +  NovaCbbOrg.Text + ',客户类型=' +
        ncbclienttype.Text + ',积分规则=' + ncbintrule.Text +
        ',积分=' + nvedtintegrate.Text + ',金额=' + nvedtprice.Text;
      SysLog.WriteLog('行包管理——>积分规则设置', '添加', log);
      SysDialogs.ShowMessage(sResult);
      ModalResult := mrok;
    end
    else
    begin
      SysDialogs.Warning(sResult);
    end;
  end; }
end;

end.
