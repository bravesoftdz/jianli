unit UFrmTicketoutletStr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, Services;

type
  TFrmTicketoutletStr = class(TSimpleCRUDForm)
    lblticketoutlet: TLabel;
    nvhlpticketoutlet: TNovaHelp;
    jsnclntdtstdelticketoutletsctr: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    optype,log:string;
  end;

var
  FrmTicketoutletStr: TFrmTicketoutletStr;

implementation

uses UFrmTicketoutletStrEdit;

{$R *.dfm}

procedure TFrmTicketoutletStr.tbtnDeleteClick(Sender: TObject);
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

  with jsnclntdtstdelticketoutletsctr do
  try
    close;
    Params.ParamByName('ticketoutletctr.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
       if jcdsResult.FieldByName('id').AsInteger > 0 then
        begin
          optype := 'ɾ��';
          log := 'ɾ����Ʊ����Ʊ������Ϣ:'+jcdsResult.FieldByName('ticketoutletsname').AsString+'�ļ�¼';
          SysLog.WriteErr(log);
        end;
        log := '';
        optype := '';
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('��Ʊ����Ʊ������Ϣɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
  tbtnFilter.Click;
end;

procedure TFrmTicketoutletStr.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmTicketoutletStrEdit := TFrmTicketoutletStrEdit.Create(Self);
  with FrmTicketoutletStrEdit do
  begin
    nvhlpticketoutlet.Enabled:=False;
    Caption := '�޸���Ʊ����Ʊ������Ϣ';
    id :=  jcdsResult.FieldByName('id').AsInteger;
    nvhlpnvedtreceipt.Id :=  jcdsResult.FieldByName('ticketoutletsid').AsInteger;
    nvhlpticketoutlet.Text  :=jcdsResult.FieldByName('ticketoutletsname').AsString;
    nvhlpnvedtreceipt.Text := jcdsResult.FieldByName('carrychildrate').AsString;
    carrychildrate:=jcdsResult.FieldByName('carrychildrate').AsString;
     maxsellmoney := jcdsResult.FieldByName('maxsellmoney').AsString;
    nvhlp1.Text := jcdsResult.FieldByName('maxsellmoney').AsString;
    if SysMainForm.showFormModal(FrmTicketoutletStrEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmTicketoutletStr.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    if nvhlpticketoutlet.Text='' then
    begin
        Params.ParamValues['filter_EQL_tc!ticketoutletsid'] :='';
    end
    else
    begin
        Params.ParamValues['filter_EQL_tc!ticketoutletsid'] :=nvhlpticketoutlet.Id;
    end;
    Active := True;
  end;
end;

procedure TFrmTicketoutletStr.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmTicketoutletStrEdit := TFrmTicketoutletStrEdit.Create(self);
  with FrmTicketoutletStrEdit do
  begin
    Caption := '�����Ʊ����Ʊ������Ϣ';
     nvhlpticketoutlet.Enabled:=True;
    if SysMainForm.showFormModal(FrmTicketoutletStrEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
