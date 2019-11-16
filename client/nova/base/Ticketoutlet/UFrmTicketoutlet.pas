unit UFrmTicketoutlet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh,Services,ImgList,NovaEdit, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NvPrnDbgeh, NvDbgridEh, NovaHComboBox, NovaHelp, NovaCheckedComboBox;

type
  TFrmTicketoutlet = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl5: TLabel;
    edt_code: TNovaEdit;
    lbl1: TLabel;
    jsonCDSDelTicketoutlet: TjsonClientDataSet;
    edt_name: TNovaEdit;
    lbl4: TLabel;
    nvhlpdistrictid: TNovaHelp;
    lbl2: TLabel;
    edtjianpin: TNovaEdit;
    cbborg: TNovaCheckedComboBox;
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmTicketoutlet: TFrmTicketoutlet;

implementation
uses PubFn,UFrmTicketoutletAdd;
{$R *.dfm}

procedure TFrmTicketoutlet.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := false;
  cbborg.Active := True;
end;

procedure TFrmTicketoutlet.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;
  if jcdsResult.FieldByName('type').AsInteger< 1 then
  begin
    SysDialogs.ShowMessage('站内售票点不允许删除');
    exit;
  end;
  with jsonCDSDelTicketoutlet do
  try
    log := '删除售票点：'+jcdsResult.FieldByName('name').AsString;
    Params.ParamByName('ticketoutlet.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
      SysLog.WriteLog('删除售点票','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('售票点信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmTicketoutlet.tbtnEditClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 with FrmTicketoutletAdd do
 begin
    FrmTicketoutletAdd := TFrmTicketoutletAdd.Create(self);
    Caption:= '修改售票点信息';
    id :=  jcdsResult.FieldByName('id').AsInteger;
    edtname.Text:=jcdsResult.FieldByName('name').AsString;
    code :=jcdsResult.FieldByName('code').AsString;
    edtphone.Text:=jcdsResult.FieldByName('contactphone').AsString;
    edtperson.Text:=jcdsResult.FieldByName('contactperson').AsString;
    edtjianpin.Text := jcdsResult.FieldByName('jianpin').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsString;
    cbbOrgid.Text := jcdsResult.FieldByName('orgname').AsString;
    cbbdistrictid.Text := jcdsResult.FieldByName('districtname').AsString;
    district := jcdsResult.FieldByName('districtid').AsString;
    createby:=jcdsResult.FieldByName('createby').AsString;
    createtime:=jcdsResult.FieldByName('createtime').AsString;
    mmoaddress.Text:= jcdsResult.FieldByName('address').AsString;
    isactive:=  jcdsResult.FieldByName('isactive').AsBoolean;
    Chkisprint.Checked:=  jcdsResult.FieldByName('isprint').AsBoolean;
    cbbtype.Text := jcdsResult.FieldByName('dictype').AsString;
    cbbgrade.Text := jcdsResult.FieldByName('dicgrade').AsString;
    cbbtype.ItemIndex := jcdsResult.FieldByName('type').AsInteger;
    cbbgrade.ItemIndex := jcdsResult.FieldByName('grade').AsInteger;
    cbbstartstation.SetItemIndexByField('id',jcdsResult.FieldByName('startstationid').AsLargeInt);
    cbbstartstation.SetItemIndexByField('name',jcdsResult.FieldByName('startstationname').AsString);
    if jcdsResult.FieldByName('dictype').AsString = '站内' then
    begin
      cbbtype.Enabled := False;
    end;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
 end;
end;

procedure TFrmTicketoutlet.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if trim(edt_name.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_s!name').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_s!name').Value := edt_name.Text;
    end;
    if trim(edt_code.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_s!code').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_s!code').Value := edt_code.Text;
    end;
    if trim(edtjianpin.Text) = '' then
    begin
      Params.ParamValues['filter_LIKES_s!jianpin'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_s!jianpin'] := edtjianpin.Text;
    end;
    if Trim(nvhlpdistrictid.Text) = '' then
    begin
      Params.ParamByName('filter_EQL_s!districtid').Value := '';
    end else
    begin
      Params.ParamByName('filter_EQL_s!districtid').Value := nvhlpdistrictid.Id
    end;
    if cbborg.CheckedCount = 0 then
    begin
      Params.ParamByName('filter_INS_s!orgid').Value := SysInfo.LoginUserInfo.OrgIDs;
    end else
    begin
      Params.ParamByName('filter_INS_s!orgid').Value := cbborg.GetSelectID;
    end;
    Active := true;
  end
end;

procedure TFrmTicketoutlet.tbtnInsertClick(Sender: TObject);
begin
  inherited;
   FrmTicketoutletAdd := TFrmTicketoutletAdd.Create(self);
   with FrmTicketoutletAdd do
   begin
    Caption := '添加售票点信息';
    if SysMainForm.showFormModal(FrmTicketoutletAdd) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;

   end;
end;

end.
