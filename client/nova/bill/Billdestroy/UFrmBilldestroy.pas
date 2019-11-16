unit UFrmBilldestroy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaEdit, NovaHelp, NovaCheckedComboBox, NvPrnDbgeh, NvDbgridEh, NovaHComboBox;

type
  TFrmBilldestroy = class(TSimpleCRUDForm)
    jcdsDel: TjsonClientDataSet;
    cbborg: TNovaCheckedComboBox; // ��������
    lbl4: TLabel;
    lbllbcode: TLabel;
    cbbbilltype: TNovaHComboBox;     //Ʊ������
    Label1: TLabel;
    NovaHBilldestoryer: TNovaHelp;   //��Ʊ��
    Label3: TLabel;
    startDate: TDateTimePicker; //����
    endDate: TDateTimePicker;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBilldestroy: TFrmBilldestroy;

implementation

uses UFrmBilldestoryEdt, UDMPublic, PubFn, Services;
{$R *.dfm}

procedure TFrmBilldestroy.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := false;
  cbborg.Active := True;
  cbbbilltype.Active := false;
  cbbbilltype.Active := True;
  startDate.Date := now;
  endDate.Date := now;

end;

procedure TFrmBilldestroy.tbtnDeleteClick(Sender: TObject);
var
  nBid, nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jcdsDel do
    try
      close;
      nBid := jcdsResult.FieldByName('id').AsInteger;
      // SysDialogs.ShowMessage(IntToStr(nBid));
      Params.ParamByName('delId').Value := jcdsResult.FieldByName('id')
        .AsInteger;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      // ���²�ѯ
      tbtnFilterClick(Sender);
      // jcdsResult.Locate('id', nBid, []);
    except
      on E: Exception do
      begin
        SysDialogs.ShowMessage(E.Message);
        SysLog.WriteErr('��Ʊ��Ϣɾ��ʧ�ܣ�' + E.Message);
      end;
    end;
end;

procedure TFrmBilldestroy.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmBilldestoryEdt := TFrmBilldestoryEdt.Create(self);
  with FrmBilldestoryEdt do
  begin

    Caption := '�޸ķ�Ʊ�����Ϣ';
    flag := false;
    id := jcdsResult.FieldByName('id').AsInteger;
   // SysDialogs.ShowMessage('id =' + IntToStr(id));
    orgname := jcdsResult.FieldByName('orgname').AsString;
    isedt := True;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    DpDESTROYDATE.Date := jcdsResult.FieldByName('destroydate').AsDateTime;
    neprice.Text := jcdsResult.FieldByName('destroyprice').AsString;
    cbbbilltype.SetItemIndexByField('id',
      jcdsResult.FieldByName('billtypeid').AsLargeInt);
    NovaCbbOrg.SetItemIndexByField('id',
      jcdsResult.FieldByName('orgid').AsLargeInt);
    NovaHBilldestoryer.Text := jcdsResult.FieldByName('destroyername').AsString;
    NovaHBilldestoryer.id := jcdsResult.FieldByName('billdestroyer').AsLargeInt;
    if SysMainForm.showFormModal(FrmBilldestoryEdt, false) = mrok then
    begin
      tbtnFilterClick(Sender);
     // SysDialogs.ShowMessage('id =' + IntToStr(id));
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmBilldestroy.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if cbborg.CheckedCount = 0 then
    begin
      Params.ParamByName('filter_INS_org!id').Value :=
        SysInfo.LoginUserInfo.OrgIDs;
    end
    else
    begin
      Params.ParamByName('filter_INS_org!id').Value := cbborg.GetSelectID;
    end;

    Params.ParamByName('filter_EQL_bt!id').Value := cbbbilltype.HelpFieldValue['id'];

    if Trim(NovaHBilldestoryer.Text) = '' then
    begin
      Params.ParamByName('filter_EQL_u!id').Value := '';
    end else
    if NovaHBilldestoryer.Id <> 0  then
      Params.ParamByName('filter_EQL_u!id').Value := NovaHBilldestoryer.id;

    Params.ParamByName('filter_GED_d!destroydate').Value :=  formatdatetime
      ('yyyy-mm-dd', startDate.Date);
        Params.ParamByName('filter_LED_d!destroydate').Value :=  formatdatetime
      ('yyyy-mm-dd', endDate.Date);

    Active := True;
  end
end;

procedure TFrmBilldestroy.tbtnInsertClick(Sender: TObject);

begin
  inherited;
  // ���
  FrmBilldestoryEdt := TFrmBilldestoryEdt.Create(self);
  with FrmBilldestoryEdt do
  begin
    Caption := '���Ʊ�ݷ�Ʊ�����Ϣ';
    edittype := Tedittype.add;

    if SysMainForm.showFormModal(FrmBilldestoryEdt) = mrok then
    begin

      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);

    end;

  end;
end;

end.
