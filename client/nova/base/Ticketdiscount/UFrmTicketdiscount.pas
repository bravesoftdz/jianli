unit UFrmTicketdiscount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaComboBox, NovaHComboBox;

type
  TFrmTicketdiscount = class(TSimpleCRUDForm)
    jcdsDelTicketdiscount: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    cbbtickettypes: TNovaHComboBox;
    cbbdata: TNovaComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id : Integer;
  end;

var
  FrmTicketdiscount: TFrmTicketdiscount;

implementation

uses Services, PubFn, UFrmTicketdiscountEdit;
{$R *.dfm}

procedure TFrmTicketdiscount.FormShow(Sender: TObject);
begin
  inherited;
  cbbtickettypes.Active:=false;
  cbbtickettypes.Active:=true;

end;

procedure TFrmTicketdiscount.tbtnDeleteClick(Sender: TObject);
var sResult, log : string;
    nResult : Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jcdsDelTicketdiscount do
  try
    close;
    Params.ParamByName('ticketdiscount.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      log := '删除折扣信息：票种='+jcdsResult.FieldByName('tickettype').AsString+
      ',类型='+jcdsResult.FieldByName('typename').AsString+',类型名称='+
      jcdsResult.FieldByName('dataname').AsString+',所属机构='+
      jcdsResult.FieldByName('orgname').AsString+',开始日期='+
      jcdsResult.FieldByName('startdate').AsString+',结束日期='+
      jcdsResult.FieldByName('enddate').AsString+',可售票数='+
      jcdsResult.FieldByName('sellnum').AsString;
      SysLog.WriteLog('业务管理->折扣信息','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('用户信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmTicketdiscount.tbtnEditClick(Sender: TObject);
var FrmTicketdiscountEdit : TFrmTicketdiscountEdit;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmTicketdiscountEdit do
  begin
    FrmTicketdiscountEdit := TFrmTicketdiscountEdit.Create(self);
    Caption := '修改折扣信息';
    id:= jcdsResult.FieldByName('id').AsLargeInt;

    cbbtickettype.SetItemIndexByField('code',jcdsResult.FieldByName('code').AsString);


    cbbdata.Text:=jcdsResult.FieldByName('typename').AsString;
    if Trim(cbbdata.Text) = '机构' then
      cbbdata.ItemIndex := 0
    else if Trim(cbbdata.Text) = '线路' then
      cbbdata.ItemIndex := 1
    else if Trim(cbbdata.Text) = '班次'  then
      cbbdata.ItemIndex := 2;

    nvhlpdatatype.Text :=jcdsResult.FieldByName('dataname').AsString;
    nvhlpdatatype.Id := jcdsResult.FieldByName('dataid').AsLargeInt;
    cbbstartdate.DateTime :=jcdsResult.FieldByName('startdate').AsDateTime;
    cbbenddate.DateTime := jcdsResult.FieldByName('enddate').AsDateTime;
    edtsellnum.Text := jcdsResult.FieldByName('sellnum').AsString;
    edtdefaultdiscountrate.Text:=jcdsResult.FieldByName('defaultdiscountrate').AsString;
    createby:=jcdsResult.FieldByName('createby').AsLargeInt;
    createtime:=jcdsResult.FieldByName('createtime').AsString;
    edtmindiscountrate.Text := jcdsResult.FieldByName('mindiscountrate').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    cbbtickettype.Enabled := False;
    cbbdata.Enabled := False;
    nvhlpdatatype.Enabled := False;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
      FreeAndNil(FrmticketdiscountEdit);
    end;
  end;
end;

procedure TFrmTicketdiscount.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    if cbbdata.ItemIndex = 0 then
      Params.ParamValues['filter_EQS_t!datatype'] := 0
    else if cbbdata.ItemIndex = 1 then
      Params.ParamValues['filter_EQS_t!datatype'] := 1
    else if cbbdata.ItemIndex = 2 then
      Params.ParamValues['filter_EQS_t!datatype'] := 2
//    else if cbbdata.ItemIndex = 3 then
//      Params.ParamValues['filter_EQS_t!datatype'] := 2
    else
      Params.ParamValues['filter_EQS_t!datatype'] := '';

    if cbbtickettypes.ItemIndex>=0 then
        Params.ParamValues['filter_EQS_t!tickettype'] := cbbtickettypes.HelpFieldValue['code']
    else
        Params.ParamValues['filter_EQS_t!tickettype'] := null;
    Active := True;
  end;
end;

procedure TFrmTicketdiscount.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmticketdiscountEdit do
  begin
    FrmticketdiscountEdit := TFrmticketdiscountEdit.Create(self);
    Caption := '添加折扣信息';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
      FreeAndNil(FrmticketdiscountEdit);
    end;
  end;
end;

end.
