unit UFrmBillupmoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Services,USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,PrnDbgeh,NovaHComboBox;

type
  TFrmBillupmoney = class(TSimpleCRUDForm)
    lbl1: TLabel;
    cbbNovaCkbOrg: TNovaCheckedComboBox;
    jsonCDSDelBillupmoney: TjsonClientDataSet;
    lblbilltype: TLabel;
    lblupmoneydate: TLabel;
    Dateupmoney: TDateTimePicker;
    Dateupmoneyend: TDateTimePicker;
    lblEndtimes: TLabel;
    cbbbilltypeid: TNovaHComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmBillupmoney: TFrmBillupmoney;

implementation
 uses UFrmBillupmoneyEdit,PubFn;
{$R *.dfm}

procedure TFrmBillupmoney.FormCreate(Sender: TObject);
begin
  inherited;
  cbbNovaCkbOrg.Active := false;
  cbbNovaCkbOrg.Active := True;
  cbbbilltypeid.Active := false;
  cbbbilltypeid.Active := True;
  Dateupmoney.Date := now;
  Dateupmoneyend.Date := now;
end;
procedure TFrmBillupmoney.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jsonCDSDelBillupmoney do
    try
      close;
      Params.ParamByName('billupmoney.id').Value := jcdsResult.FieldByName('id').AsInteger;
      Execute;
      flag := Params.ParamByName('flag').Value;
      msg := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(msg);
      if (flag = 1) then
      begin
        log := 'ɾ������Ʊ�ɿƱ������='+jcdsResult.FieldByName('billtypename').AsString+',�ɿ���='+jcdsResult.FieldByName('upusername').AsString+
          ',�ɿ���='+jcdsResult.FieldByName('price').AsString+',�ɿ�����='+jcdsResult.FieldByName('upmoneydate').AsString;
        SysLog.WriteLog('Ʊ�ݹ�����>����Ʊ�ɿ�','ɾ��',log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����Ʊ�ɿ�ɾ��ʧ�ܣ�' + E.Message);
      end;
    end;
end;

procedure TFrmBillupmoney.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmBillupmoneyEdit := TFrmBillupmoneyEdit.Create(self);
  with FrmBillupmoneyEdit do
  begin
    Caption := '�޸Ķ���Ʊ�ɿ�';
    id := jcdsResult.FieldByName('id').AsInteger;
    nvhlpupuser.ReadOnly:=true;
    cbbbilltypeid.Text := jcdsResult.FieldByName('billtypename').AsString;
    nvhlpupuser.Text := jcdsResult.FieldByName('upusername').AsString;
    edtprice.Text := jcdsResult.FieldByName('price').AsString;
    Dateupmoney.Date:= jcdsResult.FieldByName('upmoneydate').AsDateTime;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    billtypeid := jcdsResult.FieldByName('billtypeid').AsInteger;
    upuserid := jcdsResult.FieldByName('upuserid').AsInteger;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    cbbbilltypeid.Enabled := False;
    nvhlpupuser.Enabled:=False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmBillupmoney.tbtnFilterClick(Sender: TObject);
var
  orgid: integer;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
      if cbbNovaCkbOrg.CheckedCount = 0 then
        Params.ParamByName('filter_INS_b!orgid').Value := SysInfo.LoginUserInfo.OrgIDs
      else
        Params.ParamByName('filter_INS_b!orgid').Value := cbbNovaCkbOrg.GetSelectID;
    if cbbbilltypeid.ItemIndex>=0 then
      Params.ParamByName('filter_EQL_b!billtypeid').Value :=cbbbilltypeid.HelpFieldValue['id']
    else
      Params.ParamByName('filter_EQL_b!billtypeid').Value :='';
    Params.ParamByName('filter_GED_b!upmoneydate').Value := FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
    Params.ParamByName('filter_LED_b!upmoneydate').Value := FormatDateTime('yyyy-mm-dd',Dateupmoneyend.DateTime);
    Active := True;
  end
end;

procedure TFrmBillupmoney.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmBillupmoneyEdit := TFrmBillupmoneyEdit.Create(self);
  with FrmBillupmoneyEdit do
  begin
    Caption := '��Ӷ���Ʊ�ɿ�';
    if SysMainForm.showFormModal(FrmBillupmoneyEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;

  end;
end;

end.
