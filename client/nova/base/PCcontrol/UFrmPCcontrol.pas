unit UFrmPCcontrol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Services,
  PrnDbgeh, NovaEdit, NovaHelp, NovaComboBox, NovaCheckedComboBox, NvPrnDbgeh,
  NvDbgridEh, NovaHComboBox;

type
  TfrmPCcontrol = class(TSimpleCRUDForm)
    lblOrg: TLabel;
    lblIp: TLabel;
    jsonDelSchedule: TjsonClientDataSet;
    nvcbbSelltype: TNovaComboBox;
    lblSelltype: TLabel;
    nvedtIP: TNovaEdit;
    jsonSelltypeids: TjsonClientDataSet;
    dsTypename: TDataSource;
    jcdsTypename: TjsonClientDataSet;
    grp3: TGroupBox;
    dbgrdhTypeids: TDBGridEh;
    grp5: TGroupBox;
    dbgrdh5: TDBGridEh;
    wdstrngfldResulttype: TWideStringField;
    wdstrngfldResultip: TWideStringField;
    jcdsResultorgid: TLargeintField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    spl1: TSplitter;
    NovaCbbOrg: TNovaHComboBox;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaCbbOrgChange(Sender: TObject);
    procedure nvcbbSelltypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure refreshtIdName;
  public
    { Public declarations }
  end;

var
  frmPCcontrol: TfrmPCcontrol;

implementation

uses UFrmPCcontrolEdit, PubFn, UDMPublic;
{$R *.dfm}

procedure TfrmPCcontrol.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCbbOrg.Active := False;
  NovaCbbOrg.Active := True;
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  jcdsTypename.Active := False;
  jcdsTypename.Active := True;
end;

procedure TfrmPCcontrol.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  refreshtIdName;
end;

procedure TfrmPCcontrol.NovaCbbOrgChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

procedure TfrmPCcontrol.nvcbbSelltypeChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

procedure TfrmPCcontrol.refreshtIdName;
begin
  with jsonSelltypeids do
  begin
    Active := False;
    Params.ParamValues['pcsellschedule.orgid'] := jcdsResult.FieldByName
      ('orgid').AsInteger;
    Params.ParamValues['pcsellschedule.ip'] := jcdsResult.FieldByName('ip')
      .AsString;
    Params.ParamValues['pcsellschedule.type'] := jcdsResult.FieldByName('type')
      .AsString;
    Active := True;
  end;
end;

procedure TfrmPCcontrol.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult,log: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗？') then
    exit;

  with jsonDelSchedule do
    try
      close;
      Params.ParamByName('pcsellschedule.orgid').Value := jcdsResult.FieldByName('orgid')
        .AsInteger;
      Params.ParamByName('pcsellschedule.ip').Value := jcdsResult.FieldByName('ip').AsString;
      Params.ParamByName('pcsellschedule.type').Value := jcdsResult.FieldByName('type').AsString;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := ' 删除'+jcdsResult.FieldByName('orgname').AsString
                +'的售票电脑ip:'+jcdsResult.FieldByName('ip').AsString;
        SysLog.WriteLog('售票电脑控制管理', '删除', log);
        log:='';
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('删除失败：' + E.Message);
      end;
    end;
end;

procedure TfrmPCcontrol.tbtnEditClick(Sender: TObject);
var
  curip: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;

  frmPCcontrolEdit := TfrmPCcontrolEdit.Create(self);
  with frmPCcontrolEdit do
  begin
    edittype:=Tedittype.update;
    Caption := '修改售票机器售票控制信息';
    id := jcdsResult.FieldByName('orgid').AsInteger;
    orgname := jcdsResult.FieldByName('orgname').AsString;
    nvhcbbOrgid.SetItemIndexByField('name',
      jcdsResult.FieldByName('orgname').AsString);
    nvcbbSelltype.Text := jcdsResult.FieldByName('typename').AsString;
    nvedtIP.Text := jcdsResult.FieldByName('ip').AsString;
    curip := jcdsResult.FieldByName('ip').AsString;
    typename := jcdsResult.FieldByName('typename').AsString;
    types := jcdsResult.FieldByName('type').AsString;
    nvcbbSelltype.ItemIndex := jcdsResult.FieldByName('type').AsInteger;
    createby:=jsonSelltypeids.FieldByName('createby').AsLargeInt;
    createtime:=jsonSelltypeids.FieldByName('createtime').AsString;
    if types = '1' then
    begin
      nvlvRoute.Params[0].Value := jcdsResult.FieldByName('orgid').AsString;
      nvlvRoute.Params[1].Value := types;
      nvlvRoute.Params[2].Value := True;
      nvlvRoute.Active := True;
      nvlvRoute.Visible := True;
      nvlvRoute.SetCheck(jsonSelltypeids, 'id');
      nvlvSchedule.Visible := False;
    end
    else if types = '2' then
    begin
      nvlvSchedule.Params[0].Value := jcdsResult.FieldByName('orgid').AsString;
      nvlvSchedule.Params[1].Value := types;
      nvlvSchedule.Params[3].Value := True;
      nvlvSchedule.Active := True;
      nvlvSchedule.Visible := True;
      nvlvSchedule.SetCheck(jsonSelltypeids, 'id');
      nvlvRoute.Visible := False;
    end
    else if types = '0' then
    begin
      nvlvSchedule.Items.Clear;
      nvlvRoute.Items.Clear;
    end;
    //nvcbbSelltype.Enabled := False;
    nvedtIP.Enabled := False;
    nvhcbbOrgid.Enabled := False;
    nvcbbSelltype.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('ip', curip, []);
    end;
  end;
end;

procedure TfrmPCcontrol.tbtnFilterClick(Sender: TObject);
begin
  inherited;
   jcdsResult.AfterScroll := nil;
  if NovaCbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowInfo('请选择机构！');
    NovaCbbOrg.SetFocus;
    exit
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamByName('filter_EQL_o!id').Value := NovaCbbOrg.HelpFieldValue['id'];

    Params.ParamByName('filter_LIKES_s!ip').Value := nvedtIP.Text;

    if nvcbbSelltype.ItemIndex > 0 then
    begin
      Params.ParamValues['filter_EQS_s!type'] := nvcbbSelltype.GetSelectCode;
    end
    else
    begin
      Params.ParamValues['filter_EQS_s!type'] := '';
    end;
    Active := True;
    if RecordCount=0 then
    begin
      jsonSelltypeids.Close;
    end;
  end;
  refreshtIdName;
   jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TfrmPCcontrol.tbtnInsertClick(Sender: TObject);
var
  curip: string;
begin
  inherited;
  frmPCcontrolEdit := TfrmPCcontrolEdit.Create(self);
  try
    with frmPCcontrolEdit do
    begin
      Caption := '添加售票机器售票控制';
      edittype:=add;
      createby:=SysInfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(frmPCcontrolEdit, False) = mrok then
      begin
        curip := Trim(nvedtIP.Text);
        tbtnFilterClick(Sender);
        jcdsResult.Locate('ip', curip, []);
      end;
    end;
  finally
    FreeAndNil(frmPCcontrolEdit);
  end;
end;

end.
