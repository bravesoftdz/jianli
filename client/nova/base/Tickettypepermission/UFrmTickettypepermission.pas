unit UFrmTickettypepermission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmTickettypepermissionEdit, NovaComboBox, NovaHComboBox,
  NovaCheckedComboBox;

type
  TFrmTickettypepermission = class(TSimpleCRUDForm)
    cbbtype: TNovaComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cbbtypeuser: TNovaHComboBox;
    cbbtyperole: TNovaHComboBox;
    lbl3: TLabel;
    cbbtickettype: TNovaHComboBox;
    cbbticketoutlets: TNovaHComboBox;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    jcdsResultCDSDelpermission: TjsonClientDataSet;
    cbborg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTickettypepermission: TFrmTickettypepermission;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTickettypepermission.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtypeuser.Active := False;
  cbbtypeuser.Active := True;

  cbbtyperole.Active := False;
  cbbtyperole.Active := True;

  cbbticketoutlets.Active := False;
  cbbticketoutlets.Active := True;

  cbbtickettype.Active := False;
  cbbtickettype.Active := True;

  cbborg.Active := False;
  cbborg.Active := True;

end;

procedure TFrmTickettypepermission.tbtnDeleteClick(Sender: TObject);
var
  flag: LongWord;
  msg: string;
begin
  inherited;
if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jcdsResultCDSDelpermission do
  try
    close;
    log := '删除车票类型可售权限控制：所属机构='+jcdsResult.FieldByName('orgname').AsString+
    ',类型='+jcdsResult.FieldByName('type').AsString+',权限范围='+
    jcdsResult.FieldByName('name').AsString+',车票类型='+
    jcdsResult.FieldByName('tickettypename').AsString;
    Params.ParamByName('tickettypepermission.id').Value :=jcdsResult.FieldByName('id').AsString ;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
      SysLog.WriteLog('删除车票类型可售权限控制','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('车票类型可售权限控制信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmTickettypepermission.tbtnEditClick(Sender: TObject);
var
  id:integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmTickettypepermissionEdit do
  begin
    FrmTickettypepermissionEdit := TFrmTickettypepermissionEdit.Create(self);
    Caption := '修改车票类型可售权限控制';
    sign :=false;
    id :=  jcdsResult.FieldByName('id').AsInteger;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    cbbtickettype.Text := jcdsResult.FieldByName('tickettypename').AsString;
    tickettypeid := jcdsResult.FieldByName('tickettypeid').AsString;
    cbbtype.Text := jcdsResult.FieldByName('type').AsString;
    typeid := jcdsResult.FieldByName('typeid').AsString;
    cbbtypeid.ItemIndex := 0;
    if Trim(cbbtype.Text) = '售票员' then
    begin
      cbbtype.ItemIndex := 0;
      cbbtypeid.Text := jcdsResult.FieldByName('name').AsString;
      lbl2.Caption := '售票员';
    end;
    if Trim(cbbtype.Text) = '角色' then
    begin
      cbbtype.ItemIndex := 1;
      cbbtypeid.Text := jcdsResult.FieldByName('name').AsString;
      lbl2.Caption := '角色';
    end;
    if Trim(cbbtype.Text) = '售票点' then
    begin
      cbbtype.ItemIndex := 2;
      cbbtypeid.Text := jcdsResult.FieldByName('name').AsString;
      lbl2.Caption := '售票点';
    end;
    if Trim(cbbtype.Text) = '机构' then
    begin
      cbbtype.ItemIndex := 3;
      cbbtypeid.Text := jcdsResult.FieldByName('name').AsString;
      lbl2.Caption := '机构';
    end;
    typeid := jcdsResult.FieldByName('typeid').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmTickettypepermission.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      if Trim(cbbtype.Text) = '' then
      begin
        Params.ParamValues['filter_LIKES_t!type'] := '';
      end else
      begin
        Params.ParamValues['filter_LIKES_t!type'] := cbbtype.ItemIndex;
      end;
      if Trim(cbbtypeuser.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_u!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_u!id'] := cbbtypeuser.HelpFieldValue['id'];
      end;
      if Trim(cbbticketoutlets.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_ti!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_ti!id'] := cbbticketoutlets.HelpFieldValue['id'];
      end;
      if Trim(cbbtyperole.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_r!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_r!id'] := cbbtyperole.HelpFieldValue['id'];
      end;
      if cbborg.CheckedCount = 0 then
      begin
        Params.ParamValues['filter_INS_org!id'] := SysInfo.LoginUserInfo.OrgIDs;
      end else
      begin
        Params.ParamValues['filter_INS_org!id'] := cbborg.GetSelectID;
      end;
      if Trim(cbbtickettype.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_tt!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_tt!id'] := cbbtickettype.HelpFieldValue['id'];
      end;
    Active := True;
  end;
end;

procedure TFrmTickettypepermission.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmTickettypepermissionEdit do
  begin
    FrmTickettypepermissionEdit := TFrmTickettypepermissionEdit.Create(self);
    Caption := '添加车票类型可售权限控制';
    sign:=true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

end.
