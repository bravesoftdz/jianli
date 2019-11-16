unit UFrmClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit, Services, NvPrnDbgeh, NvDbgridEh,
  UFrmClientEdit, NovaCheckedComboBox;

type
  TfrmClient = class(TSimpleCRUDForm)
    nvedtName: TNovaEdit;
    lbl1: TLabel;
    lbl5: TLabel;
    nvedtPhone: TNovaEdit;
    jcdsEducation: TjsonClientDataSet;
    jcdsDelete: TjsonClientDataSet;
    jcdsCertificatetype: TjsonClientDataSet;
    lrgntfldResultid: TLargeintField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultname: TWideStringField;
    wdstrngfldResultsex: TWideStringField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    grp3: TGroupBox;
    grp8: TGroupBox;
    nvdbgrdhTicke: TNvDbgridEh;
    grp1: TGroupBox;
    grp2: TGroupBox;
    tlb2: TToolBar;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    btn11: TToolButton;
    btn12: TToolButton;
    nvdbgrdh1: TNvDbgridEh;
    jcdsType: TjsonClientDataSet;
    wdstrngfldResultremarks: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    lrgntfldResultorgid: TLargeintField;
    wdstrngfldResultemail: TWideStringField;
    jcdsvipstatus: TjsonClientDataSet;
    jcdsResulttype: TWideStringField;
    jcdsResulttypevalue: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultcontacter: TWideStringField;
    jcdsResultaddress: TWideStringField;
    jcdsResultfixphone: TWideStringField;
    jcdsResultisactive: TBooleanField;
    jcdsResultislocaldelete: TBooleanField;
    jcdsResultsynccode: TWideStringField;
    Label2: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    lbl6: TLabel;
    nvcbbtype: TNovaComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClient: TfrmClient;

implementation

uses UDMPublic, PubFn;
{$R *.dfm}

procedure TfrmClient.FormCreate(Sender: TObject);
begin
  inherited;

  nvcbborg.Active := False;
  nvcbborg.Active := True;
  nvcbbtype.Active := False;
  nvcbbtype.Active := True;
  jcdsType.Active := False;
  jcdsType.Active := True;
end;

/// /查找顾客购票明细
// procedure TfrmClient.jcdsResultAfterScroll(DataSet: TDataSet);
// begin
// inherited;
// with jcdsTickeDetail do
// begin
// Active:=False;
// Params.ParamValues['filter_EQL_t!Client.id']:= jcdsResult.FieldByName('id').AsString;
// Active:=true;
// if recordcount = 0 then
// jcdsTickeDetail.Close;
// end;
// end;

procedure TfrmClient.tbtnDeleteClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  // 删除
  if (jcdsResult.Active = True) and (jcdsResult.RecNo >= 0) then
  begin
    if not SysDialogs.Confirm('提示', '确定要删除该客户档案吗？') then
    begin
      exit;
    end;

    with jcdsDelete do
    begin
      Params.ParamValues['clientid'] := jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        log := ' 删除' + jcdsResult.FieldByName('orgname')
          .AsString + '的客户档案:' + jcdsResult.FieldByName('name').AsString;
        SysLog.WriteLog('行包客户档案管理', '删除', log);
        log := '';
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TfrmClient.tbtnEditClick(Sender: TObject);
begin
  inherited;
  // 修改
  if (jcdsResult.Active = True) and (jcdsResult.RecNo >= 0) then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
      SysDialogs.ShowError('请先选择需要修改的记录！');
    end;
    try
      frmClientEdit := TfrmClientEdit.Create(self);
      with frmClientEdit do
      begin
        Caption := '修改行包客户档案信息';
        edittype := Tedittype.update;
        id := jcdsResult.FieldByName('id').AsInteger;
        createby := jcdsResult.FieldByName('createby').AsString;
        createtime := jcdsResult.FieldByName('createtime').AsString;
        orgid := jcdsResult.FieldByName('orgid').AsString;
        mmoRemark.Text := jcdsResult.FieldByName('remarks').AsString;
        nvcbbtype.SetItemIndexByCode(self.jcdsResult.FieldByName('type')
            .AsString);
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        nvedtcode.Text := jcdsResult.FieldByName('code').AsString;
        nvedtcontacter.Text := jcdsResult.FieldByName('contacter').AsString;
        nvedtfixphone.Text := jcdsResult.FieldByName('fixphone').AsString;
        nvedtmobilephone.Text := jcdsResult.FieldByName('mobilephone').AsString;
        edtEmail.Text := jcdsResult.FieldByName('email').AsString;
        nvedtadress.Text := jcdsResult.FieldByName('address').AsString;
        synccode := jcdsResult.FieldByName('synccode').AsString;
        isactive := jcdsResult.FieldByName('isactive').AsBoolean;
        islocaldelete := jcdsResult.FieldByName('islocaldelete').AsBoolean;
        if trim(jcdsResult.FieldByName('sex').AsString) = '男' then
        begin
          rbMan.Checked := True;
          rbGrile.Checked := False;
        end
        else
        begin
          rbMan.Checked := False;
          rbGrile.Checked := True;
        end;
        if ShowModal = mrok then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id', id, []);
        end;
      end;
    finally
      FreeAndNil(frmClientEdit);
    end;
  end;
end;

procedure TfrmClient.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  // 查询
  // jcdsResult.AfterScroll := nil;
  if nvcbborg.GetSelectID = '' then
  begin
    SysDialogs.Warning('请选择所属机构！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_cnt!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_LIKES_cnt!name'] := nvedtName.Text;
    Params.ParamValues['filter_LIKES_cnt!fixphone_OR_cnt!mobilephone'] :=
      nvedtPhone.Text;
    Params.ParamValues['filter_EQB_cnt!isactive'] := True;
    Params.ParamValues['filter_EQB_cnt!islocaldelete'] := False;
    // Params.ParamValues['filter_LIKES_cnt!email'] := edtEmail.Text;

    if nvcbbtype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_cnt!type'] := ''
    else
      Params.ParamValues['filter_EQS_cnt!type'] := nvcbbtype.GetSelectCode;
    Active := True;
  end;
  // jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TfrmClient.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  // 添加
  frmClientEdit := TfrmClientEdit.Create(self);
  with frmClientEdit do
  begin
    Caption := '添加行包客户档案信息';
    edittype := Tedittype.add;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
