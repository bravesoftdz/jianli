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
    cbborg: TNovaCheckedComboBox; // 所属机构
    lbl4: TLabel;
    lbllbcode: TLabel;
    cbbbilltype: TNovaHComboBox;     //票据类型
    Label1: TLabel;
    NovaHBilldestoryer: TNovaHelp;   //废票人
    Label3: TLabel;
    startDate: TDateTimePicker; //日期
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
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
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
      // 重新查询
      tbtnFilterClick(Sender);
      // jcdsResult.Locate('id', nBid, []);
    except
      on E: Exception do
      begin
        SysDialogs.ShowMessage(E.Message);
        SysLog.WriteErr('废票信息删除失败：' + E.Message);
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

    Caption := '修改废票金额信息';
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
  // 添加
  FrmBilldestoryEdt := TFrmBilldestoryEdt.Create(self);
  with FrmBilldestoryEdt do
  begin
    Caption := '添加票据废票金额信息';
    edittype := Tedittype.add;

    if SysMainForm.showFormModal(FrmBilldestoryEdt) = mrok then
    begin

      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);

    end;

  end;
end;

end.
